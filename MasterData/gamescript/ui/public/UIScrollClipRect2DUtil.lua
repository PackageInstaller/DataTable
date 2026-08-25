local UIScrollClipRect2DUtil = {}
local T_ClipRect2D = typeof(CS.ClipRect2D)

function UIScrollClipRect2DUtil.TryEnsureOnViewport(scrollOwner)
  if not scrollOwner then
    return
  end
  local viewportTr = scrollOwner.transform:Find("Viewport")
  if not viewportTr then
    return
  end
  local go = viewportTr.gameObject
  if go:GetComponent(T_ClipRect2D) then
    return
  end
  go:AddComponent(T_ClipRect2D)
end

return UIScrollClipRect2DUtil
