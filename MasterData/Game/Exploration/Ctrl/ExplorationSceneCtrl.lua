local base = require("Game.Common.CommonGameCtrl.DungeonSceneBaseCtrl")
local ExplorationSceneCtrl = class("ExplorationSceneCtrl", base)
local CS_PlayState_Playing = CS.UnityEngine.Playables.PlayState.Playing
local CS_RenderMgr = CS.RenderManager.Instance
local cs_BattlePosData = CS.BattlePosData
local util = require("XLua.Common.xlua_util")
local Cs_coroutine = require("XLua.Common.cs_coroutine")
local HeroSkillData = require("Game.PlayerData.Skill.HeroSkillData")
local DynBattleSkill = require("Game.Exploration.Data.DynBattleSkill")
local ExplorationEnum = require("Game.Exploration.ExplorationEnum")

function ExplorationSceneCtrl:ctor(epCtrl)
  self.epCtrl = epCtrl
  table.insert(self.epCtrl.ctrls, self)
  self.resloader = CS.ResLoader.Create()
  self.__effectPool = {}
  self.__effectInUseDic = {}
  self.__onRecycleEffect = BindCallback(self, self.__RecycleEffect)
  self.__epSceneState = ExplorationEnum.eEpSceneState.None
  self.__OnEpSceneLoadRole = BindCallback(self, self.OnEpSceneLoadRole)
  MsgCenter:AddListener(eMsgEventId.OnEpSceneLoadRole, self.__OnEpSceneLoadRole)
  self.__onShowRoleHeadBar = BindCallback(self, self.ShowBattleCanvasTween)
  MsgCenter:AddListener(eMsgEventId.OnShowRoleHeadBar, self.__onShowRoleHeadBar)
  self.__onPlayerMoveComplete = BindCallback(self, self.OnPlayerMoveComplete)
  MsgCenter:AddListener(eMsgEventId.OnEpPlayerMoveComplete, self.__onPlayerMoveComplete)
  self.__onShowEpUI = BindCallback(self, self.ShowExplorationUI)
  MsgCenter:AddListener(eMsgEventId.OnShowExplorationUI, self.__onShowEpUI)
  self.__onChangeRoomSelectAudio = BindCallback(self, self.OnChangeRoomSelectAudio)
  MsgCenter:AddListener(eMsgEventId.OnChangeEpRoomSelectAudio, self.__onChangeRoomSelectAudio)
  self.__onSkipTimeline = BindCallback(self, self.OnSkipTimeline)
  self.__onStartTimelineCompleteGeneral = BindCallback(self, self.OnStartTimelineCompleteGeneral)
  self.__onEpToBattleNormalComplete = BindCallback(self, self.OnEpToBattleNormalCompleteGeneral)
  self.__onEpToBattleReconnetedComplete = BindCallback(self, self.OnExpToBatleInReconnectedComplete)
  self.__onBattleToEpComplete = BindCallback(self, self.OnBattleToEpComplete)
  self.__onSceneLoaded = BindCallback(self, self.__OnSceneEnter)
  self._onEnterEpAvgCompleteFunc = BindCallback(self, self._OnEnterEpAvgComplete)
  self.skipEpTimeline = GR.SkipEpTimeline()
end

function ExplorationSceneCtrl:GetBattleFieldSizeBySceneId()
  return self.epCtrl.mapData:GetBattleFieldSize()
end

