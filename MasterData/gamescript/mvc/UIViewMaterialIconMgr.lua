local UIViewMaterialIconMgr = NewClass("UIViewMaterialIconMgr")

function UIViewMaterialIconMgr:ctor(privider)
  self.privider = privider
end

function UIViewMaterialIconMgr:SetIcon(iconType, parent, itemData)
  local proxy = MaterialIconMgr.Instance:SetIcon(iconType, self.privider, parent, itemData)
  self._proxyMap = self._proxyMap or {}
  self._proxyMap[parent] = true
  return proxy
end

function UIViewMaterialIconMgr:ClearIcon(parent)
  MaterialIconMgr.Instance:ResetAll(parent)
  if self._proxyMap then
    self._proxyMap[parent] = nil
  end
end

function UIViewMaterialIconMgr:ClearAll()
  if not MaterialIconMgr.Instance then
    return
  end
  if self._proxyMap then
    for k, _ in pairs(self._proxyMap) do
      MaterialIconMgr.Instance:ResetAll(k)
    end
    self._proxyMap = nil
  end
end

return UIViewMaterialIconMgr
