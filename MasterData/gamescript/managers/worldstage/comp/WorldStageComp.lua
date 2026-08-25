local System = require("System.System")
local Logger = require("Utility.Logger")
local DataCenter = require("Data.DataCenter")
local DT = require("System.DataTable")
local PlayerDataUtils = require("Data.PlayerDataUtils")
local CardDataUtils = require("Data.CardDataUtils")
local CopyAwakerDataUtils = require("Data.CopyAwakerDataUtils")
local Urls = require("Managers.UI.Urls")
local UIManager = require("Managers.UI.UIManager")
local ProtoManager = require("Net.ProtoManager")
local EventMgr = require("Managers.EventManager.EventMgr")
local CopiesDataUtils = require("Data.CopiesDataUtils")
local AvgStoryManager = require("Managers.AvgStory.AvgStoryManager")
local MobileFileDataManager = require("Managers.MobileFileDataManager")
local RelicDataUtils = require("Data.RelicDataUtils")
local StateDataUtils = require("Data.StateDataUtils")
local DBGTeamDataUtils = require("Data.DBGTeamDataUtils")
local CommonDefine = require("World.Enums.CommonDefine")
local LinearFsm = require("LinearFsm.LinearFsm")
local TimerManager = require("Managers.TimerManager")
local WorldStageSyncCardComp = require("Managers.WorldStage.Comp.Item.WorldStageSyncCardComp")
local WorldStageNetMsgComp = require("Managers.WorldStage.Comp.Item.WorldStageNetMsgComp")
local SdkMgr = require("Managers.Sdk.SdkMgr")
local WorldStageComp = System.NewClass("WorldStageComp")

function WorldStageComp:ctor(stageData, recoverData)
  Logger.Info("[Map] WorldStageComp.ctor", self)
  self.stageData = stageData
  self.stageCfg = DT.Stage[self.stageData.stageId]
  self.recoverData = recoverData
  self.isGiveUp = false
  self.stageFsm = LinearFsm(self)
  self.isHaveWorldData = false
end

function WorldStageComp:OnBind(binder)
  self.binder = binder
  StateDataUtils.Reset()
  binder:BindEvent(EventMgr.Instance.OnWorldExit, System.fn(self, self.OnWorldExit))
  binder:BindResponse(self, "World", "OnChaosRelic", System.fn(self, self.OnChaosRelic))
  binder:BindEvent(EventMgr.Instance.OnStoryEnd, System.fn(self, self.OnStoryEnd))
  self.cardSyncComp = binder:BindComponent(WorldStageSyncCardComp(self))
  self.cmdDataComp = binder:BindComponent(WorldStageCmdDataComp(self))
  self.timeoutComp = binder:BindComponent(WorldStageTimeoutComp(self))
  self.netMsgComp = binder:BindComponent(WorldStageNetMsgComp(self))
  self:OnBindFsm(binder)
  DBGTeamDataUtils.SetSpecialKeeperSkill(nil)
  binder:onDestroy(System.fn(self, self.OnUnbind))
end

function WorldStageComp:OnUnbind()
end

