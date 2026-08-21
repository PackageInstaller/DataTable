_class("SkillEffectCalc_ChangeBodyArea", Object)
SkillEffectCalc_ChangeBodyArea = SkillEffectCalc_ChangeBodyArea

function SkillEffectCalc_ChangeBodyArea:Constructor(world)
  self._world = world
end

function SkillEffectCalc_ChangeBodyArea:DoSkillEffectCalculator(skillEffectCalcParam)
  local skillEffectParam = skillEffectCalcParam.skillEffectParam
  local bodyArea = skillEffectParam:GetBodyArea()
  local newBodyArea = {}
  for i, v in ipairs(bodyArea) do
    local pos = Vector2(v[1], v[2])
    table.insert(newBodyArea, pos)
  end
  local results = {}
  local targets = skillEffectCalcParam:GetTargetEntityIDs()
  for _, targetID in ipairs(targets) do
    local result = SkillEffectResultChangeBodyArea:New(targetID, newBodyArea)
    if result then
      table.insert(results, result)
    end
  end
  return results
end
