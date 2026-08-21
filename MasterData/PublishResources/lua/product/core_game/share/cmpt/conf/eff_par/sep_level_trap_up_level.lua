require("skill_damage_effect_param")
_class("SkillEffectParamLevelTrapUpLevel", SkillEffectParamBase)
SkillEffectParamLevelTrapUpLevel = SkillEffectParamLevelTrapUpLevel

function SkillEffectParamLevelTrapUpLevel:Constructor(t)
  self._checkTrapIDs = t.checkTrapIDs or {}
  self._upLevel = t.upLevel or 1
  self._modelLevels = t.modelLevels or {}
  self._transferDisabled = t.transferDisabled == 1
  self._disableDieSkill = t.disableDieSkill
end

function SkillEffectParamLevelTrapUpLevel:GetEffectType()
  return SkillEffectType.LevelTrapUpLevel
end

function SkillEffectParamLevelTrapUpLevel:GetCheckTrapIDs()
  return self._checkTrapIDs
end

function SkillEffectParamLevelTrapUpLevel:GetUpLevel()
  return self._upLevel
end

function SkillEffectParamLevelTrapUpLevel:GetModelLevels()
  return self._modelLevels
end

function SkillEffectParamLevelTrapUpLevel:IsTransferDisabled()
  return self._transferDisabled
end

function SkillEffectParamLevelTrapUpLevel:GetDisableDieSkill()
  return self._disableDieSkill
end

function SkillEffectParamLevelTrapUpLevel:GetTrapModelLevel(trapID)
  if self._modelLevels then
    for level, id in ipairs(self._modelLevels) do
      if trapID == id then
        return level
      end
    end
  end
  return 0
end
