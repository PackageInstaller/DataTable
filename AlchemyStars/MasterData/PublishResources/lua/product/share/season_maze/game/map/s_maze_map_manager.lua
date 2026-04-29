_class("SMazeMapManager", Object)
SMazeMapManager = SMazeMapManager

function SMazeMapManager:Constructor(mn)
  self._points = nil
  self._manager = mn
  self._reachable = {}
  self._resReqs = {}
  self:_Make()
end

function SMazeMapManager:OnInit(sceneManager)
  self._sceneManager = sceneManager
  self._historyEventPointMgr = SMazeMapHistoryEventpointMgr:New()
  local pRootGo = self._sceneManager:GetEventPointRoot()
  self._historyEventPointMgr:Init(self._manager:SeasonMazeID(), pRootGo)
end

function SMazeMapManager:Update(dt)
end

function SMazeMapManager:Dispose()
  for key, point in pairs(self._transPoint) do
    point:Dispose()
  end
  self._transPoint = nil
  for key, point in pairs(self._points) do
    point:Dispose()
  end
  self._points = nil
  for key, req in pairs(self._resReqs) do
    req:Dispose()
  end
  self._resReqs = nil
  self._historyEventPointMgr:Dispose()
  self._historyEventPointMgr = nil
end

function SMazeMapManager:_Make()
  local obj = GameGlobal.GetModule(SeasonMazeModule):CurSeasonObj()
  local cpt = obj:GetMazeComponent()
  local info = cpt:GetComponentInfo()
  self._points = {}
  for pointID, svrRoom in pairs(info.rooms) do
    local node = SMazeMapNode:New(obj:GetMazeID(), pointID)
    local room = self._manager:Factory():CreateRoom(svrRoom.type, svrRoom, node)
    node:_SetRoom(room)
    self._points[pointID] = node
  end
  local mazeId = obj:GetMazeID()
  self._transPoint = {}
  self._dumpLinePoints = {}
  for pointID, svrRoom in pairs(info.rooms) do
    local cfg = Cfg.cfg_component_season_maze_point[pointID]
    local id = cfg.TansportID
    local dumpLinePoints = cfg.DumpLinePointID
    if id then
      if not self._transPoint[id] then
        local node = SMazeMapNode:New(mazeId, id)
        self._transPoint[id] = node
      end
    elseif dumpLinePoints and 0 < #dumpLinePoints then
      for i, nodeId in ipairs(dumpLinePoints) do
        local node = self._dumpLinePoints[nodeId]
        if not node then
          node = SMazeMapNode:New(mazeId, nodeId)
          self._dumpLinePoints[nodeId] = node
        end
        self._points[pointID]:AddDumpLinePoint(node)
      end
    end
  end
  self:_MakeLink(cpt:GetComponentCfgId(), info.hard)
end

