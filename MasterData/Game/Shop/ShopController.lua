local ShopController = class("ShopController", ControllerBase)
local ShopEnum = require("Game.Shop.ShopEnum")
local ShopBaseData = require("Game.Shop.Data.ShopDataBase")
local CheckerTypeId, CheckerGlobalConfig = table.unpack(require("Game.Common.CheckCondition.CheckerGlobalConfig"))
local EPeriodicCardType = require("Game.DailySignIn.DailySignInEnum").EPeriodicCardType
local shopDataClasses = {
  [ShopEnum.eShopType.Normal] = require("Game.Shop.Data.NormalShopData"),
  [ShopEnum.eShopType.Skin] = require("Game.Shop.Data.SkinShopData"),
  [ShopEnum.eShopType.Random] = require("Game.Shop.Data.RefreshShopData"),
  [ShopEnum.eShopType.Resource] = require("Game.Shop.Data.ResourceShopData"),
  [ShopEnum.eShopType.ResourceRefresh] = require("Game.Shop.Data.ResourceRefreshShopData"),
  [ShopEnum.eShopType.Charcter] = require("Game.Shop.Data.HeroShopData"),
  [ShopEnum.eShopType.Recharge] = require("Game.Shop.Data.RechargeShopData")
}

function ShopController:OnInit()
  self.shopDataDic = {}
  self.redDotTimerDic = {}
  self.network = NetworkManager:GetNetwork(NetworkTypeID.Shop)
  self.isUnlocked = FunctionUnlockMgr:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_Store)
  self.shopCommonTimerFunDic = {}
  self.shopCommonTimer = TimerManager:StartTimer(1, self.OnShopCommonTimerTick, self, false, false, true)
  TimerManager:PauseTimer(self.shopCommonTimer)
end

function ShopController:SetIsUnLock(bool)
  self.isUnlocked = bool
end

function ShopController:GetIsUnlock()
  return self.isUnlocked
end

function ShopController:ReqShopDetail(shopId, callback)
  local function next()
    table.remove(self.__wait2SentReq, 1)
    
    if #self.__wait2SentReq > 0 then
      self.__wait2SentReq[1]()
    end
  end
  
  local function nextFunc()
    local shopCfg = ConfigData.shop[shopId]
    if shopCfg == nil then
      error("can't read shopCfg id = " .. shopId)
      next()
    else
      self.network:CS_STORE_Detail(shopId, function(args)
        if args ~= nil and args.Count > 0 then
          local shopDataMsg = args[0]
          local shopData = self.shopDataDic[shopId]
          if shopData ~= nil then
            shopData:UpdateShopData(shopDataMsg)
          else
            local shopDataClass = shopDataClasses[shopCfg.shop_type]
            if shopDataClass == nil then
              error("shopDataClass is nil for shopId:" .. tostring(shopId))
            end
            shopData = shopDataClass.New()
            shopData:InitShopData(shopDataMsg, shopId)
            self.shopDataDic[shopData.shopId] = shopData
          end
          self:StartOneShopRedDot(shopData)
        else
          error("require shopData not have data")
        end
        if callback ~= nil then
          callback()
        end
        next()
      end)
    end
  end
  
  if self.__wait2SentReq == nil then
    self.__wait2SentReq = {}
  end
  table.insert(self.__wait2SentReq, nextFunc)
  if #self.__wait2SentReq == 1 then
    nextFunc()
  end
end

function ShopController:ReqRefreshShopDetail(shopId, callback)
  local function next()
    table.remove(self.__wait2SentReqRefresh, 1)
    
    if #self.__wait2SentReqRefresh > 0 then
      self.__wait2SentReqRefresh[1]()
    end
  end
  
  local function nextFunc()
    self.network:CS_STORE_Fresh(shopId, function(args)
      if args ~= nil and args.Count > 0 and self.shopDataDic[shopId] ~= nil then
        local shopDataMsg = args[0]
        local shopData = self.shopDataDic[shopId]
        shopData:UpdateShopData(shopDataMsg)
      else
        error("CS_STORE_Fresh require shopData not have data")
      end
      if callback ~= nil then
        callback()
      end
      next()
    end)
  end
  
  if self.__wait2SentReqRefresh == nil then
    self.__wait2SentReqRefresh = {}
  end
  table.insert(self.__wait2SentReqRefresh, nextFunc)
  if #self.__wait2SentReqRefresh == 1 then
    nextFunc()
  end
