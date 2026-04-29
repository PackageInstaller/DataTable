_class("UIPayTokenInputTest", UIController)
UIPayTokenInputTest = UIPayTokenInputTest

function UIPayTokenInputTest:OnShow(uiParams)
  self._viewerIdInput = self:GetUIComponent("EmojiFilteredInputField", "viewerIdInputName")
  self._tokenInputName = self:GetUIComponent("EmojiFilteredInputField", "tokenInputName")
  self.viewerId = LocalDB.GetString("ui_pay_viewerId_test")
  self.token = LocalDB.GetString("ui_pay_token_test")
  self._tokenInputName.text = self.token
  self._viewerIdInput.text = self.viewerId
end

function UIPayTokenInputTest:bgOnClick(go)
  self:CloseDialog()
end

function UIPayTokenInputTest:btnCancelOnClick(go)
  self:CloseDialog()
end

function UIPayTokenInputTest:btnEnsureOnClick(go)
  LocalDB.SetString("ui_pay_token_test", self._tokenInputName.text)
  LocalDB.SetString("ui_pay_viewerId_test", self._viewerIdInput.text)
  self.viewerId = self._viewerIdInput.text
  self.token = self._tokenInputName.text
  local payM = self:GetModule(PayModule)
  payM:SetDmmParam(self.viewerId, self.token)
  self:CloseDialog()
end
