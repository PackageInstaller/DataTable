local E = require("ejoysdk_lua.ejoysdk")
local ET = require("ejoysdk_lua.ejoysdk_topic")
local EM = require("ejoysdk_lua.ejoysdk_module")
local M = {}
local TAG = EM.MODULE.CLOUD_GAME .. "cloud_config"
M.REMOTE_URLS = ""
M.SaveAssetDir = nil
M.ProductId = nil
M.ProductIdAppleReview = nil
M.FinishDownloadContinuePlayTime = 30
M.CloudGamePlayTimeLimit = 120
M.HttpJobCnt = 8
M.DEFAULT_MIN_DOWN_SPEED = 200
M.DEFAULT_MAX_DOWN_SPEED = 128000
M.HttpKpsLimit = 900
M.HttpIntervalLimit = 0.2
M.DownloadSizeFix = 0.8
M.ShowProgressByPercent = 50
M.READ_BUFFER_SIZE_BYTES = 4096
M.is_limit_speed_for_wifi = true
local DEFAULT_UPDATE_WITH_CONNECT_LIMIT = 524288000
M.UPDATING_WITH_CONNECT_LIMIT = DEFAULT_UPDATE_WITH_CONNECT_LIMIT
M.ShowDownloadCompleteTipsPercent = 95
M.LaunchInstalledPkgTipInterval = 900
M.ShowInstallPkgFloaterDelay = 600
M.ShowInstallPkgFloaterInterval = 1800
M.RemainTimeTemplete = "剩余时长：${remainTimeTick}。（每天重置10小时）"
M.CLOUD_TOPIC = {
  TOPIC_LUA_CLOSED = "cloud_game_topic_lua_closed",
  TOPIC_ACTIVITY_STATE_CHANGED = "cloud_game_activity_state_changed",
  TOPIC_ACTIVITY_STATE_CHANGED_INNER = "cloud_game_activity_state_changed_inner",
  TOPIC_DOWNLOAD_STATE_CHANGED = "cloud_game_download_state_changed",
  TOPIC_LIMIT_STATE_CHANGE = "cloud_game_limit_state_changed"
}
M.DOWNLOAD_LIMIT_CONTROL_STATE = {STATE_DEFAULT = 0, STATE_NO_LIMIT = 1}
M.ACTIVITY_STATE = {ON_START = "onStart", ON_STOP = "onStop"}

local function is_limit_for_current_net_type()
  local net_type_name = E.Sysinfo.network_type_name()
  local limit_result
  if "wifi" == net_type_name and not M.is_limit_speed_for_wifi then
    limit_result = false
  else
    limit_result = true
  end
  E.LOG.debug(TAG, "is_limit_for_current_net_type net_type_name:" .. tostring(net_type_name) .. ", limit_result:" .. tostring(limit_result))
  return limit_result
end

function M.get_http_kps_limit()
  local speed
  if M.force_http_kps then
    speed = M.force_http_kps
  elseif M.server_config_http_kps_limit and is_limit_for_current_net_type() then
    speed = M.server_config_http_kps_limit
  else
    speed = M.HttpKpsLimit
  end
  E.LOG.debug(TAG, "[download]get_http_kps_limit:" .. tostring(speed))
  return speed
end

function M.force_http_kps_limit(kps)
  E.LOG.debug(TAG, "[download]force_http_kps_limit " .. tostring(kps))
  M.force_http_kps = kps
  if -1 == kps then
    ET.publish(M.CLOUD_TOPIC.TOPIC_LIMIT_STATE_CHANGE, M.DOWNLOAD_LIMIT_CONTROL_STATE.STATE_NO_LIMIT)
  else
    ET.publish(M.CLOUD_TOPIC.TOPIC_LIMIT_STATE_CHANGE, M.DOWNLOAD_LIMIT_CONTROL_STATE.STATE_DEFAULT)
  end
end

function M.update_default_http_kps_limit(kps)
  E.LOG.debug(TAG, "[download]update_default_http_kps_limit:" .. tostring(kps))
  M.server_config_http_kps_limit = kps
