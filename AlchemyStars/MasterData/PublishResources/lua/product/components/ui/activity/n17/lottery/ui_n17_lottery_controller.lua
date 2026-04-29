_class("UIN17LotteryController", UIController)
UIN17LotteryController = UIN17LotteryController

function UIN17LotteryController:Constructor()
  self.clientHelper = ClientCampaignDrawShop:New()
  self.singleTimes = 1
  self.multiTimes = 10
  self.singlePrice = 100
  self.multiPrice = 1000
  self.uiData = {}
  self.jackpotCount = 0
  self.unlockBoxs = {}
  self._curPageIndex = 1
  self._petModule = GameGlobal.GetModule(PetModule)
  self._uiModule = GameGlobal.GetModule(RoleModule).uiModule
  self._atlas = self:GetAsset("UIN17.spriteatlas", LoadType.SpriteAtlas)
  self._timeEvents = {}
  self._lotteryState = LotteryState.None
  self._playJackpotAnim = true
end

function UIN17LotteryController:LoadDataOnEnter(TT, res, uiParams)
  self._campaignModule = GameGlobal.GetModule(CampaignModule)
  self._campaign = UIActivityCampaign:New()
  self._campaign:LoadCampaignInfo(TT, res, ECampaignType.CAMPAIGN_TYPE_N17, ECampaignN17ComponentID.ECAMPAIGN_N17_LOTTERY)
  if res and not res:GetSucc() then
    self._campaignModule:CheckErrorCode(res.m_result, self._campaign._id, nil, nil)
    return
  end
  self._lotteryComponent = self._campaign:GetComponent(ECampaignN17ComponentID.ECAMPAIGN_N17_LOTTERY)
  self._lotteryComponentInfo = self._campaign:GetComponentInfo(ECampaignN17ComponentID.ECAMPAIGN_N17_LOTTERY)
end

function UIN17LotteryController:OnShow(uiParams)
  self._closeCallBack = uiParams[1]
  self:_GetComponents()
  self:_InitData(true, true)
  self:_InitBoxPosPoint()
  self:_InitAwardListUi()
  self:_SetAwardListToPageIndex(self._initPageIndex)
  self:_AttachEvents()
  self._campaign:GetLocalProcess():OnOpenGetIntegratedCalculation()
end

function UIN17LotteryController:OnHide()
  UIWidgetHelper.SetSpineLoad(self, "_spineBg")
  UIWidgetHelper.SetSpineLoad(self, "_spineNpc")
  if self._drawTask then
    GameGlobal.TaskManager():KillTask(self._drawTask)
    self._drawTask = nil
  end
  for key, value in pairs(self._timeEvents) do
    GameGlobal.Timer():CancelEvent(value)
  end
  if self._closeCallBack then
    self._closeCallBack()
  end
end

function UIN17LotteryController:_AttachEvents()
  self:AttachEvent(GameEventType.ActivityCloseEvent, self._CheckActivityClose)
  self:AttachEvent(GameEventType.ItemCountChanged, self._OnItemCountChanged)
end

function UIN17LotteryController:_CheckActivityClose(id)
  if self._campaign and self._campaign._id == id then
    self:SwitchState(UIStateType.UIMain)
  end
end

function UIN17LotteryController:_ForceRefresh(isOpenNew)
  self:Lock("UIN17LotteryController:_ForceRefresh")
  self._playJackpotAnim = false
  self:_InitData(isOpenNew)
  self:_SetAwardListToPageIndex(self._initPageIndex)
  self._timeEvents._delayUnlockTimeEvent = GameGlobal.Timer():AddEvent(1, function()
    self:UnLock("UIN17LotteryController:_ForceRefresh")
  end)
end

