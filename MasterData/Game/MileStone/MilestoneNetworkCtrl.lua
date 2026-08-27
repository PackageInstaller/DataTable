local MilestoneNetworkCtrl = class("MilestoneNetworkCtrl", NetworkCtrlBase)
local cs_WaitNetworkResponse = CS.WaitNetworkResponse.Instance
local cs_MessageCommon = CS.MessageCommon

function MilestoneNetworkCtrl:ctor()
  self.moduleIdMsg = {moduleId = nil}
  self._bandRewardMsg = {}
end

function MilestoneNetworkCtrl:InitNetwork()
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_Milestone_Module_Reward, self, proto_csmsg.SC_Milestone_Module_Reward, self.SC_Milestone_Module_Reward)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_Milestone_Band_Reward, self, proto_csmsg.SC_Milestone_Band_Reward, self.SC_Milestone_Band_Reward)
end

function MilestoneNetworkCtrl:CS_Milestone_Module_Reward(moduleId, callback)
  self.moduleIdMsg.moduleId = moduleId
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_Milestone_Module_Reward, proto_csmsg.CS_Milestone_Module_Reward, self.moduleIdMsg)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_Milestone_Module_Reward, callback, proto_csmsg_MSG_ID.MSG_SC_Milestone_Module_Reward)
end

function MilestoneNetworkCtrl:SC_Milestone_Module_Reward(msg)
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    local err = "SC_Milestone_Module_Reward error:" .. tostring(msg.ret)
    self:ShowSCErrorMsg(err)
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_Milestone_Module_Reward)
    return
  end
  NetworkManager:HandleDiff(msg.syncUpdateDiff)
  cs_WaitNetworkResponse:AddWaitData(proto_csmsg_MSG_ID.MSG_CS_Milestone_Module_Reward, msg.rewards)
end

function MilestoneNetworkCtrl:CS_Milestone_Band_Reward(bandId, callback)
  self._bandRewardMsg.bandId = bandId
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_Milestone_Band_Reward, proto_csmsg.CS_Milestone_Band_Reward, self._bandRewardMsg)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_Milestone_Band_Reward, callback, proto_csmsg_MSG_ID.MSG_SC_Milestone_Band_Reward)
end

function MilestoneNetworkCtrl:SC_Milestone_Band_Reward(msg)
  NetworkManager:HandleDiff(msg.syncUpdateDiff)
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    local err = "SC_Milestone_Band_Reward error:" .. tostring(msg.ret)
    self:ShowSCErrorMsg(err)
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_Milestone_Band_Reward)
    return
  end
  cs_WaitNetworkResponse:AddWaitData(proto_csmsg_MSG_ID.MSG_CS_Milestone_Band_Reward, msg.rewards)
end

function MilestoneNetworkCtrl:Reset()
end

return MilestoneNetworkCtrl
