local UISimpleGameObject, Super = NewClass("UISimpleGameObject")
local typeof = _ENV.typeof
local Instantiate = CS.UnityEngine.GameObject.Instantiate
local DestroyImmediate = CS.UnityEngine.Object.DestroyImmediate
local CanvasGroup = CS.UnityEngine.CanvasGroup
local TYPEOF_CanvasGroup = typeof(CanvasGroup)
local Vector3 = CS.UnityEngine.Vector3
local Vector3_One = Vector3.one
local localizeBinder = Vue.newBinder()

function UISimpleGameObject:ctor(nodeName, fakeGo, realGoPath)
  Super.ctor(self)
  self.res = nil
  self.nodeName = nodeName
  self.gameObject = fakeGo
  self.realGoPath = realGoPath
  self.realGo = nil
  self.isLoaded = false
  if fakeGo then
    self.tag = AddLuaCompOnce(fakeGo, UISimpleGameObjectTag)
    self.realGo = self.tag:GetRealGo()
    self.isLoaded = nil ~= self.realGo
  end
  self:InitGetter()
end

function UISimpleGameObject:OnDestroy()
  ResLoadMgr.UnloadAssetByTarget(self)
end

function UISimpleGameObject:InitGetter()
  local preMt = getmetatable(self)
  local cacheFuncs = {}
  local getter = {
    __index = function(_, key)
      if rawget(self, key) then
        do return rawget, self end
        return rawget, self, key
      end
      if preMt.__index[key] then
        return preMt.__index[key]
      else
        if not self.isLoaded then
          self:LoadRealGo()
          self.isLoaded = true
        end
        if cacheFuncs[key] then
          return cacheFuncs[key]
        end
        local realValue = self.gameObject[key]
        if type(realValue) == "function" then
          cacheFuncs[key] = function(_, ...)
            do return realValue, self.gameObject, ... end
            return realValue, self.gameObject, ...
          end
          return cacheFuncs[key]
        end
        return realValue
      end
    end,
    __kind = preMt.__kind,
    __name = preMt.__name,
    __inherits = preMt.__inherits,
    __fullname = preMt.__fullname,
    __super = preMt.__super
  }
  setmetatable(self, getter)
end

function UISimpleGameObject:PackRes(res)
  self.res = res
  self.res.uiNode = self.tag and self.tag:GetRealGo() or self.gameObject
end

function UISimpleGameObject:LoadEmptyGameObject()
  if self.isLoaded then
    return
  end
  self.isLoaded = true
  local transform = self.gameObject.transform
  local childCount = transform.childCount
  if childCount > 0 then
    return
  end
  local realPrefab = ResLoadMgr.LoadAsset(self.realGoPath, self)
  local transform = self.gameObject.transform
  local realGo = Instantiate(realPrefab, transform)
  localizeBinder:UpdateLocalizedTextAndResouce(realGo)
  self.realGo = realGo
  local realTf = realGo.transform
  realGo:SetActive(true)
  realTf.localPosition = Vector3_One
  realTf:SetParent(transform, false)
  self.tag:SetRealGo(realGo)
  if self.res then
    self.res.uiNode = realGo
  end
end

function UISimpleGameObject:LoadRealGo()
  if self.isLoaded then
    return
  end
  self.isLoaded = true
  local realPrefab = ResLoadMgr.LoadAsset(self.realGoPath, self)
  local transform = self.gameObject.transform
  local childCount = transform.childCount
  for i = 0, childCount - 1 do
    local childTf = transform:GetChild(0)
    DestroyImmediate(childTf.gameObject)
  end
  local realGo = Instantiate(realPrefab, transform)
  localizeBinder:UpdateLocalizedTextAndResouce(realGo)
  local realTf = realGo.transform
  local childCount = realTf.childCount
  for i = 0, childCount - 1 do
    local childTf = realTf:GetChild(0)
    childTf:SetParent(transform, false)
  end
  DestroyImmediate(realGo)
  ResLoadMgr.UnloadAssetByTarget(nil)
end

function UISimpleGameObject:LoadRealGo2()
end

function UISimpleGameObject:RecoverCompInfo(realGo, fakeGo)
  local canvasGroup = realGo:GetComponent(TYPEOF_CanvasGroup)
  if canvasGroup then
    local oldCanvasGroup = fakeGo:GetComponent(TYPEOF_CanvasGroup)
    if oldCanvasGroup then
      canvasGroup.alpha = oldCanvasGroup.alpha
    end
  end
end

function UISimpleGameObject:SetActive(isActive)
  if self.gameObject then
    self.gameObject:SetActive(isActive)
  end
end

return UISimpleGameObject
