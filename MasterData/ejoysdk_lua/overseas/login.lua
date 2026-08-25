local E = require("ejoysdk_lua.ejoysdk")
local ET = require("ejoysdk_lua.ejoysdk_topic")
local PROTOCOL = require("ejoysdk_lua.account.api.protocol")
local CONSTANTS = require("ejoysdk_lua.ejoysdk_constants")
local UTILS = require("ejoysdk_lua.ejoysdk_utils")
local AGST = require("ejoysdk_lua.vendors.agst_account")
local AEGIS_DATA = require("ejoysdk_lua.aegis.aegis_collect_data")
local EM = require("ejoysdk_lua.ejoysdk_module")
local AGST_VENDOR_NAME = "AGST"
local EQL = require("ejoysdk_lua.ejoysdk_qualitylog")
local HISTORY = require("ejoysdk_lua.account.official_history")
local STAT = require("ejoysdk_lua.ejoysdk_stat")
local LOGIN_API = require("ejoysdk_lua.account.api.login")
local ETracer = require("ejoysdk_lua.ejoysdk_span_reporter")
local ATracer = require("ejoysdk_lua.account.account_tracer")
local ESTAT = require("ejoysdk_lua.ejoysdk_stat")
local M = {}
local TAG = EM.MODULE.OVERSEAS .. "login"
local login_webview_option
local preload_call_timestamp_map = {}

function M.login(login_type, ext, cb)
  E.log("overseas.login ----called, login_type = " .. login_type)
  if not (type(ext) ~= "function" and ext) or not cb then
    cb = ext
    if AGST_VENDOR_NAME == login_type and AGST.has_marked_agst_official() then
      PROTOCOL.fail_callback(cb, CONSTANTS.OFFICIAL_ERR_CODES.CODE_AGST_HAS_BOUND, "游客已转正")
      return
    end
    LOGIN_API.login(login_type, nil, cb)
  elseif type(ext) == "table" then
    LOGIN_API.login(login_type, ext, cb)
  end
end

function M.login_with_challenge_info(challenge_info, challenge_callback)
  if LOGIN_API.login_with_challenge_info then
    LOGIN_API.login_with_challenge_info(challenge_info, challenge_callback)
  else
    E.LOG.error(TAG, "login_with_challenge_info has error, LOGIN_API do not has this function")
  end
end

function M.ignore_bind_agst(cb)
  if LOGIN_API.ignore_bind_agst then
    LOGIN_API.ignore_bind_agst(cb)
  else
    E.LOG.error(TAG, "ignore_bind_agst has error, LOGIN_API do not has this function")
  end
end

function M.bind_agst(cb)
  if LOGIN_API.bind_agst then
    LOGIN_API.bind_agst(cb)
  else
    E.LOG.error(TAG, "bind_agst has error, LOGIN_API do not has this function")
  end
end

function M.create_new_guest(cb)
  if LOGIN_API.create_new_guest then
    LOGIN_API.create_new_guest(cb)
  else
    E.LOG.error(TAG, "create_new_guest has error, LOGIN_API do not has this function")
  end
end

M.notify_login = LOGIN_API.notify_login
M.available_login_list = LOGIN_API.get_login_items

function M.get_agst_token(cb)
  local AGST_TOKEN = require("ejoysdk_lua.user_center.agst_token_manager")
  AGST_TOKEN.get_token(function(token)
    PROTOCOL.succ_callback(cb, {agst_token = token})
  end)
end

local device_score_data
local HOLO = require("ejoysdk_lua.ejoysdk_holo")
HOLO.get_device_score(function(succ, ...)
  if succ then
    device_score_data = (...)
  end
end)

local function performance_stat(url, performance_data)
  local timing = performance_data.timing or {}
  local FCP = tonumber(performance_data.FCP) or 0
  local DCL = tonumber(performance_data.DCL) or 0
  local webview_page_show = tonumber(performance_data.webview_page_show) or 0
  local start_time = tonumber(performance_data.invoke_timestamp) or 0
  local preload = performance_data.is_preload == true
  local cost_time = math.max(webview_page_show, DCL) - start_time
  local white_screen_cost = FCP - (tonumber(timing.navigationStart) or 0)
  local first_screen_cost = DCL - (tonumber(timing.navigationStart) or 0)
  local webview_show_cost = tonumber(performance_data.webview_show_cost) or 0
  local sdk_init_to_preload_duration
  local sdk_preload_to_login_duration = -1
  if performance_data.sdk_preload_invoke_timestamp then
    local preload_timestamp = tonumber(performance_data.sdk_preload_invoke_timestamp)
    sdk_preload_to_login_duration = start_time - preload_timestamp
    local ejoysdk_pf = require("ejoysdk_lua.performance.ejoysdk_performance")
    local sdk_init_timestamp = tonumber(ejoysdk_pf.get_sdk_init_invoke_timestamp())
    if sdk_init_timestamp > 0 then
      sdk_init_to_preload_duration = preload_timestamp - sdk_init_timestamp
      ejoysdk_pf.clear_sdk_init_timestamp()
    end
    performance_data.sdk_init_invoke_timestamp = sdk_init_timestamp
  end
  url = string.gsub(url, "file://" .. E.Path.get_ext_file_dir(), "")
  local params = {
    url = url,
    mask = white_screen_cost,
    interval = first_screen_cost,
    sdk_init_to_preload_duration = sdk_init_to_preload_duration,
    sdk_preload_to_login_duration = sdk_preload_to_login_duration,
    sdk_wv_prepare_cost = webview_show_cost,
    raw_data = performance_data
  }
  local type = 0
  if preload then
    type = 1
  end
  STAT.stat_action("h5.login.performance", type, cost_time, params)
  E.log(string.format("login performance, preload:%s, cost: %d,prepare_cost: %d, preload_duration: %d,first_screen: %d", tostring(preload), math.floor(cost_time), math.floor(webview_show_cost), math.floor(sdk_preload_to_login_duration), math.floor(first_screen_cost)))
