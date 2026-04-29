require("base_ins_r")
_class("PlayCasterInTrapPosInstruction", BaseInstruction)
PlayCasterInTrapPosInstruction = PlayCasterInTrapPosInstruction

function PlayCasterInTrapPosInstruction:Constructor(paramList)
  self._trapID = tonumber(paramList.trapID)
end

function PlayCasterInTrapPosInstruction:DoInstruction(TT, casterEntity, phaseContext)
  local routineComponent = casterEntity:SkillRoutine():GetResultContainer()
  local world = casterEntity:GetOwnerWorld()
  self._world = world
  local boardServiceRender = world:GetService("BoardRender")
  local sourcePos = boardServiceRender:GetRealEntityGridPos(casterEntity)
  local utilDataSvc = world:GetService("UtilData")
  local trapEntityList = utilDataSvc:FindDontNeedAliveTrapByTrapID(self._trapID)
  if not trapEntityList or #trapEntityList == 0 then
    return
  end
  local teamEntity = casterEntity:Pet():GetOwnerTeamEntity()
  local teamLeaderEntity = teamEntity:Team():GetTeamLeaderEntity()
  local pets = teamEntity:Team():GetTeamPetEntities()
  local trapEntityID = trapEntityList[#trapEntityList]
  local trapEntity = self._world:GetEntityByID(trapEntityID)
  local trapPos = boardServiceRender:GetRealEntityGridPos(trapEntity)
  local dir = sourcePos - trapPos
  casterEntity:SetLocation(trapPos, dir)
  for i, petEntity in ipairs(pets) do
    if petEntity:GetID() ~= casterEntity:GetID() then
      petEntity:SetViewVisible(false)
    else
      petEntity:SetViewVisible(true)
    end
  end
end
