local E = require("ejoysdk_lua.ejoysdk")
local EV = require("ejoysdk_lua.ejoysdk_vendors")
local ER = require("ejoysdk_lua.ejoysdk_resource")
local ET = require("ejoysdk_lua.ejoysdk_topic")
local EM = require("ejoysdk_lua.ejoysdk_module")
local EI = require("ejoysdk_lua.ejoysdk_init")
local UNI = require("ejoysdk_lua.vendors.unisdk")
local VC = require("ejoysdk_lua.ejoysdk_version_check")
local UTILS = require("ejoysdk_lua.ejoysdk_utils")
local QL = require("ejoysdk_lua.ejoysdk_qualitylog")
local AGREEMENT = require("ejoysdk_lua.agreement.ejoysdk_agreement")
local CONSTANTS = require("ejoysdk_lua.ejoysdk_constants")
local JSON = require("ejoysdk_lua.ejoysdk_json")
local AEGIS = require("ejoysdk_lua.aegis.ejoysdk_aegis")
local POPUP = require("ejoysdk_lua.realname.ejoysdk_popup_handler")
local ACPOPUP = require("ejoysdk_lua.activedcode.ejoysdk_activecode")
local REALNAME_INFO = require("ejoysdk_lua.realname.realname_info")
local UIM = require("ejoysdk_lua.user_info_manager")
local ESTAT = require("ejoysdk_lua.ejoysdk_stat")
local CM = require("ejoysdk_lua.ejoysdk_channel_manager")
local EGC = require("ejoysdk_lua.ejoysdk_gangplank_config")
local LANG = require("ejoysdk_lua.ejoysdk_lang")
local LANG_UTIL = require("ejoysdk_lua.lang.util")
local ETAGS = require("ejoysdk_lua.opentracing.ejoysdk_tags")
local GDP = require("ejoysdk_lua.gangplank_data_provider")
local ETracer = require("ejoysdk_lua.ejoysdk_span_reporter")
local ATracer = require("ejoysdk_lua.account.account_tracer")
local EC = require("ejoysdk_lua.ejoysdk_config")
local HTTP = E.HTTP
local M = {}
local LOGINID = math.random(1000, 9999)

local function gen_login_id()
  LOGINID = LOGINID + 1
  return LOGINID
end

local login_listener, logout_listener, switch_listener, pay_listener, bind_listener, queue_listener, exit_listener, acquire_listener, game_listeners
local pending_product_infos = {}
local set_player_info_cb
local TAG = EM.MODULE.EJOYSDK_BASE_MODULE .. "gangplank"

function M.player_info()
  do return end
  return GDP.PLAYER_INFO.clone, nil
end

function M.async_player_info(cb)
  if cb then
    cb(M.player_info())
  end
end

local EJOY_TOKEN = E.LazyKeyStore:New("EJOY_TOKEN")
local VENDOR_LOGIN = E.LazyKeyStore:New("VENDOR_LOGIN", false, true)
local LOGIN_INFO = E.LazyKeyStore:New("LOGIN_INFO", true, true)
local LAST_VENDOR_AUTH = E.LazyKeyStore:New("LAST_LOGIN", false, false, false)
local acquire_token_params = {}
local token_callback_for_acquire
local last_acquire_token_invoke_timestamp = 0
local CURRENT_QUEUE_LOOP
local global_region_token_cache = {}
local inited = false
local is_magic_guest = false
local last_pay_invoke_time = 0
local login_queue_rules_data

function M.login_info()
  return LOGIN_INFO
end

function M.is_magic_guest()
  return is_magic_guest
end

local function gangplank_url_base(api, ver, url_base)
  local product = E.CONFIG.get_config("product"):lower()
  if ver then
    api = "/v" .. tostring(ver) .. api
  end
  if EC.is_force_use_rule_service_splice_in_path("gangplank") then
    return url_base .. api
  end
  return url_base .. "/gp/" .. product .. api
end

function M.gangplank_url(api, ver)
  local url_base = E.CONFIG.get_config("gangplank")
  if string.sub(api, 1, 1) ~= "/" then
    api = "/" .. api
  end
  do return gangplank_url_base, api, ver end
  return gangplank_url_base, api, ver, url_base
end

local function gangplank_logined_url_base(api, ver, url_base)
  local product = E.CONFIG.get_config("product"):lower()
  if ver then
    api = "/logined/v" .. tostring(ver) .. api
  end
  if EC.is_force_use_rule_service_splice_in_path("gangplank") then
    return url_base .. api
  end
  return url_base .. "/gp/" .. product .. api
end

function M.gangplank_logined_url(api, ver)
  local url_base = E.CONFIG.get_config("gangplank")
  do return gangplank_logined_url_base, api, ver end
  return gangplank_logined_url_base, api, ver, url_base
end

local APIS = {
  login = true,
  queue = true,
  queue_dropout = true,
  create_order = true,
  bind = true,
  query = true,
  get_product_infos = true,
  access = true,
  alive_servers = true,
  get_alive_servers = true,
  acquire = true,
  gen_uuid = true,
  validate_uuid = true,
  grant_uuid_access = true,
  get_server_time = true,
  get_global_token = true,
  global_acquire = true,
  get_recommend_servers = true,
  get_ip_location = true,
  get_location = true,
  scene_login = true,
  get_server_marks = true,
  get_server_marks_with_node = true,
  get_realms_with_alive_info = true
}
local GangplankUrl = {
  __index = function(self, key)
    local ver = rawget(self, "ver")
    local apis = rawget(self, "apis") or APIS
    assert(apis[key], "api not found: " .. key)
    do return M.gangplank_url, "/" .. key end
    return M.gangplank_url, "/" .. key, ver, key
  end,
  new = function(self, ver, apis)
    do return setmetatable, {ver = ver, apis = apis} end
    return setmetatable, {ver = ver, apis = apis}, self
  end
}
local url_tbl_v2 = GangplankUrl:new("2")

local function require_params(token)
  return {
    trace = true,
    acceptable = E.HTTP.CT_JSON,
    headers = {
      ["Ejoy-Token"] = token
    }
  }
end

local function require_params_get_options(options)
  local r_params = require_params()
  if options and type(options) == "table" then
    for k, v in pairs(options) do
      r_params[k] = v
    end
  end
  return r_params
end

local GP_OPENTRACING_APIS = {
  acquire = {span_buz = "login"},
  login = {
    span_buz = "login",
    reference = ETAGS.CHILD_OF
  },
  get_server_time = {
    span_buz = "init",
    reference = ETAGS.FOLLOWS_FROM
  }
}

local function gangplank_v2_post(cmd, params, cb, extra_opts)
  local url = url_tbl_v2[cmd]
  if extra_opts and extra_opts.is_platform_domain == true and "get_server_time" == cmd then
    local tmp_url_base = EC.get_platform_base_url("gangplank")
    if tmp_url_base then
      url = tmp_url_base .. "/v2/" .. cmd
    end
  end
  assert(url, "gangplank api: " .. cmd .. " not found")
  E.LOG.debug(TAG, "gangplank post url: " .. url)
  local config_params = {
    trace = true,
    acceptable = HTTP.CT_JSON
  }
  local gp_v2_span
  if ETracer.opentracing_enable() and GP_OPENTRACING_APIS[cmd] then
    if "get_server_time" == cmd then
      gp_v2_span = ETracer.start_span("init_get_server_time")
    else
      gp_v2_span = ATracer.start_login_sub_span("gp_" .. cmd)
    end
  end
  if gp_v2_span then
    local gp_v2_span_id = gp_v2_span:context():get_span_id()
    config_params.opentracing = {span_id = gp_v2_span_id}
  end
  config_params.enable_sign_headers_for_request = extra_opts and extra_opts.enable_sign_headers_for_request or false
  config_params.enable_sign_headers_for_response = extra_opts and extra_opts.enable_sign_headers_for_response or false
  HTTP.post(url, config_params, HTTP.CT_JSON, params, function(resp)
    if gp_v2_span then
      ETracer.finish_span(gp_v2_span:context():get_span_id(), resp)
    end
    if resp.status == 200 then
      if 0 == resp.body.code then
        cb(200, resp.body)
      else
        cb(resp.body.code, resp.body)
      end
    else
      cb(resp.status, resp.body or {})
    end
    if "acquire" == cmd then
      local data = {}
      data.request_params = config_params
      data.request_body = JSON.encode(params)
      data.response_resp = resp
      QL.log_acquire_http_data(data)
    end
  end)
end

local function gangplank_get(cmd, params, cb, options)
  local url = url_tbl_v2[cmd]
  assert(url, "gangplank api: " .. cmd .. " not found")
  local query = HTTP.urlencode2(params)
  if query and "" ~= query then
    url = url .. "?" .. query
  end
  E.LOG.debug(TAG, "gangplank get url: " .. url)
  HTTP.get(url, require_params_get_options(options), function(resp)
    E.LOG.debug(TAG, "gangplank_get response >>")
    if resp.status == 200 then
      if resp.body == nil then
        cb(CONSTANTS.GANGPLANK_ERROR_CODE.GANGPLANK_ERROR_GET_NULL_BODY, "")
      elseif 0 == resp.body.code then
        cb(200, resp.body)
      else
        cb(resp.body.code, resp.body)
      end
    else
      cb(resp.status, resp.body or {})
    end
  end)
end

local gangplank_post = gangplank_v2_post

function M.check_substitute(resp_body)
  if resp_body and resp_body.substitute and resp_body.substitute.uid then
    local s_title = "替身登录"
    local s_message = "当前为替身登录，替身账号ID:" .. tostring(resp_body.uid) .. "\n员工账号ID:" .. tostring(resp_body.substitute.uid)
    E.LOG.debug(TAG, s_message)
    if _ejoysdk.os() == "windows" then
      local sdk_version = E.Sdkinfo.getSDKVersionName("EJOYSDK")
      local check_result = VC.compare_versions(sdk_version, "2.5.3.1")
      if _ejoysdk.utf8_to_acp and tonumber(check_result) >= 0 then
        local check_result2 = VC.compare_versions(sdk_version, "2.6.4")
        if tonumber(check_result2) < 0 then
          s_title = _ejoysdk.utf8_to_acp(s_title)
          s_message = _ejoysdk.utf8_to_acp(s_message)
        end
        local s_option = {
          message = s_message,
          buttons = {"确认"},
          type = "simple"
        }
        E.Modal.open(s_title, s_option, function()
        end)
      end
    elseif _ejoysdk.os() == "ios" then
      local sdk_version = E.Sdkinfo.getSDKVersionName("EJOYSDK")
      local check_result = VC.compare_versions(sdk_version, "2.11.0")
      if tonumber(check_result) >= 0 then
        E.Toast.show(s_message)
        E.Timer.once(2, E.Toast.hide)
      end
    else
      if _ejoysdk.os() == "douyin" or _ejoysdk.os() == "weixin" then
        s_message = "当前为替身登录"
      end
      E.Toast.show(s_message)
      E.Timer.once(2, E.Toast.hide)
    end
  end
end

M.check_compatibility = E.check_compatibility

local function check_magic_guest(pinfo)
  local is_guest = false
  if pinfo and pinfo.ext then
    is_guest = pinfo.ext.is_magic_guest or false
  end
  if is_guest then
    E.LOG.debug(TAG, "check_magic_guest true, lingxi account is guest")
  else
    E.LOG.debug(TAG, "check_magic_guest false, lingxi account is not guest")
  end
  return is_guest
end

local function update_china_windows_channel_id_with_account_channel(accountCh)
  local is_overseas = E.CONFIG.get_config(E.CONFIG.KEY.MULTI_REGIONS_ENABLED)
  if _ejoysdk.os() == "windows" and not is_overseas and string.upper(tostring(accountCh)) ~= "NOONE" then
    if nil ~= accountCh then
      UIM.update_channel_id(accountCh)
      E.update_channel(accountCh)
    else
      E.reset_channel()
      UIM.refresh_channel_id(true)
    end
    local stat_params = {
      accountCh = tostring(accountCh),
      stack = E.HTTP.encode_uri(debug.traceback())
    }
    ESTAT.stat_action("update_china_windows_channel_id_with_account_channel", "", true, stat_params)
  end
end

