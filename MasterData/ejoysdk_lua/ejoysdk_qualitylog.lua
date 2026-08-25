local E = require("ejoysdk_lua.ejoysdk")
local ET = require("ejoysdk_lua.ejoysdk_topic")
local guuid = require("ejoysdk_lua.ejoysdk_uuid")
local V = require("ejoysdk_lua.version")
local EU = require("ejoysdk_lua.ejoysdk_uuid")
local EM = require("ejoysdk_lua.ejoysdk_module")
local ESTAT = require("ejoysdk_lua.ejoysdk_stat")
local subscribe = ET.subscribe
local sformat = string.format
local M = {}
local TAG = EM.MODULE.EJOYSDK_BASE_MODULE .. "qualitylog"
M.TRACE_NAMES = {
  INIT = "init",
  LOGIN = "login",
  PAY = "pay",
  CHAT_CONNECT = "chat_connect"
}
M.EVENT_NAMES = {
  SDK_START_UP = "sdk.init.invoke",
  SDK_START_UP_END = "sdk.init.end",
  SDK_VENDOR_LOGIN_INVOKE = "sdk.vendorlogin.invoke",
  SDK_VENDOR_LOGIN_END = "sdk.vendorlogin.end",
  SDK_ACQUIRE_INVOKE = "sdk.acquire.invoke",
  SDK_ACQUIRE_END = "sdk.acquire.end",
  SDK_ACQUIRE_HTTP_DATA = "sdk.acquire.http.data",
  SDK_ACQUIRE_INVOKE_FREQUENCY = "sdk.acquire.invoke.frequency",
  SDK_REGISTER_SUCC = "sdk.register.succ",
  SDK_ROLE_LOGIN_INVOKE = "sdk.login.invoke",
  SDK_ROLE_LOGIN_END = "sdk.login.end",
  SDK_PAY_INVOKE = "sdk.pay.invoke",
  SDK_PAY_CREATE_ORDER_INVOKE = "sdk.pay.createorder.invoke",
  SDK_PAY_END = "sdk.pay.end",
  SDK_HTTP_INVOKE = "sdk.http.invoke",
  SDK_HTTP_FINISH = "sdk.http.finish",
  SDK_REALNAME_QRSCAN = "sdk.realname.qrscan",
  SDK_CHAT_CONNECT = "sdk.chat.connect",
  SDK_LOGOUT_INVOKE = "sdk.logout.invoke",
  SDK_OFFLINE_INVOKE = "sdk.offline.invoke",
  SDK_PLAYER_OFFLINE_INVOKE = "sdk.playeroffline.invoke"
}
local ql_inited = false
local log_state = {}
local gp_inited = false
local cache_init_req_logs = {}

local function make_state_param(trace_name)
  M.init()
  local trace_id = string.gsub(guuid(), "-", "")
  local state_params = {
    trace_name = trace_name,
    trace_id = trace_id,
    start_timestamp = E.system_clock()
  }
  return state_params
end

local function make_base_param(state_params)
  local consuming_time = 0
  local trace_id = ""
  local sys_time = E.system_clock()
  if state_params and sys_time then
    trace_id = state_params.trace_id
    consuming_time = tonumber(sys_time) - tonumber(state_params.start_timestamp or 0)
  end
  local param = {
    trace_id = trace_id,
    sdk_version = E.get_sdk_version_name("EJOYSDK"),
    net_type = E.Sysinfo.network_type(),
    net_type_name = E.Sysinfo.network_type_name(),
    trace_consuming_time = consuming_time,
    lua_vesion = V.LUA_VERSION
  }
  return param
end

local function get_start_log_param(trace_name, sub_params)
  local state_params = make_state_param(trace_name)
  if log_state[trace_name] then
    _ejoysdk.log(sformat("trace %s not finish, trace id = %s", trace_name, tostring(state_params.trace_id)))
  end
  log_state[trace_name] = state_params
  local params = make_base_param(state_params)
  params.sub_params = sub_params
  sub_params.trace_consuming_time = params.trace_consuming_time
  params.trace_consuming_time = nil
  sub_params.trace_id = params.trace_id
  params.trace_id = nil
  return params
end

local function get_end_log_param(trace_name, sub_params)
  local state_params = log_state[trace_name] or false
  log_state[trace_name] = nil
  if not state_params then
    _ejoysdk.log(sformat("trace %s not start", trace_name))
  end
  local params = make_base_param(state_params)
  params.sub_params = sub_params
  sub_params.trace_consuming_time = params.trace_consuming_time
  params.trace_consuming_time = nil
  sub_params.trace_id = params.trace_id
  params.trace_id = nil
  return params
