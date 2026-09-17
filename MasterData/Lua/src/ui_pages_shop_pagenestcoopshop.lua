local page = class("pageNestcoopShop", G_UIPageBase)
local _heroTpl = L_GameTpl:getHeroTpl()
local _goodsTpl = L_GameTpl:getGoodsTpl()
local _shopTpl = L_GameTpl:getShopTpl()
local SHOPID = 801

function page:ctor(...)
  page.super.ctor(self, ...)
  self.isClose = false
  self.data = {
    canRefreshBuyTimes = false,
    npcVirtualCamera = nil,
    resetCam = nil,
    goodsList = {},
    curShopId = nil,
    shopRefreshTimer = nil,
    selectType = nil,
    shopGroupId = nil,
    shopList = nil,
    shopTabData = {},
    selectType = nil,
    checkTypeFunc = nil,
    chooseSlotId = nil
  }
end

function page.bind()
  return {
    txt_refreshTime = "",
    go_numInfo = false,
    go_moneyInfo = false,
    anim_moneyInfo = "",
    moduleMenuActive = true,
    refreshTimeActive = true,
    go_normalGoodsList = false,
    go_funituregoodsList = false,
    scrollList_goods = {
      moduleName = "modulePages/cellGoodsItem"
    },
    scrollList_furniture = {
      moduleName = "modulePages/cellFurnitureGroup"
    },
    module_currency = {
      moduleName = "modulePages/moduleCurrency"
    },
    module_tabList = L_Const.ModuleInfo.CommonTabList,
    costList = {
      moduleName = "pages/shop/cellCostItem"
    },
    moduleBuyGoodsInfo = {
      moduleName = "modulePages/moduleBuyGoodsInfo"
    },
    shopGroupName = "",
    shopGroupIcon = "",
    show_endTime = false,
    go_show = false,
    go_black = true,
    anim_playAnimation = ""
  }
end

function page.methods()
  return {
    scrollList_goods = {
      onClick = function(self, slotId, cost)
        if self.data.chooseSlotId == slotId then
          return
        end
        self.bind.go_moneyInfo = true
        self.bind.go_numInfo = true
        for i = 1, #self.bind.scrollList_goods do
          if self.bind.scrollList_goods:getValue(i, "slotId") == slotId then
            self.modules.moduleBuyGoodsInfo:playShowAnim()
            self.bind.anim_moneyInfo = "anim_shop_moneyinfo_show"
          elseif self.bind.scrollList_goods:getValue(i, "lockActive") == true or self.bind.scrollList_goods:getValue(i, "soldOutMask") == true then
            self.modules.scrollList_goods[i]:refreshSel(false)
          end
        end
        self.data.chooseSlotId = slotId
        if self.bind.go_numInfo then
          self:refreshCurSelGoodsPurchaseInfo(slotId)
        end
      end,
      onClickReduce = function(self, slotId)
        self:moduleBuyGoodsInfoCallback(slotId, 0, {})
        self.bind.go_numInfo = false
        self.data.chooseSlotId = -1
      end
    },
    onClick_Close = function(self)
      self.bindComponents.Volume.gameObject:SetActive(false)
      self:closeFunc()
    end,
    onClick_Buy = function(self)
      self:IntoPurchaseProcess()
    end,
    onAnimeCpt = function(self)
      if self.bind.anim_playAnimation == "anim_NestcoopShop_hide" then
        self.bind.go_show = false
      end
    end
  }
end

function page:preOpen(options)
  page.super.preOpen(self, options)
  self.data.shopGroupId = SHOPID
  self.shopEntityHandle = nil
  self.selGoodsMap = {}
  self.ItemSumMap = {}
  L_ShopStore:listenCallFunc(L_ShopStore.event.refreshStock, self.onEvent_refreshStock, self)
  L_GameStore:listenCallFunc(L_GameStore.event.refreshDayChange, self.onEvent_refreshDayChange, self)
  self:initShopTab()
  local shopGroupTpl = L_GameTpl:getShopGroupTpl()
  if self.data.curShopId == nil then
    self.data.curShopId = shopGroupTpl:getShopList(shopGroupTpl:getTplById(self.data.shopGroupId))[1]
  end
  self.bind.shopGroupName = shopGroupTpl:getShopGroupName(shopGroupTpl:getTplById(self.data.shopGroupId))
  self.bind.shopGroupIcon = shopGroupTpl:getNpcShopIcon(shopGroupTpl:getTplById(self.data.shopGroupId))
  self.data.canRefreshBuyTimes = false
  local data = {
    name = _shopTpl:getShopName(_shopTpl:getTplById(self.data.curShopId)),
    helpBtnBool = true,
    closeCurPage = function()
      L_UI:close(self.pageName)
    end,
    helpBtn = function()
    end,
    mainBtn = function()
      L_UI:backToRoot()
    end
  }
  self.firstInit = false
  self:refreshShop()
  self:initHeroTimeline(true)
  self.isEntrustShop = true
