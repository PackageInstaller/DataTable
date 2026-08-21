_class("AircraftArea", Object)
AircraftArea = AircraftArea

function AircraftArea:Constructor(main, id, areaGo, room, getTile)
  self._main = main
  self._id = id
  self._floor = Cfg.cfg_aircraft_area[id].Floor
  self._go = areaGo
  self._room = room
  self._isLock = self:checkLock()
  if self._id == 3 then
    self._isLock = false
  end
  self._tileGetter = getTile
  local box = areaGo:GetComponent(typeof(UnityEngine.BoxCollider))
  local pos = areaGo.transform.position + box.center - areaGo.transform.forward * (box.size.z / 2)
  self._center = pos
  self._furnitures = {}
  self:FlushEditData()
  self._entered = false
end

function AircraftArea:Refresh(room)
  self._room = room
  self._isLock = self:checkLock()
  self:FlushEditData()
  self._entered = false
end

function AircraftArea:checkLock()
  local space = Cfg.cfg_aircraft_area[self._id].SpaceId
  self._spaceID = space
  if space then
    if not self._room then
      return true
    end
    local type = self._room:LogicRoomType()
    if type >= AirRoomType.AmusementBegin and type <= AirRoomType.AmusementEnd and self._room:Level() <= 1 then
      return true
    end
  end
  return false
end

function AircraftArea:Dispose()
  for id, surface in pairs(self._surfaces) do
    surface:Dispose()
  end
  for _, furniture in pairs(self._furnitures) do
    furniture:Dispose()
  end
end

function AircraftArea:Floor()
  return self._floor
end

function AircraftArea:CenterPos()
  return self._center
end

function AircraftArea:IsThis(go)
  return self._go == go
end

function AircraftArea:ID()
  return self._id
end

function AircraftArea:CameraID()
  return self._defaultCameraId
end

function AircraftArea:GetCameraCfg(type)
  return self._cameraCfg[type]
end

function AircraftArea:GetFurniture(id)
  for _, fur in pairs(self._furnitures) do
    if fur:CfgID() == id then
      return fur
    end
  end
end

function AircraftArea:Furnitures()
  return self._furnitures
end

function AircraftArea:SpaceID()
  return self._spaceID
end

function AircraftArea:FlushEditData()
  local cfg = Cfg.cfg_aircraft_area[self._id]
  local cfgSurs = AircraftGrids[cfg.Floor]
  self._defaultCameraId = cfg.Cam[1]
  self._cameraCfg = {}
  self._cameraCfg[LocationType.Floor] = self._defaultCameraId
  if cfg.Cam[2] and cfg.Cam[2] > 0 then
    self._cameraCfg[LocationType.Wall] = cfg.Cam[2]
  end
  if cfg.Cam[3] and 0 < cfg.Cam[3] then
    self._cameraCfg[LocationType.Ceiling] = cfg.Cam[3]
  end
  local surfaces = {}
  for id, cfgSur in pairs(cfgSurs) do
    local w = cfgSur.Width
    local h = cfgSur.Height
    local cfgTiles = cfgSur.Tiles
    local tiles = {}
    local count = 0
    for i = 1, w do
      for j = 1, h do
        local cfgTile = cfgTiles[i][j]
        if cfgTile and self:checkTile(cfgTile) then
          if tiles[i] == nil then
            tiles[i] = {}
          end
          tiles[i][j] = self._tileGetter(cfg.Floor, id, i, j)
          count = count + 1
        end
      end
    end
    if 0 < count then
      surfaces[id] = AircraftSurface:New(cfgSur, tiles)
    end
  end
  self._surfaces = surfaces
  self:RefreshFurniture()
end

