local E = require("ejoysdk_lua.ejoysdk")
local ET = require("ejoysdk_lua.ejoysdk_topic")
local V = require("ejoysdk_lua.version")
local UTIL = require("ejoysdk_lua.ejoysdk_utils")
local JSON = require("ejoysdk_lua.ejoysdk_json")
local uuid = require("ejoysdk_lua.ejoysdk_uuid")
local EGC = require("ejoysdk_lua.ejoysdk_gangplank_config")
local STAT = require("ejoysdk_lua.ejoysdk_stat")
local EM = require("ejoysdk_lua.ejoysdk_module")
local EC = require("ejoysdk_lua.ejoysdk_constants")
local M = {}
local TAG = EM.MODULE.EJOYSDK_BASE_MODULE .. "config_center"
local inited = false
M.NAMESPACE = {
  EJOYSDK_CORE = "ejoysdk_core",
  EJOYSDK_BIZ = "ejoysdk_biz",
  APM = "apm",
  NETWORK = "network",
  USERCENTER_CN = "usercenter_cn",
  USERCENTER_OVERSEA = "usercenter_oversea",
  LUA_RESOURCE = "lua_resource",
  H5_RESOURCE = "h5_resource",
  MARKET_H5_RESOURCE = "qz_h5_res",
  EJOYSDK_H5_RESOURCE = "ejoysdk_h5res",
  GAME_RES = "game_res",
  PREDOWNLOAD = "predownload",
  QZ_CUSTOM_RES = "qz_custom_res",
  QZ_CONFIG = "qz_config",
  QZ_BOOT = "qz_boot",
  QZ_SUB_PACKAGE = "qz_sub_package",
  QZ_PATCH = "qz_patch"
}
local INIT_NAMESPACES = {
  EJOYSDK_CORE = M.NAMESPACE.EJOYSDK_CORE,
  EJOYSDK_BIZ = M.NAMESPACE.EJOYSDK_BIZ,
  APM = M.NAMESPACE.APM,
  NETWORK = M.NAMESPACE.NETWORK,
  USERCENTER_CN = M.NAMESPACE.USERCENTER_CN,
  USERCENTER_OVERSEA = M.NAMESPACE.USERCENTER_OVERSEA
}
local LONG_NAMESPACES = {
  EJOYSDK_CORE = M.NAMESPACE.EJOYSDK_CORE,
  EJOYSDK_BIZ = M.NAMESPACE.EJOYSDK_BIZ
}
local LOOP_SEC = 120
local white_namespace_list = {
  ejoysdk_core = true,
  ejoysdk_biz = true,
  apm = true,
  ejoy_cloud_game = true,
  ejoy_cloud_game_test = true,
  h5_resource = true,
  lua_resource = true,
  usercenter_cn = true,
  qz_custom_res = true,
  qz_patch = true,
  usercenter_oversea = true
}
local CONFIG_CENTER_UPDATE_TYPE = {ALL = 0, INC = 1}
M.CONFIG_CENTER_UPDATE_TYPE = CONFIG_CENTER_UPDATE_TYPE
M.ENV = {
  DEBUG = "debug",
  RELEASE = "release",
  PRE_RELEASE = "pre_release"
}
M.URL_BASE = {
  CONFIG_QUERY = "https://carbon-api.lingxigames.com"
}
M.URL_BASE_DEBUG = {
  CONFIG_QUERY = "https://ww-hk-carbon-api-test.qookkagames.com"
}
M.SERVICE = {
  GET_CONFIG_QUERY = "api.config.query"
}
local SERVICE_MAPPING = {
  [M.SERVICE.GET_CONFIG_QUERY] = "CONFIG_QUERY"
}
local l_env
local CONFIG_CENTER_API = {
  RSP_CODE_SUCC = 2000000,
  RSP_CODE_PARAMS_ERROR = 4000000,
  RSP_CODE_BIZ_ERROR = 4000001,
  RSP_CODE_SER_ERROR = 5000000,
  RSP_CODE_SYS_ERROR = 5000003,
  RSP_CODE_LIMIT_ERROR = 5000006
}
local uid, pid, platform, qz_base_url, prioritized_base_urls

