local E = require("ejoysdk_lua.ejoysdk")
local EF = require("ejoysdk_lua.res.game_sub_pkg_facade")
local QL = require("ejoysdk_lua.ejoysdk_qualitylog")
local DSP = require("ejoysdk_lua.protocol.aligames_protocol")
local ECC = require("ejoysdk_lua.ejoysdk_config_center")
local json = require("ejoysdk_lua.ejoysdk_json")
local CONSTANTS = require("ejoysdk_lua.ejoysdk_constants")
local LANG = require("ejoysdk_lua.lang.util")
local NS = require("ejoysdk_lua.res.model.strategies.network_strategy")
local PC = require("ejoysdk_lua.predownload.predownload_config")
local ESTAT = require("ejoysdk_lua.ejoysdk_stat")
local LAST_DOWNLOAD_STRATEGY = E.LazyKeyStore:New("LAST_DOWNLOAD_STRATEGY")
local M = {}
M.ACTION = {
  CONFIRM_DOWNLOAD_STRATEGY = "confirm_download_strategy"
}
local TAG = "predownload_res"
local RES_KEY_PREFIX = "predownload"
local preload_res_key, l_env, custom_game_res_save_path, custom_game_res_storage_type
local inited = false
local m_predownload_res_state

function M.set_env(env)
  E.LOG.debug(TAG, "set_env: " .. tostring(env))
  if l_env == env then
    return
  end
  l_env = env
  if l_env == DSP.ENV.DEBUG then
    ECC.set_env(DSP.ENV.DEBUG)
  else
    ECC.set_env(DSP.ENV.RELEASE)
  end
end

local function get_preload_res_key()
  if preload_res_key then
    return preload_res_key
  end
  local parent_pkg_id = E.get_parent_pkg_id()
  local parent_pkg_record_id = E.get_parent_pkg_record_id()
  local game_id = E.get_game_id()
  if not (game_id and parent_pkg_id) or not parent_pkg_record_id then
    E.LOG.warn(TAG, "get_preload_res_key failed, game_id or parent_pkg_id is nil, gid:" .. tostring(game_id) .. ", pkg_id:" .. tostring(parent_pkg_id))
    QL.commit_action_main("ej_preload_res_key_failed", game_id, parent_pkg_id)
    return nil
  end
  preload_res_key = table.concat({
    RES_KEY_PREFIX,
    game_id,
    parent_pkg_id,
    parent_pkg_record_id
  }, "_")
  E.LOG.debug(TAG, "get_preload_res_key:" .. tostring(preload_res_key))
  return preload_res_key
end

local function on_res_state_change_handler(state, state_obj)
  E.LOG.debug(TAG, "on_res_state_change_handler, res_key:" .. tostring(preload_res_key) .. ", state:" .. tostring(state))
  if state == EF.DOWNLOAD_STATE.COMPLETE then
    local res_version = state_obj[EF.RES_DOWNLOAD_STATE_KEY.VERSION_NAME]
    E.LOG.debug(TAG, "publish_using_res_version res_key:" .. tostring(preload_res_key) .. ", ver:" .. tostring(res_version))
  end
end

local current_update_info_exists = false

local function fill_res_state_info(res_info)
  if res_info and type(res_info) == "table" then
    local update_info = res_info[EF.RES_STATE_INFOS.TYPE_RES_UPDATE_STATE] or {}
    update_info.update_info_exists = current_update_info_exists
    res_info[EF.RES_STATE_INFOS.TYPE_RES_UPDATE_STATE] = update_info
  end
end

local function do_get_res_state()
  M.check_init()
  local res_key = get_preload_res_key()
  if not res_key then
    E.LOG.warn(TAG, "start_download failed, res_key is nil")
    return nil
  end
  local res_info = EF.get_res_all_state_info(res_key)
  fill_res_state_info(res_info)
  return res_info
end