end

function M.update_limit_for_wifi(is_limit_for_wifi)
  E.LOG.debug(TAG, "[download]update_limit_for_wifi:" .. tostring(is_limit_for_wifi))
  M.is_limit_speed_for_wifi = is_limit_for_wifi
end

M.CLOUD_MODE = {
  CLOUD = "cloud",
  MOBILE = "mobile",
  UNKNOWN = "unknown"
}
M.CLOUD_ENV = {
  TEST = "test",
  PRODUCT = "product",
  PRE_RELEASE = "pre_release"
}
M.CloudGameMode = M.CLOUD_MODE.MOBILE
M.CloudGameId = 0
M.CloudGameIdAppleReview = 0
M.IsLuaHardening = false
M.CloudEnv = M.CLOUD_ENV.PRODUCT
M.ODRConfig = nil
M.DOWNLOAD_DISABLE = false
M.DEBUG_OPTIONS = {
  TestCloudServerIP = nil,
  TestCloudServerPort = nil,
  cloudStartWithIpEnabled = true,
  TestRunCloudSingle = false,
  Debug = false,
  TestAlwayStartCloud = false,
  TestDisableDownload = false,
  TestEnableLuaProfile = false,
  TestNoStorageFile = "_test_no_storage.flg",
  TestMobileNetworkFile = "_test_mobile.flg",
  TestCloudStartErrorFile = "_test_cloud_start.flg",
  TestCloudCGErrorFile = "_test_cloud_cg.flg",
  TestCloudTimeLimit = nil,
  TestConnectFailed = false,
  TestConnectRequestTimeFailed = false,
  TestConnectTimeEnd = false,
  TestConnectedDelayTimeEnd = false,
  TestCountDownStopSmall = false,
  TestCountDownStopBig = false,
  TestTimeLimitComing = false,
  TestConnectedRecvFailed = false,
  TestDownloadFinish = false,
  TestInitDownloadFinish = false,
  TestInitDownloading = false,
  TestDownloadProgressSync = false,
  TestDownloadFinishForceToLocal = false,
  TestDownloadCompleteAutoSwith = false,
  TestUpdating = false,
  TestSendMessageFailed = false
}
M.CONFIG_KEYS = {
  CLOUD_GAME_MODE = "cloud_game_mode",
  CLOUD_GAME_ID = "cloud_game_id",
  CLOUD_GAME_ID_APPLE_REVIEW = "cloud_game_id_apple",
  IS_LUA_HARDENING = "is_lua_hardening",
  CLOUD_ENV = "cloud_env",
  CLOUD_DEBUGGABLE = "debuggable",
  GAME_RES_URLS = "game_res_urls",
  GAME_RES_SAVE_PATH = "game_res_save_path",
  GAME_RES_PATH_TYPE = "game_res_path_type",
  GAME_PRODUCT_ID = "game_product_id",
  GAME_PRODUCT_ID_APPLE = "game_product_id_apple",
  DIRECT_CONNECT_IP = "direct_connect_ip",
  DIRECT_CONNECT_PORT = "direct_connect_port",
  DEBUG_OPTIONS = "debug_options",
  ODR_CONFIG = "odr_config",
  PAAS_PLATFORM = "paas_platform",
  DOWNLOAD_DISABLE = "download_disable",
  SELF_START = "self_start",
  RESOURCE_TYPE = "resource_type",
  INSTALL_PKG_NAME = "install_pkg_name",
  APPSTORE_APP_SCHEME = "appstore_app_scheme",
  APPSTORE_APP_ID = "appstore_app_id",
  LAUNCHER_START_CONFIG = "launcher_start"
}
M.RES_PATH_TYPE = {INTERNAL = "internal", EXTERNAL = "external"}
M.ODR_TYPES = {
  INSTALL_TIME = "install_time",
  FAST_FOLLOW = "fast_follow",
  ON_DEMAND = "on_demand"
}
M.ODR_TAG_CONFIG_KEYS = {NAME = "name", SIZE = "size"}
M.PAAS_PLATFORM = {TTG = "ttg", ALIYUN = "aliyun"}
M.RESOURCE_TYPE = {
  GAME_RES = "game_res",
  ODR = "odr",
  PACKAGE = "package"
}
M.PaasPlatform = M.PAAS_PLATFORM.ALIYUN
M.DisableDownload = false
M.SelfStart = false
M.SelfStartInit = false
M.ResourceType = M.RESOURCE_TYPE.GAME_RES
M.InstallPkgName = nil
M.AppStoreAppID = nil
M.AppStoreScheme = nil
M.DEBUG_OPTIONS_VALUE = {
  ALAWAYS_CLOUD = "ALAWAYS_CLOUD",
  CHECK_NO_STORAGE = "CHECK_NO_STORAGE",
  ALWAYS_MOBILE_NETWORK = "ALWAYS_MOBILE_NETWORK",
  RUN_CLOUD_SINGLE = "RUN_CLOUD_SINGLE",
  DISABLE_DOWNLOAD = "DISABLE_DOWNLOAD",
  ENABLE_LUA_PROFILE = "ENABLE_LUA_PROFILE"
}
local CLOUD_VENDOR_NAME = "CLOUD_GAME"
local cloud_sdk_meta_config
local META_KEY = {
  CLOUD_GAME_MODE = "cloud_game_mode",
  CLOUD_ENV = "cloud_env"
}
local is_ab_test_switch_checked = false
local ab_test_switch_status = false
local config_abtest_enable, ab_flag, cloud_model_name
local is_show_splash_btn = true
local is_download_progress_notification_enable = true

