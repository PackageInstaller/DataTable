require("command_base_handler")
_class("PopStarProPickUpCommandHandler", CommandBaseHandler)
PopStarProPickUpCommandHandler = PopStarProPickUpCommandHandler

function PopStarProPickUpCommandHandler:DoHandleCommand(cmd)
  Log.notice("Handle PopStarPickUpCommand")
  local gridPos = cmd:GetCmdPickUpPos()
  local isValid = self:CheckPickUpPosValid(gridPos)
  if not isValid then
    return
  end
  local popStarSvc = self._world:GetService("PopStarProLogic")
  local connectPieces = popStarSvc:CalculatePopStarConnectPieces(gridPos)
  if connectPieces and #connectPieces == 0 then
    return
  end
  popStarSvc:SetPopConnectPieces(connectPieces)
  local utilDataSvc = self._world:GetService("UtilData")
  local teamEntity = self._world:Player():GetCurrentTeamEntity()
  local chainPath = {gridPos}
  if utilDataSvc:CanCastChainSkill(teamEntity, gridPos, connectPieces) then
    table.appendArray(chainPath, connectPieces)
  end
  local elementType = utilDataSvc:GetPieceType(gridPos)
  local battleStatCmpt = self._world:BattleStat()
  battleStatCmpt:AddTotalChainNum()
  self:_InitChainPathData(teamEntity, chainPath, elementType)
  self:_UpdateGridLocationByPickUpPos(teamEntity, gridPos)
  local l2RSvc = self._world:GetService("L2R")
  l2RSvc:L2RNTSelectRoundTeamNormalBefore(elementType, chainPath)
  local svc = self._world:GetService("L2R")
  svc:L2RChainPathData(teamEntity)
  self._world:EventDispatcher():Dispatch(GameEventType.WaitInputFinish, 1)
end

function PopStarProPickUpCommandHandler:CheckPickUpPosValid(gridPos)
  local utilDataSvc = self._world:GetService("UtilData")
  local isValid = utilDataSvc:IsValidPiecePos(gridPos)
  if not isValid then
    Log.fatal("PopStarPickUpCommand Invalid pos error, pick pos: ", Vector2.Pos2Index(gridPos))
    return false
  end
  return true
end

function PopStarProPickUpCommandHandler:_InitChainPathData(teamEntity, chainPath, elementType)
  local logicChainPathCmpt = teamEntity:LogicChainPath()
  logicChainPathCmpt:SetLogicChainPath(chainPath, elementType)
  local oldPos = teamEntity:GetGridPosition()
  logicChainPathCmpt:SetChainPathStartPos(oldPos)
  local utilCalcSvc = self._world:GetService("UtilCalc")
  logicChainPathCmpt:SetChainRateAtIndex(1, 0)
  for i = 2, #chainPath do
    local chainRate = utilCalcSvc:GetChainDamageRateAtIndex(chainPath, i)
    logicChainPathCmpt:SetChainRateAtIndex(i, chainRate)
  end
  local cr, superGridCount, poorGridCount = utilCalcSvc:GetChainDamageRateAtIndex(chainPath, #chainPath)
  local buffComp = teamEntity:BuffComponent()
  local addCountVal = buffComp:GetBuffValue("PetAbsorbSuperGridCount")
  if addCountVal then
    local addCount = tonumber(addCountVal)
    if 0 < addCount then
      superGridCount = superGridCount + addCount
    end
  end
  logicChainPathCmpt:SetPathSuperGridCount({
    [#chainPath] = superGridCount
  })
  logicChainPathCmpt:SetPathPoorGridCount({
    [#chainPath] = poorGridCount
  })
end

function PopStarProPickUpCommandHandler:_UpdateGridLocationByPickUpPos(teamEntity, gridPos)
  local oldPos = teamEntity:GetGridPosition()
  local pets = teamEntity:Team():GetTeamPetEntities()
  for _, entityPet in ipairs(pets) do
    entityPet:SetGridPosition(gridPos)
    entityPet:GridLocation():SetMoveLastPosition(gridPos)
  end
  teamEntity:SetGridLocation(gridPos)
  teamEntity:GridLocation():SetMoveLastPosition(gridPos)
  local boardLSvc = self._world:GetService("BoardLogic")
  boardLSvc:UpdateEntityBlockFlag(teamEntity, oldPos, gridPos)
end
