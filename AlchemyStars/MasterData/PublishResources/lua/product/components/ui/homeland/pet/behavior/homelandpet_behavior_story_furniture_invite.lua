require("homelandpet_behavior_base")
_class("HomelandPetBehaviorFurnitureInvite", HomelandPetBehaviorBase)
HomelandPetBehaviorFurnitureInvite = HomelandPetBehaviorFurnitureInvite

function HomelandPetBehaviorFurnitureInvite:Constructor(behaviorType, pet)
  HomelandPetBehaviorFurnitureInvite.super.Constructor(self, behaviorType, pet)
  self._petInviteManager = self._homelandClient:GetHomelandPetInviteManager()
  self._petManager = self._homelandClient:PetManager()
  self._moveComponent = self:GetComponent(HomelandPetComponentType.Move)
  self._animationComponent = self:GetComponent(HomelandPetComponentType.InteractionAnimation)
  self._interactPoint = nil
end

function HomelandPetBehaviorFurnitureInvite:Enter()
  HomelandPetBehaviorFurnitureInvite.super.Enter(self)
  local building = self._petInviteManager:GetOperateBuilding()
  if building == nil then
    self._pet:GetPetBehavior():RandomBehavior()
    return
  end
  self._interactPoint = building:GetPetInteractPoint()
  if self._interactPoint then
    local targetTransform = building:GetInteractTransform(self._interactPoint:GetIndex())
    if not self._petManager:MainCharacterInteracting(building, targetTransform) then
      self._moveComponent:SetTarget(targetTransform.position)
      if targetTransform.childCount > 0 then
      end
      self._interactPoint:SetInteractObject(self._pet)
      self._pet:SetInteractingBuilding(building)
    else
      self._pet:GetPetBehavior():RandomBehavior()
    end
  else
    self._pet:GetPetBehavior():RandomBehavior()
  end
end

function HomelandPetBehaviorFurnitureInvite:Exit()
  HomelandPetBehaviorFurnitureInvite.super.Exit(self)
  HomelandPetBehaviorInteractingFurniture.super.Exit(self)
  if self._interactPoint then
    self._interactPoint:SetInteractObject(nil)
    self._interactPoint = nil
  end
  self._pet:SetInteractingBuilding(nil)
end

function HomelandPetBehaviorFurnitureInvite:CanInterrupt()
  return true
end

function HomelandPetBehaviorFurnitureInvite:_GetInteractionCfg(interactions)
  local cfg
  local homelandModule = GameGlobal.GetModule(HomelandModule)
  local finishEventList = homelandModule:GetHomeLandEventInfo().finish_event_list
  for _, id in pairs(interactions) do
    if self:_IsUnLock(self._pet:TemplateID(), id, finishEventList) then
      local cfgBuildingPet = Cfg.cfg_homeland_building_pet[id]
      if cfgBuildingPet and (not cfgBuildingPet.petIDs or table.icontains(cfgBuildingPet.petIDs, self._pet:TemplateID()) or table.icontains(cfgBuildingPet.petIDs, self._pet:SkinID())) then
        cfg = cfgBuildingPet
        break
      end
    end
  end
  return cfg
end

function HomelandPetBehaviorFurnitureInvite:_IsUnLock(petID, id, finishEventList)
  return true
end
