_class("BuffViewChangeAutoBeadNeedEnergy", BuffViewBase)
BuffViewChangeAutoBeadNeedEnergy = BuffViewChangeAutoBeadNeedEnergy

function BuffViewChangeAutoBeadNeedEnergy:PlayView(TT)
  local result = self._buffResult
  local autoBeadServiceRender = self._world:GetService("AutoBeadRender")
  if autoBeadServiceRender then
    autoBeadServiceRender:NotifyAutoBeadPointToPowerChange(result:GetCurAutoBeadPointToPower(), result:GetOldAutoBeadPointToPower())
  end
end
