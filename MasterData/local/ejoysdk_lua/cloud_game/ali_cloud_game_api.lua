local BCGA = require("ejoysdk_lua.cloud_game.base_cloud_game_api")
local E = require("ejoysdk_lua.ejoysdk")
local STAT = require("ejoysdk_lua.ejoysdk_stat")
local UNI = require("ejoysdk_lua.vendors.unisdk")
local CONTS = require("ejoysdk_lua.ejoysdk_constants")
local compat = require("ejoysdk_lua.compat.ejoysdk_compat")
local compat_string = compat.string
local JSON = require("ejoysdk_lua.ejoysdk_json")
local CSTAT = require("ejoysdk_lua.cloud_game.cloud_stat")
local cloud_config = require("ejoysdk_lua.cloud_game.cloud_config")
local EM = require("ejoysdk_lua.ejoysdk_module")
local DOWNLOAD_RULES = require("ejoysdk_lua.cloud_game.cloud_download_rules")
local free_flow = require("ejoysdk_lua.free_flow.ejoysdk_free_flow")
local cloud_free_flow = require("ejoysdk_lua.cloud_game.cloud_free_data_pkg")
local M = BCGA
local TAG = EM.MODULE.CLOUD_GAME .. "cloud_game_api"
local LUA_KEY_ALIYUN_BIZ_PARAMS = "biz_params"
local LUA_KEY_REGION_NAME = "region_name"
local AGST_VERSION = 1
local AGST_EXT_TYPE = 0
local ali_cloud_biz_params, ali_cloud_region_name, ali_down_min_speed, aliyun_app_key, aliyun_app_secret, aliyun_open_id, ali_agst_trace_time
local ali_config_ab_test_flag = false
local current_ali_cloud_gaid
local CLOUD_AGST_EXT_GAID = E.LazyKeyStore:New("EJOY_CLOUD_AGST_EXT_GAID")
local hw_qos_appkey, hw_qos_appsecret, cloud_game_ext_config

function M._init_cloud_native(cb)
  E.LOG.debug(TAG, "_init_cloud_native begin")
  local trid = "0"
  if STAT.get_trace_id then
    trid = STAT.get_trace_id()
  end
  local sdk_config = M.get_sdk_config()
  local disable_test_speed_val = false
  if sdk_config and sdk_config[M.RES_KEY.EX_DISABLE_TEST_SPEED] then
    disable_test_speed_val = sdk_config[M.RES_KEY.EX_DISABLE_TEST_SPEED]
  end
  local min_down_speed = ali_down_min_speed or cloud_config.DEFAULT_MIN_DOWN_SPEED
  local min_down_speed_bit = min_down_speed * 8
  local is_oversea_val = M.is_oversea()
  local cur_env = M.get_cloud_env()
  local is_test_env_val = M.ENV.DEBUG == cur_env
  local cloud_game_id = cloud_config.CloudGameId
  local params = {
    cloud_game_id = cloud_game_id,
    trace_id = trid,
    app_key = aliyun_app_key,
    app_secret = aliyun_app_secret,
    open_id = aliyun_open_id,
    min_download_speed_bitps = min_down_speed_bit,
    ab_test_flag = ali_config_ab_test_flag,
    disable_test_speed = disable_test_speed_val,
    is_over_sea = is_oversea_val,
    is_test_env = is_test_env_val,
    hw_qos_appkey = hw_qos_appkey,
    hw_qos_appsecret = hw_qos_appsecret,
    cloud_game_ext_config = cloud_game_ext_config
  }
  E.LOG.debug(TAG, "init_cloud trace_id:" .. tostring(trid) .. ", ab_flag:" .. tostring(M.ab_test_flag) .. ", is_over_sea:" .. tostring(is_oversea_val) .. ", is_test_env:" .. tostring(is_test_env_val))
  E.LOG.debug(TAG, "init_cloud appkey:" .. tostring(aliyun_app_key))
  local vendor_name = M.get_vendor_name()
  UNI.async_call(vendor_name, M.ASYNC_INIT_CLOUD_GAME, params, nil, function(succ, ...)
    local body = (...)
    E.LOG.debug(TAG, "init ASYNC_INIT_CLOUD_GAME finish >>")
    E.LOG.debug(TAG, body)
    if succ and body then
      ali_cloud_biz_params = body[LUA_KEY_ALIYUN_BIZ_PARAMS]
      ali_cloud_region_name = body[LUA_KEY_REGION_NAME]
    end
    cb(succ, ...)
  end)
