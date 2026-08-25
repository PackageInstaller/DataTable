local typeof = _ENV.typeof
local Slider = CS.UnityEngine.UI.Slider
local AddClipToPlay = AnimatorUtils.AddClipToPlay
local UIAnimationController = CS.Z1Client.UIAnimationController
local ItemUsePanel, Super = System.NewClass("ItemUsePanel", UIBasePanel)
ItemUsePanel.uiResCls = UI_Shop_Popup_TipsResource
local MINBUYCOUNT = 1

function ItemUsePanel:ctor(itemId, afterUseCallback)
  Super.ctor(self)
  self.addNum = Vue.ref(MINBUYCOUNT)
  self.maxUseCount = math.floor(ItemDataUtils.GetItemNum(itemId) / ItemDataUtils.GetMinUseCount(itemId))
  self.itemId = itemId
  self.afterUseCallback = afterUseCallback
end

function ItemUsePanel:OnBind(binder)
  self.binder = binder
  self:BindVisible()
  self:BindImage()
  self:BindRaw()
  self:BindButton()
  self:BindText()
  self:BindSlider()
  self:BindItemComp()
  self:BindCurrency()
  self:Init()
end

function ItemUsePanel:Init()
  self.binder:SetSliderCurValue(self.ui.Slider_Buy, math.floor(self.addNum.value))
  self.uiAnimController = self.ui.uiNode:GetComponent(typeof(UIAnimationController))
  local clipsToPlay = ""
  self.uiAnimController:PlayMultiState(AddClipToPlay(clipsToPlay, "UI_Shop_Popup_Tips_Open"), nil)
  if 1 == self.maxUseCount then
    self.addNum.value = 1
  end
  self.ui.Slider_Buy:GetComponent(typeof(CS.UnityEngine.UI.Slider)).interactable = 1 ~= self.maxUseCount
end

function ItemUsePanel:BindCurrency()
  local itemCfg = DT.Item[self.itemId]
  if itemCfg.SpParam then
    local dropID = itemCfg.SpParam[1]
    local dropCfg = DT.Drop[dropID]
    if dropCfg then
      dropCfg = dropCfg.data_list[1]
      local dropItemCfg = DT.Item[dropCfg.DropItem]
      if dropItemCfg and dropItemCfg.Type == "TopBarItem" then
        self.ui.Group_Coin:SetActive(true)
        self.binder:BindComponent(CommonCurrencyGroupItem(self.ui.Group_Coin, {
          dropCfg.DropItem
        }, true, true))
      else
        self.ui.Group_Coin:SetActive(false)
      end
    else
      self.ui.Group_Coin:SetActive(false)
    end
  else
    self.ui.Group_Coin:SetActive(false)
  end
end

function ItemUsePanel:BindVisible()
  self.ui.Group_No_Money:SetActive(false)
  self.ui.Group_Buy:SetActive(true)
  self.binder:BindToVisible(self.ui.Btn_Add, function()
    return 1 ~= self.maxUseCount
  end)
  self.binder:BindToVisible(self.ui.Btn_Subtract, function()
    return 1 ~= self.maxUseCount
  end)
  self.binder:BindToVisible(self.ui.Group_Slider, function()
    return 1 ~= self.maxUseCount
  end)
  self.binder:BindToVisible(self.ui.Image_One_Good, function()
    return 1 == self.maxUseCount
  end)
  
  local function AddValue_Equal_MaxCnt()
    return self.addNum.value == self.maxBuyCount
  end
  
  local function SubValue_Equal_MinCnt()
    return self.addNum.value == MINBUYCOUNT
  end
  
  self.binder:BindToVisible(self.ui.Add_Group_Normal, function()
    return not AddValue_Equal_MaxCnt()
  end)
  self.binder:BindToVisible(self.ui.Add_Group_Unclickable, AddValue_Equal_MaxCnt)
  self.binder:BindToVisible(self.ui.Sub_Group_Normal, function()
    return not SubValue_Equal_MinCnt()
  end)
  self.binder:BindToVisible(self.ui.Sub_Group_Unclickable, SubValue_Equal_MinCnt)
end

function ItemUsePanel:BindItemComp()
  local itemTid = tonumber(self.itemId)
  local itemData = {itemTid = itemTid}
  self.binder:BindComponent(CommonIconItemType2(self.ui.UI_Common_Item_WuPin_Type2, itemData))
end

function ItemUsePanel:BindImage()
  self.binder:BindToImage(self.ui.Image_Icon, function()
    local cfg = ItemDataUtils.GetItemConfig(tonumber(self.itemId))
    return cfg.Icon or ""
  end)
end

function ItemUsePanel:BindRaw()
end

function ItemUsePanel:BindButton()
  local binder = self.binder
  local confirmBtnTipsData = {
    clickFunc = function()
      self:OnConfirmClick()
    end,
    text = LT.Text("Event_ItemUseConfirm"),
    stateFunc = function()
      return CommonDefine.BtnType.High
    end
  }
  local cancelBtnTipsData = {
    clickFunc = function()
      self:OnBtnCancelClick()
    end,
    text = LT.Text("Event_ItemUseCancel"),
    stateFunc = function()
      return CommonDefine.BtnType.High
    end
  }
  local commonPopupConfirmTipsData = {
    sizeType = CommonDefine.ConfirmTipsType.M,
    confirmBtnTipsData = confirmBtnTipsData,
    cancelBtnTipsData = cancelBtnTipsData,
    textTitleCN = LT.Text("ShopConfirmExchange")
  }
  binder:BindComponent(CommonPopupConfirmTips(self.ui.UI_Common_Popup_Tips_Confirm_M, commonPopupConfirmTipsData))
  binder:BindZ1Button(self.ui.Btn_Help, System.fn(self, self.ShowItemTips))
  binder:BindZ1Button(self.ui.Btn_Add, System.fn(self, self.OnAddClick))
  binder:BindZ1Button(self.ui.Btn_Subtract, System.fn(self, self.OnReduceClick))
  binder:BindZ1Button(self.ui.UI_Common_Btn_Max, System.fn(self, self.OnMaxClick))
