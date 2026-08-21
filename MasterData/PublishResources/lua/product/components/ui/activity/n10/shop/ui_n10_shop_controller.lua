local LotteryState = {
  None = 1,
  WaitRequestResult = 2,
  LotterySpine = 3,
  LotteryResultSpine = 4,
  ShowRewards = 5
}
_enum("LotteryState", LotteryState)
_class("UIN10ShopController", UIController)
UIN10ShopController = UIN10ShopController

function UIN10ShopController:Constructor()
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
  self._curSpine = ""
  self._atlas = self:GetAsset("UIN10.spriteatlas", LoadType.SpriteAtlas)
  self._timeEvents = {}
  self._lastUpdateSpineHolderAlpha = -1
  self._lotterySpine = nil
  self._lotterySpineTime = 0
  self._lotteryResultSpine = nil
  self._lotteryResultSpineTime = 0
  self._lotteryState = LotteryState.None
  self._playJackpotAnim = true
end

function UIN10ShopController:LoadDataOnEnter(TT, res, uiParams)
  self._campaignModule = GameGlobal.GetModule(CampaignModule)
  self._campaign = UIActivityCampaign:New()
  self._campaign:LoadCampaignInfo(TT, res, ECampaignType.CAMPAIGN_TYPE_N10, ECampaignN10ComponentID.ECAMPAIGN_N10_LOTTERY)
  if res and not res:GetSucc() then
    self._campaignModule:CheckErrorCode(res.m_result, self._campaign._id, nil, nil)
    return
  end
  self._lotteryComponent = self._campaign:GetComponent(ECampaignN10ComponentID.ECAMPAIGN_N10_LOTTERY)
  self._lotteryComponentInfo = self._campaign:GetComponentInfo(ECampaignN10ComponentID.ECAMPAIGN_N10_LOTTERY)
end

function UIN10ShopController:OnShow(uiParams)
  self._closeCallBack = uiParams[1]
  self:_GetComponents()
  self:_InitData(true, true)
  self:_InitBoxCoverSpine()
  self:_InitBoxPosPoint()
  self:_InitAwardListUi()
  self:_SetAwardListToPageIndex(self._initPageIndex)
  self:_AttachEvents()
end

function UIN10ShopController:OnHide()
  if self._spine then
    self._spine:DestroyCurrentSpine()
    self._spine = nil
  end
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

function UIN10ShopController:_AttachEvents()
  self:AttachEvent(GameEventType.ActivityCloseEvent, self._CheckActivityClose)
  self:AttachEvent(GameEventType.ItemCountChanged, self._OnItemCountChanged)
end

function UIN10ShopController:_CheckActivityClose(id)
  if self._campaign and self._campaign._id == id then
    self:SwitchState(UIStateType.UIMain)
  end
end

function UIN10ShopController:_ForceRefresh(isOpenNew)
  self:Lock("UIN10ShopController:_ForceRefresh")
  self._playJackpotAnim = false
  self:_InitData(isOpenNew)
  self:_SetAwardListToPageIndex(self._initPageIndex)
  self._timeEvents._delayUnlockTimeEvent = GameGlobal.Timer():AddEvent(1, function()
    self:UnLock("UIN10ShopController:_ForceRefresh")
  end)
end

