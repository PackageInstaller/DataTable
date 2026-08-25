local E = require("ejoysdk_lua.ejoysdk")
local ET = require("ejoysdk_lua.ejoysdk_topic")
local UTIL = require("ejoysdk_lua.ejoysdk_utils")
local uuid = require("ejoysdk_lua.ejoysdk_uuid")
local JSON = require("ejoysdk_lua.ejoysdk_json")
local EM = require("ejoysdk_lua.ejoysdk_module")
local CONFIG = require("ejoysdk_lua.ejoysdk_config")
local M = {}
local TAG = EM.MODULE.EJOYSDK_BASE_MODULE .. "stat"
local BIZ_ACCOUNT = "account"
local BIZ_PAYMENT = "payment"
local BIZ_CHAT = "IM"
local BIZ_FROM = {}
local DEVICE_ID_TYPE_IMEI = "imei"
local DEVICE_ID_TYPE_IDFA = "idfa"
local DEVICE_ID_TYPE_GAID = "gaid"
local acc_info, dev_info, chl_info, game_info, env_info, cddp_info, local_ua_cache, local_umid_token_cache
local LUA_STAT_BIZID = "sdk.lua.bizid"
local PF_COMM_SDK = "sdk.pf_comm"
local LUA_STAT_ACTION = "sdk.lua.action"
local LUA_STAT_PUSH = "sdk.notification.receive"
local acc_info_change_listeners = {}

local function on_acc_info_changed()
  E.LOG.debug(TAG, "on_acc_info_changed")
  local _acc_info = M.acc_info()
  for _, lis in ipairs(acc_info_change_listeners) do
    lis(_acc_info)
  end
end

do
  local function jf_fill_params_function(user_info, is_auth_succ)
    M.acc_info()
    
    local account_info = acc_info
    local multi_regions_enabled = E.CONFIG.get_config(E.CONFIG.KEY.MULTI_REGIONS_ENABLED)
    if multi_regions_enabled then
      account_info.accountCh = "998236"
    else
      account_info.accountCh = user_info.ds_channel_id or user_info.platform or ""
      if _ejoysdk.os() == "windows" then
        M.chl_info()
        chl_info.ch = account_info.accountCh
      end
    end
    if user_info.uid and not is_auth_succ then
      account_info.accountId = user_info.uid
    end
    account_info.chuid = user_info.pid
    if user_info.platform ~= nil and user_info.platform ~= "" then
      account_info.chUserType = user_info.platform
    else
      account_info.chUserType = E.get_channel()
    end
    if user_info.pinfo and user_info.pinfo.ext and user_info.pinfo.ext.ch_openid then
      local os = _ejoysdk.os()
      local CLOUDGAME_3RD = require("ejoysdk_lua.ejoysdk_cloudgame_3rd")
      if "weixin" == os or "douyin" == os then
        account_info.openId = user_info.pinfo.ext.ch_openid
      end
      if "android" == os and CLOUDGAME_3RD.is_cloudgame() then
        account_info.openId = user_info.pinfo.ext.ch_openid
        M.cddp_info()
        if cddp_info then
          local l_option = CLOUDGAME_3RD.get_cache_launch_option()
          if CLOUDGAME_3RD.get_cloudgame_type() == CLOUDGAME_3RD.CLOUDGAME_TYPE.DYMINICLOUDGAME then
            cddp_info.dyScene = l_option and l_option.scene or "0"
            if "" == cddp_info.dyScene then
              cddp_info.dyScene = "0"
            end
          elseif CLOUDGAME_3RD.get_cloudgame_type() == CLOUDGAME_3RD.CLOUDGAME_TYPE.WXMINICLOUDGAME then
            cddp_info.wxScene = l_option and l_option.scene or "0"
            if "" == cddp_info.wxScene then
              cddp_info.wxScene = "0"
            end
          end
        end
      end
    end
    on_acc_info_changed(account_info)
  end
  
  ET.subscribe(ET.gangplank.LOGIN, function(user_info)
    jf_fill_params_function(user_info)
    E.log("gangplank LOGIN ---")
    E.log({user_info = user_info})
    E.log(M.acc_info())
  end)
  ET.subscribe(ET.gangplank.AUTH_SUCC, function(user_info)
    jf_fill_params_function(user_info, true)
    E.log(M.acc_info())
  end)
  ET.subscribe(ET.gangplank.ACQUIRE, function(user_info)
    jf_fill_params_function(user_info)
    E.log("ejoysdk_stat acquire success---")
    E.log({user_info = user_info})
    E.log(M.acc_info())
  end)
  ET.subscribe(ET.gangplank.USER_INFO_CHANGED, function(user_info)
    jf_fill_params_function(user_info)
    E.log("USER_INFO_CHANGED ---")
    E.log(M.acc_info())
  end)
  ET.subscribe(ET.gangplank.SCAN_LOGIN, function(user_info)
    jf_fill_params_function(user_info)
    E.log("ejoysdk_stat scan_login success---")
    E.log(M.acc_info())
  end)
  ET.subscribe(ET.gangplank.LOGOUT, function()
    local account_info = acc_info
    account_info.accountCh = ""
    local is_overseas = E.CONFIG.get_config(E.CONFIG.KEY.MULTI_REGIONS_ENABLED)
    if _ejoysdk.os() == "windows" and not is_overseas then
      chl_info.ch = account_info.accountCh
    end
    on_acc_info_changed(account_info)
  end)
