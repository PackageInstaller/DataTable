_class("UINoticeDetailImgTexItem", UICustomWidget)
UINoticeDetailImgTexItem = UINoticeDetailImgTexItem

function UINoticeDetailImgTexItem:OnShow(uiParams)
  self._title = self:GetUIComponent("UIRichText", "title")
  self._msg = self:GetUIComponent("UIRichText", "msg")
  self._icon = self:GetUIComponent("RawImageLoader", "icon")
end

function UINoticeDetailImgTexItem:SetData(notice)
  self._title:SetText(notice.title)
  
  function self._title.onHrefClick(hrefName)
    SDKProxy:GetInstance():OpenUrl(hrefName)
  end
  
  self._msg:SetText(notice.content)
  
  function self._msg.onHrefClick(hrefName)
    SDKProxy:GetInstance():OpenUrl(hrefName)
  end
  
  if string.isnullorempty(notice.texture) then
    self._icon.gameObject:SetActive(false)
  else
    self._icon.gameObject:SetActive(true)
    self._icon:LoadImage(notice.texture)
  end
end

function UINoticeDetailImgTexItem:OnHide()
  self._title = nil
  self._msg = nil
  self._icon = nil
end
