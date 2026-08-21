_class("HomelandAquarium", HomeBuilding)
HomelandAquarium = HomelandAquarium

function HomelandAquarium:Constructor(insID, architecture, cfg)
  self._isInited = false
end

function HomelandAquarium:InitAquarium(architecture)
  if self._isInited then
    return
  end
  self._isInited = true
  self._uiModule = GameGlobal.GetUIModule(HomelandModule)
  self._isVisit = self._uiModule:GetClient():IsVisit()
  self._svrTimeModule = GameGlobal.GetModule(SvrTimeModule)
  self._homelandModule = GameGlobal.GetModule(HomelandModule)
  self._pstid = architecture.pstid
  self._buildID = self:GetBuildId()
  self._buildPstID = self:GetBuildPstId()
  self._transform = self:Transform()
  self._isActive = true
  self._fishingAreaPointList = self:GetFishingAreaPolygon()
  if self._isVisit then
    self:RefreshAquarium()
  else
    self:_InitAquarium()
  end
  self._refreshWithBuild = false
  self._timerHandler = GameGlobal.Timer():AddEventTimes(1, TimerTriggerCount.Infinite, function()
    if self._homelandClient:CurrentMode() == HomelandMode.Build then
      if self._wishingFishs and self._refreshWithBuild == false then
        for k, v in pairs(self._wishingFishs) do
          v:Destroy()
        end
        self._wishingFishs = {}
        self._refreshWithBuild = true
      end
    else
      self:OnCheckAquariumActive()
      if self._refreshWithBuild == true then
        self:RefreshAquarium()
        self._refreshWithBuild = false
      end
    end
  end)
end

function HomelandAquarium:Dispose()
  HomelandAquarium.super.Dispose(self)
  self:ClearFishs()
  HomelandWishingConst.ForceUpdateAquariumFishData()
  if self._timerHandler then
    GameGlobal.Timer():CancelEvent(self._timerHandler)
    self._timerHandler = nil
  end
end

function HomelandAquarium:ClearFishs()
  if self._wishingFishs then
    for k, v in pairs(self._wishingFishs) do
      v:Destroy()
    end
  end
  self:RemoveEvents()
end

function HomelandAquarium:OnSaveBuilding(updateBuildings, deleteBuildings)
  for _, building in ipairs(deleteBuildings) do
    if self._pstid == building._pstid then
      HomelandWishingConst.DeleteAquariumFish(self._pstid)
      return
    end
  end
  for _, building in ipairs(updateBuildings) do
    if self._pstid == building._pstid then
      self._refreshWithBuild = true
      return
    end
  end
end

function HomelandAquarium:RemoveEvents()
  if self._addAquariumFishCallback then
    GameGlobal.EventDispatcher():RemoveCallbackListener(GameEventType.AquariumAddFish, self._addAquariumFishCallback)
    self._addAquariumFishCallback = nil
  end
  if self._removeAquariumFishCallback then
    GameGlobal.EventDispatcher():RemoveCallbackListener(GameEventType.AquariumRemoveFish, self._removeAquariumFishCallback)
    self._removeAquariumFishCallback = nil
  end
  if self._refreshAquariumFishCallback then
    GameGlobal.EventDispatcher():RemoveCallbackListener(GameEventType.AquariumRefreshFish, self._refreshAquariumFishCallback)
    self._refreshAquariumFishCallback = nil
  end
  if self._saveBuildingCallback then
    GameGlobal.EventDispatcher():RemoveCallbackListener(GameEventType.HomelandBuildOnSaveBuilding, self._saveBuildingCallback)
    self._saveBuildingCallback = nil
  end
end

function HomelandAquarium:_InitAquarium()
  if self._addAquariumFishCallback == nil then
    self._addAquariumFishCallback = GameHelper:GetInstance():CreateCallback(self.AddAquariumFish, self)
    GameGlobal.EventDispatcher():AddCallbackListener(GameEventType.AquariumAddFish, self._addAquariumFishCallback)
  end
  if self._removeAquariumFishCallback == nil then
    self._removeAquariumFishCallback = GameHelper:GetInstance():CreateCallback(self.RemoveAquariumFish, self)
    GameGlobal.EventDispatcher():AddCallbackListener(GameEventType.AquariumRemoveFish, self._removeAquariumFishCallback)
  end
  if self._refreshAquariumFishCallback == nil then
    self._refreshAquariumFishCallback = GameHelper:GetInstance():CreateCallback(self.RefreshAquariumFish, self)
    GameGlobal.EventDispatcher():AddCallbackListener(GameEventType.AquariumRefreshFish, self._refreshAquariumFishCallback)
  end
  if self._saveBuildingCallback == nil then
    self._saveBuildingCallback = GameHelper:GetInstance():CreateCallback(self.OnSaveBuilding, self)
    GameGlobal.EventDispatcher():AddCallbackListener(GameEventType.HomelandBuildOnSaveBuilding, self._saveBuildingCallback)
  end
  self:RefreshAquarium()
