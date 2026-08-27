local base = UIBaseNode
local UINCardSetRewardItemHolder = class("UINCardSetRewardItemHolder", base)
local UINCardSetRewardItem = require("Game.CardSet.UI.Reward.UINCardSetRewardItem")

function UINCardSetRewardItemHolder:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self.ui.item:SetActive(false)
end

function UINCardSetRewardItemHolder:InitCardSetRewardItemHolder(rewardCfg, curLv, curLvExp, actCardData, clickEvent)
  if self.rewardItem == nil then
    self.rewardItem = UINCardSetRewardItem.New()
    self.rewardItem:Init(self.ui.item:Instantiate(self.transform))
    self.rewardItem.transform.anchoredPosition = Vector2.zero
  end
  self.rewardItem:Show()
  self.rewardItem:InitCardSetRewardItem(rewardCfg, curLv, curLvExp, actCardData, clickEvent)
  local sizeDelta = self.rewardItem.transform.sizeDelta
  self.ui.layoutElement.preferredWidth = sizeDelta.x
  self.ui.layoutElement.preferredHeight = sizeDelta.y
  if self.finalItem ~= nil and self.finalItem.transform.parent == self.transform then
    self.finalItem:Hide()
  end
  self.finalItem = nil
end

function UINCardSetRewardItemHolder:InitCardSetRewardItemHolderFinal(finalItem)
  if self.rewardItem then
    self.rewardItem:Hide()
  end
  finalItem.transform:SetParent(self.transform)
  finalItem.transform.anchoredPosition = Vector2.zero
  self.finalItem = finalItem
  self.finalItem:Show()
  local sizeDelta = finalItem.transform.sizeDelta
  self.ui.layoutElement.preferredWidth = sizeDelta.x
  self.ui.layoutElement.preferredHeight = sizeDelta.y
end

function UINCardSetRewardItemHolder:OnDelete()
  if self.rewardItem then
    self.rewardItem:Delete()
  end
  base.OnDelete(self)
end

return UINCardSetRewardItemHolder