end

local function check_ali_cloud_init_params(cb)
  if ali_cloud_biz_params then
    E.LOG.debug(TAG, "get_ali_cloud_biz_params >>")
    cb(true)
    return
  end
  M._init_cloud_native(function(succ, ...)
    if succ then
      cb(true)
    else
      cb(false, ...)
    end
  end)
end

local function get_local_gaid(cb)
  if current_ali_cloud_gaid then
    E.LOG.debug(TAG, "get_local_gaid# find and return:" .. tostring(current_ali_cloud_gaid))
    cb(current_ali_cloud_gaid)
    return
  end
  local gaid = CLOUD_AGST_EXT_GAID:get()
  if not gaid then
    E.Sysinfo.gaid_async(function(result)
      gaid = result.value
      E.LOG.debug(TAG, "get_local_gaid# async callback:" .. tostring(gaid))
      gaid = gaid or ""
      current_ali_cloud_gaid = gaid
      CLOUD_AGST_EXT_GAID:set(gaid)
      cb(gaid)
    end)
  else
    E.LOG.debug(TAG, "get_local_gaid# has agst gaid in sp: " .. tostring(gaid))
    current_ali_cloud_gaid = gaid
    cb(gaid)
  end
end

local function get_agst_token(cb)
  if not ali_agst_trace_time or "" == ali_agst_trace_time then
    ali_agst_trace_time = E.time()
  end
  local timestamp = ali_agst_trace_time
  local pid = E.Sysinfo.device_with_android_id()
  local ext_obj = {}
  ext_obj.ut = E.get_pkg_info().utdid
  ext_obj.oi = aliyun_open_id
  
  local function get_gaid_handler(gaid)
    ext_obj.ga = gaid
    local ext_str = JSON.encode(ext_obj)
    E.LOG.debug(TAG, "agst# login pid: " .. tostring(pid) .. " ,ext: " .. tostring(ext_str) .. ", time:" .. tostring(timestamp) .. ", gaid:" .. tostring(gaid))
    local pack = compat_string.pack("<Bs1I4Bs1", AGST_VERSION, pid, timestamp, AGST_EXT_TYPE, ext_str)
    local agst_token = _ejoysdk_crypt.base64encode(pack)
    cb(agst_token)
  end
  
  local is_oversea = M.is_oversea()
  if is_oversea then
    E.LOG.debug(TAG, "is oversea, now try get gaid")
    get_local_gaid(function(gaid)
      get_gaid_handler(gaid)
    end)
  else
    E.LOG.warn(TAG, "is NOT oversea, now skip get gaid")
    get_gaid_handler("")
  end
end

local function check_cloud_res_request_param_valid()
  local is_oversea = M.is_oversea()
  local valid
  if false == is_oversea then
    valid = "" ~= ali_cloud_biz_params
  else
    valid = true
  end
  E.LOG.debug(TAG, "check_cloud_res_request_param_valid result:" .. tostring(valid) .. ", is_oversea:" .. tostring(is_oversea))
  return valid
end

