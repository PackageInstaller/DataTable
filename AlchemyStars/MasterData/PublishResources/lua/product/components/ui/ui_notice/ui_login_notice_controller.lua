_class("UILoginNoticeController", UIController)
UILoginNoticeController = UILoginNoticeController

function UILoginNoticeController:OnShow(uiParams)
  self._noticeInfo = uiParams[1]
  self._sureCallback = uiParams[2]
  self:_GetComponents()
  self:_OnValue()
end

function UILoginNoticeController:OnHide()
  self._noticeInfo = nil
  self._sureCallback = nil
  self._title = nil
  self._msg = nil
end

function UILoginNoticeController:_GetComponents()
  self._title = self:GetUIComponent("UILocalizationText", "title")
  self._msg = self:GetUIComponent("UIRichText", "msg")
end

function UILoginNoticeController:_OnValue()
  if self._noticeInfo then
    local content = self._noticeInfo.Text_NoticeContent
    local str1 = string.sub(content, 1, 1)
    local str2 = string.sub(content, -1)
    if str1 == "{" and str2 == "}" then
      if content then
        local tab = cjson.decode(self._noticeInfo.Text_NoticeContent)
        if tab then
          self._msg:SetText(tab.content)
          
          function self._msg.onHrefClick(hrefName)
            SDKProxy:GetInstance():OpenUrl(hrefName)
          end
        else
          Log.fatal("###notice json decode fail ! content --> ", self._noticeInfo.Text_NoticeContent)
        end
      end
    elseif content then
      self._msg:SetText(content)
      
      function self._msg.onHrefClick(hrefName)
        SDKProxy:GetInstance():OpenUrl(hrefName)
      end
    end
    if self._noticeInfo.Text_NoticeTitle then
      self._title:SetText(self._noticeInfo.Text_NoticeTitle)
    end
  end
end

function UILoginNoticeController:sureOnClick(go)
  if self._sureCallback then
    self._sureCallback()
  else
    self:CloseDialog()
  end
end