end

function ItemUsePanel:OnAddClick()
  local nextNum = math.min(self.maxUseCount, self.addNum.value + 1)
  self.binder:SetSliderCurValue(self.ui.Slider_Buy, math.floor(nextNum))
  self.addNum.value = nextNum
end

function ItemUsePanel:OnReduceClick()
  local nextNum = math.max(MINBUYCOUNT, self.addNum.value - 1)
  self.binder:SetSliderCurValue(self.ui.Slider_Buy, math.floor(nextNum))
  self.addNum.value = nextNum
end

function ItemUsePanel:OnMaxClick()
  self.binder:SetSliderCurValue(self.ui.Slider_Buy, math.floor(self.maxUseCount))
  self.addNum.value = self.maxUseCount
end

function ItemUsePanel:BindText()
  local binder = self.binder
  binder:BindToText(self.ui.Text_Title, function()
    do return LT.Text end
    return LT.Text, "Event_ItemUseTitle"
  end)
  binder:BindToText(self.ui.Text_Item_Name, function()
    local cfg = ItemDataUtils.GetItemConfig(tonumber(self.itemId))
    return cfg.Name or ""
  end)
  binder:BindToText(self.ui.Text_Have, function()
    local num = ItemDataUtils.GetItemNum(self.itemId)
    local minUseCount = ItemDataUtils.GetMinUseCount(self.itemId)
    if minUseCount > 1 then
      do return LT.Textf, "Event_ItemOwnCnt" end
      return LT.Textf, "Event_ItemOwnCnt", num .. "/" .. minUseCount, "/", minUseCount
    end
    do return LT.Textf, "Event_ItemOwnCnt" end
    return LT.Textf, "Event_ItemOwnCnt", num, "/", minUseCount
  end)
  binder:BindToText(self.ui.Text_Describe, function()
    local cfg = ItemDataUtils.GetItemConfig(tonumber(self.itemId))
    return cfg.Desc or ""
  end)
  StrUtils.SetPreferredHeight(self.ui.Text_Describe)
  binder:BindToText(self.ui.Text_Group_Buy_Title, function()
    if ItemDataUtils.GetMinUseCount(self.itemId) > 1 then
      return "ItemUseTimes"
    end
    return "Event_ItemUseCnt"
  end)
  binder:BindToText(self.ui.Text_Min, function()
    do return LT.Text end
    return LT.Text, MINBUYCOUNT
  end)
  binder:BindToText(self.ui.Text_Max, function()
    do return LT.Text end
    return LT.Text, self.maxUseCount
  end)
  binder:BindToText(self.ui.Text_Quantity, function()
    do return LT.Text end
    return LT.Text, self.addNum.value
  end)
  self.ui.Text_Item_Num:SetActive(false)
  self.ui.Text_Price:SetActive(false)
  self.ui.Text_Group_Buy_Residue:SetActive(false)
  binder:SetText(self.ui.Text_NotUnlocked, LT.Text("MainShopSingleBuyConfirmPanel_Lock"))
end

function ItemUsePanel:BindSlider()
  local sliderCom = self.ui.Slider_Buy:GetComponent(typeof(Slider))
  sliderCom.value = MINBUYCOUNT
  self.binder:BindToSliderValueChange(self.ui.Slider_Buy, function()
    self.addNum.value = math.floor(sliderCom.value)
  end)
  self.binder:BindToSliderMaxValue(self.ui.Slider_Buy, function()
    return self.maxUseCount
  end)
  self.binder:BindToSliderMinValue(self.ui.Slider_Buy, function()
    if 1 == self.maxUseCount then
      return MINBUYCOUNT - 1
    end
    return MINBUYCOUNT
  end)
end

function ItemUsePanel:OnConfirmClick()
  local function OpenItemUsePanel()
    ItemDataUtils.ReqOnUseItem(self.itemId, self.addNum.value)
    
    self:Close()
    if self.afterUseCallback then
      self.afterUseCallback()
    end
  end
  
  if ItemDataUtils.IsItemsForChoose(self.itemId) then
    local panelData = {
      itemId = self.itemId,
      useNum = self.addNum.value
    }
    UIManager.Instance:Reopen(Urls.ItemUseSelectPanel, panelData)
    self:Close()
    return
  end
  local EnergyPotionItemTid = DT.GetConstant("EnergyPotionItemTid")
  if EnergyPotionItemTid == self.itemId then
    local function CheckEnergyOver()
      local energyItemNum = tonumber(DT.GetConstant("ReplenishEnergyItemRestoreNum"))
      
      local addValue = energyItemNum * self.addNum.value
      if addValue > 0 then
        do return GetEnergyCheckUtils.EnergyIsOverMax end
        return GetEnergyCheckUtils.EnergyIsOverMax, addValue
      else
        return false
      end
    end
    
    if CheckEnergyOver() then
      GetEnergyCheckUtils.TipsShow(OpenItemUsePanel)
    else
      OpenItemUsePanel()
    end
  else
    OpenItemUsePanel()
  end
end

function ItemUsePanel:OnBtnCancelClick()
  self:Close()
end

function ItemUsePanel:ShowItemTips()
  ItemDataUtils.ShowItemDetailTips(self.binder, self.ui.Btn_Help, nil, self.itemId)
end

return ItemUsePanel
