local ReinforceCardDunLevelData = class("ReinforceCardDunLevelData")

function ReinforceCardDunLevelData:ctor(levelCfg, actData)
  self.levelCfg = levelCfg
  self.actData = actData
  self.stageCfg = ConfigData.sector_stage[levelCfg.stage_id]
  self:InitLastSelectFactCardId()
end

function ReinforceCardDunLevelData:GetStageId()
  return self.levelCfg.stage_id
end

function ReinforceCardDunLevelData:InitLastSelectFactCardId()
  local actId = self.actData:GetActId()
  local stageId = self:GetStageId()
  local saveUserData = PersistentManager:GetDataModel(PersistentConfig.ePackage.UserData)
  local lastIndex = saveUserData:GetAnni24LastSelectFactCardId(actId, stageId)
  self.__factCardUID = lastIndex
end

function ReinforceCardDunLevelData:SetLastSelectFactCardId(UID)
  self.__factCardUID = UID
  local actId = self.actData:GetActId()
  local stageId = self:GetStageId()
  local saveUserData = PersistentManager:GetDataModel(PersistentConfig.ePackage.UserData)
  saveUserData:SetAnni24LastSelectFactCardId(actId, stageId, UID)
end

function ReinforceCardDunLevelData:GetLastSelectFactCardId()
  return self.__factCardUID
end

function ReinforceCardDunLevelData:GetLevelName()
  return LanguageUtil.GetLocaleText(self.stageCfg.name)
end

function ReinforceCardDunLevelData:GetLevelSmallPic()
  return PathConsts:GetReinforceLevelBgPath(self.levelCfg.small_bg)
end

function ReinforceCardDunLevelData:GetLevelBigPic()
  return PathConsts:GetReinforceLevelBgPath(self.levelCfg.bg_image)
end

function ReinforceCardDunLevelData:GetIsUnlock()
  local stageCfg = self.stageCfg
  local isUnlock = CheckCondition.CheckLua(stageCfg.pre_condition, stageCfg.pre_para1, stageCfg.pre_para2)
  if isUnlock then
    return isUnlock
  end
  local unlockDes = CheckCondition.GetUnlockInfoLua(stageCfg.pre_condition, stageCfg.pre_para1, stageCfg.pre_para2)
  return isUnlock, unlockDes
end

function ReinforceCardDunLevelData:IsHaveRank()
  return self.levelCfg.rank_id ~= 0
end

function ReinforceCardDunLevelData:GetRankId()
  return self.levelCfg.rank_id
end

function ReinforceCardDunLevelData:IsHaveLayerGroup()
  return self.levelCfg.layer_group ~= 0
end

function ReinforceCardDunLevelData:GetLayerGroupId()
  return self.levelCfg.layer_group
end

function ReinforceCardDunLevelData:IsHighEp()
  return self.levelCfg.infinite_score ~= 0
end

function ReinforceCardDunLevelData:GetBuffIds()
  return self.stageCfg.buff_id
end

function ReinforceCardDunLevelData:GetRecPow()
  if self:IsHaveLayerGroup() then
    local layerGroupId = self:GetLayerGroupId()
    local cfgList = ConfigData.reinforce_exploration_layer_group[layerGroupId]
    local curLayer = self.LayerIndex
    local layerCfg = cfgList[curLayer]
    return self.stageCfg.combat + layerCfg.add_combat
  end
  return self.stageCfg.combat
end

function ReinforceCardDunLevelData:GetIsHavingCouldPickReward(actData)
  if self:IsHighEp() then
    local stageId = self:GetStageId()
    local curScore = actData:GetRankScoreByStageId(stageId)
    local pickedScore = actData:GetRankRewardPickedScoreByStageId(stageId)
    local alreadyScore = pickedScore.alreadyScore or table.emptytable
    local rewardGroupId = self.levelCfg.reward_group_id
    local rewardGroupCfgDic = ConfigData.reinforce_exploration_reward_group[rewardGroupId]
    for value, rewardCfg in pairs(rewardGroupCfgDic) do
      local needScore = rewardCfg.value
      local isPicked = alreadyScore[needScore]
      local isComplete = curScore >= needScore
      if isComplete and not isPicked then
        return true
      end
    end
    return false
  elseif self:IsHaveLayerGroup() then
    local stageId = self:GetStageId()
    local curLayer = actData:GetHightestLevelByStageId(stageId)
    local pickedScore = actData:GetRankRewardPickedScoreByStageId(stageId)
    local alreadyLayerDic = pickedScore.alreadyLayerLevel or table.emptytable
    local rewardGroupId = self.levelCfg.reward_group_id
    local rewardGroupCfgDic = ConfigData.reinforce_exploration_reward_group[rewardGroupId]
    for value, rewardCfg in pairs(rewardGroupCfgDic) do
      local needPassedLayer = rewardCfg.value
      local isPicked = alreadyLayerDic[needPassedLayer]
      local isComplete = curLayer >= needPassedLayer
      if isComplete and not isPicked then
        return true
      end
    end
    return false
  end
  return false
end

function ReinforceCardDunLevelData:GetRankRewardDataList()
  local dataList = {}
  local rewardGroupId = self.levelCfg.reward_group_id
  local rewardGroupCfgDic = ConfigData.reinforce_exploration_reward_group[rewardGroupId]
  for value, cfg in pairs(rewardGroupCfgDic) do
    table.insert(dataList, {rewardCfg = cfg})
  end
  table.sort(dataList, function(a, b)
    return a.rewardCfg.value < b.rewardCfg.value
  end)
  return dataList
end

function ReinforceCardDunLevelData:GetNoRankFirstClearReward()
  return self.stageCfg.first_reward_ids, self.stageCfg.first_reward_nums
end

function ReinforceCardDunLevelData:GetNoRankFirstClearRewardIsPicked()
  local isFirstPicked
  local stageId = self:GetStageId()
  local stageState = PlayerDataCenter.sectorStage:GetStageState(stageId)
  if stageState == proto_object_DungeonStageState.DungeonStageStateNone then
  elseif stageState == proto_object_DungeonStageState.DungeonStageStateCompleted then
    NetworkManager:GetNetwork(NetworkTypeID.Sector):Send_SECTOR_BattleFirstRewardPick(stageId)
    isFirstPicked = true
  elseif stageState == proto_object_DungeonStageState.DungeonStageStatePicked then
    isFirstPicked = true
  end
  return isFirstPicked
end

function ReinforceCardDunLevelData:SetLayerIndex(LayerIndex)
  self.LayerIndex = LayerIndex
end

function ReinforceCardDunLevelData:GetLayerIndex()
  return self.LayerIndex
end

function ReinforceCardDunLevelData:GetLevelIsIntime()
  local rankId = self:GetRankId()
  local rankCfg = ConfigData.common_ranklist[rankId]
  local finishTime = rankCfg.overdue_time or 0
  local isIntime = finishTime > PlayerDataCenter.timestamp
  return isIntime, finishTime
end

return ReinforceCardDunLevelData