end
M.STAT_KEY = {
  IS_UPLOAD_NOW = "is_upload_now",
  APUS_ONLY = "apus_only",
  JF_ONLY = "jf_only",
  IS_PRIORITY_HIGH = "is_priority_high"
}

function M.acc_info()
  if not acc_info then
    acc_info = {}
  end
  do return UTIL.deepcopy end
  return UTIL.deepcopy, acc_info
end

function M.dev_info()
  local pkg_info = E.get_pkg_info()
  if not dev_info then
    dev_info = {}
    local storage_info = E.Sysinfo.get_storage_info()
    if storage_info then
      dev_info.totalSize = tostring(storage_info.internal_total_storage_size / 1024 / 1024 / 1024)
    end
    if pkg_info then
      dev_info.language = pkg_info.language
      dev_info.country = pkg_info.country
      dev_info.fr = pkg_info.versions.os_version
      dev_info.brand = pkg_info.brand
      dev_info.ua = pkg_info.ua
      dev_info.uuid = pkg_info.uuid
      dev_info.time_zone = pkg_info.time_zone
      dev_info.hw_machine = pkg_info.hw_machine
      dev_info.model = pkg_info.model
      dev_info.publishArea = pkg_info.publish_area or ""
      dev_info.langScript = pkg_info.lang_script or ""
      dev_info.airline = pkg_info.airline or ""
      dev_info.cloudGameMode = pkg_info.cloud_game_mode or ""
      dev_info.mobileRunMode = pkg_info.cloud_game_runmode or ""
      dev_info.abType = pkg_info.ab_type or ""
    end
    local os = pkg_info.os
    dev_info.net = E.Sysinfo.network_type_name()
    if E.Sysinfo.screen then
      local screenData = E.Sysinfo.screen()
      local h = screenData.height or 0
      local w = screenData.width or 0
      if "windows" == os then
        dev_info.res = tostring(w) .. "*" .. tostring(h)
      else
        dev_info.res = tostring(h) .. "*" .. tostring(w)
      end
    end
    dev_info.ramSize = E.Sysinfo.memory()
    if not dev_info.ua and local_ua_cache then
      dev_info.ua = local_ua_cache
    end
    if "android" == os then
      dev_info.os = "android"
      if pkg_info then
        dev_info.isSimulator = pkg_info.is_simulator
        if pkg_info.imei ~= nil and "" ~= pkg_info.imei then
          dev_info.deviceId = pkg_info.imei
          dev_info.deviceIdType = DEVICE_ID_TYPE_IMEI
        elseif nil ~= pkg_info.gaid and "" ~= pkg_info.gaid then
          dev_info.deviceId = pkg_info.gaid
          dev_info.deviceIdType = DEVICE_ID_TYPE_GAID
        end
      end
    elseif "ios" == os then
      dev_info.os = "ios"
      if pkg_info then
        dev_info.deviceId = pkg_info.idfa
        dev_info.idfv = pkg_info.idfv
        dev_info.idfa = pkg_info.idfa
      end
      dev_info.deviceIdType = DEVICE_ID_TYPE_IDFA
      local ejoyExtInfo = JSON.safe_decode(E.Sysinfo.sysinfo_ejoy_ext_info())
      dev_info.ejoyExtInfo = ejoyExtInfo
    elseif "windows" == os then
      dev_info.os = "windows"
      dev_info.caidInfo = {}
      dev_info.cda = {}
      dev_info.weibo = {}
      dev_info.ttDID = ""
      dev_info.uuid = ""
      dev_info.pcAdToken = E.get_pc_ad_token()
    elseif "harmonyos" == os then
      dev_info.os = "harmonyos"
      dev_info.caidInfo = {}
      dev_info.cda = {}
      dev_info.weibo = {}
      dev_info.ttDID = ""
      dev_info.uuid = ""
      dev_info.oaid = pkg_info.oaid
    elseif "weixin" == os then
      dev_info.os = "weixin"
    elseif "douyin" == os then
      dev_info.os = "douyin"
    end
    dev_info.system = E.Sysinfo.get_device_system()
    dev_info.deviceType = E.Sysinfo.get_device_type()
  end
  if (not dev_info.utdid or "" == dev_info.utdid) and pkg_info then
    dev_info.utdid = pkg_info.utdid
  end
  if pkg_info and pkg_info.umid_token and "" ~= pkg_info.umid_token then
    dev_info.umidToken = pkg_info.umid_token
  elseif local_umid_token_cache and "" ~= local_umid_token_cache then
    dev_info.umidToken = local_umid_token_cache
  end
  do return UTIL.deepcopy end
  return UTIL.deepcopy, dev_info, E.Sysinfo.get_device_type(), E.Sysinfo.sysinfo_ejoy_ext_info()
