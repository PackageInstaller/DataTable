local UIFairyRecovery = class("UIFairyRecovery", UIBaseWindow)
local base = UIBaseWindow
local UINFairyCultivateCardItemList = require("Game.Fairy.UI.UINFairyCultivateCardItemList")
local UINFairyTopFilterNode = require("Game.Fairy.UI.Common.UINFairyTopFilterNode")
local FairyFilterEnum = require("Game.Fairy.UI.ListFilter.FairyFilterEnum")
local UINBaseItemWithCount = require("Game.CommonUI.Item.UINBaseItemWithCount")
local UINFairySiftCondition = require("Game.Fairy.UI.ListFilter.UINFairySiftCondition")
local FairyCultivateMainUIData = require("Game.Fairy.Data.UIData.FairyCultivateMainUIData")
local eFairyEnum = require("Game.Fairy.eFairyEnum")

function UIFairyRecovery:OnInit()
  self.selectedFairyList = {}
  self.filterTopNode = UINFairyTopFilterNode.New()
  self.filterTopNode:Init(self.ui.filterTopNode)
  self.fairyCardList = UINFairyCultivateCardItemList.New()
  self.fairyCardList:Init(self.ui.list)
  self.itemPool = UIItemPool.New(UINBaseItemWithCount, self.ui.baseItemWithCount)
  UIUtil.AddButtonListener(self.ui.btn_SelectAll, self, self.OnBtnSelectAllClick)
  UIUtil.AddButtonListener(self.ui.btn_Reset, self, self.OnBtnResetClick)
  UIUtil.AddButtonListener(self.ui.btn_Recovery, self, self.OnBtnRecoveryClick)
  self.__onFairyUpdate = BindCallback(self, self.OnFairyUpdate)
  MsgCenter:AddListener(eMsgEventId.UpdateFairy, self.__onFairyUpdate)
  self.__onBtnFairyFilterClick = BindCallback(self, self.OnBtnFairyFilterClick)
  self.__onFairySortTypeChangeAction = BindCallback(self, self.OnFairySortTypeChangeAction)
  self.OnClickFairyCallback = BindCallback(self, self.OnClickFairy)
  UIUtil.SetTopStatus(self, self.BackAction, {
    ConstGlobalItem.FairyExp,
    ConstGlobalItem.FairyStarUpItem,
    ConstGlobalItem.FairyRecombineItem
  })
end

function UIFairyRecovery:InitFairyRecovery(fairyDataDic, resloader)
  self.fairyDataDic = fairyDataDic
  self.resloader = resloader
  self:_InitUIData()
  self.fairyCardList:InitFairyCultivateCardItemList(self.resloader, self.OnClickFairyCallback, self.uiMainData)
  self.fairyCardList:SetIsMaskFavouriteFairy(true)
  
  function self.fairyCardList.SetSelectedObj(list, index, fairyCardItem)
    self:OnSetSelectedObj(list, index, fairyCardItem)
  end
  
  self.__OnChangeItem = BindCallback(self, self.OnChangeItem)
  self.fairyCardList.OnChangeItemEvent = self.__OnChangeItem
  self.filterTopNode:InitFairyTopFilterNode(self.__onBtnFairyFilterClick, self.__onFairySortTypeChangeAction)
  self:UpdateFairyCountText()
  self.fairyCardList:PlayFairyCultivateCardItemListAnim()
end

function UIFairyRecovery:_InitUIData()
  self.uiMainData = FairyCultivateMainUIData.CreateNewFairyCultivateMainUIData(self.fairyDataDic)
  self.uiMainData:SetRefreshFunc(BindCallback(self, self.OnFairyUpdate))
  self.uiMainData:SetSiftFunc(BindCallback(self, self.SiftFunction))
end

function UIFairyRecovery:GetFairyCtrl()
  if self.fairyCtrl == nil then
    self.fairyCtrl = ControllerManager:GetController(ControllerTypeId.Fairy)
  end
  return self.fairyCtrl
end

function UIFairyRecovery:OnFairyUpdate(haveDelete)
  if haveDelete == true then
    table.clearmap(self.selectedFairyList)
    if self.uiMainData ~= nil then
      local fairyCtrl = self:GetFairyCtrl()
      local fairyDic = fairyCtrl:GetFairyDataDic()
      if fairyDic == nil then
        return
      end
      self.uiMainData:UpdateFairyCultivateMainUIData(fairyDic)
    end
  end
  self.fairyCardList:RefreshCultivateCardList()
  self:UpdateSelect()
end

function UIFairyRecovery:OnSetSelectedObj(list, index, fairyCardItem)
  if list == nil then
    return
  end
  if self.selectedFairyList == nil then
    return
  end
  local go = fairyCardItem and fairyCardItem.gameObject or list.ui.loopList:GetCellByIndex(index - 1)
  local realFairyCardItem = list.fairyCardItemDic[go]
  if realFairyCardItem ~= nil then
    local isSelected = false
    for index, selectedFairy in pairs(self.selectedFairyList) do
      if selectedFairy:GetFairyUID() == realFairyCardItem.fairyData:GetFairyUID() then
        isSelected = true
      end
    end
    realFairyCardItem:SetInteriorSelected(isSelected)
  end
