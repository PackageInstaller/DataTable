_class("HomelandFishingStatusBite", HomelandFishingStatus)
HomelandFishingStatusBite = HomelandFishingStatusBite

function HomelandFishingStatusBite:OnEnter(param)
  local anim = HomelandFishingConst.GetAnimationCfg(FishgingAnimation.FishPowerChange)
  self:PlayAnimation(anim.name)
  self:PlayFishRodAnimation(anim.rodname)
  self._floatPosition = param
  self._homelandFishing:FishBite()
  self._fish = HomelandFishingConst.GetBiteFish()
  self._biteLength = self._fish:GetDecouplingTime()
  if self._fishingSuccessCallback == nil then
    self._fishingSuccessCallback = GameHelper:GetInstance():CreateCallback(self.FishingSuccess, self)
    GameGlobal.EventDispatcher():AddCallbackListener(GameEventType.FishingSuccess, self._fishingSuccessCallback)
  end
  if self._fishingFailureCallback == nil then
    self._fishingFailureCallback = GameHelper:GetInstance():CreateCallback(self.FishingFailure, self)
    GameGlobal.EventDispatcher():AddCallbackListener(GameEventType.FishingFailure, self._fishingFailureCallback)
  end
  if self._fishingPowerChangeCallback == nil then
    self._fishingPowerChangeCallback = GameHelper:GetInstance():CreateCallback(self.FishingPowerChange, self)
    GameGlobal.EventDispatcher():AddCallbackListener(GameEventType.FishingPowerChange, self._fishingPowerChangeCallback)
  end
  if self._fishingCancelFishCallback == nil then
    self._fishingCancelFishCallback = GameHelper:GetInstance():CreateCallback(self.FishingCancelFish, self)
    GameGlobal.EventDispatcher():AddCallbackListener(GameEventType.FishingCancelFish, self._fishingCancelFishCallback)
  end
  self._audio_playid = AudioHelperController.PlayInnerGameSfx(CriAudioIDConst.HomelandAudioPreparePullUp, true)
end

function HomelandFishingStatusBite:OnExit()
  self:RemoveCallback()
  AudioHelperController.StopInnerGameSfx(self._audio_playid, CriAudioIDConst.HomelandAudioPreparePullUp)
end

function HomelandFishingStatusBite:FishingStatus()
  return FishgingStatus.Bite
end

function HomelandFishingStatusBite:OnUpdate(deltaTime)
  if self:GetStatusLength() < self._biteLength then
    return
  end
  self:SwitchStatus(FishgingStatus.FishDecoupling, FishgingFailureReason.TimeOut)
end

function HomelandFishingStatusBite:OnDestroy()
  self:RemoveCallback()
end

function HomelandFishingStatusBite:RemoveCallback()
  if self._fishingSuccessCallback then
    GameGlobal.EventDispatcher():RemoveCallbackListener(GameEventType.FishingSuccess, self._fishingSuccessCallback)
    self._fishingSuccessCallback = nil
  end
  if self._fishingFailureCallback then
    GameGlobal.EventDispatcher():RemoveCallbackListener(GameEventType.FishingFailure, self._fishingFailureCallback)
    self._fishingFailureCallback = nil
  end
  if self._fishingPowerChangeCallback then
    GameGlobal.EventDispatcher():RemoveCallbackListener(GameEventType.FishingPowerChange, self._fishingPowerChangeCallback)
    self._fishingPowerChangeCallback = nil
  end
  if self._fishingCancelFishCallback then
    GameGlobal.EventDispatcher():RemoveCallbackListener(GameEventType.FishingCancelFish, self._fishingCancelFishCallback)
    self._fishingCancelFishCallback = nil
  end
end

function HomelandFishingStatusBite:FishingSuccess()
  self:SwitchStatus(FishgingStatus.FishSuccess)
end

function HomelandFishingStatusBite:FishingFailure(failureReason)
  self:SwitchStatus(FishgingStatus.FishDecoupling, failureReason)
end

function HomelandFishingStatusBite:FishingPowerChange(value)
  local fishGreatAnim = HomelandFishingConst.GetAnimationCfg(FishgingAnimation.FishPowerGreate)
  local personGreatAnim = HomelandFishingConst.GetAnimationCfg(FishgingAnimation.PersonPowerGreat)
  if value < 0 then
    self:PlayAnimationLoop(fishGreatAnim.name)
    self:PlayFishRodAnimationLoop(fishGreatAnim.rodname)
    self:StopPlayAnimationLoop(personGreatAnim.name)
    self:StopFishRodyAnimationLoop(personGreatAnim.rodname)
  elseif value == 0 then
    self:StopPlayAnimationLoop(fishGreatAnim.name)
    self:StopPlayAnimationLoop(personGreatAnim.name)
    self:StopFishRodyAnimationLoop(fishGreatAnim.rodname)
    self:StopFishRodyAnimationLoop(personGreatAnim.rodname)
  elseif 0 < value then
    self:PlayAnimationLoop(personGreatAnim.name)
    self:StopPlayAnimationLoop(fishGreatAnim.name)
    self:PlayFishRodAnimationLoop(personGreatAnim.rodname)
    self:StopFishRodyAnimationLoop(fishGreatAnim.rodname)
  end
end

function HomelandFishingStatusBite:FishingCancelFish(reasonStartMove)
  if not reasonStartMove then
    local cancelFishingAnim = HomelandFishingConst.GetAnimationCfg(FishgingAnimation.CancelFishing)
    self:PlayAnimation(cancelFishingAnim.name)
    self:PlayFishRodAnimation(cancelFishingAnim.rodname)
  end
  local homeLandModule = GameGlobal.GetUIModule(HomelandModule)
  local homelandClient = homeLandModule:GetClient()
  local characterController = homelandClient:CharacterManager():MainCharacterController()
  if not characterController:GetIsFishMach() then
    GameGlobal.TaskManager():StartTask(self.RefreshFishingData, self)
  end
end

function HomelandFishingStatusBite:RefreshFishingData(TT)
  self:LockUI("HomelandFishingStatusBite_RefreshFishingData")
  local homelandModule = GameGlobal.GetModule(HomelandModule)
  homelandModule:ApplyFishPostionData(TT)
  if self._homelandFishing then
    self._homelandFishing:RefreshFishingPosition()
  end
  self:UnLockUI("HomelandFishingStatusBite_RefreshFishingData")
end
