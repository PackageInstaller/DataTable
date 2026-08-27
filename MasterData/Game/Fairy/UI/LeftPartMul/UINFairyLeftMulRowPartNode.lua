local UINFairyLeftMulRowPartNode = class("UINFairyTopFilterNode", UIBaseNode)
local base = UIBaseNode
local cs_MessageCommon = CS.MessageCommon
local UINFairyTopFilterNode = require("Game.Fairy.UI.Common.UINFairyTopFilterNode")
local UINFairyCultivateCardItemMulList = require("Game.Fairy.UI.UINFairyCultivateCardItemMulList")
local UINFairyCostItem = require("Game.Fairy.UI.Cost.UINFairyCostNode")
local FairyHelper = require("Game.Fairy.FairyHelper")

function UINFairyLeftMulRowPartNode:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self.topFilterNode = UINFairyTopFilterNode.New()
  self.topFilterNode:Init(self.ui.top)
  self.fairyCardMulRowItemList = UINFairyCultivateCardItemMulList.New()
  self.fairyCardMulRowItemList:Init(self.ui.list)
  self.costItem = UINFairyCostItem.New()
  self.costItem:Init(self.ui.cost)
end

function UINFairyLeftMulRowPartNode:InitFairyLeftMulRowPartNode(resloader, uiMainData, clickFilterFunc, sortTypeChangeAction, clickFairyFunc)
  self.resloader = resloader
  self.uiMainData = uiMainData
  self.clickFilterFunc = clickFilterFunc
  self.sortTypeChangeAction = sortTypeChangeAction
  self.clickFairyFunc = clickFairyFunc
  self.topFilterNode:InitFairyTopFilterNode(self.clickFilterFunc, self.sortTypeChangeAction)
  self.fairyCardMulRowItemList:InitFairyCultivateCardItemList(self.resloader, self.clickFairyFunc, self.uiMainData)
  self.costItem:InitFairyCostNode(self.resloader)
  self.costItem:SetCostCardEmpty()
  self:RefreshFairyCountShow()
end

function UINFairyLeftMulRowPartNode:GetFairyCardMulRowItemList()
  return self.fairyCardMulRowItemList
end

function UINFairyLeftMulRowPartNode:RefreshFairyCountShow()
  local fairyCtrl = ControllerManager:GetController(ControllerTypeId.Fairy)
  FairyHelper.SetFairyCountText(self.ui.tex_FairyCount, fairyCtrl)
end

function UINFairyLeftMulRowPartNode:SetCostCard(fairyData)
  if fairyData then
    self.costItem:SetCostCard(fairyData)
  else
    self.costItem:SetCostCardEmpty()
  end
end

function UINFairyLeftMulRowPartNode:OnDelete()
  self.fairyCardMulRowItemList:Delete()
end

return UINFairyLeftMulRowPartNode
