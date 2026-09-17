local page = class("pageShop", G_UIPageBase)
local _heroTpl = L_GameTpl:getHeroTpl()
local _goodsTpl = L_GameTpl:getGoodsTpl()
local _shopTpl = L_GameTpl:getShopTpl()
local _itemTpl = L_GameTpl:getCommonItemTpl()
local _homeDropTpl = L_GameTpl:getHomeDropTpl()
local _homeSeedsTpl = L_GameTpl:getHomeSeedsTpl()
local homeDormFurnitureTpl = L_GameTpl:gethomeDormFurnitureTpl()
local _dungeonEntrustAreaTpl = L_GameTpl:getDungeonEntrustAreaTpl()
local C_ETransmitType = CS.Lens.Gameplay.Modules.BigWorld.ETransmitType
local DUNGEONSHOPCURRENCY_RESOURCE_BAR_ITEM_TPL_ID = 413
local C_HomeStore = CS.Lens.Gameplay.UI.Home.HomeStore
local C_ShopStore = CS.Lens.Gameplay.UI.Shop.ShopStore
local _NormalFaceLayerName = "expression"
local _SingleFaceLayerName = "singleExpression"

function page:ctor(...)
  page.super.ctor(self, ...)
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
    batchMode = false
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
    go_DormHero = false,
    toggle_batch_off = true,
    toggle_batch_on = false
  }
end

function page.methods()
  return {
    scrollList_goods = {
      onClick = function(self, slotId, cost)
        if self.selGoodsMap[slotId] then
        end
        self.bind.go_moneyInfo = true
        self.bind.go_numInfo = true
        if self.data.batchMode == false then
          self:clearOtherSelGoods(slotId)
        end
        for i = 1, #self.bind.scrollList_goods do
          if self.bind.scrollList_goods:getValue(i, "slotId") == slotId then
            self.modules.moduleBuyGoodsInfo:playShowAnim()
            self.bind.anim_moneyInfo = "anim_shop_moneyinfo_show"
          elseif self.data.batchMode == false then
            self.modules.scrollList_goods[i]:refreshSel(false)
            self.modules.scrollList_goods[i]:refreshBuyNum(0)
          elseif self.bind.scrollList_goods:getValue(i, "lockActive") == true or self.bind.scrollList_goods:getValue(i, "soldOutMask") == true then
            self.modules.scrollList_goods[i]:refreshSel(false)
          end
        end
        if self.bind.go_numInfo then
          self:refreshCurSelGoodsPurchaseInfo(slotId)
        end
        C_ShopStore.GetStore():ClickNoneMallGiftStaticPoint(slotId)
      end,
      onClickReduce = function(self, slotId)
        self:moduleBuyGoodsInfoCallback(slotId, 0, {})
        for i = 1, #self.bind.scrollList_goods do
          if self.bind.scrollList_goods:getValue(i, "slotId") ~= slotId and (self.bind.scrollList_goods:getValue(i, "lockActive") == true or self.bind.scrollList_goods:getValue(i, "soldOutMask") == true) then
            self.modules.scrollList_goods[i]:refreshSel(false)
          end
        end
        self.bind.go_numInfo = false
      end
    },
    onClick_Close = function(self)
      self.bindComponents.Volume.gameObject:SetActive(false)
      L_UI:close(self.pageName)
    end,
    onClick_Buy = function(self)
      self:IntoPurchaseProcess()
    end,
    onClick_batch_on = function(self)
      C_HomeStore.GetStore():SaveCustomData("ShopBatchMode", "false")
      self:setBatchMode(false)
    end,
    onClick_batch_off = function(self)
      C_HomeStore.GetStore():SaveCustomData("ShopBatchMode", "true")
      self:setBatchMode(true)
    end
  }
end

