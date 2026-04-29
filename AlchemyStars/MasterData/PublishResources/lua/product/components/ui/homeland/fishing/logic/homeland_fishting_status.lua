_class("HomelandFishingStatus", Object)
HomelandFishingStatus = HomelandFishingStatus

function HomelandFishingStatus:Constructor()
end

function HomelandFishingStatus:Init(homelandFishing)
  self._homelandFishing = homelandFishing
  self._timer = 0
  self._characterManager = self._homelandFishing:HomelandClient():CharacterManager()
  self._mainCharacterController = self._characterManager:MainCharacterController()
  self._isLock = false
end

function HomelandFishingStatus:Enter(param)
  self._timer = 0
  self._isLock = false
  self:OnEnter(param)
end

function HomelandFishingStatus:Exit()
  self:OnExit()
end

function HomelandFishingStatus:Update(deltaTime)
  if self._isLock then
    return
  end
  self._timer = self._timer + deltaTime
  self:OnUpdate(deltaTime)
end

function HomelandFishingStatus:FsmExist()
  self:SetFishRodStatus(false)
  self:OnFsmExit()
end

function HomelandFishingStatus:Destroy()
  self:OnDestroy()
  self._homelandFishing = nil
end

function HomelandFishingStatus:LockStatus()
  self._isLock = true
end

function HomelandFishingStatus:UnLockStatus()
  self._isLock = false
end

function HomelandFishingStatus:LockUI(name)
  GameGlobal.UIStateManager():Lock(name)
  self:SetForbiddenMove(true)
end

function HomelandFishingStatus:UnLockUI(name)
  GameGlobal.UIStateManager():UnLock(name)
  self:SetForbiddenMove(false)
end

function HomelandFishingStatus:ShowDialog(uiName, ...)
  GameGlobal.UIStateManager():ShowDialog(uiName, ...)
end

function HomelandFishingStatus:SwitchStatus(statusType, param)
  self._homelandFishing:SwitchStatus(statusType, param)
end

function HomelandFishingStatus:GetStatusLength()
  return self._timer
end

function HomelandFishingStatus:CharacterTransform()
  return self._characterManager:GetCharacterTransform()
end

function HomelandFishingStatus:PlayAnimation(name)
  self._mainCharacterController:SetAnimatorTrigger(name)
end

function HomelandFishingStatus:PlayAnimationLoop(name)
  self._mainCharacterController:SetAnimatorBool(name, true)
end

function HomelandFishingStatus:StopPlayAnimationLoop(name)
  self._mainCharacterController:SetAnimatorBool(name, false)
end

function HomelandFishingStatus:PlayFishRodAnimation(name)
  self._homelandFishing:PlayFishRodAnimation(name)
end

function HomelandFishingStatus:PlayFishRodAnimationLoop(name)
  self._homelandFishing:PlayFishRodAnimation(name)
end

function HomelandFishingStatus:StopFishRodyAnimationLoop(name)
  self._homelandFishing:StopFishRodyAnimationLoop(name)
end

function HomelandFishingStatus:SetFishRodStatus(status)
  self._homelandFishing:SetFishRodStatus(status)
end

function HomelandFishingStatus:OnEnter(param)
end

function HomelandFishingStatus:OnExit()
end

function HomelandFishingStatus:OnUpdate(deltaTime)
end

function HomelandFishingStatus:FishingStatus()
end

function HomelandFishingStatus:OnFsmExit()
end

function HomelandFishingStatus:OnDestroy()
end

function HomelandFishingStatus:IsInRiver(pos)
  return self._homelandFishing:IsInRiver(pos)
end

function HomelandFishingStatus:IsRiverFishing()
  return self._homelandFishing:IsRiverFishing()
end

function HomelandFishingStatus:IsMatchFishing()
  return self._mainCharacterController:GetIsFishMach()
end

function HomelandFishingStatus:SetForbiddenMove(forbidden)
  self._mainCharacterController:SetForbiddenMove(forbidden, true)
end
