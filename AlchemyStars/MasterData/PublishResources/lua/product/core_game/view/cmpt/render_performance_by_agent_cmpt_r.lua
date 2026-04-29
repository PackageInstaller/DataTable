_class("RenderPerformanceByAgentComponent", Object)
RenderPerformanceByAgentComponent = RenderPerformanceByAgentComponent

function RenderPerformanceByAgentComponent:Constructor(agentEntityID)
  self._agentEntityID = agentEntityID
end

function RenderPerformanceByAgentComponent:GetAgentEntityID()
  return self._agentEntityID
end

function RenderPerformanceByAgentComponent:WEC_PostInitialize(owner)
end

function RenderPerformanceByAgentComponent:WEC_PostRemoved()
end

function Entity:RenderPerformanceByAgent()
  return self:GetComponent(self.WEComponentsEnum.RenderPerformanceByAgent)
end

function Entity:HasRenderPerformanceByAgent()
  return self:HasComponent(self.WEComponentsEnum.RenderPerformanceByAgent)
end

function Entity:AddRenderPerformanceByAgent()
  local index = self.WEComponentsEnum.RenderPerformanceByAgent
  local component = RenderPerformanceByAgentComponent:New()
  self:AddComponent(index, component)
end

function Entity:ReplaceRenderPerformanceByAgent(agentEntityID)
  local index = self.WEComponentsEnum.RenderPerformanceByAgent
  local component = RenderPerformanceByAgentComponent:New(agentEntityID)
  self:ReplaceComponent(index, component)
end

function Entity:RemoveRenderPerformanceByAgent()
  if self:HasRenderPerformanceByAgent() then
    self:RemoveComponent(self.WEComponentsEnum.RenderPerformanceByAgent)
  end
end