function ExplorationSceneCtrl:ChangeEpSceneState(state)
  if state == self.__epSceneState then
    return
  end
  local lastSceneState = self.__epSceneState
  self.__epSceneState = state
  if self.__epSceneState == ExplorationEnum.eEpSceneState.InBattleScene then
    if self.epCtrl.mapCtrl ~= nil then
      self.epCtrl.mapCtrl:HideMapCavas()
    end
    CS_RenderMgr:ResetShaderLODGlobal()
    if self.epCtrl:GetCurrentRoomData():IsRealBossRoom() and ExplorationManager:GetDynPlayer():GetOperatorDetailState() ~= proto_object_ExplorationCurGridState.ExplorationCurGridState_Over then
      local moduleId = ExplorationManager:GetEpModuleId()
      if moduleId == proto_csmsg_SystemFunctionID.SystemFunctionID_Exploration then
        local stageId = ExplorationManager:GetSectorStageCfg().id
        local curFloor = ExplorationManager:GetCurLevelIndex() + 1
        ExplorationManager.epCtrl.battleCtrl:SetCanShowNewEnemyDetail(false)
        ControllerManager:GetController(ControllerTypeId.AvgPlay, true):TryPlayAvg(eAvgTriggerType.MainAvgEp, stageId, curFloor, 1, function()
          ExplorationManager.epCtrl.battleCtrl:SetCanShowNewEnemyDetail(true)
          ExplorationManager.epCtrl.battleCtrl:AutoShowNewEnemyDetail()
        end)
      end
    end
    if self.epSceneEntity ~= nil then
      self:SetEpMapCameraCullMask(LayerMask.UI3D)
    end
  elseif self.__epSceneState == ExplorationEnum.eEpSceneState.InEpScene then
    if not BattleUtil.IsInTDBattle() then
      CS_RenderMgr:SetShaderLODGlobal(300)
    end
  elseif self.__epSceneState == ExplorationEnum.eEpSceneState.InTimeline then
    CS_RenderMgr:ResetShaderLODGlobal()
  end
  if lastSceneState == ExplorationEnum.eEpSceneState.InBattleScene and self.epSceneEntity ~= nil then
    self:SetEpMapCameraCullMask(LayerMask.EpMap)
  end
  MsgCenter:Broadcast(eMsgEventId.OnEpSceneStateChanged, self.__epSceneState)
end

function ExplorationSceneCtrl:InBattleScene()
  return self.__epSceneState == ExplorationEnum.eEpSceneState.InBattleScene
end

function ExplorationSceneCtrl:FirstEnterScene(enterSceneAction, startTimelineAction)
  self.firstEnterComplelte = false
  self.loadRoleComplete = false
  self.showEpUIComplete = false
  local sceneCfg = self.epCtrl.mapData:GetEpSceneCfg()
  self.__enterSceneAction = enterSceneAction
  self.__startTimelineAction = startTimelineAction
  self.heroPrefabs = {}
  self.heroObjectDic = {}
  
  local function preLoadFunc()
    self:__InitDungeonSceneEffect()
    self:__PreLoadCharacterAndSkill(self.epCtrl.dynPlayer, self.heroPrefabs, self.heroObjectDic, true)
  end
  
  local function preLoadFunc2()
    self.epCtrl:GenExplorationMap()
  end
  
  local sectorId = self.epCtrl.mapData:GetEpSceneSectorId()
  self.epSceneEntity = EpSceneConfig[sceneCfg.id].EpSceneClass.New(sceneCfg.scene_name, self)
  self.epSceneEntity:LoadArenaSceneForce(self.__onSceneLoaded, util.cs_generator(preLoadFunc), util.cs_generator(preLoadFunc2))
end

function ExplorationSceneCtrl:__OnSceneEnter()
  if self.epCtrl:GetEpAfterEnterSceneExit() then
    ExplorationManager:ExitExploration()
    return
  end
  if self.__enterSceneAction ~= nil then
    self.__enterSceneAction()
    self.__enterSceneAction = nil
  end
  local sceneCfg = self.epCtrl.mapData:GetEpSceneCfg()
  base.CheckAndOpenSepcialMode(self, sceneCfg)
  self:__PlaySceneStartTimeline()
end