local function login_base(server, region, outsource, token, cb)
  assert(type(server) == "string" and "" ~= server, "server should be string")
  region = region or E.CONFIG.get_config("product")
  assert(type(region) == "string", "region should be string")
  assert(type(outsource) == "table", "outsource should be table")
  if outsource.platform then
    assert("string" == type(outsource.ptoken), "platform set, outsource.ptoken should be string")
  end
  assert(type(token) == "string" or nil == token, "token should be string")
  assert(type(cb) == "function", "cb should be function")
  local secret = _ejoysdk_crypt.randomkey()
  local params = {
    secret = _ejoysdk_crypt.base64encode(_ejoysdk_crypt.dhexchange(secret)),
    game = E.CONFIG.get_config("product"),
    server = server,
    region = region,
    token = token,
    platform = outsource.platform,
    ptoken = outsource.ptoken,
    pid = outsource.pid,
    guest = outsource.guest,
    with = outsource.with,
    with_account = outsource.with_account,
    ext = outsource.ext,
    is_sandbox_user = outsource.is_sandbox_user,
    appname = outsource.appname,
    pkg_info = E.get_pkg_info(),
    aegisExt = UIM.get_encrypt_aegis_info()
  }
  E.log(params)
  local stat_params = {
    stack = E.HTTP.encode_uri(debug.traceback())
  }
  ESTAT.stat_action("gangplank_function_login_base", "", true, stat_params)
  local opts = {}
  opts.enable_sign_headers_for_request = true
  opts.enable_sign_headers_for_response = M.check_if_prevent_replay_status_open()
  gangplank_post("login", params, function(status, body)
    M.offline()
    E.LOG.debug(TAG, "ejoysdk log login result")
    E.log({status = status, body = body})
    if 200 == status or 413 == status or status == AGREEMENT.ERR_CODE_REJECT_FOR_AGREEMENT then
      local uinfo = GDP.USER_INFO.new({
        game = params.game,
        server = params.server,
        region = params.region,
        token = body.token,
        platform = params.platform,
        ptoken = params.ptoken,
        ext = params.ext,
        is_sandbox_user = params.is_sandbox_user,
        guest = params.guest,
        uid = body.uid,
        pinfo = body.pinfo,
        pid = body.pinfo.pid,
        with = body.pinfo.with,
        with_account = body.pinfo.with_account
      })
      M.set_user_info(uinfo)
      is_magic_guest = check_magic_guest(body.pinfo)
    end
    if 200 == status then
      local server_secret = _ejoysdk_crypt.base64decode(body.server_secret)
      local real_secret = _ejoysdk_crypt.dhsecret(server_secret, secret)
      cb(true, body.token, body.game_token, real_secret, body.pinfo)
    else
      local function handled_callback(succ, ejoy_token)
        if succ then
          E.LOG.debug(TAG, " handled success, user operation success, login again")
          
          login_base(server, region, {}, ejoy_token, cb)
        else
          M.offline()
          E.LOG.error(TAG, " login_base failed, user declined for agreement!")
          cb(false, status, body, secret)
        end
      end
      
      local aegis_handled = AEGIS.handle_login_reject_error(status, params.ptoken, body.challengeSuggest, function(aegis_succ, aegis_body)
        local aegis_token
        if aegis_body and aegis_body.token then
          aegis_token = aegis_body.token
        end
        handled_callback(aegis_succ, aegis_token)
      end)
      local agreement_handled = AGREEMENT.handle_login_reject_error(status, body.token, function(agree_succ)
        handled_callback(agree_succ, GDP.USER_INFO.get("token"))
      end)
      if aegis_handled or agreement_handled then
        E.LOG.debug(TAG, " login_base failed and wait for user result!")
      else
        E.LOG.error(TAG, " login_base failed for other reason")
        cb(false, status, body, secret)
      end
    end
  end, opts)
end

local function acquire_base(region, outsource, token, cb, ext)
  region = region or E.CONFIG.get_config("product")
  assert(type(region) == "string", "region should be string")
  assert(type(outsource) == "table", "outsource should be table")
  if outsource.platform then
    assert("string" == type(outsource.ptoken), "platform set, outsource.ptoken should be string")
  end
  assert(type(token) == "string" or nil == token, "token should be string")
  assert(type(cb) == "function", "cb should be function")
  update_china_windows_channel_id_with_account_channel(outsource.ds_channel_id or outsource.platform or "")
  local params = {
    game = E.CONFIG.get_config("product"),
    region = region,
    token = token,
    platform = outsource.platform,
    ptoken = outsource.ptoken,
    pid = outsource.pid,
    guest = outsource.guest,
    with = outsource.with,
    with_account = outsource.with_account,
    ext = outsource.ext,
    is_sandbox_user = outsource.is_sandbox_user,
    thirdPartyType = outsource.thirdPartyType,
    appname = outsource.appname,
    pkg_info = E.get_pkg_info(),
    aegisExt = UIM.get_encrypt_aegis_info(),
    popup_user_agreement = ext and ext.popup_user_agreement
  }
  E.LOG.debug(TAG, "acquire ---- http_start")
  E.log(params)
  QL.log_acquire_invoke(outsource.platform)
  local opts = {}
  opts.enable_sign_headers_for_request = true
  opts.enable_sign_headers_for_response = M.check_if_prevent_replay_status_open()
  gangplank_post("acquire", params, function(status, body)
    M.offline()
    E.LOG.debug(TAG, "ejoysdk 打印 acquire_base 返回参数, response status:" .. status)
    E.log(body)
    if body and body.reg == true then
      ET.publish(ET.analytics.REGISTER, {
        uid = body.uid or ""
      })
    end
    
    local function acquire_response_handler(response_body)
      E.LOG.debug(TAG, "acquire_response_handler >>")
      E.log(response_body)
      is_magic_guest = check_magic_guest(response_body.pinfo)
      if response_body.token then
        E.LOG.debug(TAG, "有登录态返回，缓存登录信息")
        acquire_token_params[response_body.token] = params
        local uinfo = GDP.USER_INFO.new({
          game = params.game,
          region = params.region,
          platform = params.platform,
          ptoken = params.ptoken,
          ext = params.ext,
          is_sandbox_user = params.is_sandbox_user,
          guest = params.guest,
          thirdPartyType = params.thirdPartyType,
          token = response_body.token,
          uid = response_body.uid,
          pinfo = response_body.pinfo,
          pid = response_body.pinfo.pid,
          with = response_body.pinfo.with,
          with_account = response_body.pinfo.with_account,
          isPga = outsource.isPga,
          substitute = response_body.substitute,
          reg = response_body.reg,
          permit_info = response_body.permit_info,
          is_magic_guest = is_magic_guest,
          st = outsource.st,
          ds_channel_id = outsource.ds_channel_id,
          user_agreement_info = response_body.user_agreement_info
        })
        M.set_user_info(uinfo)
      end
      REALNAME_INFO.handle_body_realname_info(response_body)
      M.check_substitute(response_body)
    end
    
    acquire_response_handler(body)
    
    local function default_callback()
      if 200 == status then
        E.LOG.debug(TAG, " acquire_base success!")
        local PC_HEARTBEAT = require("ejoysdk_lua.realname.ejoysdk_realname_heartbeat")
        PC_HEARTBEAT.heartbeat_start()
        cb(true, body.token, body)
        QL.log_acquire(outsource.platform)
      else
        E.LOG.error(TAG, " acquire_base failed for other reason")
        M.offline()
        cb(false, status, body)
        QL.log_acquire_failed(outsource.platform, status, body.message)
      end
    end
    
    local function handler_callback(succ)
      if succ then
        E.LOG.debug(TAG, "receive handler result succ, need recall acquire ")
        acquire_base(region, outsource, body.token, cb, ext)
      else
        E.LOG.error(TAG, " acquire_base failed, user not finished operation!")
        default_callback()
      end
    end
    
    local is_intercept = false
    if body.pinfo then
      is_intercept = POPUP.handle_login_reject_error(status, body.token, body.pinfo.attach_info, function(result_status)
        result_status = tonumber(result_status)
        if result_status == REALNAME_INFO.REALNAME_RESULT.STATUS_UNCOMPLETE then
          E.LOG.debug(TAG, "receive popup handle result STATUS_NEED_LOGOUT")
          M.logout()
        elseif result_status == REALNAME_INFO.REALNAME_RESULT.STATUS_COMPLETE_BIND_PHONE then
          E.LOG.debug(TAG, "receive popup handle result STATUS_COMPLETE_BIND_PHONE")
          local v_aligames = require("ejoysdk_lua.vendors.aligames")
          if v_aligames.is_for_lingxi() then
            UNI.logout("ALIGAMES")
          else
            M.logout()
          end
        else
          local realname_succ = result_status == REALNAME_INFO.REALNAME_RESULT.STATUS_COMPLETE_WITH_REALNAME_SUCC
          handler_callback(realname_succ)
        end
      end)
    end
    is_intercept = is_intercept or AEGIS.handle_login_reject_error(status, params.ptoken, body.challengeSuggest, function(succ, hbody)
      if succ then
        E.LOG.debug(TAG, " acquire_base success, user finished operation!")
        acquire_response_handler(hbody)
        cb(true, hbody.token, hbody)
        QL.log_acquire(outsource.platform)
      else
        E.LOG.error(TAG, " acquire_base failed, user not finished operation!")
        M.offline()
        cb(false, status, body)
        QL.log_acquire_failed(outsource.platform, status, body.message)
      end
    end)
    is_intercept = is_intercept or AGREEMENT.handle_login_reject_error(status, body.token, function(succ)
      E.LOG.debug(TAG, "AGREEMENT.handle_login_reject_error----callback, succ = " .. tostring(succ))
      handler_callback(succ)
    end)
    if is_intercept then
      E.LOG.debug(TAG, " acquire_base failed and wait for user result!")
    else
      local auto_login = require("ejoysdk_lua.vendors.auto_login")
      if 200 ~= status and auto_login.is_silent_login() and not EC.get_config(EC.KEY.CLOSE_SILENT_LOGIN_TIPS) then
        local function ensure()
          default_callback()
        end
        
        auto_login.show_retry_login_tips(status, ensure)
      else
        default_callback()
      end
    end
  end, opts)
end

function M.request_gangplank_acquire(region, outsource, token, cb)
  E.LOG.debug(TAG, "request_gangplank_acquire begin")
  acquire_base(region, outsource, token, cb)
end

local function call_queue_listener(status, ...)
  if queue_listener then
    queue_listener(status, ...)
  end
end

local function get_interval(queue, interval_time)
  E.LOG.debug(TAG, "get_interval with queue:" .. tostring(queue))
  if login_queue_rules_data and next(login_queue_rules_data) ~= nil then
    local find_interval
    for _, rule in ipairs(login_queue_rules_data) do
      local cnt = rule.cnt
      if queue >= cnt then
        find_interval = rule.interval
        break
      end
    end
    if find_interval then
      E.LOG.debug(TAG, "get_interval find interval in rules:" .. tostring(find_interval))
      return find_interval
    else
      E.LOG.warn(TAG, "get_interval not find in rules data, now use default")
    end
  end
  if interval_time and type(interval_time) == "number" and interval_time > 0 then
    E.LOG.debug(TAG, "get_interval server interval_time:" .. tostring(interval_time))
    return interval_time
  end
  if queue > 50 then
    return 5
  elseif queue > 5 then
    return 3
  else
    return 1
  end
end

local function update_current_queue_ticket(id, ticket)
  local ticket_id = id or "0"
  CURRENT_QUEUE_LOOP = {
    [ticket_id] = ticket
  }
  E.LOG.debug(TAG, "update_current_queue_ticket:" .. tostring(id) .. ", ticket:" .. tostring(ticket))
end

local function get_queue_ticket(id)
  local ticket_id = id or "0"
  local ticket
  if CURRENT_QUEUE_LOOP then
    ticket = CURRENT_QUEUE_LOOP[ticket_id]
  end
  E.LOG.debug(TAG, "get_queue_ticket:" .. tostring(ticket))
  return ticket
end

local function get_current_queue_ticket()
  if not CURRENT_QUEUE_LOOP then
    return nil
  end
  local current_ticket
  local first_key = next(CURRENT_QUEUE_LOOP)
  if first_key then
    current_ticket = CURRENT_QUEUE_LOOP[first_key]
    E.LOG.debug(TAG, "get_current_queue_ticket:" .. tostring(current_ticket))
  end
  return current_ticket
end

local function clear_current_queue_ticket()
  E.LOG.debug(TAG, "clear_current_queue_ticket")
  CURRENT_QUEUE_LOOP = nil
end

local function queue_loop(ticket, queue, secret, cb, login_cb_id, interval_time)
  E.LOG.debug(TAG, "queue_loop login_cb_id:" .. (login_cb_id or "nil"))
  local interval = get_interval(queue, interval_time)
  
  local function timer_cb()
    if nil == get_queue_ticket(login_cb_id) then
      return
    end
    if login_cb_id and login_cb_id ~= LOGINID then
      E.LOG.debug(TAG, "queue_loop 有新的login callback id, 当前循环需要退出, new:" .. LOGINID .. ", old:" .. login_cb_id)
      call_queue_listener("end")
      return
    end
    local params = {ticket = ticket}
    gangplank_post("queue", params, function(status, body)
      if nil == get_queue_ticket(login_cb_id) then
        return
      end
      if login_cb_id and login_cb_id ~= LOGINID then
        E.LOG.debug(TAG, "queue_loop 有新的login callback id, 当前循环需要退出")
        call_queue_listener("end")
        return
      end
      if 200 == status then
        clear_current_queue_ticket()
        local server_secret = _ejoysdk_crypt.base64decode(body.server_secret)
        local real_secret = _ejoysdk_crypt.dhsecret(server_secret, secret)
        cb(true, body.game_token, real_secret, GDP.USER_INFO.get("pid"))
        call_queue_listener("end")
        ET.publish(ET.gangplank.LOGIN, GDP.USER_INFO.get())
        ET.publish(ET.analytics.LOGIN, GDP.USER_INFO.get())
      elseif 413 == status then
        local new_queue_count = body.queue
        local new_interval_time = body.interval_time
        call_queue_listener("loop", new_queue_count, body)
        queue_loop(ticket, new_queue_count, secret, cb, login_cb_id, new_interval_time)
      else
        clear_current_queue_ticket()
        call_queue_listener("end")
        cb(false, status, body.message or "")
        M.offline()
      end
    end)
  end
  
  E.Timer.once(interval, timer_cb)
end

