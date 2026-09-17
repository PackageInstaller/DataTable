local page = class("pageSpecialShop", G_UIPageBase)
local _goodsTpl = L_GameTpl:getGoodsTpl()
local _shopGroupTpl = L_GameTpl:getShopGroupTpl()
local _shopTpl = L_GameTpl:getShopTpl()

function page:ctor(...)
  page.super.ctor(self, ...)
  self.data = {
    canRefreshBuyTimes = false,
    goodsList = {},
    curShopId = nil,
    shopRefreshTimer = nil,
    shopGroupId = nil
  }
end

function page.bind()
  return {
    module_tabList = {
      moduleName = "pages/specialShop/moduleSpecialShopTabList"
    },
    scrollList_goods = {
      moduleName = "modulePages/cellGoodSpecialItem"
    },
    module_currency = {
      moduleName = "modulePages/moduleCurrency"
    }
  }
end

function page.methods()
  return {
    onClick_Close = function(self)
      L_UI:close(self.pageName)
    end
  }
end

function page:check(options, callback)
  if AzurWorld.FunctionModuleForbidMgr:CheckIsFunctionModuleForbid(C_EForbidModuleType.MoneyShop, true) then
    callback(false)
    return
  end
  local result = C_IntegrateMgr.SystemUnlockModule:CheckAndTip(L_SystemConst.enum.specialShop)
  callback(result)
end

function page:preOpen(options)
  page.super.preOpen(self, options)
  if not options or not options.shopId then
    self.data.shopGroupId = 9999
  else
    self.data.shopGroupId = tonumber(options.shopId)
  end
  self.selSelTabIndex = 1
  self.ShopIDList = _shopGroupTpl:getShopList(_shopGroupTpl:getTplById(self.data.shopGroupId))
  if self.data.curShopId == nil then
    self.data.curShopId = self.ShopIDList[self.selSelTabIndex]
  end
  self.data.canRefreshBuyTimes = false
  self.tabList = {
    {
      index = 1,
      comTabID = _shopTpl:getTabId(_shopTpl:getTplById(self.ShopIDList[1])),
      txt_eng = "AZUR PROMILIA"
    },
    {
      index = 2,
      comTabID = _shopTpl:getTabId(_shopTpl:getTplById(self.ShopIDList[2])),
      txt_eng = "AZUR PROMILIA"
    }
  }
  self:reqShopData()
  self:initCurrencyList()
  self.modules.module_tabList:setData(self.tabList, function(tabId)
    print("========================tabID", tabId)
    self.selSelTabIndex = tabId
    self.data.curShopId = self.ShopIDList[self.selSelTabIndex]
    self:reqShopData()
  end, self.selSelTabIndex)
  C_BattleUIManager.GMSetUIShowState(false)
  L_ShopStore:listenCallFunc(L_ShopStore.event.refreshStock, self.onEvent_refreshStock, self)
  L_GameStore:listenCallFunc(L_GameStore.event.refreshDayChange, self.onEvent_refreshDayChange, self)
end

function page:reqShopData()
  local endTime = L_ShopManager:getShopTplEndTime(self.data.curShopId)
  if endTime and endTime < L_TimeUtil.getServerTime() then
    L_FlyMsgManager:showNormalMsg(L_WordsTpl:getValue("ui_pageshop_shoprefreshed"))
    L_UI:close(self.pageName)
    return
  end
  L_ShopStore:req_listShopItems(self.data.curShopId, function()
    self:initShopList()
  end)
end

function page:close(options)
  page.super.close(self, options)
  L_ShopStore:unListenCallFunc(L_ShopStore.event.refreshStock, self.onEvent_refreshStock)
  L_GameStore:unListenCallFunc(L_GameStore.event.refreshDayChange, self.onEvent_refreshDayChange)
  self:closeShopRefreshTimer()
  C_BattleUIManager.GMSetUIShowState(true)
end