function UIN17LotteryController:_GetComponents()
  self.awardList = self:GetUIComponent("UIDynamicScrollView", "AwardList")
  self.noRestItemTipsCoverGo = self:GetGameObject("NoRestItemTipsCover")
  self.drawSingleBtn = self:GetGameObject("DrawSingleBtn")
  self.drawSingleBtnGreyCoverGo = self:GetGameObject("DrawSingleBtnGreyCover")
  self.drawSingleBtnCanvas = self:GetUIComponent("CanvasGroup", "DrawSingleBtn")
  self.drawMultiBtn = self:GetGameObject("DrawMultiBtn")
  self.drawMultiBtnGreyCoverGo = self:GetGameObject("DrawMultiBtnGreyCover")
  self.drawMultiBtnCanvas = self:GetUIComponent("CanvasGroup", "DrawMultiBtn")
  self.drawSingleBtnText = self:GetUIComponent("UILocalizationText", "DrawSingleBtnText")
  self.drawSingleCostText = self:GetUIComponent("UILocalizationText", "DrawSingleCostText")
  self.drawMultiCostText = self:GetUIComponent("UILocalizationText", "DrawMultiCostText")
  self.boxLeftBtnGo = self:GetGameObject("BoxLeftBtn")
  self.boxRightBtnGo = self:GetGameObject("BoxRightBtn")
  self.pointNumText = self:GetUIComponent("UILocalizationText", "PointNumText")
  local backBtnGen = self:GetUIComponent("UISelectObjectPath", "TopLeft")
  self.backBtns = backBtnGen:SpawnObject("UICommonTopButton")
  self.backBtns:SetData(function()
    self:CloseDialogWithAnim()
  end, nil, function()
    self:ShowMainUI()
  end)
  self.grayColor = Color(0.39215686274509803, 0.39215686274509803, 0.39215686274509803)
  self.clientCfg = Cfg.cfg_activity_draw_shop_client[self._campaign._id]
  self.slideAreaGo = self:GetGameObject("SpineArea")
  self.selfRect = self:GetUIComponent("RectTransform", "SpineArea")
  self.etl = UICustomUIEventListener.Get(self.slideAreaGo)
  self:RegUIEventTriggerListener(function(ped)
    self:OnBeginDrag(ped)
  end, function(ped)
    self:OnDrag(ped)
  end, function(ped)
    self:OnEndDrag(ped)
  end)
  self.pointParentGO = self:GetGameObject("BoxImgPosPoint")
  self.points = {}
  for index = 1, 10 do
    local trans = GameObjectHelper.FindChild(self.pointParentGO.transform, "p" .. index)
    trans.gameObject:SetActive(false)
    self.points[index] = {}
    self.points[index].trans = trans
    self.points[index].rect = trans:GetComponent("RectTransform")
    self.points[index].image = trans:GetComponent("Image")
  end
  self._pageValue = self:GetUIComponent("UILocalizationText", "PageValue")
end

function UIN17LotteryController:_SetStencil(rawImage)
  rawImage.materialForRendering:SetFloat("_Stencil", 17)
  rawImage.materialForRendering:SetFloat("_StencilComp", 3)
  rawImage.materialForRendering:SetFloat("_StencilOp", 0)
end

function UIN17LotteryController:RegUIEventTriggerListener(onBeginDrag, onDrag, onEndDrag)
  self:AddUICustomEventListener(self.etl, UIEvent.BeginDrag, onBeginDrag)
  self:AddUICustomEventListener(self.etl, UIEvent.Drag, onDrag)
  self:AddUICustomEventListener(self.etl, UIEvent.EndDrag, onEndDrag)
end

function UIN17LotteryController:OnBeginDrag(ped)
  local deltaX = ped.delta.x
  if self:IsEdge(deltaX) then
    return
  end
  local pos = UIN17LotteryController.ScreenPointToLocalPointInRectangle(self.selfRect, ped)
  self._xBegainDrag = pos.x
end

function UIN17LotteryController:OnDrag(ped)
  local pos = UIN17LotteryController.ScreenPointToLocalPointInRectangle(self.selfRect, ped)
  self._xCurDrag = pos.x
end

function UIN17LotteryController:OnEndDrag(ped)
  self:InitDragField()
end

function UIN17LotteryController:OnPress()
end

function UIN17LotteryController:_UpdateDragSwitch()
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

function UIN17LotteryController.ScreenPointToLocalPointInRectangle(rect, ped)
  local res, pos = UnityEngine.RectTransformUtility.ScreenPointToLocalPointInRectangle(rect, ped.position, ped.pressEventCamera, nil)
  return pos
end

function UIN17LotteryController:IsEdge(deltaX)
  if 0 < deltaX and self._curPageIndex == 1 then
    return true
  end
  if deltaX < 0 and self._curPageIndex == self.jackpotCount then
    return true
  end
  return false
end

function UIN17LotteryController:InitDragField()
  self._xBegainDrag = nil
  self._xCurDrag = nil
  self._posBGLogo = Vector2(-667, 0)