function AircraftArea:RefreshSurfaces(room)
  self._room = room
  self._isLock = self:checkLock()
  if self._surfaces then
    for _, sur in pairs(self._surfaces) do
      sur:Dispose()
    end
  end
  self._surfaces = nil
  local cfg = Cfg.cfg_aircraft_area[self._id]
  local cfgSurs = AircraftGrids[cfg.Floor]
  local surfaces = {}
  for id, cfgSur in pairs(cfgSurs) do
    local w = cfgSur.Width
    local h = cfgSur.Height
    local cfgTiles = cfgSur.Tiles
    local tiles = {}
    local count = 0
    for i = 1, w do
      for j = 1, h do
        local cfgTile = cfgTiles[i][j]
        if cfgTile and self:checkTile(cfgTile) then
          if tiles[i] == nil then
            tiles[i] = {}
          end
          tiles[i][j] = self._tileGetter(cfg.Floor, id, i, j)
          count = count + 1
        end
      end
    end
    if 0 < count then
      surfaces[id] = AircraftSurface:New(cfgSur, tiles)
    end
  end
  self._surfaces = surfaces
end

function AircraftArea:checkTile(cfg)
  if cfg.Area1 == self._id or cfg.Area2 == self._id then
    if self._isLock then
      return cfg.Unlock
    end
    return true
  end
  return false
end

function AircraftArea:RefreshFurniture()
  local destroyFurs = {}
  for id, fur in pairs(self._furnitures) do
    fur:Dispose()
    table.insert(destroyFurs, fur:InstanceID())
  end
  self._furnitures = {}
  local allFurnitures = self:GetAllFurniture()
  allFurnitures = allFurnitures or {}
  for _, fur in pairs(allFurnitures) do
    if fur.area_id == self._id then
      local surface = self._surfaces[fur.surface]
      if surface == nil then
        Log.exception("严重错误！找不到家具所在的面。区域:", self._id, "，", "家具ID：", fur.asset_id, "面ID:", fur.surface)
      end
      local req = ResourceManager:GetInstance():SyncLoadAsset(fur.asset_id .. ".prefab", LoadType.GameObject)
      local gridPos = Vector2(GridHelper.ToFloat(fur.pos_x), GridHelper.ToFloat(fur.pos_z))
      local fp, fr = GridHelper.GetFurniturePosRot(surface, gridPos, fur.rot)
      local furniture = AircraftFurniture:New(req, nil, self._floor, self._id)
      furniture:SetDecorateData(fur, false, fp, fr)
      self._furnitures[furniture:InstanceID()] = furniture
      local grids = GridHelper.FurnitureOccupyGrids(furniture, furniture:GridPosition(), furniture:GridRotY())
      local tiles = surface:Tiles()
      local otiles = {}
      for _, pos in ipairs(grids) do
        if tiles[pos.x] == nil then
          Log.error("找不到列")
        end
        local tile = tiles[pos.x][pos.y]
        if tile == nil then
          Log.exception("面上找不到家具占据的格子。", "面:", surface:ID(), "，家具:", fur.asset_id, "，区域:", self._id, "，格子坐标:", pos.x, ",", pos.y)
        end
        if tile:Occupied(furniture:Layer()) then
          Log.fatal("格子已被占据，", "家具id：", fur.asset_id, "，区域：", self._id, "，面：", surface:ID())
        end
        otiles[#otiles + 1] = tile
      end
      furniture:SetTiles(otiles)
      furniture:OccupyTiles(true)
    end
  end
  if self._room then
    local defaultFurs = self._room:GetDefaultFurniture()
    if defaultFurs and 0 < #defaultFurs then
      for _, fur in pairs(defaultFurs) do
        self._furnitures[fur:InstanceID()] = fur
      end
    end
  end
  self._main:OnFurnituresDestroy(destroyFurs)
end

function AircraftArea:GetSurface(id)
  return self._surfaces[id]
end

function AircraftArea:Surfaces()
  return self._surfaces
end

function AircraftArea:OnEnter()
  if not self._entered then
    for id, surface in pairs(self._surfaces) do
      surface:Show()
    end
    self._entered = true
  end
end

function AircraftArea:OnExit()
  self._entered = false
  for id, surface in pairs(self._surfaces) do
    surface:Hide()
  end
end

function AircraftArea:GetFurnitureByInsID(id)
  return self._furnitures[id]
end

function AircraftArea:GetAllFurniture()
  local airModule = GameGlobal.GetModule(AircraftModule)
  return airModule:GetFurnitureByArea(self._id)
end
