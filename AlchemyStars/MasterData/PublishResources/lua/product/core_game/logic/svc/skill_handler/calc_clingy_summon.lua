_class("SkillEffectCalc_ClingySummon", SkillEffectCalc_Base)
SkillEffectCalc_ClingySummon = SkillEffectCalc_ClingySummon

function SkillEffectCalc_ClingySummon:Constructor(world)
  self._world = world
end

function SkillEffectCalc_ClingySummon:DoSkillEffectCalculator(skillEffectCalcParam)
  local effectParam = skillEffectCalcParam:GetSkillEffectParam()
  local casterEntity = self._world:GetEntityByID(skillEffectCalcParam.casterEntityID)
  local casterPos = casterEntity:GetGridPosition()
  local areaCount = casterEntity:BodyArea():GetAreaCount()
  local monsterIDs = effectParam:GetSummonList()
  local result = {}
  local clingyMonster = SkillEffectResult_SummonEverything:New(SkillEffectEnum_SummonType.Monster, monsterIDs[1], casterPos, casterPos)
  table.insert(result, clingyMonster)
  if 1 < areaCount then
    local positions = {}
    local area = casterEntity:BodyArea():GetArea()
    for _, position in ipairs(area) do
      if position.x ~= 0 or position.y ~= 0 then
        table.insert(positions, casterPos + position)
      end
    end
    local randomSvc = self._world:GetService("RandomLogic")
    local index = randomSvc:LogicRand(1, #positions)
    local summonPosition = positions[index]
    local clingyMonsterOther = SkillEffectResult_SummonEverything:New(SkillEffectEnum_SummonType.Monster, monsterIDs[1], casterPos, summonPosition)
    table.insert(result, clingyMonsterOther)
  end
  return result
end
