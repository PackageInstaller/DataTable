local FairyNetworkCtrl = class("FairyNetworkCtrl", NetworkCtrlBase)
local cs_WaitNetworkResponse = CS.WaitNetworkResponse.Instance
local cs_MessageCommon = CS.MessageCommon

function FairyNetworkCtrl:ctor()
  self.upgradeTable = {}
  self.addRankTable = {}
  self.skillRestructureTable = {}
  self.storyRewardsTable = {}
  self.modifyNameTable = {}
  self.lifeFreeTable = {}
  self.fairyLikeTable = {}
  self.fastLvTable = {}
  self.fastLvSkillTable = {}
end

function FairyNetworkCtrl:InitNetwork()
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_Fairy_Detail, self, proto_csmsg.SC_Fairy_Detail, self.SC_Fairy_Detail)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_Fairy_Upgrade, self, proto_csmsg.SC_Fairy_Upgrade, self.SC_Fairy_Upgrade)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_Fairy_Favor, self, proto_csmsg.SC_Fairy_Favor, self.SC_Fairy_Favor)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_Fairy_AddRank, self, proto_csmsg.SC_Fairy_AddRank, self.SC_Fairy_AddRank)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_Fairy_Skill_Restructuring, self, proto_csmsg.SC_Fairy_Skill_Restructuring, self.SC_Fairy_Skill_Restructuring)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_Fairy_StoryRewards, self, proto_csmsg.SC_Fairy_StoryRewards, self.SC_Fairy_StoryRewards)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_Fairy_ModifyName, self, proto_csmsg.SC_Fairy_ModifyName, self.SC_Fairy_ModifyName)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_Fairy_Life_Free, self, proto_csmsg.SC_Fairy_Life_Free, self.SC_Fairy_Life_Free)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_Fairy_FastUpgrade, self, proto_csmsg.SC_Fairy_FastUpgrade, self.SC_Fairy_FastUpgrade)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_Fairy_FastUpgradeKeep, self, proto_csmsg.SC_Fairy_FastUpgradeKeep, self.SC_Fairy_FastUpgradeKeep)
end

function FairyNetworkCtrl:CS_Fairy_Detail(callBack)
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_Fairy_Detail, proto_csmsg.CS_Fairy_Detail, table.emptytable)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_Fairy_Detail, callBack, proto_csmsg_MSG_ID.MSG_SC_Fairy_Detail)
end

function FairyNetworkCtrl:SC_Fairy_Detail(msg)
  if msg.ret and msg.ret ~= proto_csmsg_ErrorCode.None then
    local err = "SC_Fairy_Detail error:" .. tostring(msg.ret)
    self:ShowSCErrorMsg(err)
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_Fairy_Detail)
    return
  end
  cs_WaitNetworkResponse:AddWaitData(proto_csmsg_MSG_ID.MSG_CS_Fairy_Detail, msg)
end

function FairyNetworkCtrl:CS_Fairy_Favor(uid, callback)
  self.fairyLikeTable.uid = uid
  self.fairyLikeCallback = callback
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_Fairy_Favor, proto_csmsg.CS_Fairy_Favor, self.fairyLikeTable)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_Fairy_Favor, nil, proto_csmsg_MSG_ID.MSG_SC_Fairy_Favor)
end

function FairyNetworkCtrl:SC_Fairy_Favor(msg)
  if msg.ret and msg.ret ~= proto_csmsg_ErrorCode.None then
    local err = "SC_Fairy_Favor error:" .. tostring(msg.ret)
    self:ShowSCErrorMsg(err)
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_Fairy_Favor)
    return
  end
  if self.fairyLikeCallback then
    self.fairyLikeCallback()
    self.fairyLikeCallback = nil
  end
  cs_WaitNetworkResponse:AddWaitData(proto_csmsg_MSG_ID.MSG_CS_Fairy_Favor, msg)
  if msg.syncUpdateDiff == nil then
    msg.syncUpdateDiff = {
      fairy = {
        data = {}
      },
      flag = {
        [proto_csmsg_SyncUpdateDiffEnum.DIFF_FAIRY] = true
      }
    }
  end
  NetworkManager:HandleDiff(msg.syncUpdateDiff)
end

function FairyNetworkCtrl:CS_Fairy_Upgrade(uid, aimLevel, callback)
  self.upgradeTable.uid = uid
  self.upgradeTable.aimLv = aimLevel
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_Fairy_Upgrade, proto_csmsg.CS_Fairy_Upgrade, self.upgradeTable)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_Fairy_Upgrade, callback, proto_csmsg_MSG_ID.MSG_SC_Fairy_Upgrade)
end

