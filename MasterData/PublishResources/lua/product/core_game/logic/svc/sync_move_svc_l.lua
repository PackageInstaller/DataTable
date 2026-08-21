_class("SyncMoveServiceLogic", BaseService)
SyncMoveServiceLogic = SyncMoveServiceLogic

function SyncMoveServiceLogic:OnMovePathDone(chainPath)
  local group = self._world:GetGroup(self._world.BW_WEMatchers.SyncMoveWithTeam)
  local syncMoveEntites = group:GetEntities()
  for _, entity in ipairs(syncMoveEntites) do
    local syncCmpt = entity:SyncMoveWithTeam()
    syncCmpt:RecordTeamMovePath(chainPath)
    local startPos = entity:GridLocation().Position
    local syncMovePath = self:_CalcSyncMovePath(startPos, chainPath)
    syncCmpt:RecordSyncMovePath(syncMovePath)
    local finalPos = syncMovePath[#syncMovePath].tarPos
    local newDirection = entity:GetGridDirection()
    if 1 < #syncMovePath then
      newDirection = syncMovePath[#syncMovePath].tarPos - syncMovePath[#syncMovePath - 1].tarPos
    end
    local svc = self._world:GetService("L2R")
    svc:L2RSyncMoveData(entity:GetID(), syncMovePath)
    for pathIndex, path in ipairs(syncMovePath) do
      self:_NotifyEachMove(entity, syncMovePath, pathIndex)
    end
    entity:SetGridLocation(finalPos, newDirection)
    entity:GridLocation():SetMoveLastPosition(finalPos)
    local sBoard = self._world:GetService("BoardLogic")
    sBoard:UpdateEntityBlockFlag(entity, startPos, finalPos)
  end
end

function SyncMoveServiceLogic:CalcSyncMovePreviewPos(startPos, chainPath)
  local syncMovePath = self:_CalcSyncMovePath(startPos, chainPath)
  if syncMovePath and 0 < #syncMovePath then
    local finalPos = syncMovePath[#syncMovePath].tarPos
    return finalPos
  end
end

function SyncMoveServiceLogic:_CalcSyncMovePath(startPos, chainPath)
  local lastPos, lastChainPos
  local syncMovePath = {}
  for index, chainPos in ipairs(chainPath) do
    local movePos
    if not lastChainPos then
      movePos = startPos
      local moveInfo = {}
      moveInfo.tarPos = movePos
      table.insert(syncMovePath, moveInfo)
    else
      local moveDir = chainPos - lastChainPos
      local tarPos = lastPos + moveDir
      if self:_PosCanMove(tarPos) then
        movePos = tarPos
        local moveInfo = {}
        moveInfo.tarPos = movePos
        table.insert(syncMovePath, moveInfo)
      else
        movePos = lastPos
        local moveInfo = {}
        moveInfo.tarPos = movePos
        table.insert(syncMovePath, moveInfo)
      end
    end
    lastPos = movePos
    lastChainPos = chainPos
  end
  return syncMovePath
end

function SyncMoveServiceLogic:_PosCanMove(tarPos)
  local boardService = self._world:GetService("BoardLogic")
  local utilDataSvc = self._world:GetService("UtilData")
  if utilDataSvc:IsValidPiecePos(tarPos) then
    return true
  end
  return false
end

function SyncMoveServiceLogic:_NotifyEachMove(e, syncPath, pathIndex)
  local tarPath = syncPath[pathIndex]
  if tarPath then
    local oldPos = tarPath.tarPos
    local lastPath = syncPath[pathIndex - 1]
    if lastPath then
      oldPos = lastPath.tarPos
    end
    local newDirection = e:GetGridDirection()
    e:SetGridLocation(tarPath.tarPos, newDirection)
    local triggerSvc = self._world:GetService("Trigger")
    local ntSyncMoveEachMoveEnd = NTSyncMoveEachMoveEnd:New(e, tarPath.tarPos, oldPos, pathIndex)
    triggerSvc:Notify(ntSyncMoveEachMoveEnd)
  end
end
