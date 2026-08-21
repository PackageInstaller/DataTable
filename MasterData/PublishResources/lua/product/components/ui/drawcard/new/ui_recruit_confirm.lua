_class("UIRecruitConfirm", UIController)
UIRecruitConfirm = UIRecruitConfirm
local ConfirmType = {
  InValid = 1,
  FreeSingle = 2,
  FreeTen = 3,
  XbEnough = 4,
  Gp2Xb = 5,
  Yj2Gp2Xb = 6,
  GpEnough = 7,
  Yj2Gp = 8,
  CustomItemEnough = 9,
  CustomItemNotEnough = 10,
  NotEnough = 99
}

function UIRecruitConfirm:LoadDataOnEnter(TT, res, uiParams)
  res:SetSucc(true)
  local data = uiParams[1]
  local type = uiParams[2]
  local isSingle = type == ShakeType.SHAKE_ONCE
  local shop = GameGlobal.GetModule(ShopModule):GetClientShop()
  local drawCount = 1
  if not isSingle then
    drawCount = 10
  end
  if type == ShakeType.SHAKE_ONCE then
    local freeCount = data:GetFreeCount_Single()
    if freeCount and 0 < freeCount then
      self._confirmType = ConfirmType.FreeSingle
      self._ctx = {freeCount}
      return
    end
  elseif type == ShakeType.SHAKE_MULTIPLE then
    local info = data.poolData
    if info.close_type == PrizePoolOpenCloseType.PLAY_TIMES_CONDITON and info.extend_data < info.multiple_shake_times then
      Log.info("剩余次数不足以多抽,不处理")
      self._confirmType = ConfirmType.InValid
      res:SetSucc(false)
      return
    end
    local freeCount = data:GetFreeCount_Multi()
    if freeCount and 0 < freeCount then
      self._confirmType = ConfirmType.FreeTen
      self._ctx = {freeCount}
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
      self._confirmType = ConfirmType.XbEnough
      self._ctx = {costItem, discountPrice}
      return
    else
      local cfgv, goodsId = ClientShop.GetXBCfg(xbId)
      local xbPrice = cfgv[ConfigKey.ConfigKey_NowPrice]
      local costGP = diffXB * xbPrice
      local isEnoughGP, diffGP = data:IsGPEnough(costGP)
      if isEnoughGP then
        self._confirmType = ConfirmType.Gp2Xb
        self._ctx = {
          costItem,
          costGP,
          diffXB
        }
        return
      else
        local yj2gpRate = shop:GetDiamondExchangeGlowRate()
        local costYJ = math.ceil(diffGP / yj2gpRate)
        local isEnoughYJ, diffYJ = data:IsYJEnough(costYJ)
        if isEnoughYJ then
          local buyGP = costYJ * yj2gpRate
          self._confirmType = ConfirmType.Yj2Gp2Xb
          self._ctx = {
            costItem,
            costYJ,
            buyGP,
            diffXB
          }
          return
        elseif EngineGameHelper.EnableAppleVerifyBulletin() then
          ToastManager.ShowToast(StringTable.Get("str_pay_yj_not_enough_cant_exchange"))
          res:SetSucc(false)
          self._confirmType = ConfirmType.InValid
          return
        else
          self._confirmType = ConfirmType.NotEnough
          return
        end
      end
    end
  elseif data:IsCostGp(isSingle) then
    local isEnoughGP, diffGP = data:IsGPEnough(discountPrice)
    if isEnoughGP then
      self._confirmType = ConfirmType.GpEnough
      self._ctx = {costItem, discountPrice}
      return
    else
      local yj2gpRate = shop:GetDiamondExchangeGlowRate()
      local costYJ = math.ceil(diffGP / yj2gpRate)
      local isEnoughYJ, diffYJ = data:IsYJEnough(costYJ)
      if isEnoughYJ then
        local buyGP = costYJ * yj2gpRate
        self._confirmType = ConfirmType.Yj2Gp
        self._ctx = {
          costItem,
          costYJ,
          buyGP
        }
        return
      elseif EngineGameHelper.EnableAppleVerifyBulletin() then
        ToastManager.ShowToast(StringTable.Get("str_pay_yj_not_enough_cant_exchange"))
        res:SetSucc(false)
        self._confirmType = ConfirmType.InValid
        return
      else
        self._confirmType = ConfirmType.NotEnough
        return
      end
    end
  else
    local count = GameGlobal.GetModule(ItemModule):GetItemCount(costItem)
    if discountPrice > count then
      self._confirmType = ConfirmType.CustomItemNotEnough
      self._ctx = {costItem}
      return
    else
      self._confirmType = ConfirmType.CustomItemEnough
      self._ctx = {costItem, discountPrice}
      return
    end
  end
