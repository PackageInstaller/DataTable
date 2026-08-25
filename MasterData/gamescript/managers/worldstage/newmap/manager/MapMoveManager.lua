local StageAwaiter = require("Managers.WorldStage.Awaiter.StageAwaiter")
local HexAStarPathfinder = require("Managers.WorldStage.NewMap.Utils.HexAStarPathfinder")
local MapMoveManager, Super = System.NewClass("MapMoveManager", Manager)
local STEP_MOVE_DURATION = 0.35
local AWAITER_BUFFER_TIME = 1.0

function MapMoveManager:ctor()
  Super.ctor(self)
  self.isMoving = false
  self.serverPos = {x = 0, y = 0}
  self.currentPos = {x = 0, y = 0}
  self.moveEndCallBack = nil
  self.movePath = {}
  self.animPathIndex = 0
  self.enablePathfinding = true
  self.moveSessionId = 0
  self.confirmedPathIndex = 0
  self.pendingReqCount = 0
  self.animAllDone = false
  self.followGearPendingMove = false
  self.followGearTriggerUid = nil
end

function MapMoveManager:Awake(binder)
  Super.Awake(self)
  self.binder = binder
  binder:BindEvent(EventMgr.Instance.GearRoleMove, System.fn(self, self.OnGearRoleMove))
  binder:BindEvent(EventMgr.Instance.RoleDirectMove, System.fn(self, self.OnRoleDirectMove))
end

function MapMoveManager:OnInit()
end

function MapMoveManager:IsEnablePathfinding()
  return self.enablePathfinding
end

function MapMoveManager:OnGearRoleMove(gridX, gridY, callback)
  if self.enablePathfinding then
    Logger.Info("GearRoleMove: 使用寻路移动到", gridX, gridY)
    self:Move(gridX, gridY, callback)
  else
    Logger.Info("GearRoleMove: 直接移动到", gridX, gridY)
    self:DirectMove(gridX, gridY, callback)
  end
end

function MapMoveManager:OnRoleDirectMove(gridX, gridY, callback)
  Logger.Info("RoleDirectMove: 直接移动到", gridX, gridY)
  self:DirectMove(gridX, gridY, callback)
end

function MapMoveManager:OnRoleMoveTo(gridX, gridY, callBack)
  Logger.Info("RoleMoveTo: 移动到", gridX, gridY)
  self:Move(gridX, gridY, callBack)
end

function MapMoveManager:SyncPos(x, y)
  self.serverPos.x = x
  self.serverPos.y = y
  self.currentPos.x = x
  self.currentPos.y = y
  MapModel.Instance:SyncMovePos(x, y)
end

function MapMoveManager:IsGearTriggerMove(opts)
  return opts and opts.ignoreGearTrigger == true
end

function MapMoveManager:GetGearUidForTriggerMove(gear)
  if type(gear) ~= "table" then
    return gear
  end
  return gear and gear.GetUid and gear:GetUid()
end

function MapMoveManager:MoveDuringGearTrigger(gridX, gridY, callback, gear)
  local opts = {
    ignoreGearTrigger = true,
    gearUid = self:GetGearUidForTriggerMove(gear)
  }
  if self:IsEnablePathfinding() then
    do return self.Move, self, gridX, gridY, callback end
    return self.Move, self, gridX, gridY, callback, opts
  end
  do return self.DirectMove, self, gridX, gridY, callback end
  return self.DirectMove, self, gridX, gridY, callback, opts
end

function MapMoveManager:DirectMoveDuringGearTrigger(gridX, gridY, callback, gear)
  local opts = {
    ignoreGearTrigger = true,
    gearUid = self:GetGearUidForTriggerMove(gear)
  }
  do return self.DirectMove, self, gridX, gridY, callback end
  return self.DirectMove, self, gridX, gridY, callback, opts
end

