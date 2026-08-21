_class("PickUpChainSkillTargetSystem", UniqueReactiveSystem)

function PickUpChainSkillTargetSystem:Constructor(world)
end

function PickUpChainSkillTargetSystem:IsInterested(index, previousComponent, component)
  if component == nil then
    return false
  end
  if not GameFSMComponent:IsInstanceOfType(component) then
    return false
  end
  if component:CurStateID() == GameStateID.WaitInputChain then
    return true
  end
  return false
end

function PickUpChainSkillTargetSystem:Filter(world)
  return true
end

function PickUpChainSkillTargetSystem:ExecuteWorld(world)
  self._world = world
end
