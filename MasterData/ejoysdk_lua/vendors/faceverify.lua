local E = require("ejoysdk_lua.ejoysdk")
local Vendor = require("ejoysdk_lua.vendors.vendor")
local EM = require("ejoysdk_lua.ejoysdk_module")
local UNI = require("ejoysdk_lua.vendors.unisdk")
local JSON = require("ejoysdk_lua.ejoysdk_json")
local UP = require("ejoysdk_lua.user_center.usercenter_protocol")
local PROTOCOL = require("ejoysdk_lua.account.api.protocol")
local CONSTANTS = require("ejoysdk_lua.ejoysdk_constants")
local ET = require("ejoysdk_lua.ejoysdk_topic")
local ASYNC_FACE_VERIFY = "ASYNC_FACE_VERIFY"
local SYNC_GET_META_INFOS = "SYNC_GET_META_INFOS"
local CAST_INIT = "CAST_INIT"
local LUA_KEY_CERTIFY_ID = "certifyId"
local VENDOR_NAME = "FACEVERIFY"
local TAG = EM.MODULE.VENDORS.FACEVERIFY
local M = Vendor:Inherit(VENDOR_NAME)
local ejoyId, dsToken
local inited = false

local function get_identity_verify_type(params, cb)
  local request_params = params or {}
  request_params.sceneCode = "lgRealPersonFace"
  request_params.airlineType = "lingxi"
  request_params.ejoyId = ejoyId
  UP.post(UP.SERVICE.IDENTITY_VERIFY_TYPE, request_params, function(succ, ...)
    if succ then
      local data = (...)
      E.LOG.debug(TAG, "get_identity_verify_type return success")
      E.log(data)
      cb(true, data)
    else
      local code, message = ...
      E.LOG.debug(TAG, "get_identity_verify_type return code >> " .. tostring(code) .. ", message >> " .. tostring(message))
      cb(false, code, message)
    end
  end)
end

local function do_identity_verify(params, cb)
  local request_params = params or {}
  UP.post(UP.SERVICE.IDENTITY_VERIFY, request_params, function(succ, ...)
    if succ then
      local data = (...)
      E.LOG.debug(TAG, "do_identity_verify return success")
      E.log(data)
      cb(true, data)
    else
      local code, message = ...
      E.LOG.debug(TAG, "do_identity_verify return code >> " .. tostring(code) .. ", message >> " .. tostring(message))
      cb(false, code, message)
    end
  end)
end

local function logout_handler()
  E.LOG.debug(TAG, "logout invoke, clear ejoyId and dsToken")
  ejoyId = nil
  dsToken = nil
end

function M.init(opt, cb)
  E.LOG.debug(TAG, "call init")
  if inited then
    E.LOG.debug(TAG, "is inited")
    cb(true)
  end
  UNI.cast(VENDOR_NAME, CAST_INIT, opt.config or {})
  ET.subscribe(ET.gangplank.LOGOUT, logout_handler)
  inited = true
  cb(true)
end

function M.is_support_face_verify()
  local EC = require("ejoysdk_lua.ejoysdk_config")
  do return EC.has_vendor_config end
  return EC.has_vendor_config, VENDOR_NAME
end

function M.start_face_verify(cb)
  if not M.is_support_face_verify() then
    E.LOG.debug(TAG, "face verify fail,  not support face verify, maybe no face plugin in app")
    PROTOCOL.fail_callback(cb, CONSTANTS.FACE_VERIFY_ERROR.UN_SUPPORT, "Un Support")
    return
  end
  if not inited then
    E.LOG.debug(TAG, "face verify fail, is not init")
    PROTOCOL.fail_callback(cb, CONSTANTS.FACE_VERIFY_ERROR.NOT_INIT, "Not init")
    return
  end
  local metaInfos = UNI.sync_call(VENDOR_NAME, SYNC_GET_META_INFOS, {}, nil)
  if type(metaInfos) == "table" then
    metaInfos = JSON.encode(metaInfos)
  end
  E.LOG.debug(TAG, {metaInfos = metaInfos})
  if type(metaInfos) == "string" and "" ~= metaInfos then
    local identityData = {metaInfo = metaInfos}
    local params = {
      identityData = JSON.encode(identityData)
    }
    get_identity_verify_type(params, function(succ, ...)
      if succ then
        local data = (...)
        E.LOG.debug(TAG, data)
        local verifyToken = data.verifyToken
        local certifyId = data.verifyData.certifyId
        local params1 = {}
        params1[LUA_KEY_CERTIFY_ID] = certifyId
        UNI.async_call(VENDOR_NAME, ASYNC_FACE_VERIFY, params1, nil, function(succ2, ...)
          E.LOG.debug(TAG, "ASYNC_FACE_VERIFY >> " .. tostring(succ2))
          E.log({
            ...
          })
          if succ2 then
            local params2 = {
              verifyToken = verifyToken,
              verifyData = {
                realPersonFace = {certifyId = certifyId}
              }
            }
            do_identity_verify(params2, function(succ3, ...)
              if succ3 then
                local result = {verifyToken = verifyToken, dsToken = dsToken}
                PROTOCOL.succ_callback(cb, result)
              else
                local code, message = ...
                PROTOCOL.fail_callback(cb, code, message)
              end
            end)
          else
            local code, body = ...
            E.LOG.error(TAG, "ASYNC_FACE_VERIFY 扫脸结果失败, code is " .. tostring(body.error_code) .. ", msg is " .. tostring(body.error_msg))
            local message = body and body.error_msg or ""
            PROTOCOL.fail_callback(cb, code, message)
          end
        end)
      else
        local code, message = ...
        PROTOCOL.fail_callback(cb, code, message)
      end
    end)
  else
    PROTOCOL.fail_callback(cb, CONSTANTS.FACE_VERIFY_ERROR.GET_META_INFO_ERROR, "get metaInfos error")
  end
end

function M.update_lingxi_account_info(ucid, token)
  E.LOG.debug(TAG, "update user info >> " .. tostring(ucid) .. ", token >> " .. tostring(token))
  ejoyId = ucid
  dsToken = token
end

return M