end

function ShopController:ReqBuySuitGoods(storeId, shelf2Cnt, callback)
  self.network:CS_STORE_Purchase_Batch(storeId, shelf2Cnt, function(objList)
    if objList.Count ~= 1 then
      error("CS_STORE_Purchase objList.Count error:" .. tostring(objList.Count))
      return
    end
    local CommonStoreShelfDataList = objList[0]
    for k, CommonStoreShelfData in pairs(CommonStoreShelfDataList) do
      self:RefreshGoodsData(CommonStoreShelfData, storeId)
    end
    MsgCenter:Broadcast(eMsgEventId.ShopSuitGoodsBuyed, storeId)
    if callback ~= nil then
      callback()
    end
  end)
end

function ShopController:ReqBuyGoods(storeId, shelfId, cnt, callback)
  cnt = cnt or 1
  self.network:CS_STORE_Purchase(storeId, shelfId, cnt, function(objList)
    if objList.Count < 1 then
      error("CS_STORE_Purchase objList.Count error:" .. tostring(objList.Count))
      return
    end
    local CommonStoreShelfData = objList[0]
    local addInfo = objList[1]
    self:RefreshGoodsData(CommonStoreShelfData, storeId)
    MsgCenter:Broadcast(eMsgEventId.ShopGoodsBuyed, storeId, shelfId)
    if callback ~= nil then
      callback(addInfo)
    end
  end)
end

function ShopController:ReqExchangeGoods(toId, num, callback)
  self.network:CS_BACKPACK_Exchange(toId, num, callback)
end

function ShopController:RefreshGoodsData(CommonStoreShelfData, shopId)
  local shopData = self.shopDataDic[shopId]
  if shopData == nil then
    error("can't get shopData by Id:" .. tostring(shopId))
    return
  end
  local goodsData = shopData.shopGoodsDic[CommonStoreShelfData.shelfId]
  if goodsData == nil then
    return
  end
  goodsData:UpdateShopGoodData(CommonStoreShelfData)
end

function ShopController:GetShopData(shopId, callback, notLoclJudge)
  if not notLoclJudge and not self:ShopIsUnlock(shopId) then
    if callback ~= nil then
      callback(nil)
    end
    return
  end
  local shopData = self.shopDataDic[shopId]
  if shopData == nil then
    self:ReqShopDetail(shopId, function()
      if callback ~= nil then
        callback(self.shopDataDic[shopId])
      end
    end)
  else
    local isNeedFresh = shopData:GetIsHaveRefresh() and shopData:GetRemainAutoRefreshTime() < 0
    local isGoodsNeedFresh = shopData:GetIsHaveRefreshItem()
    local isLimitTimeFresh = 0 < shopData:GetIsLimitTimeRefresh() and shopData:GetIsLimitTimeRefresh() <= PlayerDataCenter.timestamp
    if isNeedFresh or isGoodsNeedFresh or isLimitTimeFresh then
      self:ReqShopDetail(shopId, function()
        if callback ~= nil then
          callback(self.shopDataDic[shopId])
        end
      end)
    else
      callback(shopData)
    end
  end
end

function ShopController:ShopShowBeforeUnlock(shopId)
  local flag = ConfigData.game_config.shopShowBeforeUnlockDic[shopId]
  if flag == nil or flag == false then
    return false
  else
    return true
  end
end

function ShopController:ShopIsUnlock(shopId)
  local cfg = ConfigData.shop[shopId]
  if cfg == nil then
    return false
  end
  return CheckCondition.CheckLua(cfg.pre_condition, cfg.pre_para1, cfg.pre_para2), CheckCondition.GetUnlockInfoLua(cfg.pre_condition, cfg.pre_para1, cfg.pre_para2)
end

function ShopController:ShopIsUnlockOnly(shopId)
  local cfg = ConfigData.shop[shopId]
  if cfg == nil then
    return false
  end
  return CheckCondition.CheckLua(cfg.pre_condition, cfg.pre_para1, cfg.pre_para2)
end

