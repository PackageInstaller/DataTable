local EG = require("ejoysdk_lua.ejoysdk_gangplank")
local message = require("ejoysdk_lua.cloud_game.message").create()
local E = require("ejoysdk_lua.ejoysdk")
local INFO_MGR = require("ejoysdk_lua.user_info_manager")
local EC = require("ejoysdk_lua.ejoysdk_constants")
local BL = require("ejoysdk_lua.cloud_game.base_logic")
local STAT = require("ejoysdk_lua.ejoysdk_stat")
local ET = require("ejoysdk_lua.ejoysdk_topic")
local cloud_config = require("ejoysdk_lua.cloud_game.cloud_config")
local EM = require("ejoysdk_lua.ejoysdk_module")
local M = {}
local TAG = EM.MODULE.CLOUD_GAME .. "cloud_remote_logic"
local TOPICS_NEED_NOTIFY_LOCAL_LOGIC = {
  [ET.config.CONFIG_CHANGED .. "_" .. "lang"] = true
}
local SYNC_DEVICE_DATA_CONFIG = {TIME_OUT = 3, RETRY_INTERVAL = 3}
local MAX_RETRY_TIMES = 10
local set_player_retry_times = 0
local current_set_player_id

local function invoke_stat_action(action, action_type, result, params)
  if E.Sysinfo.os() == "windows" then
    E.LOG.warn(TAG, "windows doesnt have jf plugin, now need call remote")
    local _params = params or {}
    _params.stat_invoke_src = "windows"
    _params.is_priority_high = true
    local _action_type = action_type or ""
    local _result = result or true
    message:invoke_remote(nil, "ejoysdk_stat", "stat_action", {
      action,
      _action_type,
      _result,
      _params
    })
  else
    STAT.stat_action(action, action_type, result, params)
  end
end

local function invoke_stat_action_fail(action, action_type, code, msg)
  if E.Sysinfo.os() == "windows" then
    E.LOG.warn(TAG, "windows doesnt have jf plugin, now need call remote")
    local params = {}
    params.code = code
    params.msg = msg
    params.stat_invoke_src = "windows"
    local _action_type = action_type or ""
    message:invoke_remote(nil, "ejoysdk_stat", "stat_action_fail", {
      action,
      _action_type,
      params
    })
  else
    STAT.stat_action_fail(action, action_type, code, msg)
  end
end

