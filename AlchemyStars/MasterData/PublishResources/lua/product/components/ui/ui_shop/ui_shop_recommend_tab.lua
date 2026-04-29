_class("UIShopRecommendTab", UICustomWidget)
UIShopRecommendTab = UIShopRecommendTab
local UIShopRecommendGroupType = {One = 1, Two = 2}
_enum("UIShopRecommendGroupType", UIShopRecommendGroupType)
local UIShopRecommendUIType = {
  None = 0,
  Gift = 1,
  Card = 2,
  Pet = 3,
  Skin = 4
}
_enum("UIShopRecommendUIType", UIShopRecommendUIType)

function UIShopRecommendTab:Constructor()
  self.loginModule = self:GetModule(LoginModule)
  self.shopModule = self:GetModule(ShopModule)
  self.svrTimeModule = self:GetModule(SvrTimeModule)
  self.clientShop = self.shopModule:GetClientShop()
  self.atlas = self:GetAsset("UIShop.spriteatlas", LoadType.SpriteAtlas)
  self._refreshTaskID = nil
  self._startTime = 0
  self._endTime = 5000
end

function UIShopRecommendTab:OnCurrencyBuySuccess(id)
  self:RefreshBattlePassInfo()
end

function UIShopRecommendTab:SetData(param)
  self.show = true
  self:RefreshRecommond(true)
  self._startTime = 0
  self:InAnimation()
end

function UIShopRecommendTab:RefreshSailingPlan()
  self._sailingPool = self:GetUIComponent("UISelectObjectPath", "SailingPlan")
  self._sailingItem = self._sailingPool:SpawnObject("UIShopSailingPlanRecommend")
  self._sailingItem:SetData(self.uiOwner)
end

function UIShopRecommendTab:RefreshRecommond(first)
  self:ShowBtnPool()
  local index = 1
  if not self.index then
    index = 1
  else
    index = self.index
  end
  self:OnClickTabBtn(index, first)
  GameGlobal.EventDispatcher():Dispatch(GameEventType.ShopTabChange, ShopMainTabType.Recommend)
end

function UIShopRecommendTab:ExcuteHideLogic(callBack)
  self.show = false
  self.index = nil
  if callBack then
    callBack(self)
  end
end

