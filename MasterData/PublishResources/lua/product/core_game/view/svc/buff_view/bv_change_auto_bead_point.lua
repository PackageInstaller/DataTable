_class("BuffViewChangeAutoBeadPoint", BuffViewBase)
BuffViewChangeAutoBeadPoint = BuffViewChangeAutoBeadPoint

function BuffViewChangeAutoBeadPoint:PlayView(TT)
  local result = self._buffResult
  local autoBeadServiceRender = self._world:GetService("AutoBeadRender")
  if autoBeadServiceRender then
    autoBeadServiceRender:NotifyAutoBeadPointChange(result:GetCurAutoBeadPoint(), result:GetOldAutoBeadPoint())
  end
end
