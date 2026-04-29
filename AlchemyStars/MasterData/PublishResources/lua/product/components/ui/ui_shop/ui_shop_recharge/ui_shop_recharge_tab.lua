_class("UIShopRechargeTab", UICustomWidget)
UIShopRechargeTab = UIShopRechargeTab

function UIShopRechargeTab:Constructor()
  self.shopModule = self:GetModule(ShopModule)
  self.clientShop = self.shopModule:GetClientShop()
  self._data = self.clientShop:GetRechargeShopData()
  self._giftData = self.clientShop:GetGiftPackShopData()
end

function UIShopRechargeTab:OnShow()
  self:AttachEvent(GameEventType.UpdateRechargeShop, self.Flush)
  self:AttachEvent(GameEventType.UpdateGiftPackShop, self.Flush)
  self:AttachEvent(GameEventType.AppResume, self._RequestGetBalanceNormal)
  self._content = self:GetUIComponent("UISelectObjectPath", "Content")
  self._anim = self:GetUIComponent("Animation", "UIShopRechargeTab")
  self:Flush()
end

function UIShopRechargeTab:OnHide()
  self:DetachEvent(GameEventType.UpdateRechargeShop, self.Flush)
  self:DetachEvent(GameEventType.UpdateGiftPackShop, self.Flush)
  self:DetachEvent(GameEventType.AppResume, self._RequestGetBalanceNormal)
end

function UIShopRechargeTab:Flush()
  local items = self._data:GetGoods()
  local giftItems = self._giftData:GetRechargeGiftGoods()
  local monthCard
  local count = table.count(items) + table.count(giftItems)
  if monthCard then
    count = count + 1
  end
  self._content:SpawnObjects("UIShopRechargeItem", count)
  local uiItems = self._content:GetAllSpawnList()
  local cfg = Cfg.cfg_shop_recharge_sort({})
  local allDatas = {}
  for key, value in pairs(cfg) do
    local t = {}
    t.sort = value.Sort
    if key == UIShopRechargeSortType.Gift then
      t.type = UIShopRechargeSortType.Gift
      t.data = giftItems
      t.count = table.count(giftItems)
    elseif key == UIShopRechargeSortType.MonthCard then
      t.type = UIShopRechargeSortType.MonthCard
      t.data = monthCard
      t.count = 1
    elseif key == UIShopRechargeSortType.Recharge then
      t.type = UIShopRechargeSortType.Recharge
      t.data = items
      t.count = table.count(items)
    end
    table.insert(allDatas, t)
  end
  table.sort(allDatas, function(a, b)
    return a.sort < b.sort
  end)
  local index = 0
  for _, value in ipairs(allDatas) do
    if value.type == UIShopRechargeSortType.Gift then
      for _, data in ipairs(value.data) do
        index = index + 1
        uiItems[index]:Flush(data:GetId(), false, true)
      end
    elseif value.type == UIShopRechargeSortType.MonthCard then
      if value.data then
        index = index + 1
        uiItems[index]:Flush(value.data:GetId(), true)
        self._monthCardWidget = uiItems[index]
      end
    elseif value.type == UIShopRechargeSortType.Recharge then
      for _, data in ipairs(value.data) do
        index = index + 1
        uiItems[index]:Flush(data:GetId())
      end
    end
  end
  self:InAnimation()
end

function UIShopRechargeTab:Update(deltaTimeMS)
end

function UIShopRechargeTab:SetData(param)
  GameGlobal.EventDispatcher():Dispatch(GameEventType.ShopTabChange, ShopMainTabType.Recharge)
  self._param = param
  self:JumpItem()
end

function UIShopRechargeTab:RefreshPanel(subTabType)
end

function UIShopRechargeTab:ExcuteHideLogic(callBack)
  if callBack then
    callBack(self)
  end
end

function UIShopRechargeTab:JumpItem()
  if self._param then
    local jumpId = self._param[4] or 0
    if jumpId then
      local monthCard = self._data:GetMonthCardGoods()
      if monthCard and monthCard:GetId() == jumpId then
        self._monthCardWidget:OpenUIShopGiftPackDetail(self._param[2] or ShopMainTabType.Recharge)
      end
    end
  end
end

function UIShopRechargeTab:_RequestGetBalanceNormal()
  local controller = self.uiOwner
  if controller and controller.curMainTabType and controller.curMainTabType == ShopMainTabType.Recharge then
    GameGlobal.GetModule(PayModule):RequestGetBalanceNormal()
  end
end

function UIShopRechargeTab:InAnimation()
  local uiItems = self._content:GetAllSpawnList()
  for k, v in pairs(uiItems) do
    v:GetGameObject():SetActive(false)
  end
  self:StartSafeTask("UIShopRechargeTab::InAnimation", function(lockName, TT)
    local animLength = 0
    for k, v in pairs(uiItems) do
      v:GetGameObject():SetActive(true)
      animLength = math.max(animLength, v:PlayInAnimation())
      if k % 2 == 0 then
        YIELD(TT)
        YIELD(TT)
      end
    end
    if 0 < animLength then
      YIELD(TT, animLength)
    end
  end)
end

function UIShopRechargeTab:ShowSelf()
  self._anim:Stop()
  self._anim:Play()
end

function UIShopRechargeTab:HideSelf()
end
