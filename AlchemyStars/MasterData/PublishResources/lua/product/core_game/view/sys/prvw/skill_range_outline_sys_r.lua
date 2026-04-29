_class("SkillRangeOutlineSystem_Render", ReactiveSystem)
SkillRangeOutlineSystem_Render = SkillRangeOutlineSystem_Render

function SkillRangeOutlineSystem_Render:Constructor(world)
  self.world = world
  self._tranRenderSvc = self.world:GetService("TransformRenderer")
end

function SkillRangeOutlineSystem_Render:GetTrigger(world)
  local c = Collector:New({
    world:GetGroup(world.BW_WEMatchers.SkillRangeOutline)
  }, {"Added"})
  return c
end

function SkillRangeOutlineSystem_Render:Filter(entity)
  return entity:HasView()
end

function SkillRangeOutlineSystem_Render:ExecuteEntities(entities)
  for _, e in pairs(entities) do
    self._tranRenderSvc:PlaySkillRangeAnim(e)
  end
end