function MapMoveManager:CanMove(opts)
  opts = opts or {}
  if self.isMoving then
    Logger.Info("正在移动中~")
    return false
  end
  local roleMgr = self:GetComponent(MapRoleManager)
  if not roleMgr or not roleMgr.role then
    Logger.Warn("找不到角色")
    return false
  end
  if not self:IsGearTriggerMove(opts) and MapModel.Instance and MapModel.Instance:InGearTrigger() then
    local uid = MapModel.Instance:GetTriggerGearUid()
    local hasEventPanel = UIManager.Instance:GetWindow(Urls.WorldStageEventPanel) ~= nil
    if uid and not MapModel.Instance:IsGearWaitingForProto(uid) and not MapModel.Instance:IsGearEventPanelOpen(uid) and not hasEventPanel then
      Logger.Warn("[NewMap] gear is in trigger, force cleanup", "uid:", uid, "tid:", MapModel.Instance:GetGearTid(uid), "type:", MapModel.Instance:GetGearType(uid))
      MapModel.Instance:EndGearTrigger(uid)
      if GuideManager.Instance then
        GuideManager.Instance:SetDisabled(false)
      end
      return true
    end
    Logger.Warn("[NewMap] 正在触发中，不响应", "uid:", uid, "waitingProto:", uid and MapModel.Instance:IsGearWaitingForProto(uid), "eventPanelOpen:", uid and MapModel.Instance:IsGearEventPanelOpen(uid))
    return false
  end
  return true
end

function MapMoveManager:_AbortGearTriggerOnMoveInterrupt(uid)
  if not self.parent or not MapModel.Instance then
    return
  end
  if not MapModel.Instance:InGearTrigger() then
    return
  end
  uid = uid or MapModel.Instance:GetTriggerGearUid()
  local gearMgr = self:GetComponent(MapGearManager)
  local gearItem = gearMgr and uid and gearMgr:GetGearByUid(uid)
  if gearItem then
    gearItem:SetWaitingForProto(false)
    gearItem:EndTriggering()
  elseif uid then
    MapModel.Instance:SetGearWaitingForProto(uid, false)
    MapModel.Instance:EndGearTrigger(uid)
  end
  if GuideManager.Instance then
    GuideManager.Instance:SetDisabled(false)
  end
end

function MapMoveManager:IsInMoveArea(curPosX, curPosY, destPosX, destPosY)
  local terrainMgr = self:GetComponent(MapTerrainManager)
  if terrainMgr then
    do return terrainMgr.IsInMoveArea, terrainMgr, curPosX, curPosY, destPosX end
    return terrainMgr.IsInMoveArea, terrainMgr, curPosX, curPosY, destPosX, destPosY
  end
  return false
end

function MapMoveManager:IsForbidBack(curPosX, curPosY, destPosX, destPosY)
  local terrainMgr = self:GetComponent(MapTerrainManager)
  if terrainMgr then
    do return terrainMgr.IsForbidBack, terrainMgr, curPosX, curPosY, destPosX end
    return terrainMgr.IsForbidBack, terrainMgr, curPosX, curPosY, destPosX, destPosY
  end
  return false
end

function MapMoveManager:_ReqMoveStep(x, y, sessionId, stepIndex)
  local guideManager = self:GetComponent(MapGuideManager)
  if guideManager then
    guideManager:TriggerEvent(CommonDefine.GuideEvent.GuideRoleMove)
  end
  self.pendingReqCount = self.pendingReqCount + 1
  ProtoManager.Instance:ReqServer("WorldRequest", "OnMove", function(data)
    self:_OnMoveStepSuccess(x, y, sessionId, stepIndex)
  end, function(data)
    self:_OnMoveStepFailed(data, sessionId, stepIndex)
  end, x, y)
end

function MapMoveManager:_OnMoveStepSuccess(x, y, sessionId, stepIndex)
  if sessionId ~= self.moveSessionId then
    return
  end
  self.pendingReqCount = math.max(0, self.pendingReqCount - 1)
  self.confirmedPathIndex = math.max(self.confirmedPathIndex, stepIndex)
  self.serverPos.x = x
  self.serverPos.y = y
  self.parent:SetRolePos(x, y)
  MapModel.Instance:SetServerPos(x, y)
  Logger.Info("[Move] Step confirmed:", stepIndex, "pos:", x, y, "pending:", self.pendingReqCount)
  self:_CheckMoveAllDone()
end

function MapMoveManager:_OnMoveStepFailed(data, sessionId, stepIndex)
  if sessionId ~= self.moveSessionId then
    return
  end
  Logger.Warn("[Move] Step FAILED at index:", stepIndex, "confirmed so far:", self.confirmedPathIndex)
  local rollbackX, rollbackY
  if data and data.curPos then
    rollbackX, rollbackY = data.curPos[1], data.curPos[2]
  else
    rollbackX, rollbackY = MapModel.Instance:GetServerPos()
  end
  self:_CancelMovementAndRollback(rollbackX, rollbackY)
end

function MapMoveManager:_CheckMoveAllDone()
  if not self.isMoving then
    return
  end
  if not self.animAllDone then
    return
  end
  if self.pendingReqCount > 0 then
    return
  end
  local finalX, finalY = MapModel.Instance:GetServerPos()
  self:_OnPathComplete(finalX, finalY)