function page:preOpen(options)
  page.super.preOpen(self, options)
  if options.isEntrustShop == true then
    self.isEntrustShop = true
    self:initMultiDungeonCurrencyList()
    C_IntegrateMgr.TopBarModule:SetResourceVisible(false)
    self:initHeroTimeline(true)
  end
  self.data.shopGroupId = options.shopId
  self.shopEntityHandle = nil
  if options.entity ~= nil then
    self.data.entityId = options.entity.data.entityId
    self.shopEntityHandle = options.entity
    self.shopEntityHandle:Transmit(C_ETransmitType.DisableNPCLookAtPlayer, nil)
    self.npcLight = C_UINpcLight.CreateLight(options.entity.data.transform.gameObject)
    if self.npcLight and self.npcLight.lightObj then
      self.npcLight.lightObj.transform.rotation = C_Quaternion.Euler(C_Vector3(45, 0, 0))
    end
  end
  self.selGoodsMap = {}
  self.ItemSumMap = {}
  L_ShopStore:listenCallFunc(L_ShopStore.event.refreshStock, self.onEvent_refreshStock, self)
  L_ShopStore:listenCallFunc(L_ShopStore.event.syncShopInfosComplete, self.initShopList, self)
  L_GameStore:listenCallFunc(L_GameStore.event.refreshDayChange, self.onEvent_refreshDayChange, self)
  self:initShopTab()
  local shopGroupTpl = L_GameTpl:getShopGroupTpl()
  if self.data.curShopId == nil then
    self.data.curShopId = shopGroupTpl:getShopList(shopGroupTpl:getTplById(options.shopId))[1]
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
  if self.shopEntityHandle ~= nil then
    self:loadVirtualCamera(self.shopEntityHandle)
    self:checkPlayNPCAni(true, 0.5)
  end
  self.firstInit = false
  self:refreshShop()
  self.data.batchMode = C_HomeStore.GetStore():TryGetCustomData("ShopBatchMode") == "true"
  self:setBatchMode(self.data.batchMode)
  self:sendPageOpenEvent(self.data.shopGroupId)
end

function page:sendPageOpenEvent(shopId)
  L_ShopStore:call(L_ShopStore.event.onOpenShopPage, shopId)
  C_ShopStore.GetStore():EnterNoneMallStaticPoint()
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
    local tpl_shop = _shopTpl:getTplById(self.data.curShopId)
    local resource = _shopTpl:getResourceBar(tpl_shop)
    local tb = L_LuaToCSharpUtil.parseLuaCfgList(resource)
    C_IntegrateMgr.TopBarModule:Lua_SetResourcesByResList(tb)
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
  L_ShopStore:unListenCallFunc(L_ShopStore.event.syncShopInfosComplete, self.initShopList)
  L_GameStore:unListenCallFunc(L_GameStore.event.refreshDayChange, self.onEvent_refreshDayChange)
  self:closeRefreshShop()
  self:clearSoundTimer()
  C_IntegrateMgr.TopBarModule:SetTopBarVisible(false)
  if options.entity ~= nil then
    self:unloadVirtualCamera()
  end
  self:resumeShopNpcLookAtIk()
  if self.isEntrustShop then
    C_AzurTimelineMgr.SetActorScale(C_Vector3.one)
    C_AzurTimelineMgr.DisposeTimelineControl()
    C_UISceneManager.SetSceneActive(true)
  end
  if self.npcLight then
    self.npcLight:Release()
  end
  if self.refreshTimerKey then
    Timer.remove(self.refreshTimerKey)
    self.refreshTimerKey = nil
  end
end

function page:resumeShopNpcLookAtIk()
  if self.shopEntityHandle ~= nil and self.shopEntityHandle:IsValid() then
    self.shopEntityHandle:Transmit(C_ETransmitType.EnableNPCLookAtPlayer, nil)
  end
end

