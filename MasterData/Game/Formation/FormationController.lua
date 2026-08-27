local FormationController = class("FormationController", ControllerBase)
local base = ControllerBase
local CS_Input = CS.UnityEngine.Input
local CS_ResLoader = CS.ResLoader
local CS_Camera = CS.UnityEngine.Camera
local CS_GameObject = CS.UnityEngine.GameObject
local CS_MessageCommon = CS.MessageCommon
local CS_Shader = CS.UnityEngine.Shader
local FmtEnum = require("Game.Formation.FmtEnum")
local ExplorationEnum = require("Game.Exploration.ExplorationEnum")
local CheckerTypeId, CheckerGlobalConfig = table.unpack(require("Game.Common.CheckCondition.CheckerGlobalConfig"))
local EnterFmtData = require("Game.Formation.Data.EnterFmtData")
local util = require("XLua.Common.xlua_util")
local FormationUtil = require("Game.Formation.FormationUtil")
local TaskCheckUtil = require("Game.Task.TaskCheckUtil")
local FormationSceneCtrl = require("Game.Formation.Ctrl.FormationSceneCtrl")
local WCEnum = require("Game.WeeklyChallenge.WCEnum")
local CSTData = require("Game.CommanderSkill.CSTData")
local CSTUtil = require("Game.CommanderSkill.CSTUtil")
local FairyHelper = require("Game.Fairy.FairyHelper")

function FormationController:OnInit()
  self.ctrls = {}
  self.fmtSceneCtrl = FormationSceneCtrl.New(self)
  self.heroNetwork = NetworkManager:GetNetwork(NetworkTypeID.Hero)
  self.resloader = CS_ResLoader.Create()
  self._GlobalCharColorHash = CS_Shader.PropertyToID("_GlobalCharColor")
  self:ResetFmtCtrlState()
  self.__TryFixFormatoionCST = BindCallback(self, self.TryFixFormatoionCST)
  self._TryUpdateSupporeDatas = BindCallback(self, self.TryUpdateSupporeDatas)
  self.__UpdateHeroForFmtInfo = BindCallback(self, self._OnUpdateHero)
  self.__FormationHeroChangeFunc = BindCallback(self, self.__FormationHeroChange)
  self.__OnCommendSkillChange = BindCallback(self, self.OnCommendSkillChange)
  self.__OnFmtHeroSkinChange = BindCallback(self, self._OnFmtHeroSkinChange)
  self.__onFmtFairyDataChange = BindCallback(self, self.__OnFmtFairyDataChange)
  MsgCenter:AddListener(eMsgEventId.PreCondition, self.__TryFixFormatoionCST)
  MsgCenter:AddListener(eMsgEventId.OnSupportHoreNeedFresh, self._TryUpdateSupporeDatas)
  MsgCenter:AddListener(eMsgEventId.UpdateHero, self.__UpdateHeroForFmtInfo)
  MsgCenter:AddListener(eMsgEventId.OnHeroAthChange, self.__FormationHeroChangeFunc)
  MsgCenter:AddListener(eMsgEventId.HeroTalentLvUp, self.__FormationHeroChangeFunc)
  MsgCenter:AddListener(eMsgEventId.OnCommanderSkillChande, self.__OnCommendSkillChange)
  MsgCenter:AddListener(eMsgEventId.OnHeroSkinChange, self.__OnFmtHeroSkinChange)
  MsgCenter:AddListener(eMsgEventId.OnFmtFairyChange, self.__onFmtFairyDataChange)
  MsgCenter:AddListener(eMsgEventId.HeroSkinLimitTimeOut, self.__OnFmtHeroSkinChange)
end

function FormationController:ResetFmtCtrlState()
  self.__fmtCtrlState = FmtEnum.FmtCtrlSate.none
  self.__enterFmtData = nil
  self.__realFmtData = nil
  self.__fmtData = nil
  self.__fmtUI2D = nil
  self._fmtCommanderskillChange = false
  self._fmtIsChange = false
  self._heroChangedIdDic = {}
  self.__fmtCSTData4vt = nil
  self.__fmtCSTDataDic = nil
end

function FormationController:GetNewEnterFmtData()
  self.__fmtCtrlState = FmtEnum.FmtCtrlSate.parpare
  self.__enterFmtData = EnterFmtData.New()
  return self.__enterFmtData
end

function FormationController:GetCurEnterFmtData()
  return self.__enterFmtData
end

function FormationController:EnterFormationScene()
  UIUtil.AddOneCover("loadMainFmt", SafePack(nil, nil, nil, Color.black, false))
  UIManager:DeleteWindow(UIWindowTypeID.Home)
  CS.GSceneManager.Instance:LoadSceneByAB(Consts.SceneName.Empty4AB, function()
    local leanTouchGo = CS.UnityEngine.GameObject("LeanTouchGo")
    leanTouchGo:AddComponent(typeof(CS.Lean.Touch.LeanTouch))
    self:ResetFmtCtrlState()
    self:GetNewEnterFmtData():SetFmtCtrlBaseInfo(FmtEnum.eFmtFromModule.MianFmt, nil, 1):SetFmtCtrlCallback(function()
    end, function()
      CS.GSceneManager.Instance:LoadSceneByAB(Consts.SceneName.Main, function()
        ControllerManager:GetController(ControllerTypeId.HomeController, true):OnEnterHome()
        UIManager:CreateWindowAsync(UIWindowTypeID.Home, function(window)
          if window == nil then
            return
          end
          window:SetFrom2Home(AreaConst.Exploration, true)
        end)
      end)
    end, nil):SetFmtForbidSupport(true):SetIsHideRecommandPow(true)
    self:EnterFormation()
    UIUtil.CloseOneCover("loadMainFmt")
  end)
end

function FormationController:EnterFormation()
  if self.__fmtCtrlState ~= FmtEnum.FmtCtrlSate.parpare then
    error("fmtCtrl state error: not parpare state when enter fromation")
    return
  end
  self.__fmtCtrlState = FmtEnum.FmtCtrlSate.normal
  self.__enterFmtData:GenFmtCtrlData()
  self:GenFormationData()
  self:__RegularSupportHeroData(self.__realFmtData)
  self.__fmtData = self.__realFmtData:DeepCopyFmtData()
  self:_RegularHeroNumLimit()
  self.__mainCam = CS_Camera.main
  self.__lightMain = CS_GameObject.FindWithTag(TagConsts.MainLight)
  self.__initCoroutine = GR.StartCoroutine(util.cs_generator(BindCallback(self, self.__LoadFormationScene)))