end

function UIRecruitConfirm:OnShow(uiParams)
  self:InitWidget()
  self._data = uiParams[1]
  self._type = uiParams[2]
  self._poolID = self._data.poolData.prize_pool_id
  self._isSingle = self._type == ShakeType.SHAKE_ONCE
  if self._confirmType == ConfirmType.InValid then
    self:CloseDialog()
  elseif self._confirmType == ConfirmType.FreeSingle then
    local count = self._ctx[1]
    self:_Enough(0, count, true, true)
    
    function self._confirmCb()
      self:StartTask(self._RecruitDirectly, self, self._type, self._poolID, 0, count)
    end
  elseif self._confirmType == ConfirmType.FreeTen then
    local count = self._ctx[1]
    self:_Enough(0, count, true, false)
    
    function self._confirmCb()
      self:StartTask(self._RecruitDirectly, self, self._type, self._poolID, 0, 0)
    end
  elseif self._confirmType == ConfirmType.XbEnough then
    local id = self._ctx[1]
    local count = self._ctx[2]
    self:_Enough(id, count, false)
    
    function self._confirmCb()
      self:StartTask(self._RecruitDirectly, self, self._type, self._poolID, id, count)
    end
  elseif self._confirmType == ConfirmType.Gp2Xb then
    local id = self._ctx[1]
    local gp = self._ctx[2]
    local xb = self._ctx[3]
    local drawCount = 1
    if not self._isSingle then
      drawCount = 10
    end
    local name = StringTable.Get(Cfg.cfg_item[id].Name)
    local strContent = StringTable.Get("str_pay_drawcard_gp_2_xb", gp, xb, name, drawCount, drawCount)
    self:_NotEnough(strContent)
    
    function self._confirmCb()
      self:StartTask(self._Gp2Xb, self, id, gp, xb)
    end
  elseif self._confirmType == ConfirmType.Yj2Gp2Xb then
    local id = self._ctx[1]
    local yj = self._ctx[2]
    local gp = self._ctx[3]
    local xb = self._ctx[4]
    local drawCount = 1
    if not self._isSingle then
      drawCount = 10
    end
    local name = StringTable.Get(Cfg.cfg_item[id].Name)
    local strContent = StringTable.Get("str_pay_drawcard_yj_2_gp_2_xb", yj, gp, xb, name, drawCount, drawCount)
    self:_NotEnough(strContent)
    
    function self._confirmCb()
      self:StartTask(self._Yj2Gp2Xb, self, id, yj, gp, xb)
    end
  elseif self._confirmType == ConfirmType.GpEnough then
    local id = self._ctx[1]
    local count = self._ctx[2]
    self:_Enough(id, count, false)
    
    function self._confirmCb()
      self:StartTask(self._RecruitDirectly, self, self._type, self._poolID, id, count)
    end
  elseif self._confirmType == ConfirmType.Yj2Gp then
    local id = self._ctx[1]
    local yj = self._ctx[2]
    local gp = self._ctx[3]
    local drawCount = 1
    if not self._isSingle then
      drawCount = 10
    end
    local strContent = StringTable.Get("str_pay_drawcard_yj_2_gp", yj, gp, drawCount, drawCount)
    self:_NotEnough(strContent)
    
    function self._confirmCb()
      self:StartTask(self._Yj2Gp, self, id, yj, gp)
    end
  elseif self._confirmType == ConfirmType.CustomItemEnough then
    local id = self._ctx[1]
    local count = self._ctx[2]
    self:_Enough(id, count, false)
    
    function self._confirmCb()
      self:StartTask(self._RecruitDirectly, self, self._type, self._poolID, id, count)
    end
  elseif self._confirmType == ConfirmType.CustomItemNotEnough then
    local id = self._ctx[1]
    local name = StringTable.Get(Cfg.cfg_item[id].Name)
    local strContent = StringTable.Get("str_draw_card_special_expend_not_enough", name)
    self:_NotEnough(strContent)
    
    function self._confirmCb()
      local viewID = self._data.poolData.performance_id
      local cfg = Cfg.cfg_recruit_pool_view[viewID]
      if not cfg.GiftID then
        Log.exception("卡池表现配置中没有GiftID字段,ID:", viewID)
      end
      self:CloseDialog()
      self:ShowDialog("UIShopController", 2, 5, 0, cfg.GiftID)
    end
  elseif self._confirmType == ConfirmType.NotEnough then
    local strContent = StringTable.Get("str_pay_res_not_enough_goto_recharge")
    self:_NotEnough(strContent)
    
    function self._confirmCb()
      self:CloseDialog()
      GameGlobal.GetModule(ShopModule):GetClientShop():OpenRechargeShop()
    end
  end
