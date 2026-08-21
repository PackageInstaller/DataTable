require("homelandpet_behavior_base")
_class("HomelandPetBehaviorStoryWaitingBuild", HomelandPetBehaviorBase)
HomelandPetBehaviorStoryWaitingBuild = HomelandPetBehaviorStoryWaitingBuild

function HomelandPetBehaviorStoryWaitingBuild:Constructor(behaviorType, pet)
  HomelandPetBehaviorStoryWaitingBuild.super.Constructor(self, behaviorType, pet)
  self._animationComponent = self:GetComponent(HomelandPetComponentType.InteractionAnimation)
  self._bubbleComponent = self:GetComponent(HomelandPetComponentType.Bubble)
  self._modeChangeProcessType = HomelandPetModeChangeProcessType.Custom
end

function HomelandPetBehaviorStoryWaitingBuild:Enter()
  HomelandPetBehaviorStoryWaitingBuild.super.Enter(self)
  self._bubbleComponent:Show()
end

function HomelandPetBehaviorStoryWaitingBuild:Exit()
  HomelandPetBehaviorStoryWaitingBuild.super.Exit(self)
  if self._interactPoint then
    self._interactPoint:SetInteractObject(nil)
    self._interactPoint = nil
  end
  GameGlobal.EventDispatcher():Dispatch(GameEventType.OnPetBehaviorInteractingFurniture, false, self._pet, self._holdbuilding, false, nil)
  self._holdbuilding = nil
  self._pet:SetInteractingBuilding(nil)
  self._pet:SetNavMeshObstacleEnabled(true)
end

function HomelandPetBehaviorStoryWaitingBuild:CanInterrupt()
  return true
end

function HomelandPetBehaviorStoryWaitingBuild:TriggerSucc(furniture, interactID, id)
  local succ = true
  self.triggerSuccParam = {
    furniture,
    interactID,
    id
  }
  self._interactPoint = furniture:GetPetInteractPoint()
  if self._interactPoint then
    local targetTr = furniture:GetInteractTransform(self._interactPoint:GetIndex())
    if targetTr.childCount > 0 then
      self._pet:SetPosition(targetTr.position)
      self._pet:SetRotation(targetTr.rotation)
      local cfgBuildingPet = Cfg.cfg_homeland_building_pet[interactID]
      self._animationComponent:Play(cfgBuildingPet, furniture, self._interactPoint, targetTr, targetTr:GetChild(0), 86400000)
    else
      Log.error("###[HomelandPetBehaviorStoryWaitingBuild] 剧情触发失败，因为targetTr.childCount < 0,id[", id, "]")
      succ = false
    end
    self._interactPoint:SetInteractObject(self._pet)
    self._pet:SetInteractingBuilding(furniture)
    self._holdbuilding = furniture
    GameGlobal.EventDispatcher():Dispatch(GameEventType.OnPetBehaviorInteractingFurniture, true, self._pet, self._holdbuilding, false, nil)
  else
    Log.error("###[HomelandPetBehaviorStoryWaitingBuild] 剧情触发失败，因为没有家具交互点,id[", id, "]")
    succ = false
  end
  return succ
end
