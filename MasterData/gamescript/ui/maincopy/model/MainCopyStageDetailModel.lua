local EMPTY_MONSTER_TID

local function createMainCopyStageDetailModelState(stageTid)
  local state = {}
  state.stageTid = stageTid
  
  function state.stageGroupId()
    do return state.GetStageGroupTid, state end
    return state.GetStageGroupTid, state, stageTid
  end
  
  state.currMonsterTid = EMPTY_MONSTER_TID
  local _stageData = MainCopyDataUtils.GetStageData(stageTid)
  state.currStar = _stageData and _stageData.star or 0
  
  function state.stageTid2Index()
    local stageDataList = state.stageList
    local stageTid2Index = {}
    for index, data in ipairs(stageDataList) do
      if data then
        stageTid2Index[data.stageID] = index
      end
    end
    return stageTid2Index
  end
  
  function state.stageList()
    local groupData = DataCenter.MainCopyData.allPlots[state.stageGroupId]
    if groupData then
      local stageList = {}
      for _, stageData in ipairs(groupData.stageList) do
        table.insert(stageList, stageData)
      end
      return stageList
    end
    return {}
  end
  
  function state.currStageIndex()
    local _stageTid = state.stageTid
    if not _stageTid or not state.stageTid2Index then
      return 0
    end
    return state.stageTid2Index[state.stageTid]
  end
  
  return state
end

