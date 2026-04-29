_class("UIActivityShopControllerBase", UIController)
UIActivityShopControllerBase = UIActivityShopControllerBase

function UIActivityShopControllerBase:Constructor()
  self._shopCloseTime = 0
  self._svrTimeModule = self:GetModule(SvrTimeModule)
  self._interactWords = nil
  self._wordStack = nil
  self._spineSke = nil
  self._animInfo = {
    name = "uieff_Activity_Eve_Shop_Out",
    len = 400
  }
  UIActivityShopControllerBase.ItemGroupHeight = 800
end

function UIActivityShopControllerBase:DefaultBackFunc()
end

function UIActivityShopControllerBase:_InitCmpt(TT, res)
  if #self.params < 2 then
    res:SetSucc(false)
    self:CloseDialog()
    return
  end
  local campaignType = self.params[1]
  local campaignId = self.params[2]
  self._backCallback = self.params[3]
  self._commonCfg = Cfg.cfg_activity_shop_common_client[campaignId]
  local cmptIds
  if self._commonCfg then
    cmptIds = self._commonCfg.ComponentIds
  end
  local campaignModule = GameGlobal.GetModule(CampaignModule)
  self._campaign = UIActivityCampaign:New()
  self._campaign:LoadCampaignInfo(TT, res, campaignType, table.unpack(cmptIds))
  if res and not res:GetSucc() then
    campaignModule:CheckErrorCode(res.m_result, self._campaign._id)
    self:CloseDialog()
    return
  end
  self._campaignId = self._campaign._id
  if self._campaignId ~= -1 then
    self._exchangeCmpts = {}
    for index, value in ipairs(cmptIds) do
      local exchangeCmpt = self._campaign:GetComponent(value)
      if exchangeCmpt then
        local cmptInfo = exchangeCmpt:GetComponentInfo()
        if cmptInfo then
          local nowTime = math.floor(self._svrTimeModule:GetServerTime() / 1000)
          local openTime = cmptInfo.m_unlock_time
          local closeTime = cmptInfo.m_close_time
          if nowTime < openTime then
            ToastManager.ShowToast(StringTable.Get("str_activity_error_110"))
          elseif nowTime > closeTime then
            ToastManager.ShowToast(StringTable.Get("str_activity_error_107"))
          else
            table.insert(self._exchangeCmpts, exchangeCmpt)
            if self._shopCloseTime == 0 then
              self._shopCloseTime = cmptInfo.m_close_time
            end
          end
        end
      end
    end
    if #self._exchangeCmpts == 0 then
      res:SetSucc(false)
      self:CloseDialog()
    end
  end
end

function UIActivityShopControllerBase:OnShow(uiParams)
  self:AddListener()
  self:InitWidget()
  self:InitPlayerSpine()
end

function UIActivityShopControllerBase:InitWidget()
  self._rootAnim = self:GetUIComponent("Animation", "Root")
  local backBtn = self:GetUIComponent("UISelectObjectPath", "BackBtn")
  self._backBtns = backBtn:SpawnObject("UICommonTopButton")
  self._lastBGMResName = AudioHelperController.GetCurrentBgm()
  self._backBtns:SetData(function()
    self:BackBtnFunc()
    AudioHelperController.PlayBGM(self._lastBGMResName, AudioConstValue.BGMCrossFadeTime)
  end)
  self._npcWordText = self:GetUIComponent("UILocalizationText", "NpcWordText")
  self._npcNameText = self:GetUIComponent("UILocalizationText", "NpcNameText")
  self._npcNameTextShadow = self:GetUIComponent("UILocalizationText", "NpcNameTextShadow")
  self._endTimeText = self:GetUIComponent("UILocalizationText", "EndTimeText")
  self._endTimeTextGo = self:GetGameObject("EndTimeText")
  self._uianimCG = self:GetUIComponent("CanvasGroup", "uianim")
  self._shopItemGroupList = self:GetUIComponent("UIDynamicScrollView", "ShopItemGroupList")
  self._refreshTaskID = nil
  self._event = nil
  self._refreshGroupEvent = nil
  self._restTime = 0
  self:_FillCfgUiRes()
  self:_FillUiData()
  self:_InitShopItemGroupList()
  self:_RefreshUi()
  self:_StartCheckGoodsGroupRefresh()
  self.itemCount = self:GetUIComponent("UILocalizationText", "itemCount")
  self.pointIcon = self:GetUIComponent("RawImageLoader", "PointIcon")
  self:_RefreshCurrency()
end