function WorldStageComp:_CheckRecoverStage()
  local function cancelFunc()
    local stageId = WorldRecoveryManager.Instance:GetWorldTid()
    
    local stageGroupId = DT.Stage[stageId].BelongGroup
    local stageGroupType = DT.StageGroup[stageGroupId].Type
    
    local function stageFunc()
      WorldStageComp.isSkipRecoverWorldStage = true
      self.stageFsm:AddState(require("Managers.WorldStage.Comp.StageFsm.StageFsmPrepareTeam")(self))
      self.stageFsm:AddState(require("Managers.WorldStage.Comp.StageFsm.StageFsmReqEnter")(self))
      self.stageFsm:AddState(require("Managers.WorldStage.Comp.StageFsm.StageFsmExitCopy")(self))
      self.stageFsm:StartUpdateTimer()
    end
    
    if stageGroupType == CommonDefine.StageGroupType.RailWay then
      self:ReqSaveAndExit(stageId, stageFunc)
    else
      ProtoManager.Instance:ReqServer("StageRequest", "OnExit", stageFunc, nil, stageId)
    end
  end
  
  local function confirmFunc()
    if WorldRecoveryManager.Instance:IsStageExpiredByServer() or WorldRecoveryManager.Instance:IsWaitingAbyssResetConfirm() then
      local stageGroupId = self.stageData and self.stageData.groupId
      Logger.Info("[WorldStageComp] 100020 confirm blocked by abyss reset, stageGroupId=%s", tostring(stageGroupId))
      if stageGroupId then
        WorldRecoveryManager.Instance:ShowAbyssResetTipsByStageGroupId(stageGroupId)
      else
        SceneMgr.Instance:EnterTown()
      end
      return
    end
    self:_StartWorldStageFsm()
  end
  
  if WorldStageComp._isGmEnter then
    confirmFunc()
    return
  end
  if WorldRecoveryManager.Instance:IsWaitingAbyssResetConfirm() then
    Logger.Info("[WorldStageComp] _CheckRecoverStage: abyss reset in progress, skip battle reconnect alert")
    return
  end
  if self.recoverData and WorldRecoveryManager.Instance:IsStageExpiredByServer() then
    local stageGroupId = self.stageData and self.stageData.groupId
    Logger.Info("[WorldStageComp] _CheckRecoverStage: abyss stage expired by server, skip battle reconnect alert, stageGroupId=%s", tostring(stageGroupId))
    WorldRecoveryManager.Instance:ShowAbyssResetTipsByStageGroupId(stageGroupId)
    return
  end
  local alertKey = 100020
  if self.stageData and self.stageCfg and DT.StageGroup[self.stageCfg.BelongGroup] and DT.StageGroup[self.stageCfg.BelongGroup].Type == CommonDefine.StageGroupType.RailWay then
    local createTime = self.recoverData and self.recoverData.createTime
    if RailWayDataUtils.IsSeasonSwitchedByTime(createTime) then
      alertKey = "RailWayContinueReconnectSeasonSwitchTips"
    end
  end
  Alert.Show(alertKey, cancelFunc, confirmFunc)
end

function WorldStageComp:OnBindFsm(binder)
  self.stageFsm:OnBind(binder)
  WorldStageComp.isSkipRecoverWorldStage = false
  local isRecovering = WorldRecoveryManager.Instance:IsRecovery()
  if not IntroductionDataUtils.IsFinish() or not isRecovering then
    self:_StartWorldStageFsm()
    return
  else
    self:_CheckRecoverStage()
  end
end

function WorldStageComp:_StartWorldStageFsm()
  self.stageFsm:AddState(require("Managers.WorldStage.Comp.StageFsm.StageFsmPrepareTeam")(self))
  self.stageFsm:AddState(require("Managers.WorldStage.Comp.StageFsm.StageFsmReqEnter")(self))
  self.stageFsm:AddState(require("Managers.WorldStage.Comp.StageFsm.StageFsmBeforeStory")(self))
  if not self:IsStoryStage() then
    self.stageFsm:AddState(require("Managers.WorldStage.Comp.StageFsm.StageFsmBeforeBattle")(self))
    self.stageFsm:AddState(require("Managers.WorldStage.Comp.StageFsm.StageFsmInCopy")(self))
  else
    AvgStoryManager.Instance:ClearSkipPlot()
  end
  self.stageFsm:AddState(require("Managers.WorldStage.Comp.StageFsm.StageFsmExitCopy")(self))
  self.stageFsm:StartUpdateTimer()
end

function WorldStageComp:Awake()
  self:CacheProtoData()
end

function WorldStageComp:CacheProtoData()
end

function WorldStageComp:ClearCacheProto()
end

