local MINBUYCOUNT = 1
local AddClipToPlay = AnimatorUtils.AddClipToPlay
local TYPOF_UIANIMATIONCONTROLLER = typeof(CS.Z1Client.UIAnimationController)
local ItemUseView, Super = NewClass("ItemUseView", BaseView)
ItemUseView.uiResCls = UI_Shop_Popup_TipsResource

function ItemUseView:ctor(itemId, afterUseCallback)
  Super.ctor(self)
  self._itemId = itemId
  self._afterUseCallback = afterUseCallback
  self._maxUseCount = 0
  self._addNum = MINBUYCOUNT
end

function ItemUseView:OnBuildView()
  self:AddViewComponent(self.ui.UI_Common_Item_WuPin_Type2, CompPublicIconItemType2, {
    itemTid = tonumber(self._itemId)
  })
  local confirmBtnTipsData = {
    clickFunc = System.fn(self, self._OnConfirmClick),
    text = LT.Text("Event_ItemUseConfirm"),
    stateFunc = function()
      return CommonDefine.BtnType.High
    end
  }
  local cancelBtnTipsData = {
    clickFunc = System.fn(self, self._OnBtnCancelClick),
    text = LT.Text("Event_ItemUseCancel"),
    stateFunc = function()
      return CommonDefine.BtnType.High
    end
  }
  local popupData = {
    sizeType = CommonDefine.ConfirmTipsType.M,
    confirmBtnTipsData = confirmBtnTipsData,
    cancelBtnTipsData = cancelBtnTipsData,
    textTitleCN = LT.Text("ShopConfirmExchange")
  }
  self:AddViewComponent(self.ui.UI_Common_Popup_Tips_Confirm_M, CompPublicPopupConfirmTips, popupData)
  self:_InitCurrencyGroup()
end

function ItemUseView:RegisterNotifications()
  self:RegisterLocalNotify(NotifyId.OnItemUseStateChanged, self._RefreshAll, self)
end

function ItemUseView:RegisterEvents()
  self:AddButtonClickListener(self.ui.Btn_Help, System.fn(self, self._OnClickHelp))
  self:AddButtonClickListener(self.ui.Btn_Add, System.fn(self, self._OnClickAdd))
  self:AddButtonClickListener(self.ui.Btn_Subtract, System.fn(self, self._OnClickSubtract))
  self:AddButtonClickListener(self.ui.UI_Common_Btn_Max, System.fn(self, self._OnClickMax))
end

function ItemUseView:OnEnterView()
  Super.OnEnterView(self)
  self._maxUseCount = self:_CalcEnergyMaxUseCount()
  self._addNum = MINBUYCOUNT
  local Slider = typeof(CS.UnityEngine.UI.Slider)
  self._sliderCom = self.ui.Slider_Buy:GetComponent(Slider)
  if self._sliderCom then
    self._sliderCom.minValue = MINBUYCOUNT
    self._sliderCom.maxValue = self._maxUseCount
    self._sliderCom.value = MINBUYCOUNT
    self._sliderCom.interactable = 1 ~= self._maxUseCount
    self._sliderCom.onValueChanged:AddListener(System.fn(self, self._OnSliderValueChanged))
  end
  if TYPOF_UIANIMATIONCONTROLLER then
    local animCtrl = self.ui.uiNode:GetComponent(TYPOF_UIANIMATIONCONTROLLER)
    if animCtrl then
      animCtrl:PlayMultiState(AddClipToPlay("", "UI_Shop_Popup_Tips_Open"), nil)
    end
  end
  self:_RefreshAll()
end

function ItemUseView:_CalcEnergyMaxUseCount()
  do return math.floor end
  return math.floor, ItemDataUtils.GetItemNum(self._itemId) / ItemDataUtils.GetMinUseCount(self._itemId), ItemDataUtils.GetMinUseCount(self._itemId), self._itemId
end

function ItemUseView:OnExitView()
  if self._sliderCom then
    self._sliderCom.onValueChanged:RemoveAllListeners()
  end
  Super.OnExitView(self)
end

function ItemUseView:_GetItemConfig()
  do return ItemDataUtils.GetItemConfig, tonumber(self._itemId) end
  return ItemDataUtils.GetItemConfig, tonumber(self._itemId)
end

function ItemUseView:_GetItemOwnedText()
  local num = ItemDataUtils.GetItemNum(self._itemId)
  local minUseCount = ItemDataUtils.GetMinUseCount(self._itemId)
  if minUseCount > 1 then
    do return LT.Textf, "Event_ItemOwnCnt" end
    return LT.Textf, "Event_ItemOwnCnt", num .. "/" .. minUseCount, "/", minUseCount
  end
  do return LT.Textf, "Event_ItemOwnCnt" end
  return LT.Textf, "Event_ItemOwnCnt", num, "/", minUseCount
end