function M._request_cloud_res(cb)
  E.LOG.debug(TAG, "_request_cloud_res begin")
  if cloud_config.PaasPlatform == cloud_config.PAAS_PLATFORM.TTG then
    get_agst_token(function(agst_token)
      local params = {
        agst = agst_token,
        cloudGameId = cloud_config.CloudGameId,
        regionName = ali_cloud_region_name
      }
      M.request_cloud_service(M.SERVICE.CLOUD_RES_LOCK, params, function(succ1, ...)
        if succ1 then
          CSTAT.stat_action("mini_client_request_source_recieve", nil, true, nil)
        else
          local code, msg = ...
          CSTAT.stat_action_fail("mini_client_request_source_recieve", nil, code, msg)
        end
        cb(succ1, ...)
      end)
    end)
  else
    check_ali_cloud_init_params(function(succ, ...)
      if succ then
        local is_req_params_valid = check_cloud_res_request_param_valid()
        if is_req_params_valid then
          get_agst_token(function(agst_token)
            local params = {
              bizParam = ali_cloud_biz_params,
              regionName = ali_cloud_region_name,
              agst = agst_token,
              cloudGameId = cloud_config.CloudGameId
            }
            E.LOG.debug(TAG, "_request_cloud_res, before request, biz_params >>")
            E.LOG.debug(TAG, params)
            CSTAT.stat_action("mini_client_request_source")
            M.request_cloud_service(M.SERVICE.ALI_CLOUD_RES_LOCK, params, function(succ2, ...)
              if succ2 then
                CSTAT.stat_action("mini_client_request_source_recieve", nil, true, nil)
              else
                local code, msg = ...
                CSTAT.stat_action_fail("mini_client_request_source_recieve", nil, code, msg)
              end
              cb(succ2, ...)
            end)
          end)
        else
          E.LOG.debug(TAG, "_request_cloud_res, failed")
          cb(false, CONTS.CLOUD_GAME_ERROR_CODES.ALIYUN_BIZ_PARAMS_INVALID, "biz params invalid")
        end
      else
        cb(false, ...)
      end
    end)
  end
end

local function parse_remote_game_res_info(res_data)
  local _res_download_url = res_data[M.RES_KEY.RES_DOWNLOAD_URL]
  local _res_size_bytes = res_data[M.RES_KEY.RES_SIZE_BYTES] or "0"
  local _res_mark = res_data[M.RES_KEY.RES_MARK]
  local _package_record_id = res_data[M.RES_KEY.PKG_RECORD_ID] or "0"
  local _game_res_info = {
    size_bytes = nil,
    size_in_g = nil,
    res_download_url = _res_download_url,
    res_mark = _res_mark,
    package_record_id = _package_record_id
  }
  if tonumber(_res_size_bytes) > 0 then
    _game_res_info.size_bytes = _res_size_bytes
    E.LOG.debug(TAG, "parse_remote_game_res_info, remote has size:" .. tostring(_res_size_bytes))
  else
    local ex = res_data[M.RES_KEY.EX]
    local sdk_config = ex and ex[M.RES_KEY.EX_SDK_CONFIG] or nil
    if sdk_config then
      local game_res_info = sdk_config and sdk_config[M.RES_KEY.EX_GAME_RES_INFO] or nil
      if game_res_info then
        _res_size_bytes = game_res_info[M.RES_KEY.EX_RES_SIZE_BYTES] or "0"
        if tonumber(_res_size_bytes) > 0 then
          E.LOG.debug(TAG, "parse_remote_game_res_info, remote NOT has size and ext has size:" .. tostring(_res_size_bytes))
          _game_res_info.size_bytes = _res_size_bytes
        end
      end
    end
  end
  M.set_game_res_info(_game_res_info)
end

local function cache_cloud_res_data(res_data)
  E.LOG.debug(TAG, "server config >>")
  E.LOG.debug(TAG, res_data)
  M.set_server_config_data(res_data)
  aliyun_open_id = res_data[M.RES_KEY.OPEN_ID]
  local res_download_url = res_data[M.RES_KEY.RES_DOWNLOAD_URL]
  E.LOG.debug(TAG, "res_download_url：" .. tostring(res_download_url))
  cloud_config.set_remote_urls(res_download_url)
  local res_mark = res_data[M.RES_KEY.RES_MARK]
  E.LOG.debug(TAG, "resourceMark: " .. tostring(res_mark))
  local package_record_id = res_data[M.RES_KEY.PKG_RECORD_ID] or "0"
  E.LOG.debug(TAG, "package_record_id: " .. tostring(package_record_id))
  local local_record_id = E.get_parent_pkg_record_id() or "0"
  if res_download_url and tonumber(package_record_id) > 0 then
    if M.get_cloud_env() == M.ENV.DEBUG and tonumber(local_record_id) > tonumber(package_record_id) then
      local error_msg = "服务器资源版本是旧版资源，请务必到打包系统更新资源！！！"
      E.Modal.alert("注意", error_msg, function()
        E.LOG.debug(TAG, "资源版本较低")
      end)
    elseif M.RES_MARK_STATE.TEST == res_mark then
      E.Modal.alert("停服维护前预发布包", "当前母包资源发布状态处于测试中，请停服维护完成后务必将资源发布成正式！停服维护后同时资源发布后此弹窗不再显示", function()
        E.LOG.debug(TAG, "当前资源发布状态为测试中")
      end)
    end
  else
    E.LOG.warn(TAG, "config game res not configed, need check!!!")
  end
  parse_remote_game_res_info(res_data)
