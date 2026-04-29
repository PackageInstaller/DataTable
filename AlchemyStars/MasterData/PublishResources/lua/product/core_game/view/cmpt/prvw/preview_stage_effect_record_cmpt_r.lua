_class("PreviewStageEffectRecordComponent", Object)
PreviewStageEffectRecordComponent = PreviewStageEffectRecordComponent

function PreviewStageEffectRecordComponent:Constructor()
  self._previewStageEffectEntityIDList = {}
end

function PreviewStageEffectRecordComponent:AddPreviewStageEffectEntityID(entityID)
  table.insert(self._previewStageEffectEntityIDList, entityID)
end

function PreviewStageEffectRecordComponent:GetPreviewStageEffectEntityIDList()
  return self._previewStageEffectEntityIDList
end

function PreviewStageEffectRecordComponent:ClearPreviewStageEffectEntityIDList()
  self._previewStageEffectEntityIDList = {}
end

function Entity:PreviewStageEffectRecord()
  return self:GetComponent(self.WEComponentsEnum.PreviewStageEffectRecord)
end

function Entity:HasPreviewStageEffectRecord()
  return self:HasComponent(self.WEComponentsEnum.PreviewStageEffectRecord)
end

function Entity:AddPreviewStageEffectRecord()
  local index = self.WEComponentsEnum.PreviewStageEffectRecord
  local component = PreviewStageEffectRecordComponent:New()
  self:AddComponent(index, component)
end

function Entity:ReplacePreviewStageEffectRecord()
  local index = self.WEComponentsEnum.PreviewStageEffectRecord
  local component = PreviewStageEffectRecordComponent:New()
  self:ReplaceComponent(index, component)
end

function Entity:RemovePreviewStageEffectRecord()
  if self:HasPreviewActiveSkill() then
    self:RemoveComponent(self.WEComponentsEnum.PreviewStageEffectRecord)
  end
end
