local UINActivityFlipCardRewardItem = class("UINActivityFlipCardRewardItem", UIBaseNode)
local base = UIBaseNode
local UINBaseItemWithReceived = require("Game.CommonUI.Item.UINBaseItemWithReceived")

function UINActivityFlipCardRewardItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self.rewardItem = UINBaseItemWithReceived.New()
  self.rewardItem:Init(self.ui.uINBaseItemWithReceived)
end

function UINActivityFlipCardRewardItem:InitFlipRewardItem(rewardId, rewardNum, rewardGroupNum)
  local itemCfg = ConfigData.item[rewardId]
  self.rewardItem:InitItemWithCount(itemCfg, rewardNum, nil, false)
  self.ui.tex_Num.text = tostring(rewardGroupNum)
  self.ui.obj_childItemCount:SetActive(true)
end

return UINActivityFlipCardRewardItem
