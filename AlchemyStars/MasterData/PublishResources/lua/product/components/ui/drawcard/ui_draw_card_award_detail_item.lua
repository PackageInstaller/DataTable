_class("UIDrawCardAwardDetailItem", UICustomWidget)
UIDrawCardAwardDetailItem = UIDrawCardAwardDetailItem

function UIDrawCardAwardDetailItem:OnShow()
  self.title = self:GetUIComponent("UILocalizationText", "title")
  self.detail = self:GetUIComponent("UILocalizationText", "detail")
  self.content = self:GetGameObject("content")
end

function UIDrawCardAwardDetailItem:SetData(title, content)
  self.title.text = StringTable.Get(title)
  if content then
    self.detail.text = StringTable.Get(content)
  else
    self.content:SetActive(false)
  end
end

function UIDrawCardAwardDetailItem:OnHide()
end