end

function FormationController:GenFormationData()
  local isFixedFmt = self.__enterFmtData:IsFmtCtrlFiexd()
  if isFixedFmt then
    local fmtId = self.__enterFmtData:GetFmtCtrlFmtId()
    self.__realFmtData = PlayerDataCenter.formationDic[fmtId]
    return
  end
  local isVirtual = self.__enterFmtData:IsFmtCtrlVirtualFmtData()
  local isBrotato = self.__enterFmtData:IsFmtInBrotatoDeploy()
  if isVirtual and not isBrotato then
    local virtualFmtData = self.__enterFmtData:GetFmtCtrlVirtualFmtData()
    self.__realFmtData = virtualFmtData.formation
    return
  end
  local isInfinity = self.__enterFmtData:GetIsEpInifinity()
  if isInfinity then
    self.__realFmtData = self.__enterFmtData:GetEpInifinityFmtData()
    return
  end
  local fmtId = self.__enterFmtData:GetFmtCtrlFmtId()
  self.__realFmtData = PlayerDataCenter.formationDic[fmtId]
  if self.__realFmtData == nil then
    PlayerDataCenter:CreateFormation(fmtId)
    self.__realFmtData = PlayerDataCenter.formationDic[fmtId]
  else
    self:CheckAndSyncIllegalCST()
    local isNeedRegular = self.__realFmtData:RegularFormationFairy()
    if isNeedRegular then
      self.heroNetwork:SendFormationFresh(self.__realFmtData.id, self.__realFmtData:GetFormationHeroDic(true), self.__realFmtData:GetFmtFairyUID())
    end
  end
  if self.__enterFmtData:GetIsEpInifinity424Act() then
    self.__enterFmtData:ApplyEpInifinity4Act24FmtData(self.__realFmtData)
    self.heroNetwork:SendFormationFresh(self.__realFmtData.id, self.__realFmtData:GetFormationHeroDic(true), self.__realFmtData:GetFmtFairyUID())
  end
end

function FormationController:GetOtherFormationData(fmtId)
  local isVirtual = self.__enterFmtData:IsFmtCtrlVirtualFmtData()
  if isVirtual then
    error("VirtualFmtData not support to get yet")
    return nil
  end
  return PlayerDataCenter.formationDic[fmtId]
end