end

function UIFairyRecovery:OnChangeItem(go, index, list, fairyCardItem, fairyData)
  self:SetFairyCardItemSelected(fairyCardItem)
end

function UIFairyRecovery:UpdateSelect()
  if self.fairyCardList == nil then
    return
  end
  local fairyCardItemDic = self.fairyCardList.fairyCardItemDic
  if fairyCardItemDic == nil then
    return
  end
  if self.selectedFairyList == nil then
    return
  end
  for go, fairyCardItem in pairs(fairyCardItemDic) do
    self:SetFairyCardItemSelected(fairyCardItem)
  end
  self:UpdateFairyCountText()
  self:UpdateRecoveryRewards(self.selectedFairyList)
end

function UIFairyRecovery:SetFairyCardItemSelected(fairyCardItem)
  local isSelected = false
  for index, selectedFairy in pairs(self.selectedFairyList) do
    if selectedFairy:GetFairyUID() == fairyCardItem.fairyData:GetFairyUID() then
      isSelected = true
    end
  end
  fairyCardItem:SetInteriorSelected(isSelected)
end

function UIFairyRecovery:UpdateRecoveryRewards(recoveryFairyList)
  self.itemPool:HideAll()
  if recoveryFairyList == nil then
    return
  end
  local rewardIds, rewardNums = self:GetFairyRecoveryRewards(recoveryFairyList)
  for i, itemId in ipairs(rewardIds) do
    local itemCount = rewardNums[i]
    local itemCfg = ConfigData.item[itemId]
    local item = self.itemPool:GetOne()
    item:InitItemWithCount(itemCfg, itemCount)
  end
end

function UIFairyRecovery:UpdateFairyCountText()
  local currentSelectedCount = table.count(self.selectedFairyList)
  local sumCount = self:GetFairyCtrl():GetFairyCount()
  self:SetFairyCountText(currentSelectedCount, sumCount)
end

function UIFairyRecovery:SetFairyCountText(currentSelectedCount, sumCount)
  self.ui.tex_fairyCount.text = string.format("%s/%s", tostring(currentSelectedCount), tostring(sumCount))
end

function UIFairyRecovery:OnClickFairy(fairyData)
  if table.contain(self.selectedFairyList, fairyData) then
    self:RemoveRecoveryFairy(fairyData)
  else
    self:AddRecoveryFairy(fairyData)
  end
end

function UIFairyRecovery:AddRecoveryFairy(fairyData)
  table.insert(self.selectedFairyList, fairyData)
  self:UpdateSelect()
  self:UpdateRecoveryRewards(self.selectedFairyList)
end

function UIFairyRecovery:RemoveRecoveryFairy(fairyData)
  table.removebyvalue(self.selectedFairyList, fairyData)
  self:UpdateSelect()
  self:UpdateRecoveryRewards(self.selectedFairyList)
end

function UIFairyRecovery:GetSelectedFairyList()
  return self.selectedFairyList
end

function UIFairyRecovery:GetFairyRecoveryRewards(fairyDataList)
  local fairyCtrl = self:GetFairyCtrl()
  return fairyCtrl:CalculateRecoveryFairyRewardsAndNum(fairyDataList)
end

function UIFairyRecovery:ClearSelect()
  table.clearmap(self.selectedFairyList)
  self:UpdateSelect()
end

function UIFairyRecovery:OnBtnSelectAllClick()
  table.clearmap(self.selectedFairyList)
  local filterFairyList = self.uiMainData:GetFairyDataUIList()
  for key, fairyData in pairs(filterFairyList) do
    if not fairyData:GetIsFavouriteFairy() then
      table.insert(self.selectedFairyList, fairyData)
    end
  end
  self:UpdateSelect()
end

function UIFairyRecovery:OnBtnResetClick()
  self:ClearSelect()
end

function UIFairyRecovery:OnBtnRecoveryClick()
  local selectedFairyList = self.selectedFairyList
  if selectedFairyList == nil then
    return
  end
  local currentSelectedCount = table.count(self.selectedFairyList)
  if currentSelectedCount == 0 then
    return
  end
  local isExistExpensiveFairy = false
  for index, fairyData in pairs(selectedFairyList) do
    if fairyData:GetCurFairyQuality() == 1 or fairyData:GetFairyCurStar() >= 3 then
      isExistExpensiveFairy = true
    end
  end
  UIManager:ShowWindowAsync(UIWindowTypeID.MessageCommon, function(win)
    if win == nil then
      return
    end
    local msg = ConfigData:GetTipContent(22011)
    win:ShowTextBoxWithYesAndNo(msg, function()
      local function __sendFairyLifeFree()
        local fairyCtrl = self:GetFairyCtrl()
        
        fairyCtrl.network:CS_Fairy_Life_Free(selectedFairyList, function(isSuccess, rewards)
          if not isSuccess then
            return nil
          end
          UIUtil.ShowCommonReward(rewards)
        end)
      end
      
      if isExistExpensiveFairy then
        local window = UIManager:ShowWindow(UIWindowTypeID.MessageCommon)
        window:ShowTextBoxWithYesAndNo(ConfigData:GetTipContent(22012), __sendFairyLifeFree)
      else
        __sendFairyLifeFree()
      end
    end, nil)
  end)