function ShopController:StartShopAllRedDot()
  if not self.isUnlocked then
    return
  end
  local showShopDic = ConfigData.shop_classification.showShopDic
  for k, shopId in ipairs(ConfigData.shop.id_sort_list) do
    local shopCfg = ConfigData.shop[shopId]
    if shopCfg.shop_type == ShopEnum.eShopType.MonthCard and PlayerDataCenter.dailySignInData:GetIsMonthCardUnlock(shopCfg.shop_para[1]) then
      local saveUserData = PersistentManager:GetDataModel(PersistentConfig.ePackage.UserData)
      local isBoughtMonthCardRDClosed = saveUserData:GetIsSReddotClose(RedDotStaticTypeId.Main .. "." .. RedDotStaticTypeId.ShopWindow .. "." .. tostring(shopId))
      if not isBoughtMonthCardRDClosed then
        local shopNode = RedDotController:AddRedDotNode(RedDotStaticTypeId.Main, RedDotStaticTypeId.ShopWindow, shopId)
        shopNode:SetRedDotCount(1)
      end
    end
    if showShopDic[shopId] and shopCfg.isRefreshShop and CheckCondition.CheckLua(shopCfg.pre_condition, shopCfg.pre_para1, shopCfg.pre_para2) then
      self:RemoveShopTimerCallback(self.redDotTimerDic[shopId])
      self.redDotTimerDic[shopId] = nil
      local counterElem = ControllerManager:GetController(ControllerTypeId.TimePass):getCounterElemData(proto_object_CounterModule.CounterModuleStoreSystemReset, shopId)
      if counterElem == nil then
        local shopNode = RedDotController:AddRedDotNode(RedDotStaticTypeId.Main, RedDotStaticTypeId.ShopWindow, shopId)
        shopNode:SetRedDotCount(1)
      else
        local saveUserData = PersistentManager:GetDataModel(PersistentConfig.ePackage.UserData)
        local isBoughtMonthCardRDClosed = saveUserData:GetIsSReddotClose(RedDotStaticTypeId.Main .. "." .. RedDotStaticTypeId.ShopWindow .. "." .. tostring(shopId))
        if isBoughtMonthCardRDClosed ~= nil and not isBoughtMonthCardRDClosed then
          local shopNode = RedDotController:AddRedDotNode(RedDotStaticTypeId.Main, RedDotStaticTypeId.ShopWindow, shopId)
          shopNode:SetRedDotCount(1)
        end
        if counterElem.nextExpiredTm > PlayerDataCenter.timestamp then
          self:_StartShopRedDotTimer(shopId, counterElem.nextExpiredTm)
        end
      end
    end
    if shopId == ShopEnum.ShopId.supportShop then
      local maxPoint = ConfigData.game_config.supportPointMaxNum
      local shopNode = RedDotController:AddRedDotNode(RedDotStaticTypeId.Main, RedDotStaticTypeId.ShopWindow, shopId)
      local SFSPNode = shopNode:AddChildWithPath(RedDotStaticTypeId.ShopFriendSupportBtn, RedDotDynPath.ShopFriendSupportBtnPath)
      local curPoint = PlayerDataCenter.inforData:GetCurSupportPoint()
      if maxPoint <= curPoint then
        SFSPNode:SetRedDotCount(1)
      else
        SFSPNode:SetRedDotCount(0)
      end
      self.__FriendShipPointReddotTimerId = TimerManager:StartTimer(60, function()
        local curPoint = PlayerDataCenter.inforData:GetCurSupportPoint()
        if curPoint >= maxPoint then
          SFSPNode:SetRedDotCount(1)
        else
          SFSPNode:SetRedDotCount(0)
        end
      end, self, false, false, true)
    end
  end
end

function ShopController:AddMonthCardRedDot(hasDiscount)
  local needReddot = false
  local saveUserData = PersistentManager:GetDataModel(PersistentConfig.ePackage.UserData)
  if hasDiscount then
    local isBoughtMonthCardRDClosed = saveUserData:GetIsSReddotClose(RedDotStaticTypeId.Main .. "." .. RedDotStaticTypeId.ShopWindow .. "." .. tostring(ShopEnum.ShopId.MonthCardId) .. "discount")
    if not isBoughtMonthCardRDClosed then
      needReddot = true
    end
  end
  if not needReddot then
    local lastTime = saveUserData:GetLastMonthCardRenew()
    local curTime = math.floor(PlayerDataCenter.timestamp)
    local leftTime = curTime - lastTime
    local dayLeft = TimeUtil:TimestampToTimeInter(leftTime, false, true)
    local monthLeftday = PlayerDataCenter.dailySignInData:GetMonthCardLeftCount(EPeriodicCardType.MonthCard)
    local canShowMonthRed = 0 < monthLeftday and monthLeftday <= ConfigData.game_config.monthCardReddot and dayLeft > ConfigData.game_config.monthCardReddot
    local weekLeftday = PlayerDataCenter.dailySignInData:GetMonthCardLeftCount(EPeriodicCardType.WeekCard)
    local canShowWeekRed = 0 < weekLeftday and weekLeftday <= ConfigData.game_config.weekCardReddot and dayLeft > ConfigData.game_config.weekCardReddot
    needReddot = canShowMonthRed or canShowWeekRed
  end
  if needReddot then
    local shopNode = RedDotController:AddRedDotNode(RedDotStaticTypeId.Main, RedDotStaticTypeId.ShopWindow, ShopEnum.ShopId.MonthCardId)
    if shopNode ~= nil then
      shopNode:SetRedDotCount(1)
    end
  end
