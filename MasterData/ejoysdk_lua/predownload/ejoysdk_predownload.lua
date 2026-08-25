local E = require("ejoysdk_lua.ejoysdk")
local CC = require("ejoysdk_lua.ejoysdk_config_center")
local Utils = require("ejoysdk_lua.native.utils.Utils")
local ejoysdk_init = require("ejoysdk_lua.ejoysdk_init")
local ejoysdk_topic = require("ejoysdk_lua.ejoysdk_topic")
local CONSTANTS = require("ejoysdk_lua.ejoysdk_constants")
local ESTAT = require("ejoysdk_lua.ejoysdk_stat")
local PDRES = require("ejoysdk_lua.predownload.predownload_res")
local LB = require("ejoysdk_lua.res.lightboat.ejoysdk_lightboat")
local PC = require("ejoysdk_lua.predownload.predownload_config")
local JSBridge = require("ejoysdk_lua.ejoysdk_js_bridge")
local EG = require("ejoysdk_lua.ejoysdk_gangplank")
local M = {}
local TAG = "predownload"
local LAST_PREDOWNLOAD_STORAGE = E.LazyKeyStore:New("LAST_PREDOWNLOAD_STORAGE", false, true, false)
M.CONFIG_KEYS = {
  SDK_SERVER_ENV = "sdk_server_env",
  GAME_PRODUCT_ID = "game_product_id",
  DEBUGGABLE = "debuggable",
  URL = "url",
  ORIENTATION = "orientation",
  OVERSEAS = "overseas",
  OPTIONS = "options",
  QUERY_PULLUP_PKGNAMES = "query_pullup_pkgnames",
  WEBOPEN_FIRST = "webopen_first",
  DOWNLOAD_WITH_STRATEGY = "download_with_strategy"
}
M.DEBUG_OPTIONS = {Debug = false}
M.PREDOWNLOAD_NAMESPACE = "predownload"
M.ACTION = {
  DOWNLOAD_FINISH = "predownload_download_finish",
  TRANSFORM_CONFIRM = "predownload_transform_confirm",
  TRANSFORM_FINISH = "predownload_transform_finish"
}
local H5_RES_UPDATE_CHECK_TIMEOUT_SEC = 5
local UPDATE_CHECK_STATE = {
  UNCHECKED = -1,
  FAILED = 0,
  SUCC = 1,
  CHECKING = 2
}
local is_logined = false
local m_acquire_callback, m_logout_callback
local m_h5_res_update_check_state = UPDATE_CHECK_STATE.UNCHECKED
local m_waitting_check_listeners = {}

function M.merge_webview_options(old_options, remote_options)
  local f_options = old_options or {}
  f_options.use_fragment = true
  f_options.hide_close_btn = true
  f_options.use_cutout = false
  f_options.disable_backkey_press = true
  f_options.screen_orientation = M.Orientation or "portrait"
  if M.Options then
    for k, v in pairs(M.Options) do
      f_options[k] = v
    end
  end
  if remote_options then
    for k, v in pairs(remote_options) do
      f_options[k] = v
    end
  end
  return f_options
end

function M.get_save_storeage()
  return LAST_PREDOWNLOAD_STORAGE
end

local function get_url()
  local webview_params = M.get_config_from_cc_h5res() or {}
  local url
  if webview_params.url then
    url = webview_params.url
  else
    url = M.Url
  end
  E.LOG.debug(TAG, "get_url:" .. tostring(url))
  return url
end

function M.get_config_from_cc_h5res()
  local final_params
  local cc_config = CC.get_config(CC.NAMESPACE.PREDOWNLOAD)
  local final_configs = cc_config and cc_config.config and cc_config.config.predownload
  if final_configs and final_configs.webview then
    final_params = final_configs.webview
  end
  return final_params
end

