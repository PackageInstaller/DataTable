_class("UIDrawCardController", UIController)
UIDrawCardController = UIDrawCardController
local ClientPrizePoolType = {
  SubType_Hand = 1,
  SubType_UP = 2,
  SubType_Turn = 3,
  SubType_Always = 4
}
_enum("ClientPrizePoolType", ClientPrizePoolType)

function UIDrawCardController:LoadDataOnEnter(TT, res, uiParams)
  local module = self:GetModule(GambleModule)
  local ack = module:ApplyAllPoolInfo(TT)
  if ack:GetSucc() then
    res:SetSucc(true)
    Log.notice("[DrawCard] get draw card data success, open ui")
  else
    res:SetSucc(false)
    Log.notice("[DrawCard] promotion time up, refresh pools failed")
    ToastManager.ShowToast(module:GetReasonByErrorCode(ack:GetResult()))
  end
  local shopModule = self:GetModule(ShopModule)
  shopModule:RequestGlowMarket(TT)
end

function UIDrawCardController:OnShow(uiParams)
  self.isSceneLoaded = false
  self._sceneLoadingTask = self:StartTask(function(TT)
    if UIHelper.GetActiveSceneName() ~= "Ckt_01_new" then
      self.preLoadScene = ResourceManager:GetInstance():AsyncLoadAsset(TT, "Ckt_01_new.unity", LoadType.Unity)
    end
    local camera = UnityEngine.Camera.main
    if camera and not GameGlobal.UIStateManager():IsShow("UIDrawCardAnimController") then
      camera.gameObject:SetActive(false)
    end
    self.isSceneLoaded = true
  end)
  AudioHelperController.RequestUISoundList({
    CriAudioIDConst.DrawCard_tuijingtou,
    CriAudioIDConst.DrawCard_lagan_new,
    CriAudioIDConst.Drawcard_lagan_eft_3,
    CriAudioIDConst.Drawcard_lagan_eft_4,
    CriAudioIDConst.Drawcard_lagan_eft_5,
    CriAudioIDConst.Drawcard_lagan_eft_6,
    CriAudioIDConst.Drawcard_light_one,
    CriAudioIDConst.Drawcard_light_more,
    CriAudioIDConst.Drawcard_light_one,
    CriAudioIDConst.Drawcard_mul_show,
    CriAudioIDConst.Drawcard_lagan_once
  })
  self._openID = nil
  if uiParams[1] then
    self._openID = uiParams[1]
  end
  local module = GameGlobal.GetModule(GambleModule)
  module:InitContext(self.sceneResReq)
  self._lastBGMResName = AudioHelperController.GetCurrentBgm()
  local sop = self:GetUIComponent("UISelectObjectPath", "currencyMenu")
  self.currencyMenu = sop:SpawnObject("UICurrencyMenu")
  self.specailCurrency = self:GetUIComponent("UISelectObjectPath", "specailCurrency")
  local topButton = self:GetUIComponent("UISelectObjectPath", "TopButtons")
  self.topButtonWidget = topButton:SpawnObject("UICommonTopButton")
  self.topButtonWidget:SetData(function()
    if GameGlobal.UIStateManager():CurUIStateType() ~= UIStateType.UIDrawCard then
      self:CloseDialog()
    else
      GameGlobal.UIStateManager():SwitchState(UIStateType.UIMain)
    end
  end, function()
    local poolData = self._poolsUIData[self.currentIdx].poolData
    local poolCfg = Cfg.cfg_drawcard_pool_view[poolData.performance_id]
    local openidx = 1
    if poolCfg then
      local subType = poolCfg.Subtype
      if subType == ClientPrizePoolType.SubType_Hand then
        openidx = 1
      elseif subType == ClientPrizePoolType.SubType_UP then
        openidx = 2
      elseif subType == ClientPrizePoolType.SubType_Turn then
        openidx = 3
      elseif subType == ClientPrizePoolType.SubType_Always then
        openidx = 4
      end
    end
    self:ShowDialog("UIHelpController", "UIDrawCardController", openidx)
  end)
  self._diamondId = RoleAssetID.RoleAssetGlow
  self._gambleModule = self:GetModule(GambleModule)
  self._roleModule = self:GetModule(RoleModule)
  self._itemModule = self:GetModule(ItemModule)
  self:AttachEvent(GameEventType.WaitForRecuitSceneLoadFinish, self._WaitForRecuitSceneLoadFinish)
  self:AttachEvent(GameEventType.RefreshRecuitUIView, self._RefreshUI)
  self:AttachEvent(GameEventType.UpdateDrawCardRed, self.UpdateDrawCardRed)
  self:_RefreshUI()
end