end

function MapMoveManager:Move(destPosX, destPosY, callBack, opts)
  opts = opts or {}
  if not self:CanMove(opts) then
    return false
  end
  EventMgr.Instance.RoleMove:Dispatch()
  local roleMgr = self:GetComponent(MapRoleManager)
  if not roleMgr or not roleMgr.role then
    return false
  end
  local curPosX, curPosY = roleMgr.role:GetGridPos()
  local dist = math.abs(destPosX - curPosX) + math.abs(destPosY - curPosY)
  if 0 == dist then
    Logger.Info("原地，不移动")
    if callBack then
      callBack(destPosX, destPosY)
    end
    return false
  end
  local gearMgr = self:GetComponent(MapGearManager)
  local targetGear = gearMgr and gearMgr:GetGearByPos(destPosX, destPosY)
  local finalDestX, finalDestY = destPosX, destPosY
  if targetGear and not targetGear:IsRemoved() then
    if self:IsAdjacent(curPosX, curPosY, destPosX, destPosY) then
      Logger.Info("目标位置有gear且已相邻，不移动")
      if callBack then
        callBack(destPosX, destPosY)
      end
      return false
    end
    local adjacentPos = self:FindBestAdjacentTerrain(destPosX, destPosY, curPosX, curPosY)
    if not adjacentPos then
      Logger.Warn("无法找到gear周围可用的terrain")
      Alert.ShowTopTips(10519)
      return false
    end
    finalDestX, finalDestY = adjacentPos.x, adjacentPos.y
    Logger.Info("目标位置有gear，移动到相邻terrain:", finalDestX, finalDestY)
  else
    Logger.Info("目标位置没有gear，直接寻路")
  end
  local path = self:FindPath(curPosX, curPosY, finalDestX, finalDestY)
  if not path or 0 == #path then
    Logger.Warn("无法找到路径到", finalDestX, finalDestY)
    Alert.ShowTopTips(10519)
    return false
  end
  if 1 == #path then
    Logger.Info("已在目标位置")
    if callBack then
      callBack(finalDestX, finalDestY)
    end
    return false
  end
  self.moveSessionId = self.moveSessionId + 1
  self.movePath = path
  self.animPathIndex = 1
  self.confirmedPathIndex = 0
  self.pendingReqCount = 0
  self.animAllDone = false
  self.moveEndCallBack = callBack
  self.isMoving = true
  self.followGearPendingMove = self:IsGearTriggerMove(opts)
  self.followGearTriggerUid = opts.gearUid
  local stepCount = #path - 1
  local timeout = math.max(2, stepCount * STEP_MOVE_DURATION + AWAITER_BUFFER_TIME)
  self:RecycleMoveAwaiter()
  self.moveAwaiter = StageAwaiter.Dispatch("RoleMove", timeout, true)
  self:_MoveToNextInPath()
  return true
end

function MapMoveManager:DirectMove(destPosX, destPosY, callBack, opts)
  opts = opts or {}
  if not self:CanMove(opts) then
    Logger.Warn("DirectMove: 无法移动")
    return false
  end
  EventMgr.Instance.RoleMove:Dispatch()
  local roleMgr = self:GetComponent(MapRoleManager)
  if not roleMgr or not roleMgr.role then
    Logger.Warn("DirectMove: 找不到角色")
    return false
  end
  local curPosX, curPosY = roleMgr.role:GetGridPos()
  if curPosX == destPosX and curPosY == destPosY then
    Logger.Info("DirectMove: 原地，不移动")
    if callBack then
      callBack(destPosX, destPosY)
    end
    return false
  end
  if not self:IsAdjacent(curPosX, curPosY, destPosX, destPosY) then
    Logger.Warn("DirectMove: 起点和终点不相邻，无法直接移动", curPosX, curPosY, "->", destPosX, destPosY)
    if callBack then
      callBack(destPosX, destPosY)
    end
    return false
  end
  if self:IsForbidBack(curPosX, curPosY, destPosX, destPosY) then
    Logger.Warn("DirectMove: 脆弱通路禁止回头", curPosX, curPosY, "->", destPosX, destPosY)
    Alert.Show(10555)
    if self:IsGearTriggerMove(opts) then
      self:_AbortGearTriggerOnMoveInterrupt(opts.gearUid)
    end
    return false
  end
  self.moveSessionId = self.moveSessionId + 1
  self.movePath = {
    {x = curPosX, y = curPosY},
    {x = destPosX, y = destPosY}
  }
  self.animPathIndex = 1
  self.confirmedPathIndex = 0
  self.pendingReqCount = 0
  self.animAllDone = false
  self.moveEndCallBack = callBack
  self.isMoving = true
  self.followGearPendingMove = self:IsGearTriggerMove(opts)
  self.followGearTriggerUid = opts.gearUid
  self.currentPos.x = destPosX
  self.currentPos.y = destPosY
  MapModel.Instance:SetCurrentPos(destPosX, destPosY)
  self:RecycleMoveAwaiter()
  self.moveAwaiter = StageAwaiter.Dispatch("RoleDirectMove", 2, true)
  local sessionId = self.moveSessionId
  self:_ReqMoveStep(destPosX, destPosY, sessionId, 2)
  self.animPathIndex = 2
  if roleMgr.role then
    roleMgr.role:MoveByGrid(destPosX, destPosY, System.fn(self, self.OnGridMoveCallFunc), function(posX, posY)
      self:_OnStepAnimDone(posX, posY, sessionId)
    end)
  end
  return true
