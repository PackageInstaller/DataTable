local UIImagesLoader = System.NewClass("UIImagesLoader")

function UIImagesLoader:ctor(binder)
  binder:onDestroy(function()
    self:ClearAll()
  end)
end

function UIImagesLoader:SetImage(imageGo, url, nativeSize, callback)
  self._useFlags = self._useFlags or {}
  self._useFlags[imageGo] = true
  UIImageCache.Instance:SetImage(imageGo, url, nativeSize, callback)
end

function UIImagesLoader:ClearImage(imageGo)
  if self._useFlags and self._useFlags[imageGo] then
    self._useFlags[imageGo] = nil
  end
  UIImageCache.Instance:ClearImage(imageGo)
end

function UIImagesLoader:ClearAll()
  if self._useFlags then
    for k, v in pairs(self._useFlags) do
      UIImageCache.Instance:ClearImage(k)
    end
    self._useFlags = nil
  end
end

return UIImagesLoader
