local UIBattle = class("UIBattle", UIBaseWindow)
local base = UIBaseWindow
local cs_MessageCommon = CS.MessageCommon
local cs_InputUtility = CS.InputUtility
local cs_eBattleState = CS.eBattleState
local cs_BattleMgr = CS.BattleManager
local UINGamePlayScore = require("Game.Battle.UI.UINGamePlayScore")
local FmtEnum = require("Game.Formation.FmtEnum")
local UINBtnCommanderSkill = require("Game.Formation.UI.2DFormation.UINBtnCommanderSkill")
local util = require("XLua.Common.xlua_util")
local UINBattleDeployChipEft = require("Game.Battle.UI.UINBattleDeployChipEft")
local BattleUtil = require("Game.Battle.BattleUtil")
local FormationUtil = require("Game.Formation.FormationUtil")
local UINAutoModuleSwitch = require("Game.Exploration.UI.AutoMode.UINAutoModuleSwitch")
local EpCommonUtil = require("Game.Exploration.Util.EpCommonUtil")
local ExplorationEnum = require("Game.Exploration.ExplorationEnum")
local eWarChessEnum = require("Game.WarChess.eWarChessEnum")
local CSTUtil = require("Game.CommanderSkill.CSTUtil")
local CSTData = require("Game.CommanderSkill.CSTData")

function UIBattle:OnInit()
  self.resLoader = CS.ResLoader.Create()
  UIUtil.AddButtonListener(self.ui.btn_Pause, self, self.__OnClickPauseTd)
  UIUtil.AddButtonListener(self.ui.btn_SpeedUP, self, self.__OnClickSpeedUP)
  UIUtil.AddButtonListener(self.ui.btn_BattleStart, self, self.__OnClickBattleStart)
  UIUtil.AddButtonListener(self.ui.btn_Back, self, self.__OnClickBreakDeploy)
  UIUtil.AddValueChangedListener(self.ui.tog_Auto, self, self.__OnAutoBattleClick)
  UIUtil.AddButtonListener(self.ui.btn_Retreat, self, self.__OnClickRetreat)
  UIUtil.AddButtonListener(self.ui.btn_Formation, self, self.__OnClickEnterFmt)
  UIUtil.AddButtonListener(self.ui.btn_PauseNormal, self, self._OnClickPauseNormal)
  UIUtil.AddButtonListener(self.ui.btn_Setting, self, self._OnClickSetting)
  UIUtil.AddButtonListener(self.ui.btn_Healing, self, self.OnClickHealing)
  UIUtil.AddButtonListener(self.ui.btn_HideUI, self, self.__OnClickHideUIState)
  UIUtil.AddButtonListener(self.ui.btn_ShowUI, self, self.__OnClickShowUIState)
  UIUtil.AddButtonListener(self.ui.btn_FacScore, self, self.OnClickFacScore)
  self:__TranslateUIPos()
  self.__callWaveComingAction = BindCallback(self, self.__CallWaveComing)
  MsgCenter:AddListener(eMsgEventId.WaveComing, self.__callWaveComingAction)
  self.__OnChipChangeEvent = BindCallback(self, self.__OnChipChange)
  MsgCenter:AddListener(eMsgEventId.OnEpChipListChange, self.__OnChipChangeEvent)
  self.isSpeedUnlock = FunctionUnlockMgr:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_PlaySpeed)
  self.isAutoBattleUnlock = FunctionUnlockMgr:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_AutoBattle)
  self.gameplayScore = UINGamePlayScore.New()
  self.gameplayScore:Init(self.ui.gamePlayScore)
  self.gameplayScore:SetGamePlayScoreResloader(self.resLoader)
  self.__haveOverclock = false
  self.__supportAutoEp = false
  self.__supoortRepickChip = false
  self.__isShowHideUIBtn = true
  self.__showMoney = false
  self.__chipScoreId = 0
  self.isOpenAutoUlt = FunctionUnlockMgr:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_battle_auto_ult)
  self.curSpeedIndex = 1
  if 0 < PlayerDataCenter.playerId then
    self._userDataCfg = PersistentManager:GetDataModel(PersistentConfig.ePackage.UserData)
    if self._userDataCfg ~= nil then
      self.curSpeedIndex = self._userDataCfg:GetBattleSpeed()
    end
  end
  local isInTDBattle = BattleUtil.IsInTDBattle()
  if ExplorationManager:IsInExploration() then
    if ExplorationManager.epCtrl.overclockCtrl:IsLevelHasOverclock() and not isInTDBattle then
      self.ui.btn_Overclock.gameObject:SetActive(true)
      self.__haveOverclock = true
      UIUtil.AddButtonListener(self.ui.btn_Overclock, self, self.OnBtnOverclockClicked)
    end
    if ExplorationManager:IsSectorNewbee() then
      self.isAutoBattleUnlock = false
    end
    self.__chipScoreId = ExplorationManager:GetChipScoreId()
    if ExplorationManager.epCtrl:GetSupportAutoEpType() == ExplorationEnum.eAutoEpSwitchType.Battle and EpCommonUtil.IsSupportEpAutoMode() then
      self.__supportAutoEp = true
      self.ui.autoModuleNode:SetActive(true)
      self.__autoSwitchNode = UINAutoModuleSwitch.New()
      self.__autoSwitchNode:Init(self.ui.autoModuleNode)
      local autoCtrl = ExplorationManager.epCtrl.autoCtrl
      if autoCtrl:IsDefaultAutoEp() or autoCtrl:IsAutoModeRunning() then
        self.__autoSwitchNode:RefreshAutoModeState(true, true)
      end
    else
      self.ui.autoModuleNode:SetActive(false)
    end
  elseif BattleDungeonManager:InBattleDungeon() and BattleDungeonManager.dungeonCtrl:DungeonAbleSelectChip() then
    self.__supoortRepickChip = true
    self.ui.btn_Repick.gameObject:SetActive(true)
    UIUtil.AddButtonListener(self.ui.btn_Repick, self, self.OnBtnRepickChip)
  end
  if isInTDBattle then
    self.isAutoBattleUnlock = false
  end
  if BattleUtil.IsInBrotatBattle() then
    self:HideSomeUIInBrotato()
  end
  self:ShowCurLvInfoUI()
  self.btnCstItem = UINBtnCommanderSkill.New()
  self.btnCstItem:Init(self.ui.btn_CommanderSkill)
  self.__OnClickCstItem = BindCallback(self, self.OnClickCstItem)
  self.btnCstItem:InitBtnCommanderSkill(self.resLoader, self.__OnClickCstItem)
  self.__OnSendCstChange = BindCallback(self, self.OnSendCstChange)
  self._SaveCftChangeFunc = BindCallback(self, self._SaveCftChange)
  self.deployChipEftPool = UIItemPool.New(UINBattleDeployChipEft, self.ui.obj_ChipEft)
  self.ui.obj_ChipEft:SetActive(false)
  self.isShowingHeroInfo = false
  local isEnemyDetailUnlock = FunctionUnlockMgr:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_EnemyDetail)
  self:OnEnemyDetailUnlock(isEnemyDetailUnlock)
  self.battleController = CS.BattleManager.Instance.CurBattleController
  self.ui.btn_FacScore.gameObject:SetActive(false)
