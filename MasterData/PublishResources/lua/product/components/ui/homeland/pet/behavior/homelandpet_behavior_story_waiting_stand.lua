require("homelandpet_behavior_base")
_class("HomelandPetBehaviorStoryWaitingStand", HomelandPetBehaviorBase)
HomelandPetBehaviorStoryWaitingStand = HomelandPetBehaviorStoryWaitingStand

function HomelandPetBehaviorStoryWaitingStand:Constructor(behaviorType, pet)
  HomelandPetBehaviorStoryWaitingStand.super.Constructor(self, behaviorType, pet)
  self._bubbleComponent = self:GetComponent(HomelandPetComponentType.Bubble)
end

function HomelandPetBehaviorStoryWaitingStand:Enter()
  HomelandPetBehaviorStoryWaitingStand.super.Enter(self)
  self._bubbleComponent:Show()
end

function HomelandPetBehaviorStoryWaitingStand:Exit()
  HomelandPetBehaviorStoryWaitingStand.super.Exit(self)
end

function HomelandPetBehaviorStoryWaitingStand:CanInterrupt()
  return true
end

function HomelandPetBehaviorStoryWaitingStand:TriggerSucc(startPos, startRot, id)
  self.triggerSuccParam = {
    startPos,
    startRot,
    id
  }
  self._pet:SetPosition(startPos)
  self._pet:SetRotation(Quaternion.Euler(startRot))
  local ob = self._pet:GetNavMeshObstacle()
  ob.enabled = true
  return true
end
