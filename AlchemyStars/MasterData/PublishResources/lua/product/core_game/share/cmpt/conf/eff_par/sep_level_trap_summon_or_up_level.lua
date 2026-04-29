require("skill_damage_effect_param")
_class("SkillEffectParamLevelTrapSummonOrUpLevel", SkillEffectParamBase)
SkillEffectParamLevelTrapSummonOrUpLevel = SkillEffectParamLevelTrapSummonOrUpLevel

function SkillEffectParamLevelTrapSummonOrUpLevel:Constructor(t)
  self._checkTrapIDs = t.checkTrapIDs or {}
  self._summonTrapID = t.summonTrapID or 0
  self._upLevel = t.upLevel or 1
  self._modelLevels = t.modelLevels or {}
  self._block = t.block or 1
  self._transferDisabled = t.transferDisabled == 1
  self._disableDieSkill = t.disableDieSkill
end

function SkillEffectParamLevelTrapSummonOrUpLevel:GetEffectType()
  return SkillEffectType.LevelTrapSummonOrUpLevel
end

function SkillEffectParamLevelTrapSummonOrUpLevel:GetCheckTrapIDs()
  return self._checkTrapIDs
end

function SkillEffectParamLevelTrapSummonOrUpLevel:GetSummonTrapID()
  return self._summonTrapID
end

function SkillEffectParamLevelTrapSummonOrUpLevel:GetUpLevel()
  return self._upLevel
end

function SkillEffectParamLevelTrapSummonOrUpLevel:GetModelLevels()
  return self._modelLevels
end

function SkillEffectParamLevelTrapSummonOrUpLevel:GetBlock()
  return self._block
end

function SkillEffectParamLevelTrapSummonOrUpLevel:IsTransferDisabled()
  return self._transferDisabled
end

function SkillEffectParamLevelTrapSummonOrUpLevel:GetDisableDieSkill()
  return self._disableDieSkill
end

function SkillEffectParamLevelTrapSummonOrUpLevel:GetTrapModelLevel(trapID)
  if self._modelLevels then
    for level, id in ipairs(self._modelLevels) do
      if trapID == id then
        return level
      end
    end
  end
  return 0
end