function ExplorationSceneCtrl:__PlaySceneStartTimeline()
  self.epSceneEntity:OnSceneLoadedPlay(self.__onStartTimelineCompleteGeneral)
  self:ChangeEpSceneState(ExplorationEnum.eEpSceneState.InTimeline)
  if self.skipEpTimeline then
    self.epSceneEntity:EndOnSceneLoadedTimeLine()
    if not self.loadRoleComplete then
      self:OnEpSceneLoadRole()
    end
    if not self.showEpUIComplete then
      self:ShowExplorationUI()
    end
  else
    self:ShowSkipWindow(false)
  end
end

function ExplorationSceneCtrl:OnChangeRoomSelectAudio()
  ExplorationManager:PlayEpAuSelctRoomSelect()
end

function ExplorationSceneCtrl:OnEpSceneLoadRole()
  if self.firstEnterComplelte or self.heroPrefabs == nil then
    return
  end
  self.firstEnterComplelte = true
  
  local function previewAniFunc()
    local dynPlayer = self.epCtrl.dynPlayer
    local heroRandList = {}
    for heroId, dynHero in pairs(dynPlayer.heroDic) do
      if dynHero ~= nil then
        local tmp = {
          id = dynHero.dataId,
          weight = math.random()
        }
        table.insert(heroRandList, tmp)
      end
    end
    table.sort(heroRandList, function(a, b)
      return a.weight < b.weight
    end)
    for k, v in pairs(heroRandList) do
      local heroId = v.id
      local dynHero = dynPlayer.heroDic[heroId]
      if dynHero ~= nil then
        local heroGo = self.heroObjectDic[dynHero.dataId]
        heroGo:SetActive(true)
        if not self.loadRoleComplete then
          local effect = self:GetRoleAppearEffect()
          effect:Play(heroGo.transform.position)
          coroutine.yield(CS.UnityEngine.WaitForSeconds(0.1))
        end
      end
    end
    if not self.loadRoleComplete then
      coroutine.yield(CS.UnityEngine.WaitForSeconds(1.5))
    end
    if self.loadRoleComplete then
      self:DeleteSkipWindow()
      self:_TryTriggerStartTimelineEndAction()
    else
      self.loadRoleComplete = true
    end
    self.__loadRoleCoroutine = nil
  end
  
  self.__loadRoleCoroutine = GR.StartCoroutine(util.cs_generator(previewAniFunc))
end

function ExplorationSceneCtrl:OnStartTimelineCompleteGeneral(isAbandonExpCamCtrl)
  MsgCenter:RemoveListener(eMsgEventId.OnEpSceneLoadRole, self.__OnEpSceneLoadRole)
  if not isAbandonExpCamCtrl then
    self:SwithCameraCtrlState(ExplorationEnum.eEpCamControlState.Exploration)
  end
  local moduleId = ExplorationManager:GetEpModuleId()
  if self.epCtrl:IsFirstEnterNewFloor() and moduleId == proto_csmsg_SystemFunctionID.SystemFunctionID_Exploration then
    local stageId = ExplorationManager:GetSectorStageCfg().id
    local curFloor = ExplorationManager:GetCurLevelIndex() + 1
    local avgPlayCtrl = ControllerManager:GetController(ControllerTypeId.AvgPlay, true)
    if avgPlayCtrl:TryPlayAvg(eAvgTriggerType.MainAvgEp, stageId, curFloor, 2, self._onEnterEpAvgCompleteFunc) then
      self._isPlayingEnterEpAvg = true
    end
  end
  if self.loadRoleComplete then
    self:DeleteSkipWindow()
    self:_TryTriggerStartTimelineEndAction()
  else
    self.loadRoleComplete = true
  end
end

function ExplorationSceneCtrl:_OnEnterEpAvgComplete()
  self._isPlayingEnterEpAvg = false
  if self.loadRoleComplete then
    self:_TryTriggerStartTimelineEndAction()
  end
end

function ExplorationSceneCtrl:_TryTriggerStartTimelineEndAction()
  if not self._isPlayingEnterEpAvg and self.__startTimelineAction ~= nil then
    self.__startTimelineAction()
    self.__startTimelineAction = nil
  end