function WorldStageComp:EnterWorldStage(callback)
  self._reqedEnterStage = true
  EventMgr.Instance.OpenReqMask:Dispatch()
  UIManager.Instance:Show(Urls.UIMaskPanel)
  
  local function successCallFunc(copyData)
    self.realId = copyData.copiesTid
    EventMgr.Instance.EnterDupSuccess:Dispatch()
    self:HandleEnterWorldData(copyData)
    if callback then
      callback()
    end
  end
  
  local function failCallFunc(data, errcode)
    StageExitPanelManager.Instance:Clear()
    if (SceneMgr.Instance:IsInTown() or SceneMgr.Instance:IsNullScene()) and not UIManager.Instance:GetWindow(Urls.MainPanel) then
      UIManager.Instance:Reopen(Urls.MainPanel)
    end
    if errcode and errcode.code then
      Logger.ReportApusInfo("进入副本失败errcode:{errcode}", errcode.code)
      if errcode.code == 10055 then
        ErrorMsg.ShowErrCodeTips(errcode, data, nil, function()
          RpcMgr.Instance:Disconnect()
          SceneMgr.Instance:EnterLogin()
        end)
      else
        ErrorMsg.ShowErrCodeTips(errcode)
      end
    end
  end
  
  local stageCfg = self.stageCfg
  local stageId = stageCfg.ID
  local diff = DailyChallengeModel.Instance:GetDifficulty(stageId) or 0
  local isExtra = AbyssExtChallengeModel.Instance:IsExtraChallenge(stageId)
  local extraParam = {
    difficultyId = diff > 0 and diff,
    isExtra = isExtra
  }
  WorldStageManager.Instance:EnterStage(stageCfg.BelongGroup)
  if self:IsAwakerTrialStage() or self:IsBattleTeachingStage() then
    ProtoManager.Instance:ReqServer("StageRequest", "EnterSpecialStage", successCallFunc, failCallFunc, stageId, {}, 0, 0)
    return
  end
  if self:IsChooseSecondMode() then
    ProtoManager.Instance:ReqServer("StageRequest", "EnterStageSecondMode", successCallFunc, failCallFunc, stageId, self.teamIdx or 1, self.assistAwakerTid, self.playerUid)
    return
  end
  local specTeamAssignId = stageCfg.SpecialTeamIndex
  local tTeamAssignCfg = DT.SpecialTeamAssign[specTeamAssignId]
  if nil == tTeamAssignCfg then
    ProtoManager.Instance:ReqServer("StageRequest", "Enter", successCallFunc, failCallFunc, stageId, self.teamIdx or 1, self.assistAwakerTid, self.playerUid, extraParam)
  else
    ProtoManager.Instance:ReqServer("StageRequest", "EnterSpecialStage", successCallFunc, failCallFunc, stageId, self.tAwakerTids, DBGTeamDataUtils.GetSpecialKeeperSkill(), self.teamIdx or 1)
  end
end

function WorldStageComp:OnChaosRelic(data)
  self.stageData.choasRelics = data
end

function WorldStageComp:HandleEnterWorldData(copyData)
  self.isHaveWorldData = true
  if self.stageEnterData then
    return
  end
  for _, card in ipairs(copyData.cards or {}) do
    CardDataUtils.ClearCardDisplayInfo(card.uid)
  end
  self.stageEnterData = copyData
  self:ProcessCopyData(copyData)
  self.cmdDataComp:Init(copyData.cmdData)
  if copyData.createTime then
    self.timeoutComp:CalTimeout(self.stageCfg.BelongGroup, copyData.createTime)
    if DT.StageGroup[self.stageCfg.BelongGroup].Type == CommonDefine.StageGroupType.RailWay then
      RailWayModel.Instance:SetCurCreateTime(copyData.createTime)
    end
  end
  StageExitPanelManager.Instance:SetEnabled()
  local groupType = self:GetGroupType()
  local StageGroupType = CommonDefine.StageGroupType
  if groupType == StageGroupType.Prologue and not self:IsRecover() then
    StageExitPanelManager.Instance:PushWhenMainCopyExit(self.stageData.stageId)
  end
  if not WorldStageComp.isSkipRecoverWorldStage then
    self:ReqResonanceInfo()
  end
  local logReason = self.recoverData and "Recover" or "Enter"
  self:StartStageLog(self.stageData.stageId, copyData.wid, logReason)
end

function WorldStageComp:StartStageLog(stageId, wid, logReason)
  WorldStageManager.Instance:StartStageLog(stageId, wid, logReason)
end

function WorldStageComp:ReqResonanceInfo()
  local resonanceGroupId
  local groupInfo = DT.StageGroup[self.stageData.groupId]
  if groupInfo and groupInfo.BattleBuff then
    resonanceGroupId = groupInfo.BattleBuff[2]
    if resonanceGroupId then
      ResonanceDataUtils.ReqResonanceData(resonanceGroupId)
    end
  end
end