function FormationController:__LoadFormationScene()
  UIUtil.AddOneCover("FmtCtrlLoadFormation", SafePack(nil, nil, nil, Color.clear, false))
  local path = PathConsts:GetFormationModelPath("Formation")
  local sceneWait = self.resloader:LoadABAssetAsyncAwait(path)
  coroutine.yield(sceneWait)
  local go = sceneWait.Result:Instantiate()
  self.fmtSceneCtrl:InitFmtSceneCtrl(go, self.__enterFmtData)
  self:OnEnterFormationScene()
  local enterFunc = self.__enterFmtData:GetFmtCtrlEnterFunc()
  if enterFunc ~= nil then
    enterFunc()
  end
  UIManager:ShowWindowAsync(UIWindowTypeID.Formation, function(win)
    self.__fmtUI2D = win
    win:InitUIFormation(self, self.__enterFmtData)
  end)
  while self.__fmtUI2D == nil do
    coroutine.yield(nil)
  end
  self.fmtSceneCtrl:RefreshFmtScene(true)
  local customLight
  if not IsNull(self.__camMain) then
    customLight = self.__camMain:GetComponent(typeof(CS.CustomLight))
  end
  if IsNull(customLight) then
    customLight = CS_Camera.main:GetComponent(typeof(CS.CustomLight))
  end
  if not IsNull(customLight) then
    CS_Shader.SetGlobalColor(self._GlobalCharColorHash, customLight.CharacterGlobalColor)
    customLight:RefreshCharacterShadow()
    customLight:RefreshCharacterOutline()
  end
  local heroIdList = {}
  for k, heroId in pairs(self.__fmtData:GetFormationHeroDic(true)) do
    table.insert(heroIdList, heroId)
  end
  if 0 < #heroIdList then
    local voHeroId = heroIdList[math.random(#heroIdList)]
    local cvCtr = ControllerManager:GetController(ControllerTypeId.Cv, true)
    cvCtr:PlayCv(voHeroId, ConfigData:GetVoicePointRandom(eVoicePointType.EnterTeam, nil, voHeroId))
  end
  UIUtil.CloseOneCover("FmtCtrlLoadFormation")
  GuideManager:TryTriggerGuide(eGuideCondition.InFormationSpecial)
end

function FormationController:SetCouldUseSwitchBtn(bool)
  self.__fmtUI2D:SetSwitchButtonActive(bool)
end

function FormationController:FmtCtrlEnterEditSate()
  if self.__fmtCtrlState == FmtEnum.FmtCtrlSate.editing then
    return
  end
  if self.__fmtCtrlState ~= FmtEnum.FmtCtrlSate.normal then
    error("fmtCtrl state error: not normal state when enter EditSate")
    return
  end
  if self.__enterFmtData:IsFmtCtrlVirtualFmtData() then
    self:ShowQuickFormation(nil)
    return
  end
  if self.__enterFmtData:IsFmtInBrotatoDeploy() and self.__enterFmtData:GetIsHaveOfficialSupport() then
    self:ShowQuickFormationWithOfficialSupport(nil)
    return
  end
  if self.__enterFmtData:GetIsEpInifinity() then
    return
  end
  self.__fmtCtrlState = FmtEnum.FmtCtrlSate.editing
  UIUtil.AddOneCover("FmtCtrlEnterEditSate", SafePack(nil, nil, nil, Color.clear, false))
  self.__fmtUI2D:EnterEditorMode()
  self.fmtSceneCtrl:PlayTimeLine(function()
    UIUtil.CloseOneCover("FmtCtrlEnterEditSate")
  end, function()
    for index, heroEntity in pairs(self.fmtSceneCtrl.heroEntityDic) do
      heroEntity:UpdateInfoPos()
    end
  end)
  self.fmtSceneCtrl:Get3DUIFormation():ShowFmtHeroQuickLvUp()
end

function FormationController:IsFmtCtrlInEditState()
  return self.__fmtCtrlState == FmtEnum.FmtCtrlSate.editing
end

function FormationController:FmtCtrlQuitEditSate()
  if self.__fmtCtrlState ~= FmtEnum.FmtCtrlSate.editing then
    error("fmtCtrl state error: not editing state when Quit EditSate")
    return
  end
  self.__fmtCtrlState = FmtEnum.FmtCtrlSate.normal
  UIUtil.AddOneCover("FmtCtrlQuitEditSate", SafePack(nil, nil, nil, Color.clear, false))
  self.__fmtUI2D:ExitEditorMode()
  self.fmtSceneCtrl:RewindTimeLine(function()
    UIUtil.CloseOneCover("FmtCtrlQuitEditSate")
  end, function()
    for index, heroEntity in pairs(self.fmtSceneCtrl.heroEntityDic) do
      heroEntity:UpdateInfoPos()
    end
  end)
  self:ModifyFormation(self.__fmtData)
  self.fmtSceneCtrl:Get3DUIFormation():ShowFmtHeroQuickLvUp()
end

function FormationController:FmtCtrlOnStartDraggingCard(heroData)
  if self.__fmtCtrlState ~= FmtEnum.FmtCtrlSate.editing then
    error("fmtCtrl state error: not editing state")
    return
  end
  self.dragingCardHeroData = heroData
  local heroEntity = self.fmtSceneCtrl.heroEntityIdDic[heroData.dataId]
  if heroEntity ~= nil then
    self.__fmtUI2D:SetFormationFocus(true, heroEntity.transform.position)
  end
end

function FormationController:FmtCtrlOnEndDraggingCard()
  self.dragingCardHeroData = nil
  self.__fmtUI2D:SetFormationFocus(false)
end

function FormationController:GetOnDragCardHeroData()
  return self.dragingCardHeroData
end

function FormationController:ModifyFormation(formationData, newHeroDic, isForce)
  if self.__fmtCtrlState == FmtEnum.FmtCtrlSate.editing and not isForce then
    return
  end
  if self.__enterFmtData:GetIsEpInifinity() then
    return
  end
  self.__realFmtData:ModifyFormationData(formationData, newHeroDic)
  if formationData == nil then
    self.__fmtData = self.__realFmtData:DeepCopyFmtData()
  end
  self:_RegularHeroNumLimit()
  if not self.__enterFmtData:IsFmtCtrlVirtualFmtData() or self.__enterFmtData:IsFmtInBrotatoDeploy() then
    self.heroNetwork:SendFormationFresh(self.__realFmtData.id, self.__realFmtData:GetFormationHeroDic(true), self.__realFmtData:GetFmtFairyUID())
  else
    local _, wcType = self.__enterFmtData:IsWCFormation()
    local saveUserData = PersistentManager:GetDataModel(PersistentConfig.ePackage.UserData)
    saveUserData:SetLastWeeklyChallengeFmt(wcType, self.__realFmtData:GetFormationHeroDic(true))
    PersistentManager:SaveModelData(PersistentConfig.ePackage.UserData)
  end
  self._fmtIsChange = true
end

function FormationController:ModifyFormationName(name)
  self.__fmtData.name = name
  self.__realFmtData.name = name
end

function FormationController:OnCurrentFmtChanged()
  self.__fmtUI2D:RefreshUIAboutCurFmtDat()
end

function FormationController:FmtStartBattle()
  if self.__enterFmtData:IsFmtChallengeMode() then
    local stgChallengeData = self.__enterFmtData:GetFmtChallengeModeData()
    for taskId, v in pairs(stgChallengeData:GetStgClgOptionalTaskOpenDic()) do
      local ok, taskDes = TaskCheckUtil:CheckFormationCondition(taskId, self.__fmtData)
      if not ok then
        UIManager:ShowWindowAsync(UIWindowTypeID.MessageCommon, function(win)
          if win == nil then
            return
          end
          win:ShowTextBoxWithConfirm(string.format(ConfigData:GetTipContent(964), taskDes), nil)
        end)
        return
      end
    end
    if self.__fmtData:GetIsHaveOfficialSupport() then
      CS_MessageCommon.ShowMessageTipsWithErrorSound(ConfigData:GetTipContent(7720))
      return
    end
  end
  local count = 0
  local heroIdList = {}
  local heroIdDic = self.__fmtData:GetFormationHeroDic()
  local maxStageNum = self.__enterFmtData:GetFormationMaxStageNum()
  for i = 1, maxStageNum do
    if heroIdDic[i] ~= nil and 0 < heroIdDic[i] then
      count = count + 1
      table.insert(heroIdList, heroIdDic[i])
    end
  end
  if self.__fmtData:GetIsOnlyHaveSupportHero() then
    CS_MessageCommon.ShowMessageTipsWithErrorSound(ConfigData:GetTipContent(TipContent.Formation_OnlyHaveASupportHero))
    return
  end
  if count < ConfigData.game_config.min_stage_hero then
    CS_MessageCommon.ShowMessageTipsWithErrorSound(string.format(ConfigData:GetTipContent(TipContent.Sector_HeroNumInsufficient), tostring(ConfigData.game_config.min_stage_hero)))
    return
  end
  
  local function startFunc()
    local voHeroId = heroIdList[math.random(#heroIdList)]
    local voiceId = ConfigData:GetVoicePointRandom(eVoicePointType.StartBattle, nil, voHeroId)
    local startBattleFunc = self.__enterFmtData:GetFmtCtrlStartBattleFunc()
    if startBattleFunc ~= nil then
      startBattleFunc(self.__fmtData, function()
        self:AfterStartBattleExitFormation(voHeroId, voiceId)
      end)
    end
    PlayerDataCenter.supportHeroData:CleanCachedSupportData()
  end
  
  if self.__enterFmtData:IsFmtCtrlFiexd() and not self.__enterFmtData:IsFmtFixedHeroFull(self.__fmtData) then
    UIManager:ShowWindowAsync(UIWindowTypeID.MessageCommon, function(win)
      if win == nil then
        return
      end
      win:ShowTextBoxWithYesAndNo(ConfigData:GetTipContent(392), startFunc, nil)
    end)
    return
  end
  local startBattleCustomCheckFuncDic = self.__enterFmtData:GetStartBattleCustomCheckFunc()
  if startBattleCustomCheckFuncDic ~= nil then
    for nameStr, func in pairs(startBattleCustomCheckFuncDic) do
      local isPass = func(self.__enterFmtData, self.__fmtData)
      if not isPass then
        return
      end
    end
  end
  startFunc()
end

function FormationController:AfterStartBattleExitFormation(voHeroId, voiceId)
  local cvCtr = ControllerManager:GetController(ControllerTypeId.Cv, true)
  cvCtr:PlayCv(voHeroId, voiceId)
  if ExplorationManager:IsInTDExp() or BattleDungeonManager:IsInTDDungeon() then
    self:Delete()
    self:OnLeaveFormationScene()
    return
  end
  local gameType = self.__enterFmtData:GetFmtCtrlGameType()
  if gameType == FmtEnum.eFmtGamePlayType.Exploration then
    if ExplorationManager:IsInExploration() then
      local heroResDic = self:__GetFmtReuseHeroResDic()
      ExplorationManager.epCtrl.sceneCtrl:SaveReuseHeroResloader(heroResDic)
    end
  elseif gameType == FmtEnum.eFmtGamePlayType.Dungeon then
    if BattleDungeonManager:InBattleDungeon() then
      local heroResDic = self:__GetFmtReuseHeroResDic()
      BattleDungeonManager.dungeonCtrl.sceneCtrl:SaveReuseHeroResloader(heroResDic)
    end
  elseif gameType == FmtEnum.eFmtGamePlayType.WarChess then
  end
  self:Delete()
  self:OnLeaveFormationScene()
end

function FormationController:__GetFmtReuseHeroResDic()
  local heroResDic = {}
  for heroId, heroEntity in pairs(self.fmtSceneCtrl.heroEntityIdDic) do
    local resloader = heroEntity:GetHeroEntityLoadedResloader()
    if resloader ~= nil then
      heroResDic[heroId] = resloader
    end
  end
  return heroResDic
end

function FormationController:FmtCtrlSwitchFmt(fmtId, index)
  if self.__fmtCtrlState == FmtEnum.FmtCtrlSate.editing then
    self:ModifyFormation(self.__fmtData, nil, true)
  end
  self._fmtIsChange = true
  self.__enterFmtData:SetFmtId(fmtId)
  local isReGenFixedFmt = self.__enterFmtData:TryReGenFixedFmtData(index)
  self:__RegularSupportHeroData(self.__realFmtData)
  self:GenFormationData()
  self:__RegularSupportHeroData(self.__realFmtData)
  self.__fmtData = self.__realFmtData:DeepCopyFmtData()
  self:_RegularHeroNumLimit()
  if isReGenFixedFmt then
    self.fmtSceneCtrl:RefreshFmtPlatformIsBanned()
  end
  self.__fmtUI2D:RefreshAllUIAboutFmtData()
  self.fmtSceneCtrl:RefreshFmtScene(true)
end

function FormationController:_RegularHeroNumLimit()
  local isChange = false
  local limitHeroNum = self.__enterFmtData:GetFmtLimitHeroNum()
  if 0 < limitHeroNum then
    local heroIdxDic = self.__fmtData:GetFormationHeroDic()
    for idx, heroId in pairs(heroIdxDic) do
      if self.__enterFmtData:IsFmtPlatformBan(idx) then
        self.__fmtData:SetHero2Formation(idx, nil)
        isChange = true
      end
    end
  end
  if isChange then
    self:ModifyFormation(self.__fmtData, nil, true)
  end
end

function FormationController:__RegularSupportHeroData(fmtData)
  if self.__enterFmtData:IsFmtInBattleDeploy() then
    local cacheSupportHeroData = self:GetCacheSelectedSupportHero()
    local curSupportHeroData = fmtData:GetRealSupportHeroData()
    local cacheHeroUserId
    if cacheSupportHeroData ~= nil and cacheSupportHeroData:GetUserInfo() ~= nil then
      cacheHeroUserId = cacheSupportHeroData:GetUserInfo():GetUserUID()
    end
    local curHeroUserId
    if curSupportHeroData ~= nil and curSupportHeroData:GetUserInfo() ~= nil then
      curHeroUserId = curSupportHeroData:GetUserInfo():GetUserUID()
    end
    if curSupportHeroData ~= nil and cacheSupportHeroData ~= nil and curSupportHeroData.dataId ~= cacheSupportHeroData.dataId or cacheHeroUserId ~= curHeroUserId and cacheHeroUserId ~= nil and curHeroUserId ~= nil then
      fmtData:CleanSupportData()
      if self.__fmtUI2D ~= nil then
        self.__fmtUI2D:RefreshFmtItemPow(fmtData)
      end
    end
  elseif fmtData.isHaveSupport then
    fmtData:CleanSupportData()
    if self.__fmtUI2D ~= nil then
      self.__fmtUI2D:RefreshFmtItemPow(fmtData)
    end
  end
  local officialSupportCfgId = self.__enterFmtData:GetOfficialSupportCfgId()
  FormationUtil.TryCleanIllegalOfficialSupportData(officialSupportCfgId, fmtData)
end

function FormationController:GetLowerEfficiencyTip(stageId)
  local stageCfg = ConfigData.sector_stage[stageId]
  if stageCfg then
    local sectorStage = stageCfg.sector
    local actType, actId, actData = PlayerDataCenter.sectorEntranceHandler:GetActivityDataBySectorId(sectorStage)
    if FmtEnum.eFmtSpecialSectorTip[sectorStage] and actData and sectorStage == FmtEnum.eFmtSpecialSector.Copley then
      return ConfigData:GetTipContent(FmtEnum.eFmtSpecialSectorTip[sectorStage][1])
    end
  end
  return ConfigData:GetTipContent(388)
end

function FormationController:GetFmtCtrlFmtData()
  return self.__fmtData
end

function FormationController:GetFmtCtrlFmtCSTData()
  local isVirtual = self.__enterFmtData:IsFmtCtrlVirtualFmtData()
  if isVirtual then
    if self.__fmtCSTData4vt == nil then
      local virtualFmtData = self.__enterFmtData:GetFmtCtrlVirtualFmtData()
      local cstSavingData = virtualFmtData:GetVirFmtCstData()
      local fairyData = virtualFmtData:GetVirFmtFairyData()
      local fmtCSTData = CSTData.New(cstSavingData, fairyData)
      self.__fmtCSTData4vt = fmtCSTData
    end
    return self.__fmtCSTData4vt
  end
  if self.__fmtCSTDataDic == nil then
    self.__fmtCSTDataDic = {}
  end
  local fmtId = self.__fmtData.id
  if self.__fmtCSTDataDic[fmtId] == nil then
    local cstSavingData = self.__fmtData:GetFmtCSTData()
    local fairyData = self.__fmtData:GetFmtFairyData()
    local fmtCSTData = CSTData.New(cstSavingData, fairyData)
    self.__fmtCSTDataDic[fmtId] = fmtCSTData
  end
  return self.__fmtCSTDataDic[fmtId]
end

function FormationController:GetFmtCtrlFmtCSTDataList()
  local list = {}
  local fairyData, curTreeId, savingDic
  local isVirtual = self.__enterFmtData:IsFmtCtrlVirtualFmtData()
  if isVirtual then
    local curCSTData = self:GetFmtCtrlFmtCSTData()
    curTreeId = curCSTData:GetCSTTreeId()
    local virtualFmtData = self.__enterFmtData:GetFmtCtrlVirtualFmtData()
    fairyData = virtualFmtData:GetVirFmtFairyData()
    savingDic = virtualFmtData:GetVirFmtCSTDatDic()
  else
    fairyData = self.__fmtData:GetFmtFairyData()
    curTreeId = self.__fmtData:GetFmtCSTDataCurId()
    savingDic = self.__fmtData:GetFmtCSTDatDic()
  end
  local cstData
  for treeId, treeCfg in ipairs(ConfigData.commander_skill) do
    if curTreeId == treeId then
      cstData = self:GetFmtCtrlFmtCSTData()
    else
      local cstSavingData = savingDic[treeId]
      if cstSavingData == nil then
        cstSavingData = CSTUtil.GetDefaultSavingData(treeId)
      end
      cstData = CSTData.New(cstSavingData, fairyData)
    end
    table.insert(list, cstData)
  end
  table.sort(list, function(a, b)
    return a:GetCSTTreeId() < b:GetCSTTreeId()
  end)
  return list
end

function FormationController:SetFmtChallengeMode(isChallengeMode, witchChallengeInfo, callback)
  local stgChallengeData = self.__enterFmtData:GetFmtChallengeModeData()
  local stageId = self.__enterFmtData:GetFmtCtrlFmtIdStageId()
  if not stgChallengeData.isDgChallenge and not PlayerDataCenter.sectorAchievementDatas:IsStageChallengeTaskOpen(stageId) then
    UIManager:ShowWindowAsync(UIWindowTypeID.MessageCommon, function(win)
      if win == nil then
        return
      end
      local msg = PlayerDataCenter.sectorAchievementDatas:GetStageChallengeTaskOpenDes(stageId)
      win:ShowTextBoxWithConfirm(msg, nil)
    end)
    return
  end
  local challengeModeFunc = self.__enterFmtData:GetFmtChallengeModeChangeFunc()
  
  local function changeModeFunc()
    stgChallengeData:SetStageChallengeOpen(isChallengeMode)
    if callback ~= nil then
      callback()
    end
    if challengeModeFunc ~= nil then
      challengeModeFunc(isChallengeMode)
    end
    self.__fmtData:CleanSupportData()
    self.fmtSceneCtrl:RefreshFmtScene()
  end
  
  if isChallengeMode and witchChallengeInfo then
    UIManager:ShowWindowAsync(UIWindowTypeID.FmtChallengeInfo, function(win)
      if win == nil then
        return
      end
      win:InitFmtChallengeInfo(stgChallengeData, changeModeFunc)
    end)
  else
    changeModeFunc()
  end
end

function FormationController:CalculatePower(formationData)
  local totalFtPower = 0
  local totalBenchPower = 0
  local heroPower = 0
  local top5Total = 0
  local heroTotalList = {}
  local campCountDic = table.GetDefaulValueTable(0)
  local fmtNum = 0
  local bunchNum = 0
  for index, heroId in pairs(formationData:GetFormationHeroDic()) do
    if not self.__enterFmtData:IsFmtPlatformBan(index) then
      local heroData
      if self.__enterFmtData:IsFmtCtrlVirtualFmtData() then
        local specialRuleGenerator = self.__enterFmtData:GetFmtCtrlSpecialRuleGenerator()
        heroData = specialRuleGenerator:GetSpecificHeroData(heroId)
      elseif self.__enterFmtData:GetIsEpInifinity() then
        heroData = self.__enterFmtData:GetEpInifinityHeroData(heroId)
      else
        heroData = formationData:GetFormationHeroData(index)
      end
      if heroData ~= nil then
        local campId = heroData.camp
        campCountDic[campId] = campCountDic[campId] + 1
        local fairyUID = formationData:GetFmtFairyUID()
        local fairyData
        if fairyUID ~= nil and fairyUID ~= 0 then
          local fairyCtrl = ControllerManager:GetController(ControllerTypeId.Fairy)
          if fairyCtrl ~= nil then
            fairyData = fairyCtrl:GetFairyDataByUID(fairyUID)
          end
        end
        heroPower = heroData:GetFightingPower(nil, fairyData)
        if heroPower ~= 0 then
          table.insert(heroTotalList, heroPower)
        end
        if index > self.__enterFmtData:GetFormationMaxStageNum() then
          totalBenchPower = heroPower + totalBenchPower
          bunchNum = bunchNum + 1
        else
          totalFtPower = heroPower + totalFtPower
          fmtNum = fmtNum + 1
        end
      end
    end
  end
  table.sort(heroTotalList, function(a, b)
    return b < a
  end)
  for i = 1, #heroTotalList do
    if 5 < i then
      break
    end
    top5Total = top5Total + heroTotalList[i]
  end
  local commanderPowerTab = {power = totalFtPower}
  local dynPlayerFtPower = ConfigData.GetFormulaValue(eFormulaType.Commander, commanderPowerTab)
  dynPlayerFtPower = math.floor(dynPlayerFtPower)
  local fairyData = formationData:GetFmtFairyData()
  local fairyPow = 0
  if fairyData ~= nil then
    fairyPow = FairyHelper.GetFairyBattlePow(fairyData)
  end
  totalFtPower = totalFtPower + dynPlayerFtPower + fairyPow * fmtNum
  totalBenchPower = totalBenchPower + fairyPow * bunchNum
  top5Total = top5Total + dynPlayerFtPower + fairyPow * math.min(5, #heroTotalList)
  totalFtPower = math.max(totalFtPower, 0)
  totalBenchPower = math.max(totalBenchPower, 0)
  top5Total = math.max(top5Total, 0)
  return totalFtPower, totalBenchPower, campCountDic, top5Total
end

function FormationController:GetFmtCtrlResloader()
  return self.resloader
end

function FormationController:EnableMainCamAndLight(enable)
  if not IsNull(self.__mainCam) then
    self.__mainCam.gameObject:SetActive(enable)
  end
  if not IsNull(self.__lightMain) then
    self.__lightMain:SetActive(enable)
  end
end

function FormationController:OnEnterFormationScene()
  self:EnableMainCamAndLight(false)
  self.__multiTouchEnabledBeforeOpen = CS_Input.multiTouchEnabled
  CS_Input.multiTouchEnabled = false
end

function FormationController:OnLeaveFormationScene()
  self:EnableMainCamAndLight(true)
  CS_Input.multiTouchEnabled = self.__multiTouchEnabledBeforeOpen
end

function FormationController:OnFmtOpenCSTUI()
  self.fmtSceneCtrl:SetFormationCameraActive(false)
  self.__fmtUI2D:Hide()
end

function FormationController:OnFmtCloseCSTUI()
  self.fmtSceneCtrl:SetFormationCameraActive(true)
  self.__fmtUI2D:Show()
end

function FormationController:SaveFmtCSTChange(cstDataList, selectedTreeId)
  local CSTNetCtrl = NetworkManager:GetNetwork(NetworkTypeID.CommanderSkill)
  if CSTNetCtrl == nil then
    return
  end
  local isVirtual = self.__enterFmtData:IsFmtCtrlVirtualFmtData()
  if isVirtual then
    local virtualFmtData = self.__enterFmtData:GetFmtCtrlVirtualFmtData()
    virtualFmtData:VirtualFmtSetCst(cstDataList, selectedTreeId)
    local treeSavingDic = virtualFmtData:GetVirFmtCSTDatDic()
    self.__fmtCSTData4vt = nil
    CSTNetCtrl:CS_COMMANDSKILL_FreshSavingTree(treeSavingDic, function()
      local _, wcType = self.__enterFmtData:IsWCFormation()
      PersistentManager:GetDataModel(PersistentConfig.ePackage.UserData):SetLastWeeklySkillList(wcType, selectedTreeId)
      PersistentManager:SaveModelData(PersistentConfig.ePackage.UserData)
    end)
  elseif self.__enterFmtData:GetIsEpInifinity() then
    self.__fmtData:ModifyCSTData(cstDataList, selectedTreeId)
    local fmtId = self.__fmtData.id
    self.__fmtCSTDataDic[fmtId] = nil
    self.__realFmtData:ModifyCSTData(cstDataList, selectedTreeId)
    self:OnCommendSkillChange()
    return
  else
    self.__fmtData:ModifyCSTData(cstDataList, selectedTreeId)
    local fmtId = self.__fmtData.id
    self.__fmtCSTDataDic[fmtId] = nil
    CSTNetCtrl:CS_COMMANDSKILL_SaveFromFormation(self.__fmtData, function()
      self._fmtCommanderskillChange = true
      self._fmtIsChange = true
    end)
  end
end

function FormationController:OnCommendSkillChange()
  if self.__fmtData == nil then
    return
  end
  self.__fmtData:CopyCST(self.__realFmtData)
  if self.__fmtUI2D ~= nil then
    self.__fmtUI2D:RefreshFmtCST()
  end
end

function FormationController:TryFixFormatoionCST(conditionId)
  if conditionId ~= CheckerTypeId.CompleteStage then
    return
  end
  if not self:CheckAndSyncIllegalCST() then
    return
  end
  local cstCtrl = ControllerManager:GetController(ControllerTypeId.CommanderSkill)
  if cstCtrl ~= nil then
    local fairyData = self.__fmtData:GetFmtFairyData()
    local fairyReplaceCSTSkillDic = fairyData:GetFairyReplacedCommanderSkill()
    local cstTreeData = self:GetFmtCtrlFmtCSTData()
    local cstDataList = self:GetFmtCtrlFmtCSTDataList()
    cstCtrl:RefreshCmdSkillCtrl(cstTreeData, cstDataList, fairyReplaceCSTSkillDic)
  end
  MsgCenter:Broadcast(eMsgEventId.OnCommanderSkillChande)
end

function FormationController:CheckAndSyncIllegalCST()
  if self.__realFmtData:IsIllegalCST(true) then
    warn("auto change fmt CST data and save")
  end
  if self.__enterFmtData:IsFmtCtrlVirtualFmtData() then
    return false
  end
  NetworkManager:GetNetwork(NetworkTypeID.CommanderSkill):CS_COMMANDSKILL_SaveFromFormation(self.__realFmtData)
  return true
end

function FormationController:OnFmtCtrlSelectWCDebuffOver()
  self.__fmtUI2D:RefreshFmtPower()
end

function FormationController:OnFmtCtrlUpdateWCDebuffSelect(buffIds)
  local virtualFmtData = self.__enterFmtData:GetFmtCtrlVirtualFmtData()
  if virtualFmtData ~= nil then
    virtualFmtData:SetBuffList(buffIds or {})
  end
  local fmtBuffSelect = self.__enterFmtData:GetPeridicFmtBuffSelect()
  if fmtBuffSelect == nil then
    return
  end
  fmtBuffSelect:SetFmtBuffSelect(buffIds)
  local permillageAll = fmtBuffSelect:GetFmtBuffCurAddScoreRate()
  local warningTipValue = fmtBuffSelect:GetBuffScoreWarningValue(1)
  self.fmtSceneCtrl:SetWarningTipState(permillageAll >= warningTipValue)
end

function FormationController:TryUpdateSupporeDatas()
  local supportHeroData = self.__fmtData:GetRealSupportHeroData()
  local selectedSupportHero = false
  if self.__fmtUI2D.editNode ~= nil then
    selectedSupportHero = self.__fmtUI2D.editNode.supportHero.heroData ~= nil
  end
  if supportHeroData == nil and not selectedSupportHero then
    return
  end
  local fixCfg = PlayerDataCenter.supportHeroData:GetCurFormationLevelEffectByAllHero(PlayerDataCenter.heroDic)
  if fixCfg ~= self.__caheFixCfg then
    self.__caheFixCfg = fixCfg
    if supportHeroData ~= nil then
      supportHeroData:UseFixCfg2ChangeSupportorAttr(fixCfg)
    end
    if selectedSupportHero then
      self.__fmtUI2D.editNode.supportHero:UpdateFixCfg(fixCfg)
    end
  end
  local supportHeroData = self.__fmtData:GetSupportHeroData()
  if supportHeroData ~= nil then
    self.fmtSceneCtrl:RefreshSupportHeroInfo(supportHeroData.formIdx)
  end
end

function FormationController:CacheStrangerSupportHeroDic(allSupportHeroDataDic, nextRefreshTm, friendsBanData, userInfoDic, assistHeroTime)
  PlayerDataCenter.supportHeroData:SetCachedSupportData(allSupportHeroDataDic, nextRefreshTm, friendsBanData, userInfoDic, assistHeroTime)
  if self.__selectedSupportHero ~= nil then
    local uid = self.__selectedSupportHero:GetUserInfo():GetUserUID()
    local heroId = self.__selectedSupportHero.dataId
    if allSupportHeroDataDic[uid] == nil or allSupportHeroDataDic[uid][heroId] == nil then
      self:CacheSelectedSupportHero(nil)
      self.__fmtData:CleanSupportData()
      if self:IsFmtCtrlInEditState() then
        self.__fmtUI2D.editNode:ClearSupportCard()
      end
    end
  end
end

function FormationController:GetStrangerSupportHeroDic()
  return PlayerDataCenter.supportHeroData:GetCachedSupportData()
end

function FormationController:CacheSelectedSupportHero(supportHeroData)
  if self.__enterFmtData:IsFmtInBattleDeploy() then
    PlayerDataCenter.dungeonDyncData:CacheDgFmtFriendSupportHeroData(supportHeroData)
  end
  self.__selectedSupportHero = supportHeroData
end

function FormationController:GetCacheSelectedSupportHero()
  if self.__enterFmtData:IsFmtInBattleDeploy() then
    return PlayerDataCenter.dungeonDyncData:GetDgFmtFriendSupportHeroDataCache()
  end
  return self.__selectedSupportHero
end

function FormationController:ShowQuickFormation(heroData)
  self.__fmtCtrlState = FmtEnum.FmtCtrlSate.editing
  UIManager:ShowWindowAsync(UIWindowTypeID.FormationQuick, function(window)
    if window ~= nil then
      self.fmtSceneCtrl:SetFormationCameraActive(false)
      self.__fmtUI2D:Hide()
      window:OpenFQCampInfluence(self.__enterFmtData:GetIsOpenedCampInfluence())
      window:InitQuickFmt(self.__fmtData, self, heroData, self.__enterFmtData:GetFmtCtrlSpecialRuleGenerator())
    end
  end)
end

function FormationController:ShowQuickFormationWithOfficialSupport(heroData)
  self.__fmtCtrlState = FmtEnum.FmtCtrlSate.editing
  UIManager:ShowWindowAsync(UIWindowTypeID.FormationQuick, function(window)
    if window ~= nil then
      self.fmtSceneCtrl:SetFormationCameraActive(false)
      self.__fmtUI2D:Hide()
      window:OpenFQCampInfluence(self.__enterFmtData:GetIsOpenedCampInfluence())
      window:SetOfficialSupportHeroDic(self.__enterFmtData:GetIsHaveOfficialSupportHeroDic())
      window:InitQuickFmt(self.__fmtData, self, heroData, self.__enterFmtData:GetFmtCtrlSpecialRuleGenerator())
    end
  end)
end

function FormationController:ExitQuickFormation(isFmtChanged)
  self.fmtSceneCtrl:SetFormationCameraActive(true)
  UIManager:DeleteWindow(UIWindowTypeID.FormationQuick)
  self.__fmtUI2D:Show()
  if isFmtChanged then
    self.__fmtUI2D:RefreshAllUIAboutFmtData()
    self.fmtSceneCtrl:RefreshFmtScene(true)
  end
  self.__fmtCtrlState = FmtEnum.FmtCtrlSate.normal
end

function FormationController:ShowHeroState(heroData, heroDataList)
  if heroData == nil then
    return
  end
  UIManager:ShowWindowAsync(UIWindowTypeID.HeroState, function(win)
    if win ~= nil then
      win:InitHeroState(heroData, heroDataList, function()
        local forCtrl = ControllerManager:GetController(ControllerTypeId.Formation)
        if forCtrl == nil then
          return
        end
        self.fmtSceneCtrl:RefreshFmtPlatUIAll()
      end)
    end
  end)
end

function FormationController:ReqFmtHeroLvUp(fmtIdx, heroId, targetLevel, notNeedFx)
  local heroData = PlayerDataCenter.heroDic[heroId]
  if heroData ~= nil then
    local isCanLevelUp = heroData:GenHeroCanQuickLevelUp()
    if isCanLevelUp then
      self.heroNetwork:CS_HERO_Upgrade(heroId, targetLevel, function()
        if not notNeedFx then
          self.fmtSceneCtrl:ShowHeroQuickLvUpEffect(fmtIdx)
        end
        self.fmtSceneCtrl:RefreshAllQuickLevel()
        self.__fmtUI2D:UpdateFmtHeroInfo(heroData)
        AudioManager:PlayAudioById(1126)
        GuideManager:TryTriggerGuide(eGuideCondition.InFormationSpecial)
      end)
    end
  end
end

function FormationController:_OnUpdateHero(heroUpdateIdDic)
  for heroId, v in pairs(heroUpdateIdDic) do
    self:__FormationHeroChange(heroId)
  end
  self.fmtSceneCtrl:OnUpdateHero(heroUpdateIdDic)
  if self.__fmtUI2D ~= nil then
    self.__fmtUI2D:TryRefreshHeroCards(heroUpdateIdDic, false)
  end
end

function FormationController:_OnFmtHeroSkinChange(heroId, skinId)
  self.fmtSceneCtrl:OnSkinChange(heroId, skinId)
  if self.__fmtUI2D ~= nil then
    self.__fmtUI2D:TryRefreshHeroCards({
      [heroId] = true
    }, true)
  end
end

function FormationController:__FormationHeroChange(heroId)
  self._heroChangedIdDic[heroId] = true
  self._fmtIsChange = true
end

function FormationController:ExitFormation()
  local mustInBattle = self.__enterFmtData:IsFmtInBattleDeploy(true)
  if mustInBattle and self._fmtIsChange then
    local heroChangedIdDic = {}
    for index, heroId in pairs(self.__fmtData.data) do
      if self._heroChangedIdDic[heroId] then
        heroChangedIdDic[heroId] = true
      end
    end
    NetworkManager:GetNetwork(NetworkTypeID.BattleDungeon):CS_BATTLE_FormationFresh(self.__fmtData, self._fmtCommanderskillChange, heroChangedIdDic, function(objList)
      self:_OnBattleFmtChange(objList)
    end)
  else
    self:RealExitFormation()
  end
end

function FormationController:RealExitFormation()
  local exitFunc = self.__enterFmtData:GetFmtCtrlExitFunc()
  if exitFunc ~= nil then
    exitFunc(self.__fmtData.id)
  end
  self:Delete()
  self:OnLeaveFormationScene()
end

function FormationController:_OnBattleFmtChange(objList)
  if objList.Count ~= 1 then
    error("objList.Count error:" .. tostring(objList.Count))
    return
  end
  local msg = objList[0]
  local curBattleSceneCtrl = BattleUtil.GetCurSceneCtrl()
  local dynPlayer = BattleUtil.GetCurDynPlayer()
  local treeId, commandTrees
  if self.__fmtData ~= nil then
    treeId = self.__fmtData:GetFmtCSTDataCurId()
    commandTrees = self.__fmtData:GetFmtCSTDatDic()
  end
  local skillDic = {}
  if dynPlayer.playerExtraSkillDic ~= nil then
    for skillId, skillLevel in pairs(dynPlayer.playerExtraSkillDic) do
      skillDic[skillId] = skillLevel
    end
  end
  dynPlayer:UpdataDynFairyData(msg.fairyStatic)
  dynPlayer:InitPlayerSkill(msg.player.stc)
  local addHeroList, newHeroList, removeHeroList = dynPlayer:ChangeDynPlayerHeroList(msg.roleSync.enter, msg.roleSync.quit, msg.roleSync.change)
  UIUtil.AddOneCover("_OnBattleFmtChange", SafePack(nil, nil, nil, Color.clear, false))
  local epWindow = UIManager:GetWindow(UIWindowTypeID.DungeonStateInfo)
  if epWindow ~= nil then
    epWindow:ReInitDungeonHeroList(dynPlayer)
  end
  curBattleSceneCtrl:ChangeEpHeroModel(removeHeroList, addHeroList, function()
    UIUtil.CloseOneCover("_OnBattleFmtChange")
    self:RealExitFormation()
  end)
  curBattleSceneCtrl:ChangeFiary(dynPlayer)
end

function FormationController:CheckFormationHero(newHeroDic)
  local posMax = ConfigData:GetFormationHeroCount()
  for pos, _ in pairs(newHeroDic) do
    if pos > posMax then
      error("formation error")
      return false
    end
  end
  return true
end

function FormationController:UpdateFormationHero(newHeroDic)
  if newHeroDic == nil then
    return false
  end
  if not self:CheckFormationHero(newHeroDic) then
    return false
  end
  local isChange = false
  local oldHeroDic = self.__fmtData:GetFormationHeroDic()
  if table.count(newHeroDic) == table.count(oldHeroDic) then
    for key, value in pairs(newHeroDic) do
      if value ~= oldHeroDic[key] then
        isChange = true
        break
      end
    end
  else
    isChange = true
  end
  if isChange then
    self:ModifyFormation(nil, newHeroDic, true)
    self.__fmtUI2D:RefreshUIAboutCurFmtDat()
    self.fmtSceneCtrl:RefreshFmtScene(self.curFormation)
  end
  return isChange
end

function FormationController:__OnFmtFairyDataChange()
  local formationData = self:GetFmtCtrlFmtData()
  local fmtId = formationData.id
  formationData:RegularFairyCSTSkill()
  if self.__fmtCSTDataDic ~= nil then
    self.__fmtCSTDataDic[fmtId] = nil
  end
  self:ModifyFormation(formationData)
  self.__fmtUI2D:RefreshAllUIAboutFmtData()
  self.fmtSceneCtrl:RefreshFmtScene(false)
  local ctsDataList = self:GetFmtCtrlFmtCSTDataList()
  local cstData = self:GetFmtCtrlFmtCSTData()
  self:SaveFmtCSTChange(ctsDataList, cstData:GetCSTTreeId())
  self._fmtIsChange = true
end

function FormationController:RefreshFmtShow()
  self.__fmtUI2D:RefreshAllUIAboutFmtData()
  self.fmtSceneCtrl:RefreshFmtScene(false)
end

function FormationController:OnDelete()
  MsgCenter:RemoveListener(eMsgEventId.PreCondition, self.__TryFixFormatoionCST)
  MsgCenter:RemoveListener(eMsgEventId.OnSupportHoreNeedFresh, self._TryUpdateSupporeDatas)
  MsgCenter:RemoveListener(eMsgEventId.UpdateHero, self.__UpdateHeroForFmtInfo)
  MsgCenter:RemoveListener(eMsgEventId.OnHeroAthChange, self.__FormationHeroChangeFunc)
  MsgCenter:RemoveListener(eMsgEventId.HeroTalentLvUp, self.__FormationHeroChangeFunc)
  MsgCenter:RemoveListener(eMsgEventId.OnCommanderSkillChande, self.__OnCommendSkillChange)
  MsgCenter:RemoveListener(eMsgEventId.OnHeroSkinChange, self.__OnFmtHeroSkinChange)
  MsgCenter:RemoveListener(eMsgEventId.OnFmtFairyChange, self.__onFmtFairyDataChange)
  MsgCenter:RemoveListener(eMsgEventId.HeroSkinLimitTimeOut, self.__OnFmtHeroSkinChange)
  UIUtil.CloseAllCover()
  if self.resloader ~= nil then
    self.resloader:Put2Pool()
    self.resloader = nil
  end
  if self.__initCoroutine ~= nil then
    GR.StopCoroutine(self.__initCoroutine)
  end
  for _, ctrl in pairs(self.ctrls) do
    ctrl:OnDelete()
  end
  base.OnDelete(self)
end

return FormationController
