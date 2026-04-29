_class("PreviewActiveSkillComponent", Object)
PreviewActiveSkillComponent = PreviewActiveSkillComponent

function PreviewActiveSkillComponent:Constructor(skillID)
  self._activeSkillID = skillID
  self._previewStageEffectEntityIDList = {}
end

function PreviewActiveSkillComponent:GetActiveSKillID()
  return self._activeSkillID
end

function PreviewActiveSkillComponent:AddPreviewStageEffectEntityID(entityID)
  table.insert(self._previewStageEffectEntityIDList, entityID)
end

function PreviewActiveSkillComponent:GetPreviewStageEffectEntityIDList()
  return self._previewStageEffectEntityIDList
end

function PreviewActiveSkillComponent:ClearPreviewStageEffectEntityIDList()
  self._previewStageEffectEntityIDList = {}
end

function Entity:PreviewActiveSkill()
  return self:GetComponent(self.WEComponentsEnum.PreviewActiveSkill)
end

function Entity:HasPreviewActiveSkill()
  return self:HasComponent(self.WEComponentsEnum.PreviewActiveSkill)
end

function Entity:AddPreviewActiveSkill(skillID)
  local index = self.WEComponentsEnum.PreviewActiveSkill
  local component = PreviewActiveSkillComponent:New(skillID)
  self:AddComponent(index, component)
end

function Entity:ReplacePreviewActiveSkill(skillID)
  local index = self.WEComponentsEnum.PreviewActiveSkill
  local component = PreviewActiveSkillComponent:New(skillID)
  self:ReplaceComponent(index, component)
end

function Entity:RemovePreviewActiveSkill()
  if self:HasPreviewActiveSkill() then
    self:RemoveComponent(self.WEComponentsEnum.PreviewActiveSkill)
  end
end
