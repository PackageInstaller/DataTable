_class("UIPayLawContentController", UIController)
UIPayLawContentController = UIPayLawContentController

function UIPayLawContentController:OnShow(uiParams)
  self._contentLabel = self:GetUIComponent("UILocalizationText", "Content")
  self._titleLabel = self:GetUIComponent("UILocalizationText", "Title")
  self._contentType = uiParams[1]
  local tips = ""
  local title = ""
  if self._contentType == 1 then
    tips = StringTable.Get("str_pay_law_content_des1")
    title = StringTable.Get("str_pay_law_content_title1")
  elseif self._contentType == 2 then
    tips = StringTable.Get("str_pay_law_content_des2")
    title = StringTable.Get("str_pay_law_content_title2")
  elseif self._contentType == 3 then
    tips = StringTable.Get("str_pay_limited_time_recharge_content")
    title = StringTable.Get("str_pay_limited_time_recharge_title")
  end
  self._contentLabel:SetText(tips)
  self._titleLabel:SetText(title)
end

function UIPayLawContentController:ConfirmBtnOnClick()
  self:CloseDialog()
end