end

function UIBattle:HideSomeUIInBrotato()
  self.isAutoBattleUnlock = false
  self.isSpeedUnlock = false
  self.curSpeedIndex = 1
  self.__supportAutoEp = false
  self.__haveOverclock = false
  self.ui.btn_Overclock.gameObject:SetActive(false)
  self.__isShowHideUIBtn = false
  self.ui.btn_PauseNormal.gameObject:SetActive(false)
  self.__showMoney = true
end

function UIBattle:__TranslateUIPos()
  if not BattleUtil.IsInTDBattle() then
    return
  end
  self.ui.btn_BattleStartTrans:SetAnchoredPosition(self.ui.tdOffset.x, self.ui.btn_BattleStartTrans.anchoredPosition.y)
end

function UIBattle:InitUIBattle(breakBattleFunc)
  self.breakBattleFunc = breakBattleFunc
  local isUnlockBattleExit = FunctionUnlockMgr:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_BattleExit)
  if not isUnlockBattleExit then
    self.ui.btn_Retreat.gameObject:SetActive(false)
  end
  self.cs_battleCtrl = CS.BattleManager.Instance.CurBattleController
end

function UIBattle:InitUIBattleDeploy(onlyDeploy, startBattleFunc, savaDeployFunc, getDeployAliveRoleCount, heroList)
  self.startBattleFunc = startBattleFunc
  self.savaDeployFunc = savaDeployFunc
  self.getDeployAliveRoleCount = getDeployAliveRoleCount
  self.deployCsHeroList = heroList
  self.ui.btn_Back.gameObject:SetActive(onlyDeploy)
  self:__SwitchUIState(false)
  if onlyDeploy then
    self.ui.btn_BattleStart.gameObject:SetActive(false)
  end
  self.ui.btn_SpeedUP.gameObject:SetActive(self.isSpeedUnlock)
  self.ui.img_Speed:SetIndex(self.curSpeedIndex - 1)
  self.ui.tex_Speed:SetIndex(self.curSpeedIndex - 1)
  self.ui.tog_Auto.gameObject:SetActive(self.isAutoBattleUnlock)
  local autoBattle = self._userDataCfg and self._userDataCfg:GetIsAutoBattle() or false
  if not autoBattle then
    autoBattle = BattleDungeonManager:InBattleDungeon() and BattleDungeonManager.autoCtrl:IsEnbaleDungeonAutoMode()
    if autoBattle then
      self._isTempAuto = true
    end
  end
  if self.isAutoBattleUnlock and autoBattle then
    self.ui.tog_Auto.isOn = true
  else
    self.ui.tog_Auto.isOn = false
  end
  self._isTempAuto = nil
  self:TryShowCstChange()
  self:TryRefreshAutoInfo()
  TimerManager:StopTimer(self._StartChipEftTimer)
  self._StartChipEftTimer = TimerManager:StartTimer(1, self.StartChipEft, self, true, true)
  self.ui.btn_HideUI.gameObject:SetActive(false)
  self.ui.btn_ShowUI.gameObject:SetActive(false)
  self.ui.frame:SetActive(true)
  local isHaveHealing = false
  if WarChessSeasonManager:IsInWCS() then
    local spitemCfg = WarChessSeasonManager:GetWcSSpItemConfigByLogicType(eWarChessEnum.WCSpecialItemLogicType.healing)
    if spitemCfg ~= nil and spitemCfg.is_show_in_battle then
      isHaveHealing = true
    end
  end
  self.ui.btn_Healing.gameObject:SetActive(isHaveHealing)
  if self.__chipScoreId > 0 then
    local totalScore = ExplorationManager:GetChipScoreInBattle()
    self.ui.tex_FacSocre.text = tostring(totalScore)
  end
end

function UIBattle:InitUIBattleRunning(pauseFunc, speedUpFunc, autoBattleFunc, autoBattleUltFunc, autoBattleUltMaxEnergyFunc, battleUIStateFunc)
  self.pauseFunc = pauseFunc
  self.speedUpFunc = speedUpFunc
  self.autoBattleFunc = autoBattleFunc
  self.autoUltFunc = autoBattleUltFunc
  self.autoUltMaxEnergy = autoBattleUltMaxEnergyFunc
  self.battleUIStateFunc = battleUIStateFunc
  self:OnSpeedUpChange(self.ui.speedArray[self.curSpeedIndex])
  self:OnAutoBattleChange(self.ui.tog_Auto.isOn)
  self:__SwitchUIState(true)
  self:CloseCstChange()
  self:EndChipEft()
  self.deployCsHeroList = nil
  if self.__showMoney then
    local win = UIManager:GetWindow(UIWindowTypeID.DungeonStateInfo)
    if win ~= nil then
      win:SetMoneyActive(true)
    end
  end
  self.ui.btn_HideUI.gameObject:SetActive(self.__isShowHideUIBtn)
  self.ui.btn_ShowUI.gameObject:SetActive(false)
  self.ui.btn_Healing.gameObject:SetActive(false)
  if self.bCacheAutoUlt ~= nil and self.autoUltFunc ~= nil then
    if self.autoUltFunc ~= nil then
      self.autoUltFunc(self.bCacheAutoUlt)
    end
    if self.autoUltMaxEnergy ~= nil then
      self.autoUltMaxEnergy(self.bCacheAutoUlt)
    end
    self.bCacheAutoUlt = nil
  end
end

function UIBattle:ChangeStartBattleBtnText(index)
  self.ui.tex_BattleStart:SetIndex(index)
end

