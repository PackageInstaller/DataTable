local Animator = CS.UnityEngine.Animator
local PanelShowParamHash = Animator.StringToHash("start")
local PanelHideParamHash = Animator.StringToHash("end")
local PanelDefualtParamHash = Animator.StringToHash("default")
local TimelinePrepared = CommonRes.TimelinePrepared
local typeof = _ENV.typeof
local GameObject = CS.UnityEngine.GameObject
local BattlePanelBoutAnimUI, Super = System.NewComponent("BattlePanelBoutAnimUI")

function BattlePanelBoutAnimUI:ctor(battlePanel, uiNode)
  Super.ctor(self)
  self.battlePanel = battlePanel
  self.ui = UI_Battle_Panel_DbgResource(uiNode)
  self.root = uiNode
  self.isBattleBegining = false
end

function BattlePanelBoutAnimUI:OnBind(binder)
  self.binder = binder
  self.panelAnimator = self.root:GetComponent(typeof(Animator))
  self:InitBattleAnim()
  binder:BindTimer(0.1, 0, nil, function()
    self.binder:BindToRaw(function(_, camp)
      self:ForbiddenKeeperSkiil(camp == bc.BattleCamp.Camp2)
      self:ForbiddenAwakerExSkill(camp == bc.BattleCamp.Camp2)
    end, function()
      return bg.battleDataCenter.boutData.camp
    end, true)
  end)
  binder:BindToRaw(function(_, nowVal, _)
    if nowVal then
      if bg.battleDataCenter and bg.battleDataCenter:ShouldSkipEnterUIAnim() then
        self:ApplyCampUIWithoutAnim()
      else
        self:PlayCampChangeAnim()
      end
    end
  end, function()
    local boutData = bg.battleDataCenter.boutData
    local isPhaseBegin = boutData.phase == bc.BoutPhase.Begin
    if self.isBattleBegining then
      return false
    end
    return isPhaseBegin
  end)
  bg.battleRender.eventMgr:RegisterEvent(BattleRenderEvent.BattleBegin, function()
    self.isBattleBegining = true
    self:OnBattleBeginCheck()
  end, self)
  self:SetPanelAniHash(PanelDefualtParamHash)
  if not bg.battleDataCenter.isRecover then
    self:ResetGroupCostAndEndofturn()
  else
    self:ApplyCampUIWithoutAnim()
  end
end

function BattlePanelBoutAnimUI:ResetGroupCostAndEndofturn()
  self.ui.Btn_Finishes:SetActive(false)
  self.ui.Group_Cost:SetActive(false)
end

function BattlePanelBoutAnimUI:InitBattleAnim()
  if self.camp1Panel == nil then
    local prefab = self.binder:LoadAsset("UI/UI_Battle/UI_Battle_Prefab/UI_Battle_Popup_Round_Mine.prefab")
    self.camp1Panel = self.binder:Instantiate(prefab, self.root.transform)
    self.binder:UpdateLocalizedTextAndResouce(self.camp1Panel)
    self.camp1Animator = self.camp1Panel:GetComponent(typeof(Animator))
  end
  self.camp1Panel:SetActive(false)
  if nil == self.camp2Panel then
    local prefab = self.binder:LoadAsset("UI/UI_Battle/UI_Battle_Prefab/UI_Battle_Popup_Round_Enemy.prefab")
    self.camp2Panel = self.binder:Instantiate(prefab, self.root.transform)
    self.binder:UpdateLocalizedTextAndResouce(self.camp2Panel)
    self.camp2Animator = self.camp2Panel:GetComponent(typeof(Animator))
  end
  self.camp2Panel:SetActive(false)
end

function BattlePanelBoutAnimUI:CheckBeginAwakerTrialBattle()
  local stageData = WorldStageManager.Instance:GetCurStageData()
  if stageData then
    local awakerTid = FreeTrialController.Instance:GetAwakerByStageId(stageData.stageId)
    if awakerTid then
      UIManager.Instance:Reopen(Urls.ActivityAwakerIntroPanel, awakerTid, System.fn(self, self.OnBattleBegin))
      return true
    end
  end
  return false
end

