_class("PlaySnakeTailMoveInstruction", BaseInstruction)
PlaySnakeTailMoveInstruction = PlaySnakeTailMoveInstruction

function PlaySnakeTailMoveInstruction:Constructor(paramList)
  self._moveAnim = paramList.MoveAnim
end

function PlaySnakeTailMoveInstruction:GetCacheResource()
end

function PlaySnakeTailMoveInstruction:DoInstruction(TT, casterEntity, phaseContext)
  local world = casterEntity:GetOwnerWorld()
  local skillEffectResultContainer = casterEntity:SkillRoutine():GetResultContainer()
  local resultArray = skillEffectResultContainer:GetEffectResultsAsArray(SkillEffectType.SnakeTailMove)
  if not resultArray then
    return
  end
  local result = resultArray[#resultArray]
  if result:IsCasterDead() then
    local sMonsterShowRender = world:GetService("MonsterShowRender")
    sMonsterShowRender:_DoOneMonsterDead(TT, casterEntity)
    return
  end
  if not result:GetNewPos() then
    return
  end
  local oldPos = casterEntity:GetRenderGridPosition()
  local newPos = result:GetNewPos()
  local playSkillInstructionSvc = world:GetService("PlaySkillInstruction")
  local trapResList = result:GetTriggerTrapResult()
  local moveSpeed = playSkillInstructionSvc:GetMoveSpeed(casterEntity)
  playSkillInstructionSvc:PlayEntityMove(TT, casterEntity, oldPos, newPos, moveSpeed)
  local bodyPos = result:GetLastBodyPos()
  local dir = bodyPos - newPos
  casterEntity:SetDirection(dir)
  playSkillInstructionSvc:PlayArrivePosTriggerTrap(TT, casterEntity, newPos, trapResList)
  world:GetService("PlayBuff"):PlayBuffView(TT, NTSnakeTailMoved:New(casterEntity, newPos, oldPos))
end