end

function M.chl_info()
  if not chl_info then
    chl_info = {}
    local pkg_info = E.get_pkg_info()
    chl_info.ch = pkg_info.ds_channel_id or ""
    chl_info.subCh = pkg_info.ds_sub_channel_id or ""
  end
  do return UTIL.deepcopy end
  return UTIL.deepcopy, chl_info
end

function M.game_info()
  if not game_info then
    game_info = {}
    local pkg_info = E.get_pkg_info()
    game_info.pkgName = pkg_info.pkg_name
    game_info.appVer = pkg_info.versions.app_version_name
    game_info.abType = pkg_info.ab_type
    game_info.ptid = E.get_ptid()
  end
  do return UTIL.deepcopy end
  return UTIL.deepcopy, game_info
end

local weixin_enter_options

local function get_weixin_cddp_info()
  if not weixin_enter_options then
    weixin_enter_options = _ejoysdk.wx.getEnterOptionsSync()
  end
  if not weixin_enter_options then
    return {}
  end
  local weixin_cddp_info = {
    wxScene = weixin_enter_options.scene
  }
  if weixin_enter_options.query then
    for k, v in pairs(weixin_enter_options.query) do
      weixin_cddp_info[k] = v
    end
  end
  return weixin_cddp_info
end

local douyin_launch_options

local function get_douyin_cddp_info()
  if not douyin_launch_options then
    douyin_launch_options = _ejoysdk.dy.getLaunchOptionsSync()
  end
  if not douyin_launch_options then
    return {}
  end
  local douyin_cddp_info = {
    dyScene = douyin_launch_options.scene
  }
  if douyin_launch_options.query then
    for k, v in pairs(douyin_launch_options.query) do
      douyin_cddp_info[k] = v
    end
  end
  return douyin_cddp_info