function UIShopRecommendTab:OnShow(param)
  self._anim = self:GetUIComponent("Animation", "UIShopRecommendTab")
  self._canvasGroup = self:GetUIComponent("CanvasGroup", "groupInfoPool")
  self._onePool = self:GetUIComponent("UISelectObjectPath", "one")
  self._oneGo = self:GetGameObject("one")
  self._onePoolData = self._onePool:SpawnObject("UIShopRecommendOne")
  self._onePoolData:SetCallback(function(id)
    self:RecommendGroupClick(id)
  end)
  self._twoPool = self:GetUIComponent("UISelectObjectPath", "two")
  self._twoPoolData = self._twoPool:SpawnObject("UIShopRecommendTwo")
  self._twoGo = self:GetGameObject("two")
  self._twoPoolData:SetCallback(function(id)
    self:RecommendGroupClick(id)
  end)
  self.btnPool = self:GetUIComponent("UISelectObjectPath", "Content")
  self.pointParentGO = self:GetGameObject("point")
  self.btnPoolRect = self:GetUIComponent("RectTransform", "Content")
  self.points = {}
  for index = 1, 20 do
    local trans = GameObjectHelper.FindChild(self.pointParentGO.transform, "p" .. index)
    trans.gameObject:SetActive(false)
    self.points[index] = {}
    self.points[index].trans = trans
    self.points[index].rect = trans:GetComponent("RectTransform")
    self.points[index].image = trans:GetComponent("Image")
  end
  self._monthCard = self:GetGameObject("MonthCard")
  self._monthCardValue1 = self:GetUIComponent("UILocalizationText", "MonthCardValue1")
  self._monthCardValue2Text = self:GetUIComponent("UILocalizationText", "MonthCardValue2Text")
  self._monthCardValue2 = self:GetUIComponent("UILocalizationText", "MonthCardValue2")
  self._monthCardValue3 = self:GetUIComponent("UILocalizationText", "MonthCardValue3")
  self._monthCardValue4 = self:GetUIComponent("UILocalizationText", "MonthCardValue4")
  self._monthCardPriceText = self:GetUIComponent("UILocalizationText", "MonthCardPriceText")
  self._monthCardPriceType = self:GetUIComponent("UILocalizationText", "MonthCardPriceType")
  self._monthCardPrice = self:GetUIComponent("UILocalizationText", "MonthCardPrice")
  self._battlePass = self:GetGameObject("BattlePass")
  self._battlePassPrice = self:GetUIComponent("UILocalizationText", "BattlePassPrice")
  self._battlePassPrice2 = self:GetGameObject("BattlePassPrice2")
  self._battlePassPrice1 = self:GetGameObject("BattlePassPrice1")
  self._battlePassBuy = self:GetGameObject("BattlePassBuy")
  self._battlePassBought = self:GetGameObject("BattlePassBought")
  self._battlePassBg = self:GetUIComponent("RawImageLoader", "BattlePassBg")
  self._battlePassBgObj = self:GetGameObject("BattlePassBg")
  self._battlePassTips1 = self:GetGameObject("BattlePassTips1")
  self._battlePassText1 = self:GetUIComponent("UILocalizationText", "BattlePassText1")
  self._battlePassText2 = self:GetUIComponent("UILocalizationText", "BattlePassText2")
  self._battlePassText3 = self:GetUIComponent("UILocalizationText", "BattlePassText3")
  self._ScrollArea = self:GetGameObject("ScrollArea")
  self:AddUICustomEventListener(UICustomUIEventListener.Get(self._ScrollArea), UIEvent.BeginDrag, function(pointData)
    if pointData then
      self._scrollview:StopMovement()
      self._beginPosX = pointData.position.x
    end
  end)
  self:AddUICustomEventListener(UICustomUIEventListener.Get(self._ScrollArea), UIEvent.EndDrag, function(pointData)
    if pointData then
      if self._beginPosX then
        self._endPosX = pointData.position.x
        local delta = self._endPosX - self._beginPosX
        if 200 < delta then
          self:PageToLeft()
        elseif delta < -200 then
          self:PageToRight()
        end
      end
      self._beginPosX = 0
    end
  end)
  self._scrollrect = self:GetUIComponent("RectTransform", "Viewport")
  self._scrollview = self:GetUIComponent("ScrollRect", "Scroll View")
  self._scrollrect_width = self._scrollrect.rect.width
  self._refreshTaskID = nil
  self:AddTimer()
end

function UIShopRecommendTab:AddTimer()
  local svrTime = math.floor(self.svrTimeModule:GetServerTime() / 1000)
  self._gapsTime = -1
  local cfg_shop_recommend = Cfg.cfg_shop_recommend({})
  if cfg_shop_recommend then
    for key, value in pairs(cfg_shop_recommend) do
      local timeStr = value.TimeLimit
      if timeStr then
        local time_1_str = timeStr[1]
        local time_2_str = timeStr[2]
        if value.IsResident then
          time_2_str = HelperProxy:GetInstance():ResidentTimeString()
        end
        local time_1_num = self.loginModule:GetTimeStampByTimeStr(time_1_str)
        local time_2_num = self.loginModule:GetTimeStampByTimeStr(time_2_str)
        local gapTime = -1
        if svrTime < time_1_num then
          gapTime = time_1_num - svrTime
        elseif svrTime < time_2_num then
          gapTime = time_2_num - svrTime
        end
        if 0 < gapTime then
          if self._gapsTime < 0 then
            self._gapsTime = gapTime
          elseif gapTime < self._gapsTime then
            self._gapsTime = gapTime
          end
        end
      end
    end
  end
  Log.debug("###[UIShopRecommendTab] self._gapsTime --> ", self._gapsTime)
  if self._gapsTime > 0 then
    self._event = GameGlobal.RealTimer():AddEvent(self._gapsTime * 1000, function()
      self:TimeDownRefresh()
    end)
    Log.debug("###[UIShopRecommendTab] addevent --> second --> ", self._gapsTime)
  end