function M.fix_url(path)
  if string.sub(path, -1) ~= "/" then
    path = path .. "/"
  end
  return path
end

function M.get_cloud_meta_config()
  if cloud_sdk_meta_config and next(cloud_sdk_meta_config) ~= nil then
    return cloud_sdk_meta_config
  end
  local _UNI = require("ejoysdk_lua.vendors.unisdk")
  local cloud_game_meta
  local sdk_infos = E.get_meta_config("sdks")
  for _, sdk_info in ipairs(sdk_infos) do
    local abilities = sdk_info.ability
    if abilities then
      for _, ab in ipairs(abilities) do
        if ab == CLOUD_VENDOR_NAME then
          cloud_game_meta = sdk_info.meta
          break
        end
      end
    end
    local config_vendor_name = sdk_info.name
    if config_vendor_name == CLOUD_VENDOR_NAME then
      E.LOG.debug(TAG, "find cloud_game vendor name, return this meta")
      cloud_game_meta = sdk_info.meta
      break
    end
  end
  cloud_sdk_meta_config = cloud_game_meta or {}
  return cloud_sdk_meta_config
end

function M.get_cloud_mode()
  local meta_config = M.get_cloud_meta_config()
  meta_config = meta_config or {}
  local mode = meta_config[META_KEY.CLOUD_GAME_MODE]
  return mode
end

function M.get_cloud_mode_name()
  if cloud_model_name then
    return cloud_model_name
  end
  local mode = M.get_cloud_mode()
  if mode then
    if "cloud" == mode then
      cloud_model_name = M.CLOUD_MODE.CLOUD
    else
      cloud_model_name = M.CLOUD_MODE.MOBILE
    end
  else
    cloud_model_name = M.CLOUD_MODE.UNKNOWN
  end
  E.LOG.debug(TAG, "get_cloud_mode in adapter, mode:" .. tostring(cloud_model_name))
  return cloud_model_name
end

