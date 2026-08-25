local Animator = CS.UnityEngine.Animator
local PanelShowParamHash = Animator.StringToHash("start")
local PanelHideParamHash = Animator.StringToHash("end")
local PanelDefualtParamHash = Animator.StringToHash("default")
local TimelinePrepared = CommonRes.TimelinePrepared
local typeof = _ENV.typeof
local GameObject = CS.UnityEngine.GameObject
local PVPBattleBoutAnimUI, Super = System.NewComponent("PVPBattleBoutAnimUI")

function PVPBattleBoutAnimUI:ctor(uiNode)
  Super.ctor(self)
  self.ui = UI_Battle_Panel_DbgResource(uiNode)
  self.root = uiNode
  self.isBattleBegining = false
end

function PVPBattleBoutAnimUI:OnBind(binder)
  self.binder = binder
  self:InitBattleAnim()
  binder:BindToRaw(function(_, nowVal, _)
    if nowVal then
      self:PlayCampChangeAnim()
    end
  end, function()
    local boutData = bg.battleDataCenter.boutData
    local isPhaseBegin = boutData.phase == bc.BoutPhase.Begin
    if self.isBattleBegining then
      return false
    end
    return isPhaseBegin
  end, true)
  bg.battleRender.eventMgr:RegisterEvent(BattleRenderEvent.BattleBegin, function()
    self.isBattleBegining = true
    self:OnBattleBeginCheck()
  end, self)
  if bg.isPVP then
    bg.battleRender:PerformWithDelay(1.5, function()
      bg.battleScene:SetBattleUIVisible()
    end, self)
  end
  self.binder:BindEvent(EventMgr.Instance.BattleResult, System.fn(self, self._OnBattleResult))
end

function PVPBattleBoutAnimUI:_OnBattleResult()
  self:_ClearPlayerBoutTimer()
  BattleVoiceController.Instance:StopAllPvpVoice()
end

function PVPBattleBoutAnimUI:InitBattleAnim()
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

function PVPBattleBoutAnimUI:CheckBeginAwakerTrialBattle()
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

function PVPBattleBoutAnimUI:OnBattleBeginCheck()
  if self:CheckBeginAwakerTrialBattle() then
    return
  end
  self:OnBattleBegin()
end

function PVPBattleBoutAnimUI:OnBattleBegin()
  bg.battleScene:SetBattleUIVisible()
  bg.battleScene:ClearBeforeStartTimeline()
end

function PVPBattleBoutAnimUI:GetPlayerBountTL()
  local assignPath = bg.battleScene.battleSceneCfg.PlayerCameraController
  assignPath = nil == assignPath and TimelinePrepared.Common_Enemy2MyTurn or assignPath
  return assignPath
end

function PVPBattleBoutAnimUI:GetEnemyBountTL()
  local assignPath = bg.battleScene.battleSceneCfg.EnemyCameraController
  assignPath = nil == assignPath and TimelinePrepared.Common_My2EnemyTurn or assignPath
  return assignPath
end

function PVPBattleBoutAnimUI:PlayCampChangeAnim()
  local boutMgr = bg.battleRender.boutMgr
  local camp = boutMgr:GetCamp()
  self:_CreatePlayerBoutTimer()
  if camp == bg.battleDataCenter:GetMyCamp() then
    local cnTips = "Battle_PlayerTurn_Title_CHN"
    local enTips = "Battle_PlayerTurn_Title_EN"
    if bg.battleDataCenter.boutData.isExtraBout then
      cnTips = "Battle_ExtraTurn_Desc_CHN"
      enTips = "Battle_ExtraTurn_Desc_EN"
    end
    self:SetBattleTip(true, LT.Text(cnTips), LT.Text(enTips), camp, function()
    end, function(finishCallback)
      self:PlayTimeLine(self:GetPlayerBountTL(), finishCallback)
    end)
  else
    self:SetBattleTip(true, LT.Text("Battle_EnemyTurn_Title_CHN"), LT.Text("Battle_EnemyTurn_Title_EN"), camp, function()
    end, function(finishCallback)
      self:PlayTimeLine(self:GetEnemyBountTL(), finishCallback)
    end)
  end
end

function PVPBattleBoutAnimUI:_CreatePlayerBoutTimer()
  self:_ClearPlayerBoutTimer()
  BattleVoiceModel.Instance:ResetPvpPlayerThinking()
  self._playerBoutTimer = self.binder:BindTimer(1, -1, function()
    BattleVoiceController.Instance:OnPvpPlayerThinkingTick()
  end, nil)
end

function PVPBattleBoutAnimUI:_ClearPlayerBoutTimer()
  if self._playerBoutTimer then
    self.binder:StopTimer(self._playerBoutTimer)
    self._playerBoutTimer = nil
  end
end

function PVPBattleBoutAnimUI:PlayTimeLine(assetPath, finishCallback)
  bg.battleScene.cameraComp:PlayCameraTimeLine(assetPath, finishCallback)
end

function PVPBattleBoutAnimUI:SetBattleTip(visible, _, _, camp, callback, animFinishCallback)
  local tipPanel, tipAnimator, BattleTipStateHash
  if camp == bg.battleDataCenter:GetMyCamp() then
    tipPanel = self.camp1Panel
    tipAnimator = self.camp1Animator
    BattleTipStateHash = Animator.StringToHash("Base Layer.UA_PopupBattleBourTips_Open")
  else
    tipPanel = self.camp2Panel
    tipAnimator = self.camp2Animator
    BattleTipStateHash = Animator.StringToHash("Base Layer.UA_PopupBattleBourTips_Open01")
  end
  tipPanel:SetActive(visible)
  tipAnimator:Play(BattleTipStateHash)
  if visible then
    self.binder:BindTimer(0.5, 0, nil, function()
      local tid = bg.battleRender.battleTid
      if bg.battleDataCenter.boutData.camp == bg.battleDataCenter:GetMyCamp() then
        local boutNum = bg.battleRender.boutMgr:GetBoutNum()
        EventMgr.Instance.GuideBattleEvent:Dispatch(CommonDefine.GuideBattle.Bout, {tid, boutNum})
      end
    end)
  end
  if visible then
    if camp == bg.battleDataCenter:GetMyCamp() then
      AudioManager.Instance:PostSoundEvent("Audio_UI_My_Round_Que")
    else
      AudioManager.Instance:PostSoundEvent("Audio_UI_Enemy_Round_Que")
    end
    local behavior = tipAnimator:GetAnimatorStateBehavior()
    behavior:onStateEnd("+", function()
      if not self.ui or IsNil(self.ui.uiNode) then
        return
      end
      if camp == bg.battleDataCenter:GetMyCamp() then
        self.camp1Panel:SetActive(false)
      else
        self.camp2Panel:SetActive(false)
      end
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

function PVPBattleBoutAnimUI:CompletePhaseBeginAwaiter()
  bg.battleRender.boutMgr:CompletePhaseBeginAwaiter()
end

function PVPBattleBoutAnimUI:OnUnbind()
end

return PVPBattleBoutAnimUI