function WorldStageComp:ProcessCopyData(copyData)
  for key, data in pairs(copyData) do
    self.stageData[key] = data
  end
  self.stageData.tasks = copyData.stageData and copyData.stageData.task or {}
  WorldstageDMoneyDataUtils.SetGold(copyData.currencyData.value)
  if copyData.role then
    local attrs = {
      hp = copyData.role.hp,
      max_hp = copyData.role.max_hp,
      occupation_master = copyData.role.occupation_master,
      occupation_master_final_per = copyData.role.occupation_master_final_per,
      blackcoin_upgrade_per = copyData.role.blackcoin_upgrade_per,
      basic_damage_per = copyData.role.basic_damage_per,
      blackcoin_upgrade_plus = copyData.role.blackcoin_upgrade_plus,
      death_resist = copyData.role.death_resist,
      death_resist_times = copyData.role.death_resist_times,
      death_resist_coefficient_plus = copyData.role.death_resist_coefficient_plus
    }
    for k, v in pairs(copyData.role.attrs or {}) do
      attrs[k] = v
    end
    PlayerDataUtils.SyncPlayerAttr(attrs)
    for slotIndex, awakerInfo in pairs(copyData.role.awakerInfos) do
      CopyAwakerDataUtils.UpdateBattleAwakerData(awakerInfo)
    end
  end
  if copyData.assistData then
    CopyAwakerDataUtils.UpdateAssistData(copyData.assistData)
  end
  CardDataUtils.RemoveAllCard()
  for _, value in ipairs(copyData.cards) do
    CardDataUtils.AddCard(value)
  end
  RelicDataUtils.ClearRelics()
  local WorldStageManager = require("Managers.WorldStage.WorldStageManager")
  local stageData = WorldStageManager.Instance:GetCurStageData()
  if copyData.role then
    local keeperDescArgs = copyData.role.keeperSkillDescArgs or copyData.role.keeperArgs or copyData.role.keeperSkillArgs
    if keeperDescArgs then
      WorldStageManager.Instance:UpdateKeeperArgs(keeperDescArgs)
    end
  end
  if copyData.relic then
    for _, value in ipairs(copyData.relic) do
      if value.tid == DT.GetConstant("RelicKey") then
        if not stageData.specialItemBag then
          stageData.specialItemBag = {}
        end
        table.insert(stageData.specialItemBag, {
          tid = value.tid,
          uid = value.uid
        })
      else
        RelicDataUtils.AddRelic(value)
      end
    end
  end
  if copyData.stageData and copyData.stageData.achivement then
    stageData.achivement = table.deepclone(copyData.stageData.achivement)
  end
  if self.stageData.gears then
    table.sort(self.stageData.gears, function(a, b)
      return a.x < b.x
    end)
  end
end

function WorldStageComp:PreloadBattle()
end

function WorldStageComp:OnEventBattleLose(_)
end

function WorldStageComp:IsReqedEnterStage()
  return self._reqedEnterStage
end

function WorldStageComp:OnStoryEnd()
  if self:GetIsInMap() then
    self.map:PlayBGM()
  end
  if UIManager.Instance:GetWindow(Urls.DBGMainCopyOutPanel) then
    UIAudioManager.Instance:SetMainSceneMusicState(true)
  end
end

function WorldStageComp:OnWorldExit(data)
  self.stageExitData = data
  WorldStageManager.Instance:StopStageLog()
  PlayerDataUtils.ResetPlayerAttr()
  StateDataUtils.Reset()
  ShopDataUtils.ResetAll()
end

function WorldStageComp:EnterMap()
  Logger.Info("[Map] EnterMap", debug.traceback())
  local WorldStageManager = require("Managers.WorldStage.WorldStageManager")
  self.isInMap = true
  EventMgr.Instance.GameEvent:Dispatch(CommonDefine.GameEvent.EnterCopy)
  self:ClearCacheProto()
  if self.map then
    self.map:Show()
    WorldStageManager.Instance.OpenWorldstageMainPanel(self.stageData.groupId, self.stageData.stageId)
    self:BlockMap(1.5)
  else
    local stageId = self.realId or self.stageData.stageId
    local stageCfg = DT.Stage[stageId]
    local boxId = MainCopyDataUtils.GetDymicDifficultyId(stageId) or stageId
    local dynamicDiffCfg = MainCopyDataUtils.GetStageConfig(boxId)
    local mapCfg = self:GetMapCfgWithDynamicDiff(stageCfg, dynamicDiffCfg)
    local mat = dynamicDiffCfg.Material or stageCfg.Material
    if mat then
      self:SetChapterIndexAudioEvent()
      if self.map then
        self.map:Destroy()
      end
      self.map = self:CreateMapEntity(self.stageData, mapCfg)
      local scenePath = string.format("Assets/ArtRes/%s", stageCfg.Scene)
      self.map:EnterMap(scenePath)
    end
  end
