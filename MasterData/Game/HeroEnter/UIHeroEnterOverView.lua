local UIHeroEnterOverView = class("UIHeroEnterOverView", UIBaseWindow)
local base = UIBaseWindow
local UINHeroEnterOverViewItem = require("Game.HeroEnter.UINHeroEnterOverViewItem")

function UIHeroEnterOverView:OnInit()
  self.slotItemDic = {}
  self.curSlotList = {}
  self.ui.scrollView.onInstantiateItem = BindCallback(self, self.__OnNewItem)
  self.ui.scrollView.onChangeItem = BindCallback(self, self.__OnChangeItem)
  UIUtil.AddButtonListener(self.ui.btn_Return, self, self.Delete)
  self.ui.obj_buildStationedItem:SetActive(false)
end

function UIHeroEnterOverView:InitHeroEnterOverView(resloader)
  self.resloader = resloader
  self:RefreshOverViewItem()
end

function UIHeroEnterOverView:RefreshOverViewItem()
  local num = 0
  for index, value in pairs(PlayerDataCenter.AllBuildingData.oasisBuilt) do
    if value.state ~= proto_object_BuildingState.BuildingStateCreate then
      table.insert(self.curSlotList, value.id)
      num = num + 1
    end
  end
  self.ui.scrollView.totalCount = num
  self.ui.scrollView:RefillCells()
end

function UIHeroEnterOverView:__OnNewItem(go)
  local slotItem = UINHeroEnterOverViewItem.New()
  slotItem:Init(go)
  self.slotItemDic[go] = slotItem
end

function UIHeroEnterOverView:__OnChangeItem(go, index)
  local slotItem = self.slotItemDic[go]
  if slotItem == nil then
    error("Can't find slotItem by gameObject")
    return
  end
  local slotData = self.curSlotList[index + 1]
  if slotData == nil then
    error("Can't find slotData by index, index = " .. tonumber(index))
  end
  slotItem:InitOverViewItem(slotData, self.resloader)
end

function UIHeroEnterOverView:OnDelete()
  UIManager:DeleteWindow(UIWindowTypeID.HeroEnterOverView)
  for _, value in pairs(self.slotItemDic) do
    value:Delete()
  end
  base.OnDelete(self)
end

return UIHeroEnterOverView