end

local function handler_url_for_statistics(url)
  if url and E.Sysinfo.os() == "ios" then
    local code_index = string.find(url, "/Documents/", 1, true)
    if code_index then
      local last_url = string.sub(url, code_index)
      if last_url then
        return last_url
      end
    end
  end
  return url
end

function M.get_startup_data(login_span, ext_params)
  local login_history = HISTORY.get_list()
  local login_list = LOGIN_API.get_login_items()
  if _ejoysdk.os() == "windows" and 1 == UTILS.tablelength(login_list) then
    local value = login_list[1]
    if value.type and string.upper(value.type) == "QR_LOGIN" then
      login_history = {}
      E.LOG.debug(TAG, "当前是PC，且登录方式只有扫码一种，不提供登录方式给H5登录页，让其不能走快速登录，只能走扫码登录")
    end
  end
  local EG = require("ejoysdk_lua.ejoysdk_gangplank")
  local startupData = {
    ds_token = EG.user_info().ptoken,
    ejoysdk_ver = E.get_sdk_version_name("EJOYSDK"),
    area = E.CONFIG.get_config("district"),
    language = E.CONFIG.get_config("lang"):lower(),
    publish_area = E.CONFIG.get_config(E.CONFIG.KEY.PUBLISH_AREA) or "",
    aegis_data = AEGIS_DATA.get_encrypt_data(),
    available_login_list = login_list,
    login_history = login_history,
    version = 2
  }
  if login_span then
    startupData.opentracing = {
      traceId = login_span:context():get_trace_id(),
      span = login_span:get_operation_name(),
      span_id = login_span:context():get_span_id(),
      trace_enable = ETracer.opentracing_enable()
    }
  end
  if ext_params then
    for k, v in pairs(ext_params) do
      startupData[k] = v
    end
  end
  return startupData
end