function UIBattle:__SwitchUIState(isBattleStart)
  local dynPlayer = BattleUtil.GetCurDynPlayer()
  local inTdBattle = BattleUtil.IsInTDBattle()
  self.ui.obj_pauseGroup:SetActive(isBattleStart and not inTdBattle)
  self.ui.btn_Pause.gameObject:SetActive(isBattleStart and inTdBattle)
  self.ui.btn_BattleStart.gameObject:SetActive(not isBattleStart)
  if BattleUtil.IsBattleEnableFormation() then
    self.ui.btn_Formation.gameObject:SetActive(not isBattleStart)
  end
  if BattleUtil.BattleAbleSelectChipSuit() then
    local stateInfoWin = UIManager:GetWindow(UIWindowTypeID.DungeonStateInfo)
    if stateInfoWin ~= nil then
      stateInfoWin.chipList:ShowDungeonChipListSuitSelectBtn(not isBattleStart)
    end
  end
  if self.__haveOverclock then
    self.ui.btn_Overclock.gameObject:SetActive(not isBattleStart)
  end
  if self.__supoortRepickChip then
    self.ui.btn_Repick.gameObject:SetActive(not isBattleStart)
  end
  self.ui.autoModuleNode:SetActive(self.__supportAutoEp and not isBattleStart)
  if self.__chipScoreId > 0 then
    self.ui.btn_FacScore.gameObject:SetActive(not isBattleStart)
  end
end

function UIBattle:HidePauseButton()
  self.ui.btn_Pause.gameObject:SetActive(false)
  self.ui.obj_pauseGroup:SetActive(false)
end

function UIBattle:SetBattleStartActive(active)
  self.ui.btn_BattleStart.gameObject:SetActive(active)
end

function UIBattle:SetBattleCanvasRaycast(active)
  self.ui.canvasGroup.blocksRaycasts = active
end

function UIBattle:SetUltAuto(bValue)
  if self.autoUltFunc ~= nil then
    self.autoUltFunc(bValue)
    if self.autoUltMaxEnergy ~= nil then
      self.autoUltMaxEnergy(bValue)
    end
  else
    self.bCacheAutoUlt = bValue
  end
end

function UIBattle:TryClickBattlePause()
  return self:_TryTdBattlePause() or self:_TryNormalBattlePause() or self:_TryBrotatoBattlePause()
end

function UIBattle:TrySmallBattlePause()
  if self:_TryTdBattlePause() then
    local isPause = BattleUtil.IsBattleInPause()
    return isPause
  end
  local isInBrotato = BattleUtil.IsInBrotatBattle()
  if isInBrotato then
    local csBattleCtrl = cs_BattleMgr.Instance.CurBattleController
    if csBattleCtrl == nil then
      return false
    end
    if not csBattleCtrl.fsm:IsCurrentState(cs_eBattleState.Running) then
      return false
    end
  end
  if isInBrotato or self.ui.btn_PauseNormal.gameObject.activeInHierarchy and cs_InputUtility.UIClickable(self.ui.btn_PauseNormal.targetGraphic.rectTransform) then
    local isPause = BattleUtil.IsBattleInPause()
    if not isPause then
      self:_OnBattlePauseChange(true)
      return true
    end
  end
  return false
end

function UIBattle:TryCancelBattlePause()
  local isPause = BattleUtil.IsBattleInPause()
  if not isPause then
    return false
  end
  local pauseWindow = UIManager:GetWindow(UIWindowTypeID.BattlePause)
  if pauseWindow ~= nil and pauseWindow.active then
    pauseWindow:Hide()
    self:_OnBattlePauseChange(false)
    return true
  end
  local isInBrotato = BattleUtil.IsInBrotatBattle()
  if isInBrotato or self.ui.btn_PauseNormal.gameObject.activeInHierarchy and cs_InputUtility.UIClickable(self.ui.btn_PauseNormal.targetGraphic.rectTransform) then
    self:_OnBattlePauseChange(false)
    return true
  end
  return false
end

function UIBattle:_TryNormalBattlePause()
  if self.ui.btn_PauseNormal.gameObject.activeInHierarchy and cs_InputUtility.UIClickable(self.ui.btn_PauseNormal.targetGraphic.rectTransform) then
    self:_OnClickSetting()
    return true
  end
  return false
end

function UIBattle:_TryBrotatoBattlePause()
  if BattleUtil.IsInBrotatBattle() and self.ui.btn_Setting.gameObject.activeInHierarchy and cs_InputUtility.UIClickable(self.ui.btn_Setting.targetGraphic.rectTransform) then
    self:_OnClickSetting()
    return true
  end
  return false
end

function UIBattle:_TryTdBattlePause()
  if self.ui.btn_Pause.gameObject.activeInHierarchy and cs_InputUtility.UIClickable(self.ui.btn_Pause.targetGraphic.rectTransform) then
    self:__OnClickPauseTd()
    return true
  end
  return false
end

function UIBattle:__OnClickPauseTd()
  self:_OnBattlePauseChange(true)
end

function UIBattle:_OnClickPauseNormal()
  local isPause = BattleUtil.IsBattleInPause()
  self:_OnBattlePauseChange(not isPause)
end

function UIBattle:_OnBattlePauseChange(pause)
  if self.pauseFunc ~= nil then
    self.pauseFunc(pause)
  end
  local stateInfoWin = UIManager:GetWindow(UIWindowTypeID.DungeonStateInfo)
  self.ui.btn_HideUI.gameObject:SetActive(not pause and self.__isShowHideUIBtn)
  if pause then
    AudioManager:PlayAudioById(1081)
    local win = UIManager:GetWindow(UIWindowTypeID.BattleCrazyMode)
    if win ~= nil then
      win:OnBattlePause()
    end
    if BattleUtil.IsInTDBattle() then
      self:_ShowBattlePauseWin()
    else
      self.ui.obj_pauseNode:SetActive(true)
      if stateInfoWin then
        stateInfoWin:PlayPopChipList()
      end
    end
  else
    if not BattleUtil.IsInTDBattle() then
      self.ui.obj_pauseNode:SetActive(false)
      if stateInfoWin then
        stateInfoWin:PlayPushChipList()
      end
    end
    local win = UIManager:GetWindow(UIWindowTypeID.BattleCrazyMode)
    if win ~= nil then
      win:OnBattleContinue()
    end
  end
  self.ui.img_PauseNormalIcon:SetIndex(pause and 1 or 0)
end

