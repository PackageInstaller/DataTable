local WorldStageManager, Super = System.NewClass("WorldStageManager", Manager)

function WorldStageManager:ctor()
  Super.ctor(self)
end

function WorldStageManager:Awake(binder)
  Super.Awake(self, binder)
  self.binder = binder
  self:PreDealConfig()
  self.stageDataList = DataCenter.worldStageDataList
  self.stagePrepareCbs = {}
  self.stageCompList = {}
  self.curGroupId = nil
  self.expressionContextStageTid = nil
  binder:BindResponse(self, "World", "LogStage", System.fn(self, self.LogStage))
end

function WorldStageManager:SetExpressionContextStageTid(stageTid)
  self.expressionContextStageTid = stageTid
end

function WorldStageManager:GetExpressionContextStageTid()
  return self.expressionContextStageTid
end

function WorldStageManager:WipeUp(_, _)
end

function WorldStageManager:CheckOpen(stageId, prepareFunc, chooseTalents, activityTid, extraData)
  if self:Check(stageId) then
    self:Open(stageId, prepareFunc, chooseTalents, activityTid, extraData)
    return true
  end
  return false
end

function WorldStageManager:CheckOpenMainChapter(stageId, prepareFunc)
  if self:Check(stageId) then
    self:Open(stageId, prepareFunc)
    return true
  end
end

function WorldStageManager:GetStageIdList(groupId)
  return self.stageGroups[groupId] or {}
end

function WorldStageManager:GetStageData(groupId)
  return self.stageDataList[groupId]
end

function WorldStageManager:GetCurStageData()
  if bg.isReplay then
    return nil
  end
  return self.stageDataList[self.curGroupId]
end

function WorldStageManager:GetCurStageGroupId()
  return self.curGroupId
end

function WorldStageManager:GetCurStageId()
  local stageData = self.stageDataList[self.curGroupId]
  return stageData and stageData.stageId
end

function WorldStageManager:GetCurStageChapter()
  local stageData = self.stageDataList[self.curGroupId]
  if stageData and stageData.stageId then
    do return CopyDataUtils.GetStageChapter end
    return CopyDataUtils.GetStageChapter, stageData.stageId
  end
end

function WorldStageManager:GetOneLineBattleNodes()
  if not self:IsOneLineMap() then
    return
  end
  local stageId = self:GetCurStageId()
  if not stageId then
    return
  end
  do return CopyDataUtils.GetOneLineStageBattleNodes end
  return CopyDataUtils.GetOneLineStageBattleNodes, stageId
end

function WorldStageManager:GetOneLineRoundInfo()
  if not self:IsOneLineMap() then
    return
  end
  local curStageComp = self:GetCurStageComp()
  if not curStageComp then
    return
  end
  do return curStageComp.GetRoundInfo end
  return curStageComp.GetRoundInfo, curStageComp
end

function WorldStageManager:PreDealConfig()
  local stageGroups = {}
  local tb_insert = table.insert
  for _, info in pairs(DT.Stage) do
    stageGroups[info.BelongGroup] = stageGroups[info.BelongGroup] or {}
    tb_insert(stageGroups[info.BelongGroup], info.ID)
  end
  self.stageGroups = stageGroups
end

function WorldStageManager:Check(stageId)
  local stageCfg = DT.Stage[stageId]
  assert(stageCfg, string.format("关卡id： %s 不存在", stageId))
  local cost = stageCfg.Cost or 0
  if cost > PlayerDataUtils.GetEnergy() then
    PlayerDataUtils.ShowEnergyRestorePanel()
    return false
  end
  return true
end

function WorldStageManager:Open(stageId, prepareFunc, chooseTalents, activityTid, extraData)
  local stageData = self:GenerateStageData(stageId, chooseTalents, activityTid, extraData)
  self.stageDataList[stageData.groupId] = stageData
  self.stagePrepareCbs[stageData.groupId] = prepareFunc
  self:LoadCachedTeamData()
  self:StartStage(stageData.groupId)
