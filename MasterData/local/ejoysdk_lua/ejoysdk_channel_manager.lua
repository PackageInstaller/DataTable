local E = require("ejoysdk_lua.ejoysdk")
local EV = require("ejoysdk_lua.ejoysdk_vendors")
local AGST_TOKEN = require("ejoysdk_lua.user_center.agst_token_manager")
local DEVICE_ID = require("ejoysdk_lua.device_id.ejoysdk_device_id")
local USER = require("ejoysdk_lua.user_center.ejoysdk_usercenter")
local EM = require("ejoysdk_lua.ejoysdk_module")
local QL = require("ejoysdk_lua.ejoysdk_qualitylog")
local ATracer = require("ejoysdk_lua.account.account_tracer")
local LOGIN_FLOW = require("ejoysdk_lua.account.login_flow")
local M = {}
local TAG = EM.MODULE.EJOYSDK_BASE_MODULE .. "channel_manager"
local origin_listeners

local function use_user_center(vendor)
  if vendor and vendor.use_user_center and vendor.use_user_center() then
    return true
  else
    return false
  end
end

local function is_vendor_unspecified(vendor_name)
  return nil == vendor_name or "" == vendor_name or "auto" == vendor_name
end

function M.get_vendor(vendor_name, ability)
  local ret_vendor_name = vendor_name
  if is_vendor_unspecified(vendor_name) then
    E.LOG.debug(TAG, "需要自动检查vendor")
    assert(ability, "vendor_name and ability all unknown")
    local vendor_name_list = EV.get_native_vendors(ability)
    E.LOG.debug(TAG, "vendor_name_list =====")
    E.log(vendor_name_list)
    local is_oversea = E.CONFIG.get_config(E.CONFIG.KEY.MULTI_REGIONS_ENABLED) or false
    for _, sdk in pairs(vendor_name_list) do
      if is_oversea then
        if EV.UMBRELLA_VENDORS[sdk] then
          ret_vendor_name = sdk
          break
        end
      elseif EV.INLAND_UMBRELLA_VENDORS[sdk] then
        ret_vendor_name = sdk
        break
      end
    end
    E.LOG.debug(TAG, "umberlla vendor >> " .. tostring(ret_vendor_name))
    local _vendor = EV.get(ret_vendor_name)
    if not (not is_vendor_unspecified(ret_vendor_name) and _vendor) or not _vendor:is_support_ability({ability}) then
      E.LOG.warn(TAG, "umbrella vendor not find or not support:" .. tostring(ret_vendor_name) .. ", now check single vendor support")
      for i = 1, #vendor_name_list do
        local vn = vendor_name_list[i]
        E.LOG.debug(TAG, "check if support login for " .. tostring(vn))
        _vendor = EV.get(vn)
        if _vendor and _vendor:is_support_ability({ability}) then
          E.LOG.debug(TAG, "find support vendor:" .. tostring(vn))
          ret_vendor_name = vn
          break
        end
      end
    end
  end
  local vendor_result = {}
  vendor_result.vendor_name = ret_vendor_name
  vendor_result.vendor = EV.get(ret_vendor_name)
  E.LOG.debug(TAG, "get_vendor ret, origin vendor_name:" .. (vendor_name or "nil") .. ", ret_vendor_name:" .. (ret_vendor_name or "nil"))
  return vendor_result
end

function M.is_support_ability(vendor_name, abilities)
  if not vendor_name or "" == vendor_name then
    E.LOG.warn(TAG, "vendor name is invalid")
    return false
  end
  local _vendor = EV.get(vendor_name)
  local support_result = _vendor:is_support_ability(abilities)
  E.LOG.debug(TAG, "is_support_ability, vendor_name:" .. tostring(vendor_name) .. ", support:" .. tostring(support_result))
  return support_result
end

local function need_use_user_center(vendors)
  for vendor_name, _value in pairs(vendors) do
    local vendor = EV.get(vendor_name)
    if use_user_center(vendor) then
      E.LOG.debug(TAG, "need_use_user_center find vendor need user_center, now return true :" .. vendor_name)
      return true
    end
  end
  E.LOG.debug(TAG, "need_use_user_center NOT find vendor need user_center, now return false :")
  return false
end

function M.init(vendors, listeners, cb)
  DEVICE_ID.init()
  origin_listeners = listeners
  if need_use_user_center(vendors) then
    AGST_TOKEN.init()
    USER.init(function(succ, ...)
      if succ then
        E.LOG.debug(TAG, "start init all vendors")
        EV.init(vendors, listeners, function(succ2, ...)
          if true == succ2 then
            local channel_init_result = {
              ...
            }
            local SC = require("ejoysdk_lua.user_center.system_config")
            SC.request_system_config(function(succ3, ...)
              if succ3 then
                local unpack = unpack or table.unpack
                cb(true, unpack(channel_init_result))
              else
                cb(false, ...)
              end
            end)
          else
            cb(false, ...)
          end
        end)
        QL.commit_action_succ_main("ejoy_usercenter_init_end")
      else
        E.LOG.debug(TAG, "user center init failed")
        cb(false, ...)
        local _code, _msg = ...
        QL.commit_action_fail_main("ejoy_usercenter_init_end", nil, _code, _msg)
      end
    end)
  else
    E.LOG.debug(TAG, "start init all vendors")
    EV.init(vendors, listeners, cb)
  end
end

function M.get_bind_info(cb)
  USER.get_bind_info(function(succ, ...)
    if not succ then
      local code, _msg = ...
      if code == USER.USER_CENTER_ERROR_CODES.ERR_TOKEN_EXPIRED or code == USER.USER_CENTER_ERROR_CODES.ERR_TOKEN_INVALID then
        E.LOG.warn(TAG, "bind err_code:" .. code .. ", token is invalid or expired, now need logout")
        local EG = require("ejoysdk_lua.ejoysdk_gangplank")
        EG.logout()
      end
    end
    cb(succ, ...)
  end)
end

function M.login(vendor_name, ext)
  E.LOG.d(TAG, "login start")
  local cm_login_span = ATracer.start_login_sub_span(ATracer.ACCOUNT_FLOWS_SPANS.CM_LOGIN)
  LOGIN_FLOW.login(vendor_name, ext, function(succ, ...)
    local login_data, ext_info = ...
    ATracer.finish_login_sub_span(cm_login_span, login_data)
    origin_listeners.auth_listener(vendor_name, succ, login_data, ext_info)
  end)
end

function M.can_show_user_center(vendor_name)
  local vendor = EV.get(vendor_name)
  if vendor and vendor.can_show_user_center then
    do return end
    return vendor.can_show_user_center
  end
  return true
end

function M.open_user_center(vendor_name, options, close_cb)
  local vendor = EV.get(vendor_name)
  if vendor and vendor.open_user_center then
    vendor.open_user_center(options and options.screen_orientation, options, close_cb)
  else
    E.LOG.warn(TAG, "open_user_center failed, no vendor implements open_user_center")
    if close_cb then
      close_cb()
    end
  end
end

function M.open_userinfo_completion(vendor_name, cb)
  local vendor = EV.get(vendor_name)
  if vendor and vendor.open_userinfo_completion then
    vendor.open_userinfo_completion(cb)
  end
end

return M