local function createMainCopyStageDetailModelViews(data)
  local views = {}
  
  function views:GetStageGroupTid(stageTid)
    local config = self:GetStageCfg(stageTid)
    if not config then
      return
    end
    return config.BelongGroup
  end
  
  function views:GetStageIndex(stageTid)
    if not stageTid or not data.stageTid2Index then
      return
    end
    return data.stageTid2Index[stageTid]
  end
  
  function views:GetStageNumber(stageId)
    local stageCfg = self:GetStageCfg(stageId)
    return stageCfg.NameNumber
  end
  
  function views:GetStageName(stageId)
    local stageCfg = self:GetStageCfg(stageId)
    do return LT.Text end
    return LT.Text, stageCfg.Name
  end
  
  function views:GetStageDesc(stageId)
    local stageCfg = self:GetStageCfg(stageId)
    do return LT.Text end
    return LT.Text, stageCfg.Desc
  end
  
  function views:GetStageBgImage(stageId)
    local stageCfg = self:GetStageCfg(stageId)
    return stageCfg.Backgrand
  end
  
  function views:GetRecommandFighting(stageId)
    local stageCfg = self:GetStageCfg(stageId)
    return stageCfg.RecScore
  end
  
  function views:GetRecommandLevel(stageId)
    local boxId = MainCopyDataUtils.GetDymicDifficultyId(stageId) or stageId
    local oriCfg = self:GetStageCfg(stageId)
    local cfg = self:GetStageCfg(boxId)
    return cfg.StageLevel or oriCfg.StageLevel
  end
  
  function views:GetRecommandSchoolTids(stageId)
    local stageCfg = self:GetStageCfg(stageId)
    return stageCfg.RecClass
  end
  
  function views:GetSortedMonsterTids(stageId)
    local boxId = MainCopyDataUtils.GetDymicDifficultyId(stageId) or stageId
    local tempCfg = DT.StageDifficulty[boxId] or {}
    if tempCfg.Map == nil then
      boxId = stageId
    end
    do return CopyDataUtils.GetStageMonsterWithAffixList, boxId end
    return CopyDataUtils.GetStageMonsterWithAffixList, boxId, true
  end
  
  function views:GetStageCfg(stageId)
    do return MainCopyDataUtils.GetStageConfig end
    return MainCopyDataUtils.GetStageConfig, stageId
  end
  
  function views:GetSchoolIcon(schoolTid)
    local config = self:GetSchoolConfig(schoolTid)
    if not config then
      return
    end
    return config.Icon
  end
  
  function views:GetUnlockItemTid(stageTid)
    local config = self:GetStageCfg(stageTid)
    if not config then
      return
    end
    local unlockItemInfo = config.OpenItem
    if not unlockItemInfo or table.next(unlockItemInfo) == nil then
      return
    end
    local itemTid
    for tid, num in pairs(unlockItemInfo) do
      if num and num > 0 then
        itemTid = tid
        break
      end
    end
    return itemTid
  end
  
  function views:GetUnlockItemIcon(stageTid)
    local itemTid = self:GetUnlockItemTid(stageTid)
    if not itemTid then
      return
    end
    do return ItemDataUtils.GetItemIcon end
    return ItemDataUtils.GetItemIcon, itemTid
  end
  
  function views:GetUnlockItemName(stageTid)
    local itemTid = self:GetUnlockItemTid(stageTid)
    if not itemTid then
      return
    end
    do return ItemDataUtils.GetItemName end
    return ItemDataUtils.GetItemName, itemTid
  end
  
  function views:GetUnlockItemCost(stageTid)
    local config = self:GetStageCfg(stageTid)
    if not config then
      return
    end
    local unlockItemInfo = config.OpenItem
    if not unlockItemInfo or table.next(unlockItemInfo) == nil then
      return
    end
    local cost = 0
    for _, num in pairs(unlockItemInfo) do
      if num and num > 0 then
        cost = num
        break
      end
    end
    return cost
  end
  
  function views:GetSchoolConfig(tid)
    if not tid then
      return
    end
    return DT.SchoolConfig[tid]
  end
  
  function views:IsHaveMap(stageId)
    local stageCfg = self:GetStageCfg(stageId)
    return stageCfg.Map
  end
  
  function views:GetCfgStarCount(stageId)
    local stageCfg = self:GetStageCfg(stageId)
    return #(stageCfg.PerfectCondition or {})
  end
  
  function views:GetStarCount(stageData)
    return stageData.star
  end
  
  function views:GetCfgAchieveCount(stageId)
    local stageCfg = self:GetStageCfg(stageId) or {}
    return #(stageCfg.LevelAchieve or {})
  end
  
  function views:GetAchieveCount(stageData)
    local count = 0
    for _, isFinish in pairs(stageData.achivement or {}) do
      if isFinish >= 1 then
        count = count + 1
      end
    end
    return count
  end
  
  function views:IsFinishAchive(stageData, achiveId)
    return (stageData.achivement[achiveId] or 0) >= 1
  end
  
  function views:GetAchieveState(stageData, achieveId)
    return stageData.achivement[achieveId]
  end
  
  function views:GetMaxAchieveCount(stageId)
    local cfg = self:GetStageCfg(stageId)
    if not cfg then
      return 0
    end
    local levelAchieve = cfg.LevelAchieve or {}
    return #levelAchieve
  end
  
  function views:GetStageRewardList(stageId, curStar)
    local boxId = MainCopyDataUtils.GetDymicDifficultyId(stageId) or stageId
    local oriCfg = self:GetStageCfg(stageId)
    local cfg = self:GetStageCfg(boxId)
    local stageData = MainCopyDataUtils.GetStageData(stageId)
    local rewards = {}
    local firstTimeReward = cfg.FirstTimeReward or oriCfg.FirstTimeReward
    for tid, num, index in table.iteraDouble(firstTimeReward or {}) do
      table.insert(rewards, {
        tid = tid,
        num = num,
        type = CommonDefine.ItemAwardType.First,
        isGot = stageData.firstRewardDraw,
        index = index
      })
    end
    local perfectReward = cfg.PerfectReward or oriCfg.PerfectReward
    for tid, num, index in table.iteraDouble(perfectReward or {}) do
      table.insert(rewards, {
        tid = tid,
        num = num,
        type = CommonDefine.ItemAwardType.First3Star,
        isGot = curStar >= 3,
        index = index
      })
    end
    local normalReward = cfg.NormalReward or oriCfg.NormalReward
    local firstTimeNormalRewardMultiple = cfg.FirstTimeNormalRewardMultiple or oriCfg.FirstTimeNormalRewardMultiple
    for tid, num, index in table.iteraDouble(normalReward or {}) do
      local normalType = CommonDefine.ItemAwardType.Normal
      local isFirst = not stageData.firstRewardDraw
      local isGot = false
      if isFirst and (firstTimeNormalRewardMultiple or 0) > 1 then
        isGot = stageData.firstRewardDraw
        normalType = CommonDefine.ItemAwardType.FirstMult
      end
      table.insert(rewards, {
        tid = tid,
        num = num,
        index = index,
        type = normalType,
        isFirst = isFirst,
        isGot = isGot,
        multipleNum = firstTimeNormalRewardMultiple
      })
    end
    rewards = ItemDataUtils.KickoutAwakerFavorItem(rewards)
    table.sort(rewards, function(a, b)
      local sortWeightA = views:GetItemSortWeight(a)
      local sortWeightB = views:GetItemSortWeight(b)
      if sortWeightA == sortWeightB then
        local itemA = DT.Item[a.tid]
        local itemB = DT.Item[b.tid]
        return itemA.BaseSortID < itemB.BaseSortID
      end
      return sortWeightA > sortWeightB
    end)
    return rewards
  end
  
  function views:GetItemSortWeight(item)
    local weight = 9999
    local gap = 100
    local isGot = item.isGot
    local type = item.type
    if not isGot and type == CommonDefine.ItemAwardType.First3Star then
      return weight - item.index
    end
    weight = weight - gap
    if not isGot and type == CommonDefine.ItemAwardType.First then
      return weight - item.index
    end
    weight = weight - gap
    if not isGot and type == CommonDefine.ItemAwardType.FirstMult then
      return weight - item.index
    end
    weight = weight - gap
    if type == CommonDefine.ItemAwardType.Normal then
      return weight - item.index
    end
    weight = weight - gap
    if type == CommonDefine.ItemAwardType.First3Star then
      return weight - item.index
    end
    weight = weight - gap
    if type == CommonDefine.ItemAwardType.First then
      return weight - item.index
    end
    return weight
  end
  
  function views:GetHideNodeList(stageTid)
    if not stageTid then
      return {}
    end
    do return MainCopyDataUtils.GetHideAwardNodeList end
    return MainCopyDataUtils.GetHideAwardNodeList, stageTid
  end
  
  function views:HasHideNode(stageTid)
    local hideNodeList = self:GetHideNodeList(stageTid)
    return #hideNodeList > 0
  end
  
  function views:HasMonster(stageTid)
    if not stageTid then
      return false
    end
    local monsterTids = self:GetSortedMonsterTids(stageTid)
    if not monsterTids or #monsterTids <= 0 then
      return false
    end
    return true
  end
  
  function views:HasRecommandSchool(stageTid)
    if not stageTid then
      return false
    end
    local config = self:GetStageCfg(stageTid)
    if not (config and config.RecClass) or #config.RecClass <= 0 then
      return false
    end
    return true
  end
  
  function views:HasRecommandLevel(stageTid)
    if not stageTid then
      return false
    end
    local config = self:GetStageCfg(stageTid)
    if not config then
      return false
    end
    local boxId = MainCopyDataUtils.GetDymicDifficultyId(stageTid) or stageTid
    local oriCfg = self:GetStageCfg(stageTid)
    local cfg = self:GetStageCfg(boxId)
    if cfg.StageLevel == nil and oriCfg.StageLevel then
      return false
    end
    return true
  end
  
  function views:HasRelicGroup(stageTid)
    if not stageTid then
      return false
    end
    local config = self:GetStageCfg(stageTid)
    if not (config and config.RelicGroupDrop) or #config.RelicGroupDrop <= 0 then
      return false
    end
    return true
  end
  
  function views:HasEnchant(stageTid)
    if not stageTid then
      return false
    end
    local config = self:GetStageCfg(stageTid)
    if not (config and config.EnchantGroupDrop) or #config.EnchantGroupDrop <= 0 then
      return false
    end
    return true
  end
  
  function views:HasAchievement(stageTid)
    if not stageTid then
      return false
    end
    local config = self:GetStageCfg(stageTid)
    if not config or not config.LevelAchieve then
      return false
    end
    return true
  end
  
  function views:CanChallenge(stageTid)
    local config = self:GetStageCfg(stageTid)
    if not config then
      return false
    end
    if not self:IsEnergyEnough(stageTid) then
      return false
    end
    return true
  end
  
  function views:IsEnergyEnough(stageTid)
    local config = self:GetStageCfg(stageTid)
    if not config then
      return false
    end
    local cost = config.Cost or 0
    return cost <= PlayerDataUtils.GetEnergy()
  end
  
  function views:IsUnlockItemEnough(stageTid)
    local config = self:GetStageCfg(stageTid)
    if not config then
      return false
    end
    if not config.OpenItem then
      return true
    end
    local itemTid, costNum
    local unlockItemInfo = config.OpenItem
    for tid, num in pairs(unlockItemInfo) do
      if num and num > 0 then
        itemTid = tid
        costNum = num
        break
      end
    end
    if itemTid and costNum then
      return costNum <= ItemDataUtils.GetItemNum(itemTid)
    end
    return false
  end
  
  function views:CanUnlockStage(stageTid)
    do return self.IsUnlockItemEnough, self end
    return self.IsUnlockItemEnough, self, stageTid
  end
  
  function views:HasEnergyCost(stageTid)
    if not stageTid then
      return false
    end
    local config = self:GetStageCfg(stageTid)
    if not config then
      return false
    end
    return config.Cost and config.Cost > 0
  end
  
  function views:HasUseUnlockItem(stageTid)
    if not stageTid then
      return true
    end
    local config = self:GetStageCfg(stageTid)
    local stageData = MainCopyDataUtils.GetStageData(stageTid)
    if not config or not stageData then
      return true
    end
    if not config.OpenItem then
      return true
    end
    return stageData.unlockItem ~= false
  end
  
  return views
end

local function createMainCopyStageDetailModelActions(data)
  local actions = {}
  
  function actions:SetStageTid(stageTid)
    data.stageTid = stageTid
  end
  
  function actions:SetMonsterTid(tid)
    data.currMonsterTid = tid
  end
  
  function actions:ResetMonsterTid()
    data.currMonsterTid = EMPTY_MONSTER_TID
  end
  
  function actions:SetCurrStar(star)
    data.currStar = star
  end
  
  function actions:ReqUnlockStage(stageTid, forceUnlock)
    if not forceUnlock and not self:CanUnlockStage(stageTid) then
      return
    end
    EventMgr.Instance.OpenReqMask:Dispatch()
    ProtoManager.Instance:ReqServer("StageRequest", "UnlockStageByItem", function()
      Alert.Show(10755)
    end, function()
    end, stageTid)
  end
  
  return actions
end

local function onSetup(_, _)
end

local MainCopyStageDetailModel = Vue.model("MainCopyStageDetailModel", createMainCopyStageDetailModelState):views(createMainCopyStageDetailModelViews):actions(createMainCopyStageDetailModelActions):setup(onSetup)
return MainCopyStageDetailModel
