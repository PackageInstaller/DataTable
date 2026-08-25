local E = require("ejoysdk_lua.ejoysdk")
local BBS_API = require("ejoysdk_lua.server_api.ejoysdk_bbs")
local EM = require("ejoysdk_lua.ejoysdk_module")
local ET = require("ejoysdk_lua.ejoysdk_topic")
local M = {}
local TAG = EM.MODULE.QRCODE .. "bbs"

function M.get_qrcode(cb)
  BBS_API.get_qrcode(function(succ, ...)
    if succ then
      local result = (...)
      cb(true, result.data.surl)
    else
      cb(false, ...)
    end
  end)
end

local function query_status_once(uuid, cb)
  BBS_API.qrcode_query_status(uuid, cb)
end

local loop_querying = false

function M.cancel_query_status()
  ET.publish(ET.gangplank.SCAN_QUERY_FINISH)
  loop_querying = false
end

function M.query_status(uuid, cb)
  loop_querying = true
  E.LOG.debug(TAG, "轮询论坛扫码, uuid:" .. tostring(uuid))
  
  local function loop_query_status()
    if not loop_querying then
      return
    end
    query_status_once(uuid, function(succ, ...)
      if succ then
        local body = (...)
        local status = body.data.status
        if 0 == status then
          M.cancel_query_status()
          E.LOG.debug(TAG, "论坛扫码成功!")
          cb(true)
        else
          E.LOG.debug(TAG, "query qrcode not login, query again")
          E.Timer.once(3, function()
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
  query_status_once(qr_info.uuid, function(succ, ...)
    if succ then
      cb(true, qr_info.uuid, qr_info.type, ...)
    else
      cb(false, ...)
    end
  end)
end

function M.grant_qrcode(uuid, cb)
  BBS_API.qrcode_login(uuid, cb)
end

return M
