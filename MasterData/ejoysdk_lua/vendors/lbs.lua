local UNI = require("ejoysdk_lua.vendors.unisdk")
local E = require("ejoysdk_lua.ejoysdk")
local Vendor = require("ejoysdk_lua.vendors.vendor")
local LANG = require("ejoysdk_lua.lang.util")
local EG = require("ejoysdk_lua.ejoysdk_gangplank")
local EC = require("ejoysdk_lua.ejoysdk_config")
local VENDOR_NAME = "LBS"
local HTTP = E.HTTP
local M = Vendor:Inherit(VENDOR_NAME)
local ASYNC_GET_LOCATION = "ASYNC_GET_LOCATION"
local ASYNC_REQUEST_LOCATION_PERMISSION = "ASYNC_REQUEST_LOCATION_PERMISSION"
local ASYNC_DETECT_LOCATION_PERMISSION = "ASYNC_DETECT_LOCATION_PERMISSION"
local LBS_PERMISSION_DIALOG_COUNT = E.LazyKeyStore:New("LBS_PERMISSION_DIALOG_COUNT", false, false, false)
local ERR_CODE_SERVER_RESULT_INVALID = 75001001
local ERR_CODE_PERMISSION_DENY = 74001002
local lbs_info_cache

local function real_get_location(cb)
  UNI.async_call(VENDOR_NAME, ASYNC_GET_LOCATION, {}, nil, function(succ, ...)
    if succ then
      E.LOG.debug(VENDOR_NAME, "real_get_location succ")
      local data = (...)
      cb(true, data)
    else
      local _, body = ...
      E.LOG.debug(VENDOR_NAME, "real_get_location failed, code:" .. tostring(body.error_code) .. ", msg:" .. tostring(body.error_msg))
      cb(false, body.error_code, body.error_msg)
    end
  end)
end

local function get_location_info_from_server(location, cb)
  local url = EG.gangplank_url("get_location", "2")
  local params = {coordinate = location}
  local headers = {}
  HTTP.post(url, headers, HTTP.CT_JSON, params, function(resp)
    if resp.status == 200 then
      local code = resp.body.code
      if 0 == code then
        local result = resp.body.data
        cb(true, result or {})
      else
        cb(false, code, resp.body and resp.body.message or "")
      end
    else
      cb(false, resp.status, resp.body and resp.body.message or "")
    end
  end)
end

local function request_location_permission(cb)
  if E.Sysinfo.os() == "harmonyos" then
    local oh_loc_permissions = {
      "ohos.permission.APPROXIMATELY_LOCATION",
      "ohos.permission.LOCATION"
    }
    local all_permission_size = #oh_loc_permissions
    E.LOG.debug(VENDOR_NAME, "request_location_permission begin:" .. tostring(all_permission_size))
    E.Permission.check_permission_list_v2(oh_loc_permissions, function(grant_ret, reject_permissions)
      local result = grant_ret or #reject_permissions < all_permission_size
      E.LOG.debug(VENDOR_NAME, "request_location_permission for harmonyos result: " .. tostring(result))
      cb(result)
    end)
  else
    UNI.async_call(VENDOR_NAME, ASYNC_REQUEST_LOCATION_PERMISSION, {}, nil, cb)
  end
end

function M.detect_location_permission(cb)
  if not EC.has_vendor_config("LBS") then
    E.LOG.debug(VENDOR_NAME, "not support detect location permission")
    cb(false, {status = 0})
  end
  if E.Sysinfo.os() == "android" then
    local permission = "android.permission.ACCESS_COARSE_LOCATION"
    E.Permission.detect_permission(permission, cb)
  elseif E.Sysinfo.os() == "harmonyos" then
    local permission = "ohos.permission.APPROXIMATELY_LOCATION"
    E.Permission.detect_permission(permission, cb)
  elseif E.Sysinfo.os() == "ios" then
    UNI.async_call(VENDOR_NAME, ASYNC_DETECT_LOCATION_PERMISSION, {}, nil, function(succ, ...)
      if succ then
        cb(true)
      else
        cb(false, {status = 0})
      end
    end)
  end
end

