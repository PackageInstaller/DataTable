local E = require("ejoysdk_lua.ejoysdk")
local EC = require("ejoysdk_lua.ejoysdk_constants")
local ESTAT = require("ejoysdk_lua.ejoysdk_stat")
local _UNISDK = require("ejoysdk_lua.vendors.unisdk")
local TAG = "ej_calendar"
local M = {}
M.REMINDER_METHODS = {METHOD_ALERT = "alert"}
local permissions_request_listeners_readonly = {}
local permissions_request_listeners_writeonly = {}
local permissions_request_listeners_readwrite = {}

function M.is_support_calendar()
  local native_fun_support_calendar = E.is_support_function(E.NATIVE_SUPPORT_FUNCTION_NAMES.ADD_CARLENDAR_EVENT)
  if not native_fun_support_calendar then
    E.LOG.debug(TAG, "native not support calendar api")
    return false
  end
  if E.Sysinfo.os() == "android" then
    if E.Sysinfo.is_simulator() then
      E.LOG.debug(TAG, "android simulator not support calendar")
      return false
    end
    local ejoysdk_version = E.get_sdk_version_name("EJOYSDK")
    local VER_CHECK = require("ejoysdk_lua.ejoysdk_version_check")
    local is_old_version = VER_CHECK.compare_versions(ejoysdk_version, "2.10.74") < 0
    if is_old_version then
      E.LOG.debug(TAG, "android old ejoysdk version not support calendar, version:" .. tostring(ejoysdk_version))
      return false
    end
  end
  return true
end

local CALENDAR_PERMISSION_TYPE_ENUM = {
  read_only = "read_only",
  write_only = "write_only",
  read_and_write = "read_and_write"
}

local function is_support_no_permission_operation()
  return false
end

local function get_read_write_permission_options()
  local android_calendar_permissions = {
    ["android.permission.WRITE_CALENDAR"] = {},
    ["android.permission.READ_CALENDAR"] = {}
  }
  local harmonyos_calendar_permissions = {
    ["ohos.permission.WRITE_CALENDAR"] = {},
    ["ohos.permission.READ_CALENDAR"] = {}
  }
  local ios_calendar_permissions = {
    NSCalendarsUsageDescription = {}
  }
  local permissions = {}
  if E.Sysinfo.os() == "android" then
    permissions = android_calendar_permissions
  elseif E.Sysinfo.os() == "harmonyos" then
    permissions = harmonyos_calendar_permissions
  elseif E.Sysinfo.os() == "ios" then
    permissions = ios_calendar_permissions
  end
  local options = {permissions = permissions}
  return options
end

local function get_read_permission_options()
  local android_calendar_permissions = {
    ["android.permission.READ_CALENDAR"] = {}
  }
  local harmonyos_calendar_permissions = {
    ["ohos.permission.READ_CALENDAR"] = {}
  }
  local ios_calendar_permissions = {
    NSCalendarsUsageDescription = {}
  }
  local permissions = {}
  if E.Sysinfo.os() == "android" then
    permissions = android_calendar_permissions
  elseif E.Sysinfo.os() == "harmonyos" then
    permissions = harmonyos_calendar_permissions
  elseif E.Sysinfo.os() == "ios" then
    permissions = ios_calendar_permissions
  end
  local options = {permissions = permissions}
  return options
end

local function get_write_permission_options()
  local android_calendar_permissions = {
    ["android.permission.WRITE_CALENDAR"] = {}
  }
  local harmonyos_calendar_permissions = {
    ["ohos.permission.WRITE_CALENDAR"] = {}
  }
  local ios_calendar_permissions = {
    NSCalendarsWriteOnlyAccessUsageDescription = {}
  }
  local permissions = {}
  if E.Sysinfo.os() == "android" then
    permissions = android_calendar_permissions
  elseif E.Sysinfo.os() == "harmonyos" then
    permissions = harmonyos_calendar_permissions
  elseif E.Sysinfo.os() == "ios" then
    permissions = ios_calendar_permissions
  end
  local options = {permissions = permissions}
  return options
end

local function ignore_multi_check_permission()
  return E.Sysinfo.os() ~= "harmonyos"
end

