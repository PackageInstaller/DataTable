local UINAthScrollList = class("UINAthScrollList", UIBaseNode)
local base = UIBaseNode
local UINAthItem = require("Game.Arithmetic.AthList.Area.UINAthItem")
local UINAthListGroup = require("Game.Arithmetic.AthList.Area.UINAthListGroup")
local AthTableUtil = require("Game.Arithmetic.AthMain.Table.AthTableUtil")
local UINAthMatUpgrade = require("Game.Arithmetic.AthList.Area.MatUpgrade.UINAthMatUpgrade")
local UINAthListSuitItem = require("Game.Arithmetic.AthList.Suit.UINAthListSuitItem")
local AthSortEnum = require("Game.Arithmetic.AthList.Sort.AthSortEnum")
local CS_EventSystem = CS.UnityEngine.EventSystems.EventSystem
local spaceIdDic = {
  [1] = 1,
  [2] = 2,
  [4] = 3,
  [8] = 4
}
local groupXMax = 6
local groupYMax = 2
local sizeGroupPosIdList = {
  [1] = {
    1,
    7,
    2,
    8,
    3,
    9,
    4,
    10,
    5,
    11,
    6,
    12
  },
  [2] = {
    1,
    2,
    3,
    4,
    5,
    6
  },
  [4] = {
    1,
    2,
    3,
    4,
    5
  }
}

function UINAthScrollList:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self:SetAthScrollListGroupGridSize(Vector2.New(groupXMax, groupYMax))
  self.__onAthItemClick = BindCallback(self, self.OnAthItemClick)
  self.__onReturnAthItem = BindCallback(self, self._ReturnAthItem)
  self.__onReturnAthMatNode = BindCallback(self, self._ReturnAthMatNode)
  self.__onReturnAthSuit = BindCallback(self, self._ReturnAthSuit)
  self.ui.scrollRect.OnDragStartHorizontal = BindCallback(self, self.__OnDragStartHorizontal)
  self.ui.scrollRect.onInstantiateItem = BindCallback(self, self.__OnNewItem)
  self.ui.scrollRect.onChangeItem = BindCallback(self, self.__OnChangeItem)
  self.ui.scrollRect.onReturnItem = BindCallback(self, self.__OnReturnItem)
  self.athItemPoolList = {}
  for k, go in ipairs(self.ui.athSpaceItemList) do
    self.athItemPoolList[k] = UIItemPool.New(UINAthItem, go)
  end
  self.athItemGoDic = {}
  self.athGroupItemDic = {}
  self._clickItemWithScroll = true
  self._scrollRectOffsetMaxY = self.ui.scrollRect.transform.offsetMax.y
end

function UINAthScrollList:SetAthScrollListGroupGridSize(groupGridSize)
  self.groupGridSize = groupGridSize
end

function UINAthScrollList:SetAthScrollListClickItemWithScroll(clickItemWithScroll)
  self._clickItemWithScroll = clickItemWithScroll
end

function UINAthScrollList:SetAthScrollListEmptyFunc(listEmptyFunc)
  self._listEmptyFunc = listEmptyFunc
end

function UINAthScrollList:InitAthScrollList(heroData, areaId, quality, clickItemFunc, itemStartDragFunc, resLoader, withMat, ignoreInstalled)
  self.heroData = heroData
  self.resLoader = resLoader
  self.areaId = areaId
  self.quality = quality
  self.clickItemFunc = clickItemFunc
  self.itemStartDragFunc = itemStartDragFunc
  self.withMat = withMat
  self.ignoreInstalled = ignoreInstalled or self.withMat
  if withMat and self.athMatUpNode == nil then
    self.athMatUpNode = UINAthMatUpgrade.New()
    self.athMatUpNode:Init(self.ui.athUpgradeItemList)
  end
end

function UINAthScrollList:SetAthScrollListArea(areaId)
  self.areaId = areaId
end

function UINAthScrollList:SetAthScrollListSuitId(suitId, suitPartId)
  self.withSuit = suitId ~= nil
  self.suitId = suitId
  self.suitPartId = suitPartId
  local offsetMax = self.ui.scrollRect.transform.offsetMax
  offsetMax.y = suitId == nil and self._scrollRectOffsetMaxY or -10
  if self.withSuit and self.athSuitItem == nil then
    local athSuitItem = UINAthListSuitItem.New()
    local go = self.ui.suitInfoItem:Instantiate(self.ui.prefabHolder)
    athSuitItem:Init(go)
    self.athSuitItem = athSuitItem
  end
  if self.withMat and self.withSuit then
    error("Dont support withMat and withSuit")
  end
end

function UINAthScrollList:RefreshAthScrollListData()
  local ignoreInstalled = self.ignoreInstalled
  self.oriAthDataList = nil
  if self.suitId ~= nil then
    self.oriAthDataList, self._allSuitPartAthNum = PlayerDataCenter.allAthData:GetSuitAthList(self.suitId, self.suitPartId)
  elseif self.areaId == nil then
    self.oriAthDataList = PlayerDataCenter.allAthData:GetAllAthList(nil, ignoreInstalled, self.quality)
  else
    self.oriAthDataList = PlayerDataCenter.allAthData:GetAllAthSlotList(self.areaId, nil, ignoreInstalled)
  end
