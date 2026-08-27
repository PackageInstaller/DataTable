local UINDmRoomFntList = class("UINDmRoomFntList", UIBaseNode)
local base = UIBaseNode
local UINDmRoomFntListItem = require("Game.Dorm.DUI.Room.Edit.UINDmRoomFntListItem")
local _inBigRoom = false

function UINDmRoomFntList:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self.ui.scrollRect.onInstantiateItem = BindCallback(self, self.__OnNewItem)
  self.ui.scrollRect.onChangeItem = BindCallback(self, self.__OnChangeItem)
  self.fntItemDic = {}
end

function UINDmRoomFntList:InitDmRoomFntList(fntWarehouseDataList, onClickFntItemFunc, inBigRoom)
  self.oriFntWarehouseDataList = fntWarehouseDataList
  self.onClickFntItemFunc = onClickFntItemFunc
  _inBigRoom = inBigRoom
end

function UINDmRoomFntList:SetDmRoomFntListInTheme(themeFntNumDic)
  self._themeFntNumDic = themeFntNumDic
end

local function defaultSortFunc(fnt1, fnt2)
  if fnt1.isDefaultDmFnt ~= fnt2.isDefaultDmFnt then
    return fnt1.isDefaultDmFnt
  end
  local has1 = fnt1.count > 0
  local has2 = fnt2.count > 0
  if has1 ~= has2 then
    return has1
  end
  if not _inBigRoom then
    local isOnlyBig1 = fnt1.fntCfg.only_big
    local isOnlyBig2 = fnt2.fntCfg.only_big
    if isOnlyBig1 ~= isOnlyBig2 then
      return isOnlyBig2
    end
  end
  local comfort1 = fnt1.fntCfg.comfort
  local comfort2 = fnt2.fntCfg.comfort
  if comfort1 ~= comfort2 then
    return comfort1 > comfort2
  end
  return fnt1.id < fnt2.id
end

function UINDmRoomFntList:RefreshDmRoomFntList(funcSift, funcSort)
  self.curFntList = {}
  self.funcSift = funcSift
  self.funcSort = funcSort or defaultSortFunc
  for index, fntData in ipairs(self.oriFntWarehouseDataList) do
    if self.funcSift == nil or self.funcSift(fntData) then
      table.insert(self.curFntList, fntData)
    end
  end
  if self.funcSort ~= nil then
    table.sort(self.curFntList, self.funcSort)
  end
end

function UINDmRoomFntList:RefillDmRoomFntList(refill)
  self.ui.scrollRect.totalCount = #self.curFntList
  if refill then
    self.ui.scrollRect:RefillCells()
    self.ui.scrollRect:RefreshCells()
  else
    self.ui.scrollRect:RefreshCells()
  end
end

function UINDmRoomFntList:__OnNewItem(go)
  local item = UINDmRoomFntListItem.New()
  item:Init(go)
  self.fntItemDic[go] = item
end

function UINDmRoomFntList:__OnChangeItem(go, index)
  local item = self.fntItemDic[go]
  if item == nil then
    error("Can't find item by gameObject")
    return
  end
  local fntWarehouseData = self.curFntList[index + 1]
  if fntWarehouseData == nil then
    error("Can't find fntWarehouseData by index, index = " .. tonumber(index))
  end
  local maxNum
  if self._themeFntNumDic ~= nil then
    maxNum = self._themeFntNumDic[fntWarehouseData.id]
  end
  item:SetDmRoomFntListItemMaxNum(maxNum)
  item:InitDmRoomFntListItem(fntWarehouseData, self.onClickFntItemFunc, _inBigRoom)
end

function UINDmRoomFntList:OnDelete()
  base.OnDelete(self)
end

return UINDmRoomFntList