function page:initPage()
  self.bind.go_numInfo = false
  self.bind.go_moneyInfo = false
  self.data.selectType = 0
  self.bCheckInDorm = false
  if self.isEntrustShop then
  else
    self:initCurrencyList()
  end
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
  local needRefreshTime = -1
  for _, v in pairs(List) do
    local goodsId = v.goodsId
    local tpl = _goodsTpl:getTplById(goodsId)
    local canShow = self:checkCanShow(tpl)
    if canShow then
      local unlock, unlockData, refreshTime = self:onCheckLockStatus(tpl, v, self.data.curShopId)
      if needRefreshTime < 0 then
        needRefreshTime = refreshTime
      elseif 0 < refreshTime and (not (refreshTime > needRefreshTime) or not needRefreshTime) then
        needRefreshTime = refreshTime
      end
      local itemType = _goodsTpl:getItem(tpl)[1][1]
      local itemId = _goodsTpl:getItem(tpl)[1][2]
      local item = L_ItemTplManager:getItemConfig(itemType, itemId)
      local exp = page:getHomeCropHarvestExp(itemId)
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
        choice = self.selGoodsMap[v.slotId],
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
        unlockProgress = v.unlockProgress,
        home_exp = exp,
        soulessence_index = 1
      })
    end
  end
  self:checkAndRefreshShopInfo(needRefreshTime)
  self:sortNormalGoodsList()
  self.bind.scrollList_goods:clear()
  self.bind.scrollList_goods:insert_array(self.data.goodsList)
  C_AudioManager.Play("Play_SFX_System_UI_NPCShop_Item_Appear")
  self.data.canRefreshBuyTimes = true
  self:closeRefreshShop()
  self:openRefreshShop()
end

function page:checkCanShow(tpl)
  local canShow = true
  local launchType = _goodsTpl:getLaunchType(tpl)
  if launchType == 1 then
    canShow = true
  else
    local goodsTimelimit = _goodsTpl:getTimelimit(tpl)
    if goodsTimelimit and 0 < goodsTimelimit then
      local startTime = C_CommonTimerMgr.GetStartTime(goodsTimelimit)
      local endTime = C_CommonTimerMgr.GetEndTime(goodsTimelimit)
      local serverTime = L_TimeUtil.getServerTime()
      if startTime and endTime then
        canShow = startTime <= serverTime and endTime >= serverTime
      end
    end
  end
  return canShow
end

function page:onCheckLockStatus(tpl, v, shopId)
  local unlock = true
  local unlockData = {}
  local needRefreshTime = -1
  local conditions = _goodsTpl:getCommonCondition(tpl)
  local unlockParams = _goodsTpl:getUnlockParams(tpl)
  local unlockDesc = _goodsTpl:getUnlockDesc(tpl)
  local shopTpl = _shopTpl:getTplById(shopId)
  if conditions and 0 < #conditions then
    for k, condition in ipairs(conditions) do
      local target = unlockParams[k]
      local current = 0
      if v.unlockProgress and v.unlockProgress[k] ~= nil then
        current = v.unlockProgress[k]
      end
      if target > current then
        unlock = false
        table.insert(unlockData, {
          progressText = string.format("(<color=#EF5743>%s</color>/%s)", current, target),
          unlockTip = L_Lang:get(_goodsTpl:getUnlockDesc(tpl)[k], {
            [0] = target
          })
        })
        break
      end
    end
    if unlock then
      local goodsTimelimit = self:getMaxLimitTime(tpl, shopTpl)
      if goodsTimelimit and 0 < goodsTimelimit then
        local startTime = C_CommonTimerMgr.GetStartTime(goodsTimelimit)
        local endTime = C_CommonTimerMgr.GetEndTime(goodsTimelimit)
        local serverTime = L_TimeUtil.getServerTime()
        if startTime > serverTime then
          unlock = false
          table.insert(unlockData, {
            progressText = "",
            unlockTip = C_TimeUtility.LeftCountdownShow(startTime),
            startTime = startTime
          })
          local offset = startTime - serverTime
          needRefreshTime = offset
        end
      end
    end
  else
    local goodsTimelimit = self:getMaxLimitTime(tpl, shopTpl)
    if goodsTimelimit and 0 < goodsTimelimit then
      local startTime = C_CommonTimerMgr.GetStartTime(goodsTimelimit)
      local endTime = C_CommonTimerMgr.GetEndTime(goodsTimelimit)
      local serverTime = L_TimeUtil.getServerTime()
      if startTime > serverTime then
        unlock = false
        if self:checkUnlockDescValid(unlockDesc) then
          table.insert(unlockData, {
            progressText = "",
            unlockTip = L_Config:provider(unlockDesc[1])
          })
        else
          table.insert(unlockData, {
            progressText = "",
            unlockTip = C_TimeUtility.LeftCountdownShow(startTime),
            startTime = startTime
          })
          local offset = startTime - serverTime
          needRefreshTime = offset
        end
      end
    end
  end
  return unlock, unlockData, needRefreshTime
