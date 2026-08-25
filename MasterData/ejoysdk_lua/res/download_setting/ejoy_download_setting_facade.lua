local BUM = require("ejoysdk_lua.res.download_setting.background_update_manager")
local E = require("ejoysdk_lua.ejoysdk")
local CONSTANTS = require("ejoysdk_lua.ejoysdk_constants")
local AUU = require("ejoysdk_lua.res.download_url_utils")
local ST = require("ejoysdk_lua.res.model.strategies.network_strategy")
local GIU = require("ejoysdk_lua.res.download_setting.groups_info_utils")
local BACKGROUND_DOWNLOAD_ERROR_CODES = CONSTANTS.BACKGROUND_DOWNLOAD_ERROR_CODES
local SETTING_PAGEID_REGION_MAP = {
  cn = "69317175b1f1ff13bcd7cd93",
  hk = "69493d910ea1881131998623",
  us = "69493e0cca826113888ccc65"
}
local M = {}
local TAG = "DOWNLOAD_SETTING#"

function M.open_background_download_manager(cb)
  local raven_page_url = AUU.generate_raven_url(SETTING_PAGEID_REGION_MAP)
  local hostname = AUU.extract_hostname_from_url(raven_page_url)
  local injection = {
    [hostname] = {transparent = true}
  }
  local options = {
    use_cutout = false,
    hide_close_btn = true,
    compactMode = true,
    use_fragment = true
  }
  local webview_is_opened = false
  
  local function on_js_callback(data)
    E.LOG.debug(TAG, "background download mananger page opened successfully, on_js_callback, data: " .. tostring(data))
    webview_is_opened = true
  end
  
  E.WebView.open(raven_page_url, injection, options, on_js_callback)
  local timeout_threshold = 12
  local times = 0
  local check_webview_opened
  
  function check_webview_opened()
    times = times + 1
    if webview_is_opened then
      if cb then
        cb(true)
        cb = nil
      end
      return
    end
    if times <= timeout_threshold then
      E.Timer.once(0.5, function()
        check_webview_opened()
      end)
    elseif cb then
      cb(false, BACKGROUND_DOWNLOAD_ERROR_CODES.OPEN_H5_PAGE_TIMEOUT, "WebView open background download manager page timeout")
      cb = nil
    end
  end
  
  check_webview_opened()
end

function M.get_task_reddot_data(params, cb)
  if not params or not cb then
    E.LOG.error(TAG, "get_task_reddot_data, params or cb is nil")
    cb(false, BACKGROUND_DOWNLOAD_ERROR_CODES.PARAMS_NOT_COMPLETE, "params or cb is nil")
    return
  end
  local all_task = BUM.get_background_download_tasks()
  local total_task_count = #all_task
  local processed_count = 0
  local result = {
    new_update = {},
    new_download = {}
  }
  for task_id, task_instance in pairs(all_task) do
    local task_type = BUM.deserialize_task_id(task_id).task_type
    local card_id = BUM.deserialize_task_id(task_id).card_id
    task_instance.get_task_info({}, function(info_result)
      processed_count = processed_count + 1
      local task_info = {}
      task_info.task_type = task_type
      if info_result and info_result.task_info then
        task_info.res_version = info_result.task_info.res_version
      end
      if card_id then
        task_info.card_id = card_id
      end
      task_instance.get_task_state({}, function(state_result)
        local task_state = state_result and state_result.state or nil
        local is_never_downloaded = task_state == BUM.TASK_UPDATE_STATE.DOWNLOAD_NOT_STARTED
        local is_never_installed = task_state == BUM.TASK_UPDATE_STATE.DOWNLOAD_COMPLETE
        local is_download_red_dot_visible = not BUM.is_version_in_red_dot_table(task_id, task_info.res_version, BUM.REDDOT_BTN_TYPE.DONWLOAD_RED_DOT)
        local is_install_red_dot_visible = not BUM.is_version_in_red_dot_table(task_id, task_info.res_version, BUM.REDDOT_BTN_TYPE.INSTALL_RED_DOT)
        if params and params.reddot_type then
          if params.reddot_type == BUM.REDDOT_TYPE.NEW_UPDATE and is_never_downloaded and is_download_red_dot_visible then
            table.insert(result.new_update, task_info)
          elseif params.reddot_type == BUM.REDDOT_TYPE.NEW_DOWNLOAD and is_never_installed and is_install_red_dot_visible then
            table.insert(result.new_download, task_info)
          end
        else
          if is_never_downloaded and is_download_red_dot_visible then
            table.insert(result.new_update, task_info)
          end
          if is_never_installed and is_install_red_dot_visible then
            table.insert(result.new_download, task_info)
          end
        end
        if processed_count == total_task_count and cb and type(cb) == "function" then
          cb(true, result)
        end
      end)
    end)
  end
  if cb and type(cb) == "function" then
    cb(true, result)
  end
