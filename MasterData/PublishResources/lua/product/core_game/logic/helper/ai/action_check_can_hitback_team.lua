require("ai_node_new")
_class("ActionCheckCanHitBackTeam", AINewNode)
ActionCheckCanHitBackTeam = ActionCheckCanHitBackTeam

function ActionCheckCanHitBackTeam:OnUpdate()
  local entityCaster = self.m_entityOwn
  local aiComponent = entityCaster:AI()
  if nil == aiComponent then
    return false
  end
  local selfPos = entityCaster:GetGridPosition()
  local entityPlayer = aiComponent:GetTargetDefault()
  local casterDir = entityCaster:GetGridDirection()
  local utilCalcSvc = self._world:GetService("UtilCalc")
  local hitBackDir = utilCalcSvc:CalcHitBackFront3Dir(selfPos, casterDir, entityPlayer, 1, nil)
  if hitBackDir then
    return AINewNodeStatus.Success
  else
    return AINewNodeStatus.Failure
  end
end
