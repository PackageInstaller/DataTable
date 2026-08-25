local T_RawImage = typeof(CS.UnityEngine.UI.RawImage)
local T_Image = typeof(CS.UnityEngine.UI.Image)
local T_Sprite = typeof(CS.UnityEngine.Sprite)
local T_Texture = typeof(CS.UnityEngine.Texture)
local _IsResourceLoaded = CS.Z1Client.LuaCSharpUtil.IsResourceLoaded
local UIImageCache, Super = System.NewClass("UIImageCache", Manager)

function UIImageCache:ctor()
  Super.ctor(self)
  self._resDict = {}
  self._useFlags = {}
  self._reqCallbacks = {}
end

function UIImageCache:SetImage(imageGo, url, nativeSize, callBack)
  if not url or 0 == #url then
    self:ClearImage(imageGo)
    return
  end
  local usingImage = self._useFlags[imageGo]
  local isCleared = false
  if usingImage then
    if usingImage.url == url and (usingImage.sprite or usingImage.texture) then
      self:_SetImage(imageGo, nativeSize, usingImage)
      if callBack then
        callBack(usingImage.width, usingImage.height)
      end
      return
    end
    isCleared = true
    self:ClearImage(imageGo)
  end
  if not isCleared then
    self:_ClearImageTexture(imageGo)
  end
  usingImage = self._resDict[url]
  if not usingImage then
    usingImage = UIImage()
    usingImage.url = url
    usingImage:Add(imageGo)
    self._useFlags[imageGo] = usingImage
    self._resDict[url] = usingImage
    self._reqCallbacks[imageGo] = function()
      self:_SetImage(imageGo, nativeSize, usingImage)
      if callBack then
        callBack(usingImage.width, usingImage.height)
      end
    end
    if _IsResourceLoaded(url) then
      local asset = ResLoadMgr.LoadAsset(url, self)
      self:_OnImageLoaded(url, asset)
    else
      ResLoadMgr.LoadAssetAsync(url, self, function(asset)
        self:_OnImageLoaded(url, asset)
      end)
    end
  else
    usingImage:Add(imageGo)
    self._useFlags[imageGo] = usingImage
    if usingImage.sprite or usingImage.texture then
      self:_SetImage(imageGo, nativeSize, usingImage)
      if callBack then
        callBack(usingImage.width, usingImage.height)
      end
    else
      self._reqCallbacks[imageGo] = function()
        self:_SetImage(imageGo, nativeSize, usingImage)
        if callBack then
          callBack(usingImage.width, usingImage.height)
        end
      end
    end
  end
end

function UIImageCache:ClearImage(imageGo)
  if self._useFlags[imageGo] then
    local usingImage = self._useFlags[imageGo]
    self:_ClearImageTexture(imageGo)
    usingImage:Remove(imageGo)
    self:TryRemove(usingImage.url)
  else
    self:_ClearImageTexture(imageGo)
  end
  self._reqCallbacks[imageGo] = nil
  self._useFlags[imageGo] = nil
end

function UIImageCache:OnDestroy()
  Super.OnDestroy(self)
  self:Clear()
end

function UIImageCache:TryRemove(url)
  if self._resDict[url] and 0 == #self._resDict[url].users then
    self._resDict[url]:Destroy()
    self._resDict[url] = nil
    ResLoadMgr.UnloadAsset(url, self)
  end
end

function UIImageCache:ReleaseAllUnused()
  local toDelete
  for k, v in pairs(self._resDict) do
    if 0 == #v.users then
      toDelete = toDelete or {}
      table.insert(toDelete, k)
      v:Destroy()
    end
  end
  if toDelete then
    for i = 1, #toDelete do
      self._resDict[toDelete[i]] = nil
      ResLoadMgr.UnloadAsset(toDelete[i], self)
    end
  end
end

function UIImageCache:Clear()
  for k, v in pairs(self._resDict) do
    v:Destroy()
  end
  self._resDict = {}
  self._reqCallbacks = {}
  self._useFlags = {}
  ResLoadMgr.UnloadAssetByTarget(self)
end

function UIImageCache:_OnImageLoaded(url, asset)
  local usingImage = self._resDict[url]
  if not usingImage then
    return
  end
  if not asset then
    Logger.Error("UIImageCache加载图片失败，资源路径===" .. url)
    return
  end
  local t_asset = asset:GetType()
  if t_asset == T_Sprite then
    usingImage.sprite = asset
    if asset and asset.texture then
      usingImage.width = asset.texture.width
      usingImage.height = asset.texture.height
    end
  elseif t_asset == T_Texture then
    usingImage.texture = asset
    if asset then
      usingImage.width = asset.width
      usingImage.height = asset.height
    end
  end
  for i = 1, #usingImage.users do
    local imageGo = usingImage.users[i]
    local cb = self._reqCallbacks[imageGo]
    if cb then
      self._reqCallbacks[imageGo] = nil
      cb()
    end
  end
end

function UIImageCache:_ClearImageTexture(imageGo)
  if IsNil(imageGo) then
    return
  end
  local imageComp = imageGo:GetComponent(T_Image)
  if imageComp then
    imageComp.enabled = false
    imageComp.overrideSprite = nil
    imageComp.sprite = nil
    return
  end
  local rawImageComp = imageGo:GetComponent(T_RawImage)
  if rawImageComp then
    rawImageComp.enabled = false
    rawImageComp.texture = nil
  end
end

function UIImageCache:_SetImage(imageGo, nativeSize, uiImage)
  if IsNil(imageGo) then
    return
  end
  local imageComp = imageGo:GetComponent(T_Image)
  if imageComp then
    imageComp.sprite = nil
    imageComp.sprite = uiImage:GetSprite()
    imageComp.enabled = true
    if nativeSize then
      imageComp:SetNativeSize()
    end
    return
  end
  local rawImageComp = imageGo:GetComponent(T_RawImage)
  if rawImageComp then
    rawImageComp.texture = nil
    rawImageComp.texture = uiImage:GetTexture()
    rawImageComp.enabled = true
    if nativeSize then
      rawImageComp:SetNativeSize()
    end
  end
end

return UIImageCache
