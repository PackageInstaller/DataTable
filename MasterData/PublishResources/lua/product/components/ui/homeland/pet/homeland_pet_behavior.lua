_class("HomelandPetBehavior", Object)
HomelandPetBehavior = HomelandPetBehavior

function HomelandPetBehavior:Constructor(pet)
  self._pet = pet
  self._allBehaviors = {}
  self._curBehavior = nil
  self._homelandClient = self._pet:GetHomelandClient()
  self._behaviorFactory = self._homelandClient:PetManager():GetBehaviorFactory()
  self._totalWeight = 0
  self._weightArray = {}
  self._cfgBehavior = Cfg.cfg_homeland_pet[self._pet:TemplateID()]
  self:_InitBehaviors()
  self._coolingBehaviors = {}
  self._tempCoolingBehaviorTypes = {}
  self._curBehaviorArgs = {}
  self._lastBehaviorArgs = {}
  self._storyArg = {}
  self._storyCallback = nil
end

function HomelandPetBehavior:_InitBehaviors()
  if not self._cfgBehavior then
    Log.error("Homeland Pet No Behavior Cfg.", self._pet:TemplateID())
    return
  end
  for _, behaviorTypeWeight in pairs(self._cfgBehavior.Behaviors) do
    local behaviorType = behaviorTypeWeight[1]
    if not self._allBehaviors[behaviorType] then
      self._allBehaviors[behaviorType] = self._behaviorFactory:CreateHomelandPetBehavior(behaviorType, self._pet)
    end
  end
end

function HomelandPetBehavior:GetHomelandPetBehavior(behaviorType)
  return self._allBehaviors[behaviorType]
end

function HomelandPetBehavior:ReloadBehaviorComponent()
  for _, behavior in pairs(self._allBehaviors) do
    behavior:ReLoadBehaviorComponent()
  end
end

function HomelandPetBehavior:Update(deltaTime)
  if not self._curBehavior then
    return
  end
  self:_UpdateCoolingBehavior(deltaTime)
  if self._curBehavior:Done() then
    self:_RandomBehavior()
  end
  self._curBehavior:Update(deltaTime)
end

function HomelandPetBehavior:RandomBehavior()
  self:_RandomBehavior()
end

function HomelandPetBehavior:_RandomBehavior()
  if self._pet:IsOccupied() then
    local tb = {
      [HomelandPetOccupiedType.Treasure] = HomelandPetBehaviorType.TreasureIdle,
      [HomelandPetOccupiedType.StoryWaiting] = HomelandPetBehaviorType.StoryWaitingStand
    }
    local occupiedType = self._pet:GetOccupiedType()
    local behaviorType = tb[occupiedType]
    if behaviorType then
      self:ChangeBehavior(behaviorType)
      return
    end
  end
  if not self._cfgBehavior then
    return
  end
  if self._curBehavior then
    local cfg = self._curBehavior:GetCfg()
    if cfg.NextBehaviorType then
      self:ChangeBehavior(cfg.NextBehaviorType)
      return
    end
  end
  local behaviorType = HomelandPetBehaviorType.Free
  local totalWeight = self:_GetTotalWeight()
  if 0 < totalWeight then
    local randomWeight = math.random(1, totalWeight)
    for _type, _weight in pairs(self._weightArray) do
      if randomWeight > _weight[1] and randomWeight <= _weight[2] then
        behaviorType = _type
        break
      end
    end
  end
  self:ChangeBehavior(behaviorType)
end

function HomelandPetBehavior:_GetTotalWeight()
  self._totalWeight = 0
  self._weightArray = {}
  for _, _typeWeight in pairs(self._cfgBehavior.Behaviors) do
    if not self:InCooling(_typeWeight[1]) and 0 < _typeWeight[2] then
      local weight = self._totalWeight + _typeWeight[2]
      self._weightArray[_typeWeight[1]] = {
        self._totalWeight,
        weight
      }
      self._totalWeight = weight
    end
  end
  return self._totalWeight
end

function HomelandPetBehavior:StartBehavior(behaviorType)
  if behaviorType then
    self:ChangeBehavior(behaviorType)
  else
    self:_RandomBehavior()
  end
end