end

local function _get_lang_text(lang_const, lang_key)
  lang_const = lang_const or {}
  local lang_text = lang_const[lang_key]
  if lang_text and "" ~= lang_text then
    return lang_text
  end
  local AREA_LANG = require("ejoysdk_lua.lang.area_default_lang")
  local default_lang_key = "default"
  local publish_area = E.CONFIG.get_config(E.CONFIG.KEY.PUBLISH_AREA)
  if publish_area ~= lang_key then
    local area_lang_key = AREA_LANG[publish_area]
    if lang_const[area_lang_key] and "" ~= lang_const[area_lang_key] then
      return lang_const[area_lang_key]
    end
  end
  return lang_const[default_lang_key]
end

local function _validate_and_fill_card_config(task_type, card_config)
  if task_type ~= BUM.BACKGROUND_UPDATE_TYPE.GROUPS_UPDATE then
    return true, card_config
  end
  if not card_config or next(card_config) == nil then
    return false, CONSTANTS.BACKGROUND_DOWNLOAD_ERROR_CODES.PARAMS_NOT_COMPLETE, "card_config is empty"
  end
  local lang_key = (E.CONFIG.get_config("lang") or ""):lower()
  E.LOG.debug(TAG, "_validate_and_fill_card_config, langKey: " .. tostring(lang_key))
  if not (card_config.title_lang_const and nil ~= next(card_config.title_lang_const) and card_config.title_lang_const.default) or "" == card_config.title_lang_const.default then
    E.LOG.warn(TAG, "_validate_and_fill_card_config: title_lang_const is missing or empty")
    return false, CONSTANTS.BACKGROUND_DOWNLOAD_ERROR_CODES.PARAMS_NOT_COMPLETE, "title_lang_const is not valid"
  end
  if not (card_config.sub_title_lang_const and nil ~= next(card_config.sub_title_lang_const) and card_config.sub_title_lang_const.default) or "" == card_config.sub_title_lang_const.default then
    E.LOG.warn(TAG, "_validate_and_fill_card_config: sub_title_lang_const is missing or empty")
    return false, CONSTANTS.BACKGROUND_DOWNLOAD_ERROR_CODES.PARAMS_NOT_COMPLETE, "sub_title_lang_const is not valid"
  end
  card_config.title = _get_lang_text(card_config.title_lang_const, lang_key)
  card_config.sub_title = _get_lang_text(card_config.sub_title_lang_const, lang_key)
  return true, card_config
end

