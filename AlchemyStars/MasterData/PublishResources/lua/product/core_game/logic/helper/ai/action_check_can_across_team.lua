require("ai_node_new")
_class("ActionCheckCanAcrossTeam", AINewNode)
ActionCheckCanAcrossTeam = ActionCheckCanAcrossTeam

function ActionCheckCanAcrossTeam:OnUpdate()
  local entityCaster = self.m_entityOwn
  local aiComponent = entityCaster:AI()
  if nil == aiComponent then
    return false
  end
  local selfPos = entityCaster:GetGridPosition()
  local entityPlayer = aiComponent:GetTargetDefault()
  local targetPos = entityPlayer:GetGridPosition()
  local dir = targetPos - selfPos
  local checkPos = targetPos + dir
  local boardServiceLogic = self._world:GetService("BoardLogic")
  if not boardServiceLogic:IsPosBlock(checkPos, BlockFlag.MonsterLand) then
    return AINewNodeStatus.Success
  else
    return AINewNodeStatus.Failure
  end
end
