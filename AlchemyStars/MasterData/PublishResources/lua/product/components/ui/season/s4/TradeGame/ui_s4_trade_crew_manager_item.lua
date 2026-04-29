_class("UIS4TradeCrewManagerItem", UICustomWidget)
UIS4TradeCrewManagerItem = UIS4TradeCrewManagerItem

function UIS4TradeCrewManagerItem:OnShow(uiParams)
  self:InitWidget()
end

function UIS4TradeCrewManagerItem:InitWidget()
  self._icon = self:GetUIComponent("RawImageLoader", "Icon")
  self._layoutElement = self:GetUIComponent("LayoutElement", "Obj")
  self._BGRect = self:GetUIComponent("RectTransform", "Bg")
  self._ImageRect = self:GetUIComponent("RectTransform", "Image")
  self._iconRect = self:GetUIComponent("RectTransform", "Icon")
end

function UIS4TradeCrewManagerItem:SetData(id)
  self._id = id
  if self._id then
    local cfg = Cfg.cfg_component_business_seaman[self._id]
    self._icon:LoadImage(cfg.Icon)
    self._icon.gameObject:SetActive(true)
  else
    self._icon.gameObject:SetActive(false)
  end
end

function UIS4TradeCrewManagerItem:SetLayout(Width, Height, BGRect, ImageRect)
  self._layoutElement.preferredWidth = Width
  self._layoutElement.preferredHeight = Height
  self._BGRect.sizeDelta = BGRect
  self._ImageRect.localScale = ImageRect
  self._iconRect.localScale = ImageRect
end
