local DungeonStageData = class("DungeonStageData")
DungeonStageData.eDungeonStageState = {
  lock = 0,
  unlock = 1,
  completed = 2,
  noData = 3
}

function DungeonStageData.CreateDungeonStageData(dungeonData, dungeonStageCfg)
  local data = DungeonStageData.New()
  data.dungeonData = dungeonData
  data.dungeonStageCfg = dungeonStageCfg
  data:__UpdateStage()
  return data
end

function DungeonStageData:ctor()
  self.dungeonData = nil
  self.dungeonStageCfg = nil
  self.dungeonStageState = nil
  self.lockResone = nil
end

function DungeonStageData:__UpdateStage()
  local isUnlock = CheckCondition.CheckLua(self.dungeonStageCfg.pre_condition, self.dungeonStageCfg.pre_para1, self.dungeonStageCfg.pre_para2)
  local isCompleted = 0 < (PlayerDataCenter.dungeonTotalBattleTimes[self:GetDungeonStageId()] or 0)
  if isUnlock then
    if isCompleted then
      self.dungeonStageState = DungeonStageData.eDungeonStageState.completed
    else
      self.dungeonStageState = DungeonStageData.eDungeonStageState.unlock
    end
  else
    self.dungeonStageState = DungeonStageData.eDungeonStageState.lock
  end
  self:UpdSgStageRedDot()
end

function DungeonStageData:GetDungeonStageUnlockInfo()
  return ConfigData:GetTipContent(196)
end

function DungeonStageData:GetDungeonStageUnlockData()
  local preConditionList = {}
  local preCondition, prePara1, prePara2
  local cfg = self.dungeonStageCfg
  for i = 1, #cfg.pre_condition do
    preCondition = {
      cfg.pre_condition[i]
    }
    prePara1 = {
      cfg.pre_para1[i]
    }
    prePara2 = {
      cfg.pre_para2[i]
    }
    local unlock = CheckCondition.CheckLua(preCondition, prePara1, prePara2)
    local lockReason = CheckCondition.GetUnlockInfoLua(preCondition, prePara1, prePara2)
    table.insert(preConditionList, {unlock = unlock, lockReason = lockReason})
  end
  return preConditionList
end

function DungeonStageData:GetDungeonStageId()
  return self.dungeonStageCfg.id
end

function DungeonStageData:GetDungeonStageCfg()
  return self.dungeonStageCfg
end

function DungeonStageData:IsDgStageQuickBattleOpen()
  return self.dungeonStageCfg.quick_battle
end

function DungeonStageData:IsDgStageQuickBattleUnlock()
  local completeChallenge = PlayerDataCenter.dungeonCenterData:IsDgChallengeTaskCompleteAll(self:GetDungeonStageId())
  return completeChallenge
end

function DungeonStageData:GetDungeonStageIsUnlock()
  return self.dungeonStageState ~= DungeonStageData.eDungeonStageState.lock
end

function DungeonStageData:GetDungeonStageIsCompleted()
  return self.dungeonStageState == DungeonStageData.eDungeonStageState.completed
end

function DungeonStageData:GetDungeonStageState()
  return self.dungeonStageState
end

function DungeonStageData:GetDungeonSeverType()
  return self.dungeonStageCfg.dungeon_type
end

function DungeonStageData:GetThisCyclePlayedNum()
  local dailyPlayedNum = 0
  local dungeonSysFuncId = self.dungeonData:GetDungeonSystemFunctionId()
  local stageId = self.dungeonStageCfg.id
  if PlayerDataCenter.dungeonDailyBattleTimes ~= nil and PlayerDataCenter.dungeonDailyBattleTimes[dungeonSysFuncId] ~= nil then
    local dungeonStageDic = PlayerDataCenter.dungeonDailyBattleTimes[dungeonSysFuncId].data
    if dungeonStageDic[stageId] ~= nil then
      dailyPlayedNum = dungeonStageDic[stageId]
    end
  end
  return dailyPlayedNum
end

function DungeonStageData:GetDgStageDungeonData()
  return self.dungeonData
end

function DungeonStageData:GetCurDungeonDailyLimit()
  local dailyLimit = self.dungeonStageCfg.frequency_day
  if dailyLimit == -1 then
    return -1
  end
  local dailyPlayedNum = self:GetThisCyclePlayedNum()
  return dailyLimit - dailyPlayedNum, dailyLimit, dailyPlayedNum