end

function UIShopRecommendTab:SetPointSelect()
  for idx, value in pairs(self.points) do
    if idx == self.index then
      value.image.sprite = self.atlas:GetSprite("shop_tuijian_icon02")
      value.rect.sizeDelta = Vector2(108, 80)
    else
      value.image.sprite = self.atlas:GetSprite("shop_tuijian_icon03")
      value.rect.sizeDelta = Vector2(76, 76)
    end
  end
end

function UIShopRecommendTab:OnHide()
  if self._refreshTaskID then
    GameGlobal.TaskManager():KillTask(self._refreshTaskID)
    self._refreshTaskID = nil
  end
  if self._contentTweener then
    self._contentTweener:Kill()
  end
  if self._event then
    GameGlobal.RealTimer():CancelEvent(self._event)
    self._event = nil
  end
end

function UIShopRecommendTab:OnClickTabBtn(index, first)
  self._scrollview:StopMovement()
  if self.index == index then
    return
  end
  if self.index and self.allIconToggle[self.index] then
    self.allIconToggle[self.index]:Select(false, true)
  end
  self.index = index
  self:SetPointSelect()
  local moveContent, movePos = self:GetContentMovePos()
  if moveContent then
    self:MovePanelToIndex(movePos)
  end
  if self.index and self.allIconToggle[self.index] then
    self.allIconToggle[self.index]:Select(true, true)
  end
  self.shopRecommendData = self.recommendDatas[self.index]
  self._startTime = 0
  self:SetAdInfo(first)
end

function UIShopRecommendTab:GetContentMovePos()
  local cellsize_x = 270
  local padding_left = 20
  local scroll_width = self._scrollrect_width
  if self._contentTweener then
    self._contentTweener:Kill(true)
  end
  local moveContent = false
  local movePos = 0
  if self.index == 1 then
    local contentPos = self.btnPoolRect.anchoredPosition.x
    if contentPos < 0 then
      moveContent = true
      movePos = 0
    end
  elseif self.index == #self.recommendDatas then
    local contentPos = self.btnPoolRect.anchoredPosition.x
    local contentWidth = self.btnPoolRect.rect.width
    if contentPos > scroll_width - contentWidth then
      moveContent = true
      movePos = scroll_width - contentWidth
    end
  else
    local leftBtnShow = false
    local checkIdx = self.index - 1
    local contentPos = self.btnPoolRect.anchoredPosition.x
    if contentPos * -1 > (checkIdx - 1) * cellsize_x then
      moveContent = true
      movePos = (checkIdx - 1) * cellsize_x * -1
    end
    if not moveContent then
      local rightBtnShow = false
      local checkIdx = self.index + 1
      local contentPos = self.btnPoolRect.anchoredPosition.x
      if checkIdx * cellsize_x > contentPos * -1 + scroll_width then
        moveContent = true
        movePos = (checkIdx * cellsize_x - scroll_width) * -1
      end
    end
  end
  return moveContent, movePos
end

function UIShopRecommendTab:ShowBtnPool()
  if not self.btnPool.uiCustomWidgets then
    Log.error("### [UIShopRecommendTab ShowBtnPool] UICustomWidgetPool uiCustomWidgets nil.")
    return
  end
  self.recommendDatas = self.clientShop:GetRecommendDatas()
  if not self.recommendDatas then
    return
  end
  local count = #self.recommendDatas
  self.btnPool:SpawnObjects("UIShopRecommendIconBtn", count)
  self.allIconToggle = self.btnPool:GetAllSpawnList()
  for i, v in ipairs(self.allIconToggle) do
    if count >= i then
      v:Init(i, self.recommendDatas[i], function(index)
        self:OnClickTabBtn(index)
      end)
      v:Select(i == 1, i == 1)
    end
  end
  for index = 1, 20 do
    if count >= index then
      self.points[index].trans.gameObject:SetActive(true)
    else
      self.points[index].trans.gameObject:SetActive(false)
    end
  end
