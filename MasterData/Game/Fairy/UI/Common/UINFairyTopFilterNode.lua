local UINFairyTopFilterNode = class("UINFairyTopFilterNode", UIBaseNode)
local base = UIBaseNode
local cs_MessageCommon = CS.MessageCommon
local UINFairyButtonGroupNode = require("Game.Fairy.UI.FairySort.UINFairySortButtonGroup")

function UINFairyTopFilterNode:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_Filter, self, self.OnClickBtnFilter)
  self.sortButtonGroupNode = UINFairyButtonGroupNode.New()
  self.sortButtonGroupNode:Init(self.ui.buttonGroupNode)
end

function UINFairyTopFilterNode:InitFairyTopFilterNode(clickFilterFunc, sortTypeChangeAction)
  self.clickFilterFunc = clickFilterFunc
  self.sortTypeChangeAction = sortTypeChangeAction
  self.sortButtonGroupNode:InitFairySortButtonGroup(self.sortTypeChangeAction)
end

function UINFairyTopFilterNode:OnClickBtnFilter()
  if self.clickFilterFunc then
    self.clickFilterFunc()
  end
end

function UINFairyTopFilterNode:OnDelete()
end

return UINFairyTopFilterNode