end

function page:show()
  if self.firstInit == true then
    self:initShopList()
  end
  if self.firstInit == false then
    self.firstInit = true
  end
end

function page:refreshShop()
  local endTime = L_ShopManager:getShopTplEndTime(self.data.curShopId)
  if endTime and endTime < L_TimeUtil.getServerTime() then
    L_UI:close(self.pageName)
    return
  end
  print("======================curshopid", self.data.curShopId)
  L_ShopStore:req_listShopItems(self.data.curShopId, function()
    self:initPage()
  end)
end

function page:initShopTab()
  if not self.data.shopGroupId then
    return
  end
  local shopGroupTpl = L_GameTpl:getShopGroupTpl()
  local shopTpl = L_GameTpl:getShopTpl()
  self.data.shopList = shopGroupTpl:getShopList(shopGroupTpl:getTplById(self.data.shopGroupId))
  self.bind.moduleMenuActive = self.data.shopList and #self.data.shopList > 1
  if #self.data.shopList > 0 then
    self.data.shopTabData = {}
    for _, shopId in ipairs(self.data.shopList) do
      local endTime = L_ShopManager:getShopTplEndTime(shopId)
      if math.isEmpty(endTime) or endTime > L_TimeUtil.getServerTime() then
        local tpl = shopTpl:getTplById(shopId)
        local icon = shopTpl:getIcon(tpl)
        local name = shopTpl:getShopName(tpl)
        table.insert(self.data.shopTabData, {
          type = shopId,
          name = name,
          icon = icon,
          order = shopTpl:getOrder(tpl),
          tab = shopTpl:getTabId(tpl)
        })
      end
    end
  end
  table.sort(self.data.shopTabData, function(a, b)
    return a.order == b.order and a.type < b.type or a.order < b.order
  end)
  if self.data.shopTabData[1] ~= nil then
    self.data.curShopId = self.data.shopTabData[1].type
  end
  self:initModule(self.data.shopTabData, self.data.curShopId, function(shopId)
    if self.data.curShopId == shopId then
      return
    end
    self:clearSelRelatedState()
    self.data.curShopId = shopId
    self:refreshShop()
  end)
end

function page:close(options)
  page.super.close(self, options)
  L_ShopStore:unListenCallFunc(L_ShopStore.event.refreshStock, self.onEvent_refreshStock)
  L_GameStore:unListenCallFunc(L_GameStore.event.refreshDayChange, self.onEvent_refreshDayChange)
  self:closeRefreshShop()
  L_TimerManager:clearTimer(self)
  if self.npcLight then
    self.npcLight:Release()
  end
  if self.timelineControl then
    self.timelineControl:dispose()
  end
  if not self.isClose then
    C_AzurTimelineMgr.DisposeTimelineControl()
  end
  C_UISceneManager.SetSceneVisible()
end

function page:initPage()
  self.bind.go_numInfo = false
  self.bind.go_moneyInfo = false
  self.data.selectType = 0
  self.bCheckInDorm = false
  self:initMultiDungeonCurrencyList()
  self:initShopList()
end

function page:initShopList()
  self.bind.go_normalGoodsList = true
  self.bind.go_funituregoodsList = false
  self:initNormGoodsList()
end

