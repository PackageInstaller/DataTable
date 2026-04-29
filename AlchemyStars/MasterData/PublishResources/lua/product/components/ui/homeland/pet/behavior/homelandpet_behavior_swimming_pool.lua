require("homelandpet_behavior_base")
_class("HomelandPetBehaviorSwimmingPool", HomelandPetBehaviorBase)
HomelandPetBehaviorSwimmingPool = HomelandPetBehaviorSwimmingPool
local HomelandPetSwimStage = {
  Coming = 1,
  Entering = 2,
  Swimming = 3,
  Leaving = 4,
  Exiting = 5,
  Finish = 6
}
_enum("HomelandPetSwimStage", HomelandPetSwimStage)

function HomelandPetBehaviorSwimmingPool:Constructor(behaviorType, pet)
  HomelandPetBehaviorSwimmingPool.super.Constructor(self, behaviorType, pet)
  self._buildManager = self._homelandClient:BuildManager()
  self._petManager = self._homelandClient:PetManager()
  self._homelandPetManager = self._homelandClient:PetManager()
  self._moveComponent = self:GetComponent(HomelandPetComponentType.Move)
  self._swimComponent = self:GetComponent(HomelandPetComponentType.Swim)
  self._petModule = GameGlobal.GetModule(PetModule)
  self._pet = pet
  self._navMeshAgent = self._pet:GetNavMeshAgent()
  self._floatEffectName = "eff_yyc_yy_shuihua01.prefab"
  self._swimEffectName = "eff_yyc_yy_shuihua02.prefab"
  self._floatEffect = nil
  self._swimEffect = nil
end

function HomelandPetBehaviorSwimmingPool:Enter()
  HomelandPetBehaviorSwimmingPool.super.Enter(self)
  if self._params ~= nil then
    self._buildingset = true
  else
    self._buildingset = false
  end
  local buildings = self._buildManager:GetBuildingsFilter(function(building)
    return self:BuildingFilter(building)
  end)
  local buildingCount = table.count(buildings)
  if buildingCount <= 0 then
    self._pet:GetPetBehavior():RandomBehavior()
    return
  end
  local petSkinID = self._needChangeSkinID or self._pet:SkinID()
  local cfgSwimmingPoolPet = Cfg.cfg_homeland_swimming_pool_pet[petSkinID]
  self._cfgSwimmingPoolPet = cfgSwimmingPoolPet
  if not cfgSwimmingPoolPet then
    return
  end
  local building = buildings[math.random(1, buildingCount)]
  self._building = building
  self._freePath, self._insidePos, self._outsidePos = self._building:GetPathPos()
  if not self._freePath then
    self._pet:GetPetBehavior():RandomBehavior()
    return
  end
  self._moveComponent:SetTarget(self._outsidePos)
  self._stage = HomelandPetSwimStage.Coming
  self._waterLineHeight = self._building:GetSwimmingPoolWaterHeight()
  if self._pet:GetMotionType() == HomelandPetMotionType.Swim then
    self:OnChangeSwimStage(HomelandPetSwimStage.Swimming)
  end
  self._nextBehavior = nil
  self._nextBehaviorArgs = nil
end

function HomelandPetBehaviorSwimmingPool:OnChangeSwimStage(stage)
  if not self._building then
    return
  end
  self._stage = stage
  if self._stage == HomelandPetSwimStage.Leaving then
    self._swimComponent:Exit()
    if not self._freePath then
      self._freePath, self._insidePos, self._outsidePos = self._building:GetPathPos()
    end
    self._moveComponent:Stop()
    self._moveComponent:Resting()
    self._moveComponent:SetTarget(self._insidePos)
  elseif self._stage == HomelandPetSwimStage.Swimming then
    self._startSwimTime = GameGlobal:GetInstance():GetCurrentTime()
    local swimDurationTime = self._cfgBehaviorLib.InteractLoopTime
    self._finishSwimTime = self._startSwimTime + swimDurationTime
    self._moveComponent:Stop()
    self._moveComponent:Resting()
    self._moveComponent:SetTarget(self._pet:GetPosition())
    self._swimComponent:Play(self._building)
  elseif self._stage == HomelandPetSwimStage.Finish then
    self:OnFinishDoSomething()
  end
end

function HomelandPetBehaviorSwimmingPool:IsInSwimmingPool()
  return self._stage ~= HomelandPetSwimStage.Coming and self._stage ~= HomelandPetSwimStage.Finish
end