function UIBattle:_ShowBattlePauseWin()
  UIManager:ShowWindowAsync(UIWindowTypeID.BattlePause, function(win)
    if win == nil then
      return
    end
    win:InitBattlePause(function()
      AudioManager:PlayAudioById(1082)
      if WarChessManager:GetIsInWarChess() then
        WarChessManager:TryExitWCBattle()
        return
      end
      BattleDungeonManager:RetreatDungeon()
    end, function()
      BattleDungeonManager:RestartDungeon()
    end, function()
      self:_OnBattlePauseChange(false)
    end)
  end)
end

function UIBattle:_OnClickSetting()
  self:_ShowBattlePauseWin()
  local isPause = BattleUtil.IsBattleInPause()
  if not isPause then
    self:_OnBattlePauseChange(true)
  end
end

function UIBattle:__OnClickSpeedUP()
  if self.isSpeedUnlock then
    self.curSpeedIndex = self.curSpeedIndex % #self.ui.speedArray + 1
    local speed = self.ui.speedArray[self.curSpeedIndex]
    if self._userDataCfg ~= nil then
      self._userDataCfg:SetBattleSpeed(self.curSpeedIndex)
    end
    self.ui.img_Speed:SetIndex(self.curSpeedIndex - 1)
    self.ui.tex_Speed:SetIndex(self.curSpeedIndex - 1)
    self:OnSpeedUpChange(speed)
  end
end

function UIBattle:OnSpeedUpChange(curSpeed)
  if self.speedUpFunc ~= nil then
    self.speedUpFunc(curSpeed)
  end
end

function UIBattle:__OnAutoBattleClick(value)
  if self._userDataCfg ~= nil and not self._isTempAuto then
    self._userDataCfg:SetIsAutoBattle(value)
  end
  self.ui.img_Auto:SetIndex(value and 1 or 0)
  self:OnAutoBattleChange(value)
end

function UIBattle:OnAutoBattleChange(value)
  if self.autoBattleFunc ~= nil then
    self.autoBattleFunc(value)
  end
  if not self.isOpenAutoUlt then
    local isAutoBattleMode = false
    if BattleDungeonManager:InBattleDungeon() then
      isAutoBattleMode = BattleDungeonManager.autoCtrl:IsEnbaleDungeonAutoMode()
    end
    if isAutoBattleMode and self.autoUltFunc ~= nil then
      self.autoUltFunc(value)
      if self.autoUltMaxEnergy ~= nil then
        self.autoUltMaxEnergy(value)
      end
    end
  end
end

function UIBattle:OnBtnOverclockClicked()
  self:HideMonsterOrNeutralRoleInfo()
  ExplorationManager.epCtrl.overclockCtrl:ShowEpOverclockUI(true)
end

function UIBattle:SetOverclockHighlight(active)
  self.ui.fx_Overclock:SetActive(active)
end

function UIBattle:OnBtnRepickChip()
  if self._isTempAuto then
    return
  end
  self:HideMonsterOrNeutralRoleInfo()
  if BattleDungeonManager:InBattleDungeon() and BattleDungeonManager.dungeonCtrl:DungeonAbleSelectChip() then
    BattleDungeonManager.dungeonCtrl:DungeonRestartSelectChip()
  end
end

function UIBattle:__OnClickEnterFmt()
  if BattleDungeonManager.dunInterfaceData == nil then
    return
  end
  self:EndChipEft()
  local fromModule = BattleDungeonManager.dunInterfaceData:GetDgItfFmtFromModule()
  if fromModule == nil then
    error("fromModule == nil")
    return
  end
  local moduleId = FormationUtil.GetModuleIdByFmtFromModule(fromModule)
  if moduleId == nil then
    return
  end
  
  local function enterFunc()
    UIManager:HideWindow(UIWindowTypeID.Battle)
    UIManager:HideWindow(UIWindowTypeID.BattleSkillModule)
    UIManager:HideWindow(UIWindowTypeID.DungeonStateInfo)
    UIManager:HideWindow(UIWindowTypeID.EpChipSuit)
    UIManager.csUIManager:HideWindow(typeof(CS.UI_CharacterInfoWindow))
    self.cs_battleCtrl.fsm:ChangeState(CS.eBattleState.End)
  end
  
  local function exitFunc(fmtId)
    local saveUserData = PersistentManager:GetDataModel(PersistentConfig.ePackage.UserData)
    saveUserData:SetLastBattleDeployFmtId(moduleId, fmtId)
    UIManager:ShowWindowOnly(UIWindowTypeID.Battle)
    UIManager:ShowWindowOnly(UIWindowTypeID.BattleSkillModule)
    UIManager:ShowWindowOnly(UIWindowTypeID.DungeonStateInfo)
    UIManager:ShowWindowOnly(UIWindowTypeID.EpChipSuit)
    UIManager.csUIManager:ShowWindow(typeof(CS.UI_CharacterInfoWindow))
    self.cs_battleCtrl:RestartBattle()
    local curBattleSceneCtrl = BattleUtil.GetCurSceneCtrl()
    curBattleSceneCtrl:DeleteChangeEpHeroOldModel()
  end
  
  local fmtCtrl = ControllerManager:GetController(ControllerTypeId.Formation, true)
  local stageId, startBattleFunc
  local lastFmtId = PersistentManager:GetDataModel(PersistentConfig.ePackage.UserData):GetLastBattleDeployFmtId(moduleId)
  fmtCtrl:ResetFmtCtrlState()
  fmtCtrl:GetNewEnterFmtData():SetFmtCtrlBaseInfo(fromModule, stageId, lastFmtId):SetFmtCtrlCallback(enterFunc, exitFunc, startBattleFunc):SetFmtCtrlIsInBattleFmt(true)
  fmtCtrl:EnterFormation()
end

function UIBattle:__OnClickBattleStart()
  UIManager:HideWindow(UIWindowTypeID.TDProcessView)
  if BattleUtil.IsInTDBattle() then
    self:OnTDBattleStart()
    return
  end
  if self.getDeployAliveRoleCount ~= nil then
    local roleNum = self.getDeployAliveRoleCount()
    if roleNum <= 0 then
      cs_MessageCommon.ShowMessageTipsWithErrorSound(ConfigData:GetTipContent(TipContent.Battle_noBattleRole))
    else
      if BattleUtil.IsBattleEnableFormation() then
        PersistentManager:SaveModelData(PersistentConfig.ePackage.UserData)
      end
      BattleUtil.TryRunAfterClickBattleCallback(function()
        self:RealStartBattle()
      end)
    end
  end
end

function UIBattle:OnTDBattleStart()
  self:RealStartBattle()
end

