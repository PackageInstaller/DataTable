local BP = bc.BattleProperty
local typeof = _ENV.typeof
local Vector3 = CS.UnityEngine.Vector3
local Button = CS.UnityEngine.UI.Button
local Animator = CS.UnityEngine.Animator
local PanelShowParamHash = Animator.StringToHash("start")
local PanelHideParamHash = Animator.StringToHash("end")
local CanvasGroup = typeof(CS.UnityEngine.CanvasGroup)
local TypeofUIAnimationController = typeof(CS.Z1Client.UIAnimationController)
local MAX_STAR_NUM = 3
local DIMENTION_BOUT_BUTTON_DELAY_TIME = 0.2
local GetRealtimeSinceStartup = CS.Framework.TimeUtil.GetRealtimeSinceStartup
local BattlePanel, Super = System.NewClass("BattlePanel", UIBasePanel, IBattlePanel, IBattleCardUIDelegate)
BattlePanel.uiResCls = UI_Battle_Panel_DbgResource

function BattlePanel:ctor()
  Super.ctor(self)
  self.winCamp = Vue.ref(bc.BattleCamp.None)
  self.isUIVisible = Vue.ref(true)
  self.tickBoutDamageChangeList = {}
  self.curDamage = 0
  self._lastCurDamage = 0
  self.banClick = Vue.ref(not bg.battleDataCenter.isRecover)
  bg.battlePanel = self
  bg.SendBattleEvent(rc.BattleEvent.BattleUIOpen, self.__name)
end

function BattlePanel:OnBind(binder)
  self.ui.Group_Damage:SetActive(false)
  self.binder = binder
  self.root = self.ui.uiNode
  self.boutAnimUI = binder:BindComponent(BattlePanelBoutAnimUI(self, self.ui.uiNode))
  self.cardUI = binder:BindComponent(BattlePanelCardUI(self, bg.battleRender.cardMgr, nil, self))
  self.stageUI = binder:BindComponent(BattlePanelStageUI(self, self.ui.uiNode))
  binder:BindComponent(BattlePanelRightTopBtnUI(self, self.ui.uiNode))
  local boutMgr = bg.battleRender.boutMgr
  local endTurnBtn = self.ui.Btn_Battle_EndOfTurn:GetComponent(typeof(Button))
  self.endTurnBtn = endTurnBtn
  self.energyAniCtr = self.ui.Group_Cost:GetComponent(TypeofUIAnimationController)
  self:BindSpeedBtn(binder)
  self:BindEndBoutBtn(binder)
  binder:BindTimer(0.1, 0, nil, System.fn(self, self.BindEnergyCostText))
  self:BindRespawnEffect(binder)
  self:BindMonsterShowTips(binder)
  self:BindKeeperSkill(binder)
  self:BindAutoBattle(binder)
  self.binder:BindToVisible(self.ui.Image_Mask_Ban_Click, function()
    return self.banClick.value
  end)
  binder:BindToRaw(function(_, nowVal, _)
    bg.battleScene.cameraComp:OnChangeBoutCamp()
  end, function()
    local phaseMatch = bg.battleDataCenter.boutData.phase == bc.BoutPhase.Action
    return phaseMatch and boutMgr:GetCamp() == bc.BattleCamp.Camp1
  end)
  binder:BindToRaw(function(_, isMyBoutBegin, _)
    if isMyBoutBegin then
      self.curDamage = 0
      self._lastCurDamage = 0
    end
  end, function()
    local boutData = bg.battleDataCenter.boutData
    return boutData.phase == bc.BoutPhase.Begin and boutMgr:GetCamp() == bc.BattleCamp.Camp1
  end)
  binder:BindToRaw(function(_, n, _)
    self.curDamage = math.max(self.curDamage, n or 0)
    local oldDisplay = self._lastCurDamage
    self:OnBoutDamageChange(self.curDamage, oldDisplay)
    self._lastCurDamage = self.curDamage
  end, function()
    do return boutMgr.GetBoutDamage end
    return boutMgr.GetBoutDamage, boutMgr
  end)
  local ultiSkillList = bg.battleRender.ultiSkillMgr:GetAllUltiSkillDatas()
  self.ultiSkillPanel = self.binder:BindComponent(BattleAwakerHeadPanel(self.ui.uiNode, ultiSkillList))
  self.binder:BindButtonClick(self.ui.Btn_Battle_Cost, function()
    UIManager.Instance:Reopen(Urls.AlertToolTipsPanel, {tipTid = 40006}, self.ui.Group_Cost)
  end)
  self:RegisterEvents()
  self:BindRelicListView()
  binder:BindToRaw(function(binder, isExtraBout, old)
    bg.battleScene:ChangeDimensionScene(isExtraBout)
  end, function()
    return bg.battleDataCenter.boutData.isExtraBout
  end)
  if not bg.battleDataCenter.isRecover then
    self:SetUIVisible(false)
    self:HideUI(true, true)
    bg.battleScene:HideBattleUI()
  else
    bg.battleRender:PerformWithDelay(0.1, function()
      self:OnBattleRecover()
    end, self)
  end
  binder:SetText(self.ui.Text_C_Setting, LT.Text("SettingPanelTitle"))
  BattleBackTrackUtils.CheckShowBackTrackTutorial()
end