end

function UIN17LotteryController:_InitData(isOpenNew, isOnShow)
  self.unlockBoxs = {}
  self.uiData = {}
  if self._lotteryComponent and self._lotteryComponentInfo then
    self.currencyId = self._lotteryComponentInfo.m_cost_item_id
    self.singlePrice = self._lotteryComponentInfo.m_cost_count
    self.multiTimes = self._lotteryComponentInfo.m_multi_lottery
    self.multiPrice = self._lotteryComponentInfo.m_cost_count * self._lotteryComponentInfo.m_multi_lottery
    self.unlockBoxs = self._lotteryComponentInfo.m_unlock_jackpots
    for index, value in ipairs(self._lotteryComponentInfo.m_jackpots) do
      local itemBox = DCampaignDrawShopItemBox:New()
      itemBox:Refresh(value, self._lotteryComponent)
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
end

function UIN17LotteryController:CloseDialogWithAnim()
  if self._lotteryState ~= LotteryState.None then
    return
  end
  UIWidgetHelper.PlayAnimation(self, "_anim", "", 0, function()
    self._campaign._campaign_module:CampaignSwitchState(true, UIStateType.UIN17MainController, UIStateType.UIMain, nil, self._campaign._id)
  end)
end

function UIN17LotteryController:ShowMainUI()
  if self._lotteryState ~= LotteryState.None then
    return
  end
  self:SwitchState(UIStateType.UIMain)
end

function UIN17LotteryController:_InitAwardListUi()
  self.awardList:InitListView(self.jackpotCount, function(scrollview, index)
    return self:_OnGetAwardBoxCell(scrollview, index)
  end)
  self.awardList.ScrollRect.enabled = false
end

function UIN17LotteryController:_OnGetAwardBoxCell(scrollview, index)
  local item = scrollview:NewListViewItem("AwardBoxCell")
  local cellPool = self:GetUIComponentDynamic("UISelectObjectPath", item.gameObject)
  if item.IsInitHandlerCalled == false then
    item.IsInitHandlerCalled = true
    cellPool:SpawnObjects("UIN17LotteryAwardBoxCell", 1)
  end
  local rowList = cellPool:GetAllSpawnList()
  local itemWidget = rowList[1]
  if itemWidget then
    local itemIndex = index + 1
    itemWidget:InitData(self.uiData[itemIndex], function(data)
      self:_ShowItemTips(data)
    end, self._playJackpotAnim)
  end
  return item
end

function UIN17LotteryController.SetLotteryIconText(uiView, widget_icon, widget_text, icon, count)
  if icon and not string.isnullorempty(widget_icon) then
    UIWidgetHelper.SetRawImage(uiView, widget_icon, icon)
  end
  if not string.isnullorempty(widget_text) then
    local c1 = "#c4c4c4"
    local c2 = "#d8ba5b"
    local text = UIActivityHelper.FormatNumber_PreZero(9, count, c1, c2)
    UIWidgetHelper.SetLocalizationText(uiView, widget_text, text)
  end
end

function UIN17LotteryController:_SetPointNumText()
  local icon, count = self._lotteryComponent:GetLotteryCostItemIconText()
  UIN17LotteryController.SetLotteryIconText(self, "DrawSingleCostIcon", "", icon, count)
  UIN17LotteryController.SetLotteryIconText(self, "DrawMultiCostIcon", "", icon, count)
  UIN17LotteryController.SetLotteryIconText(self, "PointIcon", "PointNumText", icon, count)
end

function UIN17LotteryController:SetPointSelect(index, select)
  if select then
    if self.points[index] then
      self.points[index].image.sprite = self._atlas:GetSprite("N17_event_shop_yeqian02")
      self.points[index].rect.sizeDelta = Vector2(49, 24)
    end
  elseif self.points[index] then
    self.points[index].image.sprite = self._atlas:GetSprite("N17_event_shop_yeqian01")
    self.points[index].rect.sizeDelta = Vector2(25, 24)
  end
end

function UIN17LotteryController:_PlayAnimation_ChangePage(nextIndex, animName1, duration1, animName2, duration2)
  UIWidgetHelper.PlayAnimations(self, "_anim", {
    {
      animName = animName1,
      duration = duration1,
      callback = function()
        self:_SetAwardListToPageIndex(nextIndex)
      end
    },
    {
      animName = animName2,
      duration = duration2,
      callback = function()
      end
    }
  })
