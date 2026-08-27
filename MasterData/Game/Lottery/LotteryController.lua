local LotteryController = class("LotteryController", ControllerBase)
local base = ControllerBase
local LotteryEnum = require("Game.Lottery.LotteryEnum")
local LotteryShowCtrl = require("Game.Lottery.Ctrl.LotteryShowCtrl")
local ShopEnum = require("Game.Shop.ShopEnum")
local JumpManager = require("Game.Jump.JumpManager")
local cs_MessageCommon = CS.MessageCommon
local cs_camera = CS.UnityEngine.Camera
local cs_MicaSDKManager = CS.MicaSDKManager
local RequestPreview = require("Game.RequestPreview.RequestPreview")
local CommonRewardData = require("Game.CommonUI.CommonRewardData")

function LotteryController:ctor()
  self.ctrls = {}
  self.ltrShowCtrl = LotteryShowCtrl.New(self)
  self.__lotteryState = LotteryEnum.eLotteryState.None
  self._ResetAllPoolFunc = BindCallback(self, self._ResetAllPool)
  self._ResetLtrStateFunc = BindCallback(self, self._ResetLtrState)
end

function LotteryController:OnInit()
  self.networkCtrl = NetworkManager:GetNetwork(NetworkTypeID.Lottery)
  self.dailyLotteryLimtNum = ConfigData.game_config.DailyLotteryLimtNum
  self.__mianCam = cs_camera.main
end

function LotteryController:InitLottery(showWindowCallback, defaultSelectPoolId, defaultPoolGroupId)
  self:_InitLtrPoolData()
  local poolIndex, inGroupLtrData = self:GenSelectLtrPool(defaultSelectPoolId, defaultPoolGroupId)
  UIManager:ShowWindowAsync(UIWindowTypeID.LotteryWindow, function(win)
    if win ~= nil then
      if showWindowCallback ~= nil then
        showWindowCallback(win)
      end
      win:InitUILottery(self, self.poolGroupDataList, poolIndex, inGroupLtrData)
      self:ChangeLotteryState(LotteryEnum.eLotteryState.Normal)
    end
  end)
end

function LotteryController:_InitLtrPoolData(defaultSelectPoolId)
  self.poolGroupDataList = PlayerDataCenter.allLtrData:GetOpeningLtrGroupPoolDataList()
end

function LotteryController:GenSelectLtrPool(selectPoolId, selectGroupId)
  local inGroupLtrData
  local poolIndex = 1
  for index, poolGroupData in ipairs(self.poolGroupDataList) do
    if poolGroupData:HasLtrMoreGroup() and selectGroupId then
      local groupId = poolGroupData:GetLtrMoreGroupId()
      if groupId == selectGroupId then
        poolIndex = index
        break
      end
    end
    if poolGroupData:ContainLtrGroupPool(selectPoolId) then
      poolIndex = index
      if poolGroupData:HasLtrMoreGroup() then
        inGroupLtrData = PlayerDataCenter.allLtrData.ltrDataDic[selectPoolId]
      end
      break
    end
  end
  return poolIndex, inGroupLtrData
end

function LotteryController:ChangeLotteryState(state)
  self.__lotteryState = state
  if state == LotteryEnum.eLotteryState.Normal then
    GuideManager:TryTriggerGuide(eGuideCondition.InLottery)
  end
end

function LotteryController:IsLotteryNormalState()
  return self.__lotteryState == LotteryEnum.eLotteryState.Normal
end

function LotteryController:SelectLtrPool(poolId)
  self.curPoolId = poolId
  if self:CheckLtrPoolExpired() then
    return
  end
  self.curLtrPoolCfg = ConfigData.lottery_para[poolId]
  self.curLtrPoolData = PlayerDataCenter.allLtrData.ltrDataDic[poolId]
  self.enableExcuteFree = self.curLtrPoolCfg.cd ~= 0
end

function LotteryController:_CheckLtrNumOk(ltrNum)
  local curNum = self.curLtrPoolData:GetLtrPoolDayNum()
  if ltrNum > self.dailyLotteryLimtNum - curNum then
    cs_MessageCommon.ShowMessageTipsWithErrorSound(ConfigData:GetTipContent(TipContent.lottery_DailyLimtFull))
    return false
  end
  return true
end

