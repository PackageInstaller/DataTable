_class("UIN32ShopController", UIController)
UIN32ShopController = UIN32ShopController

function UIN32ShopController:Constructor()
  self.clientHelper = ClientCampaignDrawShop:New()
  self.multiPrice = 1000
  self.uiData = {}
  self.jackpotCount = 0
  self.unlockBoxs = {}
  self._curPageIndex = 1
  self._petModule = GameGlobal.GetModule(PetModule)
  self._uiModule = GameGlobal.GetModule(RoleModule).uiModule
  self._timeEvents = {}
  self._lotteryState = LotteryState.None
  self._playJackpotAnim = true
  self._animCfg = {
    [1] = {
      "uieff_UIN32ShopController_in",
      443
    },
    [2] = {
      "uieff_UIN32ShopController_out",
      333
    },
    [3] = {
      "uieff_UIN32ShopController_tipsImg_in",
      333
    },
    [4] = {
      "uieff_UIN32ShopController_tipsImg_out",
      333
    },
    [5] = {
      "uieff_UIN32ShopIntro_LockInfoArea_in",
      500
    },
    [6] = {
      "uieff_UIN32ShopIntro_LockInfoArea_out",
      333
    }
  }
  AudioHelperController.RequestUISoundSync(CriAudioIDConst.N32SingleLottery)
  AudioHelperController.RequestUISoundSync(CriAudioIDConst.N32MultiLottery)
end

function UIN32ShopController:LoadDataOnEnter(TT, res, uiParams)
  self._campaignModule = GameGlobal.GetModule(CampaignModule)
  self._campaign = UIActivityCampaign:New()
  self._campaign:LoadCampaignInfo(TT, res, ECampaignType.CAMPAIGN_TYPE_N32, ECampaignN32ComponentID.ECAMPAIGN_N32_LOTTERY)
  if res and not res:GetSucc() then
    self._campaignModule:CheckErrorCode(res.m_result, self._campaign._id, nil, nil)
    return
  end
  self._lotteryComponent = self._campaign:GetComponent(ECampaignN32ComponentID.ECAMPAIGN_N32_LOTTERY)
  self._lotteryComponentInfo = self._campaign:GetComponentInfo(ECampaignN32ComponentID.ECAMPAIGN_N32_LOTTERY)
end

function UIN32ShopController:OnShow(uiParams)
  self:_GetComponents()
  self:_InitData(true, true)
  self:OnValue()
  self:_AttachEvents()
  self:ShowAnim(1)
end

function UIN32ShopController:OnValue()
  self:_InitAwardListUi()
  self:ArrowBtnState()
  self:ShowPoolLock()
  self:_RefreshBoxTitle()
  self:_RefreshCurBoxRest()
  self:ShowPageValue()
  self:_RefreshDrawBtn()
  self:ShowSpineAnim3()
  self:ShowDrawAllTip()
end

function UIN32ShopController:ArrowBtnState()
  self.boxLeftBtnGo:SetActive(not (self._curPageIndex <= 1))
  self.boxRightBtnGo:SetActive(not (self._curPageIndex >= self.jackpotCount))
end

function UIN32ShopController:OnHide()
  self:DetachEvent(GameEventType.ActivityCloseEvent, self._CheckActivityClose)
  self:DetachEvent(GameEventType.ItemCountChanged, self._OnItemCountChanged)
  self:DetachEvent(GameEventType.ShopForceRefresh, self._ForceRefresh)
  if self._changeEvent then
    GameGlobal.Timer():CancelEvent(self._changeEvent)
    self._changeEvent = nil
  end
  if self._drawTask then
    GameGlobal.TaskManager():KillTask(self._drawTask)
    self._drawTask = nil
  end
  for key, value in pairs(self._timeEvents) do
    GameGlobal.Timer():CancelEvent(value)
  end
  if self._spineSkipEvent then
    GameGlobal.Timer():CancelEvent(self._spineSkipEvent)
    self._spineSkipEvent = nil
  end
  if self.lockEvent then
    GameGlobal.Timer():CancelEvent(self.lockEvent)
    self.lockEvent = nil
  end
  if self._playingID then
    AudioHelperController.StopUISound(self._playingID)
  end
  AudioHelperController.ReleaseUISoundResource(CriAudioIDConst.N32SingleLottery)
  AudioHelperController.ReleaseUISoundResource(CriAudioIDConst.N32MultiLottery)
end

function UIN32ShopController:_AttachEvents()
  self:AttachEvent(GameEventType.ActivityCloseEvent, self._CheckActivityClose)
  self:AttachEvent(GameEventType.ItemCountChanged, self._OnItemCountChanged)
  self:AttachEvent(GameEventType.ShopForceRefresh, self._ForceRefresh)