end

function WorldStageComp:GetMapCfgWithDynamicDiff(stageCfg, dynamicDiffCfg)
  if not dynamicDiffCfg then
    return stageCfg
  end
  local mapCfg = {}
  mapCfg.Atmos = stageCfg.Atmos or dynamicDiffCfg.Atmos
  mapCfg.ID = stageCfg.ID or dynamicDiffCfg.ID
  mapCfg.DefaultMusic = stageCfg.DefaultMusic or dynamicDiffCfg.DefaultMusic
  mapCfg.SceneEnterMat = stageCfg.SceneEnterMat or dynamicDiffCfg.SceneEnterMat
  return mapCfg
end

function WorldStageComp:IsOneLineMap()
  return self.stageCfg.MapType == cd.StageMapType.OneLine or self.stageCfg.MapType == cd.StageMapType.Railway
end

function WorldStageComp:CreateMapEntity(stageData, cfg)
  if self:IsOneLineMap() then
    do return OneLineMapEntity, stageData, cfg end
    return OneLineMapEntity, stageData, cfg, self
  else
    do return MapEntity, stageData, cfg end
    return MapEntity, stageData, cfg, self
  end
end

function WorldStageComp:BlockMap(blockTime)
  self._lastBlockTime = CS.UnityEngine.Time.time + blockTime
end

function WorldStageComp:IsBlockingMap()
  if not self._lastBlockTime then
    return false
  end
  return CS.UnityEngine.Time.time < self._lastBlockTime
end

function WorldStageComp:GetCurStageId()
  return self.stageData.stageId
end

function WorldStageComp:SetChapterIndexAudioEvent()
end

function WorldStageComp:HideMap()
  Logger.Info("[Map] HideMap")
  self.isInMap = false
  if self.map then
    self.map:Hide()
  end
  UIManager.Instance:CloseByUrl(Urls.WorldStageMainPanel)
  EventMgr.Instance.GameEvent:Dispatch(CommonDefine.GameEvent.ExitCopy)
end

function WorldStageComp:GetIsInMap()
  return self.isInMap
end

function WorldStageComp:DestroyMap()
  Logger.Info("[Map] DestroyMap")
  self.isInMap = false
  if self.map then
    self.map:LeaveMap()
    self.map = nil
  end
end

function WorldStageComp:PlayStory(storyData)
  UIManager.Instance:CloseByUrl(Urls.PopMsgPanel)
  AvgStoryManager.Instance:StartStoryById(storyData, nil)
end

function WorldStageComp:ReqExit(tid, callFunc)
  EventMgr.Instance.OpenReqMask:Dispatch()
  EventMgr.Instance.WorldReadyExit:Dispatch()
  ProtoManager.Instance:ReqServer("StageRequest", "OnExit", function()
    self.isGiveUp = true
    if callFunc then
      callFunc()
    end
    self.stageFsm:GotoState(require("Managers.WorldStage.Comp.StageFsm.StageFsmExitCopy"))
  end, function()
    EventMgr.Instance.WorldExitFailed:Dispatch()
  end, tid)
end

function WorldStageComp:ReqSaveAndExit(tid, callFunc)
  EventMgr.Instance.OpenReqMask:Dispatch()
  EventMgr.Instance.WorldReadyExit:Dispatch()
  ProtoManager.Instance:ReqServer("StageRequest", "OnSaveAndExit", function(data)
    print("===WorldStageComp:ReqSaveAndExit success!!===", table.tostring(data or {}))
    self.isGiveUp = true
    self.isSaveAndExit = true
    if self.stageFsm:GetState(require("Managers.WorldStage.Comp.StageFsm.StageFsmExitCopy")) then
      self.stageFsm:GotoState(require("Managers.WorldStage.Comp.StageFsm.StageFsmExitCopy"))
    end
    if callFunc then
      callFunc()
    end
  end, function(data, errcode)
    print("===WorldStageComp:ReqSaveAndExit fail!!!===", errcode, table.tostring(data or {}))
    EventMgr.Instance.WorldExitFailed:Dispatch()
  end, tid)
end

function WorldStageComp:ClearBattleAwakerData()
  DataCenter.copiesData.battleAwakerMap = {}
  DataCenter.copiesData.ItemDataMap = {}
  DataCenter.copiesData.AssistAwakerTid = 0
  DataCenter.copiesData.AssistPlayerUid = 0