end

function UIRecruitConfirm:InitWidget()
  self.title = self:GetUIComponent("UILocalizationText", "title")
  self.icon = self:GetUIComponent("RawImageLoader", "icon")
  self.have = self:GetUIComponent("UILocalizationText", "have")
  self.rest = self:GetUIComponent("UILocalizationText", "rest")
  self.confirmButton = self:GetUIComponent("Image", "ConfirmButton")
  self.iconRoot = self:GetGameObject("iconRoot")
  self.enoughTip = self:GetGameObject("EnoughTip")
  self.msgBox = self:GetGameObject("MsgBox")
  self.msgBoxText = self:GetUIComponent("UILocalizationText", "MsgBoxText")
  self.otherRoot = self:GetUIComponent("RectTransform", "otherRoot")
end

function UIRecruitConfirm:_Enough(itemId, itemCount, free, isSingleFree)
  self.enoughTip:SetActive(true)
  self.msgBox:SetActive(false)
  local cfg = Cfg.cfg_item[itemId]
  local ss
  if free then
    if isSingleFree then
      ss = StringTable.Get("str_draw_card_cost_free")
    else
      ss = StringTable.Get("str_draw_card_cost_freeten")
    end
  else
    local heartstoneCount = 1
    local drawCount = 1
    if self._type == ShakeType.SHAKE_MULTIPLE then
      heartstoneCount = 10
      drawCount = 10
    end
    ss = StringTable.Get("str_draw_card_cost_to_draw", itemCount, StringTable.Get(cfg.Name), heartstoneCount, drawCount)
  end
  self.title:SetText(ss)
  self.iconRoot:SetActive(not free)
  local otherRootPosX = 0
  if free then
    otherRootPosX = -75
    local freeCount = itemCount
    local lessCount = freeCount - 1
    self.have:SetText(freeCount)
    self.rest:SetText(lessCount)
  else
    local had = self:GetModule(RoleModule):GetAssetCount(itemId)
    local rest = had - itemCount
    if 99999 < had then
      had = "99999+"
    end
    if 99999 < rest then
      rest = "99999+"
    end
    self.have:SetText(had)
    self.rest:SetText(rest)
    self.icon:LoadImage(cfg.Icon)
  end
  self.otherRoot.anchoredPosition = Vector2(otherRootPosX, 0)
end

function UIRecruitConfirm:_NotEnough(text)
  self.enoughTip:SetActive(false)
  self.msgBox:SetActive(true)
  self.msgBoxText:SetText(text)
end

function UIRecruitConfirm:ConfirmButtonOnClick(go)
  if self._confirmCb then
    self._confirmCb()
  end
end

function UIRecruitConfirm:CancelButtonOnClick(go)
  self:CloseDialog()
end

function UIRecruitConfirm:MsgBoxOKOnClick(go)
  if self._confirmCb then
    self._confirmCb()
  end
end

function UIRecruitConfirm:MsgBoxCancelOnClick(go)
  self:CloseDialog()
end

function UIRecruitConfirm:_Yj2Gp2Xb(TT, costMat, yaojing, guangpo, xingbiao)
  self:Lock("RequestYJ2GP2XB")
  local mShop = GameGlobal.GetModule(ShopModule)
  local guangpoRet = mShop:ApplyDiamondExchangeGlow(TT, yaojing, guangpo)
  if ClientShop.CheckShopCode(guangpoRet:GetResult()) then
    local cfgv, goodsId = ClientShop.GetXBCfg(costMat)
    local sale_tpye = cfgv[ConfigKey.ConfigKey_SaleType]
    local price = cfgv[ConfigKey.ConfigKey_NowPrice]
    local xingbiaoRet = mShop:BuyItem(TT, MarketType.Shop_GuangPo, goodsId, xingbiao, sale_tpye, price)
    if ClientShop.CheckShopCode(xingbiaoRet) then
      local p, discountPrice, d, m = self._data:GetAssetsPrice(self._isSingle)
      self:_RequestDrawcard(TT, self._type, self._data.poolData.prize_pool_id, costMat, discountPrice)
    else
      Log.error("耀晶兑换光珀后，再兑换星标失败:", xingbiaoRet)
    end
  else
    Log.error("耀晶兑换光珀失败:", guangpoRet:GetResult())
  end
  self:UnLock("RequestYJ2GP2XB")
  self:CloseDialog()
