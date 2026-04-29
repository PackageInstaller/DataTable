require("ai_node_new")
_class("ActionCheckTeamDead", AINewNode)
ActionCheckTeamDead = ActionCheckTeamDead

function ActionCheckTeamDead:OnUpdate()
  local teamEntity = self._world:Player():GetLocalTeamEntity()
  if teamEntity:HasDeadMark() then
    return AINewNodeStatus.Success
  end
  if teamEntity:Attributes():GetCurrentHP() == 0 then
    return AINewNodeStatus.Success
  end
  return AINewNodeStatus.Failure
end
