local NetworkCtrlBase = class("NetworkCtrlBase")
local pb = require("pb")
local pb_slice = require("pb.slice")
local traceback = debug.traceback
local cs_MessageCommon = CS.MessageCommon

function NetworkCtrlBase:ctor()
end

function NetworkCtrlBase:InitNetwork()
end

local function DecodeMsg(protoName, msgData)
  local msg = pb.decode(protoName, pb_slice.new(msgData.RawData, 1, msgData.RawDataLen))
  return msg
end

function NetworkCtrlBase:RegisterNetwork(cmdId, tab, protoName, func)
  local function cb(msgData)
    local status, msg = xpcall(DecodeMsg, traceback, protoName, msgData)
    
    if status then
      if GR.IsOpenNetworkMsgLog() then
        print("lua RecvMsg,[" .. tostring(cmdId) .. "]:" .. serpent.block(msg))
      end
      func(tab, msg)
    else
      error(msg)
      error("客户端和服务器当前的通信协议不匹配，请更新客户端或者更新服务器！cmdId:" .. tostring(cmdId) .. " protoName:" .. protoName)
    end
  end
  
  NetworkManager:RegisterListener(cmdId, cb)
end

function NetworkCtrlBase:UnRegisterNetwork(cmdId)
  NetworkManager:UnRegisterListener(cmdId)
end

function NetworkCtrlBase:SendMsg(cmdId, protoName, tabMsg)
  local msgContent = pb.encode(protoName, tabMsg)
  NetworkManager:SendMsg(cmdId, msgContent)
  if GR.IsOpenNetworkMsgLog() then
    print("lua SendMsg,[" .. tostring(cmdId) .. "]:" .. serpent.block(tabMsg))
  end
end

function NetworkCtrlBase:Reset()
end

function NetworkCtrlBase:ShowSCErrorMsg(strErr)
  if strErr == nil or string.IsNullOrEmpty(strErr) then
    return
  end
  error(strErr)
  if isGameDev then
    cs_MessageCommon.ShowMessageTips(strErr)
  end
end

function NetworkCtrlBase:OnDelete()
  self:UnRegisterNetwork()
end

return NetworkCtrlBase
