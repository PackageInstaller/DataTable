require("play_skill_phase_base_r")
_class("PlaySkillMultiGridDamageTracePhase", PlaySkillPhaseBase)
PlaySkillMultiGridDamageTracePhase = PlaySkillMultiGridDamageTracePhase

function PlaySkillMultiGridDamageTracePhase:_DoEffect2x2(TT, casterEntity, pos, isPlayerIncluded, direction, phaseParam)
  local effectService = self._world:GetService("Effect")
  if isPlayerIncluded then
    effectService:CreateWorldPositionDirectionEffect(phaseParam:GetHitEffectID(), pos, direction)
  else
    effectService:CreateWorldPositionDirectionEffect(phaseParam:GetPathEffectID(), pos, direction)
  end
end

function PlaySkillMultiGridDamageTracePhase:_GetEffectPosArray(casterEntity)
  local gridLocationComponent = casterEntity:GridLocation()
  local gridArray = {}
  local direction = gridLocationComponent:GetGridDir()
  local casterPos = casterEntity:GetGridPosition()
  local beginPos = Vector2.New(casterPos.x, casterPos.y)
  local bodyArea = casterEntity:BodyArea():GetArea()
  local vecMove = direction * 2
  local tmpVecArray = {}
  for _, areaOffset in ipairs(bodyArea) do
    local areaPos = Vector2(beginPos.x + areaOffset.x, beginPos.y + areaOffset.y)
    table.insert(tmpVecArray, areaPos)
  end
  local teamEntity = self._world:Player():GetCurrentTeamEntity()
  local playerPos = teamEntity:GetGridPosition()
  local effPosArray = {}
  local isBoardEdgeReached = false
  local utilDataSvc = self._world:GetService("UtilData")
  while not isBoardEdgeReached do
    beginPos = beginPos + vecMove
    local isPosGood = false
    for index, areaOffset in ipairs(bodyArea) do
      tmpVecArray[index] = tmpVecArray[index] + vecMove
      local pos = tmpVecArray[index]
      local isPieceOnBoard = utilDataSvc:IsValidPiecePos(pos) and not utilDataSvc:IsPosBlock(pos, BlockFlag.Skill | BlockFlag.SkillSkip)
      isPosGood = isPosGood or isPieceOnBoard
      if not isPieceOnBoard then
        isBoardEdgeReached = true
      end
    end
    if not isPosGood then
      break
    end
    table.insert(effPosArray, {
      pos = Vector2(beginPos.x + 0.5, beginPos.y + 0.5),
      isPlayerIncluded = table.icontains(tmpVecArray, playerPos)
    })
  end
  return effPosArray
end

function PlaySkillMultiGridDamageTracePhase:PlayFlight(TT, casterEntity, phaseParam)
  local routineComponent = casterEntity:SkillRoutine():GetResultContainer()
  local damageResult = routineComponent:GetEffectResultByArray(SkillEffectType.Damage)
  if not damageResult or not damageResult:GetTargetID() then
    return
  end
  local hitbackResult = routineComponent:GetEffectResultByArray(SkillEffectType.HitBack)
  local effPosArray = self:_GetEffectPosArray(casterEntity)
  if #effPosArray == 0 then
    return
  end
  local pathFxID = phaseParam:GetPathEffectID()
  local hitFxID = phaseParam:GetHitEffectID()
  local interval = phaseParam:GetInterval()
  local gridLocationComponent = casterEntity:GridLocation()
  local direction = gridLocationComponent:GetGridDir()
  local effectService = self._world:GetService("Effect")
  for i = 1, #effPosArray - 1 do
    local posInfo = effPosArray[i]
    self:_DoEffect2x2(TT, casterEntity, posInfo.pos, posInfo.isPlayerIncluded, direction, phaseParam)
    YIELD(TT, interval)
  end
  local lastPosInfo = effPosArray[#effPosArray]
  self:_DoEffect2x2(TT, casterEntity, lastPosInfo.pos, lastPosInfo.isPlayerIncluded, direction, phaseParam)
end