function BattlePanel:RegisterEvents()
  self.binder:BindEvent(EventMgr.Instance.ShowAwakerVoice, System.fn(self, self.ShowAwakerVoice))
  self.binder:BindEvent(EventMgr.Instance.UpdateBattleSpeed, System.fn(self, self.LoadGameSpeed))
  self.binder:BindEvent(EventMgr.Instance.BattleBottomUI, System.fn(self, self.BottomAreaVisible))
  self.binder:BindEvent(EventMgr.Instance.OnExtendedRelicNum, System.fn(self, self.OnExtendedRelicNum))
  local eventMgr = bg.battleRender.eventMgr
  eventMgr:RegisterEvent(BattleRenderEvent.BattleBegin, self.OnBattleBegin, self)
  eventMgr:RegisterEvent(BattleRenderEvent.SelectTargets, self.OnSelectTargets, self)
  eventMgr:RegisterEvent(BattleRenderEvent.ShowTips, self.OnShowTips, self)
  eventMgr:RegisterEvent(BattleRenderEvent.BattleFinish, self.OnBattleEnd, self)
  eventMgr:RegisterEvent(BattleRenderEvent.RelicEffect, self.OnRelicEffect, self)
  eventMgr:RegisterEvent(BattleRenderEvent.AddNewRelic, self.OnAddNewRelic, self)
  eventMgr:RegisterEvent(BattleRenderEvent.RemoveRelic, self.OnRemoveRelic, self)
  eventMgr:RegisterEvent(BattleRenderEvent.BattleRecover, self.OnBattleRecover, self)
  eventMgr:RegisterEvent(BattleRenderEvent.CommandResult, self.OnCommandResult, self)
  eventMgr:RegisterEvent(BattleRenderEvent.SwitchOceanModel, self.OnOceanModelChange, self)
  eventMgr:RegisterEvent(BattleRenderEvent.AfterUseCard, self.OnAfterUseCardForDamage, self)
  eventMgr:RegisterEvent(BattleRenderEvent.PlaySceneVFX, self.OnPlaySceneVFX, self)
end

function BattlePanel:OnPlaySceneVFX(data)
  local sceneVfxId = data and data.vfx
  if not sceneVfxId then
    return
  end
  local sfxConfig = bg.DT.BattleSfxConfig[sceneVfxId] or {}
  if sfxConfig.SceneMount ~= "BattlePanel" then
    return
  end
  local prefabPath = sfxConfig.FileName
  local prefab = self.binder:LoadAsset(prefabPath)
  local effGo = prefab and self.binder:Instantiate(prefab, self.ui.uiNode.transform)
  if not effGo then
    return
  end
  local animController = effGo:GetComponent(TypeofUIAnimationController)
  
  local function destroyEffect()
    if not IsNil(effGo) and self.binder then
      UIRootMgr.DestroyGameObject(effGo)
    end
  end
  
  if not animController then
    destroyEffect()
    return
  end
  local animationInfoList = animController.animationInfoList
  if not animationInfoList or 0 == animationInfoList.Count then
    destroyEffect()
    return
  end
  local clipInfo = animationInfoList[0]
  animController:PlayState(clipInfo.clip.name, function()
    destroyEffect()
  end)
end

function BattlePanel:BindRelicListView()
  self.binder:BindComponent(WorldStageRelicListView(self.ui.UI_Dbgcopy_Item_RelicList))
end

function BattlePanel:IsReady()
  return true
end

function BattlePanel:Tick(deltaTime)
  self:TickBoutDamage(deltaTime)
end

function BattlePanel:TickBoutDamage(delataTime)
  if self.tickBoutDamageChangeList and #self.tickBoutDamageChangeList > 0 and bg.battleRender.renderTime - (self.lastBoutDamageChangeTime or 0) >= bc.DamageFloatInterval then
    self.lastBoutDamageChangeTime = bg.battleRender.renderTime
    local func = table.remove(self.tickBoutDamageChangeList, 1)
    if func then
      func()
    end
  end
end

function BattlePanel:BindSpeedBtn(binder)
  if bg.isReplay then
    self.ui.Btn_GameSpeed:SetActive(false)
    return
  end
  local stageData = WorldStageManager.Instance:GetCurStageData()
  if stageData then
    local prologueStageId = DT.GetConstant("PrologueSettingButtonBlock")
    self.ui.Btn_GameSpeed:SetActive(stageData.stageId ~= prologueStageId)
  end
  self:_SetSpeedImage(binder)
  binder:BindButtonClick(self.ui.Btn_GameSpeed, function()
    local gameSpeed = MobileFileDataManager.Instance:GetPlayerFileValue(bc.BattleGameSpeedKey, 1)
    gameSpeed = 1 == gameSpeed and 2 or 1
    bg.battleRender.gameSpeed = gameSpeed
    local tipTid = 1 == gameSpeed and 10720 or 10721
    Alert.Show(tipTid)
    MobileFileDataManager.Instance:SetPlayerFileValue(bc.BattleGameSpeedKey, gameSpeed)
    MobileFileDataManager.Instance:OnSavePlayerFileInfo()
    EventMgr.Instance.UpdateBattleSpeed:Dispatch()
    self:_SetSpeedImage(binder)
  end)
end

function BattlePanel:ResumeGameSpeedAfterTL()
  if not self.ui or IsNil(self.ui.uiNode) or not bg.battleRender then
    return
  end
  if self.ui.Image_Once.activeSelf then
    bg.battleRender.gameSpeed = 1
  else
    bg.battleRender.gameSpeed = 2
  end
end

function BattlePanel:_SetSpeedImage(binder)
  local gameSpeed = MobileFileDataManager.Instance:GetPlayerFileValue(bc.BattleGameSpeedKey, 1)
  binder:SetActive(self.ui.Image_Once, 1 == gameSpeed)
  binder:SetActive(self.ui.Image_Twice, 2 == gameSpeed)
end

