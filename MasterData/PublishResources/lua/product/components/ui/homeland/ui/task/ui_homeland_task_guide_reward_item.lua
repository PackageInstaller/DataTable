_class("UIHomelandTaskGuideRewardItem", UICustomWidget)
UIHomelandTaskGuideRewardItem = UIHomelandTaskGuideRewardItem

function UIHomelandTaskGuideRewardItem:OnShow(uiParams)
  self:InitWidget()
end

function UIHomelandTaskGuideRewardItem:InitWidget()
  self.item = self:GetUIComponent("UISelectObjectPath", "Item")
  self.done = self:GetGameObject("Done")
end

function UIHomelandTaskGuideRewardItem:SetData(roleAsset, done)
  self.itemWidget = self.item:SpawnObject("UIItemHomeland")
  self.itemWidget:Flush(roleAsset)
  self.done:SetActive(done)
end

function UIHomelandTaskGuideRewardItem:ClearTextCount()
  self.itemWidget:ClearTextCount()
end
