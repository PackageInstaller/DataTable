_class("SyncMoveServiceRender", BaseService)
SyncMoveServiceRender = SyncMoveServiceRender

function SyncMoveServiceRender:OnGridMoveToPos(e, pathIndex, speed, teamEntity)
  local leader = teamEntity:GetTeamLeaderPetEntity()
  if leader:GetID() == e:GetID() then
    local group = self._world:GetGroup(self._world.BW_WEMatchers.RenderSyncMoveWithTeam)
    local syncMoveEntites = group:GetEntities()
    local boardServiceRender = self._world:GetService("BoardRender")
    for _, e in ipairs(syncMoveEntites) do
      local syncMoveCmptRender = e:RenderSyncMoveWithTeam()
      if syncMoveCmptRender then
        local syncPath = syncMoveCmptRender:GetSyncMovePath()
        if syncPath then
          local tarPath = syncPath[pathIndex]
          if tarPath then
            local destPos = tarPath.tarPos
            local curPos = boardServiceRender:GetRealEntityGridPos(e)
            e:SetAnimatorControllerBools({Move = true})
            e:SetDirection(destPos - curPos)
            e:AddGridMove(speed, destPos, curPos)
          end
        end
      end
    end
  end
end

function SyncMoveServiceRender:OnArriveAtPos(e, pathIndex, teamEntity)
  local leader = teamEntity:GetTeamLeaderPetEntity()
  if leader:GetID() == e:GetID() then
    local group = self._world:GetGroup(self._world.BW_WEMatchers.RenderSyncMoveWithTeam)
    local syncMoveEntites = group:GetEntities()
    local boardServiceRender = self._world:GetService("BoardRender")
    local playBuffSvc = self._world:GetService("PlayBuff")
    for _, e in ipairs(syncMoveEntites) do
      local syncMoveCmptRender = e:RenderSyncMoveWithTeam()
      if syncMoveCmptRender then
        local syncPath = syncMoveCmptRender:GetSyncMovePath()
        if syncPath then
          local tarPath = syncPath[pathIndex]
          if tarPath then
            local oldPos = tarPath.tarPos
            local lastPath = syncPath[pathIndex - 1]
            if lastPath then
              oldPos = lastPath.tarPos
            end
            local ntSyncMoveEachMoveEnd = NTSyncMoveEachMoveEnd:New(e, tarPath.tarPos, oldPos, pathIndex)
            GameGlobal.TaskManager():CoreGameStartTask(function(TT)
              playBuffSvc:PlayBuffView(TT, ntSyncMoveEachMoveEnd)
            end)
            if pathIndex == #syncPath then
              e:SetAnimatorControllerBools({Move = false})
            end
          end
        end
      end
    end
  end
end

function SyncMoveServiceRender:PreviewOnLinkLine(chainPath)
  local group = self._world:GetGroup(self._world.BW_WEMatchers.RenderSyncMoveWithTeam)
  local syncMoveEntites = group:GetEntities()
  local boardServiceRender = self._world:GetService("BoardRender")
  local entitySvc = self._world:GetService("RenderEntity")
  local utilCalcSvc = self._world:GetService("UtilCalc")
  for _, e in ipairs(syncMoveEntites) do
    local syncMoveCmptRender = e:RenderSyncMoveWithTeam()
    if syncMoveCmptRender then
      local curPos = e:GridLocation().Position
      local finalPos = utilCalcSvc:CalSyncMovePreviewPos(curPos, chainPath)
      if finalPos then
        local ghostEntityID = syncMoveCmptRender:GetGhostEntityID()
        local ghostEntity
        if ghostEntityID then
          ghostEntity = self._world:GetEntityByID(ghostEntityID)
        else
          ghostEntity = entitySvc:CreateGhost(finalPos, e)
          if ghostEntity then
            syncMoveCmptRender:SetGhostEntityID(ghostEntity:GetID())
          end
        end
        if ghostEntity then
          ghostEntity:SetPosition(finalPos)
        end
      end
    end
  end
end

function SyncMoveServiceRender:ClearPreview()
  local group = self._world:GetGroup(self._world.BW_WEMatchers.RenderSyncMoveWithTeam)
  local syncMoveEntites = group:GetEntities()
  local boardServiceRender = self._world:GetService("BoardRender")
  local entitySvc = self._world:GetService("RenderEntity")
  entitySvc:DestroyGhost()
  local utilCalcSvc = self._world:GetService("UtilCalc")
  for _, e in ipairs(syncMoveEntites) do
    local syncMoveCmptRender = e:RenderSyncMoveWithTeam()
    if syncMoveCmptRender then
      local ghostEntityID = syncMoveCmptRender:GetGhostEntityID()
      if ghostEntityID then
        syncMoveCmptRender:SetGhostEntityID(nil)
      end
    end
  end
end