end

function M.cddp_info()
  if not cddp_info then
    cddp_info = {}
    local os = _ejoysdk.os()
    if "weixin" == os then
      cddp_info = get_weixin_cddp_info()
    end
    if "douyin" == os then
      cddp_info = get_douyin_cddp_info()
    end
  end
end

function M.get_run_id()
  local run_id
  local os = _ejoysdk.os()
  if "weixin" == os and _ejoysdk.get_run_id then
    run_id = _ejoysdk.get_run_id()
  end
  run_id = run_id or uuid()
  return run_id
end

function M.env_info()
  if not env_info then
    env_info = {}
    M.acc_info()
    M.dev_info()
    M.chl_info()
    M.game_info()
    M.cddp_info()
    env_info.runId = M.get_run_id()
    env_info.accInfo = acc_info
    env_info.devInfo = dev_info
    env_info.chInfo = chl_info
    env_info.gmInfo = game_info
    env_info.cddpInfo = cddp_info
  end
  do return UTIL.deepcopy end
  return UTIL.deepcopy, env_info
end

function M.reset_env_info()
  _ejoysdk.log("reset_env_info begin")
  env_info = nil
  dev_info = nil
  chl_info = nil
  game_info = nil
end

function M.update_umid_token(umid_token)
  local_umid_token_cache = umid_token
  if dev_info then
    dev_info.umidToken = umid_token
  end
end

local has_init_public_params = false
local ejoysdk_ver = ""
local lua_ver = ""
local game_ver = ""
local os_ver = ""
local aligames_ver = ""
local security_ver = ""
local gamesec_ver = ""

local function add_public_params(params)
  params = params or {}
  if not has_init_public_params then
    has_init_public_params = true
    local versions = E.get_pkg_info().versions
    if versions then
      ejoysdk_ver = versions.ejoysdk_version
      lua_ver = versions.lua_version
      game_ver = versions.game_version
      os_ver = versions.os_version
      aligames_ver = versions.aligames_version
    end
    local os = E.Sysinfo.os()
    if "android" == os or "ios" == os then
      security_ver = E.get_sdk_version_name("SECURITY") or ""
    else
      security_ver = ""
    end
    local user_info_manager = require("ejoysdk_lua.user_info_manager")
    local mw = user_info_manager.get_mw()
    if mw then
      gamesec_ver = mw.sec_ver
    end
  end
  local pkg_info = E.get_pkg_info()
  params.sdk_version = ejoysdk_ver
  params.lua_vesion = lua_ver
  params.game_version = game_ver
  params.os_version = os_ver
  params.aligames_version = aligames_ver
  params.ab_type = pkg_info.ab_type
  params.security_version = security_ver or ""
  params.gamesec_version = gamesec_ver or ""
  params.net_type_name = E.Sysinfo.network_type_name()
end

local function commit_event(event_name, params)
  if event_name ~= PF_COMM_SDK then
    add_public_params(params)
  end
  params = params or {}
  local JF = require("ejoysdk_lua.vendors.jf")
  local is_upload_now = params[M.STAT_KEY.IS_UPLOAD_NOW] or false
  local is_priority_high = params[M.STAT_KEY.IS_PRIORITY_HIGH] or false
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
  local apus_options = params.apus_options
  local apus_only = params[M.STAT_KEY.APUS_ONLY] or false
  local ETAPUS = require("ejoysdk_lua.ejoysdk_to_apus")
  if apus_only then
    ETAPUS.commit_event(event_name, params, apus_options)
    return
  end
  local jf_only = params[M.STAT_KEY.JF_ONLY] or false
  if jf_only then
    JF.commit_event(event_name, params, options)
    return
  end
  JF.commit_event(event_name, params, options)
  ETAPUS.commit_event(event_name, params, apus_options)
end

function M.reset_has_init_public_params_flag()
  has_init_public_params = false
end