end

function ShopController:AddMonthCardRenewReddot()
end

function ShopController:StartOneShopRedDot(shopData)
  if not shopData:GetIsHaveRefresh() then
    return
  end
  local nextTime = shopData.freeFreshTm
  self:_StartShopRedDotTimer(shopData.shopId, nextTime)
end

function ShopController:_StartShopRedDotTimer(shopId, nextTime)
  if self.redDotTimerDic[shopId] ~= nil then
    self:RemoveShopTimerCallback(self.redDotTimerDic[shopId])
    self.redDotTimerDic[shopId] = nil
  end
  self.redDotTimerDic[shopId] = function()
    if nextTime < PlayerDataCenter.timestamp then
      self:RemoveShopTimerCallback(self.redDotTimerDic[shopId])
      self.redDotTimerDic[shopId] = nil
      local shopNode = RedDotController:AddRedDotNodeWithPath(RedDotDynPath.ShopPath, RedDotStaticTypeId.Main, RedDotStaticTypeId.ShopWindow, shopId)
      shopNode:SetRedDotCount(1)
      local saveUserData = PersistentManager:GetDataModel(PersistentConfig.ePackage.UserData)
      saveUserData:SetSReddotClose(RedDotStaticTypeId.Main .. "." .. RedDotStaticTypeId.ShopWindow .. "." .. tostring(shopId), false)
    end
  end
  self:AddShopTimerCallback(self.redDotTimerDic[shopId], "refreshShop out side redddot:" .. tostring(shopId))
end

function ShopController:StopShopRedDot()
  for _, func in pairs(self.redDotTimerDic) do
    self:RemoveShopTimerCallback(func)
  end
  if self.__FriendShipPointReddotTimerId ~= nil then
    TimerManager:StopTimer(self.__FriendShipPointReddotTimerId)
    self.__FriendShipPointReddotTimerId = nil
  end
end

function ShopController:IsShopBlueReddot(shopId)
  if shopId == ShopEnum.ShopId.supportShop then
    return false
  end
  local shopCfg = ConfigData.shop[shopId]
  return shopCfg ~= nil and shopCfg.isRefreshShop
end

function ShopController:OnOpenShopSetShopRedDot(shopId)
  if shopId ~= ShopEnum.ShopId.supportShop then
    local ok, shopNode = RedDotController:GetRedDotNode(RedDotStaticTypeId.Main, RedDotStaticTypeId.ShopWindow, shopId)
    if ok then
      shopNode:SetRedDotCount(0)
    end
  end
  local shopCfg = ConfigData.shop[shopId]
  if shopCfg.isRefreshShop and CheckCondition.CheckLua(shopCfg.pre_condition, shopCfg.pre_para1, shopCfg.pre_para2) then
    local saveUserData = PersistentManager:GetDataModel(PersistentConfig.ePackage.UserData)
    saveUserData:SetSReddotClose(RedDotStaticTypeId.Main .. "." .. RedDotStaticTypeId.ShopWindow .. "." .. tostring(shopId), true)
  end
end

function ShopController:AddShopTimerCallback(callback, name)
  if not self.shopCommonTimerFunDic[callback] then
    self.shopCommonTimerFunDic[callback] = name
    if TimerManager:IsTimerPaused(self.shopCommonTimer) then
      TimerManager:ResumeTimer(self.shopCommonTimer)
    end
  end
end