function BattlePanel:BindKeeperSkill()
  local keeperSkillId = bg.battleDataCenter:GetPlayerKeeperSkill()
  if not keeperSkillId then
    self.ui.KeeperSkill:SetActive(false)
    return
  end
  self.ui.KeeperSkill:SetActive(true)
  local stageData = WorldStageManager.Instance:GetCurStageData()
  local roleInfo = {}
  roleInfo.gender = bg.battleDataCenter:GetPlayerGender()
  roleInfo.name = bg.battleDataCenter:GetPlayerName()
  
  function roleInfo.GetKeeperSkillId()
    do return bg.battleDataCenter.GetPlayerKeeperSkill end
    return bg.battleDataCenter.GetPlayerKeeperSkill, bg.battleDataCenter
  end
  
  roleInfo.keeper_energy = bg.battleDataCenter:GetPlayerRoleProperty(bc.RoleProperty.keeper_energy)
  
  function roleInfo.GetLivesFunc()
    do return math.max, bg.battleRender and (bg.battleRender.lives or 1) - 1 or 0 end
    return math.max, bg.battleRender and (bg.battleRender.lives or 1) - 1 or 0, 0
  end
  
  function roleInfo.GetKeeperSkillArgs()
    do return bg.battleDataCenter.GetPlayerKeeperSkillArgs end
    return bg.battleDataCenter.GetPlayerKeeperSkillArgs, bg.battleDataCenter
  end
  
  roleInfo.keeperSkillArgs = nil
  local IsNewStageChapter = stageData and CopyDataUtils.IsNewStageChapter(stageData.stageId)
  local keeperSkillCls = IsNewStageChapter and UIBattleKeeperRoleAwakeItem or UIBattleKeeperRoleItem
  self.keeperSkillCom = self.binder:BindComponent(keeperSkillCls(self.ui.KeeperSkill, roleInfo))
end

function BattlePanel:BindEnergyCostText()
  local function changeEnergy(energy, oldEnergy)
    self.binder:SetRawText(self.ui.Text_Cost01, energy, false)
    
    if energy and oldEnergy and self.energyAniCtr then
      local anim = oldEnergy < energy and "Effect_Battle_Cost_-1_yzw_vx" or "Effect_Battle_Cost_yzw_vx"
      self.energyAniCtr:PlayState(anim)
    end
  end
  
  local energyChangeCount = 0
  self.binder:BindToRaw(function(_, energy, oldEnergy)
    energyChangeCount = energyChangeCount + 1
    bg.battleRender:PerformWithDelay((energyChangeCount - 1) * 0.5, function()
      energyChangeCount = energyChangeCount - 1
      changeEnergy(energy, oldEnergy)
    end, self)
  end, function()
    local energy = bg.battleDataCenter:GetPlayerRoleProperty(BP.energy)
    return energy
  end, true)
  self.binder:BindToText(self.ui.Text_Cost02, function()
    local baseEnergy = bg.battleDataCenter:GetPlayerRoleProperty(BP.max_energy)
    return baseEnergy
  end)
end

function BattlePanel:BindRespawnEffect()
  local stageData = WorldStageManager.Instance:GetCurStageData()
  if nil ~= stageData and stageData.respawnedNum and stageData.respawnedNum > 0 then
    self:ShowRespawn(false)
  end
end

function BattlePanel:ShowRespawn(isRespawning, callback)
  self.respawnPanel = self.respawnPanel or self.binder:BindNewComponent(self.ui.uiNode, RespawnPanel, UI_Level_Panel_RespawnResource)
  self.respawnPanel:Respawn(isRespawning, callback)
end

function BattlePanel:HideRespawn()
  if self.respawnPanel then
    self.respawnPanel.binder:teardown()
    self.respawnPanel = nil
  end
end

function BattlePanel:BindEndBoutBtn(binder)
  local playerRole = bg.battleScene:GetPlayerRole()
  binder:BindButtonClick(self.ui.Btn_Battle_EndOfTurn, System.fn(self, self.OnBtnEndTurn))
  local uName = "KeyEndTurn"
  binder:BindComponent(ShortCutComp(self.ui.Text_EndShortCut, uName, function()
    self:OnBtnEndTurn()
  end))
  binder:BindToRaw(function(_, shouldEnd)
    self.ui.Group_Normal:SetActive(shouldEnd)
  end, function()
    if self:DimensionBoutReady() then
      return false
    end
    local phaseMatch = bg.battleDataCenter.boutData.phase == bc.BoutPhase.Action
    local battleFinished = bg.battleRender.battleFinished
    local hasChoice = self:HasAvailChoice()
    return not hasChoice and phaseMatch and not playerRole:HasAnyAwakerUltiReady() and not battleFinished
  end)
  binder:BindToRaw(function(_, nVal)
    if nVal then
      self:DimensionTrun()
    else
      self:ClearDimensionTurn()
      local DimensionEndTurnAnimCtr = self.ui.UI_Vx_Battle_Chaowei_Butter:GetComponent(TypeofUIAnimationController)
      DimensionEndTurnAnimCtr:StopPlayableGraph()
      self.ui.UI_Vx_Battle_Chaowei_Butter:SetActive(false)
    end
    self.ui.Group_Unclickable:SetActive(not nVal)
  end, function()
    local isDimensionReady = self:DimensionBoutReady()
    local isUIVisible = self.isUIVisible.value
    return isDimensionReady and isUIVisible
  end)
end

function BattlePanel:HasAvailChoice()
  local availCard = bg.battleRender.cardMgr:IsHaveAvailCard()
  local availAwakerSkill = bg.battleRender:IsHaveAvailAwakerSkill()
  local availKeeperSkill = bg.battleRender:HaveAvailKeeperSkill()
  return availCard or availAwakerSkill or availKeeperSkill
