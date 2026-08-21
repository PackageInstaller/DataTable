require("base_ins_r")
_class("PlayFromSPTrapMoveToCasterInstruction", BaseInstruction)
PlayFromSPTrapMoveToCasterInstruction = PlayFromSPTrapMoveToCasterInstruction

function PlayFromSPTrapMoveToCasterInstruction:Constructor(paramList)
  self._trapID = tonumber(paramList.trapID)
  self._time = tonumber(paramList.time)
  self._speed = tonumber(paramList.speed)
  self._stageIndex = tonumber(paramList.stageIndex) or 1
  assert(self._time or self._speed, "PlayTeleportAsMoving指令需要配置time参数")
  self._animName = paramList.animName
  self._moveSetDir = tonumber(paramList.moveSetDir)
  self._moveUseResDir = tonumber(paramList.moveUseResDir)
  self._dontSetGridDown = paramList.dontSetGridDown
end

function PlayFromSPTrapMoveToCasterInstruction:DoInstruction(TT, casterEntity, phaseContext)
  local routineComponent = casterEntity:SkillRoutine():GetResultContainer()
  local world = casterEntity:GetOwnerWorld()
  self._world = world
  local teamEntity = casterEntity:Pet():GetOwnerTeamEntity()
  local teamLeaderEntity = teamEntity:Team():GetTeamLeaderEntity()
  local pets = teamEntity:Team():GetTeamPetEntities()
  local boardServiceRender = world:GetService("BoardRender")
  local sourcePos = boardServiceRender:GetRealEntityGridPos(teamLeaderEntity)
  local utilDataSvc = world:GetService("UtilData")
  local trapEntityList = utilDataSvc:FindDontNeedAliveTrapByTrapID(self._trapID)
  if not trapEntityList or #trapEntityList == 0 then
    return
  end
  local trapEntityID = trapEntityList[#trapEntityList]
  local trapEntity = self._world:GetEntityByID(trapEntityID)
  local trapPos = boardServiceRender:GetRealEntityGridPos(trapEntity)
  local dir = sourcePos - trapPos
  casterEntity:SetLocation(trapPos, dir)
  local posOld = trapPos
  local posNew = sourcePos
  YIELD(TT)
  local distance = Vector2.Distance(posNew, posOld)
  local speed = self._speed
  if self._time then
    speed = distance / self._time * 1000
  end
  while casterEntity:HasGridMove() do
    local gridMoveComponent = casterEntity:GridMove()
    YIELD(TT)
  end
  local gridPos = boardServiceRender:GetRealEntityGridPos(casterEntity)
  casterEntity:AddGridMove(speed, posNew, gridPos)
  while casterEntity:HasGridMove() do
    YIELD(TT)
  end
  local viewPos = posNew:Clone()
  local offset = casterEntity:GetGridOffset()
  if offset then
    viewPos = viewPos + offset
  end
  casterEntity:SetPosition(viewPos)
end