function UIBattle:RealStartBattle()
  UIManager:HideWindow(UIWindowTypeID.EpChipSuit)
  if self.startBattleFunc ~= nil and self.battleController.LoadedBattleMapObj then
    self.startBattleFunc()
    AudioManager:PlayAudioById(1000)
    local stateInfoWin = UIManager:GetWindow(UIWindowTypeID.DungeonStateInfo)
    if stateInfoWin then
      stateInfoWin:PlayPushChipList()
    end
  end
  self.gameplayScore:TryInitSpBattleRewardBar()
end

function UIBattle:HideRetreatAndCampBondBtn()
  self.ui.btn_Retreat.gameObject:SetActive(false)
end

function UIBattle:__OnClickBreakDeploy()
  if self.savaDeployFunc ~= nil then
    self.savaDeployFunc(true)
    self:__BreakBattle()
  end
end

function UIBattle:__BreakBattle()
  if self.breakBattleFunc ~= nil then
    self.breakBattleFunc()
  end
end

function UIBattle:GetBattleCstNode()
  return self.btnCstItem
end

function UIBattle:GetBattleCmderSkillByIndex(index)
  return self.btnCstItem:GetCmderSkillItemByIndex(index)
end

function UIBattle:TryShowCstChange()
  if not BattleUtil.IsAllowCstChangeShowMoudle() then
    self.btnCstItem:Hide()
    return
  end
  local dynPlayer = BattleUtil.GetCurDynPlayer()
  local dynFairyData = dynPlayer:GetDynFairyData()
  local curCSTId = dynPlayer:GetCSTId()
  local isFixedCst = BattleUtil.TryGetFixedCstSkills()
  self.btnCstItem:Show()
  if isFixedCst then
    local skills = {}
    for i, data in ipairs(dynPlayer.playerOriginSkillList) do
      table.insert(skills, data.dataId)
    end
    table.sort(skills)
    self.btnCstItem:RefreshCstByIdAndList(curCSTId, skills, isFixedCst, dynFairyData)
    return
  end
  local cstSavingDataDic = dynPlayer:GetCSTDic()
  local cstTreeData
  local list = {}
  for treeId, treeCfg in ipairs(ConfigData.commander_skill) do
    local cstData
    local cstSavingData = cstSavingDataDic[treeId]
    if cstSavingData == nil then
      cstSavingData = CSTUtil.GetDefaultSavingData(treeId)
    end
    cstData = CSTData.New(cstSavingData, dynFairyData)
    if curCSTId == treeId then
      cstTreeData = cstData
    elseif curCSTId == 0 and cstTreeData == nil then
      error("编队指挥官保底处理--请检查")
      local skills = {}
      for i, data in ipairs(dynPlayer.playerOriginSkillList) do
        table.insert(skills, data.dataId)
      end
      table.sort(skills)
      cstSavingData = CSTUtil.GetSavingData4OldMsg(skills)
      if cstSavingData ~= nil then
        cstData = CSTData.New(cstSavingData, dynFairyData)
      end
      cstTreeData = cstData
    end
    table.insert(list, cstData)
  end
  self.btnCstItem:RefreshCstByTreeInfo(cstTreeData, list)
end

function UIBattle:CloseCstChange()
  self.btnCstItem:Hide()
end

function UIBattle:OnClickCstItem(cstTreeData, cstDataList)
  local isFixedCst = BattleUtil.TryGetFixedCstSkills()
  if isFixedCst then
    cs_MessageCommon.ShowMessageTipsWithErrorSound(ConfigData:GetTipContent(TipContent.CstFixed))
    return
  end
  UIManager:HideWindow(UIWindowTypeID.EpChipSuit)
  self:HideMonsterOrNeutralRoleInfo()
  local cstCtrl = ControllerManager:GetController(ControllerTypeId.CommanderSkill, true)
  cstCtrl:InitCmdSkillCtrl(cstTreeData, cstDataList, self.__OnSendCstChange, self._SaveCftChangeFunc)
end

function UIBattle:_SaveCftChange(cstDataList, selectedTreeId)
  local dynPlayer = BattleUtil.GetCurDynPlayer()
  local msgDic = {}
  local curCSTData
  for key, cstData in pairs(cstDataList) do
    local cstId = cstData:GetCSTTreeId()
    if cstId == selectedTreeId then
      curCSTData = cstData
    end
    msgDic[cstId] = cstData:GetCSTSavingData()
  end
  local newCstId = curCSTData:GetCSTTreeId()
  local newSkills = curCSTData:GetUsingCmdSkillList()
  local isChange = false
  if dynPlayer:GetCSTId() ~= newCstId then
    isChange = true
  else
    local oldSkillDis = {}
    for i, dynSkillData in ipairs(dynPlayer.playerOriginSkillList) do
      oldSkillDis[dynSkillData.dataId] = true
    end
    if dynPlayer.playerExtraSkillDic ~= nil then
      for skillId, skillLevel in pairs(dynPlayer.playerExtraSkillDic) do
        oldSkillDis[skillId] = nil
      end
    end
    for i, skillId in ipairs(newSkills) do
      if oldSkillDis[skillId] == nil then
        isChange = true
        break
      end
    end
  end
  if not isChange then
    return
  end
  
  local function networkCallback()
    dynPlayer:UpdatePlayerSkillInBattke(msgDic, newCstId)
    local isFixedCst = BattleUtil.TryGetFixedCstSkills()
    local dynFairyData = dynPlayer:GetDynFairyData()
    self.btnCstItem:RefreshCstByIdAndList(newCstId, newSkills, isFixedCst, dynFairyData)
  end
  
  if BattleUtil.IsBattleEnableFormation() then
    local fromModule = BattleDungeonManager.dunInterfaceData:GetDgItfFmtFromModule()
    if fromModule == nil then
      error("fromModule == nil")
      return
    end
    local moduleId = FormationUtil.GetModuleIdByFmtFromModule(fromModule)
    local lastFmtId = PersistentManager:GetDataModel(PersistentConfig.ePackage.UserData):GetLastBattleDeployFmtId(moduleId)
    local fmtData = PlayerDataCenter.formationDic[lastFmtId]
    fmtData:ModifyCSTData(cstDataList, selectedTreeId)
    local skillNet = NetworkManager:GetNetwork(NetworkTypeID.CommanderSkill)
    skillNet:CS_COMMANDSKILL_SaveFromFormation(fmtData, function()
      networkCallback()
      if fmtData ~= nil then
        fmtData:ModifyCSTData(cstDataList, selectedTreeId)
      end
    end)
  elseif BattleDungeonManager:InBattleDungeon() then
    local formationData = BattleDungeonManager:GetFormation()
    if formationData == nil then
      return
    end
    formationData:ModifyCSTData(cstDataList, selectedTreeId)
    local skillNet = NetworkManager:GetNetwork(NetworkTypeID.CommanderSkill)
    skillNet:CS_COMMANDSKILL_SaveFromFormation(formationData, function()
      networkCallback()
      formationData:ModifyCSTData(cstDataList, selectedTreeId)
    end)
  elseif ExplorationManager:GetIsInWeeklyChallenge() then
    local exploraNet = NetworkManager:GetNetwork(NetworkTypeID.Exploration)
    exploraNet:CS_EXPLORATION_BATTLE_RefreshCommandSkillTree(msgDic, selectedTreeId, networkCallback)
  else
    local exploraNet = NetworkManager:GetNetwork(NetworkTypeID.Exploration)
    exploraNet:CS_EXPLORATION_BATTLE_RefreshCommandSkillTree(msgDic, selectedTreeId, networkCallback)
  end