function M.init_config(sdk_meta_configs)
  E.LOG.debug(TAG, "init_config begin >>")
  if not sdk_meta_configs or next(sdk_meta_configs) == nil then
    E.LOG.debug(TAG, "init_config failed, config obj is nil, try get from local config")
    sdk_meta_configs = M.get_cloud_meta_config()
    if not sdk_meta_configs then
      E.LOG.debug(TAG, "init_config failed, config obj is nil, return")
      return
    end
  end
  cloud_sdk_meta_config = sdk_meta_configs
  E.LOG.debug(TAG, sdk_meta_configs)
  local start_with = E.Utils.start_with
  M.CloudGameMode = sdk_meta_configs[M.CONFIG_KEYS.CLOUD_GAME_MODE] or M.CLOUD_MODE.MOBILE
  if M.CloudGameMode == M.CLOUD_MODE.MOBILE then
    E.LOG.debug(TAG, "init_config in mobile mode")
    M.CloudEnv = sdk_meta_configs[M.CONFIG_KEYS.CLOUD_ENV] or M.CLOUD_ENV.PRODUCT
    M.CloudGameId = sdk_meta_configs[M.CONFIG_KEYS.CLOUD_GAME_ID] or 0
    M.CloudGameIdAppleReview = sdk_meta_configs[M.CONFIG_KEYS.CLOUD_GAME_ID_APPLE_REVIEW] or 0
    M.ProductId = sdk_meta_configs[M.CONFIG_KEYS.GAME_PRODUCT_ID] or nil
    M.ProductIdAppleReview = sdk_meta_configs[M.CONFIG_KEYS.GAME_PRODUCT_ID_APPLE] or nil
    E.CONFIG.autoconfig("", M.ProductId)
    local luaHardeningStr = sdk_meta_configs[M.CONFIG_KEYS.IS_LUA_HARDENING] or "false"
    M.IsLuaHardening = "true" == luaHardeningStr
    local save_data_relative_path = sdk_meta_configs[M.CONFIG_KEYS.GAME_RES_SAVE_PATH] or ""
    local save_data_path_type = sdk_meta_configs[M.CONFIG_KEYS.GAME_RES_PATH_TYPE] or M.RES_PATH_TYPE.INTERNAL
    local start_with_path = start_with(save_data_relative_path, "/")
    if not start_with_path then
      save_data_relative_path = "/" .. save_data_relative_path
    end
    local res_facade = require("ejoysdk_lua.res.ejoysdk_res_facade")
    if save_data_path_type == M.RES_PATH_TYPE.EXTERNAL then
      local external_path = res_facade.get_storage_path_by_type(res_facade.STORAGE_TYPE.EXTERNAL_APP_PRIVATE)
      M.SaveAssetDir = external_path .. save_data_relative_path
    else
      local internal_path = res_facade.get_storage_path_by_type(res_facade.STORAGE_TYPE.INTERNAL_APP_PRIVATE)
      M.SaveAssetDir = internal_path .. save_data_relative_path
    end
    M.SaveAssetDir = M.fix_url(M.SaveAssetDir)
    E.LOG.debug(TAG, "SaveAssetDir " .. M.SaveAssetDir)
    M.PaasPlatform = sdk_meta_configs[M.CONFIG_KEYS.PAAS_PLATFORM]
    M.DisableDownload = sdk_meta_configs[M.CONFIG_KEYS.DOWNLOAD_DISABLE] or false
    if nil ~= sdk_meta_configs[M.CONFIG_KEYS.LAUNCHER_START_CONFIG] then
      M.SelfStart = sdk_meta_configs[M.CONFIG_KEYS.LAUNCHER_START_CONFIG]
    else
      M.SelfStart = sdk_meta_configs[M.CONFIG_KEYS.SELF_START] or false
    end
    M.SelfStartInit = true
    E.LOG.debug(TAG, "paas platform is " .. tostring(M.PaasPlatform))
    M.ResourceType = sdk_meta_configs[M.CONFIG_KEYS.RESOURCE_TYPE] or M.RESOURCE_TYPE.GAME_RES
    M.InstallPkgName = sdk_meta_configs[M.CONFIG_KEYS.INSTALL_PKG_NAME]
    M.AppStoreAppID = sdk_meta_configs[M.CONFIG_KEYS.APPSTORE_APP_ID]
    M.AppStoreScheme = sdk_meta_configs[M.CONFIG_KEYS.APPSTORE_APP_SCHEME]
    M.DEBUG_OPTIONS.Debug = sdk_meta_configs[M.CONFIG_KEYS.CLOUD_DEBUGGABLE] or false
    if M.DEBUG_OPTIONS.Debug then
      E.LOG.debug(TAG, "init_config is debug mode")
      M.DEBUG_OPTIONS.TestCloudServerIP = sdk_meta_configs[M.CONFIG_KEYS.DIRECT_CONNECT_IP] or nil
      M.DEBUG_OPTIONS.TestCloudServerPort = sdk_meta_configs[M.CONFIG_KEYS.DIRECT_CONNECT_PORT] or 0
      if M.DEBUG_OPTIONS.TestCloudServerIP and "" ~= M.DEBUG_OPTIONS.TestCloudServerIP and M.DEBUG_OPTIONS.TestCloudServerPort > 0 then
        E.LOG.debug(TAG, "init_config with directIP enabled, ip:" .. tostring(M.DEBUG_OPTIONS.TestCloudServerIP) .. ", port:" .. tostring(M.DEBUG_OPTIONS.TestCloudServerPort))
        M.DEBUG_OPTIONS.cloudStartWithIpEnabled = true
      else
        E.LOG.debug(TAG, "init_config with directIP disabled!")
        M.DEBUG_OPTIONS.cloudStartWithIpEnabled = false
      end
      local debug_options = sdk_meta_configs[M.CONFIG_KEYS.DEBUG_OPTIONS] or {}
      E.LOG.debug(TAG, "debug options >>")
      E.LOG.debug(TAG, debug_options)
      if debug_options and next(debug_options) ~= nil then
        for _, opt in ipairs(debug_options) do
          if opt == M.DEBUG_OPTIONS_VALUE.ALAWAYS_CLOUD then
            M.DEBUG_OPTIONS.TestAlwayStartCloud = true
          elseif opt == M.DEBUG_OPTIONS_VALUE.DISABLE_DOWNLOAD then
            E.LOG.debug(TAG, "set config disable download")
            M.DEBUG_OPTIONS.TestDisableDownload = true
          elseif opt == M.DEBUG_OPTIONS_VALUE.ENABLE_LUA_PROFILE then
            E.LOG.debug(TAG, "enabled lua profile")
            M.DEBUG_OPTIONS.TestEnableLuaProfile = true
          end
        end
      end
    else
      E.LOG.debug(TAG, "init_config is release mode")
    end
  else
    E.LOG.debug(TAG, "init_config in cloud mode")
    M.DEBUG_OPTIONS.Debug = sdk_meta_configs[M.CONFIG_KEYS.CLOUD_DEBUGGABLE] or false
    E.LOG.debug(TAG, "sdk_meta_configs >>")
    E.LOG.debug(TAG, sdk_meta_configs)
    if M.DEBUG_OPTIONS.Debug then
      E.LOG.debug(TAG, "init_config is debug mode")
      local debug_options = sdk_meta_configs[M.CONFIG_KEYS.DEBUG_OPTIONS] or {}
      E.LOG.debug(TAG, "debug options >>")
      E.LOG.debug(TAG, debug_options)
      if debug_options and next(debug_options) ~= nil then
        for _, opt in ipairs(debug_options) do
          if opt == M.DEBUG_OPTIONS_VALUE.RUN_CLOUD_SINGLE then
            M.DEBUG_OPTIONS.TestRunCloudSingle = true
            E.LOG.debug(TAG, "enable TestRunCloudSingle")
          end
        end
      end
    else
      E.LOG.debug(TAG, "init_config is release mode")
    end
  end
  if M.DEBUG_OPTIONS.Debug then
    local ELOG = require("ejoysdk_lua.ejoysdk_log")
    local ej_debugable = E.get_ej_debugable()
    _ejoysdk.log("=======>ej_debugable:" .. tostring(ej_debugable))
    ELOG.setup_ej_debugable(ej_debugable)
    if ej_debugable then
      E.open_log(ej_debugable)
    end
  end
  M.ODRConfig = sdk_meta_configs[M.CONFIG_KEYS.ODR_CONFIG]
  E.LOG.debug(TAG, "print odr config from lua!")
  E.LOG.debug(TAG, M.ODRConfig)
