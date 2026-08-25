local SummonPoolType = CommonDefine.SummonPoolType

local function createSummonPanelModelState(poolId, isMainBanner)
  local state = {}
  
  local function GetDefaultPoolTidList(numId)
    if not numId then
      return {}
    end
    local showList = SummonDataUtils.GetShowPoolList()
    for _, showData in ipairs(showList) do
      if table.contains(showData.poolTidList, numId) then
        return showData.poolTidList
      end
    end
    return {}
  end
  
  local function GetDefaultPoolId(numId)
    local defaultPoolId = numId
    local poolList = SummonDataUtils.GetSortedPoolList()
    assert(#poolList > 0, "没有卡池开启")
    if (nil == defaultPoolId or not SummonDataUtils.IsSummonPoolOpen(defaultPoolId)) and 0 ~= #poolList then
      defaultPoolId = poolList[1].tid
    end
    if defaultPoolId and not table.findvalue(poolList, defaultPoolId, "tid") then
      local curCfg = SummonDataUtils.GetSummonConfig(defaultPoolId)
      local isFind = false
      for _, poolData in ipairs(poolList) do
        local poolCfg = SummonDataUtils.GetSummonConfig(poolData.tid)
        if curCfg.Type == poolCfg.Type then
          defaultPoolId = poolData.tid
          isFind = true
          break
        end
      end
      if not isFind then
        defaultPoolId = poolList[1].tid
      end
    end
    local groupTids = GetDefaultPoolTidList(defaultPoolId)
    if #groupTids > 1 then
      local lastSelectedGroupPoolTid = SummonDataUtils.GetDefaultPoolTidByGroup(groupTids)
      if not numId or isMainBanner then
        defaultPoolId = lastSelectedGroupPoolTid
      else
        SummonDataUtils.SetLastSelectedGroupPoolTid(groupTids, numId)
      end
    end
    return defaultPoolId
  end
  
  state.curPoolId = GetDefaultPoolId(poolId, isMainBanner)
  state.poolTidList = GetDefaultPoolTidList(state.curPoolId)
  
  function state.poolCfg()
    return DT.Summon[state.curPoolId] or {}
  end
  
  function state.chooseItemTid()
    do return SummonDataUtils.GetChooseUpMapByType end
    return SummonDataUtils.GetChooseUpMapByType, state.poolCfg.Type
  end
  
  state.leftTimeText = ""
  
  function state.showCareerList()
    return DT.Constant.SummonCareerSelectList.Data
  end
  
  state.isMainBanner = isMainBanner
  state._isCashPurchasing = false
  state._chargedPoolIds = {}
  return state
end

local function createSummonPanelModelViews(model)
  local views = {}
  
  function views.GetCostNumText(costNum, isEnough)
    local numText = ItemNumUtils.GetStr(costNum)
    if not isEnough then
      numText = string.format("<Color4:%s>", numText)
    end
    return numText
  end
  
  function views:IsTenSummonDiscount()
    if SummonCfgUtils.IsCashDirectPurchasePool(self.curPoolId) then
      return false
    end
    local poolId = self.curPoolId
    local poolCfg = SummonDataUtils.GetSummonConfig(poolId)
    if not poolCfg then
      return false
    end
    local _, costItemNum = SummonDataUtils.Get10TimesPrice(poolId)
    if poolCfg.Type == SummonPoolType.Begin then
      return 0 ~= costItemNum
    end
    if poolCfg.TenTimesConsumeTicket then
      local discountedNum = poolCfg.TenTimesConsumeTicket[2]
      return discountedNum < CommonDefine.MultiSummonTimes
    else
      return false
    end
  end
  
  function views:HasChargedPool(targetPoolId)
    local poolId = targetPoolId or self.curPoolId
    return self._chargedPoolIds and self._chargedPoolIds[poolId] == true
  end
  
  function views:WeaponCntMaxCheck()
    local _, cnt = ItemDataUtils.GetWeaponCountInfo()
    local limitList = DT.GetOriginalConstant("BagCapacity")
    local maxCnt = limitList[1]
    if cnt >= maxCnt then
      local function confirmFunc()
        UIManager.Instance:Reopen(Urls.AlchemyMainPanel, AlchemyDefine.AlchemyType.Decompose)
      end
      
      Alert.Show(20090, nil, confirmFunc)
      return true
    else
      return false
    end
  end
  
  local TargetedSelectPoolTypes = DT.GetOriginalConstant("SelectSSRUPSummonType")
  
  function views:CheckTargetedPoolNotSelect(targetPoolTid)
    return self:CheckIsTargetedPool(targetPoolTid) and not model.chooseItemTid
  end
  
  function views:CheckIsTargetedPool(targetPoolTid)
    local targetPoolType = model.poolCfg.Type
    if targetPoolTid then
      local cfgPoolType = SummonCfgUtils.GetCfgField("Type", targetPoolTid)
      if cfgPoolType then
        targetPoolType = cfgPoolType
      end
    end
    do return table.contains, TargetedSelectPoolTypes end
    return table.contains, TargetedSelectPoolTypes, targetPoolType
  end
  
  return views
end

local function createSummonPanelModelActions(data)
  local actions = {}
  
  function actions:SetLeftTimeText(strVal)
    if not strVal then
      Logger.Error("Error Val")
      return
    end
    data.leftTimeText = strVal
  end
  
  function actions:SetChargedPool(poolId, flag)
    if not poolId then
      return
    end
    if not data._chargedPoolIds then
      data._chargedPoolIds = {}
    end
    data._chargedPoolIds[poolId] = flag
  end
  
  function actions:SetCashPurchasing(flag)
    data._isCashPurchasing = flag
  end
  
  function actions:SetCurrPoolId(numVal)
    if not numVal then
      Logger.Error("Error Val")
      return
    end
    data.curPoolId = numVal
  end
  
  function actions:SetPoolTidList(list)
    data.poolTidList = list
  end
  
  function actions:CheckCanSummon(targetPoolTid)
    if data:WeaponCntMaxCheck() then
      return false
    end
    local poolId = targetPoolTid or data.curPoolId
    if SummonDataUtils.NeedSelectBeforeSummon(poolId) then
      return false
    end
    if self:CheckTargetedPoolNotSelect(targetPoolTid) then
      Alert.ShowStr(LT.Text("SummonTargetPoolNotSelectTips"))
      return false
    end
    return true
  end
  
  function actions:CheckCanMultiSummon(targetPoolTid)
    local poolId = targetPoolTid or data.curPoolId
    if not self:CheckCanSummon(poolId) then
      return false
    end
    if not SummonDataUtils.IsLeftSummonTimes(poolId) then
      ErrorMsg.ShowErrCodeTips({code = 13628})
      return false
    end
    return true
  end
  
  function actions:ReqSingleSummon()
    if not self:CheckCanSummon() then
      return
    end
    local poolId = data.curPoolId
    SummonDataUtils.SetSummonGainShowList({})
    
    local function ReqSummon()
      SummonDataUtils.ReqSummon(poolId, 1, CommonDefine.SummonType.Normal, function(summonResult)
        local function showRewardFunc()
          PopTipsManager.Instance:SetTutorialLock(false)
        end
        
        UIManager.Instance:CloseByUrl(Urls.SummonedAwakerPanel)
        UIManager.Instance:Reopen(Urls.SummonResultPanel, summonResult, poolId, true, showRewardFunc, nil, data)
        if SummonDataUtils.IsLuckyBagPool(poolId) then
          EventMgr.Instance.OnLuckyBagSummon:Dispatch()
        end
      end)
    end
    
    local costItemId, costItemNum = SummonDataUtils.GetSummonCostInfo(poolId)
    local ownedNum = ItemDataUtils.GetItemNum(costItemId)
    if costItemNum > ownedNum then
      local confirmFunc = ReqSummon
      local buyTicketItemId, buyTicketItemNum = SummonDataUtils.GetTicketCostInfo(poolId)
      local tipTid = DT.Summon[poolId].Type == SummonPoolType.NormalWeapon and 20047 or 20048
      local desc = LT.Textf(DT.TipsType[tipTid].Desc, 1, ItemDataUtils.GetItemName(costItemId), buyTicketItemNum)
      if buyTicketItemNum > ItemDataUtils.GetItemNum(buyTicketItemId) then
        function confirmFunc()
          DiamondShopDataUtils.RechargeTips(buyTicketItemNum - ItemDataUtils.GetItemNum(buyTicketItemId))
        end
      end
      Alert.Show(tipTid, nil, confirmFunc, nil, desc)
      return
    end
    if ItemDataUtils.IsPayMoneyType(costItemId) then
      Alert.ShowPayMoneyBuyConfirm(costItemNum, ReqSummon)
    else
      ReqSummon()
    end
  end
  
  function actions:ReqMultiSummon(summonTimes, callback, targetPoolTid)
    local poolId = targetPoolTid or data.curPoolId
    if not self:CheckCanMultiSummon(poolId) then
      return
    end
    SummonDataUtils.SetSummonGainShowList({})
    
    local function ReqSummon()
      SummonDataUtils.ReqSummon(poolId, summonTimes, CommonDefine.SummonType.Normal, SummonDataUtils.BuildSummonResultCallback(poolId, data, function()
        if summonTimes == CommonDefine.MultiSummonTimes then
          SummonDataUtils.UseFreeFiveSummon(poolId, 1)
        end
        if callback then
          callback()
        end
      end))
    end
    
    local function GetMultiSummonCost()
      local costItemId, costItemNum = SummonDataUtils.Get10TimesPrice(poolId)
      if SummonDataUtils.IsSummonPoolHaveFree(poolId) > 0 and summonTimes == CommonDefine.MultiSummonTimes then
        costItemNum = 0
      end
      return costItemId, costItemNum
    end
    
    local function HandleCurrencyNotEnough(costItemId, lackNum)
      if costItemId == CommonDefine.CurrencyType.PayMoney then
        DiamondShopDataUtils.ChargeNotEnoughTips()
        return
      end
      local ticketCostItemId, ticketCostItemNum = SummonDataUtils.GetTicketCostInfo(poolId)
      local costDiamondNum = ticketCostItemNum * lackNum - ItemDataUtils.GetItemNum(ticketCostItemId)
      if costItemId == CommonDefine.CurrencyType.SeniorMoney then
        DiamondShopDataUtils.RechargeTips(costDiamondNum)
      else
        local confirmFunc = ReqSummon
        local tipTid = 20048
        local desc = LT.Textf(DT.TipsType[tipTid].Desc, lackNum, ItemDataUtils.GetItemName(costItemId), ticketCostItemNum * lackNum)
        if ItemDataUtils.GetItemNum(ticketCostItemId) < ticketCostItemNum * lackNum then
          function confirmFunc()
            DiamondShopDataUtils.RechargeTips(costDiamondNum)
          end
        end
        Alert.Show(tipTid, nil, confirmFunc, nil, desc)
      end
    end
    
    local function TryOpenPriorityNotEnoughView(costItemId, lackNum)
      local poolCfg = SummonDataUtils.GetSummonConfig(poolId)
      local priorityConsumeTicket = poolCfg and poolCfg.PriorityConsumeTicket
      local consumeTicket = poolCfg and poolCfg.ConsumeTicket
      if not priorityConsumeTicket or costItemId ~= priorityConsumeTicket[1] then
        return false
      end
      local consumeTicketItemId = consumeTicket and consumeTicket[1]
      if consumeTicketItemId and consumeTicketItemId ~= costItemId then
        SummonController.Instance:OnOpenSummonPriorityNotEnoughView({
          lackNum = lackNum,
          confirmFunc = function()
            local haveNum = ItemDataUtils.GetItemNum(consumeTicketItemId)
            if haveNum >= lackNum then
              ReqSummon()
              return
            end
            HandleCurrencyNotEnough(consumeTicketItemId, lackNum - haveNum)
          end
        })
        return true
      end
      return false
    end
    
    local costMultiItemId, costMultiItemNum = GetMultiSummonCost()
    local ownedNum = ItemDataUtils.GetItemNum(costMultiItemId)
    if costMultiItemNum > ownedNum then
      local lackNum = costMultiItemNum - ownedNum
      if TryOpenPriorityNotEnoughView(costMultiItemId, lackNum) then
        return
      end
      HandleCurrencyNotEnough(costMultiItemId, lackNum)
      return
    end
    if ItemDataUtils.IsPayMoneyType(costMultiItemId) then
      Alert.ShowPayMoneyBuyConfirm(costMultiItemNum, ReqSummon)
    else
      ReqSummon()
    end
  end
  
  function actions:ReqCashDirectPurchase()
    local poolId = data.curPoolId
    local chargeId, _ = SummonCfgUtils.GetCashDirectPurchaseChargeInfo(poolId)
    if not chargeId then
      Logger.Error("[SummonPanelModel] ReqCashDirectPurchase: 找不到充值项 poolId=%s", tostring(poolId))
      return
    end
    local chargeCfg = ShopDataUtils.GetChargeCfgById(chargeId)
    if not chargeCfg then
      Logger.Error("[SummonPanelModel] ReqCashDirectPurchase: chargeCfg 为空 chargeId=%s", tostring(chargeId))
      return
    end
    self:SetCashPurchasing(true)
    self:SetChargedPool(poolId, true)
    local callbackReceived = false
    local payTimeoutTimer = TimerManager.Instance:CreateTimer(60, 0, nil, function()
      if not callbackReceived then
        self:SetCashPurchasing(false)
      end
    end)
    SdkMgr.Instance:Pay(chargeCfg.PayCode, chargeId, function(payCode, id, isSuccess)
      callbackReceived = true
      if payTimeoutTimer then
        TimerManager.Instance:StopTimer(payTimeoutTimer)
        payTimeoutTimer = nil
      end
      self:SetCashPurchasing(false)
      if isSuccess then
        if UIManager.Instance:GetWindow(Urls.SummonPanel) then
          local autoResult = SummonDataUtils.TryAutoSummonByItemCount(poolId)
          if autoResult then
            self:SetChargedPool(poolId, nil)
          end
        end
      else
        self:SetChargedPool(poolId, nil)
      end
    end, true)
  end
  
  return actions
end

local function onSetup(_, _)
end

local SummonPanelModelModel = Vue.model("SummonPanelModelModel", createSummonPanelModelState):views(createSummonPanelModelViews):actions(createSummonPanelModelActions):setup(onSetup)
return SummonPanelModelModel