end

local is_apm_inited = false

local function _check_init_apm(cb)
  local configed_product = E.CONFIG.get_config("product")
  if not configed_product then
    _ejoysdk.log("not configed, cannot init apm.")
    cb(false)
    return
  end
  if true == is_apm_inited then
    cb(true)
    return
  end
  E.LOG.debug(TAG, "apm begin init")
  local apm = require("ejoysdk_lua.vendors.apm")
  local init_params = {}
  apm.init(init_params, function(succ)
    if succ then
      E.LOG.debug(TAG, "apm init result:" .. tostring(succ))
      is_apm_inited = true
    end
    cb(succ)
  end)
end

local function commit_to_apus(event_name, params)
  if not E.has_apus_vendor() then
    return
  end
  _check_init_apm(function()
    local ETAPUS = require("ejoysdk_lua.ejoysdk_to_apus")
    ETAPUS.commit_event(event_name, params)
  end)
end

local function jf_commit_event(event_name, params, is_upload_now, is_upload_to_apus, is_priority_high)
  if ql_inited then
    local JF = require("ejoysdk_lua.vendors.jf")
    local options = {}
    if is_upload_now then
      options = {
        [JF.OPTION_KEY.IS_UPLOAD_NOW] = true
      }
    elseif is_priority_high then
      options = {
        [JF.OPTION_KEY.IS_PRIORITY_HIGH] = true
      }
    end
    JF.commit_event(event_name, params, options)
    if is_upload_to_apus then
      commit_to_apus(event_name, params and params.sub_params or params)
    end
  end
end

local function jf_commit_action(action, action_type, result, params, is_upload_now, is_upload_to_apus, is_priority_high)
  if not ql_inited then
    return
  end
  local commit_params = params and params.sub_params or params or {}
  if is_upload_now then
    commit_params.is_upload_now = is_upload_now
  end
  commit_params.is_priority_high = is_priority_high or false
  ESTAT.stat_action(action, action_type, result, commit_params)
  if is_upload_to_apus then
    commit_to_apus("sdk.lua.action", commit_params)
  end
end

local function jf_commit_action_fail(action, action_type, code, msg, params, opts)
  if not ql_inited then
    return
  end
  local commit_params = params and params.sub_params or params or {}
  opts = opts or {}
  local is_upload_now = opts.is_upload_now
  local is_upload_to_apus = opts.is_upload_to_apus
  local is_priority_high = opts.is_priority_high or false
  if is_upload_now then
    commit_params.is_upload_now = is_upload_now
  end
  if is_priority_high then
    commit_params.is_priority_high = is_priority_high
  end
  commit_params.code = code
  commit_params.msg = msg
  ESTAT.stat_action_fail(action, action_type, commit_params)
  if is_upload_to_apus then
    commit_to_apus("sdk.lua.action", commit_params)
  end
end

local function gangplank_init_start_handler()
  E.LOG.debug(TAG, "set a test action, jf_test_action")
  jf_commit_event(M.EVENT_NAMES.SDK_START_UP, get_start_log_param(M.TRACE_NAMES.INIT, {}), false, true, true)
  ESTAT.sdk_init_report({
    biz_act = "start",
    biz_st = "succ",
    biz_co = "200"
  })
end

