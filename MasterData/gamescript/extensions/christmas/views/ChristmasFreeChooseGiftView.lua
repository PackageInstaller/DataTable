local ChristmasFreeChooseGiftView, Super = NewClass("ChristmasFreeChooseGiftView", BaseView)
ChristmasFreeChooseGiftView.uiResCls = "UI/UI_Research/UI_Research_Prefab/UI_Recharge_Panel_OptionGift.prefab"

function ChristmasFreeChooseGiftView:ctor(itemId, goodsConfig, isSellout)
  Super.ctor(self)
  self.itemId = itemId
  self.itemCfg = ItemDataUtils.GetItemConfig(itemId)
  self.dataList = self:_GetDataListFromSpParam()
  self.goodsConfig = goodsConfig
  self.isSellout = isSellout
end

function ChristmasFreeChooseGiftView:OnBuildView()
  Super.OnBuildView(self)
  self:_CreateGiftInfoDisplay()
  self:_CreateCloseButtonListener()
  self:_CreateCurrencyGroup()
  self:_CreateGiftTableView()
end

function ChristmasFreeChooseGiftView:RegisterNotifications()
  self:RegisterNotify(NotifyId.OnChristmasItemChoose, self._OnChristmasItemChoose, self)
  self:RegisterNotify(NotifyId.OnBagItemDataChanged, self._OnBagItemDataChanged, self)
end

function ChristmasFreeChooseGiftView:RegisterEvents()
  self:AddButtonClickListener(self.ui.Btn_Buy, System.fn(self, self._OnBtnBuyClick))
end

function ChristmasFreeChooseGiftView:OnEnterView()
  Super.OnEnterView(self)
  self:RefreshView()
end

function ChristmasFreeChooseGiftView:OnExitView()
  Super.OnExitView(self)
  if self.goodsConfig.SpecialSoundVX then
    AudioManager.Instance:PostSoundEvent(self.goodsConfig.SpecialSoundVX[2])
  end
end

function ChristmasFreeChooseGiftView:_CreateCloseButtonListener()
  self:AddViewComponent(self.ui.UI_Common_Btn_Back3, UICompBtnCloseItem, System.fn(self, self.Close))
end

function ChristmasFreeChooseGiftView:_CreateCurrencyGroup()
  local currencyList = {
    CommonDefine.CurrencyType.PayMoney,
    CommonDefine.CurrencyType.SeniorMoney
  }
  self:AddViewComponentOnce(self.ui.Group_Coin, UICompCommonCurrencyGroupItem, currencyList)
end

function ChristmasFreeChooseGiftView:_CreateGiftTableView()
  local itemGameObj = self.ui.UI_Recharge_Item_OptionGift
  local sizeDelta = itemGameObj.transform.sizeDelta
  local w, h = sizeDelta.x, sizeDelta.y
  self._giftTableView = self:CreateTableview(self.ui.TableView_Optional, function()
    return #self.dataList
  end, function(view, index)
    do return self._FillGiftItem, self, view end
    return self._FillGiftItem, self, view, index
  end, function()
    return w, h
  end)
  itemGameObj:SetActive(false)
end

function ChristmasFreeChooseGiftView:_FillGiftItem(view, index)
  local cell = view:DequeueCell()
  cell = cell or view:AddChild(self.ui.UI_Recharge_Item_OptionGift)
  local data = self.dataList[index]
  if data then
    self:AddViewComponentOnce(cell.gameObject, ChristmasOptionGiftItem, data, self.ui.UI_Common_Item_WuPin_Type2)
  end
  return cell
end

function ChristmasFreeChooseGiftView:_CreateGiftInfoDisplay()
  if not self.itemCfg then
    return
  end
  if self.ui.Image_Bg then
    local bgPath = self.goodsConfig.SpecialBg
    if bgPath then
      self:SetImage(self.ui.Image_Bg, bgPath)
    end
  end
  if self.goodsConfig.SpecialSoundVX then
    AudioManager.Instance:PostSoundEvent(self.goodsConfig.SpecialSoundVX[1])
    if self.goodsConfig.SpecialSoundVX[3] then
      local prefab = self.binder:LoadAsset(self.goodsConfig.SpecialSoundVX[3])
      self:Instantiate(prefab, self.ui.Image_Bg.transform)
    end
  end
  if self.ui.Image_Icon_Gift then
    local iconPath = ItemDataUtils.GetIcon(self.itemId)
    if iconPath then
      self:SetImage(self.ui.Image_Icon_Gift, iconPath)
    end
  end
  if self.ui.Text_Gift_Name then
    local giftName = ItemDataUtils.GetItemName(self.itemId)
    self:SetText(self.ui.Text_Gift_Name, giftName)
  end
end

function ChristmasFreeChooseGiftView:_RefreshCost()
  local costItem, costNum = self:GetCostItemAndNum()
  if costItem and costNum then
    self:SetImage(self.ui.Image_Cost, ItemDataUtils.GetSmallIcon(costItem))
    local haveNum = ItemDataUtils.GetItemNum(costItem)
    local isChooseAll = self:IsChooseAll()
    local color = "#ffffff"
    if not isChooseAll then
      color = "#B5B5B5"
    elseif costNum > haveNum then
      color = "#FF6262"
    end
    local costText = string.format("<color=%s>x%d</color>", color, costNum)
    self:SetText(self.ui.Text_Cost, costText)
  end
end

function ChristmasFreeChooseGiftView:GetCostItemAndNum()
  if self.goodsConfig and self.goodsConfig.Price then
    do return table.unpack end
    return table.unpack, self.goodsConfig.Price
  end
  return nil, nil
