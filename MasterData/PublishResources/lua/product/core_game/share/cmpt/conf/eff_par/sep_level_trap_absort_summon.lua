require("skill_damage_effect_param")
_class("SkillEffectParamLevelTrapAbsortSummon", SkillEffectParamBase)
SkillEffectParamLevelTrapAbsortSummon = SkillEffectParamLevelTrapAbsortSummon

function SkillEffectParamLevelTrapAbsortSummon:Constructor(t)
  self._checkTrapIDs = t.checkTrapIDs or {}
  self._modelLevels = t.modelLevels or {}
  self._transferDisabled = t.transferDisabled == 1
end

function SkillEffectParamLevelTrapAbsortSummon:GetEffectType()
  return SkillEffectType.LevelTrapAbsortSummon
end

function SkillEffectParamLevelTrapAbsortSummon:GetCheckTrapIDs()
  return self._checkTrapIDs
end

function SkillEffectParamLevelTrapAbsortSummon:GetModelLevels()
  return self._modelLevels
end

function SkillEffectParamLevelTrapAbsortSummon:IsTransferDisabled()
  return self._transferDisabled
end

function SkillEffectParamLevelTrapAbsortSummon:GetTrapModelLevel(trapID)
  if self._modelLevels then
    for level, id in ipairs(self._modelLevels) do
      if trapID == id then
        return level
      end
    end
  end
  return 0
end