end

function UIN17LotteryController:_SetAlpha(alpha)
  self:GetUIComponent("SpineLoader", "_spineBg").color = Color(1, 1, 1, 0)
  self:GetUIComponent("SpineLoader", "_spineNpc").color = Color(1, 1, 1, 0)
  self:GetUIComponent("CanvasGroup", "Center2").alpha = alpha
end

function UIN17LotteryController:BoxLeftBtnOnClick(go)
  if self._lotteryState ~= LotteryState.None then
    return
  end
  local nextIndex = self._curPageIndex - 1
  if nextIndex < 1 then
    return
  end
  self._playJackpotAnim = false
  self:_PlayAnimation_ChangePage(nextIndex, "uieffanim_N17_UIN17LotteryController_right_out", 500, "uieffanim_N17_UIN17LotteryController_right_in", 500)
end

function UIN17LotteryController:BoxRightBtnOnClick(go)
  if self._lotteryState ~= LotteryState.None then
    return
  end
  local nextIndex = self._curPageIndex + 1
  if nextIndex > self.jackpotCount then
    return
  end
  self._playJackpotAnim = false
  self:_PlayAnimation_ChangePage(nextIndex, "uieffanim_N17_UIN17LotteryController_left_out", 500, "uieffanim_N17_UIN17LotteryController_left_in", 500)
end

function UIN17LotteryController:OnUpdate(deltaTimeMS)
  self:_UpdateDragSwitch()
end

function UIN17LotteryController:_ShowItemTips(data)
  if self._lotteryState ~= LotteryState.None then
    return
  end
  self:ShowDialog("UIN17LotteryTipsController", data)
end

function UIN17LotteryController:NoRestItemTipsCoverOnClick(go)
  ToastManager.ShowToast(StringTable.Get("str_n17_lottery_no_item_tips"))
end

function UIN17LotteryController:_IsBoxUnlock(boxIndex)
  if self._lotteryComponent then
    return self._lotteryComponent:IsLotteryJackpotUnlock(boxIndex)
  end
  return false
end

function UIN17LotteryController:_SetAwardListToPageIndex(index)
  self:SetPointSelect(self._curPageIndex, false)
  self._curPageIndex = index
  self:SetPointSelect(self._curPageIndex, true)
  self.boxLeftBtnGo:SetActive(not (self._curPageIndex <= 1))
  self.boxRightBtnGo:SetActive(not (self._curPageIndex >= self.jackpotCount))
  self.awardList:MovePanelToItemIndex(self._curPageIndex - 1, 0)
  self.awardList:RefreshAllShownItem()
  self:_RefreshDrawBtnArea()
  self:_RefreshBoxTitle()
  self:_RefreshCurBoxRest()
  self:_RefreshCurBoxCover()
  self:_RefreshLocationText()
  self._pageValue:SetText(self._curPageIndex .. "/" .. self.jackpotCount)
  self:_RefreshDrawBtn()
end

function UIN17LotteryController:_RefreshDrawBtn()
  self.drawSingleCostText:SetText(self.singlePrice)
  self.drawMultiCostText:SetText(self.multiPrice)
  self:_SetPointNumText()
  local totalNum = ClientCampaignDrawShop.GetMoney(self.currencyId)
  if totalNum >= self.singlePrice then
  else
    self.drawSingleCostText.color = Color.red
  end
  if totalNum >= self.multiPrice then
  else
    self.drawMultiCostText.color = Color.red
  end
end

function UIN17LotteryController:_InitBoxPosPoint()
  for index = 1, 10 do
    if index <= self.jackpotCount then
      self.points[index].trans.gameObject:SetActive(true)
    else
      self.points[index].trans.gameObject:SetActive(false)
    end
  end
end

function UIN17LotteryController:_RefreshDrawBtnArea()
  local unlock = self:_IsBoxUnlock(self._curPageIndex)
  self:GetGameObject("LockInfoArea"):SetActive(not unlock)
  self:GetGameObject("DrawBtnArea"):SetActive(unlock)
  if not unlock then
    self:_RefreshLockInfoText()
  else
    self:_RefreshSingleDrawBtn()
    self:_RefreshMultiDrawBtn()
    self:_RefreshDrawBtnNoItemCover()
  end
end

