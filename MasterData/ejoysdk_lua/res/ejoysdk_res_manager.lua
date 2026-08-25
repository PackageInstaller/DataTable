local E = require("ejoysdk_lua.ejoysdk")
local EM = require("ejoysdk_lua.ejoysdk_module")
local STAT = require("ejoysdk_lua.res.res_stat")
local FLOW_TASK = require("ejoysdk_lua.libs.flow_task")
local CONSTANTS = require("ejoysdk_lua.ejoysdk_constants")
local EGC = require("ejoysdk_lua.ejoysdk_gangplank_config")
local ELU = require("ejoysdk_lua.res.ejoysdk_lua_update")
local PATCH_PATH_EJOYSDK_LUA = E.LazyKeyStore:New("PATCH_PATH_EJOYSDK_LUA", false, false, false)
local TAG = "LUA_UPDATE#" .. EM.MODULE.RES .. "ejoysdk_res_manager"
local debuggable = false
local M = {}
local RES_TYPE_EJOY_LUA = "ejoysdk_lua"
local init_callback

local function callback_global(succ, ...)
  if not succ then
    local code, msg = ...
    E.LOG.warn(TAG, "callback_global failed, code:" .. tostring(code) .. ", msg:" .. tostring(msg))
    local type = tostring(msg) .. ":" .. tostring(code)
    STAT.stat_err("lua_update_err", type, code, msg)
  else
    STAT.stat("lua_update_succ", nil, true)
  end
  if not init_callback then
    E.LOG.warn(TAG, "lua_update callback_global skip, no init_callback")
    return
  end
  
  local function to_native_result(succ_result, ...)
    local result = {}
    result.type = "formatted"
    if succ_result then
      result.result = true
      result.code = 200
      local result_body = (...)
      result.data = result_body
    else
      local code, msg, body = ...
      result.result = false
      result.code = code
      result.msg = msg
      result.data = body
    end
    return result
  end
  
  local result = to_native_result(succ, ...)
  init_callback(result)
end

local Task_res_init = FLOW_TASK:new("EJOY_RES_INIT")

function Task_res_init:run()
  E.LOG.debug(TAG, "begin run Task_res_init")
  
  local function res_init_callback(succ, ...)
    if succ then
      self:run_next()
    else
      local code, msg = ...
      E.LOG.debug(TAG, "init failed due to ejoysdk_res init failed, code:" .. tostring(code) .. ", msg:" .. tostring(msg))
      callback_global(false, ...)
    end
  end
  
  ELU.init(res_init_callback)
end

local function request_sdk_config(cb)
  EGC.init_config(function(succ, ...)
    if succ then
      E.LOG.debug(TAG, "init_config succ >>")
      STAT.init_jf()
      cb(true)
    else
      local status, message = ...
      E.LOG.warn(TAG, "init_config failed, status:" .. (status or "nil") .. ", message:" .. (message or "nil"))
      cb(false, status, message)
    end
  end)
end

local Task_request_config = FLOW_TASK:new("RES_CONFIG_REQ")

function Task_request_config:run()
  E.LOG.debug(TAG, "begin run Task_request_config")
  
  local function sdk_config_callback(succ, ...)
    if succ then
      E.LOG.debug(TAG, "request_sdk_config succ")
      self:run_next()
    else
      local code, msg = ...
      E.LOG.warn(TAG, "request_sdk_config failed, code:" .. tostring(code) .. ", msg:" .. tostring(msg))
      callback_global(false, code, msg)
    end
  end
  
  request_sdk_config(sdk_config_callback)
end

local function lua_res_update(cb)
  ELU.res_update(RES_TYPE_EJOY_LUA, function(succ, ...)
    if not succ then
      local code, _msg = ...
      if code == CONSTANTS.RESOURCE_UPDATE_ERROR_CODES.RES_CACHE_NOT_SUPPORT or code == CONSTANTS.RESOURCE_UPDATE_ERROR_CODES.RES_RES_UPDATE_FAILED or code == CONSTANTS.RESOURCE_UPDATE_ERROR_CODES.RES_NAMESPACE_CONFIG_NOT_EXIST or code == CONSTANTS.RESOURCE_UPDATE_ERROR_CODES.RES_RES_UPDATE_SWITCH_OFF or code == CONSTANTS.RESOURCE_UPDATE_ERROR_CODES.RES_RES_CONFIG_INVALID then
        E.LOG.warn(TAG, "code is " .. tostring(code) .. ", maybe lua_res_update with cache not support or namespace config not exist or lua update switch off or config_center api error")
        STAT.stat("res_update_warn", "not support", true, {
          not_support_err_code = tostring(code)
        })
        cb(true, {
          [ELU.RES_CONFIG_KEY.KEY_RESOURCE_UPDATED] = false
        })
        return
      end
    end
    E.LOG.debug(TAG, "lua update result is >>>")
    local config_info = (...)
    E.LOG.debug(TAG, config_info)
    E.LOG.debug(TAG, "update lua res complete, result is " .. tostring(succ))
    cb(succ, ...)
  end)
end

local Task_check_start_res = FLOW_TASK:new("CHECK_RES_STATE")

function Task_check_start_res:run()
  E.LOG.debug(TAG, "begin run Task_check_start_res")
  lua_res_update(function(succ, ...)
    if succ then
      local ejoysdk_lua_res_path = ELU.get_res_location()
      PATCH_PATH_EJOYSDK_LUA:set(ejoysdk_lua_res_path or "")
      E.LOG.debug(TAG, "set lua patch path: " .. tostring(ejoysdk_lua_res_path))
      local res_config_data = (...)
      res_config_data = res_config_data or {}
      local has_res_updated = res_config_data[ELU.RES_CONFIG_KEY.KEY_RESOURCE_UPDATED] or false
      local result_data = {}
      result_data.res_updated = has_res_updated
      E.LOG.debug(TAG, "lua_res_update succ, res_updated:" .. tostring(has_res_updated) .. ", update url:" .. tostring(ejoysdk_lua_res_path))
      callback_global(true, result_data)
    else
      local code, msg = ...
      E.LOG.warn(TAG, "lua_res_update failed for res ejoysdk_lua, code:" .. tostring(code) .. ", msg:" .. tostring(msg))
      callback_global(false, code, tostring(msg))
    end
  end)
end

function M.init(params, cb)
  init_callback = cb
  params = params or {}
  local is_oversea = params.overseas or false
  local EI = require("ejoysdk_lua.ejoysdk_init")
  EI.config(nil, params)
  E.LOG.debug(TAG, "init begin, debuggable:" .. tostring(debuggable) .. ", is_oversea:" .. tostring(is_oversea))
  if true == is_oversea then
    E.CONFIG.set_config(E.CONFIG.KEY.MULTI_REGIONS_ENABLED, true)
  end
  Task_res_init:SetSuccessor(Task_request_config)
  Task_request_config:SetSuccessor(Task_check_start_res)
  Task_res_init:run()
end

return M