function SMazeMapManager:_MakeLink(cptID, hard)
  for id, point in pairs(self._points) do
    local cfg = Cfg.cfg_component_season_maze_point[id]
    local nextIds = cfg.LockPoint
    local nexts = {}
    if nextIds then
      for _, nID in ipairs(nextIds) do
        table.insert(nexts, self._points[nID])
      end
    end
    point:_Link(nexts, self:GetTransportPointByID(point:TransportID()))
  end
  local mazeCfg = Cfg.cfg_component_season_maze({ComponentID = cptID, Hard = hard})[1]
  local startID = mazeCfg.SpecialPoints[1]
  local branchStarts = {}
  local start = self._points[startID]
  branchStarts[start:BranchIdx()] = start
  for id, node in pairs(self._points) do
    if node:NextPoints() and #node:NextPoints() > 0 then
      for _, next in ipairs(node:NextPoints()) do
        if not branchStarts[next:BranchIdx()] then
          branchStarts[next:BranchIdx()] = node
        end
      end
    end
  end
  local branches = {}
  for idx, branch in pairs(branchStarts) do
    local tb = {}
    local tmp = branch
    table.insert(tb, branch)
    while tmp do
      local found = false
      if tmp:NextPoints() then
        for _, next in ipairs(tmp:NextPoints()) do
          if next:BranchIdx() == idx then
            table.insert(tb, next)
            tmp = next
            found = true
            break
          elseif 1 < #tb then
            local transportId = tmp:TransportID() or 0
            if transportId < 1 then
              table.insert(tb, next)
              found = false
              break
            end
          end
        end
      end
      if not found then
        tmp = nil
      end
    end
    branches[idx] = tb
  end
  self._pointNumPerLine = {}
  for i, subBranch in ipairs(branches) do
    local num = 0
    num = #subBranch
    for _, node in pairs(subBranch) do
      local dumpPoints = node:GetDumpLinePoint()
      num = num + #dumpPoints
    end
    self._pointNumPerLine[i] = num
  end
  for i, nodes in ipairs(branches) do
    local go = self:_LoadPrefab("pfb_Scene_line_3.prefab")
    go.transform.position = Vector3.zero
    local lines = go:GetComponentsInChildren(typeof(UnityEngine.LineRenderer))
    local pointCount = self._pointNumPerLine[i]
    for i = 0, lines.Length - 1 do
      local line = lines[i]
      line.positionCount = pointCount
      local pIndex = 0
      for _, node in pairs(nodes) do
        line:SetPosition(pIndex, node:Position())
        pIndex = pIndex + 1
        local dumPoint = node:GetDumpLinePoint()
        for _, dumpNode in pairs(dumPoint) do
          line:SetPosition(pIndex, dumpNode:Position())
          pIndex = pIndex + 1
        end
      end
    end
  end
  for id, node in pairs(self._points) do
    if node:TransportID() then
      local transportPoint = self._transPoint[node:TransportID()]
      local next = node:NextPoints()[1]
      local obj = self:_LoadPrefab("pfb_Scene_line_4.prefab")
      obj.transform.position = Vector3.zero
      local lines = obj:GetComponentsInChildren(typeof(UnityEngine.LineRenderer))
      for i = 0, lines.Length - 1 do
        local line = lines[i]
        line.positionCount = 2
        line:SetPosition(0, node:Position())
        line:SetPosition(1, transportPoint:Position())
      end
      local obj2 = self:_LoadPrefab("pfb_Scene_line_4.prefab")
      obj2.transform.position = Vector3.zero
      local lines2 = obj2:GetComponentsInChildren(typeof(UnityEngine.LineRenderer))
      for i = 0, lines2.Length - 1 do
        local line2 = lines2[i]
        line2.positionCount = 2
        line2:SetPosition(0, transportPoint:Position())
        line2:SetPosition(1, next:Position())
      end
    end
  end
  for id, node in pairs(self._points) do
    local targetID = node:TransRoomTargetID() or 0
    if 0 < targetID then
      local targetNode = self._points[targetID]
      if targetNode then
        local obj = self:_LoadPrefab("pfb_Scene_line_4.prefab")
        obj.transform.position = Vector3.zero
        local lines = obj:GetComponentsInChildren(typeof(UnityEngine.LineRenderer))
        for i = 0, lines.Length - 1 do
          local line = lines[i]
          line.positionCount = 2
          line:SetPosition(0, node:Position())
          line:SetPosition(1, targetNode:Position())
        end
      else
        Log.error("s_maze_map_manager ，传送房间找不到目标ID ", targetID)
      end
    end
  end
end

function SMazeMapManager:GetNode(id)
  return self._points[id]
end

function SMazeMapManager:GetRoomByGameObject(go)
  for _, node in pairs(self._points) do
    if node:Room():GameObject() == go then
      return node
    end
  end
end

function SMazeMapManager:GetTransportPointByGameObject(go)
  for _, node in pairs(self._transPoint) do
    if node:IsTransfortPoint() and node:GetTransfortPoint():GameObject() == go then
      return node
    end
  end
end

function SMazeMapManager:ReMake()
  for key, point in pairs(self._transPoint) do
    point:Dispose()
  end
  self._transPoint = nil
  for key, point in pairs(self._points) do
    point:Dispose()
  end
  self._points = nil
  for key, req in pairs(self._resReqs) do
    req:Dispose()
  end
  self._resReqs = {}
  self:_Make()
end

function SMazeMapManager:GetTransportPointByID(id)
  return id and self._transPoint[id]
end

function SMazeMapManager:RefreshLinkState(curPointID, startState, onInit)
  local start = self:GetNode(curPointID)
  
  local function search(point, reachable)
    local nexts = point:NextPoints()
    if not nexts or not next(nexts) then
      return
    end
    for _, next in ipairs(nexts) do
      reachable[next:ID()] = true
      search(next, reachable)
    end
  end
  
  local reachable = {}
  search(start, reachable)
  for id, point in pairs(self._points) do
    local state = SMazeNodeState.UnReachable
    if id == start:ID() then
      state = startState
    elseif reachable[id] == true then
      state = SMazeNodeState.Reachable
    end
    point:SetState(state, onInit)
    if point:TransportID() then
      local transPoint = self._transPoint[point:TransportID()]
      if point:ID() == start:ID() then
        transPoint:SetState(SMazeNodeState.StayTemp, onInit)
      else
        transPoint:SetState(state, onInit)
      end
    end
  end
end

function SMazeMapManager:GetNodes(filter)
  local results = {}
  for _, point in pairs(self._points) do
    if filter(point) then
      table.insert(results, point)
    end
  end
  return results
end

function SMazeMapManager:_LoadPrefab(name)
  local req = ResourceManager:GetInstance():SyncLoadAsset(name, LoadType.GameObject)
  req.Obj:SetActive(true)
  table.insert(self._resReqs, req)
  return req.Obj
end