end

function BattlePanel:GuideCheck_TurnCanEnd()
  if self:HasAvailChoice() then
    local event = CommonDefine.GuideBattle.GuideEndLock
    local battleId = bg.battleRender.battleTid
    EventMgr.Instance.GuideBattleEvent:Dispatch(event, battleId)
    if GuideManager.Instance:CheckIsLockBattleEndTurn() then
      Logger.Warn("[Guide]指引中有可操作的技能或手牌，所以不让跳过")
      return false
    end
  end
  return true
end

function BattlePanel:OnBtnEndTurn()
  local opMode = bg.battleDataCenter:GetOpMode()
  if opMode == rc.OpMode.Inspect or opMode == rc.OpMode.SelectHandCard then
    return
  end
  if bg.battleRender:IsInSelectCard() then
    return
  end
  if not self:GuideCheck_TurnCanEnd() then
    return
  end
  if self.isClickedBtnBout then
    return
  end
  local nowTime = GetRealtimeSinceStartup()
  if nowTime - (self._clickedBtnBoutTime or 0) <= 1 then
    return
  end
  local isBoutEnd = true
  local isUseNewExtraBout = bg.battleDataCenter:IsNewExtraBoutState()
  local dimensionBoutReady = self:DimensionBoutReady()
  if isUseNewExtraBout and dimensionBoutReady then
    isBoutEnd = false
    self.isClickedBtnBout = false
  end
  self._clickedBtnBoutTime = nowTime
  self:SetPanelAniHash(PanelHideParamHash)
  if isBoutEnd then
    EventMgr.Instance.BattleEndTurnClicked:Dispatch(bg.battleDataCenter:GetMyCamp())
    bg.battleRender.recordMgr:EnableFirstTrigger(false)
    self:ClearEndTurnDelayTimer()
    self.endTurnDelayTimer = self.binder:BindTimer(1, 0, nil, function()
      self.endTurnDelayTimer = nil
      if not bg or not bg.battleDataCenter then
        return
      end
      bg.battleDataCenter:SetRealCamp(bc.BattleCamp.Camp2)
      bg.battleDataCenter:SetIsMyBoutEnd(true)
    end)
  elseif isUseNewExtraBout and dimensionBoutReady then
    self:ClearEndTurnDelayTimer()
    self.endTurnDelayTimer = self.binder:BindTimer(1.5, 0, nil, function()
      self.endTurnDelayTimer = nil
      if not bg or not bg.battleDataCenter then
        return
      end
      self:SetPanelAniHash(PanelShowParamHash)
    end)
  end
  local msgData = {
    boutNumber = bg.battleRender.boutMgr:GetBoutNum(),
    isExtraBout = bg.battleRender.boutMgr.boutData:GetExtraBout()
  }
  if self:DimensionBoutReady() then
    bg.battleRender:SendCommand(BattleCommand.lg_ExtraBout, msgData)
  else
    bg.battleRender:SendCommand(BattleCommand.lg_BoutEnd, msgData)
  end
  AudioManager.Instance:PostSoundEvent("UI_FT_BTN_ROUNDEND_CLICK")
end

function BattlePanel:ClearEndTurnDelayTimer()
  if self.endTurnDelayTimer then
    self.binder:StopTimer(self.endTurnDelayTimer)
    self.endTurnDelayTimer = nil
  end
end

function BattlePanel:OnEndTurnFail()
  self:ClearEndTurnDelayTimer()
  self.isClickedBtnBout = false
  self:SetPanelAniHash(PanelShowParamHash)
  bg.battleDataCenter:SetRealCamp(bc.BattleCamp.Camp1)
  bg.battleRender.recordMgr:EnableFirstTrigger(true)
end

function BattlePanel:OnAfterUseCardForDamage()
  if not bg.battleDataCenter or not bg.battleDataCenter.boutData then
    return
  end
  local statsDamage = bg.battleDataCenter.boutData:GetStatsBoutDamage() or 0
  self.curDamage = math.max(self.curDamage, statsDamage)
  local oldDisplay = self._lastCurDamage
  self._lastCurDamage = self.curDamage
  if self.curDamage ~= oldDisplay then
    bg.battleRender:UnperformWithDelay(self._playCurBoutStatsDamageTimer)
    table.insert(self.tickBoutDamageChangeList, function()
      self:DoBoutDamageChangeAnim(self.curDamage, oldDisplay)
    end)
  end
end

function BattlePanel:OnBoutDamageChange(newDamage, oldDamage)
  bg.battleRender:UnperformWithDelay(self._playCurBoutStatsDamageTimer)
  table.insert(self.tickBoutDamageChangeList, function()
    self:DoBoutDamageChangeAnim(newDamage, oldDamage)
  end)
end