function UIN10ShopController:_GetComponents()
  self.awardList = self:GetUIComponent("UIDynamicScrollView", "AwardList")
  self.drawBtnAreaGo = self:GetGameObject("DrawBtnArea")
  self.lockInfoAreaGo = self:GetGameObject("LockInfoArea")
  self.lockInfoText = self:GetUIComponent("UILocalizationText", "LockInfoText")
  self.noRestItemTipsCoverGo = self:GetGameObject("NoRestItemTipsCover")
  self.drawSingleBtn = self:GetGameObject("DrawSingleBtn")
  self.drawSingleBtnImg = self:GetUIComponent("Image", "DrawSingleBtn")
  self.drawSingleBtnGreyCoverGo = self:GetGameObject("DrawSingleBtnGreyCover")
  self.drawSingleBtnGreyCoverGoImg = self:GetUIComponent("Image", "DrawSingleBtnGreyCover")
  self.drawSingleBtnCanvas = self:GetUIComponent("CanvasGroup", "DrawSingleBtn")
  self:AddUICustomEventListener(UICustomUIEventListener.Get(self.drawSingleBtn), UIEvent.Press, function(go)
    self.drawSingleBtnImg.sprite = self._atlas:GetSprite(ShopTheme.SingleLotteryBtnPressBg[ShopTheme.Theme])
  end)
  self:AddUICustomEventListener(UICustomUIEventListener.Get(self.drawSingleBtn), UIEvent.Release, function(go)
    self.drawSingleBtnImg.sprite = self._atlas:GetSprite(ShopTheme.SingleLotteryBtnBg[ShopTheme.Theme])
  end)
  self.drawMultiBtn = self:GetGameObject("DrawMultiBtn")
  self.drawMultiBtnImg = self:GetUIComponent("Image", "DrawMultiBtn")
  self.drawMultiBtnGreyCoverGo = self:GetGameObject("DrawMultiBtnGreyCover")
  self.drawMultiBtnGreyCoverGoImg = self:GetUIComponent("Image", "DrawMultiBtnGreyCover")
  self.drawMultiBtnCanvas = self:GetUIComponent("CanvasGroup", "DrawMultiBtn")
  self:AddUICustomEventListener(UICustomUIEventListener.Get(self.drawMultiBtn), UIEvent.Press, function(go)
    self.drawMultiBtnImg.sprite = self._atlas:GetSprite(ShopTheme.MutliLotteryBtnPressBg[ShopTheme.Theme])
  end)
  self:AddUICustomEventListener(UICustomUIEventListener.Get(self.drawMultiBtn), UIEvent.Release, function(go)
    self.drawMultiBtnImg.sprite = self._atlas:GetSprite(ShopTheme.MutliLotteryBtnBg[ShopTheme.Theme])
  end)
  self.drawMultiCostIcon = self:GetUIComponent("Image", "DrawMultiCostIcon")
  self.drawSingleCostIcon = self:GetUIComponent("Image", "DrawSingleCostIcon")
  self.drawSingleBtnText = self:GetUIComponent("UILocalizationText", "DrawSingleBtnText")
  self.drawSingleCostText = self:GetUIComponent("UILocalizationText", "DrawSingleCostText")
  self.drawMultiCostText = self:GetUIComponent("UILocalizationText", "DrawMultiCostText")
  self.drawMultiBtnText = self:GetUIComponent("UILocalizationText", "DrawMultiBtnText")
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
  self.curBoxRestText = self:GetUIComponent("UILocalizationText", "CurBoxRestText")
  self.awardListTitleText = self:GetUIComponent("UILocalizationText", "AwardListTitleText")
  self.grayColor = Color(0.39215686274509803, 0.39215686274509803, 0.39215686274509803)
  self.clientCfg = Cfg.cfg_activity_draw_shop_client[self._campaign._id]
  self.spineHolderCG = self:GetUIComponent("CanvasGroup", "SpineHolder")
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
  self._mask = self:GetUIComponent("RectTransform", "Mask")
  self._mask.localScale = Vector3(ResolutionManager.RealWidth(), ResolutionManager.RealHeight(), 0)
  self._awardListTitleArea = self:GetUIComponent("RawImage", "AwardListTitleArea")
  self._awardListTitleAreaImg = self:GetUIComponent("RawImageLoader", "AwardListTitleArea")
  self._bg = self:GetUIComponent("RawImage", "bg")
  self._top = self:GetUIComponent("RawImage", "top")
  self._bottom = self:GetUIComponent("RawImage", "bottom")
  self:_SetStencil(self._awardListTitleArea)
  self:_SetStencil(self._bg)
  self:_SetStencil(self._top)
  self:_SetStencil(self._bottom)
  self._drawSingleBtnImg = self:GetUIComponent("Image", "DrawSingleBtn")
  self._drawMultiBtnImg = self:GetUIComponent("Image", "DrawMultiBtn")
end

function UIN10ShopController:_SetStencil(rawImage)
  rawImage.materialForRendering:SetFloat("_Stencil", 17)
  rawImage.materialForRendering:SetFloat("_StencilComp", 3)
  rawImage.materialForRendering:SetFloat("_StencilOp", 0)
end

