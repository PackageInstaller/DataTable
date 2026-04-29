require("homelandpet_behavior_base")
_class("HomelandPetBehaviorRoam", HomelandPetBehaviorBase)
HomelandPetBehaviorRoam = HomelandPetBehaviorRoam

function HomelandPetBehaviorRoam:Constructor(behaviorType, pet)
  self._moveComponent = self:GetComponent(HomelandPetComponentType.Move)
  self._bubbleComponent = self:GetComponent(HomelandPetComponentType.Bubble)
end

function HomelandPetBehaviorRoam:Enter()
  HomelandPetBehaviorRoam.super.Enter(self)
  local position = HomelandNavmeshTool:GetInstance():GetRandomPositionRing(10, 25, self._pet:GetPosition())
  self._moveComponent:SetTarget(position)
  self._bubbleComponent:Show()
end