end

function UIRecruitConfirm:_Gp2Xb(TT, costMat, guangpo, xingbiao)
  local cfgv, goodsId = ClientShop.GetXBCfg(costMat)
  if not cfgv then
    return
  end
  local sale_tpye = cfgv[ConfigKey.ConfigKey_SaleType]
  local price = cfgv[ConfigKey.ConfigKey_NowPrice]
  local mShop = GameGlobal.GetModule(ShopModule)
  self:Lock("RequestGP2XB")
  local ret = mShop:BuyItem(TT, MarketType.Shop_GuangPo, goodsId, xingbiao, sale_tpye, price)
  self:UnLock("RequestGP2XB")
  if ClientShop.CheckShopCode(ret) then
    local p, discountPrice, d, m = self._data:GetAssetsPrice(self._isSingle)
    self:_RequestDrawcard(TT, self._type, self._data.poolData.prize_pool_id, costMat, discountPrice)
  else
    Log.fatal("### RequestGP2XB failed.", guangpo, xingbiao, ret)
  end
  self:CloseDialog()
end

function UIRecruitConfirm:_Yj2Gp(TT, costMat, yaojing, guangpo)
  local mShop = GameGlobal.GetModule(ShopModule)
  self:Lock("RequestYJ2GP")
  local ret = mShop:ApplyDiamondExchangeGlow(TT, yaojing, guangpo)
  self:UnLock("RequestYJ2GP")
  if ClientShop.CheckShopCode(ret:GetResult()) then
    local p, discountPrice, d, m = self._data:GetAssetsPrice(self._isSingle)
    self:_RequestDrawcard(TT, self._type, self._data.poolData.prize_pool_id, costMat, discountPrice)
  else
    Log.fatal("### ApplyDiamondExchangeGlow failed.", yaojing, guangpo, ret:GetResult())
  end
  self:CloseDialog()
end

function UIRecruitConfirm:_RecruitDirectly(TT, drawType, poolID, itemID, itemCount)
  self:_RequestDrawcard(TT, drawType, poolID, itemID, itemCount)
  self:CloseDialog()
end

function UIRecruitConfirm:_RequestDrawcard(TT, drawType, poolID, itemID, itemCount)
  if SDKProxy:GetInstance():IsInlandSDK() then
    local ready = false
    GameGlobal.EventDispatcher():Dispatch(GameEventType.WaitForRecuitSceneLoadFinish, function()
      ready = true
    end)
    self:Lock("WaitRecruitScene")
    while not ready do
      YIELD(TT)
    end
    self:UnLock("WaitRecruitScene")
  end
  self:Lock("StartDrawCard")
  local module = GameGlobal.GetModule(GambleModule)
  local petModule = GameGlobal.GetModule(PetModule)
  petModule:GetAllPetsSnapshoot()
  module:Context():SetHaveMaxStarPet(petModule:GetMaxStarResult())
  local funcModule = GameGlobal.GetModule(RoleModule).uiModule
  funcModule:LockAchievementFinishPanel(true)
  local ack, cards, duplicateTags, fixed_reward = module:Shake(TT, drawType, poolID, itemID, itemCount)
  self:UnLock("StartDrawCard")
  if ack:GetSucc() then
    if cards == nil or #cards == 0 then
      Log.fatal("[DrawCard] cards result is empty!")
      return
    end
    Log.notice("[DrawCard] draw card success, count: ", #cards)
    local viewData = UIDrawCardViewData:New(cards, duplicateTags, drawType, poolID, fixed_reward)
    module:Context():SetStateDrawCard(true)
    self:ShowDialog("UIDrawCardAnimController", viewData)
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
  local module = GameGlobal.GetModule(GambleModule)
  module:Context():SetDefaultPoolIndex(self._data.index)
  module:Context():SetPoolID(self._data.poolData.performance_id)
  module:Context():SetPoolType(self._data.poolData.prize_pool_type)
end
