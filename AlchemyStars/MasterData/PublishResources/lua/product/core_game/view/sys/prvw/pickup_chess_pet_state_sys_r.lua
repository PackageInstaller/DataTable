_class("PickUpChessPetStateSystem_Render", UniqueReactiveSystem)

function PickUpChessPetStateSystem_Render:IsInterested(index, previousComponent, component)
  if component == nil then
    return false
  end
  if not GameFSMComponent:IsInstanceOfType(component) then
    return false
  end
  if component:CurStateID() == GameStateID.PickUpChessPet or component:CurStateID() == GameStateID.PreviewChessPet then
    return true
  end
  return false
end

function PickUpChessPetStateSystem_Render:ExecuteWorld(world)
  self._world = world
  Log.notice("### PickUpChessPetStateSystem ExecuteWorld")
end

function PickUpChessPetStateSystem_Render:Filter(world)
  return true
end
