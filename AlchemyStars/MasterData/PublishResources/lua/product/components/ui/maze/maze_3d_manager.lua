_class("Maze3DManager", Object)
Maze3DManager = Maze3DManager

function Maze3DManager:Constructor()
  self._inputManager = MazeInputManager:New()
  self._cameraManager = MazeCameraManager:New()
  self._actorManager = MazeActorManager:New()
  self._mainCamera = UnityEngine.GameObject.Find("Main Camera"):GetComponent("Camera")
  self._currentRoomIdx = 0
  self._currentPos = nil
  self._currentRoom = nil
  self._previewRoom = nil
  self._resReqs = {}
  self._assets = {
    prefabName = {
      point = "eff_ingame_ludian.prefab",
      path = "eff_ingame_line.prefab"
    },
    animName = {
      point = {
        unReach = "eff_ludian_normal",
        reached = "eff_ludian_white",
        passed = "eff_ludian_dark",
        active = "eff_ludian_active",
        onLeave = "eff_ludian_a2n",
        reachable = "eff_ludian_next"
      },
      path = {
        normal = "eff_ludian_line_normal",
        passed = "eff_ludian_line_dark",
        next = "eff_ludian_line_active"
      }
    },
    iconName = {
      [0] = "ludian_start.mat",
      [1] = "ludian_normal.mat",
      [2] = "ludian_danger.mat",
      [3] = "ludian_special.mat",
      [4] = "ludian_boss.mat",
      [5] = "ludian_storehouse.mat",
      [6] = "ludian_cure.mat",
      [7] = "ludian_shief.mat"
    },
    colors = {
      [0] = Color(1.0947, 0.7977, 1.2311, 1),
      [1] = Color(1.8305, 0.5307, 0.4921, 1),
      [2] = Color(1.8305, 0.5307, 0.4921, 1),
      [3] = Color(1.8305, 0.5307, 0.4921, 1),
      [4] = Color(1.8305, 0.5307, 0.4921, 1),
      [5] = Color(0.4078, 0.8004, 1.498, 1),
      [6] = Color(0.8156, 1.498, 0.4078, 1),
      [7] = Color(1.411, 0.6114, 0.0094, 1),
      [99] = Color(0.271, 0.6, 0.671, 1)
    }
  }
  self._roomMap = {}
  self._mazePathMap = {}
end

function Maze3DManager:Dispose()
  self._inputManager:Dispose()
  self._cameraManager:Dispose()
  self._actorManager:Dispose()
  for _, req in ipairs(self._resReqs) do
    req:Dispose()
  end
  self._previewRoom = nil
  self._currentRoom = nil
end

function Maze3DManager:Init(uiController, mazeInfo, archievGetter)
  self._uiController = uiController
  self._mazeInfo = mazeInfo
  self._archieveGetter = archievGetter
  self._roomInfo = self._mazeInfo.room_info
  self._currentRoomIdx = self._mazeInfo.room_index + 1
  local cfg = Cfg.cfg_maze_layer_positions[mazeInfo.layer]
  self._startPos = Vector3(cfg.BornPos[1], 0, cfg.BornPos[2])
  self._bossPos = Vector3(cfg.BossPos[1], 0, cfg.BossPos[2])
  self._pointOffset = Vector3(-40, 0, -8)
  self._availablePoints = self:GetAvaliablePoints()
  self:InitMazePath()
  self._inputManager:Init()
  self._actorManager:Init(self:GetPetActor(), self:GetStartPosition())
  self._cameraManager:Init(self, self._mainCamera, self._startPos, self._bossPos)
  self._currentPos = self._actorManager:ActorPosition()
end

function Maze3DManager:RefreshMaze(mazeInfo)
  self._mazeInfo = mazeInfo
  self._currentRoomIdx = self._mazeInfo.room_index + 1
  self._actorManager:FefreshActor(self:GetPetActor(), self:GetStartPosition())
  self._currentPos = self._actorManager:ActorPosition()
end

function Maze3DManager:RefreshActor()
  self._actorManager:FefreshActor(self:GetPetActor(), self._actorManager:ActorPosition())
end

