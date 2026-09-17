local this = class("moduleBuyGoodsInfo", G_UIModuleBase)
local homeDormFurnitureTpl = L_GameTpl:gethomeDormFurnitureTpl()
local _goodsTpl = L_GameTpl:getGoodsTpl()
local _commonItemTpl = L_GameTpl:getCommonItemTpl()
local _homeSeedTpl = L_GameTpl:getHomeSeedsTpl()
local _homeDropTpl = L_GameTpl:getHomeDropTpl()
local _shopTpl = L_GameTpl:getShopTpl()

function this.bind()
  return {
    name = "",
    holdNum = "",
    info = "",
    storeNumText = "",
    storeBox = true,
    numberFiledActive = true,
    numberMobileFiledActive = false,
    unlockListActive = true,
    freeGet = false,
    infoScrollVerticalNormalized = 1,
    unlockList = {
      moduleName = "modulePages/cellGoodUnlockItem"
    },
    moduleInputNum = {
      moduleName = "modulePages/moduleSelectNum"
    },
    moduleInputMobileNum = {
      moduleName = "modulePages/moduleSelectNum"
    },
    itemRarity = "",
    itemIcon = "",
    expActive = false,
    expTxt = ""
  }
end

function this.methods()
  return {
    onClick_view = function(self)
      L_ItemTplManager:showInfoTip(self.itemType, self.itemId)
    end
  }
end

function this:open()
  this.super.open(self)
  self.isPc = L_DeviceTpl:getIsPc()
  self.bind.numberFiledActive = self.isPc
  self.bind.numberMobileFiledActive = not self.isPc
  self.onEvent_refreshResHandle = handler(self, self.onEvent_refreshRes)
  C_BagEvent.instance:Listen(C_EBagEvent.BagChange, self.onEvent_refreshResHandle)
  L_PlayerStore:listenCallFunc(L_PlayerStore.event.refreshAttr, self.onEvent_refreshRes, self)
end

function this:close()
  this.super.close(self)
  if self.refreshTimerKey then
    Timer.remove(self.refreshTimerKey)
    self.refreshTimerKey = nil
  end
  C_BagEvent.instance:Cancel(C_EBagEvent.BagChange, self.onEvent_refreshResHandle)
  L_PlayerStore:unListenCallFunc(L_PlayerStore.event.refreshAttr, self.onEvent_refreshRes)
end

function this:onEvent_refreshRes()
  local text = L_WordsTpl:getValue("ui_shopinfo_hasitemnumber")
  self.bind.holdNum = text .. self:getHoldNum(self.itemType, self.itemId)
  Unity.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.bindComponents.num)
end

function this:refresh(options, refreshNumCallBack)
  if not options then
    return
  end
  self.refreshNumCallBack = refreshNumCallBack
  self.bind.infoScrollVerticalNormalized = 1
  self.slotId = options.slotId
  self.shopId = options.shopId
  self.otherGoodsCost = options.otherGoodsCost
  self.defalutNum = 1
  if options.defalutNum then
    self.defalutNum = options.defalutNum
  end
  local goodsItem = L_ShopStore:getGoodsItem(self.shopId, self.slotId)
  local isLimit = L_ShopStore:getIsLimitGoods(self.shopId, self.slotId)
  self.bind.storeBox = isLimit == true
  self.goodsId = goodsItem.goodsId
  local tpl = _goodsTpl:getTplById(goodsItem.goodsId)
  local itemType = _goodsTpl:getItem(tpl)[1][1]
  local itemId = _goodsTpl:getItem(tpl)[1][2]
  self.itemId = itemId
  self.itemType = itemType
  local item = L_ItemTplManager:getItemConfig(itemType, itemId)
  if self.itemType == L_Const.resType.soulEssence then
    item = L_ItemTplManager:getsoulessenceItem(self.itemId, 1)
  end
  self.bind.name = L_ItemTplManager:getSplitName(_goodsTpl:getGoodsName(tpl), 13)
  self.bind.itemIcon = item.icon
  self.bind.itemRarity = string.format("UI/Atlas/Bag/tex_bag_rarity_tips_w_%s.png", item.quality)
  local text = L_WordsTpl:getValue("ui_shopinfo_hasitemnumber")
  self.bind.holdNum = text .. L_ItemTplManager:getItemNum(itemType, itemId)
  local goodsNum = L_ShopStore:getStock(self.shopId, self.slotId)
  local stockText = L_Lang:get(_goodsTpl:getLimitTxt(tpl), {
    [0] = goodsNum
  })
  self.bind.storeNumText = stockText
  Unity.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.bindComponents.num)
  self.bind.info = _goodsTpl:getGoodsDesc(tpl)
  self:updateMaxValue()
  
  local function func(num)
    self.defalutNum = num
    self:refreshExpAdd(options, num)
    self.refreshNumCallBack(self.slotId, self.defalutNum)
  end
  
  if self.isPc then
    self.modules.moduleInputNum:initModule(func, self.maxValue, 1, self.defalutNum)
  else
    self.modules.moduleInputMobileNum:initModule(func, self.maxValue, 1, self.defalutNum)
  end
  func(self.defalutNum)
  self:refreshUnlockCondition()
