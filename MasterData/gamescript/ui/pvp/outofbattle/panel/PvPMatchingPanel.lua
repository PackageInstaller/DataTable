local SkeletonGraphic = CS.Spine.Unity.SkeletonGraphic
local UIAnimationController = CS.Z1Client.UIAnimationController
local SEARCH_LOOP_SPINE_ANIM = "Searching_1"
local SEARCH_SUCCESS_SPINE_ANIM = "Searching_2"
local UI_MOVE_DOWN_ANIM = "UI_Pvp_Panel_Match_Open"
local PvPMatchingPanel, Super = System.NewClass("DBGTeamRenamePanel", DBGTeamRenamePanel)
PvPMatchingPanel.uiResCls = UI_Pvp_Panel_MatchResource

function PvPMatchingPanel:ctor()
  Super.ctor(self)
  self.animState = CommonDefine.PvpMatchingAnimState.None
  self.isCanceling = Vue.ref(false)
  self.isMatchSuccess = false
  self.isPlayMatchEndEffect = false
end

function PvPMatchingPanel:OnBind(binder)
  self.binder = binder
  self.uiAnimController = self.ui.uiNode:GetComponent(typeof(UIAnimationController))
  if self.ui.UI_Pvp_Vx_Spine_Searching then
    self.spineAnimGraphic = self.ui.UI_Pvp_Vx_Spine_Searching:GetComponent(typeof(SkeletonGraphic))
  end
  if self.spineAnimGraphic then
    self.spineAnimState = self.spineAnimGraphic.AnimationState
  end
  if not self.spineAnimState then
    self.ui.UI_Pvp_Vx_Spine_Searching:SetActive(false)
  end
  binder:BindZ1Button(self.ui.UI_ComBtn2_Match, System.fn(self, self.OnClickCancel), function()
    return CommonDefine.BtnType.High
  end, System.fn(self, self.GetCancelBtnText))
  binder:BindEvent(EventMgr.Instance.PvPMatchEnded, System.fn(self, self._MatchEndedFunc))
  binder:BindEvent(EventMgr.Instance.PvpDraftDataUpdate, System.fn(self, self._MatchEndedFunc))
  local tickNum = 0
  self:_RefreshMatchingTipsByTickNum(tickNum)
  self.timer = binder:BindTimer(1, -1, function()
    tickNum = tickNum + 1
    self:_RefreshMatchingTipsByTickNum(tickNum)
  end)
  self:PrepareVideo()
  self:PlaySpineAnimSearchingLoop()
end

function PvPMatchingPanel:_RefreshMatchingTipsByTickNum(tickNum)
  self.binder:SetText(self.ui.Text_Time, tickNum)
  ProtoManager.Instance:ReqServer("PvpRequest", "OnGetMatchQueueCount", function(data)
    if self.binder and self.ui and not IsNil(self.ui.Text_Matching) then
      if data.roleState == "InGame" then
        Alert.Show("PvpMatchingInterruptTips")
        self:Close()
        return
      end
      local waitstr = self:_GetMatchingTipByTickNum(tickNum)
      local content = LT.Textf("PvPMatchinging", data.count, waitstr)
      self.binder:SetText(self.ui.Text_Matching, content)
    end
  end)
end

function PvPMatchingPanel:_MatchEndedFunc(data)
  self.isMatchSuccess = true
  self:PlayAnimSearchingSuccess()
end

function PvPMatchingPanel:OnMatchPlayEnd()
  self.isPlayMatchEndEffect = true
  self:UpdateAnimState(CommonDefine.PvpMatchingAnimState.End)
  self:Close()
  UIManager.Instance:CloseAllExcept()
  PvPMatchDataUtils.SetIsMatching(false, true)
  if PvpDraftModel.Instance:IsInDraftPvp() then
    PvpController.Instance:OpenPvpDraftView()
  else
    PvPMatchDataUtils.OpenPvPMatchRstPanel()
  end
end

function PvPMatchingPanel:OnUnbind()
  if self.timer then
    self.binder:StopTimer(self.timer)
    self.timer = nil
  end
  self.ui.VideoPlayer:SetActive(false)
  self.ui.VideoPlayerBak:SetActive(false)
  if self.videoPlayer then
    self.videoPlayer:Dispose()
    self.videoPlayer = nil
  end
  if self.isMatchSuccess and not self.isPlayMatchEndEffect then
    self:OnMatchPlayEnd()
  end