local function on_vendor_login_fail(status, last_login_params)
  local stat_params = {
    status = status,
    last_login_params = last_login_params,
    stack = E.HTTP.encode_uri(debug.traceback())
  }
  ESTAT.stat_action("gangplank_function_on_vendor_login_fail", "", true, stat_params)
  local outsource = last_login_params.outsource
  local guest = nil == outsource
  if guest then
    return false
  end
  local vendor_name = EV.get_vendor_name(outsource)
  if vendor_name then
    local vendor = EV.get(vendor_name)
    if vendor and vendor.login_fail and vendor.login_fail(status, last_login_params) then
      return true
    end
  end
  return false
end

local function login_callback_builder(server, region, outsource, info, cb)
  local guest = nil == outsource
  
  local function update_token(token, pinfo)
    if guest then
      EJOY_TOKEN:set(token)
      info = pinfo
    else
      local vendor_name = EV.get_vendor_name(outsource)
      local vendor = EV.get(vendor_name)
      info = vendor.merge_info(info, pinfo)
      outsource.pid = info.pid
      VENDOR_LOGIN:set({
        server = server,
        region = region,
        token = token,
        outsource = outsource,
        info = info
      })
    end
    return info
  end
  
  return function(succ, token, game_token, secret, pinfo)
    if succ then
      local updated_info = update_token(token, pinfo)
      ET.publish(ET.gangplank.LOGIN, GDP.USER_INFO.get())
      ET.publish(ET.analytics.LOGIN, GDP.USER_INFO.get())
      cb(true, game_token, secret, updated_info.pid)
    else
      local status = token
      local body = game_token or {}
      E.LOG.error(TAG, "login failed " .. tostring(status))
      if 401 == status then
        if guest then
          EJOY_TOKEN:delete()
        else
          VENDOR_LOGIN:delete()
        end
      elseif 413 == status then
        update_token(body.token, body.pinfo)
        local queue = body.queue
        local interval_time = body.interval_time
        call_queue_listener("start", queue, body)
        update_current_queue_ticket(nil, body.ticket)
        do return queue_loop, body.ticket, queue, secret, cb, nil end
        return queue_loop, body.ticket, queue, secret, cb, nil, interval_time
      elseif 406 == status or 462 == status or 407 == status then
        LAST_VENDOR_AUTH:set("")
        VENDOR_LOGIN:delete()
      end
      local last_login_params = {
        outsource = outsource,
        info = info,
        update_token = update_token,
        direct_cb = cb,
        region = region,
        server = server,
        body = body
      }
      if on_vendor_login_fail(status, last_login_params) then
        return
      end
      cb(false, status, body.message or "", body)
    end
  end
end

local function check_acquire_listener_stat(cb)
  local stat_params = {}
  if not acquire_listener then
    E.LOG.warn(TAG, "check_acquire_listener_stat acquire_listener is nil")
    stat_params.acquire_listener_state = "false"
  else
    stat_params.acquire_listener_state = "true"
  end
  if not cb then
    E.LOG.warn(TAG, "check_acquire_listener_stat cb is nil")
    stat_params.cb_listener_state = "false"
  else
    stat_params.cb_listener_state = "true"
  end
  if game_listeners then
    stat_params.game_listeners_state = "true"
    if game_listeners.acquire_listener then
      stat_params.game_listeners_acquire_lis_state = "true"
    else
      stat_params.game_listeners_acquire_lis_state = "false"
    end
  end
  ESTAT.stat_action("acquirelistener_check", nil, true, stat_params)
end

local function acquire_callback_builder(region, outsource, info, cb)
  local guest = nil == outsource
  
  local function update_token(token, pinfo)
    if guest then
      EJOY_TOKEN:set(token)
      info = pinfo
    else
      local vendor_name = EV.get_vendor_name(outsource)
      local vendor = EV.get(vendor_name)
      info = vendor.merge_info(info, pinfo)
      outsource.pid = info.pid
      VENDOR_LOGIN:set({
        region = region,
        token = token,
        outsource = outsource,
        info = info
      })
    end
    return info
  end
  
  return function(succ, ...)
    E.LOG.debug(TAG, "准备acquire_listener回调给游戏了，清理掉 last_acquire_token_invoke_timestamp")
    last_acquire_token_invoke_timestamp = 0
    if succ then
      local token, body = ...
      local pinfo = body.pinfo
      update_token(token, pinfo)
      if cb then
        ATracer.finish_login_span()
        cb(true, token, body)
      end
      ET.publish(ET.gangplank.ACQUIRE, GDP.USER_INFO.get())
      check_acquire_listener_stat(cb)
    else
      local status, body = ...
      body = body or {}
      E.LOG.error(TAG, "acquire failed, status code: " .. tostring(status))
      E.LOG.debug(TAG, {body = body})
      local AUTO_LOGIN = require("ejoysdk_lua.vendors.auto_login")
      AUTO_LOGIN.clear_last_login()
      if 401 == status then
        if guest then
          EJOY_TOKEN:delete()
        else
          VENDOR_LOGIN:delete()
        end
      elseif 406 == status or 462 == status or 407 == status then
        LAST_VENDOR_AUTH:set("")
        VENDOR_LOGIN:delete()
        if 406 == status then
          UTILS.toast_msg("login_account_channel_not_match", "", 3)
        end
      elseif 422 == status then
        UTILS.toast_msg("login_submit_user_protocol_fail", "", 3)
      elseif 503 == status then
        UTILS.toast_msg("login_gangplank_unavailable_service", "", 3)
      end
      local last_login_params = {
        outsource = outsource,
        info = info,
        update_token = update_token,
        direct_cb = cb,
        region = region,
        body = body
      }
      if on_vendor_login_fail(status, last_login_params) then
        return
      end
      ET.publish(ET.ACCOUNT.LOGIN_NEED_PRELOAD)
      local err_msg = body.message or body.msg or ""
      if cb then
        E.LOG.debug(TAG, "acquire callback, body.ds_code:" .. tostring(body.ds_code) .. ", status:" .. tostring(status) .. ", ds_server_code:" .. tostring(body.ds_server_code))
        ATracer.finish_login_span()
        cb(false, status, err_msg, body)
      end
      local fail_info = {code = status, msg = err_msg}
      ET.publish(ET.gangplank.ACQUIRE_FAILED, fail_info)
    end
  end
end

function M.logout(manual)
  local PC_HEARTBEAT = require("ejoysdk_lua.realname.ejoysdk_realname_heartbeat")
  PC_HEARTBEAT.heartbeat_stop()
  local last_login = LAST_VENDOR_AUTH:get()
  E.LOG.debug(TAG, "logout, last_login:" .. (last_login or "nil"))
  last_acquire_token_invoke_timestamp = 0
  M.cancel_queue()
  local USERCENTER = require("ejoysdk_lua.user_center.ejoysdk_usercenter")
  USERCENTER.logout()
  local params = {
    stack = E.HTTP.encode_uri(debug.traceback())
  }
  QL.commit_event(QL.EVENT_NAMES.SDK_LOGOUT_INVOKE, params, true)
  ESTAT.sdk_logout_report({biz_act = "click"})
  update_china_windows_channel_id_with_account_channel(nil)
  if last_login then
    LAST_VENDOR_AUTH:set("")
    if "guest" ~= last_login then
      local vendor = EV.get(last_login)
      if vendor then
        vendor.logout(manual)
        return
      end
    end
  end
  LOGIN_INFO:delete()
  M.offline()
  ET.publish(ET.gangplank.LOGOUT, GDP.USER_INFO.get())
  if not manual or type(manual) ~= "boolean" or false == manual then
    logout_listener()
  end
end

function M.clear_user_info()
  GDP.USER_INFO.clear()
  GDP.PLAYER_INFO.clear()
end

function M.get_last_login()
  return LAST_VENDOR_AUTH:get() or ""
end

function M.set_last_login(vendor_name)
  LAST_VENDOR_AUTH:set(vendor_name)
end

local function get_acquire_token_listener(ext)
  if ext and ext.override_acquire_listener then
    return ext.override_acquire_listener
  else
    return acquire_listener
  end
end

local function acquire_token_base(vendor_name, region, ext)
  E.LOG.d(TAG, "acquire token base:" .. tostring(vendor_name or ""))
  ET.publish(ET.gangplank.LOGIN_INVOKE)
  token_callback_for_acquire = get_acquire_token_listener(ext)
  if "guest" == vendor_name then
    local token = EJOY_TOKEN:get()
    LAST_VENDOR_AUTH:set("guest")
    local acquire_callback = acquire_callback_builder(region, nil, nil, token_callback_for_acquire)
    acquire_base(region, {}, token, acquire_callback, ext)
  else
    if E.is_scan_pkg() then
      E.LOG.debug(TAG, "is a scan pkg, change to : EJOY_SCAN vendor" .. tostring(vendor_name))
      vendor_name = "EJOY_SCAN"
    end
    local vendor_ret = CM.get_vendor(vendor_name, EV.ABILITY.ACCOUNT)
    vendor_name = vendor_ret.vendor_name
    local vendor = vendor_ret.vendor
    assert(vendor, "vendor: " .. tostring(vendor_name) .. "not found")
    LOGIN_INFO:set({
      type = "acquire",
      region = region,
      token = nil,
      vendor = vendor_name
    })
    CM.login(vendor_name, ext)
    E.LOG.debug(TAG, "vendor login begin:" .. tostring(vendor_name))
    ET.publish(ET.gangplank.VENDOR_LOGIN_BEGIN, vendor_name)
    QL.log_vendor_login_invoke(vendor_name)
  end
end

function M._acquire_token_global(vendor_name, region, ext)
  region = region or E.CONFIG.get_config("product")
  assert(type(region) == "string", "region or product should be string")
  local acquire_token_listener = get_acquire_token_listener(ext)
  if not inited then
    E.LOG.error(TAG, "acquire failed, not init")
    acquire_token_listener(false, CONSTANTS.GANGPLANK_ERROR_CODE.GANGPLANK_ERROR_NOT_INIT, "not init")
    return
  end
  local global_gangplank_enabled = E.CONFIG.get_config("global_gangplank_enabled")
  if not global_gangplank_enabled then
    E.LOG.debug(TAG, "acquire_token_global > global gangplank not enabled, directly request gangplank")
    acquire_token_base(vendor_name, region, ext)
  else
    E.LOG.debug(TAG, "acquire_token_global > now try get from cache")
    region = E.CONFIG.get_config(E.CONFIG.KEY.REGION)
    assert(region, "region should not be nil in global gangplank")
    
    local function return_cached_token(ejoy_token)
      acquire_token_listener(true, ejoy_token)
      global_region_token_cache = {}
    end
    
    local region_token_cache = global_region_token_cache[region]
    if region_token_cache then
      E.LOG.debug(TAG, "acquire_token_global > return ejoy_token from cache")
      return_cached_token(region_token_cache)
    else
      E.LOG.debug(TAG, "acquire_token_global > no token cache for region, try process from local region cache")
      local local_region = E.CONFIG.get_config(E.CONFIG.KEY.LOCAL_GANGPLANK_REGION)
      if local_region then
        E.LOG.debug(TAG, "acquire_token_global > try get local region token cache")
        local local_region_token_cache = global_region_token_cache[local_region]
        if local_region_token_cache then
          E.LOG.debug(TAG, "acquire_token_global > exists local region cache, do global_acquire")
        else
          E.LOG.debug(TAG, "acquire_token_global > no token cache for local region, do acquire_token_base")
          acquire_token_base(vendor_name, region, ext)
        end
      else
        E.LOG.debug(TAG, "acquire_token_global > unknown local region, do acquire_token_base")
        acquire_token_base(vendor_name, region, ext)
      end
    end
  end
end

function M.acquire_token(vendor_name, region, acquire_opts)
  E.LOG.debug(TAG, "acquire_token")
  local cur_time = E.system_ms()
  E.LOG.debug(TAG, {cur_time = cur_time, last_acquire_token_invoke_timestamp = last_acquire_token_invoke_timestamp})
  if cur_time > last_acquire_token_invoke_timestamp and cur_time - last_acquire_token_invoke_timestamp < 1000 then
    E.LOG.debug(TAG, "1秒内频繁调用登录接口！丢弃本次调用")
    QL.commit_event(QL.EVENT_NAMES.SDK_ACQUIRE_INVOKE_FREQUENCY, {}, true)
    return
  else
    last_acquire_token_invoke_timestamp = cur_time
  end
  local JF = require("ejoysdk_lua.vendors.jf")
  if JF.get_init_media_stats_vendors_occasion() == "sdk.login" then
    JF.init_media_stats_vendors()
  end
  ATracer.start_login_span(vendor_name, region)
  local ext = {
    popup_user_agreement = acquire_opts and acquire_opts.popup_user_agreement,
    invoke_timestamp = E.system_ms()
  }
  M._acquire_token_global(vendor_name, region, ext)
end

function M.can_show_user_center()
  local USERCENTER = require("ejoysdk_lua.user_center.ejoysdk_usercenter")
  local usercenter_userinfo = USERCENTER.user_info()
  local user_info = M.user_info()
  if user_info and user_info.token and string.len(user_info.token) > 0 or usercenter_userinfo and usercenter_userinfo.token and string.len(usercenter_userinfo.token) > 0 then
    local vendor_ret = CM.get_vendor(nil, EV.ABILITY.ACCOUNT)
    do return CM.can_show_user_center end
    return CM.can_show_user_center, vendor_ret.vendor_name
  else
    E.LOG.error(TAG, "not login yet, can_show_user_center return false")
    return false
  end
