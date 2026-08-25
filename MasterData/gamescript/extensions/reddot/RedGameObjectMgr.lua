local RedGameObjectMgr = {}
local _resCache

function RedGameObjectMgr.Init()
  if _resCache then
    return
  end
  _resCache = ResCache()
  _resCache:SetPermanent(CommonRes.RedPoint_Dot, true)
  _resCache:SetPermanent(CommonRes.RedPoint_New, true)
  _resCache:SetPermanent(CommonRes.RedPoint_Num, true)
end

function RedGameObjectMgr.FetchRedPoint(assetPath, parent, loadedCallback)
  if not _resCache then
    RedGameObjectMgr.Init()
  end
  local handle = _resCache:NewObject(assetPath, loadedCallback)
  handle:SetParent(parent, false)
  handle:SetLocalPos(0, 0, 0)
  handle:SetScale(1, 1, 1)
  return handle
end

function RedGameObjectMgr.RecycleRedPoint(handle)
  if handle and _resCache then
    _resCache:RecycleObject(handle)
  end
end

function RedGameObjectMgr.LateUpdate()
  if _resCache then
    _resCache:LateUpdate()
  end
end

function RedGameObjectMgr.Dispose()
  if _resCache then
    _resCache:Dispose()
    _resCache = nil
  end
end

return RedGameObjectMgr
