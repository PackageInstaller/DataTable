local DungeonMaterialController, Super = NewClass("DungeonMaterialController", BaseController)

function DungeonMaterialController:OnInit()
  self:OnReset()
end

function DungeonMaterialController:OnReset()
end

function DungeonMaterialController:SetStageGroupList()
  local stageGroupType = DungeonMaterialModel.Instance:GetStageGroupType()
  local stageGroupList = StageGroupCfgUtils.GetDisplayStageGroupByType(stageGroupType)
  table.sort(stageGroupList, function(groupA, groupB)
    return groupA.BaseSortID < groupB.BaseSortID
  end)
  DungeonMaterialModel.Instance:SetStageGroupData(stageGroupList)
end

function DungeonMaterialController:GetStageGroupReawrds(stageGroupId)
  local groupCfg = DT.StageGroup[stageGroupId]
  local rewardCfg = groupCfg and groupCfg.StageGroupDropPreview or {}
  local rewardData = {}
  for _, tid in ipairs(rewardCfg) do
    local reward = {}
    reward.tid = tid
    table.insert(rewardData, reward)
  end
  return rewardData
end

function DungeonMaterialController:GetStageGroupType()
  local stageGroupId = DungeonMaterialModel.Instance:GetStageGroupId()
  local stageGroupCfg = DT.StageGroup[stageGroupId]
  if not stageGroupCfg then
    Logger.Warn("[DungeonMaterialController] GetStageGroupType: stageGroup config is nil, stageGroupId=" .. tostring(stageGroupId))
    return nil
  end
  return stageGroupCfg.Type
end

function DungeonMaterialController:GetStageInitRelic()
  local stageId = DungeonMaterialModel.Instance:GetStageId()
  local cfg = DT.Stage[stageId]
  if cfg and cfg.InitRelic then
    return cfg.InitRelic
  end
  return {}
end

function DungeonMaterialController:GetStarLevel(stageId)
  local stageData = DungeonMaterialModel.Instance:GetStageDataById(stageId)
  return stageData.star or 0
end

function DungeonMaterialController:GetStageRewars()
  local stageId = DungeonMaterialModel.Instance:GetStageId()
  do return CopyDataUtils.GetStageRewardPreviewList, stageId end
  return CopyDataUtils.GetStageRewardPreviewList, stageId, {firstPassGotMode = "star", includeTaskNormalReward = false}
end

function DungeonMaterialController:CheckCanChallengeAndShowTips()
  local stageId = DungeonMaterialModel.Instance:GetStageId()
  local showLevelLimit = DungeonUtils.IsShowStageLevelLimit(self:GetStageGroupType())
  if showLevelLimit then
    if not self:IsPlayerLevelReach(stageId) then
      local limitLv = DT.Stage[stageId].PlayerLevel or 0
      Alert.ShowStr(LT.Textf("WeeklyBoss_LvLimit", limitLv))
      return false
    end
  elseif DungeonMaterialModel.Instance:IsLockedStage(stageId) then
    Alert.ShowStr(self:GetStageUnlockTips(stageId))
    return false
  end
  return true
end

function DungeonMaterialController:CheckTrinketCntIsMax()
  if self:GetStageGroupType() == CommonDefine.StageGroupType.TrinketCopy then
    local cnt = ItemDataUtils.GetTrinketCount()
    local limitList = DT.GetOriginalConstant("BagCapacity")
    local maxCnt = limitList[2]
    if cnt >= maxCnt then
      local function confirmFunc()
        UIManager.Instance:Reopen(Urls.AlchemyMainPanel, AlchemyDefine.AlchemyType.TrinketDecompose)
      end
      
      Alert.Show(20091, nil, confirmFunc)
      return true
    end
  end
  return false
end

function DungeonMaterialController:IsStageCanSweep()
  local stageId = DungeonMaterialModel.Instance:GetStageId()
  local stageSweep = DT.Stage[stageId].StageSweep
  if stageSweep then
    return 0 ~= stageSweep
  end
  return false
end

function DungeonMaterialController:GetChallengeBtnState()
  local stageId = DungeonMaterialModel.Instance:GetStageId()
  local btnState = CommonDefine.BtnType.High
  local showLevelLimit = DungeonUtils.IsShowStageLevelLimit(self:GetStageGroupType())
  if showLevelLimit then
    if not self:IsPlayerLevelReach(stageId) then
      btnState = CommonDefine.BtnType.Unclickable
    end
  elseif DungeonMaterialModel.Instance:IsLockedStage(stageId) then
    btnState = CommonDefine.BtnType.Unclickable
  end
  return btnState
end

function DungeonMaterialController:GetSweepBtnState()
  local stageId = DungeonMaterialModel.Instance:GetStageId()
  local showLevelLimit = DungeonUtils.IsShowStageLevelLimit(self:GetStageGroupType())
  if showLevelLimit then
    if not self:IsPlayerLevelReach(stageId) then
      return CommonDefine.BtnType.Unclickable
    end
  elseif DungeonMaterialModel.Instance:IsLockedStage(stageId) then
    return CommonDefine.BtnType.Unclickable
  end
  if StageModel.Instance:IsStageCanSweepBySweepType(stageId) then
    return CommonDefine.BtnType.High
  end
  return CommonDefine.BtnType.Unclickable
end

function DungeonMaterialController:IsUnLockStage(stageId)
  local showLevelLimit = DungeonUtils.IsShowStageLevelLimit(self:GetStageGroupType())
  if showLevelLimit then
    do return self.IsPlayerLevelReach, self end
    return self.IsPlayerLevelReach, self, stageId
  else
    return not DungeonMaterialModel.Instance:IsLockedStage(stageId)
  end
end

function DungeonMaterialController:IsPlayerLevelReach(stageId)
  local playerLv = DataCenter.playerData.DRole.level
  local limitLv = DT.Stage[stageId].PlayerLevel or 0
  return playerLv >= limitLv
end

function DungeonMaterialController:GetStageUnlockTips(stageId)
  local stageCfg = DT.Stage[stageId]
  local showLevelLimit = DungeonUtils.IsShowStageLevelLimit(self:GetStageGroupType())
  if showLevelLimit then
    if not self:IsPlayerLevelReach(stageId) then
      do return LT.Textf, "WeeklyBoss_LvLimit" end
      return LT.Textf, "WeeklyBoss_LvLimit", stageCfg.PlayerLevel, self:GetStageGroupType()
    else
      do return string.format, "%s%s", (LT.Text("Copy_Recommend_Level")) end
      return string.format, "%s%s", LT.Text("Copy_Recommend_Level"), stageCfg.StageLevel, self:GetStageGroupType()
    end
  else
    local stageData = DungeonMaterialModel.Instance:GetStageDataById(stageId)
    if stageData.unlocked then
      do return string.format, "%s%s", (LT.Text("Copy_Recommend_Level")) end
      return string.format, "%s%s", LT.Text("Copy_Recommend_Level"), stageCfg.StageLevel, self:GetStageGroupType()
    else
      local preStageData = DungeonMaterialModel.Instance:GetStageDataById(stageId - 1)
      local preStageCfg = DT.Stage[preStageData.stageID]
      local tipsId = 20016
      local tipsDesc = DT.TipsType[tipsId] and DT.TipsType[tipsId].Desc or ""
      do return LT.Textf, tipsDesc end
      return LT.Textf, tipsDesc, preStageCfg and preStageCfg.Name or ""
    end
  end
end

return DungeonMaterialController
