local manager = class("sceneGuidePathEntity")

function manager:ctor()
  self.hitPositionGroup = nil
  self.hitGroundPosList = nil
  self.taskDirection = {}
  self.pathGenTimer = nil
  self.currentPos = nil
  local go = L_ResPool:syncGameObject("Program/Guide/pre_pathGuideNode.prefab")
  self.root = go.transform
  self.root.position = Unity.Vector3.zero
  self.normalRoot = self.root:Find("normalRoot")
  self.normalRoot.position = Unity.Vector3.zero
  self.despawnRoot = self.root:Find("despawnRoot")
  self.startPathGuide = false
  self.spawnPool = L_PoolManager:getSpawnPool(self.despawnRoot, 10)
  self._onLateCutWorldStart = handler(self, self.clean)
  C_GameFlow.flowEvent:Listen(C_EGameFlowEvent.LateCutWorldStart, self._onLateCutWorldStart)
  self._onTaskUpdateHandle = handler(self, self.onEvent_taskUpdateHandle)
  AzurWorld.TaskMgr:RegisterEvent(C_ETaskEvent.RefreshUITask, self._onTaskUpdateHandle)
end

function manager:clear()
  C_GameFlow.flowEvent:Cancel(C_EGameFlowEvent.LateCutWorldStart, self._onLateCutWorldStart)
  if self._onTaskUpdateHandle then
    AzurWorld.TaskMgr:UnregisterEvent(C_ETaskEvent.RefreshUITask, self._onTaskUpdateHandle)
    self._onTaskUpdateHandle = nil
  end
  self._onLateCutWorldStart = nil
  self.hitPositionGroup = nil
  self.hitGroundPosList = nil
  if self.pathGenTimer ~= nil then
    self.pathGenTimer:destroy()
    self.pathGenTimer = nil
  end
  self.taskDirection = {}
  self.spawnPool:dispose()
  self.spawnPool = nil
end

function manager:onEvent_taskUpdateHandle(type, list)
end

function manager:genPathGuide(pos, bSubsist)
  if self.pathGenTimer ~= nil then
    Timer.remove(self.pathGenTimer)
    self.pathGenTimer = nil
  end
  local navMeshPath = C_NavMeshPath()
  C_NavmeshHelper.CalculatePath(L_PlayerManager:getMainControlEntityPos(), pos, function(path)
    self.pathFinderPos = {}
    for i = 0, path.Count - 1 do
      self.pathFinderPos[i + 1] = path[i]
    end
  end, function()
    if self.pathGenTimer ~= nil then
      Timer.remove(self.pathGenTimer)
      self.pathGenTimer = nil
    end
    return
  end)
  if self.pathGenTimer == nil then
    self.startPathGuide = true
    self:genCorners(pos, navMeshPath)
    self.pathGenTimer = Timer.repeated(3, function()
      if bSubsist then
        self:genCorners(pos, navMeshPath)
      else
        local curTaskId = AzurWorld.TaskMgr:GetTraceTaskId()
        if curTaskId == nil then
          self:clean()
        elseif AzurWorld.TaskMgr:HasExecuteTaskById(curTaskId) then
          self:genCorners(pos, navMeshPath)
        else
          self:clean()
        end
      end
    end, self)
  end
end

function manager:genCorners(pos, navMeshPath)
  local mainControl = AzurWorld.playerMgr.myPlayerData:GetPlayerMainControl(false)
  navMeshPath:ClearCorners()
  if mainControl then
    self.currentPos = L_PlayerManager:getMainControlEntityPos()
    if C_NavmeshHelper.AStarPathfinding == false then
      local dis = C_Vector3.Distance(self.currentPos, pos)
      if 100 < dis then
        self:cleanAllEffect()
        return
      end
    end
    C_NavmeshHelper.CalculatePath(self.currentPos, pos, function(path)
      if self.startPathGuide then
        self.pathFinderPos = {}
        for i = 0, path.Count - 1 do
          self.pathFinderPos[i + 1] = path[i]
        end
        for i = 1, #self.pathFinderPos do
          local result, navMeshHit = Unity.AI.NavMesh.FindClosestEdge(self.pathFinderPos[i], Unity.AI.NavMesh.AllAreas)
          if result == true and navMeshHit and navMeshHit.distance ~= nil and navMeshHit.distance < 2 and navMeshHit.normal then
            self.pathFinderPos[i] = navMeshHit.position + navMeshHit.normal * 2
          end
        end
        self:calculateEffectPath(self.pathFinderPos)
      end
    end)
  else
    return
  end