function UIActivityShopControllerBase:_RefreshCurrency()
  if not self._currencyId then
    self._currencyId = self._commonCfg.CurrencyId
  end
  local _count = self:GetModule(ItemModule):GetItemCount(self._currencyId)
  _count = _count or 0
  self.itemCount:SetText(_count)
  if self.pointIcon then
    local currencyIcon = ""
    local cfgItem = Cfg.cfg_item[self._currencyId]
    if cfgItem then
      currencyIcon = cfgItem.Icon
      self.pointIcon:LoadImage(currencyIcon)
    end
  end
end

function UIActivityShopControllerBase:_FillCfgUiRes()
  local shopCfg = self._commonCfg
  if shopCfg then
    if self._npcNameText then
      self._npcNameText:SetText(StringTable.Get(shopCfg.NpcName))
      if self._npcNameTextShadow then
        self._npcNameTextShadow:SetText(StringTable.Get(shopCfg.NpcName))
      end
    end
    self._interactWords = string.split(StringTable.Get(shopCfg.NpcWord), "|")
    self._wordStack = Stack:New()
    if self._npcWordText then
      local word = self:_GetInteractWord()
      self._npcWordText:SetText(word)
    end
  end
end

function UIActivityShopControllerBase:OnActivityShopBuySuccess(goodsId)
  self:_ForceRefresh()
end

function UIActivityShopControllerBase:_ForceRefresh()
  self._refreshTaskID = self:StartTask(function(TT)
    local res = AsyncRequestRes:New()
    res:SetSucc(true)
    self:_InitCmpt(TT, res)
    if res and res:GetSucc() then
      self:_FillUiData()
      self:_RefreshUi()
      self:_RefreshCurrency()
    end
  end, self)
end

function UIActivityShopControllerBase:BackBtnFunc()
  self:CloseDialogWithAnim()
end

function UIActivityShopControllerBase:CloseDialogWithAnim()
  self:Lock("UIActivityShopControllerBase:CloseDialogWithAnim")
  if self._rootAnim then
    self._rootAnim:Play(self._animInfo.name)
  end
  self:StartTask(function(TT)
    YIELD(TT, self._animInfo.len)
    self:UnLock("UIActivityShopControllerBase:CloseDialogWithAnim")
    if self._backCallback then
      self._backCallback()
    else
      self:DefaultBackFunc()
    end
  end, self)
end

function UIActivityShopControllerBase:_FillUiData()
  local boxItemLimit = 2
  local tmpData = {}
  for index, value in ipairs(self._exchangeCmpts) do
    local exchangeInfo = value:GetComponentInfo()
    local itemGroupData = DCampaignShopItemGroup:New()
    local smallBoxData = {}
    local smallItemCountInBox = 0
    for itemIndex, itemInfo in ipairs(exchangeInfo.m_exchange_item_list) do
      local uiItemData = DCampaignShopItemBase:New()
      uiItemData:Refresh(itemInfo, value)
      if uiItemData:GetIsSpecial() then
        table.insert(itemGroupData, uiItemData)
      else
        smallItemCountInBox = smallItemCountInBox + 1
        table.insert(smallBoxData, uiItemData)
        if smallItemCountInBox == boxItemLimit or itemIndex == #exchangeInfo.m_exchange_item_list then
          table.insert(itemGroupData, smallBoxData)
          smallBoxData = {}
          smallItemCountInBox = 0
        end
      end
    end
    itemGroupData._unlockTime = exchangeInfo.m_unlock_time
    itemGroupData._showTime = exchangeInfo.m_open_time
    itemGroupData._closeTime = exchangeInfo.m_close_time
    local nowTime = math.floor(self._svrTimeModule:GetServerTime() / 1000)
    itemGroupData._isShow = ClientCampaignShop.CheckIsGoodsGroupCanShow(itemGroupData._showTime, nowTime)
    itemGroupData._isUnlock = ClientCampaignShop.CheckIsGoodsGroupUnlock(itemGroupData._unlockTime, nowTime)
    itemGroupData._isClose = ClientCampaignShop.CheckIsGoodsGroupUnlock(itemGroupData._closeTime, nowTime)
    itemGroupData._campaignId = self._campaign._id
    table.insert(tmpData, itemGroupData)
  end
  self._shopItemGroupData = tmpData
end

function UIActivityShopControllerBase:_RefreshUi(bResetPos)
  local canShowItemGroupData = {}
  local nowTime = math.floor(self._svrTimeModule:GetServerTime() / 1000)
  for index, value in ipairs(self._shopItemGroupData) do
    if ClientCampaignShop.CheckIsGoodsGroupCanShow(value._showTime, nowTime) then
      table.insert(canShowItemGroupData, value)
    end
  end
  self._showShopItemGroupData = canShowItemGroupData
  self._itemGroupCount = #self._showShopItemGroupData
  self._shopItemGroupList:SetListItemCount(self._itemGroupCount, false)
  self._shopItemGroupList:RefreshAllShownItem()
  if bResetPos then
    self._shopItemGroupList:MovePanelToItemIndex(0, 0)
    self._shopItemGroupList:FinishSnapImmediately()
  end
  self:_OnValueRemainingTime()