end

function UIN32ShopController:_CheckActivityClose(id)
  if self._campaign and self._campaign._id == id then
    self:SwitchState(UIStateType.UIMain)
  end
end

function UIN32ShopController:_ForceRefresh(isOpenNew)
  self:Lock("UIN32ShopController:_ForceRefresh")
  self._playJackpotAnim = isOpenNew
  self:_InitData(isOpenNew)
  self:OnValue()
  self._timeEvents._delayUnlockTimeEvent = GameGlobal.Timer():AddEvent(1, function()
    self:UnLock("UIN32ShopController:_ForceRefresh")
  end)
end

function UIN32ShopController:ShowTips(itemId, pos)
  self._tips:SetData(itemId, pos)
end

function UIN32ShopController:_GetComponents()
  self._itemInfo = self:GetUIComponent("UISelectObjectPath", "itemInfo")
  self._tips = self._itemInfo:SpawnObject("UISelectInfo")
  self._uiAnim = self:GetUIComponent("Animation", "Anim")
  self.awardPool = self:GetUIComponent("UISelectObjectPath", "Content")
  self.awardPoolRect = self:GetUIComponent("RectTransform", "Content")
  self.lockInfoAreaGo = self:GetGameObject("LockInfoArea")
  self.sinMask = self:GetGameObject("sinMask")
  self.mulMask = self:GetGameObject("mulMask")
  self.drawSingleBtnText = self:GetUIComponent("UILocalizationText", "DrawSingleBtnText")
  self.drawSingleCostText = self:GetUIComponent("UILocalizationText", "DrawSingleCostText")
  self.drawMultiCostText = self:GetUIComponent("UILocalizationText", "DrawMultiCostText")
  self.drawMultiBtnText = self:GetUIComponent("UILocalizationText", "DrawMultiBtnText")
  self.boxLeftBtnGo = self:GetGameObject("BoxLeftBtn")
  self.boxRightBtnGo = self:GetGameObject("BoxRightBtn")
  self.pointNumText = self:GetUIComponent("UILocalizationText", "PointNumText")
  self.pointNumText2 = self:GetUIComponent("UILocalizationText", "PointNumText2")
  local backBtnGen = self:GetUIComponent("UISelectObjectPath", "TopLeft")
  self.backBtns = backBtnGen:SpawnObject("UICommonTopButton")
  self.backBtns:SetData(function()
    self:CloseDialogWithAnim()
  end, nil, function()
    self:ShowMainUI()
  end)
  self.TopTips = self:GetGameObject("TopTips")
  self.tipsImg = self:GetGameObject("tipsImg")
  self:ShowTopTips(false)
  self.curBoxRestText = self:GetUIComponent("UILocalizationText", "CurBoxRestText")
  self.awardListTitleText = self:GetUIComponent("UILocalizationText", "AwardListTitleText")
  self.spineHolderCG = self:GetUIComponent("CanvasGroup", "SpineHolder")
  self.spine = self:GetUIComponent("SpineLoader", "spine")
  self.spine:LoadSpine("n32_g_spine_idle")
  self._spineSke = self.spine.CurrentSkeleton
  if not self._spineSke then
    self._spineSke = self.spine.CurrentMultiSkeleton
  end
  self._spineSke.AnimationState.Data.DefaultMix = 0
  self.slideAreaGo = self:GetGameObject("SpineArea")
  self.selfRect = self:GetUIComponent("RectTransform", "SpineArea")
  if self.slideAreaGo then
    self.etl = UICustomUIEventListener.Get(self.slideAreaGo)
    self:RegUIEventTriggerListener(function(ped)
      self:OnBeginDrag(ped)
    end, function(ped)
      self:OnDrag(ped)
    end, function(ped)
      self:OnEndDrag(ped)
    end)
  end
  self.spineSkipGo = self:GetGameObject("SpineSkip")
  self.spineSkipGo:SetActive(false)
  self._pageValue = self:GetUIComponent("UILocalizationText", "PageValue")
  self._drawAllTip = self:GetGameObject("DrawAllTip")
end

