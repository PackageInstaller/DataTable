local PayGiftController = class("PayGiftController", ControllerBase)
local base = ControllerBase
local PayGiftInfo = require("Game.PayGift.PayGiftInfo")
local ShopEnum = require("Game.Shop.ShopEnum")
local CommonRewardData = require("Game.CommonUI.CommonRewardData")
local HomeEnum = require("Game.Home.HomeEnum")
local CheckerTypeId, _ = table.unpack(require("Game.Common.CheckCondition.CheckerGlobalConfig"))
local ConditionListener = require("Game.Common.CheckCondition.ConditonListener.ConditionListener")
local JumpManager = require("Game.Jump.JumpManager")
local CS_MessageCommon = CS.MessageCommon
local PopFuncDic = {
  [1] = function(giftInfo, callback)
    UIManager:ShowWindowAsync(UIWindowTypeID.ChipGift, function(window)
      if IsNull(window) then
        return
      end
      window:InitChipGift(giftInfo, callback)
    end)
  end,
  [2] = function(giftInfo, callback)
    UIManager:ShowWindowAsync(UIWindowTypeID.CommonActivityLogin, function(window)
      if IsNull(window) then
        return
      end
      local loginPupupCfg = ConfigData.login_popup_ui[giftInfo.groupCfg.popup_id]
      local shopItemId = giftInfo.groupCfg.id
      local shopId = giftInfo:GetGiftInWhichShop()
      window:SetCloseCallback(callback)
      window:SetJumpFunc(function()
        local flag = giftInfo:IsUnlock() and not giftInfo:IsSoldOut()
        if flag then
          JumpManager:Jump(JumpManager.eJumpTarget.DynShop, nil, nil, {shopId, shopItemId})
        else
          CS.MessageCommon.ShowMessageTips(ConfigData:GetTipContent(TipContent.Shop_OutOfDate))
          return
        end
      end)
      window:InitActivityLoginUI(loginPupupCfg)
    end)
  end,
  [3] = function(giftInfo, callback)
    UIManager:ShowWindowAsync(UIWindowTypeID.EventNewYear23SkinBag, function(window)
      if IsNull(window) then
        return
      end
      window:InitSkinBag(giftInfo, callback)
    end)
  end,
  [5] = function(giftInfo, callback)
    UIManager:ShowWindowAsync(UIWindowTypeID.EventCommonSkinBag, function(window)
      if IsNull(window) then
        return
      end
      window:InitSkinBag(giftInfo, callback)
    end)
  end
}

local function Local_GroupPopFunc(groupPopId, callback, self)
  local groupCfg = ConfigData.pay_gift_pop_des[groupPopId]
  if groupCfg == nil then
    callback()
    return
  end
  local giftids = ConfigData.pay_gift_pop_des.popGroup[groupPopId]
  if giftids == nil or giftids[1] == nil then
    callback()
    return
  end
  local isRemove = false
  for _, giftInfoId in ipairs(giftids) do
    if self._homeMainPopDic[giftInfoId] ~= nil then
      self._homeMainPopDic[giftInfoId] = nil
      isRemove = true
    end
  end
  if isRemove then
    self:SortHomeMainPopList()
  end
  UIManager:ShowWindowAsync(UIWindowTypeID.CommonThemedPacks, function(win)
    if win == nil then
      return
    end
    win:InitCommonThemedPacks(groupPopId, callback)
  end)
end