end

function manager:calculateEffectPath(path)
  self.hitPositionGroup = {}
  self.hitGroundPosList = {}
  for i = 1, #path do
    path[i] = Unity.Vector3(path[i].x + 0, path[i].y + 0.5, path[i].z + 0)
  end
  for i = 1, #path do
    if i < #path then
      local vector = Unity.Vector3(path[i + 1].x - path[i].x, path[i + 1].y - path[i].y, path[i + 1].z - path[i].z)
      local distanceVector = Unity.Vector3.ProjectOnPlane(vector, Unity.Vector3(0, 1, 0))
      local distance = distanceVector.magnitude
      local flag = true
      while flag do
        flag = false
        if distance < 1 then
          table.insert(self.hitPositionGroup, path[i])
          break
        end
        local total_Point = math.floor(distance / 1)
        local startPoint = path[i]
        for j = 1, total_Point do
          local middlePoint = Unity.Vector3(vector.x * (j / total_Point) + startPoint.x, vector.y * (j / total_Point) + startPoint.y, vector.z * (j / total_Point) + startPoint.z)
          table.insert(self.hitPositionGroup, middlePoint)
        end
      end
    end
  end
  if C_NavmeshHelper.AStarPathfinding == false then
    if #self.hitPositionGroup > 0 then
      local yScale = 0.1
      for index = 1, #self.hitPositionGroup do
        local m_pos = self.hitPositionGroup[index]
        for i = 1, 60 do
          m_pos.y = m_pos.y - yScale
          local isBlock, navMeshHit = C_NavmeshHelper.SamplePosition(m_pos, yScale, Unity.AI.NavMesh.AllAreas)
          if navMeshHit ~= nil then
            local hitPos = Unity.Vector3(navMeshHit.x, navMeshHit.y + 0.15, navMeshHit.z)
            table.insert(self.hitGroundPosList, hitPos)
            break
          end
        end
      end
    end
    for i = 1, #self.hitGroundPosList do
      if i < #self.hitGroundPosList and 2 <= i and self.hitGroundPosList[i].y > self.hitGroundPosList[i - 1].y and self.hitGroundPosList[i].y > self.hitGroundPosList[i + 1].y and self.hitGroundPosList[i - 1].y <= 0.5 and self.hitGroundPosList[i + 1].y <= 0.5 then
        self.hitGroundPosList[i].y = (self.hitGroundPosList[i - 1].y + self.hitGroundPosList[i + 1].y) / 2
      end
    end
  elseif #self.hitPositionGroup > 0 then
    for index = 1, #self.hitPositionGroup do
      local m_pos = self.hitPositionGroup[index]
      local hitPos = Unity.Vector3(m_pos.x, m_pos.y + 0.2, m_pos.z)
      table.insert(self.hitGroundPosList, hitPos)
    end
  end
  if 0 < #self.taskDirection then
    for i, v in pairs(self.taskDirection) do
      self.spawnPool:despawn(v)
      v = nil
    end
  end
  self.taskDirection = {}
  for i = 1, #self.hitGroundPosList do
    self.spawnPool:asyncSpawn("Effect/Scene/pre_common_guide_yellow.prefab", function(go)
      if self.taskDirection[i] ~= nil then
        self.spawnPool:despawn(self.taskDirection[i])
      end
      self.taskDirection[i] = go
      self.taskDirection[i].transform:SetParent(self.normalRoot)
      L_Vector3.setRelativePos(self.taskDirection[i].transform, self.hitGroundPosList[i])
    end, nil, true, C_EAssetOperationModule.Lua, C_AssetLoadPriority.GetPriority(C_AssetLoadPriority.UI_Page))
  end
end

function manager:clean()
  if self.pathGenTimer ~= nil then
    self.startPathGuide = false
    Timer.remove(self.pathGenTimer)
    self.pathGenTimer = nil
  end
  if #self.taskDirection > 0 then
    for i, v in pairs(self.taskDirection) do
      self.spawnPool:despawn(v)
    end
  end
  self.taskDirection = {}
  for i = 0, self.normalRoot.transform.childCount - 1 do
    Unity.GameObject.Destroy(self.normalRoot.transform:GetChild(i).gameObject)
  end
  if self.spawnPool ~= nil then
    self.spawnPool:dispose()
  end
end

function manager:cleanAllEffect()
  if self.pathGenTimer ~= nil and #self.taskDirection > 0 then
    for i, v in pairs(self.taskDirection) do
      self.spawnPool:despawn(v)
    end
  end
end

return manager
