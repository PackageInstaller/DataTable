local ShopViewBase, Super = NewClass("ShopViewBase", BaseView)
local TYPEOF_RectTransform = typeof(CS.UnityEngine.RectTransform)
local TYPEOF_Z1ToggleGroup = typeof(CS.Z1Client.Z1ToggleGroup)
local TYPEOF_UIAnimationController = typeof(CS.Z1Client.UIAnimationController)
local MainShopTypeTag = CommonDefine.MainShopTypeTag

function ShopViewBase:ctor(targetShopTypeTid, closeCb)
  Super.ctor(self)
  self:_SetCurSelectShopType(targetShopTypeTid)
  self.textObj2TimerMap = {}
  self.closeCb = closeCb
end

function ShopViewBase:OnBuildView()
  local featureNotUnlocked = self.curShopTypeTag and not MainShopDataUtils.GetFeatrueUnlockByMainShopTypeTag(self.curShopTypeTag)
  local notShopData = self.curShopTypeTag and not MainShopDataUtils.GetShopDataByTag(self.curShopTypeTag)
  if featureNotUnlocked or notShopData then
    self:_CloseOfUnOpenedShopType()
    return
  end
  self.compCloseBtn = self:AddViewComponent(self.ui.UI_Common_Btn_Back3, UICompBtnCloseItem, System.fn(self, self.Close))
  self.uiAnimationController = self.ui.uiNode:GetComponent(TYPEOF_UIAnimationController)
  self.shopTypeRelativeUIInfos = {
    [MainShopTypeTag.MoonCard] = {
      relativeUI = self.ui.Group_Card,
      refreshFunc = System.fn(self, self._RefreshMonthCardUI),
      openAnim = System.fn(self, self._OpenMonthCard)
    },
    [MainShopTypeTag.BattlePassReview] = {
      relativeUI = self.ui.Group_Instructions,
      refreshFunc = System.fn(self, self._RefreshBattlePassUI),
      openAnim = System.fn(self, self._OpenBattlePassReview)
    },
    [MainShopTypeTag.GiftBag] = {
      relativeUI = self.ui.Group_GiftBag,
      refreshFunc = System.fn(self, self._RefreshGiftBagUI),
      openAnim = System.fn(self, self._OpenGiftBag)
    }
  }
  self.goodsItemClsMap = {
    [MainShopTypeTag.GoldShop] = GoldShopGoodsListItem
  }
  self.z1ToggleGroup = self.ui.Group_Toggle:GetComponent(TYPEOF_Z1ToggleGroup)
end

function ShopViewBase:OnEnterView()
  self:_RefreshTabTableView(true)
  self:_RefreshView()
  self:_PlayTabsOpenAnimation()
  self:_RefreshShopTitle()
  self:_RefreshBgImage()
  if self.ui.Image_Shop_Black then
    self.ui.Image_Shop_Black:SetActive(self.curShopTypeTag == MainShopTypeTag.ReturnCoinShop)
  end
end

function ShopViewBase:RegisterNotifications()
  self:RegisterLocalNotify(NotifyId.OnSelectShopTypeChanged, System.fn(self, self._OnSelectShopTypeChanged))
  self:RegisterLocalNotify(NotifyId.OnUpdateShopGoodsList, System.fn(self, self._OnUpdateShopGoodsList))
end

function ShopViewBase:RegisterEvents()
  Super.RegisterEvents(self)
  self:BindEvent(EventMgr.Instance.UpdateBagEvent, System.fn(self, self._OnItemChanged))
  self:_CreateShopTypeTableView()
  self:_CreateGoodsTableView()
end

function ShopViewBase:OnExitView()
  self.shopTypeTableView.reloadFinishCallback = nil
  Super.OnExitView(self)
end

function ShopViewBase:Close()
  Super.Close(self)
  if self.closeCb then
    self.closeCb()
  end
end

function ShopViewBase:_CloseOfUnOpenedShopType()
  local unopenedTipsId = 10207
  Alert.Show(unopenedTipsId)
  self:SetRendered(false)
  self.binder:BindTimer(0, 0, nil, function()
    self:Close()
  end)
end

