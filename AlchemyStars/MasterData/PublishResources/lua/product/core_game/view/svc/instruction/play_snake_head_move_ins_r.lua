_class("PlaySnakeHeadMoveInstruction", BaseInstruction)
PlaySnakeHeadMoveInstruction = PlaySnakeHeadMoveInstruction

function PlaySnakeHeadMoveInstruction:Constructor(paramList)
  self._moveAnim = paramList.MoveAnim
end

function PlaySnakeHeadMoveInstruction:GetCacheResource()
end

function PlaySnakeHeadMoveInstruction:DoInstruction(TT, casterEntity, phaseContext)
  local world = casterEntity:GetOwnerWorld()
  local skillEffectResultContainer = casterEntity:SkillRoutine():GetResultContainer()
  local resultArray = skillEffectResultContainer:GetEffectResultsAsArray(SkillEffectType.SnakeHeadMove)
  if not resultArray then
    return
  end
  local result = resultArray[#resultArray]
  local oldPos = result:GetOldPos()
  local newPos = result:GetNewPos()
  local playSkillInstructionSvc = world:GetService("PlaySkillInstruction")
  local casterIsDead = result:GetCasterIsDead()
  if casterIsDead then
    local sMonsterShowRender = world:GetService("MonsterShowRender")
    sMonsterShowRender:_DoOneMonsterDead(TT, casterEntity)
  else
    local trapResList = result:GetTriggerTrapResult()
    local moveSpeed = playSkillInstructionSvc:GetMoveSpeed(casterEntity)
    playSkillInstructionSvc:PlayEntityMove(TT, casterEntity, oldPos, newPos, moveSpeed)
    playSkillInstructionSvc:PlayArrivePosTriggerTrap(TT, casterEntity, newPos, trapResList)
    world:GetService("PlayBuff"):PlayBuffView(TT, NTSnakeHeadMoved:New(casterEntity, newPos, oldPos))
  end
end

function PlaySnakeHeadMoveInstruction:_PlayArrivePosTriggerTrap(TT, monsterEntity, pos, trapResList)
  for _, v in ipairs(trapResList) do
    local walkTrapRes = v
    local trapEntityID = walkTrapRes:GetTrapEntityID()
    local trapEntity = self._world:GetEntityByID(trapEntityID)
    local trapSkillRes = walkTrapRes:GetTrapResult()
    local skillEffectResultContainer = trapSkillRes:GetResultContainer()
    trapEntity:SkillRoutine():SetResultContainer(skillEffectResultContainer)
    Log.debug("[AIMove] PlayArrivePos() monster=", monsterEntity:GetID(), " pos=", pos, " play trapid=", trapEntity:GetID(), " defender=", skillEffectResultContainer:GetScopeResult():GetTargetIDs()[1])
    local trapSvc = self._world:GetService("TrapRender")
    trapSvc:PlayTrapTriggerSkill(TT, trapEntity, false, monsterEntity)
  end
end