end

function ChristmasFreeChooseGiftView:_RefreshSelectCountTip()
  if not self.ui.Text_Tip then
    return
  end
  if self.isSellout then
    self:SetText(self.ui.Text_Tip, LT.TipsText("10710"))
    return
  end
  local selectedCount = self:_GetSelectedCount()
  local totalCount = self:_GetTotalSelectCount()
  local tipText = LT.Text("MultiSelectBox_SelectItemText")
  tipText = string.format("%s <color=#e1e1e1>%d/%d</color>", tipText, selectedCount, totalCount)
  self:SetText(self.ui.Text_Tip, tipText)
end

function ChristmasFreeChooseGiftView:_GetSelectedCount()
  local count = 0
  for _, data in ipairs(self.dataList) do
    if not data.isFixedDrop and data.selectedItemIndex ~= nil then
      count = count + 1
    end
  end
  return count
end

function ChristmasFreeChooseGiftView:_GetTotalSelectCount()
  local totalCount = 0
  for _, data in ipairs(self.dataList) do
    if not data.isFixedDrop then
      totalCount = totalCount + 1
    end
  end
  return totalCount
end

function ChristmasFreeChooseGiftView:_GetDataListFromSpParam()
  if not self.itemCfg or not self.itemCfg.SpParam then
    return {}
  end
  local dataList = {}
  for index = 1, #self.itemCfg.SpParam do
    local dropTid = self.itemCfg.SpParam[index]
    local isFixedDrop = 1 == index
    if dropTid then
      local dropDataList = DropCfgUtils.GetDropDataList(dropTid)
      if isFixedDrop and not table.next(dropDataList) then
      else
        local giftIndex = #dataList + 1
        table.insert(dataList, {
          isFixedDrop = isFixedDrop,
          dropDataList = dropDataList,
          selectedItemIndex = nil,
          giftIndex = giftIndex
        })
      end
    end
  end
  return dataList
end

function ChristmasFreeChooseGiftView:RefreshView()
  if self._giftTableView then
    self._giftTableView:ReloadData()
  end
  self:_RefreshSelectCountTip()
  self:_RefreshBuyBtnState()
  self:_RefreshCost()
end

function ChristmasFreeChooseGiftView:IsChooseAll()
  local selectedCount = self:_GetSelectedCount()
  local totalCount = self:_GetTotalSelectCount()
  local allSelected = selectedCount >= totalCount
  return allSelected
end

function ChristmasFreeChooseGiftView:_RefreshBuyBtnState()
  local btnEnabled = self:IsChooseAll()
  if self.isSellout then
    btnEnabled = false
  end
  self:SetButtonState(self.ui.Btn_Buy, btnEnabled and CommonDefine.Z1ButtonState.High or CommonDefine.Z1ButtonState.Unclickable)
end

function ChristmasFreeChooseGiftView:_OnChristmasItemChoose(giftIndex, itemIndex)
  for _, data in ipairs(self.dataList) do
    if data.giftIndex == giftIndex then
      data.selectedItemIndex = itemIndex
      break
    end
  end
  self:_RefreshSelectCountTip()
  self:_RefreshBuyBtnState()
  self:_RefreshCost()
end

function ChristmasFreeChooseGiftView:_OnBagItemDataChanged()
  self:_RefreshBuyBtnState()
  self:_RefreshCost()
end

function ChristmasFreeChooseGiftView:_OnBtnBuyClick()
  if self.isSellout then
    Alert.Show(10710)
    return
  end
  if not self:IsChooseAll() then
    Alert.Show("MultiSelectBox_SelectTips")
    return
  end
  local costItem, costNum = self:GetCostItemAndNum()
  if costItem and costNum and not ItemDataUtils.IsItemEnough(costItem, costNum, true) then
    return
  end
  if not self.goodsConfig then
    return
  end
  local itemList = self:GetObtainItemList()
  local priceArr = {costItem, costNum}
  
  local function buyCallback()
    self:_OnBuy()
  end
  
  local extraInfo = {
    currencyList = {
      CommonDefine.CurrencyType.PayMoney,
      CommonDefine.CurrencyType.SeniorMoney
    }
  }
  UIManager.Instance:Reopen(Urls.ConfirmBuyView, itemList, priceArr, buyCallback, extraInfo)
end

function ChristmasFreeChooseGiftView:GetObtainItemList()
  local itemList = {}
  for _, data in ipairs(self.dataList) do
    local selectedIndex = data.selectedItemIndex
    if selectedIndex and data.dropDataList[selectedIndex] then
      local dropInfo = data.dropDataList[selectedIndex]
      table.insert(itemList, {
        tid = dropInfo.DropItem,
        num = dropInfo.DropNum or 1
      })
    elseif data.isFixedDrop then
      for _, dropInfo in ipairs(data.dropDataList) do
        table.insert(itemList, {
          tid = dropInfo.DropItem,
          num = dropInfo.DropNum or 1
        })
      end
    end
  end
  return itemList
end

function ChristmasFreeChooseGiftView:_OnBuy()
  local chooseList = {}
  for _, data in ipairs(self.dataList) do
    if data.selectedItemIndex then
      local itemTid = data.dropDataList[data.selectedItemIndex].DropItem
      table.insert(chooseList, itemTid)
    end
  end
  local params = {
    shopType = self.goodsConfig.ShopType,
    chooseList = chooseList
  }
  MainShopDataUtils.ReqOnBuyMultipleChooseItem(self.goodsConfig.ID, params, function(data)
    self:Close()
  end)
end

return ChristmasFreeChooseGiftView
