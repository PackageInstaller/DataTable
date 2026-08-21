_class("PickUpActiveSkillTargetSystem", UniqueReactiveSystem)

function PickUpActiveSkillTargetSystem:Constructor(world)
end

function PickUpActiveSkillTargetSystem:IsInterested(index, previousComponent, component)
  if component == nil then
    return false
  end
  if not GameFSMComponent:IsInstanceOfType(component) then
    return false
  end
  if component:CurStateID() == GameStateID.PickUpActiveSkillTarget or component:CurStateID() == GameStateID.PreviewActiveSkill then
    return true
  end
  return false
end

function PickUpActiveSkillTargetSystem:ExecuteWorld(world)
  self._world = world
  Log.notice("### PickUpActiveSkillSystem ExecuteWorld")
end

function PickUpActiveSkillTargetSystem:Filter(world)
  return true
end