function M.start_background_task(task_params, cb)
  local success, result, valid_err_msg = _validate_and_fill_card_config(task_params.task_type, task_params.card_config)
  if not success then
    cb(false, result, valid_err_msg)
    return
  end
  task_params.card_config = result or {}
  local on_backdownload_close_cb
  task_params.opts = task_params.opts or {}
  if task_params.card_config.can_download_direct then
    E.LOG.debug(TAG, "can_download_direct is true, card_id: " .. tostring(task_params.card_config.id))
  end
  task_params.opts.network_strategy = BUM.get_background_network_strategy()
  ST.update_strategy(task_params.opts.network_strategy)
  E.LOG.debug(TAG, "task_params.opts.network_strategy: " .. tostring(task_params.opts.network_strategy))
  if task_params.task_type and task_params.task_type == BUM.BACKGROUND_UPDATE_TYPE.PRE_DOWNLOAD then
    if M.pre_download_task then
      cb(false, CONSTANTS.BACKGROUND_DOWNLOAD_ERROR_CODES.CREATE_TASK_FAIL, "pre_download_task already exists")
      return
    end
    local PRE_DOWNLOAD = require("ejoysdk_lua.res.predownload.pre_download_task")
    local EF = require("ejoysdk_lua.res.ejoysdk_res_facade_v2")
    local startup_local_res_info = EF.get_startup_res_info() or {}
    local namespace = EF.NAMESPACES.QZ_PATCH
    local res_key = startup_local_res_info.res_key
    E.LOG.debug(TAG, "start_background_task, startup_local_res_info: ")
    E.log(startup_local_res_info)
    
    function on_backdownload_close_cb()
      PRE_DOWNLOAD.create_task(namespace, res_key, task_params.groups, task_params.opts, task_params.listener, function(succ, ...)
        if succ then
          M.pre_download_task = (...)
          E.LOG.debug(TAG, "create_task successfully")
          cb(true)
          BUM.register_task_to_background_manager(task_params, M.pre_download_task, function(register_succ, ...)
            if register_succ then
              E.LOG.debug(TAG, "register task successfully")
            else
              local code, msg = ...
              E.LOG.debug(TAG, "register predownload task failed," .. tostring(code) .. " " .. tostring(msg))
            end
          end)
        else
          local code, msg = ...
          E.LOG.debug(TAG, "create_task failed" .. tostring(code) .. " " .. tostring(msg))
          cb(false, ...)
        end
      end)
    end
  elseif task_params.task_type and task_params.task_type == BUM.BACKGROUND_UPDATE_TYPE.APP_UPDATE then
    E.LOG.debug(TAG, "start_background_task, app_update")
    
    function on_backdownload_close_cb()
      E.LOG.debug(TAG, "on_backdownload_close_cb app_update")
      local AUT = require("ejoysdk_lua.res.app_update.app_update_task")
      AUT.create_background_task(task_params.opts, function(succ, ...)
        E.LOG.debug(TAG, "create_background_task app_update result: " .. tostring(succ))
        if succ then
          local task_instance = (...)
          E.LOG.debug(TAG, "create_background_task app_update task_instance: ")
          E.log(task_instance)
          cb(true)
          BUM.register_task_to_background_manager(task_params, task_instance, function(register_succ, ...)
            if register_succ then
              E.LOG.debug(TAG, "register app_update task successfully")
              BUM.show_new_version_popup()
            else
              local code, msg = ...
              E.LOG.debug(TAG, "register app_update task failed," .. tostring(code) .. " " .. tostring(msg))
            end
          end)
        else
          local code, msg = ...
          cb(false, code, msg)
        end
      end)
    end
  elseif task_params.task_type and task_params.task_type == BUM.BACKGROUND_UPDATE_TYPE.GROUPS_UPDATE then
    local EF = require("ejoysdk_lua.res.ejoysdk_res_facade_v2")
    local startup_local_res_info = EF.get_startup_res_info() or {}
    local namespace = EF.NAMESPACES.QZ_PATCH
    local res_key = startup_local_res_info.res_key
    
    function on_backdownload_close_cb()
      E.LOG.debug(TAG, "on_backdownload_close_cb groups_update")
      local GROUPS_UPDATE = require("ejoysdk_lua.res.download_setting.groups_update.groups_update_task")
      local card_id = task_params.card_config and task_params.card_config.id or nil
      local is_valid, code, msg = GIU.check_groups_infos_valid(card_id, task_params.groups)
      if not is_valid then
        E.LOG.warn(TAG, "check_groups_infos_valid failed, code: " .. tostring(code) .. ", msg: " .. tostring(msg))
        cb(false, code, msg)
        return
      end
      GROUPS_UPDATE.create_task(namespace, res_key, card_id, task_params.groups, task_params.opts, function(succ, ...)
        if succ then
          local task_instance = (...)
          E.LOG.debug(TAG, "create_task successfully")
          BUM.register_task_to_background_manager(task_params, task_instance, function(register_succ, ...)
            if register_succ then
              E.LOG.debug(TAG, "register task successfully")
              cb(true)
            else
              local _code, _msg = ...
              cb(false, _code, _msg)
            end
          end)
        else
          local _code, _msg = ...
          E.LOG.debug(TAG, "create_task failed" .. tostring(_code) .. " " .. tostring(_msg))
          cb(false, ...)
        end
      end)
    end
  end
  if on_backdownload_close_cb and type(on_backdownload_close_cb) == "function" then
    BUM.show_background_download_guide(nil, on_backdownload_close_cb)
  end
end

function M.set_background_download_config(params)
  E.LOG.debug(TAG, "set_background_download_config, speed_limit params: ")
  E.log(params)
  if params and params.max_band_width_kbytes_per_sec ~= nil then
    local download_config = {
      max_band_width_kbytes_per_sec = params.max_band_width_kbytes_per_sec
    }
    local EMM = require("ejoysdk_lua.res.ejoy_res_model_factory")
    local http_multi_res_model = EMM.get_http_res_multi_model()
    http_multi_res_model:update_download_config(download_config)
  end
  if params and nil ~= params.enable_clear then
    BUM.set_enable_clear(params.enable_clear)
  end
end

return M