local function check_calendar_read_write_permission(permission_type, cb)
  if E.Sysinfo.os() ~= "android" and E.Sysinfo.os() ~= "harmonyos" and E.Sysinfo.os() ~= "ios" then
    E.LOG.debug(TAG, "check_calendar_permission skip, just return true")
    cb(true)
    return
  end
  local options, requesting_listeners
  if permission_type == CALENDAR_PERMISSION_TYPE_ENUM.read_only then
    requesting_listeners = permissions_request_listeners_readonly
    options = get_read_permission_options()
  elseif permission_type == CALENDAR_PERMISSION_TYPE_ENUM.write_only then
    requesting_listeners = permissions_request_listeners_writeonly
    options = get_write_permission_options()
  else
    requesting_listeners = permissions_request_listeners_readwrite
    options = get_read_write_permission_options()
  end
  table.insert(requesting_listeners, cb)
  if ignore_multi_check_permission() and requesting_listeners and #requesting_listeners > 1 then
    E.LOG.debug(TAG, "already has permission request, now just add listener and wait")
    return
  end
  E.LOG.debug(TAG, "begin check calendar permission")
  E.Permission.check_permission_v3(options, function(succ, is_open_settings)
    if succ then
      E.LOG.debug(TAG, "calendar permission granted")
      for _, lis in ipairs(requesting_listeners) do
        lis(true)
      end
    else
      E.LOG.debug(TAG, "calendar permission not granted")
      local err_code = EC.CALENDAR_ERROR_CODES.CODE_CALENDAR_PERMISSION_REJECT
      if is_open_settings then
        err_code = EC.CALENDAR_ERROR_CODES.CODE_PERMISSION_REJECT_OPEN_SETTINGS
      end
      for _, lis in ipairs(requesting_listeners) do
        lis(false, err_code, "calendar permission reject")
      end
    end
    if permission_type == CALENDAR_PERMISSION_TYPE_ENUM.read_only then
      permissions_request_listeners_readonly = {}
    elseif permission_type == CALENDAR_PERMISSION_TYPE_ENUM.write_only then
      permissions_request_listeners_writeonly = {}
    else
      permissions_request_listeners_readwrite = {}
    end
    requesting_listeners = {}
  end)
end

local function check_before_calendar_operation(permission_type, cb)
  if not M.is_support_calendar() then
    cb(false, EC.CALENDAR_ERROR_CODES.CODE_NOT_SUPPORT, "not support calendar")
    return
  end
  check_calendar_read_write_permission(permission_type, function(succ, ...)
    cb(succ, ...)
    local stat_params = {is_priority_high = true}
    ESTAT.stat_action("calendar_permission_result", permission_type, succ, stat_params)
  end)
end

function M.add_event(params, cb)
  if not params or not params.event_info then
    E.LOG.warn(TAG, "add_event failed, params invalid")
    cb(false, EC.CALENDAR_ERROR_CODES.CODE_EVENT_PARAM_INVALID, "params or event is nil")
    return
  end
  if not params.reminder_info or next(params.reminder_info) == nil then
    params.reminder_info = {
      minutes = 0,
      method_name = M.REMINDER_METHODS.METHOD_ALERT
    }
  end
  check_before_calendar_operation(CALENDAR_PERMISSION_TYPE_ENUM.write_only, function(succ, ...)
    local function cb_wrap(_succ, ...)
      if cb then
        cb(_succ, ...)
      end
      ESTAT.stat_action("calendar_add_event", TAG, _succ, {is_priority_high = true, params = params})
    end
    
    if succ then
      E.LOG.debug(TAG, "add_event begin")
      E.Calendar.add_event(params, cb_wrap)
    else
      local code, msg = ...
      if is_support_no_permission_operation() and code ~= EC.CALENDAR_ERROR_CODES.CODE_PERMISSION_REJECT_OPEN_SETTINGS then
        E.LOG.debug(TAG, "add_event support no permission operation")
        E.Calendar.add_event(params, cb_wrap)
      else
        E.LOG.warn(TAG, "add_event no permission return false, code:" .. tostring(code) .. ", msg:" .. tostring(msg))
        if cb then
          cb(false, ...)
        end
      end
    end
  end)
end