function HomelandPetBehaviorSwimmingPool:Update(dms)
  HomelandPetBehaviorSwimmingPool.super.Update(self, dms)
  if not self._building or self._building:IsDelete() then
    self:OnChangeSwimStage(HomelandPetSwimStage.Finish)
    return
  end
  if self._stage == HomelandPetSwimStage.Coming then
    if self._moveComponent.state == HomelandPetComponentState.Success then
      local distance = Vector3.Distance(self._pet:GetPosition(), self._outsidePos)
      if 1 < distance then
        self._moveComponent:Stop()
        self._moveComponent:Resting()
        self._moveComponent:SetTarget(self._outsidePos)
        return
      end
      if self._building:GetSwimmingPoolIsFull() then
        self._pet:GetPetBehavior():RandomBehavior()
        return
      end
      GameGlobal.EventDispatcher():Dispatch(GameEventType.OnPetBehaviorInteractingFurniture, true, self._pet, self._building, self._buildingset)
      self._building:AddSwimmingPet(self._pet)
      self._pet:SetInteractingBuilding(self._building)
      self._moveComponent:Stop()
      self._moveComponent:Resting()
      self._moveComponent:SetTarget(self._insidePos)
      self._stage = HomelandPetSwimStage.Entering
      self._navMeshAgent.areaMask = 5
      if self._needChangeSkinID then
        self._pet:SetPoolAndOldSkin(self._building, self._pet:SkinID(), self._pet:ClothSkinID())
        self:ChangePetSkin(self._needChangeSkinID, self._needChangeClothSkinID)
      end
      self._pet:LoadExtraAnimation()
      self._animation = self._pet:GetAnimation()
    end
  elseif self._stage == HomelandPetSwimStage.Entering then
    self:CheckPetMotionType()
    if self._moveComponent.state == HomelandPetComponentState.Success then
      self._stage = HomelandPetSwimStage.Swimming
      self._startSwimTime = GameGlobal:GetInstance():GetCurrentTime()
      local swimDurationTime = self._cfgBehaviorLib.InteractLoopTime
      self._finishSwimTime = self._startSwimTime + swimDurationTime
      self._navMeshAgent.areaMask = 4
      if self._freePath then
        self._building:GiveBackPath(self._freePath)
        self._freePath = nil
      end
      self:ShowFloatEffect(true)
      self._swimComponent:Play(self._building)
    end
  elseif self._stage == HomelandPetSwimStage.Swimming then
    self:CheckPetMotionType()
    local curTime = GameGlobal:GetInstance():GetCurrentTime()
    if curTime > self._finishSwimTime then
      self._swimComponent:Exit()
      if not self._freePath then
        self._freePath, self._insidePos, self._outsidePos = self._building:GetPathPos()
      end
      self._moveComponent:Stop()
      self._moveComponent:Resting()
      self._moveComponent:SetTarget(self._insidePos)
      self._stage = HomelandPetSwimStage.Leaving
    end
  elseif self._stage == HomelandPetSwimStage.Leaving then
    self:CheckPetMotionType()
    if self._moveComponent.state == HomelandPetComponentState.Success then
      self._stage = HomelandPetSwimStage.Exiting
      self._moveComponent:Stop()
      self._moveComponent:Resting()
      self._moveComponent:SetTarget(self._outsidePos)
      self._navMeshAgent.areaMask = 5
    end
  elseif self._stage == HomelandPetSwimStage.Exiting then
    self:CheckPetMotionType()
    if self._moveComponent.state == HomelandPetComponentState.Success then
      self._stage = HomelandPetSwimStage.Finish
    end
  elseif self._stage == HomelandPetSwimStage.Finish then
    self:OnFinishDoSomething()
  end
end