function page:initShopList()
  print("=================================self.data.curShopId", self.data.curShopId)
  local sortList = L_ShopStore:getGoodsList(self.data.curShopId)
  self.data.curShopId = self.ShopIDList[self.selSelTabIndex]
  self.data.goodsList = {}
  
  local function onClick_select(cell)
    local option = CS.Lens.Gameplay.UI.ShopBuyTipOptions.Get()
    option.goodsId = cell.bind.goodsId
    option.slotId = cell.bind.slotId
    option.curShopId = cell.bind.curShopId
    option.soldOutMask = cell.bind.soldOutMask
    option.lockActive = cell.bind.lockActive
    option.stockNum = cell.bind.stockNum
    option.deadTime = cell.bind.deadTime
    C_UIMgr.Open("pageSpecialShopBuyTip", option)
  end
  
  self.data.goodsList = {}
  for _, v in pairs(sortList) do
    local tpl = _goodsTpl:getTplById(v.goodsId)
    if not tpl then
      errorf("tpl is nil, goodsId: " .. tostring(v.goodsId))
    else
      local condition = L_ConditionManager:isComplete(_goodsTpl:getCommonCondition(tpl))
      local order = _goodsTpl:getOrder(tpl)
      local stockNum = L_ShopStore:getStock(self.data.curShopId, v.slotId)
      local itemType = _goodsTpl:getItem(tpl)[1][1]
      table.insert(self.data.goodsList, {
        goodsId = v.goodsId,
        slotId = v.slotId,
        curShopId = self.data.curShopId,
        txt_name = _goodsTpl:getGoodsName(tpl),
        soldOutMask = stockNum <= 0 and L_ShopStore:getIsLimitGoods(self.data.curShopId, v.slotId),
        goodsData = v,
        lockActive = not condition,
        stockNum = stockNum,
        deadTime = v.deadTime,
        order = order,
        callBack = onClick_select
      })
    end
  end
  self:sortList()
  self.bind.scrollList_goods:clear()
  self.bind.scrollList_goods:insert_array(self.data.goodsList)
  self.data.canRefreshBuyTimes = true
  self:startShopRefreshTimer()
end

function page:sortList()
  for _, good in ipairs(self.data.goodsList) do
    good.weight = 0
    if good.lockActive then
      good.weight = 10000 + good.weight
    end
    if good.stockNum == 0 then
      good.weight = 100000 + good.weight
    end
  end
  
  local function compareFunc(a, b)
    if a.weight == b.weight then
      if a.order == b.order then
        return a.goodsId < b.goodsId
      end
      return a.order > b.order
    end
    return a.weight < b.weight
  end
  
  table.sort(self.data.goodsList, compareFunc)
end

function page:initCurrencyList()
  local tpl_sys = L_GameTpl:getSystemUnlockTpl():getTplById(L_SystemConst.enum.specialShop)
  self.modules.module_currency:refreshRes(tpl_sys)
end

function page:onEvent_refreshStock(entity)
  if not entity then
    return
  end
  for _, v in ipairs(self.data.goodsList) do
    if v.slotId == entity.slotId then
      local stockNum = L_ShopStore:getStock(self.data.curShopId, entity.slotId)
      local tpl = _goodsTpl:getTplById(v.goodsId)
      v.stockNum = stockNum
      v.deadTime = entity.deadTime
      local condition = L_ConditionManager:isComplete(_goodsTpl:getCommonCondition(tpl))
      v.lockActive = not condition
      v.soldOutMask = stockNum <= 0 and L_ShopStore:getIsLimitGoods(self.data.curShopId, v.slotId)
    end
  end
  for i = 1, #self.bind.scrollList_goods do
    self.bind.scrollList_goods:change(i, self.data.goodsList[i])
  end
end

function page:onEvent_refreshDayChange()
  Timer.once(1.5, function()
    self.data.canRefreshBuyTimes = false
    L_ShopStore:req_listShopItems(self.data.curShopId, function(errorCode)
      self:initShopList()
      if errorCode == L_Const.errorCode.ErrCodeSucc then
        L_FlyMsgManager:showNormalMsg(L_WordsTpl:getValue("ui_pageshop_shoprefreshed"))
      end
    end)
  end, self, self.gameObject)
end

function page:startShopRefreshTimer()
  if self.data.shopRefreshTimer then
    self:closeShopRefreshTimer()
  end
  local endTime = L_ShopManager:getShopTplEndTime(self.data.curShopId)
  if endTime and endTime < L_TimeUtil.getServerTime() then
    L_FlyMsgManager:showNormalMsg(L_WordsTpl:getValue("ui_pageshop_shoprefreshed"))
    L_UI:close(self.pageName)
    return
  end
  local frequency = 1
  local shopId = self.data.curShopId
  
  local function _run()
    local tempEndTime = L_ShopManager:getShopTplEndTime(shopId)
    L_TimeUtil.getLeftTimeString(tempEndTime)
    if tempEndTime and tempEndTime < L_TimeUtil.getServerTime() and self.data.canRefreshBuyTimes then
      self.data.canRefreshBuyTimes = false
      L_FlyMsgManager:showNormalMsg(L_WordsTpl:getValue("ui_pageshop_shoprefreshed"))
      L_UI:close(self.pageName)
    end
  end
  
  if endTime and endTime >= L_TimeUtil.getServerTime() then
    self.data.shopRefreshTimer = Timer.repeated(frequency, _run)
  end
end

function page:closeShopRefreshTimer()
  if not self.data.shopRefreshTimer then
    return
  end
  self.data.shopRefreshTimer:destroy()
  self.data.shopRefreshTimer = nil
end

return page