end

function this:getHoldNum(type, id)
  if type == L_Const.resType.currency then
    return L_PlayerStore:getCurrencyNum(id)
  else
    return C_BagMgr:getItemNumByItemId(id)
  end
end

function this:refreshUnlockCondition()
  local goodsItem = L_ShopStore:getGoodsItem(self.shopId, self.slotId)
  local tpl = _goodsTpl:getTplById(self.goodsId)
  local isComplete, unlockData, refreshTime = self:onCheckLockStatus(tpl, goodsItem, self.shopId)
  self:onRefreshUnlockStatus(isComplete, false)
  if not isComplete then
    self.bind.unlockList:clear()
    self.bind.unlockList:insert_array(unlockData)
  end
end

function this:onRefreshUnlockStatus(isComplete, forceClear)
  self.bind.numberFiledActive = isComplete and self.isPc
  self.bind.numberMobileFiledActive = isComplete and not self.isPc
  self.bind.unlockListActive = not isComplete
  if forceClear then
    self.bind.unlockList:clear()
  end
end

function this:checkAndRefreshShopInfo(needRefreshTime)
  if self.refreshTimerKey then
    Timer.remove(self.refreshTimerKey)
    self.refreshTimerKey = nil
  end
  if 0 < needRefreshTime then
    self.refreshTimerKey = Timer.once(needRefreshTime, function()
      self:onRefreshUnlockStatus(true, true)
    end, self)
  end
end

function this:refreshExpAdd(options, num)
  local expAdd = options.otherExpAdd
  if self.itemType == L_Const.resType.commonItem then
    local itemTpl = _commonItemTpl:getTplById(self.itemId)
    if itemTpl.type == 310 then
      local seedTpl = _homeSeedTpl:getTplById(itemTpl.subId)
      local dropTpl = seedTpl.homeDropId_exp > 0 and _homeDropTpl:getTplById(seedTpl.homeDropId_exp) or nil
      if dropTpl and 0 < dropTpl.minValue then
        expAdd = expAdd + dropTpl.minValue * num
      end
    end
  end
  if 0 < expAdd then
    self.bind.expActive = true
    self.bind.expTxt = string.format("%d", expAdd)
  else
    self.bind.expActive = false
  end
end

function this:onCheckLockStatus(tpl, v, shopId)
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

function this:getMaxLimitTime(goodTpl, shopTpl)
  local goodsTimelimit = goodTpl and _goodsTpl:getTimelimit(goodTpl) or 0
  local shopTimelimit = shopTpl and _shopTpl:getTimelimit(shopTpl) or 0
  local goodStartTime = C_CommonTimerMgr.GetStartTime(goodsTimelimit)
  local shopStartTime = C_CommonTimerMgr.GetStartTime(shopTimelimit)
  return goodStartTime > shopStartTime and goodsTimelimit or shopTimelimit
end

function this:checkUnlockDescValid(unlockDesc)
  return unlockDesc and 0 < #unlockDesc and L_Config:provider(unlockDesc[1]) ~= "-1"
end

function this:updateMaxValue()
  local goodsNum = L_ShopStore:getStock(self.shopId, self.slotId)
  self.maxValue = nil
  local costIds = _goodsTpl:getCostId(_goodsTpl:getTplById(self.goodsId))
  if table.isEmpty(costIds) then
    self.maxValue = goodsNum
  else
    for _, cost in ipairs(costIds) do
      local price = cost[3]
      if price <= 0 then
        self.maxValue = goodsNum
        break
      end
      local item = L_ItemTplManager:getItemConfig(cost[1], cost[2])
      local remainNum = item.num - (self.otherGoodsCost[cost[2]] ~= nil and self.otherGoodsCost[cost[2]].itemNumTxt or 0)
      local maxValue = 1
      if goodsNum < math.modf(remainNum / price) then
        maxValue = goodsNum
      else
        maxValue = math.modf(remainNum / price)
      end
      if self.maxValue == nil or maxValue < self.maxValue then
        self.maxValue = maxValue
      end
    end
  end
  if self.maxValue == nil or self.maxValue <= 0 then
    self.maxValue = 1
  end
end

function this:playShowAnim()
  self.bindComponents.ani:Stop()
  self.bindComponents.ani:Play("anim_shop_info_show")
end

return this
