require("skill_damage_effect_param")
_class("SkillEffectMonsterMoveGridToSkillRangeFar", SkillEffectParamBase)
SkillEffectMonsterMoveGridToSkillRangeFar = SkillEffectMonsterMoveGridToSkillRangeFar

function SkillEffectMonsterMoveGridToSkillRangeFar:Constructor(t)
  self._skillID = t.skillID
  self._preferElement = t.preferElement
  self._flushTrapIDs = {}
  if t.flushTrapIDs then
    for _, id in ipairs(t.flushTrapIDs) do
      self._flushTrapIDs[id] = true
    end
  end
  local disableDieSkill = t.disableDieSkill or 0
  if disableDieSkill == 1 then
    self._disableDieSkill = true
  else
    self._disableDieSkill = false
  end
end

function SkillEffectMonsterMoveGridToSkillRangeFar:GetEffectType()
  return SkillEffectType.MonsterMoveGridToSkillRangeFar
end

function SkillEffectMonsterMoveGridToSkillRangeFar:GetCheckSkillID()
  return self._skillID
end

function SkillEffectMonsterMoveGridToSkillRangeFar:GetPreferElement()
  return self._preferElement
end

function SkillEffectMonsterMoveGridToSkillRangeFar:GetFlushTrapIDs()
  return self._flushTrapIDs
end

function SkillEffectMonsterMoveGridToSkillRangeFar:GetDisableDieSkill()
  return self._disableDieSkill
end