end

function page:checkAndRefreshShopInfo(needRefreshTime)
  if self.refreshTimerKey then
    Timer.remove(self.refreshTimerKey)
    self.refreshTimerKey = nil
  end
  if 0 < needRefreshTime then
    self.refreshTimerKey = Timer.once(needRefreshTime, self.onEvent_refreshDayChange, self)
  end
end

function page:getMaxLimitTime(goodTpl, shopTpl)
  local goodsTimelimit = goodTpl and _goodsTpl:getTimelimit(goodTpl) or 0
  local shopTimelimit = shopTpl and _shopTpl:getTimelimit(shopTpl) or 0
  local goodStartTime = C_CommonTimerMgr.GetStartTime(goodsTimelimit)
  local shopStartTime = C_CommonTimerMgr.GetStartTime(shopTimelimit)
  return goodStartTime > shopStartTime and goodsTimelimit or shopTimelimit
end

function page:checkUnlockDescValid(unlockDesc)
  return unlockDesc and 0 < #unlockDesc and L_Config:provider(unlockDesc[1]) ~= "-1"
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
  self.modules.module_currency:refreshResByResBarTplIdList({DUNGEONSHOPCURRENCY_RESOURCE_BAR_ITEM_TPL_ID})
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
    if tempEndTime and tempEndTime < L_TimeUtil.getServerTime() and self.data.canRefreshBuyTimes then
      self.data.canRefreshBuyTimes = false
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

function page:clearOtherSelGoods(slotId)
  if self.selGoodsMap ~= nil then
    for key, _ in pairs(self.selGoodsMap) do
      if key ~= slotId then
        self.selGoodsMap[key] = nil
      end
    end
  end
  if self.data.goodsList == nil then
    return
  end
  for key, goods in pairs(self.data.goodsList) do
    if goods.slotId ~= slotId then
      goods.choice = nil
      if self.modules.scrollList_goods[key] ~= nil then
        self.modules.scrollList_goods[key]:refreshSel(false)
        self.modules.scrollList_goods[key]:refreshBuyNum(0)
      end
    end
  end
end

function page:refreshSelGoodsState()
  if self.data.goodsList == nil then
    return
  end
  for key, goods in pairs(self.data.goodsList) do
    local selGoods = self.selGoodsMap[goods.slotId]
    goods.choice = selGoods
    if self.modules.scrollList_goods[key] ~= nil then
      self.modules.scrollList_goods[key]:refreshSel(selGoods ~= nil)
      self.modules.scrollList_goods[key]:refreshBuyNum(selGoods and selGoods.buyNum or 0)
    end
  end
end

function page:moduleBuyGoodsInfoCallback(slotId, buyNum)
  if buyNum <= 0 then
    if self.selGoodsMap[slotId] ~= nil then
      self.selGoodsMap[slotId] = nil
    end
  else
    if self.data.batchMode == false then
      self:clearOtherSelGoods(slotId)
    end
    for key, v in pairs(self.data.goodsList) do
      if v.slotId == slotId and v.lockActive == false and v.soldOutMask == false then
        self.selGoodsMap[slotId] = {
          buyNum = buyNum,
          costData = self:calculateSingleItemCostData(slotId, buyNum),
          home_exp = v.home_exp * buyNum
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
  self:refreshSelGoodsState()
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

function page:calculateExpAdd(exceptGoodsId)
  local exp = 0
  for key, value in pairs(self.selGoodsMap) do
    if exceptGoodsId == nil or exceptGoodsId ~= key then
      exp = exp + value.home_exp
    end
  end
  return exp
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
      L_FlyMsgManager:showNormalMsg(L_WordsTpl:getValue("ui_product_lack_coin"))
      return
    end
  end
  local data = {}
  local res = {}
  for key, v in pairs(self.selGoodsMap) do
    table.insert(res, {
      slot_id = key,
      times = v.buyNum,
      goods_id = key
    })
  end
  data.shop_id = self.data.curShopId
  data.items = res
  data.sign = L_ShopStore:getEndTime(self.data.curShopId)
  L_ShopManager:buyGoods(data)
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
    otherExpAdd = 0,
    defalutNum = defalutNum
  }
  self.modules.moduleBuyGoodsInfo:refresh(options, function(slotId, buyNum, costData)
    self:moduleBuyGoodsInfoCallback(slotId, buyNum, costData)
    local num = buyNum ~= 0 and buyNum or 1
  end)
