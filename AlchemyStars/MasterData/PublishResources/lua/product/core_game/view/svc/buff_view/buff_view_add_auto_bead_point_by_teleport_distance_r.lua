_class("BuffViewAddAutoBeadPointByTeleportDistance", BuffViewBase)
BuffViewAddAutoBeadPointByTeleportDistance = BuffViewAddAutoBeadPointByTeleportDistance

function BuffViewAddAutoBeadPointByTeleportDistance:PlayView(TT)
  local result = self._buffResult
  local autoBeadServiceRender = self._world:GetService("AutoBeadRender")
  if autoBeadServiceRender then
    autoBeadServiceRender:NotifyAutoBeadPointChange(result:GetCurAutoBeadPoint(), result:GetOldAutoBeadPoint())
  end
end
