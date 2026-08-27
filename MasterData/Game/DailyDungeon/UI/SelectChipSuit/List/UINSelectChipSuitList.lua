local UINSelectChipSuitList = class("UINSelectChipSuitList", UIBaseNode)
local base = UIBaseNode
local UINSelectChipSuitListItem = require("Game.DailyDungeon.UI.SelectChipSuit.List.UINSelectChipSuitListItem")

function UINSelectChipSuitList:ctor(selectChipSuitRoot)
  self.selectChipSuitRoot = selectChipSuitRoot
end

function UINSelectChipSuitList:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self.ui.scrollRect.onInstantiateItem = BindCallback(self, self.__OnNewItem)
  self.ui.scrollRect.onChangeItem = BindCallback(self, self.__OnChangeItem)
  self._itemDic = {}
  self._showSuitIntroDic = {}
end

function UINSelectChipSuitList:SetLockedSuitDataList(lockedChipPoolList, lockedChipPoolUnlockInfoList)
  self.lockedChipPoolList = lockedChipPoolList
  self.lockedChipPoolUnlockInfoList = lockedChipPoolUnlockInfoList
end

function UINSelectChipSuitList:InitSelectChipSuitList(chipSuitDataList, lastSelectedSuitDic, selectMaxNum, itemClickCallback, lastChipSuitIdList)
  self.chipSuitDataList = chipSuitDataList
  self.lastChipSuitIdList = lastChipSuitIdList
  self._selectedSuitDic = lastSelectedSuitDic
  self.selectMaxNum = selectMaxNum
  self._itemClickCallback = itemClickCallback
  self:_RefillScrollRect()
end

function UINSelectChipSuitList:_RefillScrollRect()
  table.sort(self.chipSuitDataList, function(a, b)
    local isRecommendA = a.isRecommend
    local isRecommendB = b.isRecommend
    if isRecommendA ~= isRecommendB then
      return isRecommendA
    end
    local hasNumA = a.selectNumCur < a.selectNumMax
    local hasNumB = b.selectNumCur < b.selectNumMax
    if hasNumA ~= hasNumB then
      return hasNumA
    end
    local influenceIdA = a.dynChipSuitData:GetSuitChipInfluence()
    local influenceIdB = b.dynChipSuitData:GetSuitChipInfluence()
    if influenceIdA ~= influenceIdB then
      return influenceIdA < influenceIdB
    end
    return a.dynChipSuitData.tagId < b.dynChipSuitData.tagId
  end)
  local count = 0
  count = #self.chipSuitDataList
  if self.lockedChipPoolList ~= nil then
    count = count + #self.lockedChipPoolList
  end
  self.ui.scrollRect.totalCount = count
  self.ui.scrollRect:RefillCells()
end

function UINSelectChipSuitList:__OnNewItem(go)
  local item = UINSelectChipSuitListItem.New(self)
  item:Init(go)
  self._itemDic[go] = item
end

function UINSelectChipSuitList:__OnChangeItem(go, index)
  local item = self._itemDic[go]
  if item == nil then
    error("Can't find item by gameObject")
    return
  end
  local normalLength = #self.chipSuitDataList
  if index < normalLength then
    local chipSuitData = self.chipSuitDataList[index + 1]
    if chipSuitData == nil then
      error("Can't find chipSuitData by index, index = " .. tonumber(index))
    end
    local tagId = chipSuitData.dynChipSuitData.tagId
    local showIntro = self._showSuitIntroDic[tagId]
    local selected = self._selectedSuitDic[tagId] ~= nil
    item:InitSelectChipSuitListItem(chipSuitData, showIntro, selected)
  else
    local chipPoolId = self.lockedChipPoolList[index + 1 - normalLength]
    local unlockInfo = self.lockedChipPoolUnlockInfoList[index + 1 - normalLength]
    item:InitLockedState(chipPoolId, unlockInfo)
  end
end

function UINSelectChipSuitList:RecordSeChipSuitListItemIntroState(chipTagId, showIntro)
  if showIntro == false then
    showIntro = nil
  end
  self._showSuitIntroDic[chipTagId] = showIntro
end

function UINSelectChipSuitList:TrySelectChipSuitItem(chipTagId, selected)
  if selected and table.count(self._selectedSuitDic) >= self.selectMaxNum then
    AudioManager:PlayAudioById(1107)
    return false
  end
  if selected == false then
    table.removebyvalue(self.lastChipSuitIdList, chipTagId)
    self._selectedSuitDic[chipTagId] = nil
  else
    table.insert(self.lastChipSuitIdList, chipTagId)
    self._selectedSuitDic[chipTagId] = #self.lastChipSuitIdList
  end
  self.selectChipSuitRoot:UpdSelectedChipSuit()
  if selected and self._itemClickCallback ~= nil then
    self._itemClickCallback(chipTagId)
  end
  return true
end

function UINSelectChipSuitList:RefreshSelectChipSuitList()
  self.ui.scrollRect:RefreshCells()
end

function UINSelectChipSuitList:OnDelete()
  for k, v in pairs(self._itemDic) do
    v:Delete()
  end
  base.OnDelete(self)
end

return UINSelectChipSuitList