function ItemUseView:_GetCurrencyItemId()
  local itemCfg = DT.Item[self._itemId]
  if itemCfg and itemCfg.SpParam then
    local dropID = itemCfg.SpParam[1]
    local dropCfg = DT.Drop[dropID]
    if dropCfg then
      local dropData = dropCfg.data_list[1]
      local dropItemCfg = DT.Item[dropData.DropItem]
      if dropItemCfg and dropItemCfg.Type == "TopBarItem" then
        return dropData.DropItem
      end
    end
  end
  return nil
end

function ItemUseView:_RefreshAll()
  self:_RefreshItemInfo()
  self:_RefreshQuantityArea()
end

function ItemUseView:_RefreshItemInfo()
  local cfg = self:_GetItemConfig()
  self:SetText(self.ui.Text_Title, LT.Text("Event_ItemUseTitle"))
  self:SetText(self.ui.Text_Item_Name, cfg and cfg.Name or "")
  self:SetText(self.ui.Text_Describe, cfg and cfg.Desc or "")
  self:SetText(self.ui.Text_Have, self:_GetItemOwnedText())
  self:SetText(self.ui.Text_NotUnlocked, LT.Text("MainShopSingleBuyConfirmPanel_Lock"))
  if cfg and cfg.Icon then
    self:SetImage(self.ui.Image_Icon, cfg.Icon)
  end
  self.ui.Text_Item_Num.gameObject:SetActive(false)
  self.ui.Text_Price.gameObject:SetActive(false)
  self.ui.Text_Group_Buy_Residue.gameObject:SetActive(false)
end

function ItemUseView:_RefreshQuantityArea()
  local maxUseCount = self._maxUseCount
  local addNum = self._addNum
  local isSingleUse = 1 == maxUseCount
  self.ui.Btn_Add.gameObject:SetActive(not isSingleUse)
  self.ui.Btn_Subtract.gameObject:SetActive(not isSingleUse)
  self.ui.Group_Slider.gameObject:SetActive(not isSingleUse)
  self.ui.Image_One_Good.gameObject:SetActive(isSingleUse)
  if not isSingleUse then
    local atMax = maxUseCount <= addNum
    local atMin = addNum <= MINBUYCOUNT
    self.ui.Add_Group_Normal.gameObject:SetActive(not atMax)
    self.ui.Add_Group_Unclickable.gameObject:SetActive(atMax)
    self.ui.Sub_Group_Normal.gameObject:SetActive(not atMin)
    self.ui.Sub_Group_Unclickable.gameObject:SetActive(atMin)
  end
  local titleKey = "Event_ItemUseCnt"
  if ItemDataUtils.GetMinUseCount(self._itemId) > 1 then
    titleKey = "ItemUseTimes"
  end
  self:SetText(self.ui.Text_Group_Buy_Title, LT.Text(titleKey))
  self:SetText(self.ui.Text_Min, LT.Text(MINBUYCOUNT))
  self:SetText(self.ui.Text_Max, LT.Text(maxUseCount))
  self:SetText(self.ui.Text_Quantity, LT.Text(addNum))
end

function ItemUseView:_InitCurrencyGroup()
  local currencyItemId = self:_GetCurrencyItemId()
  if currencyItemId then
    self.ui.Group_Coin.gameObject:SetActive(true)
    self:AddViewComponent(self.ui.Group_Coin, UICompCommonCurrencyGroupItem, {currencyItemId}, true, true)
  else
    self.ui.Group_Coin.gameObject:SetActive(false)
  end
end

function ItemUseView:_OnSliderValueChanged()
  if self._sliderCom then
    self._addNum = math.floor(self._sliderCom.value)
    self:_RefreshQuantityArea()
  end
end

function ItemUseView:_OnClickAdd()
  self._addNum = math.min(self._addNum + 1, self._maxUseCount)
  if self._sliderCom then
    self._sliderCom.value = self._addNum
  end
  self:_RefreshQuantityArea()
end

function ItemUseView:_OnClickSubtract()
  self._addNum = math.max(self._addNum - 1, MINBUYCOUNT)
  if self._sliderCom then
    self._sliderCom.value = self._addNum
  end
  self:_RefreshQuantityArea()
end

function ItemUseView:_OnClickMax()
  self._addNum = self._maxUseCount
  if self._sliderCom then
    self._sliderCom.value = self._addNum
  end
  self:_RefreshQuantityArea()
end

function ItemUseView:_OnClickHelp()
  local comp = self:GetViewComponent(self.ui.UI_Common_Item_WuPin_Type2, CompPublicIconItemType2)
  if comp then
    comp:OnBtnClick()
  end
end

function ItemUseView:_OnConfirmClick()
  ItemUseController.Instance:ReqUseItem(self._itemId, self._addNum, self._afterUseCallback)
end

function ItemUseView:_OnBtnCancelClick()
  self:Close()
end

return ItemUseView
