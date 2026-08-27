local base = UIBaseNode
local UINDmSortItemList = class("UINDmSortItemList", base)
local UINDmSortItem = require("Game.Dorm.DUI.Room.Edit.Theme.Sort.UINDmSortItem")
local DmThemeSortEnum = require("Game.Dorm.DUI.Room.Edit.Theme.Sort.DmThemeSortEnum")
local eDmFntThemeSortType = DmThemeSortEnum.eDmFntThemeSortType
local cs_LeanTouch = CS.Lean.Touch.LeanTouch
local cs_InputUtility = CS.InputUtility

function UINDmSortItemList:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self._sortItemPool = UIItemPool.New(UINDmSortItem, self.ui.themeSortItem, false)
  self._OnClickSortItemFunc = BindCallback(self, self._OnClickSortItem)
  self.__onFingerDown = BindCallback(self, self.OnFingerDown)
end

function UINDmSortItemList:InitDmSortItemList(sortData, themeRoot)
  self:Show()
  cs_LeanTouch.OnFingerDown("+", self.__onFingerDown)
  self._themeRoot = themeRoot
  self._sortData = sortData
  self._sortItemPool:HideAll()
  for typeId = 1, eDmFntThemeSortType.Max - 1 do
    local sortItem = self._sortItemPool:GetOne()
    sortItem:InitDmSortItem(typeId, sortData, self._OnClickSortItemFunc)
    if sortData:IsDmThemeCurSortType(typeId) then
      self._lastSortItem = sortItem
    end
  end
end

function UINDmSortItemList:_OnClickSortItem(sortItem, sortTypeId)
  if self._sortData:IsDmThemeCurSortType(sortTypeId) then
    self._sortData:ChangeDmThemeCurSortTypeReverse(sortTypeId)
  else
    self._sortData:SetDmThemeCurSortType(sortTypeId)
    self._lastSortItem:UpdDmSortItem()
    self._lastSortItem = sortItem
  end
  sortItem:UpdDmSortItem()
  self._themeRoot:DmThemeUpdSortFunc()
  self._themeRoot:RefillDmRoomThemeList()
end

function UINDmSortItemList:OnFingerDown(leanFinger)
  if not cs_InputUtility.OverUIValidTag(TagConsts.ValidTarget) then
    self:Hide()
  end
end

function UINDmSortItemList:OnHide()
  cs_LeanTouch.OnFingerDown("-", self.__onFingerDown)
  base.OnHide(self)
end

function UINDmSortItemList:OnDelete()
  self._sortItemPool:DeleteAll()
  base.OnDelete(self)
end

return UINDmSortItemList
