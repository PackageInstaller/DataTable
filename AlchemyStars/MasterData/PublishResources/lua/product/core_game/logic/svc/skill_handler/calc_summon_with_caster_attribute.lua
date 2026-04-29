_class("SkillEffectCalc_SummonWithCasterAttribute", SkillEffectCalc_Base)
SkillEffectCalc_SummonWithCasterAttribute = SkillEffectCalc_SummonWithCasterAttribute

function SkillEffectCalc_SummonWithCasterAttribute:Constructor(world)
  self._world = world
end

function SkillEffectCalc_SummonWithCasterAttribute:DoSkillEffectCalculator(skillEffectCalcParam)
  local results = {}
  local effectParam = skillEffectCalcParam:GetSkillEffectParam()
  local skillRange = table.clone(skillEffectCalcParam.skillRange)
  local casterEntity = self._world:GetEntityByID(skillEffectCalcParam.casterEntityID)
  local casterPos = casterEntity:GetGridPosition()
  local compareAttributeType = effectParam:GetCompareType()
  local compareAttribute
  local attrCmpt = casterEntity:Attributes()
  if compareAttributeType == SummonWithCasterAttributeType.HpPercent then
    local max_hp = attrCmpt:CalcMaxHp()
    local cur_hp = attrCmpt:GetCurrentHP()
    compareAttribute = math.floor(cur_hp / max_hp * 100)
  end
  local compareParam = effectParam:GetCompareParam()
  local compareSymbol = effectParam:GetCompareSymbol()
  local satisfied = false
  if compareSymbol == ComparisonOperator.EQ then
    satisfied = compareAttribute == compareParam
  elseif compareSymbol == ComparisonOperator.NE then
    satisfied = compareAttribute ~= compareParam
  elseif compareSymbol == ComparisonOperator.GT then
    satisfied = compareAttribute > compareParam
  elseif compareSymbol == ComparisonOperator.GE then
    satisfied = compareAttribute >= compareParam
  elseif compareSymbol == ComparisonOperator.LT then
    satisfied = compareAttribute < compareParam
  elseif compareSymbol == ComparisonOperator.LE then
    satisfied = compareAttribute <= compareParam
  end
  if not satisfied then
    return {}
  end
  if not skillRange or table.count(skillRange) == 0 then
    return {}
  end
  local hadSummonPosList = {}
  local randomSvc = self._world:GetService("RandomLogic")
  local boardSvc = self._world:GetService("BoardLogic")
  skillRange = randomSvc:Shuffle(skillRange)
  local monsterIDList = effectParam:GetMonsterID()
  for _, monsterID in ipairs(monsterIDList) do
    local summonPos
    for i, v in ipairs(skillRange) do
      if not boardSvc:IsPosBlock(v, BlockFlag.MonsterLand) and not table.icontains(hadSummonPosList, summonPos) then
        summonPos = v
        table.insert(hadSummonPosList, summonPos)
        break
      end
    end
    local result = SkillEffectResult_SummonEverything:New(SkillEffectEnum_SummonType.Monster, monsterID, casterPos, summonPos)
    table.insert(results, result)
  end
  return results
end
