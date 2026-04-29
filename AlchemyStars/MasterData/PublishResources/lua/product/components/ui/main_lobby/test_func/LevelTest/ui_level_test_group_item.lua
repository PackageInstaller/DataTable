_class("UILevelTestGroupItem", UICustomWidget)
UILevelTestGroupItem = UILevelTestGroupItem

function UILevelTestGroupItem:OnShow(uiParams)
  self:InitWidget()
end

function UILevelTestGroupItem:InitWidget()
  self.title = self:GetUIComponent("UILocalizationText", "title")
end

function UILevelTestGroupItem:SetData(data)
  self.data = data
  self.title:SetText(data[2])
end

function UILevelTestGroupItem:BtnOnClick(go)
  self:ShowDialog("UIEachTestController", self.data)
end
