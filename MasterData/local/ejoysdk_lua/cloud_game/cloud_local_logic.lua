local EG = require("ejoysdk_lua.ejoysdk_gangplank")
local message = require("ejoysdk_lua.cloud_game.message").create()
local BL = require("ejoysdk_lua.cloud_game.base_logic")
local E = require("ejoysdk_lua.ejoysdk")
local STAT = require("ejoysdk_lua.ejoysdk_stat")
local CSTAT = require("ejoysdk_lua.cloud_game.cloud_stat")
local ET = require("ejoysdk_lua.ejoysdk_topic")
local cloud_config = require("ejoysdk_lua.cloud_game.cloud_config")
local user_info = require("ejoysdk_lua.user_info_manager")
local EM = require("ejoysdk_lua.ejoysdk_module")
local CSM = require("ejoysdk_lua.cloud_game.cloud_connect_statemachine")
local CC = require("ejoysdk_lua.ejoysdk_constants")
local M = {}
local TAG = EM.MODULE.CLOUD_GAME .. "cloud_local_logic"
local activity_foreground_state

local function init_applog()
  E.LOG.debug(TAG, "init_applog begin")
  local uni = require("ejoysdk_lua.vendors.unisdk")
  local sdk_infos = uni.get_sdk_infos()
  local app_config_info = sdk_infos.APPLOG
  local app_opt = {}
  if app_config_info and app_config_info.meta then
    app_opt = app_config_info.meta
  end
  
  local function app_log_init_cb(succ)
    E.LOG.debug(TAG, "init_applog app init result:" .. tostring(succ))
  end
  
  message:invoke_remote(nil, "vendors.applog", "init", {app_opt, app_log_init_cb})
end

function M.init_remote_modules()
  init_applog()
end

function M.on_remote_init_succ()
  E.LOG.debug(TAG, "remote init succ, now do local logics")
  M.init_remote_modules()
end

function M.notify_remote_local_device_info()
  local function cb(data)
    E.LOG.debug(TAG, "notify local device info to remote " .. tostring(data))
    
    local msg_content = {
      type = "device_info",
      content = data
    }
    local error_handler = {
      cb = function(code, msg)
        E.LOG.debug(TAG, "invoke remote logic receive message error code >> " .. code .. ", msg >> " .. msg)
      end
    }
    message:invoke_remote(error_handler, "cloud_game.cloud_remote_logic", "receive_message", {msg_content})
  end
  
  E.LOG.debug(TAG, "get device info then sync to remote >>  ")
  user_info.get_device_info_async(cb)
end

local INJECT_METHODS = {
  ["ejoysdk_lua.ejoysdk_gangplank"] = {
    logout = function(origin_method, ...)
      origin_method(...)
      E.LOG.debug(TAG, "start call remote logout")
      message:invoke_remote(nil, "ejoysdk_gangplank", "logout", {
        ...
      })
    end,
    open_user_center = function(_origin_method, ...)
      E.LOG.debug(TAG, "start call open_user_center")
      _origin_method(...)
      STAT.stat_action("cloud_request_mini_client_usercenter_page_success")
    end
  },
  ["ejoysdk_lua.vendors.aligames"] = {
    show_user_center = function(_origin_method, ...)
      E.LOG.debug(TAG, "aligames user_center show call begin")
      _origin_method(...)
      STAT.stat_action("cloud_request_mini_client_usercenter_page_success")
    end
  },
  ["ejoysdk_lua.user_info_manager"] = {
    get_device_info_async = function(_origin_method, ...)
      E.LOG.debug(TAG, "receive remote call local device_info")
      _origin_method(...)
      M.on_remote_init_succ()
    end
  }
}

local function login_handler()
  E.LOG.debug(TAG, "login_handler, receive login from remote")
  ET.publish(ET.analytics.LOGIN, EG.user_info())
end

local function activity_state_change_handler(state_info)
  local state = ""
  if state_info then
    state = state_info.state or ""
  end
  activity_foreground_state = state
  E.LOG.debug(TAG, "receive activity_state_change_handler:" .. tostring(state))
  message:invoke_remote(nil, "ejoysdk_topic", "publish", {
    cloud_config.CLOUD_TOPIC.TOPIC_ACTIVITY_STATE_CHANGED,
    state
  })
end