end

function WorldStageManager.OpenWorldstageMainPanel(stageGroupId, stageId)
  UIManager.Instance:Reopen(Urls.WorldStageMainPanel, stageGroupId, stageId)
end

function WorldStageManager:GenerateStageData(stageId, chooseTalents, activityTid, extraData)
  local stageCfg = DT.Stage[stageId]
  if nil == stageCfg then
    Logger.Warn("配置没找到", stageId)
    return
  end
  local groupId = stageCfg.BelongGroup
  local stageData = Vue.reactive({})
  stageData.stageId = stageId
  stageData.groupId = groupId
  stageData.activityTid = activityTid
  stageData.descList = self:GetEffectDescList(groupId)
  stageData.respawnedNum = 0
  stageData.chooseTalents = chooseTalents or {}
  stageData.extraData = extraData
  if extraData and extraData.specialMode then
    stageData.specialMode = extraData.specialMode
  end
  self.curGroupId = groupId
  stageData.nodeList = {}
  local maxNodeNum = CommonDefine.MaxStageNodeNum
  for index = 1, maxNodeNum do
    local section = "StageSection" .. index
    if stageCfg[section] then
      table.insert(stageData.nodeList, table.clone(stageCfg[section]))
    end
  end
  stageData.nodeIndex = 0
  return stageData
end

function WorldStageManager:RemoveStageComp(stageGroupId)
  local stageComp = self.stageCompList[stageGroupId]
  if stageComp then
    stageComp:OnDestroy()
  end
  self.stageCompList[stageGroupId] = nil
end

function WorldStageManager:CreateStageComp(stageType, stageData, recoverData)
  local StageGroupType = CommonDefine.StageGroupType
  local stageComp
  if stageType == StageGroupType.WeeklyCopy2 or stageType == StageGroupType.WeeklyCopy then
    stageComp = WorldWeekStageComp(stageData, recoverData)
  elseif IntroductionDataUtils.GetStageGroupId() ~= stageData.groupId then
    stageComp = WorldStageComp(stageData, recoverData)
  else
    stageComp = WorldIntroductionComp(stageData, recoverData)
  end
  local childBinder = self.binder:createChild(stageComp)
  stageComp:OnBind(childBinder)
  stageComp:Awake()
  return stageComp
end

function WorldStageManager:OnRecoveryStage(stageTid, recoverData, chooseTalents)
  if recoverData and AbyssDataUtils.IsAbyssStageTid(stageTid) and WorldRecoveryManager.Instance:IsStageExpiredByServer() then
    local stageCfg = DT.Stage[stageTid]
    local stageGroupId = stageCfg and stageCfg.BelongGroup
    if stageGroupId then
      Logger.Info("[WorldStageManager] OnRecoveryStage: abyss stage expired by server, skip create stageComp, stageGroupId=%s", tostring(stageGroupId))
      WorldRecoveryManager.Instance:ShowAbyssResetTipsByStageGroupId(stageGroupId)
    end
    return
  end
  local stageData = self:GenerateStageData(stageTid, chooseTalents)
  if not stageData then
    Logger.Error("[WorldStageManager] OnRecoveryStage: GenerateStageData failed, stageTid=%s", tostring(stageTid))
    return
  end
  self.stageDataList[stageData.groupId] = stageData
  self:RemoveStageComp(stageData.groupId)
  local cfg = DT.StageGroup[stageData.groupId]
  local stageComp = self:CreateStageComp(cfg.Type, stageData, recoverData)
  self.stageCompList[stageData.groupId] = stageComp
  StateDataUtils.Reset()
end

function WorldStageManager:UpdateStageRespawnedNum(num, isRespawing, lives)
  local stageData = self.stageDataList[self.curGroupId]
  if stageData then
    stageData.respawnedNum = num
    stageData.isRespawing = isRespawing
    stageData.lives = lives
  end
