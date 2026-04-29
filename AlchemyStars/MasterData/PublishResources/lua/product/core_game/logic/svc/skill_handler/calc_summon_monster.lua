_class("SkillEffectCalc_SummonMonster", SkillEffectCalc_Base)
SkillEffectCalc_SummonMonster = SkillEffectCalc_SummonMonster

function SkillEffectCalc_SummonMonster:DoSkillEffectCalculator(skillEffectCalcParam)
  local effectParam = skillEffectCalcParam:GetSkillEffectParam()
  local skillRange = table.clone(skillEffectCalcParam.skillRange)
  local casterEntity = self._world:GetEntityByID(skillEffectCalcParam.casterEntityID)
  local casterPos = casterEntity:GetGridPosition()
  local findPosType = effectParam:GetFindPosType()
  local monsterID = effectParam:GetMonsterID()
  local summonPos
  if findPosType == SummonMonsterFindPosType.RangRandom then
    local randomSvc = self._world:GetService("RandomLogic")
    local boardSvc = self._world:GetService("BoardLogic")
    skillRange = randomSvc:Shuffle(skillRange)
    for i, v in ipairs(skillRange) do
      if not boardSvc:IsPosBlock(v, BlockFlag.MonsterLand) then
        summonPos = v
        break
      end
    end
  elseif findPosType == SummonMonsterFindPosType.RangeFixed4 then
    summonPos = self:RangeFixed4(skillRange)
  end
  local result = SkillEffectResult_SummonEverything:New(SkillEffectEnum_SummonType.Monster, monsterID, casterPos, summonPos)
  return {result}
end

function SkillEffectCalc_SummonMonster:RangeFixed4(skillRange)
  local spPos = skillRange[1]
  local spRange = {}
  for i, v in ipairs(Offset4) do
    local pos = Vector2(spPos.x + v[1], spPos.y + v[2])
    table.insert(spRange, pos)
  end
  local randomSvc = self._world:GetService("RandomLogic")
  local boardSvc = self._world:GetService("BoardLogic")
  spRange = randomSvc:Shuffle(spRange)
  for i, pos in ipairs(spRange) do
    if boardSvc:IsPosBlock(pos, BlockFlag.MonsterLand) then
      return pos
    end
  end
  for i = 1, 10 do
    local ringRange = ComputeScopeRange.ComputeRange_SquareRing(spPos, 1, i)
    for _, pos in ipairs(ringRange) do
      if boardSvc:IsPosBlock(pos, BlockFlag.MonsterLand) then
        return pos
      end
    end
  end
end