function ShopViewBase:_RefreshShopTitle()
  local title = self:_GetShopTitle()
  self:SetText(self.ui.Text_Shop_Title, title)
end

function ShopViewBase:_RefreshBgImage()
  local bgPath = self:_GetShopBg()
  if bgPath then
    self:SetImageSync(self.ui.Image_Shop_Bg, bgPath)
  end
end

function ShopViewBase:_CreateShopTypeTableView()
  local cellRT = self.ui.UI_Shop_Item_Toggle:GetComponent(TYPEOF_RectTransform)
  local width, height = cellRT.sizeDelta.x, cellRT.sizeDelta.y
  self.shopTypeTableView = self:CreateTableview(self.ui.ScrollView, function()
    if not self.shopTypeList then
      return 0
    end
    return #self.shopTypeList
  end, function(view, index)
    do return self._ShopTypeCellAtIndex, self, view end
    return self._ShopTypeCellAtIndex, self, view, index
  end, function()
    return width, height
  end)
end

function ShopViewBase:_ShopTypeCellAtIndex(view, index)
  local shopTypeTid = self.shopTypeList[index]
  local cell = view:DequeueCell()
  cell = cell or view:AddChild(self.ui.UI_Shop_Item_Toggle)
  local shopTypeCfg = ShopExtModel.Instance:GetShopTypeConfig(shopTypeTid)
  local relativeUIInfo = self:_GetRelativeUIInfo(shopTypeCfg.TypeTag)
  if not relativeUIInfo or not relativeUIInfo.relativeUI then
    return cell
  end
  local toggleItem = self:AddViewComponentOnce(cell.gameObject, ShopTypeToggleListItem, shopTypeTid, relativeUIInfo.relativeUI, relativeUIInfo.openAnim, self.z1ToggleGroup)
  if shopTypeTid == self.curShopTypeTid then
    toggleItem:SetToggleOn(true)
    RedPointDataUtils.ReqRemoveData(RedPointDataUtils.RedType.Shop, RedPointDataUtils.RedAttrType.IsNew, shopTypeTid)
  end
  return cell
end

function ShopViewBase:_RefreshTabTableView(reloadDataList)
  self.shopTypeList = self:_GetShopTypeList(reloadDataList)
  if not self.curShopTypeTid then
    local shopTypeTid = self.shopTypeList and self.shopTypeList[1]
    self:_SetCurSelectShopType(shopTypeTid)
  end
  if reloadDataList then
    self.shopTypeTableView:ReloadData()
  else
    self.shopTypeTableView:Refresh()
  end
end

function ShopViewBase:_PlayTabsOpenAnimation()
  if self.shopTypeTableView.isReady then
    self:PlayTableViewFadeInAnim(self.ui.ScrollView)
  else
    function self.shopTypeTableView.reloadFinishCallback()
      self.shopTypeTableView.reloadFinishCallback = nil
      
      self:PlayTableViewFadeInAnim(self.ui.ScrollView)
    end
  end
end

function ShopViewBase:_RefreshCurrencyList()
  self.currencyList = self:_GetCurrencyList()
  self:AddViewComponentOnce(self.ui.Group_Coin, UICompCommonCurrencyGroupItem, self.currencyList)
end

function ShopViewBase:_CreateGoodsTableView()
  self.goodsTableView = self:CreateTableview(self.ui.ScrollView_Bag_Material, function()
    if not self.goodsList then
      return 0
    end
    return #self.goodsList
  end, function(view, index)
    do return self._GoodsCellAtIndex, self, view end
    return self._GoodsCellAtIndex, self, view, index
  end)
end

function ShopViewBase:_GoodsCellAtIndex(view, index)
  local goods = self.goodsList[index]
  local cell = view:DequeueCell()
  cell = cell or view:AddChild(self.ui.UI_Shop_Item_Commodity)
  local goodsItemCls = self:_GetGoodsItemCls(self.curShopTypeTag)
  self:AddViewComponentOnce(cell.gameObject, goodsItemCls, goods)
  return cell
end

function ShopViewBase:_RefreshGoodsTableView(reloadDataList)
  local needReloadView = false
  if reloadDataList then
    local goodsList = self:_GetGoodsList(self.curShopTypeTid, true) or {}
    needReloadView = #goodsList ~= #(self.goodsList or {})
    self.goodsList = goodsList
  end
  self.goodsTableView:ReloadData()
