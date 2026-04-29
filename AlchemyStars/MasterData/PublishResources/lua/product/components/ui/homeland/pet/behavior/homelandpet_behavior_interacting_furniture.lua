require("homelandpet_behavior_base")
_class("HomelandPetBehaviorInteractingFurniture", HomelandPetBehaviorBase)
HomelandPetBehaviorInteractingFurniture = HomelandPetBehaviorInteractingFurniture

function HomelandPetBehaviorInteractingFurniture:Constructor(behaviorType, pet)
  HomelandPetBehaviorInteractingFurniture.super.Constructor(self, behaviorType, pet)
  self._buildManager = self._homelandClient:BuildManager()
  self._petManager = self._homelandClient:PetManager()
  self._inviteManager = self._homelandClient:GetHomelandPetInviteManager()
  self._moveComponent = self:GetComponent(HomelandPetComponentType.Move)
  self._animationComponent = self:GetComponent(HomelandPetComponentType.InteractionAnimation)
  self._interactPoint = nil
  self._modeChangeProcessType = HomelandPetModeChangeProcessType.Custom
end

function HomelandPetBehaviorInteractingFurniture:Enter()
  HomelandPetBehaviorInteractingFurniture.super.Enter(self)
  local buildings = self._buildManager:GetBuildingsFilter(function(building)
    return self:_BuildingFilter(building)
  end)
  local buildingCount = table.count(buildings)
  if self._params ~= nil then
    self._isInvite = true
  elseif buildingCount <= 0 then
    self._pet:GetPetBehavior():RandomBehavior()
    return
  end
  local building, interactPointIndex
  if self._isInvite then
    building = self._params
    interactPointIndex = self._index
  else
    building = buildings[math.random(1, buildingCount)]
  end
  self._holdbuilding = building
  self._interactPoint, interactPointIndex = building:GetPetInteractPoint(interactPointIndex)
  if self._interactPoint then
    GameGlobal.EventDispatcher():Dispatch(GameEventType.OnPetBehaviorInteractingFurniture, true, self._pet, self._holdbuilding, self._isInvite, nil)
    local targetTransform = building:GetInteractTransform(self._interactPoint:GetIndex())
    if not self._petManager:MainCharacterInteracting(building, targetTransform) then
      self._moveComponent:SetTarget(targetTransform.position)
      if 0 < targetTransform.childCount then
        local cfgArchitecture = Cfg.cfg_item_architecture[building:GetBuildId()]
        local cfgBuildingPet = self:_GetInteractionCfg(cfgArchitecture.Interaction, interactPointIndex)
        if cfgBuildingPet then
          local loopTime = self._cfgBehaviorLib.InteractLoopTime or 0
          if self._isInvite then
            loopTime = math.max(loopTime, self._inviteManager:GetLimitCD())
          end
          self._animationComponent:Play(cfgBuildingPet, building, self._interactPoint, targetTransform, targetTransform:GetChild(0), loopTime, self._isInvite)
        else
          self._pet:GetPetBehavior():RandomBehavior()
          return
        end
      end
      self._interactPoint:SetInteractObject(self._pet)
      building:AddInteractingPet(self._pet)
      self._pet:SetInteractingBuilding(building)
    else
      self._pet:GetPetBehavior():RandomBehavior()
    end
  else
    self._pet:GetPetBehavior():RandomBehavior()
  end
end

function HomelandPetBehaviorInteractingFurniture:Exit()
  GameGlobal.EventDispatcher():Dispatch(GameEventType.OnPetBehaviorInteractingFurniture, false, self._pet, self._holdbuilding, self._isInvite, nil)
  HomelandPetBehaviorInteractingFurniture.super.Exit(self)
  if self._interactPoint then
    self._interactPoint:SetInteractObject(nil)
    self._interactPoint = nil
  end
  if self._holdbuilding then
    self._holdbuilding:RemoveInteractingPet(self._pet)
  end
  self._pet:SetInteractingBuilding(nil)
  self._holdbuilding = nil
  self._isInvite = false
  self._params = nil
  self._index = nil
end

function HomelandPetBehaviorInteractingFurniture:_BuildingFilter(building)
  if Vector3.Distance(self._pet:GetPosition(), building:Pos()) > self._cfgBehaviorLib.Range then
    return false
  end
  local cfgArchitecture = Cfg.cfg_item_architecture[building:GetBuildId()]
  if not cfgArchitecture or not cfgArchitecture.Interaction then
    return false
  end
  local unRestraint = false
  for _, value in pairs(cfgArchitecture.Interaction) do
    local cfgBuildingPet = Cfg.cfg_homeland_building_pet[value]
    if cfgBuildingPet then
      if not cfgBuildingPet.petIDs then
        unRestraint = true
        break
      end
      if table.icontains(cfgBuildingPet.petIDs, self._pet:TemplateID()) or table.icontains(cfgBuildingPet.petIDs, self._pet:SkinID()) then
        unRestraint = true
        break
      end
    end
  end
  return unRestraint
end

function HomelandPetBehaviorInteractingFurniture:_GetInteractionCfg(interactions, interactPointIndex)
  local function IPICheckFunc(cfgBuildingPet)
    if interactPointIndex then
      if cfgBuildingPet.InteractPointIndex then
        return table.icontains(cfgBuildingPet.InteractPointIndex, interactPointIndex)
      else
        return true
      end
    else
      return true
    end
  end
  
  local cfg
  local homelandModule = GameGlobal.GetModule(HomelandModule)
  local finishEventList = homelandModule:GetHomeLandEventInfo().finish_event_list
  for _, id in pairs(interactions) do
    if self:_IsUnLock(self._pet:TemplateID(), id, finishEventList) then
      local cfgBuildingPet = Cfg.cfg_homeland_building_pet[id]
      if cfgBuildingPet and IPICheckFunc(cfgBuildingPet) and (not cfgBuildingPet.petIDs or table.icontains(cfgBuildingPet.petIDs, self._pet:TemplateID()) or table.icontains(cfgBuildingPet.petIDs, self._pet:SkinID())) then
        cfg = cfgBuildingPet
        break
      end
    end
  end
  return cfg
end

function HomelandPetBehaviorInteractingFurniture:_IsUnLock(petID, id, finishEventList)
  local cfgs = Cfg.cfg_homeland_event({PetID = petID})
  if not cfgs then
    return true
  end
  for _, cfg in pairs(cfgs) do
    if cfg.RewardsInteractID and table.icontains(cfg.RewardsInteractID, id) then
      for eventID, eventTime in pairs(finishEventList) do
        if eventID == cfg.ID then
          return true
        end
      end
      return false
    end
  end
  return true
end
