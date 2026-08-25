local UIBinderMaterialIconMgr = NewClass("UIBinderMaterialIconMgr")

function UIBinderMaterialIconMgr:ctor(binder)
  self.binder = binder
  self.binder:onDestroy(function()
    self:ClearAll()
  end)
end

function UIBinderMaterialIconMgr:SetIcon(iconType, binder, parent, itemData)
  if binder ~= self.binder then
    Logger.Error("===UIBinderMaterialIconMgr.SetIcon binder error!!!!, stacktrace=", debug.traceback())
  end
  local proxy = MaterialIconMgr.Instance:SetIcon_Obsolete(iconType, self.binder, parent, itemData)
  self._proxyMap = self._proxyMap or {}
  self._proxyMap[parent] = true
  return proxy
end

function UIBinderMaterialIconMgr:ClearIcon(parent)
  MaterialIconMgr.Instance:ResetAll(parent)
  if self._proxyMap then
    self._proxyMap[parent] = nil
  end
end

function UIBinderMaterialIconMgr:ClearAll()
  if self._proxyMap then
    for k, _ in pairs(self._proxyMap) do
      MaterialIconMgr.Instance:ResetAll(k)
    end
    self._proxyMap = nil
  end
end

return UIBinderMaterialIconMgr