function HomelandPetBehaviorSwimmingPool:OnFinishDoSomething()
  self._buildingset = false
  if not self._building then
    return
  end
  GameGlobal.EventDispatcher():Dispatch(GameEventType.OnPetBehaviorInteractingFurniture, false, self._pet, self._building, self._buildingset)
  self._building:RemovSwimmingPet(self._pet)
  self._pet:SetInteractingBuilding(nil)
  if self._freePath then
    self._building:GiveBackPath(self._freePath)
    self._freePath = nil
  end
  self._navMeshAgent.areaMask = 1
  if self._moveComponent then
    self._moveComponent:Stop()
    self._moveComponent:Resting()
  end
  if self._swimComponent then
    self._swimComponent:Exit()
  end
  self._pet:SetMotionType(HomelandPetMotionType.None)
  if self._pet._petTransform.localPosition.y ~= 0 then
    self._pet._petTransform.localPosition = Vector3(0, 0, 0)
  end
  if self._animation then
    self._animation:CrossFade(HomelandPetAnimName.Stand)
  end
  if self._floatEffect then
    self._floatEffect:SetActive(false)
  end
  if self._swimEffect then
    self._swimEffect:SetActive(false)
  end
  self._building = nil
  if self._nextBehavior then
    if self._nextBehaviorArgs:IsMaxInteractable() then
      self._pet:GetPetBehavior():RandomBehavior()
      return
    end
    local behaviourMgr = self._pet:GetPetBehavior()
    behaviourMgr:OnChangeToNextBehavior(self._nextBehavior, self._nextBehaviorArgs)
    self._nextBehavior = nil
    self._nextBehaviorArgs = nil
  else
    self._pet:GetPetBehavior():RandomBehavior()
  end
end

function HomelandPetBehaviorSwimmingPool:Exit()
  HomelandPetBehaviorSwimmingPool.super.Exit(self)
  if self._freePath then
    self._building:GiveBackPath(self._freePath)
    self._freePath = nil
  end
  GameGlobal.EventDispatcher():Dispatch(GameEventType.OnPetBehaviorInteractingFurniture, false, self._pet, self._building, self._buildingset)
  self._pet:SetInteractingBuilding(nil)
end

function HomelandPetBehaviorSwimmingPool:BeInvitedToNextBehavior(nextBehavior, args)
  self._nextBehavior = nextBehavior
  self._nextBehaviorArgs = args
  if self._stage == HomelandPetSwimStage.Coming then
    self:OnChangeSwimStage(HomelandPetSwimStage.Finish)
  elseif self._stage >= HomelandPetSwimStage.Leaving then
  else
    self:OnChangeSwimStage(HomelandPetSwimStage.Leaving)
  end
end

function HomelandPetBehaviorSwimmingPool:CheckPetMotionType()
  if not self._animation then
    self._animation = self._pet:GetAnimation()
  end
  local petTransform = self._pet._petTransform
  local motionType = self._pet:GetMotionType()
  local offsetPosY = self._pet:GetPosition().y + self._cfgSwimmingPoolPet.ChestHeight - self._waterLineHeight
  if motionType == HomelandPetMotionType.None then
    if offsetPosY <= 0 then
      self._pet:SetMotionType(HomelandPetMotionType.Swim)
      if self._animation:IsPlaying(HomelandPetAnimName.Stand) then
        self._animation:CrossFade(HomelandPetAnimName.Float)
      elseif self._animation:IsPlaying(HomelandPetAnimName.Walk) then
        self._animation:CrossFade(HomelandPetAnimName.Swim)
      elseif self._animation:IsPlaying(HomelandPetAnimName.Run) then
        self._animation:CrossFade(HomelandPetAnimName.FastSwim)
      end
    end
    if petTransform.localPosition.y ~= 0 then
      petTransform.localPosition = Vector3(0, 0, 0)
    end
  elseif motionType == HomelandPetMotionType.Swim then
    if 0 < offsetPosY then
      self._pet:SetMotionType(HomelandPetMotionType.None)
      if self._animation:IsPlaying(HomelandPetAnimName.Float) then
        self._animation:CrossFade(HomelandPetAnimName.Stand)
      elseif self._animation:IsPlaying(HomelandPetAnimName.Swim) then
        self._animation:CrossFade(HomelandPetAnimName.Walk)
      elseif self._animation:IsPlaying(HomelandPetAnimName.FastSwim) then
        self._animation:CrossFade(HomelandPetAnimName.Run)
      end
      self:ShowFloatEffect(false)
      self:ShowSwimEffect(false)
    end
    if petTransform.localPosition.y ~= -offsetPosY then
      petTransform.localPosition = Vector3(0, -offsetPosY, 0)
    end
  end
end