end

function MapMoveManager:_MoveToNextInPath()
  if not self.movePath or 0 == #self.movePath then
    return
  end
  if self.animPathIndex >= #self.movePath then
    self:_CheckMoveAllDone()
    return
  end
  local nextPos = self.movePath[self.animPathIndex + 1]
  if not nextPos then
    return
  end
  local roleMgr = self:GetComponent(MapRoleManager)
  if not roleMgr or not roleMgr.role then
    return
  end
  local curPosX, curPosY = roleMgr.role:GetGridPos()
  if self:IsForbidBack(curPosX, curPosY, nextPos.x, nextPos.y) then
    Logger.Warn("路径中包含禁止回退的格子，停止移动")
    Alert.Show(10555)
    local serverX, serverY = MapModel.Instance:GetServerPos()
    self:_CancelMovementAndRollback(serverX, serverY)
    return
  end
  self.currentPos.x = nextPos.x
  self.currentPos.y = nextPos.y
  MapModel.Instance:SetCurrentPos(nextPos.x, nextPos.y)
  self.animPathIndex = self.animPathIndex + 1
  local sessionId = self.moveSessionId
  local stepIndex = self.animPathIndex
  self:_ReqMoveStep(nextPos.x, nextPos.y, sessionId, stepIndex)
  if roleMgr.role then
    roleMgr.role:MoveByGrid(nextPos.x, nextPos.y, System.fn(self, self.OnGridMoveCallFunc), function(posX, posY)
      self:_OnStepAnimDone(posX, posY, sessionId)
    end)
  end
end

function MapMoveManager:_OnStepAnimDone(posX, posY, sessionId)
  if sessionId ~= self.moveSessionId then
    return
  end
  self.currentPos.x = posX
  self.currentPos.y = posY
  MapModel.Instance:SetCurrentPos(posX, posY)
  local roleMgr = self:GetComponent(MapRoleManager)
  if roleMgr and roleMgr.role then
    roleMgr.role:SetGridPos(posX, posY)
  end
  if self.movePath and self.animPathIndex >= #self.movePath then
    self.animAllDone = true
    self:_CheckMoveAllDone()
    return
  end
  self:_MoveToNextInPath()
end

function MapMoveManager:_OnPathComplete(finalX, finalY)
  self.isMoving = false
  self.followGearPendingMove = false
  self.followGearTriggerUid = nil
  self.movePath = {}
  self.animPathIndex = 0
  self.confirmedPathIndex = 0
  self.pendingReqCount = 0
  self.animAllDone = false
  EventMgr.Instance.MoveEnd:Dispatch()
  if self.moveEndCallBack then
    local cb = self.moveEndCallBack
    self.moveEndCallBack = nil
    cb(finalX, finalY)
  end
  self:RecycleMoveAwaiter()
end

function MapMoveManager:_CancelMovement()
  self.moveSessionId = self.moveSessionId + 1
  self.isMoving = false
  self.followGearPendingMove = false
  self.followGearTriggerUid = nil
  self.movePath = {}
  self.animPathIndex = 0
  self.confirmedPathIndex = 0
  self.pendingReqCount = 0
  self.animAllDone = false
  self.moveEndCallBack = nil
  self:RecycleMoveAwaiter()
end

function MapMoveManager:_CancelMovementAndRollback(rollbackX, rollbackY)
  local followGear = self.followGearPendingMove
  local gearUid = self.followGearTriggerUid
  self:_CancelMovement()
  self:TransToPos(rollbackX, rollbackY)
  if followGear then
    self:_AbortGearTriggerOnMoveInterrupt(gearUid)
  end