function UIN32ShopController:PlaySpineAnimation(spineAnim, loop, lotteryType)
  if not self._spineSke then
    Log.debug("###[UIMainLobbyController] not self._spineSke")
    return
  end
  local entry
  
  local function func()
    self._spineSke:Initialize(true)
    entry = self._spineSke.AnimationState:SetAnimation(0, spineAnim, loop)
  end
  
  local succ = pcall(func)
  if not succ then
    Log.error("###[UIMainLobbyController] set spine anim fail ! anim[", spineAnim, "]")
    return
  end
  if not entry then
    Log.error("###[UIMainLobbyController] entry is nil ! anim[", spineAnim, "]")
    return
  end
  if lotteryType and lotteryType == ECampaignLotteryType.E_CLT_SINGLE then
    local color = {
      "blue",
      "red",
      "yellow"
    }
    local spineSke
    if self._spineSke then
      spineSke = self.spine.gameObject:GetComponentInChildren(typeof(Spine.Unity.Modules.SkeletonGraphicMultiObject))
    end
    spineSke.Skeleton:SetSkin(color[math.random(1, #color)])
  end
  local anim = entry.Animation
  local duration = anim.Duration
  local yieldTime = math.floor(duration * 1000)
  return yieldTime
end

function UIN32ShopController:RegUIEventTriggerListener(onBeginDrag, onDrag, onEndDrag)
  self:AddUICustomEventListener(self.etl, UIEvent.BeginDrag, onBeginDrag)
  self:AddUICustomEventListener(self.etl, UIEvent.Drag, onDrag)
  self:AddUICustomEventListener(self.etl, UIEvent.EndDrag, onEndDrag)
end

function UIN32ShopController:OnBeginDrag(ped)
  local deltaX = ped.delta.x
  if self:IsEdge(deltaX) then
    return
  end
  local pos = UIN32ShopController.ScreenPointToLocalPointInRectangle(self.selfRect, ped)
  self._xBegainDrag = pos.x
end

function UIN32ShopController:OnDrag(ped)
  local pos = UIN32ShopController.ScreenPointToLocalPointInRectangle(self.selfRect, ped)
  self._xCurDrag = pos.x
end

function UIN32ShopController:OnEndDrag(ped)
  self:InitDragField()
end

function UIN32ShopController:_UpdateDragSwitch()
  if not self.etl then
    return
  end
  if not self.etl.IsDragging then
    return
  end
  if not self._xBegainDrag or not self._xCurDrag then
    return
  end
  local deltaX = self._xCurDrag - self._xBegainDrag
  if deltaX == 0 then
    return
  end
  if self:IsEdge(deltaX) then
    return
  end
  local absDeltaX = math.abs(deltaX)
  if 100 < absDeltaX then
    self:OnEndDrag()
    if deltaX < 0 then
      self:BoxRightBtnOnClick()
    else
      self:BoxLeftBtnOnClick()
    end
  end
end

function UIN32ShopController.ScreenPointToLocalPointInRectangle(rect, ped)
  local res, pos = UnityEngine.RectTransformUtility.ScreenPointToLocalPointInRectangle(rect, ped.position, ped.pressEventCamera, nil)
  return pos
end

function UIN32ShopController:IsEdge(deltaX)
  if 0 < deltaX and self._curPageIndex == 1 then
    return true
  end
  if deltaX < 0 and self._curPageIndex == self.jackpotCount then
    return true
  end
  return false
end

function UIN32ShopController:InitDragField()
  self._xBegainDrag = nil
  self._xCurDrag = nil
  self._posBGLogo = Vector2(-667, 0)
end

function UIN32ShopController:_InitData(isOpenNew, isOnShow)
  self.unlockBoxs = {}
  self.uiData = {}
  if self._lotteryComponent and self._lotteryComponentInfo then
    self.currencyId = self._lotteryComponentInfo.m_cost_item_id
    self.multiPrice = self._lotteryComponentInfo.m_cost_count * self._lotteryComponentInfo.m_multi_lottery
    self.unlockBoxs = self._lotteryComponentInfo.m_unlock_jackpots
    for index, value in ipairs(self._lotteryComponentInfo.m_jackpots) do
      local itemBox = DCampaignDrawShopItemBox:New()
      itemBox:Refresh(value, self._lotteryComponent)
      itemBox:SortBig(value)
      table.insert(self.uiData, itemBox)
    end
    self.jackpotCount = #self.uiData
    local unlockBoxNum = #self.unlockBoxs
    if isOnShow then
      self._initPageIndex = self:_GetDefaultPageIndexOnShow()
    elseif isOpenNew then
      if 0 < unlockBoxNum then
        self._initPageIndex = self.unlockBoxs[unlockBoxNum]
      else
        self._initPageIndex = 1
      end
    else
      self._initPageIndex = self._curPageIndex
    end
  end
  self._curPageIndex = self._initPageIndex
end

function UIN32ShopController:CloseDialogWithAnim()
  if self._lotteryState ~= LotteryState.None then
    return
  end
  
  local function callback()
    local campModule = GameGlobal.GetModule(CampaignModule)
    campModule:CampaignSwitchState(true, UIStateType.UIActivityN32MainController, UIStateType.UIMain, {nil, false}, self._campaign._id)
  end
  
  self:ShowAnim(2, callback)
end

function UIN32ShopController:ShowMainUI()
  if self._lotteryState ~= LotteryState.None then
    return
  end
  self:SwitchState(UIStateType.UIMain)
end

function UIN32ShopController:ShowTopTips(show)
  self.TopTips:SetActive(show)
  self.tipsImg:SetActive(show)
end

function UIN32ShopController:TopTipsOnClick(go)
  self:ShowAnim(4, self:ShowTopTips(false))
end

function UIN32ShopController:PointAreaOnClick(go)
  self:ShowTopTips(true)
  self:ShowAnim(3)
end

function UIN32ShopController:_InitAwardListUi()
  self:ShowAwardsAnim()
end

function UIN32ShopController:ShowAwardsAnim()
  local unlock = self:_IsBoxUnlock()
  local awards = self:GetPoolAwards()
  self._awards = self.awardPool:SpawnObjects("UIN32ShopAwardCell", #awards)
  local pools = self.awardPool:GetAllSpawnList()
  self._playJackpotAnim = unlock and self._playJackpotAnim
  local aniTime = self._playJackpotAnim and 20 or 0
  self:StartTask(function(TT)
    self:Lock("UIN32ShopController:ShowAwardsAnim")
    for i = 1, #awards do
      local item = pools[i]
      local data = awards[i]
      if self._playJackpotAnim then
        YIELD(TT, aniTime)
      end
      item:InitData(data, function(id, pos)
        self:_ShowItemTips(id, pos)
      end, unlock, self._playJackpotAnim)
    end
    self._playJackpotAnim = false
    self:UnLock("UIN32ShopController:ShowAwardsAnim")
  end)
end

function UIN32ShopController:BoxLeftBtnOnClick(go)
  if self._lotteryState ~= LotteryState.None then
    return
  end
  local nextIndex = self._curPageIndex - 1
  if nextIndex < 1 then
    return
  end
  self._curPageIndex = self._curPageIndex - 1
  self._playJackpotAnim = true
  local animTime = 333
  self:Lock("UIN32ShopController:BoxLeftBtnOnClick")
  self._changeEvent = GameGlobal.Timer():AddEvent(animTime, function()
    self:UnLock("UIN32ShopController:BoxLeftBtnOnClick")
    self.awardPoolRect.anchoredPosition = Vector2(0, 0)
    self:OnValue()
  end)
  self._tips:closeOnClick()
end

function UIN32ShopController:BoxRightBtnOnClick(go)
  if self._lotteryState ~= LotteryState.None then
    return
  end
  local nextIndex = self._curPageIndex + 1
  if nextIndex > self.jackpotCount then
    return
  end
  self._curPageIndex = self._curPageIndex + 1
  self._playJackpotAnim = true
  local animTime = 333
  self:Lock("UIN32ShopController:BoxRightBtnOnClick")
  self._changeEvent = GameGlobal.Timer():AddEvent(animTime, function()
    self:UnLock("UIN32ShopController:BoxRightBtnOnClick")
    self.awardPoolRect.anchoredPosition = Vector2(0, 0)
    self:OnValue()
  end)
  self._tips:closeOnClick()
end

function UIN32ShopController:OnUpdate(deltaTimeMS)
  self:_UpdateDragSwitch()
end

function UIN32ShopController:_ShowItemTips(id, pos)
  if self._lotteryState ~= LotteryState.None then
    return
  end
  self:ShowTips(id, pos)
end

function UIN32ShopController:_IsBoxUnlock()
  if self._lotteryComponent then
    return self._lotteryComponent:IsLotteryJackpotUnlock(self._curPageIndex)
  end
  return false
end

function UIN32ShopController:ShowPageValue()
  self._pageValue:SetText(self._curPageIndex .. "/" .. self.jackpotCount)
end

function UIN32ShopController:GetPoolAwards()
  local jackpots = self._lotteryComponentInfo.m_jackpots
  local awards = jackpots[self._curPageIndex]
  return awards
end

function UIN32ShopController:GetCurrentPoolLock()
  if self._lotteryComponentInfo.m_unlock_jackpots[self._curPageIndex] then
    self.cantDrawCard = false
  else
    self.cantDrawCard = true
  end
end

function UIN32ShopController:GetLessDrawCount()
  local awards = self:GetPoolAwards()
  self.notDrawCount = true
  local canDrawCardCount = 0
  for i = 1, #awards do
    local award = awards[i]
    if award.m_lottery_count and 0 < award.m_lottery_count then
      canDrawCardCount = canDrawCardCount + award.m_lottery_count
      self.notDrawCount = false
    end
  end
  if self.cantDrawCard or self.notDrawCount then
    canDrawCardCount = 10
  elseif 10 < canDrawCardCount then
    canDrawCardCount = 10
  end
  return canDrawCardCount
end

function UIN32ShopController:_RefreshDrawBtn()
  self.drawSingleBtnText:SetText(StringTable.Get("str_n32_draw_btn", 1))
  local canDrawCardCount = self:GetLessDrawCount()
  self.drawMultiBtnText:SetText(StringTable.Get("str_n32_draw_btn", canDrawCardCount))
  self:SetPointNumber()
  self:_RefreshSingleDrawBtn()
  self:_RefreshMultiDrawBtn()
end

function UIN32ShopController:ShowPoolLock()
  if not self:_IsBoxUnlock() then
    self:ShowAnim(5)
    self.lockInfoAreaGo:SetActive(true)
  else
    self:ShowAnim(6)
    self.lockInfoAreaGo:SetActive(false)
  end
end

function UIN32ShopController:_RefreshSingleDrawBtn()
  local bEnableBtn = true
  if not self:_IsBoxUnlock() then
    bEnableBtn = false
  end
  if bEnableBtn then
    local checkCount = 1
    bEnableBtn = not self.notDrawCount
  end
  self:_EnableSingleDrawBtn(bEnableBtn)
end

function UIN32ShopController:_RefreshMultiDrawBtn()
  local bEnableBtn = true
  if not self:_IsBoxUnlock() then
    bEnableBtn = false
  end
  bEnableBtn = bEnableBtn and not self.notDrawCount
  self:_EnableMultiDrawBtn(bEnableBtn)
end

function UIN32ShopController:_RefreshBoxTitle()
  local boxNameText = StringTable.Get("str_n32_lottery_pool_title", self._curPageIndex)
  self.awardListTitleText:SetText(boxNameText)
end

function UIN32ShopController:_RefreshCurBoxRest()
  local curBoxRest = 0
  local curBoxTotal = 0
  local boxData = self.uiData[self._curPageIndex]
  if boxData then
    curBoxRest, curBoxTotal = boxData:GetTotalRestItem()
  end
  local tmpText = StringTable.Get("str_n32_shop_award_rest_num", curBoxRest, curBoxTotal)
  self.curBoxRestText:SetText(tmpText)
end

function UIN32ShopController:_CheckCurrencyEnable(price)
  local haveCurrency = self.clientHelper.GetMoney(self.currencyId)
  if price <= haveCurrency then
    return true
  else
    return false
  end
end

function UIN32ShopController:_OnItemCountChanged()
  self:_RefreshSingleDrawBtn()
  self:_RefreshMultiDrawBtn()
  self:SetPointNumber()
end

function UIN32ShopController:SetPointNumber()
  local totalNum = ClientCampaignDrawShop.GetMoney(self.currencyId)
  local count = self:GetLessDrawCount()
  self.drawSingleCostText:SetText(self._lotteryComponentInfo.m_cost_count)
  self.drawMultiCostText:SetText(self._lotteryComponentInfo.m_cost_count * count)
  self.singleCostEnough = true
  if totalNum >= self._lotteryComponentInfo.m_cost_count then
    self.singleCostEnough = true
  else
    self.drawSingleCostText.color = Color.red
    self.singleCostEnough = false
  end
  self.muliCostEnough = true
  if totalNum >= self._lotteryComponentInfo.m_cost_count * count then
    self.muliCostEnough = true
  else
    self.drawMultiCostText.color = Color.red
    self.muliCostEnough = false
  end
  self:SetTopNumber()
end

function UIN32ShopController:SetTopNumber()
  local totalNum = ClientCampaignDrawShop.GetMoney(self.currencyId)
  self.pointNumText:SetText(self:GetItemCountStr(totalNum, "#bdb3a9", "#fffcfc"))
  self.pointNumText2:SetText(self:GetItemCountStr(totalNum, "#bdb3a9", "#fffcfc"))
end

function UIN32ShopController:_GetDefaultPageIndexOnShow()
  local pageIndex = 1
  if self._lotteryComponent then
    for index, value in ipairs(self.unlockBoxs) do
      local isNoRestBigReward = self._lotteryComponent:IsLotteryJeckpotNoRestBigReward(value)
      if not isNoRestBigReward then
        return value
      end
    end
    for index, value in ipairs(self.unlockBoxs) do
      local isEmpty = self._lotteryComponent:IsLotteryJeckpotEmpty(value)
      if not isEmpty then
        return value
      end
    end
  end
  return pageIndex
end

function UIN32ShopController:_CheckAwardRestSingle()
  if self._lotteryComponent then
    local isEmpty = self._lotteryComponent:IsLotteryJeckpotEmpty(self._curPageIndex)
    if isEmpty then
      return false
    else
      return true
    end
  end
  return false
end

function UIN32ShopController:_CheckAwardRestMulti()
  if self._lotteryComponent then
    local canDraw = self._lotteryComponent:IsLotteryJeckpotCanMutliLottery(self._curPageIndex)
    if canDraw then
      return true
    else
      return false
    end
  end
  return false
end

function UIN32ShopController:DrawSingleBtnOnClick(go)
  if self.notDrawCount then
    return
  end
  if not self:_IsBoxUnlock() then
    return
  end
  if UIActivityCustomHelper.CheckComponentStatus(self._lotteryComponent) == ActivityComponentStatus.Close then
    ToastManager.ShowToast(StringTable.Get("str_activity_finished"))
    self:SwitchState(UIStateType.UIMain)
    return
  end
  if not self.singleCostEnough then
    ToastManager.ShowToast(StringTable.Get("str_activity_error_9001"))
    return
  end
  self:_DoDraw(ECampaignLotteryType.E_CLT_SINGLE)
end

function UIN32ShopController:DrawMultiBtnOnClick(go)
  if self.notDrawCount then
    return
  end
  if not self:_IsBoxUnlock() then
    return
  end
  if UIActivityCustomHelper.CheckComponentStatus(self._lotteryComponent) == ActivityComponentStatus.Close then
    ToastManager.ShowToast(StringTable.Get("str_activity_finished"))
    self:SwitchState(UIStateType.UIMain)
    return
  end
  if not self.muliCostEnough then
    ToastManager.ShowToast(StringTable.Get("str_activity_error_9001"))
    return
  end
  self:_DoDraw(ECampaignLotteryType.E_CLT_MULTI)
end

function UIN32ShopController:_EnableSingleDrawBtn(enable)
  self.sinMask:SetActive(not enable)
end

function UIN32ShopController:_EnableMultiDrawBtn(enable)
  self.mulMask:SetActive(not enable)
end

function UIN32ShopController:_CheckCanDrawOnceMore(lotteryType)
  if lotteryType == ECampaignLotteryType.E_CLT_SINGLE then
    local bEnable = true
    if not self:_IsBoxUnlock() then
      bEnable = false
    end
    bEnable = bEnable and self:_CheckCurrencyEnable(self._lotteryComponentInfo.m_cost_count)
    bEnable = bEnable and self:_CheckAwardRestSingle()
    return bEnable
  elseif lotteryType == ECampaignLotteryType.E_CLT_MULTI then
    local bEnable = true
    if not self:_IsBoxUnlock() then
      bEnable = false
    end
    bEnable = bEnable and self:_CheckCurrencyEnable(self.multiPrice)
    bEnable = bEnable and self:_CheckAwardRestMulti()
    return bEnable
  end
  return false
end

function UIN32ShopController:_DoDraw(lotteryType)
  if self._lotteryState ~= LotteryState.None then
    return
  end
  self._uiModule:LockAchievementFinishPanel(true)
  self._lotteryState = LotteryState.WaitRequestResult
  self._drawTask = self:StartTask(function(TT)
    local res = AsyncRequestRes:New()
    local getRewards, isOpenNew = self:_SendDrawReq(TT, res, self._curPageIndex, lotteryType)
    if res:GetSucc() then
      if lotteryType == ECampaignLotteryType.E_CLT_SINGLE then
        self._playingID = AudioHelperController.PlayUISoundResource(CriAudioIDConst.N32SingleLottery, false)
      elseif lotteryType == ECampaignLotteryType.E_CLT_MULTI then
        self._playingID = AudioHelperController.PlayUISoundResource(CriAudioIDConst.N32MultiLottery, false)
      end
      local canDrawOnceMore = self:_CheckCanDrawOnceMore(lotteryType)
      local curBoxHasRest = self:_CheckAwardRestSingle()
      if getRewards then
        self:_RecordRewardsInfo(getRewards, lotteryType, curBoxHasRest, isOpenNew, canDrawOnceMore)
        self:_ShowDrawSpineAnim(TT, lotteryType)
      else
        self._lotteryState = LotteryState.None
      end
    else
      self._lotteryState = LotteryState.None
      self._uiModule:LockAchievementFinishPanel(false)
      self._campaignModule:CheckErrorCode(res.m_result, self._campaign._id, function()
        self:_ForceRefresh(isOpenNew)
      end, function()
        self:CloseDialog()
      end)
    end
  end, self)
end

function UIN32ShopController:_SendDrawReq(TT, res, boxIndex, lotteryType)
  if self._lotteryComponent then
    return self._lotteryComponent:HandleLottery(TT, res, boxIndex, lotteryType)
  end
  res:SetSucc(false)
  return nil
end

function UIN32ShopController:_ShowGetReward(record)
  self:ShowSpineAnim3()
  self._lotteryState = LotteryState.None
  self._uiModule:LockAchievementFinishPanel(false)
  if not record then
    return
  end
  local rewards = record.m_getRewards
  local lotteryType = record.m_lotteryType
  local curBoxHasRest = record.m_curBoxHasRest
  local isOpenNew = record.m_isOpenNew
  local canDrawOnceMore = record.m_canDrawOnceMore
  local assetAwards = {}
  local tempPets = {}
  local hasBig = false
  local tableTemp, tableSmall = {}, {}
  for i, v in ipairs(rewards) do
    if v.m_is_big_reward then
      table.insert(tableTemp, v)
    else
      table.insert(tableSmall, v)
    end
  end
  for i, v in ipairs(tableSmall) do
    table.insert(tableTemp, v)
  end
  rewards = tableTemp
  if 0 < #rewards then
    for i = 1, #rewards do
      local roleAsset = RoleAsset:New()
      roleAsset.assetid = rewards[i].m_item_id
      roleAsset.count = rewards[i].m_count
      local ispet = self._petModule:IsPetID(roleAsset.assetid)
      if ispet then
        table.insert(tempPets, roleAsset)
      end
      roleAsset.outeffect = rewards[i].m_is_big_reward
      table.insert(assetAwards, roleAsset)
      if rewards[i].m_is_big_reward then
        hasBig = true
      end
    end
  end
  local cbFunc
  if isOpenNew then
    if self:_CheckIsRestRepeatBox() then
      function cbFunc()
        self:_LoopBoxRestTips()
      end
    else
      function cbFunc()
        self:_ConfirmToNextBox()
      end
    end
  elseif hasBig then
    function cbFunc()
      self:_LoopBoxRestTips()
    end
  elseif not curBoxHasRest then
    function cbFunc()
      GameGlobal.EventDispatcher():Dispatch(GameEventType.ShopForceRefresh, false)
    end
  elseif canDrawOnceMore then
    function cbFunc()
      GameGlobal.EventDispatcher():Dispatch(GameEventType.ShopForceRefresh, false)
    end
  else
    function cbFunc()
      GameGlobal.EventDispatcher():Dispatch(GameEventType.ShopForceRefresh, false)
    end
  end
  local getItemCtrl = "UIGetItemController"
  if 0 < #tempPets then
    self:ShowDialog("UIPetObtain", tempPets, function()
      GameGlobal.UIStateManager():CloseDialog("UIPetObtain")
      self:ShowDialog(getItemCtrl, assetAwards, cbFunc, true)
    end)
  else
    self:ShowDialog(getItemCtrl, assetAwards, cbFunc, true)
  end
end

function UIN32ShopController:_ConfirmToNextBox()
  local strTitle = StringTable.Get("str_n32_shop_new_box_unlock_title")
  local strText = StringTable.Get("str_n32_shop_open_next_text", self._curPageIndex, self._curPageIndex + 1)
  local curCost = 10
  
  local function okCb()
    GameGlobal.EventDispatcher():Dispatch(GameEventType.ShopForceRefresh, true)
  end
  
  PopupManager.Alert("UICommonMessageBox", PopupPriority.Normal, PopupMsgBoxType.Ok, strTitle, strText, okCb, nil)
end

function UIN32ShopController:_LoopBoxRestTips()
  local strTitle = ""
  local strText = StringTable.Get("str_n32_shop_loop_box_reset_tips")
  local curCost = 10
  
  local function okCb()
    GameGlobal.EventDispatcher():Dispatch(GameEventType.ShopForceRefresh, true)
  end
  
  PopupManager.Alert("UICommonMessageBox", PopupPriority.Normal, PopupMsgBoxType.Ok, strTitle, strText, okCb, nil)
end

function UIN32ShopController:_RecordRewardsInfo(getRewards, lotteryType, curBoxHasRest, isOpenNew, canDrawOnceMore)
  if not self.rewardRecord then
    self.rewardRecord = DCampaignDrawShopDrawResultRecord:New()
  end
  self.rewardRecord:Record(getRewards, lotteryType, curBoxHasRest, isOpenNew, canDrawOnceMore)
end

function UIN32ShopController:_ShowDrawSpineAnim(TT, lotteryType)
  self._lotteryState = LotteryState.ShowRewards
  local spineAnim
  self._lotteryType = lotteryType
  if lotteryType == ECampaignLotteryType.E_CLT_SINGLE then
    spineAnim = self._curPageIndex .. "_1"
  else
    spineAnim = self._curPageIndex .. "_2"
  end
  local yieldTime = self:PlaySpineAnimation(spineAnim, false, lotteryType)
  if yieldTime and 0 < yieldTime then
    self.spineSkipGo:SetActive(true)
    self._spineSkipEvent = GameGlobal.Timer():AddEvent(yieldTime, function()
      self.spineSkipGo:SetActive(false)
      self:_ShowGetReward(self.rewardRecord)
    end)
  else
    self:_ShowGetReward(self.rewardRecord)
  end
end

function UIN32ShopController:SpineSkipOnClick(go)
  if self._spineSkipEvent then
    GameGlobal.Timer():CancelEvent(self._spineSkipEvent)
  end
  if self._playingID then
    AudioHelperController.StopUISound(self._playingID)
  end
  self.spineSkipGo:SetActive(false)
  self:_ShowGetReward(self.rewardRecord)
end

function UIN32ShopController:ShowSpineAnim2(lotteryType)
  self.spineSkipGo:SetActive(false)
  self:Lock("UIN32ShopController:ShowSpineAnim2")
  local spineAnim2 = self._curPageIndex .. "_idle"
  if lotteryType == ECampaignLotteryType.E_CLT_SINGLE then
  end
  local yieldTime = self:PlaySpineAnimation(spineAnim2, false)
  if yieldTime and 0 < yieldTime then
    GameGlobal.Timer():AddEvent(yieldTime, function()
      self:UnLock("UIN32ShopController:ShowSpineAnim2")
    end)
  else
    self:UnLock("UIN32ShopController:ShowSpineAnim2")
    self:_ShowGetReward(self.rewardRecord)
  end
end

function UIN32ShopController:ShowSpineAnim3()
  local spineAnim = self._curPageIndex .. "_idle"
  self:PlaySpineAnimation(spineAnim, true)
end

function UIN32ShopController:_CheckIsRestRepeatBox()
  if self._lotteryComponentInfo then
    self.unlockBoxs = self._lotteryComponentInfo.m_unlock_jackpots
    local unlockBoxNum = #self.unlockBoxs
    local newIndex = 1
    if 0 < unlockBoxNum then
      newIndex = self.unlockBoxs[unlockBoxNum]
    end
    return self._curPageIndex == newIndex
  end
  return false
end

function UIN32ShopController:RuleDescriptionBtnOnClick(go)
  if self._lotteryState ~= LotteryState.None then
    return
  end
  self:ShowDialog("UIIntroLoader", "UIN32ShopIntro", MaskType.MT_BlurMask)
end

function UIN32ShopController:GetItemCountStr(count, preColor, countColor)
  local dight = 0
  if 9999999 < count then
    count = 9999999
  end
  local tmpCount = count
  if tmpCount < 0 then
    tmpCount = -tmpCount
  end
  while 0 < tmpCount do
    tmpCount = math.floor(tmpCount / 10)
    dight = dight + 1
  end
  local pre = ""
  if 0 <= count then
    for i = 1, 7 - dight do
      pre = pre .. "0"
    end
  else
    for i = 1, 7 - dight - 1 do
      pre = pre .. "0"
    end
  end
  if 0 < count then
    return string.format("<color=" .. preColor .. ">%s</color><color=" .. countColor .. ">%s</color>", pre, count)
  elseif count == 0 then
    return string.format("<color=" .. preColor .. ">%s</color>", pre)
  else
    return string.format("<color=" .. preColor .. ">%s</color><color=" .. countColor .. ">%s</color>", pre, count)
  end
end

function UIN32ShopController:ShowDrawAllTip()
  self._drawAllTip:SetActive(self.notDrawCount)
end

function UIN32ShopController:ShowAnim(id, callback)
  local data = self._animCfg[id]
  self:StartTask(function(TT)
    self:Lock("UIN32ShopController:ShowAnim")
    self._uiAnim:Play(data[1])
    YIELD(TT, data[2])
    self:UnLock("UIN32ShopController:ShowAnim")
    if callback then
      callback()
    end
  end)
end