end

function UIBattle:OnSendCstChange()
  UIManager:ShowWindowOnly(UIWindowTypeID.EpChipSuit)
end

function UIBattle:StartChipEft()
  self._chipEftDic = nil
  if self.deployCsHeroList == nil then
    return
  end
  self.deployChipEftPool:HideAll()
  local dynPlayer = BattleUtil.GetCurDynPlayer()
  if dynPlayer == nil then
    return
  end
  self._chipEftDic = {}
  local dungeonStateUI = UIManager:GetWindow(UIWindowTypeID.DungeonStateInfo)
  if not (dungeonStateUI ~= nil and dungeonStateUI.active) or not dungeonStateUI.chipList.active then
    return
  end
  for i = 1, self.deployCsHeroList.Count do
    local csCharactor = self.deployCsHeroList[i - 1]
    local dynHero = csCharactor.character
    local ownedChips = dynHero:GetOwnedChips()
    if ownedChips ~= nil and not table.IsEmptyTable(ownedChips) then
      local skills = {}
      for chipData, _ in pairs(ownedChips) do
        if chipData.chipBattleData.skillDataList ~= nil and #chipData.chipBattleData.skillDataList > 0 then
          for _, skillData in ipairs(chipData.chipBattleData.skillDataList) do
            if skillData:GetSkillTag() == eSkillTag.passiveSkill then
              table.insert(skills, skillData)
            end
          end
        end
      end
      if #skills ~= 0 then
        local item = self.deployChipEftPool:GetOne()
        local lsObject = csCharactor.lsObject
        if lsObject ~= nil and not IsNull(lsObject.transform) then
          local lineStartPos = dungeonStateUI.chipList:GetEftLineStartPos()
          lineStartPos = self.transform:InverseTransformPoint(lineStartPos)
          item:StartEft(skills, lineStartPos, lsObject, self.resLoader)
          self._chipEftDic[dynHero.dataId] = item
        end
      end
    end
  end
  if 0 < #self.deployChipEftPool.listItem then
    dungeonStateUI.chipList:PlayDepolyEft()
  end
end

function UIBattle:ResetSkillEft()
  if self._chipEftDic == nil or self.deployCsHeroList == nil then
    return
  end
  for i = 1, self.deployCsHeroList.Count do
    local csCharactor = self.deployCsHeroList[i - 1]
    local dynHero = csCharactor.character
    local item = self._chipEftDic[dynHero.dataId]
    local ownedChips = dynHero:GetOwnedChips()
    if ownedChips == nil or table.count(ownedChips) == 0 then
      if item ~= nil then
        self._chipEftDic[dynHero.dataId] = nil
        self.deployChipEftPool:HideOne(item)
      end
    else
      local skills = {}
      for chipData, _ in pairs(ownedChips) do
        if chipData.chipBattleData.skillDataList ~= nil and 0 < #chipData.chipBattleData.skillDataList then
          for _, skillData in ipairs(chipData.chipBattleData.skillDataList) do
            if skillData:GetSkillTag() == eSkillTag.passiveSkill then
              table.insert(skills, skillData)
            end
          end
        end
      end
      if #skills == 0 then
        if item ~= nil then
          self._chipEftDic[dynHero.dataId] = nil
          self.deployChipEftPool:HideOne(item)
        end
      elseif item ~= nil then
        item:ResetSkillsEft(skills)
      else
        local item = self.deployChipEftPool:GetOne()
        local lsObject = csCharactor.lsObject
        if lsObject ~= nil and not IsNull(lsObject.transform) then
          item:ResetEftState(skills, lsObject, self.resLoader)
          item:PlayHeroChipShow()
          self._chipEftDic[dynHero.dataId] = item
        end
      end
    end
  end
end

function UIBattle:EndChipEft()
  TimerManager:StopTimer(self._StartChipEftTimer)
  self.deployChipEftPool:HideAll()
  local dungeonStateUI = UIManager:GetWindow(UIWindowTypeID.DungeonStateInfo)
  if dungeonStateUI ~= nil and dungeonStateUI.active and dungeonStateUI.chipList.active then
    dungeonStateUI.chipList:StopDepolyEft()
    dungeonStateUI:StopAllGetChipAni()
  end
end

function UIBattle:__OnChipChange()
  self:ResetSkillEft()
end

function UIBattle:__OnClickRetreat()
  if ExplorationManager:IsInExploration() and ExplorationManager.epCtrl.battleCtrl:IsBattleBeforeRunning() then
    ExplorationManager.epCtrl.autoCtrl:DisableEpAutoMode()
  end
  local isDungeonAuto = BattleDungeonManager:InBattleDungeon() and BattleDungeonManager.autoCtrl:IsEnbaleDungeonAutoMode()
  if isDungeonAuto then
    BattleDungeonManager.autoCtrl:AutoBreak(true)
  end
  UIManager:ShowWindowAsync(UIWindowTypeID.BattlePause, function(win)
    if win == nil then
      return
    end
    win:InitBattlePause(function()
      if WarChessManager:GetIsInWarChess() then
        WarChessManager:TryExitWCBattle()
      end
      BattleDungeonManager:RetreatDungeon()
      AudioManager:PlayAudioById(1082)
    end, nil, function()
      if isDungeonAuto then
        BattleDungeonManager.autoCtrl:AutoBreak(false)
      end
    end)
    win:SetAboutBattleUIActive(false)
  end)
end