function FairyNetworkCtrl:SC_Fairy_Upgrade(msg)
  if msg.ret and msg.ret ~= proto_csmsg_ErrorCode.None then
    local err = "SC_Fairy_Upgrade error:" .. tostring(msg.ret)
    self:ShowSCErrorMsg(err)
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_Fairy_Upgrade)
    return
  end
  cs_WaitNetworkResponse:AddWaitData(proto_csmsg_MSG_ID.MSG_CS_Fairy_Upgrade, msg)
  NetworkManager:HandleDiff(msg.syncUpdateDiff)
end

function FairyNetworkCtrl:CS_Fairy_AddRank(uid, dogUid, keepSkillDataList, callback)
  self.addRankTable.uid = uid
  self.addRankTable.dogUid = dogUid
  local realKeepSkillIds = {}
  for i, data in pairs(keepSkillDataList) do
    local item = {}
    item.skillId = data.fairySkillId
    item.uid = data.fairyUID
    item.grade = data.fairySkillRare
    table.insert(realKeepSkillIds, item)
  end
  self.addRankTable.keepSkills = realKeepSkillIds
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_Fairy_AddRank, proto_csmsg.CS_Fairy_AddRank, self.addRankTable)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_Fairy_AddRank, callback, proto_csmsg_MSG_ID.MSG_SC_Fairy_AddRank)
end

function FairyNetworkCtrl:SC_Fairy_AddRank(msg)
  if msg.ret and msg.ret ~= proto_csmsg_ErrorCode.None then
    local err = "SC_Fairy_AddRank error:" .. tostring(msg.ret)
    self:ShowSCErrorMsg(err)
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_Fairy_AddRank)
    return
  end
  cs_WaitNetworkResponse:AddWaitData(proto_csmsg_MSG_ID.MSG_CS_Fairy_AddRank, msg)
  NetworkManager:HandleDiff(msg.syncUpdateDiff)
end

function FairyNetworkCtrl:CS_Fairy_Skill_Restructuring(uid, dogUid, keepSkillDataList, callback)
  self.skillRestructureTable.uid = uid
  self.skillRestructureTable.dogUid = dogUid
  local realKeepSkillIds = {}
  for i, data in pairs(keepSkillDataList) do
    local item = {}
    item.skillId = data.fairySkillId
    item.uid = data.fairyUID
    item.grade = data.fairySkillRare
    table.insert(realKeepSkillIds, item)
  end
  self.skillRestructureTable.keepSkills = realKeepSkillIds
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_Fairy_Skill_Restructuring, proto_csmsg.CS_Fairy_Skill_Restructuring, self.skillRestructureTable)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_Fairy_Skill_Restructuring, callback, proto_csmsg_MSG_ID.MSG_SC_Fairy_Skill_Restructuring)
end

function FairyNetworkCtrl:SC_Fairy_Skill_Restructuring(msg)
  if msg.ret and msg.ret ~= proto_csmsg_ErrorCode.None then
    local err = "SC_Fairy_Skill_Restructuring error:" .. tostring(msg.ret)
    self:ShowSCErrorMsg(err)
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_Fairy_Skill_Restructuring)
    return
  end
  cs_WaitNetworkResponse:AddWaitData(proto_csmsg_MSG_ID.MSG_CS_Fairy_Skill_Restructuring, msg)
  NetworkManager:HandleDiff(msg.syncUpdateDiff)
end

function FairyNetworkCtrl:CS_Fairy_StoryRewards(uid, storyId, callback)
  self.storyRewardsTable.uid = uid
  self.storyRewardsTable.storyId = storyId
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_Fairy_StoryRewards, proto_csmsg.CS_Fairy_StoryRewards, self.storyRewardsTable)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_Fairy_StoryRewards, callback, proto_csmsg_MSG_ID.MSG_SC_Fairy_StoryRewards)
end

function FairyNetworkCtrl:SC_Fairy_StoryRewards(msg)
  if msg.ret and msg.ret ~= proto_csmsg_ErrorCode.None then
    local err = "SC_Fairy_StoryRewards error:" .. tostring(msg.ret)
    self:ShowSCErrorMsg(err)
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_Fairy_StoryRewards)
    return
  end
  cs_WaitNetworkResponse:AddWaitData(proto_csmsg_MSG_ID.MSG_CS_Fairy_StoryRewards, msg)
  NetworkManager:HandleDiff(msg.syncUpdateDiff)
end

function FairyNetworkCtrl:CS_Fairy_ModifyName(uid, newFiryName, callback)
  self.modifyNameTable.uid = uid
  self.modifyNameTable.name = newFiryName
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_Fairy_ModifyName, proto_csmsg.CS_Fairy_ModifyName, self.modifyNameTable)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_Fairy_ModifyName, callback, proto_csmsg_MSG_ID.MSG_SC_Fairy_ModifyName)
end