end

function WorldStageManager:IsInStage()
  local stageComp = self:GetCurStageComp()
  if not stageComp then
    return false
  end
  if stageComp:GetStageExitData() then
    return false
  end
  return stageComp.isHaveWorldData
end

function WorldStageManager:IsOneLineMap()
  local stageComp = self:GetCurStageComp()
  if stageComp then
    do return stageComp.IsOneLineMap end
    return stageComp.IsOneLineMap, stageComp
  end
end

function WorldStageManager:StartStage(groupId, userData)
  local stageData = self.stageDataList[groupId]
  self:RemoveStageComp(groupId)
  local cfg = DT.StageGroup[groupId]
  local stageComp = self:CreateStageComp(cfg.Type, stageData)
  self.stageCompList[groupId] = stageComp
end

function WorldStageManager:EnterStage(groupId)
  StageExitPanelManager.Instance:Clear()
  local prepareFunc = self.stagePrepareCbs[groupId]
  if prepareFunc then
    prepareFunc()
  end
end

function WorldStageManager:ClearStage(groupId)
  if groupId == self.curGroupId then
    self.curGroupId = nil
  end
  local stageComp = self.stageCompList[groupId]
  if stageComp then
    stageComp:OnDestroy()
    self.stageCompList[groupId] = nil
  end
end

function WorldStageManager:FinishStage(groupId)
  if groupId == self.curGroupId then
    self.lastGroupId = self.curGroupId
    self.curGroupId = nil
  end
  local stageComp = self.stageCompList[groupId]
  if stageComp then
    stageComp:OnDestroy()
    self.stageCompList[groupId] = nil
    StageExitPanelManager.Instance:OnStageExit()
  end
  if not UIManager.Instance:GetWindow(Urls.DBGMainCopyOutPanel) then
    CopiesDataUtils.ClearCopiesSettleData()
  end
  AvgStoryManager.Instance:ClearSkipPlot()
  self:StopStageLog()
end

function WorldStageManager:ReqExit(tid, callFunc)
  local stageComp = self.stageCompList[tid]
  if stageComp then
    stageComp:ReqExit(stageComp.stageData.stageId, callFunc)
  end
end

function WorldStageManager:ReqSaveAndExit(tid, callFunc)
  local stageComp = self.stageCompList[tid]
  if stageComp then
    stageComp:ReqSaveAndExit(stageComp.stageData.stageId, callFunc)
  end
end

function WorldStageManager:LoadCachedTeamData()
end

function WorldStageManager:GetTeamData(groupId)
  return self.cachedTeamData and self.cachedTeamData[groupId]
end

function WorldStageManager:StartStageLog(stageId, wid, reason)
  StageLogClient:StartLogFile(stageId, wid, reason)
end

function WorldStageManager:LogStage(msg, wid, tid)
  StageLogClient:Log(msg, wid, tid)
end

function WorldStageManager:StopStageLog()
  StageLogClient:StopLogFile()
end

function WorldStageManager:ReplayBGM()
  local com = self:GetCurStageComp()
  if com and com:GetIsInMap() then
    AudioManager.Instance:StopBGM()
    com.map:PlayBGM()
  end
end

function WorldStageManager:UpdateSchoolArgs(schoolArgs)
  local stageData = self.stageDataList[self.curGroupId]
  if not stageData then
    return
  end
  local role = stageData.role
  if not role then
    return
  end
  stageData.role.schoolArgs = schoolArgs
end

function WorldStageManager:UpdateKeeperArgs(keeperArgs)
  local stageData = self.stageDataList[self.curGroupId]
  if not stageData then
    return
  end
  local role = stageData.role
  if not role then
    return
  end
  stageData.role.keeperArgs = WorldStageManager.NormalizeKeeperDescArgs(keeperArgs)
end