function UIBattle:ShowHeroRoleInfo(hero)
  if self.isShowEnemyDetail then
    self:HideMonsterOrNeutralRoleInfo()
  end
  self.isShowingHeroInfo = true
  UIManager:GetWindow(UIWindowTypeID.DungeonStateInfo):ShowHero(hero)
end

function UIBattle:ShowHeroRoleInfoBattleRunning(entity)
  if self.isShowEnemyDetail then
    self:HideMonsterOrNeutralRoleInfo()
  end
  local win = UIManager:ShowWindow(UIWindowTypeID.DungeonInfoDetail)
  win:ShowHeroDetailInBattle(entity)
  win:SetSwitchBtnActive(false)
end

function UIBattle:ShowMonsterOrNeutralRoleInfoBattleRunning(entity)
  local heroCopy = DeepCopy(entity.character)
  heroCopy:CopyAttrFromBattleCharacterEntity(entity)
  self:ShowMonsterOrNeutralRoleInfo(entity.battleRoleView, heroCopy)
end

function UIBattle:ShowSummonRoleInfoBattleRunning(entity)
  local dynSummoner = entity.summoner
  local resCfg = ConfigData.resource_model[dynSummoner.srcId]
  if resCfg == nil then
    return
  end
  if self.__lastEntityView ~= nil and self.__lastEntityView ~= entity.battleRoleView then
    self.__lastEntityView:ShowViewTag(false)
    self.__lastEntityView = nil
  end
  self.isShowEnemyDetail = true
  UIManager:ShowWindowAsync(UIWindowTypeID.BattleEnemyDetail, function(window)
    self.__lastEntityView = entity.battleRoleView
    window:InitBattleSummonerDetail(dynSummoner, entity)
    self.__lastEntityView:ShowViewTag(true)
  end)
  UIUtil.CreateNewTopStatusData(self):SetTopStatusBackAction(self.BackAction):PushTopStatusDataToBackStack(true)
end

function UIBattle:ShowMonsterOrNeutralRoleInfo(battleCharacterView, monsterOrNeutral)
  if self.__lastEntityView ~= nil and self.__lastEntityView ~= battleCharacterView then
    self.__lastEntityView:ShowViewTag(false)
    self.__lastEntityView = nil
  end
  if not self.onEnemyDetailUnlock then
    return
  end
  if self.battleCharacterViewList ~= nil then
    for _, view in ipairs(self.battleCharacterViewList) do
      view:ShowNewArrow(false)
    end
    self.battleCharacterViewList = nil
  end
  local isNew = battleCharacterView.isNew
  if isNew then
    self.battleCharacterViewList = {}
    table.insert(self.battleCharacterViewList, battleCharacterView)
    local enemyList = ExplorationManager.epCtrl.battleCtrl.battleCtrl.EnemyTeamController.battleOriginRoleList
    for i = 0, enemyList.Count - 1 do
      local enemy = enemyList[i]
      if enemy.roleDataId == monsterOrNeutral.dataId then
        table.insert(self.battleCharacterViewList, enemy.battleRoleView)
      end
    end
    local neutralList = ExplorationManager.epCtrl.battleCtrl.battleCtrl.NeutralTeamController.battleOriginRoleList
    for i = 0, neutralList.Count - 1 do
      local neutral = neutralList[i]
      if neutral.roleDataId == monsterOrNeutral.dataId then
        table.insert(self.battleCharacterViewList, neutral.battleRoleView)
      end
    end
  end
  self.isShowEnemyDetail = true
  UIManager:ShowWindowAsync(UIWindowTypeID.BattleEnemyDetail, function(window)
    if self.isShowEnemyDetail then
      battleCharacterView:ShowViewTag(true)
      self.__lastEntityView = battleCharacterView
      window:InitBattleEnemyDetail(monsterOrNeutral, isNew, battleCharacterView.characterEntity)
    else
      battleCharacterView:ShowViewTag(false)
      window:Hide()
    end
  end)
  UIUtil.CreateNewTopStatusData(self):SetTopStatusBackAction(self.BackAction):PushTopStatusDataToBackStack(true)
end

function UIBattle:HideHeroRoleInfo()
  self.isShowingHeroInfo = false
end

function UIBattle:BackAction()
  if not self.onEnemyDetailUnlock then
    return
  end
  if self.battleCharacterViewList ~= nil then
    for _, view in ipairs(self.battleCharacterViewList) do
      view:ShowNewArrow(false)
    end
    self.battleCharacterViewList = nil
  end
  self.isShowEnemyDetail = false
  if self.__lastEntityView ~= nil then
    self.__lastEntityView:ShowViewTag(false)
    self.__lastEntityView = nil
  end
  UIManager:HideWindow(UIWindowTypeID.BattleEnemyDetail)
end

function UIBattle:HideMonsterOrNeutralRoleInfo()
  UIUtil.OnClickBackByUiTab(self)
end

function UIBattle:IsRoleInfoShow()
  return self.isShowingHeroInfo or self.isShowEnemyDetail
end

function UIBattle:SetEpChipListUIActive(active)
  if active then
    local win = UIManager:GetWindow(UIWindowTypeID.DungeonStateInfo)
    if win ~= nil then
      win:Show()
      win:SetHeroListActive(false)
      win:SetHeroListHpBar(false)
      win:SetMoneyActive(false)
      win:SetSaveMoneyActive(false)
      win:SetRareMoneyActive(false)
    end
  else
    local win = UIManager:GetWindow(UIWindowTypeID.DungeonStateInfo)
    if win ~= nil then
      win:SetHeroListActive(true)
      win:SetHeroListHpBar(true)
      win:SetMoneyActive(true)
      win:SetSaveMoneyActive(true)
      win:SetRareMoneyActive(true)
      win:Hide()
    end
  end
end

function UIBattle:OnEnemyDetailUnlock(active)
  self.onEnemyDetailUnlock = active
end

function UIBattle:TryRefreshAutoInfo()
  if not BattleDungeonManager:InBattleDungeon() or not BattleDungeonManager.autoCtrl:IsEnbaleDungeonAutoMode() then
    self.ui.battleAutoNow:SetActive(false)
    return
  end
  local battleCount = BattleDungeonManager.autoCtrl:GetBattleCount() + 1
  local totalCount = BattleDungeonManager.autoCtrl:GetTotalDungeonAutoCount()
  self.ui.battleAutoNow:SetActive(true)
  self.ui.tex_Count_BattleAuto.text = string.format("%d/%d", battleCount, totalCount)