function page:initNormGoodsList()
  local List = L_ShopStore:getGoodsList(self.data.curShopId)
  self.data.goodsList = {}
  for _, v in pairs(List) do
    local goodsId = v.goodsId
    local tpl = _goodsTpl:getTplById(goodsId)
    local unlock = true
    local conditions = _goodsTpl:getCommonCondition(tpl)
    local unlockParams = _goodsTpl:getUnlockParams(tpl)
    for k, condition in ipairs(conditions) do
      local target = unlockParams[k]
      local current = 0
      if v.unlockProgress and v.unlockProgress[k] ~= nil then
        current = v.unlockProgress[k]
      end
      if target > current then
        unlock = false
        break
      end
    end
    local itemType = _goodsTpl:getItem(tpl)[1][1]
    local itemId = _goodsTpl:getItem(tpl)[1][2]
    local item = L_ItemTplManager:getItemConfig(itemType, itemId)
    local order = _goodsTpl:getOrder(tpl)
    local stockNum = L_ShopStore:getStock(self.data.curShopId, v.slotId)
    local stockText = L_Lang:get(_goodsTpl:getLimitTxt(tpl), {
      [0] = stockNum
    })
    table.insert(self.data.goodsList, {
      itemType = L_Const.resType.goods,
      itemId = goodsId,
      parseData = item,
      slotId = v.slotId,
      choice = not math.isEmpty(self.data.chooseSlotId) and self.data.chooseSlotId == v.slotId,
      curShopId = self.data.curShopId,
      txt_name = _goodsTpl:getGoodsName(tpl),
      go_new = false,
      stockText = stockText,
      stock_box = L_ShopStore:getIsLimitGoods(self.data.curShopId, v.slotId),
      soldOutMask = stockNum <= 0 and L_ShopStore:getIsLimitGoods(self.data.curShopId, v.slotId),
      goodsData = v,
      lockActive = not unlock,
      stockNum = stockNum,
      deadTime = v.deadTime,
      order = order,
      bFurniture = false,
      unlockProgress = v.unlockProgress
    })
  end
  self:sortNormalGoodsList()
  self.bind.scrollList_goods:clear()
  self.bind.scrollList_goods:insert_array(self.data.goodsList)
  C_AudioManager.Play("Play_SFX_System_UI_NPCShop_Item_Appear")
  self.data.canRefreshBuyTimes = true
  self:closeRefreshShop()
  self:openRefreshShop()
end

function page:sortNormalGoodsList()
  for _, good in ipairs(self.data.goodsList) do
    good.weight = good.order
    if good.lockActive then
      good.weight = 10000000 + good.weight
    end
    if good.stockNum == 0 then
      good.weight = 100000000 + good.weight
    end
  end
  
  local function compareFunc(a, b)
    if a.weight == b.weight then
      return a.itemId < b.itemId
    end
    return a.weight < b.weight
  end
  
  table.sort(self.data.goodsList, compareFunc)
end

function page:initCurrencyList()
  local tpl_sys = L_GameTpl:getSystemUnlockTpl():getTplByTab(L_SystemConst.enum.shop, self.data.curShopId)
  self.modules.module_currency:refreshRes(tpl_sys)
end

function page:initMultiDungeonCurrencyList()
  local currencyList = L_GameTpl:getGameConstTpl():getNestShopCurrencyBar()
  self.modules.module_currency:refreshResByResBarTplIdList(currencyList)
end

function page:onEvent_refreshStock(entity)
  if not entity then
    return
  end
  self:updateNormalGoodsData(entity)
end

function page:updateNormalGoodsData(entity)
  local needUpdate = false
  for _, v in pairs(self.data.goodsList) do
    if v.slotId == entity.slotId then
      local stockNum = L_ShopStore:getStock(self.data.curShopId, v.slotId)
      if stockNum <= 0 then
        v.go_soldOut = true
        v.deadTime = entity.deadTime
        needUpdate = true
      else
        v.go_soldOut = false
      end
      v.unlockProgres = entity.unlockProgres
      local tpl = _goodsTpl:getTplById(v.itemId)
      local stockText = L_Lang:get(_goodsTpl:getLimitTxt(tpl), {
        [0] = stockNum
      })
      v.stockNum = stockNum
      v.stockText = stockText
      local unlock = true
      local conditions = _goodsTpl:getCommonCondition(tpl)
      local unlockParams = _goodsTpl:getUnlockParams(tpl)
      for k, condition in ipairs(conditions) do
        local target = unlockParams[k]
        local current = 0
        if v.unlockProgress and v.unlockProgress[k] ~= nil then
          current = v.unlockProgress[k]
        end
        if target > current then
          unlock = false
          break
        end
      end
      if v.lockActive and unlock then
        needUpdate = true
      end
      v.lockActive = not unlock
      v.soldOutMask = stockNum <= 0 and L_ShopStore:getIsLimitGoods(self.data.curShopId, v.slotId)
      break
    end
  end
  if needUpdate then
    self.bind.go_numInfo = false
    self.bind.go_moneyInfo = false
    self.data.chooseSlotId = nil
    self:sortNormalGoodsList()
    self.bind.scrollList_goods:clear()
    self.bind.scrollList_goods:insert_array(self.data.goodsList)
  end