function WorldStageManager.NormalizeKeeperDescArgs(keeperArgs)
  if not keeperArgs then
    return nil
  end
  if keeperArgs.curValues then
    return keeperArgs
  end
  if keeperArgs.descArgs and keeperArgs.descArgs.curValues then
    return keeperArgs.descArgs
  end
  return keeperArgs
end

function WorldStageManager:GetKeeperArgs()
  local stageData = self.stageDataList[self.curGroupId]
  if not stageData or not stageData.role then
    return
  end
  local role = stageData.role
  do return WorldStageManager.NormalizeKeeperDescArgs end
  return WorldStageManager.NormalizeKeeperDescArgs, role.keeperArgs or role.keeperSkillDescArgs
end

function WorldStageManager:UpdateUltiArgs(tid, args)
  local stageData = self.stageDataList[self.curGroupId]
  if not stageData then
    return
  end
  CopyAwakerDataUtils.UpdateUltiArgs(tid, args)
end

function WorldStageManager:GetSchoolTips()
  local stageData = self.stageDataList[self.curGroupId]
  if not stageData then
    return ""
  end
  local role = stageData.role
  if not role then
    return ""
  end
  local school = role.school
  local schoolArgs = role.schoolArgs and role.schoolArgs[school] or role.schoolArgs or {}
  return AwakerDataUtils.GetSchoolTips(school, true, schoolArgs) or ""
end

function WorldStageManager:UpdatePlayerAttrs(data)
  local stageData = self.stageDataList[self.curGroupId]
  if not stageData then
    return
  end
  local role = stageData.role
  if not role then
    return
  end
  local roleAttrsList = role.roleAttrsList or {}
  for roleId, info in pairs(data) do
    if 0 == roleId then
      for attrName, value in pairs(info) do
        role[attrName] = value
      end
    elseif roleAttrsList[roleId] then
      for attrName, value in pairs(info) do
        roleAttrsList[roleId][attrName] = value
      end
    end
  end
end

function WorldStageManager:GetAttr(attrName, tid)
  local stageData = self.stageDataList[self.curGroupId]
  if not stageData then
    return 0
  end
  local role = stageData.role
  if not role then
    return 0
  end
  if not tid or 0 == tid then
    return role[attrName] or 0
  end
  if not role.roleAttrsList then
    return 0
  end
  if not role.roleAttrsList[tid] then
    return 0
  end
  return role.roleAttrsList[tid][attrName] or 0
end

function WorldStageManager:GetAwakerAvgAttr(attrName)
  local stageData = self.stageDataList[self.curGroupId]
  local role = stageData and stageData.role
  if not role then
    return 0
  end
  local roleAttrsList = role.roleAttrsList or {}
  local awakerNum, value = 0, 0
  for tid, attrInfo in pairs(roleAttrsList) do
    if 0 ~= tid then
      value = (attrInfo[attrName] or 0) + value
      awakerNum = awakerNum + 1
    end
  end
  if awakerNum > 0 then
    do return math.ceil end
    return math.ceil, value / awakerNum, pairs(roleAttrsList)
  end
  return 0
end

function WorldStageManager:GetTeamAtk()
  local stageData = self.stageDataList[self.curGroupId]
  local role = stageData and stageData.role
  if not role then
    return 0
  end
  local totalAtk = 0
  local awakerNum = 0
  for _, attr in pairs(role.roleAttrsList) do
    awakerNum = awakerNum + 1
    local atk = attr.atk
    local atk_per = attr.atk_per or 0
    local final_atk = math.ceil(atk * (1 + atk_per / 100))
    totalAtk = final_atk + totalAtk
  end
  if awakerNum > 0 then
    totalAtk = math.ceil(totalAtk / awakerNum)
  end
  return totalAtk
end