end

function MapMoveManager:OnGridMoveCallFunc(posX, posY)
end

function MapMoveManager:RecycleMoveAwaiter()
  if self.moveAwaiter then
    self.moveAwaiter:SetCompleted()
    self.moveAwaiter:Recycle()
    self.moveAwaiter = nil
  end
end

function MapMoveManager:TransToPos(x, y, lv)
  local roleMgr = self:GetComponent(MapRoleManager)
  if not roleMgr or not roleMgr.role then
    return
  end
  local curPosX, curPosY = roleMgr.role:GetGridPos()
  local effectMgr = self:GetComponent(MapArtEffectManager)
  if effectMgr then
    effectMgr:PlayOpenMist(x, y)
    local roleFOV = lv or MapModel.Instance.roleFOV
    local upTime = 0.01
    local gapTime = self.parent:GetGapTime()
    local sinkTime = 0
    effectMgr:PlayGridAnimAfterMove(curPosX, curPosY, x, y, roleFOV, sinkTime, upTime, gapTime)
  end
  self.currentPos.x = x
  self.currentPos.y = y
  self.serverPos.x = x
  self.serverPos.y = y
  MapModel.Instance:SyncMovePos(x, y)
  if roleMgr.SetRolePos then
    roleMgr:SetRolePos(x, y)
  end
end

function MapMoveManager:SetRolePos(x, y)
  local roleMgr = self:GetComponent(MapRoleManager)
  if roleMgr and roleMgr.SetRolePos then
    roleMgr:SetRolePos(x, y)
  end
  self:SyncPos(x, y)
end

function MapMoveManager:IsMoving()
  return self.isMoving
end

function MapMoveManager:GetServerPos()
  do return MapModel.Instance.GetServerPos end
  return MapModel.Instance.GetServerPos, MapModel.Instance
end

function MapMoveManager:GetCurrentPos()
  do return MapModel.Instance.GetCurrentPos end
  return MapModel.Instance.GetCurrentPos, MapModel.Instance
end

function MapMoveManager:IsWalkable(x, y)
  local terrainMgr = self:GetComponent(MapTerrainManager)
  do return MapModel.Instance.IsWalkable, MapModel.Instance, x, y end
  return MapModel.Instance.IsWalkable, MapModel.Instance, x, y, terrainMgr
end

function MapMoveManager:IsAdjacent(x1, y1, x2, y2)
  do return MapModel.Instance.IsAdjacent, MapModel.Instance, x1, y1, x2 end
  return MapModel.Instance.IsAdjacent, MapModel.Instance, x1, y1, x2, y2
end

function MapMoveManager:FindBestAdjacentTerrain(gearX, gearY, startX, startY)
  local terrainMgr = self:GetComponent(MapTerrainManager)
  if not terrainMgr then
    return nil
  end
  local offsets = HexAStarPathfinder.GetNeighborOffsets(gearY)
  local validTerrains = {}
  for _, offset in ipairs(offsets) do
    local terrainX = gearX + offset[1]
    local terrainY = gearY + offset[2]
    if terrainX < 1 or terrainX > self.parent:GetMapWidth() or terrainY < 1 or terrainY > self.parent:GetMapHeight() then
    elseif not MapModel.Instance:CanStandOnAdjacentTerrain(terrainX, terrainY, terrainMgr) then
    else
      table.insert(validTerrains, {x = terrainX, y = terrainY})
    end
  end
  if 0 == #validTerrains then
    return nil
  end
  local bestPos
  local minDist = math.huge
  for _, pos in ipairs(validTerrains) do
    local path = self:FindPath(startX, startY, pos.x, pos.y)
    if path and #path > 0 then
      local pathLength = #path
      if minDist > pathLength then
        minDist = pathLength
        bestPos = pos
      end
    end
  end
  return bestPos
end

function MapMoveManager:FindPath(startX, startY, endX, endY)
  do return HexAStarPathfinder.FindPath, startX, startY, endX, endY, System.fn(self, self.IsWalkable), self.parent:GetMapWidth(), self.parent:GetMapHeight() end
  return HexAStarPathfinder.FindPath, startX, startY, endX, endY, System.fn(self, self.IsWalkable), self.parent:GetMapWidth(), self.parent:GetMapHeight()
end

function MapMoveManager:OnDestroy()
  Super.OnDestroy(self)
  self:_CancelMovement()
end

return MapMoveManager