function UIN17LotteryController:_RefreshLockInfoText()
  local name = self._lotteryComponent:GetLotteryBigRewardName(self._curPageIndex - 1)
  local str = StringTable.Get("str_n17_lottery_lock_2", name)
  UIWidgetHelper.SetLocalizationText(self, "LockInfoText", str)
end

function UIN17LotteryController:_RefreshDrawBtnNoItemCover()
  local hasRestItem = self:_CheckAwardRestSingle()
  self.noRestItemTipsCoverGo:SetActive(not hasRestItem)
end

function UIN17LotteryController:_RefreshSingleDrawBtn()
  local bEnableBtn = true
  if not self:_IsBoxUnlock(self._curPageIndex) then
    bEnableBtn = false
  end
  bEnableBtn = bEnableBtn and self:_CheckCurrencyEnable(self.singlePrice)
  bEnableBtn = bEnableBtn and self:_CheckAwardRestSingle()
  self:_EnableSingleDrawBtn(bEnableBtn)
end

function UIN17LotteryController:_RefreshMultiDrawBtn()
  local bEnableBtn = true
  if not self:_IsBoxUnlock(self._curPageIndex) then
    bEnableBtn = false
  end
  bEnableBtn = bEnableBtn and self:_CheckCurrencyEnable(self.multiPrice)
  bEnableBtn = bEnableBtn and self:_CheckAwardRestMulti()
  self:_EnableMultiDrawBtn(bEnableBtn)
end

function UIN17LotteryController:_RefreshBoxTitle()
  local name = self._lotteryComponent:GetLotteryBigRewardName(self._curPageIndex)
  local text = StringTable.Get("str_n17_lottery_pool_title", name)
  UIWidgetHelper.SetLocalizationText(self, "AwardListTitleText", text)
end

function UIN17LotteryController:_RefreshCurBoxRest()
  local curBoxRest = 0
  local curBoxTotal = 0
  if self._curPageIndex > self.jackpotCount then
    return
  end
  local boxData = self.uiData[self._curPageIndex]
  if boxData then
    curBoxRest, curBoxTotal = boxData:GetTotalRestItem()
  end
  local t = StringTable.Get("str_n17_lottery_reward_rest_num")
  local cur = UIActivityHelper.GetColorText("#faaa28", curBoxRest)
  local all = curBoxTotal
  local text = string.format("(%s %s/%s)", t, cur, all)
  UIWidgetHelper.SetLocalizationText(self, "CurBoxRestText", text)
  self:GetGameObject("AwardEmpty"):SetActive(curBoxRest == 0)
end

function UIN17LotteryController:_RefreshCurBoxCover()
  local uiCfg = Cfg.cfg_n17_lottery_box_ui_client[self._curPageIndex]
  if not uiCfg then
    return
  end
  local skip = true
  local spineName = uiCfg.SpineBg
  local animName = uiCfg.SpineBg_Idle
  self._spineBg, skip = UIWidgetHelper.SetSpineLoad(self, "_spineBg", spineName, self._spineBg)
  if not skip then
    UIWidgetHelper.SetSpineAnimation(self._spineBg, 0, animName, true)
  end
  UIWidgetHelper.SetSpineAnimationTimeScale(self._spineBg, 1)
  spineName = uiCfg.SpineNpc
  animName = uiCfg.SpineNpc_Idle
  self._spineNpc, skip = UIWidgetHelper.SetSpineLoad(self, "_spineNpc", spineName, self._spineNpc)
  if not skip then
    UIWidgetHelper.SetSpineAnimation(self._spineNpc, 0, animName, true)
  end
end

function UIN17LotteryController:_RefreshLocationText()
  local type = self._curPageIndex
  local text = StringTable.Get("str_n17_lottery_location_" .. type)
  UIWidgetHelper.SetLocalizationText(self, "LocationText", text)
end

function UIN17LotteryController:_CheckCurrencyEnable(price)
  local haveCurrency = self.clientHelper.GetMoney(self.currencyId)
  if price <= haveCurrency then
    return true
  else
    return false
  end
end

function UIN17LotteryController:_OnItemCountChanged()
  self:_RefreshSingleDrawBtn()
  self:_RefreshMultiDrawBtn()
  self:_RefreshDrawBtnNoItemCover()
  self:_SetPointNumText()
end

