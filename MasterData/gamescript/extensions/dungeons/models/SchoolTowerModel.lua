local StageGroupType = CommonDefine.StageGroupType
local stageGroupType2DbgDungeonBgType = {
  [StageGroupType.DisposableSchoolTower] = CommonDefine.DbgDungeonBgType.Normal,
  [StageGroupType.AlternationSchoolTower] = CommonDefine.DbgDungeonBgType.Red
}
local SchoolTowerModel = NewClass("SchoolTowerModel", BaseModel)

function SchoolTowerModel:OnInit()
  self._stageGroupAwardProgressDict = {}
  self:RefreshMainViewData()
  self:RefreshDetailViewData()
end

function SchoolTowerModel:OnReset()
  table.clear(self._stageGroupAwardProgressDict)
end

function SchoolTowerModel:RefreshMainViewData()
  self.stageGroupType = StageGroupType.DisposableSchoolTower
  self.featureId = CommonDefine.FeatureId.AlternationSchoolTower
end

function SchoolTowerModel:RefreshDetailViewData(stageGroupId, stageId)
  self.selectStageGroupTid = stageGroupId or 0
  self.curMonsterTid = nil
  self.stageDataList = {}
  self:Update_stageDataList(self.selectStageGroupTid)
  self.selectStageTid = self:GetDefaultSelectStage(stageId, self.stageDataList)
  self.relicDataList = {}
  self:Update_relicDataList(self.selectStageTid)
  self.monsterDataList = {}
  self:Update_monsterDataList(self.selectStageTid)
  self.rewardDataList = {}
  self:Update_rewardDataList(self.selectStageTid)
end

function SchoolTowerModel:Set_curMonsterTid(numVal)
  self.curMonsterTid = numVal
  self:LocalNotify(NotifyId.OnSchoolTowerDetailSelectMonsterChanged)
end

function SchoolTowerModel:Set_selectStageTid(numVal)
  if not numVal or type(numVal) ~= "number" then
    return
  end
  self.selectStageTid = numVal
  self:RefreshDetailViewData(self.selectStageGroupTid, self.selectStageTid)
  self:LocalNotify(NotifyId.OnSchoolTowerDetailSelectStageChanged)
end

function SchoolTowerModel:Set_selectStageGroupId(numVal)
  if not numVal or type(numVal) ~= "number" then
    return
  end
  self.selectStageGroupTid = numVal
end

function SchoolTowerModel:GetDefaultSelectStage(defaultStageId, stageDataList)
  local defulatIdx = 1
  for idx, stageData in ipairs(self.stageDataList) do
    if stageData.unlock then
      defulatIdx = idx
    end
  end
  local lastUnlockStageData = stageDataList[math.max(1, defulatIdx)]
  local lastUnlockStageId = lastUnlockStageData and lastUnlockStageData.stageID or 0
  return defaultStageId or lastUnlockStageId
end

function SchoolTowerModel:SetStageGroupAwardProgressDict(stageGroupTid, tbl)
  self._stageGroupAwardProgressDict[stageGroupTid] = tbl
end

function SchoolTowerModel:SetStageGroupAwardProgress(stageGroupTid, star, boolVal)
  if not self._stageGroupAwardProgressDict[stageGroupTid] then
    self._stageGroupAwardProgressDict[stageGroupTid] = {}
  end
  self._stageGroupAwardProgressDict[stageGroupTid][star] = boolVal
end

function SchoolTowerModel:GetStageGroupAwardProgressDict(stageGroupTid)
  return self._stageGroupAwardProgressDict[stageGroupTid]
end

function SchoolTowerModel:GetStageGroupAwardMaxProgressStar(stageGroupTid)
  local progressDict = self:GetStageGroupAwardProgressDict(stageGroupTid)
  if not progressDict then
    return 0
  end
  local maxStar = 0
  for star, _ in pairs(progressDict) do
    if star > maxStar then
      maxStar = star
    end
  end
  return maxStar
end

function SchoolTowerModel:GetCurStageGroupCfg()
  if not self.selectStageGroupTid or not DT.StageGroup[self.selectStageGroupTid] then
    return {}
  end
  return DT.StageGroup[self.selectStageGroupTid]
end

function SchoolTowerModel:GetCurStageCfg()
  if not self.selectStageTid or not DT.Stage[self.selectStageTid] then
    return {}
  end
  return DT.Stage[self.selectStageTid]
end

function SchoolTowerModel:GetCurStageCfgField(field)
  local cfg = self:GetCurStageCfg()
  if not table.next(cfg) then
    return nil
  end
  return cfg[field]
end

function SchoolTowerModel:GetCurStageGroupCfgField(field)
  local cfg = self:GetCurStageGroupCfg()
  if not table.next(cfg) then
    return nil
  end
  return cfg[field]
end

