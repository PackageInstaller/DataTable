local UINAthMatUpgrade = class("UINAthMatUpgrade", UIBaseNode)
local base = UIBaseNode
local UINAthMatUpItem = require("Game.Arithmetic.AthList.Area.MatUpgrade.UINAthMatUpItem")
local CS_LayoutRebuilder = CS.UnityEngine.UI.LayoutRebuilder

function UINAthMatUpgrade:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self.lvUpMatItemDic = {}
  self.growupItemList = {}
  self.ui.upgradeItem:SetActive(false)
  self.lvUpMatPool = UIItemPool.New(UINAthMatUpItem, self.ui.upgradeItem)
  self.__onItemChange = BindCallback(self, self.OnItemChange)
  MsgCenter:AddListener(eMsgEventId.UpdateItem, self.__onItemChange)
end

function UINAthMatUpgrade:SetAthMatNodeChangeHeightFunc(athMatNodeChangeHeightFunc)
  self.athMatNodeChangeHeightFunc = athMatNodeChangeHeightFunc
end

function UINAthMatUpgrade:InitAthMatUp(addExpFunc, itemIdList)
  self.addExpFunc = addExpFunc
  self.itemIdList = itemIdList
  self:RefreshAllAthMatItem()
end

function UINAthMatUpgrade:SetRefreshAthSlotAddExpFunc(refreshAthSlotAddExpFunc)
  self.refreshAthSlotAddExpFunc = refreshAthSlotAddExpFunc
end

function UINAthMatUpgrade:RefreshAllAthMatItem()
  if not self.gameObject.activeInHierarchy then
    return
  end
  self.lvUpMatPool:HideAll()
  for _, id in ipairs(self.itemIdList) do
    if PlayerDataCenter.itemDic[id] ~= nil then
      local itemData = PlayerDataCenter.itemDic[id]
      local item = self.lvUpMatPool:GetOne(true)
      item.gameObject.name = tostring(id)
      item:InitExpItem(itemData, function(num)
        self.lvUpMatItemDic[itemData] = num
        self:GenAthMatExpAdd()
      end)
      table.insert(self.growupItemList, item)
    else
      local item = self.lvUpMatPool:GetOne(true)
      item:InitEmptyExpItem(id)
    end
  end
  CS_LayoutRebuilder.ForceRebuildLayoutImmediate(self.transform)
  if self.athMatNodeChangeHeightFunc ~= nil then
    self.athMatNodeChangeHeightFunc(self.transform.sizeDelta.y)
  end
end

function UINAthMatUpgrade:CleanAllAthUpMat()
  for _, item in ipairs(self.growupItemList) do
    item:CleanAll()
  end
  for itemData, _ in pairs(self.lvUpMatItemDic) do
    self.lvUpMatItemDic[itemData] = 0
  end
end

function UINAthMatUpgrade:SetAthAddExpLimt(maxAddExp, addExp, expLimitFunc)
  for _, item in ipairs(self.growupItemList) do
    item:SetAddExpLimt(maxAddExp, addExp, expLimitFunc)
  end
end

function UINAthMatUpgrade:GenAthMatExpAdd()
  local addExp = 0
  for itemData, num in pairs(self.lvUpMatItemDic) do
    addExp = addExp + itemData:GetActionArg(1) * num
  end
  if self.addExpFunc ~= nil then
    self.addExpFunc(addExp)
  end
end

function UINAthMatUpgrade:GetAthMatExpAddItemDic()
  local itemDic = {}
  for itemData, num in pairs(self.lvUpMatItemDic) do
    itemDic[itemData.dataId] = num
  end
  return itemDic
end

function UINAthMatUpgrade:GetAthMatItemList()
  return self.growupItemList
end

function UINAthMatUpgrade:OnItemChange(itemUpdate)
  for k, v in ipairs(self.lvUpMatPool.listItem) do
    if itemUpdate[v:GetHeroLvUpItemId()] == false then
      self:RefreshAllAthMatItem()
      if self.refreshAthSlotAddExpFunc ~= nil then
        self.refreshAthSlotAddExpFunc()
      end
      break
    end
  end
end

function UINAthMatUpgrade:OnDelete()
  self.lvUpMatPool:DeleteAll()
  MsgCenter:RemoveListener(eMsgEventId.UpdateItem, self.__onItemChange)
  base.OnDelete(self)
end

return UINAthMatUpgrade
