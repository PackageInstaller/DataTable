local E = require("ejoysdk_lua.ejoysdk")
local ET = require("ejoysdk_lua.ejoysdk_topic")
local Utils = require("ejoysdk_lua.apm-sdk-lua.common.utils")
local Ver = require("ejoysdk_lua.apm-sdk-lua.version")
local Cfg = require("ejoysdk_lua.apm-sdk-lua.config.configurator")
local Time = require("ejoysdk_lua.apm-sdk-lua.common.time.init")
local apm_stats = require("ejoysdk_lua.apm-sdk-lua.stats.apm_stats")
local JSON = require("ejoysdk_lua.apm-sdk-lua.common.json_utils")
local NETWORK_NAME = {
  [0] = "default",
  [1] = "unknown",
  [2] = "wifi",
  [3] = "2G",
  [4] = "3G",
  [5] = "4G",
  [6] = "5G"
}
local LOGGER = "apm_label"
local M = {}
M.__index = M
M.get_token_failure = apm_stats:new_counter("failure_get_token", true)
local resource = {}
local attribute_funcs = {}
local built_in_label_keys = {
  "os",
  "os_ver",
  "device",
  "app_name",
  "app_ver",
  "ejoysdk_ver",
  "apmsdk_ver",
  "game_ver",
  "ej_lua_ver",
  "aligames_ver",
  "network",
  "device_id_type",
  "device_id",
  "oaid",
  "utdid",
  "game_id",
  "channel_id",
  "sub_channel_id",
  "country",
  "env",
  "is_login",
  "collect_interval",
  "cpu_model",
  "uid",
  "game_server",
  "session_id",
  "cpu_score",
  "gpu_score",
  "scene",
  "pos_x",
  "pos_y",
  "pos_z",
  "res",
  "is_simulator",
  "lang_script",
  "publish_area",
  "airline",
  "time_zone",
  "language",
  "game_lang",
  "storage_size",
  "umid_token",
  "uuid",
  "hw_machine",
  "ch_sub_ch",
  "cloud_game_mode",
  "cloud_game_runmode"
}
local _namespace

function M.set_namespace(namespace)
  if type(namespace) == "string" and Utils.is_metric_name_valid(namespace) then
    if #namespace >= 6 then
      namespace = string.sub(namespace, 1, 6)
    end
    _namespace = namespace
  end
end

local function hit_built_in_label_keys(key)
  for _, built_in_key in ipairs(built_in_label_keys) do
    if built_in_key == key then
      return true
    end
  end
  return false
end

local function refresh_token()
  local ingester_server = Cfg.get_ingester_server() or ""
  if "" == ingester_server then
    E.LOG.error(LOGGER, "cannot get ingester_server from conf")
    return
  end
  local url = ingester_server .. "/v1/token"
  local app_name = M.get_resource("app_name") or ""
  local utdid = M.get_resource("utdid") or ""
  if "" == app_name or "" == utdid then
    E.LOG.error(LOGGER, "app_name or utdid is empty, unexpected! ")
    return
  end
  local timeout = Cfg.get_http_post_timeout() or 10
  local abnormal_refresh_interval = Cfg.get_abnormal_refresh_token_interval() or 60
  
  local function cb(resp)
    if not resp then
      M.get_token_failure:inc()
      return
    end
    local status = tostring(resp.status)
    local resp_body = tostring(resp.body)
    E.LOG.debug(LOGGER, " get_token status=" .. status .. " body:" .. resp_body)
    if resp.status ~= 200 then
      E.LOG.error(LOGGER, "get_token err " .. ",status:" .. status .. " body:" .. resp_body)
      M.get_token_failure:inc()
      resource.token = nil
      if resp.status ~= 400 then
        E.LOG.debug(LOGGER, " retry refresh_token ...")
        E.Timer.once(abnormal_refresh_interval, refresh_token)
      end
      return
    end
    resource.token = resp_body
  end
  
  local data = string.format("{\"app_name\":\"%s\",\"utdid\":\"%s\"}", app_name, utdid)
  E.HTTP.post(url, {timeout = timeout}, E.HTTP.CT_JSON, data, cb)
end

local function loop_refresh_token()
  local normal_refresh_interval = Cfg.get_normal_refresh_token_interval() or 21600
  E.Timer.once(normal_refresh_interval, loop_refresh_token)
  E.LOG.debug(LOGGER, "loop_refresh_token ...")
  refresh_token()
end

