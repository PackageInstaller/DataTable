local DamieNetWorkCtrl = class("DamieNetWorkCtrl", NetworkCtrlBase)
local cs_WaitNetworkResponse = CS.WaitNetworkResponse.Instance

function DamieNetWorkCtrl:InitNetwork()
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_ACTIVITY_REFRESHDUNGEON_DamieSettle, self, proto_csmsg.SC_ACTIVITY_REFRESHDUNGEON_DamieSettle, self.SC_ACTIVITY_REFRESHDUNGEON_DamieSettle)
end

function DamieNetWorkCtrl:CS_ACTIVITY_REFRESHDUNGEON_DamieSettle(actId, gameId, score, action)
  local sendMsg = {}
  sendMsg.actLongId = actId
  sendMsg.gameId = gameId
  sendMsg.score = score
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_ACTIVITY_REFRESHDUNGEON_DamieSettle, proto_csmsg.CS_ACTIVITY_REFRESHDUNGEON_DamieSettle, sendMsg)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_ACTIVITY_REFRESHDUNGEON_DamieSettle, action, proto_csmsg_MSG_ID.MSG_SC_ACTIVITY_REFRESHDUNGEON_DamieSettle)
end

function DamieNetWorkCtrl:SC_ACTIVITY_REFRESHDUNGEON_DamieSettle(msg)
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_ACTIVITY_REFRESHDUNGEON_DamieSettle)
    local err = "DamieNetWorkCtrl:SC_ACTIVITY_REFRESHDUNGEON_DamieSettle error:" .. tostring(msg.ret)
    self:ShowSCErrorMsg(err)
    return
  end
  NetworkManager:HandleDiff(msg.syncUpdateDiff)
  cs_WaitNetworkResponse:AddWaitData(proto_csmsg_MSG_ID.MSG_CS_ACTIVITY_REFRESHDUNGEON_DamieSettle, msg)
end

return DamieNetWorkCtrl