local function lang_config_changed(value)
  E.LOG.debug(TAG, "received lang_config_changed:" .. tostring(value))
  local ejoy_lang = require("ejoysdk_lua.ejoysdk_lang")
  ejoy_lang.set(value)
end

function M.init_message()
  E.LOG.debug(TAG, "begin init_message")
  BL.inject_methods(INJECT_METHODS)
  local gp_listener = EG.get_listener()
  
  function gp_listener.exit_listener(...)
    local succ = (...)
    E.LOG.debug(TAG, "exit_listener succ:" .. tostring(succ))
    if succ then
      E.LOG.debug(TAG, "exit, invoke_remote ejoysdk_topic publish ET.gangplank.EXIT")
      message:invoke_remote(nil, "ejoysdk_topic", "publish", {
        ET.gangplank.EXIT
      })
      local cloud_adapter = require("ejoysdk_lua.cloud_game.cloud_adapter")
      cloud_adapter.exit_app()
    else
      E.LOG.debug(TAG, "exit cancelled")
    end
  end
  
  EG.set_listener(gp_listener)
  E.LOG.debug(TAG, "init_message register_handle >>")
  message:rpc_register_handle("acquire_token", function(_error_response, response, ...)
    local listener = EG.get_listener()
    local origin_acquire_listener = listener.acquire_listener
    if CSM.is_connect_pause() then
      E.LOG.debug(TAG, "cloud connect state is pause, do not require")
      origin_acquire_listener(false, CC.GANGPLANK_ERROR_CODE.GANGPLANK_ACQ_FAIL_WITH_STOP_STATE, "acquire not complete in pause state", {})
      response(nil, false, CC.GANGPLANK_ERROR_CODE.GANGPLANK_ACQ_FAIL_WITH_STOP_STATE, "acquire not complete in pause state", {})
      return
    end
    if "onStop" == activity_foreground_state then
      E.LOG.warn(TAG, "acquire received in stop state, now return failed")
      origin_acquire_listener(false, CC.GANGPLANK_ERROR_CODE.GANGPLANK_ACQ_FAIL_WITH_STOP_STATE, "acquire not complete in stop state", {})
      response(nil, false, CC.GANGPLANK_ERROR_CODE.GANGPLANK_ACQ_FAIL_WITH_STOP_STATE, "acquire not complete in stop state", {})
      return
    end
    E.LOG.debug(TAG, "set the cloud require listener")
    
    function listener.acquire_listener(succ, ...)
      local uinfo = EG.user_info()
      response(uinfo, succ, ...)
      if succ then
        E.LOG.debug(TAG, "send response succ to remote")
        STAT.stat_action("mini_client_lingxi_login_complete_request_cloud", nil, true)
      else
        local code, msg = ...
        E.LOG.warn(TAG, "send response failed to remote, code:" .. tostring(code) .. ", msg:" .. tostring(msg))
        STAT.stat_action_fail("mini_client_lingxi_login_complete_request_cloud", nil, code, msg)
      end
      E.LOG.debug(TAG, "reset the origin listener")
      listener.acquire_listener = origin_acquire_listener
      EG.set_listener(listener)
    end
    
    EG.set_listener(listener)
    EG.acquire_token(...)
    CSTAT.stat_action("mini_client_recieve_login_frequency")
  end)
  message:rpc_register_handle("pay", function(_error_response, response, ...)
    if CSM.is_connect_pause() then
      E.LOG.debug(TAG, "cloud connect state is pause, do not pay")
      return
    end
    local listener = EG.get_listener()
    local origin_pay_listener = listener.pay_listener
    E.LOG.debug(TAG, "[cloud game] pay ")
    E.LOG.debug(TAG, "set the cloud pay listener")
    
    function listener.pay_listener(...)
      E.LOG.debug(TAG, "[cloud game] pay_listener ")
      response(...)
      E.LOG.debug(TAG, "reset the origin listener")
      listener.pay_listener = origin_pay_listener
      EG.set_listener(listener)
    end
    
    EG.set_listener(listener)
    EG.pay(...)
  end)
  ET.subscribe(ET.gangplank.LOGIN, login_handler)
  ET.subscribe(cloud_config.CLOUD_TOPIC.TOPIC_ACTIVITY_STATE_CHANGED_INNER, activity_state_change_handler)
  ET.subscribe(ET.config.CONFIG_CHANGED .. "_" .. "lang", lang_config_changed)
end

function M.get_msg()
  return message
end

function M.init_sdk()
end

return M
