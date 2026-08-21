require("skill_effect_result_base")
_class("SkillEffectResultPetMinosGhostDamage", SkillEffectResultBase)
SkillEffectResultPetMinosGhostDamage = SkillEffectResultPetMinosGhostDamage

function SkillEffectResultPetMinosGhostDamage:GetEffectType()
  return SkillEffectType.PetMinosGhostDamage
end

function SkillEffectResultPetMinosGhostDamage:Constructor(centerPos, damageResults, curMovePath)
  self._centerPos = centerPos
  self._damageResults = damageResults
  self._curMovePath = {}
  for index, value in ipairs(curMovePath) do
    table.insert(self._curMovePath, Vector2(value.x, value.y))
  end
end

function SkillEffectResultPetMinosGhostDamage:GetCastCenterPos()
  return self._centerPos
end

function SkillEffectResultPetMinosGhostDamage:GetDamageResults()
  return self._damageResults
end

function SkillEffectResultPetMinosGhostDamage:GetCurMovePath()
  return self._curMovePath
end
