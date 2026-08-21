_class("UIHomelandShopController", UIController)
UIHomelandShopController = UIHomelandShopController

function UIHomelandShopController:_SetRawImageBtn(widgetName, size, urlNormal, urlClick, callback)
  local obj = UIWidgetHelper.SpawnObject(self, widgetName, "UIActivityCommonRawImageBtn")
  obj:SetData(size, urlNormal, urlClick, callback)
end

function UIHomelandShopController:_SetRemainingTime(widgetName, descId, endTime, customTimeStr)
  local obj = UIWidgetHelper.SpawnObject(self, widgetName, "UIActivityCommonRemainingTime")
  if customTimeStr then
    obj:SetCustomTimeStr_Common_1()
  end
  obj:SetAdvanceText(descId)
  obj:SetData(endTime, nil, nil)
end

function UIHomelandShopController:LoadDataOnEnter(TT, res, uiParams)
  local homeLandModule = GameGlobal.GetModule(HomelandModule)
  homeLandModule:HomelandShopRefreshReq(TT)
end

function UIHomelandShopController:OnShow(uiParams)
  self._isOpen = true
  self._timeEvent = UIActivityHelper.StartTimerEvent(self._timeEvent, function()
    if self._isOpen then
      self:_AssistantUpdate()
    end
  end)
  self:_AttachEvents()
  self:_SetDebug()
  self:_SetTabBtns()
  self:_SetTabPages()
  self:_SetTabSelect(1)
  self:_CheckGuide()
end

function UIHomelandShopController:OnHide()
  self._isOpen = nil
  self._timeEvent = UIActivityHelper.CancelTimerEvent(self._timeEvent)
  self:_DetachEvents()
end

function UIHomelandShopController:_Refresh()
  local homeLandModule = GameGlobal.GetModule(HomelandModule)
  local shop_info = homeLandModule.m_homeland_info.shop_info
  local index = self._tabIndex
  self._tabPages[index]:SetData(shop_info)
  if index == 1 then
    self._firstBuyBtnObj = self._tabPages[index]:GetMask()
  end
  if index == 2 then
    self._firstSubmitBtnObj = self._tabPages[index]:GetSubmitBtn()
  end
  self:_SetCoinInfo()
end

function UIHomelandShopController:_SetCoinInfo()
  local obj = UIWidgetHelper.SpawnObject(self, "_coinPool", "UIHomelandShopCoin")
  obj:SetData()
end