function M.login_with_h5(urls, ext, out_option, callback)
  local overseas_login_span = ATracer.start_login_sub_span(ATracer.ACCOUNT_FLOWS_SPANS.OVERSEA_LOGIN)
  
  local function callback_wrapper(result)
    ATracer.finish_login_sub_span(overseas_login_span, result)
    if callback then
      callback(result)
    end
  end
  
  local preferred = urls.preferred
  local fallback = urls.fallback
  local performance_callback
  local life_cycle_topic = "webview_life_cycle"
  local login_result, close_data, acquire_succ_flag
  
  local function webview_cache_remove_function()
    if acquire_succ_flag and close_data and close_data.ext and close_data.ext.preload_info and not UTILS.STR.is_empty(close_data.ext.preload_info.baseUrl) then
      local base_url = close_data.ext.preload_info.baseUrl
      E.LOG.d(TAG, "remove webview cache, url:" .. base_url)
      E.WebView.remove_cache(base_url)
    end
  end
  
  local function close_callback(_value)
    close_data = _value
    preload_call_timestamp_map[preferred.url] = nil
    if type(performance_callback) == "function" then
      ET.unsubscribe(life_cycle_topic, performance_callback)
    end
    if nil == login_result then
      callback_wrapper(PROTOCOL.LoginResult.fail(CONSTANTS.OFFICIAL_ERR_CODES.CODE_LOGIN_CANCEL, "取消登录"))
    else
      webview_cache_remove_function()
    end
    ESTAT.sdk_account_pfcomm({
      biz_mod = "login",
      biz_func = "sdk.close_login_page",
      biz_act = "click"
    })
  end
  
  local function js_callback(_value)
    local args = _value.args or {}
    if args.type == "notify_login" then
      E.LOG.debug(TAG, "js_callback, args=====>>>>>>>")
      E.LOG.debug(TAG, args)
      local data = args.body or {}
      if data.succ then
        login_result = data.body.login_result or PROTOCOL.LoginResult.fail(-1, "登录异常")
      else
        local code = data.body.err_code
        local msg = data.body.err_msg
        login_result = PROTOCOL.LoginResult.fail(code, msg)
      end
      callback_wrapper(login_result)
      local acquire_finish, acquire_succ
      
      function acquire_finish()
        E.LOG.debug(TAG, "acquire_finish ----called")
        ET.unsubscribe(ET.gangplank.ACQUIRE_FAILED, acquire_finish)
        ET.unsubscribe(ET.gangplank.ACQUIRE, acquire_succ)
      end
      
      function acquire_succ()
        E.LOG.debug(TAG, "acquire_succ ----called")
        acquire_finish()
        acquire_succ_flag = true
        webview_cache_remove_function()
        preload_call_timestamp_map[preferred.url] = nil
      end
      
      ET.subscribe(ET.gangplank.ACQUIRE_FAILED, acquire_finish)
      ET.subscribe(ET.gangplank.ACQUIRE, acquire_succ)
    end
  end
  
  local option = {
    startupData = M.get_startup_data(overseas_login_span, ext),
    transparent = true
  }
  fallback = fallback or {url = "", host = ""}
  local is_preload = true == (out_option or {}).preload
  local force_preferred = is_preload
  local login_option = {
    compactMode = true,
    use_fragment = true,
    hide_close_btn = true,
    use_cutout = true,
    stat_timestamp = {
      open_call = E.system_ms(),
      real_show = 0
    }
  }
  if not force_preferred then
    login_option.fallback_url = fallback.url
  end
  for _, options in pairs({login_webview_option, out_option}) do
    if options and type(options) == "table" then
      for k, v in pairs(options) do
        login_option[k] = v
      end
    end
  end
  login_option.trace_id = E.get_pkg_info().sdk_trace_id
  local host_data = {}
  local white_host_list = urls.white_host_list or {}
  table.insert(white_host_list, preferred.host)
  table.insert(white_host_list, fallback.host)
  for _, new_host in pairs(white_host_list) do
    host_data[new_host] = option
  end
  local LIGHTBOAT = require("ejoysdk_lua.res.lightboat.ejoysdk_lightboat")
  local local_url = LIGHTBOAT.get_url_from_cache(preferred.url)
  local is_offline = E.Utils.start_with(local_url, "file://")
  local regx = is_offline and "(%d+%.%d+%.%d+)/[^/]*" or "/(v%d+_%d+)/"
  local version = local_url:match(regx)
  STAT.stat_bizid("login.url.version", "0", "0", {
    url = preferred.url,
    local_url = local_url,
    is_preload = is_preload,
    is_offline = is_offline,
    version = version
  })
  E.WebView.open(preferred.url, host_data, login_option, js_callback, close_callback)
  local action_type_string = "preload"
  if not is_preload then
    action_type_string = "login"
    if ext then
      function performance_callback(value)
        if value and value.type and tostring(value.type) == "4" then
          E.LOG.debug(TAG, {login_performance_detail = value})
          
          value.url = handler_url_for_statistics(value.url)
          if value.data and ext.invoke_timestamp then
            ET.unsubscribe(life_cycle_topic, performance_callback)
            local performance_detail = value.data
            performance_detail.invoke_timestamp = ext.invoke_timestamp
            if preload_call_timestamp_map[preferred.url] then
              performance_detail.sdk_preload_invoke_timestamp = preload_call_timestamp_map[preferred.url]
              preload_call_timestamp_map[preferred.url] = nil
            end
            local webview_page_show_time = tonumber(performance_detail.webview_page_show)
            local webview_page_performance_time = E.system_ms()
            if webview_page_show_time > 0 then
              webview_page_performance_time = math.min(webview_page_performance_time, webview_page_show_time)
            end
            performance_detail.webview_page_show = webview_page_performance_time
            performance_detail.webview_show_cost = login_option.stat_timestamp.real_show - login_option.stat_timestamp.open_call
            performance_detail.device_score_data = device_score_data
            if login_option.stat_timestamp.real_show > 0 then
              performance_stat(value.url, performance_detail)
            else
              E.LOG.debug(TAG, "此时login_option.stat_timestamp.real_show是0，说明该次登录接口调用被webview管理队列丢弃了，没有真正展示登录页")
              E.LOG.debug(TAG, {login_option = login_option})
              E.LOG.debug(TAG, {performance_detail = performance_detail})
            end
          end
        end
      end
      
      ET.subscribe(life_cycle_topic, performance_callback)
    end
  elseif not preload_call_timestamp_map[preferred.url] then
    preload_call_timestamp_map[preferred.url] = E.system_ms()
  end
  EQL.commit_action_main("al_show_h5_login", action_type_string, "", urls)
  ESTAT.sdk_account_pfcomm({
    biz_mod = "login",
    biz_func = is_preload and "sdk.preload_page" or "sdk.open_login_page",
    biz_act = "finish",
    biz_st = "succ",
    biz_co = "200",
    biz_params = {
      url = urls,
      is_offline = is_offline,
      version = version,
      is_preload = is_preload
    }
  })
end

function M.inject_webview_options(_options)
  if _options then
    login_webview_option = _options
  end
end

return M
