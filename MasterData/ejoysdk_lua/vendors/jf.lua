local E = require("ejoysdk_lua.ejoysdk")
local ET = require("ejoysdk_lua.ejoysdk_topic")
local UNI = require("ejoysdk_lua.vendors.unisdk")
local Vendor = require("ejoysdk_lua.vendors.vendor")
local UIM = require("ejoysdk_lua.user_info_manager")
local JF_LUA = require("ejoysdk_lua.jf.jf_lua_impl")
local EM = require("ejoysdk_lua.ejoysdk_module")
local JSON = require("ejoysdk_lua.ejoysdk_json")
local EU = require("ejoysdk_lua.ejoysdk_utils")
local CHANNEL = "JF"
local LUA_IMP = {
  windows = true,
  harmonyos = true,
  weixin = true,
  douyin = true
}
local M = Vendor:Inherit(CHANNEL)
M.VENDOR_NAME = CHANNEL
M.secInfoCache = nil
local TAG = EM.MODULE.VENDORS.JF
local CAST_INIT_JF = "CAST_INIT_JF"
local CAST_COMMIT_EVENT = "CAST_COMMIT_EVENT"
local CAST_UPLOAD_EVENT = "CAST_UPLOAD_EVENT"
local CAST_UPDATE_DATA = "CAST_UPDATE_DATA"
local CAST_UPDATE_DEVICE_INFO = "CAST_UPDATE_DEVICE_INFO"
local SYNC_IS_SUPPORT_PRIORITY_HIGH = "SYNC_IS_SUPPORT_PRIORITY_HIGH"
local DEFAULT_WHITE_PRIVACY_FIELDS = {
  "brand",
  "model",
  "mac",
  "country",
  "lang",
  "ramSize",
  "availRamSize",
  "hwf",
  "fr",
  "cpu"
}
local cp_white_privacy_fields = DEFAULT_WHITE_PRIVACY_FIELDS
local uid, pid, platform
local jf_inited = false
local log_collector_host
local cached_commit_events = {}
local has_stat_oaid_received_event = false
local media_stats_inited = false
local init_time = E.system_clock()
local trace_id
M.EVENT_NAMES = {
  SDK_START_UP = "sdk.startup",
  SDK_START_UP_LINK_LAUNCH = "sdk.startup.link_launch",
  SDK_START_UP_SUCCESS = "sdk.startup.success",
  SDK_ROLE_ONLINE = "sdk.role.online",
  SDK_ROLE_CREATE = "sdk.role.create",
  SDK_ROLE_LEVEL_UP = "sdk.role.levelup",
  SDK_START_UP_PRE_ORDER = "sdk.startup.pre_order",
  SDK_STARTUP_OAID_RECEIVED = "sdk.startup.oaid",
  SDK_CLOUD_GAME_LOGIN = "sdk.cloudgame.login"
}
M.EVENT_OCCASION = {
  ENTERGAME = "enterGame",
  UPDATES = "updates",
  CREATEROLE = "createRole",
  EXITGAME = "exitGame"
}
M.OPTION_KEY = {
  IS_UPLOAD_NOW = "is_upload_now",
  IS_PRIORITY_HIGH = "is_priority_high"
}
local init_media_stats_vendors_occasion

function M.get_init_media_stats_vendors_occasion()
  return init_media_stats_vendors_occasion
end

local function is_support_priority_high()
  local ret = UNI.sync_call(CHANNEL, SYNC_IS_SUPPORT_PRIORITY_HIGH, {}, nil)
  local support = ret and ret.support or false
  return support
end

local function uni_cast(channel, cast_commit_event, event_params)
  if LUA_IMP[E.Sysinfo.os()] then
    return
  end
  if jf_inited then
    UNI.cast(channel, cast_commit_event, event_params)
  end
end

