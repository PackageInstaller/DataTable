local UINAct21SumExcgRewardItem = class("UINAct21SumExcgRewardItem", UIBaseNode)
local base = require("Game.CommonUI.Item.UINBaseItemWithCount")
local UINBaseItemWithCount = require("Game.CommonUI.Item.UINBaseItemWithCount")

function UINAct21SumExcgRewardItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self.baseItem = UINBaseItemWithCount.New()
  self.baseItem:Init(self.ui.uINBaseItemWithCount)
  self.baseItem:SetNotNeedAnyJump(false)
end

function UINAct21SumExcgRewardItem:InitAct21SumExcgRewardItem(itemCfg, itemNum, surplusNum)
  self.baseItem:InitItemWithCount(itemCfg, itemNum, nil, nil, nil, true)
  self.ui.tex_Surplus.text = tostring(surplusNum)
  local isClear = surplusNum == 0
  self.ui.isClear:SetActive(isClear)
  self.ui.fade.alpha = isClear and 0.4 or 1
end

function UINAct21SumExcgRewardItem:OnDelete()
  self.baseItem:Delete()
  base.OnDelete(self)
end

return UINAct21SumExcgRewardItem