function LotteryController:LtrCheckSpecialSelect()
  if self.curLtrPoolData:IsLtrSpecialSelectHero() and self.curLtrPoolData:GetLtrSpeSelectedList() == nil then
    cs_MessageCommon.ShowMessageTipsWithErrorSound(ConfigData:GetTipContent(9716))
    return false
  end
  return true
end

function LotteryController:_OnLtrDrawComplete(objList, notNeedPopPreview)
  if objList.Count < 1 then
    error("objList.Count error:" .. tostring(objList.Count))
    return
  end
  local elemList = objList[0]
  self:GenLtrResult(elemList, notNeedPopPreview)
  local ltrWin = UIManager:GetWindow(UIWindowTypeID.LotteryWindow)
  if ltrWin ~= nil then
    ltrWin:RefreshCurLtrChangedUI()
  end
end

function LotteryController:LtrDrawOne(customCallback)
  if self:CheckLtrPoolExpired() then
    return
  end
  if not self:_CheckLtrNumOk(1) then
    return
  end
  if not self:LtrCheckSpecialSelect() then
    return
  end
  local itemCount = PlayerDataCenter:GetItemCount(self.curLtrPoolCfg.costId1)
  local drawOverCallback
  if customCallback == nil then
    if self.__onDrawOneComplete == nil then
      self.__onDrawOneComplete = BindCallback(self, self.OnLtrDrawOneComplete)
    end
    drawOverCallback = self.__onDrawOneComplete
  else
    drawOverCallback = customCallback
  end
  
  local function executeOneFunc()
    if self:CheckLtrPoolExpired() then
      return
    end
    self:__BeforeDrawFunc()
    self.networkCtrl:SendExecuteOnce(self.curPoolId, drawOverCallback)
  end
  
  if self.curLtrPoolData:IsLtrExecOneceFree() then
    executeOneFunc()
  elseif itemCount >= self.curLtrPoolCfg.costNum1 then
    self:OnConsumptionEnough(self.curLtrPoolCfg.costId1, self.curLtrPoolCfg.costNum1, executeOneFunc)
  else
    self:OnConsumptionNotEnough(self.curLtrPoolCfg.costId1, itemCount, self.curLtrPoolCfg.costNum1, executeOneFunc)
  end
end

function LotteryController:OnLtrDrawOneComplete(objList, notNeedPopPreview)
  self:_OnLtrDrawComplete(objList, notNeedPopPreview)
  if cs_MicaSDKManager.Instance:IsUseSdk() and Consts.GameChannelType.IsOversea() and self.curLtrPoolCfg.costId1 == ConstGlobalItem.LotteryTicket1 and self.curLtrPoolCfg.costNum1 == 1 then
    cs_MicaSDKManager.Instance:StatsEventPreSetUid("gacha_1")
  end
end

function LotteryController:LtrDrawTen(customCallback)
  if self:CheckLtrPoolExpired() then
    return
  end
  if not self:_CheckLtrNumOk(10) then
    return
  end
  if not self:LtrCheckSpecialSelect() then
    return
  end
  local drawOverCallback
  if customCallback == nil then
    if self.__onDrawTenComplete == nil then
      self.__onDrawTenComplete = BindCallback(self, self.OnLtrDrawTenComplete)
    end
    drawOverCallback = self.__onDrawTenComplete
  else
    drawOverCallback = customCallback
  end
  
  local function executeTenFunc()
    if self:CheckLtrPoolExpired() then
      return
    end
    self:__BeforeDrawFunc()
    self.networkCtrl:SendExecuteTen(self.curPoolId, drawOverCallback)
  end
  
  if self.curLtrPoolData:LtrCurTenIsPrior() then
    executeTenFunc()
    return
  end
  local itemCount = PlayerDataCenter:GetItemCount(self.curLtrPoolCfg.costId2)
  if itemCount >= self.curLtrPoolCfg.costNum2 then
    self:OnConsumptionEnough(self.curLtrPoolCfg.costId2, self.curLtrPoolCfg.costNum2, executeTenFunc)
  else
    self:OnConsumptionNotEnough(self.curLtrPoolCfg.costId2, itemCount, self.curLtrPoolCfg.costNum2, executeTenFunc)
  end
end

