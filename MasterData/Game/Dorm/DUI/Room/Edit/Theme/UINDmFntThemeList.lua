local base = UIBaseNode
local UINDmFntThemeList = class("UINDmFntThemeList", base)
local UINDmFntThemeListItem = require("Game.Dorm.DUI.Room.Edit.Theme.UINDmFntThemeListItem")
local ShopEnum = require("Game.Shop.ShopEnum")
local DmFntThemeData = require("Game.Dorm.DUI.Room.Edit.Theme.Data.DmFntThemeData")
local DmFntThemeSortData = require("Game.Dorm.DUI.Room.Edit.Theme.Data.DmFntThemeSortData")
local DmThemeSortEnum = require("Game.Dorm.DUI.Room.Edit.Theme.Sort.DmThemeSortEnum")
local eDmFntThemeSortType = DmThemeSortEnum.eDmFntThemeSortType

function UINDmFntThemeList:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_SortTheme, self, self._OnClickSort)
  self.ui.themeSortList:SetActive(false)
  self._SelectThemeFunc = BindCallback(self, self._OnSelectTheme)
  self.ui.scrollRect.onInstantiateItem = BindCallback(self, self.__OnNewItem)
  self.ui.scrollRect.onChangeItem = BindCallback(self, self.__OnChangeItem)
  self.themeItemDic = {}
end

function UINDmFntThemeList:InitDmFntThemeList(inBigRoom, editRoomData, resLoader, roomEditRoot)
  self._sortData = DmFntThemeSortData.New()
  self._roomEditRoot = roomEditRoot
  self:Show()
  self._inBigRoom = inBigRoom
  self._editRoomData = editRoomData
  self._resLoader = resLoader
  self._inShopThemeIdDic = {}
  local shopCtrl = ControllerManager:GetController(ControllerTypeId.Shop, true)
  local curNum, totalNum = 0, #ConfigData.shop.dmThemeShopIdList
  for k, shopId in ipairs(ConfigData.shop.dmThemeShopIdList) do
    shopCtrl:GetShopData(shopId, function(shopData)
      if shopData ~= nil then
        shopData:GetShopInSellDormThemeDic(self._inShopThemeIdDic)
      end
      curNum = curNum + 1
      if curNum == totalNum then
        self:_InitData()
        self:RefillDmRoomThemeList(true)
      end
    end)
  end
end

function UINDmFntThemeList:_InitData()
  self._themeDataList = {}
  for k, themeCfg in pairs(ConfigData.dorm_theme) do
    local inSell = self._inShopThemeIdDic[themeCfg.id] == true
    local data = DmFntThemeData.New(themeCfg, inSell, self._editRoomData)
    table.insert(self._themeDataList, data)
  end
  self:DmThemeUpdSortFunc()
end

function UINDmFntThemeList:DmThemeUpdSortFunc(sortType, isReverse)
  local sortFunc = self._sortData:GetDmThemeSortFunc(self._inBigRoom)
  table.sort(self._themeDataList, sortFunc)
  self._sortData.ClearDmThemeSort()
end

function UINDmFntThemeList:RefillDmRoomThemeList(refill)
  self.ui.scrollRect.totalCount = #self._themeDataList
  if refill then
    self.ui.scrollRect:RefillCells()
  else
    self.ui.scrollRect:RefreshCells()
  end
end

function UINDmFntThemeList:__OnNewItem(go)
  local item = UINDmFntThemeListItem.New()
  item:Init(go)
  self.themeItemDic[go] = item
end

function UINDmFntThemeList:__OnChangeItem(go, index)
  local item = self.themeItemDic[go]
  if item == nil then
    error("Can't find item by gameObject")
    return
  end
  local themeData = self._themeDataList[index + 1]
  if themeData == nil then
    error("Can't find themeData by index, index = " .. tonumber(index))
  end
  item:InitDmFntThemeListItem(themeData, self._editRoomData, self._resLoader, self._SelectThemeFunc)
end

function UINDmFntThemeList:_OnSelectTheme(themeCfg)
  self._roomEditRoot:ShowDmRoomEditThemeFntList(themeCfg)
end

function UINDmFntThemeList:_OnClickSort()
  if self._sortList == nil then
    local UINDmSortItemList = require("Game.Dorm.DUI.Room.Edit.Theme.Sort.UINDmSortItemList")
    self._sortList = UINDmSortItemList.New()
    self._sortList:Init(self.ui.themeSortList)
  end
  if self._sortList.active then
    self._sortList:Hide()
  else
    self._sortList:InitDmSortItemList(self._sortData, self)
  end
end

function UINDmFntThemeList:OnShow()
  self.ui.btn_SortTheme.gameObject:SetActive(true)
end

function UINDmFntThemeList:OnHide()
  self.ui.btn_SortTheme.gameObject:SetActive(false)
end

function UINDmFntThemeList:OnDelete()
  if self._sortList then
    self._sortList:Delete()
  end
  base.OnDelete(self)
end

return UINDmFntThemeList
