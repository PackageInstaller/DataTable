_class("UISeasonMazeBossRewardItem", UICustomWidget)
UISeasonMazeBossRewardItem = UISeasonMazeBossRewardItem

function UISeasonMazeBossRewardItem:OnShow(uiParams)
  self:InitWidget()
end

function UISeasonMazeBossRewardItem:InitWidget()
  self.item = self:GetUIComponent("UISelectObjectPath", "Item")
end

function UISeasonMazeBossRewardItem:SetData()
end

function UISeasonMazeBossRewardItem:TipsBtnOnClick(go)
end
