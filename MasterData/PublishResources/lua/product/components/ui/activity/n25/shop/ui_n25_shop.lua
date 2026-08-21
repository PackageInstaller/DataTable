_class("UIN25Shop", UIController)
UIN25Shop = UIN25Shop

function UIN25Shop:Constructor()
  self._shopCloseTime = 0
  self._svrTimeModule = self:GetModule(SvrTimeModule)
  self._interactWords = nil
  self._wordStack = nil
  self._spineSke = nil
  self.mCampaign = self:GetModule(CampaignModule)
  self.data = self.mCampaign:GetN25Data()
  self.strsLeftTime = {
    "str_n25_shop_open_left_time_d_h",
    "str_n25_shop_open_left_time_d",
    "str_n25_shop_open_left_time_h_m",
    "str_n25_shop_open_left_time_h",
    "str_n25_shop_open_left_time_m"
  }
  self._animInfo = {
    name = "uieff_UIN25Shop_out",
    len = 167
  }
end

function UIN25Shop:LoadDataOnEnter(TT, res, uiParams)
  self.params = uiParams
  self:_InitCmpt(TT, res)
end

function UIN25Shop:_InitCmpt(TT, res)
  if #self.params < 2 then
    res:SetSucc(false)
    self:CloseDialog()
    return
  end
  local campaignType = self.params[1]
  local campaignId = self.params[2]
  self._backCallback = self.params[3]
  self._activityConst = self.params[4]
  self._commonCfg = Cfg.cfg_activity_shop_common_client[campaignId]
  local cmptIds
  if self._commonCfg then
    cmptIds = self._commonCfg.ComponentIds
  end
  local campaignModule = GameGlobal.GetModule(CampaignModule)
  self._campaign = UIActivityCampaign:New()
  self._campaign:LoadCampaignInfo(TT, res, campaignType, table.unpack(cmptIds), ECampaignN25ComponentID.ECAMPAIGN_N25_LINE_MISSION)
  if res and not res:GetSucc() then
    campaignModule:CheckErrorCode(res.m_result, self._campaign._id)
    self:CloseDialog()
    return
  end
  self._campaignId = self._campaign._id
  if self._campaignId ~= -1 then
    self._line_component = self._campaign:GetComponent(ECampaignN25ComponentID.ECAMPAIGN_N25_LINE_MISSION)
    self._line_info = self._line_component:GetComponentInfo()
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

function UIN25Shop:OnShow(uiParams)
  local spine, bgm = self:GetSpineAndBgm()
  if bgm then
    AudioHelperController.PlayBGM(bgm, AudioConstValue.BGMCrossFadeTime)
  end
  N25Data.SetPrefsShop()
  self.txtCountLow = self:GetUIComponent("UILocalizationText", "txtCountLow")
  self.txtCount = self:GetUIComponent("UILocalizationText", "txtCount")
  self.info = self:GetGameObject("info")
  self.info:SetActive(false)
  self.arrowLeft = self:GetGameObject("ArrowLeft")
  self.arrowright = self:GetGameObject("ArrowRight")
  self.pointOn1 = self:GetGameObject("pointOn1")
  self.pointOn2 = self:GetGameObject("pointOn2")
  self.pointOn3 = self:GetGameObject("pointOn3")
  self:AddListener()
  self:InitWidget()
  self._animation:Play()
end

function UIN25Shop:OnHide()
  self._endTimeText = nil
end

function UIN25Shop:DefaultBackFunc()
  self.mCampaign:CampaignSwitchState(true, UIStateType.UIActivityN25MainController, UIStateType.UIMain, nil, self._campaign._id)
end

function UIN25Shop:_RefreshCurrency()
  if not self._currencyId then
    self._currencyId = self._commonCfg.CurrencyId
  end
  local count = self:GetModule(ItemModule):GetItemCount(self._currencyId) or 0
  local preZero = UIActivityHelper.GetZeroStrFrontNum(7, count)
  local fmtStr = string.format("<color=#827B78>%s</color><color=#FFE65A>%s</color>", preZero, tostring(count))
  self.txtCountLow:SetText(preZero .. count)
  self.txtCount:SetText(fmtStr)
  if self.pointIcon then
    local currencyIcon = ""
    local cfgItem = Cfg.cfg_item[self._currencyId]
    if cfgItem then
      currencyIcon = cfgItem.Icon
      self.pointIcon:LoadImage(currencyIcon)
    end
  end
end

function UIN25Shop:_ShowRemainingTime()
  if self._endTimeText then
    UIForge.FlushCDText(self._endTimeText, self._shopCloseTime, self.strsLeftTime, true)
  end
end

