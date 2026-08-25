local E = require("ejoysdk_lua.ejoysdk")
local DSP = require("ejoysdk_lua.protocol.aligames_protocol")
local EM = require("ejoysdk_lua.ejoysdk_module")
local TAG = EM.MODULE.VENDORS.DS_API
local M = {}

function M.get_community_info(scene, cb)
  DSP.post(DSP.SERVICE.GAME_COMMUNITY_INFO, {sceneCode = scene}, cb)
end

local function login_ds_with_params(params, cb)
  E.LOG.d(TAG, {ds_request_data = params})
  DSP.post(DSP.SERVICE.ACCOUNT_LOGIN, params, function(succ, ...)
    if succ then
      local data = (...)
      if data and data.ex then
        local exStr = data.ex
        local JSON = require("ejoysdk_lua.ejoysdk_json")
        local exJson = JSON.safe_decode(exStr)
        if exJson then
          data.ex = exJson
        end
      end
      if cb then
        cb(true, data)
      end
    else
      local code, msg = ...
      E.LOG.warn(TAG, "request one account failed, code:" .. tostring(code) .. ", msg:" .. tostring(msg))
      if cb then
        local resp = {
          code = code,
          message = msg,
          msg = msg
        }
        cb(false, resp)
      end
    end
  end)
end

function M.login_to_ds_service(params, cb)
  login_ds_with_params(params, cb)
end

function M.login(login_params, ext_info, cb)
  local request_params = login_params or {}
  request_params.ex = ext_info
  login_ds_with_params(request_params, cb)
end

return M