local function on_res_progress_change_handler(download_state, progress_info)
  local current_res_download_state = do_get_res_state()
  local current_downloading_info = current_res_download_state[EF.RES_STATE_INFOS.TYPE_DOWNLOADING_INFO] or {}
  local current_downloading_state = current_downloading_info[EF.RES_DOWNLOAD_STATE_KEY.STATE]
  if current_downloading_state ~= EF.DOWNLOAD_STATE.COMPLETE then
    m_predownload_res_state = current_res_download_state
  else
    E.LOG.warn(TAG, "on_res_progress_change_handler skip update complete on progess change handler, it's modified in on_res_update_complete handler")
  end
  local percent = progress_info[EF.PROGRESS_INFO_KEY.PERCENT]
  local total_size = progress_info[EF.PROGRESS_INFO_KEY.TOTAL_SIZE]
  local downloading_size = progress_info[EF.PROGRESS_INFO_KEY.DOWNLOADING_SIZE]
  local total_cnt = progress_info[EF.PROGRESS_INFO_KEY.TOTAL_COUNT]
  local finish_cnt = progress_info[EF.PROGRESS_INFO_KEY.FINISH_COUNT]
  local last_finish_item = progress_info[EF.PROGRESS_INFO_KEY.LAST_FINISH_ITEM] or {}
  E.LOG.debug(TAG, "on_res_progress_change_handler, rk:" .. tostring(preload_res_key) .. ", state:" .. tostring(download_state) .. ", p:" .. tostring(percent) .. ", total_size:" .. tostring(total_size) .. ", downloading_size:" .. tostring(downloading_size) .. ", total_cnt:" .. tostring(total_cnt) .. ", finish_cnt:" .. tostring(finish_cnt) .. ", last:" .. tostring(last_finish_item[EF.FILE_LIST_ITEM_KEY.KEY_TO]))
end

function M.check_init()
  if inited then
    return
  end
  E.LOG.debug(TAG, "check_init begin")
  get_preload_res_key()
  local unisdk_config_path = "unisdk/ejoy_pack_config.json"
  local config_content = _ejoysdk.lread(unisdk_config_path)
  local ok, cfg = pcall(json.decode, config_content)
  local _custom_game_res_save_path_base, _custom_game_res_storage_type
  if ok then
    E.log(cfg)
    if cfg.predownload_resource_list then
      if cfg.predownload_resource_list.game_res_save_path then
        _custom_game_res_save_path_base = cfg.predownload_resource_list.game_res_save_path
      end
      local storage_type = cfg.predownload_resource_list.storage_type
      if "external" == storage_type then
        _custom_game_res_storage_type = EF.STORAGE_TYPE.EXTERNAL_APP_PRIVATE
      elseif "internal" == storage_type then
        _custom_game_res_storage_type = EF.STORAGE_TYPE.INTERNAL_APP_PRIVATE
      else
        _custom_game_res_storage_type = EF.STORAGE_TYPE.EXTERNAL_OTHER
      end
      E.LOG.debug(TAG, "init has custom game res save path:" .. tostring(_custom_game_res_save_path_base))
    end
  else
    E.LOG.warn(TAG, "check_init failed, decode pack_config failed")
  end
  custom_game_res_save_path = _custom_game_res_save_path_base
  custom_game_res_storage_type = _custom_game_res_storage_type
  E.LOG.debug(TAG, "check_init custom_game_res_save_path:" .. tostring(custom_game_res_save_path) .. ", storage type:" .. tostring(custom_game_res_storage_type))
  inited = true
end

local function select_strategy(res_state_info, confirm_cb)
  local function on_strategy_confirmed(strategy)
    local stat_params = {is_priority_high = true}
    
    ESTAT.stat_bizid(M.ACTION.CONFIRM_DOWNLOAD_STRATEGY, strategy, nil, stat_params)
    EF.update_res_download_strategy(get_preload_res_key(), strategy)
    confirm_cb(true)
  end
  
  local last_download_strategy = LAST_DOWNLOAD_STRATEGY:get()
  if last_download_strategy and "" ~= last_download_strategy then
    E.LOG.debug(TAG, "select_strategy has last strategy:" .. tostring(last_download_strategy))
    on_strategy_confirmed(last_download_strategy)
  else
    E.LOG.debug(TAG, "select_strategy NOT has last strategy, show dialog")
    E.LOG.debug(TAG, "show_confirm_download_strategy_dialog begin")
    local confirm_title = LANG.getString("update_tips", "更新提示")
    local confirm_message = LANG.getString("update_message_select_download_strategy", "检测到(%s)GB资源更新，请选择下载方式")
    local size_g = res_state_info.total_size / 1024 / 1024 / 1024
    local total_size_gb = string.format("%.2f", size_g)
    confirm_message = string.format(confirm_message, total_size_gb)
    local btn_wifi_and_mobile = LANG.getString("download_in_wifi_mobile", "移动网络和WIFI时下载")
    local btn_only_wifi = LANG.getString("download_in_only_wifi", "仅WIFI时下载")
    E.Modal.open(confirm_title, {
      message = confirm_message,
      buttons = {btn_wifi_and_mobile, btn_only_wifi},
      type = "simple",
      style = "lingxi",
      modal = true,
      closeable = false
    }, function(index)
      E.LOG.debug(TAG, "show_confirm_download_strategy_dialog click:" .. tostring(index))
      local strategy
      if 0 == index then
        E.LOG.debug(TAG, "select download in both mobile and wifi network")
        strategy = NS.STRATEGY.BOTH_MOBILE_WIFI_NETWORK
      else
        E.LOG.debug(TAG, "select download in only wifi")
        strategy = NS.STRATEGY.WIFI_ONLY
      end
      LAST_DOWNLOAD_STRATEGY:set(strategy)
      on_strategy_confirmed(strategy)
    end)
  end
