_class("UIRecruitAction", Object)
UIRecruitAction = UIRecruitAction

function UIRecruitAction:Constructor(poolData, type)
  self._poolInfo = poolData
  self._type = type
  self._isSingle = self._type == ShakeType.SHAKE_ONCE
end

function UIRecruitAction:Recruit()
  local data = self._poolInfo
  local type = self._type
  local isSingle = type == ShakeType.SHAKE_ONCE
  local shop = GameGlobal.GetModule(ShopModule):GetClientShop()
  local drawCount = 1
  if not isSingle then
    drawCount = 10
  end
  if type == ShakeType.SHAKE_ONCE then
    local freeCount = data:GetFreeCount_Single()
    if freeCount and 0 < freeCount then
      self:ShowConfirmDialog(0, freeCount, type, true)
      return
    end
  elseif type == ShakeType.SHAKE_MULTIPLE then
    local info = data.poolData
    if info.close_type == PrizePoolOpenCloseType.PLAY_TIMES_CONDITON and info.extend_data < info.multiple_shake_times then
      Log.info("剩余次数不足以多抽,不处理")
      return
    end
    local freeCount = data:GetFreeCount_Multi()
    if freeCount and 0 < freeCount then
      self:ShowConfirmDialog(0, freeCount, type, true)
      return
    end
  end
  local costItem
  if type == ShakeType.SHAKE_ONCE then
    costItem = data.singleMat
  elseif type == ShakeType.SHAKE_MULTIPLE then
    costItem = data.multipleMat
  end
  local p, discountPrice, d, m = data:GetAssetsPrice(isSingle)
  local costXB, xbId = data:IsCostXB(isSingle)
  if costXB then
    local isEnoughXB, diffXB = data:IsXBEnough(discountPrice, isSingle)
    if isEnoughXB then
      self:ShowConfirmDialog(costItem, discountPrice, type)
      return
    else
      do
        local cfgv, goodsId = ClientShop.GetXBCfg(xbId)
        local xbPrice = cfgv[ConfigKey.ConfigKey_NowPrice]
        local costGP = diffXB * xbPrice
        local isEnoughGP, diffGP = data:IsGPEnough(costGP)
        if isEnoughGP then
          local strContent = StringTable.Get("str_pay_drawcard_gp_2_xb", costGP, diffXB, self._poolInfo:GetXBName(self._isSingle), drawCount, drawCount)
          PopMsgBox(strContent, function()
            GameGlobal.TaskManager():StartTask(self._Gp2Xb, self, costItem, costGP, diffXB)
          end)
          return
        else
          do
            local yj2gpRate = shop:GetDiamondExchangeGlowRate()
            local costYJ = math.ceil(diffGP / yj2gpRate)
            local isEnoughYJ, diffYJ = data:IsYJEnough(costYJ)
            if isEnoughYJ then
              local buyGP = costYJ * yj2gpRate
              local strContent = StringTable.Get("str_pay_drawcard_yj_2_gp_2_xb", costYJ, buyGP, diffXB, self._poolInfo:GetXBName(self._isSingle), drawCount, drawCount)
              PopMsgBox(strContent, function()
                GameGlobal.TaskManager():StartTask(self._Yj2Gp2Xb, self, costItem, costYJ, buyGP, diffXB)
              end)
              return
            else
              self:Recharge()
              return
            end
          end
        end
      end
    end
  elseif data:IsCostGp(isSingle) then
    local isEnoughGP, diffGP = data:IsGPEnough(discountPrice)
    if isEnoughGP then
      self:ShowConfirmDialog(costItem, discountPrice, type)
      return
    else
      local yj2gpRate = shop:GetDiamondExchangeGlowRate()
      local costYJ = math.ceil(diffGP / yj2gpRate)
      local isEnoughYJ, diffYJ = data:IsYJEnough(costYJ)
      if isEnoughYJ then
        local buyGP = costYJ * yj2gpRate
        local strContent = StringTable.Get("str_pay_drawcard_yj_2_gp", costYJ, buyGP, drawCount, drawCount)
        PopMsgBox(strContent, function()
          GameGlobal.TaskManager():StartTask(self._Yj2Gp, self, costItem, costYJ, buyGP)
        end)
        return
      else
        self:Recharge()
        return
      end
    end
  else
    local count = GameGlobal.GetModule(ItemModule):GetItemCount(costItem)
    if discountPrice > count then
      PopMsgBox(StringTable.Get("str_draw_card_special_expend_not_enough", StringTable.Get(Cfg.cfg_item[costItem].Name)), function()
        local viewID = self._poolInfo.poolData.performance_id
        local cfg = Cfg.cfg_recruit_pool_view[viewID]
        if not cfg.GiftID then
          Log.exception("卡池表现配置中没有GiftID字段,ID:", viewID)
        end
        GameGlobal.UIStateManager():ShowDialog("UIShopController", 2, 5, 0, cfg.GiftID)
      end)
      return
    else
      self:ShowConfirmDialog(costItem, discountPrice, type)
      return
    end
  end
