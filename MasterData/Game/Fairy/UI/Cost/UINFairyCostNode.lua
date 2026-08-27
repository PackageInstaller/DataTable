local UINFairyCostNode = class("UINFairyCostNode", UIBaseNode)
local base = UIBaseNode
local UINFairyCultivateCardItem = require("Game.Fairy.UI.UINFairyCultivateCardItem")

function UINFairyCostNode:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self.costCardItem = UINFairyCultivateCardItem.New()
  self.costCardItem:Init(self.ui.uINFairyCardItem)
end

function UINFairyCostNode:InitFairyCostNode(resloader)
  self.resloader = resloader
end

function UINFairyCostNode:SetCostCard(fairyData)
  self.costCardItem:InitFairyCultivateCardItem(fairyData, 0, self.resloader, nil)
  self.ui.obj_text:SetActive(false)
  self.costCardItem:Show()
  self:RefreshSelectTip(fairyData)
end

function UINFairyCostNode:RefreshSelectTip(fairyData)
  if not fairyData then
    self.ui.obj_selectTip:SetActive(false)
    return
  end
  local lastMaxLevel = fairyData:GetLastMaxLevel()
  local nowLevel = fairyData:GetFairyCurLevel()
  self.ui.obj_selectTip:SetActive(lastMaxLevel < nowLevel)
end

function UINFairyCostNode:SetCostCardEmpty()
  self.ui.obj_text:SetActive(true)
  self.costCardItem:Hide()
  self:RefreshSelectTip()
end

function UINFairyCostNode:OnDelete()
end

return UINFairyCostNode
