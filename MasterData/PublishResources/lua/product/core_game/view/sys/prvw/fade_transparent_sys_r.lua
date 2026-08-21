_class("FadeTransprentSystem_Render", Object)
FadeTransprentSystem_Render = FadeTransprentSystem_Render

function FadeTransprentSystem_Render:Constructor(world)
  self.world = world
  self._group = world:GetGroup(world.BW_WEMatchers.FadeController)
  self._timeService = world:GetService("Time")
end

function FadeTransprentSystem_Render:Execute()
  self:ExecuteEntities(self._group:GetEntities())
end

function FadeTransprentSystem_Render:ExecuteEntities(entities)
  for i, e in ipairs(entities) do
    self:HandleEntity(e)
  end
end

function FadeTransprentSystem_Render:HandleEntity(e)
  local fadeCom = e:FadeController()
  local fade = fadeCom:Fade()
  if not fadeCom._param then
    fadeCom._param = 0.8
  end
  if fadeCom:IsTransparent() then
    fade.Alpha = fade.Alpha + self._timeService:GetDeltaTime() * fadeCom._param
    if fade.Alpha >= 1 or fade.Alpha <= 0 then
      fadeCom._param = -fadeCom._param
    end
  end
end