function UIHomelandShopController:_SetTabBtns()
  local title = {
    "str_homeland_shop_tab_buy_title",
    "str_homeland_shop_tab_order_title",
    "str_homeland_shop_tab_sell_title"
  }
  self._tabBtns = UIWidgetHelper.SpawnObjects(self, "_tabBtns", "UIActivityCommonTextTabBtn", #title)
  for i, v in ipairs(self._tabBtns) do
    v:SetData(i, {
      indexWidgets = {
        {"iconBuy"},
        {"iconOrder"},
        {"iconSell"}
      },
      onoffWidgets = {
        {"OnBtn"},
        {"OffBtn"}
      },
      lockWidgets = {
        {"lock"},
        {}
      },
      titleWidgets = {
        "txtTitle_off",
        "txtTitle_on"
      },
      titleText = StringTable.Get(title[i]),
      callback = function(index, isOffBtnClick)
        if isOffBtnClick then
          self:_SetTabSelect(index)
        end
      end
    })
  end
end

function UIHomelandShopController:_SetTabSelect(index)
  if self._tabIndex == index then
    return
  end
  self._tabIndex = index
  for i = 1, #self._tabBtns do
    self._tabBtns[i]:SetSelected(i == index)
    self._tabPages[i]:GetGameObject():SetActive(i == index)
  end
  self:_SetAssistant(true)
  self:_Refresh()
end

function UIHomelandShopController:_SetTabPages()
  self._tabPages = {}
  self._tabPages[1] = UIWidgetHelper.SpawnObject(self, "_tab_Buy", "UIHomelandShopTabBuy")
  self._tabPages[2] = UIWidgetHelper.SpawnObject(self, "_tab_Order", "UIHomelandShopTabOrder")
  self._tabPages[3] = UIWidgetHelper.SpawnObject(self, "_tab_Sell", "UIHomelandShopTabSell")
end

function UIHomelandShopController:_SetAssistant(open)
  self._assistantOpen = open
  self:GetGameObject("_assistantTip"):SetActive(self._assistantOpen)
  if self._assistantOpen then
    local svrTimeModule = self:GetModule(SvrTimeModule)
    local curTime = math.floor(svrTimeModule:GetServerTime() * 0.001)
    self._assistantTime = curTime + 3
    self._assistantType = self._assistantType or 1
    local tb = {
      1,
      2,
      3,
      4
    }
    table.shuffle(tb)
    self._assistantType = self._assistantType ~= tb[1] and tb[1] or tb[2]
    local txt = StringTable.Get("str_homeland_shop_assistant_common_" .. self._assistantType)
    txt = UIActivityHelper.GetColorText("#6a6969", txt)
    UIWidgetHelper.SetLocalizationText(self, "_txtAssistant", txt)
    local spriteName = "n17_mascot_icon0" .. self._assistantType
    UIWidgetHelper.SetImageSprite(self, "Assistant", "UIHomelandShop.spriteatlas", spriteName)
  end
end

function UIHomelandShopController:_AssistantUpdate()
  local svrTimeModule = self:GetModule(SvrTimeModule)
  local curTime = math.floor(svrTimeModule:GetServerTime() * 0.001)
  self._assistantTime = self._assistantTime or 0
  if self._assistantOpen and curTime > self._assistantTime then
    self:_SetAssistant(false)
  end
end

function UIHomelandShopController:_AttachEvents()
  self:AttachEvent(GameEventType.OnUIGetItemCloseInQuest, self._Refresh)
  self:AttachEvent(GameEventType.HomelandShopUpdate, self._Refresh)
end

function UIHomelandShopController:_DetachEvents()
  self:DetachEvent(GameEventType.OnUIGetItemCloseInQuest, self._Refresh)
  self:DetachEvent(GameEventType.HomelandShopUpdate, self._Refresh)
end

function UIHomelandShopController:CloseBtnOnClick(go)
  self:CloseDialog()
end

function UIHomelandShopController:AssistantOnClick(go)
  self:_SetAssistant(not self._assistantOpen)
end

function UIHomelandShopController:_SetDebug()
  local open = UIActivityHelper.CheckDebugOpen()
  self:GetGameObject("_debug"):SetActive(open)
end

function UIHomelandShopController:_DelayRefresh()
  TaskManager:GetInstance():StartTask(function(TT)
    YIELD(TT, 100)
    self:_Refresh()
  end)
end

function UIHomelandShopController:TestAddCoinsBtnOnClick(go)
  local count = 1000
  UIGMHelper.AddAsset(UIHomelandShopHelper.GetCoinItemId(), count)
  self:_DelayRefresh()
end

function UIHomelandShopController:TestAddOrderItemsBtnOnClick(go)
  local homeLandModule = GameGlobal.GetModule(HomelandModule)
  local shop_info = homeLandModule.m_homeland_info.shop_info
  for _, goods_info in pairs(shop_info.goods_info) do
    for i, v in ipairs(goods_info.item_info) do
      UIGMHelper.AddAsset(v.assetid, v.count)
    end
  end
  self:_DelayRefresh()
end

function UIHomelandShopController:TestAddSellItemsBtnOnClick(go)
  local cfgs = Cfg.cfg_homeland_univalence({})
  for k, v in pairs(cfgs) do
    UIGMHelper.AddAsset(k, 1)
  end
  self:_DelayRefresh()
end

function UIHomelandShopController:TestAddRefreshlItemBtnOnClick(go)
  local itemId = Cfg.cfg_homeland_global.GoodsRefreshItemId.IntValue
  UIGMHelper.AddAsset(itemId, 1)
  self:_DelayRefresh()
end

function UIHomelandShopController:TestRefreshAllBtnOnClick(go)
  local homeLandModule = GameGlobal.GetModule(HomelandModule)
  local shop_info = homeLandModule.m_homeland_info.shop_info
  local itemId = Cfg.cfg_homeland_global.GoodsRefreshItemId.IntValue
  UIGMHelper.AddAsset(itemId, table.count(shop_info.goods_info))
  for i, _ in pairs(shop_info.goods_info) do
    UIHomelandShopHelper.Start_HomelandGoodReq(i + 1, false)
  end
  self:_DelayRefresh()
end

function UIHomelandShopController:_CheckGuide()
  GameGlobal.EventDispatcher():Dispatch(GameEventType.GuideOpenUI, GuideOpenUI.UIHomelandShopController)
end

function UIHomelandShopController:GetOrderTagBtn()
  return self._tabBtns[2]:GetGameObject("OffBtn")
end

function UIHomelandShopController:GetOrderSubmitBtn()
  return self._firstSubmitBtnObj
end

function UIHomelandShopController:GetShopTagBtn()
  return self._tabBtns[1]:GetGameObject("OffBtn")
end

function UIHomelandShopController:GetShopBuyBtn()
  return self._firstBuyBtnObj
end