end

function UIActivityShopControllerBase:LoadDataOnEnter(TT, res, uiParams)
  self.params = uiParams
  self:_InitCmpt(TT, res)
end

function UIActivityShopControllerBase:_OnValueRemainingTime()
  self:_ShowRemainingTime()
  if self._event then
    GameGlobal.RealTimer():CancelEvent(self._event)
    self._event = nil
  end
  self._event = GameGlobal.RealTimer():AddEventTimes(1000, TimerTriggerCount.Infinite, function()
    self:_ShowRemainingTime()
  end)
end

function UIActivityShopControllerBase:_StartCheckGoodsGroupRefresh()
  if self._refreshGroupEvent then
    GameGlobal.RealTimer():CancelEvent(self._refreshGroupEvent)
    self._refreshGroupEvent = nil
  end
  self._refreshGroupEvent = GameGlobal.RealTimer():AddEventTimes(1000, TimerTriggerCount.Infinite, function()
    self:_CheckGoodsGroupRefresh()
  end)
end

function UIActivityShopControllerBase:_CheckGoodsGroupRefresh()
  local nowTime = math.floor(self._svrTimeModule:GetServerTime() / 1000)
  local needRefresh = false
  for index, value in ipairs(self._shopItemGroupData) do
    if not value._isShow then
      local newIsShow = ClientCampaignShop.CheckIsGoodsGroupCanShow(value._showTime, nowTime)
      if newIsShow then
        needRefresh = true
        break
      end
    end
    if not value._isUnlock then
      local newIsUnlock = ClientCampaignShop.CheckIsGoodsGroupUnlock(value._unlockTime, nowTime)
      if newIsUnlock then
        needRefresh = true
        break
      end
    end
    if not value._isClose then
      local newIsClose = ClientCampaignShop.CheckIsGoodsGroupClose(value._closeTime, nowTime)
      if newIsClose then
        needRefresh = true
        break
      end
    end
  end
  if needRefresh then
    self:_FillUiData()
    self:_RefreshUi(true)
  end
end

function UIActivityShopControllerBase:_ShowRemainingTime()
  local stopTime = self._shopCloseTime
  local nowTime = math.floor(self._svrTimeModule:GetServerTime() / 1000)
  local remainingTime = stopTime - nowTime
  if remainingTime <= 0 then
    if self._event then
      GameGlobal.RealTimer():CancelEvent(self._event)
      self._event = nil
    end
    self._endTimeTextGo:SetActive(false)
    remainingTime = 0
  else
    self._endTimeTextGo:SetActive(true)
  end
  self._endTimeText:SetText(self:_GetFormatString(remainingTime))
end

function UIActivityShopControllerBase:_GetFormatString(stamp)
  local timeStr = UIActivityHelper.GetFormatTimerStr(stamp)
  local showStr = StringTable.Get("str_activity_common_shop_close_at", timeStr)
  return showStr
end

function UIActivityShopControllerBase:OnHide()
  if self._refreshTaskID then
    GameGlobal.TaskManager():KillTask(self._refreshTaskID)
    self._refreshTaskID = nil
  end
  if self._event then
    GameGlobal.RealTimer():CancelEvent(self._event)
    self._event = nil
  end
  if self._refreshGroupEvent then
    GameGlobal.RealTimer():CancelEvent(self._refreshGroupEvent)
    self._refreshGroupEvent = nil
  end
  self:DetachListener()
end

function UIActivityShopControllerBase:AddListener()
  self:AttachEvent(GameEventType.ActivityShopBuySuccess, self.OnActivityShopBuySuccess)
  self:AttachEvent(GameEventType.ActivityCloseEvent, self.OnActivityCloseEvent)
  self:AttachEvent(GameEventType.ActivityComponentCloseEvent, self.OnActivityComponentCloseEvent)
  self:AttachEvent(GameEventType.ActivityShopNeedRefresh, self.OnActivityShopNeedRefresh)
end

function UIActivityShopControllerBase:DetachListener()
  self:DetachEvent(GameEventType.ActivityShopBuySuccess, self.OnActivityShopBuySuccess)
  self:DetachEvent(GameEventType.ActivityCloseEvent, self.OnActivityCloseEvent)
  self:DetachEvent(GameEventType.ActivityComponentCloseEvent, self.OnActivityComponentCloseEvent)
  self:DetachEvent(GameEventType.ActivityShopNeedRefresh, self.OnActivityShopNeedRefresh)