function UIDrawCardController:_RefreshUI()
  self.currentIdx = -1
  self._awardPools = self._gambleModule:GetPrizePools()
  self.awardPoolCount = #self._awardPools
  if self.awardPoolCount == 0 then
    ToastManager.ShowToast(StringTable.Get("str_toast_manager_there_is_no_open_prize_pool"))
    self:CloseDialog()
    return
  end
  self.isDrawCard = self._gambleModule:Context():GetStateDrawCard()
  self.isHaveMaxStar = self._gambleModule:Context():GetHaveMaxStarPet()
  self.drawCardPoolIndex = self._gambleModule:Context():GetDefaultPoolIndex()
  self.maxStar, self.maxStarId = self._gambleModule:Context():GetMaxStarPetId()
  self:GuideAppraise()
  self:InitData()
  self:InitWidgets()
  self:InitScrollView()
  self:HandlePromotionPool()
  self:InitUIDrawCardPoolItem()
  self:UpdateDrawCardRed()
  if #self._awardPools == 1 then
    self:GetGameObject("indexs"):SetActive(false)
    self.lastPoolBtn:SetActive(false)
    self.nextPoolBtn:SetActive(false)
    self._leftRed:SetActive(false)
    self._rightRed:SetActive(false)
  end
end

function UIDrawCardController:_WaitForRecuitSceneLoadFinish(callback)
  if not self.isSceneLoaded then
    self:Lock("UIDrawCardController_WaitForRecuitSceneLoadFinish")
    self:StartTask(function(TT)
      while not self.isSceneLoaded do
        YIELD(TT)
      end
      self:UnLock("UIDrawCardController_WaitForRecuitSceneLoadFinish")
      if callback then
        callback()
      end
    end)
  elseif callback then
    callback()
  end
end

function UIDrawCardController:InitWidgets()
  self.lastPoolBtn = self:GetGameObject("ButtonLastPool")
  self.nextPoolBtn = self:GetGameObject("ButtonNextPool")
  self._leftRed = self:GetGameObject("leftRed")
  self._rightRed = self:GetGameObject("rightRed")
  local atlas = self:GetAsset("UIDrawCard.spriteatlas", LoadType.SpriteAtlas)
  self.indexIcons = {
    Current = atlas:GetSprite("obtain_xinshou_icon4"),
    Normal = atlas:GetSprite("obtain_xinshou_icon3")
  }
  self._videoWidget = self:GetGameObject("VideoWidget")
  self._uiLayout = self:GetUIComponent("RectTransform", "uiLayout")
  self._uiWish = self:GetUIComponent("RectTransform", "uiWish")
  self._uiWishRed = self:GetChildComponent(self._uiWish, "RectTransform", "red")
  self._videoCanvasGroups = self._videoWidget.gameObject:AddComponent(typeof(UnityEngine.CanvasGroup))
  self._blackMask = self:GetGameObject("BlackMask")
end

function UIDrawCardController:InitData()
  self._poolsUIData = {}
  for idx, pool in ipairs(self._awardPools) do
    local uiData = UIDrawCardPoolInfo:New(pool, idx)
    self._poolsUIData[idx] = uiData
  end
end

function UIDrawCardController:InitUIDrawCardPoolItem()
  local cardPool = self:GetUIComponent("UISelectObjectPath", "cardPool")
  cardPool:ClearWidgets()
  self._widgetCardPool = cardPool:SpawnObject("UIDrawCardPoolItem")
  self._widgetCardPool:Init(self._poolsUIData, self, self._openID)
  self._openID = nil
end

function UIDrawCardController:OnHide()
  if self.promotionTimer then
    GameGlobal.Timer():CancelEvent(self.promotionTimer)
    self.promotionTimer = nil
  end
  AudioHelperController.PlayBGM(self._lastBGMResName, AudioConstValue.BGMCrossFadeTime)
  if not self.dontSwitchScene then
    self:Lock("UIDrawCardController_OnHide")
    self:StartTask(function(TT)
      while not self.isSceneLoaded do
        YIELD(TT)
      end
      ResourceManager:GetInstance():AsyncLoadAsset(TT, "UI.unity", LoadType.Unity)
      self.preLoadScene:Dispose()
      self:UnLock("UIDrawCardController_OnHide")
    end)
  end
end

function UIDrawCardController:InitScrollView()
  self.idxLoader = self:GetUIComponent("UISelectObjectPath", "indexs")
  self.idxLoader:SpawnObjects("UIEmptyWidget", self.awardPoolCount)
  local pool = self.idxLoader:GetAllSpawnList()
  self.indexsImages = {}
  for i = 1, self.awardPoolCount do
    local item = pool[i]:GetGameObject()
    self.indexsImages[i] = item:GetComponent(typeof(UnityEngine.UI.Image))
    self.indexsImages[i].rectTransform.sizeDelta = Vector2(38, 39)
  end
end

function UIDrawCardController:ShowAwardPool(idx, isInit)
  if idx < 0 or idx > self.awardPoolCount then
    Log.fatal("[DrawCard] award pool index error:", idx)
    return
  end
  if self.currentIdx == idx then
    return
  end
  if 0 < self.currentIdx then
  end
  self.currentIdx = idx
  if isInit then
    self.indexsImages[self.currentIdx].rectTransform.sizeDelta = Vector2(73, 39)
  end
  self.lastPoolBtn:SetActive(self.currentIdx ~= 1)
  self.nextPoolBtn:SetActive(self.currentIdx ~= self.awardPoolCount)
  self:OtherPoolsRed()
  self:RefreshItemInfo()
  self:_RefreshPetWish(self._poolsUIData[self.currentIdx])
  if not self._isPvPlaying then
    self:_CheckGuide()
  end