end

function M.async_can_show_user_center(cb)
  if type(cb) ~= "function" then
    E.LOG.error(TAG, "call cb is nil")
    return
  end
  local result = M.can_show_user_center()
  cb(result)
end

function M.open_user_center(vendor_name, options, close_cb)
  if M.can_show_user_center() then
    local vendor_ret = CM.get_vendor(vendor_name, EV.ABILITY.ACCOUNT)
    CM.open_user_center(vendor_ret.vendor_name, options, close_cb)
  else
    E.LOG.error(TAG, "open user_center fail, can not open now, maybe not login, or not login by official channel account")
    if close_cb then
      close_cb()
    end
  end
end

function M.open_userinfo_completion(vendor_name, cb)
  local user_info = M.user_info()
  if user_info and user_info.token and string.len(user_info.token) > 0 then
    local vendor_ret = CM.get_vendor(vendor_name, EV.ABILITY.ACCOUNT)
    CM.open_userinfo_completion(vendor_ret.vendor_name, cb)
  else
    E.LOG.error(TAG, "open userinfo completion page fail, not login yet")
  end
end

local function do_login_with_token(server, token, cbid, login_opts)
  E.LOG.debug(TAG, "do_login_with_token cbid:" .. (cbid or "nil") .. ", server:" .. (server or "nil"))
  assert(type(server) == "string" and "" ~= server, "server should be string")
  assert(type(token) == "string" or nil == token, "token should be string")
  QL.log_login_invoke()
  local secret = _ejoysdk_crypt.randomkey()
  local params = {
    secret = _ejoysdk_crypt.base64encode(_ejoysdk_crypt.dhexchange(secret)),
    game = E.CONFIG.get_config("product"),
    server = server,
    token = token,
    pkg_info = E.get_pkg_info()
  }
  local acquire_params = acquire_token_params[token]
  if acquire_params then
    params.platform = acquire_params.platform
    params.with = acquire_params.with
  end
  local login_api_name = "login"
  if login_opts then
    if login_opts.user_agreement_info then
      params.user_agreement_version = login_opts.user_agreement_info.version
      local USERCENTER = require("ejoysdk_lua.user_center.ejoysdk_usercenter")
      params.location_info = (USERCENTER.user_info() or {}).location
    end
    if login_opts.login_api then
      login_api_name = login_opts.login_api
      E.LOG.debug(TAG, "login_with_token api:" .. tostring(login_api_name))
    end
  end
  E.LOG.debug(TAG, "do_login_with_token params:>>")
  E.log(params)
  local opts = {}
  opts.enable_sign_headers_for_request = true
  opts.enable_sign_headers_for_response = M.check_if_prevent_replay_status_open()
  gangplank_post(login_api_name, params, function(status, body)
    E.LOG.debug(TAG, "current cbid:" .. (cbid or "nil") .. ", loginId:" .. LOGINID)
    if cbid ~= LOGINID then
      E.LOG.debug(TAG, "已有最新的请求调用，该请求不处理，当前callback_id:" .. (cbid or "nil") .. ", 最新callback_id:" .. (LOGINID or "nil"))
      return
    end
    E.LOG.debug(TAG, "ejoysdk 打印 login_with_token 返回参数")
    E.log(body)
    
    local function handled_callback(succ)
      if succ then
        E.LOG.debug(TAG, " login_with_token success,  login again")
        do_login_with_token(server, token, cbid, login_opts)
      else
        E.LOG.error(TAG, " login_with_token failed")
        VENDOR_LOGIN:delete()
        login_listener(false, status, body.message or "", body)
      end
    end
    
    if 200 == status then
      E.LOG.debug(TAG, "do_login_with_token 成功！")
      GDP.USER_INFO.update(GDP.USER_INFO_KEY.SERVER, server)
      local uid = body and body.uid
      if uid then
        GDP.USER_INFO.update(GDP.USER_INFO_KEY.UID, uid)
      end
      local server_secret = _ejoysdk_crypt.base64decode(body.server_secret)
      local real_secret = _ejoysdk_crypt.dhsecret(server_secret, secret)
      ET.publish(ET.gangplank.LOGIN, GDP.USER_INFO.get())
      ET.publish(ET.analytics.LOGIN, GDP.USER_INFO.get())
      login_listener(true, body.game_token, real_secret, body.pinfo.pid)
    elseif 413 == status then
      E.LOG.debug(TAG, "do_login_with_token 排队！")
      GDP.USER_INFO.update(GDP.USER_INFO_KEY.SERVER, server)
      local uid = body and body.uid
      if uid then
        GDP.USER_INFO.update(GDP.USER_INFO_KEY.UID, uid)
      end
      local queue = body.queue
      local interval_time = body.interval_time
      call_queue_listener("start", queue, body)
      update_current_queue_ticket(cbid, body.ticket)
      do return queue_loop, body.ticket, queue, secret, login_listener, cbid end
      return queue_loop, body.ticket, queue, secret, login_listener, cbid, interval_time
    elseif 10421 == status then
      E.LOG.debug(TAG, "do_login_with_token activat-code required")
      local popup_info = {
        ejoy_token = GDP.USER_INFO.get("token"),
        config_url = body.active_code_url,
        server_id = server
      }
      ACPOPUP.handle_login_interrupt_info(status, popup_info, function(code, msg)
        handled_callback(code == ACPOPUP.ACTIVE_STATUS.ACTIVED)
      end)
    else
      local agreement_handled = AGREEMENT.handle_login_reject_error(status, body.token, handled_callback)
      if agreement_handled then
        E.LOG.debug(TAG, " login_with_token failed and wait for user agreement result!")
      else
        E.LOG.error(TAG, "login_with_token failed for other reason")
        VENDOR_LOGIN:delete()
        login_listener(false, status, body.message or "", body)
      end
    end
  end, opts)
end

function M.login_with_token(server, token, login_opts)
  local cbid = gen_login_id()
  E.LOG.debug(TAG, "收到新的请求调用，callback_id:" .. cbid)
  do_login_with_token(server, token, cbid, login_opts)
end

function M.scene_login_with_token(server, token)
  local cbid = gen_login_id()
  E.LOG.debug(TAG, "scene_login_with_token: 收到新的请求调用，callback_id:" .. tostring(cbid))
  local opts = {
    login_api = "scene_login"
  }
  do_login_with_token(server, token, cbid, opts)
end

function M.login(vendor_name, opts)
  M.acquire_token(vendor_name, nil, opts)
end

function M.enter_game(server, opts)
  local token = M.user_info().token
  if UTILS.STR.is_empty(token) then
    login_listener(false, CONSTANTS.GANGPLANK_ERROR_CODE.GANGPLANK_ERROR_CODE_EJOY_TOKEN_INVALID, "invalid ejoy_token, call acquire_token first")
  elseif UTILS.STR.is_empty(server) then
    login_listener(false, CONSTANTS.GANGPLANK_ERROR_CODE.GANGPLANK_ERROR_INVALID_SERVER, "invalid params: server")
  else
    M.login_with_token(server, token, opts)
  end
end

function M.set_queue_interval_rules(rules)
  if not rules then
    E.LOG.warn(TAG, "set_queque_interval_rules skip, rules is nil")
    return
  end
  local rules_data = {}
  for cnt, interval in pairs(rules) do
    local data = {}
    data.cnt = cnt
    data.interval = interval
    table.insert(rules_data, data)
  end
  table.sort(rules_data, function(data1, data2)
    return data1.cnt > data2.cnt
  end)
  E.LOG.debug(TAG, "set_queue_interval_rules >")
  E.log(rules_data)
  login_queue_rules_data = rules_data
end

local function acquire_handler()
  GDP.SESSION_INFO.set("account")
end

local has_set_player_info = false

local function login_handler()
  has_set_player_info = false
end

local function logout_hanlder()
  has_set_player_info = false
  GDP.PLAYER_INFO.clear()
  GDP.SESSION_INFO.clear()
end

local function get_player_token_succ_handler(moment_token)
  if moment_token and "" ~= moment_token and type(moment_token) == "string" then
    GDP.PLAYER_INFO.update(GDP.PLAYER_INFO_KEY.PLAYER_TOKEN, moment_token)
  end
  if set_player_info_cb then
    set_player_info_cb(true, {
      type = M.SET_PLAYER_INFO_CALLBACK_EVENT.GET_PLAYER_TOKEN_SUCC
    })
  end
  GDP.SESSION_INFO.set("player")
end

local function get_player_token_fail_handler(ret)
  local code = ret.code
  local msg = ret.msg
  if set_player_info_cb then
    set_player_info_cb(false, {
      type = M.SET_PLAYER_INFO_CALLBACK_EVENT.GET_PLAYER_TOKEN_FAIL,
      code = code,
      msg = msg
    })
  end
end

M.SET_PLAYER_INFO_CALLBACK_EVENT = {
  GET_PLAYER_TOKEN_SUCC = "GET_PLAYER_TOKEN_SUCC",
  GET_PLAYER_TOKEN_FAIL = "GET_PLAYER_TOKEN_FAIL"
}

function M.set_player_info(player_info, player_info_type, cb)
  assert(player_info, "player_info can not be nil")
  assert(player_info.server_id, "server_id can not be nil")
  assert(type(player_info.server_id) == "string", "server_id should be string")
  assert(player_info.player_id, "player_id can not be nil")
  assert(player_info.player_name, "player_name can not be nil")
  player_info.player_id = tostring(player_info.player_id)
  set_player_info_cb = cb
  local current_player_id = GDP.PLAYER_INFO.get("player_id")
  GDP.PLAYER_INFO.set(player_info)
  local clone_player_info = GDP.PLAYER_INFO.clone()
  if not has_set_player_info or player_info.player_id ~= current_player_id then
    E.LOG.debug(TAG, "set_player_info player change, cur:" .. tostring(current_player_id) .. ", new:" .. tostring(player_info.player_id))
    ET.publish(ET.gangplank.SET_PLAYER_INFO, clone_player_info)
    has_set_player_info = true
  elseif player_info.player_id == current_player_id then
    ET.publish(ET.gangplank.UPDATE_PLAYER_INFO, clone_player_info)
  end
  local stat_params = {
    new_player_id = player_info.player_id,
    old_player_id = current_player_id,
    player_info = player_info,
    player_info_type = player_info_type
  }
  ESTAT.stat_action("ejoy_set_player_info_invoke", player_info_type, nil, stat_params)
  if player_info_type then
    E.LOG.debug(TAG, "set_player_info with type, player_info_type:" .. tostring(player_info_type))
    ET.publish(ET.gangplank.SET_PLAYER_INFO_WITH_TYPE, clone_player_info, player_info_type)
  end
  if player_info and player_info.server_id and player_info.player_id and player_info.is_valid ~= false then
    GDP.PLAYER_INFO.save_simple(player_info)
  end
end

function M.player_offline()
  has_set_player_info = false
  GDP.PLAYER_INFO.clear()
  ET.publish(ET.holo.CLEAR_PLAYER_TOKEN)
  ET.publish(ET.gangplank.PLAYER_OFFLINE)
end

function M.cancel_queue()
  local current_ticket = get_current_queue_ticket()
  if current_ticket then
    local params = {ticket = current_ticket}
    gangplank_post("queue_dropout", params, function()
    end)
    call_queue_listener("end")
    clear_current_queue_ticket()
  end
end

local function bind_base(token, outsource, force, cb)
  local stat_params = {
    stack = E.HTTP.encode_uri(debug.traceback())
  }
  ESTAT.stat_action("gangplank_function_bind_base", "", true, stat_params)
  local _server = GDP.USER_INFO.get("server")
  local _region = GDP.USER_INFO.get("region")
  local params = {
    token = token,
    game = E.CONFIG.get_config("product"),
    server = _server,
    region = _region,
    platform = outsource.platform,
    ptoken = outsource.ptoken,
    pid = outsource.pid,
    ext = outsource.ext,
    force = force,
    with = outsource.with,
    with_account = outsource.with_account,
    appname = outsource.appname
  }
  gangplank_post("bind", params, function(status, body)
    E.LOG.debug(TAG, "ejoysdk log bind result")
    E.log({body = body, status = status})
    if 200 == status then
      cb.success(body)
    elseif 403 == status then
      cb.conflict(body.conflict)
    else
      cb.error(status)
    end
  end)
end

local function bind_callback_builder(outsource, info)
  local stat_params = {
    outsource = outsource,
    info = info,
    stack = E.HTTP.encode_uri(debug.traceback())
  }
  ESTAT.stat_action("gangplank_function_bind_callback_builder", "", true, stat_params)
  local platform = GDP.USER_INFO.get("platform")
  local guest = nil == platform
  local token
  if guest then
    token = EJOY_TOKEN:get()
  else
    token = VENDOR_LOGIN:get().token
  end
  local cb = {
    success = function(body)
      if guest then
        EJOY_TOKEN:delete()
      end
      local _region = GDP.USER_INFO.get("region")
      VENDOR_LOGIN:set({
        region = _region,
        token = body.token,
        outsource = outsource,
        info = info
      })
      bind_listener("succ", body.token)
    end,
    error = function(status)
      if 401 == status then
        if guest then
          EJOY_TOKEN:delete()
        else
          VENDOR_LOGIN:delete()
        end
      end
      local last_login_params = {outsource = outsource, info = info}
      if on_vendor_login_fail(status, last_login_params) then
        return
      end
      bind_listener("error", status)
    end,
    conflict = function(conflict)
      local function continure_bind(selected_token)
        if selected_token == token then
          bind_base(token, outsource, true, bind_callback_builder(outsource, info))
        end
      end
      
      bind_listener("conflict", conflict, continure_bind)
    end
  }
  return cb