function M.open_webview(_option)
  local url = get_url()
  E.LOG.debug(TAG, "open_webview begin:" .. tostring(url))
  if url then
    local webview_params = M.get_config_from_cc_h5res() or {}
    
    local function open_predownload_webview(_final_url, _local_host)
      local EW = require("ejoysdk_lua.ejoysdk_web")
      local options = _option
      options = EW.get_fill_default_options(options)
      local remote_options = webview_params.options
      options = M.merge_webview_options(options, remote_options)
      E.LOG.debug(TAG, options)
      local hosts = {
        ".aligames.com",
        ".lingxigames.com",
        ".ejoy.com",
        ".alibaba.net",
        ".qookkagames.com",
        ".sialiagames.com.tw",
        ".sialiagamesinc.com.tw"
      }
      if _local_host and type(_local_host) == "string" then
        E.LOG.debug(TAG, "local_res_host: " .. tostring(_local_host))
        table.insert(hosts, _local_host)
      end
      local web_injection, web_options = EW.to_webview_open_params(hosts, {}, options)
      E.LOG.debug(TAG, "open_url in predownload:" .. tostring(_final_url))
      JSBridge.init()
      local VPRD = require("ejoysdk_lua.vendors.predownload")
      VPRD.open_url(_final_url, {injection = web_injection, options = web_options})
      if PC.DEBUG_CONFIG.enable_auto_download then
        M.check_res_state(function(succ, ...)
          if succ then
            local EF = require("ejoysdk_lua.res.game_sub_pkg_facade")
            local _res_info = (...)
            local _downloading_info = _res_info[EF.RES_STATE_INFOS.TYPE_DOWNLOADING_INFO] or {}
            local _state = _downloading_info[EF.RES_DOWNLOAD_STATE_KEY.STATE]
            if _state == EF.DOWNLOAD_STATE.COMPLETE then
              E.LOG.debug(TAG, "check_res_state is complete, now open game activity")
              VPRD.start_game_activity(true)
            else
              E.LOG.debug(TAG, "check_res_state not complete, now start_download")
              M.start_download()
            end
          else
            local _code, _msg = ...
            E.LOG.warn(TAG, "check_res_state failed, code:" .. tostring(_code) .. ", msg:" .. tostring(_msg))
          end
        end)
        E.LOG.debug(TAG, "loop_query_res_state begin")
        local RTM = require("ejoysdk_lua.res.model.ejoy_res_type_model")
        local last_state = {state = nil, net_type = nil}
        local loop_query_state
        
        function loop_query_state()
          local state_info = M.get_res_state()
          local downloading_info = state_info[RTM.INFO_TYPE_KEY.TYPE_DOWNLOADING_INFO]
          local net_type = E.Sysinfo.network_type()
          E.log(state_info)
          E.log("get_res_state, cur_state" .. tostring(downloading_info.state) .. ", cur_net:" .. tostring(net_type) .. ", last_state:" .. tostring(last_state.state) .. ", last_net_type:" .. tostring(last_state.net_type) .. ", changed:" .. tostring(downloading_info.state ~= last_state.state or net_type ~= last_state.net_type))
          if (downloading_info.state ~= last_state.state or net_type ~= last_state.net_type) and downloading_info.state == RTM.PUBLIC_DOWNLOAD_STATE.FAILED and 1 == net_type then
            _ejoysdk.log("received failed state , now start again, downloading_info.state:" .. tostring(downloading_info.state) .. ", net_type:" .. tostring(net_type))
            last_state.state = downloading_info.state
            last_state.net_type = net_type
            M.start_download()
          else
            last_state.state = downloading_info.state
            last_state.net_type = net_type
          end
          E.Timer.once(3, loop_query_state)
        end
        
        E.Timer.once(3, loop_query_state)
      end
    end
    
    local LIGHTBOAT = require("ejoysdk_lua.res.lightboat.ejoysdk_lightboat")
    local _final_url = LIGHTBOAT.get_url_from_cache(url)
    local _local_host
    local is_local_url = url ~= _final_url
    if is_local_url then
      _local_host = E.Utils.url_clipping(_final_url)
    end
    open_predownload_webview(_final_url, _local_host)
  else
    E.LOG.warn(TAG, "open failed, config url is not ready")
  end
end

function M.start_game()
  local VPRD = require("ejoysdk_lua.vendors.predownload")
  VPRD.start_game_activity()
end

function M.start_download()
  E.LOG.debug(TAG, "start_download")
  PDRES.start_download(function(succ, update_info_exist, ...)
    if succ then
      if update_info_exist then
        E.LOG.warn(TAG, "download finish")
        local stat_params = {
          [ESTAT.STAT_KEY.IS_UPLOAD_NOW] = true
        }
        ESTAT.stat_bizid(M.ACTION.DOWNLOAD_FINISH, "1", "1", stat_params)
      else
        E.LOG.debug(TAG, "start_download no resource")
      end
    else
      E.LOG.warn(TAG, "start_download failed")
      local stat_params = {
        [ESTAT.STAT_KEY.IS_UPLOAD_NOW] = true,
        update_info_exist = update_info_exist
      }
      ESTAT.stat_bizid(M.ACTION.DOWNLOAD_FINISH, "1", "0", stat_params)
    end
  end)