function UIN17LotteryController:_GetDefaultPageIndexOnShow()
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

function UIN17LotteryController:_CheckAwardRestSingle()
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

function UIN17LotteryController:_CheckAwardRestMulti()
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

function UIN17LotteryController:DrawSingleBtnOnClick(go)
  self:_DoDraw(ECampaignLotteryType.E_CLT_SINGLE)
end

function UIN17LotteryController:DrawMultiBtnOnClick(go)
  self:_DoDraw(ECampaignLotteryType.E_CLT_MULTI)
end

function UIN17LotteryController:_EnableSingleDrawBtn(enable)
  self.drawSingleBtnGreyCoverGo:SetActive(not enable)
  self.drawSingleBtnCanvas.blocksRaycasts = enable
end

function UIN17LotteryController:_EnableMultiDrawBtn(enable)
  self.drawMultiBtnGreyCoverGo:SetActive(not enable)
  self.drawMultiBtnCanvas.blocksRaycasts = enable
end

function UIN17LotteryController:_CheckCanDrawOnceMore(lotteryType)
  if lotteryType == ECampaignLotteryType.E_CLT_SINGLE then
    local bEnable = true
    if not self:_IsBoxUnlock(self._curPageIndex) then
      bEnable = false
    end
    bEnable = bEnable and self:_CheckCurrencyEnable(self.singlePrice)
    bEnable = bEnable and self:_CheckAwardRestSingle()
    return bEnable
  elseif lotteryType == ECampaignLotteryType.E_CLT_MULTI then
    local bEnable = true
    if not self:_IsBoxUnlock(self._curPageIndex) then
      bEnable = false
    end
    bEnable = bEnable and self:_CheckCurrencyEnable(self.multiPrice)
    bEnable = bEnable and self:_CheckAwardRestMulti()
    return bEnable
  end
  return false
end

function UIN17LotteryController:_DoDraw(lotteryType)
  if self._lotteryState ~= LotteryState.None then
    return
  end
  self._uiModule:LockAchievementFinishPanel(true)
  self._lotteryState = LotteryState.WaitRequestResult
  self._drawTask = self:StartTask(function(TT)
    local res = AsyncRequestRes:New()
    local getRewards, isOpenNew = self:_SendDrawReq(TT, res, self._curPageIndex, lotteryType)
    if res:GetSucc() then
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
        self:SwitchState(UIStateType.UIN17MainController)
      end)
    end
  end, self)
end

function UIN17LotteryController:_SendDrawReq(TT, res, boxIndex, lotteryType)
  if self._lotteryComponent then
    return self._lotteryComponent:HandleLottery(TT, res, boxIndex, lotteryType)
  end
  res:SetSucc(false)
  return nil
end

function UIN17LotteryController:_ShowGetReward(record)
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
  if 0 < #rewards then
    for i = 1, #rewards do
      local roleAsset = RoleAsset:New()
      roleAsset.assetid = rewards[i].m_item_id
      roleAsset.count = rewards[i].m_count
      local ispet = self._petModule:IsPetID(roleAsset.assetid)
      if ispet then
        table.insert(tempPets, roleAsset)
      end
      table.insert(assetAwards, roleAsset)
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
  elseif not curBoxHasRest then
    function cbFunc()
      self:_ForceRefresh(false)
    end
  elseif canDrawOnceMore then
    function cbFunc()
      self:_ForceRefresh(false)
    end
  else
    function cbFunc()
      self:_ForceRefresh(false)
    end
  end
  local getItemCtrl = "UIN17GetItemController"
  if 0 < #tempPets then
    self:ShowDialog("UIPetObtain", tempPets, function()
      GameGlobal.UIStateManager():CloseDialog("UIPetObtain")
      self:ShowDialog(getItemCtrl, assetAwards, cbFunc)
    end)
  else
    self:ShowDialog(getItemCtrl, assetAwards, cbFunc)
  end
end

function UIN17LotteryController:_ConfirmToNextBox()
  local strTitle = StringTable.Get("str_n17_lottery_new_box_unlock_title")
  local name1 = self._lotteryComponent:GetLotteryBigRewardName(self._curPageIndex)
  local name2 = StringTable.Get("str_n17_lottery_location_" .. self._curPageIndex + 1)
  local strText = StringTable.Get("str_n17_lottery_open_next_text", name1, name2)
  local curCost = 10
  
  local function okCb()
    self:_ForceRefresh(true)
  end
  
  self:ShowDialog("UIN17MessageBoxController", strTitle, strText, okCb)
