_class("UIIntimateTip", UICustomWidget)

function UIIntimateTip:Constructor()
end

function UIIntimateTip:OnShow(uiParams)
  self._rectTranform = self:GetUIComponent("RectTransform", "")
end

function UIIntimateTip:SetData()
end

function UIIntimateTip:UpdateToast(TT, textContent)
  self._toastRoot:SetActive(true)
  self._toastRoot.transform.localPosition = self._original
  self._toastText:SetText(textContent)
  local startTime = GameGlobal:GetInstance():GetCurrentTime()
  local lastTime = startTime
end