end

function M.query_game_pkg_install_state(cb)
  local pkgnames = M.QueryPullUpPkgNames or {}
  local len = #pkgnames
  if 0 == len then
    E.LOG.warn(TAG, "query_game_pkg_install_state, query config is empty, return empty")
    cb({})
    return
  end
  local result = {}
  for i = 1, len do
    local pkg_name = pkgnames[i]
    local installed = E.Sysinfo.is_app_install(pkg_name)
    result[pkg_name] = installed
  end
  cb(result)
end

function M.stat_finish()
  local stat_params = {
    [ESTAT.STAT_KEY.IS_UPLOAD_NOW] = true
  }
  ESTAT.stat_bizid(M.ACTION.TRANSFORM_FINISH, "3", "1", stat_params)
end

function M.start_game_from_webview()
  local parmas = {
    is_start_game = true,
    timestamp = os.time()
  }
  LAST_PREDOWNLOAD_STORAGE:set(parmas)
  local stat_params = {
    [ESTAT.STAT_KEY.IS_UPLOAD_NOW] = true
  }
  ESTAT.stat_bizid(M.ACTION.TRANSFORM_CONFIRM, "2", "1", stat_params)
  M.start_game()
end

function M.is_confirmed_to_finish()
  local result = LAST_PREDOWNLOAD_STORAGE:get()
  return nil ~= result
end

function M.is_finish_predownload()
  do return end
  return M.is_confirmed_to_finish, nil
end

function M.get_res_state()
  local res_state = PDRES.get_res_state()
  if nil ~= res_state then
    return res_state
  end
  return nil
end

function M.check_res_state(cb)
  PDRES.check_res_state(cb)
end

local function auth_listener(succ, ...)
  if succ then
    E.LOG.debug(TAG, "-------gangplank login success-------")
  else
    local code, message = ...
    E.LOG.debug(TAG, "code: " .. code .. " ,message: " .. message)
    if code == CONSTANTS.OFFICIAL_ERR_CODES.CODE_LOGIN_CANCEL then
      M.vm_login()
    end
  end
end

local function on_h5_res_update_check_complete(_succ, ...)
  m_h5_res_update_check_state = _succ and UPDATE_CHECK_STATE.SUCC or UPDATE_CHECK_STATE.FAILED
  E.LOG.debug(TAG, "on_h5_res_update_check_complete result:" .. tostring(_succ) .. ", state:" .. tostring(m_h5_res_update_check_state))
  if #m_waitting_check_listeners > 0 then
    for _, lis in ipairs(m_waitting_check_listeners) do
      lis(m_h5_res_update_check_state)
    end
  end
  m_waitting_check_listeners = {}
end

local function listen_h5_res_config_check_complete()
  if m_h5_res_update_check_state ~= UPDATE_CHECK_STATE.CHECKING and m_h5_res_update_check_state ~= UPDATE_CHECK_STATE.UNCHECKED then
    E.LOG.debug(TAG, "listen_h5_res_config_check_complete already check complete, skip listen")
    return
  end
  m_h5_res_update_check_state = UPDATE_CHECK_STATE.CHECKING
  local is_timeout = false
  local received_res_update_complete = false
  local listen_topic_func
  E.Timer.once(H5_RES_UPDATE_CHECK_TIMEOUT_SEC, function()
    if received_res_update_complete then
      E.LOG.debug(TAG, "already received_res_update_complete skip notify result")
      return
    end
    is_timeout = true
    E.LOG.warn(TAG, "received h5 res update check timeout")
    ejoysdk_topic.unsubscribe(ejoysdk_topic.lightboat.QZ_H5_RES_UPDATE_CHECK_ALL_COMPLETE, listen_topic_func)
    on_h5_res_update_check_complete(false, CONSTANTS.GANGPLANK_ERROR_CODE.GANGPLANK_ERROR_REQUEST_TIMEOUT, "check res update timeout")
  end)
  
  function listen_topic_func(succ, ...)
    if is_timeout then
      E.LOG.warn(TAG, "already timeout notified before check complete, skip process")
      return
    end
    received_res_update_complete = true
    ejoysdk_topic.unsubscribe(ejoysdk_topic.lightboat.QZ_H5_RES_UPDATE_CHECK_ALL_COMPLETE, listen_topic_func)
    on_h5_res_update_check_complete(succ, ...)
  end
  
  ejoysdk_topic.subscribe(ejoysdk_topic.lightboat.QZ_H5_RES_UPDATE_CHECK_ALL_COMPLETE, listen_topic_func)
