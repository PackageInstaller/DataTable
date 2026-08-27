local UINSortButtonGroup = class("UINSortButtonGroup", UIBaseNode)
local base = UIBaseNode
local UINSortButtonItem = require("Game.Hero.NewUI.SortList.UINSortButtonItem")
local HeroSortEnum = require("Game.Hero.NewUI.HeroSortEnum")

function UINSortButtonGroup:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self.ui.obj_SortItem:SetActive(false)
  self.itemDic = {}
  self.__onItemClick = BindCallback(self, self.__OnItemClick)
end

function UINSortButtonGroup:InitSortButtonGroup(SortMannerDefine, itemClickAction, fid, assignSortTypeDic)
  self.fid = fid
  if assignSortTypeDic == nil then
    assignSortTypeDic = HeroSortEnum.defaultShow
  end
  local SavedSortMannerType, savedIsAsceSort = PlayerDataCenter.cacheSaveData:GetSpecificHeroListSort(fid)
  if SortMannerDefine == nil then
    return
  end
  self.itemClickAction = itemClickAction
  self.sortMannerDefine = SortMannerDefine
  local sortItem
  for index, type in ipairs(assignSortTypeDic) do
    sortItem = self.itemDic[type]
    if sortItem == nil then
      sortItem = UINSortButtonItem.New()
      local go = self.ui.obj_SortItem:Instantiate()
      go:SetActive(true)
      sortItem:Init(go)
    end
    sortItem:InitSortButtonItem(type, false, self.__onItemClick)
    self.itemDic[type] = sortItem
    if self.selectItem == nil then
      self.selectItem = sortItem
    end
    if SavedSortMannerType ~= nil then
      if type == SavedSortMannerType then
        self.selectItem = sortItem
        self.selectItem.isAscend = savedIsAsceSort
        self.selectItem:RefeshSortStateUI()
      end
    elseif type == HeroSortEnum.eSortMannerType.Level then
      self.selectItem = sortItem
    end
  end
  self:__RefreshButtonGroupUI(self.selectItem)
  self:__GetSortFunc(self.selectItem)
end

function UINSortButtonGroup:__RefreshButtonGroupUI(selectItem)
  for type, Item in pairs(self.itemDic) do
    if Item ~= selectItem then
      Item:SetAllStateUI(false)
    else
      selectItem:RefeshSortStateUI()
    end
  end
end

function UINSortButtonGroup:__OnItemClick(sortType)
  local sortItem = self.itemDic[sortType]
  if sortItem == nil then
    return
  end
  if self.selectItem == sortItem then
    self.selectItem:ReversalAscend()
  else
    self:__RefreshButtonGroupUI(sortItem)
    self.selectItem = sortItem
  end
  self:__GetSortFunc(self.selectItem)
end

function UINSortButtonGroup:__GetSortFunc(selectItem)
  if selectItem == nil then
    return
  end
  if selectItem.isAscend then
    self.sortFunc = self.sortMannerDefine[selectItem.sortType].asceSort
  else
    self.sortFunc = self.sortMannerDefine[selectItem.sortType].descSort
  end
  PlayerDataCenter.cacheSaveData:SetSpecificHeroListSort(self.fid, selectItem.sortType, selectItem.isAscend)
  if self.itemClickAction ~= nil then
    self.itemClickAction(self.sortFunc)
  end
end

function UINSortButtonGroup:OnDelete()
  if self.itemDic ~= nil then
    for type, item in pairs(self.itemDic) do
      item:OnDelete()
    end
    self.itemDic = nil
  end
end

return UINSortButtonGroup
