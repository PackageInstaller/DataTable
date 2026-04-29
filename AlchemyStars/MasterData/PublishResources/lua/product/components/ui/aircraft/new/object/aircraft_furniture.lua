_class("AircraftFurniture", Object)
AircraftFurniture = AircraftFurniture

function AircraftFurniture:Constructor(req, go, floor, area)
  self._area = area
  self._instanceID = GridHelper.CreateFurnitureInstanceID()
  self._pets = {}
  self._points = {}
  if req then
    go = req.Obj
    self._req = req
  end
  self._go = go
  go:SetActive(true)
  go.layer = AircraftLayer.Furniture
  self._transform = go.transform
  local obs = self._go:GetComponent(typeof(UnityEngine.AI.NavMeshObstacle))
  if obs == nil then
    AirLog("家具没有NavMeshObstacle组件：", self._go.name)
  else
    obs.carving = true
  end
  self._floor = floor
  local grids
  for i = self._transform.childCount - 1, 0, -1 do
    local child = self._transform:GetChild(i)
    if string.find(child.name, "F_Grid=") then
      grids = child
      break
    end
  end
  if grids then
    local localPos = grids.localPosition:Clone()
    self._offset = Vector2(localPos.x / GridHelper.SIZE, localPos.z / GridHelper.SIZE)
    self._offset.x = GridHelper.ToFloat(GridHelper.ToInt(self._offset.x))
    self._offset.y = GridHelper.ToFloat(GridHelper.ToInt(self._offset.y))
    self._gridAreaParent = grids
  end
  self:Init()
  self._tileReleased = false
end

function AircraftFurniture:Init()
  self._cfgID = tonumber(self._go.name)
  local cfg = Cfg.cfg_item_furniture[self._cfgID]
  if cfg == nil then
    Log.exception("[AircraftFurniture] 找不到家具配置：", self._cfgID)
  end
  self._type = cfg.AirFurnitureType
  local model = self._go.transform:Find("model")
  self._hasModel = model.childCount > 0
  self._effectSlot = self._go.transform:Find("EffectSlot")
  if self._hasModel then
    self._furEffect = model:GetChild(0):Find("effect")
    self._modelT = model
  end
  self._animation = model.gameObject:GetComponentInChildren(typeof(UnityEngine.Animation))
  if cfg.FurIdleAction then
    self._idleAnimName = cfg.FurIdleAction
    self:Anim_Play(cfg.FurIdleAction)
  end
  self._petDefaultActionCfg = cfg.DefaultAction
  if cfg.SpecialAction then
    self._petSpecialActionCfg = {}
    for _, value in ipairs(cfg.SpecialAction) do
      local petSkinID = value[1]
      local cfgID = value[2]
      self._petSpecialActionCfg[petSkinID] = cfgID
    end
  end
  local pointsRootGo = self._go.transform:Find("pointsRoot").gameObject
  if pointsRootGo then
    local pointsRoot = pointsRootGo.transform
    local count = pointsRoot.childCount
    if count <= 0 then
      AirLog("家具的交互点数量为", count)
    else
      for i = 0, count - 1 do
        local actionPoint = pointsRoot:GetChild(i)
        local idx = i + 1
        local aircraftFurniturePoint = AircraftFurniturePoint:New(idx, actionPoint)
        self._points[idx] = aircraftFurniturePoint
      end
    end
  else
    AirLog("家具没有交互点：", self._cfgID)
  end
  self._available = #self._points
  self._petOnCount = 0
  self._hasExtraAnim = cfg.HasExtraAnim
end

function AircraftFurniture:Dispose()
  if self._req then
    self._req:Dispose()
  end
  if self._footReqs then
    for _, req in ipairs(self._footReqs) do
      req:Dispose()
    end
  end
  if self._gridAreaReq then
    self._gridAreaReq:Dispose()
  end
  if not self._tileReleased then
    self:OccupyTiles(false)
  end
  self._occupiedTiles = nil
  if self._shaker then
    self._shaker:Kill()
    self._shaker = nil
  end
end