end

function page:onEvent_refreshDayChange()
  Timer.once(1.5, function()
    self.data.canRefreshBuyTimes = false
    local oldGoodsList = self.data.goodsList
    L_ShopStore:req_listShopItems(self.data.curShopId, function(errorCode)
      self:initShopList()
      local newGoodsList = self.data.goodsList
      local bDiff = self:isDiff(oldGoodsList, newGoodsList)
      if errorCode == L_Const.errorCode.ErrCodeSucc then
        if bDiff then
          L_FlyMsgManager:showNormalMsg(L_WordsTpl:getValue("ui_pageshop_shoprefreshed"))
        end
        self.bind.purchase = false
      end
    end)
  end, self, self.gameObject)
end

function page:openRefreshShop()
  if self.data.shopRefreshTimer then
    self:closeRefreshShop()
  end
  local endTime = L_ShopManager:getShopTplEndTime(self.data.curShopId)
  self.bind.refreshTimeActive = not math.isEmpty(endTime)
  self.bind.show_endTime = true
  if string.isEmpty(endTime) then
    self.bind.show_endTime = false
    return
  end
  if endTime and endTime < L_TimeUtil.getServerTime() then
    L_UI:close(self.pageName)
    return
  end
  local frequency = 1
  local shopId = self.data.curShopId
  
  local function _run()
    local tempEndTime = L_ShopManager:getShopTplEndTime(shopId)
    self.bind.txt_refreshTime = L_WordsTpl:getValue("ui_pageshop_shoprefresh_time") .. L_TimeUtil.getLeftTimeString(tempEndTime)
    print("商店：运行每日刷新" .. self.bind.txt_refreshTime)
    if tempEndTime and tempEndTime < L_TimeUtil.getServerTime() and self.data.canRefreshBuyTimes then
      self.data.canRefreshBuyTimes = false
      L_FlyMsgManager:showNormalMsg(L_WordsTpl:getValue("ui_pageshop_shoprefreshed"))
      L_UI:close(self.pageName)
    end
  end
  
  self.bind.txt_refreshTime = L_WordsTpl:getValue("ui_pageshop_shoprefresh_time") .. L_TimeUtil.getLeftTimeString(endTime)
  if endTime and endTime >= L_TimeUtil.getServerTime() then
    self.data.shopRefreshTimer = Timer.repeated(frequency, _run)
  end
end

function page:closeRefreshShop()
  if self.data.shopRefreshTimer == nil then
    return
  end
  self.data.shopRefreshTimer:destroy()
  self.data.shopRefreshTimer = nil
end

function page:moduleBuyGoodsInfoCallback(slotId, buyNum)
  if buyNum <= 0 then
    if self.selGoodsMap[slotId] ~= nil then
      self.selGoodsMap[slotId] = nil
    end
  else
    for key, v in pairs(self.data.goodsList) do
      if v.slotId == slotId and v.lockActive == false and v.soldOutMask == false then
        self.selGoodsMap[slotId] = {
          buyNum = buyNum,
          costData = self:calculateSingleItemCostData(slotId, buyNum)
        }
        self.modules.scrollList_goods[key]:refreshBuyNum(buyNum)
      end
    end
  end
  if self.selGoodsMap == nil or next(self.selGoodsMap) == nil then
    self.bind.go_moneyInfo = false
  end
  table.clear(self.ItemSumMap)
  self.ItemSumMap = self:calculateMoneyCost()
  self.allCostDataList = {}
  for id, item in pairs(self.ItemSumMap) do
    table.insert(self.allCostDataList, {
      itemType = item.itemType,
      itemId = id,
      itemNumTxt = tostring(math.floor(item.itemNumTxt)),
      icon = item.icon
    })
  end
  self.bind.costList:clear()
  self.bind.costList:insert_array(self.allCostDataList)