end

function M._request_cloud_config(cb)
  E.LOG.debug(TAG, "_request_cloud_config begin")
  local params = {}
  params.pkg_info = E.get_pkg_info()
  params.parentPkgId = E.get_parent_pkg_id()
  params.parentPkgRid = E.get_parent_pkg_record_id()
  params.cloudGameId = cloud_config.CloudGameId
  get_agst_token(function(agst_token)
    E.LOG.debug(TAG, "_request_cloud_config agst_token:" .. tostring(agst_token))
    params.agst = agst_token
    CSTAT.stat_action("mini_client_request_source_config")
    E.log(params)
    M.request_cloud_service(M.SERVICE.CLOUD_CONFIG, params, function(succ, ...)
      if succ then
        E.LOG.debug(TAG, "_request_cloud_config succ")
        CSTAT.stat_action("request_cloud_config_succ", nil, true, nil)
        local res_data = (...)
        cache_cloud_res_data(res_data)
      else
        local code, msg = ...
        E.LOG.warn(TAG, "_request_cloud_config failed, code:" .. tostring(code) .. ", msg:" .. tostring(msg))
        CSTAT.stat_action_fail("request_cloud_config_fail", nil, code, msg)
      end
      cb(succ, ...)
    end)
  end)
end

function M._get_schedule_start_params(cb)
  E.LOG.debug(TAG, "start_game begin, start_mode is scheduling, now start request_cloud_res")
  local cloud_schedule_config = M.get_server_schedule_config()
  if cloud_schedule_config and cloud_schedule_config[BCGA.RES_KEY.GAME_SESSION] and cloud_schedule_config[BCGA.RES_KEY.TOKEN] then
    E.LOG.debug(TAG, "cloud_schedule_config not nil, use it directly")
    local params = {
      token = cloud_schedule_config[BCGA.RES_KEY.TOKEN],
      game_session = cloud_schedule_config[BCGA.RES_KEY.GAME_SESSION]
    }
    cb(true, params)
  else
    E.LOG.debug(TAG, "cloud_schedule_config is nil, now request for cloud_res")
    M._request_cloud_res(function(succ, ...)
      if succ then
        E.LOG.debug(TAG, "request_cloud_res succ")
        local res_data = (...)
        E.LOG.debug(TAG, ">>>>>>>> res_data>>")
        E.LOG.debug(TAG, res_data)
        local tok = res_data[BCGA.RES_KEY.TOKEN]
        local session = res_data[BCGA.RES_KEY.GAME_SESSION]
        local scheduleId = res_data[BCGA.RES_KEY.SCHEDULE_ID]
        local resInfo = res_data[BCGA.RES_KEY.CLOUD_RES_INFO]
        local game_session_val = session
        if nil == game_session_val or "" == game_session_val then
          game_session_val = scheduleId
        end
        local params = {
          token = tok,
          game_session = game_session_val,
          resInfo = resInfo
        }
        E.CONFIG.set_config("cloudgame_cg_game_session", session or "")
        local stat_params = {
          game_session = session,
          token = tok,
          is_priority_high = true
        }
        CSTAT.stat_action("mini_client_res_result", nil, true, stat_params)
        cb(true, params)
      else
        local code, msg = ...
        CSTAT.stat_action_fail("mini_client_res_result", nil, code, msg)
        E.LOG.warn(TAG, "request_cloud_res failed, code:" .. tostring(code) .. ", msg:" .. tostring(msg))
        cb(false, ...)
      end
    end)
  end
end

