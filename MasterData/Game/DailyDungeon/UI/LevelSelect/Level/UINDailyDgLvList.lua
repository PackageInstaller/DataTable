local UINDailyDgLvList = class("UINDailyDgLvList", UIBaseNode)
local base = UIBaseNode
local UINDailyDgLvListItemHolder = require("Game.DailyDungeon.UI.LevelSelect.Level.UINDailyDgLvListItemHolder")
local UINDailyDgLvListItem = require("Game.DailyDungeon.UI.LevelSelect.Level.UINDailyDgLvListItem")

function UINDailyDgLvList:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self.ui.scrollRect.onInstantiateItem = BindCallback(self, self.__OnNewItem)
  self.ui.scrollRect.onChangeItem = BindCallback(self, self.__OnChangeItem)
  self.ui.scrollRect.onReturnItem = BindCallback(self, self.__onReturnItem)
  self._itemDic = {}
  self.ui.levelItem:SetActive(false)
  self.normalLvItemPool = UIItemPool.New(UINDailyDgLvListItem, self.ui.levelItem)
  self.ui.bossLevelItem:SetActive(false)
  self.bossLvItemPool = UIItemPool.New(UINDailyDgLvListItem, self.ui.bossLevelItem)
end

function UINDailyDgLvList:InitDailyDgLvList(levelNum, curLvIdx, inDungeon, matDungeonCfg, resloader, clickItemFunc)
  self.curLvIdx = curLvIdx
  self.clickItemFunc = clickItemFunc
  self.inDungeon = inDungeon
  self.matDungeonCfg = matDungeonCfg
  self.resloader = resloader
  local lvIndexList = {}
  for i = 1, levelNum do
    table.insert(lvIndexList, i)
  end
  self.lvIndexList = lvIndexList
  self:_RefillScrollRect()
end

function UINDailyDgLvList:_RefillScrollRect()
  local allNum = #self.lvIndexList
  self.ui.scrollRect.totalCount = allNum
  local leftPad = self.ui.layout_rect.padding.left
  local rightPad = self.ui.layout_rect.padding.right
  local spacing = self.ui.layout_rect.spacing
  local itemNum = math.max(self.curLvIdx - 1, 0)
  local normalItemSize = self.ui.levelItem.transform.rect.width
  local bossItemSize = self.ui.bossLevelItem.transform.rect.width
  local offset = 0
  if 0 < itemNum then
    offset = leftPad + itemNum * normalItemSize + (itemNum - 0.5) * spacing
    local maxOffset = leftPad + (allNum - 1) * (normalItemSize + spacing) + bossItemSize + rightPad - self.ui.scrollRect.transform.rect.width
    offset = math.min(offset, maxOffset)
  end
  self.ui.scrollRect:RefillCells(0, math.floor(offset))
end

function UINDailyDgLvList:__OnNewItem(go)
  local item = UINDailyDgLvListItemHolder.New(self)
  item:Init(go)
  self._itemDic[go] = item
end

function UINDailyDgLvList:__OnChangeItem(go, index)
  local item = self._itemDic[go]
  if item == nil then
    error("Can't find item by gameObject")
    return
  end
  local lvIndex = self.lvIndexList[index + 1]
  if lvIndex == nil then
    error("Can't find lvIndex by index, index = " .. tonumber(index))
  end
  local isBoss = lvIndex == #self.lvIndexList
  local needCreatNewItem, returnLvItem = item:CheckNewReturnDailyDgLvListItem(isBoss)
  if returnLvItem ~= nil then
    self:_ReturnLvItem(returnLvItem, not isBoss)
  end
  if needCreatNewItem then
    local lvItem
    if isBoss then
      lvItem = self.bossLvItemPool:GetOne()
    else
      lvItem = self.normalLvItemPool:GetOne()
    end
    item:SetDailyDgLvListItem(lvItem)
  end
  local isComplete = lvIndex <= self.curLvIdx
  local isLock = lvIndex > self.curLvIdx + 1
  if self.inDungeon and lvIndex == 1 then
    isLock = false
  end
  local isCurrent = self.inDungeon and self.curLvIdx + 1 == lvIndex
  local bossId
  if isBoss then
    bossId = self.matDungeonCfg.boss_id
  end
  item:InitDailyDgLvListItemHolder(lvIndex, bossId, isComplete, isLock, isCurrent, self.resloader, self.clickItemFunc)
end

function UINDailyDgLvList:__onReturnItem(go)
  local item = self._itemDic[go]
  if item == nil then
    error("Can't find item by gameObject")
    return
  end
  local lvItem, isBoss = item:ReturnDailyDgLvListItem()
  self:_ReturnLvItem(lvItem, isBoss)
end

function UINDailyDgLvList:_ReturnLvItem(lvItem, isBoss)
  if lvItem == nil then
    return
  end
  lvItem.transform:SetParent(self.ui.prefabHolder)
  if isBoss then
    self.bossLvItemPool:HideOne(lvItem)
  else
    self.normalLvItemPool:HideOne(lvItem)
  end
end

function UINDailyDgLvList:OnDelete()
  self.bossLvItemPool:DeleteAll()
  self.normalLvItemPool:DeleteAll()
  for k, v in pairs(self._itemDic) do
    v:Delete()
  end
  base.OnDelete(self)
end

return UINDailyDgLvList
