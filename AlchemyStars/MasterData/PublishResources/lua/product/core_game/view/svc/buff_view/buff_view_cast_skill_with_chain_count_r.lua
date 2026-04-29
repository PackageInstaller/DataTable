_class("BuffViewCastSkillWithChainCount", BuffViewBase)
BuffViewCastSkillWithChainCount = BuffViewCastSkillWithChainCount

function BuffViewCastSkillWithChainCount:PlayView(TT, notify)
  local entity = self._entity
  local result = self._buffResult
  local entityID = result:GetEntityID()
  local petEntity = self._world:GetEntityByID(entityID)
  local buffView = petEntity:BuffView()
  buffView:SetBuffValue("AgentChainEntityID", entity:GetID())
end