function M.stat_bizid(bizid, biztype, bizresult, params)
  if "sdk.payment" == bizid or bizid == PF_COMM_SDK then
    M.stat_bizid_pfcomm(params)
    return
  end
  params = params or {}
  params.bizid = bizid
  params.biztype = biztype
  params.bizresult = bizresult
  commit_event(LUA_STAT_BIZID, params)
end

local STAT_TIME_MAP = {}
local STAT_FROM_MAP = {}
local biz_trace_id = ""
local pay_chain_ver = ""

function M.stat_bizid_pfcomm(params)
  params = params or {}
  local pkg_info = E.get_pkg_info()
  local mobile_info = E.Sysinfo.mobile_info()
  params.pub = pkg_info.publish_area or ""
  params.pt = "app"
  if pkg_info.versions then
    params.sdk_ver = pkg_info.versions.ejoysdk_version
    params.lua_ver = pkg_info.versions.lua_version
  end
  if CONFIG.has_vendor_config("AIRLINE_V2") then
    params.has_airline_v2 = true
  end
  params.mcc = mobile_info and mobile_info.mcc or ""
  local biz_prod = params.biz_prod or BIZ_PAYMENT
  params.biz_prod = biz_prod
  local EG = require("ejoysdk_lua.ejoysdk_gangplank")
  params.account_id = EG.user_info().uid
  if params.biz_trace_id then
    biz_trace_id = params.biz_trace_id
  else
    params.biz_trace_id = biz_trace_id
  end
  if params.biz_act == "start" or params.biz_act == "enter" then
    local start_key = params.biz_mod .. params.biz_func .. params.biz_act
    STAT_TIME_MAP[start_key] = E.system_ms()
    local biz_from = BIZ_FROM[biz_prod] or nil
    if biz_from then
      local last_index = #biz_from
      params.biz_from = biz_from[last_index]
      params.biz_level = last_index + 1
    else
      params.biz_from = nil
      params.biz_level = 1
    end
    STAT_FROM_MAP[start_key] = params.biz_from
    if not BIZ_FROM[biz_prod] then
      BIZ_FROM[biz_prod] = {}
    end
    table.insert(BIZ_FROM[biz_prod], {
      biz_prod = params.biz_prod,
      biz_mod = params.biz_mod,
      biz_func = params.biz_func
    })
  elseif params.biz_act == "finish" or params.biz_act == "exit" then
    local last_act = params.biz_act == "finish" and "start" or "enter"
    local start_key = params.biz_mod .. params.biz_func .. last_act
    params.duration = STAT_TIME_MAP[start_key] and E.system_ms() - STAT_TIME_MAP[start_key] or 0
    params.biz_from = STAT_FROM_MAP[start_key] or nil
    STAT_TIME_MAP[start_key] = nil
    STAT_FROM_MAP[start_key] = nil
  end
  commit_event(PF_COMM_SDK, params)
end

function M.sdk_pay_pfcomm(pa)
  pa.biz_prod = BIZ_PAYMENT
  if pa.biz_chain_ver then
    pay_chain_ver = pa.biz_chain_ver
  else
    pa.biz_chain_ver = pay_chain_ver
  end
  M.stat_bizid_pfcomm(pa)
end

function M.pay_init_report(pa)
  pa.biz_mod = "init"
  pa.biz_func = "sdk.pay_init"
  M.sdk_pay_pfcomm(pa)
end

function M.place_order_report(pa)
  pa.biz_mod = "place_order"
  pa.biz_func = "sdk.access_place_order"
  local guuid = require("ejoysdk_lua.ejoysdk_uuid")
  if pa.biz_act == "start" then
    local trace_id = string.gsub(guuid(), "-", "")
    pa.biz_trace_id = trace_id
  end
  M.sdk_pay_pfcomm(pa)
end

function M.create_order_report(pa)
  pa.biz_mod = "create_order"
  M.sdk_pay_pfcomm(pa)
end