end

function page:clearSelRelatedState()
  self.selGoodsMap = {}
  self.allCostDataList = {}
  self.bind.go_numInfo = false
  self.bind.go_moneyInfo = false
end

function page:loadVirtualCamera(entityHandle)
  L_ShopStore:setCurOpenShopGroupId(self.data.shopGroupId)
  C_CameraManager.ActivateTactics(C_ECameraType.NpcShop, C_CinemachineBlendType.EaseIn, 1000)
  local cameraController = C_CameraManager.GetTactics(C_ECameraType.NpcShop)
  cameraController:SetNpcShopData(entityHandle.entity:GetTransform(), entityHandle.entity:GetUnitId(), L_ShopStore:getCurOpenShopGroupId())
  L_PlayerManager:showOrHideAllPlayer(false)
  AzurWorld.HUDMgr:SetAllVisible(false, "PageShop")
  AzurWorldInstance:SetNodeVisible(L_Const.WorldNode.PLAYERPETNODE, false, L_Const.worldNodeHideType.LuaUIControlHide)
  self:SendPageShopShowEvent(true)
end

function page:checkPlayNPCAni(isPlaySound, delayTime)
  if self.shopEntityHandle and self.shopEntityHandle.data.spwanerData.id == 700119 then
    delayTime = delayTime or 0.3
    if self.timerKey then
      Timer.remove(self.timerKey)
      self.timerKey = nil
    end
    self.timerKey = Timer.once(delayTime, function()
      self.animator = self.shopEntityHandle.data.animator
      self.faceLayerIdx = self.animator:GetLayerIndex(_SingleFaceLayerName)
      self.normalFaceLayerIdx = self.animator:GetLayerIndex(_NormalFaceLayerName)
      self.animator:Play("story_expect_02_start")
      if isPlaySound then
        Timer.once(0.55, function()
          L_AudioUtil.playSound("Play_VO_System_700119_StoreOpen")
        end)
      end
      self:waitAnimTimeToPlaySound("story_shop_welcome", 0.05, "Play_SFX_Timeline_Interface_HomeStore_700119_Stamp")
    end)
  end
end

function page:waitAnimTimeToPlaySound(stateName, triggerTime, soundKey)
  self:clearSoundTimer()
  local state = self.animator:GetState(stateName)
  if not state then
    return
  end
  self._soundCheckTimer = L_GameTimer.repeated(0, function()
    if not self.animator or not state then
      self:clearSoundTimer()
      return
    end
    local curTime = state.normalizedTime * state.length
    if curTime >= triggerTime then
      L_AudioUtil.playSound(soundKey)
      self:clearSoundTimer()
    end
  end, self)
end

function page:clearSoundTimer()
  if self._soundCheckTimer then
    self._soundCheckTimer:stop()
    Timer.remove(self._soundCheckTimer)
    self._soundCheckTimer = nil
  end
end

function page:playOrStopAni(animName, isPlay)
  if not self.animator then
    return
  end
  if isPlay then
    self.animator:SetLayerWeight(self.faceLayerIdx, 1)
    self.animator:SetLayerWeight(self.normalFaceLayerIdx, 0)
    self.animName = animName
    self.animState = self.animator:GetState(self.animName, self.faceLayerIdx)
    if self.animState then
      self.animator:Play(self.animName, self.faceLayerIdx, 0)
    else
      errorf("角色缺少动画状态机缺少动画 " .. self.animName)
    end
  else
    self.animator:SetLayerWeight(self.faceLayerIdx, 0)
    self.animator:SetLayerWeight(self.normalFaceLayerIdx, 1)
  end