function UIN25Shop:InitWidget()
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
  self._animation = self:GetUIComponent("Animation", "animation")
  self._page1Animation = self:GetUIComponent("Animation", "page1")
  self._page2Animation = self:GetUIComponent("Animation", "page2")
  self._page3Animation = self:GetUIComponent("Animation", "page3")
  self._refreshTaskID = nil
  self._event = nil
  self._refreshGroupEvent = nil
  self._restTime = 0
  self:_FillCfgUiRes()
  self:_FillUiData()
  self:_RefreshUi(nil, true)
  self:_StartCheckGoodsGroupRefresh()
  self.itemCount = self:GetUIComponent("UILocalizationText", "itemCount")
  self.pointIcon = self:GetUIComponent("RawImageLoader", "PointIcon")
  self:_RefreshCurrency()
end

function UIN25Shop:_FillCfgUiRes()
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

function UIN25Shop:OnActivityShopBuySuccess(goodsId)
  self:_ForceRefresh(goodsId)
end

function UIN25Shop:_ForceRefresh(goodsId)
  self._refreshTaskID = self:StartTask(function(TT)
    local res = AsyncRequestRes:New()
    res:SetSucc(true)
    self:_InitCmpt(TT, res)
    if res and res:GetSucc() then
      self:_FillUiData()
      self:_RefreshUi()
      self:_RefreshCurrency()
      if goodsId then
        self:_CheckBuySucc(goodsId)
      end
    end
  end, self)
end

function UIN25Shop:_CheckBuySucc(goodsId)
  local page = self.pages[self.curPage]
  if page then
    page:PlaySellOutAni(goodsId)
  end
end

function UIN25Shop:BackBtnFunc()
  self:CloseDialogWithAnim()
end

function UIN25Shop:CloseDialogWithAnim()
  self:Lock("UIN25Shop:CloseDialogWithAnim")
  if self._rootAnim then
    self._rootAnim:Play(self._animInfo.name)
  end
  self:StartTask(function(TT)
    YIELD(TT, self._animInfo.len)
    self:UnLock("UIN25Shop:CloseDialogWithAnim")
    if self._backCallback then
      self._backCallback()
    else
      self:DefaultBackFunc()
    end
  end, self)
end

function UIN25Shop:_FillUiData()
  local boxItemLimit = 1
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

function UIN25Shop:_RefreshUi(bResetPos, withAni)
  local canShowItemGroupData = {}
  local nowTime = math.floor(self._svrTimeModule:GetServerTime() / 1000)
  for index, value in ipairs(self._shopItemGroupData) do
    if ClientCampaignShop.CheckIsGoodsGroupCanShow(value._showTime, nowTime) then
      table.insert(canShowItemGroupData, value)
    end
  end
  self._showShopItemGroupData = canShowItemGroupData
  self:_RefreshPanels(bResetPos, withAni)
  self:_OnValueRemainingTime()
end

function UIN25Shop:_RefreshPanels(bResetPos, withAni)
  self:InitPanels()
  if bResetPos then
    self.curPage = 1
  end
  self.pages[1]:Show(self.curPage == 1)
  self.pages[2]:Show(self.curPage == 2)
  self.pages[3]:Show(self.curPage == 3)
  self.pages[1]:SetData(1, self._showShopItemGroupData)
  self.pages[2]:SetData(2, self._showShopItemGroupData)
  self.pages[3]:SetData(3, self._showShopItemGroupData)
  self:RefreshArrowBtn(withAni)
end

function UIN25Shop:InitPanels()
  if not self.pages then
    self.curPage = 1
    self.pages = {}
    local pagePool1 = self:GetUIComponent("UISelectObjectPath", "page1")
    self.pages[1] = pagePool1:SpawnObject("UIN25ShopPage")
    self.pages[1]:Show(true)
    local pagePool2 = self:GetUIComponent("UISelectObjectPath", "page2")
    self.pages[2] = pagePool2:SpawnObject("UIN25ShopPage")
    self.pages[2]:Show(false)
    local pagePool3 = self:GetUIComponent("UISelectObjectPath", "page3")
    self.pages[3] = pagePool3:SpawnObject("UIN25ShopPage")
    self.pages[3]:Show(false)
  end
end

function UIN25Shop:ArrowRightOnClick(go)
  if self.curPage < 3 then
    local fromPage = self.curPage
    local targetPage = self.curPage + 1
    self:ChangePage(fromPage, targetPage)
  end
end

function UIN25Shop:ArrowLeftOnClick(go)
  if self.curPage > 1 then
    local fromPage = self.curPage
    local targetPage = self.curPage - 1
    self:ChangePage(fromPage, targetPage)
  end
end

function UIN25Shop:ChangePage(fromPage, targetPage)
  self.curPage = targetPage
  self.pages[fromPage]:Show(false)
  self.pages[targetPage]:Show(true)
  self:RefreshArrowBtn(true)
end

function UIN25Shop:RefreshArrowBtn(withAni)
  self.arrowLeft:SetActive(self.curPage > 1)
  self.arrowright:SetActive(self.curPage < 3)
  self.pointOn1:SetActive(self.curPage == 1)
  self.pointOn2:SetActive(self.curPage == 2)
  self.pointOn3:SetActive(self.curPage == 3)
  if withAni then
    if self.curPage == 1 then
      self._page1Animation:Play()
    elseif self.curPage == 2 then
      self._page2Animation:Play()
    elseif self.curPage == 3 then
      self._page3Animation:Play()
    end
  end