function Maze3DManager:GetPetActor()
  local lastTeam = GameGlobal.GetModule(MazeModule):GetLastTeamID()
  if lastTeam < 1 then
    lastTeam = 1
  end
  local captainID = 0
  local moduleMission = GameGlobal.GetModule(MissionModule)
  local teamCtx = moduleMission:TeamCtx()
  local teams = teamCtx:GetMazeTeam()
  local team = teams:Get(lastTeam)
  if team then
    captainID = team:GetLeaderPetId()
  end
  local petModule = GameGlobal.GetModule(PetModule)
  if captainID == FormationPetPlaceType.FormationPetPlaceType_None then
    for _, pet in pairs(petModule:GetPets()) do
      if pet:GetTemplateID() == 1500331 then
        Log.warn("[Maze] captain not found, use 1500331-薇丝")
        return pet
      end
    end
  end
  return petModule:GetPet(captainID)
end

function Maze3DManager:GetAvaliablePoints()
  if self._currentRoomIdx == 0 then
    local available = {}
    for _, room in ipairs(self._roomInfo) do
      available[room.room_index] = true
    end
    return available
  end
  local available = {}
  local curPoint = self._roomInfo[self._currentRoomIdx]
  
  local function search(room, available)
    if room.next_rooms == nil or #room.next_rooms == 0 then
      return
    end
    for _, nextID in ipairs(room.next_rooms) do
      local next = self._roomInfo[nextID + 1]
      if not available[next.room_index] then
        available[next.room_index] = true
        search(next, available)
      end
    end
  end
  
  search(curPoint, available)
  return available
end

