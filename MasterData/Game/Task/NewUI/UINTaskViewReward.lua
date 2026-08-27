local UINTaskViewReward = class("UINTaskViewReward", UIBaseNode)
local base = UIBaseNode
local UINFloatUINode = require("Game.CommonUI.FloatWin.UINFloatUINode")
local UINBaseItemWithCount = require("Game.CommonUI.Item.UINBaseItemWithCount")

function UINTaskViewReward:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_background, self, self.Hide)
  self.rewardPool = UIItemPool.New(UINBaseItemWithCount, self.ui.rewardItem)
  self.ui.rewardItem:SetActive(false)
  self.floatNode = UINFloatUINode.New()
  self.floatNode:Init(self.ui.frame)
  self:Hide()
end

function UINTaskViewReward:FloatTo(transform, horizontalAlign, verticalAlign, shiftX, shiftY)
  self.floatNode:FloatTo(transform, horizontalAlign, verticalAlign, shiftX, shiftY)
end

function UINTaskViewReward:RefreshItems(ids, nums, callback)
  self.callback = callback
  self.rewardPool:HideAll()
  for index, id in ipairs(ids) do
    local itemCfg = ConfigData.item[id]
    local num = nums[index]
    local item = self.rewardPool:GetOne()
    item:InitItemWithCount(itemCfg, num, nil)
  end
end

function UINTaskViewReward:OnHide()
  if self.callback ~= nil then
    self.callback()
  end
end

function UINTaskViewReward:OnDelete()
  base.OnDelete(self)
end

return UINTaskViewReward
