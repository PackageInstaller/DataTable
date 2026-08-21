require("homelandpet_behavior_base")
_class("HomelandPetBehaviorFollowing", HomelandPetBehaviorBase)
HomelandPetBehaviorFollowing = HomelandPetBehaviorFollowing

function HomelandPetBehaviorFollowing:Constructor(behaviorType, pet)
  HomelandPetBehaviorFollowing.super.Constructor(self, behaviorType, pet)
  self._fixedTime = 500
  self._yieldTime = 0
  self._stopDis = 2
  self._runDis = 5
  self._isMoving = false
  self._petTransform = self._pet:AgentTransform()
  self._moveComponent = self:GetComponent(HomelandPetComponentType.Move)
  self._animationComponent = self:GetComponent(HomelandPetComponentType.Animation)
  self._speedState = nil
  self._followPosOffset = Vector3(0, 0, 0)
end

function HomelandPetBehaviorFollowing:Enter()
  HomelandPetBehaviorFollowing.super.Enter(self)
  local followList = self._homelandClient:PetManager():GetFollowPets()
  local petid = self._pet:PstID()
  local followIdx = 1
  for i = 1, #followList do
    local _pet = followList[i]
    if _pet:PstID() == petid then
      followIdx = i
      break
    end
  end
  local followMgr = self._homelandClient:HomePetFollowManager()
  self._followPosOffset = followMgr:GetPosOffset(followIdx)
  self._followRot = followMgr:GetRot(followIdx)
  if self._followPosOffset then
    local character = self._homelandClient:CharacterManager()
    self._targetTransform = character:GetCharacterTransform()
  elseif followIdx == 1 then
    local character = self._homelandClient:CharacterManager()
    self._targetTransform = character:GetCharacterTransform()
  else
    local followPet = followList[followIdx - 1]
    self._targetTransform = followPet:AgentTransform()
  end
end

function HomelandPetBehaviorFollowing:ReloadTarget()
  local character = self._homelandClient:CharacterManager()
  self._targetTransform = character:GetCharacterTransform()
end

function HomelandPetBehaviorFollowing:GetTargetPos()
  local pos = self._targetTransform.position
  local rot = self._targetTransform.rotation
  local worldPos = pos + rot * self._followPosOffset
  return worldPos
end

function HomelandPetBehaviorFollowing:Update(dms)
  HomelandPetBehaviorFollowing.super.Update(self, dms)
  local petPos = self._petTransform.position
  local charaPos
  if self._followPosOffset then
    charaPos = self:GetTargetPos()
  else
    charaPos = self._targetTransform.position
  end
  if self:Distance(petPos, charaPos) <= self._stopDis then
    self._moveComponent:Stop()
    if self._speedState ~= 1 then
      self._animationComponent:PlayStand()
      self._speedState = 1
      if self._followPosOffset and self._followRot then
        local targetRot = self._targetTransform.localRotation
        local v3 = targetRot:ToEulerAngles()
        local tov3 = Vector3(v3.x, v3.y + self._followRot, v3.z)
        self._petTransform:DOLocalRotate(tov3, 0.2)
      end
    end
    self._animationComponent:Resting()
  else
    if self._yieldTime - dms < 0 then
      if self:Distance(petPos, charaPos) <= self._runDis then
        if self._speedState ~= 2 then
          self._pet:SetSpeed(self._pet.walkSpeed)
          self._speedState = 2
        end
      else
        if self._speedState ~= 3 then
          self._pet:SetSpeed(self._pet.runSpeed)
          self._speedState = 3
        end
        if self._pet:GetSpeed() ~= self._pet.runSpeed then
          self._pet:SetSpeed(self._pet.runSpeed)
        end
      end
      self._yieldTime = self._fixedTime
      self._moveComponent:SetTarget(charaPos)
      self._moveComponent:Resting()
    end
    self._yieldTime = self._yieldTime - dms
  end
end

function HomelandPetBehaviorFollowing:Distance(v1, v2)
  local v1x = v1.x
  local v1z = v1.z
  local v2x = v2.x
  local v2z = v2.z
  local dis = math.sqrt((v1x - v2x) * (v1x - v2x) + (v1z - v2z) * (v1z - v2z))
  return dis
end

function HomelandPetBehaviorFollowing:CanInterrupt()
  return true
end

function HomelandPetBehaviorFollowing:Exit()
  HomelandPetBehaviorFollowing.super.Exit(self)
  self._pet:SetSpeed(self._pet.walkSpeed)
end
