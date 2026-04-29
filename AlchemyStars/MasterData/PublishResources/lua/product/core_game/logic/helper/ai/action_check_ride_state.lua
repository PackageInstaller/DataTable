require("ai_node_new")
_class("ActionCheckRideState", AINewNode)
ActionCheckRideState = ActionCheckRideState

function ActionCheckRideState:OnUpdate()
  local entity = self.m_entityOwn
  local aiComponent = self.m_entityOwn:AI()
  if not entity:HasRide() then
    return AINewNodeStatus.Other + AIRideStateType.NoRide
  end
  local rideCmpt = entity:Ride()
  if entity:GetID() == rideCmpt:GetMountID() then
    return AINewNodeStatus.Other + AIRideStateType.BeRide
  end
  local mountEntity = self._world:GetEntityByID(rideCmpt:GetMountID())
  if not mountEntity then
    return AINewNodeStatus.Other + AIRideStateType.NoRide
  end
  if mountEntity:HasTrap() then
    return AINewNodeStatus.Other + AIRideStateType.RideOnTrap
  end
  if mountEntity:HasMonsterID() then
    return AINewNodeStatus.Other + AIRideStateType.RideOnMonster
  end
  return AINewNodeStatus.Other + AIRideStateType.NoRide
end
