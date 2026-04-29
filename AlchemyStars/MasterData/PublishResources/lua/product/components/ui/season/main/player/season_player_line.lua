_class("SeasonPlayerLine", Object)
SeasonPlayerLine = SeasonPlayerLine

function SeasonPlayerLine:Constructor(root, agent)
  self._root = root
  self._agent = agent
  self._seasonModule = GameGlobal.GetModule(SeasonModule)
  local seasonID = self._seasonModule.uiModule:GetSeasonID()
  self._cfg = Cfg.cfg_season_map[seasonID]
  self:_CreateLineRenderer()
end

function SeasonPlayerLine:Dispose()
  if self._lineRendererReq then
    self._lineRendererReq:Dispose()
    self._lineRendererReq = nil
  end
  UnityEngine.Object.Destroy(self._lineRendererGO)
end

function SeasonPlayerLine:Update(deltaTime)
  self:_UpdateLineRenderer()
end

function SeasonPlayerLine:_CreateLineRenderer()
  self._lineRendererReq = ResourceManager:GetInstance():SyncLoadAsset(self._cfg.Line, LoadType.GameObject)
  if not self._lineRendererReq then
    Log.error("SeasonPlayer load line fail.", self._cfg.Line)
    return
  end
  self._lineRendererGO = self._lineRendererReq.Obj
  self._lineRendererGO.transform:SetParent(self._root.transform)
  self._lineRendererGO.transform.position = Vector3(0, 0, 0)
  self._lineRendererGO.transform.rotation = Vector3(0, 0, 0)
  self._lineRendererList = {}
  local lineRenderchildCount = self._lineRendererGO.transform.childCount
  if 0 < lineRenderchildCount then
    for i = 0, lineRenderchildCount - 1 do
      local lineRenderGO = self._lineRendererGO.transform:GetChild(i)
      if lineRenderGO ~= nil and lineRenderGO:GetComponent(typeof(UnityEngine.LineRenderer)) ~= nil then
        local lineRender = lineRenderGO:GetComponent(typeof(UnityEngine.LineRenderer))
        lineRender.transform.position = Vector3(0, 0, 0)
        lineRender.transform.rotation = Vector3(0, 0, 0)
        table.insert(self._lineRendererList, lineRender)
      end
    end
  end
  for _, lineRenderer in ipairs(self._lineRendererList) do
    lineRenderer.numCornerVertices = 0
  end
  self._lineRendererGO:SetActive(true)
end

function SeasonPlayerLine:_UpdateLineRenderer()
  local bezierCorners1bend = self:_UpdateCalculateSmoothLine()
  if bezierCorners1bend ~= nil then
    local count = #bezierCorners1bend
    for _, lineRenderer in ipairs(self._lineRendererList) do
      lineRenderer.positionCount = count
      for j = count - 1, 0, -1 do
        local p = bezierCorners1bend[j + 1]
        p.y = p.y + 0.1
        lineRenderer:SetPosition(j, p)
      end
    end
  else
    for _, lineRenderer in ipairs(self._lineRendererList) do
      lineRenderer.positionCount = 0
    end
  end
end

function SeasonPlayerLine:ClearLineRender()
  for _, lineRenderer in ipairs(self._lineRendererList) do
    lineRenderer.positionCount = 0
  end
end

function SeasonPlayerLine:_UpdateCalculateSmoothLine()
  local count = self._agent.path.corners.Length
  local navPoints = self._agent.path.corners
  local splitPoints = {}
  local controlPoints = {}
  if count == 0 or count == 1 then
    return nil
  end
  for i = 0, count - 1 do
    table.insert(splitPoints, navPoints[i])
  end
  table.insert(controlPoints, splitPoints[1] + (splitPoints[1] - splitPoints[2]) * 0.05)
  table.insert(controlPoints, splitPoints[1])
  for l = 1, #splitPoints - 1 do
    local splitCont = self:_GetStraightLineSplit(splitPoints[l], splitPoints[l + 1])
    for m = 1, #splitCont do
      table.insert(controlPoints, splitCont[m])
    end
  end
  table.insert(controlPoints, navPoints[count - 1])
  table.insert(controlPoints, navPoints[count - 1] + (navPoints[count - 1] - splitPoints[#splitPoints - 1]) * 0.05)
  local numPoints = 3
  local positions = {}
  table.insert(positions, navPoints[0])
  for k = 2, #controlPoints - 2 do
    local p0 = controlPoints[k - 1]
    local p1 = controlPoints[k]
    local p2 = controlPoints[k + 1]
    local p3 = controlPoints[k + 2]
    local romDist = Vector3.Distance(p1, p2)
    if romDist < 0.1 and p2 == #controlPoints - 2 then
      table.insert(positions, controlPoints[k + 1])
    else
      numPoints = math.ceil(romDist / 0.2)
      numPoints = math.max(3, numPoints)
      for j = 1, numPoints do
        local t = j / numPoints
        local point = self:_CatmullRomPoint(p0, p1, p2, p3, t)
        table.insert(positions, point)
      end
    end
  end
  return positions
end

function SeasonPlayerLine:_CatmullRomPoint(p0, p1, p2, p3, t)
  return p0 * (-0.5 * t * t * t + t * t - 0.5 * t) + p1 * (1.5 * t * t * t - 2.5 * t * t + 1.0) + p2 * (-1.5 * t * t * t + 2.0 * t * t + 0.5 * t) + p3 * (0.5 * t * t * t - 0.5 * t * t)
end

function SeasonPlayerLine:_GetStraightLineSplit(p1, p2)
  local pointList = {}
  local spliteCount = 2
  local mSvrTime = GameGlobal.GetModule(SvrTimeModule)
  local lineArg = mSvrTime:GetServerTime() / 1000
  spliteCount = math.ceil(Vector3.Distance(p1, p2) / 0.25)
  spliteCount = math.max(2, spliteCount)
  local vectorX = Vector3(1, p1.y, 0)
  local vectorZ = Vector3(0, p1.y, 1)
  for i = 1, spliteCount do
    local lerp = 1 / spliteCount * i
    if 0 < lerp and lerp < 1 then
      local x = p1.x * (1 - lerp) + p2.x * lerp
      local z = p1.z * (1 - lerp) + p2.z * lerp
      local splitPoint = Vector3(x, p1.y, z)
      local dotX = math.abs(Vector3.Dot(vectorX.normalized, splitPoint.normalized))
      local dotZ = math.abs(Vector3.Dot(vectorZ.normalized, splitPoint.normalized))
      local tDistX = math.sin(lineArg + splitPoint.z * 2) * dotX * 0.18
      local tDistz = math.sin(lineArg + splitPoint.x * 2) * dotZ * 0.18
      splitPoint.x = splitPoint.x + tDistX
      splitPoint.z = splitPoint.z + tDistz
      table.insert(pointList, splitPoint)
    end
  end
  return pointList
end