end

function ExplorationSceneCtrl:ExplorationToBattleSceneNormal(dir, mapRoot, roomPosition, epToBattleAction)
  self.__epToBattleAction = epToBattleAction
  self:SceneResetBattleCamera()
  self:SwithCameraCtrlState(ExplorationEnum.eEpCamControlState.None)
  local tlIndex = self.epSceneEntity:CalculateExpToBattleNormalTL(dir)
  self.epSceneEntity:OnStartBattlePlay(self.__onEpToBattleNormalComplete)
  self:ChangeEpSceneState(ExplorationEnum.eEpSceneState.InTimeline)
  if tlIndex == 1 then
  elseif tlIndex == 2 then
  end
  if self.skipEpTimeline then
    self.epSceneEntity:EndOnStartBattleTimeLine()
  else
    self:ShowSkipWindow()
    self:TweenRoomToScreenCenter(mapRoot, roomPosition)
  end
end

function ExplorationSceneCtrl:OnEpToBattleNormalCompleteGeneral()
  self:DeleteSkipWindow()
  self:ChangeEpSceneState(ExplorationEnum.eEpSceneState.InBattleScene)
  if self.__epToBattleAction ~= nil then
    self.__epToBattleAction()
    self.__epToBattleAction = nil
  end
  if self.__resetMapPosAction ~= nil then
    self.__resetMapPosAction()
    self.__resetMapPosAction = nil
  end
  self:TryPlayFairyEnterAni(false)
end

function ExplorationSceneCtrl:ExplorationToBattleSceneInReconnected(epToBattleAction)
  self.__epToBattleAction = epToBattleAction
  self:SceneResetBattleCamera()
  self:SwithCameraCtrlState(ExplorationEnum.eEpCamControlState.None)
  self.epSceneEntity:OnReconnectToBattlePlay(self.__onEpToBattleReconnetedComplete)
  self:ChangeEpSceneState(ExplorationEnum.eEpSceneState.InTimeline)
  if self.skipEpTimeline then
    self.epSceneEntity:EndOnReconnectToBattleTimeLine()
  else
    self:ShowSkipWindow()
  end
end

function ExplorationSceneCtrl:OnExpToBatleInReconnectedComplete()
  self:DeleteSkipWindow()
  self:ChangeEpSceneState(ExplorationEnum.eEpSceneState.InBattleScene)
  if self.__epToBattleAction ~= nil then
    self.__epToBattleAction()
    self.__epToBattleAction = nil
  end
  self:TryPlayFairyEnterAni(false)
end

function ExplorationSceneCtrl:BattleToExplorationScene(battleToEpAction)
  self.showEpUIComplete = false
  self.__battleToEpAction = battleToEpAction
  self.epSceneEntity:EpRoomCoverBattleMap()
  self.epSceneEntity:OnExitBattlePlay(self.__onBattleToEpComplete)
  self.epCtrl.mapCtrl:EpMapFadeTweenBack()
  self:ChangeEpSceneState(ExplorationEnum.eEpSceneState.InTimeline)
  if self.skipEpTimeline then
    self.epSceneEntity:EndOnExitBattleTimeLine()
    if not self.showEpUIComplete then
      self:ShowExplorationUI()
    end
  else
    self:ShowSkipWindow()
  end
end

function ExplorationSceneCtrl:OnBattleToEpComplete()
  self:DeleteSkipWindow()
  self:ChangeEpSceneState(ExplorationEnum.eEpSceneState.InEpScene)
  self:SwithCameraCtrlState(ExplorationEnum.eEpCamControlState.Exploration)
  for _, heroObject in pairs(self.heroObjectDic) do
    heroObject.transform.localScale = Vector3.one
  end
  MsgCenter:Broadcast(eMsgEventId.OnExitRoomComplete, ExplorationEnum.eExitRoomCompleteType.BattleToEp)