end

local function bind(vendor_name)
  local stat_params = {
    vendor_name = vendor_name,
    stack = E.HTTP.encode_uri(debug.traceback())
  }
  ESTAT.stat_action("gangplank_function_bind", "", true, stat_params)
  local vendor = EV.get(vendor_name)
  assert(vendor, "vendor: " .. tostring(vendor_name) .. "not found")
  local _token = GDP.USER_INFO.get("token")
  LOGIN_INFO:set({
    type = "bind",
    token = _token,
    vendor = vendor_name
  })
  vendor.login()
end

local function query(server, region, outsource, cb)
  assert(type(server) == "string" and "" ~= server, "server should be string")
  assert(type(region) == "string" or nil == region, "region should be string or nil")
  assert("string" == type(outsource.platform), "outsource.platform should be string")
  assert("string" == type(outsource.ptoken), "outsource.ptoken should be string")
  assert("string" == type(outsource.pid) or nil == outsource.pid, "outsource.pid should be string or nil")
  assert(type(cb.success) == "function", "cb.success should be function")
  assert("function" == type(cb.error), "cb.error should be function")
  local params = {
    game = E.CONFIG.get_config("product"),
    server = server,
    region = region,
    platform = outsource.platform,
    ptoken = outsource.ptoken,
    pid = outsource.pid,
    ext = outsource.ext
  }
  local stat_params = {
    params = params,
    stack = E.HTTP.encode_uri(debug.traceback())
  }
  ESTAT.stat_action("gangplank_function_query", "", true, stat_params)
  gangplank_post("query", params, function(status, body)
    if 200 == status then
      cb.success(body.tokens)
    else
      cb.error(status)
    end
  end)
end

ET.subscribe("app_on_stop", function()
  if LOGIN_INFO:get() then
    LOGIN_INFO:save()
  end
end)

local function create_order_base(type_, amount, channel, outsource, cb, override)
  assert(type(type_) == "string" and "" ~= type_, "type should be string")
  assert(type(amount) == "number" and amount > 0, "amount should be number and larger then 0")
  assert(type(cb) == "function", "cb should be function")
  local _token = GDP.USER_INFO.get("token")
  assert(_token, "need login")
  local user_server_id = GDP.USER_INFO.get("server")
  local player_server_id = GDP.PLAYER_INFO.get("server_id")
  local current_server_id = user_server_id
  if player_server_id then
    E.LOG.debug(TAG, "已经设置了player_info，server_id:" .. player_server_id)
    if current_server_id ~= player_server_id then
      E.LOG.debug(TAG, "[warning]当前登录的角色和进入游戏的角色不一致，登录角色区服ID:" .. tostring(user_server_id) .. ", 进入游戏角色区服ID：" .. tostring(player_server_id))
      current_server_id = player_server_id
    end
  else
    E.LOG.debug(TAG, "没有设置player_info，使用 user_info 的 server_id:" .. tostring(user_server_id))
  end
  local ql_params
  if user_server_id ~= player_server_id then
    local login_server_id_str = user_server_id or "nil"
    local player_server_id_str = player_server_id or "nil"
    ql_params = {login_server_id = login_server_id_str, player_server_id = player_server_id_str}
    E.LOG.debug(TAG, "server_id inconsistent, login_server_id:" .. login_server_id_str .. ", player_server_id:" .. player_server_id_str)
  end
  QL.commit_event(QL.EVENT_NAMES.SDK_PAY_CREATE_ORDER_INVOKE, ql_params, true)
  local _player_info = GDP.PLAYER_INFO.get()
  local params = {
    type = type_,
    amount = amount,
    platform = outsource.platform,
    ptoken = outsource.ptoken,
    pid = outsource.pid,
    with = outsource.with,
    with_account = outsource.with_account,
    ext = outsource.ext,
    channel = channel,
    game = E.CONFIG.get_config("product"),
    server = current_server_id,
    token = _token,
    pkg_info = E.get_pkg_info(),
    player_info = _player_info,
    money_type = outsource.money_type
  }
  E.LOG.debug(TAG, "create_order_base params >>")
  E.log(params)
  E.log(override)
  if override then
    for k, v in pairs(override) do
      if type(v) ~= "function" then
        params[k] = v
      end
    end
  end
  ESTAT.create_order_report({
    biz_func = "sdk.create_gp_order",
    biz_act = "start",
    biz_st = "succ",
    biz_co = "200"
  })
  gangplank_post("create_order", params, function(status, body)
    if 200 == status then
      cb(true, body.order_id, body)
    else
      E.LOG.debug(TAG, body)
      cb(false, body.code or status, body.message, body)
    end
  end)
end

local function pay_base(vendor_name, product_id, count, override)
  local vendor_ret = CM.get_vendor(vendor_name, EV.ABILITY.PAY)
  vendor_name = vendor_ret.vendor_name
  local vendor = vendor_ret.vendor
  local prefix_message = "{" .. LANG_UTIL.getStringSuitCNOverseas("code", "") .. ":"
  if nil == vendor then
    E.LOG.debug(TAG, "pay vendor is nil")
    ET.publish("purchased", false, ER.order.CANT_PURCHASE)
    ET.publish(ET.gangplank.PAY_FAILED, {
      can_pay = false,
      vendor_name = tostring(vendor_name)
    })
    local tip_msg = LANG_UTIL.getStringSuitCNOverseas("pay_vendor_can_not_find_tips", "")
    tip_msg = tip_msg .. prefix_message .. tostring(CONSTANTS.GANGPLANK_ERROR_CODE.GANGPLANK_ERROR_PAY_NOT_SUPPORT) .. "}"
    E.Modal.open(LANG_UTIL.getStringSuitCNOverseas("tips", ""), {
      message = tip_msg,
      buttons = {
        LANG_UTIL.getStringSuitCNOverseas("confirm", "")
      }
    })
    pay_listener(false, "", CONSTANTS.GANGPLANK_ERROR_CODE.GANGPLANK_ERROR_PAY_NOT_SUPPORT, tip_msg, {
      vendor_name = tostring(vendor_name),
      product_id = tostring(product_id)
    })
    ESTAT.place_order_report({
      biz_act = "finish",
      biz_st = "fail",
      biz_co = "400",
      biz_params = {
        product_id = product_id,
        msg = "pay vendor is nil",
        code = CONSTANTS.GANGPLANK_ERROR_CODE.GANGPLANK_ERROR_PAY_NOT_SUPPORT
      }
    })
    return
  end
  if not vendor.can_pay() then
    E.LOG.debug(TAG, "vendor can_pay is false")
    ET.publish("purchased", false, ER.order.CANT_PURCHASE)
    ET.publish(ET.gangplank.PAY_FAILED, {
      can_pay = false,
      vendor_name = tostring(vendor_name)
    })
    local tip_msg = LANG_UTIL.getStringSuitCNOverseas("pay_vendor_can_not_pay_tips", "")
    tip_msg = tip_msg .. prefix_message .. tostring(CONSTANTS.GANGPLANK_ERROR_CODE.GANGPLANK_ERROR_CAN_NOT_PAY) .. "}"
    E.Modal.open(LANG_UTIL.getStringSuitCNOverseas("tips", ""), {
      message = tip_msg,
      buttons = {
        LANG_UTIL.getStringSuitCNOverseas("confirm", "")
      }
    })
    pay_listener(false, "", CONSTANTS.GANGPLANK_ERROR_CODE.GANGPLANK_ERROR_CAN_NOT_PAY, tip_msg, {
      vendor_name = tostring(vendor_name),
      product_id = tostring(product_id)
    })
    ESTAT.place_order_report({
      biz_act = "finish",
      biz_st = "fail",
      biz_co = "400",
      biz_params = {
        product_id = product_id,
        msg = "vendor can_pay is false",
        code = CONSTANTS.GANGPLANK_ERROR_CODE.GANGPLANK_ERROR_CAN_NOT_PAY
      }
    })
    return
  end
  local product_info = vendor.product_list()[product_id]
  if not product_info then
    E.LOG.debug(TAG, "product_info is nil")
    local tip_msg = LANG_UTIL.getStringSuitCNOverseas("pay_product_can_not_find_tips", "")
    tip_msg = tip_msg .. prefix_message .. tostring(CONSTANTS.GANGPLANK_ERROR_CODE.GANGPLANK_ERROR_PAY_PRODUCT_NOT_FOUND) .. "}"
    E.Modal.open(LANG_UTIL.getStringSuitCNOverseas("tips", ""), {
      message = tip_msg,
      buttons = {
        LANG_UTIL.getStringSuitCNOverseas("confirm", "")
      }
    })
    pay_listener(false, "", CONSTANTS.GANGPLANK_ERROR_CODE.GANGPLANK_ERROR_PAY_PRODUCT_NOT_FOUND, tip_msg, {
      vendor_name = tostring(vendor_name),
      product_id = tostring(product_id),
      product_list = vendor.product_list()
    })
    ESTAT.place_order_report({
      biz_act = "finish",
      biz_st = "fail",
      biz_co = "400",
      biz_params = {
        product_id = product_id,
        msg = "product_info is nil",
        code = CONSTANTS.GANGPLANK_ERROR_CODE.GANGPLANK_ERROR_PAY_PRODUCT_NOT_FOUND
      }
    })
    return
  end
  local _platform = GDP.USER_INFO.get("platform")
  local _ptoken = GDP.USER_INFO.get("ptoken")
  local _pid = GDP.USER_INFO.get("pid")
  local _with = GDP.USER_INFO.get("with")
  local _with_account = GDP.USER_INFO.get("with_account")
  local _ext = GDP.USER_INFO.get("ext")
  local outsource = {
    platform = _platform,
    ptoken = _ptoken,
    pid = _pid,
    with = _with,
    with_account = _with_account,
    ext = _ext,
    money_type = product_info.money_type
  }
  local pay_channel = vendor_name
  if vendor and vendor.vendor_channel then
    pay_channel = vendor.vendor_channel()
  end
  if "ALIGAMES" == pay_channel then
    pay_channel = nil
  end
  if "HARMONY_ACCOUNT" == pay_channel then
    pay_channel = nil
  end
  ESTAT.place_order_report({
    biz_act = "finish",
    biz_st = "succ",
    biz_co = "200",
    biz_params = {product_id = product_id}
  })
  E.LOG.debug(TAG, "before create_order_base, pay_channel:" .. tostring(pay_channel))
  if vendor and vendor.skip_gp_order and vendor.skip_gp_order() then
    vendor.pay(product_id, count, "", {}, override)
  else
    local gp_pay_span = ATracer.start_pay_sub_span(ATracer.PAY_FLOWS_SPANS.GANGPLANK_PAY)
    create_order_base(product_id, count, pay_channel, outsource, function(succ, ...)
      if succ then
        local order_id, body = ...
        E.LOG.debug(TAG, "before create_order_base success " .. tostring(order_id))
        pending_product_infos.order_id = product_info
        ET.publish(ET.analytics.CREATE_ORDER, order_id, product_info)
        ATracer.finish_pay_sub_span(gp_pay_span, body)
        vendor.pay(product_id, count, order_id, body, override)
        ESTAT.create_order_report({
          biz_func = "sdk.create_gp_order",
          biz_act = "finish",
          biz_st = "succ",
          biz_co = "200",
          biz_params = {product_id = product_id, gp_order_id = order_id}
        })
      else
        E.LOG.error(TAG, "before create_order_base failure")
        local code, msg, body = ...
        local defaul_msg = "default error msg[gangplank_order]"
        local param = {
          can_pay = true,
          code = code,
          msg = msg or defaul_msg,
          ext = {
            pay_part = "gangplank_order",
            body = body,
            product_id = tostring(product_id)
          }
        }
        ET.publish(ET.gangplank.PAY_FAILED, param)
        ATracer.finish_pay_sub_span(gp_pay_span, param)
        pay_listener(false, "", code, msg or defaul_msg, param)
        ESTAT.create_order_report({
          biz_func = "sdk.create_gp_order",
          biz_act = "finish",
          biz_st = "fail",
          biz_co = "400",
          biz_params = {
            product_id = product_id,
            code = code,
            msg = msg
          }
        })
        local tip_msg = LANG_UTIL.getStringSuitCNOverseas("pay_common_tips", "")
        if 401 == code then
          tip_msg = LANG_UTIL.getStringSuitCNOverseas("pay_need_login_tips", "")
        end
        tip_msg = tip_msg .. prefix_message .. tostring(code) .. "}"
        E.Modal.open(LANG_UTIL.getStringSuitCNOverseas("tips", ""), {
          message = tip_msg,
          buttons = {
            LANG_UTIL.getStringSuitCNOverseas("confirm", "")
          }
        })
      end
    end, override)
  end
end

