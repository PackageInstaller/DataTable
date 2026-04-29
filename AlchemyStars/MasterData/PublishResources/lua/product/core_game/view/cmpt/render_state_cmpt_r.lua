RenderStateType = {
  None = 0,
  PlayingSkill = 1,
  WaitPlayTask = 2
}
_enum("RenderStateType", RenderStateType)
_class("RenderStateComponent", Object)
RenderStateComponent = RenderStateComponent

function RenderStateComponent:Constructor()
  self._renderState = RenderStateType.None
  self._param = nil
  self._previewIndex = 0
  self._skillTipsEntityID = -1
end

function RenderStateComponent:SetRenderState(renderState)
  self._renderState = renderState
end

function RenderStateComponent:SetRenderStateAndParam(renderState, param)
  self._renderState = renderState
  self._param = param
end

function RenderStateComponent:GetRenderStateType()
  return self._renderState
end

function RenderStateComponent:GetRenderStateParam()
  return self._param
end

function RenderStateComponent:NewPreviewRoutine()
  self._previewIndex = self._previewIndex + 1
end

function RenderStateComponent:GetPreviewRoutineIndex()
  return self._previewIndex
end

function RenderStateComponent:ResetPreviewRoutine()
  self._previewIndex = self._previewIndex + 1
end

function RenderStateComponent:SetSkillTipsEntityID(entityID)
  self._skillTipsEntityID = entityID
end

function RenderStateComponent:GetSkillTipsEntityID()
  return self._skillTipsEntityID
end

function RenderStateComponent:WEC_PostInitialize(owner)
end

function RenderStateComponent:WEC_PostRemoved()
end

function Entity:RenderState()
  return self:GetComponent(self.WEComponentsEnum.RenderState)
end

function Entity:HasRenderState()
  return self:HasComponent(self.WEComponentsEnum.RenderState)
end

function Entity:AddRenderState()
  local index = self.WEComponentsEnum.RenderState
  local component = RenderStateComponent:New()
  self:AddComponent(index, component)
end

function Entity:ReplaceRenderState()
  local index = self.WEComponentsEnum.RenderState
  local component = RenderStateComponent:New()
  self:ReplaceComponent(index, component)
end

function Entity:RemoveRenderState()
  Log.fatal("1111 Trace:", Log.traceback())
  if self:HasRenderState() then
    self:RemoveComponent(self.WEComponentsEnum.RenderState)
  end
end
