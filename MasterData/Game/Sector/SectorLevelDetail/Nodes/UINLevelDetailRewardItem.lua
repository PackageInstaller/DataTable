local UINBaseItemWithReceived = require("Game.CommonUI.Item.UINBaseItemWithReceived")
local UINLevelDetailRewardItem = class("UINLevelDetailRewardItem", UINBaseItemWithReceived)
local base = UINBaseItemWithReceived

function UINLevelDetailRewardItem:OnInit()
  base.OnInit(self)
end

function UINLevelDetailRewardItem:InitItemWithCount(itemCfg, count, clickEvent, isPicked, showTag)
  base.InitItemWithCount(self, itemCfg, count, clickEvent, isPicked)
  self.ui.img_isActSupport.gameObject:SetActive(showTag)
end

function UINLevelDetailRewardItem:OnDelete()
  base.OnDelete(self)
end

return UINLevelDetailRewardItem