end

function UIShopRecommendTab:SetAdInfo(first)
  self:SetAdValue()
end

function UIShopRecommendTab:Update(dms)
  if self.show then
    self._startTime = self._startTime + dms
    if self._startTime > self._endTime then
      self._startTime = 0
      self:PageToRightRepeat()
    end
  end
end

function UIShopRecommendTab:SetAdValue()
  local groupType = self.shopRecommendData:GroupType()
  self._oneGo:SetActive(groupType == UIShopRecommendGroupType.One)
  self._twoGo:SetActive(groupType == UIShopRecommendGroupType.Two)
  if groupType == UIShopRecommendGroupType.One then
    self._onePoolData:SetData(self.shopRecommendData)
  elseif groupType == UIShopRecommendGroupType.Two then
    self._twoPoolData:SetData(self.shopRecommendData)
  end
end

function UIShopRecommendTab:CanPass(id)
  local pass = true
  local isTimeLimit = false
  local cfg = Cfg.cfg_shop_recommend[id]
  if cfg.TabType == RecommendType.RecommendType_TimeLimit then
    isTimeLimit = true
  end
  if isTimeLimit then
    self:StartTask(function(TT)
      local result, idDic = self.shopModule:confirmIfExist(TT, id)
      if result == true then
      elseif idDic ~= {} and idDic ~= nil then
        pass = false
        self.clientShop:SetRecommendConfig(idDic)
        self:RefreshRecommond()
        ToastManager.ShowToast(StringTable.Get("str_toast_manager_time_limited_TAB_closed"))
        return
      end
    end, self)
  end
  return pass
end

function UIShopRecommendTab:TimeDownRefresh()
  self:Lock("UIShopRecommendTab:TimeDownRefresh")
  GameGlobal.TaskManager():StartTask(self._OnTimeDownRefresh, self)
end

function UIShopRecommendTab:_OnTimeDownRefresh(TT)
  self:UnLock("UIShopRecommendTab:TimeDownRefresh")
  local idDic = self.shopModule:GetRecommendIds(TT)
  self.index = 1
  self.clientShop:SetRecommendConfig(idDic)
  self:RefreshRecommond(false)
  Log.debug("###[UIShopRecommendTab] TimeDownRefresh !")
end

function UIShopRecommendTab:RecommendGroupClick(id)
  if not self:CanPass(id) then
    return
  end
  local cfg = Cfg.cfg_shop_recommend_ad[id]
  local adGotoType = cfg.GotoType
  local adGotoParam = cfg.GotoParam
  local controller = GameGlobal.UIStateManager():GetController("UIShopController")
  if not controller then
    return
  end
  local param
  if adGotoType == ShopGotoType.OpenShopConfirm then
    local shopId
    if not adGotoParam[3] then
      Log.Error("找策划 广告跳转类型为0 但gotoParam没配shopid")
    else
      shopId = adGotoParam[3]
    end
    param = {
      [1] = ShopGotoType.OpenShopConfirm,
      [2] = adGotoParam[1],
      [3] = adGotoParam[2]
    }
    param[4] = shopId
  elseif adGotoType == ShopGotoType.SortGoods then
    param = {
      [1] = ShopGotoType.SortGoods,
      [2] = adGotoParam[1],
      [3] = adGotoParam[2]
    }
    local shopIds = {}
    for i = 3, #adGotoParam do
      if adGotoParam[i] then
        shopIds[adGotoParam[i]] = 1
      end
    end
    param[4] = shopIds
  elseif adGotoType == ShopGotoType.OpenTab then
    param = {
      [1] = ShopGotoType.OpenTab,
      [2] = adGotoParam[1],
      [3] = adGotoParam[2]
    }
  end
  if adGotoType == ShopGotoType.OpenShopConfirm then
    local shopId = param[4]
    local cfgv = Cfg.cfg_shop_giftmarket_goods[shopId]
    if cfgv ~= nil and cfgv.ShowInSkinsTab then
      param[2] = ShopMainTabType.Skins
    end
  end
  controller:ShowTab(param)