function M._cache_cloud_static_config(sdk_config)
  E.LOG.debug(TAG, "_cache_cloud_static_config begin")
  local restrict_rules = sdk_config[M.RES_KEY.EX_RESTRICT_RULES]
  M.set_server_restrict_rules(restrict_rules)
  M.set_sdk_config(sdk_config)
  local skip_time_before_restrict_check_sec = sdk_config[M.RES_KEY.EX_SKIP_TIME_BEFORE_CHECK_RESTRICT_SEC] or 0
  M.set_server_skip_time_before_restrict_check_sec(skip_time_before_restrict_check_sec)
  local updating_limit_size = sdk_config[M.RES_KEY.EX_UPDATING_WITH_CONNECT_SIZE_LIMIT] or 0
  cloud_config.update_updating_connect_size_limit(updating_limit_size)
  local download_rules_config = sdk_config[M.RES_KEY.EX_DOWNLOAD_RULES]
  DOWNLOAD_RULES.handle_sdk_config_from_server(download_rules_config)
  E.LOG.debug(TAG, "restrict_rules >>")
  E.LOG.debug(TAG, restrict_rules)
  local instant_config = sdk_config[M.RES_KEY.EX_INSTANT_CONFIG]
  M.set_instant_config(instant_config)
  local is_show_download_progress = sdk_config[M.RES_KEY.EX_IS_DOWNLOAD_PROGRESS]
  if nil == is_show_download_progress then
    is_show_download_progress = true
  end
  cloud_config.set_download_progress_notification_enabled(is_show_download_progress)
  local app_params = sdk_config[M.RES_KEY.EX_APP_PARAMS]
  ali_down_min_speed = DOWNLOAD_RULES.get_config_min_download_speed()
  ali_config_ab_test_flag = DOWNLOAD_RULES.is_download_control_disable()
  aliyun_app_key = app_params.app_key
  E.log(app_params)
  aliyun_app_secret = app_params.app_secret
  hw_qos_appkey = app_params[M.RES_KEY.EX_HW_QOS_APPKEY]
  hw_qos_appsecret = app_params[M.RES_KEY.EX_HW_QOS_APPSECRET]
  cloud_game_ext_config = sdk_config[M.RES_KEY.EX_CLOUD_SDK_CONFIG]
  local splash_rules = sdk_config[M.RES_KEY.EX_SPLASH_RULES]
  if splash_rules then
    local is_show_btn = splash_rules[M.RES_KEY.EX_IS_SHOW_BTN]
    cloud_config.set_is_splash_btn(is_show_btn)
  end
  local continue_play_time = sdk_config[M.RES_KEY.EX_CONTINUE_PLAY_TIME]
  if continue_play_time then
    cloud_config.set_continue_play_time(continue_play_time)
  end
  local float_panel_config = sdk_config[M.RES_KEY.FLOAT_PANEL_CONFIG]
  if float_panel_config then
    local templete = float_panel_config[M.RES_KEY.REMAIN_TIME_TEMPLETE]
    cloud_config.update_remain_time_templete(templete)
  else
    E.LOG.debug(TAG, "float panel config is nil")
  end
end

function M._cache_free_flow_config(config)
  local free_flow_open = config[M.RES_KEY.EX_FREE_FLOW_OPEN]
  if nil ~= free_flow_open then
    E.LOG.debug(TAG, "config is free flow open >> " .. tostring(free_flow_open))
    cloud_free_flow.set_is_free_flow_open(free_flow_open)
  end
  local mobile_auth = config[M.RES_KEY.EX_MOBILE_AUTH]
  if mobile_auth then
    E.LOG.debug(TAG, "config the mobile auth secret >> " .. tostring(mobile_auth))
    free_flow.set_mobile_auth_secret(mobile_auth)
  end
  local free_flow_config = config[M.RES_KEY.EX_FREE_FLOW]
  if free_flow_config then
    local productId = free_flow_config[M.RES_KEY.EX_FREE_FLOW_PRODUCTID]
    local xgipAppId = free_flow_config[M.RES_KEY.EX_FREE_FLOW_XGIPAPPID]
    local dataPkgName = free_flow_config[M.RES_KEY.EX_FREE_FLOW_DATAPKG_NAME]
    E.LOG.debug(TAG, "config the free flow config, productId  >> " .. tostring(productId) .. ", xgipAppId >> " .. tostring(xgipAppId) .. ", dataPkgName >> " .. tostring(dataPkgName))
    free_flow.set_ali_free_flow_config(productId, xgipAppId, dataPkgName)
  end
end

function M.get_min_download_speed()
  return ali_down_min_speed or cloud_config.DEFAULT_MIN_DOWN_SPEED
end

return M