end

function ExplorationSceneCtrl:ShowSkipWindow(clickClose)
  UIManager:ShowWindow(UIWindowTypeID.ClickContinue):InitContinue(self.__onSkipTimeline, false, nil, Color.clear, clickClose)
end

function ExplorationSceneCtrl:DeleteSkipWindow()
  UIManager:HideWindow(UIWindowTypeID.ClickContinue)
end

function ExplorationSceneCtrl:OnSkipTimeline()
  self.onLoadCompleteTL = self.epSceneEntity:GetOnSceneLoadedTL()
  local skipTime = self.onLoadCompleteTL.duration
  if self.onLoadCompleteTL.state == CS_PlayState_Playing and skipTime > self.onLoadCompleteTL.time then
    self.onLoadCompleteTL.time = skipTime
    if not self.loadRoleComplete then
      self:OnEpSceneLoadRole()
    end
    if not self.showEpUIComplete then
      self:ShowExplorationUI()
    end
  end
  self.OnExitBattleTL = self.epSceneEntity:GetOnExitBattleTL()
  skipTime = self.OnExitBattleTL.duration
  if self.OnExitBattleTL.state == CS_PlayState_Playing and skipTime > self.OnExitBattleTL.time then
    self.OnExitBattleTL.time = skipTime
    if not self.showEpUIComplete then
      self:ShowExplorationUI()
    end
  end
  self.onStartBattleTL = self.epSceneEntity:GetOnStartBattleTL()
  if self.onStartBattleTL ~= nil then
    skipTime = self.onStartBattleTL.duration
    if self.onStartBattleTL.state == CS_PlayState_Playing and skipTime > self.onStartBattleTL.time then
      self.onStartBattleTL.time = skipTime
      self:ClearEpMapTween()
    end
  end
  self.onReconnectToBattleTL = self.epSceneEntity:GetOnReconnectToBattleTL()
  skipTime = self.onReconnectToBattleTL.duration
  if self.onReconnectToBattleTL.state == CS_PlayState_Playing and skipTime > self.onReconnectToBattleTL.time then
    self.onReconnectToBattleTL.time = skipTime
    self:ClearEpMapTween()
  end
end

function ExplorationSceneCtrl:ClearEpMapTween()
  if self.epCtrl.mapCtrl ~= nil then
    self.epCtrl.mapCtrl:PauseEpMapTween()
  end
  if self.__resetMapPosAction ~= nil then
    self.__resetMapPosAction()
    self.__resetMapPosAction = nil
  end
end

function ExplorationSceneCtrl:ShowBattleCanvasTween()
  UIManager:PlayDoFade(self.epSceneEntity:GetBattleCanvasGroup(), 0, 1, 0.5)
end

function ExplorationSceneCtrl:OnPlayerMoveComplete(roomData)
  self:RefreshBattleToMapLine()
end

function ExplorationSceneCtrl:RefreshBattleToMapLine()
  if self.epSceneEntity ~= nil then
    local playerPosItem = self.epCtrl.mapCtrl:GetPlayerPosItem()
    self.epSceneEntity:GetBattleToMapLine().endPoint = playerPosItem.transform
  end
end

function ExplorationSceneCtrl:ShowExplorationUI()
  if self.showEpUIComplete then
    return
  end
  local dungeonWindow = UIManager:GetWindow(UIWindowTypeID.DungeonStateInfo)
  if dungeonWindow ~= nil then
    dungeonWindow:Show()
    dungeonWindow:OnlyShowChipList(false)
    dungeonWindow:ChipListWeakenTween(false)
    dungeonWindow:RefreshHeroListHp()
  end
  UIManager:GetWindow(UIWindowTypeID.Exploration):Show(true)
  local epChipSuitWin = UIManager:GetWindow(UIWindowTypeID.EpChipSuit)
  if epChipSuitWin ~= nil then
    epChipSuitWin:Show()
  end
  self.epCtrl.campFetterCtrl:OnEpBack2Ep()
  if self.__battleToEpAction ~= nil then
    self.__battleToEpAction()
    self.__battleToEpAction = nil
  end
  self.showEpUIComplete = true