end

function UIDrawCardController:OtherPoolsRed()
  local leftRed = false
  local rightRed = false
  for i = 1, #self._awardPools do
    local pool = self._poolsUIData[i]
    if not leftRed and i < self.currentIdx and pool:HasFreeDraw() then
      leftRed = true
    end
    if not rightRed and i > self.currentIdx and pool:HasFreeDraw() then
      rightRed = true
    end
  end
  self._leftRed:SetActive(leftRed)
  self._rightRed:SetActive(rightRed)
end

function UIDrawCardController:RefreshItemInfo()
  local tips = self._poolsUIData[self.currentIdx]:GetTopTips()
  if 2 < #tips then
    local normal = {}
    local specail = {}
    for idx, id in ipairs(tips) do
      if idx <= #tips - 2 then
        specail[#specail + 1] = id
      else
        normal[#normal + 1] = id
      end
    end
    self.currencyMenu:SetData(normal)
    local items = self.specailCurrency:SpawnObjects("UICurrencyItem", #specail)
    for i = 1, #specail do
      items[i]:SetAsShortForm(true)
      items[i]:SetData(specail[i], function(id, go)
        self.currencyMenu._topTipsInfo:SetData(id, go)
      end, true)
    end
  else
    self.currencyMenu:SetData(tips)
    self.specailCurrency:SpawnObjects("UICurrencyItem", 0)
  end
  local viewID = self._awardPools[self.currentIdx].performance_id
  local cfg = Cfg.cfg_drawcard_pool_view[viewID]
  if cfg and cfg.bgmID then
    AudioHelperController.PlayBGM(cfg.bgmID, AudioConstValue.BGMCrossFadeTime)
  else
    AudioHelperController.PlayBGM(self._lastBGMResName, AudioConstValue.BGMCrossFadeTime)
  end
  local poolInfo = self._poolsUIData[self.currentIdx]
  self:_ShowPVBtn(poolInfo)
end

function UIDrawCardController:CfgItem(id)
  if not self._cfg_item then
    self._cfg_item = Cfg.cfg_item({})
  end
  local cfg_item = self._cfg_item[id]
  if not cfg_item then
    Log.error("###[UIDrawCardController] cfg_item is nil ! id --> ", id)
  end
  return cfg_item
end

function UIDrawCardController:HandlePromotionPool()
  local now = GetSvrTimeNow()
  local time = 86400
  for _, pool in ipairs(self._poolsUIData) do
    local refreshTime = pool:GetRefreshTime()
    if refreshTime then
      local deltaTime = refreshTime - now
      if 0 < deltaTime and time > deltaTime then
        time = deltaTime
      end
    end
  end
  if time < 86400 then
    if self.promotionTimer then
      GameGlobal.Timer():CancelEvent(self.promotionTimer)
    end
    self.promotionTimer = GameGlobal.Timer():AddEvent(time * 1000, function()
      self.promotionTimer = nil
      self:ReLoadDataAndRefresh()
    end)
  end
end

function UIDrawCardController:ReLoadDataAndRefresh()
  self:Lock("UIDrawCardController_ReLoadDataAndRefresh")
  self:StartTask(function(TT)
    local res = AsyncRequestRes:New()
    self:LoadDataOnEnter(TT, res)
    self:_RefreshUI()
    self:UnLock("UIDrawCardController_ReLoadDataAndRefresh")
  end)
end

function UIDrawCardController:ButtonAddDiamondOnClick()
  self:JumpToGetway(self._awardPools[self.currentIdx].cost2_id)
end

function UIDrawCardController:JumpToGetway(_id, _notEnough)
  if _id == self._diamondId then
    ToastManager.ShowToast(StringTable.Get("str_toast_manager_no_recharge_interface"))
  elseif _notEnough then
  else
    self:ShowDialog("UIItemGetPathController", _id)
  end
end

function UIDrawCardController:ButtonLastPoolOnClick()
  if self.currentIdx == 1 then
    Log.error("[DrawCard] first page, cant change")
    return
  end
  self._widgetCardPool:ButtonLastPoolOnClick()
  if self._videoWidget then
    self._videoWidget.gameObject:SetActive(false)
  end
  if self._uiLayout then
    self._uiLayout.gameObject:SetActive(false)
  end
end

function UIDrawCardController:ButtonNextPoolOnClick()
  if self.currentIdx == self.awardPoolCount then
    Log.error("[DrawCard] last page, cant change")
    return
  end
  self._widgetCardPool:ButtonNextPoolOnClick()
  if self._videoWidget then
    self._videoWidget.gameObject:SetActive(false)
  end
  if self._uiLayout then
    self._uiLayout.gameObject:SetActive(false)
  end
end

function UIDrawCardController:HideVideoAndHeart()
  if self._videoWidget then
    self._videoWidget.gameObject:SetActive(false)
  end
  if self._uiLayout then
    self._uiLayout.gameObject:SetActive(false)
  end
end

function UIDrawCardController:id1IconOnClick(go)
  self._toptipsInfo:SetData(self._awardPools[self.currentIdx].cost1_id, go)
end

function UIDrawCardController:id2IconOnClick(go)
  self._toptipsInfo:SetData(self._awardPools[self.currentIdx].cost2_id, go)
end

function UIDrawCardController:GetOneBtn(index)
  return self._widgetCardPool and self._widgetCardPool:GetGameObject("SingleDrawButton")
end

function UIDrawCardController:GetTopButtonBack()
  return self.topButtonWidget and self.topButtonWidget:GetGameObject("ButtonBack")
end

function UIDrawCardController:OnUpdate(deltaTimeMS)
  self._widgetCardPool:OnUpdate(deltaTimeMS)
end

function UIDrawCardController:GuideAppraise()
  if self.isDrawCard then
    local idx, type = self._gambleModule:Context():GetPoolIDAndType()
    local maxStar = self.maxStar
    local maxStarId = self.maxStarId
    local isHaveMaxStar = self.isHaveMaxStar
    if maxStar < 6 then
      return
    end
    local roleModule = GameGlobal.GetModule(RoleModule)
    local pstId = roleModule:GetPstId()
    local dbKey = pstId .. "GuideAppTime"
    local dbResultKey = pstId .. "GuideAppResult"
    local timeState = true
    self._svrTimeModule = self:GetModule(SvrTimeModule)
    local lastTime = LocalDB.GetInt(dbKey)
    local lastResult = LocalDB.GetInt(dbResultKey)
    local nowTime = math.floor(self._svrTimeModule:GetServerTime() * 0.001)
    local dif = nowTime - lastTime
    if lastResult == 1 then
      timeState = 31536000 <= dif
    elseif lastResult == -1 then
      timeState = 2592000 <= dif
    elseif lastResult == 0 then
      if lastTime == 0 then
        timeState = true
      else
        timeState = 2592000 <= dif
      end
    end
    local coverState = false
    local cfg = Cfg.cfg_drawcard_pool_view[idx]
    if cfg == nil then
      Log.fatal("###error -- drawcard - cfg_drawcard_pool_view is nil ! key --> ", idx)
      return
    end
    for index, value in pairs(cfg.PetList) do
      if value == maxStarId then
        coverState = true
      end
    end
    if isHaveMaxStar then
      if type == PrizePoolType.PROMOTION_POOL and timeState and coverState then
        self:PopupGuide(dbKey, dbResultKey)
      end
    else
      self:PopupGuide(dbKey, dbResultKey)
    end
  end
end

function UIDrawCardController:PopupGuide(dbKey, dbResultKey)
  if IsPc() then
    return
  end
  local char_mod = self:GetModule(RoleModule)
  if char_mod:CanStoreReview() == false then
    return
  end
  PopupManager.Alert("UICommonMessageBox", PopupPriority.Normal, PopupMsgBoxType.OkCancel, StringTable.Get("str_common_guide_appraise_title"), StringTable.Get("str_common_guide_appraise_context"), function()
    local gv = HelperProxy:GetInstance():GetGameVersion()
    local app_store_id = ""
    if gv == GameVersionType.INTL then
      app_store_id = "1529088856"
    elseif gv == GameVersionType.USA then
      app_store_id = "1563326554"
    else
      app_store_id = "1577315941"
    end
    self.srm = GameStore.StoreReviewManager:New()
    self.srm:RequestSystemBasedReview(app_store_id)
    LocalDB.SetInt(dbResultKey, 1)
  end, nil, function()
    LocalDB.SetInt(dbResultKey, -1)
  end, nil)
  LocalDB.SetInt(dbKey, math.floor(self._svrTimeModule:GetServerTime() * 0.001))
end

function UIDrawCardController:IndexerTweenWidth(next)
  local seq = DG.Tweening.DOTween.Sequence()
  local indexImageCurr = self.indexsImages[self.currentIdx]
  local indexImageNext = self.indexsImages[next]
  if indexImageCurr and indexImageNext then
    local zoomOut = indexImageCurr.rectTransform:DOSizeDelta(Vector2(38, 39), 0.6):SetEase(DG.Tweening.Ease.Linear)
    local zoomIn = indexImageNext.rectTransform:DOSizeDelta(Vector2(73, 39), 0.7):SetEase(DG.Tweening.Ease.OutCubic)
    seq:Append(zoomOut)
    seq:Append(zoomIn)
  else
    Log.fatal("### indexsImages not exist index: ", self.currentIdx, next)
  end
end

function UIDrawCardController:_ShowPVBtn(poolInfo)
  local cfg = Cfg.cfg_drawcard_pool_view[poolInfo.poolData.performance_id]
  local childCount = self._videoWidget.transform.childCount
  for i = 0, childCount - 1 do
    UIHelper.DestroyGameObject(self._videoWidget.transform:GetChild(0).gameObject)
  end
  HotUpdate.ActivityLuaProxy.AddListener(nil)
  if self:_CheckDownLoadPV(cfg) then
    self:_InitDownLoadVedioBtn(cfg)
    return
  end
  self:_InitVedioBtn(cfg)
end

function UIDrawCardController:_InitVedioBtn(cfg)
  if cfg.PlayVideoName then
    self._uiLayout.gameObject:SetActive(true)
    self._videoWidget.gameObject:SetActive(true)
    if self._videoCanvasGroups ~= nil then
      self._videoCanvasGroups.alpha = 0
      self._videoCanvasGroups:DOFade(1, 1)
    end
    local go = UIHelper.GetGameObject(cfg.PlayVideoPrefab .. ".prefab")
    local tf = go.transform
    tf:SetParent(self._videoWidget.transform)
    tf:GetComponent("RectTransform").anchoredPosition = Vector2.zero
    tf.localScale = Vector3.one
    tf.localRotation = Quaternion.identity
    UIEventTriggerListener.Get(go).onClick = function()
      self._blackMask:SetActive(true)
      Log.debug("fx: click playvedio")
      self:ShowVideo(cfg.PlayVideoName, cfg.PlayVideoBg, function()
        self._blackMask:SetActive(false)
      end)
    end
    local roleModule = GameGlobal.GetModule(RoleModule)
    local pstId = roleModule:GetPstId()
    local dbKey = "UIDrawCardControllerFirstPlayPV_" .. cfg.PlayVideoName .. pstId
    if LocalDB.GetInt(dbKey, 0) == 0 then
      self._blackMask:SetActive(true)
      Log.debug("fx: click playvedio")
      self._isPvPlaying = true
      self:ShowVideo(cfg.PlayVideoName, cfg.PlayVideoBg, function()
        self._blackMask:SetActive(false)
        self:_OnPvPlayFinish()
      end)
      LocalDB.SetInt(dbKey, 1)
    end
    self:_FixVedioBtnState(cfg, go)
  end
end

function UIDrawCardController:_OnPvPlayFinish()
  self._isPvPlaying = nil
  self:_CheckGuide()
end

function UIDrawCardController:_CheckGuide()
  local poolInfo = self._poolsUIData[self.currentIdx]
  local module = self:GetModule(GambleModule)
  local idOptional = module:GetCfgOptionalPoolId(poolInfo.index)
  local cfgOptional = Cfg.cfg_optional_pool[idOptional]
  if cfgOptional ~= nil then
    GameGlobal.EventDispatcher():Dispatch(GameEventType.GuideOpenUI, GuideOpenUI.UIDrawCardController_PetWish)
  end
end

function UIDrawCardController:ShowVideo(videoName, Bg, func)
  if CriWare.CriManaMovieControllerForUI then
    self:ShowDialog("UICriVideoController", videoName, Bg, func, nil)
  else
    self:ShowDialog("UICriVideoControllerNowrap", videoName, Bg, func, nil)
  end
end

function UIDrawCardController:_FixVedioBtnState(cfg, go)
  if tonumber(cfg.VedioDownLoadId) ~= nil then
    self.downLoadBtnAnim = go:GetComponent("Animation")
    if self.downLoadBtnAnim then
      self.downLoadBtnAnim.enabled = false
    end
    local loadState = go.transform:GetChild(1)
    loadState.gameObject:SetActive(false)
    local loadState2 = go.transform:GetChild(0)
    loadState2.gameObject:SetActive(true)
  end
end

function UIDrawCardController:_CheckDownLoadPV(cfg)
  Log.debug("cfg.VedioDownLoadId", cfg.VedioDownLoadId)
  if tonumber(cfg.VedioDownLoadId) == nil then
    return false
  end
  if EDITOR then
    return false
  end
  if HotUpdate.ActivityLuaProxy.CurrProcessingActivityID() == tonumber(cfg.VedioDownLoadId) then
    return true
  end
  if not HotUpdate.ActivityLuaProxy.HasDownloadList(tonumber(cfg.VedioDownLoadId)) then
    Log.debug("tonumber(cfg.VedioDownLoadId) load over", tonumber(cfg.VedioDownLoadId), "HasDownloadList:   ")
    return false
  end
  return true
end

function UIDrawCardController:_InitDownLoadVedioBtn(cfg)
  if cfg.PlayVideoName then
    local go = UIHelper.GetGameObject(cfg.PlayVideoPrefab .. ".prefab")
    local tf = go.transform
    tf:SetParent(self._videoWidget.transform)
    tf:GetComponent("RectTransform").anchoredPosition = Vector2.zero
    tf.localScale = Vector3.one
    tf.localRotation = Quaternion.identity
    local loadState = go.transform:GetChild(1)
    loadState.gameObject:SetActive(true)
    self.downLoadBtnAnim = go:GetComponent("Animation")
    self.downLoadBtnAnim.enabled = false
    self:_CheckNotWifiFirstDownLoad(go, cfg)
    self:_AddDownLoadListener(go, cfg)
    self:_InitDownLoadPvClick(go, cfg)
    self:_Check4GNeedQuik(go, cfg)
  end
end

function UIDrawCardController:_Check4GNeedQuik(go, cfg)
  if cfg.VedioDownLoadId == nil then
    return
  end
  Log.debug("###[fx] dbKey2", HotUpdate.ActivityLuaProxy.HasDownloadList(tonumber(cfg.VedioDownLoadId)))
  Log.debug("###[fx] dbKey3", HotUpdate.ActivityLuaProxy.CurrProcessingActivityID() ~= tonumber(cfg.VedioDownLoadId), HotUpdate.ActivityLuaProxy.CurrProcessingActivityID(), tonumber(cfg.VedioDownLoadId))
  if HotUpdate.ActivityLuaProxy.HasDownloadList(tonumber(cfg.VedioDownLoadId)) and HotUpdate.ActivityLuaProxy.CurrProcessingActivityID() ~= tonumber(cfg.VedioDownLoadId) then
    local loadState = go.transform:GetChild(1)
    loadState.gameObject:SetActive(true)
    local loadText = loadState.transform:GetChild(2).gameObject:GetComponent("Text")
    if loadText ~= nil then
      loadText.text = StringTable.Get("str_draw_card_new_click_download")
    end
    local canvasGroup = loadState:GetComponent("CanvasGroup")
    if canvasGroup ~= nil then
      canvasGroup.alpha = 1
    end
  else
  end
end

function UIDrawCardController:_CheckNotWifiFirstDownLoad(go, cfg)
  local roleModule = GameGlobal.GetModule(RoleModule)
  local pstId = roleModule:GetPstId()
  local dbKey = "UIDrawCardControllerFirstDownLoadPV_" .. cfg.PlayVideoName .. pstId
  Log.debug("###[fx] dbKey", LocalDB.GetInt(dbKey, 0))
  if LocalDB.GetInt(dbKey, 0) == 0 then
    if HotUpdate.ActivityLuaProxy.HasDownloadList(tonumber(cfg.VedioDownLoadId)) and HotUpdate.ActivityLuaProxy.CurrProcessingActivityID() ~= tonumber(cfg.VedioDownLoadId) then
      do
        local reach_ability = UnityEngine.Application.internetReachability
        if reach_ability == UnityEngine.NetworkReachability.ReachableViaCarrierDataNetwork then
          local strTitle = ""
          local size = HotUpdate.ActivityLuaProxy.GetTotalSize(tonumber(cfg.VedioDownLoadId))
          local fileLensStr = string.format("%.2f", size / 1024 / 1024) .. "M"
          local titleStr = StringTable.Get("str_draw_card_video_title_" .. cfg.ID)
          local stringTable = StringTable.Get("str_draw_card_new_can_download_pv", titleStr, fileLensStr)
          local strText = stringTable
          
          local function okCb()
            Log.debug("###[fx] 开始下载PV资源包:", tonumber(cfg.VedioDownLoadId))
            HotUpdate.ActivityLuaProxy.StartDownload(tonumber(cfg.VedioDownLoadId))
            LocalDB.SetInt(dbKey, 1)
            local loadState = go.transform:GetChild(1)
            local loadText = loadState.transform:GetChild(2).gameObject:GetComponent("Text")
            loadText.text = StringTable.Get("str_draw_card_new_downloading")
            self.downLoadBtnAnim.enabled = true
            self.downLoadBtnAnim:Play("UIDrawCardLongFeiVideoButton_downloading")
          end
          
          local function cancelCb()
            local roleModule = GameGlobal.GetModule(RoleModule)
            local pstId = roleModule:GetPstId()
            local dbKey2 = "UIDrawCardControllerFirstDownLoadPV_" .. cfg.PlayVideoName .. pstId
            Log.debug("###[fx] cancelCb", dbKey2)
            LocalDB.SetInt(dbKey2, 1)
          end
          
          PopupManager.Alert("UICommonMessageBox", PopupPriority.Normal, PopupMsgBoxType.OkCancel, strTitle, strText, okCb, cancelCb)
          LocalDB.SetInt(dbKey, 1)
        else
          if reach_ability == UnityEngine.NetworkReachability.ReachableViaLocalAreaNetwork then
            local title = ""
            local str = StringTable.Get("str_draw_card_new_begin_download")
            PopupManager.Alert("UICommonMessageBox", PopupPriority.Normal, PopupMsgBoxType.Ok, title, str)
            Log.debug("###[fx] 开始下载PV资源包:", tonumber(cfg.VedioDownLoadId))
            HotUpdate.ActivityLuaProxy.StartDownload(tonumber(cfg.VedioDownLoadId))
            LocalDB.SetInt(dbKey, 1)
            local loadState = go.transform:GetChild(1)
            local loadText = loadState.transform:GetChild(2).gameObject:GetComponent("Text")
            loadText.text = StringTable.Get("str_draw_card_new_downloading")
            self.downLoadBtnAnim.enabled = true
            self.downLoadBtnAnim:Play("UIDrawCardLongFeiVideoButton_downloading")
          else
          end
        end
      end
    end
  else
    local reach_ability = UnityEngine.Application.internetReachability
    if reach_ability == UnityEngine.NetworkReachability.ReachableViaLocalAreaNetwork then
      if HotUpdate.ActivityLuaProxy.HasDownloadList(tonumber(cfg.VedioDownLoadId)) and HotUpdate.ActivityLuaProxy.CurrProcessingActivityID() ~= tonumber(cfg.VedioDownLoadId) then
        Log.debug("###[fx] 没wifi 下载有问题 重连", tonumber(cfg.VedioDownLoadId))
      end
      Log.debug("###[fx] 开始下载PV资源包:", tonumber(cfg.VedioDownLoadId))
      HotUpdate.ActivityLuaProxy.StartDownload(tonumber(cfg.VedioDownLoadId))
      self.downLoadBtnAnim.enabled = true
      self.downLoadBtnAnim:Play("UIDrawCardLongFeiVideoButton_downloading")
    elseif reach_ability == UnityEngine.NetworkReachability.ReachableViaCarrierDataNetwork then
      if HotUpdate.ActivityLuaProxy.HasDownloadList(tonumber(cfg.VedioDownLoadId)) then
        self.downLoadBtnAnim.enabled = true
        self.downLoadBtnAnim:Play("UIDrawCardLongFeiVideoButton_downloading")
      end
    elseif reach_ability == UnityEngine.NetworkReachability.NotReachable then
      Log.debug("###[fx] 没网")
    end
  end
end

function UIDrawCardController:_InitDownLoadPvClick(go, cfg)
  UIEventTriggerListener.Get(go).onClick = function()
    if HotUpdate.ActivityLuaProxy.CurrProcessingActivityID() == tonumber(cfg.VedioDownLoadId) then
      local title = ""
      local str = StringTable.Get("str_draw_card_new_downloading_tips")
      PopupManager.Alert("UICommonMessageBox", PopupPriority.Normal, PopupMsgBoxType.Ok, title, str)
      local loadState = go.transform:GetChild(1)
      local loadText = loadState.transform:GetChild(2).gameObject:GetComponent("Text")
      loadText.text = StringTable.Get("str_draw_card_new_downloading")
      self.downLoadBtnAnim.enabled = true
      self.downLoadBtnAnim:Play("UIDrawCardLongFeiVideoButton_downloading")
    elseif not HotUpdate.ActivityLuaProxy.HasDownloadList(tonumber(cfg.VedioDownLoadId)) then
      self._blackMask:SetActive(true)
      Log.debug("fx: click playvedio 已经下载完成 正常播放")
      self:ShowVideo(cfg.PlayVideoName, cfg.PlayVideoBg, function()
        self._blackMask:SetActive(false)
      end)
      local roleModule = GameGlobal.GetModule(RoleModule)
      local pstId = roleModule:GetPstId()
      local dbKey = "UIDrawCardControllerFirstPlayPV_" .. cfg.PlayVideoName .. pstId
      LocalDB.SetInt(dbKey, 1)
    else
      local wifi = false
      local reach_ability = UnityEngine.Application.internetReachability
      if reach_ability == UnityEngine.NetworkReachability.NotReachable then
        Log.error("###[fx:] UnityEngine.NetworkReachability.NotReachable !")
        return
      elseif reach_ability == UnityEngine.NetworkReachability.ReachableViaCarrierDataNetwork then
        wifi = false
      elseif reach_ability == UnityEngine.NetworkReachability.ReachableViaLocalAreaNetwork then
        wifi = true
      end
      if wifi then
        if HotUpdate.ActivityLuaProxy.CurrProcessingActivityID() ~= tonumber(cfg.VedioDownLoadId) then
          local title = ""
          local str = StringTable.Get("str_draw_card_new_begin_download")
          PopupManager.Alert("UICommonMessageBox", PopupPriority.Normal, PopupMsgBoxType.Ok, title, str)
          Log.debug("###[fx] 开始下载PV资源包:", tonumber(cfg.VedioDownLoadId), "当前下载id", HotUpdate.ActivityLuaProxy.CurrProcessingActivityID())
          self:_AddDownLoadListener(go, cfg)
          HotUpdate.ActivityLuaProxy.StartDownload(tonumber(cfg.VedioDownLoadId))
          local loadState = go.transform:GetChild(1)
          local loadText = loadState.transform:GetChild(2).gameObject:GetComponent("Text")
          loadText.text = StringTable.Get("str_draw_card_new_downloading")
          self.downLoadBtnAnim.enabled = true
          self.downLoadBtnAnim:Play("UIDrawCardLongFeiVideoButton_downloading")
        else
          local title = ""
          local str = StringTable.Get("str_draw_card_new_downloading_tips")
          PopupManager.Alert("UICommonMessageBox", PopupPriority.Normal, PopupMsgBoxType.Ok, title, str)
          local loadState = go.transform:GetChild(1)
          local loadText = loadState.transform:GetChild(2).gameObject:GetComponent("Text")
          loadText.text = StringTable.Get("str_draw_card_new_downloading")
          self.downLoadBtnAnim.enabled = true
          self.downLoadBtnAnim:Play("UIDrawCardLongFeiVideoButton_downloading")
        end
      else
        local strTitle = ""
        local size = HotUpdate.ActivityLuaProxy.GetTotalSize(tonumber(cfg.VedioDownLoadId))
        local fileLensStr = string.format("%.2f", size / 1024 / 1024) .. "M"
        local titleStr = StringTable.Get("str_draw_card_video_title_" .. cfg.ID)
        local stringTable = StringTable.Get("str_draw_card_new_can_download_pv", titleStr, fileLensStr)
        local strText = stringTable
        
        local function okCb()
          Log.debug("###[fx] 开始下载PV资源包:", tonumber(cfg.VedioDownLoadId))
          self:_AddDownLoadListener(go, cfg)
          HotUpdate.ActivityLuaProxy.StartDownload(tonumber(cfg.VedioDownLoadId))
          local loadState = go.transform:GetChild(1)
          local loadText = loadState.transform:GetChild(2).gameObject:GetComponent("Text")
          loadText.text = StringTable.Get("str_draw_card_new_downloading")
          self.downLoadBtnAnim.enabled = true
          self.downLoadBtnAnim:Play("UIDrawCardLongFeiVideoButton_downloading")
        end
        
        local function cancelCb()
          Log.debug("###[fx] 手动取消下载")
        end
        
        PopupManager.Alert("UICommonMessageBox", PopupPriority.Normal, PopupMsgBoxType.OkCancel, strTitle, strText, okCb, cancelCb)
      end
    end
    local roleModule = GameGlobal.GetModule(RoleModule)
    local pstId = roleModule:GetPstId()
    local dbKey = "UIDrawCardControllerFirstPlayPV_" .. cfg.PlayVideoName .. pstId
    if LocalDB.GetInt(dbKey, 0) ~= 0 then
      if go.transform.childCount > 2 then
        local loadState = go.transform:GetChild(2)
        loadState.gameObject:SetActive(false)
      end
    elseif go.transform.childCount > 2 then
      local loadState = go.transform:GetChild(1)
      if loadState.gameObject.activeSelf then
        return
      end
      local loadState = go.transform:GetChild(2)
      Log.debug("###[fx] 设置红点")
      loadState.gameObject:SetActive(true)
    end
  end
end

function UIDrawCardController:_AddDownLoadListener(go, cfg)
  if not HotUpdate.ActivityLuaProxy.HasDownloadList(tonumber(cfg.VedioDownLoadId)) then
    Log.fatal("###[fx] 已经下载完成 不监听：", tonumber(cfg.VedioDownLoadId))
  end
  Log.fatal("###[fx] ：proces", HotUpdate.ActivityLuaProxy.CurrProcessingActivityID(), "downloadid", tonumber(cfg.VedioDownLoadId))
  HotUpdate.ActivityLuaProxy.AddListener(function(callbackType, activityId, unityActionCallBack)
    if callbackType == HotUpdate.ActivityDownloaderCallbackType.DownloadError or callbackType == HotUpdate.ActivityDownloaderCallbackType.FatalError then
      Log.fatal("###[fx] 下载包失败：", tonumber(cfg.VedioDownLoadId))
    elseif callbackType == HotUpdate.ActivityDownloaderCallbackType.Finish then
      Log.debug("###[fx] 下包完成:", tonumber(cfg.VedioDownLoadId))
      local loadState = go.transform:GetChild(1)
      loadState.gameObject:SetActive(false)
      if go.transform.childCount > 2 then
        local loadState = go.transform:GetChild(2)
        Log.debug("###[fx] 设置红点")
        loadState.gameObject:SetActive(true)
      end
      self.downLoadBtnAnim.enabled = true
      self.downLoadBtnAnim:Play("UIDrawCardLongFeiVideoButton_complete")
    elseif callbackType == HotUpdate.ActivityDownloaderCallbackType.SpaceNotEnough then
      Log.fatal("###[fx] 下载包失败，磁盘空间不足:", tonumber(cfg.VedioDownLoadId))
    elseif callbackType == HotUpdate.ActivityDownloaderCallbackType.NotUseWifi then
      Log.debug("###[fx] 使用4G下载包:", tonumber(cfg.VedioDownLoadId))
      unityActionCallBack:DynamicInvoke(true)
    end
  end)
end

function UIDrawCardController:_RefreshPetWish(poolInfo)
  local module = self:GetModule(GambleModule)
  local idOptional = module:GetCfgOptionalPoolId(poolInfo.index)
  local cfgOptional = Cfg.cfg_optional_pool[idOptional]
  local showRed = module:CheckOptionalRed(poolInfo.index)
  self._uiLayout.gameObject:SetActive(true)
  self._uiWish.gameObject:SetActive(cfgOptional ~= nil)
  self._uiWishRed.gameObject:SetActive(showRed)
end

function UIDrawCardController:BtnWishOnClick(go)
  local module = self:GetModule(GambleModule)
  local poolInfo = self._poolsUIData[self.currentIdx]
  local param = {
    indexPool = self.currentIdx,
    idRecruit = poolInfo.poolData.performance_id,
    idOptional = module:GetCfgOptionalPoolId(poolInfo.index)
  }
  self:ShowDialog("UIRecruitWish", param)
end

function UIDrawCardController:UpdateDrawCardRed()
  local module = self:GetModule(GambleModule)
  local showRed = module:CheckOptionalRed(self.currentIdx)
  self._uiWishRed.gameObject:SetActive(showRed)
  do return end
  for k, v in pairs(self._thumbItems) do
    v:PublicCheckWishRed()
  end
end