function Maze3DManager:InitMazePath()
  local temp = {}
  local _start = self:LoadGO(self._assets.prefabName.point)
  local startAnim = self:SetPointState(_start, 0)
  temp[1] = startAnim
  _start.transform.position = self._startPos
  for _, room in ipairs(self._roomInfo) do
    if room.layer_step == 1 then
      local nextPos = Vector3(room.x, 0, room.z) + self._pointOffset
      local path = self:LoadGO(self._assets.prefabName.path)
      local _pathAnim = self:SetPathState(path, nil, room, self._startPos, nextPos)
      temp[#temp + 1] = _pathAnim
    end
  end
  self._mazePathMap[0] = temp
  for idx, room in ipairs(self._roomInfo) do
    temp = {}
    local go = self:LoadGO(self._assets.prefabName.point)
    local pointAnim = self:SetPointState(go, idx)
    temp[0] = pointAnim
    if idx == #self._roomInfo then
      go.transform.position = self._bossPos
      go.transform.localScale = Vector3(1.5, 1, 1.5)
    else
      local roomPos = Vector3(room.x, 0, room.z) + self._pointOffset
      go.transform.position = roomPos
      go.name = go.name .. room.layer_step .. "-" .. room.step_index
      for _, nextRoomIdx in ipairs(room.next_rooms) do
        local nextIdx = nextRoomIdx + 1
        local nextRoom = self._roomInfo[nextIdx]
        local nextPos
        if nextIdx == #self._roomInfo then
          nextPos = self._bossPos
        else
          nextPos = Vector3(nextRoom.x, 0, nextRoom.z) + self._pointOffset
        end
        local path = self:LoadGO(self._assets.prefabName.path)
        local pathAnim = self:SetPathState(path, room, nextRoom, roomPos, nextPos)
        temp[#temp + 1] = pathAnim
      end
    end
    self._roomMap[go] = room
    self._mazePathMap[room.room_index] = temp
  end
end

function Maze3DManager:GoToRoomByIndex(idx)
  for K, v in pairs(self._roomMap) do
    if v.room_index == idx then
      self:OnClickRoom(K, true)
      break
    end
  end
end

function Maze3DManager:SetPointState(go, idx)
  local animation = go:GetComponentInChildren(typeof(UnityEngine.Animation))
  local mat1 = go.transform:Find("root"):GetComponent(typeof(UnityEngine.MeshRenderer)).material
  local mat2 = go.transform:Find("icon"):GetComponent(typeof(UnityEngine.MeshRenderer)).material
  local tex, anim, color
  local room = self._roomInfo[idx]
  local curRoom = self._roomInfo[self._currentRoomIdx]
  if self._currentRoomIdx == 0 then
    if idx == 0 then
      anim = self._assets.animName.point.active
      tex = self:LoadTexture(self._assets.iconName[0])
      color = self._assets.colors[0]
      self._currentRoom = go
    else
      if room.layer_step == 1 then
        anim = self._assets.animName.point.reachable
      else
        anim = self._assets.animName.point.unReach
      end
      local cfg = Cfg.cfg_maze_room[room.room_id]
      if cfg == nil then
        Log.error("cfg_maze_room cant find room_id ", room.room_id)
      end
      tex = self:LoadTexture(self._assets.iconName[cfg.MazeRoomType])
      color = self._assets.colors[cfg.MazeRoomType]
    end
  elseif idx == 0 then
    anim = self._assets.animName.point.reached
    tex = self:LoadTexture(self._assets.iconName[0])
    color = self._assets.colors[0]
  else
    local cfg = Cfg.cfg_maze_room[room.room_id]
    tex = self:LoadTexture(self._assets.iconName[cfg.MazeRoomType])
    color = self._assets.colors[cfg.MazeRoomType]
    if room.layer_step < curRoom.layer_step then
      if table.icontains(self._mazeInfo.layer_path, room.room_id) then
        anim = self._assets.animName.point.reached
      else
        anim = self._assets.animName.point.passed
      end
    elseif room.layer_step > curRoom.layer_step then
      local _reachable = false
      for _, _nextID in ipairs(curRoom.next_rooms) do
        local nextRoom = self._roomInfo[_nextID + 1]
        if nextRoom.room_index == room.room_index then
          _reachable = true
          break
        end
      end
      if _reachable then
        anim = self._assets.animName.point.reachable
      else
        anim = self._assets.animName.point.unReach
      end
    elseif room.room_index == curRoom.room_index then
      anim = self._assets.animName.point.active
      self._currentRoom = go
    else
      anim = self._assets.animName.point.passed
    end
  end
  mat1:SetTexture("_IconTex", tex)
  mat2:SetTexture("_IconTex", tex)
  if self:RoomHasArchieve(room) then
    color = self._assets.colors[99]
  end
  mat1:SetColor("_CircleColor", color)
  animation:Play(anim)
  return animation
end

function Maze3DManager:OnLeavePoint(go)
  local anim = go:GetComponentInChildren(typeof(UnityEngine.Animation))
  local leaveRoom = self:GetRoomData(go)
  if leaveRoom == nil then
    anim:Play(self._assets.animName.point.onLeave)
  else
    local curRoom = self._roomInfo[self._currentRoomIdx]
    if curRoom == nil then
      anim:Play(self._assets.animName.point.onLeave)
      anim:PlayQueued(self._assets.animName.point.reachable)
    elseif leaveRoom.room_index == curRoom.room_index then
      anim:Play(self._assets.animName.point.onLeave)
    else
      anim:Play(self._assets.animName.point.onLeave)
      anim:PlayQueued(self._assets.animName.point.reachable)
    end
  end
end

function Maze3DManager:OnArrivePoint(go)
  go:GetComponentInChildren(typeof(UnityEngine.Animation)):Play(self._assets.animName.point.active)
end

function Maze3DManager:SetPathState(go, start, target, startPos, endPos)
  local curLayer = 0
  local curRoomIdx
  if 0 < self._currentRoomIdx then
    curLayer = self._roomInfo[self._currentRoomIdx].layer_step
    curRoomIdx = self._roomInfo[self._currentRoomIdx].room_index
  end
  local anim = go:GetComponent(typeof(UnityEngine.Animation))
  local line = go:GetComponent(typeof(UnityEngine.LineRenderer))
  local name
  if start == nil then
    if curLayer == 0 then
      name = self._assets.animName.path.next
    elseif table.icontains(self._mazeInfo.layer_path, target.room_index) then
      name = self._assets.animName.path.normal
    else
      name = self._assets.animName.path.passed
    end
  elseif curLayer >= target.layer_step then
    if table.icontains(self._mazeInfo.layer_path, target.room_index) and table.icontains(self._mazeInfo.layer_path, start.room_index) then
      name = self._assets.animName.path.normal
    else
      name = self._assets.animName.path.passed
    end
  elseif start.layer_step == curLayer then
    if start.room_index == curRoomIdx then
      name = self._assets.animName.path.next
    else
      name = self._assets.animName.path.passed
    end
  elseif self._availablePoints[start.room_index] then
    name = self._assets.animName.path.normal
  else
    name = self._assets.animName.path.passed
  end
  if startPos and endPos then
    line:SetPosition(0, startPos)
    line:SetPosition(1, endPos)
  end
  anim:Play(name)
  return anim
end

function Maze3DManager:LoadGO(name)
  local req = ResourceManager:GetInstance():SyncLoadAsset(name, LoadType.GameObject)
  self._resReqs[#self._resReqs + 1] = req
  local go = req.Obj
  go:SetActive(true)
  return go
end

function Maze3DManager:LoadTexture(name)
  local req = ResourceManager:GetInstance():SyncLoadAsset(name, LoadType.Mat)
  self._resReqs[#self._resReqs + 1] = req
  return req.Obj:GetTexture("_MainTex")
end

function Maze3DManager:GetStartPosition()
  if self._mazeInfo.room_index == -1 then
    return self._startPos
  elseif self._mazeInfo.room_index + 1 == #self._roomInfo then
    return self._bossPos
  end
  local room = self._roomInfo[self._mazeInfo.room_index + 1]
  return Vector3(room.x, 0, room.z) + self._pointOffset
end

function Maze3DManager:Update(deltaTime)
  self._inputManager:Update(deltaTime)
  self._cameraManager:Update(deltaTime)
  self._actorManager:Update(deltaTime)
  local clicked, clickPos = self._inputManager:GetClick()
  local dragging, dragStart, dragEnd = self._inputManager:GetDrag()
  if clicked then
    if self._previewRoom then
      self:ExitPreviewRoom()
    else
      local clickRoom = self._cameraManager:TryClickRoom(clickPos)
      if clickRoom then
        self:OnClickRoom(clickRoom)
      end
    end
  elseif dragging then
    if self._previewRoom then
      self:ExitPreviewRoom()
    else
      self._cameraManager:OnDrag(dragStart, dragEnd)
    end
  end
end

function Maze3DManager:GetInputManager()
  return self._inputManager
end

function Maze3DManager:GetActorManager()
  return self._actorManager
end

function Maze3DManager:OnClickRoom(roomGO, again)
  AudioHelperController.PlayUISoundAutoRelease(CriAudioIDConst.SoundDefaultClick)
  if self._previewRoom == roomGO then
    return
  end
  local roomData = self:GetRoomData(roomGO)
  if roomData == nil then
    Log.notice("[Maze] click gameObject is not room: ", roomGO.name)
    return
  end
  local reachState = self:GetReachState(roomData)
  if reachState == 0 then
    self._previewRoom = roomGO
    self:PreviewRoom(roomData, roomGO, again)
  elseif reachState == 1 then
    self._uiController:ShowRoomMsg(roomData, false)
  elseif reachState == -1 then
    ToastManager.ShowToast(StringTable.Get("str_maze_passed"))
  elseif reachState == 2 then
  end
end

function Maze3DManager:GetRoomData(roomGO)
  return self._roomMap[roomGO]
end

function Maze3DManager:GetReachState(targetRoom)
  if self._currentRoomIdx == 0 then
    if targetRoom.layer_step == 1 then
      return 0
    else
      return 1
    end
  else
    local room = self._roomInfo[self._currentRoomIdx]
    if room.room_index == targetRoom.room_index then
      return 2
    end
    if targetRoom.layer_step <= room.layer_step then
      return -1
    end
    for _, next in ipairs(room.next_rooms) do
      local nextRoom = self._roomInfo[next + 1]
      if nextRoom.room_index == targetRoom.room_index then
        return 0
      end
    end
    return 1
  end
end

function Maze3DManager:PreviewRoom(roomData, roomGo, again)
  self._inputManager:SetEnable(false)
  GameGlobal.TaskManager():StartTask(self.EnterRoom, self, roomData, roomGo, again)
end

function Maze3DManager:EnterRoom(TT, roomData, gameObject, again)
  local movetime
  if again then
    movetime = 0
  end
  local cameraArrive = false
  local actorArrive = false
  self._cameraManager:FocusWayPoint(gameObject.transform.position, function(_cameraDragged)
    self._cameraManager:SetActorMove(not _cameraDragged)
    cameraArrive = true
  end, movetime)
  self:OnLeavePoint(self._currentRoom)
  self._actorManager:MoveToTarget(self._previewRoom.transform.position, function()
    actorArrive = true
    self:OnArrivePoint(self._previewRoom)
  end, movetime)
  while not cameraArrive or not actorArrive do
    YIELD(TT)
  end
  self._cameraManager:SetActorMove(false)
  self._uiController:ShowRoomMsg(roomData, true)
  self._inputManager:SetEnable(true)
end

function Maze3DManager:ExitPreviewRoom()
  self._inputManager:SetEnable(false)
  self._uiController:HideRoomMsg()
  self._cameraManager:SetActorMove(true)
  if self._previewRoom then
    self:OnLeavePoint(self._previewRoom)
  end
  self._actorManager:MoveToTarget(self._currentPos, function()
    self._previewRoom = nil
    self._cameraManager:SetActorMove(false)
    self._inputManager:SetEnable(true)
    self:OnArrivePoint(self._currentRoom)
  end)
end

function Maze3DManager:RoomHasArchieve(room)
  return self._archieveGetter(room)
end
