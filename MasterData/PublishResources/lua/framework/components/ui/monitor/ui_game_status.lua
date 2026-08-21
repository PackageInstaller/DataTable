_class("UIGameStatus", UIController)
UIGameStatus = UIGameStatus

function UIGameStatus:OnShow(uiParams)
  self.title = self:GetUIComponent("Text", "title")
  self.title.text = uiParams[1]
  self.content = self:GetUIComponent("Text", "content")
  self.content.text = uiParams[2]
end

function UIGameStatus:btnCloseOnClick(go)
  self:CloseDialog()
end