end

local function reset_downloading_state()
  E.LOG.debug(TAG, "reset_downloading_state begin")
  if m_predownload_res_state then
    local downloading_info = m_predownload_res_state[EF.RES_STATE_INFOS.TYPE_DOWNLOADING_INFO] or {}
    downloading_info[EF.RES_DOWNLOAD_STATE_KEY.STATE] = EF.DOWNLOAD_STATE.UNKNOWN
    downloading_info[EF.RES_DOWNLOAD_STATE_KEY.ERR_CODE] = 0
    downloading_info[EF.RES_DOWNLOAD_STATE_KEY.ERR_MSG] = nil
  end
end

local function on_check_update_failed(code, msg)
  E.LOG.debug(TAG, "on_check_update_failed begin, code:" .. tostring(code) .. ", msg:" .. tostring(msg))
  if m_predownload_res_state then
    local downloading_info = m_predownload_res_state[EF.RES_STATE_INFOS.TYPE_DOWNLOADING_INFO] or {}
    downloading_info[EF.RES_DOWNLOAD_STATE_KEY.STATE] = EF.DOWNLOAD_STATE.FAILED
    downloading_info[EF.RES_DOWNLOAD_STATE_KEY.ERR_CODE] = code
    downloading_info[EF.RES_DOWNLOAD_STATE_KEY.ERR_MSG] = msg
  end
end

local function on_check_update_complete()
  E.LOG.debug(TAG, "on_check_update_complete received")
  if m_predownload_res_state then
    local downloading_info = m_predownload_res_state[EF.RES_STATE_INFOS.TYPE_DOWNLOADING_INFO] or {}
    downloading_info[EF.RES_DOWNLOAD_STATE_KEY.STATE] = EF.DOWNLOAD_STATE.COMPLETE
    downloading_info[EF.RES_DOWNLOAD_STATE_KEY.ERR_CODE] = 0
    downloading_info[EF.RES_DOWNLOAD_STATE_KEY.ERR_MSG] = nil
  end
end

