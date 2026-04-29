_class("UIBookRoleMapForceItem", UICustomWidget)
UIBookRoleMapForceItem = UIBookRoleMapForceItem

function UIBookRoleMapForceItem:Constructor()
end

function UIBookRoleMapForceItem:OnShow()
  self:_GetComponents()
end

function UIBookRoleMapForceItem:_GetComponents()
  self._icon = self:GetUIComponent("Image", "Icon")
  self._owner = self:RootUIOwner()
  self._altas = self._owner.altas
end

function UIBookRoleMapForceItem:SetData(cfg, callback)
  self._cfg = cfg
  self._callback = callback
  self:_InitComponents()
end

function UIBookRoleMapForceItem:_InitComponents()
  self._icon.sprite = self._altas:GetSprite(self._cfg.ForceIcon)
end

function UIBookRoleMapForceItem:BtnOnClick()
  if self._callback then
    self._callback(self._cfg)
  end
end
