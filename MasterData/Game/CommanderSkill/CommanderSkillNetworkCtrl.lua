local CommanderSkillNetworkCtrl = class("CommanderSkillNetworkCtrl", NetworkCtrlBase)
local cs_WaitNetworkResponse = CS.WaitNetworkResponse.Instance

function CommanderSkillNetworkCtrl:ctor()
  self._modifyFmt = {}
  self._freshSavingTreeTab = {}
end

function CommanderSkillNetworkCtrl:InitNetwork()
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_COMMANDSKILL_SaveFromFormation, self, proto_csmsg.SC_COMMANDSKILL_SaveFromFormation, self.SC_COMMANDSKILL_SaveFromFormation)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_COMMANDSKILL_FreshSavingTree, self, proto_csmsg.SC_COMMANDSKILL_FreshSavingTree, self.SC_COMMANDSKILL_FreshSavingTree)
end

function CommanderSkillNetworkCtrl:CS_COMMANDSKILL_SaveFromFormation(formData, callBack)
  local formId = formData.id
  self._modifyFmt.formId = formData.id
  self._modifyFmt.tree = formData:GetFmtCSTDataCurId()
  self._modifyFmt.commandTrees = formData:GetFmtCSTDatDic()
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_COMMANDSKILL_SaveFromFormation, proto_csmsg.CS_COMMANDSKILL_SaveFromFormation, self._modifyFmt)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_COMMANDSKILL_SaveFromFormation, function()
    local formatData = PlayerDataCenter.formationDic[formId]
    formatData:ModifyCSTDataOrg(self._modifyFmt.commandTrees, self._modifyFmt.tree)
    MsgCenter:Broadcast(eMsgEventId.OnCommanderSkillChande)
    if callBack ~= nil then
      callBack()
    end
  end, proto_csmsg_MSG_ID.MSG_SC_COMMANDSKILL_SaveFromFormation)
end

function CommanderSkillNetworkCtrl:SC_COMMANDSKILL_SaveFromFormation(msg)
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    local errorMsg = "HeroNetworkCtrl:SC_COMMANDSKILL_SaveFromFormation error:" .. tostring(msg.ret)
    error(errorMsg)
    if isGameDev then
      CS.MessageCommon.ShowMessageTips(errorMsg)
    end
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_COMMANDSKILL_SaveFromFormation)
  end
  NetworkManager:HandleDiff(msg.syncUpdateDiff)
end

function CommanderSkillNetworkCtrl:CS_COMMANDSKILL_FreshSavingTree(treeSavingDic, callBack)
  self._freshSavingTreeTab.commandTrees = treeSavingDic
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_COMMANDSKILL_FreshSavingTree, proto_csmsg.CS_COMMANDSKILL_FreshSavingTree, self._freshSavingTreeTab)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_COMMANDSKILL_FreshSavingTree, callBack, proto_csmsg_MSG_ID.MSG_SC_COMMANDSKILL_FreshSavingTree)
end

function CommanderSkillNetworkCtrl:SC_COMMANDSKILL_FreshSavingTree(msg)
  NetworkManager:HandleDiff(msg.syncUpdateDiff)
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    local errorMsg = "HeroNetworkCtrl:SC_COMMANDSKILL_SaveFromFormation error:" .. tostring(msg.ret)
    self:ShowSCErrorMsg(errorMsg)
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_COMMANDSKILL_FreshSavingTree)
  end
  PlayerDataCenter.globalTreeSavingData = self._freshSavingTreeTab.commandTrees
  MsgCenter:Broadcast(eMsgEventId.OnCommanderSkillChande)
end

function CommanderSkillNetworkCtrl:Reset()
end

return CommanderSkillNetworkCtrl