end

function DungeonStageData:GetIsReach2Limit()
  local dailyLimit = self.dungeonStageCfg.frequency_day
  if dailyLimit == -1 then
    return false
  end
  local dailyPlayedNum = self:GetThisCyclePlayedNum()
  return dailyLimit <= dailyPlayedNum, dailyLimit, dailyPlayedNum
end

function DungeonStageData:IsHaveATHReward()
  local cfg = self.dungeonStageCfg
  if cfg == nil then
    return false
  end
  local norDrop = cfg.normal_drop
  for _, itemId in ipairs(norDrop) do
    local itemCfg = ConfigData.item[itemId]
    if itemCfg ~= nil then
      if itemCfg.type == eItemType.Package then
        if ConfigData.item.athGiftDic[itemId] ~= nil then
          return true
        end
      elseif itemCfg.type == eItemType.Arithmetic then
        return true
      end
    end
  end
  for _, itemId in ipairs(cfg.first_reward_ids) do
    local itemCfg = ConfigData.item[itemId]
    if itemCfg ~= nil then
      if itemCfg.type == eItemType.Package then
        if ConfigData.item.athGiftDic[itemId] ~= nil then
          return true
        end
      elseif itemCfg.type == eItemType.Arithmetic then
        return true
      end
    end
  end
  return false
end

function DungeonStageData:GetNormalCostItemDic()
  if self.costItemDic then
    return self.costItemDic
  end
  local dic = {}
  for index, itemId in ipairs(self.dungeonStageCfg.cost_itemIds) do
    local num = self.dungeonStageCfg.cost_itemNums[index]
    dic[itemId] = num
  end
  self.costItemDic = dic
  return dic
end

function DungeonStageData:GetStaminaCost()
  if self.stamina then
    return self.stamina
  end
  for index, itemId in ipairs(self.dungeonStageCfg.cost_itemIds) do
    if itemId == ConstGlobalItem.SKey then
      local num = self.dungeonStageCfg.cost_itemNums[index]
      self.stamina = num
      return num
    end
  end
end

function DungeonStageData:UpdSgStageRedDot()
  if self.dungeonData.dungeonTypeData == nil then
    return
  end
  local _, sctSrcNode = RedDotController:GetRedDotNode(RedDotStaticTypeId.Main, RedDotStaticTypeId.SectorEntrance, RedDotStaticTypeId.SectorEntranceSrcDun)
  local dungeonType = self.dungeonData.dungeonTypeData.dungeonType
  local dungeonId = self.dungeonData.dungeonId
  local dungeonStageId = self:GetDungeonStageId()
  local dgTypeNode = sctSrcNode:AddChildWithPath(dungeonType, RedDotDynPath.SctDgTypePath)
  local dgNode = dgTypeNode:AddChildWithPath(dungeonId, RedDotDynPath.SctDungeonPath)
  local dgStageNode = dgNode:AddChildWithPath(dungeonStageId, RedDotDynPath.SctDgStagePath)
  self._dgStageDotNode = dgStageNode
  self:_UpdChallengeTaskRed(dgStageNode)
end

function DungeonStageData:_UpdChallengeTaskRed(dgStageNode)
  local dungeonStageId = self:GetDungeonStageId()
  if not PlayerDataCenter.dungeonCenterData:HasDungeonChallengeTask(dungeonStageId) then
    return
  end
  local clgNode = dgStageNode:AddChild(RedDotStaticTypeId.SctDgChallengeTask)
  local saveUserData = PersistentManager:GetDataModel(PersistentConfig.ePackage.UserData)
  if PlayerDataCenter.dungeonCenterData:IsDgChallengeTaskCompleteAll(dungeonStageId) then
    clgNode:SetBlueDotCount(0)
  elseif self:GetDungeonStageIsUnlock() then
    local isRead = saveUserData:GetDgChallengeRead(dungeonStageId)
    clgNode:SetBlueDotCount(isRead and 0 or 1)
  end
end

function DungeonStageData:GetDgStageRedDotNode()
  return self._dgStageDotNode
end

function DungeonStageData:Delete()
end

return DungeonStageData