function M.pay(vendor_name, product_id, count, override)
  assert(pay_listener, "register pay listener first")
  ESTAT.place_order_report({
    biz_act = "start",
    biz_st = "succ",
    biz_co = "200",
    biz_params = {product_id = product_id}
  })
  ET.publish(ET.gangplank.PAY_INVOKE)
  local prefix_message = "{" .. LANG_UTIL.getStringSuitCNOverseas("code", "") .. ":"
  local token = GDP.USER_INFO.get("token")
  if not token then
    local tip_msg = LANG_UTIL.getStringSuitCNOverseas("pay_need_login_tips", "")
    tip_msg = tip_msg .. prefix_message .. tostring(CONSTANTS.GANGPLANK_ERROR_CODE.GANGPLANK_ERROR_PAY_TOKEN_EMPTY) .. "}"
    E.Modal.open(LANG_UTIL.getStringSuitCNOverseas("tips", ""), {
      message = tip_msg,
      buttons = {
        LANG_UTIL.getStringSuitCNOverseas("confirm", "")
      }
    })
    pay_listener(false, "", CONSTANTS.GANGPLANK_ERROR_CODE.GANGPLANK_ERROR_PAY_TOKEN_EMPTY, tip_msg, {})
    return
  end
  local cur_time = os.time()
  if cur_time - last_pay_invoke_time < 1 then
    E.LOG.debug(TAG, "频繁调用充值！")
    return
  else
    last_pay_invoke_time = cur_time
  end
  E.LOG.debug(TAG, "now do create order!")
  ATracer.start_pay_span(vendor_name, product_id)
  pay_base(vendor_name, product_id, count, override)
end

local function product_infos_base(channel, cb)
  local params = {
    game = E.CONFIG.get_config("product"),
    channel = channel,
    tags = E.CONFIG.get_config("pay_tags"),
    area = E.CONFIG.get_config("district"),
    language = LANG.get_startup_lang(),
    device_platforms = {
      E.Sysinfo.os()
    }
  }
  E.log("product_infos request params>>")
  E.log(params)
  gangplank_get("get_product_infos", params, function(status, body)
    if 200 == status then
      local product_infos = {}
      for _, v in ipairs(body.product_infos) do
        product_infos[v.product_id] = v
      end
      cb(true, product_infos)
    else
      cb(false, status)
    end
  end)
end

function M.get_product_list_simple(cb)
  local function cb_wrapper(succ, ...)
    if succ then
      local product_list = (...)
      
      E.LOG.debug(TAG, {product_list_before = product_list})
      for _k, v in pairs(product_list) do
        v.money = nil
        v.show_money = nil
        v.currency = v.money_type
        v.money_type = nil
        if v.product_items and type(v.product_items) == "table" then
          for _k2, sub_product in pairs(v.product_items) do
            sub_product.money = nil
            sub_product.show_money = nil
            sub_product.currency = sub_product.money_type
            sub_product.money_type = nil
          end
        end
      end
      E.LOG.debug(TAG, {product_list_after = product_list})
      if cb then
        cb(succ, product_list)
      end
    elseif cb then
      cb(succ, ...)
    end
  end
  
  do return M.get_product_list_v2 end
  return M.get_product_list_v2, cb_wrapper
end

function M.get_product_list_v2(cb)
  do return M.get_product_list, nil end
  return M.get_product_list, nil, cb
end

function M.get_product_list(channel, cb)
  if nil == cb then
    return
  end
  E.LOG.debug(TAG, "get_product_list begin")
  local vendor = EV.get(channel)
  if nil == channel or "" == channel or "auto" == channel then
    local vendor_ret = CM.get_vendor(nil, EV.ABILITY.PAY)
    if vendor_ret and vendor_ret.vendor then
      vendor = vendor_ret.vendor
    end
  end
  if vendor and vendor.vendor_channel then
    channel = vendor.vendor_channel()
  end
  if nil == channel or "" == channel then
    local is_oversea = E.CONFIG.get_config(E.CONFIG.KEY.MULTI_REGIONS_ENABLED)
    if is_oversea then
      channel = "OFFICIAL"
    else
      channel = "ALIGAMES"
    end
    vendor = vendor or EV.get(channel)
  end
  E.LOG.debug(TAG, "get_product_list from channel: " .. (channel or "nil"))
  if vendor then
    if vendor.get_product_list then
      vendor.get_product_list(cb)
      return
    end
    local product_list
    if vendor.product_list then
      local ok, result = pcall(vendor.product_list)
      if ok then
        product_list = result
      end
    end
    if product_list and next(product_list) then
      E.LOG.debug(TAG, "get product from cache")
      cb(true, UTILS.deepcopy(product_list))
    else
      M.product_infos_base(channel, cb)
    end
  else
    E.LOG.debug(TAG, "channel can not find vendor, channel = " .. tostring(channel))
    cb(false, CONSTANTS.GANGPLANK_ERROR_CODE.GANGPLANK_ERROR_GET_PRODUCT_LIST_VENDOR_EMPTY)
  end
end

M.VENDOR_LOGIN_ERROR = CONSTANTS.CHANNEL_ERROR_CODE.CHANNEL_VENDOR_UNKNOWN_LOGIN_FAILED
M.login_base = login_base
M.bind_base = bind_base
M.product_infos_base = product_infos_base
M.create_order_base = create_order_base

function M.set_user_info(info)
  GDP.USER_INFO.set(info)
end

function M.get_ejoy_token()
  local stat_params = {
    stack = E.HTTP.encode_uri(debug.traceback())
  }
  ESTAT.stat_action("gangplank_function_get_ejoy_token", "", true, stat_params)
  do return EJOY_TOKEN.get end
  return EJOY_TOKEN.get, EJOY_TOKEN, "", true, stat_params
end

function M.get_vendor_auth_info()
  local stat_params = {
    stack = E.HTTP.encode_uri(debug.traceback())
  }
  ESTAT.stat_action("gangplank_function_get_vendor_auth_info", "", true, stat_params)
  do return VENDOR_LOGIN.get end
  return VENDOR_LOGIN.get, VENDOR_LOGIN, "", true, stat_params
end

function M.offline()
  GDP.USER_INFO.clear()
  local params = {
    stack = E.HTTP.encode_uri(debug.traceback())
  }
  QL.commit_event(QL.EVENT_NAMES.SDK_OFFLINE_INVOKE, params, true)
end

M.bind = bind
M.query = query

function M.user_info()
  do return end
  return GDP.USER_INFO.clone, nil
end

function M.ejoy_token()
  do return GDP.USER_INFO.get end
  return GDP.USER_INFO.get, "token"
end

function M.user_info_value(key)
  if not key then
    return nil
  end
  do return GDP.USER_INFO.get end
  return GDP.USER_INFO.get, key
end

function M.async_user_info(cb)
  UTILS.safe_call_cb(cb, M.user_info())
end

function M.access(cb)
  local stat_params = {
    stack = E.HTTP.encode_uri(debug.traceback())
  }
  ESTAT.stat_action("gangplank_function_access", "", true, stat_params)
  local params = {
    token = GDP.USER_INFO.get("token")
  }
  gangplank_post("access", params, function(status, body)
    if 200 == status then
      cb(true, body)
    else
      cb(false, body)
    end
  end)
end

function M.exit(_vendor_name)
  local vendor_ret = CM.get_vendor(nil, EV.ABILITY.ACCOUNT)
  local vendor_name = vendor_ret.vendor_name
  local vendor = vendor_ret.vendor
  if vendor and vendor.exit then
    E.LOG.debug(TAG, "exit called, to call vendor exit function, find vendor = " .. tostring(vendor_name))
    vendor.exit()
  elseif _ejoysdk.os() == "windows" then
    E.LOG.debug(TAG, "当前PC找不到ACCOUNT的插件，说明接的是gangplank的扫码，此时调用gangplank.exit也需要弹出挽留弹窗")
    if not E.is_support_ejoy_style_alert() then
      E.LOG.debug(TAG, "now is old ejoysdk version, can not show lingxi style alert")
      M.notify_exit(true)
      return
    end
    E.LOG.debug(TAG, "now is new ejoysdk version, can show lingxi style alert, so show user the alert.")
    local title = LANG_UTIL.getStringSuitCNOverseas("exit_alert_title", "")
    local param = {
      message = LANG_UTIL.getStringSuitCNOverseas("exit_alert_content", ""),
      buttons = {
        LANG_UTIL.getStringSuitCNOverseas("exit_alert_ensure", ""),
        LANG_UTIL.getStringSuitCNOverseas("exit_alert_cancel", "")
      }
    }
    E.Modal.open(title, param, function(answer)
      E.LOG.debug(TAG, "on exit callback >> " .. tostring(answer))
      if 0 == answer then
        M.notify_exit(true)
      else
        M.notify_exit(false)
      end
    end)
  else
    E.LOG.error(TAG, "exit called, can not find vendor to make exit!!!!")
  end
end

local function bind_listener_wrapper(listener)
  return function(succ, ...)
    LOGIN_INFO:delete()
    if listener then
      listener(succ, ...)
    end
  end
end

local function login_listener_wrapper(listener)
  return function(succ, ...)
    LOGIN_INFO:delete()
    if listener then
      listener(succ, ...)
    end
  end
end

local function acquire_listener_wrapper(listener)
  return function(succ, ...)
    LOGIN_INFO:delete()
    if listener then
      listener(succ, ...)
    end
  end
end

local function login_listener_modify(listener)
  return function(success, ...)
    if listener then
      listener(success, ...)
    end
    if success then
      QL.log_login(...)
    else
      ET.publish(ET.gangplank.LOGIN_FAILED, ...)
      QL.log_login_failed(...)
    end
  end
end

local function pay_listener_modify(listener)
  return function(succ, ...)
    if listener then
      listener(succ, ...)
    end
    local param = {can_pay = true}
    if succ then
      local order_id, ext = ...
      param.order_id = order_id
      param.ext = ext or nil
      param.platform = ext and ext.platform
      ET.publish(ET.gangplank.PAY, param)
    else
      local order_id, code, msg, ext = ...
      param.order_id = order_id
      param.code = code
      param.msg = msg
      param.ext = ext
      param.platform = ext and ext.platform
      ET.publish(ET.gangplank.PAY_FAILED, param)
    end
    ATracer.finish_pay_span(param)
  end
end

function M.get_global_cdn_config()
  do return end
  return EGC.get_global_cdn_config, nil
end

local function get_cutout_info_from_cc()
  local CC = require("ejoysdk_lua.ejoysdk_config_center")
  local biz_config = CC.get_config(CC.NAMESPACE.EJOYSDK_BIZ)
  if biz_config and biz_config.config then
    local cc_cutout_infos = biz_config.config.cutout_infos
    local model_str = E.Sysinfo.model() or ""
    if cc_cutout_infos and type(model_str) == "string" and 0 ~= #model_str then
      local cutout_info = cc_cutout_infos[model_str]
      if cutout_info then
        E.LOG.debug(TAG, "get cutout from config_center")
        return {
          [model_str] = cutout_info
        }
      end
    end
  end
  return nil
end

