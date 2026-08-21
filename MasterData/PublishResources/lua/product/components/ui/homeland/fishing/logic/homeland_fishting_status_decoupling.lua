_class("HomelandFishingStatusDecoupling", HomelandFishingStatus)
HomelandFishingStatusDecoupling = HomelandFishingStatusDecoupling

function HomelandFishingStatusDecoupling:OnEnter(failureReason)
  ToastManager.ShowHomeToast(StringTable.Get("str_homeland_fish_flee"))
  GameGlobal.TaskManager():StartTask(self.FishingFailureCoror, self, failureReason)
end

function HomelandFishingStatusDecoupling:FishingFailureCoror(TT, failureReason)
  self:LockUI("HomelandFishingStatusDecoupling_FishingFailureCoror")
  local homelandModule = GameGlobal.GetModule(HomelandModule)
  homelandModule:ApplyFishPostionData(TT)
  local homelandUIModule = GameGlobal.GetUIModule(HomelandModule)
  local homelandClient = homelandUIModule:GetClient()
  local characterController = homelandClient:CharacterManager():MainCharacterController()
  if not characterController:GetIsFishMach() then
    self._homelandFishing:RefreshFishingPosition()
  end
  local anim
  if failureReason == FishgingFailureReason.FishPowerGreat then
    anim = HomelandFishingConst.GetAnimationCfg(FishgingAnimation.DecouplingFishPowerGreat)
  elseif failureReason == FishgingFailureReason.PersonPowerGreat then
    anim = HomelandFishingConst.GetAnimationCfg(FishgingAnimation.DecouplingPersonPowerGreat)
  elseif failureReason == FishgingFailureReason.TimeOut then
    anim = HomelandFishingConst.GetAnimationCfg(FishgingAnimation.FishFailure)
  end
  AudioHelperController.PlayUISoundAutoRelease(CriAudioIDConst.HomelandAudioFishingFail)
  if anim then
    self:PlayAnimation(anim.name)
    self:PlayFishRodAnimation(anim.rodname)
    YIELD(TT, anim.length)
  end
  self:SwitchStatus(FishgingStatus.Finish)
  self:UnLockUI("HomelandFishingStatusDecoupling_FishingFailureCoror")
end

function HomelandFishingStatusDecoupling:OnExit()
end

function HomelandFishingStatusDecoupling:FishingStatus()
  return FishgingStatus.FishDecoupling
end

function HomelandFishingStatusDecoupling:OnDestroy()
end