function UIN10ShopController:RegUIEventTriggerListener(onBeginDrag, onDrag, onEndDrag)
  self:AddUICustomEventListener(self.etl, UIEvent.BeginDrag, onBeginDrag)
  self:AddUICustomEventListener(self.etl, UIEvent.Drag, onDrag)
  self:AddUICustomEventListener(self.etl, UIEvent.EndDrag, onEndDrag)
end

function UIN10ShopController:OnBeginDrag(ped)
  local deltaX = ped.delta.x
  if self:IsEdge(deltaX) then
    return
  end
  local pos = UIN10ShopController.ScreenPointToLocalPointInRectangle(self.selfRect, ped)
  self._xBegainDrag = pos.x
end

function UIN10ShopController:OnDrag(ped)
  local pos = UIN10ShopController.ScreenPointToLocalPointInRectangle(self.selfRect, ped)
  self._xCurDrag = pos.x
end

function UIN10ShopController:OnEndDrag(ped)
  self:InitDragField()
end

function UIN10ShopController:OnPress()
end

function UIN10ShopController:_UpdateDragSwitch()
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

function UIN10ShopController.ScreenPointToLocalPointInRectangle(rect, ped)
  local res, pos = UnityEngine.RectTransformUtility.ScreenPointToLocalPointInRectangle(rect, ped.position, ped.pressEventCamera, nil)
  return pos
end

function UIN10ShopController:IsEdge(deltaX)
  if 0 < deltaX and self._curPageIndex == 1 then
    return true
  end
  if deltaX < 0 and self._curPageIndex == self.jackpotCount then
    return true
  end
  return false
end

function UIN10ShopController:InitDragField()
  self._xBegainDrag = nil
  self._xCurDrag = nil
  self._posBGLogo = Vector2(-667, 0)
end

function UIN10ShopController:_InitData(isOpenNew, isOnShow)
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

function UIN10ShopController:CloseDialogWithAnim()
  if self._lotteryState ~= LotteryState.None then
    return
  end
  self:CloseDialog()
end

function UIN10ShopController:ShowMainUI()
  if self._lotteryState ~= LotteryState.None then
    return
  end
  self:SwitchState(UIStateType.UIMain)
end

function UIN10ShopController:_InitAwardListUi()
  self.awardList:InitListView(self.jackpotCount, function(scrollview, index)
    return self:_OnGetAwardBoxCell(scrollview, index)
  end)
  self.awardList.ScrollRect.enabled = false
end

function UIN10ShopController:_InitBoxCoverSpine()
  self._spine = self:GetUIComponent("SpineLoader", "spine")
  self._spineGo = self:GetGameObject("spine")
  local uiCfg = Cfg.cfg_n10_shop_box_ui_client[1]
  if uiCfg and self._spine then
    self._curSpine = uiCfg.CoverBaseSpine
    self._spine:LoadSpine(self._curSpine)
    self._spineSkeMultipleTex = self._spineGo:GetComponentInChildren(typeof(Spine.Unity.Modules.SkeletonGraphicMultiObject))
    self._spineSkeMultipleTex.UseInstanceMaterials = true
    
    function self._spineSkeMultipleTex.OnInstanceMaterialCreated(material)
      material:SetFloat("_StencilRef", 17)
      material:SetFloat("_StencilComp", 3)
    end
  end
end

function UIN10ShopController:_OnGetAwardBoxCell(scrollview, index)
  local item = scrollview:NewListViewItem("AwardBoxCell")
  local cellPool = self:GetUIComponentDynamic("UISelectObjectPath", item.gameObject)
  if item.IsInitHandlerCalled == false then
    item.IsInitHandlerCalled = true
    cellPool:SpawnObjects("UIN10ShopAwardBoxCell", 1)
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

function UIN10ShopController:SetPointSelect(index, select)
  if select then
    if self.points[index] then
      self.points[index].image.sprite = self._atlas:GetSprite("n10_gacha_dian2")
      self.points[index].rect.sizeDelta = Vector2(68, 26)
    end
  elseif self.points[index] then
    self.points[index].image.sprite = self._atlas:GetSprite("n10_gacha_dian1")
    self.points[index].rect.sizeDelta = Vector2(26, 26)
  end
end

