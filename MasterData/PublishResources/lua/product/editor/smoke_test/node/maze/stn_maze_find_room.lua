require("base_state_node")
_class("Maze_FindRoom", CTestRobot_Base)
Maze_FindRoom = Maze_FindRoom

function Maze_FindRoom:OnWorking()
  local findMazeRoom = self:_FindNextRoom(self.m_mazeInfo)
  if nil == findMazeRoom then
    self.m_nLogicResult = 0
  else
    self.m_nLogicResult = 1
  end
  self.m_pReturnData = findMazeRoom
  local mazeModule = GameGlobal.GetModule(MazeModule)
  local mazeInfo = mazeModule:GetMazeInfo()
  local count = 0
  for layer = 1, mazeInfo.layer - 1 do
    local cfgMazeLayer = Cfg.cfg_maze_layer({Layer = layer})
    count = count + #cfgMazeLayer
  end
  local cfgCurrentLayer = Cfg.cfg_maze_layer({
    Layer = mazeInfo.layer
  })
  if cfgCurrentLayer and 0 < #cfgCurrentLayer and mazeInfo.room_index ~= -1 then
    table.sort(cfgCurrentLayer, function(a, b)
      return a.Step < b.Step
    end)
    for _, e in ipairs(cfgCurrentLayer) do
      if e.Step < mazeInfo.room_index + 1 then
        count = count + 1
      else
        break
      end
    end
  end
  local progressInfo = self.m_pManager:GetProgressInfo()
  if mazeInfo.room_index ~= -1 then
    progressInfo:TickProgress(mazeInfo.room_index + mazeInfo.layer * 100)
  end
  return Maze_FindRoom.super.OnWorking(self)
end

function Maze_FindRoom:OnBegin(...)
  if self.m_pActionTree then
    local listScanID = self.m_pActionTree:GetScanActionID()
    local nTreeID = self.m_pActionTree:GetTreeID()
    self:PrintLog("ScanPath TreeID = ", nTreeID, ", Path = [", table.concat(listScanID, ","), "]")
    self.m_pActionTree:ResetScanActionID()
  end
  local nReturn = Maze_FindRoom.super.OnBegin(self, ...)
  return nReturn
end

function Maze_FindRoom:_GetMazeRoom(mazeInfo, nCppIndex)
  return mazeInfo.room_info[nCppIndex + 1]
end

function Maze_FindRoom:_FindNextRoom()
  local mazeModule = self:GetModule(MazeModule)
  local mazeInfo = mazeModule:GetMazeInfo()
  if nil == mazeInfo then
    return nil
  end
  if -1 == mazeInfo.room_index then
    local nNextIndex = math.random(1, 2)
    return mazeInfo.room_info[nNextIndex]
  end
  local roomInfo = self:_GetMazeRoom(mazeInfo, mazeInfo.room_index)
  if table.count(roomInfo.next_rooms) <= 0 then
    return nil
  end
  local nRoomSelect = math.random(1, table.count(roomInfo.next_rooms))
  local nRoomNext = roomInfo.next_rooms[nRoomSelect]
  if nil == nRoomNext then
    return nil
  end
  return self:_GetMazeRoom(mazeInfo, nRoomNext)
end