end

function M.is_self_start()
  if M.SelfStartInit then
    return M.SelfStart
  end
  local cloud_meta = M.get_cloud_meta_config()
  M.SelfStart = cloud_meta.self_start
  M.SelfStartInit = true
  return M.SelfStart
end

function M.update_ab_test_flag(_ab_flag)
  E.LOG.debug(TAG, "update_ab_test_flag: " .. tostring(_ab_flag))
  ab_flag = _ab_flag
end

function M.get_ab_flag()
  return ab_flag
end

function M.is_ab_test_switch_on()
  if is_ab_test_switch_checked then
    return ab_test_switch_status
  end
  if nil ~= config_abtest_enable then
    if false == config_abtest_enable then
      E.LOG.debug(TAG, "is_ab_test_switch_on ab test switch from server is false, now return false")
      return false
    end
    local utdid = E.get_pkg_info().utdid
    local key = _ejoysdk_crypt.hashkey(tostring(utdid))
    local hex_val = _ejoysdk_crypt.hexencode(key)
    local last_character = string.sub(hex_val, -1)
    local last_number = tonumber(last_character, 16)
    ab_test_switch_status = last_number > 0 and last_number < 9
    is_ab_test_switch_checked = true
    E.LOG.debug(TAG, "is_ab_test_switch_on, utdid:" .. tostring(utdid) .. ", hex:" .. hex_val .. ", last_character:" .. tostring(last_character) .. ", last_number:" .. tostring(last_number) .. ", isDisable:" .. tostring(ab_test_switch_status) .. ", configAB enable:" .. tostring(config_abtest_enable))
    return ab_test_switch_status
  else
    E.LOG.debug(TAG, "is_ab_test_switch_on server config not received, now default return false")
    return false
  end