function LotteryController:OnLtrDrawTenComplete(objList, notNeedPopPreview)
  self:_OnLtrDrawComplete(objList, notNeedPopPreview)
  if cs_MicaSDKManager.Instance:IsUseSdk() and Consts.GameChannelType.IsOversea() and self.curLtrPoolCfg.costId2 == ConstGlobalItem.LotteryTicket1 and self.curLtrPoolCfg.costNum2 == 10 then
    cs_MicaSDKManager.Instance:StatsEventPreSetUid("gacha_10")
  end
end

function LotteryController:LtrDrawSpecialOne()
  if self:CheckLtrPoolExpired() then
    return
  end
  if not self:_CheckLtrNumOk(1) then
    return
  end
  if not self:LtrCheckSpecialSelect() then
    return
  end
  local itemCount = PlayerDataCenter:GetItemCount(self.curLtrPoolCfg.costId3)
  self.__onDrawSpecialOneComplete = self.__onDrawSpecialOneComplete or BindCallback(self, self.OnLtrDrawSpecialOneComplete)
  
  local function executeFunc()
    if self:CheckLtrPoolExpired() then
      return
    end
    self:__BeforeDrawFunc()
    self.networkCtrl:CS_LOTTERY_ExecOnceSpecial(self.curPoolId, self.__onDrawSpecialOneComplete)
  end
  
  if itemCount >= self.curLtrPoolCfg.costNum3 then
    self:OnConsumptionEnough(self.curLtrPoolCfg.costId3, self.curLtrPoolCfg.costNum3, executeFunc)
  else
    self:OnConsumptionNotEnough(self.curLtrPoolCfg.costId3, itemCount, self.curLtrPoolCfg.costNum3, executeFunc)
  end
end

function LotteryController:OnLtrDrawSpecialOneComplete(objList)
  self:_OnLtrDrawComplete(objList)
end

function LotteryController:LtrCustomDraw(ltrNum)
  if self:CheckLtrPoolExpired() then
    return
  end
  if not self:_CheckLtrNumOk(ltrNum) then
    return
  end
  if not self:LtrCheckSpecialSelect() then
    return
  end
  
  local function excuteFunc()
    if self:CheckLtrPoolExpired() then
      return
    end
    self:__BeforeDrawFunc()
    self.__onLtrCustomDrawComplete = self.__onLtrCustomDrawComplete or BindCallback(self, self.LtrCustomDrawComplete)
    self.networkCtrl:CS_LOTTERY_CustomisedQtt(self.curPoolId, ltrNum, self.__onLtrCustomDrawComplete)
  end
  
  local itemCount = PlayerDataCenter:GetItemCount(self.curLtrPoolCfg.costId1)
  local costNum = self.curLtrPoolCfg.costNum1 * ltrNum
  if itemCount >= costNum then
    self:OnConsumptionEnough(self.curLtrPoolCfg.costId1, costNum, excuteFunc)
  else
    self:OnConsumptionNotEnough(self.curLtrPoolCfg.costId1, itemCount, costNum, excuteFunc)
  end
end

function LotteryController:LtrCustomDrawComplete(objList)
  self:_OnLtrDrawComplete(objList)
end

function LotteryController:LtrFreeSelect(itemId)
  if self:CheckLtrPoolExpired() then
    return
  end
  self.__OnLtrFreeSelectComplete = self.__OnLtrFreeSelectComplete or BindCallback(self, self.OnLtrFreeSelectComplete)
  self:ChangeLotteryState(LotteryEnum.eLotteryState.LotteryAnimation)
  self._heroIdSnapShoot = PlayerDataCenter:TakeHeroIdSnapShoot()
  self._freeChoiceItemId = itemId
  self.networkCtrl:CS_LOTTERY_IndepChoice(self.curPoolId, itemId, self.__OnLtrFreeSelectComplete)
end

