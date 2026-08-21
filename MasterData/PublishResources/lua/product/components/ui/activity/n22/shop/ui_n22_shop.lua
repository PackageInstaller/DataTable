_class("UIActivtiyN22ShopController", UIActivityShopControllerBase)
UIActivtiyN22ShopController = UIActivtiyN22ShopController

function UIActivtiyN22ShopController:Constructor()
  UIActivtiyN22ShopController.super.Constructor(self)
  UIActivityShopControllerBase.ItemGroupHeight = 682
  self.strsLeftTime = {
    "str_n22_shop_open_left_time_d_h",
    "str_n22_shop_open_left_time_h_m",
    "str_n22_shop_open_left_time_m"
  }
end

function UIActivtiyN22ShopController:OnShow(uiParams)
  self._daytext = self:GetUIComponent("UILocalizationText", "EndTimeTextDay")
  self._hourtext = self:GetUIComponent("UILocalizationText", "EndTimeTextHour")
  self._minitext = self:GetUIComponent("UILocalizationText", "EndTimeTextMin")
  self.tipsImg = self:GetGameObject("tipsImg")
  UIActivtiyN22ShopController.super.OnShow(self, uiParams)
  self:ShowTopTips(false)
end

function UIActivtiyN22ShopController:DefaultBackFunc()
  local mCampaign = GameGlobal.GetModule(CampaignModule)
  mCampaign:CampaignSwitchState(true, UIStateType.UIActivityN22MainController, UIStateType.UIMain, nil, self._campaign._id)
end

function UIActivtiyN22ShopController:_RefreshCurrency()
  if not self._currencyId then
    self._currencyId = self._commonCfg.CurrencyId
  end
  local count = self:GetModule(ItemModule):GetItemCount(self._currencyId) or 0
  local preZero = UIActivityHelper.GetZeroStrFrontNum(7, count)
  local fmtStr = string.format("<color=#545454>%s</color><color=#F2C641>%s</color>", preZero, tostring(count))
  self.itemCount:SetText(fmtStr)
  if self.pointIcon then
    local currencyIcon = ""
    local cfgItem = Cfg.cfg_item[self._currencyId]
    if cfgItem then
      currencyIcon = cfgItem.Icon
      self.pointIcon:LoadImage(currencyIcon)
    end
  end
end

function UIActivtiyN22ShopController:_ShowRemainingTime()
  local stopTime = self._shopCloseTime
  local nowTime = math.floor(self._svrTimeModule:GetServerTime() / 1000)
  local remainingTime = stopTime - nowTime
  if remainingTime <= 0 then
    if self._event then
      GameGlobal.RealTimer():CancelEvent(self._event)
      self._event = nil
    end
    remainingTime = 0
  else
  end
  local d, h, m, s = UIActivityHelper.Time2Str(remainingTime)
  self._daytext:SetText(math.ceil(d))
  self._hourtext:SetText(math.ceil(h))
  self._minitext:SetText(math.ceil(m))
end

function UIActivtiyN22ShopController:_ChangeDataStruct(oridata)
  local updata, downdata = DCampaignShopItemGroup:New(), DCampaignShopItemGroup:New()
  updata._unlockTime = oridata._unlockTime
  updata._showTime = oridata._showTime
  updata._closeTime = oridata._closeTime
  updata._isShow = oridata._isShow
  updata._isUnlock = oridata._isUnlock
  updata._isClose = oridata._isClose
  updata._campaignId = oridata._campaignId
  downdata._unlockTime = oridata._unlockTime
  downdata._showTime = oridata._showTime
  downdata._closeTime = oridata._closeTime
  downdata._isShow = oridata._isShow
  downdata._isUnlock = oridata._isUnlock
  downdata._isClose = oridata._isClose
  downdata._campaignId = oridata._campaignId
  local len = #oridata
  for i = 1, #oridata - 1 do
    if i <= len / 2 then
      table.insert(updata, oridata[i])
    else
      table.insert(downdata, oridata[i])
    end
  end
  local lastdata = oridata[#oridata]
  if lastdata then
    local data1 = {
      lastdata[1]
    }
    local data2 = {
      lastdata[2]
    }
    table.insert(updata, data1)
    table.insert(downdata, data2)
  end
  return updata, downdata
end

function UIActivtiyN22ShopController:_RefreshUi(bResetPos)
  local canShowItemGroupData = {}
  local nowTime = math.floor(self._svrTimeModule:GetServerTime() / 1000)
  for index, value in ipairs(self._shopItemGroupData) do
    if ClientCampaignShop.CheckIsGoodsGroupCanShow(value._showTime, nowTime) then
      table.insert(canShowItemGroupData, value)
    end
  end
  self._showShopItemGroupData = canShowItemGroupData
  self._itemGroupCount = #self._showShopItemGroupData
  self._shopItemGroupList:SetListItemCount(self._itemGroupCount, false)
  self._shopItemGroupList:RefreshAllShownItem()
  if bResetPos then
    self._shopItemGroupList:MovePanelToItemIndex(0, 0)
    self._shopItemGroupList:FinishSnapImmediately()
  end
  self:_OnValueRemainingTime()
end

function UIActivtiyN22ShopController:_OnGetShopItemGroupCell(scrollview, index)
  local item = scrollview:NewListViewItem("CellItem")
  local cellPool = self:GetUIComponentDynamic("UISelectObjectPath", item.gameObject)
  if item.IsInitHandlerCalled == false then
    item.IsInitHandlerCalled = true
    cellPool:SpawnObjects("UIActivityShopItemGroup", 2)
  end
  local rowList = cellPool:GetAllSpawnList()
  for i = 1, #rowList do
    local itemWidget = rowList[i]
    if itemWidget then
      local itemIndex = index + 1
      local up, down = self:_ChangeDataStruct(self._showShopItemGroupData[1])
      local showData = i == 1 and up or down
      itemWidget:InitData(showData)
      if itemIndex > self._itemGroupCount then
        itemWidget:GetGameObject():SetActive(false)
      end
      item:GetComponent("RectTransform").sizeDelta = itemWidget:GetRealSize() - Vector2(300, 0)
    end
  end
  return item
end

function UIActivtiyN22ShopController:ShowTopTips(show)
  self.tipsImg:SetActive(show)
end

function UIActivtiyN22ShopController:IconOnClick(go)
  self:ShowTopTips(true)
end

function UIActivtiyN22ShopController:IconAreaOnClick(go)
  self:ShowTopTips(false)
end

function UIActivtiyN22ShopController:TipBtnOnClick(go)
  self.tipsImg:SetActive(false)
end
