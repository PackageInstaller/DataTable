_class("UIDrawCardPetInfoLoader", UICustomWidget)
UIDrawCardPetInfoLoader = UIDrawCardPetInfoLoader

function UIDrawCardPetInfoLoader:OnShow()
  self._prefabs = {
    [1] = "UIDrawCardPetInfoItem1.prefab",
    [2] = "UIDrawCardPetInfoItem2.prefab",
    [3] = "UIDrawCardPetInfoItem3.prefab",
    [4] = "UIDrawCardPetInfoItem2.prefab",
    [5] = "UIDrawCardPetInfoItem3.prefab",
    [6] = "UIDrawCardPetInfoItem4.prefab",
    [7] = "UIDrawCardPetInfoItem5.prefab"
  }
  self._loader = self:GetUIComponent("UISelectObjectPath", "loader")
end

function UIDrawCardPetInfoLoader:SetData(tmpID, cfg, callback)
  local type = cfg.type
  local prefab = self._prefabs[type]
  if self._prefab ~= prefab then
    self:Clear()
    self._req = ResourceManager:GetInstance():SyncLoadAsset(self._prefabs[type], LoadType.GameObject)
    local t = self._req.Obj.transform
    t:SetParent(self:GetGameObject().transform)
    t.localPosition = Vector3.zero
    t.localRotation = Quaternion.identity
    t.localScale = Vector3.one
    self._req.Obj:SetActive(true)
    self._widget = UIDrawCardPetInfoItem:New(self._req.Obj)
    self._prefab = prefab
  end
  self._widget:SetData(tmpID, cfg, callback)
end

function UIDrawCardPetInfoLoader:Clear()
  if self._req then
    self._req:Dispose()
    self._req = nil
  end
  if self._widget then
    self._widget:Dispose()
    self._widget = nil
  end
end

function UIDrawCardPetInfoLoader:OnHide()
  self:Clear()
end