function HomelandPetBehavior:ChangeBehavior(behaviorType, args, isInteract, index)
  local nextBehavior = self._allBehaviors[behaviorType]
  if not nextBehavior then
    Log.error("HomelandPet Have't This Behavior. behaviorType:", behaviorType)
    return
  end
  self._lastBehaviorArgs = self._curBehaviorArgs
  self._curBehaviorArgs = {
    behaviorType = behaviorType,
    args = args,
    isInteract = isInteract,
    index = index
  }
  self:_AddCoolingBehavior(nextBehavior)
  if not self._curBehavior then
    self._curBehavior = nextBehavior
    self._curBehavior:OnEnter(args, index)
    self._curBehavior:Enter()
  else
    if self._curBehavior:CanInterrupt() then
      if isInteract and self._curBehavior:GetBehaviorType() == HomelandPetBehaviorType.SwimmingPool then
        self._curBehavior:BeInvitedToNextBehavior(nextBehavior, args)
        return
      end
      self._curBehavior:Exit()
      self._curBehavior = nextBehavior
      self._curBehavior:OnEnter(args, index)
      self._curBehavior:Enter()
    else
    end
  end
  self._pet:OnBehaviorChanged()
end

function HomelandPetBehavior:CanChange(behaviorType)
  return self._curBehavior and self._curBehavior:CanInterrupt()
end

function HomelandPetBehavior:OnChangeToNextBehavior(nextBehavior, args)
  self._curBehavior = nextBehavior
  self._curBehavior:OnEnter(args)
  self._curBehavior:Enter()
  self._pet:OnBehaviorChanged()
end

function HomelandPetBehavior:Dispose()
  for _, behavior in pairs(self._allBehaviors) do
    behavior:Dispose()
  end
  self._allBehaviors = nil
  self._curBehavior = nil
  self._coolingBehaviors = nil
end

function HomelandPetBehavior:RecoverBehaviorToLast()
  if self._lastBehaviorArgs then
    local args = self._lastBehaviorArgs
    self:ChangeBehavior(args.behaviorType, args.args, args.isInteract, args.index)
    if self._storyCallback and (args.behaviorType == HomelandPetBehaviorType.StoryWaitingBuild or HomelandPetBehaviorType.StoryWaitingBuildStand or HomelandPetBehaviorType.StoryWaitingStand or HomelandPetBehaviorType.StoryWaitingWalk) then
      local storyArgs = self._storyArg
      self._storyCallback(storyArgs.furniture, storyArgs.interactID, storyArgs.id)
    end
  else
    Log.fatal("没有上一个状态！")
  end
end

function HomelandPetBehavior:SetStoryBehaviorArgs(args, callback)
  self._storyArg = args
  self._storyCallback = callback
end

function HomelandPetBehavior:GetCurBehavior()
  return self._curBehavior
end

function HomelandPetBehavior:GetHasBehaviors()
  return self._allBehaviors ~= nil
end

function HomelandPetBehavior:GetCurBehaviorType()
  return self._curBehavior and self._curBehavior:GetBehaviorType()
end

function HomelandPetBehavior:_AddCoolingBehavior(behavior)
  if not behavior then
    return
  end
  local behaviorType = behavior:GetBehaviorType()
  if self._coolingBehaviors[behaviorType] then
    Log.info("Homeland Pet Behavior In Cooling.", behaviorType)
    return
  end
  if behavior:CD() <= 0 then
    return
  end
  self._coolingBehaviors[behaviorType] = behavior:CD()
end

function HomelandPetBehavior:_UpdateCoolingBehavior(deltaTime)
  if table.count(self._coolingBehaviors) <= 0 then
    return
  end
  table.clear(self._tempCoolingBehaviorTypes)
  for _behaviorType, _ in pairs(self._coolingBehaviors) do
    if self._curBehavior:GetBehaviorType() ~= _behaviorType then
      self._coolingBehaviors[_behaviorType] = self._coolingBehaviors[_behaviorType] - deltaTime
      if self._coolingBehaviors[_behaviorType] <= 0 then
        table.insert(self._tempCoolingBehaviorTypes, _behaviorType)
      end
    end
  end
  if 0 < #self._tempCoolingBehaviorTypes then
    for _, behaviorType in pairs(self._tempCoolingBehaviorTypes) do
      self._coolingBehaviors[behaviorType] = nil
    end
  end
end

function HomelandPetBehavior:InCooling(behaviorType)
  return self._coolingBehaviors[behaviorType]
end