function PayGiftController:OnInit()
  self._conditionListener = ConditionListener.New()
  self.__OnConditionStateChangeCallback = BindCallback(self, self.__OnConditionStateChange)
  self.__SoldoutStateChangeChangeCallback = BindCallback(self, self.__SoldoutStateChange)
  self.dataDic = {}
  self.shopGiftDic = {}
  self._homeMainPopDic = {}
  self._conditionGiftDic = {}
  for k, giftTypeCfg in pairs(ConfigData.pay_gift_type) do
    local data = PayGiftInfo.CreatePayGiftInfo(giftTypeCfg)
    if self.shopGiftDic[giftTypeCfg.inShop] == nil then
      self.shopGiftDic[giftTypeCfg.inShop] = true
    end
    self.dataDic[k] = data
    for _, conditonKey in ipairs(giftTypeCfg.pre_condition) do
      local conditionGifts = self._conditionGiftDic[conditonKey]
      if conditionGifts == nil then
        conditionGifts = {}
        self._conditionGiftDic[conditonKey] = conditionGifts
      end
      table.insert(conditionGifts, data)
    end
    for _, conditonKey in ipairs(giftTypeCfg.pre_condition2) do
      local conditionGifts = self._conditionGiftDic[conditonKey]
      if conditionGifts == nil then
        conditionGifts = {}
        self._conditionGiftDic[conditonKey] = conditionGifts
      end
      table.insert(conditionGifts, data)
    end
  end
  self.__ListenPreCondtion = BindCallback(self, self.ListenPreCondtion)
  MsgCenter:AddListener(eMsgEventId.PreCondition, self.__ListenPreCondtion)
  self._timeConditionFixed = {
    CheckerTypeId.TimeRange
  }
  self._timePara1 = {}
  self._timePara2Fixed = {-1}
  PersistentManager:GetDataModel(PersistentConfig.ePackage.UserData):TryClearChipGiftPopIgnore()
end

function PayGiftController:InitPayGift()
  self.PopOffset = 10000
  for k, v in pairs(self.dataDic) do
    v:UpdatePayGiftInfo()
  end
  self.shopId = 0
  for k, v in pairs(ConfigData.shop) do
    if v.shop_type == ShopEnum.eShopType.PayGift then
      self.shopId = k
      break
    end
  end
  self._lockedDic = {}
  self._lockedPopDic = {}
  local currentTm = PlayerDataCenter.timestamp
  for k, payGiftInfo in pairs(self.dataDic) do
    local giftTypeInfo = PlayerDataCenter.GiftTypeInfos[payGiftInfo.groupCfg.id]
    if giftTypeInfo ~= nil then
      local PopStartTime = giftTypeInfo.popFixedTm
      local _, timeLength = payGiftInfo:GetParas34ByCondition2Id(CheckerTypeId.SectorStagePassTm)
      local PopEndTime = timeLength + PopStartTime
      self._conditionListener:AddConditionChangeListener(-k - self.PopOffset, self.__OnConditionStateChangeCallback, {
        CheckerTypeId.TimeRange
      }, {PopStartTime}, {PopEndTime})
      payGiftInfo.startTime = PopStartTime
      payGiftInfo.endTime = PopEndTime
    end
    local flag, startTime, endTime = payGiftInfo:IsUnlockTimeCondition()
    if flag and (endTime == -1 or currentTm < endTime) then
      self._conditionListener:AddConditionChangeListener(-k, self.__OnConditionStateChangeCallback, {
        CheckerTypeId.TimeRange
      }, {startTime}, {endTime})
    end
    local isUnlock = payGiftInfo:IsUnlock()
    local isFree = self:__IsFreeGift(payGiftInfo)
    local isUnlockPop = self:CheckPayGiftCanPop(payGiftInfo)
    if isUnlockPop then
      self._homeMainPopDic[k] = isUnlock and true or nil
    elseif 0 < payGiftInfo.groupCfg.ispop then
      self._lockedPopDic[k] = payGiftInfo
    end
    if not isUnlock then
      self._lockedDic[k] = payGiftInfo
    elseif isFree then
      if payGiftInfo:IsSoldOut() then
        local nextRefreshTime = payGiftInfo:GetPayGiftNextTime()
        if nextRefreshTime > PlayerDataCenter.timestamp then
          self._timePara1[1] = nextRefreshTime
          self._conditionListener:AddConditionChangeListener(k, self.__SoldoutStateChangeChangeCallback, self._timeConditionFixed, self._timePara1, self._timePara2Fixed)
        end
      elseif payGiftInfo:IsGiftInfoInShop() and self:GetCanBuyGiftAndTipId(payGiftInfo) then
        local reddot = self:__GetPayGiftReddot(payGiftInfo)
        reddot:SetRedDotCount(1)
      end
    end
  end
  self:SortHomeMainPopList()
