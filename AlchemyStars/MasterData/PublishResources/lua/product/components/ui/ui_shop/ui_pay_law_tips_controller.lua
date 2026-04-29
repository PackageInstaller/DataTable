_class("UIPayLawTipsController", UIController)
UIPayLawTipsController = UIPayLawTipsController

function UIPayLawTipsController:OnShow(uiParams)
  self._tipsLabel = self:GetUIComponent("UILocalizationText", "Tips")
  self._ageId = uiParams[1]
  local tips = ""
  if self._ageId == 1 then
    tips = StringTable.Get("str_pay_law_tips_under16_tips")
  elseif self._ageId == 2 then
    tips = StringTable.Get("str_pay_law_tips_between_16_20_tips")
  end
  self._tipsLabel:SetText(tips)
end

function UIPayLawTipsController:ConfirmBtnOnClick()
  self:CloseDialog()
end
