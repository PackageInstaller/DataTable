_class("SMazeMapNode", Object)
SMazeMapNode = SMazeMapNode

function SMazeMapNode:Constructor(smazeID, id)
  self._id = id
  local cfg = Cfg.cfg_component_season_maze_point[self._id]
  self._transportID = cfg.TansportID
  self._branchIdx = cfg.BranchIndex
  self._forceSettle = cfg.IsForceSettle
  self._transRoomTargetID = cfg.TransFerPoint
  self._isDumpLinePoint = cfg.IsDumpLinePoint
  self._room = nil
  self._nexts = nil
  self._pos = Vector3(cfg.XYZ[1], cfg.XYZ[2], cfg.XYZ[3])
  self._isTransfortPoint = cfg.IsTransportPoint == true
  if self._isTransfortPoint then
    self._transfortPoint = SMazeMapTransportPoint:New(self)
  end
  self._state = SMazeNodeState.None
  self._dumpLinePoints = {}
end

function SMazeMapNode:AddDumpLinePoint(point)
  table.insert(self._dumpLinePoints, point)
end

function SMazeMapNode:GetDumpLinePoint()
  return self._dumpLinePoints
end

function SMazeMapNode:ID()
  return self._id
end

function SMazeMapNode:Dispose()
  if self._room then
    self._room:Dispose()
    self._room = nil
  end
  if self._transfortPoint then
    self._transfortPoint:Dispose()
  end
end

function SMazeMapNode:_Link(nexts, transportPoint)
  self._nexts = nexts
end

function SMazeMapNode:_SetRoom(room)
  self._room = room
end

function SMazeMapNode:Room()
  return self._room
end

function SMazeMapNode:IsTransfortPoint()
  return self._isTransfortPoint
end

function SMazeMapNode:GetTransfortPoint()
  return self._transfortPoint
end

function SMazeMapNode:Position()
  return self._pos
end

function SMazeMapNode:NextPoints()
  return self._nexts
end

function SMazeMapNode:IsFinalOne()
  return not self:IsTransfortPoint() and next(self._nexts) == nil
end

function SMazeMapNode:OnCross()
end

function SMazeMapNode:TransportID()
  return self._transportID
end

function SMazeMapNode:TransRoomTargetID()
  return self._transRoomTargetID
end

function SMazeMapNode:SetState(state, onInit)
  if self._isTransfortPoint then
    if onInit then
      local reachable = state == SMazeNodeState.Reachable or state == SMazeNodeState.StayTemp
      self._transfortPoint:Anim_Reachable(reachable, true)
    elseif (self._state == SMazeNodeState.Reachable or self._state == SMazeNodeState.StayTemp) and state == SMazeNodeState.UnReachable then
      self._transfortPoint:Anim_Reachable(false, false)
    end
  elseif onInit then
    self._room:Anim_Init(state)
  else
    self._room:Anim_State(self._state, state)
  end
  self._state = state
end

function SMazeMapNode:Reachable()
  return self._state == SMazeNodeState.Reachable
end

function SMazeMapNode:GetState()
  return self._state
end

function SMazeMapNode:ReachableForTranspoint()
  local reachable = self._state == SMazeNodeState.Reachable or self._state == SMazeNodeState.StayTemp
  return reachable
end

function SMazeMapNode:SetHighLight(highLight)
  if self._highLight ~= highLight then
    self._room:Anim_HighLight(highLight)
    self._highLight = highLight
  end
end

function SMazeMapNode:BranchIdx()
  return self._branchIdx
end

function SMazeMapNode:ForceSettle()
  return self._forceSettle
end

function SMazeMapNode:PlayHighLightForce()
  self._highLight = true
  self._room:Anim_HighLight(true)
end

function SMazeMapNode:IsDumpLinePoint()
  return self._isDumpLinePoint
end