end

function PayGiftController:SortHomeMainPopList()
  local homeMainPopList = {}
  for id, _ in pairs(self._homeMainPopDic) do
    table.insert(homeMainPopList, id)
  end
  table.sort(homeMainPopList, function(aId, bId)
    local aInfo = self:GetPayGiftDataById(aId)
    local bInfo = self:GetPayGiftDataById(bId)
    local orderA = aInfo:GeyGiftGroupPopId()
    local orderB = bInfo:GeyGiftGroupPopId()
    if orderA ~= orderB then
      return orderA < orderB
    end
    return aInfo.groupCfg.id > bInfo.groupCfg.id
  end)
  self._homeMainPopList = homeMainPopList
  self._homeMainPopListIndex = 1
end

function PayGiftController:UpdatePayGift(giftInfo)
  giftInfo:UpdatePayGiftInfo()
  if giftInfo:IsSoldOut() then
    if self:__IsFreeGift(giftInfo) and giftInfo:IsGiftInfoInShop() then
      local reddot = self:__GetPayGiftReddot(giftInfo)
      reddot:SetRedDotCount(0)
    end
    local nextRefreshTime = giftInfo:GetPayGiftNextTime()
    if nextRefreshTime > PlayerDataCenter.timestamp then
      self._timePara1[1] = nextRefreshTime
      self._conditionListener:AddConditionChangeListener(giftInfo.groupCfg.id, self.__SoldoutStateChangeChangeCallback, self._timeConditionFixed, self._timePara1, self._timePara2Fixed)
    end
  end
end

function PayGiftController:__OnConditionStateChange(listenId)
  local giftId = -listenId
  if giftId > self.PopOffset then
    giftId = giftId - self.PopOffset
  end
  local payGiftInfo = self.dataDic[giftId]
  local newState = payGiftInfo:IsUnlock()
  if not (self._lockedDic[giftId] == nil or newState) or self._lockedDic[giftId] == nil and newState then
    return
  end
  local needRefreshPopList = false
  local isFree = self:__IsFreeGift(payGiftInfo)
  if newState then
    self._lockedDic[giftId] = nil
    if isFree and payGiftInfo:IsGiftInfoInShop() then
      local reddot = self:__GetPayGiftReddot(payGiftInfo)
      local redCount = payGiftInfo:IsSoldOut() and 0 or 1
      reddot:SetRedDotCount(redCount)
    end
    if self:CheckPayGiftCanPop(payGiftInfo) then
      self._homeMainPopDic[giftId] = true
      needRefreshPopList = true
      local homeController = ControllerManager:GetController(ControllerTypeId.HomeController)
      if homeController ~= nil then
        homeController:AddAutoShowGuide(HomeEnum.eAutoShwoCommand.ChipGift)
      end
    end
  else
    self._lockedDic[giftId] = payGiftInfo
    if isFree and payGiftInfo:IsGiftInfoInShop() then
      local reddot = self:__GetPayGiftReddot(payGiftInfo)
      reddot:SetRedDotCount(0)
    end
    self._homeMainPopDic[giftId] = nil
    needRefreshPopList = true
  end
  if needRefreshPopList then
    self:SortHomeMainPopList()
  end
  MsgCenter:Broadcast(eMsgEventId.PayGiftItemPreConfition)
end

function PayGiftController:__SoldoutStateChange(listenId, isUnlock)
  self._conditionListener:RemoveConditionChangeListener(listenId)
  local giftInfo = self.dataDic[listenId]
  if self:__IsFreeGift(giftInfo) and giftInfo:IsGiftInfoInShop() then
    local reddot = self:__GetPayGiftReddot(giftInfo)
    reddot:SetRedDotCount(1)
  end
  MsgCenter:Broadcast(eMsgEventId.PayGiftChange, listenId)
end

