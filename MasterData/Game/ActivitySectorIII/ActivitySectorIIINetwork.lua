local ActivitySectorIIINetwork = class("ActivitySectorIIINetwork", NetworkCtrlBase)
local cs_MessageCommon = CS.MessageCommon
local cs_WaitNetworkResponse = CS.WaitNetworkResponse.Instance

function ActivitySectorIIINetwork:ctor()
  self._taskSingleTable = {}
end

function ActivitySectorIIINetwork:InitNetwork()
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_ACTIVITY_Summer2022_RefreshQuest, self, proto_csmsg.SC_ACTIVITY_Summer2022_RefreshQuest, self.SC_ACTIVITY_Summer2022_RefreshQuest)
end

function ActivitySectorIIINetwork:CS_ACTIVITY_Summer2022_RefreshQuest(actId, taskId, callback)
  self._taskSingleTable.actId = actId
  self._taskSingleTable.questId = taskId
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_ACTIVITY_Summer2022_RefreshQuest, proto_csmsg.CS_ACTIVITY_Summer2022_RefreshQuest, self._taskSingleTable)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_ACTIVITY_Summer2022_RefreshQuest, callback, proto_csmsg_MSG_ID.MSG_SC_ACTIVITY_Summer2022_RefreshQuest)
end

function ActivitySectorIIINetwork:SC_ACTIVITY_Summer2022_RefreshQuest(msg)
  NetworkManager:HandleDiff(msg.syncUpdateDiff)
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    local err = "SC_ACTIVITY_Summer2022_RefreshQuest error:" .. tostring(msg.ret)
    self:ShowSCErrorMsg(err)
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_ACTIVITY_Summer2022_RefreshQuest)
    return
  end
end

return ActivitySectorIIINetwork
