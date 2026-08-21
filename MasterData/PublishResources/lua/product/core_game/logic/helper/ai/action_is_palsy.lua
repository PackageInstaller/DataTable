require("ai_node_new")
_class("ActionIsPalsy", AINewNode)
ActionIsPalsy = ActionIsPalsy

function ActionIsPalsy:OnBegin()
end

function ActionIsPalsy:OnUpdate()
  local cBuff = self.m_entityOwn:BuffComponent()
  if cBuff and cBuff:HasBuffEffect(BuffEffectType.Palsy) then
    return AINewNodeStatus.Success
  end
  return AINewNodeStatus.Failure
end