local INJECT_METHODS = {
  ["ejoysdk_lua.ejoysdk_gangplank"] = {
    acquire_token = function(_origin_method, ...)
      local function acquire_listener(user_info, succ, ...)
        E.LOG.debug(TAG, "_user_info callback >>")
        
        E.LOG.debug(TAG, user_info)
        EG.set_user_info(user_info)
        EG.get_listener().acquire_listener(succ, ...)
        if succ then
          E.LOG.debug(TAG, "receive response succ from mobile")
          invoke_stat_action("cloud_recieve_login_token_frequency", nil, true)
        else
          local code, msg = ...
          E.LOG.warn(TAG, "receive response succ from mobile, code:" .. tostring(code) .. ", msg:" .. tostring(msg))
          invoke_stat_action_fail("cloud_recieve_login_token_frequency", nil, code, msg)
        end
      end
      
      local err_handler = message:rpc_create_error_handle(function(err_code, err_msg)
        E.LOG.warn(TAG, "acquire_token failed, err_code:" .. tostring(err_code) .. ", msg:" .. tostring(err_msg))
        acquire_listener({}, false, err_code, err_msg)
      end)
      message:rpc_request(err_handler, acquire_listener, "acquire_token", ...)
      invoke_stat_action("cloud_request_mini_client_login")
    end,
    pay = function(_origin_method, ...)
      local function pay_listener(succ, ...)
        if succ then
          E.LOG.debug(TAG, "pay succ")
        else
          local _order_id, code, msg, ext = ...
          E.LOG.warn(TAG, "pay failed, code: " .. tostring(code) .. ", msg:" .. tostring(msg) .. ", ext >")
          E.LOG.debug(TAG, ext)
        end
        EG.get_listener().pay_listener(succ, ...)
      end
      
      local vendor_name, product_id = ...
      E.LOG.debug(TAG, "start call remote pay, vendor_name:" .. tostring(vendor_name) .. ", productId:" .. tostring(product_id))
      local err_handler = message:rpc_create_error_handle(function(err_code, err_msg)
        E.LOG.warn(TAG, "pay failed, err_code:" .. tostring(err_code) .. ", msg:" .. tostring(err_msg))
        pay_listener({}, false, err_code, err_msg)
      end)
      message:rpc_request(err_handler, pay_listener, "pay", ...)
      invoke_stat_action("cloud_request_mini_client_pay")
    end,
    set_player_info = function(origin_method, ...)
      origin_method(...)
      E.LOG.debug(TAG, "start call remote set_player_info")
      local _player_info, _player_info_type, _cb = ...
      current_set_player_id = _player_info and _player_info.player_id
      local error_handler
      error_handler = {
        cb = function(code, msg)
          E.LOG.debug(TAG, "set player_info error >> code: " .. tostring(code) .. ", msg: " .. tostring(msg))
          E.Timer.once(SYNC_DEVICE_DATA_CONFIG.RETRY_INTERVAL, function()
            local retrying_player_id = _player_info and _player_info.player_id
            if set_player_retry_times > MAX_RETRY_TIMES or current_set_player_id ~= retrying_player_id then
              E.LOG.warn(TAG, "current retrying player_id not equals current set player_id, skip retry:" .. tostring(set_player_retry_times) .. ", curp:" .. tostring(current_set_player_id) .. ", rp:" .. tostring(retrying_player_id))
              return
            end
            set_player_retry_times = set_player_retry_times + 1
            E.LOG.debug(TAG, "retry set_player_info, time is " .. tostring(os.time()) .. ", player_id:" .. tostring(retrying_player_id))
            message:invoke_remote(error_handler, "ejoysdk_gangplank", "set_player_info", {
              _player_info,
              _player_info_type,
              _cb
            })
          end)
        end
      }
      set_player_retry_times = 0
      message:invoke_remote(error_handler, "ejoysdk_gangplank", "set_player_info", {
        ...
      })
    end,
    qrcode_scan = function(_origin_method, ...)
      E.LOG.debug(TAG, "start call remote ejoysdk_gangplank qrcode_scan")
      message:invoke_remote(nil, "ejoysdk_gangplank", "qrcode_scan", {
        ...
      })
    end,
    grant_login_uuid = function(_origin_method, ...)
      E.LOG.debug(TAG, "start call remote ejoysdk_gangplank grant_login_uuid")
      message:invoke_remote(nil, "ejoysdk_gangplank", "grant_login_uuid", {
        ...
      })
    end,
    cancel_query_qrcode_login = function(_origin_method, ...)
      E.LOG.debug(TAG, "start call remote ejoysdk_gangplank cancel_query_qrcode_login")
      message:invoke_remote(nil, "ejoysdk_gangplank", "cancel_query_qrcode_login", {
        ...
      })
    end,
    exit = function(_origin_method, ...)
      E.LOG.debug(TAG, "start call remote exit")
      message:invoke_remote(nil, "ejoysdk_gangplank", "exit", {
        ...
      })
    end,
    open_user_center = function(_origin_method, ...)
      E.LOG.debug(TAG, "start call open_user_center")
      message:invoke_remote(nil, "ejoysdk_gangplank", "open_user_center", {
        ...
      })
      invoke_stat_action("cloud_request_mini_client_usercenter", nil, true)
    end,
    get_product_list = function(_origin_method, ...)
      E.LOG.debug(TAG, "start call get_product_list")
      local channel, get_product_cb = ...
      
      local function remote_cb(succ, ...)
        if succ then
          local product_list = (...)
          E.LOG.debug(TAG, "get_product_list callback:" .. tostring(succ) .. ", data >>")
          E.log(product_list)
        else
          local code, msg = ...
          E.LOG.warn(TAG, "get_product_list callback:" .. tostring(succ) .. ", code:" .. tostring(code) .. ", msg:" .. tostring(msg))
        end
        get_product_cb(succ, ...)
      end
      
      message:invoke_remote(nil, "ejoysdk_gangplank", "get_product_list", {channel, remote_cb})
    end,
    get_ip_location_async = function(_origin_method, ...)
      E.LOG.debug(TAG, "start call remote get_ip_location_async")
      message:invoke_remote(nil, "ejoysdk_gangplank", "get_ip_location_async", {
        ...
      })
    end,
    get_recommend_servers = function(_origin_method, ...)
      local _params1, _cb1 = ...
      _params1 = _params1 or {}
      E.LOG.debug(TAG, "start call remote get_recommend_servers")
      message:invoke_remote(nil, "ejoysdk_gangplank", "get_recommend_servers", {_params1, _cb1})
    end
  },
  ["ejoysdk_lua.social.ejoysdk_social"] = {
    is_support = function(_origin_method, ...)
      E.LOG.debug(TAG, "share is_support always false")
      invoke_stat_action_fail("cloud_request_mini_client_share", nil, EC.CLOUD_GAME_ERROR_CODES.NOT_SUPPORT)
      return false
    end,
    is_support_v2 = function(_origin_method, ...)
      E.LOG.debug(TAG, "share is_support_v2 always false")
      invoke_stat_action_fail("cloud_request_mini_client_share", nil, EC.CLOUD_GAME_ERROR_CODES.NOT_SUPPORT)
      return false
    end,
    share = function(_origin_method, ...)
      E.LOG.debug(TAG, "social share is not support in cloud game")
      invoke_stat_action_fail("cloud_request_mini_client_share", nil, EC.CLOUD_GAME_ERROR_CODES.NOT_SUPPORT)
      local _platform, _param, cb = ...
      local err_msg = "云游戏暂时不支持该功能，请在游戏下载完资源后重试"
      E.Toast.show(err_msg)
      E.Timer.once(3, E.Toast.hide)
      if cb then
        cb({
          code = EC.CLOUD_GAME_ERROR_CODES.NOT_SUPPORT,
          msg = err_msg
        })
      end
    end
  },
  ["ejoysdk_lua.vendors.aligames"] = {
    can_show_user_center = function(_origin_method, ...)
      local channel = E.get_pkg_info().channel_id
      E.LOG.debug(TAG, "aligames user_center could not show:" .. tostring(channel))
      return "998233" == channel or "998236" == channel
    end,
    show_user_center = function(_origin_method, ...)
      E.LOG.debug(TAG, "aligames user_center show call begin")
      message:invoke_remote(nil, "vendors.aligames", "show_user_center", {
        ...
      })
      invoke_stat_action("cloud_request_mini_client_usercenter", nil, true)
    end,
    show_custom_service = function(_origin_method, ...)
      E.LOG.debug(TAG, "aligames custom_service could not show")
      invoke_stat_action_fail("cloud_request_mini_client_customer_service", nil, EC.CLOUD_GAME_ERROR_CODES.NOT_SUPPORT)
      E.Toast.show("云游戏暂时不支持该功能，请在游戏下载完资源后重试")
      E.Timer.once(3, E.Toast.hide)
      local _params, cb = ...
      if cb then
        cb(false)
      end
    end,
    custom_service = function(_origin_method, ...)
      E.LOG.debug(TAG, "aligames custom_service could show")
      invoke_stat_action_fail("cloud_request_mini_client_customer_service", nil, EC.CLOUD_GAME_ERROR_CODES.NOT_SUPPORT)
      message:invoke_remote(nil, "vendors.aligames", "custom_service", {
        ...
      })
    end
  },
  ["ejoysdk_lua.ejoysdk"] = {
    Media = {
      start_record = function(_origin_method, ...)
        E.LOG.debug(TAG, "Media.start_record not support")
        invoke_stat_action_fail("cloud_request_mini_client_record", nil, EC.CLOUD_GAME_ERROR_CODES.NOT_SUPPORT)
        local err_msg = "云游戏暂时不支持该功能，请在游戏下载完资源后重试"
        E.Toast.show(err_msg)
        E.Timer.once(3, E.Toast.hide)
        local _opts, cb = ...
        if cb then
          local cb_info = {succ = false, message = err_msg}
          cb(cb_info)
        end
      end
    },
    support_save_to_album = function(_origin_method, ...)
      E.LOG.debug(TAG, "save_to_album is always false")
      return false
    end,
    save_to_album = function(_origin_method, ...)
      local _path, _need_delete, cb = ...
      local err_msg = "云游戏暂时不支持该功能，请在游戏下载完资源后重试"
      E.Toast.show(err_msg)
      E.Timer.once(3, E.Toast.hide)
      if cb then
        cb({
          code = EC.CLOUD_GAME_ERROR_CODES.NOT_SUPPORT,
          msg = err_msg
        })
      end
    end,
    Sysinfo = {
      cutout_async = function(_origin_method, ...)
        message:invoke_remote(nil, "ejoysdk", "Sysinfo.cutout_async", {
          ...
        })
      end,
      open_url = function(_origin_method, ...)
        message:invoke_remote(nil, "ejoysdk", "Sysinfo.open_url", {
          ...
        })
      end
    },
    WebView = {
      open = function(_origin_method, ...)
        message:invoke_remote(nil, "ejoysdk", "WebView.open", {
          ...
        })
      end,
      close = function(_origin_method, ...)
        message:invoke_remote(nil, "ejoysdk", "WebView.close", {
          ...
        })
      end
    },
    Permission = {
      setting_dialog = function(_origin_method, ...)
        message:invoke_remote(nil, "ejoysdk", "Permission.setting_dialog", {
          ...
        })
      end,
      openSetting = function(_origin_method, ...)
        local err_msg = "云游戏暂时不支持该功能，请在游戏下载完资源后重试"
        E.Toast.show(err_msg)
        E.Timer.once(3, E.Toast.hide)
      end
    },
    Sensor = {
      register_shake = function(_origin_method, ...)
        message:invoke_remote(nil, "ejoysdk", "Sensor.register_shake", {
          ...
        })
      end,
      unregister_shake = function(_origin_method, ...)
        message:invoke_remote(nil, "ejoysdk", "Sensor.unregister_shake", {
          ...
        })
      end,
      is_shake_support = function(_origin_method, ...)
        message:invoke_remote(nil, "ejoysdk", "Sensor.is_shake_support", {
          ...
        })
      end
    },
    Toast = {
      show = function(_origin_method, ...)
        message:invoke_remote(nil, "ejoysdk", "Toast.show", {
          ...
        })
      end,
      hide = function(_origin_method, ...)
        message:invoke_remote(nil, "ejoysdk", "Toast.hide", {
          ...
        })
      end
    },
    get_brightness = function(_origin_method, ...)
      message:invoke_remote(nil, "ejoysdk", "get_brightness", {
        ...
      })
    end,
    set_brightness = function(_origin_method, ...)
      message:invoke_remote(nil, "ejoysdk", "set_brightness", {
        ...
      })
    end,
    reset_brightness = function(_origin_method, ...)
      message:invoke_remote(nil, "ejoysdk", "reset_brightness", {
        ...
      })
    end,
    vibrate = function(_origin_method, ...)
      message:invoke_remote(nil, "ejoysdk", "vibrate", {
        ...
      })
    end,
    is_vibrate_support = function(_origin_method, ...)
      message:invoke_remote(nil, "ejoysdk", "is_vibrate_support", {
        ...
      })
    end
  },
  ["ejoysdk_lua.push.ejoysdk_push"] = {
    add_local_notification = function(_origin_method, ...)
      E.LOG.debug(TAG, "ejoysdk_push add_local_notification")
      invoke_stat_action("cloud_request_mini_client_add_local_notification", nil, true)
      message:invoke_remote(nil, "push.ejoysdk_push", "add_local_notification", {
        ...
      })
    end,
    remove_local_notification = function(_origin_method, ...)
      E.LOG.debug(TAG, "ejoysdk_push remove_local_notification")
      invoke_stat_action("cloud_request_mini_client_remove_local_notification", nil, true)
      message:invoke_remote(nil, "push.ejoysdk_push", "remove_local_notification", {
        ...
      })
    end,
    remove_all_local_notification = function(_origin_method, ...)
      E.LOG.debug(TAG, "ejoysdk_push remove_all_local_notification")
      invoke_stat_action("cloud_request_mini_client_remove_all_local_notification", nil, true)
      message:invoke_remote(nil, "push.ejoysdk_push", "remove_all_local_notification", {
        ...
      })
    end
  },
  ["ejoysdk_lua.vendors.unisdk"] = {
    cast = function(origin_method, ...)
      local channel, type_, _params, _chunk = ...
      if "APPLOG" == channel and "CAST_SERVER_PURCHASE_SUCC" == type_ then
        E.LOG.debug(TAG, "hook applog CAST_PURCHASE_SUCC")
        message:invoke_remote(nil, "vendors.unisdk", "cast", {
          ...
        })
      else
        origin_method(...)
      end
    end
  },
  ["ejoysdk_lua.vendors.lbs"] = {
    get_location = function(_origin_method, ...)
      E.LOG.debug(TAG, "ejoysdk_push lbs get_location")
      message:invoke_remote(nil, "vendors.lbs", "get_location", {
        ...
      })
    end,
    detect_location_permission = function(_origin_method, ...)
      E.LOG.debug(TAG, "ejoysdk_push lbs detect_location_permission")
      message:invoke_remote(nil, "vendors.lbs", "detect_location_permission", {
        ...
      })
    end
  },
  ["ejoysdk_lua.custom.ejoysdk_custom_service"] = {
    show_custom_service = function(_origin_method, ...)
      E.LOG.debug(TAG, "hook ejoysdk_custom_service show_custom_service")
      local params, show_cb = ...
      
      local function show_cb_wrapper(succ, ...)
        if succ then
          E.LOG.debug(TAG, "show show_custom_service succ")
        else
          local code, msg = ...
          E.LOG.debug(TAG, "show show_custom_service failed, code:" .. tostring(code) .. ", msg:" .. tostring(msg))
        end
        show_cb(succ, ...)
      end
      
      message:invoke_remote(nil, "custom.ejoysdk_custom_service", "show_custom_service", {params, show_cb_wrapper})
    end
  },
  ["ejoysdk_lua.ejoysdk_lang"] = {
    set_lang_list = function(origin_method, ...)
      E.LOG.debug(TAG, "hook ejoysdk_lua.ejoysdk_lang set_lang_list method>>")
      origin_method(...)
      message:invoke_remote(nil, "ejoysdk_lang", "set_lang_list", {
        ...
      })
    end,
    set = function(origin_method, ...)
      E.LOG.debug(TAG, "hook ejoysdk_lua.ejoysdk_lang set method>>")
      origin_method(...)
      message:invoke_remote(nil, "ejoysdk_lang", "set", {
        ...
      })
    end
  },
  ["ejoysdk_lua.ejoysdk_topic"] = {
    publish = function(origin_method, ...)
      local topic = (...)
      E.LOG.debug(TAG, "hook ejoysdk_topic publish topic:" .. tostring(topic))
      origin_method(...)
      if true == TOPICS_NEED_NOTIFY_LOCAL_LOGIC[topic] then
        E.LOG.debug(TAG, "send topic to local, topic:" .. tostring(topic))
        message:invoke_remote(nil, "ejoysdk_topic", "publish", {
          ...
        })
      end
    end
  },
  ["ejoysdk_lua.ejoysdk_community"] = {
    open = function(_origin_method, ...)
      local topic = (...)
      E.LOG.debug(TAG, "hook ejoysdk_lua.ejoysdk_community open topic:" .. tostring(topic))
      message:invoke_remote(nil, "ejoysdk_community", "open", {
        ...
      })
    end,
    open_with_option = function(_origin_method, ...)
      local topic = (...)
      E.LOG.debug(TAG, "hook ejoysdk_lua.ejoysdk_community open_with_option topic:" .. tostring(topic))
      message:invoke_remote(nil, "ejoysdk_community", "open_with_option", {
        ...
      })
    end,
    open_from_webview = function(_origin_method, ...)
      local topic = (...)
      E.LOG.debug(TAG, "hook ejoysdk_lua.ejoysdk_community open_from_webview topic:" .. tostring(topic))
      message:invoke_remote(nil, "ejoysdk_community", "open_from_webview", {
        ...
      })
    end,
    register = function(_origin_method, ...)
      local topic = (...)
      E.LOG.debug(TAG, "hook ejoysdk_lua.ejoysdk_community register topic:" .. tostring(topic))
      message:invoke_remote(nil, "ejoysdk_community", "register", {
        ...
      }, true)
    end,
    is_support_shortcut = function(_origin_method, ...)
      local topic = (...)
      E.LOG.debug(TAG, "hook ejoysdk_lua.ejoysdk_community is_support_shortcut topic:" .. tostring(topic))
      message:invoke_remote(nil, "ejoysdk_community", "is_support_shortcut", {
        ...
      })
    end,
    add_shortcut = function(_origin_method, ...)
      local topic = (...)
      E.LOG.debug(TAG, "hook ejoysdk_lua.ejoysdk_community add_shortcut topic:" .. tostring(topic))
      message:invoke_remote(nil, "ejoysdk_community", "add_shortcut", {
        ...
      })
    end
  },
  ["ejoysdk_lua.shortcut.ejoysdk_shortcut_webview"] = {
    open_webview = function(_origin_method, ...)
      local versions = E.get_pkg_info().versions
      local lua_version = versions and versions.lua_version
      local version_check = require("ejoysdk_lua.ejoysdk_version_check")
      local result = version_check.compare_versions(lua_version, "3.1.22")
      if tonumber(result) >= 0 then
        E.LOG.debug(TAG, "hook ejoysdk_lua.ejoysdk_shortcut_webview open")
        message:invoke_remote(nil, "shortcut.ejoysdk_shortcut_webview", "open_webview", {
          ...
        })
        return
      end
      E.LOG.debug(TAG, "old_version, hook ejoysdk_lua.ejoysdk_community open_with_option")
      local _biz_type, _params, _option, _on_callbacks = ...
      message:invoke_remote(nil, "ejoysdk_community", "open_with_option", {
        _params,
        _option,
        _on_callbacks
      })
    end,
    register = function(_origin_method, ...)
      local versions = E.get_pkg_info().versions
      local lua_version = versions and versions.lua_version
      local version_check = require("ejoysdk_lua.ejoysdk_version_check")
      local result = version_check.compare_versions(lua_version, "3.1.22")
      if tonumber(result) >= 0 then
        E.LOG.debug(TAG, "hook ejoysdk_lua.ejoysdk_shortcut_webview register")
        message:invoke_remote(nil, "shortcut.ejoysdk_shortcut_webview", "register", {
          ...
        })
        return
      end
      local _biz_type, _on_callbacks = ...
      E.LOG.debug(TAG, "hook ejoysdk_community register")
      message:invoke_remote(nil, "ejoysdk_community", "register", {_on_callbacks}, true)
    end
  },
  ["ejoysdk_lua.qrcode.ejoysdk_qrcode"] = {
    qrcode_scan = function(_origin_method, ...)
      local topic = (...)
      E.LOG.debug(TAG, "hook ejoysdk_lua.qrcode.ejoysdk_qrcode qrcode_scan topic:" .. tostring(topic))
      message:invoke_remote(nil, "qrcode.ejoysdk_qrcode", "qrcode_scan", {
        ...
      })
    end,
    grant_qrcode = function(_origin_method, ...)
      local topic = (...)
      E.LOG.debug(TAG, "hook ejoysdk_lua.qrcode.ejoysdk_qrcode grant_qrcode topic:" .. tostring(topic))
      message:invoke_remote(nil, "qrcode.ejoysdk_qrcode", "grant_qrcode", {
        ...
      })
    end
  },
  ["ejoysdk_lua.ejoysdk_web"] = {
    open_webview = function(_origin_method, ...)
      local url, hosts, params, _screen_orientation, on_js_callback, on_close_callback = ...
      hosts = hosts or {}
      params = params or {}
      _screen_orientation = _screen_orientation or "landscape"
      on_js_callback = on_js_callback or function()
      end
      on_close_callback = on_close_callback or function()
      end
      message:invoke_remote(nil, "ejoysdk_web", "open_webview", {
        url,
        hosts,
        params,
        _screen_orientation,
        on_js_callback,
        on_close_callback
      })
    end
  }
}
local is_device_info_sync = false

