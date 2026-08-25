local E = require("ejoysdk_lua.ejoysdk")
local EG = require("ejoysdk_lua.ejoysdk_gangplank")
local REALNAME_INFO = require("ejoysdk_lua.realname.realname_info")
local ET = require("ejoysdk_lua.ejoysdk_topic")
local EM = require("ejoysdk_lua.ejoysdk_module")
local TAG = EM.MODULE.QRCODE .. "login"
local M = {}

function M.get_qrcode(cb)
  EG.get_login_qrcode_http(function(succ, ...)
    if succ then
      local result = (...)
      local JSON = require("ejoysdk_lua.ejoysdk_json")
      cb(true, JSON.encode({
        uuid = result.uuid,
        type = "login"
      }))
    else
      cb(false, ...)
    end
  end)
end

local function query_status_once(uuid, extra_params, cb)
  EG.validate_qrcode_uuid_http(uuid, extra_params, cb)
end

local loop_querying = false

function M.cancel_query_status()
  ET.publish(ET.gangplank.SCAN_QUERY_FINISH)
  loop_querying = false
end

local loop_uuid

function M.query_status(uuid, cb)
  loop_querying = true
  loop_uuid = uuid
  E.LOG.debug(TAG, "轮询扫码登录, uuid:" .. tostring(loop_uuid))
  local query_frequency = 1
  E.Timer.once(60, function()
    query_frequency = 3
  end)
  
  local function loop_query_status()
    if not loop_querying or not loop_uuid then
      return
    end
    local extra_params = {return_all = true}
    query_status_once(loop_uuid, extra_params, function(succ, ...)
      if succ then
        local body = (...)
        local status = body.status
        if 1 == status then
          M.cancel_query_status()
          E.LOG.debug(TAG, "扫码登录成功!")
          local game = E.CONFIG.get_config("product")
          local region = game
          local login_data = body.login_data
          local temp_ptoken = ""
          local ext = body.ext
          if ext and ext.ptoken then
            temp_ptoken = ext.ptoken
          end
          local pinfo = login_data.pinfo or {}
          EG.set_user_info({
            game = game,
            region = region,
            token = login_data.token,
            uid = login_data.uid,
            pinfo = pinfo,
            pid = pinfo.pid,
            with = pinfo.with,
            with_account = pinfo.with_account,
            platform = pinfo.platform,
            ptoken = temp_ptoken
          })
          E.LOG.debug(TAG, EG.user_info())
          cb(true, login_data.token, login_data)
          ET.publish(ET.gangplank.SCAN_LOGIN, EG.user_info())
        else
          E.LOG.debug(TAG, "query qrcode not login, query again")
          E.Timer.once(query_frequency, function()
            loop_query_status()
          end)
        end
      else
        M.cancel_query_status()
        E.LOG.debug(TAG, "query qrcode other error")
        cb(false, ...)
      end
    end)
  end
  
  loop_query_status()
end

function M.scan_handler(qr_info, cb)
  local succ, code, msg = REALNAME_INFO.check_realname()
  if not succ then
    E.LOG.warn(TAG, "scan_handler skip, realname check failed")
    if cb then
      cb(false, code, msg)
    end
    return
  end
  query_status_once(qr_info.uuid, {}, function(_succ, ...)
    if _succ then
      cb(true, qr_info.uuid, "login", ...)
    else
      cb(false, ...)
    end
  end)
end

function M.grant_qrcode(uuid, cb)
  EG.grant_login_uuid_http(uuid, cb)
end

return M