end

function UIShopRecommendTab:PageToLeft()
  AudioHelperController.PlayUISoundAutoRelease(CriAudioIDConst.SoundSwitch)
  local index = self.index
  if self.index > 1 then
    index = index - 1
    self:OnClickTabBtn(index)
  end
end

function UIShopRecommendTab:PageToRight()
  AudioHelperController.PlayUISoundAutoRelease(CriAudioIDConst.SoundSwitch)
  local index = self.index
  if self.index < #self.recommendDatas then
    index = index + 1
    self:OnClickTabBtn(index)
  end
end

function UIShopRecommendTab:PageToRightRepeat()
  AudioHelperController.PlayUISoundAutoRelease(CriAudioIDConst.SoundSwitch)
  local index = self.index
  if self.index == #self.recommendDatas then
    index = 1
  else
    index = index + 1
  end
  self:OnClickTabBtn(index)
end

function UIShopRecommendTab:MovePanelToIndex(pos)
  local time = 0.2
  local movePos = pos
  if self._contentTweener then
    self._contentTweener:Kill(true)
  end
  self._contentTweener = self.btnPoolRect:DOAnchorPosX(movePos, time):OnComplete(function()
    self.btnPoolRect.anchoredPosition = Vector2(movePos, self.btnPoolRect.anchoredPosition.y)
  end)
end

function UIShopRecommendTab:RefreshMonthCardInfo()
  self._monthCardInfo = self.shopModule:GetMonthCardInfo()
  if self._monthCardInfo then
    self._monthCard:SetActive(true)
    if self._monthCardInfo.DirectAssetList[1] then
      self._monthCardValue1:SetText(self._monthCardInfo.DirectAssetList[1].count)
    end
    if self._monthCardInfo.CycleAcceptAssetList[1] then
      self._monthCardValue2Text:SetText(StringTable.Get("str_shop_monthcard_notice2", 30))
      self._monthCardValue2:SetText("*" .. self._monthCardInfo.CycleAcceptAssetList[1].count)
      if #self._monthCardInfo.CycleAcceptAssetList > 2 then
        self._monthCardValue3:SetText("*" .. self._monthCardInfo.CycleAcceptAssetList[2].count)
        self._monthCardValue4:SetText("*" .. self._monthCardInfo.CycleAcceptAssetList[3].count)
      end
    end
    if self._monthCardInfo.DeadlineTime > 0 then
      self._monthCardPriceText:SetText(StringTable.Get("str_shop_monthcard_notice3"))
      self._monthCardPriceText.color = Color(0.10980392156862745, 0.9764705882352941, 0.9647058823529412)
      self._monthCardPriceType:SetText("")
      local remainTime = self._monthCardInfo.DeadlineTime
      self._monthCardPrice:SetText(math.ceil(remainTime / 86400))
    else
      self._monthCardPriceText:SetText(StringTable.Get("str_shop_goto_buy"))
      self._monthCardPriceText.color = Color(0.996078431372549, 0.7686274509803922, 0.06274509803921569)
      self._monthCardPriceType:SetText(ClientShop.PriceUnit())
      self._monthCardPrice:SetText(UIShopToolFunctions.GetPrice(self._monthCardInfo.NowPrice))
    end
  else
    self._monthCard:SetActive(false)
  end
end