end

function UIRecruitAction:Recharge()
  if EngineGameHelper.EnableAppleVerifyBulletin() then
    ToastManager.ShowToast(StringTable.Get("str_pay_yj_not_enough_cant_exchange"))
    return
  end
  PopMsgBox(StringTable.Get("str_pay_res_not_enough_goto_recharge"), function(param)
    GameGlobal.GetModule(ShopModule):GetClientShop():OpenRechargeShop()
  end)
end

function UIRecruitAction:ShowConfirmDialog(assetId, price, shakeType, free)
  local isSingle = shakeType == ShakeType.SHAKE_ONCE
  local mGamble = GameGlobal.GetModule(GambleModule)
  mGamble:Context():SetDefaultPoolIndex(self._poolInfo.index)
  mGamble:Context():SetPoolID(self._poolInfo.poolData.performance_id)
  mGamble:Context():SetPoolType(self._poolInfo.poolData.prize_pool_type)
  if not mGamble.hasShowNotIncluePedPoolTips then
    local times = mGamble:GetNotIncludePetPoolGambleTimes(self._poolInfo.index)
    local strTips
    if 0 < times then
      strTips = StringTable.Get("str_draw_card_pop_has_get")
    elseif times == 0 then
      local petList = mGamble:GetNotIncludePetPool(self._poolInfo.index)
      if not petList or #petList == 0 then
        strTips = StringTable.Get("str_draw_card_pop_has_all")
      end
    end
    if strTips then
      local strTitle = ""
      mGamble.hasShowNotIncluePedPoolTips = true
      PopMsgBox(strTips, function()
        GameGlobal.UIStateManager():ShowDialog("UIDrawCardConfirmController", assetId, price, self._poolInfo.poolData.prize_pool_id, shakeType, free, isSingle)
      end)
      return
    end
  end
  GameGlobal.UIStateManager():ShowDialog("UIDrawCardConfirmController", assetId, price, self._poolInfo.poolData.prize_pool_id, shakeType, free, isSingle)
end

function UIRecruitAction:_Yj2Gp2Xb(TT, costMat, yaojing, guangpo, xingbiao)
  GameGlobal.UIStateManager():Lock("RequestYJ2GP2XB")
  local mShop = GameGlobal.GetModule(ShopModule)
  local guangpoRet = mShop:ApplyDiamondExchangeGlow(TT, yaojing, guangpo)
  if ClientShop.CheckShopCode(guangpoRet:GetResult()) then
    local cfgv, goodsId = ClientShop.GetXBCfg(costMat)
    local sale_tpye = cfgv[ConfigKey.ConfigKey_SaleType]
    local price = cfgv[ConfigKey.ConfigKey_NowPrice]
    local xingbiaoRet = mShop:BuyItem(TT, MarketType.Shop_GuangPo, goodsId, xingbiao, sale_tpye, price)
    if ClientShop.CheckShopCode(xingbiaoRet) then
      local p, discountPrice, d, m = self._poolInfo:GetAssetsPrice(self._isSingle)
      local module = GameGlobal.GetModule(GambleModule)
      module:Context():SetDefaultPoolIndex(self._poolInfo.index)
      module:Context():SetPoolID(self._poolInfo.poolData.performance_id)
      module:Context():SetPoolType(self._poolInfo.poolData.prize_pool_type)
      UIRecruitAction.Drawcard(self._type, self._poolInfo.poolData.prize_pool_id, costMat, discountPrice)
    else
      Log.error("耀晶兑换光珀后，再兑换星标失败:", xingbiaoRet)
    end
  else
    Log.error("耀晶兑换光珀失败:", guangpoRet:GetResult())
  end
  GameGlobal.UIStateManager():UnLock("RequestYJ2GP2XB")
end