function M.flush_cached_events()
  if next(cached_commit_events) ~= nil then
    E.LOG.debug(TAG, "has cache now commit cached events:" .. tostring(#cached_commit_events))
    for _, cached_data in ipairs(cached_commit_events) do
      if LUA_IMP[E.Sysinfo.os()] then
        JF_LUA.commit_event(cached_data)
      else
        UNI.cast(CHANNEL, CAST_COMMIT_EVENT, cached_data)
      end
    end
    cached_commit_events = {}
  end
end

function M.flush_high_level_events()
  E.LOG.debug(TAG, "flush_high_level_events received")
  local _os = E.Sysinfo.os()
  if "android" ~= _os and "ios" ~= _os then
    JF_LUA.flush_high_level_logs()
  end
end

M.enable_ldu = false

local function is_table_json_array_type(t)
  if type(t) ~= "table" then
    return false
  end
  local is_array = type(next(t)) == "number"
  return is_array
end

function M.get_trace_params()
  return M.get_trace_id(), E.system_clock() - init_time
end

function M.commit_event(event_name, params, options)
  if nil == params then
    params = {}
  end
  if type(params) == "table" then
    params.trace_id = M.get_trace_id()
    params.trace_uptime = E.system_clock() - init_time
  end
  params[M.OPTION_KEY.IS_UPLOAD_NOW] = options and options[M.OPTION_KEY.IS_UPLOAD_NOW]
  params[M.OPTION_KEY.IS_PRIORITY_HIGH] = options and options[M.OPTION_KEY.IS_PRIORITY_HIGH]
  local event_params = {
    event_name = event_name,
    params = params,
    opts = options
  }
  if jf_inited then
    M.flush_cached_events()
    E.LOG.debug(TAG, "commit_event event_name:" .. tostring(event_name))
    if LUA_IMP[E.Sysinfo.os()] then
      JF_LUA.commit_event(event_params)
    elseif E.Sysinfo.os() == "ios" then
      if tostring(params[M.OPTION_KEY.IS_UPLOAD_NOW]) == "true" then
        uni_cast(CHANNEL, CAST_UPLOAD_EVENT, event_params)
      else
        uni_cast(CHANNEL, CAST_COMMIT_EVENT, event_params)
      end
    elseif E.Sysinfo.os() == "android" then
      local current_jf_version_name = E.get_sdk_version_name(CHANNEL)
      if EU.version_compare(current_jf_version_name, "2.0.29") < 0 then
        _ejoysdk.log("android jf params array compact, jf_version less than 2.0.28 :" .. tostring(current_jf_version_name))
        for k, v in pairs(event_params.params) do
          local is_array = is_table_json_array_type(v)
          if is_array then
            event_params.params[k] = JSON.encode(v)
          end
        end
      end
      uni_cast(CHANNEL, CAST_COMMIT_EVENT, event_params)
    end
  else
    E.LOG.debug(TAG, "commit_event save to cache, event_name:" .. tostring(event_name))
    table.insert(cached_commit_events, event_params)
  end
end

local function update_data(params)
  if LUA_IMP[E.Sysinfo.os()] then
    JF_LUA.update_data(params)
  else
    uni_cast(CHANNEL, CAST_UPDATE_DATA, params)
  end
end

local function ejoysdk_config_changed_handler()
  local host = E.CONFIG.get_config("log-collector")
  E.LOG.debug(TAG, "ejoysdk_config_changed_handler entered, get host:" .. (host or "nil") .. ", last host:" .. (log_collector_host or "nil"))
  if host ~= log_collector_host then
    log_collector_host = host
    local jf_api_server = host .. "/log/gbi_log"
    local params = {api_server = jf_api_server}
    E.LOG.debug(TAG, "ejoysdk_config_changed_handler，update api_server of JF:" .. tostring(jf_api_server))
    update_data(params)
  end
end

local function get_black_event_arr(cloud_mode)
  local black_events = {}
  if cloud_mode then
    local CC = require("ejoysdk_lua.cloud_game.cloud_config")
    if cloud_mode == CC.CLOUD_MODE.CLOUD then
      E.LOG.debug(TAG, "get_black_event_arr, its cloud side, so it has black event array")
      black_events.type = "event_arr"
      black_events.data = {
        "sdk.role.online",
        "sdk.role.create",
        "sdk.role.level.up",
        "sdk.user.create",
        "sdk.user.online",
        "sdk.startup",
        "sdk.startup.success",
        "sdk.install",
        "sdk.startup.native",
        "sdk.list",
        "sdk.heartbeat"
      }
      return black_events
    end
  end
  E.LOG.debug(TAG, "no black commit events")
  return nil
end

local function init_jf_sdk(opt)
  if E.Sysinfo.os() == "android" then
    E.Sysinfo.is_simulator()
  end
  local ch = E.get_channel()
  local game_id = tostring(E.get_game_id())
  log_collector_host = E.CONFIG.get_config("log-collector")
  local jf_api_server = log_collector_host .. "/log/gbi_log"
  E.LOG.debug(TAG, "init_jf_sdk, jf_api_server:" .. tostring(jf_api_server))
  local has_cp_set_white_fields = type(opt.white_privacy_fields)
  if "table" == has_cp_set_white_fields then
    cp_white_privacy_fields = opt.white_privacy_fields
  else
    local is_overseas = E.CONFIG.get_config(E.CONFIG.KEY.MULTI_REGIONS_ENABLED)
    if not is_overseas then
      table.insert(cp_white_privacy_fields, "imei")
    end
  end
  local ds_channel_id, ds_sub_channel_id
  if E.Sysinfo.os() == "android" or E.Sysinfo.os() == "ios" then
    ds_channel_id = E.Sysinfo.ds_channel_id()
    ds_sub_channel_id = E.Sysinfo.ds_sub_channel_id()
  end
  local cloud_info = UIM.get_cloud_game_info()
  local cloud_mode = cloud_info[UIM.PKG_INFO_KEY.KEY_CLOUD_GAME_MODE]
  local cloud_run_mode = cloud_info[UIM.PKG_INFO_KEY.KEY_CLOUD_GAME_RUN_MODE]
  local CLOUDGAME_3RD = require("ejoysdk_lua.ejoysdk_cloudgame_3rd")
  if CLOUDGAME_3RD.is_cloudgame() then
    cloud_mode = E.get_pkg_info().cloud_game_mode
  end
  local black_events = get_black_event_arr(cloud_mode)
  local instant_mode = UIM.get_instant_mode() or "normal"
  E.LOG.debug(TAG, "instant mode >> " .. tostring(instant_mode))
  local predownload_game_mode = UIM.get_predownload_game_mode()
  if predownload_game_mode and predownload_game_mode[UIM.PKG_INFO_KEY.KEY_PREDOWNLOAD_GAME_RUN_MODE] then
    cloud_run_mode = predownload_game_mode[UIM.PKG_INFO_KEY.KEY_PREDOWNLOAD_GAME_RUN_MODE]
  end
  local install_referrer = E.Sysinfo.get_ejoy_referer() or "none"
  E.LOG.debug(TAG, "install referrer >> " .. tostring(install_referrer))
  local apk_build_seq = E.get_apk_build_seq()
  if not init_media_stats_vendors_occasion then
    local sdk_infos = UNI.get_sdk_infos()
    local jf_sdk_info = sdk_infos[CHANNEL] or {}
    local meta = jf_sdk_info.meta or {}
    init_media_stats_vendors_occasion = meta.media_stats_vendors_occasion or ""
  end
  local ptid = E.get_ptid()
  local security = require("ejoysdk_lua.vendors.security")
  local init_param = {
    white_privacy_fields = cp_white_privacy_fields,
    white_event_prefix_arr = {"ejoy.", "gamesec."},
    upload_internal_events_enable = false,
    api_server = jf_api_server,
    channel_id = ch,
    game_id = game_id,
    debuggable = opt.debug or false,
    ds_ch_id = ds_channel_id,
    ds_sub_ch_id = ds_sub_channel_id,
    debug = opt.debug or false,
    utdid = E.Sysinfo.utdid(),
    forbidden_keys = {"mac", "imei"},
    cloud_game_mode = cloud_mode,
    cloud_game_run_mode = cloud_run_mode,
    black_event_arr = black_events,
    instantMode = instant_mode,
    installReferrer = install_referrer,
    apk_build_seq = apk_build_seq,
    ptid = ptid,
    secInfo = security.ejoysdk_get_mw()
  }
  if LUA_IMP[E.Sysinfo.os()] then
    JF_LUA.init(init_param)
  else
    UNI.cast(CHANNEL, CAST_INIT_JF, init_param)
    E.LOG.debug(TAG, "is_support_priority_high(native): " .. tostring(is_support_priority_high()) .. ", ptid:" .. tostring(init_param.ptid))
    E.log(init_param)
  end
  ET.subscribe(ET.config.CONFIG_CHANGED, ejoysdk_config_changed_handler)
end

local function player_offline_handler()
  local params = {
    server_id = "",
    server_name = "",
    player_id = "",
    player_name = "",
    player_level = "",
    uid = uid or ""
  }
  E.LOG.debug(TAG, "player_offline_handler，update role data of JF")
  update_data(params)
end

local function set_player_info_handler_with_type(player_info, _type)
  local params = {
    server_id = player_info.server_id,
    server_name = player_info.server_name,
    player_id = player_info.player_id,
    player_name = player_info.player_name,
    player_level = player_info.player_level,
    uid = uid or ""
  }
  E.LOG.debug(TAG, "setPlayerInfo，update role data of JF")
  update_data(params)
end

local function set_player_info_handler(_player_info)
end

local function login_handler(user_info)
  uid = user_info.uid
  pid = user_info.pid
  platform = user_info.platform
  local params = {
    uid = uid,
    chuid = pid,
    chUserType = platform,
    server_id = "",
    server_name = "",
    player_id = "",
    player_name = "",
    player_level = ""
  }
  E.LOG.debug(TAG, "login，clear cached role data and update account data of JF")
  local CLOUDGAME_3RD = require("ejoysdk_lua.ejoysdk_cloudgame_3rd")
  local is_cloudgame = CLOUDGAME_3RD.is_cloudgame()
  if is_cloudgame then
    if user_info and user_info.pinfo and user_info.pinfo.ext and user_info.pinfo.ext.ch_openid then
      params.openId = user_info.pinfo.ext.ch_openid
    end
    local l_option = CLOUDGAME_3RD.get_cache_launch_option()
    if CLOUDGAME_3RD.get_cloudgame_type() == CLOUDGAME_3RD.CLOUDGAME_TYPE.DYMINICLOUDGAME then
      params.dyScene = l_option and l_option.scene or "0"
      if "" == params.dyScene then
        params.dyScene = "0"
      end
    elseif CLOUDGAME_3RD.get_cloudgame_type() == CLOUDGAME_3RD.CLOUDGAME_TYPE.WXMINICLOUDGAME then
      params.wxScene = l_option and l_option.scene or "0"
      if "" == params.wxScene then
        params.wxScene = "0"
      end
    end
    params.system = CLOUDGAME_3RD.get_device_system()
  end
  E.LOG.debug(TAG, "login，update account data of JF")
  E.LOG.debug(TAG, {params = params})
  update_data(params)
  if is_cloudgame then
    local ad_params = CLOUDGAME_3RD.get_third_ad_params()
    local c_params = {adParams = ad_params}
    M.commit_event(M.EVENT_NAMES.SDK_CLOUD_GAME_LOGIN, c_params, {
      [M.OPTION_KEY.IS_UPLOAD_NOW] = true,
      [M.OPTION_KEY.IS_PRIORITY_HIGH] = true
    })
  end
end

local function gangplank_logout_handler()
  uid = ""
  pid = ""
  platform = ""
  local params = {
    server_id = "",
    server_name = "",
    player_id = "",
    player_name = "",
    player_level = "",
    uid = "",
    chuid = "",
    chUserType = ""
  }
  E.LOG.debug(TAG, "logout，clear cached account and role data of JF")
  update_data(params)
end

local function gangplank_exit_handler()
  uid = ""
  pid = ""
  platform = ""
  local params = {
    server_id = "",
    server_name = "",
    player_id = "",
    player_name = "",
    player_level = "",
    uid = "",
    chuid = "",
    chUserType = ""
  }
  E.LOG.debug(TAG, "exit，clear cached account and role data of JF")
  update_data(params)
end

local function has_value(table, val)
  local tab = table or {}
  for _, value in ipairs(tab) do
    if value == val then
      return true
    end
  end
  return false
end

local STAT_PRE_ORDER_STATUS = E.LazyKeyStore:New("EJOY_STAT_PRE_ORDER_STATUS", false, false, false)

local function commit_pre_order_status()
  local post_status = "posted"
  local status = STAT_PRE_ORDER_STATUS:get()
  if status == post_status then
    E.LOG.debug(TAG, "pre-order#has been counted pre_order status")
    return
  else
    E.LOG.debug(TAG, "pre-order#getting pre-order status")
    E.get_pre_order_status(function(post_succ, data)
      data = data or {}
      local is_pre_order_user = data.isReserveUser
      if true == is_pre_order_user then
        E.LOG.debug(TAG, "pre-order# pre_order status not count yet, commit now")
        M.commit_event(M.EVENT_NAMES.SDK_START_UP_PRE_ORDER, data, {
          [M.OPTION_KEY.IS_UPLOAD_NOW] = true,
          [M.OPTION_KEY.IS_PRIORITY_HIGH] = true
        })
      end
      if true == post_succ then
        STAT_PRE_ORDER_STATUS:set(post_status)
        if false == is_pre_order_user then
          E.LOG.debug(TAG, "pre-order#not target pre-order user")
        end
      end
    end)
  end
end

local function gangplank_inited_handler(succ, ...)
  E.LOG.debug(TAG, "jinfen gangplank_inited_handler! " .. tostring(succ))
  local is_imei_in_white_field = has_value(cp_white_privacy_fields, "imei")
  local is_imei_in_white_field_result
  if is_imei_in_white_field then
    is_imei_in_white_field_result = "true"
  else
    is_imei_in_white_field_result = "false"
  end
  E.LOG.debug(TAG, "jinfen gangplank_inited_handler, is_imei_in_white_field: " .. tostring(is_imei_in_white_field_result))
  local params = {}
  local url_open_datas = E.get_url_open_datas()
  if url_open_datas and next(url_open_datas) ~= nil and nil ~= url_open_datas[1] then
    local link_data = url_open_datas[1]
    if link_data.url and type(link_data.url) == "string" and #link_data.url > 0 then
      params = {link_data = link_data}
    elseif link_data.data and link_data.data.url and "string" == type(link_data.data.url) and #link_data.data.url > 0 then
      link_data.url = link_data.data.url
      params = {link_data = link_data}
    end
  end
  local CLOUDGAME_3RD = require("ejoysdk_lua.ejoysdk_cloudgame_3rd")
  if CLOUDGAME_3RD.is_cloudgame() then
    params.adParams = CLOUDGAME_3RD.get_third_ad_params()
  end
  M.commit_event(M.EVENT_NAMES.SDK_START_UP_SUCCESS, params, {
    [M.OPTION_KEY.IS_UPLOAD_NOW] = true
  })
  if "sdk.startup.success" == init_media_stats_vendors_occasion then
    M.init_media_stats_vendors()
  end
  local is_overseas = E.CONFIG.get_config(E.CONFIG.KEY.MULTI_REGIONS_ENABLED)
  if _ejoysdk.os() == "android" and not is_overseas then
    E.LOG.debug(TAG, "安卓且是国内游戏包，则不需要走这个预约打点的业务流程，因为安卓的ejoysdk是直接区访问google的api的，国内无google插件，会有异常日志打印出来 >>>>")
  else
    commit_pre_order_status()
  end
end

local function update_jf_pkg_info(pkg_info_data)
  E.LOG.debug(TAG, "its pkg_info changed, now update jf data >>>>")
  E.LOG.debug(TAG, pkg_info_data)
  uni_cast(CHANNEL, CAST_UPDATE_DEVICE_INFO, pkg_info_data)
end

local function update_cloud_game_info(cloud_game_info)
  E.LOG.debug(TAG, "its cloud_game_info changed, now update jf data >>>>")
  E.LOG.debug(TAG, cloud_game_info)
  local params = {
    cloud_game_run_mode = cloud_game_info[UIM.PKG_INFO_KEY.KEY_CLOUD_GAME_RUN_MODE]
  }
  E.LOG.debug(TAG, "update_cloud_game_info, cloud_game_run_mode:" .. tostring(params.cloud_game_run_mode))
  update_data(params)
end

local function on_pkg_info_changed(data)
  E.LOG.debug(TAG, "on_pkg_info_changed >>")
  E.LOG.debug(TAG, data)
  if not data or next(data) == nil then
    E.LOG.warn(TAG, "on_pkg_info_changed data is nil")
    return
  end
  local data_type = data[UIM.TOPIC_DATA_KEY.KEY_DATA_TYPE]
  if data_type == UIM.INFO_KEY.KEY_PKG_INFO then
    E.LOG.debug(TAG, "receive pkg info changed")
    local pkg_info_data = data[UIM.TOPIC_DATA_KEY.KEY_DATA]
    update_jf_pkg_info(pkg_info_data)
  elseif data_type == UIM.INFO_KEY.KEY_CLOUD_GAME_INFO then
    E.LOG.debug(TAG, "receive cloud game info changed:" .. tostring(data_type))
    local cloud_game_info = data[UIM.TOPIC_DATA_KEY.KEY_DATA]
    update_cloud_game_info(cloud_game_info)
  end
end

local function on_runmode_info_changes(runmode_info)
  runmode_info = runmode_info or {}
  E.log("on_runmode_info_changes received")
  E.log(runmode_info)
  local run_info = runmode_info[UIM.TOPIC_DATA_KEY.KEY_DATA] or {}
  local run_mode = run_info[UIM.PKG_INFO_KEY.KEY_PREDOWNLOAD_GAME_RUN_MODE]
  local params = {cloud_game_run_mode = run_mode}
  update_data(params)
end

function M.init_media_stats_vendors()
  if media_stats_inited then
    return
  end
  media_stats_inited = true
  E.LOG.debug(TAG, "init_media_stats_vendors begin")
  local ev = require("ejoysdk_lua.ejoysdk_vendors")
  local stats_vendors = ev.get_vendors(Vendor.ABILITY.STATS)
  local stats_vendors_set = {}
  for _, stats_vendor in ipairs(stats_vendors) do
    if stats_vendor ~= CHANNEL then
      stats_vendors_set[stats_vendor] = true
    end
  end
  local sdk_infos = UNI.get_sdk_infos()
  if sdk_infos.APPLOG then
    local applog = require("ejoysdk_lua.vendors.applog")
    stats_vendors_set[applog.VENDOR_NAME] = true
    _ejoysdk.log("init_media_stats_vendors has applog true")
  end
  E.log(stats_vendors_set)
  if next(stats_vendors_set) then
    for vendor_name, _ in pairs(stats_vendors_set) do
      local vendor = ev.get(vendor_name)
      if vendor and vendor.init then
        _ejoysdk.log("init_media_stats_vendors init begin name:" .. tostring(vendor_name))
        local sdk_info = sdk_infos[vendor_name] or {}
        local opts = sdk_info.meta or {}
        E.log(opts)
        vendor.init(opts, function()
          _ejoysdk.log("init_media_stats_vendors init finish name:" .. tostring(vendor_name))
        end)
      end
    end
  else
    _ejoysdk.log("init_media_stats_vendors no stats vendors, skip init")
  end
end

local function send_startup_event()
  local EGC = require("ejoysdk_lua.ejoysdk_gangplank_config")
  local security = require("ejoysdk_lua.vendors.security")
  EU.func_retry_with_times(EGC.check_init_cdn_config, function(succ, code, msg)
    _ejoysdk.log("send_startup_event check_init_cdn_config result:" .. tostring(succ) .. ", code:" .. tostring(code) .. ", msg:" .. tostring(msg) .. ", init_media_stats_vendors_occasion:" .. tostring(init_media_stats_vendors_occasion))
    local startup_params = {}
    if _ejoysdk.os() == "harmonyos" then
      M.commit_event_with_security_for_harmony(M.EVENT_NAMES.SDK_START_UP, startup_params, {is_upload_now = true})
    else
      startup_params.secInfo = security.ejoysdk_get_mw()
      M.commit_event(M.EVENT_NAMES.SDK_START_UP, startup_params)
    end
    if nil == init_media_stats_vendors_occasion or "" == init_media_stats_vendors_occasion or "sdk.startup" == init_media_stats_vendors_occasion then
      M.init_media_stats_vendors()
    end
  end)
end

function M.init(opt, cb)
  E.LOG.debug(TAG, "jinfen stat start init!")
  init_jf_sdk(opt)
  local user_pkg_info = UIM.get_user_pkg_info()
  if user_pkg_info then
    update_jf_pkg_info(user_pkg_info)
  end
  if not has_stat_oaid_received_event then
    E.Sysinfo.oaid_async(function(_oaid)
      E.LOG.debug(TAG, "jf oaid_async received:" .. tostring(_oaid))
      if _oaid then
        has_stat_oaid_received_event = true
        M.commit_event(M.EVENT_NAMES.SDK_STARTUP_OAID_RECEIVED, {}, {is_upload_now = true})
      end
    end)
  end
  if jf_inited then
    cb(true)
    return
  end
  jf_inited = true
  send_startup_event()
  ET.subscribe(ET.gangplank.LOGIN, login_handler)
  ET.subscribe(ET.gangplank.LOGOUT, gangplank_logout_handler)
  ET.subscribe(ET.gangplank.EXIT, gangplank_exit_handler)
  ET.subscribe(ET.gangplank.INITED, gangplank_inited_handler)
  ET.subscribe(ET.gangplank.SET_PLAYER_INFO_WITH_TYPE, set_player_info_handler_with_type)
  ET.subscribe(ET.gangplank.PLAYER_OFFLINE, player_offline_handler)
  ET.subscribe(ET.gangplank.SET_PLAYER_INFO, set_player_info_handler)
  ET.subscribe(UIM.TOPIC.TOPIC_INFO_CHANGES, on_pkg_info_changed)
  ET.subscribe(UIM.TOPIC.TOPIC_MOBILE_RUN_MODE_CHANGES, on_runmode_info_changes)
  cb(true)
end

function M.get_trace_id()
  trace_id = E.get_pkg_info().sdk_trace_id
  E.LOG.debug(TAG, "get_trace_id use trace_id:" .. tostring(trace_id))
  return trace_id
end

function M.disable_pc_media_event()
  JF_LUA.disable_media_event()
end

M:is_implemented({
  Vendor.ABILITY.STATS
})

function M.commit_event_with_security_for_harmony(event_name, params, options)
  local security = require("ejoysdk_lua.vendors.security")
  local SECURITY_MW_TIMEOUT = 0.2
  local has_result = false
  E.Timer.once(SECURITY_MW_TIMEOUT, function()
    if not has_result then
      has_result = true
      E.LOG.debug("JF", "security.get_mw_async timeout for event, commit event without secInfo")
      M.commit_event(event_name, params, options)
    end
  end)
  security.get_mw_async(function(_, result)
    if not has_result then
      has_result = true
      params.secInfo = result
      M.secInfoCache = result
      M.commit_event(event_name, params, options)
    end
  end)
end

return M