function ShopController:RemoveShopTimerCallback(callback)
  if callback ~= nil and self.shopCommonTimerFunDic[callback] ~= nil then
    self.shopCommonTimerFunDic[callback] = nil
    if table.count(self.shopCommonTimerFunDic) == 0 then
      TimerManager:PauseTimer(self.shopCommonTimer)
    end
  end
end

function ShopController:OnShopCommonTimerTick()
  for callback, name in pairs(self.shopCommonTimerFunDic) do
    if not pcall(callback) then
      error(name)
    end
  end
end

function ShopController:ReqShopRecharge(pay_id)
  self._rechargePayId = pay_id
  self._OnShopRechargeFunc = self._OnShopRechargeFunc or BindCallback(self, self._OnShopRecharge)
  self.network:CS_STORE_Recharge(pay_id, self._OnShopRechargeFunc)
end

function ShopController:_OnShopRecharge()
  ControllerManager:GetController(ControllerTypeId.Pay, true):ReqPay(self._rechargePayId, 1)
end

function ShopController:AfterShopRechargeComplete(CommonStore)
  if self.shopDataDic[CommonStore.storeId] ~= nil then
    for k, CommonStoreShelf in pairs(CommonStore.data) do
      self:RefreshGoodsData(CommonStoreShelf, CommonStore.storeId)
    end
  end
  MsgCenter:Broadcast(eMsgEventId.ShopRechargeComplete, CommonStore.storeId)
end

function ShopController:IsHaveNewGoodItemInShop(shopData)
  if shopData == nil then
    return
  end
  local saveUserData = PersistentManager:GetDataModel(PersistentConfig.ePackage.UserData)
  local isHaveNew = false
  for i, goodData in pairs(shopData.shopGoodsDic) do
    local isNotNew = saveUserData:GetNewItemReddotDic()[goodData.itemId]
    if goodData.isSoldOut == false and not isNotNew then
      isHaveNew = true
      break
    end
  end
  return isHaveNew
end

function ShopController:GetIsHaveNewVowSkinGoodItemInShop()
  self:GetIsHaveNewSkinGoodItemInShop(ShopEnum.ShopId.vow)
end

function ShopController:GetIsHaveNewSkinGoodItemInShop(targetShopId)
  local realTargetShopId = targetShopId and targetShopId or ShopEnum.ShopId.skin
  local shopData = self.shopDataDic[realTargetShopId]
  if shopData == nil then
    return false
  end
  if self:ShopIsUnlockOnly(ShopEnum.ShopId.specialSkin) then
    return false
  end
  local isHaveNew = self:IsHaveNewGoodItemInShop(shopData)
  return isHaveNew
end

function ShopController:IsHaveNewSkinGoodItemInShop(callback, skinShopType)
  local realSkinShopType = skinShopType and skinShopType or ShopEnum.ShopId.skin
  local shopData = self.shopDataDic[realSkinShopType]
  if shopData == nil then
    self:GetShopData(realSkinShopType, function(shopData)
      local isHavaNew = self:IsHaveNewGoodItemInShop(shopData)
      if callback then
        callback(isHavaNew)
      end
    end)
    return
  end
  local isHavaNew = self:IsHaveNewGoodItemInShop(shopData)
  if callback then
    callback(isHavaNew)
  end
end

function ShopController:IsHaveNewRechargeGoodsInShop(shopData)
  if shopData == nil then
    return
  end
  local saveUserData = PersistentManager:GetDataModel(PersistentConfig.ePackage.UserData)
  local isHaveNew = false
  for i, goodData in pairs(shopData.shopGoodsDic) do
    if goodData.shelfId > 6 then
      local isNotNew = saveUserData:GetIsRechargeShelfNotNew(goodData.shelfId)
      if goodData.isSoldOut == false and not isNotNew then
        isHaveNew = true
        break
      end
    end
  end
  return isHaveNew
end

function ShopController:IsHaveNewRechargeGoodItemInShop(callback)
  local shopData = self.shopDataDic[ShopEnum.ShopId.recharge]
  if shopData == nil then
    self:GetShopData(ShopEnum.ShopId.recharge, function(shopData)
      local isHavaNew = self:IsHaveNewRechargeGoodsInShop(shopData)
      if callback then
        callback(isHavaNew)
      end
    end)
    return
  end
  local isHavaNew = self:IsHaveNewRechargeGoodsInShop(shopData)
  if callback then
    callback(isHavaNew)
  end
end