function PayGiftController:ListenPreCondtion(conditionId)
  local conditionGifts = self._conditionGiftDic[conditionId]
  if conditionGifts == nil then
    return
  end
  local needRefreshPopList = false
  local needBrodcast = false
  local collectDic
  for _, giftInfo in pairs(conditionGifts) do
    if giftInfo:IsUnlock() and self._lockedDic[giftInfo.groupCfg.id] ~= nil then
      needBrodcast = true
      self._lockedDic[giftInfo.groupCfg.id] = nil
      if self:__IsFreeGift(giftInfo) and giftInfo:IsGiftInfoInShop() then
        local reddot = self:__GetPayGiftReddot(giftInfo)
        local redcount = giftInfo:IsSoldOut() and 0 or 1
        reddot:SetRedDotCount(redcount)
      end
      if conditionId == CheckerTypeId.MinHeroStar and self:CheckPayGiftCanPop(giftInfo) then
        collectDic = collectDic or {}
        collectDic[giftInfo.groupCfg.id] = true
      end
    end
    if giftInfo:IsUnlock() and self:CheckPayGiftCanPop(giftInfo) and self._lockedPopDic[giftInfo.groupCfg.id] ~= nil then
      self._lockedPopDic[giftInfo.groupCfg.id] = nil
      collectDic = collectDic or {}
      collectDic[giftInfo.groupCfg.id] = true
    end
  end
  if collectDic ~= nil then
    local homeController = ControllerManager:GetController(ControllerTypeId.HomeController)
    if homeController ~= nil then
      for giftId, _ in pairs(collectDic) do
        if not self._homeMainPopDic[giftId] then
          self._homeMainPopDic[giftId] = true
          needRefreshPopList = true
          homeController:AddAutoShowGuide(HomeEnum.eAutoShwoCommand.ChipGift)
        end
      end
    end
  end
  if needRefreshPopList then
    self:SortHomeMainPopList()
  end
  if needBrodcast then
    MsgCenter:Broadcast(eMsgEventId.PayGiftItemPreConfition)
  end
  return
end

function PayGiftController:__GetPayGiftReddot(payGiftInfo)
  local ok, shopNode = RedDotController:GetRedDotNode(RedDotStaticTypeId.Main, RedDotStaticTypeId.ShopWindow, self.shopId)
  if not ok then
    shopNode = RedDotController:AddRedDotNode(RedDotStaticTypeId.Main, RedDotStaticTypeId.ShopWindow, self.shopId)
  end
  return shopNode:AddChild(payGiftInfo.groupCfg.inPage):AddChild(payGiftInfo.groupCfg.id)
end

function PayGiftController:__IsFreeGift(payGiftInfo)
  local payCtrl = ControllerManager:GetController(ControllerTypeId.Pay, true)
  if payGiftInfo:IsUseItemPay() then
    return false
  end
  local payId = payGiftInfo.defaultCfg.payId
  local _, isFree = payCtrl:GetPayPriceInter(payId)
  return isFree
end

function PayGiftController:__GetGiftInfoByChildId(childGiftId)
  for k, giftInfo in pairs(self.dataDic) do
    if giftInfo.groupCfg.giftDic[childGiftId] ~= nil then
      return giftInfo
    end
  end
  return nil
end