function M.h5_pay_report(pa)
  pa.biz_mod = "cashier_pay"
  pa.biz_func = "sdk.pay_open"
  pa.is_priority_high = true
  M.sdk_pay_pfcomm(pa)
end

function M.app_pay_report(pa)
  pa.biz_mod = "app_pay"
  pa.is_priority_high = true
  M.sdk_pay_pfcomm(pa)
end

function M.sdk_account_pfcomm(pa)
  pa.biz_prod = BIZ_ACCOUNT
  pa.is_priority_high = true
  M.stat_bizid_pfcomm(pa)
end

function M.sdk_login_pfcomm(pa)
  pa.biz_prod = "login"
  pa.is_priority_high = true
  M.stat_bizid_pfcomm(pa)
end

function M.sdk_init_report(pa)
  pa.biz_mod = "init"
  pa.biz_func = "sdk.init"
  M.sdk_account_pfcomm(pa)
end

function M.sdk_vendorlogin_report(pa)
  pa.biz_mod = "login"
  pa.biz_func = "sdk.vendor_login"
  M.sdk_account_pfcomm(pa)
end

function M.sdk_accountlogin_report(pa)
  pa.biz_mod = "login"
  pa.biz_func = "sdk.account_login"
  M.sdk_account_pfcomm(pa)
end

function M.sdk_acquire_report(pa)
  pa.biz_mod = "login"
  pa.biz_func = "sdk.acquire"
  M.sdk_account_pfcomm(pa)
end

function M.sdk_rolelogin_report(pa)
  pa.biz_mod = "login"
  pa.biz_func = "sdk.role_login"
  M.sdk_account_pfcomm(pa)
end

function M.sdk_logout_report(pa)
  pa.biz_mod = "login"
  pa.biz_func = "sdk.logout"
  pa.biz_act = "click"
  M.sdk_account_pfcomm(pa)
end

function M.sdk_chat_pfcomm(pa)
  pa.biz_prod = BIZ_CHAT
  M.stat_bizid_pfcomm(pa)
end

function M.sdk_msg_visit_report(pa)
  pa.biz_mod = "chat_window"
  pa.biz_func = "sdk.message_visit"
  pa.is_priority_high = false
  M.sdk_chat_pfcomm(pa)
end

function M.stat_action(action, action_type, result, params)
  params = params or {}
  local trim_action = E.Utils.trim(action)
  local trim_action_type = E.Utils.trim(action_type)
  local trim_result = E.Utils.trim(result)
  params.action = trim_action
  params.type = trim_action_type
  params.result = trim_result
  E.LOG.debug(TAG, "stat_action action:" .. tostring(trim_action) .. ", action_type:" .. tostring(trim_action_type) .. ", result:" .. tostring(trim_result))
  E.log(params)
  commit_event(LUA_STAT_ACTION, params)
end

function M.sdk_ability_report(ability)
  local params = {}
  params[M.STAT_KEY.APUS_ONLY] = true
  params.type = ability
  commit_event("sdk.lua.ability", params)
end

function M.stat_action_apus(action, action_type, result, params)
  params = params or {}
  params[M.STAT_KEY.APUS_ONLY] = true
  M.stat_action(action, action_type, result, params)
end

function M.flush_cached_events()
  local JF = require("ejoysdk_lua.vendors.jf")
  JF.flush_cached_events()
end

function M.stat_fatal_error(action, action_type, result, params)
  params = params or {}
  params.is_priority_high = true
  M.stat_action(action, action_type, result, params)
end

function M.stat_action_fail(action, action_type, ...)
  local params = {}
  local args = (...)
  local args_type = type(args)
  if "table" == args_type then
    params = args
  else
    local code, msg = ...
    params.code = code
    params.msg = msg
  end
  params.action = action
  params.type = action_type
  params.result = "false"
  E.LOG.debug(TAG, "stat_action_fail action:" .. tostring(action) .. ", action_type:" .. tostring(action_type) .. ", code:" .. tostring(params.code) .. ", msg:" .. tostring(params.msg))
  commit_event(LUA_STAT_ACTION, params)