function HomelandPetBehaviorSwimmingPool:BuildingFilter(building, noCheckfull)
  local cfgSwimmingPool = Cfg.cfg_homeland_swimming_pool[building:GetBuildId()]
  if not cfgSwimmingPool then
    return false
  end
  self._cfgSwimmingPool = cfgSwimmingPool
  if not building:IsSwimmable() then
    return false
  end
  local petIsInSwimmingPool = building:PetIsInSwimmingPool(self._pet)
  local swimmingPoolIsFull = building:GetSwimmingPoolIsFull()
  if not petIsInSwimmingPool and swimmingPoolIsFull and not noCheckfull then
    return false
  end
  if Vector3.Distance(self._pet:GetPosition(), building:Pos()) > cfgSwimmingPool.Range then
    return false
  end
  self._needChangeSkinID = nil
  local unRestraint = false
  if not cfgSwimmingPool.PetSkinIDs then
    unRestraint = true
  else
    local canSwimSkinIds = {}
    local canSwimClothSkinIds = {}
    local skinsStateData = self._petModule:GetPetSkinsData(self._pet:TemplateID())
    if skinsStateData then
      local obtainedSkinInfo = skinsStateData.skin_info
      if obtainedSkinInfo then
        for _, skinInfo in pairs(obtainedSkinInfo) do
          if skinInfo then
            local skinPetCfg = Cfg.cfg_pet_skin({
              id = skinInfo.skin_id
            })
            local skinIDStr = string.gsub(skinPetCfg[1].Prefab, ".prefab", "")
            local skinID = tonumber(skinIDStr)
            if table.icontains(cfgSwimmingPool.PetSkinIDs, skinID) then
              table.insert(canSwimSkinIds, skinID)
              table.insert(canSwimClothSkinIds, skinInfo.skin_id)
            end
          end
        end
      end
    end
    if table.count(canSwimSkinIds) > 0 then
      if table.icontains(canSwimSkinIds, self._pet:SkinID()) then
      else
        local swimwearIndex = math.random(1, #canSwimSkinIds)
        self._needChangeSkinID = canSwimSkinIds[swimwearIndex]
        self._needChangeClothSkinID = canSwimClothSkinIds[swimwearIndex]
      end
      unRestraint = true
    end
  end
  return unRestraint
end

function HomelandPetBehaviorSwimmingPool:ShowFloatEffect(visible)
  if not self._floatEffect then
    self._floatEffectResRequest = ResourceManager:GetInstance():SyncLoadAsset(self._floatEffectName, LoadType.GameObject)
    if self._floatEffectResRequest then
      self._floatEffect = self._floatEffectResRequest.Obj
      local tran = self._floatEffect.transform
      tran.parent = self._pet:AgentTransform()
      local offsetPosY = self._cfgSwimmingPool.WaterHeight - self._pet:GetPosition().y
      tran.localPosition = Vector3(0, offsetPosY, 0)
      tran.localRotation = Quaternion.identity
    end
  end
  if not self._floatEffect then
    return
  end
  self._floatEffect:SetActive(visible)
end

function HomelandPetBehaviorSwimmingPool:ShowSwimEffect(visible)
  if not self._swimEffect then
    self._swimEffectResRequest = ResourceManager:GetInstance():SyncLoadAsset(self._swimEffectName, LoadType.GameObject)
    if self._swimEffectResRequest then
      self._swimEffect = self._swimEffectResRequest.Obj
      self._swimEffect:SetActive(true)
      local tran = self._swimEffect.transform
      tran.parent = self._pet:AgentTransform()
      local offsetPosY = self._cfgSwimmingPool.WaterHeight - self._pet:GetPosition().y
      tran.localPosition = Vector3(0, offsetPosY, 0)
      tran.localRotation = Quaternion.identity
    end
  end
  if not self._swimEffect then
    return
  end
  self._swimEffect:SetActive(visible)
end

function HomelandPetBehaviorSwimmingPool:ChangePetSkin(SkinID, ClothSkinID)
  if self._pet._miniMapVisible then
    GameGlobal.EventDispatcher():Dispatch(GameEventType.MinimapRemoveIcon, HomelandMapIconType.Pet, self._pet._data:TmpID())
  end
  local req = ResourceManager:GetInstance():SyncLoadAsset(self._cfgSwimmingPoolPet.ChangeSkinEffectName, LoadType.GameObject)
  if req then
    req.Obj:SetActive(true)
    local tran = req.Obj.transform
    tran.position = self._pet:AgentTransform().position
    tran.localRotation = Quaternion.identity
  end
  self._homelandPetManager:ChangePetSkin(self._pet, SkinID, ClothSkinID)
  if self._pet._miniMapVisible then
    GameGlobal.EventDispatcher():Dispatch(GameEventType.MinimapAddIcon, HomelandMapIconType.Pet, self._pet._data:TmpID(), self._pet._petAgentTransform, self._pet)
  end
  self._pet:PlayMaterialAnim("eff_yyc_hz_switch_glow")
  self._pet:ReloadBehaviorComponent()
end