end

function page:unloadVirtualCamera()
  L_ShopStore:setCurOpenShopGroupId(-1)
  L_PlayerManager:showOrHideAllPlayer(true)
  C_CameraManager.PlaySetBlend(C_CinemachineBlendType.Custom, 1000)
  C_CameraManager.DeactivateTactics(C_ECameraType.NpcShop)
  AzurWorld.HUDMgr:SetAllVisible(true, "PageShop")
  AzurWorldInstance:SetNodeVisible(L_Const.WorldNode.PLAYERPETNODE, true, L_Const.worldNodeHideType.LuaUIControlHide)
  self:SendPageShopShowEvent(false)
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
  local areaId = self:mapAreaConfig()
  self.areaTpl = _dungeonEntrustAreaTpl:getTplByAreaId(areaId)
  
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
    C_UISceneManager.SetSceneActive(false)
    local sceneTime, isNight = self:getSceneLightTime()
    if isNight then
      C_RealWeather:getCurrentWeatherController():SetTime(sceneTime, 0)
    end
    self.bind.go_black = false
    self.bind.go_show = true
    local posData = _dungeonEntrustAreaTpl:getShopTimelinePos(self.areaTpl)
    local rotData = _dungeonEntrustAreaTpl:getShopTimelineRot(self.areaTpl)
    local pos = C_Vector3(posData[1], posData[2], posData[3])
    local rot = C_Vector3(rotData[1], rotData[2], rotData[3])
    local pos = C_Vector3(0.05, -0.03, -0.11)
    local rot = C_Vector3(-25.5, -259, 20.5)
    local scale = C_Vector3(-1, 1, 1)
    C_AzurTimelineMgr.SetActorPosAndRot(pos, rot)
    C_AzurTimelineMgr.SetActorScale(scale)
  end
  
  local path = _dungeonEntrustAreaTpl:getTimelineActor(self.areaTpl)
  path = "Timeline/UI/Hero/108001"
  local scenePath = _dungeonEntrustAreaTpl:getShopBackGround(self.areaTpl)
  scenePath = L_CommonUtil.getMultiPlatformScenePath(scenePath)
  local state = L_Const.heroTimelineState.Detail
  local excludeState = {
    L_Const.heroTimelineState.Select
  }
  local heroId = _dungeonEntrustAreaTpl:getActorId(self.areaTpl)
  C_AzurTimelineMgr.AsyncLoadTimelineAssetsListByStateLoader(path, state, excludeState, scenePath, heroId, isFirstInit, function()
  end, function()
    C_AzurTimelineMgr.PlayTimelineStateByStateLoader(state, true, true)
    C_AzurTimelineMgr.PreloadStateByStateLoader(state)
    C_AzurTimelineMgr.PreloadStateOutgoingTransitionsByStateLoader(state)
    allLoad()
  end)
end

function page:initTimeline()
  local areaId = self:mapAreaConfig()
  self.areaTpl = _dungeonEntrustAreaTpl:getTplByAreaId(areaId)
  self.entrustScene = _dungeonEntrustAreaTpl:getTimelineBackGround(self.areaTpl)
  self.entrustScene = L_CommonUtil.getMultiPlatformScenePath(self.entrustScene)
  self.shopScene = _dungeonEntrustAreaTpl:getShopBackGround(self.areaTpl)
  self.shopScene = L_CommonUtil.getMultiPlatformScenePath(self.shopScene)
  self.timelineActor = _dungeonEntrustAreaTpl:getTimelineActor(self.areaTpl)
  self.actorId = _dungeonEntrustAreaTpl:getActorId(self.areaTpl)
  local timelinePos = _dungeonEntrustAreaTpl:getShopTimelinePos(self.areaTpl)
  local timelineRot = _dungeonEntrustAreaTpl:getShopTimelineRot(self.areaTpl)
  self.timelineControl:setTimeLineTrans({
    x = timelinePos[1],
    y = timelinePos[2],
    z = timelinePos[3]
  }, {
    x = timelineRot[1],
    y = timelineRot[2],
    z = timelineRot[3]
  })
  self:loadScenePrefab()
end