end

local function check_res_check_state(cb)
  if m_h5_res_update_check_state == UPDATE_CHECK_STATE.CHECKING or m_h5_res_update_check_state == UPDATE_CHECK_STATE.UNCHECKED then
    table.insert(m_waitting_check_listeners, cb)
  else
    cb(m_h5_res_update_check_state)
  end
end

local function show_main_web_page()
  E.LOG.debug(TAG, "show_main_web_page before check_res_check_state")
  check_res_check_state(function(state)
    E.LOG.debug(TAG, "show_main_web_page begin:" .. tostring(state))
    if state == UPDATE_CHECK_STATE.FAILED then
      local _url = get_url()
      local _url_code = E.Utils.url_clipping(_url)
      LB.remove_local_path_with_url_code(_url_code)
      E.LOG.warn(TAG, "check res state failed, force use remote url res, url:" .. tostring(_url) .. ", code:" .. tostring(_url_code))
    end
    M.open_webview({})
  end)
end

local function acquire_listener(succ, ...)
  E.LOG.debug(TAG, "acquire result:" .. tostring(succ))
  is_logined = succ
  if m_acquire_callback then
    m_acquire_callback(succ, ...)
    m_acquire_callback = nil
  end
end

function M.logout(cb)
  M.vm_logout(cb)
end

local function logout_listener()
  E.LOG.debug(TAG, "-------gangplank logout success-------")
  if m_logout_callback then
    m_logout_callback()
    m_logout_callback = nil
  end
  if not M.DisableAutoLogin then
    E.LOG.debug(TAG, "logout_listener received, auto login is true and call login")
    E.Timer.once(1, function()
      if false == is_logined then
        M.vm_login()
      end
    end)
  end
end

local function exit_listener(succ)
  if succ then
    E.LOG.debug(TAG, "-------gangplank exit success-------")
  else
    E.LOG.debug(TAG, "-------gangplank exit failure-------")
  end
end

function M.vm_login(cb)
  m_acquire_callback = cb
  EG.acquire_token()
end

local function auto_login(complete_cb)
  M.vm_login(function(succ, ...)
    if succ then
      E.LOG.debug(TAG, "auto_login succ")
      complete_cb(succ, ...)
    else
      E.LOG.warn(TAG, "auto_login failed, try next")
      E.Timer.once(1, function()
        if false == is_logined then
          E.LOG.debug(TAG, "auto_login try next")
          auto_login(complete_cb)
        end
      end)
    end
  end)
end

function M.vm_logout(cb)
  is_logined = false
  m_logout_callback = cb
  EG.logout()
end

local is_gp_inited = false
local current_init_retry_times = 1

local function parse_query_pullup_pkgnames(config_query_pkgnames)
  local result = {}
  if not config_query_pkgnames or "" == config_query_pkgnames then
    E.LOG.warn(TAG, "parse_query_pullup_pkgnames empty, for config_query_pkgnames is nil:" .. tostring(config_query_pkgnames))
    return result
  end
  local split_strs = E.Utils.split_string(config_query_pkgnames, ",")
  for _, item in ipairs(split_strs) do
    item = E.Utils.trim(item)
    table.insert(result, item)
  end
  return result
end