end

function HomelandAquarium:RefreshAquarium()
  if self._wishingFishs then
    for k, v in pairs(self._wishingFishs) do
      v:Destroy()
    end
  end
  self._wishingFishs = {}
  local aquariumFishList = self._isVisit and HomelandVisitHelper.GetAquariumFishList(self._pstid) or HomelandWishingConst.GetCurAquariumFishList(self._pstid)
  for i = 1, #aquariumFishList do
    local fish = aquariumFishList[i]
    self._wishingFishs[fish.InstanceId] = HomelandAquariumFishModel:New(self._transform, fish.ID, fish.InstanceId, self._buildID, self)
  end
  self:NotifyFishs()
end

function HomelandAquarium:AddAquariumFish(buildPstID, id, fishInstanceId)
  if buildPstID ~= self._buildPstID then
    return
  end
  if self._wishingFishs[fishInstanceId] then
    return
  end
  self._wishingFishs[fishInstanceId] = HomelandAquariumFishModel:New(self._transform, id, fishInstanceId, self._buildID, self)
  self:NotifyFishs()
end

function HomelandAquarium:RemoveAquariumFish(buildPstID, fishInstanceId)
  if buildPstID ~= self._buildPstID then
    return
  end
  if self._wishingFishs[fishInstanceId] then
    self._wishingFishs[fishInstanceId]:Destroy()
    self._wishingFishs[fishInstanceId] = nil
  end
end

function HomelandAquarium:RefreshAquariumFish(buildPstID)
  if buildPstID ~= self._buildPstID then
    return
  end
  local lastList = {}
  if self._wishingFishs then
    for k, v in pairs(self._wishingFishs) do
      table.insert(lastList, v)
    end
  end
  self._wishingFishs = {}
  local aquariumFishList = HomelandWishingConst.GetCurAquariumFishList(self._pstid)
  for i = 1, #aquariumFishList do
    local fish = aquariumFishList[i]
    local fishID = fish.ID
    local homelandAquariumFishModel
    for k, v in pairs(lastList) do
      if v._id == fishID then
        homelandAquariumFishModel = v
        lastList[k] = nil
        break
      end
    end
    if homelandAquariumFishModel then
      self._wishingFishs[fish.InstanceId] = homelandAquariumFishModel
    else
      self._wishingFishs[fish.InstanceId] = HomelandAquariumFishModel:New(self._transform, fish.ID, fish.InstanceId, self._buildID, self)
    end
  end
  for k, v in pairs(lastList) do
    v:Destroy()
  end
  self:NotifyFishs()
end

function HomelandAquarium:NotifyFishs()
  if self._wishingFishs then
    for k, v in pairs(self._wishingFishs) do
      v:NotifyFishs(self._wishingFishs)
    end
  end
end

function HomelandAquarium:AquariumIsActive()
  return self._isActive
end

function HomelandAquarium:OnCheckAquariumActive()
  self._isActive = false
  local isDelete = self:IsDelete()
  if isDelete then
    return
  end
  if not self._camera then
    local cameraMgr = self._homelandClient:CameraManager()
    if cameraMgr then
      local homelandFollowCameraController = cameraMgr:FollowCameraController()
      self._camera = homelandFollowCameraController:CameraCmp()
    end
    if not self._camera then
      return
    end
  end
  local distance = Vector3.Distance(self._transform.position, self._camera.gameObject.transform.position)
  if 25 < distance then
    return
  end
  local inCameraField = false
  for _, pos in ipairs(self._fishingAreaPointList) do
    inCameraField = self:_CheckInCameraField(pos)
    if inCameraField then
      break
    end
  end
  if inCameraField == false then
    return
  end
  self._isActive = true
end

function HomelandAquarium:_CheckInCameraField(position)
  local viewPoint = self._camera:WorldToViewportPoint(position)
  local dir = (position - self._camera.gameObject.transform.position).normalized
  local dot = Vector3.Dot(self._camera.gameObject.transform.forward, dir)
  return 0 < dot and 0 <= viewPoint.x and viewPoint.x <= 1 and 0 <= viewPoint.y and 1 >= viewPoint.y
end

function HomelandAquarium:GetFishingAreaPolygon()
  local fishingAreaObj = GameObjectHelper.FindChild(self._transform, "AreaRoot")
  local areaNode = {}
  for i = 0, fishingAreaObj.childCount - 1 do
    local childTransform = fishingAreaObj:GetChild(i)
    areaNode[#areaNode + 1] = childTransform.position
  end
  return areaNode
end