function AircraftFurniture:GetPets()
  local ids = {}
  for id, _ in pairs(self._pets) do
    ids[#ids + 1] = id
  end
  return ids
end

function AircraftFurniture:PopPoint()
  if self._available <= 0 then
    Log.fatal("[AircraftFurniture] no point")
    return
  end
  local target = math.random(1, self._available)
  local i = 1
  for idx, point in ipairs(self._points) do
    if not point:IsOccupied() then
      if i == target then
        self._available = self._available - 1
        point:Occupy()
        return point
      end
      i = i + 1
    end
  end
end

function AircraftFurniture:ReleasePoint(point)
  if not table.icontains(self._points, point) then
    Log.fatal("[AircraftFurniture] 当前家具不包含该点")
  end
  point:Release()
  self._available = self._available + 1
  if self._available > #self._points then
    Log.exception("家具点数量错误，", self._cfgID, "数量：", self._available)
  end
end

function AircraftFurniture:OccupyPointByIndex(idx)
  local point = self._points[idx]
  self._available = self._available - 1
  point:Occupy()
  return point
end

function AircraftFurniture:IsPointOccupied(idx)
  return self._points[idx]:IsOccupied()
end

function AircraftFurniture:AvailableCount()
  return self._available
end

function AircraftFurniture:PopPointByName(name)
  for _, point in ipairs(self._points) do
    if point:Name() == name and not point:IsOccupied() then
      self._available = self._available - 1
      point:Occupy()
      return point
    end
  end
end

function AircraftFurniture:GetPointByName(name)
  for _, point in ipairs(self._points) do
    if point:Name() == name and not point:IsOccupied() then
      return point
    end
  end
end

function AircraftFurniture:HasAvailablePoint(name)
  for _, point in ipairs(self._points) do
    if point:Name() == name and not point:IsOccupied() then
      return true
    end
  end
end

function AircraftFurniture:OccupyAllPoint(occupy)
  for _, point in ipairs(self._points) do
    if occupy then
      point:Occupy()
    else
      point:Release()
    end
  end
  if occupy then
    self._available = 0
  else
    self._available = #self._points
  end
end

function AircraftFurniture:HasPoint(idx)
  return self._points[idx] ~= nil
end

function AircraftFurniture:Floor()
  return self._floor
end

function AircraftFurniture:Type()
  return self._type
end

function AircraftFurniture:Area()
  return self._area
end

function AircraftFurniture:CfgID()
  return self._cfgID
end

function AircraftFurniture:ID()
  Log.exception("家具的ID接口已删除，请使用CfgID()获取家具的配置ID。", debug.traceback())
end

function AircraftFurniture:InstanceID()
  return self._instanceID
end

function AircraftFurniture:MatchKey(key)
  return key == self:GetPstKey()
end

function AircraftFurniture:GetPstKey()
  if self._svrData then
    return string.format("%s|%s|%s|%s|%s", self._svrData.asset_id, self._svrData.area_id, self._svrData.surface, self._svrData.pos_x, self._svrData.pos_z)
  else
    return string.format("%s|%s", self._cfgID, self._area)
  end
end

function AircraftFurniture:EffectSlot()
  return self._effectSlot
end

function AircraftFurniture:IsEmpty()
  return self._available >= #self._points
end

function AircraftFurniture:GetPetActionCfg(skinID)
  local cfg
  if self._petSpecialActionCfg then
    cfg = self._petSpecialActionCfg[skinID]
  end
  if cfg == nil then
    cfg = self._petDefaultActionCfg
  end
  return cfg
end

function AircraftFurniture:OnPetArrive(pet)
  self._pets[pet:TemplateID()] = true
  self._petOnCount = self._petOnCount + 1
end

function AircraftFurniture:OnPetLeave(pet)
  if self._pets[pet:TemplateID()] then
    self._pets[pet:TemplateID()] = nil
    self._petOnCount = self._petOnCount - 1
  else
    Log.exception("[AircraftFurniture] 星灵不在家具上，无法离开。星灵id：", pet:TemplateID(), ", 家具id：", self._cfgID, debug.traceback())
  end
  if self._petOnCount > 0 then
  elseif self._idleAnimName then
    self:Anim_Play(self._idleAnimName)
  end
end

function AircraftFurniture:Anim_Play(name)
  if not self._animation then
    Log.exception("[AircraftFurniture] 找不到Animation不能播放，家具id：", self._cfgID, debug.traceback())
  end
  self._animation:Play(name)
end

function AircraftFurniture:Anim_Stop()
  if self._animation then
    if self._animation.isPlaying then
      local clips = HelperProxy:GetInstance():GetAllAnimationClip(self._animation)
      for i = 0, clips.Length - 1 do
        local clip = clips[i]
        if self._animation:IsPlaying(clip.name) then
          local state = self._animation:get_Item(clip.name)
          state.time = 0
          state.enabled = true
          state.weight = 1
          self._animation:Sample()
          state.enabled = false
          break
        end
      end
    end
    self._animation:Stop()
  end
end

function AircraftFurniture:Animation()
  return self._animation
end

function AircraftFurniture:Transform()
  return self._transform
end

function AircraftFurniture:HasModel()
  return self._hasModel
end

function AircraftFurniture:SetEffectActive(active)
  if self._effectSlot then
    self._effectSlot.gameObject:SetActive(active)
  end
  if self._furEffect then
    self._furEffect.gameObject:SetActive(active)
  end
end

function AircraftFurniture:SetDecorateData(data, newAdder, worldPos, worldRot)
  self._svrData = data
  self._gridPosition = Vector2(GridHelper.ToFloat(data.pos_x), GridHelper.ToFloat(data.pos_z))
  self._rotY = data.rot
  self._surfaceID = data.surface
  local cfg = Cfg.cfg_item_furniture[self._cfgID]
  if cfg == nil then
    Log.exception("找不到家具配置：", self._cfgID)
  end
  self._layer = cfg.Layer
  self._locationType = cfg.LocateType
  self._oprateType = cfg.OprateType
  self._size = Vector2(cfg.Size[1], cfg.Size[2])
  self._ambient = cfg.Atmosphere
  self:SetPosition(worldPos)
  self:SetRotation(worldRot)
end

function AircraftFurniture:SurfaceID()
  return self._surfaceID
end

function AircraftFurniture:GridPosition()
  return self._gridPosition
end

function AircraftFurniture:GridRotY()
  return self._rotY
end

function AircraftFurniture:Size()
  return self._size
end

function AircraftFurniture:Ambient()
  return self._ambient
end

function AircraftFurniture:Offset()
  return self._offset
end

function AircraftFurniture:WorldPosition()
  return self._worldPosition
end

function AircraftFurniture:WorldRotation()
  return self._worldRotation
end

function AircraftFurniture:SetPosition(p)
  self._worldPosition = p
  self._transform.position = p:Clone()
end

function AircraftFurniture:SetRotation(r)
  self._worldRotation = r
  self._transform.rotation = r:Clone()
end

function AircraftFurniture:Layer()
  return self._layer
end

function AircraftFurniture:LocationType()
  return self._locationType
end

function AircraftFurniture:OprateType()
  return self._oprateType
end

function AircraftFurniture:IsThisGO(go)
  return self._go == go
end

function AircraftFurniture:SetActive(active)
  self._go:SetActive(active)
end

function AircraftFurniture:GetSvrData()
  return self._svrData
end

function AircraftFurniture:_showFootprint(show)
  if show then
    if self._footprints then
      for _, go in ipairs(self._footprints) do
        go:SetActive(true)
      end
    elseif self._points and #self._points > 0 then
      self._footReqs = {}
      self._footprints = {}
      for i, point in ipairs(self._points) do
        local target = point:Target()
        local req = ResourceManager:GetInstance():SyncLoadAsset("AircraftFootprint.prefab", LoadType.GameObject)
        self._footReqs[i] = req
        local t = req.Obj.transform
        t:SetParent(target)
        t.localPosition = Vector3.zero
        t.localRotation = Quaternion.identity
        local go = req.Obj
        go:SetActive(true)
        self._footprints[i] = go
      end
    end
  elseif self._footprints then
    for _, go in ipairs(self._footprints) do
      go:SetActive(false)
    end
  end
end

function AircraftFurniture:_showGridArea(show, pickUp)
  if show then
    if self._gridAreaParent == nil then
      Log.exception("家具没有FGrid节点:", self._cfgID)
    end
    if not self._areaGridImage then
      local req = ResourceManager:GetInstance():SyncLoadAsset("AircraftFurnitureArea.prefab", LoadType.GameObject)
      self._gridAreaReq = req
      local go = req.Obj
      local t = go.transform
      go:SetActive(true)
      self._areaGridCanvas = go
      t:SetParent(self._gridAreaParent)
      t.localPosition = Vector3(0, -GridHelper.PICKUPHEIGHT + 0.05, 0)
      t.localRotation = Quaternion.identity
      local uiview = go:GetComponent(typeof(UIView))
      local image = uiview:GetUIComponent("Image", "Image")
      local rect = uiview:GetUIComponent("RectTransform", "Image")
      rect.sizeDelta = Vector2(self._size.x / 0.006 * GridHelper.SIZE, self._size.y / 0.006 * GridHelper.SIZE)
      self._areaGridImage = image
      trans = t
    end
    self._areaGridCanvas:SetActive(true)
    if pickUp then
      self._areaGridCanvas.transform.localPosition = Vector3(0, -GridHelper.PICKUPHEIGHT + 0.05, 0)
    else
      self._areaGridCanvas.transform.localPosition = Vector3(0, 0.05, 0)
    end
  elseif self._areaGridCanvas then
    self._areaGridCanvas:SetActive(false)
  end
end

function AircraftFurniture:ShowAreaAndFootprint(show, isPickUp)
  self:_showGridArea(show, isPickUp)
  self:_showFootprint(show)
end

function AircraftFurniture:ShowOutline()
  if self._outline == nil then
    self._outline = self._modelT.gameObject:AddComponent(typeof(OutlineComponent))
  end
  self._outline.enabled = true
end

function AircraftFurniture:SetOutlineColor(color)
  if self._outline then
    self._outline.outlinColor = color
  end
end

function AircraftFurniture:HideOutline()
  if self._outline then
    self._outline.enabled = false
  end
end

function AircraftFurniture:SetAreaGridValid(valid)
  if valid then
    self._areaGridImage.color = Color(0.0196078431372549, 0.9372549019607843, 0.9411764705882353)
  else
    self._areaGridImage.color = Color(0.996078431372549, 0.2196078431372549, 0.2196078431372549)
  end
end

function AircraftFurniture:SetTiles(tiles)
  self._occupiedTiles = tiles
end

function AircraftFurniture:OccupyTiles(occupy)
  if self._occupiedTiles then
    for _, tile in ipairs(self._occupiedTiles) do
      if occupy then
        tile:Occupy(self._layer, self._instanceID)
      else
        tile:Release(self._layer, self._instanceID)
      end
    end
    self._tileReleased = not occupy
  end
end

function AircraftFurniture:DoShake(onFinish)
  local offset = self._transform.right * 0.5
  if self._hasModel then
    self._shaker = self._modelT:DOShakePosition(0.3, offset, 50, 90, false):OnComplete(function()
      self._shaker = nil
      if onFinish then
        onFinish()
      end
    end)
  end
end

function AircraftFurniture:HasExtraAnim()
  return self._hasExtraAnim
end

function AircraftFurniture.Default()
  local f = {}
  
  function f.GridPosition()
    return Vector2(2, 2)
  end
  
  function f.GridRotation()
    return 30
  end
  
  function f.Size()
    return Vector2(2, 2)
  end
  
  function f.Offset()
    return Vector3(-1, -1)
  end
  
  return f
end

_class("AircraftFurniturePoint", Object)
AircraftFurniturePoint = AircraftFurniturePoint

function AircraftFurniturePoint:Constructor(idx, point)
  self._idx = idx
  self._occupied = false
  self._name = point.name
  self._actionPoint = point
  self._targetPoint = point:GetChild(0)
end

function AircraftFurniturePoint:MovePoint()
  return self._targetPoint.position
end

function AircraftFurniturePoint:Target()
  return self._targetPoint
end

function AircraftFurniturePoint:InteractionPoint()
  return self._actionPoint.position, self._actionPoint.rotation
end

function AircraftFurniturePoint:IsOccupied()
  return self._occupied
end

function AircraftFurniturePoint:Occupy()
  if self._occupied then
    Log.exception("[AircraftFurniture] 当前点已被占据")
  end
  self._occupied = true
end

function AircraftFurniturePoint:Release()
  if not self._occupied then
    Log.exception("[AircraftFurniture] 当前点未被占据，不用释放", debug.traceback())
  end
  self._occupied = false
end

function AircraftFurniturePoint:Index()
  return self._idx
end

function AircraftFurniturePoint:Name()
  return self._name
end