function LotteryController:LtrFreeSelectJudge()
  if self:CheckLtrPoolExpired() then
    return
  end
  local itemCount = self.curLtrPoolCfg.costNum4
  local PaidItemNum = PlayerDataCenter:GetItemCount(ConstGlobalItem.PaidItem)
  local FreeItemNum = PlayerDataCenter:GetItemCount(ConstGlobalItem.PaidSubItem)
  
  local function executeFunc()
    local win = UIManager:GetWindow(UIWindowTypeID.LotterySelectHero)
    if win ~= nil then
      win:ConfimFreeSelectHero(self)
    end
  end
  
  if itemCount > FreeItemNum then
    local needItemNum = itemCount - FreeItemNum
    local assignMsg = string.format(ConfigData:GetTipContent(10008), needItemNum, needItemNum)
    if Consts.GameChannelType.IsJp() then
      assignMsg = assignMsg .. ConfigData:GetTipContent(334)
    end
    local shopCtrl = ControllerManager:GetController(ControllerTypeId.Shop, true)
    
    local function executeBuyBeforeFunc()
      shopCtrl:ReqExchangeGoods(ConstGlobalItem.PaidSubItem, needItemNum, executeFunc)
    end
    
    self:OnConsumptionNotEnough(ConstGlobalItem.PaidSubItem, FreeItemNum, itemCount, executeBuyBeforeFunc, assignMsg)
  else
    executeFunc()
  end
end

function LotteryController:OnLtrFreeSelectComplete()
  local objList = {}
  objList.Count = 1
  objList[0] = {}
  local owned = PlayerDataCenter.heroDic[self._freeChoiceItemId] ~= nil
  local temp = {}
  temp.firstReward = owned
  temp.item = self._freeChoiceItemId
  temp.num = 1
  table.insert(objList[0], temp)
  self:OnLtrDrawOneComplete(objList, true)
end

function LotteryController:ReqExchangeLtrPtReward(itemId, extraAward)
  if self:CheckLtrPoolExpired() then
    return
  end
  self._ptExchangeItemId = itemId
  self._extraAward = extraAward
  self._heroIdSnapShoot = PlayerDataCenter:TakeHeroIdSnapShoot()
  self._OnExchangeLtrPtRewardFunc = self._OnExchangeLtrPtRewardFunc or BindCallback(self, self._OnExchangeLtrPtReward)
  self.networkCtrl:CS_LOTTERY_PickPt(self.curPoolId, itemId, self._OnExchangeLtrPtRewardFunc)
end

function LotteryController:_OnExchangeLtrPtReward()
  local ltrWin = UIManager:GetWindow(UIWindowTypeID.LotteryWindow)
  if ltrWin ~= nil then
    ltrWin:RefreshCurLtrChangedUI()
  end
  local ltrExWin = UIManager:GetWindow(UIWindowTypeID.LotteryExchange)
  if ltrExWin ~= nil then
    ltrExWin.ltrPtNode:ReFreshLtrPtUI()
  end
  local upHeroFragDic = self.curLtrPoolData:GetLtrUpHeroFragDic()
  UIManager:ShowWindowAsync(UIWindowTypeID.CommonReward, function(window)
    if window == nil then
      return
    end
    local ltrWin = UIManager:GetWindow(UIWindowTypeID.LotteryWindow)
    if ltrWin then
      ltrWin:EnableLtrVideo(false)
    end
    local rewardIds = {}
    local rewardNums = {}
    table.insert(rewardIds, self._ptExchangeItemId)
    table.insert(rewardNums, 1)
    if self._extraAward ~= nil then
      for id, num in pairs(self._extraAward) do
        table.insert(rewardIds, id)
        table.insert(rewardNums, num)
      end
    end
    if upHeroFragDic ~= nil then
      for heroId, num in pairs(upHeroFragDic) do
        local fragId = ConfigData.hero_data[heroId].fragment
        table.insert(rewardIds, fragId)
        table.insert(rewardNums, num)
        break
      end
    end
    local CRData = CommonRewardData.CreateCRDataUseList(rewardIds, rewardNums):SetCRHeroSnapshoot(self._heroIdSnapShoot):SetCRHeroUpFragDic(upHeroFragDic):SetCRShowOverFunc(function()
      local ltrWin = UIManager:GetWindow(UIWindowTypeID.LotteryWindow)
      if ltrWin then
        ltrWin:EnableLtrVideo(true)
      end
    end)
    window:AddAndTryShowReward(CRData)
  end)
end

function LotteryController:__BeforeDrawFunc()
  self:ChangeLotteryState(LotteryEnum.eLotteryState.LotteryAnimation)
  self._heroIdSnapShoot = PlayerDataCenter:TakeHeroIdSnapShoot()
  NoticeManager:PuaseShowNotice("lottery")
