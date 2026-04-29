require("skill_effect_param_base")
_class("SkillEffectParam_TeleportAndReplaceBodyArea", SkillEffectParamBase)
SkillEffectParam_TeleportAndReplaceBodyArea = SkillEffectParam_TeleportAndReplaceBodyArea

function SkillEffectParam_TeleportAndReplaceBodyArea:Constructor(t)
  local posData = t.pos
  self._pos = Vector2(posData[1], posData[2])
  local dirData = t.dir
  self._dir = Vector2(dirData[1], dirData[2])
  self._bodyArea = {}
  local bodyAreaData = t.bodyArea or {}
  for index, value in ipairs(bodyAreaData) do
    local off = Vector2(value[1], value[2])
    table.insert(self._bodyArea, off)
  end
  local gridOffSetData = t.gridOffSet
  self._gridOffSet = Vector2(gridOffSetData[1], gridOffSetData[2])
  local damageOffSetData = t.damageOffSet
  self._damageOffSet = Vector2(damageOffSetData[1], damageOffSetData[2])
end

function SkillEffectParam_TeleportAndReplaceBodyArea:GetEffectType()
  return SkillEffectType.TeleportAndReplaceBodyArea
end

function SkillEffectParam_TeleportAndReplaceBodyArea:GetTargetPos()
  return self._pos
end

function SkillEffectParam_TeleportAndReplaceBodyArea:GetTargetDir()
  return self._dir
end

function SkillEffectParam_TeleportAndReplaceBodyArea:GetReplaceBodyArea()
  return self._bodyArea
end

function SkillEffectParam_TeleportAndReplaceBodyArea:GetReplaceGridOffSet()
  return self._gridOffSet
end

function SkillEffectParam_TeleportAndReplaceBodyArea:GetReplaceDamageOffSet()
  return self._damageOffSet
end
