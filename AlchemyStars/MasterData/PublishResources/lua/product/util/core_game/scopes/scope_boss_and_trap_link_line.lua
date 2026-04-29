require("scope_base")
_class("SkillScopeCalculator_BossAndTrapLinkLine", SkillScopeCalculator_Base)
SkillScopeCalculator_BossAndTrapLinkLine = SkillScopeCalculator_BossAndTrapLinkLine

function SkillScopeCalculator_BossAndTrapLinkLine:CalcRange(scopeType, scopeParam, centerPos, bodyArea, casterDir, nTargetType, casterPos)
  if #bodyArea ~= 4 then
    Log.error("[BossAndTrapLinkLine] caster body area error, body area size must be 4, cur size=", #bodyArea)
    return
  end
  local trapID = scopeParam.trapID
  local noExtend = scopeParam.noExtend == 1
  local widthThreshold = BattleConst.ScopeAngleFreeLineThreshold
  if scopeParam.widthThreshold then
    widthThreshold = scopeParam.widthThreshold * 0.8
  end
  local trapCount = 2
  local trapPosList = {}
  local world = self._gridFilter._world
  local utilDataSvc = world:GetService("UtilData")
  local trapEntityList = utilDataSvc:GetTrapByID(trapID)
  for _, trapEntity in ipairs(trapEntityList) do
    if not trapEntity:HasDeadMark() then
      local trapPos = trapEntity:GetGridPosition():Clone()
      table.insert(trapPosList, trapPos)
    end
  end
  if trapCount > #trapPosList then
    Log.error("[BossAndTrapLinkLine] trap count error, trap id = ", trapID, ", trap count = ", #trapPosList)
    return
  end
  local trap1Pos = trapPosList[1]
  local trap2Pos = trapPosList[2]
  local norDir = casterDir
  local leftUp = centerPos + Vector2(0, 1)
  local leftDown = centerPos + Vector2(0, 0)
  local rightUp = centerPos + Vector2(1, 1)
  local rightDown = centerPos + Vector2(1, 0)
  local tailLeftPos = leftDown
  local tailRightPos = rightDown
  local trapLeftPos = trap1Pos
  local trapRightPos = trap2Pos
  if norDir == Vector2.up then
    if trap1Pos.x < trap2Pos.x then
      trapLeftPos = trap1Pos
      trapRightPos = trap2Pos
    else
      trapLeftPos = trap2Pos
      trapRightPos = trap1Pos
    end
  elseif norDir == Vector2.down then
    tailLeftPos = rightUp
    tailRightPos = leftUp
    if trap1Pos.x > trap2Pos.x then
      trapLeftPos = trap1Pos
      trapRightPos = trap2Pos
    else
      trapLeftPos = trap2Pos
      trapRightPos = trap1Pos
    end
  elseif norDir == Vector2.left then
    tailLeftPos = rightDown
    tailRightPos = rightUp
    if trap1Pos.y < trap2Pos.y then
      trapLeftPos = trap1Pos
      trapRightPos = trap2Pos
    else
      trapLeftPos = trap2Pos
      trapRightPos = trap1Pos
    end
  elseif norDir == Vector2.right then
    tailLeftPos = leftUp
    tailRightPos = leftDown
    if trap1Pos.y > trap2Pos.y then
      trapLeftPos = trap1Pos
      trapRightPos = trap2Pos
    else
      trapLeftPos = trap2Pos
      trapRightPos = trap1Pos
    end
  else
    Log.error("[XForwardToOutside] caster dir error, dir=Vector2( ", norDir.x, ", ", norDir.y, " )")
    return
  end
  local lineList = {}
  lineList[1] = {startPos = tailLeftPos, endPos = trapLeftPos}
  lineList[2] = {startPos = tailRightPos, endPos = trapRightPos}
  lineList[3] = {startPos = trapLeftPos, endPos = trapRightPos}
  local totalAttackRange = {}
  local totalWholeRange = {}
  local utilSCSvc = world:GetService("UtilScopeCalc")
  for _, line in ipairs(lineList) do
    local attackRange = {}
    local wholeRange = {}
    utilSCSvc:P2PAngleFreeLineRange(line.startPos, line.endPos, attackRange, wholeRange, noExtend, widthThreshold, true)
    table.appendArray(totalAttackRange, attackRange)
    table.appendArray(totalWholeRange, wholeRange)
  end
  totalAttackRange = table.unique(totalAttackRange)
  totalWholeRange = table.unique(totalWholeRange)
  local result = SkillScopeResult:New(SkillScopeType.BossAndTrapLinkLine, centerPos, totalWholeRange, totalWholeRange)
  return result
end