local function handle_device_data(data)
  if data then
    is_device_info_sync = true
    E.LOG.debug(TAG, "handle_device_data received data >>")
    E.log(data)
    if not data or next(data) == nil then
      E.LOG.warn(TAG, "sync_device_data failed, data is nil")
      return
    end
    local infos = data
    local pkg_info = infos[INFO_MGR.INFO_KEY.KEY_PKG_INFO]
    local aegis_info = infos[INFO_MGR.INFO_KEY.KEY_AEGIS_INFO]
    local trace_id = infos[INFO_MGR.INFO_KEY.KEY_TRACE_ID]
    INFO_MGR.set_pkg_info(pkg_info)
    INFO_MGR.set_aegis_info(aegis_info)
    INFO_MGR.set_trace_id(trace_id)
  end
end

function M.receive_message(_message)
  E.LOG.debug(TAG, "receive message from client >> " .. tostring(_message))
  if _message and _message.type == "device_info" then
    handle_device_data(_message.content)
  end
end

local function sync_device_data()
  if is_device_info_sync then
    E.LOG.debug(TAG, "device info had sync")
    return
  end
  E.LOG.debug(TAG, "start sync_device_data")
  
  local function callback(data)
    handle_device_data(data)
  end
  
  local error_handler
  error_handler = {
    cb = function(code, msg)
      E.LOG.debug(TAG, "sync device data error >> code: " .. tostring(code) .. ", msg: " .. tostring(msg))
      E.Timer.once(SYNC_DEVICE_DATA_CONFIG.RETRY_INTERVAL, function()
        if is_device_info_sync then
          E.LOG.debug(TAG, "device info had sync, stop retry")
          return
        end
        E.LOG.debug(TAG, "retry sync device data, time is " .. tostring(os.time()))
        message:invoke_remote(error_handler, "user_info_manager", "get_device_info_async", {callback})
      end)
    end
  }
  message:invoke_remote(error_handler, "user_info_manager", "get_device_info_async", {callback})
end

local function login_handler()
  E.LOG.debug(TAG, "login_handler, invoke_remote ejoysdk_topic publish ET.gangplank.LOGIN")
  message:invoke_remote(nil, "ejoysdk_topic", "publish", {
    ET.gangplank.LOGIN,
    EG.user_info()
  })
end

local function player_offline_handler()
  E.LOG.debug(TAG, "player_offline_handler received, and reset current_set_player_id")
  current_set_player_id = nil
end

function M.init_message()
  if cloud_config.DEBUG_OPTIONS.TestSendMessageFailed or not cloud_config.DEBUG_OPTIONS.TestRunCloudSingle then
    E.LOG.debug(TAG, "TestRunCloudSingle disable, begin hook remote methods")
    BL.inject_methods(INJECT_METHODS)
  else
    E.LOG.debug(TAG, "TestRunCloudSingle enable, NOT hook remote methods")
  end
  sync_device_data()
  ET.subscribe(ET.gangplank.LOGIN, login_handler)
  ET.subscribe(ET.gangplank.PLAYER_OFFLINE, player_offline_handler)
end

function M.on_remote_client_init()
  E.LOG.debug(TAG, "receive the client init finish msg, but do nothing now!")
end

function M.get_msg()
  return message
end

return M