function UIN10ShopController:BoxLeftBtnOnClick(go)
  if self._lotteryState ~= LotteryState.None then
    return
  end
  local nextIndex = self._curPageIndex - 1
  if nextIndex < 1 then
    return
  end
  self._playJackpotAnim = false
  self:_SetAwardListToPageIndex(nextIndex)
end

function UIN10ShopController:BoxRightBtnOnClick(go)
  if self._lotteryState ~= LotteryState.None then
    return
  end
  local nextIndex = self._curPageIndex + 1
  if nextIndex > self.jackpotCount then
    return
  end
  self._playJackpotAnim = false
  self:_SetAwardListToPageIndex(nextIndex)
end

function UIN10ShopController:OnUpdate(deltaTimeMS)
  if self._spineSke and self.spineHolderCG then
    local curAlpha = self.spineHolderCG.alpha
    if self._lastUpdateSpineHolderAlpha ~= curAlpha then
      self._lastUpdateSpineHolderAlpha = curAlpha
      self._spineSke.color = Color(1, 1, 1, curAlpha)
      self._spineSke.Skeleton.A = curAlpha
    end
  end
  self:_UpdateDragSwitch()
end

function UIN10ShopController:_ShowItemTips(data)
  if self._lotteryState ~= LotteryState.None then
    return
  end
  self:ShowDialog("UIN10ShopTipsController", data)
end

function UIN10ShopController:NoRestItemTipsCoverOnClick(go)
  ToastManager.ShowToast(StringTable.Get("str_n10_shop_no_item_tips"))
end

function UIN10ShopController:_IsBoxUnlock(boxIndex)
  if self._lotteryComponent then
    return self._lotteryComponent:IsLotteryJackpotUnlock(boxIndex)
  end
  return false
end

function UIN10ShopController:_SetAwardListToPageIndex(index)
  self:SetPointSelect(self._curPageIndex, false)
  self._curPageIndex = index
  local uiCfg = Cfg.cfg_n10_shop_box_ui_client[self._curPageIndex]
  if uiCfg then
    ShopTheme.Theme = uiCfg.Sheme
  end
  self:SetPointSelect(self._curPageIndex, true)
  self.boxLeftBtnGo:SetActive(not (self._curPageIndex <= 1))
  self.boxRightBtnGo:SetActive(not (self._curPageIndex >= self.jackpotCount))
  self.awardList:MovePanelToItemIndex(self._curPageIndex - 1, 0)
  self.awardList:RefreshAllShownItem()
  self:_RefreshDrawBtnArea()
  self:_RefreshBoxTitle()
  self:_RefreshCurBoxRest()
  self:_RefreshCurBoxCover()
  self._pageValue:SetText(self._curPageIndex .. "/" .. self.jackpotCount)
  self._awardListTitleAreaImg:LoadImage(ShopTheme.JackPotTitleBg[ShopTheme.Theme])
  self:_RefreshDrawBtn()
end

function UIN10ShopController:_RefreshDrawBtn()
  self.drawSingleCostText:SetText(self.singlePrice)
  self.drawMultiCostText:SetText(self.multiPrice)
  local singleText = "str_n10_lottery_one"
  if self.clientCfg then
    singleText = self.clientCfg.DrawOnceText
  end
  self.drawSingleBtnText:SetText(StringTable.Get(singleText))
  local multiText = "str_n10_lottery_one"
  if self.clientCfg then
    multiText = self.clientCfg.DrawMultiText
  end
  self.drawMultiBtnText:SetText(StringTable.Get(multiText))
  local totalNum = ClientCampaignDrawShop.GetMoney(self.currencyId)
  self.pointNumText:SetText(totalNum)
  self._drawSingleBtnImg.sprite = self._atlas:GetSprite(ShopTheme.SingleLotteryBtnBg[ShopTheme.Theme])
  self.drawSingleBtnText.color = ShopTheme.SingleLotteryBtnTextColor[ShopTheme.Theme]
  self._drawMultiBtnImg.sprite = self._atlas:GetSprite(ShopTheme.MutliLotteryBtnBg[ShopTheme.Theme])
  if totalNum >= self.singlePrice then
    self.drawSingleCostText.color = ShopTheme.SingleLotteryBtnTextColor[ShopTheme.Theme]
  else
    self.drawSingleCostText.color = Color.red
  end
  if totalNum >= self.multiPrice then
    self.drawMultiCostText.color = Color.white
  else
    self.drawMultiCostText.color = Color.red
  end