end

function WorldStageComp:ShowCopySettlePanel(endFunc)
  CopiesDataUtils.ShowSettlement(endFunc, DT.StageGroup[self.stageData.groupId].Type)
end

function WorldStageComp:ShowSceneEffect(isShow)
  if self.map and self.map.sceneEffect and self.map.sceneEffect.gameObject then
    self.map.sceneEffect.gameObject:SetActive(isShow)
  end
end

function WorldStageComp:GetRoundInfo()
  local curBattleIndex, totalBattleIndex = 0, 0
  local countedGearMap = {}
  for _, gearList in ipairs({
    self.stageData.finishGears,
    self.stageData.gears
  }) do
    for _, gear in ipairs(gearList or {}) do
      local gearKey = gear.uid or string.format("%s_%s_%s", tostring(gear.tid), tostring(gear.x), tostring(gear.y))
      if countedGearMap[gearKey] then
      else
        countedGearMap[gearKey] = true
        local tid = gear.tid
        local nodeCfg = DT.MapNode[tid]
        local nodeEffectId = nodeCfg and nodeCfg.Effect and nodeCfg.Effect[1] or -1
        local battleCfg = DT.BattleConfig[nodeEffectId]
        if battleCfg then
          totalBattleIndex = totalBattleIndex + 1
          if gear.state ~= cd.GearState.Pending then
            curBattleIndex = curBattleIndex + 1
          end
        end
      end
    end
  end
  return curBattleIndex, totalBattleIndex
end

function WorldStageComp:GetWorldStageUid()
  if not self.stageEnterData then
    return
  end
  return self.stageEnterData.wid
end

function WorldStageComp:GetBossId()
  if not self.stageEnterData or not self.stageEnterData.gears then
    return
  end
  local gears = self.stageEnterData.gears
  for _, gearData in ipairs(gears) do
    local nodeCfg = DT.MapNode[gearData.tid]
    if nodeCfg and nodeCfg.NodeType == CommonDefine.GearType.Boss then
      local battleCfgId = nodeCfg.Effect and nodeCfg.Effect[1] or 0
      local battleCfg = DT.BattleConfig[battleCfgId]
      for i = 1, 5 do
        local monsterId = battleCfg["Monster" .. i] or 0
        local monsterCfg = DT.MonsterConfig[monsterId] or {}
        if "Boss" == monsterCfg.MonsterClass then
          return monsterId
        end
      end
    end
  end
end

function WorldStageComp:ExitCopy()
  local WorldStageManager = require("Managers.WorldStage.WorldStageManager")
  WorldStageManager.Instance:FinishStage(self.stageData.groupId)
  PlayerDataUtils.ClearPostion()
  TimerManager.Instance:CreateTimer(1, 0, nil, function()
    UIManager.Instance:CloseByUrl(Urls.DBGMainCopyOutPanel)
  end)
  self:ClearBattleAwakerData()
end

function WorldStageComp:IsStoryStage()
  return self.stageCfg.Map == nil and nil ~= self.stageCfg.StartStory
end

function WorldStageComp:IsOneBattleStage()
  do return CopyDataUtils.IsOneBattleStage end
  return CopyDataUtils.IsOneBattleStage, self.stageData and self.stageData.stageId
end

function WorldStageComp:IsAwakerTrialStage()
  local belongGroup = self.stageCfg.BelongGroup
  local groupInfo = DT.StageGroup[belongGroup]
  if groupInfo.Type == CommonDefine.StageGroupType.Vindicate then
    return false
  end
  local awakerTid = FreeTrialController.Instance:GetAwakerByStageId(self.stageData.stageId)
  return awakerTid and awakerTid > 0
end

function WorldStageComp:IsBattleTeachingStage()
  local belongGroup = self.stageCfg.BelongGroup
  local stageGroupCfg = DT.StageGroup[belongGroup]
  return stageGroupCfg.Type == CommonDefine.StageGroupType.BattleTeaching
end

function WorldStageComp:IsChooseSecondMode()
  return self.stageData.specialMode and self.stageData.specialMode == CommonDefine.StageSpecialMode.SecondMode
end

function WorldStageComp:ShowTeamPanel()
end

