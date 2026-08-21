_class("HomeBuildArea", Object)
HomeBuildArea = HomeBuildArea

function HomeBuildArea:Constructor(area, belongBuildingArea)
  self._homeArea = area
  self._trans = self._homeArea.transform
  self._showGrid = false
  local inPoints = {}
  for i = 1, self._homeArea.InterPoints.Count do
    local p = self._homeArea.InterPoints[i - 1]
    inPoints[i] = Vector2(p.x, p.z)
  end
  inPoints[#inPoints + 1] = inPoints[1]
  local outPoints = {}
  for i = 1, self._homeArea.ExterPoints.Count do
    local p = self._homeArea.ExterPoints[i - 1]
    outPoints[i] = Vector2(p.x, p.z)
  end
  outPoints[#outPoints + 1] = outPoints[1]
  self._buildHeight = self._homeArea.transform.position.y
  self._inPoly = BuildPoly:New(inPoints)
  self._outPoly = BuildPoly:New(outPoints)
  if not belongBuildingArea then
    self._homeArea.gameObject:SetActive(false)
    local terrainPlain = GameObjectHelper.CreateEmpty("TerrainPlain", nil)
    local dragPlain = GameObjectHelper.CreateEmpty("DragPlain", nil)
    GameObjectHelper.SetGameObjectLayer(terrainPlain, HomeBuildLayer.Surface)
    GameObjectHelper.SetGameObjectLayer(dragPlain, HomeBuildLayer.Drag)
    local plainPos = BuildConfig.MaxCircle.Center
    plainPos = Vector3(plainPos.x, self._buildHeight - 5.0E-5, plainPos.y)
    local plainSize = Vector3(BuildConfig.MaxCircle.Radius * 2 + 100, 1.0E-4, BuildConfig.MaxCircle.Radius * 2 + 100)
    self._terrainCollider = terrainPlain:AddComponent(typeof(UnityEngine.BoxCollider))
    self._dragCollider = dragPlain:AddComponent(typeof(UnityEngine.BoxCollider))
    terrainPlain.transform.position = plainPos
    dragPlain.transform.position = plainPos
    self._terrainCollider.size = plainSize
    self._dragCollider.size = plainSize
  else
    self._belongBuildingArea = belongBuildingArea
  end
  self._meshRenderer = self._homeArea.gameObject:GetComponent(typeof(UnityEngine.MeshRenderer))
  self._exterMat = self._meshRenderer.materials[1]
  local color = self._exterMat:GetColor("_Color")
  self._gridColor = Color(color:Get())
  self:ShowGrid(false)
  self:SetGridSpace(1)
end

function HomeBuildArea:GetHeight()
  return self._buildHeight
end

function HomeBuildArea:GetBelongBuildingArea()
  return self._belongBuildingArea
end

function HomeBuildArea:Contains(pos)
  if self._belongBuildingArea then
    local needRefreshPoly = false
    if not self._pos or self._pos ~= self._trans.position then
      self._pos = self._trans.position
      needRefreshPoly = true
    end
    if not self._rot or self._rot ~= self._trans.eulerAngles.y then
      self._rot = self._trans.eulerAngles.y
      needRefreshPoly = true
    end
    if needRefreshPoly then
      self:RefreshPolyWithOffset(Vector2(self._pos.x, self._pos.z), self._rot)
    end
  end
  return not self._inPoly:Contains(pos) and self._outPoly:Contains(pos)
end

function HomeBuildArea:OnOutSide(pos)
  if self._belongBuildingArea then
    local needRefreshPoly = false
    if not self._pos or self._pos ~= self._trans.position then
      self._pos = self._trans.position
      needRefreshPoly = true
    end
    if not self._rot or self._rot ~= self._trans.eulerAngles.y then
      self._rot = self._trans.eulerAngles.y
      needRefreshPoly = true
    end
    if needRefreshPoly then
      self:RefreshPolyWithOffset(Vector2(self._pos.x, self._pos.z), self._rot)
    end
  end
  return not self._outPoly:Contains(pos)
end

function HomeBuildArea:RefreshPolyWithOffset(offset, rot)
  offset = offset or Vector2.zero
  rot = rot or 0
  local inPoints = {}
  for i = 1, self._homeArea.InterPoints.Count do
    local p = self._homeArea.InterPoints[i - 1]
    inPoints[i] = self:RotPoint(Vector2(p.x, p.z), rot) + offset
  end
  inPoints[#inPoints + 1] = inPoints[1]
  local outPoints = {}
  for i = 1, self._homeArea.ExterPoints.Count do
    local p = self._homeArea.ExterPoints[i - 1]
    outPoints[i] = self:RotPoint(Vector2(p.x, p.z), rot) + offset
  end
  outPoints[#outPoints + 1] = outPoints[1]
  self._buildHeight = self._homeArea.transform.position.y
  self._inPoly = BuildPoly:New(inPoints)
  self._outPoly = BuildPoly:New(outPoints)
end

function HomeBuildArea:RotPoint(point, rot)
  if rot == 0 then
    return point
  end
  local rad = lmathext.deg2rad * rot
  local sin = math.sin(rad)
  local cos = math.cos(rad)
  local newX = point.x * cos + point.y * sin
  local newY = -point.x * sin + point.y * cos
  return Vector2(newX, newY)
end

function HomeBuildArea:SetDragHeight(posY)
  if self._dragCollider then
    local pos = self._dragCollider.center
    self._dragCollider.center = Vector3(pos.x, posY - self._buildHeight, pos.z)
  end
end

function HomeBuildArea:ShowGrid(show)
  if show then
    self._exterMat:SetColor("_Color", self._gridColor)
  else
    self._exterMat:SetColor("_Color", Color.clear)
  end
  self._showGrid = show
end

function HomeBuildArea:GetShowGrid()
  return self._showGrid
end

function HomeBuildArea:ShowArea(show)
  if self._belongBuildingArea then
    self._meshRenderer.enabled = show
  else
    self._homeArea.gameObject:SetActive(show)
  end
  local exterArea = self._homeArea.gameObject.transform:Find("ExterArea")
  if exterArea ~= nil then
    exterArea.gameObject:SetActive(show)
  end
  self:ShowGrid(false)
end

function HomeBuildArea:ShowMindMesh(isShow)
end

function HomeBuildArea:GetArea()
  return self._homeArea
end

function HomeBuildArea:SetGridSpace(space)
  self._gridSpace = space
  self._exterMat:SetFloat("_GridStep", space)
end

function HomeBuildArea:GetGridSpace()
  return self._gridSpace
end

function HomeBuildArea:MinSpace()
  return 1
end