end

function UIN10ShopController:_InitBoxPosPoint()
  for index = 1, 10 do
    if index <= self.jackpotCount then
      self.points[index].trans.gameObject:SetActive(true)
    else
      self.points[index].trans.gameObject:SetActive(false)
    end
  end
end

function UIN10ShopController:_RefreshDrawBtnArea()
  if not self:_IsBoxUnlock(self._curPageIndex) then
    self.drawBtnAreaGo:SetActive(false)
    self.lockInfoAreaGo:SetActive(true)
    self:_RefreshLockInfoText()
  else
    self.drawBtnAreaGo:SetActive(true)
    self.lockInfoAreaGo:SetActive(false)
    self:_RefreshSingleDrawBtn()
    self:_RefreshMultiDrawBtn()
    self:_RefreshDrawBtnNoItemCover()
  end
end

function UIN10ShopController:_RefreshLockInfoText()
  local str = StringTable.Get("str_n10_shop_box_unlock_intro", self._curPageIndex - 1)
  self.lockInfoText:SetText(str)
end

function UIN10ShopController:_RefreshDrawBtnNoItemCover()
  local hasRestItem = self:_CheckAwardRestSingle()
  self.noRestItemTipsCoverGo:SetActive(not hasRestItem)
end

function UIN10ShopController:_RefreshSingleDrawBtn()
  local bEnableBtn = true
  if not self:_IsBoxUnlock(self._curPageIndex) then
    bEnableBtn = false
  end
  bEnableBtn = bEnableBtn and self:_CheckCurrencyEnable(self.singlePrice)
  bEnableBtn = bEnableBtn and self:_CheckAwardRestSingle()
  self:_EnableSingleDrawBtn(bEnableBtn)
end

function UIN10ShopController:_RefreshMultiDrawBtn()
  local bEnableBtn = true
  if not self:_IsBoxUnlock(self._curPageIndex) then
    bEnableBtn = false
  end
  bEnableBtn = bEnableBtn and self:_CheckCurrencyEnable(self.multiPrice)
  bEnableBtn = bEnableBtn and self:_CheckAwardRestMulti()
  self:_EnableMultiDrawBtn(bEnableBtn)
end

function UIN10ShopController:_RefreshBoxTitle()
  local boxNameText = StringTable.Get("str_n10_lottery_pool", self._curPageIndex)
  self.awardListTitleText:SetText(boxNameText)
end

function UIN10ShopController:_RefreshCurBoxRest()
  local curBoxRest = 0
  local curBoxTotal = 0
  if self._curPageIndex > self.jackpotCount then
    return
  end
  local boxData = self.uiData[self._curPageIndex]
  if boxData then
    curBoxRest, curBoxTotal = boxData:GetTotalRestItem()
  end
  local tmpText = "(" .. StringTable.Get("str_n10_shop_award_rest_num") .. " " .. "<color=#F6e834>" .. curBoxRest .. "</color>" .. "/" .. curBoxTotal .. ")"
  self.curBoxRestText:SetText(tmpText)
end

function UIN10ShopController:_RefreshCurBoxCover()
  local uiCfg = Cfg.cfg_n10_shop_box_ui_client[self._curPageIndex]
  if uiCfg then
    if self._curSpine and uiCfg.CoverBaseSpine and self._curSpine ~= uiCfg.CoverBaseSpine then
      self._curSpine = uiCfg.CoverBaseSpine
      self._spine:LoadSpine(uiCfg.CoverBaseSpine)
    end
    if self._spine then
      self._spineSke = self._spine.CurrentSkeleton
      if not self._spineSke then
        self._spineSke = self._spine.CurrentMultiSkeleton
      end
      if self._spineSke then
        self._spineSke.AnimationState:SetAnimation(0, uiCfg.IdleAnim, true)
      end
    end
  end
end

function UIN10ShopController:_CheckCurrencyEnable(price)
  local haveCurrency = self.clientHelper.GetMoney(self.currencyId)
  if price <= haveCurrency then
    return true
  else
    return false
  end
end

