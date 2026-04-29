_class("UIS4HelperBannerItem", UICustomWidget)
UIS4HelperBannerItem = UIS4HelperBannerItem

function UIS4HelperBannerItem:OnShow()
end

function UIS4HelperBannerItem:OnHide()
end

function UIS4HelperBannerItem:SetData(cfg, callbcak, begindrag, drag, enddrag)
  self._cfg = cfg
  self._callback = callbcak
  self._beginDrag = begindrag
  self._drag = drag
  self._endDrag = enddrag
  self._btn = self:GetGameObject("btn")
  self._icon = self:GetUIComponent("RawImageLoader", "ad")
  self._icon:LoadImage(self._cfg.data.Icon)
  self._descGo = self:GetGameObject("Desc")
  self._desc = self:GetUIComponent("UILocalizationText", "Desc")
  self._titleGo = self:GetGameObject("Title")
  self._title = self:GetUIComponent("UILocalizationText", "Title")
  self:AddUICustomEventListener(UICustomUIEventListener.Get(self._btn), UIEvent.BeginDrag, self._beginDrag)
  self:AddUICustomEventListener(UICustomUIEventListener.Get(self._btn), UIEvent.Drag, self._drag)
  self:AddUICustomEventListener(UICustomUIEventListener.Get(self._btn), UIEvent.EndDrag, self._endDrag)
  if self._cfg.data.Title then
    self._titleGo:SetActive(true)
    self._title:SetText(StringTable.Get(self._cfg.data.Title))
  else
    self._title:SetActive(false)
  end
  if self._cfg.data.Desc then
    self._descGo:SetActive(true)
    self._desc:SetText(StringTable.Get(self._cfg.data.Desc))
  else
    self._descGo:SetActive(false)
  end
end

function UIS4HelperBannerItem:BtnOnClick()
end

function UIS4HelperBannerItem:Dispose()
  self._cfg = nil
  self._callback = nil
  self._icon = nil
end
