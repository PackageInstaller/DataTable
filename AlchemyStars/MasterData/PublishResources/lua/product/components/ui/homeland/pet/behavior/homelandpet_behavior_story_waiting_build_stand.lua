require("homelandpet_behavior_base")
_class("HomelandPetBehaviorStoryWaitingBuildStand", HomelandPetBehaviorBase)
HomelandPetBehaviorStoryWaitingBuildStand = HomelandPetBehaviorStoryWaitingBuildStand

function HomelandPetBehaviorStoryWaitingBuildStand:Constructor(behaviorType, pet)
  HomelandPetBehaviorStoryWaitingBuildStand.super.Constructor(self, behaviorType, pet)
  self._bubbleComponent = self:GetComponent(HomelandPetComponentType.Bubble)
end

function HomelandPetBehaviorStoryWaitingBuildStand:Enter()
  HomelandPetBehaviorStoryWaitingBuildStand.super.Enter(self)
  self._bubbleComponent:Show()
end

function HomelandPetBehaviorStoryWaitingBuildStand:Exit()
  HomelandPetBehaviorStoryWaitingBuildStand.super.Exit(self)
end

function HomelandPetBehaviorStoryWaitingBuildStand:CanInterrupt()
  return true
end

function HomelandPetBehaviorStoryWaitingBuildStand:TriggerSucc(startPos, startRot, id)
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
