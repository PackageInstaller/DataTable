_class("UIActivityN34TaskInfomationPasteTips", UIController)
UIActivityN34TaskInfomationPasteTips = UIActivityN34TaskInfomationPasteTips

function UIActivityN34TaskInfomationPasteTips:OnShow(uiParams)
  self._pastBtn = self:GetGameObject("PastBtn")
  self._closeBtn = self:GetGameObject("CloseBtn")
  self._descText = self:GetUIComponent("UILocalizationText", "Des")
  self:StartTask(self.PlayAnimation, self)
  if uiParams then
    self._cfg = uiParams[1]
    self._callBack = uiParams[2]
  end
  self._descText:SetText(StringTable.Get(self._cfg.FinalReport))
end

function UIActivityN34TaskInfomationPasteTips:PlayAnimation(TT)
  self._pastBtn:SetActive(false)
  self._closeBtn:SetActive(false)
  self._pastBtn:SetActive(false)
  self._closeBtn:SetActive(true)
end

function UIActivityN34TaskInfomationPasteTips:PastBtnOnClick()
end

function UIActivityN34TaskInfomationPasteTips:CloseBtnOnClick()
  if self._callBack then
    self._callBack()
  end
  self:CloseDialog()
end