function UIShopRecommendTab:MonthCardBtnOnClick(go)
  if self.uiOwner and self._monthCardInfo then
    local param = {}
    param[1] = ShopGotoType.OpenShopConfirm
    param[2] = ShopMainTabType.MonthCard
    param[3] = nil
    param[4] = self._monthCardInfo.ID
    self.uiOwner:ShowTab(param)
  end
end

function UIShopRecommendTab:RefreshBattlePassInfo()
  self._campaign = UIActivityCampaign:New()
  self._campaign:LoadCampaignInfo_Local(ECampaignType.CAMPAIGN_TYPE_BATTLEPASS, ECampaignBattlePassComponentID.ECAMPAIGN_BATTLEPASS_LV_REWARD, ECampaignBattlePassComponentID.ECAMPAIGN_BATTLEPASS_BUY_GIFT)
  if not self._campaign:CheckCampaignOpen() then
    self._battlePass:SetActive(false)
    return false
  end
  self._battlePass:SetActive(true)
  self._lvRewardComponent = self._campaign:GetComponent(ECampaignBattlePassComponentID.ECAMPAIGN_BATTLEPASS_LV_REWARD)
  self._buyGiftComponent = self._campaign:GetComponent(ECampaignBattlePassComponentID.ECAMPAIGN_BATTLEPASS_BUY_GIFT)
  self._buyGiftComponentInfo = self._campaign:GetComponentInfo(ECampaignBattlePassComponentID.ECAMPAIGN_BATTLEPASS_BUY_GIFT)
  local specialReward = self._lvRewardComponent:GetSpecialRewardCfg()
  if specialReward and specialReward.ShopRecommendImage then
    self._battlePassBg:LoadImage(specialReward.ShopRecommendImage)
    self._battlePassBgObj:SetActive(true)
  else
    self._battlePassBgObj:SetActive(false)
  end
  if self._buyGiftComponentInfo.m_buy_state == BuyGiftStateType.EBGST_INIT then
    local skinName1 = StringTable.Get(UIActivityBattlePassHelper.GetStrIdInCampaign(self._campaign, "str_activity_battlepass_n5_cg_name_1"))
    local skinName2 = StringTable.Get(UIActivityBattlePassHelper.GetStrIdInCampaign(self._campaign, "str_activity_battlepass_n5_cg_name_2"))
    local giftId = self._buyGiftComponent:GetFirstGiftIDByType(CampaignGiftType.ECGT_ADVANCED)
    local price = self._buyGiftComponent:GetGiftPriceById(giftId)
    self._battlePassPrice:SetText(UIShopToolFunctions.GetPrice(price))
    self._battlePassBuy:SetActive(true)
    self._battlePassBought:SetActive(false)
  else
    self._battlePassPrice1:SetActive(self._buyGiftComponentInfo.m_buy_state == BuyGiftStateType.EBGST_ADVANCED)
    self._battlePassPrice2:SetActive(self._buyGiftComponentInfo.m_buy_state == BuyGiftStateType.EBGST_LUXURY)
    local skinName1 = StringTable.Get(UIActivityBattlePassHelper.GetStrIdInCampaign(self._campaign, "str_activity_battlepass_n5_cg_name_1"))
    local skinName2 = StringTable.Get(UIActivityBattlePassHelper.GetStrIdInCampaign(self._campaign, "str_activity_battlepass_n5_cg_name_2"))
    self._battlePassBuy:SetActive(false)
    self._battlePassBought:SetActive(true)
  end
  return true
end

function UIShopRecommendTab:BattlePassBtnOnClick(go)
  UIActivityBattlePassHelper.OpenBuyGiftController()
end

function UIShopRecommendTab:InAnimation()
  if self.allIconToggle == nil then
    return
  end
  for i, v in ipairs(self.allIconToggle) do
    if not v:IsSelected() then
      v:PlayAnimation("uianim_UIShopRecommendIconBtn_in01")
    end
  end
end

function UIShopRecommendTab:ShowSelf()
  self._anim:Stop()
  self._anim:Play()
end

function UIShopRecommendTab:HideSelf()
end