function BattlePanel:DoBoutDamageChangeAnim(newDamage, oldDamage)
  local Group_DamageCG = self.ui.Group_Damage:GetComponent(typeof(CanvasGroup))
  local uiAnimCtr = self.ui.Group_Damage:GetComponent(TypeofUIAnimationController)
  if bg.battleDataCenter and bg.battleDataCenter:ShouldSkipEnterUIAnim() then
    if newDamage > 0 then
      newDamage = math.floor(newDamage)
      self.ui.Group_Damage:SetActive(true)
      Group_DamageCG.alpha = 1
      self.binder:SetText(self.ui.Text_Damage, string.format("%s", newDamage))
    else
      self.ui.Group_Damage:SetActive(false)
    end
    return
  end
  if newDamage > 0 then
    newDamage = math.floor(newDamage)
    oldDamage = math.floor(oldDamage or 0)
    local updateFrame = 4
    local delta = math.ceil((newDamage - oldDamage) / updateFrame)
    local value = math.floor(oldDamage)
    if self.damageTimer then
      self.binder:StopTimer(self.damageTimer)
    end
    self.damageTimer = self.binder:BindTimer(0.03, updateFrame, function()
      value = math.min(value + delta, newDamage)
      self.binder:SetText(self.ui.Text_Damage, string.format("%s", value))
    end)
  end
  if newDamage > 0 then
    self.ui.Group_Damage:SetActive(true)
    Group_DamageCG:DOFade(1, 0.3)
    if not oldDamage or 0 == oldDamage then
      uiAnimCtr:StopPlayableGraph()
      uiAnimCtr:PlayState("UI_Battle_Damage_Open")
    else
      uiAnimCtr:PlayState("UI_Battle_Damage_WordChange")
    end
  else
    uiAnimCtr:PlayState("UI_Battle_Damage_Close")
  end
end

function BattlePanel:GetCardUI(_)
  return self.cardUI
end

function BattlePanel:GetCardItemByUid(cardUid, createIfNone)
  do return self.cardUI.GetCardItemByUid, self.cardUI, cardUid end
  return self.cardUI.GetCardItemByUid, self.cardUI, cardUid, createIfNone
end

function BattlePanel:SetPanelAniHash(hash)
  self.boutAnimUI:SetPanelAniHash(hash)
end

function BattlePanel:CameraMovement(position, rotation)
  local duration = 0.5
  bg.mainCamera.transform:DOMove(position, duration)
  bg.mainCamera.transform:DORotateQuaternion(rotation, duration)
end

function BattlePanel:SetOpMode(opMode, revertTime)
  if bg.battleDataCenter then
    bg.battleDataCenter:SetOpMode(opMode, revertTime)
  end
end