function M.delete_event(event_info, cb)
  if not event_info or next(event_info) == nil then
    E.LOG.warn(TAG, "delete_event failed, event_info invalid")
    cb(false, EC.CALENDAR_ERROR_CODES.CODE_EVENT_PARAM_INVALID, "params or event is nil")
    return
  end
  check_before_calendar_operation(CALENDAR_PERMISSION_TYPE_ENUM.read_and_write, function(succ, ...)
    local function cb_wrap(_succ, ...)
      cb(_succ, ...)
      
      ESTAT.stat_action("calendar_delete_event", TAG, _succ, {is_priority_high = true, params = event_info})
    end
    
    if succ then
      E.LOG.debug(TAG, "delete_event begin")
      E.Calendar.delete_event(event_info, cb_wrap)
    else
      E.LOG.debug(TAG, "delete_event no permission return false")
      if cb then
        cb(false, ...)
      end
    end
  end)
end

function M.update_event(_old_event_info, _new_calendar_info, cb)
  if not _new_calendar_info or next(_new_calendar_info) == nil then
    E.LOG.warn(TAG, "update_event failed, _new_calendar_info invalid")
    cb(false, EC.CALENDAR_ERROR_CODES.CODE_EVENT_PARAM_INVALID, "new calendar info is nil")
    return
  end
  local params = {old_event_info = _old_event_info, new_calendar_info = _new_calendar_info}
  check_before_calendar_operation(CALENDAR_PERMISSION_TYPE_ENUM.read_and_write, function(succ, ...)
    local function cb_wrap(_succ, ...)
      cb(_succ, ...)
      
      ESTAT.stat_action("calendar_update_event", TAG, _succ, {is_priority_high = true, params = params})
    end
    
    if succ then
      E.LOG.debug(TAG, "update_event begin")
      E.Calendar.update_event(params, cb_wrap)
    else
      local code, msg = ...
      if is_support_no_permission_operation() and code ~= EC.CALENDAR_ERROR_CODES.CODE_PERMISSION_REJECT_OPEN_SETTINGS then
        E.LOG.debug(TAG, "add_event support no permission operation")
        E.Calendar.update_event(params, cb_wrap)
      else
        E.LOG.warn(TAG, "update_event no permission return false, code:" .. tostring(code) .. ", msg:" .. tostring(msg))
        if cb then
          cb(false, ...)
        end
      end
    end
  end)
end

function M.query_event(event_info, cb)
  if not event_info or next(event_info) == nil then
    E.LOG.warn(TAG, "query_event failed, event_info invalid")
    cb(false, EC.CALENDAR_ERROR_CODES.CODE_EVENT_PARAM_INVALID, "event_info is nil")
    return
  end
  check_before_calendar_operation(CALENDAR_PERMISSION_TYPE_ENUM.read_only, function(succ, ...)
    local function cb_wrap(_succ, ...)
      cb(_succ, ...)
      
      ESTAT.stat_action("calendar_query_event", TAG, _succ, {is_priority_high = true, params = event_info})
    end
    
    if succ then
      E.LOG.debug(TAG, "query_event begin")
      E.Calendar.query_event(event_info, cb_wrap)
    else
      E.LOG.warn(TAG, "query_event no permission return false")
      if cb then
        cb(false, ...)
      end
    end
  end)
end

function M.query_event_id(event_info, cb)
  if not event_info or next(event_info) == nil then
    E.LOG.warn(TAG, "query_event_id failed, event_info invalid")
    cb(false, EC.CALENDAR_ERROR_CODES.CODE_EVENT_PARAM_INVALID, "event_info is nil")
    return
  end
  check_before_calendar_operation(CALENDAR_PERMISSION_TYPE_ENUM.read_only, function(succ, ...)
    local function cb_wrap(_succ, ...)
      cb(_succ, ...)
      
      ESTAT.stat_action("calendar_query_event_id", TAG, _succ, {is_priority_high = true, params = event_info})
    end
    
    if succ then
      E.LOG.debug(TAG, "query_event_id begin")
      E.Calendar.query_event_id(event_info, cb_wrap)
    else
      E.LOG.warn(TAG, "query_event_id no permission return false")
      if cb then
        cb(false, ...)
      end
    end
  end)
end

function M.is_event_exists(event_info, cb)
  M.query_event_id(event_info, function(ret)
    local succ = ret.succ
    if succ then
      local data = ret.data or {}
      local event_id = data.event_id
      local exists = event_id and "" ~= event_id and "0" ~= event_id
      if cb then
        cb(exists)
      end
    elseif cb then
      cb(false)
    end
  end)
end

return M
