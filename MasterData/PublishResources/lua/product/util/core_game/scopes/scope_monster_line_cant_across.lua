require("scope_base")
_class("SkillScopeCalculator_MonsterLineCantAcross", SkillScopeCalculator_Base)
SkillScopeCalculator_MonsterLineCantAcross = SkillScopeCalculator_MonsterLineCantAcross

function SkillScopeCalculator_MonsterLineCantAcross:CalcRange(scopeType, scopeParam, centerPos, bodyArea, casterDir, nTargetType, casterPos, casterEntity)
  local world = self._hub._gridFilter._world
  local utilScopeSvc = world:GetService("UtilScopeCalc")
  local utilData = world:GetService("UtilData")
  local monsterClassID = scopeParam[1]
  local containEdges = scopeParam[2] or 1
  local targetEntity
  local monsterList, monsterPosList = utilScopeSvc:SelectAllMonster()
  for i, e in ipairs(monsterList) do
    if monsterClassID == e:MonsterID():GetMonsterClassID() then
      targetEntity = e
      break
    end
  end
  if not targetEntity then
    return SkillScopeResult:New(SkillScopeType.MonsterLineCantAcross, casterPos, {}, {})
  end
  local targetPos = targetEntity:GetGridPosition()
  local cross_area = {}
  local wholeArea = {}
  local curPos = casterEntity:GetGridPosition()
  local curBodyArea = casterEntity:BodyArea():GetArea()
  local scopeCalculator = utilScopeSvc:GetSkillScopeCalc()
  local scopeParam = {widthThreshold = 0.7, noExtend = 1}
  local scopeResult = scopeCalculator:ComputeScopeRange(SkillScopeType.AngleFreeLine, scopeParam, targetPos, curBodyArea, nil, nil, curPos)
  local attackRange = scopeResult:GetAttackRange()
  
  local function CmpDistancefunc(pos1, pos2)
    local dis1 = Vector2.Distance(casterPos, pos1)
    local dis2 = Vector2.Distance(casterPos, pos2)
    return dis1 > dis2
  end
  
  table.sort(attackRange, CmpDistancefunc)
  local supplementPosList = {}
  for k, pos in ipairs(attackRange) do
    local nextPos = attackRange[k + 1]
    if not nextPos then
      break
    end
    if math.abs(pos.x - nextPos.x) == 1 and math.abs(pos.y - nextPos.y) == 1 then
      local remainPosList = {}
      local intableCount = 0
      local diffX = nextPos.x - pos.x
      local diffY = nextPos.y - pos.y
      for i = pos.x, nextPos.x, diffX do
        for j = pos.y, nextPos.y, diffY do
          local workPos = Vector2(i, j)
          if table.intable(attackRange, workPos) then
            intableCount = intableCount + 1
          elseif workPos ~= pos and workPos ~= nextPos then
            local isValidGrid = utilData:IsValidPiecePos(workPos)
            if isValidGrid then
              table.insert(remainPosList, workPos)
            end
          end
        end
      end
      if 0 < table.count(remainPosList) and intableCount == 2 then
        table.insert(supplementPosList, remainPosList[1])
      end
    end
  end
  table.appendArray(attackRange, supplementPosList)
  if containEdges == 0 then
    table.removev(attackRange, targetPos)
    table.removev(attackRange, casterPos)
  end
  local result = SkillScopeResult:New(SkillScopeType.MonsterLineCantAcross, casterPos, attackRange, attackRange)
  return result
end