end

function ExplorationSceneCtrl:TweenRoomToScreenCenter(mapRoot, roomPos)
  local mapRootPos = mapRoot.position
  local mapRootRot = mapRoot.rotation
  local mainCamTran = self.epSceneEntity:GetMainCam().transform
  local roomOffset = mainCamTran:InverseTransformVector(mapRootPos - roomPos)
  
  function self.__resetMapPosAction()
    mapRoot:SetParent(nil)
    mapRoot:SetPositionAndRotation(mapRootPos, mapRootRot)
  end
  
  mapRoot:SetParent(mainCamTran)
  local roomPos = mainCamTran:InverseTransformPoint(roomPos)
  local targetPos = roomOffset
  targetPos.z = mapRoot.localPosition.z
  targetPos.x = targetPos.x - 0.2
  self.epCtrl.mapCtrl:EpMapTween(targetPos, self.__resetMapPosAction)
end

function ExplorationSceneCtrl:__RecycleEffect(effectCommon)
  local efcName = effectCommon:GetEffectName()
  local poolList = self.__effectPool[efcName]
  if poolList == nil then
    error("该特效组被提前销毁，请检查:" .. efcName)
    return
  end
  self.__effectInUseDic[effectCommon] = nil
  table.insert(poolList, effectCommon)
end

function ExplorationSceneCtrl:RefreshEpSceneHeroPos(dynHeroList)
  local size_row, size_col, delowRow, gridScaleFactor = ExplorationManager:GetEpSceneBattleFieldSize()
  local battlePos = cs_BattlePosData(size_row, size_col, ConfigData.game_config.battleMap_bench_count, gridScaleFactor)
  for k, dynHero in ipairs(dynHeroList) do
    local heroGo = self.heroObjectDic[dynHero.dataId]
    if not IsNull(heroGo) then
      local logicPos
      if dynHero.onBench then
        logicPos = battlePos.benchLogicPosMap[dynHero.y]:ToVector3()
      else
        logicPos = battlePos.boardLogicPosMap:GetValue(dynHero.x, dynHero.y):ToVector3()
      end
      heroGo.transform.position = logicPos
    end
  end
end

function ExplorationSceneCtrl:OnDelete()
  CS_RenderMgr:ResetShaderLODGlobal()
  base.OnDelete(self)
  self.heroPrefabs = nil
  if self.__loadRoleCoroutine ~= nil then
    GR.StopCoroutine(self.__loadRoleCoroutine)
    self.__loadRoleCoroutine = nil
  end
  if self.resloader ~= nil then
    self.resloader:Put2Pool()
    self.resloader = nil
  end
  self:ClearEpMapTween()
  self.epSceneEntity:OnDelete()
  self.epSceneEntity = nil
  MsgCenter:RemoveListener(eMsgEventId.OnShowRoleHeadBar, self.__onShowRoleHeadBar)
  MsgCenter:RemoveListener(eMsgEventId.OnEpPlayerMoveComplete, self.__onPlayerMoveComplete)
  MsgCenter:RemoveListener(eMsgEventId.OnShowExplorationUI, self.__onShowEpUI)
  MsgCenter:RemoveListener(eMsgEventId.OnChangeEpRoomSelectAudio, self.__onChangeRoomSelectAudio)
end

