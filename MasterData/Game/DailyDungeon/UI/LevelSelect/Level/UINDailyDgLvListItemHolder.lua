local UINDailyDgLvListItemHolder = class("UINDailyDgLvListItemHolder", UIBaseNode)
local base = UIBaseNode

function UINDailyDgLvListItemHolder:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
end

function UINDailyDgLvListItemHolder:SetDailyDgLvListItem(lvItem)
  self.lvItem = lvItem
end

function UINDailyDgLvListItemHolder:InitDailyDgLvListItemHolder(lvIndex, bossId, isComplete, isLock, isCurrent, resloader, clickFunc)
  self.isBoss = bossId ~= nil
  self.lvItem:InitDailyDgLvListItem(lvIndex, isComplete, isLock, isCurrent, bossId, resloader, clickFunc)
  self.lvItem.transform:SetParent(self.transform)
end

function UINDailyDgLvListItemHolder:CheckNewReturnDailyDgLvListItem(isBoss)
  local needCreatNewItem = self.lvItem == nil
  local needReturnItem = self.isBoss ~= isBoss
  local returnLvItem
  if needReturnItem then
    returnLvItem = self:ReturnDailyDgLvListItem()
    needCreatNewItem = true
  end
  return needCreatNewItem, returnLvItem
end

function UINDailyDgLvListItemHolder:ReturnDailyDgLvListItem()
  local lvItem = self.lvItem
  self.lvItem = nil
  return lvItem, self.isBoss
end

function UINDailyDgLvListItemHolder:OnDelete()
  base.OnDelete(self)
end

return UINDailyDgLvListItemHolder
