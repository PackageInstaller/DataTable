local UINFairyCultivateCardItemList = class("UINFairyCultivateCardItemList", UIBaseNode)
local base = UIBaseNode
local UINFairyCultivateCardItem = require("Game.Fairy.UI.UINFairyCultivateCardItem")
local FairyFilterEnum = require("Game.Fairy.UI.ListFilter.FairyFilterEnum")
local FairyHelper = require("Game.Fairy.FairyHelper")

function UINFairyCultivateCardItemList:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self._clickItemCallbackFunc = BindCallback(self, self.OnClickFairyCardItem)
  self.fairyCardItemDic = {}
  self.isMaskFavouriteFairy = false
  self.ui.loopList.onInstantiateItem = BindCallback(self, self.__OnInstantiateFairyCultivateCardItem)
  self.ui.loopList.onChangeItem = BindCallback(self, self.__OnChangeItem)
end

function UINFairyCultivateCardItemList:InitFairyCultivateCardItemList(resloader, clickItemCallback, mainUiData)
  self.clickItemCallback = clickItemCallback
  self.resloader = resloader
  self.selectedIndex = nil
  self.fairyDataList = {}
  self.noFilterFairyList = {}
  self.mainUiData = mainUiData
end

function UINFairyCultivateCardItemList:SetIsMaskFavouriteFairy(value)
  self.isMaskFavouriteFairy = value
end

function UINFairyCultivateCardItemList:RefreshCultivateCardList()
  local fairyDataList = self.mainUiData:GetFairyDataUIList()
  self.ui.loopList.totalCount = #fairyDataList
  self.ui.loopList:RefillCells()
end

function UINFairyCultivateCardItemList:ResetSelectedIndex()
  self.selectedIndex = nil
end

function UINFairyCultivateCardItemList:__OnInstantiateFairyCultivateCardItem(go)
  local fairyCardItem = UINFairyCultivateCardItem.New()
  fairyCardItem:Init(go)
  self.fairyCardItemDic[go] = fairyCardItem
end

function UINFairyCultivateCardItemList:__OnChangeItem(go, index)
  local fairyCardItem = self.fairyCardItemDic[go]
  if fairyCardItem == nil then
    error("UINFairyCultivateCardItemList error:Cant find FairyItem")
    return
  end
  local fairyDataList = self.mainUiData:GetFairyDataUIList()
  local fairyData = fairyDataList[index + 1]
  if fairyData == nil then
    error("UINFairyCultivateCardItemList error: Cant find fairyData")
    return
  end
  if self.selectedIndex and fairyCardItem.index == self.selectedIndex then
    self:SetSelected(false)
  end
  fairyCardItem:InitFairyCultivateCardItem(fairyData, index + 1, self.resloader, self._clickItemCallbackFunc)
  self:SpecialGenFairyCardFunc(fairyCardItem)
  if fairyCardItem.index == self.selectedIndex then
    self:StartSelectObjTimer(fairyCardItem.index)
  end
  if self.OnChangeItemEvent ~= nil then
    self.OnChangeItemEvent(go, index, self, fairyCardItem, fairyData)
  end
end

function UINFairyCultivateCardItemList:SpecialGenFairyCardFunc(fairyCardItem)
  if self.isMaskFavouriteFairy == true then
    if fairyCardItem.fairyData:GetIsFavouriteFairy() then
      fairyCardItem:SetMaskAndIndex(true, 0)
    else
      fairyCardItem:SetMaskAndIndex(false)
    end
  end
end

function UINFairyCultivateCardItemList:Roll2IndexByUid(uid, callback)
  local index = 1
  local fairyDataList = self.mainUiData:GetFairyDataUIList()
  for i, value in ipairs(fairyDataList) do
    if uid and uid == value:GetFairyUID() then
      index = i
    end
  end
  self.ui.loopList.totalCount = #fairyDataList
  self.ui.loopList:RefillCells(index - 1)
  self:OnClickFairyCardItem(index)
  if callback ~= nil then
    callback()
  end
end

function UINFairyCultivateCardItemList:SetSelectedObj(index, fairyCardItem)
  local go = fairyCardItem and fairyCardItem.gameObject or self.ui.loopList:GetCellByIndex(index - 1)
  self.selectedIndex = index
  if not IsNull(go) then
    self:SetSelected(true)
    self.ui.obj_Selected.transform:SetParent(go.transform)
    self.ui.obj_Selected.transform.anchoredPosition = Vector2.zero
  end
end

function UINFairyCultivateCardItemList:RefreshCardListItem()
  for i, item in pairs(self.fairyCardItemDic) do
    item:RefreshCardItem()
  end
end

function UINFairyCultivateCardItemList:SetSelected(bool)
  self.ui.obj_Selected:SetActive(bool)
end

function UINFairyCultivateCardItemList:OnClickFairyCardItem(index)
  if self.clickItemCallback then
    local fairyDataList = self.mainUiData:GetFairyDataUIList()
    local fairyData = fairyDataList[index]
    if fairyData == nil then
      return
    end
    self.clickItemCallback(fairyData)
    self:StartSelectObjTimer(index)
  end
end

function UINFairyCultivateCardItemList:StartSelectObjTimer(index)
  self:CloseSelectObjTimer()
  self.selectObjTimer = TimerManager:StartTimer(1, function()
    self:SetSelectedObj(index)
  end, self, true, true)
end

function UINFairyCultivateCardItemList:CloseSelectObjTimer()
  if self.selectObjTimer then
    TimerManager:StopTimer(self.selectObjTimer)
    self.selectObjTimer = nil
  end
end

function UINFairyCultivateCardItemList:PlayFairyCultivateCardItemListAnim(boolean)
  for i, item in pairs(self.fairyCardItemDic) do
    if not IsNull(item) then
      item:PlayFairyCultivateCardAnim(item:GetFairyCultivateCardIndex() * 0.04 + 0.25, boolean)
    end
  end
end

function UINFairyCultivateCardItemList:GetMainUIData()
  return self.mainUiData
end

function UINFairyCultivateCardItemList:OnDelete()
  self:CloseSelectObjTimer()
  for i, item in pairs(self.fairyCardItemDic) do
    item:Delete()
  end
  if self.OnChangeItemEvent ~= nil then
    self.OnChangeItemEvent = nil
  end
end

return UINFairyCultivateCardItemList