function ShopController:SetHaveNewGoodItemInShop(shopData)
  if shopData == nil then
    return
  end
  local saveUserData = PersistentManager:GetDataModel(PersistentConfig.ePackage.UserData)
  for i, goodData in pairs(shopData.shopGoodsDic) do
    saveUserData:SetNewItemReddot(goodData.itemId, true)
  end
end

function ShopController:GetShopIsSouldOut(shopId)
  local shopCfg = ConfigData.shop[shopId]
  if shopCfg == nil then
    return true
  end
  local shopData = self.shopDataDic[shopId]
  if shopData == nil then
    return true
  end
  local empty = true
  for i, goodData in pairs(shopData.shopGoodsDic) do
    local isTimelimit, inTime = goodData:GetStillTime()
    if isTimelimit and inTime and goodData.isSoldOut == false then
      empty = false
      break
    end
  end
  return empty
end

function ShopController:GetShelfIsSouldOut(shopId, shelfId)
  local shopCfg = ConfigData.shop[shopId]
  if shopCfg == nil then
    return true
  end
  if shopCfg.shop_type == ShopEnum.eShopType.PayGift then
    local payGiftCtrl = ControllerManager:GetController(ControllerTypeId.PayGift, true)
    return payGiftCtrl:GetIsGiftSouldOut(shelfId)
  else
    local shopData = self.shopDataDic[shopId]
    if shopData == nil then
      return true
    end
    local goodData = shopData.shopGoodsDic[shelfId]
    if goodData == nil then
      return true
    end
    local isTimelimit, inTime = goodData:GetStillTime()
    if isTimelimit and not inTime then
      return true
    end
    return goodData.isSoldOut
  end
end

function ShopController:GetShelfOutDataTime(shopId, shelfId)
  local shopCfg = ConfigData.shop[shopId]
  if shopCfg == nil then
    return false
  end
  if shopCfg.shop_type == ShopEnum.eShopType.PayGift then
    return false
  end
  local shopData = self.shopDataDic[shopId]
  if shopData == nil then
    return false
  end
  local goodData = shopData.shopGoodsDic[shelfId]
  if goodData == nil then
    return false
  end
  local outDataTime = -1
  if shopData.isRefreshShop then
    outDataTime = shopData.freeFreshTm
  end
  local isTimelimit, inTime, _, endTime = goodData:GetStillTime()
  if isTimelimit and (not (0 < outDataTime and outDataTime < endTime) or not outDataTime) then
    outDataTime = endTime
  end
  return 0 < outDataTime, outDataTime, true
end

function ShopController:GetIsThisShopHasTimeLimit(shopId)
  local shopCfg = ConfigData.shop[shopId]
  if shopCfg == nil then
    return false
  end
  
  local function checkEndTimeValid(paraIndex)
    local startTime = shopCfg.pre_para1[paraIndex]
    local endTime = shopCfg.pre_para2[paraIndex]
    if endTime < 0 then
      return false
    end
    return true
  end
  
  if not CheckCondition.CheckLua(shopCfg.pre_condition, shopCfg.pre_para1, shopCfg.pre_para2) then
    return false
  end
  for index, conditonTypeId in ipairs(shopCfg.pre_condition) do
    if conditonTypeId == CheckerTypeId.TimeRange then
      return checkEndTimeValid(index), shopCfg.pre_para1[index], shopCfg.pre_para2[index]
    elseif conditonTypeId == CheckerTypeId.SectorStagePassTm then
      local ok, outRange, sectorPassTm, realSectorPassTm = PlayerDataCenter.sectorStage:CheckStagePassTmInRange(shopCfg.pre_para1[index], shopCfg.pre_para2[index])
      return checkEndTimeValid(index), sectorPassTm, realSectorPassTm
    end
  end
  return false
end

function ShopController:CheckShopInTimePeriod(shopId)
  local hasTimeFlag, startTime, endTime = self:GetIsThisShopHasTimeLimit(shopId)
  if hasTimeFlag then
    return startTime <= PlayerDataCenter.timestamp and endTime > PlayerDataCenter.timestamp
  end
  return false
end

function ShopController:OnDelete()
  self:StopShopRedDot()
  self.shopDataDic = nil
  if self.shopCommonTimer ~= nil then
    TimerManager:StopTimer(self.shopCommonTimer)
    self.shopCommonTimer = nil
  end
end

return ShopController