end

function LotteryController:GenLtrResult(elemList, notNeedPopPreview)
  local newElemList = elemList
  local showRareList = {}
  local heroIdList = {}
  local newHeroIndexDic = {}
  local acquiredHeroIdDic = {}
  for k, elem in ipairs(newElemList) do
    local itemId = elem.item
    local itemCfg = ConfigData.item[itemId]
    if itemCfg == nil then
      error("Can't find item, id = " .. tostring(itemId))
    else
      elem.itemCfg = itemCfg
      local rare = eHeroCardRareType.R
      if itemCfg.action_type == eItemActionType.HeroCard then
        local heroId = itemCfg.arg[1]
        local heroData = PlayerDataCenter.heroDic[heroId]
        table.insert(heroIdList, heroId)
        local isNewHero = self._heroIdSnapShoot[heroId] ~= true and not acquiredHeroIdDic[heroId]
        newHeroIndexDic[#heroIdList] = isNewHero
        elem.isNewHero = isNewHero
        local rankCfg = ConfigData.hero_rank[heroData.heroCfg.rank]
        if rankCfg == nil then
          error("Can't find rankCfg, id = " .. tostring(heroData.heroCfg.rank))
          goto lbl_79
        else
          rare = rankCfg.rare
        end
        elem.heroData = heroData
        acquiredHeroIdDic[heroId] = true
      end
      table.insert(showRareList, rare)
    end
    ::lbl_79::
  end
  UIManager:ShowWindow(UIWindowTypeID.ClickContinue):InitContinue(nil, nil, nil, Color.black, false)
  UIManager:ShowWindowAsync(UIWindowTypeID.LotteryShow, function(window)
    if window == nil then
      return
    end
    window:InitLotteryShow(self.ltrShowCtrl)
    self:__SetMainCamActive(false)
    self.ltrShowCtrl:LtrShowStart(showRareList, self.curLtrPoolCfg.pool_client_type, notNeedPopPreview)
  end)
  
  local function backFun()
    local UILottery = UIManager:GetWindow(UIWindowTypeID.LotteryWindow)
    if UILottery ~= nil then
      UILottery:__RefreshGuaranteeState()
    end
  end
  
  TimerManager:StartTimer(0.1, backFun, self, true, false, false)
  self.heroIdList = heroIdList
  self.newHeroIndexDic = newHeroIndexDic
  self.upHeroFragDic = self.curLtrPoolData:GetLtrUpHeroFragDic()
  self.rewardElemList = newElemList
end

function LotteryController:LtrShowEnd(isSkip, notNeedPopPreview)
  UIManager:HideWindow(UIWindowTypeID.LotteryShow)
  UIUtil.PopFromBackStackByWinId(UIWindowTypeID.LotteryShow)
  if self.rewardElemList == nil then
    return
  end
  if #self.heroIdList == 0 then
    self:LtrHeroShowEnd(true, notNeedPopPreview)
    return
  end
  local newHeroCount = 0
  for heroid, hasNew in pairs(self.newHeroIndexDic) do
    if hasNew then
      newHeroCount = newHeroCount + 1
    end
  end
  if isSkip and newHeroCount == 0 then
    self:LtrHeroShowEnd(true, notNeedPopPreview)
  else
    UIManager:ShowWindowAsync(UIWindowTypeID.GetHero, function(window)
      if window == nil then
        return
      end
      if self.upHeroFragDic ~= nil then
        window:SetGetHeroConvertFrag(self.upHeroFragDic)
      end
      window:InitGetHeroList(self.heroIdList, false, true, self.newHeroIndexDic, function()
        self:LtrHeroShowEnd(false, notNeedPopPreview)
      end, isSkip)
      self:_HideLtrShow()
    end)
  end
end

function LotteryController:LtrHeroShowEnd(withHideShow, notNeedPopPreview)
  UIManager:ShowWindowAsync(UIWindowTypeID.LotteryResult, function(window)
    UIManager:ShowWindow(UIWindowTypeID.LotteryWindow)
    NoticeManager:ContinueShowNotice("lottery")
    if window == nil then
      return
    end
    local isConvrtFrag = self.curLtrPoolData:IsLtrHeroConvertFrag()
    window:InitLtrResult(self.rewardElemList, isConvrtFrag, self.upHeroFragDic)
    window:BindLotteryResultExit(function()
      self:OnLotteryComplete(notNeedPopPreview)
    end)
    if #self.rewardElemList == 1 then
      AudioManager:PlayAudioById(1115)
    else
      AudioManager:PlayAudioById(1114)
    end
    if withHideShow then
      self:_HideLtrShow()
    else
      UIManager:DeleteWindow(UIWindowTypeID.GetHero)
    end
  end)
end

function LotteryController:_ResetLtrState()
  local lotteryWindow = UIManager:GetWindow(UIWindowTypeID.LotteryWindow)
  if lotteryWindow == nil then
    self:ChangeLotteryState(LotteryEnum.eLotteryState.None)
  else
    self:ChangeLotteryState(LotteryEnum.eLotteryState.Normal)
  end
end

function LotteryController:OnLotteryComplete(notNeedPopPreview)
  self:_ResetLtrState()
  UIManager:ShowWindowOnly(UIWindowTypeID.TopStatus)
  self:CheckLtrPoolExpired(true)
  if not notNeedPopPreview then
    RequestPreview:TryRequestReview(self.rewardElemList)
  end
end

function LotteryController:_HideLtrShow()
  self.ltrShowCtrl:HideLtrShow()
  self:__SetMainCamActive(true)
end

function LotteryController:CheckLtrPoolExpired(immediateRefresh)
  if not PlayerDataCenter.allLtrData:GetIsSpecificPoolOpen(self.curPoolId) then
    if immediateRefresh then
      self._ResetAllPoolFunc()
    else
      cs_MessageCommon.ShowMessageBoxConfirm(ConfigData:GetTipContent(TipContent.Ltr_PoolExpired), self._ResetAllPoolFunc)
    end
    return true
  end
  return false
end

function LotteryController:_ResetAllPool()
  self:_InitLtrPoolData()
  local window = UIManager:GetWindow(UIWindowTypeID.LotteryWindow)
  if window ~= nil then
    window:RefreshLtrPoolUI(self.poolGroupDataList)
  end
  local window = UIManager:GetWindow(UIWindowTypeID.FairyLottery)
  if window ~= nil then
    window:InitFairyLottery()
  end
end

function LotteryController:OnConsumptionEnough(costId, costNum, executeFunc)
  if self.curLtrPoolCfg.pool_client_type == LotteryEnum.eLotteryPoolType.Paid then
    local costName = LanguageUtil.GetLocaleText(ConfigData.item[costId].name)
    local msg = string.format(ConfigData:GetTipContent(303), tostring(costNum), costName)
    if Consts.GameChannelType.IsJp() then
      msg = msg .. ConfigData:GetTipContent(334)
    end
    if ConfigData.game_config.ltrShowDontHintCurrencyDic[costId] then
      if PlayerDataCenter.cacheSaveData:GetEnableLotteryPaidExecuteConfirm() then
        local window = UIManager:ShowWindow(UIWindowTypeID.MessageCommon)
        window:ShowItemCost(msg, costId, costNum, executeFunc, nil, true)
        window:ShowDontRemindTog(function(isOn)
          PlayerDataCenter.cacheSaveData:SetEnableLotteryPaidExecuteConfirm(not isOn)
        end)
        return
      end
    else
      local window = UIManager:ShowWindow(UIWindowTypeID.MessageCommon)
      window:ShowItemCost(msg, costId, costNum, executeFunc, nil, true)
      return
    end
  end
  executeFunc()
end

function LotteryController:OnConsumptionNotEnough(itemId, containNum, costNum, executeFunc, assignMsg)
  local costItemName = LanguageUtil.GetLocaleText(ConfigData.item[itemId].name)
  if self.curLtrPoolCfg.pool_client_type == LotteryEnum.eLotteryPoolType.NoPaid then
    local isFairy = self.curLtrPoolCfg.pool_type == LotteryEnum.eLotteryPoolLogicType.fairy
    if isFairy then
      local info = string.format(ConfigData:GetTipContent(12102), costItemName, costItemName)
      cs_MessageCommon.ShowMessageBox(info, function()
        local shopId = ShopEnum.ShopId.resident
        JumpManager:Jump(JumpManager.eJumpTarget.DynShop, nil, nil, {
          shopId,
          0,
          6
        }, true)
      end, nil)
      return
    end
    local msg = costItemName .. ConfigData:GetTipContent(TipContent.lottery_ItemInsufficient)
    local window = UIManager:ShowWindow(UIWindowTypeID.MessageCommon)
    window:ShowItemCostConfirm(msg, itemId, costNum, nil, true)
  elseif self.curLtrPoolCfg.pool_client_type == LotteryEnum.eLotteryPoolType.Paid then
    local quickBuyData = ShopEnum.eQuickBuy.lottery
    local shopId = quickBuyData.shopId
    local needItemNum = costNum - containNum
    local shopCtrl = ControllerManager:GetController(ControllerTypeId.Shop, true)
    
    local function checkShopOpenFunc()
      if not shopCtrl:ShopIsUnlock(shopId) then
        local msg = costItemName .. ConfigData:GetTipContent(TipContent.lottery_ItemInsufficient)
        local window = UIManager:ShowWindow(UIWindowTypeID.MessageCommon)
        window:ShowItemCostConfirm(msg, itemId, costNum, nil, true)
        return false
      end
      return true
    end
    
    local payCtrl = ControllerManager:GetController(ControllerTypeId.Pay, true)
    if itemId == ConstGlobalItem.PaidSubItem then
      self:__PaidCurrencyExecute(ConstGlobalItem.PaidSubItem, costNum, itemId, needItemNum, executeFunc, assignMsg)
      return
    elseif itemId == ConstGlobalItem.PaidItem then
      if checkShopOpenFunc() then
        payCtrl:Jump2BuyQuartz(nil, nil, true)
      end
      return
    end
    if not checkShopOpenFunc() then
      return
    end
    shopCtrl:GetShopData(shopId, function(shopData)
      local goodData = shopData:GetNormalShopGoodByItemId(itemId)
      if goodData == nil then
        error("Cant get goodData from normalShop, itemId = " .. itemId)
        return
      end
      local needCurrencyNum = goodData.newCurrencyNum * needItemNum
      self:__PaidCurrencyExecute(goodData.currencyId, needCurrencyNum, itemId, needItemNum, function()
        shopCtrl:ReqBuyGoods(goodData.shopId, goodData.shelfId, needItemNum, function()
          executeFunc()
        end)
      end)
    end)
  end
end

function LotteryController:__PaidCurrencyExecute(currencyId, needCurrencyNum, needItemId, needItemNum, executeFunc, assignMsg)
  local payCtrl = ControllerManager:GetController(ControllerTypeId.Pay, true)
  return payCtrl:PaidCurrencyExecute(currencyId, needCurrencyNum, needItemId, needItemNum, executeFunc, assignMsg)
end

function LotteryController:__SetMainCamActive(active)
  if not IsNull(self.__mianCam) then
    self.__mianCam.gameObject:SetActive(active)
  end
end

function LotteryController:IsInLotteryShow()
  return self.__lotteryState == LotteryEnum.eLotteryState.LotteryAnimation
end

function LotteryController:SelectGroupPoolSuccess(newPoolId)
  local poolGroupId = ConfigData.lottery_group.ltrGroupIdMap[newPoolId]
  local allLtrData = PlayerDataCenter.allLtrData
  if allLtrData:GetIsSelectByGroupId(poolGroupId) == newPoolId then
    return
  end
  allLtrData:SetIsSelectSuccess(poolGroupId, newPoolId)
  self.networkCtrl:CS_LOTTERY_SelectPool(poolGroupId, newPoolId)
end

function LotteryController:ReqLtrSpeSelectHero(ltrData, itemIdList, callBack)
  local poolId = ltrData.poolId
  local rewardType = ltrData:GetLtrSpeSelectHeroRewardType()
  self.networkCtrl:CS_LOTTERY_CUSTOM(poolId, rewardType, itemIdList, callBack)
end

function LotteryController:OnDelete()
  PersistentManager:SaveModelData(PersistentConfig.ePackage.UserData)
  self:ChangeLotteryState(LotteryEnum.eLotteryState.None)
  self:__SetMainCamActive(true)
  for k, v in pairs(self.ctrls) do
    v:OnDelete()
  end
end

return LotteryController