function UIN10ShopController:_OnItemCountChanged()
  self:_RefreshSingleDrawBtn()
  self:_RefreshMultiDrawBtn()
  self:_RefreshDrawBtnNoItemCover()
  local totalNum = ClientCampaignDrawShop.GetMoney(self.currencyId)
  self.pointNumText:SetText(totalNum)
end

function UIN10ShopController:_GetDefaultPageIndexOnShow()
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

function UIN10ShopController:_CheckAwardRestSingle()
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

function UIN10ShopController:_CheckAwardRestMulti()
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

function UIN10ShopController:DrawSingleBtnOnClick(go)
  self:_DoDraw(ECampaignLotteryType.E_CLT_SINGLE)
end

function UIN10ShopController:DrawMultiBtnOnClick(go)
  self:_DoDraw(ECampaignLotteryType.E_CLT_MULTI)
end

function UIN10ShopController:_EnableSingleDrawBtn(enable)
  self.drawSingleBtnGreyCoverGo:SetActive(not enable)
  self.drawSingleBtnGreyCoverGoImg.sprite = self._atlas:GetSprite(ShopTheme.SingleLotteryBtnPressBg[ShopTheme.Theme])
  self.drawSingleBtnCanvas.blocksRaycasts = enable
end

function UIN10ShopController:_EnableMultiDrawBtn(enable)
  self.drawMultiBtnGreyCoverGo:SetActive(not enable)
  self.drawMultiBtnGreyCoverGoImg.sprite = self._atlas:GetSprite(ShopTheme.MutliLotteryBtnPressBg[ShopTheme.Theme])
  self.drawMultiBtnCanvas.blocksRaycasts = enable
end

function UIN10ShopController:GetNumberCN(num)
  if num <= 0 then
    return nil
  elseif num < 11 then
    return StringTable.Get("str_n10_shop_number_" .. num)
  elseif num < 100 then
    local gewei = num % 10
    local shiwei = math.floor(num / 10)
    local str = ""
    if shiwei == 1 then
      str = str .. StringTable.Get("str_n10_shop_number_10")
    else
      str = str .. StringTable.Get("str_n10_shop_number_" .. shiwei) .. StringTable.Get("str_n10_shop_number_10")
    end
    if gewei == 0 then
      return str
    else
      return str .. StringTable.Get("str_n10_shop_number_" .. gewei)
    end
  else
    return StringTable.Get("str_n10_shop_number_99")
  end
end

function UIN10ShopController:_CheckCanDrawOnceMore(lotteryType)
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

function UIN10ShopController:_DoDraw(lotteryType)
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
        self:CloseDialog()
      end)
    end
  end, self)
end

function UIN10ShopController:_SendDrawReq(TT, res, boxIndex, lotteryType)
  if self._lotteryComponent then
    return self._lotteryComponent:HandleLottery(TT, res, boxIndex, lotteryType)
  end
  res:SetSucc(false)
  return nil
end

function UIN10ShopController:_ShowGetReward(record)
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
  local getItemCtrl = "UIGetItemController"
  if 0 < #tempPets then
    self:ShowDialog("UIPetObtain", tempPets, function()
      GameGlobal.UIStateManager():CloseDialog("UIPetObtain")
      self:ShowDialog(getItemCtrl, assetAwards, cbFunc)
    end)
  else
    self:ShowDialog(getItemCtrl, assetAwards, cbFunc)
  end
end

function UIN10ShopController:_ConfirmToNextBox()
  local strTitle = StringTable.Get("str_n10_shop_new_box_unlock_title")
  local strText = StringTable.Get("str_n10_shop_open_next_text", self._curPageIndex, self._curPageIndex + 1)
  local curCost = 10
  
  local function okCb()
    self:_ForceRefresh(true)
  end
  
  PopupManager.Alert("UICommonMessageBox", PopupPriority.Normal, PopupMsgBoxType.Ok, strTitle, strText, okCb, nil)
end

function UIN10ShopController:_LoopBoxRestTips()
  local strTitle = ""
  local strText = StringTable.Get("str_n10_shop_loop_box_reset_tips")
  local curCost = 10
  
  local function okCb()
    self:_ForceRefresh(true)
  end
  
  PopupManager.Alert("UICommonMessageBox", PopupPriority.Normal, PopupMsgBoxType.Ok, strTitle, strText, okCb, nil)