end

function page:calculateMoneyCost(exceptGoodsId)
  local money = {}
  for key, value in pairs(self.selGoodsMap) do
    if exceptGoodsId == nil or exceptGoodsId ~= key then
      for _, cost in ipairs(value.costData) do
        if money[cost.itemId] == nil then
          money[cost.itemId] = {}
          money[cost.itemId].itemNumTxt = 0
        end
        money[cost.itemId].itemNumTxt = money[cost.itemId].itemNumTxt + tonumber(cost.itemNumTxt)
        money[cost.itemId].itemType = cost.itemType
        money[cost.itemId].icon = cost.icon
      end
    end
  end
  return money
end

function page:calculateSingleItemCostData(slotId, num)
  local costData = {}
  local goodsItem = L_ShopStore:getGoodsItem(self.data.curShopId, slotId)
  local tpl = _goodsTpl:getTplById(goodsItem.goodsId)
  local conditions = _goodsTpl:getCommonCondition(tpl)
  local unlockParams = _goodsTpl:getUnlockParams(tpl)
  local isUnlock = true
  for k, _ in ipairs(conditions) do
    local target = unlockParams[k]
    local current = 0
    if goodsItem.unlockProgress and goodsItem.unlockProgress[k] ~= nil then
      current = goodsItem.unlockProgress[k]
    end
    if target > current then
      isUnlock = false
      break
    end
  end
  local costIds = _goodsTpl:getCostId(tpl)
  for _, cost in ipairs(costIds) do
    local item = L_ItemTplManager:getItemConfig(cost[1], cost[2])
    local price = cost[3] * num
    local icon = item.icon
    table.insert(costData, {
      itemType = item.itemType,
      itemId = item.itemId,
      itemNumTxt = isUnlock and price or 0,
      icon = icon
    })
  end
  return costData
end

function page:IntoPurchaseProcess()
  for key, value in ipairs(self.allCostDataList) do
    if L_ItemTplManager:getItemNum(value.itemType, value.itemId) < tonumber(L_GameUtil.clearColor(value.itemNumTxt)) then
      L_FlyMsgManager:showNormalMsg(L_WordsTpl:getValue("notice_pageRogueShopPurchase"))
      return
    end
  end
  local res = {}
  for key, v in pairs(self.selGoodsMap) do
    table.insert(res, {
      slot_id = key,
      times = v.buyNum,
      sign = L_ShopStore:getEndTime(self.data.curShopId)
    })
  end
  L_ShopManager:buyGoods({items = res})
  for key, v in pairs(self.data.goodsList) do
    self.modules.scrollList_goods[key]:refreshSel(false)
  end
  self:clearSelRelatedState()
end

function page:refreshCurSelGoodsPurchaseInfo(slotId)
  local defalutNum = 1
  if self.selGoodsMap[slotId] then
    defalutNum = self.selGoodsMap[slotId].buyNum
  end
  local goodsItem = L_ShopStore:getGoodsItem(self.data.curShopId, slotId)
  local otherGoodsCost = self:calculateMoneyCost(goodsItem.slotId)
  local options = {
    slotId = slotId,
    shopId = self.data.curShopId,
    otherGoodsCost = otherGoodsCost,
    defalutNum = defalutNum
  }
  self.modules.moduleBuyGoodsInfo:refresh(options, function(slotId, buyNum, costData)
    self:moduleBuyGoodsInfoCallback(slotId, buyNum, costData)
  end)
end

function page:clearSelRelatedState()
  self.selGoodsMap = {}
  self.allCostDataList = {}
  self.data.chooseSlotId = nil
  self.bind.go_numInfo = false
  self.bind.go_moneyInfo = false
end

function page:SendPageShopShowEvent(bShow)
  local entity = C_EntityManager.GetEntity(self.data.entityId)
  if not entity then
    return
  end
end

function page:initModule(typeList, defaultSelectType, func)
  self.data.checkTypeFunc = func
  self.data.selectType = defaultSelectType
  self:initTypeList(typeList)
end