function BattlePanel:SetUIVisible(visible)
  self.isUIVisible.value = visible
  self.ui.Card_Content:SetActive(visible)
  local relicList = bg.battleRender.relicMgr:GetAllRelicDatas()
  self.ui.UI_Dbgcopy_Item_RelicList:SetActive(visible and #relicList > 0)
end

function BattlePanel:GetUIVisible()
  return self.isUIVisible.value
end

function BattlePanel:OnBattleRecover()
  self:OnBattleBegin()
  bg.battleDataCenter.isRecover = false
  bg.battleRender:PerformWithDelay(0.5, function()
    bg.battleRender.recordMgr:RecoverRecords()
    if bg.battleDataCenter then
      bg.battleDataCenter:EndRecoverEnterUIAnim()
    end
  end, self)
  local boutData = bg.battleDataCenter.boutData
  if boutData.isExtraBout then
    bg.battleScene:PlaySuperDimensionTimeline()
  end
end

function BattlePanel:OnBattleBegin()
  self:SetUIVisible(true)
  self:LoadGameSpeed()
  local stageId = (WorldStageManager.Instance:GetCurStageData() or {}).stageId
  local belongGroup = stageId and DT.Stage[stageId] and DT.Stage[stageId].BelongGroup
  if belongGroup and DT.StageGroup[belongGroup] and DT.StageGroup[belongGroup].Type == CommonDefine.StageGroupType.RailWay then
    RailWayDataUtils.OnBattleStart()
  end
end

function BattlePanel:OnBattleEnd()
  self.banClick.value = true
  if bg.battleScene then
    bg.battleScene:StopBattleBGM()
  end
  RailWayDataUtils.OnBattleFinish()
end

function BattlePanel:OnRelicChange(newRelicData)
  EventMgr.Instance.OnRelicDataChange:Dispatch(newRelicData)
end

function BattlePanel:OnRelicEffect(data)
  local tid = data and (data.tid or data.relicTid)
  print("[RelicGlow] BattlePanel:OnRelicEffect recv", tid, "data=", data and table.tostring(data) or "nil")
  EventMgr.Instance.OnRelicEffect:Dispatch(tid)
end

function BattlePanel:OnAddNewRelic(data)
  if data and data.relic and data.relic.tid then
    print("[RelicGlow] BattlePanel:OnAddNewRelic recv tid=", data.relic.tid, "data=", table.tostring(data))
    bg.battleRender.relicMgr:OnAddNewRelic(data.relic.tid)
  end
end

function BattlePanel:OnRemoveRelic(data)
  if data and data.tid then
    bg.battleRender.relicMgr:OnRemoveRelic(data.tid)
  end
end

function BattlePanel:OnBattleFinish(winCamp)
  self.winCamp.value = winCamp
  UIManager.Instance:CloseByUrl(Urls.BuffListPanelNew)
  UIManager.Instance:CloseByUrl(Urls.CardFeatureInfoPanel)
  UIManager.Instance:CloseByUrl(Urls.CardPanel)
end

function BattlePanel:OpenRelicPanel()
  local relics = bg.battleRender.relicMgr:GetAllRelicDatas()
  UIManager.Instance:Show(Urls.DbgRelicBattleScenePanel, relics)
end

function BattlePanel:OnSelectTargets(data)
  if bg.isReplay then
    return
  end
  Logger.Debug("BattlePanel:OnSelectTargets ", table.tostring(data))
  self:SetOpMode(rc.OpMode.Inspect, 9999)
  if data.targetSelectType == bc.TargetSelectType.Awaker then
    UIManager.Instance:Show(Urls.DbgAwakerSelectionPanel, data, function(selectedUids)
      self:SetOpMode(rc.OpMode.Play)
      local resp = {
        effectUid = data.effectUid,
        targetUids = selectedUids,
        selectType = data.targetSelectType
      }
      bg.battleRender:SendCommand(BattleCommand.lg_SelectTargets, resp)
    end)
  elseif data.targetSelectType == bc.TargetSelectType.Card then
    self:SetOpMode(rc.OpMode.Inspect, 9999)
    self.cardUI:OnSelectCards(data)
  elseif data.targetSelectType == bc.TargetSelectType.KeeperSkill then
    self:SetOpMode(rc.OpMode.Inspect, 9999)
    UIManager.Instance:Reopen(Urls.KeeperSkillSelectPanel, data.targetUids, data.desc, function(selectedUids)
      local resp = {
        effectUid = data.effectUid,
        targetUids = selectedUids,
        selectType = data.targetSelectType
      }
      bg.battleRender:SendCommand(BattleCommand.lg_SelectTargets, resp)
    end, data.cancelable)
  elseif data.targetSelectType == bc.TargetSelectType.Relic then
    UIManager.Instance:Reopen(Urls.BattleRelicSelectPanel, data, function(uid)
      self:SetOpMode(rc.OpMode.Play)
      local resp = {
        effectUid = data.effectUid,
        targetUids = {uid},
        selectType = data.targetSelectType
      }
      bg.battleRender:SendCommand(BattleCommand.lg_SelectTargets, resp)
    end)
  elseif data.targetSelectType == bc.TargetSelectType.CardDrop or data.targetSelectType == bc.TargetSelectType.KeeperSkillDrop then
    self:SetOpMode(rc.OpMode.Inspect, 9999)
    print("[CardDrop] BattlePanel:OnSelectTargets packList:", table.tostring(data.packList), "selectMaxNum:", tostring(data.selectMaxNum), "selectMinNum:", tostring(data.selectMinNum))
    UIManager.Instance:Reopen(Urls.BattleCardDropSelectView, data, function(packIndexList)
      self:SetOpMode(rc.OpMode.Play)
      print("[CardDrop] BattlePanel callback packIndexList:", table.tostring(packIndexList))
      local resp = {
        effectUid = data.effectUid,
        packIndexList = packIndexList,
        selectType = data.targetSelectType
      }
      bg.battleRender:SendCommand(BattleCommand.lg_SelectTargets, resp)
    end)
  end
end

function BattlePanel:PlayDrama(effectUid, dramaTid, hideUI)
  if hideUI then
    self:SetDramaUIVisible(false)
  end
end

function BattlePanel:PlayAwakerVoice(voiceId)
  if 0 == voiceId then
    return
  end
  local soundEventName = AwakerDataUtils.GetAwakerVoiceSound(voiceId)
  local duration = AudioManager.Instance:GetEventLength(soundEventName)
  EventMgr.Instance.ShowAwakerVoice:Dispatch(voiceId, nil, duration)
  AudioManager.Instance:PostSoundEvent(soundEventName)
end

function BattlePanel:ShowAwakerVoice(voiceId, delay, duration)
  local voiceConfig = DT.Voice[voiceId]
  
  local function ShowVoice()
    self.ui.Image_Bubble:SetActive(true)
    self.binder:SetText(self.ui.Text_Describe, voiceConfig.AwakerVoiceContent)
    if self.timer ~= nil then
      self.binder:StopTimer(self.timer)
      self.timer = nil
    end
    self.timer = self.binder:BindTimer(duration, 1, nil, function()
      self.ui.Image_Bubble:SetActive(false)
      self.binder:SetText(self.ui.Text_Describe, "")
    end)
  end
  
  if not delay then
    ShowVoice()
  else
    delay = delay and delay / 1000 or 1
    self.binder:BindTimer(delay, 1, nil, ShowVoice)
  end
end

function BattlePanel:SetDramaUIVisible(visible)
  self.isUIVisible.value = visible
  self.ui.Card_Content:SetActive(visible)
  self.ui.Group_Btn_Relic:SetActive(visible)
  self.ui.Group_Course:SetActive(visible)
  self.ui.Btn_Battle_Setting:SetActive(visible)
end

function BattlePanel:HideUI(hide, immediately)
  if IsNil(self.root) then
    return
  end
  self.isUIVisible.value = not hide
  local alpha = hide and 0 or 1
  if self.root then
    local canvasGroup = self.root:GetComponent(CanvasGroup)
    if canvasGroup then
      self:_TweenCanvasGroup(canvasGroup, alpha, immediately)
      canvasGroup.blocksRaycasts = not hide
    end
  end
  local uieffLayer = bg.battleScene:GetUIEffectLayer()
  if uieffLayer then
    local canvasGroup = uieffLayer:GetComponent(CanvasGroup)
    self:_TweenCanvasGroup(canvasGroup, alpha, immediately)
  end
end

function BattlePanel:_TweenCanvasGroup(canvasGroup, alpha, immediately)
  if immediately then
    canvasGroup.alpha = alpha
  else
    canvasGroup:DOFade(alpha, 0.3)
  end
end

function BattlePanel:BottomAreaVisible(isShow)
  self.isUIVisible.value = isShow
  self.ui.Image_Expenses:SetActive(isShow)
  local keeperSkillId = bg.battleDataCenter:GetPlayerKeeperSkill()
  if keeperSkillId then
    self.ui.KeeperSkill:SetActive(isShow)
  end
  self.ui.Card_Content:SetActive(isShow)
  self.ui.Image_End:SetActive(isShow)
  self.ui.Group_Battle_Disuse_1:SetActive(isShow)
  self.ui.Group_Handdeck_My:SetActive(isShow)
end

function BattlePanel:OnExtendedRelicNum(isExtended)
  if self.ui.Image_Line then
    self.ui.Image_Line:SetActive(not isExtended)
  end
end

function BattlePanel:BindMonsterShowTips(binder)
  binder:BindToRaw(function(_, isShow)
    if not isShow then
      self:HideMonsterTips()
    end
  end, function()
    if bg.battleDataCenter.boutData:IsCamp1Action() then
      return true
    end
  end)
end

function BattlePanel:BindAutoBattle(binder)
  if bg.isReplay then
    self.binder:SetActive(self.ui.Btn_AutoFight, false)
    return
  end
  local _, unlock = PlayerDataUtils.IsFeatureUnlock(CommonDefine.FeatureId.QuickClear, 0)
  self.binder:BindToVisible(self.ui.Btn_AutoFight, function()
    if not unlock then
      return false
    end
    return self.isUIVisible.value
  end)
  local isBattleAllowAuto = bg.battleRender:IsBattleAllowAuto()
  if not isBattleAllowAuto then
    local isSettingAutoFight = SettingManager.Instance:IsAutoFight()
    if isSettingAutoFight then
      Alert.ShowStr(LT.Text("AutoFightForbid"))
    end
  end
  self.binder:SetActive(self.ui.Image_AutoFight_Disabled, not isBattleAllowAuto or not unlock)
  if not unlock then
    self.binder:BindButtonClick(self.ui.Btn_AutoFight, function()
      PlayerDataUtils.AlertLockedTips(CommonDefine.FeatureId.QuickClear, 0)
    end)
    return
  end
  self.binder:BindButtonClick(self.ui.Btn_AutoFight, function()
    if not isBattleAllowAuto then
      Alert.ShowStr(LT.Text("AutoFightForbid"))
      return
    end
    local isAutoFight = self:IsAutoFight()
    SettingManager.Instance:SetAutoFight(not isAutoFight)
  end)
  self.binder:BindToRaw(function(_, isAuto)
    self.binder:SetActive(self.ui.Image_AutoFight_Light, isAuto)
    self.binder:SetActive(self.ui.Image_AutoFight_Nor, not isAuto)
    bg.battleRender.robotMgr:SetAuto(isAuto)
  end, function()
    do return self.IsAutoFight end
    return self.IsAutoFight, self
  end)
  CS.Framework.TransformUtil.SetLocalPos(self.ui.Group_AutoFight_Adaptive.transform, 0, 0, 0)
  local ratio = AdaptiveManager.Instance:GetHeightRatio()
  if ratio < 1.38 then
    local battleId = bg.battleRender.battleTid
    local virtualCamera = BattleCfgUtils.GetCfgField("VirtualCamera", battleId)
    if virtualCamera and table.contains({
      "StageBoss9",
      "StageBossS202"
    }, virtualCamera) then
      CS.Framework.TransformUtil.SetLocalPos(self.ui.Group_AutoFight_Adaptive.transform, -50, 0, 0)
    end
  end
end

function BattlePanel:IsAutoFight()
  return bg.battleRender:IsBattleAllowAuto() and SettingManager.Instance:IsAutoFight()
end

function BattlePanel:OnShowTips(data)
  if self.showTipsSchedulerId then
    self.showTips:SetActive(false)
    bg.battleRender:UnperformWithDelay(self.showTipsSchedulerId)
    self.showTipsSchedulerId = nil
  end
  local cardPos = self.ui.Card_Content.transform.position
  local tipsPos = self.ui.Monster_Warn_Tips_Node.transform.position
  if self.showTips == nil then
    self.showTips = self.binder:BindNewComponent(self.ui.Card_Content, MonsterWarnItem, UI_Battle_Item_Monster_WarnResource, tipsPos, data.tipsId)
  else
    self.showTips:SetText(data.tipsId)
    self.showTips:SetActive(true)
  end
  self.showTipsSchedulerId = bg.battleRender:PerformWithDelay(data.showTime / 1000, function()
    self:HideMonsterTips()
  end, self)
end

function BattlePanel:HideMonsterTips()
  if self.showTips then
    self.showTips:SetActive(false)
    self.showTips = nil
  end
  if self.showTipsSchedulerId then
    bg.battleRender:UnperformWithDelay(self.showTipsSchedulerId)
    self.showTipsSchedulerId = nil
  end
end

function BattlePanel:OnUseCard(cardUid, deck)
  self.cardUI:OnUseCard(cardUid, deck)
end

function BattlePanel:RefreshCardNum()
  self.cardUI:RefreshCardNum()
end

function BattlePanel:AddNewCard(newCards, _)
  self.cardUI:DelayAddNewCard(newCards)
end

function BattlePanel:ShowCardDetail(card, battleTouchPos, extraParams)
  self.cardUI:ShowCardDetail(card, battleTouchPos, extraParams)
end

function BattlePanel:LoadGameSpeed()
  local gameSpeed = MobileFileDataManager.Instance:GetPlayerFileValue(bc.BattleGameSpeedKey, 1)
  if 1 == tonumber(gameSpeed) then
    AudioManager.Instance:PostSoundEvent("BATTLE_DOUBLESPEED_OFF")
  elseif 2 == tonumber(gameSpeed) then
    AudioManager.Instance:PostSoundEvent("BATTLE_DOUBLESPEED_ON")
  end
  bg.battleRender.gameSpeed = gameSpeed
end

function BattlePanel:OnCommandResult(msgData)
  local msgId = msgData.msgId
  local isEnableExtraBout = not bg.battleDataCenter:IsNewExtraBoutState()
  local isBoutEnd = msgId == BattleCommand.lg_BoutEnd or isEnableExtraBout and msgId == BattleCommand.lg_ExtraBout
  if isBoutEnd then
    print("commandresult ===== ", table.tostring(msgData))
    if not msgData.ret then
      self:OnEndTurnFail()
    end
  end
  if msgData.msgId == BattleCommand.lg_BoutEnd or msgData.msgId == BattleCommand.lg_ExtraBout then
    if msgData.isEnterExtraBout then
      if bg.battleRender and bg.battleRender.boutMgr then
        bg.battleRender.boutMgr:OnChangeExtraBout({isExtraBout = true})
      end
      self:DimensionEnd()
      bg.battleScene:PlaySuperDimensionTimeline()
    else
      if bg.battleScene:IsPlayingSuperDimensionTimeline() then
        bg.battleScene:StopPlayingSuperDimensionTimeline()
      end
      bg.battleScene.battleSceneMgr:StartExitTimelineBattleScene()
    end
  end
  if msgData.msgId == BattleCommand.lg_UseDimensionSkill and msgData.ret == true then
    AudioManager.Instance:PostSoundEvent("Play_SFX_Realm_D_Slot_Fill_Del")
  end
end

function BattlePanel:DimensionTrun()
  if self.dimensionTurnTimer then
    return
  end
  self.dimensionTurnTimer = self.binder:BindTimer(DIMENTION_BOUT_BUTTON_DELAY_TIME, -1, function()
    if not self.ui or IsNil(self.ui.uiNode) then
      return
    end
    local DimensionEndTurnAnimCtr = self.ui.UI_Vx_Battle_Chaowei_Butter:GetComponent(TypeofUIAnimationController)
    DimensionEndTurnAnimCtr:StopPlayableGraph()
    self.ui.UI_Vx_Battle_Chaowei_Butter:SetActive(true)
    self.ui.Group_Endofturn:SetActive(false)
    if not self.ui.UI_Vx_Battle_Chaowei_Butter.activeInHierarchy then
      return
    end
    self.binder:StopTimer(self.dimensionTurnTimer)
    self.dimensionTurnTimer = nil
    DimensionEndTurnAnimCtr:PlayState("UI_Vx_Battle_Chaowei_Butter_Open")
    if bg.battleDataCenter:IsNewExtraBoutState() then
      self.binder:SetText(self.ui.Text_C_ExtraTurn, LT.Text("Battle_Transcendent_Title"))
    end
  end)
end

function BattlePanel:ClearDimensionTurn()
  if self.dimensionTurnTimer then
    self.binder:StopTimer(self.dimensionTurnTimer)
    self.dimensionTurnTimer = nil
  end
end

function BattlePanel:DimensionEnd()
  if bg.isReplay then
    self.ui.Btn_Finishes:SetActive(true)
    self.ui.UI_Vx_Battle_Chaowei_Butter:SetActive(true)
  end
  local DimensionEndTurnAnimCtr = self.ui.UI_Vx_Battle_Chaowei_Butter:GetComponent(TypeofUIAnimationController)
  DimensionEndTurnAnimCtr:PlayState("UI_Vx_Battle_Chaowei_Butter_Close", function()
    if not self.ui or not self._isDimensionClosing then
      return
    end
    self.ui.UI_Vx_Battle_Chaowei_Butter:SetActive(false)
  end)
  EventMgr.Instance.DimensionBoutEnd:Dispatch()
end

function BattlePanel:DimensionBoutReady()
  local isDimensionBoutReady = bg.battleDataCenter:IsSchool(bc.SchoolCnID.DIMENSION) and CardDataUtils.GetDimensionCardMax()
  local cmdParser = BattleCmdParserClient({})
  local cond = DT.BattleApi.dimensionSpace and DT.BattleApi.dimensionSpace.Data
  local ret = cmdParser:GetValueByCmd(cond)
  if true ~= ret then
    return
  end
  return isDimensionBoutReady
end

function BattlePanel:SetRendered(isRendering)
end

function BattlePanel:OnOceanModelChange(data)
  if data.model ~= bc.OceanModel.OceanModel1 then
    AudioManager.Instance:PostSoundEvent("Play_SFX_Realm_O_Tentacle_Switch")
  end
end

function BattlePanel:GetTransform()
  return self.ui.uiNode.transform
end

function BattlePanel:GetCardContent()
  return self.ui.Card_Content
end

function BattlePanel:GetDrawDeckBtn()
  return self.ui.Group_Battle_Disuse_1
end

function BattlePanel:GetGraveyardDeckBtn()
  return self.ui.Group_Battle_Disuse_1
end

function BattlePanel:GetHandDeckBtn()
  return self.ui.Group_Handdeck_My
end

function BattlePanel:OnUnbind(binder)
  self:ClearEndTurnDelayTimer()
  if self.timer then
    self.binder:StopTimer(self.timer)
    self.timer = nil
  end
  if bg.battleRender then
    if bg.battleRender.eventMgr then
      bg.battleRender.eventMgr:UnregisterAllEventsByTarget(self)
    end
    bg.battleRender:UnperformWithAllDelaysByTarget(self)
  end
  bg.battlePanel = nil
  AudioManager.Instance:PostSoundEvent("Play_SFX_Realm_D_Space_End")
  bg.SendBattleEvent(rc.BattleEvent.BattleUIClose, self.__name)
  if not IsNil(self.energyAniCtr) then
    self.energyAniCtr:StopPlayableGraph()
    self.energyAniCtr = nil
  end
end

return BattlePanel