function WorldStageComp:SetTeamInfo(teamIdx, tAwakerTids, assistAwakerTid, playerUid, awakerEquipData)
  self.teamIdx = teamIdx
  self.tAwakerTids = tAwakerTids
  self.assistAwakerTid = assistAwakerTid
  self.playerUid = playerUid
  self.awakerEquipData = awakerEquipData
end

function WorldStageComp:OnDestroy()
  if not self.binder then
    return
  end
  Logger.Warn("[Map] WorldStageComp.OnDestroy")
  local WorldRecoveryManager = require("Managers.WorldStage.WorldRecoveryManager")
  if WorldRecoveryManager.Instance then
    WorldRecoveryManager.Instance:ClearRecoverData(true)
  end
  MapOneLineManager.BeforeEnterUid = nil
  self:DestroyMap()
  self.stageFsm:OnDestroy()
  self.stageFsm = nil
  self.stageEnterData = nil
  self.stageExitData = nil
  self.binder:teardown()
  self.binder = nil
end

function WorldStageComp:PopRatingTips()
  local settleData = DataCenter.copiesData.copiesSettleData
  if not settleData then
    return
  end
  local isSuccess = settleData.isFinish or false
  local stageId = settleData.worldTid or 0
  local savedKey = CommonDefine.LocalSaveKey.FirstCompleteStage .. stageId
  if isSuccess and table.contains(DT.GetOriginalConstant("EvaluationTiming"), stageId) then
    local isFirstCompleteStage = MobileFileDataManager.Instance:GetPlayerFileValue(savedKey, 0)
    if 0 == isFirstCompleteStage then
      MobileFileDataManager.Instance:SetPlayerFileValue(savedKey, 1)
      MobileFileDataManager.Instance:OnSavePlayerFileInfo()
      if not SdkMgr.Instance:CheckIsGWPackage() and not SteamSdk.Instance:IsSteam() then
        UIManager.Instance:Reopen(Urls.CommunityRatingTips)
      end
    end
  end
end

function WorldStageComp:GetRecommandScore()
  local score = self.stageCfg.RecScore
  return score
end

function WorldStageComp:SetCurTriggeredGearType(gearType)
  self._curTriggeredGearType = gearType
end

function WorldStageComp:GetCurTriggeredGearType()
  return self._curTriggeredGearType
end

function WorldStageComp:GetCurTriggerGearData()
  local gearMgr = self.map and self.map.gearMgr
  if gearMgr then
    local triggerObj = gearMgr:GetTriggerObj()
    return triggerObj and triggerObj.userData
  end
  if self:IsOneLineMap() then
    local mapOneLineManager = self.map and self.map:GetComponent(MapOneLineManager)
    if mapOneLineManager then
      do return mapOneLineManager.GetCurrentTriggeringGearData end
      return mapOneLineManager.GetCurrentTriggeringGearData, mapOneLineManager
    end
  end
end

function WorldStageComp:GetGearObj(gearUid)
  local gearMgr = self.map and self.map.gearMgr
  return gearMgr and gearMgr:GetGearByUid(gearUid)
end

function WorldStageComp:GetGroupType()
  return DT.StageGroup[self.stageData.groupId].Type
end

function WorldStageComp:IsRecover()
  return self.recoverData ~= nil
end

function WorldStageComp:GetRecoverData()
  return self.recoverData
end

function WorldStageComp:GetStageEnterData()
  return self.stageEnterData
end

function WorldStageComp:GetStageTriggerData()
  if self.stageEnterData then
    return self.stageEnterData.gearTriggerData
  end
end

function WorldStageComp:ClearStageTriggerData()
  self.stageEnterData.gearTriggerData = nil
end

function WorldStageComp:GetStageExitData()
  return self.stageExitData
end

function WorldStageComp:GetStartStoryId()
  return self.stageCfg.StartStory
end

function WorldStageComp:GetEndStoryId()
  return self.stageCfg.EndStory
end

function WorldStageComp:GetPreTriggerGearData()
  return self.stageData.preTriggerGearData
end

function WorldStageComp:GetIsGiveUp()
  return self.isGiveUp
end

function WorldStageComp:GetTeamIdx()
  return self.teamIdx or 1
end

function WorldStageComp:GetTeamAwakerTids()
  return self.tAwakerTids
end

function WorldStageComp:HasShadowEffect()
  return self.stageData.shadow
end

function WorldStageComp:SetShadowEffect()
  self.stageData.shadow = true
end

return WorldStageComp