function PayGiftController:GetShowPayGiftByPageId(pageId, showSouldOut)
  local oriGroupDatas = {}
  for k, v in pairs(self.dataDic) do
    if (v.groupCfg.pre_group == nil or #v.groupCfg.pre_group == 0) and v:IsUnlock() and (pageId == nil or v.groupCfg.inPage == pageId) then
      table.insert(oriGroupDatas, v)
    end
  end
  if showSouldOut then
    return oriGroupDatas
  end
  local dataList = {}
  for i, v in ipairs(oriGroupDatas) do
    if v:IsLinearGift() then
      do
        local list = self:SeekNextLinearSellGift(v)
        if list ~= nil and 0 < #list then
          table.insertto(dataList, list)
        end
      end
    elseif not v:IsEternalAndSoldOut() and (v.needRefresh or not v:IsSoldOut()) then
      table.insert(dataList, v)
    end
  end
  return dataList
end

function PayGiftController:CheckHaveLimitGift()
  local shopCtrl = ControllerManager:GetController(ControllerTypeId.Shop, true)
  for shopId, _ in pairs(self.shopGiftDic) do
    if shopCtrl:GetIsThisShopHasTimeLimit(shopId) and #self:GetShowPayGiftByPageId(shopId) > 0 then
      return true
    end
  end
  return false
end

function PayGiftController:CheckPageIdIsGiftShop(pageId)
  return self.shopGiftDic[pageId]
end

function PayGiftController:GetPayGiftDataById(id)
  return self.dataDic[id]
end

function PayGiftController:GetCanBuyGiftAndTipId(giftInfo)
  local preIds = giftInfo.groupCfg.pre_group
  if preIds ~= nil and 0 < #preIds then
    local tempCanBuy = true
    for k, id in pairs(preIds) do
      local tempData = self:GetPayGiftDataById(id)
      tempCanBuy = tempCanBuy and tempData:IsSoldOut()
    end
    if not tempCanBuy then
      return tempCanBuy, 1
    end
  end
  return not giftInfo:IsSoldOut(), 0
end

function PayGiftController:SeekNextLinearSellGift(giftGroup)
  local list = {}
  if giftGroup == nil or not giftGroup:IsLinearGift() then
    return list
  end
  
  local function __SeekNextLinerSellGift(item)
    if not item:IsSoldOut() then
      table.insert(list, item)
      return
    end
    for k, v in pairs(item.groupCfg.afterGroup) do
      local nextItem = self.dataDic[k]
      if nextItem:IsUnlock() then
        __SeekNextLinerSellGift(nextItem)
      end
    end
  end
  
  __SeekNextLinerSellGift(giftGroup)
  return list
end

function PayGiftController:SendBuyGifitInfo(giftInfo, params, successFunc, directShowShop)
  if not giftInfo:IsUnlock() then
    CS_MessageCommon.ShowMessageTipsWithErrorSound(ConfigData:GetTipContent(7208))
    return
  end
  self:SendBuyGifit(giftInfo.defaultCfg, params, successFunc, directShowShop)
end

function PayGiftController:SendBuyGifit(giftCfg, params, successFunc, directShowShop)
  local payCtrl = ControllerManager:GetController(ControllerTypeId.Pay)
  local giftId = giftCfg.id
  local mdirectShowShop = false
  if directShowShop ~= nil then
    mdirectShowShop = directShowShop
  end
  local giftInfo = self:__GetGiftInfoByChildId(giftId)
  
  local function buyLogicFunc()
    local network = NetworkManager:GetNetwork(NetworkTypeID.PayGift)
    network:CS_Gift_Buy(giftId, params, function()
      if giftInfo:IsUseItemPay() then
        self:UpdatePayGift(giftInfo)
        MsgCenter:Broadcast(eMsgEventId.PayGiftChange, giftInfo.groupCfg.id)
        if successFunc ~= nil then
          successFunc()
        end
      else
        local payId = giftCfg.payId
        if payId ~= nil then
          payCtrl:ReqPay(payId, 1, function()
            self:UpdatePayGift(giftInfo)
            MsgCenter:Broadcast(eMsgEventId.PayGiftChange, giftInfo.groupCfg.id)
            if successFunc ~= nil then
              successFunc()
            end
          end, ConfigData:GetTipContent(297))
        end
      end
    end)
  end
  
  if giftInfo:IsUseItemPay() then
    local haveCost = PlayerDataCenter:GetItemCount(giftCfg.costId)
    if haveCost < giftCfg.costCount then
      if payCtrl:IsPayItem(giftCfg.costId) then
        payCtrl:TryConvertPayItem(giftCfg.costId, giftCfg.costCount - haveCost, nil, nil, function()
          buyLogicFunc()
        end, mdirectShowShop)
      else
        CS.MessageCommon.ShowMessageTipsWithErrorSound(ConfigData:GetTipContent(TipContent.Shop_MoneyInsufficient))
      end
      return
    end
  end
  buyLogicFunc()
end

function PayGiftController:SelfSelectGift(giftCfg, payGiftInfo, successFunc)
  local payCtrl = ControllerManager:GetController(ControllerTypeId.Pay)
  local giftId = giftCfg.id
  local giftInfo = self:__GetGiftInfoByChildId(giftId)
  local selfSelectParam = giftCfg.param
  if selfSelectParam == nil then
    return false
  end
  local selfSelectCfg = ConfigData.customized_gift[selfSelectParam]
  if selfSelectCfg == nil then
    return false
  end
  local SelfSelectGiftDealFunc = require("Game.PayGift.SelfSelectGiftDealFunc")
  local func = SelfSelectGiftDealFunc[selfSelectCfg.type]
  if func == nil then
    return false
  end
  func(selfSelectCfg, successFunc, payGiftInfo)
  return true
end

function PayGiftController:GetIsGiftSouldOut(giftGroupId)
  local giftInfo = self.dataDic[giftGroupId]
  if giftInfo ~= nil then
    return giftInfo:IsSoldOut()
  end
  return false
end

function PayGiftController:IsHaveNewGiftInShop(pageId)
  for giftId, paygiftInfo in pairs(self.dataDic) do
    if (pageId == nil or paygiftInfo.groupCfg.inPage == pageId) and paygiftInfo:IsUnlock() and paygiftInfo:IsNewGiftInShop() then
      return true
    end
  end
  return false
end

function PayGiftController:SetAllNewBeLooked(pageId)
  for giftId, paygiftInfo in pairs(self.dataDic) do
    if (pageId == nil or paygiftInfo.groupCfg.inPage == pageId) and paygiftInfo:IsUnlock() then
      paygiftInfo:SetNewGiftLooked()
    end
  end
end

function PayGiftController:GetHomePopGiftDic()
  return self._homeMainPopDic
end

function PayGiftController:GetHomePopGiftOne(needDelete)
  if self._homeMainPopList == nil then
    return nil
  end
  local giftId = self._homeMainPopList[self._homeMainPopListIndex]
  if giftId ~= nil and needDelete then
    self._homeMainPopDic[giftId] = nil
    self._homeMainPopList[self._homeMainPopListIndex] = nil
    self._homeMainPopListIndex = self._homeMainPopListIndex + 1
  end
  return giftId
end

function PayGiftController:CheckPayGiftCanPop(giftInfo)
  local flag = giftInfo:IsUnclockPopGift() and not giftInfo:IsSoldOut()
  if not flag then
    return false
  end
  local giftId = giftInfo.groupCfg.id
  local userData = PersistentManager:GetDataModel(PersistentConfig.ePackage.UserData)
  local time, endTime = userData:GetChipGiftPopIgnore(giftId)
  if time ~= nil then
    if endTime ~= nil and endTime < PlayerDataCenter.timestamp then
      return true
    end
    return false
  end
  return true
end

function PayGiftController:GetPopGiftType(giftInfo)
  return giftInfo:GetPopGiftType()
end

function PayGiftController:ShowPayGiftWin(giftInfo, callback)
  local groupPopId = giftInfo:GeyGiftGroupPopId()
  if 0 < groupPopId then
    Local_GroupPopFunc(groupPopId, callback, self)
    return
  end
  local winPopFunc = PopFuncDic[giftInfo:GetPopGiftType()]
  if winPopFunc ~= nil then
    winPopFunc(giftInfo, callback)
  else
    error("对应礼包弹窗类型不存在 " .. tostring(giftInfo:GetPopGiftType()))
    if callback ~= nil then
      callback()
    end
  end
end

function PayGiftController:ShowHeroGiftWin(giftInfo, callback)
  UIManager:ShowWindowAsync(UIWindowTypeID.CustomHeroGift, function(window)
    if IsNull(window) then
      return
    end
    window:InitCustomHeroGift(giftInfo, callback)
  end)
end

function PayGiftController:OnDelete()
  self._conditionListener:Delete()
  MsgCenter:RemoveListener(eMsgEventId.PreCondition, self.__ListenPreCondtion)
  base.OnDelete(self)
end

return PayGiftController