function M.vm_init(params, cb)
  local sdk_meta_configs = params or {}
  cb = cb or function()
    E.LOG.debug(TAG, "init_vm cb nil")
  end
  local _meta_data_load = require("ejoysdk_lua.vendors.unisdk")
  M.DEBUG_OPTIONS.Debug = sdk_meta_configs[M.CONFIG_KEYS.DEBUGGABLE] or false
  if M.DEBUG_OPTIONS.Debug then
    local ELOG = require("ejoysdk_lua.ejoysdk_log")
    local ej_debugable = E.get_ej_debugable()
    ELOG.setup_ej_debugable(ej_debugable)
    if ej_debugable then
      E.open_log(ej_debugable)
    end
  end
  E.LOG.debug(TAG, sdk_meta_configs)
  E.CONFIG.set_config(E.CONFIG.KEY.APP_VERSION_UPDATE_CHECK, true)
  local UIM = require("ejoysdk_lua.user_info_manager")
  local predownload_game_info = {
    [UIM.PKG_INFO_KEY.KEY_PREDOWNLOAD_GAME_RUN_MODE] = "predownload",
    [UIM.PKG_INFO_KEY.KEY_PKG_GAME_RUN_MODE_TYPE] = "predownload"
  }
  UIM.set_predownload_game_mode(predownload_game_info)
  CC.add_init_namespace(M.PREDOWNLOAD_NAMESPACE)
  M.ProductId = sdk_meta_configs[M.CONFIG_KEYS.GAME_PRODUCT_ID] or nil
  M.Url = sdk_meta_configs[M.CONFIG_KEYS.URL]
  M.ProductEnv = sdk_meta_configs[M.CONFIG_KEYS.SDK_SERVER_ENV] or "release"
  M.Options = sdk_meta_configs[M.CONFIG_KEYS.OPTIONS] or {}
  M.Orientation = sdk_meta_configs[M.CONFIG_KEYS.ORIENTATION]
  local config_query_pkgnames = sdk_meta_configs[M.CONFIG_KEYS.QUERY_PULLUP_PKGNAMES]
  M.QueryPullUpPkgNames = parse_query_pullup_pkgnames(config_query_pkgnames)
  M.DisableAutoLogin = sdk_meta_configs[M.CONFIG_KEYS.WEBOPEN_FIRST] or false
  PC.DownloadWithStrategyEnabled = sdk_meta_configs[M.CONFIG_KEYS.DOWNLOAD_WITH_STRATEGY] or false
  local is_overseas = sdk_meta_configs[M.CONFIG_KEYS.OVERSEAS]
  if nil == is_overseas then
    is_overseas = true
  end
  M.IsOverSeas = is_overseas
  local config_params = {
    open_log = M.DEBUG_OPTIONS.Debug,
    env = M.ProductEnv,
    overseas = is_overseas,
    open_app_version_update_check = true
  }
  ejoysdk_init.config(M.ProductId, config_params)
  local sdk_list = params.sdk_list or {}
  
  local function retry_init(interval)
    if false == is_gp_inited and current_init_retry_times <= 20 then
      E.Timer.once(interval, function()
        E.LOG.debug(TAG, "retry init, retry_times:" .. tostring(current_init_retry_times))
        current_init_retry_times = current_init_retry_times + 1
        ejoysdk_init.init()
      end)
    end
  end
  
  listen_h5_res_config_check_complete()
  E.LOG.debug(TAG, "predownload init begin")
  ejoysdk_topic.subscribe(ejoysdk_init.SUBSCRIBE_GANGPLANK_INITED, function(succ, ...)
    if succ then
      is_gp_inited = true
      E.LOG.debug(TAG, "predownload init succ")
      Utils.notify(cb, 200, "init succ", {
        vm = "predownload"
      })
      if M.IsOverSeas then
        local overseas_login = require("ejoysdk_lua.overseas.login")
        overseas_login.inject_webview_options({disable_backkey_press = true})
      end
      if not M.DisableAutoLogin then
        E.LOG.debug(TAG, "auto_login enabled, now begin login")
        auto_login(function()
          E.LOG.debug(TAG, "auto login succ, now begin show web page")
          show_main_web_page()
        end)
      else
        E.LOG.debug(TAG, "NOT auto login, now begin show web page")
        show_main_web_page()
      end
    else
      local code, error_msg = ...
      Utils.notify(cb, -1, error_msg or "init failed", {
        code = code or -1,
        vm = "predownload"
      })
      E.LOG.warn(TAG, "predownload init failed:" .. tostring(code) .. ", msg:" .. tostring(error_msg))
      retry_init(current_init_retry_times)
    end
  end)
  local vendors = sdk_list
  ejoysdk_init.gangplank(vendors, {
    auth_listener = auth_listener,
    acquire_listener = acquire_listener,
    logout_listener = logout_listener,
    exit_listener = exit_listener
  })
  ejoysdk_init.init()
end

return M