end

function UIActivityShopControllerBase:OnActivityCloseEvent(campaignId)
  if self._campaign and self._campaign._id == campaignId then
    self:SwitchState(UIStateType.UIMain)
  end
end

function UIActivityShopControllerBase:OnActivityShopNeedRefresh(campaignId)
  if self._campaign and self._campaign._id == campaignId then
    self:_ForceRefresh()
  end
end

function UIActivityShopControllerBase:OnActivityComponentCloseEvent(componentFullId)
  for index, value in ipairs(self._exchangeCmpts) do
    local exchangeInfo = value:GetComponentInfo()
    local cmptFullId = value:GetComponetCfgId(self._campaignId, exchangeInfo.m_component_id)
    if cmptFullId == componentFullId then
      self:_ForceRefresh()
      return
    end
  end
end

function UIActivityShopControllerBase:_SetShopItemGroupListCellCount()
  self._shopItemGroupList:SetListItemCount(self._itemGroupCount, false)
end

function UIActivityShopControllerBase:_InitShopItemGroupList()
  local canShowItemGroupData = {}
  local nowTime = math.floor(self._svrTimeModule:GetServerTime() / 1000)
  for index, value in ipairs(self._shopItemGroupData) do
    if ClientCampaignShop.CheckIsGoodsGroupCanShow(value._showTime, nowTime) then
      table.insert(canShowItemGroupData, value)
    end
  end
  self._showShopItemGroupData = canShowItemGroupData
  self._itemGroupCount = #self._showShopItemGroupData
  self._shopItemGroupList:InitListView(self._itemGroupCount, function(scrollview, index)
    return self:_OnGetShopItemGroupCell(scrollview, index)
  end)
end

function UIActivityShopControllerBase:_OnGetShopItemGroupCell(scrollview, index)
  local item = scrollview:NewListViewItem("CellItem")
  local cellPool = self:GetUIComponentDynamic("UISelectObjectPath", item.gameObject)
  if item.IsInitHandlerCalled == false then
    item.IsInitHandlerCalled = true
    cellPool:SpawnObjects("UIActivityShopItemGroup", 1)
  end
  local rowList = cellPool:GetAllSpawnList()
  local itemWidget = rowList[1]
  if itemWidget then
    local itemIndex = index + 1
    itemWidget:InitData(self._showShopItemGroupData[itemIndex])
    if itemIndex > self._itemGroupCount then
      itemWidget:GetGameObject():SetActive(false)
    end
    item:GetComponent("RectTransform").sizeDelta = itemWidget:GetRealSize()
  end
  return item
end

function UIActivityShopControllerBase:NpcWordInteractBtnOnClick(go)
  if self._npcWordText then
    local word = self:_GetInteractWord()
    self._npcWordText:SetText(word)
  end
end

function UIActivityShopControllerBase:_GetInteractWord()
  if self._wordStack:Size() <= 0 then
    local count = 0
    local all = #self._interactWords
    local tmpIndexs = {}
    for i = 1, all do
      table.insert(tmpIndexs, i)
    end
    for j = #tmpIndexs, 1, -1 do
      local index = math.random(1, #tmpIndexs)
      tmpIndexs[j], tmpIndexs[index] = tmpIndexs[index], tmpIndexs[j]
    end
    for _, value in ipairs(tmpIndexs) do
      self._wordStack:Push(value)
    end
  end
  return self._interactWords[self._wordStack:Pop()]
end

function UIActivityShopControllerBase:InitPlayerSpine()
  local spineName = self._commonCfg.NpcSpine
  if string.isnullorempty(spineName) then
    return
  end
  self._spine = self:GetUIComponent("SpineLoader", "NpcSpine")
  self._spine:LoadSpine(spineName)
  if self._spine then
    self._spineSke = self._spine.CurrentSkeleton
    if not self._spineSke then
      self._spineSke = self._spine.CurrentMultiSkeleton
    end
  end
end

function UIActivityShopControllerBase:OnUpdate(deltaTimeMS)
  if self._spineSke and self._uianimCG then
    local curAlpha = self._uianimCG.alpha
    if self._lastUpdateSpineHolderAlpha ~= curAlpha then
      self._lastUpdateSpineHolderAlpha = curAlpha
      self._spineSke.color = Color(1, 1, 1, curAlpha)
      self._spineSke.Skeleton.A = curAlpha
    end
  end
end