end

function UIBattle:OnHide()
  base.OnHide(self)
  self:EndChipEft()
  local win = UIManager:GetWindow(UIWindowTypeID.BattleCrazyMode)
  if win ~= nil then
    win:Hide()
  end
end

function UIBattle:__CallWaveComing(index)
  if self.ui.img_WaveWarning ~= nil and self.ui.tween_WaveWarning ~= nil and self.ui.text_WaveWarning ~= nil then
    self.ui.img_WaveWarning:SetIndex(index)
    self.ui.text_WaveWarning:SetIndex(index)
    self.ui.tween_WaveWarning:DORestart()
  end
end

function UIBattle:ShowCurLvInfoUI()
  self.ui.obj_currLevel.gameObject:SetActive(false)
  self:_ShowCurEpProgress()
  if ExplorationManager:IsInExploration() then
    self.ui.obj_currLevel.gameObject:SetActive(true)
    self.ui.tex_LvName:SetIndex(0)
    self.ui.tex_Level.text = tostring(ExplorationManager:GetCurLevelIndex() + 1) .. "/" .. tostring(ExplorationManager:GetLevelCount())
    return
  end
  local towerLvName, LvNum = BattleUtil.TryGetDungeonLvTowerLvInfo()
  if towerLvName ~= nil then
    self.ui.obj_currLevel.gameObject:SetActive(true)
    self.ui.tex_LvName:SetIndex(1, towerLvName)
    self.ui.tex_Level.text = tostring(LvNum)
  end
end

function UIBattle:_ShowCurEpProgress()
  self.ui.obj_curDefRate:SetActive(false)
  if not ExplorationManager:IsInExplorationTD() and not BattleUtil.IsSpecialTDMode() and not ExplorationManager:IsInExplorationLight() and not BattleUtil.IsInGuardBattle() then
    return
  end
  local dynPlayer = BattleUtil.GetCurDynPlayer()
  local opDetail = dynPlayer:GetOperatorDetail()
  if opDetail ~= nil then
    local x, y = ExplorationManager.Coordination2Pos(opDetail.curPostion)
    local maxDepth = ExplorationManager.epCtrl.mapData.maxMapColNumber
    if maxDepth ~= nil then
      self.ui.obj_curDefRate:SetActive(true)
      local strX = tostring(x)
      local strMaxDepth = tostring(maxDepth)
      self.ui.tex_curDefRate.text = strX .. "/" .. strMaxDepth
    end
  end
end

function UIBattle:__OnClickHideUIState()
  if self.battleUIStateFunc ~= nil then
    self.battleUIStateFunc(false)
  end
  self.gameplayScore:Hide()
  UIManager:HideWindow(UIWindowTypeID.BattleDPS)
  UIManager:HideWindow(UIWindowTypeID.BattleCrazyMode)
  UIManager:HideWindow(UIWindowTypeID.BattleSkillModule)
  UIManager:HideWindow(UIWindowTypeID.DungeonStateInfo)
  self.ui.btn_HideUI.gameObject:SetActive(false)
  self.ui.btn_ShowUI.gameObject:SetActive(true)
  self.ui.frame:SetActive(false)
end

function UIBattle:__OnClickShowUIState()
  if self.battleUIStateFunc ~= nil then
    self.battleUIStateFunc(true)
  end
  self.gameplayScore:Show()
  UIManager:ShowWindow(UIWindowTypeID.BattleDPS)
  UIManager:ShowWindow(UIWindowTypeID.BattleCrazyMode)
  UIManager:ShowWindow(UIWindowTypeID.BattleSkillModule)
  UIManager:ShowWindow(UIWindowTypeID.DungeonStateInfo)
  self.ui.btn_HideUI.gameObject:SetActive(self.__isShowHideUIBtn)
  self.ui.btn_ShowUI.gameObject:SetActive(false)
  self.ui.frame:SetActive(true)
end

function UIBattle:OnClickHealing()
  if self.isShowEnemyDetail then
    self:HideMonsterOrNeutralRoleInfo()
  end
  local spitemCfg = WarChessSeasonManager:GetWcSSpItemConfigByLogicType(eWarChessEnum.WCSpecialItemLogicType.healing)
  local WarchessEventUtil = require("Game.WarChess.WarchessEventUtil")
  WarchessEventUtil:ApplyWcEventInBattle(spitemCfg.ex_arg1[1], true, function()
    local wcCtrl = WarChessManager:GetWarChessCtrl()
    wcCtrl.battleCtrl:SetWCUseedEventSystemInbattle()
  end)
end

function UIBattle:OnClickFacScore()
  UIManager:ShowWindowAsync(UIWindowTypeID.ChipScoreShow, function(win)
    if win == nil then
      return
    end
    UIManager:HideWindow(UIWindowTypeID.BattleEnemyDetail)
    win:InitChipScoreShow()
  end)
end

function UIBattle:OnDelete()
  TimerManager:StopTimer(self._StartChipEftTimer)
  MsgCenter:RemoveListener(eMsgEventId.WaveComing, self.__callWaveComingAction)
  MsgCenter:RemoveListener(eMsgEventId.OnEpChipListChange, self.__OnChipChangeEvent)
  UIManager:DeleteWindow(UIWindowTypeID.BattleCrazyMode)
  if self.gameplayScore ~= nil then
    self.gameplayScore:OnDelete()
    self.gameplayScore = nil
  end
  self.deployCsHeroList = nil
  if self._userDataCfg ~= nil then
    PersistentManager:SaveModelData(PersistentConfig.ePackage.UserData)
  end
  local stateInfoWin = UIManager:GetWindow(UIWindowTypeID.DungeonStateInfo)
  if stateInfoWin then
    stateInfoWin:PlayPopChipList()
  end
  self.deployChipEftPool:DeleteAll()
  UIManager:DeleteWindow(UIWindowTypeID.BattleEnemyDetail)
  if self.__autoSwitchNode ~= nil then
    self.__autoSwitchNode:Delete()
  end
  self.breakBattleFunc = nil
  self.__lastEntityView = nil
  self.cs_battleCtrl = nil
  self.startBattleFunc = nil
  self.savaDeployFunc = nil
  self.getDeployAliveRoleCount = nil
  self.pauseFunc = nil
  self.speedUpFunc = nil
  self.autoBattleFunc = nil
  self.autoUltFunc = nil
  self.autoUltMaxEnergy = nil
  self.battleController = nil
  base.OnDelete(self)
end

return UIBattle
