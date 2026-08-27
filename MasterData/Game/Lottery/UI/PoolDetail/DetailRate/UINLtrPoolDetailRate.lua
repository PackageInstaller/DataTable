local UINLtrPoolDetailRate = class("UINLtrPoolDetailRate", UIBaseNode)
local base = UIBaseNode
local UILtrPoolDetailRateReward = require("Game.Lottery.UI.PoolDetail.DetailRate.UILtrPoolDetailRateReward")

function UINLtrPoolDetailRate:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self.ui.scrollRect.onInstantiateItem = BindCallback(self, self.__OnNewItem)
  self.ui.scrollRect.onChangeItem = BindCallback(self, self.__OnChangeItem)
  self.rewardItemDic = {}
end

function UINLtrPoolDetailRate:InitLtrPoolDetailRate(rewardDataList, isGuarantee)
  self.rewardDataList = rewardDataList
  self.ui.tex_subTile:SetIndex(isGuarantee and 0 or 1)
  self:_RefillScrollRect()
end

function UINLtrPoolDetailRate:_RefillScrollRect()
  self.ui.scrollRect.totalCount = #self.rewardDataList
  self.ui.scrollRect:RefillCells()
end

function UINLtrPoolDetailRate:__OnNewItem(go)
  local item = UILtrPoolDetailRateReward.New()
  item:Init(go)
  self.rewardItemDic[go] = item
end

function UINLtrPoolDetailRate:__OnChangeItem(go, index)
  local item = self.rewardItemDic[go]
  if item == nil then
    error("Can't find item by gameObject")
    return
  end
  local rewardData = self.rewardDataList[index + 1]
  if rewardData == nil then
    error("Can't find rewardData by index, index = " .. tonumber(index))
  end
  item:InitLtrPoolDetailRateReward(rewardData)
end

function UINLtrPoolDetailRate:OnDelete()
  base.OnDelete(self)
end

return UINLtrPoolDetailRate
