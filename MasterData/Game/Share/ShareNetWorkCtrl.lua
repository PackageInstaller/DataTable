local ShareNetWorkCtrl = class("ShareNetWorkCtrl", NetworkCtrlBase)
local cs_WaitNetworkResponse = CS.WaitNetworkResponse.Instance

function ShareNetWorkCtrl:ctor()
  self._shareTab = {}
end

function ShareNetWorkCtrl:InitNetwork()
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_Share, self, proto_csmsg.SC_Share, self.SC_Share)
end

function ShareNetWorkCtrl:CS_Share(shareId, channelId, callBack)
  self._shareTab.funcId = shareId
  self._shareTab.sdkId = channelId
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_Share, proto_csmsg.CS_Share, self._shareTab)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_Share, callBack, proto_csmsg_MSG_ID.MSG_SC_Share)
end

function ShareNetWorkCtrl:SC_Share(msg)
  NetworkManager:HandleDiff(msg.syncUpdateDiff)
  if msg.ret ~= 0 then
    local err = "SC_Share:" .. tostring(msg.ret)
    self:ShowSCErrorMsg(err)
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_Share)
    return
  end
  cs_WaitNetworkResponse:AddWaitData(proto_csmsg_MSG_ID.MSG_CS_Share, msg)
end

function ShareNetWorkCtrl:Reset()
end

return ShareNetWorkCtrl