function M.get_device_location(opt, cb)
  if nil == opt then
    opt = {}
  end
  E.LOG.debug(VENDOR_NAME, "get device location, opt is ")
  E.log(opt)
  local permission = "android.permission.ACCESS_COARSE_LOCATION"
  local _os = E.Sysinfo.os()
  if "ios" == _os then
    permission = "NSLocationWhenInUseUsageDescription"
  elseif "harmonyos" == _os then
    permission = "ohos.permission.APPROXIMATELY_LOCATION"
  end
  local permission_title, permission_desc_content = E.Permission.permission_default_description({
    [permission] = {}
  })
  local force_request_permission = opt.force_request_permission or false
  local max_request_permission_count = opt.max_request_permission_count or 1
  local current_permission_request_count_str = LBS_PERMISSION_DIALOG_COUNT:get() or "0"
  local current_permission_request_count = 0
  if type(current_permission_request_count_str) == "string" then
    current_permission_request_count = tonumber(current_permission_request_count_str)
  end
  E.LOG.debug(VENDOR_NAME, "current permission count is " .. tostring(current_permission_request_count))
  local can_request_permission = true
  if false == force_request_permission and max_request_permission_count <= current_permission_request_count then
    can_request_permission = false
  end
  local title = opt.title or permission_title
  local desc = opt.desc or permission_desc_content
  local setting_guide_title = opt.setting_guide_title or permission_title
  local setting_guide_desc = opt.setting_guide_message or "系统拒绝应用申请此权限。如需使用功能，请前往系统设置内手动打开此权限。\n\n" .. permission_desc_content
  local usage_options = {
    buttons = {
      LANG.getString("confirm", "确定")
    },
    title = title,
    message = desc,
    permissions = {permission}
  }
  local setting_usage_options = {
    title = setting_guide_title,
    message = setting_guide_desc,
    buttons = {
      "取消",
      "跳转到设置"
    },
    permissions = {permission}
  }
  M.detect_location_permission(function(succ, resp)
    E.LOG.debug(VENDOR_NAME, "detect_location_permission result:" .. tostring(succ))
    if not succ then
      if false == can_request_permission then
        E.LOG.debug(VENDOR_NAME, "permission deny and request permission is max count, should not request again")
        cb(false, ERR_CODE_PERMISSION_DENY, "permission deny and request permission is max count, should not request again")
        return
      end
      
      local function show_setting_usage_dialog_fun()
        local function show_setting_usage_dialog_cb(ret)
          LBS_PERMISSION_DIALOG_COUNT:set(tostring(current_permission_request_count + 1))
          
          if 1 == ret then
            E.Permission.openSetting()
          end
        end
        
        if opt.show_custom_setting_usage_dialog then
          opt.show_custom_setting_usage_dialog(show_setting_usage_dialog_cb)
        else
          E.Permission.show_usage_dialog(setting_usage_options, show_setting_usage_dialog_cb)
        end
      end
      
      local status = resp.status
      E.LOG.debug(VENDOR_NAME, "detect_location_permission status:" .. tostring(status))
      if 0 == status then
        if "android" == _os or "harmonyos" == _os then
          local function show_usage_dialog_cb()
            E.LOG.debug(VENDOR_NAME, "show_usage_dialog_cb begin request_location_permission")
            
            LBS_PERMISSION_DIALOG_COUNT:set(tostring(current_permission_request_count + 1))
            request_location_permission(function(request_permission_succ)
              E.LOG.debug(VENDOR_NAME, "permission callback " .. tostring(request_permission_succ))
              if request_permission_succ then
                E.LOG.debug(VENDOR_NAME, "check permission succ")
                real_get_location(cb)
              else
                E.LOG.debug(VENDOR_NAME, "check permission fail")
                cb(false, ERR_CODE_PERMISSION_DENY, "permission deny")
              end
            end)
          end
          
          if opt.show_custom_usage_dialog then
            opt.show_custom_usage_dialog(show_usage_dialog_cb)
          else
            E.Permission.show_usage_dialog(usage_options, show_usage_dialog_cb)
          end
        elseif E.Sysinfo.os() == "ios" then
          request_location_permission(function(request_permission_succ)
            E.log("request_location_permission result is " .. tostring(request_permission_succ))
            if request_permission_succ then
              E.LOG.debug(VENDOR_NAME, "request permission succ")
              real_get_location(cb)
            else
              show_setting_usage_dialog_fun()
              cb(false, ERR_CODE_PERMISSION_DENY, "permission deny")
            end
          end)
        end
      elseif -1 == status then
        E.LOG.debug(VENDOR_NAME, "permission deny， and never ask" .. permission)
        show_setting_usage_dialog_fun()
        cb(false, ERR_CODE_PERMISSION_DENY, "permission deny")
      end
    else
      E.LOG.debug(VENDOR_NAME, "real_get_location begin, " .. permission)
      real_get_location(cb)
    end
  end)
end

function M.get_location(opt, cb)
  local force_request_location = opt.force_request_location or false
  if lbs_info_cache and false == force_request_location then
    E.LOG.debug(VENDOR_NAME, "has location info cache, now return")
    cb(true, lbs_info_cache)
  else
    local function ip_location_cb(succ, ...)
      if succ then
        local lbs_info = (...)
        
        if lbs_info and lbs_info.city_code then
          lbs_info_cache = lbs_info
          E.LOG.debug(VENDOR_NAME, "get location info succ")
          E.log(lbs_info_cache)
          cb(true, ...)
        else
          cb(false, ERR_CODE_SERVER_RESULT_INVALID, "server result is invalid")
        end
      else
        local status, error_msg = ...
        E.LOG.debug(VENDOR_NAME, "get location info fail, status is " .. tostring(status) .. ", msg is " .. tostring(error_msg))
        cb(false, ...)
      end
    end
    
    E.LOG.debug(VENDOR_NAME, "has_vendor_config:" .. tostring(EC.has_vendor_config("LBS")))
    if not EC.has_vendor_config("LBS") then
      get_location_info_from_server({}, ip_location_cb)
      return
    end
    M.get_device_location(opt, function(succ, ...)
      E.LOG.debug(VENDOR_NAME, "get_device_location callback")
      if succ then
        E.LOG.debug(VENDOR_NAME, "get_device_location succ, request location info")
        local params = (...)
        if params then
          E.log(params)
        end
        get_location_info_from_server(params, ip_location_cb)
      else
        local ip_lbs_enable = true
        if opt.ip_lbs_enable ~= nil then
          ip_lbs_enable = opt.ip_lbs_enable
        end
        if ip_lbs_enable then
          E.LOG.debug(VENDOR_NAME, "get_device_location fail, now use ip location")
          get_location_info_from_server({}, ip_location_cb)
        else
          cb(false, ...)
        end
      end
    end)
  end
end

return M
