_class("BuffViewAddTrapExist", BuffViewBase)
BuffViewAddTrapExist = BuffViewAddTrapExist

function BuffViewAddTrapExist:PlayView(TT, notify)
  local result = self._buffResult
  local trapRenderSvc = self._world:GetService("TrapRender")
  local entity = self._entity
  local isForceFull = result:IsForceFull()
  trapRenderSvc:UpdateTrapExistShow(entity, isForceFull)
  local ignoreNextEffectUpdate = result:IgnoreNextEffectUpdate()
  if ignoreNextEffectUpdate then
    local roundRenderCmpt = entity:TrapRoundInfoRender()
    if roundRenderCmpt then
      roundRenderCmpt:SetEffectID(nil)
    end
  end
  if result:IsDestroy() then
    local trapServiceRender = self._world:GetService("TrapRender")
    trapServiceRender:PlayTrapDieSkill(TT, {entity})
  end
end