end

function UINAthScrollList:SetAthScrollListRefillFunc(refillFunc)
  self.refillFunc = refillFunc
end

function UINAthScrollList:SetAthScrollListSortFunc(funcSort)
  self.funcSort = funcSort
end

function UINAthScrollList:SetAthScrollListSiftFunc(funcSift)
  self.funcSift = funcSift
end

function UINAthScrollList:RefillAthScrollList(funcSift, funcSort, useLastPos)
  if self.withSuit then
    local recommendDic = self.heroData:GetHeroAthSuitRecommendDic()
    local isRecommend = recommendDic[self.suitId] ~= nil
    self.athSuitItem:InitAthListSuitItem(self.suitId, isRecommend, nil, self.resLoader, self._allSuitPartAthNum)
  end
  if funcSift ~= nil then
    self.funcSift = funcSift
  end
  if funcSort ~= nil then
    self.funcSort = funcSort
  end
  self.curAthSuitDic = {}
  if self.heroData ~= nil then
    self.curAthSuitDic = PlayerDataCenter.allAthData:GetHeroAthSuitIdDic(self.heroData.dataId, self.areaId)
  end
  self.curAthDataList = {}
  for index, athData in ipairs(self.oriAthDataList) do
    if self.funcSift == nil or self.funcSift(athData) then
      table.insert(self.curAthDataList, athData)
    end
  end
  AthSortEnum.ResetAthSort(self.areaId)
  if self.funcSort ~= nil then
    table.sort(self.curAthDataList, self.funcSort)
  end
  self.curAthDataGroupList = {}
  local tempGroup, tempGroupIdList
  local freeSpaceNewLine = false
  for k, athData in ipairs(self.curAthDataList) do
    if tempGroup == nil then
      tempGroup = {allSize = 0}
      tempGroupIdList = {}
      table.insert(self.curAthDataGroupList, tempGroup)
    end
    local size = athData:GetAthSize()
    local forceNewLine = false
    if not freeSpaceNewLine then
      if #tempGroup ~= 0 then
        forceNewLine = true
      end
      freeSpaceNewLine = true
    end
    if forceNewLine or not self:__Insert2TempGroup(tempGroupIdList, tempGroup, athData) then
      tempGroup = {allSize = 0}
      tempGroupIdList = {}
      table.insert(self.curAthDataGroupList, tempGroup)
      self:__Insert2TempGroup(tempGroupIdList, tempGroup, athData)
    end
  end
  self:__RefillList(useLastPos)
  if self.refillFunc ~= nil then
    self.refillFunc()
  end
end

function UINAthScrollList:__Insert2TempGroup(tempGroupIdList, tempGroup, athData)
  local athSize = athData:GetAthSize()
  local posIdList = sizeGroupPosIdList[athSize]
  local groupMaxCount = self.groupGridSize.x * self.groupGridSize.y
  for k, posId in ipairs(posIdList) do
    if tempGroupIdList[posId] == nil then
      local gridIdList = AthTableUtil.GetAthGridIdList(athData, posId, self.groupGridSize.x)
      local canInsert = true
      for k, gridId in ipairs(gridIdList) do
        if gridId > groupMaxCount or tempGroupIdList[gridId] == true then
          canInsert = false
          break
        end
      end
      if canInsert then
        for k, gridId in ipairs(gridIdList) do
          tempGroupIdList[gridId] = true
        end
        tempGroup.allSize = tempGroup.allSize + athSize
        table.insert(tempGroup, {gridId = posId, athData = athData})
        return true
      end
    end
  end
  return false
end

