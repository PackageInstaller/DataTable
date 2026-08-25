local UIViewImagesLoader = System.NewClass("UIViewImagesLoader")
local UIImageCache = _ENV.UIImageCache

function UIViewImagesLoader:ctor()
end

function UIViewImagesLoader:SetImage(imageGo, url, nativeSize, callback)
  self._useFlags = self._useFlags or {}
  self._useFlags[imageGo] = true
  UIImageCache.Instance:SetImage(imageGo, url, nativeSize, callback)
end

function UIViewImagesLoader:ClearImage(imageGo)
  if self._useFlags and self._useFlags[imageGo] then
    self._useFlags[imageGo] = nil
  end
  UIImageCache.Instance:ClearImage(imageGo)
end

function UIViewImagesLoader:ClearAll()
  if self._useFlags then
    for k, v in pairs(self._useFlags) do
      UIImageCache.Instance:ClearImage(k)
    end
    self._useFlags = nil
  end
end

return UIViewImagesLoader