end

function UIN25Shop:BtnBackOnClick(go)
  self:BackBtnFunc()
  AudioHelperController.PlayBGM(self._lastBGMResName, AudioConstValue.BGMCrossFadeTime)
end

function UIN25Shop:BtnHomeOnClick(go)
  self:SwitchState(UIStateType.UIMain)
end

function UIN25Shop:BtnInfoOnClick(go)
  self.info:SetActive(true)
end

function UIN25Shop:ImgInfoOnClick(go)
  self.info:SetActive(false)
end

function UIN25Shop:OnActivityShopBuySuccess(exchangeId)
  self:_ForceRefresh(exchangeId)
end

function UIN25Shop:Replay(id)
  local replay = self.data:GetReplayById(id)
  local viewSpine = replay:ViewSpine()
  local spineLoader = self.spines[viewSpine]
  local viewPlaySequence = replay:ViewPlaySequence()
end

function UIN25Shop:_OnValueRemainingTime()
  self:_ShowRemainingTime()
  if self._event then
    GameGlobal.RealTimer():CancelEvent(self._event)
    self._event = nil
  end
  self._event = GameGlobal.RealTimer():AddEventTimes(1000, TimerTriggerCount.Infinite, function()
    self:_ShowRemainingTime()
  end)
end

function UIN25Shop:_StartCheckGoodsGroupRefresh()
  if self._refreshGroupEvent then
    GameGlobal.RealTimer():CancelEvent(self._refreshGroupEvent)
    self._refreshGroupEvent = nil
  end
  self._refreshGroupEvent = GameGlobal.RealTimer():AddEventTimes(1000, TimerTriggerCount.Infinite, function()
    self:_CheckGoodsGroupRefresh()
  end)
end

function UIN25Shop:_CheckGoodsGroupRefresh()
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

function UIN25Shop:_ShowRemainingTime()
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

function UIN25Shop:_GetFormatString(stamp)
  local timeStr = UIActivityHelper.GetFormatTimerStr(stamp)
  local showStr = StringTable.Get("str_n25_activity_shop_close_at", timeStr)
  return showStr
end

function UIN25Shop:OnHide()
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

function UIN25Shop:AddListener()
  self:AttachEvent(GameEventType.ActivityShopBuySuccess, self.OnActivityShopBuySuccess)
  self:AttachEvent(GameEventType.ActivityCloseEvent, self.OnActivityCloseEvent)
  self:AttachEvent(GameEventType.ActivityComponentCloseEvent, self.OnActivityComponentCloseEvent)
  self:AttachEvent(GameEventType.ActivityShopNeedRefresh, self.OnActivityShopNeedRefresh)
end

function UIN25Shop:DetachListener()
  self:DetachEvent(GameEventType.ActivityShopBuySuccess, self.OnActivityShopBuySuccess)
  self:DetachEvent(GameEventType.ActivityCloseEvent, self.OnActivityCloseEvent)
  self:DetachEvent(GameEventType.ActivityComponentCloseEvent, self.OnActivityComponentCloseEvent)
  self:DetachEvent(GameEventType.ActivityShopNeedRefresh, self.OnActivityShopNeedRefresh)
end

function UIN25Shop:OnActivityCloseEvent(campaignId)
  if self._campaign and self._campaign._id == campaignId then
    self:SwitchState(UIStateType.UIMain)
  end
end

function UIN25Shop:OnActivityShopNeedRefresh(campaignId)
  if self._campaign and self._campaign._id == campaignId then
    self:_ForceRefresh()
  end
end

function UIN25Shop:OnActivityComponentCloseEvent(componentFullId)
  for index, value in ipairs(self._exchangeCmpts) do
    local exchangeInfo = value:GetComponentInfo()
    local cmptFullId = value:GetComponetCfgId(self._campaignId, exchangeInfo.m_component_id)
    if cmptFullId == componentFullId then
      self:_ForceRefresh()
      return
    end
  end
end

function UIN25Shop:NpcWordInteractBtnOnClick(go)
  if self._npcWordText then
    local word = self:_GetInteractWord()
    self._npcWordText:SetText(word)
  end
end

function UIN25Shop:_GetInteractWord()
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

function UIN25Shop:GetSpineAndBgm()
  local cfg = Cfg.cfg_n25_const[1]
  if self._line_info and cfg then
    local missionModule = GameGlobal.GetModule(MissionModule)
    local passInfo = self._line_info.m_pass_mission_info
    for _, info in pairs(passInfo) do
      local storyId = missionModule:GetStoryByStageIdStoryType(info.mission_id, StoryTriggerType.Node)
      if storyId == cfg.StoryID then
        return cfg.Spine2, cfg.Bgm2
      end
    end
    return cfg.Spine1, cfg.Bgm1
  end
  return nil, nil
end
