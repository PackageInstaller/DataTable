local UINFairyLtrPoolDetail = class("UINFairyLtrPoolDetail", UIBaseNode)
local base = UIBaseNode
local UINFairyLtrPoolDetailItem = require("Game.Lottery.UI.PoolDetail.FairyDetailRate.UINFairyLtrPoolDetailItem")

function UINFairyLtrPoolDetail:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self.ui.scrollRect.onInstantiateItem = BindCallback(self, self.__OnNewItem)
  self.ui.scrollRect.onChangeItem = BindCallback(self, self.__OnChangeItem)
  self.rewardItemDic = {}
end

function UINFairyLtrPoolDetail:InitFairyLtrPoolDetailRate(ltrPoolData)
  self.rewardDataList = {}
  local poolCfg = ltrPoolData.ltrCfg
  local lotteryCfg = ConfigData.lottery[poolCfg.lottery_id]
  if lotteryCfg == nil then
    error("Cant get lotteryCfg, id = " .. self.poolCfg.lottery_id)
    return
  end
  local fairDic = {}
  local fairIdList = {}
  local fairyNum = 0
  for type, v in pairs(lotteryCfg) do
    local rewardTypeDic = ConfigData.lottery_reward_pool[type]
    if rewardTypeDic == nil then
      error("Cant get lottery_reward_pool, type = " .. tostring(type))
    else
      for k, rewardCfg in pairs(rewardTypeDic) do
        local itemId = rewardCfg.item_reward
        local itemCfg = ConfigData.item[itemId]
        if itemCfg.action_type == eItemActionType.Fairy then
          local fairyId = itemCfg.arg[1]
          if fairDic[fairyId] == nil then
            fairyNum = fairyNum + 1
            fairDic[fairyId] = fairyId
            table.insert(fairIdList, fairyId)
          end
        end
      end
    end
  end
  for itemId, rate in pairs(poolCfg.fiary_show_item) do
    table.insert(self.rewardDataList, {
      isItem = true,
      itemId = itemId,
      itemCfg = ConfigData.item[itemId],
      rate = rate
    })
  end
  table.sort(self.rewardDataList, function(a, b)
    return a.itemId < b.itemId
  end)
  local fairyRate = poolCfg.fiary_show / fairyNum
  table.sort(fairIdList)
  for index, fairyId in ipairs(fairIdList) do
    table.insert(self.rewardDataList, index, {
      isFairy = true,
      fairyId = fairyId,
      fairyCfg = ConfigData.fairy_data[fairyId],
      rate = fairyRate
    })
  end
  self.ui.tex_subTile:SetIndex(1)
  self:_RefillScrollRect()
end

function UINFairyLtrPoolDetail:_RefillScrollRect()
  self.ui.scrollRect.totalCount = #self.rewardDataList
  self.ui.scrollRect:RefillCells()
end

function UINFairyLtrPoolDetail:__OnNewItem(go)
  local item = UINFairyLtrPoolDetailItem.New()
  item:Init(go)
  self.rewardItemDic[go] = item
end

function UINFairyLtrPoolDetail:__OnChangeItem(go, index)
  local item = self.rewardItemDic[go]
  if item == nil then
    error("Can't find item by gameObject")
    return
  end
  local rewardData = self.rewardDataList[index + 1]
  if rewardData == nil then
    error("Can't find rewardData by index, index = " .. tonumber(index))
  end
  item:InitFairyLtrPoolDetailItem(rewardData)
end

function UINFairyLtrPoolDetail:OnDelete()
  base.OnDelete(self)
end

return UINFairyLtrPoolDetail