function M.start_download(_download_cb)
  M.check_init()
  local downloading_info = m_predownload_res_state and m_predownload_res_state[EF.RES_STATE_INFOS.TYPE_DOWNLOADING_INFO]
  local downloading_state = downloading_info and downloading_info[EF.RES_DOWNLOAD_STATE_KEY.STATE]
  if downloading_state == EF.DOWNLOAD_STATE.FAILED then
    E.LOG.debug(TAG, "start_download with failed state, now reset it")
    reset_downloading_state()
  else
    E.LOG.debug(TAG, "start_download with no fail state, continue")
  end
  if not preload_res_key then
    E.LOG.warn(TAG, "start_download failed, res_key is nil")
    if _download_cb then
      _download_cb(false, CONSTANTS.RESOURCE_UPDATE_ERROR_CODES.RES_KEY_INVALID, "res key not valid:")
    end
    return
  end
  local local_res_state = EF.get_res_all_state_info(preload_res_key)
  local using_res_info = local_res_state[EF.RES_STATE_INFOS.TYPE_USING_RES_INFO] or {}
  local using_res_ver = using_res_info[EF.USING_RES_INFO_KEY.VERSION_NAME]
  E.LOG.debug(TAG, "start_download using res version:" .. tostring(using_res_ver))
  local opts = {
    [EF.NAMESPACE_UPDATE_OPTIONS.PROGRESS_UPDATE_INTERVAL_SEC] = 1,
    [EF.NAMESPACE_UPDATE_OPTIONS.FOREGROUND_NOTIFICATION_ENABLED] = true,
    stat_is_upload_now = true,
    ext = {
      apus_options = {is_upload_now = true}
    }
  }
  local current_res_info = {
    res_key = preload_res_key,
    [EF.NAMESPACE_UPDATE_OPTIONS.RES_SAVE_BASE_PATH] = custom_game_res_save_path,
    [EF.NAMESPACE_UPDATE_OPTIONS.RES_SAVE_STORAGE_TYPE] = custom_game_res_storage_type,
    engine_handler = {}
  }
  
  local function on_res_update_complete_handler(update_result, ...)
    if update_result then
      E.LOG.debug(TAG, "update_namespace_res complete")
      on_check_update_complete()
      if _download_cb then
        _download_cb(true, current_update_info_exists, ...)
      end
    else
      local code, msg = ...
      E.LOG.debug(TAG, "update_namespace_res failed, code:" .. tostring(code) .. ", msg:" .. tostring(msg))
      on_check_update_failed(code, msg)
      if _download_cb then
        _download_cb(false, code, msg)
      end
    end
  end
  
  local function _on_confirm_res_update_handler(res_state_info, confirm_update_cb)
    local update_ver = res_state_info.new_version
    local has_new_update = res_state_info.has_new_update
    current_update_info_exists = has_new_update
    local need_show_strategy_dialog = has_new_update and PC.DownloadWithStrategyEnabled
    E.LOG.debug(TAG, "on_receive_res_update_confirm, res_key:" .. tostring(preload_res_key) .. ", ver:" .. tostring(update_ver) .. ", has_new_update:" .. tostring(has_new_update) .. ", need_show_strategy_dialog:" .. tostring(need_show_strategy_dialog) .. ", DownloadWithStrategyEnabled:" .. tostring(PC.DownloadWithStrategyEnabled))
    E.log(res_state_info)
    if need_show_strategy_dialog or PC.DEBUG_CONFIG.mock_has_update then
      E.LOG.debug(TAG, "_on_confirm_res_update_handler show confirm dialog begin")
      select_strategy(res_state_info, confirm_update_cb)
    else
      E.LOG.debug(TAG, "_on_confirm_res_update_handler directly confirm true")
      confirm_update_cb(true)
    end
  end
  
  local listeners = {
    on_confirm_res_update = _on_confirm_res_update_handler,
    on_res_download_state_change_listener = on_res_state_change_handler,
    on_res_download_progress_change_listener = on_res_progress_change_handler,
    on_res_update_complete = on_res_update_complete_handler
  }
  EF.check_and_update(current_res_info, opts, listeners)
end

function M.get_res_state()
  if not m_predownload_res_state then
    m_predownload_res_state = do_get_res_state()
  end
  local downloading_info = m_predownload_res_state[EF.RES_STATE_INFOS.TYPE_DOWNLOADING_INFO] or {}
  E.LOG.debug(TAG, "get_res_state received: " .. tostring(downloading_info[EF.RES_DOWNLOAD_STATE_KEY.STATE]))
  E.log(m_predownload_res_state)
  return m_predownload_res_state
end

function M.check_res_state(cb)
  M.check_init()
  local res_key = get_preload_res_key()
  if not res_key then
    E.LOG.warn(TAG, "start_download failed, res_key is nil")
    return nil
  end
  local local_res_state = EF.get_res_all_state_info(preload_res_key)
  local using_res_ver
  if local_res_state then
    local using_res_info = local_res_state[EF.RES_STATE_INFOS.TYPE_USING_RES_INFO] or {}
    using_res_ver = using_res_info[EF.USING_RES_INFO_KEY.VERSION_NAME]
  end
  local opts = {}
  opts[EF.NAMESPACE_UPDATE_OPTIONS.RES_SAVE_BASE_PATH] = custom_game_res_save_path
  opts[EF.NAMESPACE_UPDATE_OPTIONS.RES_SAVE_STORAGE_TYPE] = custom_game_res_storage_type
  local params = {
    res_key = res_key,
    version = using_res_ver,
    opts = opts
  }
  EF.check_res_update(params, function(succ, ...)
    if succ then
      local is_update_info_exists, has_update, update_res_info, _namespace_ext = ...
      E.LOG.debug(TAG, update_res_info)
      update_res_info = update_res_info or {}
      current_update_info_exists = is_update_info_exists and has_update
      fill_res_state_info(update_res_info)
      cb(true, update_res_info)
    else
      local code, msg = ...
      cb(false, code, msg)
    end
  end)
end

return M