function ExplorationSceneCtrl:EditorModelChangeHero(srcHeroId, tarHeroId, onFinish)
  if self.epCtrl.dynPlayer.heroDic[srcHeroId] == nil then
    return
  end
  local dynHero = self.epCtrl.dynPlayer.heroDic[srcHeroId]
  local heroCfg = ConfigData.hero_data[tarHeroId]
  local heroRankCfg = ConfigData.hero_rank[heroCfg.rank]
  if heroCfg ~= nil then
    dynHero.heroData.dataId = tarHeroId
    dynHero.heroData.heroCfg = heroCfg
    dynHero.heroData.camp = heroCfg.camp
    dynHero.heroData.career = heroCfg.career
    dynHero.heroData.rare = heroRankCfg.rare
    dynHero.heroData.fragId = heroCfg.fragment
    dynHero.heroData.resCfg = ConfigData.resource_model[heroCfg.src_id]
    dynHero.heroData.skillDic = {}
    dynHero.heroData.skillList = {}
    for k, skillId in ipairs(heroCfg.skill_list) do
      local skillData = HeroSkillData.New(skillId, dynHero.heroData)
      skillData.level = 1
      dynHero.heroData.skillDic[skillId] = skillData
      table.insert(dynHero.heroData.skillList, skillData)
    end
    dynHero.dataId = tarHeroId
    dynHero.heroCfg = heroCfg
    dynHero.resCfg = ConfigData.resource_model[heroCfg.src_id]
    dynHero.attackRange = heroCfg.range
    dynHero.intensity = heroCfg.intensity
    dynHero.hpPer = ExplorationEnum.eHeroHpPercent
    self.epCtrl.dynPlayer.heroDic[srcHeroId] = nil
    self.epCtrl.dynPlayer.heroDic[tarHeroId] = dynHero
    local heroResName = PathConsts:GetCharacterModelPathEx(dynHero:GetResModelName(), dynHero.modelSpecSign)
    local wait = self.resloader:LoadABAssetAsyncAwait(heroResName)
    local size_row, size_col, delowRow, grid_scale_factor = ExplorationManager:GetEpSceneBattleFieldSize()
    local battlePos = CS.BattlePosData(size_row, size_col, ConfigData.game_config.battleMap_bench_count, grid_scale_factor)
    Cs_coroutine.start(function()
      coroutine.yield(wait)
      local heroPrefab = wait.Result
      self.heroPrefabs[tarHeroId] = heroPrefab
      local heroGo = heroPrefab:Instantiate(self.heroModelHolder)
      local logicPos
      if dynHero.onBench then
        logicPos = battlePos.benchLogicPosMap[dynHero.y]:ToVector3()
      else
        logicPos = battlePos.boardLogicPosMap:GetValue(dynHero.x, dynHero.y):ToVector3()
      end
      heroGo.transform.position = logicPos
      self.heroObjectDic[srcHeroId] = nil
      self.heroObjectDic[tarHeroId] = heroGo
      onFinish(dynHero, heroGo)
    end)
  end
end

function ExplorationSceneCtrl:EditorModelChangeMonster(srcId, index, tarId)
  local currentRoomDta = self.epCtrl:GetCurrentRoomData()
  local monsterList = currentRoomDta.battleMap.monsterList
  local tarDynMonster
  for k, v in pairs(monsterList) do
    if v.dataId == srcId and k == index then
      tarDynMonster = v
      break
    end
  end
  if tarDynMonster ~= nil and ConfigData.monster[tarId] ~= nil then
    tarDynMonster.dataId = tarId
    tarDynMonster.monsterCfg = ConfigData.monster[tarId]
    tarDynMonster.resCfg = ConfigData.resource_model[tarDynMonster.monsterCfg.src_id]
    tarDynMonster.attackRange = tarDynMonster.monsterCfg.range
    tarDynMonster.intensity = tarDynMonster.monsterCfg.intensity
    tarDynMonster.originSkillList = {}
    for k, skillId in pairs(tarDynMonster.monsterCfg.enemy_skill) do
      local battleSkill = DynBattleSkill.New(skillId, 1, eBattleSkillLogicType.Original)
      table.insert(tarDynMonster.originSkillList, battleSkill)
    end
  end
  return tarDynMonster
end

return ExplorationSceneCtrl
