local UINLNNInfinityLayerItem = class("UINLNNInfinityLayerItem", UIBaseNode)
local base = UIBaseNode
local UINLNNInfinityRewardItem = require("Game.Sector.SectorLevelDetail.Nodes.UINLNNInfinityRewardItem")

function UINLNNInfinityLayerItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  local rewardItem = UINLNNInfinityRewardItem.New()
  rewardItem:Init(self.ui.obj_rewardItem)
  self.rewardList = {}
  table.insert(self.rewardList, rewardItem)
  self.passCountList = {}
  table.insert(self.passCountList, self.ui.obj_img_PassCount)
end

function UINLNNInfinityLayerItem:InitNodeInfinityLevel(LayerData)
  self.id = LayerData.id
  self.index = LayerData.index
  local endlessLayerCfg = ConfigData.endless_layer[self.id]
  if endlessLayerCfg == nil then
    error("can't read endlessLayerCfg with id=" .. tostring(self.id))
  end
  self:RefeshPassCount(self.index)
  self:RefeshReward(endlessLayerCfg)
  self.ui.obj_isGetReward:SetActive(LayerData.isPass)
end

function UINLNNInfinityLayerItem:RefeshReward(endlessLayerCfg)
  for _, item in ipairs(self.rewardList) do
    item.gameObject:SetActive(false)
  end
  for index, id in ipairs(endlessLayerCfg.reward_itemIds) do
    local num = endlessLayerCfg.reward_itemNums[index]
    if self.rewardList[index] ~= nil then
      self.rewardList[index].gameObject:SetActive(true)
    else
      local newGo = self.ui.obj_rewardItem:Instantiate()
      local newItem = UINLNNInfinityRewardItem.New()
      newItem:Init(newGo)
      table.insert(self.rewardList, newItem)
      newItem.gameObject:SetActive(true)
    end
    self.rewardList[index]:InitReardItem(id, num)
  end
end

function UINLNNInfinityLayerItem:RefeshPassCount(num)
  for _, go in ipairs(self.passCountList) do
    go:SetActive(false)
  end
  for i = 1, num do
    if self.passCountList[i] ~= nil then
      self.passCountList[i]:SetActive(true)
    else
      local newGo = self.ui.obj_img_PassCount:Instantiate()
      table.insert(self.passCountList, newGo)
      newGo:SetActive(true)
    end
  end
end

function UINLNNInfinityLayerItem:OnDelete()
  base.OnDelete(self)
end

return UINLNNInfinityLayerItem