function WorldStageManager:OnAddAwaker(data)
  local stageData = self.stageDataList[self.curGroupId]
  if not stageData then
    return
  end
  stageData.role.awakerTids = {}
  for _, awakerInfo in ipairs(data.awakerInfos) do
    CopyAwakerDataUtils.UpdateBattleAwakerData(awakerInfo)
    stageData.role.roleAttrsList[awakerInfo.tid] = awakerInfo.attrs
    table.insert(stageData.role.awakerTids, awakerInfo.tid)
    table.insert(stageData.role.awakerInfos, awakerInfo)
  end
  local showAwakerNum = 0
  local name = ""
  for index, tid in ipairs(stageData.role.awakerTids) do
    if not tid then
    else
      local summonItemData = {awakerItemTid = tid}
      SummonDataUtils.ShowGainItems(summonItemData)
      showAwakerNum = showAwakerNum + 1
      local config = AwakerDataUtils.GetAwakerConfig(tid)
      name = name .. LT.Text(config.Name)
      if index < #stageData.role.awakerTids then
        name = name .. ", "
      end
    end
  end
  local animData = {
    summonNum = showAwakerNum,
    skipBeginAnim = true,
    isSpecialAwakerTid = true
  }
  if UIManager.Instance:GetWindow(Urls.WorldStageMainPanel) then
    UIManager.Instance:Reopen(Urls.SummonNewItemPanel, nil, nil, nil, animData)
  else
    UIManager.Instance:InsertCopyUIReopenQueue(Urls.SummonNewItemPanel, nil, nil, nil, animData)
  end
end

function WorldStageManager:GetCurStageComp()
  if not self.curGroupId or not self.stageCompList then
    return
  end
  return self.stageCompList[self.curGroupId]
end

function WorldStageManager:GetCurMapRole()
  local stageComp = self:GetCurStageComp()
  local mapRoleManager = stageComp and stageComp.map and stageComp.map:GetComponent(MapRoleManager)
  if not mapRoleManager then
    return
  end
  local mapRole = mapRoleManager:GetRole()
  return mapRole
end

function WorldStageManager:SetCurTriggeredGearType(gearType)
  local stageComp = self:GetCurStageComp()
  if not stageComp then
    return
  end
  stageComp:SetCurTriggeredGearType(gearType)
end

function WorldStageManager:GetCurTriggeredGearType()
  local stageComp = self:GetCurStageComp()
  if stageComp then
    do return stageComp.GetCurTriggeredGearType end
    return stageComp.GetCurTriggeredGearType, stageComp
  end
end

function WorldStageManager:GetCurTriggerGearData()
  local stageComp = self:GetCurStageComp()
  if stageComp then
    do return stageComp.GetCurTriggerGearData end
    return stageComp.GetCurTriggerGearData, stageComp
  end
end

function WorldStageManager:GetGearObj(gearUid)
  local stageComp = self:GetCurStageComp()
  if stageComp then
    do return stageComp.GetGearObj, stageComp end
    return stageComp.GetGearObj, stageComp, gearUid
  end
end

function WorldStageManager:GetBossId()
  local stageComp = self:GetCurStageComp()
  return stageComp and stageComp:GetBossId()
end

function WorldStageManager:GetWorldStageUid()
  local stageComp = self:GetCurStageComp()
  return stageComp and stageComp:GetWorldStageUid()
end

function WorldStageManager:ClearAllStage()
  for _, stageComp in pairs(self.stageCompList) do
    stageComp:OnDestroy()
    stageComp:DestroyMap()
  end
  table.clear(self.stageCompList)
end

function WorldStageManager:OnDestroy()
  Super.OnDestroy(self)
  self.binder:teardown()
  if not Main.isAppDestroyed then
    local Pool = require("Utility.Pool")
    Pool.Clear()
  end
end

function WorldStageManager:GetEffectDescList(_)
  return {}
end

function WorldStageManager:IsBlockingMap()
  local stageComp = self:GetCurStageComp()
  if not stageComp then
    return false
  end
  do return stageComp.IsBlockingMap end
  return stageComp.IsBlockingMap, stageComp
end

return WorldStageManager