local function get_channel_id()
  local channel_id = E.get_channel()
  if type(channel_id) == "string" and "" ~= channel_id then
    return channel_id
  end
  channel_id = E.Sysinfo.ds_channel_id() or ""
  return channel_id
end

function M.init()
  local env_info = E.get_env_info()
  local pkg_info = E.get_pkg_info()
  local versions = pkg_info.versions
  local tmp_resource = {
    os = E.Sysinfo.os() or "",
    os_ver = E.Sysinfo.os_version() or "",
    device = E.Sysinfo.brand() .. " " .. E.Sysinfo.model(),
    app_name = E.Sysinfo.app_name() or "",
    app_ver = E.Sysinfo.app_version_name() or "",
    ejoysdk_ver = E.get_sdk_version_name("EJOYSDK") or "",
    apmsdk_ver = Ver.VERSION,
    game_ver = versions and versions.game_version or "",
    ej_lua_ver = versions and versions.lua_version or "",
    aligames_ver = versions and versions.aligames_version or "",
    network = NETWORK_NAME[E.Sysinfo.network_current_state()] or "",
    device_id = env_info.devInfo.deviceId or "",
    utdid = E.Sysinfo.utdid() or "",
    game_id = E.get_game_id() or "",
    channel_id = get_channel_id(),
    sub_channel_id = env_info.chInfo.subCh,
    country = E.Sysinfo.country(),
    env = E.CONFIG.get_config("product"),
    is_login = "0",
    collect_interval = Cfg.get(Cfg.CATEGORY_STATS, "collect_interval", 60),
    pkg_name = E.Sysinfo.package_name() or "",
    res = env_info.devInfo.res or "",
    is_simulator = env_info.devInfo.isSimulator,
    device_id_type = env_info.devInfo.deviceIdType or "",
    lang_script = env_info.devInfo.langScript or "",
    publish_area = env_info.devInfo.publishArea,
    airline = env_info.devInfo.airline,
    time_zone = env_info.devInfo.time_zone,
    language = env_info.devInfo.language,
    storage_size = env_info.devInfo.totalSize,
    cloud_game_mode = pkg_info.cloud_game_mode,
    cloud_game_runmode = pkg_info.cloud_game_runmode,
    umid_token = env_info.devInfo.umidToken or "",
    uuid = env_info.devInfo.uuid or "",
    hw_machine = env_info.devInfo.hw_machine,
    game_lang = pkg_info.game_lang,
    oaid = pkg_info.oaid
  }
  resource = Utils.merge_table(resource, tmp_resource, false)
  resource.session_id = tostring(resource.utdid) .. "-" .. tostring(Time.now_ms())
  ET.subscribe(ET.gangplank.ACQUIRE or "acquire", function(user_info)
    E.LOG.debug(LOGGER, "Got user info")
    E.LOG.debug(LOGGER, user_info)
    resource.account = user_info and user_info.uid
  end)
  ET.subscribe(ET.gangplank.SET_PLAYER_INFO, function(player_info)
    E.LOG.debug(LOGGER, "Got player info")
    resource.uid = player_info.player_id
    resource.game_server = player_info.server_id
    resource.is_login = "1"
  end)
  ET.subscribe(ET.gangplank.PLAYER_OFFLINE or "player_offline", function()
    E.LOG.debug(LOGGER, "logout player info")
    resource.uid = nil
    resource.game_server = nil
    resource.is_login = "0"
    resource.session_id = tostring(resource.utdid) .. "-" .. tostring(Time.now_ms())
  end)
  ET.subscribe(ET.gangplank.LOGOUT, function()
    resource.is_login = "0"
    resource.account = nil
  end)
  ET.subscribe("network_state_change", function()
    resource.network = NETWORK_NAME[E.Sysinfo.network_current_state()] or ""
    refresh_token()
  end)
  local EH = require("ejoysdk_lua.ejoysdk_holo")
  EH.get_device_score(function(succ, info)
    if succ then
      resource.cpu_score = info.cpu
      resource.gpu_score = info.gpu
      E.LOG.debug(LOGGER, "apus_modules cpu_score: " .. info.cpu)
    else
      E.LOG.error(LOGGER, "apus_modules get cpu_score fail")
    end
  end)
  E.Sysinfo.get_hardware_info(function(info)
    if nil == info then
      E.LOG.error(LOGGER, "get_hardware_info failed")
      return
    end
    if nil ~= info.cpu and nil ~= info.cpu.model then
      local cm = tostring(info.cpu.model)
      E.LOG.debug(LOGGER, "use hardware cpu_model: " .. cm)
      resource.cpu_model = cm
    end
    if nil ~= info.gpu and nil ~= info.gpu.model then
      local gm = tostring(info.gpu.model)
      E.LOG.debug(LOGGER, "use hardware gpu_model: " .. gm)
      resource.gpu_model = gm
    end
    if nil ~= info.gpus and #info.gpus > 0 then
      local gm = JSON.encode(info.gpus)
      E.LOG.debug(LOGGER, "use hardware gpu_model: " .. gm)
      resource.gpu_model = gm
    end
  end)
  loop_refresh_token()
  E.LOG.debug(LOGGER, "Labeler initialized.")
  E.LOG.debug(LOGGER, resource)
