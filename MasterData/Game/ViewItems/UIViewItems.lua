local UIViewItems = class("UIViewItems", UIBaseWindow)
local base = UIBaseWindow
local UIViewItemsGroup = require("Game.ViewItems.UIViewItemsGroup")

function UIViewItems:OnInit()
  self.itemGroupDataList = nil
  self.ItemDic = {}
  UIUtil.AddButtonListener(self.ui.btn_mask_Close, self, self.Hide)
  self.ui.loop_itemTypeList.onInstantiateItem = BindCallback(self, self.__LevelChipListInitItem)
  self.ui.loop_itemTypeList.onChangeItem = BindCallback(self, self.__LevelChipListItemChanged)
end

function UIViewItems:InitItems(itemList, resloader)
  local itemGroupDataDic = {}
  for index, itemData in ipairs(itemList) do
    local drop_type = itemData.itemCfg.drop_type
    if drop_type == 4 then
      drop_type = 1
    end
    if itemGroupDataDic[drop_type] == nil then
      itemGroupDataDic[drop_type] = {}
    end
    table.insert(itemGroupDataDic[drop_type], itemData)
  end
  self.itemGroupDataList = {}
  for typeId, itemList in pairs(itemGroupDataDic) do
    table.sort(itemList, function(a, b)
      if a.itemCfg.quality > b.itemCfg.quality then
        return true
      elseif a.itemCfg.quality == b.itemCfg.quality then
        return a.itemCfg.id < b.itemCfg.id
      end
      return false
    end)
    table.insert(self.itemGroupDataList, {typeId = typeId, itemList = itemList})
  end
  self.ui.loop_itemTypeList.totalCount = #self.itemGroupDataList
  self.ui.loop_itemTypeList:RefillCells()
end

function UIViewItems:__LevelChipListInitItem(go)
  local ItemGroupItem = UIViewItemsGroup.New()
  ItemGroupItem:Init(go)
  self.ItemDic[go] = ItemGroupItem
end

function UIViewItems:__LevelChipListItemChanged(go, index)
  local ItemGroupItem = self.ItemDic[go]
  if ItemGroupItem == nil then
    error("Can't find ItemGroupItem by gameObject")
    return
  end
  index = index + 1
  local itemGroupData = self.itemGroupDataList[index]
  if itemGroupData == nil then
    error("Can't find itemGroupData by index:" .. tonumber(index))
  end
  ItemGroupItem:InitGroup(itemGroupData)
end

function UIViewItems:OnDelete()
  base.OnDelete(self)
end

return UIViewItems