function FairyNetworkCtrl:SC_Fairy_ModifyName(msg)
  if msg.ret and msg.ret ~= proto_csmsg_ErrorCode.None then
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_Fairy_ModifyName)
    if msg.ret == proto_csmsg_ErrorCode.INVALID_CHARACTER_INPUT then
      local err = ConfigData:GetTipContent(22007)
      cs_MessageCommon.ShowMessageTips(err)
      return
    end
    if msg.ret == proto_csmsg_ErrorCode.FAIRY_MODIFY_NAME_CD then
      local err = ConfigData:GetTipContent(22009)
      cs_MessageCommon.ShowMessageTips(err)
      return
    end
    local err = "SC_Fairy_ModifyName error:" .. tostring(msg.ret)
    self:ShowSCErrorMsg(err)
    return
  end
  cs_WaitNetworkResponse:AddWaitData(proto_csmsg_MSG_ID.MSG_CS_Fairy_ModifyName, msg)
  NetworkManager:HandleDiff(msg.syncUpdateDiff)
end

function FairyNetworkCtrl:CS_Fairy_Life_Free(fairyList, callback)
  self.lifeFreeTable.uid = {}
  for key, fairyData in pairs(fairyList) do
    table.insert(self.lifeFreeTable.uid, fairyData:GetFairyUID())
  end
  self.lifeFreeTable.callback = callback
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_Fairy_Life_Free, proto_csmsg.CS_Fairy_Life_Free, self.lifeFreeTable)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_Fairy_Life_Free, nil, proto_csmsg_MSG_ID.MSG_SC_Fairy_Life_Free)
end

function FairyNetworkCtrl:SC_Fairy_Life_Free(msg)
  if msg.ret and msg.ret ~= proto_csmsg_ErrorCode.None then
    local err = "SC_Fairy_Life_Free error:" .. tostring(msg.ret)
    self:ShowSCErrorMsg(err)
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_Fairy_Life_Free)
    if self.lifeFreeTable.callback ~= nil then
      self.lifeFreeTable.callback(false)
    end
    return
  end
  if self.lifeFreeTable.callback ~= nil then
    self.lifeFreeTable.callback(true, msg.reward)
  end
  cs_WaitNetworkResponse:AddWaitData(proto_csmsg_MSG_ID.MSG_CS_Fairy_Life_Free, msg)
  NetworkManager:HandleDiff(msg.syncUpdateDiff)
end

function FairyNetworkCtrl:CS_Fairy_FastUpgrade(uid, aimLv, dogUidDic, aimRank, callback)
  self.fastLvTable.uid = uid
  self.fastLvTable.aimLv = aimLv
  self.fastLvTable.dogUids = dogUidDic
  self.fastLvTable.aimRank = aimRank
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_Fairy_FastUpgrade, proto_csmsg.CS_Fairy_FastUpgrade, self.fastLvTable)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_Fairy_FastUpgrade, callback, proto_csmsg_MSG_ID.MSG_SC_Fairy_FastUpgrade)
end

function FairyNetworkCtrl:SC_Fairy_FastUpgrade(msg)
  NetworkManager:HandleDiff(msg.syncUpdateDiff)
  if msg.ret and msg.ret ~= proto_csmsg_ErrorCode.None then
    local err = "SC_Fairy_FastUpgrade error:" .. tostring(msg.ret)
    self:ShowSCErrorMsg(err)
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_Fairy_FastUpgrade)
    return
  end
  cs_WaitNetworkResponse:AddWaitData(proto_csmsg_MSG_ID.MSG_CS_Fairy_FastUpgrade, msg)
end

function FairyNetworkCtrl:CS_Fairy_FastUpgradeKeep(uid, skillIds, callback)
  self.fastLvSkillTable.uid = uid
  self.fastLvSkillTable.skillIds = skillIds
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_Fairy_FastUpgradeKeep, proto_csmsg.CS_Fairy_FastUpgradeKeep, self.fastLvSkillTable)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_Fairy_FastUpgradeKeep, callback, proto_csmsg_MSG_ID.MSG_SC_Fairy_FastUpgradeKeep)
end

function FairyNetworkCtrl:SC_Fairy_FastUpgradeKeep(msg)
  NetworkManager:HandleDiff(msg.syncUpdateDiff)
  if msg.ret and msg.ret ~= proto_csmsg_ErrorCode.None then
    local err = "SC_Fairy_FastUpgradeKeep error:" .. tostring(msg.ret)
    self:ShowSCErrorMsg(err)
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_Fairy_FastUpgradeKeep)
    return
  end
end

return FairyNetworkCtrl
