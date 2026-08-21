_class("HomelandFishingStatusThrow", HomelandFishingStatus)
HomelandFishingStatusThrowThrow = HomelandFishingStatusThrow

function HomelandFishingStatusThrow:OnEnter()
  if self._throwPowerCallback == nil then
    self._throwPowerCallback = GameHelper:GetInstance():CreateCallback(self.ThrowPowerChange, self)
    GameGlobal.EventDispatcher():AddCallbackListener(GameEventType.FishingThrowPower, self._throwPowerCallback)
  end
  if self._startThrowPowerCallback == nil then
    self._startThrowPowerCallback = GameHelper:GetInstance():CreateCallback(self.StartThrowPower, self)
    GameGlobal.EventDispatcher():AddCallbackListener(GameEventType.FishingStartThrow, self._startThrowPowerCallback)
  end
  GameGlobal.EventDispatcher():Dispatch(GameEventType.SetInteractPointUIStatus, true)
end

function HomelandFishingStatusThrow:OnExit()
  self:RemoveCallback()
end

function HomelandFishingStatusThrow:FishingStatus()
  return FishgingStatus.Throw
end

function HomelandFishingStatusThrow:OnDestroy()
  self:RemoveCallback()
end

function HomelandFishingStatusThrow:RemoveCallback()
  if self._throwPowerCallback then
    GameGlobal.EventDispatcher():RemoveCallbackListener(GameEventType.FishingThrowPower, self._throwPowerCallback)
    self._throwPowerCallback = nil
  end
  if self._startThrowPowerCallback then
    GameGlobal.EventDispatcher():RemoveCallbackListener(GameEventType.FishingStartThrow, self._startThrowPowerCallback)
    self._startThrowPowerCallback = nil
  end
end

function HomelandFishingStatusThrow:ThrowPowerChange(power)
  GameGlobal.TaskManager():StartTask(self.ThrowAnim, self, power)
end

function HomelandFishingStatusThrow:ThrowAnim(TT, power)
  self:LockStatus()
  self:LockUI("HomelandFishingStatusThrow_ThrowAnim")
  local result, floatPosition = self:IsThrowSuccess(power)
  GameGlobal.EventDispatcher():Dispatch(GameEventType.FishThrowResult, result)
  if result then
    GameGlobal.EventDispatcher():Dispatch(GameEventType.ForceFinishGuideStep, GuideType.Button)
    local anim = HomelandFishingConst.GetAnimationCfg(FishgingAnimation.FishThrowSuccess)
    self:PlayAnimation(anim.name)
    self:PlayFishRodAnimation(anim.rodname)
    YIELD(TT, 800)
    local layers = 0
    layers = layers | 1 << HomeBuildLayer.Water
    local castRes, hitInfo = UnityEngine.Physics.Raycast(floatPosition + Vector3(0, 1, 0), Vector3.down, nil, 1000, layers)
    if castRes then
      floatPosition = hitInfo.point
    end
    self._homelandFishing:CreateFloat(floatPosition)
    YIELD(TT, anim.length - 800)
    self:SwitchStatus(FishgingStatus.Fishing, floatPosition)
  else
    ToastManager.ShowHomeToast(StringTable.Get("str_homeland_fish_toss_miss"))
    local anim = HomelandFishingConst.GetAnimationCfg(FishgingAnimation.FishThrowFailure)
    self:PlayAnimation(anim.name)
    self:PlayFishRodAnimation(anim.rodname)
    YIELD(TT, anim.length - 50)
    self:SwitchStatus(FishgingStatus.Throw)
    self:SetFishRodStatus(false)
  end
  self:UnLockUI("HomelandFishingStatusThrow_ThrowAnim")
  self:UnLockStatus()
end

function HomelandFishingStatusThrow:StartThrowPower()
  self:SetFishRodStatus(true)
end

function HomelandFishingStatusThrow:IsThrowSuccess(power)
  local minDistance = HomelandFishingConst.GetThrowMinDistance()
  local maxDistance = HomelandFishingConst.GetThrowMaxDistance()
  local distance = minDistance + (maxDistance - minDistance) * power
  local transform = self:CharacterTransform()
  local pos = transform.position + transform:TransformDirection(Vector3(0, 0, distance))
  return self:IsInRiver(Vector2(pos.x, pos.z)), pos
end
