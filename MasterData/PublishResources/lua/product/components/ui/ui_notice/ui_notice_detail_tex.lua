_class("UINoticeDetailTex", UICustomWidget)
UINoticeDetailTex = UINoticeDetailTex

function UINoticeDetailTex:OnShow(uiParams)
  self._title = self:GetUIComponent("UIRichText", "title")
  self._msg = self:GetUIComponent("UIRichText", "msg")
  self._content = self:GetUIComponent("RectTransform", "Content")
  self._anim = self:GetUIComponent("Animation", "anim")
end

function UINoticeDetailTex:SetData(noticeInfo)
  self._content.anchoredPosition = Vector2(self._content.anchoredPosition.x, 0)
  local content = noticeInfo.Text_NoticeContent
  local str1 = string.sub(content, 1, 1)
  local str2 = string.sub(content, -1)
  if str1 == "{" and str2 == "}" then
    local tab = cjson.decode(noticeInfo.Text_NoticeContent)
    if tab then
      self._msg:SetText(tab.content)
      
      function self._msg.onHrefClick(hrefName)
        SDKProxy:GetInstance():OpenUrl(hrefName)
      end
      
      self._title:SetText(tab.title)
      
      function self._title.onHrefClick(hrefName)
        SDKProxy:GetInstance():OpenUrl(hrefName)
      end
    else
      Log.fatal("###notice json decode fail ! content --> ", noticeInfo.Text_NoticeContent)
    end
  else
    self._msg:SetText(content)
    
    function self._msg.onHrefClick(hrefName)
      SDKProxy:GetInstance():OpenUrl(hrefName)
    end
    
    self._title:SetText(noticeInfo.Text_NoticeTitle)
    
    function self._title.onHrefClick(hrefName)
      SDKProxy:GetInstance():OpenUrl(hrefName)
    end
  end
end

function UINoticeDetailTex:AnimFade()
  self._anim:Play("uieff_Notice_DetailTex_Fade")
end

function UINoticeDetailTex:AnimShow()
  self._anim:Play("uieff_Notice_DetailTex_Show")
end

function UINoticeDetailTex:OnHide()
  self._msg = nil
  self._title = nil
end