function UIRecruitAction:_Gp2Xb(TT, costMat, guangpo, xingbiao)
  local cfgv, goodsId = ClientShop.GetXBCfg(costMat)
  if not cfgv then
    return
  end
  local sale_tpye = cfgv[ConfigKey.ConfigKey_SaleType]
  local price = cfgv[ConfigKey.ConfigKey_NowPrice]
  local mShop = GameGlobal.GetModule(ShopModule)
  GameGlobal.UIStateManager():Lock("RequestGP2XB")
  local ret = mShop:BuyItem(TT, MarketType.Shop_GuangPo, goodsId, xingbiao, sale_tpye, price)
  GameGlobal.UIStateManager():UnLock("RequestGP2XB")
  if ClientShop.CheckShopCode(ret) then
    local p, discountPrice, d, m = self._poolInfo:GetAssetsPrice(self._isSingle)
    local module = GameGlobal.GetModule(GambleModule)
    module:Context():SetDefaultPoolIndex(self._poolInfo.index)
    module:Context():SetPoolID(self._poolInfo.poolData.performance_id)
    module:Context():SetPoolType(self._poolInfo.poolData.prize_pool_type)
    UIRecruitAction.Drawcard(self._type, self._poolInfo.poolData.prize_pool_id, costMat, discountPrice)
  else
    Log.fatal("### RequestGP2XB failed.", guangpo, xingbiao, ret)
  end
end

function UIRecruitAction:_Yj2Gp(TT, costMat, yaojing, guangpo)
  local mShop = GameGlobal.GetModule(ShopModule)
  GameGlobal.UIStateManager():Lock("RequestYJ2GP")
  local ret = mShop:ApplyDiamondExchangeGlow(TT, yaojing, guangpo)
  GameGlobal.UIStateManager():UnLock("RequestYJ2GP")
  if ClientShop.CheckShopCode(ret:GetResult()) then
    local p, discountPrice, d, m = self._poolInfo:GetAssetsPrice(self._isSingle)
    local module = GameGlobal.GetModule(GambleModule)
    module:Context():SetDefaultPoolIndex(self._poolInfo.index)
    module:Context():SetPoolID(self._poolInfo.poolData.performance_id)
    module:Context():SetPoolType(self._poolInfo.poolData.prize_pool_type)
    UIRecruitAction.Drawcard(self._type, self._poolInfo.poolData.prize_pool_id, costMat, discountPrice)
  else
    Log.fatal("### ApplyDiamondExchangeGlow failed.", yaojing, guangpo, ret:GetResult())
  end
end

function UIRecruitAction.Drawcard(drawType, poolId, itemId, itemCount)
  GameGlobal.EventDispatcher():Dispatch(GameEventType.WaitForRecuitSceneLoadFinish, function()
    GameGlobal.UIStateManager():Lock("StartDrawCard")
    local module = GameGlobal.GetModule(GambleModule)
    local petModule = GameGlobal.GetModule(PetModule)
    petModule:GetAllPetsSnapshoot()
    module:Context():SetHaveMaxStarPet(petModule:GetMaxStarResult())
    local funcModule = GameGlobal.GetModule(RoleModule).uiModule
    funcModule:LockAchievementFinishPanel(true)
    GameGlobal.TaskManager():StartTask(function()
      local ack, cards, duplicateTags, fixed_reward = module:Shake(TT, drawType, poolId, itemId, itemCount)
      GameGlobal.UIStateManager():UnLock("StartDrawCard")
      if ack:GetSucc() then
        if cards == nil or #cards == 0 then
          Log.fatal("[DrawCard] cards result is empty!")
          return
        end
        Log.notice("[DrawCard] draw card success, count: ", #cards)
        local viewData = UIDrawCardViewData:New(cards, duplicateTags, drawType, poolId, fixed_reward)
        module:Context():SetStateDrawCard(true)
        GameGlobal.UIStateManager():ShowDialog("UIDrawCardAnimController", viewData)
      else
        local funcModule = GameGlobal.GetModule(RoleModule).uiModule
        funcModule:LockAchievementFinishPanel(false)
        ToastManager.ShowToast(module:GetReasonByErrorCode(ack:GetResult()))
        Log.error("抽卡失败:", ack:GetResult())
      end
      local ack2 = module:ApplyAllPoolInfo(TT)
      if ack2:GetSucc() then
        Log.notice("[DrawCard] get draw card data success, open ui")
      else
        Log.notice("[DrawCard] promotion time up, refresh pools failed")
        ToastManager.ShowToast(module:GetReasonByErrorCode(ack2:GetResult()))
      end
      local shopModule = GameGlobal.GetModule(ShopModule)
      shopModule:RequestGlowMarket(TT)
    end)
  end)
end
