_class("SkillConfigHelper", Object)
SkillConfigHelper = SkillConfigHelper

function SkillConfigHelper:Constructor(hasViewParser)
  self._skillConfigDic = {}
  self._scopeParamParser = SkillScopeParamParser:New()
  self._skillEffectParamParser = SkillEffectParamParser:New()
  if hasViewParser ~= false then
    self._skillViewParamParser = SkillViewParamParser:New()
    self._skillPreviewParamParser = SkillPreviewParamParser:New()
  else
    self._skillViewParamParser = nil
  end
end

function SkillConfigHelper:ClearSkillData()
  self._skillConfigDic = {}
  if self._skillViewParamParser ~= nil then
    self._skillViewParamParser:ClearSkillView()
  end
end

function SkillConfigHelper:GetSkillData(skillID, forceFetchNew)
  if skillID == nil then
    return
  end
  if not forceFetchNew and self._skillConfigDic[skillID] ~= nil then
    return self._skillConfigDic[skillID]
  end
  local skillConfigData = SkillConfigData:New(self._scopeParamParser, self._skillEffectParamParser, self._skillViewParamParser, self._skillPreviewParamParser)
  skillConfigData:ParseSkillConfig(skillID)
  if not forceFetchNew then
    self._skillConfigDic[skillID] = skillConfigData
  end
  return skillConfigData
end