end

function PvPMatchingPanel:_GetMatchingTipByTickNum(tickNum)
  local dotNum = tickNum % 3 + 1
  local matchingText = ""
  for i = 1, dotNum do
    matchingText = matchingText .. "."
  end
  return matchingText
end

function PvPMatchingPanel:UpdateAnimState(state)
  self.animState = state
end

function PvPMatchingPanel:PlaySpineAnimSearchingLoop()
  AudioManager.Instance:PostSoundEvent("Play_Anim_PVP_Matching_Machine_Loop1")
  self:UpdateAnimState(CommonDefine.PvpMatchingAnimState.SearchingLoop)
  if self.spineAnimState then
    self.spineAnimState:SetAnimation(0, SEARCH_LOOP_SPINE_ANIM, true)
  end
end

function PvPMatchingPanel:PlayAnimSearchingSuccess()
  AudioManager.Instance:PostSoundEvent("Stop_Anim_PVP_Matching_Machine_Loop1")
  AudioManager.Instance:PostSoundEvent("Play_Anim_PVP_Matching_Machine_Loop2")
  GyroscopeManager.Instance:DisableGyroscope()
  self:UpdateAnimState(CommonDefine.PvpMatchingAnimState.SearchingSuccess)
  if self.spineAnimState then
    self.spineAnimState:SetAnimation(0, SEARCH_SUCCESS_SPINE_ANIM, false)
  end
  local animClip = self.uiAnimController:GetClip(UI_MOVE_DOWN_ANIM).clip
  self.uiAnimController:RemoveAnimationEvent(animClip)
  CS.AMTimeline.AMTimelineUtils.AddAnimationEvent(animClip, 88 / animClip.frameRate, "PlayTransformVideo", "SendLuaEvent")
  self.uiAnimController:RegisterAniamtionEventHander(self.OnCSAnimEvent, self)
  self.uiAnimController:PlayState(UI_MOVE_DOWN_ANIM)
  self.binder:BindTimer(1.5, 0, nil, function()
    if self.animState == CommonDefine.PvpMatchingAnimState.SearchingSuccess then
      self:PlayTransformVideo()
    end
  end)
end

function PvPMatchingPanel:OnCSAnimEvent(eventName)
  if "PlayTransformVideo" == eventName and self.animState == CommonDefine.PvpMatchingAnimState.SearchingSuccess then
    self:PlayTransformVideo()
  end
end

function PvPMatchingPanel:PrepareVideo()
  self.videoPlayer = GameVideoPlayer(self.ui.VideoPlayer, self.ui.VideoPlayerBak)
  self.ui.VideoPlayer:SetActive(true)
  
  local function onPrepareCompleted()
    self.videoPlayer:Pause()
  end
  
  self.videoPlayer:SetLooping(false)
  self.videoPlayer.preparedCallback = onPrepareCompleted
  self.videoPlayer:OpenMedia("Pvp_In.mp4")
end

function PvPMatchingPanel:PlayTransformVideo()
  AudioManager.Instance:PostSoundEvent("Play_Trans_PVP_Matching_Exit")
  self:UpdateAnimState(CommonDefine.PvpMatchingAnimState.TransformVideo)
  
  function self.videoPlayer.finishedCallback()
    self:OnMatchPlayEnd()
  end
  
  self.videoPlayer:Play()
  self.binder:BindTimer(2, 0, nil, function()
    if self.animState == CommonDefine.PvpMatchingAnimState.TransformVideo then
      self:OnMatchPlayEnd()
    end
  end)
end

function PvPMatchingPanel:OnClickCancel()
  self.isCanceling.value = true
  PvpController.Instance:ReqOnCancel(System.fn(self, self.Close))
end

function PvPMatchingPanel:GetCancelBtnText()
  if self.isCanceling.value then
    do return LT.Text end
    return LT.Text, "PvpMatchCanceling"
  end
  do return LT.Text end
  return LT.Text, "UniversalCancelButton"
end

function PvPMatchingPanel:Close()
  AudioManager.Instance:PostSoundEvent("Stop_Anim_PVP_Matching_Machine_Loop1")
  Super.Close(self)
end

return PvPMatchingPanel