end

function UIFairyRecovery:OnFairyFilterConfirmAction(sortKindData)
  self.sortKindData = sortKindData
  self.uiMainData:FilterFairyDic(self.sortKindData)
  self.fairyCardList:RefreshCultivateCardList()
  local oldSelectedFairyList = self.selectedFairyList
  local filterFairyList = self.uiMainData:GetFairyDataUIList()
  for selectedIndex, fairyData in pairs(oldSelectedFairyList) do
    oldSelectedFairyList[selectedIndex] = nil
    for filterIndex, filterFairyData in pairs(filterFairyList) do
      if fairyData:GetFairyUID() == filterFairyData:GetFairyUID() then
        oldSelectedFairyList[selectedIndex] = fairyData
      end
    end
  end
  self:UpdateSelect()
end

function UIFairyRecovery:CheckFairyFilterCanConfirm(sortKindData)
  local dataList = self.uiMainData:GetRealFairyDataList()
  for i, data in pairs(dataList) do
    if self:SiftFunction(data, sortKindData) then
      return true
    end
  end
  return false
end

function UIFairyRecovery:SiftFunction(fairyData, sortKindData)
  local realSortKindData = sortKindData or self.sortKindData
  if realSortKindData == nil then
    return true
  end
  local rankConfig = realSortKindData[FairyFilterEnum.eKindType.Rank]
  local rankOk = rankConfig.nocondition or rankConfig.selectIndexs[fairyData:GetFairyCurStar()]
  local qualityConfig = realSortKindData[FairyFilterEnum.eKindType.Quality]
  local qualityOk = qualityConfig.nocondition or qualityConfig.selectIndexs[fairyData:GetCurFairyQuality()]
  local typeConfig = realSortKindData[FairyFilterEnum.eKindType.Type]
  local typeOk = typeConfig.nocondition or typeConfig.selectIndexs[fairyData:GetFairyID()]
  if rankOk and qualityOk and typeOk then
    return true
  else
    return false
  end
end

function UIFairyRecovery:OnBtnFairyFilterClick()
  if self.siftCondition == nil then
    local SiftConditionPage = UINFairySiftCondition.New()
    SiftConditionPage:Init(self.ui.fairyShiftConditionNode)
    SiftConditionPage:InitFairySiftCondition(FairyFilterEnum.eKindType, FairyFilterEnum.eKindMaxCount, BindCallback(self, self.OnFairyFilterConfirmAction), nil, BindCallback(self, self.CheckFairyFilterCanConfirm))
    self.siftCondition = SiftConditionPage
  end
  self.siftCondition:SetSortKindData(self.sortKindData)
  self.siftCondition:Show()
end

function UIFairyRecovery:OnFairySortTypeChangeAction(sortFunc)
  self.uiMainData:SetFairySortRuleFunc(sortFunc)
  self.uiMainData:SetSortRule()
  self.fairyCardList:RefreshCultivateCardList()
  self:UpdateSelect()
end

function UIFairyRecovery:BackAction()
  self:OnCloseWin()
  self:Delete()
end

function UIFairyRecovery:CloseWindow()
  UIUtil.OnClickBackByUiTab(self)
end

function UIFairyRecovery:RegistFromeWindowTypeID(UIWindowTypeID)
  self.formWindowTypeID = UIWindowTypeID
end

function UIFairyRecovery:OnDelete()
  if self.fairyCardList ~= nil then
    self.fairyCardList:Delete()
  end
  if self.filterTopNode ~= nil then
    self.filterTopNode:Delete()
  end
  if self.itmePool ~= nil then
    self.itmePool:DeleteAll()
  end
  self.__OnChangeItem = nil
  self.uiMainData = nil
  MsgCenter:RemoveListener(eMsgEventId.UpdateFairy, self.__onFairyUpdate)
  base.OnDelete(self)
end

function UIFairyRecovery:Delete()
  if self.formWindowTypeID ~= nil then
    local win = UIManager:GetWindow(self.formWindowTypeID)
    if win ~= nil and not win.active and self.formWindowTypeID == UIWindowTypeID.FairyCultivateMain then
      win.active = true
      win.gameObject:SetActive(true)
      MsgCenter:Broadcast(eMsgEventId.OnChangeFairyCultivateState, eFairyEnum.FairyCultivateState.check)
      if self:GetFairyCtrl():GetFairyCount() == 0 then
        UIUtil.ReturnUntil2Marker(UIWindowTypeID.FairyCultivateMain, true)
      end
    end
  end
  base.Delete(self)
end

return UIFairyRecovery