local function init_all_channel(opts, cb)
  local function vendor_init_callback(succ, ...)
    if succ then
      E.LOG.debug(TAG, "vendor_init_callback success, now begin init native side")
      
      local ALL_CHANNEL = "ALL"
      UNI.register_init_listener(ALL_CHANNEL, function(succ2, msg)
        if succ2 then
          E.LOG.debug(TAG, "all channel init success!")
          cb(true)
        else
          E.LOG.error(TAG, "all channel init failed, msg:" .. (msg or "nil"))
          cb(false, CONSTANTS.CHANNEL_ERROR_CODE.CHANNEL_NATIVE_INIT_FAILED, msg)
        end
      end)
      local params = {}
      if _ejoysdk.os then
        local cutout_info = get_cutout_info_from_cc()
        if cutout_info then
          params.cutout_info = cutout_info
        else
          params.cutout_info = require("ejoysdk_lua.consts.cutout_info")[_ejoysdk.os() or ""]
        end
      end
      UNI.init(ALL_CHANNEL, params)
    else
      local code, msg = ...
      E.LOG.error(TAG, "vendor_init_callback failed, now callback init failed, code:" .. tostring(code) .. ", msg:" .. (msg or "nil"))
      cb(false, code, msg)
    end
  end
  
  CM.init(opts, {
    auth_listener = function(vendor, succ, outsource, info)
      local login_info = LOGIN_INFO:get()
      if login_info and vendor == login_info.vendor then
        if login_info.type == "login" then
          if succ then
            E.LOG.debug(TAG, "auth_listener result succ, the login_info type is login, now set LAST_VENDOR_AUTH:" .. vendor)
            LAST_VENDOR_AUTH:set(vendor)
            local region = login_info.region
            login_base(login_info.server, region, outsource, login_info.token, login_callback_builder(login_info.server, region, outsource, info, login_listener))
            QL.log_vendor_login(vendor)
          else
            VENDOR_LOGIN:delete()
            local login_fail_info = outsource or {}
            login_fail_info.type = "vendor_login_failed"
            login_fail_info.vendor = vendor
            ET.publish("trace_event", "boot", login_fail_info)
            local err_code = login_fail_info.code or M.VENDOR_LOGIN_ERROR
            local err_msg = login_fail_info.msg or ""
            login_listener(false, err_code, err_msg)
            QL.log_vendor_login_failed(vendor, err_code, err_msg)
          end
          ET.publish(ET.gangplank.VENDOR_LOGIN_END, succ, outsource or {})
        elseif login_info.type == "bind" then
          if succ then
            bind_base(login_info.token, outsource, false, bind_callback_builder(outsource, info))
          else
            bind_listener("error", M.VENDOR_LOGIN_ERROR, outsource)
          end
        elseif login_info.type == "acquire" then
          if succ then
            E.LOG.debug(TAG, "auth_listener result succ, the login_info type is acquire, now set LAST_VENDOR_AUTH:" .. vendor)
            E.LOG.debug(TAG, "outsource =====")
            E.LOG.debug(TAG, outsource)
            LAST_VENDOR_AUTH:set(vendor)
            local userinfo = M.user_info() or {}
            userinfo.ptoken = outsource.ptoken
            userinfo.platform = outsource.platform
            userinfo.uid = outsource.openId
            userinfo.with = outsource.with
            userinfo.st = outsource.st
            userinfo.is_sandbox_user = outsource.is_sandbox_user
            ET.publish(ET.gangplank.AUTH_SUCC, userinfo)
            local region = login_info.region
            local token = login_info.token
            local acquire_callback = acquire_callback_builder(region, outsource, info, token_callback_for_acquire)
            acquire_base(region, outsource, token, acquire_callback, info)
            QL.log_vendor_login(vendor)
          else
            local safe_outsource = {}
            if outsource and type(outsource) == "table" then
              safe_outsource.code = outsource.code
              safe_outsource.msg = outsource.msg
            end
            local login_fail_info = safe_outsource or {}
            login_fail_info.type = "vendor_login_failed"
            login_fail_info.vendor = vendor
            local err_msg = login_fail_info.msg or ""
            login_fail_info.message = err_msg
            ET.publish("trace_event", "boot", login_fail_info)
            local err_code = login_fail_info.code or M.VENDOR_LOGIN_ERROR
            local region = login_info.region
            acquire_callback_builder(region, outsource, info, token_callback_for_acquire)(false, err_code, outsource or {})
            QL.log_vendor_login_failed(vendor, err_code, err_msg)
          end
          ET.publish(ET.gangplank.VENDOR_LOGIN_END, succ, outsource or {})
        end
      else
        E.log("vendor not equal to login_info.vendor, vendor = " .. tostring(vendor))
        E.log("login_info = ")
        E.log(login_info)
      end
    end,
    pay_listener = function(vendor, succ, ...)
      if succ then
        local order_id, ext = ...
        local product_info = pending_product_infos.order_id
        ET.publish(ET.analytics.PURCHASE_SUCC, order_id, product_info)
        pending_product_infos.order_id = nil
        ext = ext or {}
        ext.platform = vendor
        pay_listener(true, order_id, ext)
      else
        local order_id, value = ...
        local ext = value and value.ext or {}
        ext.platform = vendor
        pay_listener(false, order_id, value.code or ext.code or CONSTANTS.GANGPLANK_ERROR_CODE.GANGPLANK_ERROR_PAY_FAILED_DEFAULT_CODE, value.msg or ext.msg or "", ext)
      end
    end,
    switch_listener = function(_vendor, outsource, info)
      local vendor_login = VENDOR_LOGIN:get()
      if vendor_login then
        login_base(vendor_login.server, vendor_login.region, outsource, vendor_login.token, login_callback_builder(vendor_login.server, vendor_login.region, outsource, info, switch_listener))
      end
    end,
    logout_listener = function(_vendor, _ext)
      LOGIN_INFO:delete()
      VENDOR_LOGIN:delete()
      M.offline()
      ET.publish(ET.gangplank.LOGOUT, GDP.USER_INFO.get())
      logout_listener()
    end,
    exit_listener = function(_vendor, succ)
      M.notify_exit(succ)
    end
  }, vendor_init_callback)
end

local pure_vendors = {"QR_LOGIN"}

function M.get_pure_lua_account_vendors()
  return pure_vendors
end

local function check_init_opts(opts)
  if type(opts) == "string" and "auto" == opts then
    local login_sdks = EV.get_native_vendors(EV.ABILITY.ACCOUNT)
    local pay_sdks = EV.get_native_vendors(EV.ABILITY.PAY)
    opts = {}
    for _, sdk in pairs(login_sdks) do
      opts[sdk] = {}
    end
    for _, sdk in pairs(pay_sdks) do
      opts[sdk] = {}
    end
  else
    opts = opts or {}
  end
  E.LOG.debug(TAG, "check init opts before >>")
  
  local function make_lua_account_vendor_data(vendor_name)
    return {
      name = vendor_name,
      lua_vendor = true,
      ability = {"ACCOUNT"}
    }
  end
  
  local sdk_infos = UNI.get_sdk_infos()
  if sdk_infos and (sdk_infos.OFFICIAL or sdk_infos.AIRLINE_V2) then
    local st_login_name = "ST_LOGIN"
    sdk_infos[st_login_name] = make_lua_account_vendor_data(st_login_name)
  end
  for _, name in ipairs(pure_vendors) do
    local has_contain = false
    for key, _item in ipairs(sdk_infos) do
      if sdk_infos[key] == name then
        has_contain = true
        break
      end
    end
    if not has_contain then
      sdk_infos[name] = make_lua_account_vendor_data(name)
    end
  end
  E.LOG.debug(TAG, "check init opts sdk_infos >>")
  E.log(sdk_infos)
  for sdk_name, sdk_info in pairs(sdk_infos) do
    sdk_info = sdk_info or {}
    if sdk_info.lua_vendor and EV.get(string.upper(sdk_name)) then
      sdk_name = string.upper(sdk_name)
    end
    local temp_table = opts[sdk_name]
    if nil == temp_table or type(temp_table) == "table" and 0 == UTILS.tablelength(temp_table) then
      E.LOG.debug(TAG, "opts add native sdk: " .. tostring(sdk_name))
      local meta_info = sdk_info.meta or {}
      opts[sdk_name] = meta_info
    end
  end
  for vendor_name, options in pairs(opts) do
    if options._disable then
      E.LOG.debug(TAG, "vendor is disable, so remove it from opts:" .. vendor_name)
      opts[vendor_name] = nil
    end
  end
  local JF = require("ejoysdk_lua.vendors.jf")
  local init_media_stats_vendors_occasion = JF.get_init_media_stats_vendors_occasion()
  if "sdk.startup.success" == init_media_stats_vendors_occasion or "sdk.login" == init_media_stats_vendors_occasion then
    opts.FIREBASE = nil
    opts.APPSFLYER = nil
  end
  E.LOG.debug(TAG, "check_init_opts opts after >>")
  E.log(opts)
  return opts
end

function M.sync_server_time(cb, _retry_times, _retry_timer_interval, is_platform_domain)
  local start = os.time()
  local start_clock = E.system_clock()
  gangplank_post("get_server_time", {}, function(status, body)
    if 200 == status then
      E.LOG.debug(TAG, "get_server_info service_splice_version:" .. tostring(body and body.service_splice_version) .. ", server_time:" .. tostring(body and body.server_time_ms))
      if not body or not body.server_time_ms then
        if cb then
          cb(false, 0, {
            code = CONSTANTS.BASE_API_COMMON_ERROR.CODE_NOT_DATA,
            message = "server_time_ms is nil"
          })
        end
        return
      end
      local now = os.time()
      local rtt = (start - now) / 2
      local diff = body.server_time_ms / 1000 + rtt - now
      local end_clock = E.system_clock()
      local clock_rtt = end_clock - start_clock
      local server_ms = body.server_time_ms + clock_rtt / 2
      E.set_time_diff(diff)
      if body then
        pcall(EC.set_service_splice_version, body and body.service_splice_version or 0)
      end
      if clock_rtt < 240000 and clock_rtt > 0 then
        E.set_server_ms(server_ms)
        if cb then
          cb(true)
        end
      else
        E.LOG.debug(TAG, "tick sync_server_time time out")
        if cb then
          cb(false, 0, {
            code = 0,
            message = "sync_server_time time out"
          })
        end
      end
    else
      local retry_times = _retry_times or 0
      local retry_timer_interval = _retry_timer_interval or 1
      if retry_timer_interval <= 0 then
        retry_timer_interval = 600
      end
      if retry_times > 0 then
        E.Timer.once(retry_timer_interval, function()
          M.sync_server_time(cb, retry_times - 1, retry_timer_interval * 2)
        end)
      elseif cb then
        cb(false, status, body)
      end
    end
  end, {is_platform_domain = is_platform_domain})
end

local DEFAULT_LOOP_SYNC_SERVER_TIME = 43200
local did_start_loop_sync_timer = false

local function loop_sync_server_timer()
  E.Timer.once(DEFAULT_LOOP_SYNC_SERVER_TIME, function()
    M.sync_server_time()
    loop_sync_server_timer()
  end)
end

function M.notify_exit(succ)
  E.LOG.debug(TAG, "notify game exit")
  exit_listener(succ)
  if succ then
    ET.publish(ET.gangplank.EXIT)
  end
end

function M.init(opts, listeners)
  E.LOG.debug(TAG, "gangplank init ----->>>>>> called")
  local ejoysdk_pf = require("ejoysdk_lua.performance.ejoysdk_performance")
  ejoysdk_pf.mark_sdk_init_invoke()
  if inited then
    if -1 == EC.get_service_splice_version() then
      M.sync_server_time(function()
        ET.publish(EI.SUBSCRIBE_GANGPLANK_INITED, true)
      end, nil, nil, false)
      E.LOG.debug(TAG, "get_service_splice_version is -1 value, return now")
      return
    end
    E.LOG.debug(TAG, "gangplank already inited, just notify init success and return")
    ET.publish(EI.SUBSCRIBE_GANGPLANK_INITED, true)
    return
  end
  ET.publish(EI.SUBSCRIBE_GANGPLANK_INITSTART)
  opts = check_init_opts(opts)
  ETracer.init()
  local check_result = VC.check_sdk_version(opts)
  if not check_result.result then
    local check_fail_msg = "[error]version check failed! sdk_name:" .. check_result.sdk_name .. ", current version is " .. check_result.current_sdk_version .. ", min sdk required is:" .. check_result.sdk_min_version
    E.LOG.warn(TAG, check_fail_msg)
    ET.publish(EI.SUBSCRIBE_GANGPLANK_INITED, false, CONSTANTS.GANGPLANK_ERROR_CODE.GANGPLANK_CHECK_SDK_VERSIONS_FAILED, check_fail_msg)
    return
  end
  M.set_listener(listeners)
  ET.subscribe(ET.gangplank.LOGIN, login_handler)
  ET.subscribe(ET.gangplank.LOGOUT, logout_hanlder)
  ET.subscribe(ET.gangplank.ACQUIRE, acquire_handler)
  ET.subscribe(ET.holo.GET_PLAYER_TOKEN, get_player_token_succ_handler)
  ET.subscribe(ET.holo.GET_PLAYER_TOKEN_FAIL, get_player_token_fail_handler)
  
  local function publish_init_success()
    inited = true
    ET.publish(EI.SUBSCRIBE_GANGPLANK_INITED, true)
  end
  
  local function publish_init_failed(status, message)
    E.LOG.error(TAG, "init failed, status:" .. (status or "nil") .. ", msg:" .. (message or nil))
    ET.publish(EI.SUBSCRIBE_GANGPLANK_INITED, false, status, message)
  end
  
  E.LOG.debug(TAG, "gangplank init begin, bin_ver:" .. tostring(E.Sysinfo.bin_version()))
  EGC.init_config(function(succ, ...)
    if succ then
      E.LOG.debug(TAG, "init_config succ >>")
      local first_sync_server_time_cb
      
      function first_sync_server_time_cb(_time_succ_new_domain, ...)
        if not _time_succ_new_domain then
          M.sync_server_time(function(_time_succ, ...)
            if _time_succ then
              E.LOG.debug(TAG, "sync_server_server succ")
              QL.commit_action_succ_main("ejoy_get_server_time_end")
            else
              local _status = (...)
              E.LOG.warn(TAG, "sync_server_server failed:" .. tostring(_status))
              QL.commit_action_fail_main("ejoy_get_server_time_end", nil, _status)
            end
          end, 10)
        end
        if not did_start_loop_sync_timer then
          loop_sync_server_timer()
          did_start_loop_sync_timer = true
        end
        local config_center = require("ejoysdk_lua.ejoysdk_config_center")
        local aligames_config = require("ejoysdk_lua.vendors.aligames_config")
        config_center.set_url_base(aligames_config.get_config_center_base_url())
        config_center.init()
        local ejoy_res = require("ejoysdk_lua.res.ejoysdk_res")
        ejoy_res.init()
        local ejoy_lightboat = require("ejoysdk_lua.res.lightboat.ejoysdk_lightboat")
        ejoy_lightboat.init()
        E.LOG.debug(TAG, "init_all_channel begin")
        init_all_channel(opts, function(succ2, ...)
          local status, message = ...
          if not succ2 then
            E.LOG.error(TAG, "init_all_channel failed, status: " .. tostring(status) .. ", msg:" .. tostring(message))
            publish_init_failed(status, message)
            return
          end
          E.LOG.debug(TAG, "init_all_channel succ received")
          
          local function temp_callback_function(_succ, ...)
            if _succ then
              if succ2 then
                local succ3, _code, _msg = M.check_compatibility()
                if true == succ3 then
                  publish_init_success()
                else
                  publish_init_failed(_code or CONSTANTS.ENV_ERROR.CODE_NOT_COMPATIBILITY, _msg or "Incompatible with your system")
                end
              else
                publish_init_failed(status, message)
              end
            else
              local code, msg = ...
              E.LOG.error(TAG, "gangplank init failed, code: " .. tostring(code) .. ", msg:" .. tostring(msg))
              publish_init_failed(code, msg)
            end
          end
          
          local APP_Update = require("ejoysdk_lua.app_update.app_update")
          if APP_Update.is_app_update_checked() then
            E.LOG.debug(TAG, "app update has been checked")
            temp_callback_function(true)
          elseif APP_Update.skip_app_update() then
            E.LOG.debug(TAG, "app update skip")
            temp_callback_function(true)
          else
            APP_Update.check_update_app_version(function(_succ, ...)
              temp_callback_function(_succ, ...)
            end)
          end
        end)
      end
      
      M.sync_server_time(first_sync_server_time_cb, nil, nil, false)
      M.sync_server_time(function()
      end, nil, nil, true)
      QL.commit_action_succ_main("ejoy_gp_config_end")
    else
      local status, message = ...
      E.LOG.error(TAG, "init_config failed, status:" .. (status or "nil") .. ", message:" .. (message or "nil"))
      publish_init_failed(status, message)
      QL.commit_action_fail_main("ejoy_gp_config_end", nil, status, message)
    end
  end)