function BattlePanelBoutAnimUI:OnBattleBeginCheck()
  if bg.battleDataCenter and bg.battleDataCenter:ShouldSkipEnterUIAnim() then
    self.isBattleBegining = false
    bg.battleRender.boutMgr:CompleteBattleBeginAwaiter()
    self:ReShowBattleUI()
    self:ApplyCampUIWithoutAnim()
    return
  end
  if self:CheckBeginAwakerTrialBattle() then
    return
  end
  
  local function call()
    self:OnBattleBegin()
  end
  
  self.tag = "OnBattleBegin"
  
  local function excute()
    bg.battleRender:Push2Queue_RunInThisFrameData(call, self.tag)
  end
  
  if not BattleManager.isRunInServer then
    FrameWaiter.OnNextFrame(function()
      excute()
    end, 1)
  else
    excute()
  end
end

function BattlePanelBoutAnimUI:OnBattleBegin()
  if self.binder:isDestroyed() then
    return
  end
  local battleConfig, battleType
  if bg.battleData and bg.battleData.battleTid then
    battleConfig = DT.BattleConfig[bg.battleData.battleTid]
    battleType = battleConfig.BattleType
  else
    battleType = bc.BattleType.Common
  end
  local prefab, titleKey
  if battleType == bc.BattleType.Common then
    prefab = self.binder:LoadAsset("UI/UI_Battle/UI_Battle_Prefab/UI_Battle_Popup_Open_Tips.prefab")
    AudioManager.Instance:PostSoundEvent("FIGHT_START_CM")
  elseif battleType == bc.BattleType.Elite then
    prefab = self.binder:LoadAsset("UI/UI_Battle/UI_Battle_Prefab/UI_Battle_Popup_Elite_Tips.prefab")
    titleKey = "Battle_Begin_Elite_CHN"
    AudioManager.Instance:PostSoundEvent("FIGHT_START_ELITE")
  elseif battleType == bc.BattleType.Boss then
    prefab = self.binder:LoadAsset("UI/UI_Battle/UI_Battle_Prefab/UI_Battle_Popup_Elite_Tips.prefab")
    titleKey = "Battle_Begin_Boss_CHN"
    AudioManager.Instance:PostSoundEvent("FIGHT_START_ELITE")
  elseif battleType == bc.BattleType.PVP then
    prefab = self.binder:LoadAsset("UI/UI_Battle/UI_Battle_Prefab/UI_Battle_Popup_Elite_Tips.prefab")
    titleKey = "Battle_Begin_Boss_CHN"
    AudioManager.Instance:PostSoundEvent("FIGHT_START_ELITE")
  end
  local panel = self.binder:Instantiate(prefab, UIRootMgr.FindChild(UIRootMgr.GetUIRoot().transform, self.battlePanel.panelCfg.layer).transform)
  local battleStartUI = UI_Battle_Popup_Open_TipsResource(panel)
  self.binder:UpdateLocalizedTextAndResouce(panel)
  if titleKey then
    self.binder:SetText(battleStartUI.Text_Title, LT.Text(titleKey))
  end
  local animator = panel:GetComponent(typeof(Animator))
  local behavior = animator:GetAnimatorStateBehavior()
  behavior:onStateEnd("+", function()
    GameObject.Destroy(panel)
    self.isBattleBegining = false
    bg.battleRender:PopPerformQueue(self.tag)
    bg.battleRender.boutMgr:CompleteBattleBeginAwaiter()
    self:ReShowBattleUI()
    self:PlayCampChangeAnim()
    bg.SendBattleEvent(rc.BattleEvent.BattleBeginAnimDone)
  end)
  bg.battleScene:ClearBeforeStartTimeline()
  local oneLineBattleNodes = WorldStageManager.Instance:GetOneLineBattleNodes()
  if oneLineBattleNodes then
    local battleTid = bg.battleData and bg.battleData.battleTid or 0
    local curIndex = table.findvalue(oneLineBattleNodes, battleTid)
    if curIndex then
      if battleStartUI.Text_C_Hang then
        battleStartUI.Text_C_Hang:SetActive(false)
      end
      if battleStartUI.Text_Wave then
        self.binder:SetText(battleStartUI.Text_Wave, LT.Textf("BattleWaves", curIndex, #oneLineBattleNodes))
      end
    end
  elseif WorldStageManager.Instance:GetCurStageChapter() == cd.StageChapterName.StageChapterStarsCameRight then
    if battleStartUI.Text_C_Hang then
      battleStartUI.Text_C_Hang:SetActive(false)
    end
    if battleStartUI.Text_Wave then
      self.binder:SetText(battleStartUI.Text_Wave, LT.Textf("BattleWaves", 1, 1))
    end
  end
end

function BattlePanelBoutAnimUI:GetPlayerBountTL()
  local assignPath = bg.battleScene.battleSceneCfg.PlayerCameraController
  assignPath = nil == assignPath and TimelinePrepared.Common_Enemy2MyTurn or assignPath
  return assignPath
end

function BattlePanelBoutAnimUI:GetEnemyBountTL()
  local assignPath = bg.battleScene.battleSceneCfg.EnemyCameraController
  assignPath = nil == assignPath and TimelinePrepared.Common_My2EnemyTurn or assignPath
  return assignPath
end

function BattlePanelBoutAnimUI:ApplyCampUIWithoutAnim()
  if not bg.battleRender or not bg.battleRender.boutMgr then
    return
  end
  local camp = bg.battleRender.boutMgr:GetCamp()
  if camp == bc.BattleCamp.Camp1 then
    bg.battleDataCenter:SetIsMyBoutEnd(false)
    self.ui.Group_Cost:SetActive(true)
    self.ui.Btn_Finishes:SetActive(not bg.isReplay)
    self.ui.Btn_Battle_EndOfTurn:SetActive(true)
    self:SetPanelAniHash(PanelShowParamHash)
  elseif camp == bc.BattleCamp.Camp2 then
    self:SetPanelAniHash(PanelHideParamHash)
  end
end

function BattlePanelBoutAnimUI:PlayCampChangeAnim()
  if bg.battleDataCenter and bg.battleDataCenter:ShouldSkipEnterUIAnim() then
    self:ApplyCampUIWithoutAnim()
    return
  end
  local boutMgr = bg.battleRender.boutMgr
  local camp = boutMgr:GetCamp()
  if camp == bc.BattleCamp.Camp1 then
    local cnTips = "Battle_PlayerTurn_Title_CHN"
    local enTips = "Battle_PlayerTurn_Title_EN"
    if bg.battleDataCenter.boutData.isExtraBout then
      cnTips = "Battle_ExtraTurn_Desc_CHN"
      enTips = "Battle_ExtraTurn_Desc_EN"
    end
    bg.battleDataCenter:SetIsMyBoutEnd(false)
    self.ui.Group_Cost:SetActive(true)
    self.ui.Btn_Finishes:SetActive(not bg.isReplay)
    self.ui.Btn_Battle_EndOfTurn:SetActive(true)
    self:SetPanelAniHash(PanelShowParamHash)
    self:SetDelayInterationInGuide()
    if bg.isPVE then
      Awaiter.Dispatch(LT.Text(cnTips), 1.1, true)
    end
    self:SetBattleTip(true, LT.Text(cnTips), LT.Text(enTips), camp, function()
    end, function(finishCallback)
      self:PlayTimeLine(self:GetPlayerBountTL(), finishCallback)
    end)
  elseif camp == bc.BattleCamp.Camp2 then
    self:SetBattleTip(true, LT.Text("Battle_EnemyTurn_Title_CHN"), LT.Text("Battle_EnemyTurn_Title_EN"), camp, function()
      self:SetPanelAniHash(PanelHideParamHash)
    end, function(finishCallback)
      self:PlayTimeLine(self:GetEnemyBountTL(), finishCallback)
    end)
  end
end

function BattlePanelBoutAnimUI:PlayTimeLine(assetPath, finishCallback)
  bg.battleScene.cameraComp:PlayCameraTimeLine(assetPath, finishCallback)
end

function BattlePanelBoutAnimUI:SetBattleTip(visible, _, _, camp, callback, animFinishCallback)
  local tipPanel, tipAnimator, BattleTipStateHash
  if camp == bc.BattleCamp.Camp1 then
    tipPanel = self.camp1Panel
    tipAnimator = self.camp1Animator
    BattleTipStateHash = Animator.StringToHash("Base Layer.UA_PopupBattleBourTips_Open")
  elseif camp == bc.BattleCamp.Camp2 then
    tipPanel = self.camp2Panel
    tipAnimator = self.camp2Animator
    BattleTipStateHash = Animator.StringToHash("Base Layer.UA_PopupBattleBourTips_Open01")
  end
  tipPanel:SetActive(visible)
  tipAnimator:Play(BattleTipStateHash)
  tipAnimator:Update(0)
  if visible then
    if camp == bc.BattleCamp.Camp1 then
      AudioManager.Instance:PostSoundEvent("Audio_UI_My_Round_Que")
    else
      AudioManager.Instance:PostSoundEvent("Audio_UI_Enemy_Round_Que")
    end
    local behavior = tipAnimator:GetAnimatorStateBehavior()
    behavior:onStateEnd("+", function()
      if camp == bc.BattleCamp.Camp1 then
        self.camp1Panel:SetActive(false)
      elseif camp == bc.BattleCamp.Camp2 then
        self.camp2Panel:SetActive(false)
      end
      self.battlePanel.banClick.value = false
      bg.battleRender.boutMgr:CompleteBattleBeginAwaiter()
      self:SendGuideEvent()
      if animFinishCallback then
        animFinishCallback(System.fn(self, self.CompletePhaseBeginAwaiter))
      else
        self:CompletePhaseBeginAwaiter()
      end
    end)
    if callback then
      callback()
    end
  elseif animFinishCallback then
    animFinishCallback(System.fn(self, self.CompletePhaseBeginAwaiter))
  else
    self:CompletePhaseBeginAwaiter()
  end
end

function BattlePanelBoutAnimUI:SendGuideEvent()
  local tid = bg.battleRender.battleTid
  if bg.battleDataCenter.boutData.camp == bc.BattleCamp.Camp1 then
    local boutNum = bg.battleRender.boutMgr:GetBoutNum()
    EventMgr.Instance.GuideBattleEvent:Dispatch(CommonDefine.GuideBattle.Bout, {tid, boutNum})
    local keeperEnergy = bg.battleDataCenter:GetPlayerRoleProperty(bc.RoleProperty.keeper_energy)
    if KeeperSkillUtils.GetKeeperSkillEnergyLevel(keeperEnergy) >= CommonDefine.KeeperSkillEnergyLevel.Pos1 then
      EventMgr.Instance.GuideBattleEvent:Dispatch(CommonDefine.GuideBattle.GuideCondKeeperSkillEnergyFull, {tid, boutNum})
    end
  end
end

function BattlePanelBoutAnimUI:CompletePhaseBeginAwaiter()
  print("---------------complete phase begin")
  bg.battleRender:PopPerformQueue(self.tag)
  bg.battleRender.boutMgr:CompletePhaseBeginAwaiter()
end

function BattlePanelBoutAnimUI:SetPanelAniHash(hash)
  if self.panelAniHash == hash then
    return
  end
  self.panelAniHash = hash
  self.panelAnimator:SetTrigger(hash)
  self.panelAnimator:Update(0)
end

function BattlePanelBoutAnimUI:ReShowBattleUI()
  self.battlePanel:HideUI(false)
  bg.battleScene:SetBattleUIVisible()
end

function BattlePanelBoutAnimUI:ForbiddenKeeperSkiil(boolVal)
  if self.battlePanel and self.battlePanel.keeperSkillCom then
    self.battlePanel.keeperSkillCom:ForbiddenClick(boolVal)
  end
end

function BattlePanelBoutAnimUI:ForbiddenAwakerExSkill(boolVal)
  if self.battlePanel and self.battlePanel.ultiSkillPanel then
    self.battlePanel.ultiSkillPanel:ForbiddenAwakerItemsClick(boolVal)
  end
end

function BattlePanelBoutAnimUI:SetDelayInterationInGuide()
  if GuideManager.Instance:IsBattleHaveGuide() then
    EventMgr.Instance.OpenClickMask:Dispatch("NewbieGuidePanel", 2)
  end
end

function BattlePanelBoutAnimUI:OnUnbind()
end

return BattlePanelBoutAnimUI
