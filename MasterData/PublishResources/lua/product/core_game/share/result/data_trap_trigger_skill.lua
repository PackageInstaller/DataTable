_class("DataTrapTriggerSkill", Object)
DataTrapTriggerSkill = DataTrapTriggerSkill

function DataTrapTriggerSkill:Constructor()
  self._trapEntity = nil
  self._triggerEntity = nil
  self._resultContainer = nil
end

function DataTrapTriggerSkill:SetTrapEntity(e)
  self._trapEntity = e
  return self
end

function DataTrapTriggerSkill:GetTrapEntity()
  return self._trapEntity
end

function DataTrapTriggerSkill:SetTriggerEntity(e)
  self._triggerEntity = e
  return self
end

function DataTrapTriggerSkill:GetTriggerEntity()
  return self._triggerEntity
end

function DataTrapTriggerSkill:SetResultContainer(container)
  self._resultContainer = container
  return self
end

function DataTrapTriggerSkill:GetResultContainer()
  return self._resultContainer
end
