require("skill_scope_filter_param")
_class("SkillEffectParamBase", Object)
SkillEffectParamBase = SkillEffectParamBase

function SkillEffectParamBase:Constructor(t, petId, effectIndex, skillType, grade, awaking)
  self._targetType = t.scopeTargetType
  self._scopeType = t.scopeType
  self._scopeCenterType = t.scopeCenterType
  local scopeParser = SkillScopeParamParser:New()
  self._scopeParam = scopeParser:ParseScopeParam(self._scopeType, t.scopeParam)
  self._damageStageIndex = t.damageStageIndex or 1
  self._scopeTargetTypeParam = t.scopeTargetTypeParam or 0
  if not t.scopeCasterOccupiedFilter and not t.obstructingTrapFilter and not t.monsterOccupiedPosFilter and not t.targetSelectionMode and not t.obstructingTrapByIDFilter then
    self._scopeFilterParam = SkillScopeFilterParam.GenerateDefaultParam()
  else
    self._scopeFilterParam = SkillScopeFilterParam:New(t)
  end
  self._petId = petId
  self._effectIndex = effectIndex
  self._skillType = skillType
  self._grade = grade
  self._awaking = awaking
  self._disableTeamLeaderActiveSkill = t.disableTeamLeaderActiveSkill
end

function SkillEffectParamBase:GetSKillAwakeAndGradeParam()
  if self._skillAwakeAndGradeParam then
    return self._skillAwakeAndGradeParam
  end
  if self._petId == nil or self._effectIndex == nil or self._skillType == nil or self._grade == nil or self._awaking == nil then
    return nil
  end
  if self._petSkillCfg == nil then
    local petSkillCfg = Cfg.cfg_pet_skill({
      PetID = self._petId,
      Grade = self._grade,
      Awakening = self._awaking
    })
    if petSkillCfg then
      self._petSkillCfg = petSkillCfg[1]
    end
  end
  if not self._petSkillCfg then
    return nil
  end
  if self._skillType == SkillType.Normal then
    self._skillAwakeAndGradeParam = self._petSkillCfg.NormallSkillParam[self._effectIndex]
  elseif self._skillType == SkillType.Chain then
    self._skillAwakeAndGradeParam = self._petSkillCfg.ChainSkillParam[self._effectIndex]
  elseif self._skillType == SkillType.Active then
    self._skillAwakeAndGradeParam = self._petSkillCfg.ActiveSkillParam[self._effectIndex]
  end
  return self._skillAwakeAndGradeParam
end

function SkillEffectParamBase:GetPetId()
  return self._petId
end

function SkillEffectParamBase:GetEffectIndex()
  return self._effectIndex
end

function SkillEffectParamBase:GetSkillType()
  return self._skillType
end

function SkillEffectParamBase:GetGrade()
  return self._grade
end

function SkillEffectParamBase:GetAwaking()
  return self._awaking
end

function SkillEffectParamBase:GetEffectType()
  return SkillEffectType.Base
end

function SkillEffectParamBase:GetSkillEffectTargetType()
  return self._targetType
end

function SkillEffectParamBase:GetSkillEffectScopeType()
  return self._scopeType
end

function SkillEffectParamBase:GetSkillEffectScopeCenterType()
  return self._scopeCenterType
end

function SkillEffectParamBase:GetSkillEffectScopeParam()
  return self._scopeParam
end

function SkillEffectParamBase:GetSkillEffectDamageStageIndex()
  return self._damageStageIndex
end

function SkillEffectParamBase:GetScopeFilterParam()
  return self._scopeFilterParam
end

function SkillEffectParamBase:GetSkillEffectTargetTypeParam()
  return self._scopeTargetTypeParam
end

function SkillEffectParamBase:IsDisableTeamLeaderActiveSkill()
  return self._disableTeamLeaderActiveSkill
end
