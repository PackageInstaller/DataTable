_class("SkillPreviewConfigData", Object)
SkillPreviewConfigData = SkillPreviewConfigData

function SkillPreviewConfigData:Constructor()
  self._previewEffectList = {}
  self._scopeParam = nil
  self._onStartInstructionSet = nil
  self._onSelectValidInstructionSet = nil
  self._onSelectEmptyInstructionSet = nil
  self._onSelectCancelInstructionSet = nil
  self._onSelectInvalidInstructionSet = nil
  self._onCancelPreviewInstructionSet = nil
  self._onSelectRepeatInstructionSet = nil
  self._onActiveSkillInstructionSet = nil
  self._onPreActiveSkillInstructionSet = nil
  self._instructionSetList = {}
  self._id = 0
end

function SkillPreviewConfigData:SetPreviewEffectList(effectList)
  self._previewEffectList = effectList
end

function SkillPreviewConfigData:SetPreviewScopeParam(scopeParam)
  self._scopeParam = scopeParam
end

function SkillPreviewConfigData:SetPreviewInstructionSet(instructionSet, type)
  self._instructionSetList[type] = instructionSet
end

function SkillPreviewConfigData:GetPreviewInstructionSet(type)
  return self._instructionSetList[type]
end

function SkillPreviewConfigData:SetOnStartInstructionSet(instructionSet)
  self._onStartInstructionSet = instructionSet
end

function SkillPreviewConfigData:SetOnSelectValidInstructionSet(instructionSet)
  self._onSelectValidInstructionSet = instructionSet
end

function SkillPreviewConfigData:SetOnSelectCancelInstructionSet(instructionSet)
  self._onSelectCancelInstructionSet = instructionSet
end

function SkillPreviewConfigData:SetOnSelectInvalidInstructionSet(instructionSet)
  self._onSelectInvalidInstructionSet = instructionSet
end

function SkillPreviewConfigData:SetOnSelectEmptyInstructionSet(instructionSet)
  self._onSelectEmptyInstructionSet = instructionSet
end

function SkillPreviewConfigData:SetCancelPreviewInstructionSet(instructionSet)
  self._onCancelPreviewInstructionSet = instructionSet
end

function SkillPreviewConfigData:SetActiveSkillInstructionSet(instructionSet)
  self._onActiveSkillInstructionSet = instructionSet
end

function SkillPreviewConfigData:SetPreActiveSkillInstructionSet(instructionSet)
  self._onPreActiveSkillInstructionSet = instructionSet
end

function SkillPreviewConfigData:GetPreviewEffectList()
  return self._previewEffectList
end

function SkillPreviewConfigData:GetPreviewScopeParam()
  return self._scopeParam
end

function SkillPreviewConfigData:GetOnSelectValidInstructionSet()
  return self._onSelectValidInstructionSet
end

function SkillPreviewConfigData:GetOnSelectCancelInstructionSet()
  return self._onSelectCancelInstructionSet
end

function SkillPreviewConfigData:GetOnSelectInvalidInstructionSet()
  return self._onSelectInvalidInstructionSet
end

function SkillPreviewConfigData:GetOnStartInstructionSet()
  return self._onStartInstructionSet
end

function SkillPreviewConfigData:GetOnSelectEmptyInstructionSet()
  return self._onSelectEmptyInstructionSet
end

function SkillPreviewConfigData:GetCancelPreviewInstructionSet()
  return self._onCancelPreviewInstructionSet
end

function SkillPreviewConfigData:GetActiveSkillInstructionSet()
  return self._onActiveSkillInstructionSet
end

function SkillPreviewConfigData:GetPreActiveSkillInstructionSet()
  return self._onPreActiveSkillInstructionSet
end

function SkillPreviewConfigData:SetID(id)
  self._id = id
end

function SkillPreviewConfigData:GetID()
  return self._id
end
