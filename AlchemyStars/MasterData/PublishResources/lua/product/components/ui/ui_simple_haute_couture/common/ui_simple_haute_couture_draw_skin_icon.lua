_class("UISimpleHauteCoutureDrawSkinIcon", UICustomWidget)
UISimpleHauteCoutureDrawSkinIcon = UISimpleHauteCoutureDrawSkinIcon

function UISimpleHauteCoutureDrawSkinIcon:Constructor()
end

function UISimpleHauteCoutureDrawSkinIcon:OnShow()
  self:_GetComponents()
end

function UISimpleHauteCoutureDrawSkinIcon:_GetComponents()
  self._skinName = self:GetUIComponent("UILocalizationText", "skinName")
  self._getMaskObj = self:GetGameObject("GetMask")
end

function UISimpleHauteCoutureDrawSkinIcon:SetData(skinID, callback)
  self._skinID = skinID
  self._callback = callback
  self:_InitComponents()
end

function UISimpleHauteCoutureDrawSkinIcon:SetSkinGet(isGet)
  self._getMaskObj:SetActive(isGet)
end

function UISimpleHauteCoutureDrawSkinIcon:_InitComponents()
  local skinCfg = Cfg.cfg_pet_skin[self._skinID]
  self._skinName:SetText(StringTable.Get(skinCfg.SkinName))
end

function UISimpleHauteCoutureDrawSkinIcon:SkinBtnOnClick()
  if self._callback then
    self._callback()
  end
end