function page:loadScenePrefab()
  local function loadPrefab()
    local characterPos = _dungeonEntrustAreaTpl:getShopCharacterPos(self.areaTpl)
    
    local characterRot = _dungeonEntrustAreaTpl:getShopCharacterRot(self.areaTpl)
    self.timelineControl:setActorTrans({
      x = characterPos[1],
      y = characterPos[2],
      z = characterPos[3]
    }, {
      x = characterRot[1],
      y = characterRot[2],
      z = characterRot[3]
    })
    self.timelineControl:setCameraTimelineActive(true)
    local handle = self.timelineControl.onPlayTimelineAssetHandle
    
    function self.timelineControl.onPlayTimelineAssetHandle()
      C_UIMgr.CloseCutin()
      if handle then
        handle()
      end
      self.timelineControl.onPlayTimelineAssetHandle = handle
    end
    
    self.timelineControl:playTimelineState(L_Const.EntrustTimelineState.Shop, true, false)
    local sceneTime, isNight = self:getSceneLightTime()
    if isNight then
      C_RealWeather:getCurrentWeatherController():SetTime(sceneTime, 0)
    end
    local heroPrefab = self.timelineControl:getCurHeroPrefab()
    self.npcLight = C_UINpcLight.CreateLight(heroPrefab.actor)
    if self.npcLight and self.npcLight.lightObj then
      self.npcLight.lightObj.transform.rotation = C_Quaternion.Euler(C_Vector3(45, 0, 0))
    end
  end
  
  local tmpActive = self.timelineControl:isSceneActive(self.shopScene)
  if tmpActive then
    self.timelineControl:setSceneActiveByName(self.entrustScene, false)
    self.timelineControl:setSceneActiveByName(self.shopScene, true)
    loadPrefab()
  else
    self.timelineControl:loadSceneNew(self.shopScene, loadPrefab)
  end
end

function page:exitShopTimeline()
  self.timelineControl:playTimelineState(L_Const.EntrustTimelineState.None, true, false)
  self.timelineControl:setActorTrans({
    x = 0,
    y = 0,
    z = 0
  }, {
    x = 0,
    y = 0,
    z = 0
  })
  local posData = _dungeonEntrustAreaTpl:getHeroPos(self.areaTpl)
  local rotData = _dungeonEntrustAreaTpl:getHeroRot(self.areaTpl)
  self.timelineControl:setTimeLineTrans({
    x = posData[1],
    y = posData[2],
    z = posData[3]
  }, {
    x = rotData[1],
    y = rotData[2],
    z = rotData[3]
  })
  self.timelineControl:unloadScene(self.shopScene)
  self.timelineControl:setSceneActiveByName(self.entrustScene, true)
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
  L_UI:close(self.pageName)
end

function page:setBatchMode(isOn)
  local oldIsOn = self.data.batchMode
  self.data.batchMode = isOn
  self.bindComponents.offBtn.gameObject:SetActive(not isOn)
  self.bindComponents.onBtn.gameObject:SetActive(isOn)
  self.bind.toggle_batch_off = not isOn
  self.bind.toggle_batch_on = isOn
  if oldIsOn == true and isOn == false then
    self:clearSelRelatedState()
    if self.ItemSumMap ~= nil then
      table.clear(self.ItemSumMap)
    end
    self.ItemSumMap = {}
    self.bind.costList:clear()
    self:refreshSelGoodsState()
  end
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

function page:getCurShopId()
  if self.data and self.data.curShopId then
    return self.data.curShopId
  end
  return 0
end

function page:isHomeCrop(type)
  return type == 310
end

function page:getHomeCropHarvestExp(itemId)
  local tpl = _itemTpl:getTplById(itemId)
  if tpl == nil then
    return 0
  end
  if tpl.type == 310 then
    local seedTpl = _homeSeedsTpl:getTplById(tpl.subId)
    local dropTpl = 0 < seedTpl.homeDropId_exp and _homeDropTpl:getTplById(seedTpl.homeDropId_exp) or nil
    if dropTpl then
      return dropTpl.minValue
    else
      return 0
    end
  else
    return 0
  end
end

return page
