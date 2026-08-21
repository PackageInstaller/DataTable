require("homelandpet_behavior_base")
_class("HomelandPetBehaviorGreetPlayer", HomelandPetBehaviorBase)
HomelandPetBehaviorGreetPlayer = HomelandPetBehaviorGreetPlayer

function HomelandPetBehaviorGreetPlayer:Constructor(behaviorType, pet)
  self._animationComponent = self:GetComponent(HomelandPetComponentType.Animation)
  self._bubbleComponent = self:GetComponent(HomelandPetComponentType.Bubble)
end

function HomelandPetBehaviorGreetPlayer:Enter()
  HomelandPetBehaviorGreetPlayer.super.Enter(self)
  if self._pet:GetMotionType() == HomelandPetMotionType.Swim then
    self._animationComponent:Play(HomelandPetAnimName.Float)
  else
    self._animationComponent:Play(HomelandPetAnimName.Greet)
  end
  self._bubbleComponent:Show()
  self._rotateTime = 0
end

function HomelandPetBehaviorGreetPlayer:Update(dms)
  HomelandPetBehaviorGreetPlayer.super.Update(self, dms)
  self._rotateTime = self._rotateTime + dms
  if self._rotateTime > self._cfgBehaviorLib.RotateTime * 1000 then
    return
  end
  local target = self._homelandClient:CharacterManager():MainCharacterController():Position()
  local from = self._pet:GetPosition()
  local dir = target - from
  dir.y = 0
  local rot = Quaternion.LookRotation(dir, Vector3.up)
  self._pet:SetRotation(rot)
end

function HomelandPetBehaviorGreetPlayer:HideBubble()
  self._bubbleComponent:Hide()
end