local function gangplank_inited_handler(succ, code, msg)
  local params = get_end_log_param(M.TRACE_NAMES.INIT, {
    success = succ,
    code = code,
    msg = msg
  })
  jf_commit_event(M.EVENT_NAMES.SDK_START_UP_END, params, false, true, true)
  ESTAT.sdk_init_report({
    biz_act = "finish",
    biz_st = succ and "succ" or "fail",
    biz_co = succ and "200" or "400",
    biz_params = {
      success = succ,
      code = code,
      msg = msg
    }
  })
  gp_inited = true
  if cache_init_req_logs and #cache_init_req_logs > 0 then
    E.log("cache_init_req_logs, count: " .. #cache_init_req_logs)
    local ok, m_api_stats = pcall(require, "ejoysdk_lua.apm-sdk-lua.apus")
    if ok and nil ~= m_api_stats and m_api_stats.count_platform_api_call then
      for _, cv in ipairs(cache_init_req_logs) do
        m_api_stats.count_platform_api_call(cv.u_domain, cv.u_api, cv.status, cv.e_cost, cv.r_method)
      end
    end
    cache_init_req_logs = {}
  end
end

local function pay_invoke_handler()
  jf_commit_event(M.EVENT_NAMES.SDK_PAY_INVOKE, get_start_log_param(M.TRACE_NAMES.PAY, {}), false, true, true)
end

local function pay_handler(pa)
  pa.success = true
  local params = get_end_log_param(M.TRACE_NAMES.PAY, pa)
  jf_commit_event(M.EVENT_NAMES.SDK_PAY_END, params, false, true, true)
end

local function pay_failed_handler(pa)
  pa.success = false
  local params = get_end_log_param(M.TRACE_NAMES.PAY, pa)
  jf_commit_event(M.EVENT_NAMES.SDK_PAY_END, params, false, true, true)
end

local function register_succ_handler()
  E.LOG.debug(TAG, "register_succ_handler received")
  jf_commit_event(M.EVENT_NAMES.SDK_REGISTER_SUCC, {}, false, true, true)
end

function M.log_vendor_login_invoke(vendor_name)
  jf_commit_event(M.EVENT_NAMES.SDK_VENDOR_LOGIN_INVOKE, get_start_log_param(M.TRACE_NAMES.LOGIN, {type = vendor_name}), false, true, true)
  ESTAT.sdk_vendorlogin_report({
    biz_act = "start",
    biz_st = "succ",
    biz_co = "200"
  })
end

function M.log_vendor_login(vendor_name, ...)
  local params = get_end_log_param(M.TRACE_NAMES.LOGIN, {success = true, type = vendor_name})
  jf_commit_event(M.EVENT_NAMES.SDK_VENDOR_LOGIN_END, params, false, true, true)
  ESTAT.sdk_vendorlogin_report({
    biz_act = "finish",
    biz_st = "succ",
    biz_co = "200",
    biz_params = {vendor_name = vendor_name}
  })
end

function M.log_vendor_login_failed(vendor_name, code, msg)
  local sub_params = {}
  sub_params.code = code
  sub_params.msg = msg
  sub_params.success = false
  sub_params.type = vendor_name
  local params = get_end_log_param(M.TRACE_NAMES.LOGIN, sub_params)
  jf_commit_event(M.EVENT_NAMES.SDK_VENDOR_LOGIN_END, params, false, true, true)
  ESTAT.sdk_vendorlogin_report({
    biz_act = "finish",
    biz_st = "fail",
    biz_co = "400",
    biz_params = {
      vendor_name = vendor_name,
      code = code,
      msg = msg
    }
  })
end

local version_table_str

local function get_sdk_plugin_versions()
  if version_table_str then
    return version_table_str
  end
  local version_table = {}
  local display_sdk_infos = E.get_display_sdk_infos()
  for k, v in pairs(display_sdk_infos) do
    version_table[k or v.name] = tostring(v.version or "")
  end
  local JSON = require("ejoysdk_lua.ejoysdk_json")
  version_table_str = JSON.encode(version_table)
  return version_table_str
end

function M.log_acquire_invoke(platform)
  jf_commit_event(M.EVENT_NAMES.SDK_ACQUIRE_INVOKE, get_start_log_param(M.TRACE_NAMES.LOGIN, {type = platform}), false, true, true)
  ESTAT.sdk_acquire_report({
    biz_act = "start",
    biz_st = "succ",
    biz_co = "200",
    biz_params = {platform = platform}
  })
end

function M.log_acquire(vendor_name, ...)
  local params = get_end_log_param(M.TRACE_NAMES.LOGIN, {success = true, type = vendor_name})
  local UIM = require("ejoysdk_lua.user_info_manager")
  local channel_cloud_game_tag = UIM.get_channel_cloud_game_tag()
  params[UIM.PKG_INFO_KEY.KEY_CHANNEL_CLOUD_GAME_TAG] = channel_cloud_game_tag
  params[UIM.PKG_INFO_KEY.KEY_SDK_PLUGIN_VERSIONS] = get_sdk_plugin_versions()
  jf_commit_event(M.EVENT_NAMES.SDK_ACQUIRE_END, params, false, true, true)
  ESTAT.sdk_acquire_report({
    biz_act = "finish",
    biz_st = "succ",
    biz_co = "200",
    biz_params = {vendor_name = vendor_name}
  })
end

function M.log_acquire_failed(vendor_name, code, msg)
  local sub_params = {}
  sub_params.code = code
  sub_params.msg = msg
  sub_params.success = false
  sub_params.type = vendor_name
  local params = get_end_log_param(M.TRACE_NAMES.LOGIN, sub_params)
  local UIM = require("ejoysdk_lua.user_info_manager")
  local channel_cloud_game_tag = UIM.get_channel_cloud_game_tag()
  params[UIM.PKG_INFO_KEY.KEY_CHANNEL_CLOUD_GAME_TAG] = channel_cloud_game_tag
  jf_commit_event(M.EVENT_NAMES.SDK_ACQUIRE_END, params, false, true, true)
  ESTAT.sdk_acquire_report({
    biz_act = "finish",
    biz_st = "fail",
    biz_co = "400",
    biz_params = {
      vendor_name = vendor_name,
      code = code,
      msg = msg
    }
  })
end

function M.log_acquire_http_data(temp_params)
  local sub_params = temp_params
  local params = make_base_param()
  params.sub_params = sub_params
  local UIM = require("ejoysdk_lua.user_info_manager")
  local channel_cloud_game_tag = UIM.get_channel_cloud_game_tag()
  params[UIM.PKG_INFO_KEY.KEY_CHANNEL_CLOUD_GAME_TAG] = channel_cloud_game_tag
  jf_commit_event(M.EVENT_NAMES.SDK_ACQUIRE_HTTP_DATA, params, false, false, true)
end

function M.log_login_invoke()
  jf_commit_event(M.EVENT_NAMES.SDK_ROLE_LOGIN_INVOKE, get_start_log_param(M.TRACE_NAMES.LOGIN, {}), false, true, true)
  ESTAT.sdk_rolelogin_report({
    biz_act = "start",
    biz_st = "succ",
    biz_co = "200"
  })
end

function M.log_login(...)
  local params = get_end_log_param(M.TRACE_NAMES.LOGIN, {success = true})
  jf_commit_event(M.EVENT_NAMES.SDK_ROLE_LOGIN_END, params, false, true, true)
  ESTAT.sdk_rolelogin_report({
    biz_act = "finish",
    biz_st = "succ",
    biz_co = "200"
  })
end

function M.log_login_failed(...)
  local code, msg = ...
  local sub_params = {
    code = tostring(code),
    msg = tostring(msg)
  }
  sub_params.success = false
  local params = get_end_log_param(M.TRACE_NAMES.LOGIN, sub_params)
  jf_commit_event(M.EVENT_NAMES.SDK_ROLE_LOGIN_END, params, false, true, true)
  ESTAT.sdk_rolelogin_report({
    biz_act = "finish",
    biz_st = "fail",
    biz_co = "400",
    biz_params = {code = code, msg = msg}
  })
end

function M.commit_event(event_name, params, is_priority_high)
  local event_params = make_base_param()
  event_params.sub_params = params
  jf_commit_event(event_name, event_params, false, true, is_priority_high)
end

function M.commit_action_main(action_name, action_type, result, params)
  if not ql_inited then
    M.init()
  end
  jf_commit_action(action_name, action_type, result, params, false, true, true)
end

function M.commit_action_succ_main(action, action_type, params)
  if not ql_inited then
    M.init()
  end
  jf_commit_action(action, action_type, true, params, false, true, true)
end

function M.commit_action_fail_main(action, action_type, code, msg, params)
  if not ql_inited then
    M.init()
  end
  local opts = {is_priority_high = true, is_upload_to_apus = true}
  jf_commit_action_fail(action, action_type, code, msg, params, opts)
end

local function log_http_invoke(uuid, url)
  local sub_params = {url = url}
  local params = get_start_log_param(uuid, sub_params, sub_params)
  jf_commit_event(M.EVENT_NAMES.SDK_HTTP_INVOKE, params)
end

local function log_http_finish(uuid, is_post, url, resp)
  local body = resp.body or {}
  local body_code = body.code
  local body_msg = body.message
  local sub_params = {
    is_post = is_post,
    url = url,
    status = resp.status,
    code = body_code,
    msg = body_msg
  }
  local params = get_end_log_param(uuid, sub_params)
  jf_commit_event(M.EVENT_NAMES.SDK_HTTP_FINISH, params)
end

local function log_to_apus(url, resp, start_clock, is_post)
  local ok, m_api_stats = pcall(require, "ejoysdk_lua.apm-sdk-lua.apus")
  if ok and nil ~= m_api_stats then
    local u_domain, u_api = string.match(url, "([%w%-%.]*%.[%w%-]+%.%w+)%/([^?#]*)")
    if u_domain and u_api then
      local e_cost
      if resp.http_ext_params and resp.http_ext_params.cost then
        e_cost = resp.http_ext_params.cost
      else
        e_cost = E.system_clock() - start_clock
      end
      if m_api_stats.count_platform_api_call then
        local r_method = 1
        if is_post then
          r_method = 2
        end
        if false == gp_inited then
          table.insert(cache_init_req_logs, {
            u_domain = u_domain,
            u_api = u_api,
            status = resp.status,
            e_cost = e_cost,
            r_method = r_method
          })
          if #cache_init_req_logs > 100 then
            table.remove(cache_init_req_logs, 1)
          end
          return
        end
        m_api_stats.count_platform_api_call(u_domain, u_api, resp.status, e_cost, r_method)
      end
    end
  end
end

function M.make_log_http_callback(url, is_post, params, cb, start_clock, is_apm_collect)
  local cb_inner = cb
  if params.trace then
    local trace_uuid = string.gsub(EU(), "-", "")
    if not params.headers then
      params.headers = {}
    end
    params.headers["trace-id"] = trace_uuid
    log_http_invoke(trace_uuid, url)
    
    function cb_inner(resp)
      log_http_finish(trace_uuid, is_post, url, resp)
      if is_apm_collect then
        log_to_apus(url, resp, start_clock, is_post)
      end
      do return cb end
      return cb, resp, resp, start_clock, is_post
    end
  elseif is_apm_collect then
    M.init()
    
    function cb_inner(resp)
      log_to_apus(url, resp, start_clock, is_post)
      do return cb end
      return cb, resp, resp, start_clock, is_post
    end
  end
  return cb_inner
end

function M.socket_connect_statistics(state, temp_param, error_msg)
  local params = temp_param or {}
  params.detail_msg = error_msg or ""
  local CHATSTATES = require("ejoysdk_lua.chat.ejoysdk_chat_states")
  if state == CHATSTATES.CONNECT_INVOKE then
    params.action = "connect_invoke"
    params = get_start_log_param(M.TRACE_NAMES.CHAT_CONNECT, params)
  elseif state == CHATSTATES.CONNECT_START then
    params.action = "connect_start"
    params = get_start_log_param(M.TRACE_NAMES.CHAT_CONNECT, params)
  elseif state == CHATSTATES.CONNECT_ERROR then
    params.action = "connect_error"
    params = get_end_log_param(M.TRACE_NAMES.CHAT_CONNECT, params)
  elseif state == CHATSTATES.CONNECTED then
    params.action = "connect_connected"
    params = get_end_log_param(M.TRACE_NAMES.CHAT_CONNECT, params)
  elseif state == CHATSTATES.ERROR then
    params.action = "connect_readwrite_error"
    params = get_end_log_param(M.TRACE_NAMES.CHAT_CONNECT, params)
  elseif state == CHATSTATES.CONNECT_LOST then
    params.action = "connect_lost"
    params = get_end_log_param(M.TRACE_NAMES.CHAT_CONNECT, params)
  elseif state == CHATSTATES.NO_LIMIT_RECONNECT_AT_NEXT_LOOP then
    params.action = "no_limit_reconnect_at_next_loop"
    params = get_end_log_param(M.TRACE_NAMES.CHAT_CONNECT, params)
  end
  jf_commit_event(M.EVENT_NAMES.SDK_CHAT_CONNECT, params)
  E.LOG.debug(TAG, "socket_connect_statistics, state:" .. state .. ", params >>")
  E.log(params)
end

function M.init()
  if ql_inited then
    return
  end
  ql_inited = true
  E = require("ejoysdk_lua.ejoysdk")
  _ejoysdk.log("qualitylog stat start init!")
  log_state = {}
  subscribe(ET.gangplank.INITSTART, gangplank_init_start_handler)
  subscribe(ET.gangplank.INITED, gangplank_inited_handler)
  subscribe(ET.gangplank.PAY_INVOKE, pay_invoke_handler)
  subscribe(ET.gangplank.PAY, pay_handler)
  subscribe(ET.gangplank.PAY_FAILED, pay_failed_handler)
  subscribe(ET.analytics.REGISTER, register_succ_handler)
end

return M