function UINAthScrollList:__RefillList(useLastPos)
  local totalCount = #self.curAthDataGroupList
  if self.withMat or self.withSuit then
    totalCount = totalCount + 1
  end
  if self.ui.scrollRect.totalCount == 0 then
    useLastPos = false
  end
  self.ui.scrollRect.totalCount = totalCount
  if useLastPos then
    self.ui.scrollRect.velocity = Vector2.New(0, 0.001)
    self.ui.scrollRect:RefreshCells()
  else
    self.ui.scrollRect:RefillCells()
  end
  if self._listEmptyFunc ~= nil then
    self._listEmptyFunc(#self.curAthDataGroupList == 0)
  end
end

function UINAthScrollList:SetAthScrollListMultSeletedUidDic(dic)
  self.athMultSeletedUidDic = dic
end

function UINAthScrollList:__OnDragStartHorizontal()
  local curGo = CS_EventSystem.current.currentSelectedGameObject
  local item = self.athItemGoDic[curGo]
  if item == nil then
    return
  end
  item:OnAthItemBeginDrag()
end

function UINAthScrollList:__OnNewItem(go)
  local item = UINAthListGroup.New()
  item:Init(go)
  item:InitAthListGroup(self.__onReturnAthItem, self.__onReturnAthMatNode, self.groupGridSize)
  self.athGroupItemDic[go] = item
end

function UINAthScrollList:__OnChangeItem(go, index)
  local item = self.athGroupItemDic[go]
  if item == nil then
    error("Can't find item by gameObject")
    return
  end
  item:ClealAllAthItem()
  if self.withMat then
    if index == 0 then
      item:AddMatNode2Group(self.athMatUpNode)
      return
    end
  elseif self.withSuit then
    if index == 0 then
      item:AddAthSuit2Group(self.athSuitItem, self.__onReturnAthSuit)
      return
    end
  else
    index = index + 1
  end
  local groupData = self.curAthDataGroupList[index]
  if groupData == nil then
    error("Can't find ath groupData by index, index = " .. tonumber(index))
  end
  for k, v in ipairs(groupData) do
    local athSize = v.athData:GetAthSize()
    local itemPool = self.athItemPoolList[spaceIdDic[athSize]]
    local athItem = itemPool:GetOne()
    athItem.gameObject.name = tostring(k)
    if self.newItemFunc ~= nil then
      self.newItemFunc(athItem)
    end
    if self.itemStartDragFunc ~= nil then
      athItem:SetAthItemDragFunc(self.itemStartDragFunc)
    end
    athItem:SetAthItemRootScrollRectRoot(self.ui.scrollRect)
    athItem:InitAthItem(v.athData, self.__onAthItemClick, self.resLoader)
    local selected = self.athMultSeletedUidDic ~= nil and self.athMultSeletedUidDic[v.athData.uid] ~= nil
    athItem:SetAthItemSelect(selected, true)
    local suitId = v.athData:GetAthSuit()
    if self.curAthSuitDic == nil or self.curAthSuitDic[suitId] then
    end
    self.athItemGoDic[athItem.gameObject] = athItem
    item:AddAthItem2Group(athItem, v.gridId)
  end
end

function UINAthScrollList:__OnReturnItem(go)
  local groupItem = self.athGroupItemDic[go]
  groupItem:ClealAllAthItem()
end

function UINAthScrollList:_ReturnAthItem(athItem)
  local athSize = athItem:GetAthItemData():GetAthSize()
  athItem:TryReturnAthItemSuit(function(hasSuitItem)
  end)
  local itemPool = self.athItemPoolList[spaceIdDic[athSize]]
  athItem.transform:SetParent(self.ui.prefabHolder)
  itemPool:HideOne(athItem)
end

function UINAthScrollList:_ReturnAthMatNode()
  if self.athMatUpNode ~= nil then
    self.athMatUpNode.transform:SetParent(self.ui.prefabHolder)
  end
end

function UINAthScrollList:_ReturnAthSuit()
  if self.athSuitItem ~= nil then
    self.athSuitItem.transform:SetParent(self.ui.prefabHolder)
  end
end

function UINAthScrollList:GetAthItemFromListAll(uid)
  local index = self:__GetAthDataGroupIndexByUid(uid)
  local go = self.ui.scrollRect:GetCellByIndex(index - 1)
  if go == nil then
    return nil
  end
  local groupItem = self.athGroupItemDic[go]
  return groupItem:GetAthItemFromAllGroup(uid)
end

function UINAthScrollList:GetSpaceAthByList(size)
  for index, v in ipairs(self.curAthDataGroupList) do
    for k, v2 in ipairs(v) do
      if v2.athData:GetAthSize() == size then
        local go = self.ui.scrollRect:GetCellByIndex(index - 1)
        if go == nil then
          return nil
        end
        local groupItem = self.athGroupItemDic[go]
        local athItem = groupItem:GetAthItemFromAllGroup(v2.athData.uid)
        return athItem ~= nil and athItem.transform
      end
    end
  end
end

function UINAthScrollList:OnAthItemClick(athItem)
  local uid = athItem:GetAthItemData():GetAthDataUID()
  local rollIndex = self:__GetAthDataGroupIndexByUid(uid)
  if not self.withMat and not self.withSuit then
    rollIndex = rollIndex - 1
  end
  
  local function clickItemFunc()
    if self.clickItemFunc ~= nil then
      self.clickItemFunc(athItem)
    end
  end
  
  if self._clickItemWithScroll then
    self.ui.scrollRect:LocationItem(rollIndex, 1500, clickItemFunc)
  else
    clickItemFunc()
  end
end

function UINAthScrollList:__GetAthDataGroupIndexByUid(uid)
  for index, v in ipairs(self.curAthDataGroupList) do
    for k, v2 in ipairs(v) do
      if v2.athData.uid == uid then
        return index
      end
    end
  end
end

function UINAthScrollList:GetAthScrollListMatUpNode()
  return self.athMatUpNode
end

function UINAthScrollList:GetAthScrollListCurAthList()
  return self.curAthDataList
end

function UINAthScrollList:OnDelete()
  for k, pool in ipairs(self.athItemPoolList) do
    pool:DeleteAll()
  end
  if self.athMatUpNode ~= nil then
    self.athMatUpNode:Delete()
  end
  if self.athSuitItem ~= nil then
    self.athSuitItem:Delete()
  end
  base.OnDelete(self)
end

return UINAthScrollList
