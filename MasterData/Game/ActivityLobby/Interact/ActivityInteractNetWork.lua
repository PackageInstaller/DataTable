local ActivityInteractNetWork = class("ActivityInteractNetWork", NetworkCtrlBase)
local CommonRewardData = require("Game.CommonUI.CommonRewardData")
local cs_MessageCommon = CS.MessageCommon
local cs_WaitNetworkResponse = CS.WaitNetworkResponse.Instance

function ActivityInteractNetWork:ctor()
  self._interactTable = {}
  self._interactStoryTable = {}
end

function ActivityInteractNetWork:InitNetwork()
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_ACTIVITY_Interact, self, proto_csmsg.SC_ACTIVITY_Interact, self.SC_ACTIVITY_Interact)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_ACTIVITY_Interact_Story_Award, self, proto_csmsg.SC_ACTIVITY_Interact_Story_Award, self.SC_ACTIVITY_Interact_Story_Award)
end

function ActivityInteractNetWork:CS_ACTIVITY_Interact(actLongId, interactId, successAction)
  self._interactTable.actLongId = actLongId
  self._interactTable.interactId = interactId
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_ACTIVITY_Interact, proto_csmsg.CS_ACTIVITY_Interact, self._interactTable)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_ACTIVITY_Interact, successAction, proto_csmsg_MSG_ID.MSG_SC_ACTIVITY_Interact)
end

function ActivityInteractNetWork:SC_ACTIVITY_Interact(msg)
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    local err = "SC_ACTIVITY_Interact error:" .. tostring(msg.ret)
    self:ShowSCErrorMsg(err)
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_ACTIVITY_Interact)
    return
  end
  cs_WaitNetworkResponse:AddWaitData(proto_csmsg_MSG_ID.MSG_CS_ACTIVITY_Interact, msg)
  NetworkManager:HandleDiff(msg.syncUpdateDiff)
end

function ActivityInteractNetWork:CS_ACTIVITY_Interact_Story_Award(actLongId, successAction)
  self._interactStoryTable.actLongId = actLongId
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_ACTIVITY_Interact_Story_Award, proto_csmsg.CS_ACTIVITY_Interact_Story_Award, self._interactStoryTable)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_ACTIVITY_Interact_Story_Award, successAction, proto_csmsg_MSG_ID.MSG_SC_ACTIVITY_Interact_Story_Award)
end

function ActivityInteractNetWork:SC_ACTIVITY_Interact_Story_Award(msg)
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    local err = "SC_ACTIVITY_Interact_Story_Award error:" .. tostring(msg.ret)
    self:ShowSCErrorMsg(err)
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_ACTIVITY_Interact_Story_Award)
    return
  end
  cs_WaitNetworkResponse:AddWaitData(proto_csmsg_MSG_ID.MSG_CS_ACTIVITY_Interact_Story_Award, msg)
  NetworkManager:HandleDiff(msg.syncUpdateDiff)
end

return ActivityInteractNetWork