end

function ShopViewBase:_ResetGoodsTableViewToTop()
  local relativeUIInfo = self:_GetRelativeUIInfo(self.curShopTypeTag)
  if relativeUIInfo.refreshFunc then
    return
  end
  
  local function _ResetToTop()
    if #(self.goodsList or {}) > 0 then
      local offset = self.goodsTableView:GetOffsetByIndex(0)
      self.goodsTableView:SetOffset(offset, false)
    end
  end
  
  if self.goodsTableView.isReady then
    _ResetToTop()
  else
    local oldCb = self.goodsTableView.reloadFinishCallback
    
    function self.goodsTableView.reloadFinishCallback()
      self.goodsTableView.reloadFinishCallback = oldCb
      if oldCb then
        oldCb()
      end
      _ResetToTop()
    end
  end
end

function ShopViewBase:_GetGoodsItemCls(shopType)
  local specificGoodsItemCls = self.goodsItemClsMap[shopType]
  return specificGoodsItemCls or ShopGoodsListItemBase
end

function ShopViewBase:_RefreshMonthCardUI()
end

function ShopViewBase:_OpenMonthCard()
end

function ShopViewBase:_OpenGiftBag()
end

function ShopViewBase:_RefreshGiftBagUI(reloadData)
end

function ShopViewBase:_RefreshBattlePassUI()
end

function ShopViewBase:_OpenBattlePassReview()
end

function ShopViewBase:_RefreshView()
  self:_RefreshCurrencyList()
  self:_RefreshCountdownUI()
  local shopTypeTag = self.curShopTypeTag
  local relativeUIInfo = self:_GetRelativeUIInfo(shopTypeTag)
  if relativeUIInfo and relativeUIInfo.openAnim then
    relativeUIInfo.openAnim()
  end
  if relativeUIInfo.refreshFunc then
    relativeUIInfo.refreshFunc()
    return
  end
  self:_RefreshGoodsTableView(true)
end

function ShopViewBase:_GetShopTitle()
  do return LT.Text end
  return LT.Text, "ShopNameDefault"
end

function ShopViewBase:_GetShopBg()
  local shopTypeConfig = ShopExtModel.Instance:GetShopTypeConfig(self.curShopTypeTid)
  return shopTypeConfig and shopTypeConfig.BackgroundImage
end

function ShopViewBase:_GetShopTypeList()
  return
end

function ShopViewBase:_GetRelativeUIInfo(shopType)
  return self.shopTypeRelativeUIInfos[shopType] or {
    relativeUI = self.ui.ScrollView_Bag_Material
  }
end

function ShopViewBase:_SetCurSelectShopType(shopTypeTid)
  if not shopTypeTid then
    return
  end
  self.curShopTypeTid = shopTypeTid
  self.curShopTypeTag = ShopExtModel.Instance:GetShopTypeTag(self.curShopTypeTid)
end

function ShopViewBase:_OnSelectShopTypeChanged(shopTypeTid)
  if not shopTypeTid then
    return
  end
  if shopTypeTid == self.curShopTypeTid then
    return
  end
  self:_SetCurSelectShopType(shopTypeTid)
  RedPointDataUtils.ReqRemoveData(RedPointDataUtils.RedType.Shop, RedPointDataUtils.RedAttrType.IsNew, shopTypeTid)
  if self.curShopTypeTag == MainShopTypeTag.MoonCard then
    RedPointDataUtils.ReqRemoveData(RedPointDataUtils.RedType.MonthCardExpire, "red")
  end
  self:_RefreshView()
  self:_ResetGoodsTableViewToTop()
end

function ShopViewBase:_OnUpdateShopGoodsList(shopTypeTid)
  if not shopTypeTid then
    return
  end
  if shopTypeTid ~= self.curShopTypeTid then
    return
  end
  local relativeUIInfo = self:_GetRelativeUIInfo(self.curShopTypeTag)
  if relativeUIInfo.refreshFunc then
    relativeUIInfo.refreshFunc(true)
    return
  end
  self:_RefreshGoodsTableView(true)
end