end

function UIN17LotteryController:_LoopBoxRestTips()
  local strTitle = ""
  local strText = StringTable.Get("str_n17_lottery_loop_box_reset_tips")
  local curCost = 10
  
  local function okCb()
    self:_ForceRefresh(true)
  end
  
  self:ShowDialog("UIN17MessageBoxController", strTitle, strText, okCb)
end

function UIN17LotteryController:_RecordRewardsInfo(getRewards, lotteryType, curBoxHasRest, isOpenNew, canDrawOnceMore)
  if not self.rewardRecord then
    self.rewardRecord = DCampaignDrawShopDrawResultRecord:New()
  end
  self.rewardRecord:Record(getRewards, lotteryType, curBoxHasRest, isOpenNew, canDrawOnceMore)
end

function UIN17LotteryController:_ShowDrawSpineAnim(TT, lotteryType)
  local uiCfg = Cfg.cfg_n17_lottery_box_ui_client[self._curPageIndex]
  if not uiCfg then
    return
  end
  local drawType = lotteryType == ECampaignLotteryType.E_CLT_SINGLE and 1 or 2
  local audioId = {
    CriAudioIDConst.N10SingleLottery,
    CriAudioIDConst.N10MultiLottery
  }
  local spineName_1 = uiCfg.SpineNpc
  local animName_1 = uiCfg.SpineNpc_Found
  local animTime_1 = uiCfg.SpineNpc_FoundTime
  local spineName_2 = uiCfg.SpineDraw
  local animName_2 = {
    uiCfg.SpineDraw_Once,
    uiCfg.SpineDraw_Multi
  }
  local animTime_2 = {
    uiCfg.SpineDraw_OnceTime,
    uiCfg.SpineDraw_MultiTime
  }
  self._lottery_spineName_2 = spineName_2
  self._lottery_animName_2 = animName_2[drawType]
  self._lottery_animTime_2 = animTime_2[drawType]
  self._lotteryState = LotteryState.LotterySpine
  UIWidgetHelper.SetSpineAnimationTimeScale(self._spineBg, 0)
  self._spineNpc = UIWidgetHelper.SetSpineLoad(self, "_spineNpc", spineName_1, self._spineNpc)
  UIWidgetHelper.SetSpineAnimation(self._spineNpc, 0, animName_1, false)
  AudioHelperController.PlayUISoundAutoRelease(audioId[drawType])
  YIELD(TT, animTime_1)
  if self._lotteryState ~= LotteryState.LotterySpine then
    return
  end
  self._lotteryState = LotteryState.LotteryResultSpine
  self._spineNpc = UIWidgetHelper.SetSpineLoad(self, "_spineNpc", self._lottery_spineName_2, self._spineNpc)
  UIWidgetHelper.SetSpineAnimation(self._spineNpc, 0, self._lottery_animName_2, false)
  YIELD(TT, self._lottery_animTime_2)
  self._lotteryState = LotteryState.ShowRewards
  self:_ShowGetReward(self.rewardRecord)
end

function UIN17LotteryController:SpineAreaOnClick()
  if string.isnullorempty(self._lottery_spineName_2) or string.isnullorempty(self._lottery_animName_2) or string.isnullorempty(self._lottery_animTime_2) then
    return
  end
  if self._lotteryState ~= LotteryState.LotterySpine then
    return
  end
  self._lotteryState = LotteryState.LotteryResultSpine
  self:StartTask(function(TT)
    self._spineNpc = UIWidgetHelper.SetSpineLoad(self, "_spineNpc", self._lottery_spineName_2, self._spineNpc)
    UIWidgetHelper.SetSpineAnimation(self._spineNpc, 0, self._lottery_animName_2, false)
    YIELD(TT, self._lottery_animTime_2)
    self._lotteryState = LotteryState.ShowRewards
    self:_ShowGetReward(self.rewardRecord)
  end)
end

function UIN17LotteryController:_CheckIsRestRepeatBox()
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

function UIN17LotteryController:RuleDescriptionBtnOnClick(go)
  if self._lotteryState ~= LotteryState.None then
    return
  end
  self:ShowDialog("UIN17Intro2Controller", "UIN17Intro2Controller_Lottery", true)
end