end

function M.set_remote_urls(remote_url)
  if nil == remote_url or "" == remote_url then
    E.LOG.error(TAG, "[set_remote_url] the url is nil!")
  else
    E.LOG.debug(TAG, "[set_remote_url] the assets url is : " .. tostring(remote_url))
    M.REMOTE_URLS = remote_url
  end
end

function M.update_updating_connect_size_limit(updating_limit_size)
  if updating_limit_size > 0 then
    M.UPDATING_WITH_CONNECT_LIMIT = updating_limit_size
  else
    M.UPDATING_WITH_CONNECT_LIMIT = DEFAULT_UPDATE_WITH_CONNECT_LIMIT
  end
  E.LOG.debug(TAG, "update_updating_connect_size_limit result:" .. tostring(M.UPDATING_WITH_CONNECT_LIMIT))
end

function M.set_is_splash_btn(is_show)
  E.LOG.debug(TAG, "set is splash btn >> " .. tostring(is_show))
  is_show_splash_btn = is_show
end

function M.set_continue_play_time(time)
  E.LOG.debug(TAG, "set download finish continue play time  >> " .. tostring(time))
  if time and time > 0 then
    M.FinishDownloadContinuePlayTime = time
  end
end

function M.update_remain_time_templete(templete)
  E.LOG.debug(TAG, "update remain time templete  >> " .. tostring(templete))
  if templete and #templete > 0 then
    M.RemainTimeTemplete = templete
  end
end

function M.get_is_splash_btn()
  return is_show_splash_btn
end

function M.set_download_progress_notification_enabled(is_enable)
  E.LOG.debug(TAG, "set_download_progress_enabled:" .. tostring(is_enable))
  is_download_progress_notification_enable = is_enable
end

function M.is_download_progress_notification_enable()
  return is_download_progress_notification_enable
end

function M.disable_download()
  E.LOG.debug(TAG, "disable download")
  M.DEBUG_OPTIONS.TestDisableDownload = true
end

return M
