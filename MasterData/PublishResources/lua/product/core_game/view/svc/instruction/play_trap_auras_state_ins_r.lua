_class("PlayTrapAurasStateInstruction", BaseInstruction)
PlayTrapAurasStateInstruction = PlayTrapAurasStateInstruction

function PlayTrapAurasStateInstruction:Constructor(paramList)
  self.effectName = paramList.effectName
  self.state = tonumber(paramList.state)
end

function PlayTrapAurasStateInstruction:GetCacheResource()
  local t = {}
  table.insert(t, {
    self.effectName,
    1
  })
  return t
end

function PlayTrapAurasStateInstruction:DoInstruction(TT, casterEntity, phaseContext)
  local world = casterEntity:GetOwnerWorld()
  if casterEntity:HasSuperEntity() then
    casterEntity = casterEntity:GetSuperEntity()
  end
  local trapRenderComponent = casterEntity:TrapRender()
  if trapRenderComponent then
    trapRenderComponent:SetAurasStatus(self.state)
    if self.state == TrapAurasState.Open then
      casterEntity:ReplaceTrapAurasOutline()
    elseif self.state == TrapAurasState.Close then
      casterEntity:ReplaceTrapAurasOutline()
    end
  end
end
