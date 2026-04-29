_class("AircraftOccupyTip", Object)
AircraftOccupyTip = AircraftOccupyTip

function AircraftOccupyTip:Constructor()
  self._reqs = {}
  self._tileCache = {}
  for i = 1, 8 do
    self._tileCache[i] = self:loadTile()
  end
  self._showTiles = {}
  self._inValidColor = Color(1, 0.067, 0, 0.5098)
  self._validColor = Color(0.394, 0.6424, 0.6792, 0.4)
  self._mat = self._tileCache[1]:GetComponent(typeof(UnityEngine.MeshRenderer)).sharedMaterial
end

function AircraftOccupyTip:Dispose()
  for _, req in pairs(self._reqs) do
    req:Dispose()
  end
end

function AircraftOccupyTip:Show(grids, rot, valid, gs)
  if valid then
    self._mat:SetColor("_MainColor", self._validColor)
  else
    self._mat:SetColor("_MainColor", self._inValidColor)
  end
  local count = #grids
  local num = #self._showTiles - count
  if num < 0 then
    for i = 1, -num do
      self._showTiles[#self._showTiles + 1] = self:getTile()
      local go = self._showTiles[#self._showTiles]
    end
  else
    if 0 < num then
      for i = 1, num do
        local t = self._showTiles[#self._showTiles]
        self._showTiles[#self._showTiles] = nil
        t:SetActive(false)
        self._tileCache[#self._tileCache + 1] = t
      end
    else
    end
  end
  for i, tile in ipairs(self._showTiles) do
    local t = tile.transform
    t.position = grids[i]
    t.rotation = rot
  end
end

function AircraftOccupyTip:Hide()
  for i = 1, #self._showTiles do
    local tile = self._showTiles[i]
    tile:SetActive(false)
    self._tileCache[#self._tileCache + 1] = tile
  end
  self._showTiles = {}
end

function AircraftOccupyTip:getTile()
  local cacheCount = #self._tileCache
  local t
  if 0 < cacheCount then
    t = self._tileCache[cacheCount]
    self._tileCache[cacheCount] = nil
  else
    t = self:loadTile()
  end
  t:SetActive(true)
  return t
end

function AircraftOccupyTip:loadTile()
  local req = ResourceManager:GetInstance():SyncLoadAsset("AircraftOccupyTile.prefab", LoadType.GameObject)
  self._reqs[#self._reqs + 1] = req
  return req.Obj
end
