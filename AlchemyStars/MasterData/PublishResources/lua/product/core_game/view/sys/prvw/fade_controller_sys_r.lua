_class("FadeControllerSystem_Render", ReactiveSystem)
FadeControllerSystem_Render = FadeControllerSystem_Render

function FadeControllerSystem_Render:Constructor(world)
  self.world = world
end

function FadeControllerSystem_Render:GetTrigger(world)
  local group = world:GetGroup(world.BW_WEMatchers.FadeController)
  local c = Collector:New({group}, {"Added"})
  return c
end

function FadeControllerSystem_Render:Filter(entity)
  return entity:HasFadeController() and entity:HasView()
end

function FadeControllerSystem_Render:ExecuteEntities(entities)
  for i = 1, #entities do
    local e = entities[i]
    self:HandleEntity(e)
  end
end

function FadeControllerSystem_Render:HandleEntity(e)
  local fadeCom = e:FadeController()
  local fade = fadeCom:Fade()
  fade.viewType = fadeCom:IsFlash() and ActorViewType.DotSelected or ActorViewType.Normal
  if not fadeCom:IsTransparent() then
    local transparentValue = fadeCom:GetTransparentValue()
    fade.Alpha = fadeCom:IsGhost() and transparentValue or 1
  end
end