function SchoolTowerModel:Update_rewardDataList(stageId)
  local rst = {}
  local cfg = DT.Stage[stageId]
  if cfg and cfg.NormalReward then
    local rewards = {}
    for tid, count in table.iteraDouble(cfg.NormalReward) do
      table.insert(rewards, {tid = tid, count = count})
    end
    table.sort(rewards, function(a, b)
      local aCfg = DT.Item[a.tid]
      local bCfg = DT.Item[b.tid]
      return aCfg.BaseSortID < bCfg.BaseSortID
    end)
    rst = ItemDataUtils.KickoutAwakerFavorItem(rewards)
  end
  self.rewardDataList = rst
end

function SchoolTowerModel:Update_stageDataList(stageGroupId)
  if not stageGroupId then
    self.stageDataList = {}
    return
  end
  local rst = self:GetStageDataList(stageGroupId)
  self.stageDataList = rst
end

function SchoolTowerModel:GetStageDataList(stageGroupId)
  local towerData = SchoolTowerDataUtils.GetTowerDataGroup(stageGroupId)
  if not towerData or not table.next(towerData) then
    return {}
  end
  local rst = {}
  for _, tbl in pairs(towerData.stageList) do
    table.insert(rst, tbl)
  end
  table.sort(rst, function(a, b)
    local aCfg = DT.Stage[a.stageID]
    local bCfg = DT.Stage[b.stageID]
    return aCfg.BaseSortID < bCfg.BaseSortID
  end)
  return rst
end

function SchoolTowerModel:Update_relicDataList(stageId)
  self.relicDataList = CopyDataUtils.GetStageInitRelic(stageId)
end

function SchoolTowerModel:Update_monsterDataList(stageId)
  self.monsterDataList = CopyDataUtils.GetStageMonsterWithAffixList(stageId, true)
end

function SchoolTowerModel:GetCanChallenge(stageId)
  local type = self:GetCurStageGroupCfgField("Type")
  local showLevelLimit = DungeonUtils.IsShowStageLevelLimit(type)
  if showLevelLimit then
    if not CopyDataUtils.CheckLevelReach(stageId) then
      return false
    end
  elseif CopyDataUtils.GetIsLocked(stageId, self.stageDataList) then
    return true
  end
  return false
end

function SchoolTowerModel:GetShowUnlockTips(stageId)
  local stageCfg = DT.Stage[stageId] or {}
  local type = self:GetCurStageGroupCfgField("Type")
  local stageLevel = stageCfg.StageLevel or 0
  local playerLevel = stageCfg.PlayerLevel or 0
  local showLevelLimit = DungeonUtils.IsShowStageLevelLimit(type)
  if showLevelLimit and not CopyDataUtils.CheckLevelReach(stageId) then
    local limitLv = playerLevel
    do return LT.Textf, "WeeklyBoss_LvLimit" end
    return LT.Textf, "WeeklyBoss_LvLimit", limitLv
  else
    do return string.format, "%s%s", (LT.Text("Copy_Recommend_Level")) end
    return string.format, "%s%s", LT.Text("Copy_Recommend_Level"), stageLevel
  end
end

function SchoolTowerModel:GetTowerRedStage(stageGroupId)
  do return RedPointDataUtils.GetRedPointState, RedPointDataUtils.RedType.MainStageGetAward end
  return RedPointDataUtils.GetRedPointState, RedPointDataUtils.RedType.MainStageGetAward, {stageGroupId}, stageGroupId
end

function SchoolTowerModel:GetTowerFeatureUnlock(stageGroupId)
  local _, unlock = PlayerDataUtils.IsFeatureUnlock(self.featureId, stageGroupId)
  return unlock
end

function SchoolTowerModel:GetTowerSvrData()
  local rst = SchoolTowerDataUtils.GetTowerDataByStageGroupType(self.stageGroupType)
  table.sort(rst, function(a, b)
    local cfgA = DT.StageGroup[a.stageGroupId]
    local cfgB = DT.StageGroup[b.stageGroupId]
    return cfgA.Sequence < cfgB.Sequence
  end)
  return rst
end

function SchoolTowerModel:Set_stageGroupType(type)
  if not type then
    return
  end
  self.stageGroupType = type
  EventMgr.Instance.OnDungeonBgChange:Dispatch(stageGroupType2DbgDungeonBgType[self.stageGroupType])
end

function SchoolTowerModel:Get_stageGroupType()
  if SchoolTowerDataUtils.NeedBanAlternationSchool() then
    return StageGroupType.DisposableSchoolTower
  end
  return self.stageGroupType
end

function SchoolTowerModel:GetCountDown()
  local refreshTs = SchoolTowerDataUtils.GetTowerRefreshTs(self:GetCurStageGroupCfgField("Type"))
  if refreshTs then
    return refreshTs - TimeUtils.GetServerTime()
  end
  return 0
end

return SchoolTowerModel
