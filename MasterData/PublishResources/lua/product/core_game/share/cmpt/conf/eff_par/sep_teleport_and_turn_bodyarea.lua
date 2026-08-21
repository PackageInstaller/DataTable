require("skill_effect_param_base")
_class("SkillEffectParam_TeleportAndTurnBodyArea", SkillEffectParamBase)
SkillEffectParam_TeleportAndTurnBodyArea = SkillEffectParam_TeleportAndTurnBodyArea

function SkillEffectParam_TeleportAndTurnBodyArea:Constructor(t)
  local fixedPosData = t.fixedPosData
  self._posList = {}
  for i, v in ipairs(fixedPosData) do
    local pos = Vector2(v.pos[1], v.pos[2])
    local newDir = v.dir
    table.insert(self._posList, {pos = pos, dir = newDir})
  end
  self.ignoreBlock = t.ignoreBlock
end

function SkillEffectParam_TeleportAndTurnBodyArea:IsIgnoreBlock()
  return self.ignoreBlock
end

function SkillEffectParam_TeleportAndTurnBodyArea:GetEffectType()
  return SkillEffectType.TeleportAndTurnBodyArea
end

function SkillEffectParam_TeleportAndTurnBodyArea:GetFixedPosList()
  return self._posList
end
