_class("UIMainLobbyScrollItem", UICustomWidget)
UIMainLobbyScrollItem = UIMainLobbyScrollItem

function UIMainLobbyScrollItem:OnShow()
  self._uiPrice = self:GetGameObject("uiPrice"):GetComponent("UIView")
  self._uiBuy = self._uiPrice:GetUIComponent("RectTransform", "uiBuy")
  self._uiDay = self._uiPrice:GetUIComponent("RectTransform", "uiDay")
  self._uiActiveNon = self._uiPrice:GetUIComponent("RectTransform", "uiActiveNon")
  self._uiActiveNor = self._uiPrice:GetUIComponent("RectTransform", "uiActiveNor")
  self._uiActiveLux = self._uiPrice:GetUIComponent("RectTransform", "uiActiveLux")
  self._txtBuyValue = self._uiPrice:GetUIComponent("UILocalizationText", "txtBuyValue")
  self._txtDayValue = self._uiPrice:GetUIComponent("UILocalizationText", "txtDayValue")
end

function UIMainLobbyScrollItem:SetData(cfg, callbcak, begindrag, drag, enddrag)
  self._cfg = cfg
  self._callback = callbcak
  self._beginDrag = begindrag
  self._drag = drag
  self._endDrag = enddrag
  self._btn = self:GetGameObject("btn")
  self._icon = self:GetUIComponent("RawImageLoader", "ad")
  self._descGo = self:GetGameObject("descGo")
  self._desc = self:GetUIComponent("UILocalizationText", "desc")
  self._icon:LoadImage(self._cfg.data.Icon)
  self._imgNew = self:GetGameObject("imgNew")
  self._imgNew:SetActive(false)
  if false then
    self._descGo:SetActive(true)
    self._desc:SetText(StringTable.Get(self._cfg.data.Desc))
  else
    self._descGo:SetActive(false)
  end
  self:AddUICustomEventListener(UICustomUIEventListener.Get(self._btn), UIEvent.BeginDrag, self._beginDrag)
  self:AddUICustomEventListener(UICustomUIEventListener.Get(self._btn), UIEvent.Drag, self._drag)
  self:AddUICustomEventListener(UICustomUIEventListener.Get(self._btn), UIEvent.EndDrag, self._endDrag)
end

function UIMainLobbyScrollItem:BtnOnClick()
  if self._callback then
    self._callback(self._cfg.idx)
  end
end

function UIMainLobbyScrollItem:Dispose()
  self._cfg = nil
  self._callback = nil
  self._icon = nil
end
