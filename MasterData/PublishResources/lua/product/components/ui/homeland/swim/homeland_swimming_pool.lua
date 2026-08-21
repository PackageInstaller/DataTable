_class("HomelandSwimmingPool", HomeBuildingFather)
HomelandSwimmingPool = HomelandSwimmingPool

function HomelandSwimmingPool:Constructor(insID, architecture, cfg)
  self._isInited = false
end

function HomelandSwimmingPool:InitSwimmingPool(architecture)
  if self._isInited then
    return
  end
  self._uiModule = GameGlobal.GetUIModule(HomelandModule)
  self._isVisit = self._uiModule:GetClient():IsVisit()
  self._svrTimeModule = GameGlobal.GetModule(SvrTimeModule)
  self._homelandModule = GameGlobal.GetModule(HomelandModule)
  self._pstid = architecture.pstid
  self._buildID = self:GetBuildId()
  self._transform = self:Transform()
  local cfgSwimmingPool = Cfg.cfg_homeland_swimming_pool[self._buildID]
  self._waterHeight = self._transform.position.y + cfgSwimmingPool.WaterHeight
  local pathRoot = GameObjectHelper.FindChild(self._transform, "Path")
  local swimAreaRoot = GameObjectHelper.FindChild(self._transform, "PetSwimArea")
  if not swimAreaRoot then
    return
  end
  self._swimAreaCollider = swimAreaRoot:GetComponent(typeof(UnityEngine.BoxCollider))
  local roleSwimAreaRoot = GameObjectHelper.FindChild(self._transform, "RoleSwimArea")
  if not roleSwimAreaRoot then
    return
  end
  self._roleSwimAreaCollider = roleSwimAreaRoot:GetComponent(typeof(UnityEngine.BoxCollider))
  local poolAreaRoot = GameObjectHelper.FindChild(self._transform, "RolePoolArea")
  if not poolAreaRoot then
    return
  end
  self._poolAreaCollider = poolAreaRoot:GetComponent(typeof(UnityEngine.CapsuleCollider))
  self._pathList = {}
  for i = 0, pathRoot.childCount - 1 do
    local childTransform = pathRoot:GetChild(i)
    self._pathList[#self._pathList + 1] = childTransform
  end
  self._commingPetList = {}
  self._swimmingPetList = {}
  self._swimmingPetCountMax = cfgSwimmingPool.PetCountMax
  self:OnReCheckPetSwimState()
  self._timerHandler = GameGlobal.Timer():AddEventTimes(1, TimerTriggerCount.Infinite, function()
    self:CheckRoleSwimsuit()
  end)
  self._roleInSwimArea = false
  if self._saveBuildingCallback == nil then
    self._saveBuildingCallback = GameHelper:GetInstance():CreateCallback(self.OnSaveBuilding, self)
    GameGlobal.EventDispatcher():AddCallbackListener(GameEventType.HomelandBuildOnSaveBuilding, self._saveBuildingCallback)
  end
end

function HomelandSwimmingPool:GetInteractingPetCountMax()
  return self._swimmingPetCountMax
end

function HomelandSwimmingPool:Dispose()
  HomelandSwimmingPool.super.Dispose(self)
  if self._saveBuildingCallback then
    GameGlobal.EventDispatcher():RemoveCallbackListener(GameEventType.HomelandBuildOnSaveBuilding, self._saveBuildingCallback)
    self._saveBuildingCallback = nil
  end
  self:OnRemoveAllSwimmingPet()
  if self._characterController and self._characterController:IsWearingSwimsuit() and self._characterController._charGO then
    self._characterController:OnChangeSwimsuit()
  end
  if self._timerHandler then
    GameGlobal.Timer():CancelEvent(self._timerHandler)
    self._timerHandler = nil
  end
end

function HomelandSwimmingPool:OnSaveBuilding(updateBuildings, deleteBuildings)
  for _, building in ipairs(updateBuildings) do
    if self._pstid == building._pstid then
      self:OnReCheckPetSwimState()
      self:ResetInteractPoint()
      self:RefreshInteractPoint()
      return
    end
  end
end

function HomelandSwimmingPool:OnReCheckPetSwimState()
  self:OnDissolveHomeInteractFollow()
  local tmpList = {}
  for _, pet in pairs(self._swimmingPetList) do
    if pet:IsAlive() then
      table.insert(tmpList, pet)
    end
  end
  self._petManager = self._homelandClient:PetManager()
  local allPet = self._petManager:GetAllPets()
  for key, pet in pairs(allPet) do
    local closestPoint = self._roleSwimAreaCollider:ClosestPoint(pet:GetPosition())
    local dir = Vector3.Distance(closestPoint, pet:GetPosition())
    local inRange = false
    if dir <= 0 then
      inRange = true
    end
    if table.icontains(tmpList, pet) then
      if not inRange then
        local behavior = pet:GetPetBehavior()
        local behaviorSwimmingPool = behavior:GetHomelandPetBehavior(HomelandPetBehaviorType.SwimmingPool)
        if behaviorSwimmingPool then
          behaviorSwimmingPool:OnChangeSwimStage(HomelandPetSwimStage.Finish)
        end
      end
    elseif inRange then
      pet:_RandomBornPosition()
    end
  end
end

function HomelandSwimmingPool:OnRemoveAllSwimmingPet()
  self:OnDissolveHomeInteractFollow()
  local tmpList = {}
  for _, pet in pairs(self._swimmingPetList) do
    if pet:IsAlive() then
      table.insert(tmpList, pet)
    end
  end
  for _, pet in pairs(tmpList) do
    local behavior = pet:GetPetBehavior()
    local behaviorSwimmingPool = behavior:GetHomelandPetBehavior(HomelandPetBehaviorType.SwimmingPool)
    if behaviorSwimmingPool then
      behaviorSwimmingPool:OnChangeSwimStage(HomelandPetSwimStage.Finish)
    end
  end
  self._swimmingPetList = {}
end

function HomelandSwimmingPool:OnDissolveHomeInteractFollow()
  local homeModule = GameGlobal.GetModule(HomelandModule)
  local uiHomeModule = homeModule:GetUIModule()
  local homeClient = uiHomeModule:GetClient()
  local followList = homeClient:PetManager():GetFollowPets()
  if followList and table.count(followList) > 0 then
    local tmpList = {}
    for _, pet in pairs(followList) do
      table.insert(tmpList, pet)
    end
    for _, pet in pairs(tmpList) do
      if table.icontains(self._swimmingPetList, pet) then
        table.removev(self._homelandClient:PetManager()._followPets, pet)
      end
    end
  end
end

function HomelandSwimmingPool:IsSwimmable()
  if self:GetBuildId() == 5271001 then
    return self:IsAreaCleaned(52710011)
  end
  return false
end

function HomelandSwimmingPool:OnHangPointCleaned(hangPointID)
  if self:GetBuildId() == 5271001 and self:IsAreaCleaned(52710011) then
    GameGlobal.EventDispatcher():Dispatch(GameEventType.HomeBuildingSwimmingUnlock, self:GetBuildId())
  end
end

function HomelandSwimmingPool:GetSwimmingPoolIsFull()
  return table.count(self._swimmingPetList) >= self._swimmingPetCountMax
end

function HomelandSwimmingPool:AddSwimmingPet(pet)
  table.insert(self._swimmingPetList, pet)
end

function HomelandSwimmingPool:RemovSwimmingPet(pet)
  table.removev(self._swimmingPetList, pet)
end

function HomelandSwimmingPool:PetIsInSwimmingPool(pet)
  return table.icontains(self._swimmingPetList, pet)
end

function HomelandSwimmingPool:GetSwimmingPoolWaterHeight()
  return self._waterHeight
end

function HomelandSwimmingPool:GetPathPos()
  local freePath = self:GetFreePath()
  if not freePath then
    return nil, nil, nil
  end
  local insidePos = GameObjectHelper.FindChild(freePath, "inside").position
  local outsidePos = GameObjectHelper.FindChild(freePath, "outside").position
  return freePath, insidePos, outsidePos
end

function HomelandSwimmingPool:GetFreePath()
  if not self._pathList or table.count(self._pathList) == 0 then
    return
  end
  local index = math.random(1, #self._pathList)
  local freePath = self._pathList[index]
  table.removev(self._pathList, freePath)
  return freePath
end

function HomelandSwimmingPool:GiveBackPath(pathTransform)
  self._pathList[#self._pathList + 1] = pathTransform
end

function HomelandSwimmingPool:GetSwimRandomPos()
  if not self._swimAreaCollider then
    return
  end
  local boxcollider = self._swimAreaCollider
  local posX = boxcollider.center.x + UnityEngine.Random.Range(-boxcollider.size.x, boxcollider.size.x) * 0.5
  local posZ = boxcollider.center.z + UnityEngine.Random.Range(-boxcollider.size.z, boxcollider.size.z) * 0.5
  local pos = Vector3(posX, 0, posZ)
  pos = boxcollider.transform:TransformPoint(pos)
  return pos
end

function HomelandSwimmingPool:GetRoleSwimAreaCollider()
  return self._roleSwimAreaCollider
end

function HomelandSwimmingPool:GetPoolAreaCollider()
  return self._poolAreaCollider
end

function HomelandSwimmingPool:Interactable()
  return self:IsSwimmable()
end

function HomelandSwimmingPool:CheckRoleSwimsuit()
  if self._homelandClient:CurrentMode() == HomelandMode.Build then
    return
  end
  if not self._roleSwimAreaCollider then
    return
  end
  local curRoleInSwimArea = self:OnCheckRoleInSwimmingArea()
  if self._roleInSwimArea == false and curRoleInSwimArea and self._characterController:IsNotWearingSwimsuit() then
    ToastManager.ShowHomeToast(StringTable.Get("str_homeland_invite_role_cannot_swim"))
  end
  if self._roleInSwimArea == false and curRoleInSwimArea == true and self._characterController:IsWearingSwimsuit() then
    GameGlobal.EventDispatcher():Dispatch(GameEventType.OnChangeUIHomelandButtonSprintShow, false)
  end
  if self._roleInSwimArea == true and curRoleInSwimArea == false and self._characterController:IsWearingSwimsuit() then
    GameGlobal.EventDispatcher():Dispatch(GameEventType.OnChangeUIHomelandButtonSprintShow, true)
  end
  if self._roleInSwimArea ~= curRoleInSwimArea and self._characterController:IsWearingSwimsuit() then
    local homeModule = GameGlobal.GetModule(HomelandModule)
    local uiHomeModule = homeModule:GetUIModule()
    local homeClient = uiHomeModule:GetClient()
    local followList = homeClient:PetManager():GetFollowPets()
    if followList and table.count(followList) > 0 then
      local tmpList = {}
      for _, pet in pairs(followList) do
        table.insert(tmpList, pet)
      end
      for _, pet in pairs(tmpList) do
        GameGlobal.EventDispatcher():Dispatch(GameEventType.OnHomeInteractFollow, false, pet)
        if curRoleInSwimArea == false then
          local behavior = pet:GetPetBehavior()
          behavior:ChangeBehavior(HomelandPetBehaviorType.SwimmingPool)
          local behaviorSwimmingPool = behavior:GetHomelandPetBehavior(HomelandPetBehaviorType.SwimmingPool)
          if behaviorSwimmingPool then
            behaviorSwimmingPool:OnChangeSwimStage(HomelandPetSwimStage.Swimming)
          end
        end
      end
    end
  end
  self._roleInSwimArea = curRoleInSwimArea
end

function HomelandSwimmingPool:OnCheckRoleInSwimmingArea()
  if not self._characterController then
    local characterManager = self._homelandClient:CharacterManager()
    self._characterController = characterManager:MainCharacterController()
  end
  if not self._characterController._charTrans then
    return false
  end
  if not self._swimmingPoolArea then
    local homeBuildingFatherArea = self._areaList[#self._areaList]
    self._swimmingPoolArea = homeBuildingFatherArea:GetHomeArea()
  end
  local posOffset = self._characterController._charTrans.position
  local posWork = Vector2(posOffset.x, posOffset.z)
  if self._swimmingPoolArea:OnOutSide(posWork) then
    return false
  end
  local rolePos = self._characterController:Position()
  local inRange = false
  local closestPoint = self._roleSwimAreaCollider:ClosestPoint(rolePos)
  local dir = Vector3.Distance(closestPoint, rolePos)
  if dir <= 0 then
    inRange = true
  end
  return inRange
end