function ShopViewBase:_OnItemChanged(items)
  if not items or type(items) ~= "table" then
    return
  end
  local needRefreshView = false
  for _, item in pairs(items) do
    if table.contains(self.currencyList, item.tid) then
      needRefreshView = true
      break
    end
  end
  if not needRefreshView then
    return
  end
  self:_RefreshView()
end

function ShopViewBase:_GetGoodsList(shopTypeTid, needCalc)
  do return ShopExtModel.Instance.GetGoodsList, ShopExtModel.Instance, shopTypeTid end
  return ShopExtModel.Instance.GetGoodsList, ShopExtModel.Instance, shopTypeTid, needCalc
end

function ShopViewBase:_GetCurrencyList()
  local shopTypeConfig = ShopExtModel.Instance:GetShopTypeConfig(self.curShopTypeTid)
  return shopTypeConfig and shopTypeConfig.ShowMoney or {}
end

function ShopViewBase:_RefreshCountdownUI()
  local shopData = MainShopDataUtils.GetShopData(self.curShopTypeTid)
  local hasFlushTime = shopData and (shopData.refreshTime or 0) > 0
  local hasCloseTime = shopData and (shopData.closeTs or 0) > 0
  local isActivityShop = self.curShopTypeTag ~= MainShopTypeTag.GoldShop
  self.ui.Group_Cost:SetActive(false)
  self.ui.UI_Common_Btn_Type1:SetActive(false)
  self.ui.Btn_Flushed:SetActive(false)
  self.ui.Image_Flushed:SetActive(hasFlushTime)
  self.ui.Group_CloseTime:SetActive(hasCloseTime and not isActivityShop)
  if hasFlushTime then
    local refreshTs = shopData.refreshTime or 0
    self:_BindRefreshTimer(refreshTs)
  end
  if hasCloseTime then
    local closeTs = shopData.closeTs or 0
    self:_BindCloseTimer(closeTs)
  end
end

function ShopViewBase:_BindRefreshTimer(nextRefreshTs)
  self:_RefreshTimerFixUpdate(nextRefreshTs)
  self:ClearTimer(self.ui.Text_Flushed)
  if nextRefreshTs <= 0 then
    return
  end
  local refreshTimer = self:BindTimer(1, -1, System.bind(self._RefreshTimerFixUpdate, self, nextRefreshTs))
  self.textObj2TimerMap[self.ui.Text_Flushed] = refreshTimer
end

function ShopViewBase:_RefreshTimerFixUpdate(nextRefreshTs)
  local timeText = ""
  local countdown = nextRefreshTs - TimeUtils.GetServerTime()
  if countdown > 0 then
    local _, m, h, s = TimeUtils.ConvertTime(countdown)
    timeText = LT.Textf("GoldShopRefreshDesc", m, h, s)
  else
    self:ClearTimer(self.ui.Text_Flushed)
  end
  self:SetText(self.ui.Text_Flushed, timeText)
end

function ShopViewBase:_BindCloseTimer(closeTs)
  self:_CloseTimerFixUpdate(closeTs)
  self:ClearTimer(self.ui.Text_CloseTime)
  if closeTs <= 0 then
    return
  end
  local closeTimer = self:BindTimer(1, -1, System.bind(self._CloseTimerFixUpdate, self, closeTs))
  self.textObj2TimerMap[self.ui.Text_CloseTime] = closeTimer
end

function ShopViewBase:_CloseTimerFixUpdate(closeTs)
  local timeText = ""
  local countdown = closeTs - TimeUtils.GetServerTime()
  if countdown > 0 then
    timeText = TimeUtils.ActivityCountDownFormat(countdown)
  else
    self:ClearTimer(self.ui.Text_CloseTime)
  end
  self:SetText(self.ui.Text_CloseTime, timeText)
end

function ShopViewBase:ClearTimer(textObj)
  if textObj and self.textObj2TimerMap[textObj] then
    self:StopTimer(self.textObj2TimerMap[textObj])
    self.textObj2TimerMap[textObj] = nil
    return
  end
  for obj, timerId in pairs(self.textObj2TimerMap) do
    self:StopTimer(timerId)
    self.textObj2TimerMap[obj] = nil
  end
end

return ShopViewBase
