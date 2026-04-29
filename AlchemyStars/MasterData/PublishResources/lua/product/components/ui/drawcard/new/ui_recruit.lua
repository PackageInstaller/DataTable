_class("UIRecruit", UIController)
UIRecruit = UIRecruit
local ClientPrizePoolType = {
  SubType_Hand = 1,
  SubType_UP = 2,
  SubType_Turn = 3,
  SubType_Always = 4
}
_enum("ClientPrizePoolType", ClientPrizePoolType)

function UIRecruit:LoadDataOnEnter(TT, res, uiParams)
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
  self._timeModule = GameGlobal.GetModule(SvrTimeModule)
  GameGlobal.GetModule(PayModule):RequestGetBalanceNormal()
  self._campaign = UIActivityCampaign:New()
  local campaignModule = GameGlobal.GetModule(CampaignModule)
  self._campaign:LoadCampaignInfo(TT, res, ECampaignType.CAMPAIGN_TYPE_INLAND_GAMBLE)
  if res and not res:GetSucc() then
    res:SetSucc(true)
  else
    self._campaign:ReLoadCampaignInfo_Force(TT, res)
    self._questComponent = self._campaign:GetComponent(ECampaignGambleComponentID.ECAMPAIGN_Gamble_QUEST)
  end
end

function UIRecruit:OnShow(uiParams)
  CutsceneManager.ExcuteCutsceneOut()
  self:ManualSetUnderLayerUIVisble(false)
  self.isSceneLoaded = false
  self._sceneLoadingTask = self:StartTask(function(TT)
    if UIHelper.GetActiveSceneName() ~= "Ckt_01_new" then
      self.preLoadPrefab = ResourceManager:GetInstance():AsyncLoadAsset(TT, "Chouka_lagan_charge_prefab.prefab", LoadType.GameObject)
      self.preLoadScene = ResourceManager:GetInstance():AsyncLoadAsset(TT, "Ckt_01_new.unity", LoadType.Unity)
    end
    self.isSceneLoaded = true
    self.sceneCamera = UnityEngine.Camera.main
    if self.sceneCamera and not GameGlobal.UIStateManager():IsShow("UIDrawCardAnimController") then
      self.sceneCamera.gameObject:SetActive(false)
    end
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
  self:InitWidget()
  self:AttachEvent(GameEventType.ItemCountChanged, self._OnItemChanged)
  self:AttachEvent(GameEventType.WaitForRecuitSceneLoadFinish, self._WaitForRecuitSceneLoadFinish)
  self:AttachEvent(GameEventType.RefreshRecuitUIView, self._RefreshUI)
  self:AttachEvent(GameEventType.UpdateDrawCardRed, self.UpdateDrawCardRed)
  self._gambleModule = self:GetModule(GambleModule)
  self._gambleModule:InitContext(self._gambleModule)
  self._roleModule = self:GetModule(RoleModule)
  self._itemModule = self:GetModule(ItemModule)
  self._lastBGMResName = AudioHelperController.GetCurrentBgm()
  local firstID = uiParams[1]
  self.nearestTime = 86400
  self:_RefreshUI(firstID)
end

function UIRecruit:_RefreshUI(firstID)
  self:ClearData()
  self._currentIdx = nil
  local awardPools = self._gambleModule:GetPrizePools()
  self._poolsUIData = {}
  for idx, pool in ipairs(awardPools) do
    local uiData = UIDrawCardPoolInfo:New(pool, idx)
    self._poolsUIData[idx] = uiData
    if not Cfg.cfg_recruit_pool_view[uiData.poolData.performance_id] then
      Log.exception("cfg_recruit_pool_view中找不到配置:", uiData.poolData.performance_id)
    end
  end
  if firstID then
    for i, pool in ipairs(self._poolsUIData) do
      if pool.poolData.performance_id == firstID then
        local poolCfg = Cfg.cfg_recruit_pool_view[pool.poolData.performance_id]
        if self:CheckInOpenTimeInterval(poolCfg) then
          self._gambleModule:Context():SetDefaultPoolIndex(pool.index)
          Log.info("抽卡界面设置初始卡池索引:", i)
          break
        end
      end
    end
  end
  local sop = self:GetUIComponent("UISelectObjectPath", "currencyMenu")
  self.currencyMenu = sop:SpawnObject("UICurrencyMenu")
  self.specailCurrency = self:GetUIComponent("UISelectObjectPath", "specailCurrency")
  local topButton = self:GetUIComponent("UISelectObjectPath", "TopButtons")
  self.topButtonWidget = topButton:SpawnObject("UICommonTopButton")
  self.topButtonWidget:SetData(function()
    self:ManualSetUnderLayerUIVisble(true)
    GameGlobal.EventDispatcher():Dispatch(GameEventType.UpdateDrawCardRed)
    if GameGlobal.UIStateManager():CurUIStateType() ~= UIStateType.UIRecruit then
      self:CloseDialog()
    else
      GameGlobal.UIStateManager():SwitchState(UIStateType.UIMain)
    end
  end, function()
    local poolData = self._poolsUIData[self._currentIdx].poolData
    local poolCfg = Cfg.cfg_recruit_pool_view[poolData.performance_id]
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
  end, function()
    self:ManualSetUnderLayerUIVisble(true)
    GameGlobal.EventDispatcher():Dispatch(GameEventType.UpdateDrawCardRed)
    UICommonHelper:GetInstance():SwitchToUIMain()
  end)
  self:InitThumbList()
  local poolIndex = self._gambleModule:Context():GetDefaultPoolIndex()
  local defaultIdx = 1
  if poolIndex and 0 < poolIndex then
    for i, pool in ipairs(self._poolsUIData) do
      if pool.index == poolIndex then
        defaultIdx = i
        break
      end
    end
  end
  if self._thumbItems[defaultIdx] == nil then
    for key, v in pairs(self._thumbItems) do
      defaultIdx = key
      break
    end
  end
  local viewPortHeight = self:GetUIComponent("RectTransform", "Viewport").rect.height
  local contentRect = self.thumbList:GetComponent(typeof(UnityEngine.RectTransform))
  UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(contentRect)
  if defaultIdx ~= 1 then
    local posY = -self._thumbItems[defaultIdx]:GameObject():GetComponent(typeof(UnityEngine.RectTransform)).anchoredPosition.y
    local height = contentRect.rect.height
    local target = viewPortHeight / 2
    local deltaY = posY - target
    deltaY = Mathf.Clamp(deltaY, 0, math.max(height - viewPortHeight, 0))
    contentRect.anchoredPosition = Vector2(contentRect.anchoredPosition.x, deltaY)
  end
  if viewPortHeight < contentRect.rect.height then
    self._thumbScrollRect.movementType = UnityEngine.UI.ScrollRect.MovementType.Elastic
    self._thumbScrollRect.elasticity = 0.1
  else
    self._thumbScrollRect.movementType = UnityEngine.UI.ScrollRect.MovementType.Clamped
  end
  self:HandleCountdownTimer()
  self:_RefreshByIdx(defaultIdx, true)
  self._thumbItems[self._currentIdx]:SetOffset()
  self._eftAnim = UIRecruitAnim:New(self)
  self:UpdateDrawCardRed()
  self:GuideAppraise()
end

function UIRecruit:PlayHideAnim(cb)
  self:StartTask(function(TT)
    self:Lock("UIRecruit_PlayHideAnim")
    self._anim:Play("uieff_Recruit_out01")
    YIELD(TT, 200)
    self:UnLock("UIRecruit_PlayHideAnim")
    if cb then
      cb()
    end
  end)
end

function UIRecruit:_WaitForRecuitSceneLoadFinish(callback)
  if not self.isSceneLoaded then
    self:Lock("UIRecruit_WaitForRecuitSceneLoadFinish")
    self:StartTask(function(TT)
      while not self.isSceneLoaded do
        YIELD(TT)
      end
      self:UnLock("UIRecruit_WaitForRecuitSceneLoadFinish")
      if callback then
        callback()
      end
    end)
  elseif callback then
    callback()
  end
end

function UIRecruit:OnUpdate(deltaTimeMS)
  if self._eftAnim then
    self._eftAnim:Update(deltaTimeMS)
  end
end

function UIRecruit:OnHide()
  if self.sceneCamera then
    self.sceneCamera.gameObject:SetActive(false)
  end
  GameGlobal.EventDispatcher():Dispatch(GameEventType.UpdateDrawCardRed)
  for _, item in ipairs(self._thumbItems) do
    item:Dispose()
  end
  self._thumbItems = nil
  for _, item in pairs(self._thumbTitleItems) do
    item:Dispose()
  end
  self._thumbTitleItems = nil
  for _, go in ipairs(self._thumbGos) do
    UIHelper.DestroyGameObject(go)
  end
  self._thumbGos = nil
  AudioHelperController.PlayBGM(self._lastBGMResName, AudioConstValue.BGMCrossFadeTime)
  if self._countdownTimer then
    GameGlobal.Timer():CancelEvent(self._countdownTimer)
    self._countdownTimer = nil
  end
  if self._countdownRefreshTimer then
    GameGlobal.Timer():CancelEvent(self._countdownRefreshTimer)
    self._countdownRefreshTimer = nil
  end
  if self._freeTimeEvent then
    GameGlobal.Timer():CancelEvent(self._freeTimeEvent)
    self._freeTimeEvent = nil
  end
  if self._refreshTimeEvent then
    GameGlobal.Timer():CancelEvent(self._refreshTimeEvent)
    self._refreshTimeEvent = nil
  end
  if self._eftAnim then
    self._eftAnim:Dispose()
    self._eftAnim = nil
  end
  if not self.dontSwitchScene then
    self:Lock("UIRecruit_OnHide")
    self:StartTask(function(TT)
      while not self.isSceneLoaded do
        YIELD(TT)
      end
      ResourceManager:GetInstance():AsyncLoadAsset(TT, "UI.unity", LoadType.Unity)
      self.preLoadScene:Dispose()
      self:UnLock("UIRecruit_OnHide")
    end)
  end
  HotUpdate.ActivityLuaProxy.AddListener(nil)
end

function UIRecruit:InitWidget()
  self.thumbList = self:GetGameObject("ThumbList")
  self._thumbScrollRect = self:GetUIComponent("ScrollRect", "Thumb")
  self._normalPoolTitle = self:GetUIComponent("UILocalizationText", "NormalPoolTitle")
  self._normalPoolTitleShadow = self:GetUIComponent("UILocalizationText", "NormalPoolTitleShadow")
  self._petPosotioningPoolTitle = self:GetUIComponent("UILocalizationText", "PetPosotioningPoolTitle")
  self._poolSubtitle = self:GetUIComponent("UILocalizationText", "PoolSubtitle")
  self._sixProb = self:GetUIComponent("UIRichText", "SixProb")
  self._prob = self:GetGameObject("Prob")
  self._poolSubtitleBgObj = self:GetGameObject("PoolSubtitleObj")
  self._closeCondition = self:GetUIComponent("UILocalizationText", "CloseCondition")
  self._closeConditionObj = self:GetGameObject("CloseConditionObj")
  self.rawTitle = self:GetUIComponent("RawImageLoader", "rawTitle")
  self.rawImageTitle = self:GetUIComponent("RectTransform", "rawTitle")
  self.post_rawTitle = self:GetUIComponent("RawImageLoader", "post_rawTitle")
  self.rawImagePost = self:GetUIComponent("RectTransform", "post_rawTitle")
  self.poolTitleBgLayout = self:GetGameObject("PoolTitleBgLayout")
  self._commonAtlas = self:GetAsset("UICommon.spriteatlas", LoadType.SpriteAtlas)
  self._propertyAtlas = self:GetAsset("Property.spriteatlas", LoadType.SpriteAtlas)
  self._multiBtnsBg = self:GetGameObject("MutiBtnBg")
  self._singleDraw = self:GetGameObject("SingleDraw")
  self._multipleDraw = self:GetGameObject("MultipleDraw")
  self._singleDrawRect = self:GetUIComponent("RectTransform", "SingleDraw")
  self._multipleDrawRect = self:GetUIComponent("RectTransform", "MultipleDraw")
  self._singleItemIcon = self:GetUIComponent("Image", "SingleIcon")
  self._singleItemCount = self:GetUIComponent("UILocalizationText", "SingleCount")
  self._singleDiscount = self:GetGameObject("SingleDiscount")
  self._singleDiscountInfo = self:GetUIComponent("UILocalizationText", "SingleDiscountInfo")
  self._singleOriPrice = self:GetUIComponent("UILocalizationText", "SingleOriPrice")
  self._singleNowPrice = self:GetUIComponent("UILocalizationText", "SingleNowPrice")
  self._multipleItemIcon = self:GetUIComponent("Image", "MultipleIcon")
  self._multipleItemCount = self:GetUIComponent("UILocalizationText", "MultipleCount")
  self._multipleBtnText = self:GetUIComponent("UILocalizationText", "MultipleBtnText")
  self._multipleDiscount = self:GetGameObject("MultipleDiscount")
  self._multipleDiscountInfo = self:GetUIComponent("UILocalizationText", "MultipleDiscountInfo")
  self._multipleOriPrice = self:GetUIComponent("UILocalizationText", "MultipleOriPrice")
  self._multipleNowPrice = self:GetUIComponent("UILocalizationText", "MultipleNowPrice")
  self._newPlayerLastTimeObj = self:GetGameObject("newPlayerLastTimeObj")
  self._newPlayerLastTime = self:GetUIComponent("UILocalizationText", "newPlayerLastTime")
  self._petWidget = self:GetUIComponent("UISelectObjectPath", "PetWidgets")
  self._bgPool = {
    [1] = self:GetGameObject("pool_l0").transform:GetChild(0).gameObject,
    [2] = self:GetGameObject("pool_l1").transform:GetChild(0).gameObject,
    [3] = self:GetGameObject("pool_l2").transform:GetChild(0).gameObject,
    [4] = self:GetGameObject("pool_l3").transform:GetChild(0).gameObject
  }
  self._fullScreenAnimBtnObj = self:GetGameObject("FullScreenAnimBtn")
  self._timeLimitUpImageObj = self:GetGameObject("TimeLimitUpImageObj")
  self._timeLimitUpImage = self:GetUIComponent("Image", "TimeLimitUpImage")
  self._timeLimitUpInfo = self:GetUIComponent("UILocalizationText", "TimeLimitUpInfo")
  self._positioningTitleDownObj = self:GetGameObject("PositioningTitleDownObj")
  self._positioningTitleDownBg = self:GetUIComponent("Image", "PositioningTitleDownBg")
  self._positioningTitleDownTitle = self:GetUIComponent("UILocalizationText", "PositioningTitleDownTitle")
  self._petPosotioningPoolTitleOutline = self:GetUIComponent("H3D.UGUI.CircleOutline", "PetPosotioningPoolTitle")
  self._positioningBgLayout = self:GetUIComponent("Image", "PositioningBgLayout")
  self._cfgPosCtrl = self:GetUIComponent("RectTransform", "CfgPosCtrl")
  self._petDesc = self:GetUIComponent("UILocalizationText", "PetDesc")
  self._positioningTitleDownTitle = self:GetUIComponent("UILocalizationText", "PositioningTitleDownTitle")
  self._positioningDesc = self:GetUIComponent("UILocalizationText", "PositioningDesc")
  self._PetPositioningObj = self:GetGameObject("PetPositioningObj")
  self._DefaultPetInfoObj = self:GetGameObject("DefaultPetInfoObj")
  self._videoWidget = self:GetGameObject("VideoWidget")
  self._fiveDrawCardTimesTip = self:GetGameObject("fiveDrawCardTimesTip")
  self._fiveDrawCardTimesText = self:GetUIComponent("UIRichText", "fiveDrawCardTimesText")
  self._blackMask = self:GetGameObject("BlackMask")
  self._anim = self:GetUIComponent("Animation", "anim")
  self._blackMask = self:GetGameObject("BlackMask")
  self._starImage = self:GetGameObject("starImage")
  self._uiWish = self:GetUIComponent("RectTransform", "uiWish")
  self._uiWishRed = self:GetChildComponent(self._uiWish, "RectTransform", "red")
  self._notIncludeBtn = self:GetGameObject("NotIncludeBtn")
  self._notIncludeTip = self:GetGameObject("NotIncludeTip")
  self._notIncludeTipText = self:GetUIComponent("UILocalizationText", "NotIncludeTipText")
  self._petEftLogos = {
    self:GetUIComponent("RawImageLoader", "logo1"),
    self:GetUIComponent("RawImageLoader", "logo2"),
    self:GetUIComponent("RawImageLoader", "logo3"),
    self:GetUIComponent("RawImageLoader", "logo4")
  }
  self.mulFreeTimeTex = self:GetUIComponent("UILocalizationText", "mulFreeTimeTex")
  self.sinFreeTimeTex = self:GetUIComponent("UILocalizationText", "sinFreeTimeTex")
  self.normalSingleGo = self:GetGameObject("normalSingleGo")
  self.SingleFree = self:GetGameObject("SingleFree")
  self.sinFreeTimeGo = self:GetGameObject("sinFreeTimeGo")
  self.MultipleFree = self:GetGameObject("MultipleFree")
  self.normalMultipleGo = self:GetGameObject("normalMultipleGo")
  self.mulFreeTimeGo = self:GetGameObject("mulFreeTimeGo")
end

function UIRecruit:_FreeCount(poolInfo)
  local freeCountSingle = poolInfo:GetFreeCount_Single()
  self.SingleFree:SetActive(0 < freeCountSingle)
  self.normalSingleGo:SetActive(freeCountSingle <= 0)
  local freeCountMulti = poolInfo:GetFreeCount_Multi()
  self.MultipleFree:SetActive(0 < freeCountMulti)
  self.normalMultipleGo:SetActive(freeCountMulti <= 0)
  local timerTex, showTimer, nextTime
  local showTimer_Sin, nextTime_Sin = self:GetSingleFreeTimer(poolInfo)
  local showTimer_Mul, nextTime_Mul = self:GetMultipleFreeTimer(poolInfo)
  if showTimer_Mul and not showTimer_Sin then
    nextTime = nextTime_Mul
    timerTex = self.mulFreeTimeTex
  elseif showTimer_Mul and showTimer_Sin then
    if nextTime_Sin < nextTime_Mul then
      timerTex = self.sinFreeTimeTex
    else
      timerTex = self.mulFreeTimeTex
    end
    nextTime = math.min(nextTime_Sin, nextTime_Mul)
  elseif not showTimer_Mul and showTimer_Sin then
    nextTime = nextTime_Mul
    timerTex = self.sinFreeTimeTex
  end
  self.sinFreeTimeGo:SetActive(showTimer_Sin)
  self.mulFreeTimeGo:SetActive(showTimer_Mul)
  if nextTime then
    self._nextTime = nextTime
    if self._freeTimeEvent then
      GameGlobal.Timer():CancelEvent(self._freeTimeEvent)
      self._freeTimeEvent = nil
    end
    self:SetFreeTimerTex(timerTex)
    self._freeTimeEvent = GameGlobal.Timer():AddEventTimes(1000, TimerTriggerCount.Infinite, function()
      self:SetFreeTimerTex(timerTex)
    end)
    if self._refreshTimeEvent then
      GameGlobal.Timer():CancelEvent(self._refreshTimeEvent)
      self._refreshTimeEvent = nil
    end
    local svrTime = math.ceil(self._timeModule:GetServerTime())
    local refreshTime = nextTime * 1000 - svrTime + 1000
    self._refreshTimeEvent = GameGlobal.Timer():AddEvent(refreshTime, function()
      Log.debug("执行刷新逻辑 ReLoadDataAndRefresh")
      self:ReLoadDataAndRefresh()
    end)
  end
end

function UIRecruit:SetFreeTimerTex(timerTex)
  local svrTime = math.floor(self._timeModule:GetServerTime() * 0.001)
  local lessTime = self._nextTime - svrTime
  if 0 <= lessTime then
    local timeStr = HelperProxy:GetInstance():Time2Tex(lessTime)
    timerTex:SetText(timeStr)
  end
end

function UIRecruit:GetSingleFreeTimer(poolInfo)
  local closeTimer = poolInfo:CloseTimer_Single()
  local svrTimeModule = GameGlobal.GetModule(SvrTimeModule)
  local nowTimer = math.ceil(svrTimeModule:GetServerTime() * 0.001)
  if closeTimer < nowTimer then
    return false
  end
  local nextTimer = poolInfo:NextTimer_Single()
  if nextTimer == 0 then
    return false
  end
  if closeTimer <= nextTimer then
    return false
  end
  local poolCloseType = poolInfo.poolData.close_type
  if poolCloseType == PrizePoolOpenCloseType.TIME_CONDITON then
    local poolCloseTimer = poolInfo.poolData.extend_data
    if nextTimer >= poolCloseTimer then
      return false
    end
  end
  return true, nextTimer
end

function UIRecruit:GetMultipleFreeTimer(poolInfo)
  local closeTimer = poolInfo:CloseTimer_Multi()
  local svrTimeModule = GameGlobal.GetModule(SvrTimeModule)
  local nowTimer = math.ceil(svrTimeModule:GetServerTime() * 0.001)
  if closeTimer < nowTimer then
    return false
  end
  local nextTimer = poolInfo:NextTimer_Multi()
  if nextTimer == 0 then
    return false
  end
  if closeTimer <= nextTimer then
    return false
  end
  local poolCloseType = poolInfo.poolData.close_type
  if poolCloseType == PrizePoolOpenCloseType.TIME_CONDITON then
    local poolCloseTimer = poolInfo.poolData.extend_data
    if nextTimer >= poolCloseTimer then
      return false
    end
  end
  return true, nextTimer
end

function UIRecruit:InitThumbList()
  self._thumbItems = {}
  self._thumbTitleItems = {}
  self._thumbGos = {}
  local type = -1
  local parent = self.thumbList.transform
  
  local function loadPrefab(name)
    local go = UIHelper.GetGameObject(name)
    local tf = go.transform
    tf:SetParent(parent)
    tf.localScale = Vector3.one
    tf.localRotation = Quaternion.identity
    table.insert(self._thumbGos, go)
    return go
  end
  
  for index, pool in ipairs(self._poolsUIData) do
    local poolCfg = Cfg.cfg_recruit_pool_view[pool.poolData.performance_id]
    local subtype = poolCfg.Subtype
    if self:CheckInOpenTimeInterval(poolCfg) then
      self._thumbItems[index] = UIRecruitThumbItem:New(loadPrefab("UIRecruitThumbItem.prefab"), index, pool, function(idx)
        self:_OnClickThumbItem(idx)
      end, self._questComponent)
    end
  end
end

function UIRecruit:CheckInOpenTimeInterval(cfg)
  local poolCfg = Cfg.cfg_gamble_pool_putaway[cfg.ID]
  if not poolCfg then
    return true, -1
  end
  if not poolCfg.OpenTimeInterval then
    return true, -1
  end
  local timeToStart = 86400
  self.nearestTime = 86400
  local loginModule = GameGlobal.GetModule(LoginModule)
  local svrTimeModule = GameGlobal.GetModule(SvrTimeModule)
  local curTime = svrTimeModule and math.floor(svrTimeModule:GetServerTime() * 0.001) or 0
  for _, timePairArray in pairs(poolCfg.OpenTimeInterval) do
    local startTime = loginModule:GetTimeStampByTimeStr(timePairArray[1], Enum_DateTimeZoneType.E_ZoneType_GMT)
    local endTime = loginModule:GetTimeStampByTimeStr(timePairArray[2], Enum_DateTimeZoneType.E_ZoneType_GMT)
    Log.debug("CheckInOpenTimeInterval卡池限时id=", poolCfg.ID, curTime, startTime, endTime)
    if curTime < endTime and curTime >= startTime then
      local nearEndTime = endTime - curTime
      self.nearestTime = nearEndTime < self.nearestTime and nearEndTime or self.nearestTime
      Log.debug("CheckInOpenTimeInterval当前显示的卡池限时id=", poolCfg.ID)
      return true
    elseif curTime < startTime then
      local dis = startTime - curTime
      timeToStart = timeToStart < dis and timeToStart or dis
    end
  end
  self.nearestTime = timeToStart < self.nearestTime and timeToStart or self.nearestTime
  return false
end

function UIRecruit:ClearData()
  if self._thumbItems then
    for _, item in pairs(self._thumbItems) do
      item:Dispose()
    end
    self._thumbItems = nil
  end
  if self._thumbTitleItems then
    for _, item in pairs(self._thumbTitleItems) do
      item:Dispose()
    end
    self._thumbTitleItems = nil
  end
  if self._thumbGos then
    for _, go in ipairs(self._thumbGos) do
      UIHelper.DestroyGameObject(go)
    end
    self._thumbGos = nil
  end
  if self._countdownTimer then
    GameGlobal.Timer():CancelEvent(self._countdownTimer)
    self._countdownTimer = nil
  end
  if self._countdownRefreshTimer then
    GameGlobal.Timer():CancelEvent(self._countdownRefreshTimer)
    self._countdownRefreshTimer = nil
  end
  if self._eftAnim then
    self._eftAnim:Dispose()
    self._eftAnim = nil
  end
end

function UIRecruit:HandleCountdownTimer()
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
  time = time > self.nearestTime and self.nearestTime or time
  Log.debug("HandleCountdownTimer下次刷新时间=", time, self.nearestTime)
  if time < 86400 then
    self._countdownRefreshTimer = GameGlobal.Timer():AddEvent(time * 1000, function()
      self._countdownRefreshTimer = nil
      Log.debug("执行刷新逻辑 ReLoadDataAndRefresh")
      self:ReLoadDataAndRefresh()
    end)
  end
end

function UIRecruit:ReLoadDataAndRefresh()
  self:Lock("UIRecruit_ReLoadDataAndRefresh")
  self:StartTask(function(TT)
    local res = AsyncRequestRes:New()
    self:LoadDataOnEnter(TT, res)
    self:_RefreshUI()
    self:UnLock("UIRecruit_ReLoadDataAndRefresh")
  end)
end

function UIRecruit:_OnClickThumbItem(idx)
  if self._currentIdx == idx then
    return
  end
  if self._eftAnim then
    self._eftAnim:SwitchTo(self._currentIdx, idx)
  else
    self:_RefreshByIdx(idx)
  end
end

function UIRecruit:_RefreshByIdx(idx, isFirstShow)
  if self._currentIdx == idx then
    return
  end
  if self._currentIdx then
    self._thumbItems[self._currentIdx]:DeSelect()
  end
  self._currentIdx = idx
  self._thumbItems[self._currentIdx]:OnSelect(isFirstShow)
  self:_ShowPoolInfo(self._currentIdx)
end

function UIRecruit:_ShowPoolInfo(idx)
  local poolInfo = self._poolsUIData[idx]
  self:_RefreshImage(poolInfo)
  self:_RefreshTopTips(poolInfo)
  self:_RefreshPoolContent(poolInfo)
  self:_RefreshTitle(poolInfo)
  self:_RefreshDrawBtns(poolInfo)
  self:_RefreshBGM(poolInfo)
  self:_RefreshPetWidget(poolInfo)
  self:_RefreshPetInfo(poolInfo)
  self:_RefreshCloseCondition(poolInfo)
  self:_ShowPVBtn(poolInfo)
  self:_ShowRewardBtn(poolInfo)
  self:_RefreshFiveStarTips(poolInfo)
  self:_RefreshPetWish(poolInfo)
  self:_RefreshNotIncludeTip(poolInfo)
  self:_FreeCount(poolInfo)
  if not self._isPvPlaying then
    self:_CheckGuide()
  end
end

function UIRecruit:_RefreshTitle(poolInfo)
  self._uiData = poolInfo
  local cfg = Cfg.cfg_recruit_pool_view[self._uiData.poolData.performance_id]
  if cfg == nil then
    Log.fatal("###error -- drawcard - cfg_drawcard_pool_view is nil ! key --> ", self._uiData.poolData.performance_id)
    return
  end
  local petPositioningOffset = cfg.PetPositioningOffset
  if petPositioningOffset then
    if cfg.PoolNameIcon == nil then
      self.post_rawTitle.gameObject:SetActive(false)
      self._positioningBgLayout.gameObject:SetActive(true)
    else
      self.post_rawTitle.gameObject:SetActive(true)
      self._positioningBgLayout.gameObject:SetActive(false)
      self.post_rawTitle:LoadImage(cfg.PoolNameIcon)
      if cfg.PoolNameIconSize then
        self.rawImagePost.sizeDelta = Vector2(cfg.PoolNameIconSize[1], cfg.PoolNameIconSize[2])
      end
    end
  elseif cfg.PoolNameIcon == nil then
    self.rawTitle.gameObject:SetActive(false)
    self.poolTitleBgLayout.gameObject:SetActive(true)
  else
    self.rawTitle.gameObject:SetActive(true)
    self.poolTitleBgLayout.gameObject:SetActive(false)
    self.rawTitle:LoadImage(cfg.PoolNameIcon)
    if cfg.PoolNameIconSize then
      self.rawImageTitle.sizeDelta = Vector2(cfg.PoolNameIconSize[1], cfg.PoolNameIconSize[2])
    end
  end
end

function UIRecruit:_ShowPVBtn(poolInfo)
  local cfg = Cfg.cfg_recruit_pool_view[poolInfo.poolData.performance_id]
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

function UIRecruit:_ShowRewardBtn(poolInfo)
  local poolData = poolInfo.poolData
  local uiShopObj = self:GetGameObject("uiShop")
  local uiAwardSpawner = self:GetUIComponent("UISelectObjectPath", "uiAwardSpawner")
  local uiAwardSpawnerObj = self:GetGameObject("uiAwardSpawner")
  uiAwardSpawnerObj:SetActive(false)
  uiShopObj:SetActive(false)
  if self._questComponent then
    self._awardButton = uiAwardSpawner:SpawnObject("UIDrawCardAwardButton")
    self._awardButton:SetData(self._questComponent)
    if poolData.prize_group_id and poolData.prize_group_id > 0 then
      uiAwardSpawnerObj:SetActive(true)
    end
  end
end

function UIRecruit:_InitVedioBtn(cfg)
  if cfg.PlayVideoName then
    local go = UIHelper.GetGameObject("UIDrawCardCommonVideoButton.prefab")
    local tf = go.transform
    tf:SetParent(self._videoWidget.transform)
    tf:GetComponent("RectTransform").anchoredPosition = Vector2.zero
    tf.localScale = Vector3.one
    tf.localRotation = Quaternion.identity
    UIEventTriggerListener.Get(go).onClick = function()
      self._blackMask:SetActive(true)
      Log.debug("fx: click playvedio")
      self:CheckForUIPlayVedio(cfg.PlayVideoName, cfg.PlayVideoBg, function()
        self._blackMask:SetActive(false)
      end)
    end
    local roleModule = GameGlobal.GetModule(RoleModule)
    local pstId = roleModule:GetPstId()
    local dbKey = "UIRecruitFirstPlayPV_" .. cfg.PlayVideoName .. pstId
    if cfg.FirstLocalDBKey then
      dbKey = dbKey .. "FirstKey" .. cfg.FirstLocalDBKey
    end
    if LocalDB.GetInt(dbKey, 0) == 0 then
      self._blackMask:SetActive(true)
      Log.debug("fx: click playvedio")
      self._isPvPlaying = true
      self:CheckForUIPlayVedio(cfg.PlayVideoName, cfg.PlayVideoBg, function()
        self._blackMask:SetActive(false)
        self:_OnPvPlayFinish()
      end)
      LocalDB.SetInt(dbKey, 1)
    end
    self:_FixVedioBtnState(cfg, go)
  end
end

function UIRecruit:CheckForUIPlayVedio(videoName, Bg, finishCB)
  if CriWare.CriManaMovieControllerForUI then
    self:ShowDialog("UICriVideoController", videoName, Bg, finishCB, nil)
  else
    self:ShowDialog("UICriVideoControllerNowrap", videoName, Bg, finishCB, nil)
  end
end

function UIRecruit:_OnPvPlayFinish()
  self._isPvPlaying = nil
  self:_CheckGuide()
end

function UIRecruit:_CheckGuide()
  local poolInfo = self._poolsUIData[self._currentIdx]
  local module = self:GetModule(GambleModule)
  local idOptional = module:GetCfgOptionalPoolId(poolInfo.index)
  local cfgOptional = Cfg.cfg_optional_pool[idOptional]
  if cfgOptional ~= nil then
    GameGlobal.EventDispatcher():Dispatch(GameEventType.GuideOpenUI, GuideOpenUI.UIRecruit_PetWish)
  end
end

function UIRecruit:_FixVedioBtnState(cfg, go)
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

function UIRecruit:_CheckDownLoadPV(cfg)
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

function UIRecruit:_InitDownLoadVedioBtn(cfg)
  if cfg.PlayVideoName then
    local go = UIHelper.GetGameObject("UIDrawCardCommonVideoButton.prefab")
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

function UIRecruit:_Check4GNeedQuik(go, cfg)
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

function UIRecruit:_CheckNotWifiFirstDownLoad(go, cfg)
  local roleModule = GameGlobal.GetModule(RoleModule)
  local pstId = roleModule:GetPstId()
  local dbKey = "UIRecruitFirstDownLoadPV_" .. cfg.PlayVideoName .. pstId
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
            local dbKey2 = "UIRecruitFirstDownLoadPV_" .. cfg.PlayVideoName .. pstId
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

function UIRecruit:_InitDownLoadPvClick(go, cfg)
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
      self:CheckForUIPlayVedio(cfg.PlayVideoName, cfg.PlayVideoBg, function()
        self._blackMask:SetActive(false)
      end)
      local roleModule = GameGlobal.GetModule(RoleModule)
      local pstId = roleModule:GetPstId()
      local dbKey = "UIRecruitFirstPlayPV_" .. cfg.PlayVideoName .. pstId
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
    local dbKey = "UIRecruitFirstPlayPV_" .. cfg.PlayVideoName .. pstId
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

function UIRecruit:_AddDownLoadListener(go, cfg)
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

function UIRecruit:_RefreshFiveStarTips(poolInfo)
  if poolInfo.poolData.is_show_five_star == 1 then
    local poolId = poolInfo.poolData.prize_pool_id
    local drawTimes = self._gambleModule:GetPoolDrawTimes(poolId)
    drawTimes = drawTimes or 0
    if drawTimes < 10 then
      local hasFive = self._gambleModule:CheckAlreadyGainFiveStarCard(poolId)
      if not hasFive then
        self._fiveDrawCardTimesTip:SetActive(true)
        self._fiveDrawCardTimesText:SetText(StringTable.Get("str_draw_card_new_5star_desc", 10 - drawTimes))
        local img1 = self._fiveDrawCardTimesText.gameObject.transform:GetChild(0).gameObject
        self._starImage.transform:SetParent(img1.transform)
        self._starImage:GetComponent("RectTransform").anchoredPosition = Vector2(0, -21)
        return
      end
    end
  end
  self._fiveDrawCardTimesTip:SetActive(false)
end

function UIRecruit:_RefreshImage(poolInfo)
  local cfg = Cfg.cfg_recruit_pool_view[poolInfo.poolData.performance_id]
  if cfg.PoolImage then
    local spineCount = 0
    self:AddUICustomEventListener(UICustomUIEventListener.Get(self._fullScreenAnimBtnObj), UIEvent.Click, function(go)
    end)
    for i = 1, #self._bgPool do
      local tv = cfg.PoolImage[i]
      local pool = self._bgPool[i]
      local rect = pool:GetComponent("RectTransform")
      local imageLoader = pool:GetComponent("RawImageLoader")
      local image = pool:GetComponent("RawImage")
      local spineLoader = pool:GetComponent("SpineLoader")
      local live2dLoader
      if tv ~= nil then
        local cgType = tonumber(tv[2])
        if cgType == 1 then
          image.enabled = true
          imageLoader:LoadImage(tv[1])
          spineLoader:DestroyCurrentSpine()
          if live2dLoader then
            live2dLoader:DestroyCurrentLive2D()
          end
          rect.anchoredPosition = Vector2.zero
          rect.localScale = Vector3.one
        elseif cgType == 2 then
          spineCount = spineCount + 1
          image.enabled = false
          if live2dLoader then
            live2dLoader:DestroyCurrentLive2D()
          end
          spineLoader:LoadSpine(tv[1])
          local st = cfg.PoolSpineST[spineCount]
          rect.anchoredPosition = Vector2(st[1], st[2])
          local scale = st[3]
          rect.localScale = Vector3(scale, scale, scale)
          self:AddUICustomEventListener(UICustomUIEventListener.Get(self._fullScreenAnimBtnObj), UIEvent.Click, function(go)
            local anims = self:GetAnimNameFromPetSkinCfg(tv[1])
            if anims then
              self:PlaySpineAnimation(spineLoader, anims[1])
            end
          end)
        elseif cgType == 3 then
          spineCount = spineCount + 1
          image.enabled = false
          if live2dLoader then
            spineLoader:DestroyCurrentSpine()
            live2dLoader:LoadLive2D(tv[1])
            DynamicCG.ProcessLive2DCamSize(tv[1], live2dLoader)
            local st = cfg.PoolSpineST[spineCount]
            rect.anchoredPosition = Vector2(st[1], st[2])
            local scale = st[3]
            rect.localScale = Vector3(scale, scale, scale)
            self:AddUICustomEventListener(UICustomUIEventListener.Get(self._fullScreenAnimBtnObj), UIEvent.Click, function(go)
              local anims = self:GetAnimNameFromPetSkinCfg(tv[1])
              if anims then
                self:PlayLive2DAnimation(live2dLoader, anims[1])
              end
            end)
          else
            spineLoader:LoadSpine(tv[3])
            local st = cfg.PoolSpineST[spineCount]
            rect.anchoredPosition = Vector2(st[4], st[5])
            local scale = st[6]
            rect.localScale = Vector3(scale, scale, scale)
            self:AddUICustomEventListener(UICustomUIEventListener.Get(self._fullScreenAnimBtnObj), UIEvent.Click, function(go)
              if cfg.CgAnim then
                local anims = self:GetAnimNameFromPetSkinCfg(tv[1])
                if anims then
                  self:PlaySpineAnimation(spineLoader, anims[1])
                end
              end
            end)
          end
        end
      else
        image.enabled = false
        spineLoader:DestroyCurrentSpine()
        if live2dLoader then
          live2dLoader:DestroyCurrentLive2D()
        end
      end
    end
  else
  end
end

function UIRecruit:GetAnimNameFromPetSkinCfg(name)
  local cfg = Cfg.cfg_pet_skin({Spine = name})
  if cfg then
    return cfg[1].MainLobbySpineAnim
  end
end

function UIRecruit:PlaySpineAnimation(spineLoader, animName)
  if not spineLoader then
    return
  end
  if self._playCgAnim == true then
    return
  end
  local spineSke = spineLoader.CurrentSkeleton
  spineSke = spineSke or spineLoader.CurrentMultiSkeleton
  if spineSke then
    self._playCgAnim = true
    local entry = spineSke.AnimationState:SetAnimation(0, animName, false)
    spineSke:SetAnimMixTime(0)
    spineSke:Update(0)
    local anim = entry.Animation
    local duration = anim.Duration
    local yieldTime = math.floor(duration * 1000)
    if self._spineEvent then
      GameGlobal.Timer():CancelEvent(self._spineEvent)
      self._spineEvent = nil
    end
    self._playSpineAnim = true
    self._spineEvent = GameGlobal.Timer():AddEvent(yieldTime, function()
      self._playCgAnim = false
      local animationName = "idle"
      spineSke:SetAnimation(0, animationName, true)
      spineSke:SetAnimMixTime(0)
      spineSke:Update(0)
      self._playSpineAnim = false
    end)
  else
    Log.exception("[UIRecruit] SetAnimation while spineSke is nil")
  end
end

function UIRecruit:PlayLive2DAnimation(l2dLoder, animName)
  if not l2dLoder then
    return
  end
  if self._playSpineAnim == true then
    return
  end
  self._playCgAnim = true
  l2dLoder:PlayAnimation(animName, 0, 3, false)
  local anim
  local cam = l2dLoder.RTCam
  if cam then
    local l2dTF = cam.transform:GetChild(0)
    if l2dTF then
      require("tolua.reflection")
      tolua.loadassembly("Assembly-CSharp")
      local animationListType = typeof("AnimationClipList")
      local property = tolua.getproperty(animationListType, "Animations")
      if property then
      else
        local field = tolua.getfield(animationListType, "Animations")
        if field then
          local animationClipListCmpt = l2dTF.gameObject:GetComponent(animationListType)
          local value = field:Get(animationClipListCmpt)
          field:Destroy()
          for i = 0, value.Length - 1 do
            local l_anim = value[i]
            if l_anim.name == animName then
              anim = l_anim
              break
            end
          end
        end
      end
    end
  end
  if anim then
    local duration = anim.length
    local yieldTime = math.floor(duration * 1000)
    if self._spineEvent then
      GameGlobal.Timer():CancelEvent(self._spineEvent)
      self._spineEvent = nil
      self._playSpineAnim = false
    end
    self._playSpineAnim = true
    self._spineEvent = GameGlobal.Timer():AddEvent(yieldTime, function()
      self._playSpineAnim = false
      local animationName = "idle"
      l2dLoder:PlayAnimation(animationName, 0, 3, true)
      self._playCgAnim = false
    end)
  end
end

function UIRecruit:_RefreshTopTips(poolInfo)
  if not poolInfo then
    return
  end
  local cfg = Cfg.cfg_recruit_pool_view[poolInfo.poolData.performance_id]
  local tips = poolInfo:GetTopTips(cfg.TopTips)
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
    self.currencyMenu:SetData(normal, nil, true)
    local items = self.specailCurrency:SpawnObjects("UICurrencyItem", #specail)
    for i = 1, #specail do
      items[i]:SetAsShortForm(true)
      items[i]:SetData(specail[i], function(id, go)
        self.currencyMenu._topTipsInfo:SetData(id, go)
      end, true)
    end
  else
    self.currencyMenu:SetData(tips, nil, true)
    self.specailCurrency:SpawnObjects("UICurrencyItem", 0)
  end
end

function UIRecruit:_RefreshPoolContent(poolInfo)
  local cfg = Cfg.cfg_recruit_pool_view[poolInfo.poolData.performance_id]
  local petPositioningOffset = cfg.PetPositioningOffset
  if petPositioningOffset then
    self._petPosotioningPoolTitle:SetText(StringTable.Get(cfg.PoolTitle))
    self._PetPositioningObj:SetActive(true)
    self._DefaultPetInfoObj:SetActive(false)
    self._positioningTitleDownObj:SetActive(true)
    self._timeLimitUpImageObj:SetActive(false)
    self._cfgPosCtrl.anchoredPosition = Vector2(petPositioningOffset[1], petPositioningOffset[2])
    self._positioningDesc:SetText(StringTable.Get(cfg.PetPositioningDesc))
    if cfg.upTitleInfo then
      self._positioningTitleDownObj:SetActive(true)
      self._positioningTitleDownTitle:SetText(StringTable.Get(cfg.upTitleInfo))
      self._positioningTitleDownBg.color = self:Hex2Color(cfg.upTitleColor[1])
      self._positioningBgLayout.color = self:Hex2Color(cfg.upTitleColor[2])
      local outlineColor = self:Hex2Color(cfg.upTitleColor[3])
      self._petPosotioningPoolTitleOutline.effectColor = Color(outlineColor.r, outlineColor.g, outlineColor.b, 0.0784313725490196)
    else
      self._positioningTitleDownObj:SetActive(false)
    end
  else
    local txtTemp = StringTable.Get(cfg.PoolTitle)
    self._normalPoolTitle:SetText(txtTemp)
    self._normalPoolTitleShadow:SetText(txtTemp)
    self._PetPositioningObj:SetActive(false)
    self._DefaultPetInfoObj:SetActive(true)
    self._positioningTitleDownObj:SetActive(false)
    self._timeLimitUpImageObj:SetActive(true)
    self._cfgPosCtrl.anchoredPosition = Vector2(0, 0)
    if cfg.upTitleInfo then
      self._timeLimitUpImageObj:SetActive(true)
      self._timeLimitUpInfo:SetText(StringTable.Get(cfg.upTitleInfo))
      self._timeLimitUpInfo.gameObject:SetActive(false)
      self._timeLimitUpInfo.gameObject:SetActive(true)
      self._timeLimitUpImage.color = self:Hex2Color(cfg.upTitleColor[1])
    else
      self._timeLimitUpImageObj:SetActive(false)
    end
  end
  if string.isnullorempty(cfg.PoolContent) then
    self._poolSubtitleBgObj:SetActive(false)
  else
    self._poolSubtitleBgObj:SetActive(true)
    self._poolSubtitle:SetText(StringTable.Get(cfg.PoolContent))
  end
  if poolInfo.poolData.prize_pool_type == PrizePoolType.BEGINNER_POOL then
    self._prob:SetActive(false)
  else
    local prob_01, prob_02 = self._gambleModule:GetProbs(poolInfo.index)
    self._prob:SetActive(true)
    local probTex
    if prob_02 <= 0 and 100 <= prob_01 then
      probTex = "<color=#fff718>" .. prob_01 .. "%</color>"
    else
      probTex = "<color=#fff718>" .. prob_01 .. "%+" .. prob_02 .. "%</color>"
    end
    local tex = StringTable.Get("str_draw_card_prob_tips") .. probTex
    self._sixProb:SetText(tex)
    if self._sixProb.gameObject.transform.childCount == 0 then
      return
    end
    local img1 = self._sixProb.gameObject.transform:GetChild(0).gameObject
    local img2
    if 1 < img1.transform.childCount then
      img2 = img1.transform:GetChild(0).gameObject
    else
      img2 = UnityEngine.GameObject.Instantiate(img1, img1.transform)
    end
    img2:GetComponent("RectTransform").anchoredPosition = Vector2(img1:GetComponent("RectTransform").anchoredPosition.x, -img1:GetComponent("RectTransform").anchoredPosition.y)
    img1:GetComponent("Image").color = Color(1, 1, 1, 0)
  end
end

function UIRecruit:Hex2Color(hex)
  local default_color = Color.white
  local len = string.len(hex)
  if len ~= 7 or string.sub(hex, 1, 1) ~= "#" then
    Log.exception("[颜色格式不合法]请检查配置表数据", hex)
    return default_color
  end
  
  local function str_2_hex(str)
    return tonumber(str, 16) or 255
  end
  
  local r = str_2_hex(string.sub(hex, 2, 3))
  local g = str_2_hex(string.sub(hex, 4, 5))
  local b = str_2_hex(string.sub(hex, 6, 7))
  return Color(r / 255, g / 255, b / 255)
end

function UIRecruit:_CountDown(poolInfo)
  local loginModule = GameGlobal.GetModule(LoginModule)
  local cfg = Cfg.cfg_gamble_pool_putaway[poolInfo.poolData.performance_id]
  local now = GetSvrTimeNow()
  local time = 0
  local closeType2 = poolInfo.poolData.close_condition2
  if closeType2 and 0 < closeType2 then
    time = closeType2
  else
    time = poolInfo.poolData.extend_data
  end
  local sec = math.max(time - now, 0)
  if cfg and cfg.OpenTimeInterval then
    for _, timePairArray in pairs(cfg.OpenTimeInterval) do
      local startTime = loginModule:GetTimeStampByTimeStr(timePairArray[1], Enum_DateTimeZoneType.E_ZoneType_GMT)
      local endTime = loginModule:GetTimeStampByTimeStr(timePairArray[2], Enum_DateTimeZoneType.E_ZoneType_GMT)
      if now < endTime and now > startTime then
        sec = endTime - now
      end
    end
  end
  local timeStr = UIActivityHelper.GetFormatTimerStr(sec)
  if self._timeStr ~= timeStr then
    self._timeStr = timeStr
    local str = StringTable.Get("str_draw_card_pool_end_time") .. timeStr
    self._closeCondition:SetText(str)
  end
end

function UIRecruit:_RefreshDrawBtns(poolInfo)
  if not poolInfo then
    return
  end
  if poolInfo:CanSingleDraw() then
    local singleIconCfg = Cfg.cfg_top_tips[poolInfo.singleMat]
    if not singleIconCfg then
      Log.exception("cfg_top_tips中找不到配置:", poolInfo.singleMat)
    end
    local singleIcon = singleIconCfg.Icon
    self._singleItemIcon.sprite = self._commonAtlas:GetSprite(singleIcon)
    local haveSingle = self._itemModule:GetItemCount(poolInfo.singleMat)
    local isEnoughSingle = haveSingle >= poolInfo.singlePrice
    local color, dicountPriceColor
    if isEnoughSingle then
      color = Color.white
      dicountPriceColor = Color(0.027450980392156862, 0.6274509803921569, 0.8588235294117647)
    else
      color = Color(0.9764705882352941, 0.21176470588235294, 0.21176470588235294)
      dicountPriceColor = Color(0.9764705882352941, 0.21176470588235294, 0.21176470588235294)
    end
    self._singleItemCount:SetText("x" .. poolInfo.singlePrice)
    self._singleItemCount.color = color
    self._singleNowPrice.color = dicountPriceColor
    if poolInfo.singleDiscount then
      self._singleItemCount.gameObject:SetActive(false)
      self._singleDiscount:SetActive(true)
      local discount = poolInfo.singleDiscount
      local discountText = string.format("<size=36>%s</size>", StringTable.Get("str_pay_discount_percent", discount))
      self._singleDiscountInfo:SetText(discountText)
      self._singleOriPrice:SetText(poolInfo.singleOriPrice)
      self._singleNowPrice:SetText("x" .. poolInfo.singlePrice)
    else
      self._singleItemCount.gameObject:SetActive(true)
      self._singleItemCount:SetText("x" .. poolInfo.singlePrice)
      self._singleDiscount:SetActive(false)
    end
  end
  if poolInfo:CanMultipleDraw() then
    local multipleIconCfg = Cfg.cfg_top_tips[poolInfo.multipleMat]
    if not multipleIconCfg then
      Log.exception("cfg_top_tips中找不到配置:", poolInfo.singleMat)
    end
    local multipleIcon = multipleIconCfg.Icon
    self._multipleItemIcon.sprite = self._commonAtlas:GetSprite(multipleIcon)
    self._multipleItemCount.color = Color(0.19215686274509805, 0.19215686274509805, 0.19215686274509805)
    self._multipleBtnText.color = Color(0.19215686274509805, 0.19215686274509805, 0.19215686274509805)
    self._multipleNowPrice.color = Color(0.027450980392156862, 0.6274509803921569, 0.8588235294117647)
    self._multipleItemIcon.color = Color.white
    local timesEnough = true
    local closeType = poolInfo.poolData.close_type
    if closeType == PrizePoolOpenCloseType.PLAY_TIMES_CONDITON and poolInfo.poolData.extend_data < poolInfo.poolData.multiple_shake_times then
      local color = Color(0.39215686274509803, 0.39215686274509803, 0.39215686274509803)
      self._multipleItemCount.color = color
      self._multipleBtnText.color = color
      self._multipleItemIcon.color = Color(1, 1, 1, 0.4)
      timesEnough = false
    end
    local mulitMat = poolInfo.multipleMat
    local mulitPrice = poolInfo.multiplePrice
    local haveMulti = self._itemModule:GetItemCount(mulitMat)
    local isEnoughMulti = mulitPrice <= haveMulti
    if isEnoughMulti then
    else
      local color = Color(0.9764705882352941, 0.21176470588235294, 0.21176470588235294)
      self._multipleItemCount.color = color
      self._multipleNowPrice.color = color
    end
    if poolInfo.multipleDiscount then
      self._multipleItemCount.gameObject:SetActive(false)
      self._multipleDiscount:SetActive(true)
      local discount = poolInfo.multipleDiscount
      local discountText = string.format("<size=36>%s</size>", StringTable.Get("str_pay_discount_percent", discount))
      self._multipleDiscountInfo:SetText(discountText)
      self._multipleOriPrice:SetText(poolInfo.multipleOriPrice)
      self._multipleNowPrice:SetText("x" .. poolInfo.multiplePrice)
    else
      self._multipleItemCount.gameObject:SetActive(true)
      self._multipleItemCount:SetText("x" .. poolInfo.multiplePrice)
      self._multipleDiscount:SetActive(false)
    end
  end
  if poolInfo:CanSingleDraw() and poolInfo:CanMultipleDraw() then
    self._singleDraw:SetActive(true)
    self._multipleDraw:SetActive(true)
    self._singleDrawRect.anchoredPosition = Vector2(-698, 110)
    self._multipleDrawRect.anchoredPosition = Vector2(-252, 109)
  elseif not poolInfo:CanMultipleDraw() then
    self._singleDraw:SetActive(true)
    self._singleDrawRect.anchoredPosition = Vector2(-252, 110)
    self._multipleDraw:SetActive(false)
  elseif not poolInfo:CanSingleDraw() then
    self._singleDraw:SetActive(false)
    self._multipleDrawRect.anchoredPosition = Vector2(-252, 110)
    self._multipleDraw:SetActive(true)
  end
end

function UIRecruit:_RefreshBGM(poolInfo)
  local viewID = poolInfo.poolData.performance_id
  local cfg = Cfg.cfg_recruit_pool_view[viewID]
  if cfg and cfg.bgmID then
    AudioHelperController.PlayBGM(cfg.bgmID, AudioConstValue.BGMCrossFadeTime)
  else
    AudioHelperController.PlayBGM(self._lastBGMResName, AudioConstValue.BGMCrossFadeTime)
  end
  if self._playingVoiceID then
    CriAudioManager.Instance:StopCriVoice(self._playingVoiceID, 0)
  end
  if cfg and cfg.audioID then
    local audioid = cfg.audioID
    local l_cfg_adx2_audio = Cfg.cfg_adx2_audio[audioid]
    if l_cfg_adx2_audio == nil then
      Log.error("###[lxs] audioid: ", audioid, "not find res")
      return
    end
    local l_cuesheet_id = l_cfg_adx2_audio.CueSheetID
    local audioType = AudioHelperController.GetPetAudioTypeByCueSheetID(l_cuesheet_id)
    if audioType == AudioLanguageType.Zh and l_cfg_adx2_audio.ZhCueSheetID then
      l_cuesheet_id = l_cfg_adx2_audio.ZhCueSheetID
    end
    local l_cfg_cuesheet = Cfg.cfg_cuesheet[l_cuesheet_id]
    if l_cfg_cuesheet == nil then
      Log.error("###[lxs] cuesheet_id: ", l_cuesheet_id, "not find audioid:", audioid)
      return
    end
    local l_strAcbName
    if audioType == AudioLanguageType.Zh then
      l_strAcbName = l_cfg_cuesheet.ZhAcbFileName
    elseif audioType == AudioLanguageType.Jp then
      l_strAcbName = l_cfg_cuesheet.JpAcbFileName
      if not l_strAcbName then
        Log.debug("###[UIDrawCardController] not jp voice , id :", l_cuesheet_id)
        l_strAcbName = l_cfg_cuesheet.ZhAcbFileName
      end
    end
    local cueName = l_cfg_adx2_audio.CueName
    if audioType == AudioLanguageType.Zh and l_cfg_adx2_audio.ZhCueName then
      cueName = l_cfg_adx2_audio.ZhCueName
    end
    self._playingVoiceID = CriAudioManager.Instance:PlayUIVoiceCue(l_strAcbName, cueName, true)
  end
end

function UIRecruit:_RefreshPetWidget(poolInfo)
  local count = 0
  local cfg = Cfg.cfg_recruit_pool_view[poolInfo.poolData.performance_id]
  if cfg.PetWidget and 0 < #cfg.PetWidget then
    count = #cfg.PetWidget
  end
  local widgets = self._petWidget:SpawnObjects("UIDrawCardPetInfoLoader", count)
  for i = 1, count do
    local petWidgetCfg = cfg.PetWidget[i]
    widgets[i]:SetData(petWidgetCfg.id, petWidgetCfg, function(petID)
      self:ShowDialog("UIShopPetDetailController", petID)
    end)
  end
end

function UIRecruit:_RefreshPetInfo(poolInfo)
end

function UIRecruit:_RefreshCloseCondition(poolInfo)
  local count = 0
  local cfg = Cfg.cfg_recruit_pool_view[poolInfo.poolData.performance_id]
  if cfg.PetWidget and 0 < #cfg.PetWidget then
    count = #cfg.PetWidget
  end
  local closeType = poolInfo.poolData.close_type
  local closeType2 = poolInfo.poolData.close_condition2
  local countdwon = false
  self._newPlayerLastTimeObj:SetActive(false)
  if closeType == PrizePoolOpenCloseType.PLAY_TIMES_CONDITON then
    if closeType2 and 0 < closeType2 then
      countdwon = true
      self._closeConditionObj:SetActive(true)
    else
      countdwon = false
      self._closeConditionObj:SetActive(false)
      self._newPlayerLastTimeObj:SetActive(true)
    end
    local lastTimeTxt = StringTable.Get("str_draw_card_newplayer_left_times", poolInfo.poolData.extend_data)
    self._newPlayerLastTime:SetText(lastTimeTxt)
  elseif closeType == PrizePoolOpenCloseType.PERMANENT then
    self._closeConditionObj:SetActive(false)
    countdwon = false
  elseif closeType == PrizePoolOpenCloseType.TIME_CONDITON then
    countdwon = true
    self._closeConditionObj:SetActive(true)
  end
  if self._countdownTimer then
    GameGlobal.Timer():CancelEvent(self._countdownTimer)
    self._countdownTimer = nil
  end
  if countdwon then
    self._timeStr = nil
    self:_CountDown(poolInfo)
    self._countdownTimer = GameGlobal.Timer():AddEventTimes(30000, TimerTriggerCount.Infinite, function()
      self:_CountDown(poolInfo)
    end)
  end
end

function UIRecruit:Recruit(data, type)
  self:_CheckNotIncluePool(data.index, function()
    self:ShowDialog("UIRecruitConfirm", data, type)
  end)
end

function UIRecruit:CurrentIdx()
  return self._currentIdx
end

function UIRecruit:SwitchToPool(idx)
  self:_RefreshByIdx(idx)
end

function UIRecruit:IsTheFirst()
  return self._currentIdx <= 1
end

function UIRecruit:IsTheLast()
  return self._currentIdx >= #self._poolsUIData
end

function UIRecruit:SetPoolPetLogo(idx)
  local pool = self._poolsUIData[idx]
  local cfg = Cfg.cfg_recruit_pool_view[pool.poolData.performance_id]
  if cfg.PetWidget and #cfg.PetWidget > 0 then
    for i, widget in ipairs(cfg.PetWidget) do
      self._petEftLogos[i]:LoadImage(widget.id .. "_logo")
    end
  end
end

function UIRecruit:GetPoolPetCount(idx)
  local nextPool = self._poolsUIData[idx]
  local cfg = Cfg.cfg_recruit_pool_view[nextPool.poolData.performance_id]
  if cfg.PetWidget and #cfg.PetWidget > 0 then
    return #cfg.PetWidget
  else
    return 0
  end
end

function UIRecruit:PlayThumbItemFadeinAnim(idx)
  self._thumbItems[idx]:PlayFadeInAnim()
end

function UIRecruit:PlayThumbItemFadeoutAnim(idx)
  self._thumbItems[idx]:PlayFadeOutAnim()
end

function UIRecruit:GuideAppraise()
  if IsAndroid() then
    return
  end
  local isDrawCard = self._gambleModule:Context():GetStateDrawCard()
  if isDrawCard then
    local maxStar, maxStarId
    maxStar, maxStarId = self._gambleModule:Context():GetMaxStarPetId()
    local isHaveMaxStar = self._gambleModule:Context():GetHaveMaxStarPet()
    local idx, type = self._gambleModule:Context():GetPoolIDAndType()
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

function UIRecruit:PopupGuide(dbKey, dbResultKey)
  if IsPc() then
    return
  end
  local char_mod = self:GetModule(RoleModule)
  if char_mod:CanStoreReview() == false then
    return
  end
  PopupManager.Alert("UICommonMessageBox", PopupPriority.Normal, PopupMsgBoxType.OkCancel, StringTable.Get("str_common_guide_appraise_title"), StringTable.Get("str_common_guide_appraise_context"), function()
    local gv = HelperProxy:GetInstance():GetGameVersion()
    local app_store_id = "6443444750"
    self.srm = GameStore.StoreReviewManager:New()
    self.srm:RequestSystemBasedReview(app_store_id)
    LocalDB.SetInt(dbResultKey, 1)
  end, nil, function()
    LocalDB.SetInt(dbResultKey, -1)
  end, nil)
  LocalDB.SetInt(dbKey, math.floor(self._svrTimeModule:GetServerTime() * 0.001))
end

function UIRecruit:_OnItemChanged()
  local awardPools = self._gambleModule:GetPrizePools()
  self._poolsUIData = {}
  for idx, pool in ipairs(awardPools) do
    local uiData = UIDrawCardPoolInfo:New(pool, idx)
    self._poolsUIData[idx] = uiData
  end
  local poolInfo = self._poolsUIData[self._currentIdx]
  self:_RefreshTopTips(poolInfo)
  self:_RefreshDrawBtns(poolInfo)
  if self._questComponent then
    self._awardButton:RefreshInfo()
  end
end

function UIRecruit:OnePetPoolDetailBtnOnClick()
  local poolInfo = self._poolsUIData[self._currentIdx]
  self:ShowDialog("UIDrawCardAwardPoolDetailController", poolInfo)
end

function UIRecruit:MorePetPoolDetailBtnOnClick()
  local poolInfo = self._poolsUIData[self._currentIdx]
  self:ShowDialog("UIDrawCardAwardPoolDetailController", poolInfo)
end

function UIRecruit:OnePetIconOnClick()
  local poolData = self._poolsUIData[self._currentIdx].poolData
  local cfg = Cfg.cfg_recruit_pool_view[poolData.performance_id]
  self:ShowDialog("UIShopPetDetailController", cfg.PetWidget[1].id)
end

function UIRecruit:SingleDrawOnClick()
  self._gambleModule:OptionalPoolAlert(self._currentIdx, function()
    self:BtnWishOnClick(nil)
  end, function()
    local poolInfo = self._poolsUIData[self._currentIdx]
    self:Recruit(poolInfo, ShakeType.SHAKE_ONCE)
  end)
end

function UIRecruit:MultipleDrawOnClick()
  self._gambleModule:OptionalPoolAlert(self._currentIdx, function()
    self:BtnWishOnClick(nil)
  end, function()
    local poolInfo = self._poolsUIData[self._currentIdx]
    self:Recruit(poolInfo, ShakeType.SHAKE_MULTIPLE)
  end)
end

function UIRecruit:PetShopBtnOnClick()
  self:ShowDialog("UIShopController", 2, 3)
end

function UIRecruit:NotIncludeBtnOnClick()
  local poolInfo = self._poolsUIData[self._currentIdx]
  local times = self._gambleModule:GetNotIncludePetPoolGambleTimes(poolInfo.index)
  if -1 < times then
    local petList = self._gambleModule:GetNotIncludePetPool(poolInfo.index)
    if not petList or #petList == 0 then
    else
      if times == 0 then
        self:ShowDialog("UIUnObtainSixPetController", petList)
      else
      end
    end
  else
  end
end

function UIRecruit:GetOneBtn(index)
  return self:GetGameObject("SingleDrawBtn")
end

function UIRecruit:GetTopButtonBack()
  return self.topButtonWidget and self.topButtonWidget:GetGameObject("ButtonBack")
end

function UIRecruit:_RefreshPetWish(poolInfo)
  local module = self:GetModule(GambleModule)
  local idOptional = module:GetCfgOptionalPoolId(poolInfo.index)
  local cfgOptional = Cfg.cfg_optional_pool[idOptional]
  local showRed = self._thumbItems[poolInfo.index]:PublicCheckWishRed()
  self._uiWish.gameObject:SetActive(cfgOptional ~= nil)
  self._uiWishRed.gameObject:SetActive(showRed)
end

function UIRecruit:BtnWishOnClick(go)
  local module = self:GetModule(GambleModule)
  local poolInfo = self._poolsUIData[self._currentIdx]
  local param = {
    indexPool = self._currentIdx,
    idRecruit = poolInfo.poolData.performance_id,
    idOptional = module:GetCfgOptionalPoolId(poolInfo.index)
  }
  self:ShowDialog("UIRecruitWish", param)
end

function UIRecruit:UpdateDrawCardRed()
  for k, v in pairs(self._thumbItems) do
    v:PublicCheckWishRed()
  end
  local showRed = self._thumbItems[self._currentIdx]:PublicCheckWishRed()
  self._uiWishRed.gameObject:SetActive(showRed)
end

function UIRecruit:_RefreshNotIncludeTip(poolInfo)
  local cfg = Cfg.cfg_recruit_pool_view[poolInfo.poolData.performance_id]
  if cfg.extendBtn then
    local idx = poolInfo.index
    local times = self._gambleModule:GetNotIncludePetPoolGambleTimes(idx)
    if -1 < times then
      local petList = self._gambleModule:GetNotIncludePetPool(idx)
      if not petList or #petList == 0 then
        self._notIncludeBtn:SetActive(false)
        self._notIncludeTip:SetActive(true)
        self._notIncludeTipText:SetText(StringTable.Get("str_draw_card_btn_has_all"))
      elseif times == 0 then
        self._notIncludeBtn:SetActive(true)
        self._notIncludeTip:SetActive(false)
      else
        self._notIncludeBtn:SetActive(false)
        self._notIncludeTip:SetActive(true)
        self._notIncludeTipText:SetText(StringTable.Get("str_draw_card_btn_has_get"))
      end
      return
    end
  end
  self._notIncludeBtn:SetActive(false)
  self._notIncludeTip:SetActive(false)
end

function UIRecruit:_CheckNotIncluePool(index, onConfirm)
  if not self._gambleModule.hasShowNotIncluePedPoolTips then
    local times = self._gambleModule:GetNotIncludePetPoolGambleTimes(index)
    local strTips
    if 0 < times then
      strTips = StringTable.Get("str_draw_card_pop_has_get")
    elseif times == 0 then
      local petList = self._gambleModule:GetNotIncludePetPool(index)
      if not petList or #petList == 0 then
        strTips = StringTable.Get("str_draw_card_pop_has_all")
      end
    end
    if strTips then
      self._gambleModule.hasShowNotIncluePedPoolTips = true
      PopMsgBox(strTips, onConfirm)
      return
    end
  end
  onConfirm()
end

function UIRecruit:BtnShopOnClick()
  GameGlobal.UIStateManager():ShowDialog("UIShopController", nil, ShopMainTabType.Gift)
end
