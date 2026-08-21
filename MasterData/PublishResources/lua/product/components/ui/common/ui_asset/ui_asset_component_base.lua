_class("UIAssetComponentBase", Object)
UIAssetComponentBase = UIAssetComponentBase

function UIAssetComponentBase:Constructor(owner, itemId, index, params)
  self._owner = owner
  self._id = itemId
  self._index = index
  self._params = params
end

function UIAssetComponentBase:AttachEvent(event, func)
  self._owner:AttachEvent(event, func)
end

function UIAssetComponentBase:DetachEvent(event, func)
  self._owner:DetachEvent(event, func)
end

function UIAssetComponentBase:LoadPrefab(prefab)
  if not string.endwith(prefab, ".prefab") then
    prefab = prefab .. ".prefab"
  end
  self._req = ResourceManager:GetInstance():SyncLoadAsset(prefab, LoadType.GameObject)
  self._gameObject = self._req.Obj
  self._uiView = self._gameObject:GetComponent(typeof(UIView))
  local rect = self._gameObject:GetComponent(typeof(UnityEngine.RectTransform))
  rect:SetParent(self._owner:ComponentRoot())
  self._gameObject:SetActive(true)
  UIHelper.SetRectTransformToFillFullScreen(rect)
  return self._gameObject
end

function UIAssetComponentBase:Reset(itemId, index, params)
  self._id = itemId
  self._index = index
  self._params = params
end

function UIAssetComponentBase:OnInit()
end

function UIAssetComponentBase:SetActive(active)
  self._gameObject:SetActive(active)
end

function UIAssetComponentBase:OnAdd()
end

function UIAssetComponentBase:OnRemove()
end

function UIAssetComponentBase:OnDestroy()
  if self._req then
    self._req:Dispose()
    self._req = nil
  end
  if self._owner then
    self._owner = nil
  end
end

function UIAssetComponentBase:Index()
  return self._index
end

function UIAssetComponentBase:GameObject()
  return self._gameObject
end

function UIAssetComponentBase:GetUIComponent(type, name)
  return self._uiView:GetUIComponent(type, name)
end

function UIAssetComponentBase:GetGameObject(name)
  return self._uiView:GetGameObject(name)
end
