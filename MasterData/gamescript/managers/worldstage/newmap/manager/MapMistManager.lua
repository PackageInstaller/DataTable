local MapMistManager, Super = System.NewClass("MapMistManager", Manager)

function MapMistManager:ctor()
  Super.ctor(self)
  self.mistObjs = {}
end

function MapMistManager:Awake()
  Super.Awake(self)
  self.rootNode = CS.UnityEngine.GameObject.Find("mapRoot/fogMask")
  self.rootTransform = self.rootNode.transform
end

function MapMistManager:OnInit()
  if WorldRecoveryManager.Instance:IsRecovery() then
    self:InitMist(self.parent:GetMistData())
  end
end

function MapMistManager:IsInMist(posX, posY)
  assert(posX >= 1 and posX <= self.parent:GetMapWidth(), "IsInMist posX 越界 " .. posX)
  assert(posY >= 1 and posY <= self.parent:GetMapHeight(), "IsInMist posY 越界 " .. posY)
  local idx = self.parent:GetIdxByPos(posX, posY)
  return not self.mistObjs[idx]
end

function MapMistManager:IsAdjacentNodesAllInMist(posX, posY)
  assert(posX >= 1 and posX <= self.parent:GetMapWidth(), "IsInMist posX 越界 " .. posX)
  assert(posY >= 1 and posY <= self.parent:GetMapHeight(), "IsInMist posY 越界 " .. posY)
  if not self:IsInMist(posX, posY) then
    return false
  end
  local terrainMgr = self:GetComponent(MapTerrainManager)
  local gridIdxList = terrainMgr:GetFieldTerrain(posX, posY, 1)
  for _, gridIdx in pairs(gridIdxList) do
    if self.mistObjs[gridIdx] then
      return false
    end
  end
  return true
end

function MapMistManager:RemoveMistByPos(x, y)
  local idx = self.parent:GetIdxByPos(x, y)
  self:RemoveMistByIdx(idx)
end

function MapMistManager:RemoveMistByIdx(idx)
  if not self.mistObjs[idx] then
    self.mistObjs[idx] = true
    EventMgr.Instance.MapMistRemove:Dispatch(idx, true)
  end
end

function MapMistManager:UpdateMistData(posX, posY, viewLevel)
  self:RemoveMistByPos(posX, posY)
  for i = 1, viewLevel do
    local field = self.parent:GetFieldOfView(posY, i)
    for _, v in ipairs(field) do
      local biasX, biasY = v[1], v[2]
      local newX = posX + biasX
      local newY = posY + biasY
      if newX >= 1 and newX <= self.parent:GetMapWidth() and newY >= 1 and newY <= self.parent:GetMapHeight() then
        self:RemoveMistByPos(newX, newY)
      end
    end
  end
end

function MapMistManager:OpenMist(x, y, viewLevel, openOnly)
  local terrainMgr = self:GetComponent(MapTerrainManager)
  local lv = viewLevel or MapModel.Instance:GetRoleFOV()
  if openOnly then
    terrainMgr:SetMist(x, y, lv)
  else
    terrainMgr:PlayMist(x, y, lv)
  end
  self:UpdateMistData(x, y, lv)
  local mapTerrainMgr = self:GetComponent(MapTerrainManager)
  mapTerrainMgr:UpdateGearsRendering()
end

function MapMistManager:InitMist(oldPoints)
  if nil == oldPoints then
    Logger.Warn("没有迷雾数据")
    return
  end
  for _, v in ipairs(oldPoints) do
    self:OpenMist(v[1], v[2], nil, true)
  end
end

function MapMistManager:OnDestroy()
  Super.OnDestroy(self)
  self.mistObjs = nil
end

return MapMistManager