end

function UIN10ShopController:_ConfirmDrawOnceMore(lotteryType)
  local price = self.singlePrice
  if lotteryType == ECampaignLotteryType.E_CLT_MULTI then
    price = self.multiPrice
  end
  local strText = StringTable.Get("str_n10_shop_draw_once_more_text", price)
  
  local function okCb()
    self:_ForceRefresh(false)
    self:_DoDraw(lotteryType)
  end
  
  local function cancelCb()
    self:_ForceRefresh(false)
  end
  
  PopupManager.Alert("UICommonMessageBox", PopupPriority.Normal, PopupMsgBoxType.OkCancel, "", strText, okCb, nil, cancelCb)
end

function UIN10ShopController:_RecordRewardsInfo(getRewards, lotteryType, curBoxHasRest, isOpenNew, canDrawOnceMore)
  if not self.rewardRecord then
    self.rewardRecord = DCampaignDrawShopDrawResultRecord:New()
  end
  self.rewardRecord:Record(getRewards, lotteryType, curBoxHasRest, isOpenNew, canDrawOnceMore)
end

function UIN10ShopController:_ShowDrawSpineAnim(TT, lotteryType)
  self._lotterySpine = nil
  self._lotterySpineTime = 0
  self._lotteryResultSpine = nil
  self._lotteryResultSpineTime = 0
  local criAudioID = CriAudioIDConst.N10SingleLottery
  local uiCfg = Cfg.cfg_n10_shop_box_ui_client[self._curPageIndex]
  if uiCfg and self._spine then
    self._spineSke = self._spine.CurrentSkeleton
    if not self._spineSke then
      self._spineSke = self._spine.CurrentMultiSkeleton
    end
    if lotteryType == ECampaignLotteryType.E_CLT_SINGLE then
      self._lotterySpine = uiCfg.DrawOnceAnim
      self._lotterySpineTime = uiCfg.DrawOnceAnimTime
      self._lotteryResultSpine = uiCfg.DrawOnceResultAnim
      self._lotteryResultSpineTime = uiCfg.DrawOnceResultAnimTime
      criAudioID = CriAudioIDConst.N10SingleLottery
    elseif lotteryType == ECampaignLotteryType.E_CLT_MULTI then
      self._lotterySpine = uiCfg.DrawMultiAnim
      self._lotterySpineTime = uiCfg.DrawMultiAnimTime
      self._lotteryResultSpine = uiCfg.DrawMultiResultAnim
      self._lotteryResultSpineTime = uiCfg.DrawMultiResultAnimTime
      criAudioID = CriAudioIDConst.N10MultiLottery
    end
    if self._spineSke then
      self._lotteryState = LotteryState.LotterySpine
      self._spineSke.AnimationState:SetAnimation(0, self._lotterySpine, false)
      AudioHelperController.PlayUISoundAutoRelease(criAudioID)
      YIELD(TT, self._lotterySpineTime)
      if self._lotteryState ~= LotteryState.LotterySpine then
        return
      end
      self._lotteryState = LotteryState.LotteryResultSpine
      self._spineSke.AnimationState:SetAnimation(0, self._lotteryResultSpine, false)
    end
  end
  YIELD(TT, self._lotteryResultSpineTime)
  self._lotteryState = LotteryState.ShowRewards
  self:_ShowGetReward(self.rewardRecord)
end

function UIN10ShopController:SpineAreaOnClick()
  if self._lotteryState ~= LotteryState.LotterySpine then
    return
  end
  self._lotteryState = LotteryState.LotteryResultSpine
  self:StartTask(function(TT)
    self._spineSke.AnimationState:SetAnimation(0, self._lotteryResultSpine, false)
    YIELD(TT, self._lotteryResultSpineTime)
    self._lotteryState = LotteryState.ShowRewards
    self:_ShowGetReward(self.rewardRecord)
  end)
end

function UIN10ShopController:_CheckIsRestRepeatBox()
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

function UIN10ShopController:RuleDescriptionBtnOnClick(go)
  if self._lotteryState ~= LotteryState.None then
    return
  end
  self:ShowDialog("UIN10IntroController", "UIN10ShopController")
end