local function get_prefer_product_code(product_code)
  if product_code and (type(product_code) ~= "string" or "" == product_code) then
    product_code = nil
  end
  local prefer_product_code = product_code and product_code:lower()
  if not prefer_product_code then
    local current_product_code = E.CONFIG.get_config("product")
    prefer_product_code = current_product_code and current_product_code:lower() or nil
  end
  if not prefer_product_code then
    return nil, EC.GLOBAL_GANGPLANK_ERROR_CODE.GLOBAL_PRODUCT_CODE_NOT_SET, "product code not set"
  else
    return prefer_product_code
  end
end

function M.set_env(env)
  E.LOG.debug(TAG, "set_env: " .. tostring(env))
  l_env = env
end

function M.get_env()
  if l_env then
    return l_env
  end
  local EI = require("ejoysdk_lua.ejoysdk_init")
  do return end
  return EI.env
end

function M.set_url_base(url_base)
  qz_base_url = url_base
end

function M.set_prioritized_base_urls(base_urls)
  prioritized_base_urls = base_urls
end

local request_namespaces = UTIL.deepcopy(LONG_NAMESPACES)

local function add_request_namespace(new_np)
  if nil == new_np then
    return
  end
  for _, np in pairs(request_namespaces) do
    if np == new_np then
      return
    end
  end
  request_namespaces[#request_namespaces + 1] = new_np
end

local function remove_request_namespace(del_np)
  if nil == del_np then
    return
  end
  for _, np in pairs(LONG_NAMESPACES) do
    if np == del_np then
      return
    end
  end
  local new = {}
  for k, np in pairs(request_namespaces) do
    if del_np ~= np then
      new[k] = np
    end
  end
  request_namespaces = new
end

local cache_configs_map = {}
local cache_ex_infos = {}
local cache_model_pcode_map = {}

function M._get_namespace_disk_cache_model(product_code)
  local req_product_code, _code, _msg = get_prefer_product_code(product_code)
  if not req_product_code then
    E.LOG.warn(TAG, "_get_namespace_cache_model failed, for current product code is nil")
    return nil, _code, _msg
  end
  local cache_model = cache_model_pcode_map[req_product_code]
  if cache_model then
    return cache_model
  end
  local keyStoreName = "NAMESPACE_INFOS_" .. tostring(req_product_code)
  cache_model = E.LazyKeyStore:New(keyStoreName, true, true, false)
  cache_model_pcode_map[req_product_code] = cache_model
  return cache_model
end

function M._test_get_cache_model_pcode_map()
  return cache_model_pcode_map
end

function M._load_disk_configs(product_code)
  local keystore, _code, _msg = M._get_namespace_disk_cache_model(product_code)
  if not keystore then
    E.LOG.warn(TAG, "_load_namespace_cache_info failed, code:" .. tostring(_code) .. ", msg:" .. tostring(_msg))
    return nil, _code, _msg
  end
  local data = UTIL.deepcopy(keystore:get())
  if type(data) ~= "table" then
    E.LOG.warn(TAG, "_load_disk_configs cache type invalid with pcode, just return empty table :" .. tostring(product_code))
    data = {}
  end
  return data
end

local function save_disk_configs()
  for _pcode, configs in pairs(cache_configs_map) do
    local keystore, _code, _msg = M._get_namespace_disk_cache_model(_pcode)
    if not keystore then
      E.LOG.warn(TAG, "_load_namespace_cache_info failed, code:" .. tostring(_code) .. ", msg:" .. tostring(_msg))
    elseif nil ~= configs then
      keystore:set(UTIL.deepcopy(configs))
      keystore:save()
    end
  end
end

function M._test_save_disk_configs()
  save_disk_configs()
end

function M._test_set_cache_configs_map(test_data)
  cache_configs_map = test_data or {}
end

local function get_local_configs_with_product(product_code)
  local req_product_code, _code, _msg = get_prefer_product_code(product_code)
  if not req_product_code then
    E.LOG.warn(TAG, "load_configs failed, for current product code is nil")
    return nil, _code, _msg
  end
  local pcode_cfg_cache = cache_configs_map[req_product_code]
  if nil == pcode_cfg_cache then
    pcode_cfg_cache = M._load_disk_configs(product_code)
    cache_configs_map[req_product_code] = pcode_cfg_cache
  end
  return pcode_cfg_cache
end

local function set_local_cache_config(ns_info)
  local ns_info_pcode, _code, _msg = get_prefer_product_code(ns_info.product_code)
  if not ns_info_pcode then
    E.LOG.warn(TAG, "save_cache_config failed, code:" .. tostring(_code) .. ", msg:" .. tostring(_msg))
    return false, _code, _msg
  end
  if nil ~= ns_info and nil ~= ns_info.namespace then
    local namespace = ns_info.namespace
    local pcode_cache_configs = cache_configs_map[ns_info_pcode]
    if nil == pcode_cache_configs then
      cache_configs_map[ns_info_pcode] = {
        [namespace] = ns_info
      }
    else
      pcode_cache_configs[namespace] = ns_info
    end
  end
  return true
end

local function get_local_config(namespace, product_code)
  local pcode_configs = get_local_configs_with_product(product_code)
  if pcode_configs then
    return pcode_configs[namespace]
  end
  return nil
end

function M.get_configs(product_code)
  do return UTIL.deepcopy, get_local_configs_with_product(product_code) end
  return UTIL.deepcopy, get_local_configs_with_product(product_code)
end

function M.get_config(namespace, product_code)
  do return UTIL.deepcopy, get_local_config(namespace, product_code) end
  return UTIL.deepcopy, get_local_config(namespace, product_code)
end

function M.set_ex_info(namespace, np_ex_info)
  if nil ~= namespace and type(np_ex_info) == "table" then
    cache_ex_infos[namespace] = np_ex_info
  end
end

function M.get_ex_info(namespace)
  do return UTIL.deepcopy end
  return UTIL.deepcopy, cache_ex_infos[namespace]
end

function M.get_ex_infos()
  do return UTIL.deepcopy end
  return UTIL.deepcopy, cache_ex_infos
end

local random_time_in_mills = 0

local function get_request_id()
  if 0 == random_time_in_mills then
    local random_mills = math.random(1, 1000)
    local sys_clock = os.time() * 1000
    random_time_in_mills = sys_clock + random_mills
    E.LOG.debug(TAG, "get_request_id :" .. random_time_in_mills .. ", sys_clock:" .. sys_clock .. ", random_mills:" .. random_mills)
  else
    random_time_in_mills = random_time_in_mills + 1
  end
  return random_time_in_mills
end

local dispatcher = {}

function M.subscribe(namespace, cb)
  if nil == namespace then
    return
  end
  E.LOG.debug(TAG, "subscribe: " .. namespace)
  local handlers = dispatcher[namespace]
  if not handlers then
    handlers = {}
    dispatcher[namespace] = handlers
  end
  for _, handler in ipairs(handlers) do
    if handler == cb then
      return
    end
  end
  handlers[#handlers + 1] = cb
  add_request_namespace(namespace)
end

function M.unsubscribe(namespace, cb)
  if nil == namespace then
    return
  end
  E.LOG.debug(TAG, "unsubscribe: " .. namespace)
  local handlers = dispatcher[namespace]
  if handlers then
    local new = {}
    for _, handler in ipairs(handlers) do
      if cb ~= handler then
        new[#new + 1] = handler
      end
    end
    dispatcher[namespace] = new
    if 0 == #new then
      remove_request_namespace(namespace)
    end
  end
end

local function publish(namespace, ...)
  local handlers = dispatcher[namespace]
  if handlers then
    for _, cb in ipairs(handlers) do
      local succ, err = pcall(cb, ...)
      if not succ then
        E.LOG.debug(TAG, "error namespace " .. tostring(namespace) .. ": " .. tostring(err))
      end
    end
  end
end

function M.add_init_namespace(namespace)
  if INIT_NAMESPACES and namespace and type(namespace) == "string" then
    INIT_NAMESPACES[namespace] = namespace
  end
end

local function get_request_params()
  local md5_utdid
  local utdid = E.Sysinfo.utdid() or ""
  if type(_ejoysdk_crypt.md5) == "function" then
    md5_utdid = _ejoysdk_crypt.md5(utdid)
  elseif type(_ejoysdk_crypt.md5) == "table" and _ejoysdk_crypt.md5.sum then
    md5_utdid = _ejoysdk_crypt.hexencode(_ejoysdk_crypt.md5.sum(utdid))
  end
  local request_params = {
    headers = {
      did = md5_utdid,
      gid = E.get_pkg_info().game_id,
      gver = E.get_pkg_info().versions.app_version_name,
      os = E.get_pkg_info().os,
      ch = "",
      cver = V.LUA_VERSION
    }
  }
  for k, v in pairs(E.get_pkg_info().versions) do
    request_params.headers[k] = v
  end
  return request_params
end

local function get_full_url(url_base, service_api)
  return url_base .. "/client/" .. service_api .. "?ver=1.3&df=json&gt=ng&cver=" .. V.LUA_VERSION .. "&os=" .. E.Sysinfo.os()
end

local function get_default_base_url(service_api)
  local is_overseas = E.CONFIG.get_config(E.CONFIG.KEY.MULTI_REGIONS_ENABLED)
  local url_base
  local server = SERVICE_MAPPING[service_api]
  if qz_base_url and "" ~= qz_base_url then
    url_base = qz_base_url
  end
  if nil == url_base then
    if is_overseas then
      local current_cdn_config = EGC.get_current_cdn_config()
      if current_cdn_config then
        url_base = current_cdn_config.config_center
      end
    else
      local _env = M.get_env()
      if _env == M.ENV.RELEASE then
        url_base = M.URL_BASE[server]
      else
        url_base = M.URL_BASE_DEBUG[server]
      end
    end
  end
  return url_base
end

local role_info, acc_info, env_info

local function update_role_info(params)
  if params then
    role_info = params
  end
  if role_info and env_info then
    env_info.roleInfo = role_info
  end
end

function M.role_info()
  if not role_info then
    role_info = {}
  end
  do return UTIL.deepcopy end
  return UTIL.deepcopy, role_info
end

function M.acc_info()
  if not acc_info then
    acc_info = {}
  end
  do return UTIL.deepcopy end
  return UTIL.deepcopy, acc_info
end

function M.env_info()
  if not env_info then
    env_info = {}
    local stat_env_info = STAT.env_info()
    if stat_env_info then
      M.acc_info()
      if stat_env_info.acc_info then
        acc_info = stat_env_info.acc_info
      end
      env_info.accInfo = acc_info
      env_info.devInfo = stat_env_info.devInfo
      env_info.chInfo = stat_env_info.chInfo
      env_info.chInfo.ch = E.get_channel()
      env_info.gmInfo = stat_env_info.gmInfo
    end
    env_info.runId = uuid()
    env_info.roleInfo = role_info
    if env_info.devInfo then
      local is_overseas = E.CONFIG.get_config(E.CONFIG.KEY.MULTI_REGIONS_ENABLED)
      if is_overseas then
        local gangplank_config = EGC.get_current_cdn_config()
        if gangplank_config then
          local airline_info = gangplank_config.ext and gangplank_config.ext.airline_info
          env_info.devInfo.airline = airline_info and airline_info.brand or "qookka"
        end
      else
        local airlineStr = E.get_pkg_info().airline or ""
        if "" == airlineStr then
          env_info.devInfo.airline = "lingxi"
        end
        if not env_info.devInfo.publishArea or "" == env_info.devInfo.publishArea then
          env_info.devInfo.publishArea = "cn"
        end
      end
    end
    if env_info.gmInfo and type(env_info.gmInfo) == "table" then
      local versions = E.get_pkg_info().versions
      if versions and type(versions) == "table" then
        for k, v in pairs(versions) do
          env_info.gmInfo[k] = v
        end
      end
    end
    if env_info.devInfo then
      local pkg_info = E.get_pkg_info()
      local UIM = require("ejoysdk_lua.user_info_manager")
      env_info.devInfo[UIM.PKG_INFO_KEY.KEY_CLOUD_GAME_MODE] = pkg_info[UIM.PKG_INFO_KEY.KEY_CLOUD_GAME_MODE]
      env_info.devInfo[UIM.PKG_INFO_KEY.KEY_INSTANT_MODE] = pkg_info[UIM.PKG_INFO_KEY.KEY_INSTANT_MODE]
      env_info.devInfo[UIM.PKG_INFO_KEY.KEY_INSTALL_REFERRER] = pkg_info[UIM.PKG_INFO_KEY.KEY_INSTALL_REFERRER]
      env_info.devInfo[UIM.PKG_INFO_KEY.KEY_CLOUD_GAME_RUN_MODE] = pkg_info[UIM.PKG_INFO_KEY.KEY_CLOUD_GAME_RUN_MODE]
    end
  end
  do return UTIL.deepcopy end
  return UTIL.deepcopy, env_info, require("ejoysdk_lua.user_info_manager"), env_info.devInfo, UIM.PKG_INFO_KEY.KEY_CLOUD_GAME_RUN_MODE, pkg_info[UIM.PKG_INFO_KEY.KEY_CLOUD_GAME_RUN_MODE], nil, nil, env_info.gmInfo
end

function M.reset_env_info()
  env_info = nil
  role_info = nil
end

local function dispatch_and_save_remote_data(data, req_product_code, disable_update_cache_ns_map)
  disable_update_cache_ns_map = disable_update_cache_ns_map or {}
  if not data then
    E.LOG.debug(TAG, "data is nil")
    return
  end
  local namespaces = data.configList
  if not namespaces then
    E.LOG.debug(TAG, "data.configList is nil")
    return
  end
  local save_count = 0
  local update_info = {}
  for _, ns_info in pairs(namespaces) do
    local namespace = ns_info.namespace
    if not disable_update_cache_ns_map[namespace] then
      E.LOG.debug(TAG, "not disable update config center cache, continue:" .. tostring(namespace))
      local hash = ns_info.hash
      local version = ns_info.version
      local is_test = ns_info.test or false
      ns_info.product_code = req_product_code or ""
      local last_ns_info = get_local_config(namespace, req_product_code)
      if nil ~= last_ns_info then
        local last_ns_product_code = last_ns_info.product_code
        if req_product_code and last_ns_product_code and "" ~= req_product_code and "" ~= last_ns_product_code and req_product_code ~= last_ns_product_code then
          E.LOG.warn(TAG, "dispatch_and_save_remote_data cache pcode different from request pcode, for ns:" .. tostring(namespace) .. ", cache pcode:" .. tostring(last_ns_product_code) .. ", req pcode:" .. tostring(req_product_code))
          last_ns_info = nil
        end
      end
      if nil ~= last_ns_info then
        local last_hash = last_ns_info.hash
        local last_version = last_ns_info.version or -1
        if version > last_version or -1 == last_version or is_test then
          if hash ~= last_hash then
            set_local_cache_config(ns_info)
            save_count = save_count + 1
            table.insert(update_info, ns_info)
            E.LOG.debug(TAG, "namespace:" .. tostring(namespace) .. ", update [new version]:" .. tostring(version))
          else
            last_ns_info.version = version
            save_count = save_count + 1
            set_local_cache_config(last_ns_info)
            E.LOG.debug(TAG, "namespace:" .. tostring(namespace) .. ", update [only version]:" .. tostring(version))
          end
        elseif last_version == version and hash ~= last_hash then
          set_local_cache_config(ns_info)
          save_count = save_count + 1
          table.insert(update_info, ns_info)
          E.LOG.debug(TAG, "namespace:" .. tostring(namespace) .. ", update [new hash]:" .. tostring(version))
        end
      else
        set_local_cache_config(ns_info)
        table.insert(update_info, ns_info)
        save_count = save_count + 1
        E.LOG.debug(TAG, "namespace:" .. tostring(namespace) .. ", update [no cache]:" .. tostring(version))
      end
    else
      E.LOG.debug(TAG, "not update config cache, for its disabled:" .. tostring(namespace))
    end
  end
  if save_count > 0 then
    E.LOG.debug(TAG, "update namespace count:" .. tostring(save_count))
    save_disk_configs()
  end
  for _, info in pairs(update_info) do
    publish(info.namespace, UTIL.deepcopy(info))
  end
end

local function get_configs_from_server(_namespaces, update_type, cb, product_code, disable_update_cache, options, ext)
  options = options or {}
  ext = ext or {}
  local req_params = get_request_params()
  local default_base_url = get_default_base_url(M.SERVICE.GET_CONFIG_QUERY)
  if not default_base_url then
    cb(false, EC.CONFIG_CENTER_ERROR_CODES.NO_REQUEST_URL, "default base url is nil")
    return
  end
  local req_product_code = get_prefer_product_code(product_code)
  local disable_update_cache_ns_map = {}
  if true == disable_update_cache then
    if options.disable_update_cache_ns_arr == nil then
      for _, np_name in ipairs(_namespaces) do
        disable_update_cache_ns_map[np_name] = true
      end
    else
      for _, np_name in ipairs(options.disable_update_cache_ns_arr) do
        disable_update_cache_ns_map[np_name] = true
      end
    end
  end
  local namespace_list = {}
  for _, np_name in pairs(_namespaces) do
    local np_config = get_local_config(np_name, req_product_code)
    if not disable_update_cache_ns_map[np_name] and np_config then
      local np_version = {
        namespace = string.lower(np_config.namespace) or "",
        hash = np_config.hash or "",
        version = np_config.version or -1
      }
      table.insert(namespace_list, np_version)
    else
      local np_version = {
        namespace = string.lower(np_name),
        hash = "",
        version = -1
      }
      table.insert(namespace_list, np_version)
    end
  end
  local np_ex_infos = M.get_ex_infos()
  local context_info = M.env_info()
  context_info.customInfo = ext.custom_infos or nil
  local public_params = {
    contextInfo = context_info,
    appId = E.get_game_id(),
    env = req_product_code or "",
    os = E.CONFIG.get_config("os"),
    ve = V.LUA_VERSION
  }
  local id = get_request_id()
  local body_params = {
    id = id,
    data = {
      type = update_type,
      namespaceList = namespace_list,
      exInfos = np_ex_infos
    },
    client = public_params
  }
  local current_retry_times = 1
  local all_url_bases = prioritized_base_urls or {}
  table.insert(all_url_bases, default_base_url)
  local all_retry_count = #all_url_bases
  local retry_request_server_wrapper
  
  function retry_request_server_wrapper(current_base_url, _cb)
    local config_center_url = get_full_url(current_base_url, M.SERVICE.GET_CONFIG_QUERY)
    E.LOG.debug(TAG, "config_center_url is " .. tostring(config_center_url))
    E.HTTP.post(config_center_url, req_params, E.HTTP.CT_JSON, body_params, function(resp)
      if resp.status == 200 then
        _cb(true, resp, config_center_url)
      else
        E.LOG.warn(TAG, "post response failed, url:" .. tostring(config_center_url) .. ", status: " .. tostring(resp.status))
        local retry_index = current_retry_times + 1
        if retry_index <= all_retry_count then
          current_retry_times = retry_index
          local retry_base_url = all_url_bases[retry_index]
          E.LOG.debug(TAG, "get_configs_from_server retry, retry base url is " .. tostring(retry_base_url))
          retry_request_server_wrapper(retry_base_url, _cb)
        else
          _cb(false, resp, config_center_url)
        end
      end
    end)
  end
  
  local base_url = all_url_bases[1]
  _ejoysdk.log("config_center_url is " .. tostring(base_url))
  retry_request_server_wrapper(base_url, function(succ, resp, real_config_center_url)
    if succ then
      E.LOG.debug(TAG, "get resp >>")
      E.log(resp)
      local body_json = resp.body
      if type(resp.body) == "string" then
        body_json = JSON.safe_decode(resp.body)
      end
      if body_json and body_json.state then
        if body_json.state.code == CONFIG_CENTER_API.RSP_CODE_SUCC then
          if not disable_update_cache then
            dispatch_and_save_remote_data(body_json.data, req_product_code)
            local cb_np_list = {}
            for _, np_name in pairs(_namespaces) do
              local new_config = get_local_config(np_name, req_product_code)
              if new_config then
                table.insert(cb_np_list, new_config)
              end
            end
            cb(true, cb_np_list)
          else
            dispatch_and_save_remote_data(body_json.data, req_product_code, disable_update_cache_ns_map)
            local config_list = body_json.data and body_json.data.configList or {}
            for _, v in pairs(config_list) do
              if v and v.namespace then
                v.product_code = req_product_code or ""
              end
            end
            cb(true, config_list)
          end
        else
          E.LOG.warn(TAG, "post response failed, url:" .. tostring(real_config_center_url) .. ", code:" .. tostring(body_json.state.code) .. ", msg:" .. tostring(body_json.state.msg))
          cb(false, body_json.state.code or EC.CONFIG_CENTER_ERROR_CODES.SERVICE_ERROR, body_json.state.msg or "", body_json.data)
        end
      else
        E.LOG.warn(TAG, "post response failed, url:" .. tostring(real_config_center_url) .. ", body.state is nil")
        cb(false, EC.CONFIG_CENTER_ERROR_CODES.PARSE_DATA_FAIL, "response could not be parsed")
      end
    else
      E.LOG.warn(TAG, "post response failed, url:" .. tostring(real_config_center_url) .. ", status:" .. tostring(resp.status))
      cb(false, resp.status or EC.CONFIG_CENTER_ERROR_CODES.HTTP_REQUEST_FAIL, "request error")
    end
  end)
end

local function timer_fire_request_configs()
  get_configs_from_server(request_namespaces, CONFIG_CENTER_UPDATE_TYPE.INC, function()
  end)
end

function M.get_configs_in_whitelist(str_namespaces, cb, product_code)
  local in_white_list_nps = {}
  if str_namespaces and type(str_namespaces) == "table" then
    for _, v in pairs(str_namespaces) do
      if nil ~= white_namespace_list[v] then
        table.insert(in_white_list_nps, v)
      end
    end
  end
  if #in_white_list_nps > 0 then
    get_configs_from_server(in_white_list_nps, CONFIG_CENTER_UPDATE_TYPE.INC, cb, product_code)
  else
    cb(false, EC.CONFIG_CENTER_ERROR_CODES.NAMESPACE_NOT_IN_WHITE_LIST, "all namespaces is not in white list")
  end
end

function M._get_configs_from_server(str_namespaces, cb, product_code)
  get_configs_from_server(str_namespaces, CONFIG_CENTER_UPDATE_TYPE.INC, cb, product_code)
end

function M.get_configs_with_options(options, str_namespaces, cb, ext)
  options = options or {}
  local product_code = options.product_code
  local disable_update_cache = true
  if options.disable_update_cache ~= nil then
    disable_update_cache = options.disable_update_cache
  end
  local update_type = options.update_type or CONFIG_CENTER_UPDATE_TYPE.ALL
  get_configs_from_server(str_namespaces, update_type, cb, product_code, disable_update_cache, options, ext)
end

local need_update_init_namespace = false

function M.delete_config(_namespace, product_code)
  local req_product_code, _code, _msg = get_prefer_product_code(product_code)
  if not req_product_code then
    E.LOG.warn(TAG, "load_configs failed, for current product code is nil")
    return nil, _code, _msg
  end
  local product_code_configs_cache = get_local_configs_with_product(req_product_code)
  if product_code_configs_cache then
    if not _namespace then
      cache_configs_map[req_product_code] = {}
    elseif product_code_configs_cache[_namespace] then
      product_code_configs_cache[_namespace] = nil
    end
    save_disk_configs()
    need_update_init_namespace = true
  end
end

function M.delete_with_new_product(_new_productcode, _namespace)
  local cur_productcode = E.CONFIG.get_config("product")
  if _new_productcode and cur_productcode then
    cur_productcode = cur_productcode:lower()
    if cur_productcode == _new_productcode:lower() then
      E.LOG.debug(TAG, "new_productcode = current productcode is no need to delete")
      return
    end
  end
  E.LOG.debug(TAG, "delete current productcode: " .. tostring(cur_productcode))
  M.delete_config(_namespace, cur_productcode)
end

local function set_player_info_handler(player_info, _type)
  E.LOG.debug(TAG, "set_player_info_handler")
  local params = {
    serverId = player_info.server_id,
    serverName = player_info.server_name,
    playerId = player_info.player_id,
    playerName = player_info.player_name,
    playerLevel = player_info.player_level,
    uid = uid or "",
    chuid = pid or "",
    chUserType = platform or ""
  }
  update_role_info(params)
end

local function player_offline_handler()
  E.LOG.debug(TAG, "player_offline_handler")
  local params = {
    serverId = "",
    serverName = "",
    playerId = "",
    playerName = "",
    playerLevel = "",
    uid = uid or "",
    chuid = pid or "",
    chUserType = platform or ""
  }
  update_role_info(params)
end

local function login_handler(user_info)
  uid = user_info.uid
  pid = user_info.pid
  platform = user_info.platform
  local params = {
    uid = uid,
    chuid = pid,
    chUserType = platform,
    serverId = "",
    serverName = "",
    playerId = "",
    playerName = "",
    playerLevel = ""
  }
  E.LOG.debug(TAG, "login，clear cached role data and update account data of ConfigCenter")
  update_role_info(params)
  M.acc_info()
  local account_info = acc_info
  account_info.accountId = user_info.uid
  account_info.chuid = user_info.pid
  if user_info.platform ~= nil and user_info.platform ~= "" then
    account_info.chUserType = user_info.platform
  else
    account_info.chUserType = E.get_channel()
  end
  if account_info and env_info then
    env_info.accInfo = account_info
  end
end

local function gangplank_logout_handler()
  uid = ""
  pid = ""
  platform = ""
  local params = {
    serverId = "",
    serverName = "",
    playerId = "",
    playerName = "",
    playerLevel = "",
    uid = "",
    chuid = "",
    chUserType = ""
  }
  E.LOG.debug(TAG, "logout，clear cached account and role data of ConfigCenter")
  update_role_info(params)
end

local function gangplank_exit_handler()
  uid = ""
  pid = ""
  platform = ""
  local params = {
    serverId = "",
    serverName = "",
    playerId = "",
    playerName = "",
    playerLevel = "",
    uid = "",
    chuid = "",
    chUserType = ""
  }
  E.LOG.debug(TAG, "exit，clear cached account and role data of ConfigCenter")
  update_role_info(params)
end

function M.get_config_for_unittest()
  do return end
  return get_local_configs_with_product, nil
end

function M.update_config_for_unittest(_ns_config)
  set_local_cache_config(_ns_config)
end

M._debug_publish = publish

local function loop_request()
  E.Timer.once(LOOP_SEC, function()
    timer_fire_request_configs()
    loop_request()
  end)
end

local function ns_biz_handler(biz_config)
  if biz_config and biz_config.config then
    local cc_cutout_infos = biz_config.config.cutout_infos
    local model_str = E.Sysinfo.model() or ""
    if cc_cutout_infos and type(model_str) == "string" and 0 ~= #model_str then
      local cutout_info = cc_cutout_infos[model_str]
      if cutout_info then
        _ejoysdk.log("update cutout from config_center")
        local cut_params = {}
        cut_params.cutout_info = {
          [model_str] = cutout_info
        }
        E.Sysinfo.update_cutout(cut_params)
      end
    end
  end
end

M.is_data_inited = false

function M.init()
  if inited then
    E.LOG.debug(TAG, "already inited, just notify init success and return")
    return
  end
  ET.subscribe(ET.gangplank.LOGIN, login_handler)
  ET.subscribe(ET.gangplank.LOGOUT, gangplank_logout_handler)
  ET.subscribe(ET.gangplank.EXIT, gangplank_exit_handler)
  ET.subscribe(ET.gangplank.SET_PLAYER_INFO_WITH_TYPE, set_player_info_handler)
  ET.subscribe(ET.gangplank.PLAYER_OFFLINE, player_offline_handler)
  ET.subscribe(ET.gangplank.INITED, function(succ, ...)
    E.LOG.debug(TAG, "need_update_init_namespace is " .. tostring(need_update_init_namespace))
    if succ and need_update_init_namespace then
      get_configs_from_server(INIT_NAMESPACES, CONFIG_CENTER_UPDATE_TYPE.INC, function(_succ, ...)
        if _succ then
          need_update_init_namespace = false
        end
      end)
    end
  end)
  M.subscribe(M.NAMESPACE.EJOYSDK_BIZ, ns_biz_handler)
  get_local_configs_with_product()
  get_configs_from_server(INIT_NAMESPACES, CONFIG_CENTER_UPDATE_TYPE.INC, function(...)
    M.is_data_inited = true
    ET.publish(ET.config_center.DATA_INITED, ...)
    E.LOG.debug(TAG, "config_center_init_succ_handler inited")
    local succ = (...)
    local ql = require("ejoysdk_lua.ejoysdk_qualitylog")
    if succ then
      ql.commit_action_succ_main("ejoy_config_center_end")
    else
      local _succ, code, msg = ...
      ql.commit_action_fail_main("ejoy_config_center_end", nil, code, msg)
    end
  end)
  loop_request()
  inited = true
end

return M
