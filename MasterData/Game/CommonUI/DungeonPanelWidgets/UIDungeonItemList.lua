local UIDungeonItemList = class("UIDungeonItemList", UIBaseNode)
local base = UIBaseNode

function UIDungeonItemList:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
end

function UIDungeonItemList:InjectItemInitEvent(initItemEvent)
  self.initItemEvent = initItemEvent
end

function UIDungeonItemList:InjectItemUpdateEvent(updateItemEvent)
  self.updateItemEvent = updateItemEvent
end

function UIDungeonItemList:LoadItemList(itemIndex)
  self.ui.loopList.onChangeItem = BindCallback(self, self.__onChangeItem)
  self.ui.loopList.onInstantiateItem = BindCallback(self, self.__onInstantiateItem)
  self.ui.loopList.totalCount = self.itemCount
  self.ui.loopList:RefillCells()
  if itemIndex ~= nil then
    local needScrollIndex = math.max(itemIndex - 1, 0)
    self.ui.loopList:SrollToCell(needScrollIndex, 999999)
  end
end

function UIDungeonItemList:__onChangeItem(go, index)
  if self.updateItemEvent ~= nil then
    self.updateItemEvent(go, index)
  end
end

function UIDungeonItemList:__onInstantiateItem(go)
  if self.initItemEvent ~= nil then
    self.initItemEvent(go)
  end
end

function UIDungeonItemList:InjectDataAndFilterEvent(dungeonDataList)
  self.dungeonDataList = dungeonDataList
  self.itemCount = #dungeonDataList
end

function UIDungeonItemList:ExecuteFilter(itemCount, selectItemIndex)
  self:__updateListItem(itemCount, selectItemIndex)
end

function UIDungeonItemList:__updateListItem(itemCount, selectItemIndex)
  self.ui.loopList.totalCount = itemCount
  if selectItemIndex ~= nil then
    self.ui.loopList:RefillCells(selectItemIndex - 1)
  else
    self.ui.loopList:RefillCells()
  end
end

function UIDungeonItemList:Roll2Index(index, callback)
  self.ui.loopList:RefillCells(index)
  if callback ~= nil then
    callback()
  end
end

function UIDungeonItemList:OnDelete()
  base.OnDelete(self)
end

return UIDungeonItemList