end

function M.get_resource(key)
  if nil == key then
    return resource
  else
    return resource[key]
  end
end

function M.set_quality_level(level)
  resource.quality_lv = level
end

function M.set_device_level(level)
  resource.device_lv = level
end

function M.set_game_version(version)
  resource.game_ver = version
end

function M.set_login_type(ltype)
  resource.login_type = ltype
end

function M.set_login_ret(ret)
  resource.login_ret = ret
end

function M.set_login_func(func)
  if nil == func then
    return
  end
  ET.subscribe(ET.gangplank.SET_PLAYER_INFO, function(player_info)
    E.LOG.debug(LOGGER, "login detected")
    Utils.exec(func)
  end)
end

function M.set_logout_func(func)
  if nil == func then
    return
  end
  ET.subscribe(ET.gangplank.LOGOUT, function(player_info)
    E.LOG.debug(LOGGER, "logout detected")
    Utils.exec(func)
  end)
end

local function is_custom_key_valid(key)
  if type(key) ~= "string" or "" == key then
    return false
  end
  return not hit_built_in_label_keys(key)
end

local function concate_key(key)
  if _namespace then
    return _namespace .. "_" .. key
  end
  return key
end

M.is_custom_key_valid = is_custom_key_valid

function M.set_static_label(key, value)
  if is_custom_key_valid(key) then
    resource[concate_key(key)] = tostring(value)
  end
end

function M.add_dynamic_label(key, func, ...)
  if type(func) ~= "function" then
    return
  end
  if is_custom_key_valid(key) then
    attribute_funcs[concate_key(key)] = {
      func,
      {
        ...
      }
    }
  end
end

function M.del_dynamic_label(key)
  if is_custom_key_valid(key) then
    attribute_funcs[concate_key(key)] = nil
  end
end

function M.set_scene_func(func)
  if type(func) ~= "function" then
    return
  end
  attribute_funcs.scene = {func}
end

function M.get_current_scene()
  local scene_func = attribute_funcs.scene
  if type(scene_func) ~= "table" then
    return nil
  end
  local func = scene_func[1]
  if type(func) ~= "function" then
    return nil
  end
  local scene = Utils.exec(func)
  if type(scene) ~= "string" or "" == scene then
    E.LOG.warn(LOGGER, "scene_func return invalid scene:" .. tostring(scene))
    return nil
  end
  return scene
end

function M.set_position_func(func)
  if nil == func then
    return
  end
  M.position_func = func
end

function M.get_attributes()
  local attributes = {}
  for name, func_args in pairs(attribute_funcs) do
    local func = func_args[1]
    local args = func_args[2]
    local v = Utils.exec(func, args)
    if nil ~= v then
      attributes[name] = tostring(v)
    end
  end
  if nil ~= M.position_func then
    local pos_x, pos_y, pos_z = Utils.exec(M.position_func)
    attributes.pos_x = pos_x
    attributes.pos_y = pos_y
    attributes.pos_z = pos_z
  end
  return attributes
end

function M.set_is_login(is_login)
  resource.is_login = is_login
end

local first_time_upload_log = true

function M.minimise_resource(res)
  if type(res) ~= "table" or next(res) == nil then
    return res
  end
  if not Cfg.enable_minimised_log_labels() then
    return res
  end
  if first_time_upload_log then
    first_time_upload_log = false
    return res
  end
  local whitelist_labels = Cfg.get_log_whitelist_labels()
  if type(whitelist_labels) ~= "table" or next(whitelist_labels) == nil then
    return res
  end
  local minimised_resource = {}
  for _, key in ipairs(whitelist_labels) do
    if nil ~= res[key] then
      minimised_resource[key] = res[key]
    end
  end
  minimised_resource.env = res.env
  return minimised_resource
end

return M