end

function M.stat_action_fail_apus(action, action_type, ...)
  local params = {}
  local args = (...)
  local args_type = type(args)
  if "table" == args_type then
    params = args
  else
    local code, msg = ...
    params.code = code
    params.msg = msg
  end
  params.action = action
  params.type = action_type
  params.result = "false"
  E.LOG.debug(TAG, "stat_action_fail_apus action:" .. tostring(action) .. ", action_type:" .. tostring(action_type) .. ", code:" .. tostring(params.code) .. ", msg:" .. tostring(params.msg))
  M.stat_action_apus(action, action_type, false, params)
end

function M.stat_push(action, action_type, result, params)
  params = params or {}
  local trim_action = E.Utils.trim(action)
  local trim_action_type = E.Utils.trim(action_type)
  local trim_result = E.Utils.trim(result)
  params.action = trim_action
  params.type = trim_action_type
  params.result = trim_result
  E.LOG.debug(TAG, "stat_push action:" .. tostring(trim_action) .. ", action_type:" .. tostring(trim_action_type) .. ", result:" .. tostring(trim_result))
  E.log(params)
  commit_event(LUA_STAT_PUSH, params)
end

function M.get_trace_id()
  local JF = require("ejoysdk_lua.vendors.jf")
  do return end
  return JF.get_trace_id
end

local delay_get_ua_state = 0

function M.get_jf_format_data(event_name, params, cb)
  add_public_params(params)
  E.LOG.debug(TAG, "start get_jf_format_data")
  local res = {}
  res.envInfo = M.env_info()
  res.appId = E.get_game_id()
  res.event = event_name
  res.params = params
  res.time = E.time() * 1000
  E.LOG.debug(TAG, "end get_jf_format_data")
  local userAgent = res.envInfo.devInfo.ua
  if not userAgent or "unknown" == userAgent then
    if 0 == delay_get_ua_state or 1 == delay_get_ua_state then
      if 0 == delay_get_ua_state then
        delay_get_ua_state = 1
      end
      E.Timer.once(2.5, function()
        delay_get_ua_state = 2
        local_ua_cache = E.Sysinfo.get_user_agent()
        E.LOG.debug(TAG, "延迟获取ua:" .. tostring(local_ua_cache))
        if dev_info then
          dev_info.ua = local_ua_cache
        end
        if not res.envInfo.devInfo.ua and dev_info then
          res.envInfo.devInfo.ua = dev_info.ua
        end
        cb(res)
      end)
    else
      cb(res)
    end
  else
    cb(res)
  end
end

function M.register_acc_info_change_listener(lis)
  for _, handler in ipairs(acc_info_change_listeners) do
    if handler == lis then
      return
    end
  end
  acc_info_change_listeners[#acc_info_change_listeners + 1] = lis
end

function M.unregister_acc_info_change_listener(lis)
  if acc_info_change_listeners then
    local new = {}
    for _, handler in ipairs(acc_info_change_listeners) do
      if lis ~= handler then
        new[#new + 1] = handler
      end
    end
    acc_info_change_listeners = new
  end
end

local stat_error_cache = {}

function M.stat_error_with_limit(module, stat_key, action, action_type, param, max_count)
  if not stat_error_cache[module] then
    stat_error_cache[module] = {}
  end
  local stat_error_cache_one_module = stat_error_cache[module]
  if not stat_error_cache_one_module[stat_key] then
    stat_error_cache_one_module[stat_key] = 1
  end
  if stat_error_cache_one_module[stat_key] <= (max_count or 30) then
    local safe_param = param or {}
    safe_param.count = stat_error_cache_one_module[stat_key]
    M.stat_action(action, action_type, false, safe_param)
    stat_error_cache_one_module[stat_key] = stat_error_cache_one_module[stat_key] + 1
  end
end

M.stat_action_with_limit = M.stat_error_with_limit

function M._test_clear_cache()
  local_ua_cache = nil
  local_umid_token_cache = nil
end

return M