end

function M.is_inited()
  return inited
end

function M._test_reset_init()
  inited = false
end

function M.set_listener(listeners)
  login_listener = login_listener_modify(listeners.auth_listener)
  logout_listener = listeners.logout_listener
  switch_listener = listeners.switch_listener
  pay_listener = pay_listener_modify(listeners.pay_listener)
  bind_listener = listeners.bind_listener
  queue_listener = listeners.queue_listener
  exit_listener = listeners.exit_listener
  acquire_listener = listeners.acquire_listener
  game_listeners = listeners
end

function M.get_listener()
  return game_listeners
end

function M.alive_servers_with_params(cb, params, options)
  E.LOG.debug(TAG, "alive_servers_with_params params >>")
  E.log(params)
  gangplank_get("get_alive_servers", params, function(status, body)
    if 200 == status then
      for _, server in pairs(body.servers) do
        server.realm = server.realm[1] or ""
      end
      cb(true, body.servers)
      QL.commit_action_succ_main("ejoy_alive_servers_end")
    else
      local msg = body and body.message or ""
      cb(false, status, msg)
      QL.commit_action_fail_main("ejoy_alive_servers_end", nil, status, msg)
    end
  end, options)
end

function M.alive_servers(tags, cb)
  E.LOG.debug(TAG, "alive_servers begin >>")
  if type(tags) == "function" then
    cb = tags
    tags = {}
  end
  if tags and 0 == #tags then
    tags = nil
  end
  local params = {tags = tags}
  M.alive_servers_with_params(cb, params)
end

function M.alive_servers_auth_with_params(cb, params)
  E.LOG.debug(TAG, "alive_servers_auth_with_params params >>")
  E.log(params)
  local url = M.gangplank_logined_url("/alive_servers", "2")
  local token = M.user_info().token
  E.HTTP.post(url, require_params(token), HTTP.CT_JSON, params, function(resp)
    E.log({resp = resp})
    local status = resp.status
    local body = resp.body
    if 200 == status then
      for _, server in pairs(body.servers) do
        server.realm = server.realm[1] or ""
      end
      cb(true, body.servers)
      QL.commit_action_succ_main("ejoy_alive_servers_auth_end")
    else
      local _msg = body and body.message or ""
      cb(false, status, _msg)
      QL.commit_action_fail_main("ejoy_alive_servers_auth_end", nil, status, _msg)
    end
  end)
end

function M.alive_servers_with_auth(tags, cb)
  if tags and 0 == #tags then
    tags = nil
  end
  local params = {tags = tags}
  M.alive_servers_auth_with_params(cb, params)
end

function M.get_recommend_servers(_params, cb)
  local params = _params or {}
  E.LOG.debug(TAG, "get_recommend_servers params >>")
  E.log(params)
  gangplank_get("get_recommend_servers", params, function(status, body)
    if 200 == status then
      cb(true, body.servers)
    else
      cb(false, status, body and body.message or "")
    end
  end)
end

local _gp_server_marks_enable = true

function M.get_server_marks(_params, cb)
  if false == _gp_server_marks_enable then
    cb(false, 404, "")
    return
  end
  local params = _params or {}
  E.LOG.debug(TAG, "get_server_marks params >>")
  E.log(params)
  gangplank_get("get_server_marks", params, function(status, body)
    if 200 == status then
      cb(true, body.mark_data)
    else
      if 404 == status then
        _gp_server_marks_enable = false
      end
      cb(false, status, body and body.message or "")
    end
  end)
end

function M.get_server_marks_with_node(_params, cb)
  local params = _params or {}
  E.LOG.debug(TAG, "get_server_marks params >>")
  E.log(params)
  gangplank_get("get_server_marks_with_node", params, function(status, body)
    if 200 == status then
      cb(true, body and body.data)
    else
      cb(false, status, body and body.message or "")
    end
  end)
end

function M.get_realms_with_alive_info(_params, cb)
  local params = _params or {}
  if not params.lang then
    params.lang = EC.get_config("lang")
  end
  gangplank_post("get_realms_with_alive_info", params, function(status, body)
    if 200 == status then
      for _, server in pairs(body and body.servers or {}) do
        if server.alive_data_info and server.alive_data_info.realm and #server.alive_data_info.realm > 0 then
          server.alive_data_info.realm = server.alive_data_info.realm[1] or ""
        end
      end
      cb(true, body and body.servers)
    else
      cb(false, status, body and body.message or "")
    end
  end)
end

local gplbs_config

local function get_ip_location_from_server(_params, cb)
  local params = _params or {}
  gangplank_post("get_location", params, function(status, body)
    if 200 == status then
      local result = body and body.data
      if result then
        gplbs_config = result
      end
      if cb then
        cb(true, result or {})
      end
    elseif cb then
      cb(false, status, body and body.message or "")
    end
  end)
end

function M.get_ip_location_async(cb)
  if gplbs_config then
    if cb then
      cb(true, gplbs_config)
    end
  else
    get_ip_location_from_server({}, cb)
  end
end

function M.get_players(token, cb)
  local user_info_api = require("ejoysdk_lua.server_api.ejoysdk_user_info")
  user_info_api.get_players(token, cb)
end

function M.get_players_with_query(_query, cb)
  local user_info_api = require("ejoysdk_lua.server_api.ejoysdk_user_info")
  user_info_api.get_players_with_query(_query, cb)
end

function M.get_players_from_gs(cb)
  local url = M.gangplank_logined_url("/get_players", "2")
  E.LOG.debug(TAG, "get_players_from_gs url : " .. tostring(url))
  local token = M.user_info().token
  HTTP.post(url, require_params(token), HTTP.CT_JSON, {}, function(resp)
    local status = resp.status
    local body = resp.body
    E.log({status = status, body = body})
    if 200 == status then
      if 0 == body.code then
        cb(true, body.result)
      else
        cb(false, body.code)
      end
    else
      cb(false, status)
    end
  end)
end

local function get_global_players(cb)
  local user_info_api = require("ejoysdk_lua.server_api.ejoysdk_user_info")
  user_info_api.get_global_players(cb)
end

function M.get_global_players_for_unittest(cb)
  get_global_players(cb)
end

function M.login_global_center(vendor_name, cb)
  local stat_params = {
    vendor_name = vendor_name,
    stack = E.HTTP.encode_uri(debug.traceback())
  }
  ESTAT.stat_action("gangplank_function_login_global_center", "", true, stat_params)
  local global_gangplank_enabled = E.CONFIG.get_config(E.CONFIG.KEY.GLOBAL_GANGPLANK_ENABLED)
  if not global_gangplank_enabled then
    local err_msg = "login_global_center failed, global gangplank not enabled!"
    E.LOG.error(TAG, err_msg)
    cb(false, CONSTANTS.GLOBAL_GANGPLANK_ERROR_CODE.GLOBAL_GANGPLANK_NOT_ENABLED, err_msg)
    return
  end
  
  local function login_global_center_callback(succ, ...)
    if succ then
      local players = (...)
      local global_result = {}
      global_result.global_players = players
      global_result.gangplank_config = EGC.get_global_gangplank_configs()
      cb(true, global_result)
    else
      local status, message = ...
      E.LOG.error(TAG, "get_global_players failed:" .. status)
      cb(false, status, message or "login global center failed!")
    end
  end
  
  local function acquire_token_callback(succ, ...)
    if succ then
      local token = (...)
      E.LOG.debug(TAG, "login_global_center get ejoy_token succ:" .. token)
      local region = E.CONFIG.get_config(E.CONFIG.KEY.REGION)
      global_region_token_cache[region] = token
      E.LOG.debug(TAG, "login_global_center update token cache, region:" .. region .. ", token:" .. token)
      get_global_players(function(succ2, ...)
        if succ2 then
          local players = (...)
          E.LOG.debug(TAG, "get_global_players succ:")
          E.log(players)
          login_global_center_callback(true, players)
        else
          local status = (...)
          E.LOG.error(TAG, "get_global_players failed:" .. status)
          login_global_center_callback(false, status, "get global players failed!")
        end
      end)
    else
      local code, message = ...
      E.LOG.error(TAG, "login_global_center get ejoy_token failed, code: " .. code .. " ,message: " .. message)
      login_global_center_callback(false, code, message)
    end
  end
  
  local ext = {override_acquire_listener = acquire_token_callback}
  global_region_token_cache = {}
  M._acquire_token_global(vendor_name, nil, ext)
end

function M.check_if_prevent_replay_status_open()
  local CC = require("ejoysdk_lua.ejoysdk_config_center")
  local core_config = CC.get_config(CC.NAMESPACE.EJOYSDK_CORE)
  if core_config and core_config.config then
    local value = core_config.config.enable_sign_headers_for_response
    if value then
      return true
    end
  end
  return false
end

function M.get_login_qrcode(cb)
  local QR = require("ejoysdk_lua.qrcode.ejoysdk_qrcode")
  QR.get_qrcode(QR.SCAN_TYPE.LOGIN, cb)
end

function M.cancel_query_qrcode_login()
  local QR = require("ejoysdk_lua.qrcode.ejoysdk_qrcode")
  QR.cancel_query_status()
end

function M.query_qrcode_login_status(cb)
  local QR = require("ejoysdk_lua.qrcode.ejoysdk_qrcode")
  QR.query_status(cb)
end

function M.grant_login_uuid(_uuid, cb)
  local QR = require("ejoysdk_lua.qrcode.ejoysdk_qrcode")
  QR.grant_qrcode(cb)
end

function M.qrcode_scan(cb)
  local QR = require("ejoysdk_lua.qrcode.ejoysdk_qrcode")
  QR.qrcode_scan(cb)
end

function M.get_punishment(cb)
  local user_info_api = require("ejoysdk_lua.server_api.ejoysdk_user_info")
  user_info_api.get_punishment(cb)
end

function M.unfreeze_player_product(player_id, cb)
  if not GDP.USER_INFO.get("token") or GDP.USER_INFO.get("token") == "" then
    E.LOG.error(TAG, "unfreeze_player_product failed, ejoy token is nil")
    cb(false, CONSTANTS.GANGPLANK_ERROR_CODE.GANGPLANK_ERROR_CODE_EJOY_TOKEN_INVALID, "ejoy token is nil")
    return
  end
  local playerid = player_id
  E.LOG.debug(TAG, "unfreeze_player_product, game set with player_id:" .. (playerid or "nil"))
  if not playerid or "" == playerid then
    local player_info = M.player_info()
    playerid = player_info and player_info.player_id or nil
    E.LOG.debug(TAG, "unfreeze_player_product, game NOT set with player_id, now use current player_id:" .. (playerid or "nil"))
  end
  if not playerid or "" == playerid then
    E.LOG.error(TAG, "unfreeze_player_product failed, player id is nil")
    cb(false, CONSTANTS.GANGPLANK_ERROR_CODE.GANGPLANK_ERROR_CODE_PLAYER_ID_INVALID, "player id is nil")
    return
  end
  local params = {
    player_id = tostring(playerid)
  }
  E.LOG.debug(TAG, "unfreeze_player_product player_id:" .. (playerid or "nil"))
  E.log(params)
  local token = GDP.USER_INFO.get("token")
  HTTP.post(M.gangplank_logined_url("/unfreeze_player_product", 2), require_params(token), E.HTTP.CT_JSON, params, function(resp)
    E.log({resp = resp})
    local status = resp and resp.status or -1
    if 200 == status then
      local result_code = resp and resp.body and resp.body.code
      if 0 == result_code then
        cb(true)
      else
        local msg = resp and resp.body and resp.body.message
        cb(false, result_code, msg or "request failed")
      end
    else
      cb(false, status, "request failed, status:" .. status)
    end
  end)
end

function M.check_white_black(cb)
  local url = M.gangplank_logined_url("/check_white_black", "2")
  local token = M.user_info().token
  E.HTTP.post(url, require_params(token), HTTP.CT_JSON, {}, function(resp)
    E.LOG.debug(TAG, "check_white_black resp >>")
    E.log({resp = resp})
    local status = resp.status
    local body = resp.body
    if 200 == status then
      local code = body.code
      local msg = body.message
      if 0 == code then
        E.LOG.debug(TAG, "check_white_black succ")
        cb(true, body)
      else
        E.LOG.error(TAG, "check_white_black failed, code:" .. code .. ", msg:" .. msg)
        cb(false, code, msg)
      end
    else
      local err_msg = body and body.message or ""
      E.LOG.error(TAG, "check_white_black failed, status:" .. status .. ", msg:" .. err_msg)
      cb(false, status, err_msg)
    end
  end)
end

return M