function page:initTypeList(typeList)
  if #typeList <= 1 then
    return
  end
  local tabList = {}
  local selectId = 1
  for i, v in ipairs(typeList) do
    if self.data.selectType == v.type then
      selectId = i
    end
    if v.tab == 0 then
      errorf("商店没配tab! " .. v.type)
    end
    table.insert(tabList, v.tab)
  end
  self.modules.module_tabList:setData(tabList, function(tab)
    for key, value in pairs(self.data.shopTabData) do
      if value.tab == tab then
        self.data.checkTypeFunc(value.type)
        self.data.selectType = value.type
      end
    end
  end, selectId)
end

function page:initHeroTimeline(isFirstInit)
  local nestcoopTpl = L_GameTpl:getNestShopTpl()
  local tpl = nestcoopTpl:getTplByShopGroupId(self.data.curShopId)
  
  local function allLoad()
    C_UIMgr.CloseCutin()
    if not self.isBind then
      return
    end
    if L_UI:getPageStatus(self.pageName) == L_UI.pageStatus.hided or L_UI:getPageStatus(self.pageName) == L_UI.pageStatus.closed then
      C_AzurTimelineMgr.SetAssetsActive(false)
    else
      C_AzurTimelineMgr.SetAssetsActive(true)
    end
    C_UISceneManager.SetSceneVisible()
    self.bind.go_black = false
    self.bind.go_show = true
    self:playOpenAnimation()
    local posData = nestcoopTpl:getShopTimelinePos(tpl)
    local rotData = nestcoopTpl:getShopTimelineRot(tpl)
    local pos = C_Vector3(posData[1], posData[2], posData[3])
    local rot = C_Vector3(rotData[1], rotData[2], rotData[3])
    C_AzurTimelineMgr.SetActorPosAndRot(pos, rot)
  end
  
  local path = L_Config:getPathByHash(nestcoopTpl:getTimelineActor(tpl))
  local scenePath = L_Config:getPathByHash(nestcoopTpl:getShopBackGround(tpl))
  scenePath = L_CommonUtil.getMultiPlatformScenePath(scenePath)
  local state = L_Const.heroTimelineState.Skill
  local excludeState = {
    L_Const.heroTimelineState.Select
  }
  local heroId = nestcoopTpl:getActorId(tpl)
  C_AzurTimelineMgr.AsyncLoadTimelineAssetsListByStateLoader(path, state, excludeState, scenePath, heroId, isFirstInit, function()
  end, function()
    C_AzurTimelineMgr.PlayTimelineStateByStateLoader(state, true, true)
    C_AzurTimelineMgr.PreloadStateByStateLoader(state)
    C_AzurTimelineMgr.PreloadStateOutgoingTransitionsByStateLoader(state)
    allLoad()
  end)
end

function page:mapAreaConfig()
  local runtimeId = AzurWorld.areaManager:GetMapAreaId()
  if runtimeId == 100000 then
    return 1
  elseif runtimeId == 200000 then
    return 2
  else
    return 2
  end
end

function page:escHandle()
  self.bindComponents.Volume.gameObject:SetActive(false)
  self:closeFunc()
end

function page:getSceneLightTime()
  local isNight = false
  local curSenceTime = C_GameTime:GetSceneTimeOfDay()
  curSenceTime = curSenceTime % 2400
  local senceTime = 0
  if 600 < curSenceTime and curSenceTime < 1800 then
    senceTime = 1200
    isNight = false
  else
    senceTime = 0
    isNight = true
  end
  return senceTime, isNight
end

function page:isDiff(a, b)
  a = a or {}
  b = b or {}
  local stockBySlot = {}
  for _, it in ipairs(a) do
    if it and it.slotId ~= nil then
      stockBySlot[it.slotId] = it.stockNum
    end
  end
  for _, it in ipairs(b) do
    if it and it.slotId ~= nil then
      local stockA = stockBySlot[it.slotId]
      if stockA ~= nil and stockA ~= it.stockNum then
        return true
      end
    end
  end
  return false
end

function page:playOpenAnimation()
  self.bind.anim_playAnimation = "anim_NestcoopShop_show"
end

function page:playCloseAnimation()
  self.bind.anim_playAnimation = "anim_NestcoopShop_hide"
end

function page:closeFunc()
  if self.isClose then
    return
  end
  self.isClose = true
  self:playCloseAnimation()
  L_TimerManager:newOrResetTimer(self, "closeTimer", function()
    L_UI:close(self.pageName)
  end, 0.2)
  C_AzurTimelineMgr.DisposeTimelineControl()
end

return page
