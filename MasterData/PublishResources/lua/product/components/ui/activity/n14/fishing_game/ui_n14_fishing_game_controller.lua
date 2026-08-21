_class("UIN14FishingGameController", UIController)
UIN14FishingGameController = UIN14FishingGameController

function UIN14FishingGameController:OnShow(uiParams)
  self._stage_id = uiParams[1]
  self._component = uiParams[2]
  self._componentInfo = uiParams[3]
  self._lastBGMResName = uiParams[4]
  self._callback = uiParams[5]
  self._cfg_stage = Cfg.cfg_component_mini_game_mission[self._stage_id]
  local guideModule = GameGlobal.GetModule(GuideModule)
  local guideDone = guideModule:IsGuideDone(6025)
  if not guideDone then
    self._cfg_fishgame_inner = Cfg.cfg_fishing_game_inner_guide[1]
  else
    self._cfg_fishgame_inner = Cfg.cfg_fishing_game_inner({
      ID = self._cfg_stage.ID
    })[1]
  end
  self._cfg_minigame = Cfg.cfg_fishing_minigame[1]
  self._bonus = self._cfg_minigame.BaseScoreMult
  self._baseFishScore = self._cfg_minigame.BaseFishScore
  self._orderFinishBouns = self._cfg_minigame.OrderFinishAddScoreMult
  self._fishingSuccessAddScoreMult = self._cfg_minigame.FishingSuccessAddScoreMult
  self._cathedFishDisappearTime = self._cfg_minigame.CatchedFishDisappearTime
  self._netRotateAngle = self._cfg_minigame.NetDefaultRotateAngle
  self._camera = GameGlobal.UIStateManager():GetControllerCamera(self:GetName())
  self:GenerateGameData()
  self:InitWidget()
  self:_OnValue()
  self:AttachEvent(GameEventType.ShowGuideStep, self._ShowGuideStep)
end

function UIN14FishingGameController:OnHide()
  self._timerHolder = nil
  self._spineTimeHolder = nil
  self._catchedFishDisTimeHolder = nil
  self._catchingFishs = nil
end

function UIN14FishingGameController:Constructor()
  self._roleModule = self:GetModule(RoleModule)
  self._guideModule = self:GetModule(GuideModule)
  self._gameState = FishingGameState.Start
  self._baseFishScore = 0
  self._score = 0
  self._currentAddScore = 0
  self._tempScore = 0
  self._tempScoreDelta = 1
  self._skillPoint = 0
  self._skillPointDelta = 0
  self._skillCanStartCurrentPoint = 0
  self._skillTime = 0
  self._clickInterval = 0
  self._elapseDeltaTime = 0
  self._elapseTime = 0
  self._playstory = false
  self._currentOrderIndex = 1
  self._currentFishIndex = 1
  self._currentOrderTime = 0
  self._currentGenerateFishTime = 0
  self._orangeColor = Color(1.0, 0.5254901960784314, 0)
  self._isFirstInitOrder = true
  self._fishList = {}
  self._bubblePool = {}
  self._currentPufferTime = 0
  self._currentOctopusTime = 0
  self._showOctopusEff = false
  self._showPufferEff = false
  self._canExit = false
  self._catchedFishIdList = {}
  self._orderList = {}
  self._rawImageName = {
    "n14_fish_icon_shou",
    "n14_fish_icon_shou1"
  }
  self._isRefreshing = false
  self._guideing = false
  self._handOffect = nil
end

function UIN14FishingGameController:InitWidget()
  self._pause = self:GetGameObject("Puase")
  self._start = self:GetGameObject("Start")
  self._countDown = self:GetUIComponent("UILocalizedTMP", "CountDown")
  self._finish = self:GetGameObject("Finish")
  self._timeValue = self:GetUIComponent("UILocalizationText", "TimeValue")
  self._scoreValue = self:GetUIComponent("UILocalizationText", "ScoreValue")
  self._bounsValue = self:GetUIComponent("UILocalizationText", "BounsValue")
  self._totalScore = self:GetUIComponent("UILocalizationText", "TotalScore")
  self._skillObj = self:GetGameObject("Skill")
  self._gameStateAnimation = self:GetUIComponent("Animation", "GameState")
  self._scoreAnimation = self:GetUIComponent("Animation", "ScoreEff")
  self._skillAnimation = self:GetUIComponent("Animation", "SKillBtn")
  self._gameStateskillAnimation = self:GetUIComponent("Animation", "Center_Skill")
  self._list = self:GetUIComponent("UIDynamicScrollView", "OrderList")
  self._lineList = self:GetUIComponent("UIDynamicScrollView", "LineList")
  self._roleSpine = self:GetUIComponent("SpineLoader", "RoleSpine")
  self._cdAnimation = self:GetUIComponent("Animation", "Start")
  self._orderCountDownImg = self:GetUIComponent("Image", "CountDownImg")
  self._orderCountDownImgTrans = self:GetUIComponent("RectTransform", "CountDownImg")
  self._orderCountDownImgBgTrans = self:GetUIComponent("RectTransform", "CountDownImgBg")
  self._fishingNetHandle = self:GetGameObject("FishingNetHandleImg")
  self._fishingNetTrans = self:GetUIComponent("RectTransform", "FishingNet")
  self._fishingNetHandleClone = self:GetGameObject("FishingNetHandleTransClone")
  self._fishingNet = self:GetUIComponent("RectTransform", "FishingNetImg")
  self._fishingNetRawImage = self:GetUIComponent("RawImageLoader", "FishingNet")
  self._bornPos = self:GetUIComponent("UISelectObjectPath", "FishBornPos")
  self._shawdowLayerPos = self:GetUIComponent("UISelectObjectPath", "FishShadowLayerPos")
  self._poolBg = self:GetUIComponent("RectTransform", "poolBg")
  self._skillPointImg = self:GetUIComponent("Image", "SkillPoint")
  self._bubblePoolTrans = self:GetUIComponent("RectTransform", "bubblePool")
  self._octopusEff = self:GetGameObject("OctopusEff")
  self._layerPool = self:GetGameObject("FishLayerPos")
  self._skillSpine = self:GetGameObject("SkillSpine")
  self._gamePauseText = self:GetUIComponent("UILocalizedTMP", "GamePauseText")
  self._gameStartText = self:GetUIComponent("UILocalizedTMP", "GameStartText")
  self._gameEndText = self:GetUIComponent("UILocalizedTMP", "GameEndText")
  self._currentFishSpine = self:GetUIComponent("SpineLoader", "CurrentFish")
  self._currentCatchedFishPool = self:GetUIComponent("UISelectObjectPath", "CurrentFish")
  self._currentCatchedFishObj = self:GetGameObject("CurrentFish")
  self._continueClickText = self:GetUIComponent("UILocalizedTMP", "ClickText")
  self._fishingNetGuide = self:GetGameObject("FishingNetGuide")
  self._skillPointMaterial = self._skillPointImg.material
  self._poolSize = {
    self._poolBg.sizeDelta.y / 2 - 50,
    -self._poolBg.sizeDelta.y / 2,
    self._poolBg.sizeDelta.x / 2 - 100,
    -self._poolBg.sizeDelta.x / 2 + 100
  }
  self._countDownWidth = self._orderCountDownImgBgTrans.sizeDelta.x
  self._countDownHeight = self._orderCountDownImgBgTrans.sizeDelta.y
  self._skillReady = self:GetGameObject("SkillReady")
  self._skillkanban = self:GetGameObject("Kanban")
  self._eff = self:GetGameObject("CatchEff")
  self._effectEndPos = self:GetGameObject("ScoreValue").transform.position
  self._effectOctopusEffAni = self:GetUIComponent("Animation", "OctopusEff")
  local etl = UICustomUIEventListener.Get(self._fishingNet.gameObject)
  self._pathValues = {
    self:GetGameObject("path1").transform.position,
    self:GetGameObject("path2").transform.position,
    self:GetGameObject("path3").transform.position
  }
  self._uieffClick = self:GetGameObject("uieffClick")
  self._scoreEffect = self:GetGameObject("ScoreEffect")
  self:AddUICustomEventListener(etl, UIEvent.BeginDrag, function(pointData)
    self:BeginDragFishingNet(pointData)
  end)
  self:AddUICustomEventListener(etl, UIEvent.Drag, function(pointData)
    self:OnDragFishingNet(pointData)
  end)
  self:AddUICustomEventListener(etl, UIEvent.EndDrag, function(pointData)
    self:EndDragFishingNet(pointData)
  end)
  etl = UICustomUIEventListener.Get(self._poolBg.gameObject)
  self:AddUICustomEventListener(etl, UIEvent.Click, function(pointData)
    self:ShowClickEff(pointData)
  end)
  if not EDITOR then
    self:AddUICustomEventListener(etl, UIEvent.ApplicationFocus, function(b)
      if not b then
        etl.IsDragging = false
        self._fishingNetHandle.transform.position = self._fishingNetOriginPos
        GameGlobal.UIStateManager():UnLock("FishingLock")
      end
    end)
  end
  self._fishingNetOriginPos = self._fishingNetHandle.transform.position
  self:GenerateLayerPool()
  self:InitializationOriginAllFish()
  self:SetFontMat()
  self:FishNetCloneShow(false)
  self._timerHolder = UITimerHolder:New()
  self._spineTimeHolder = UITimerHolder:New()
  self._catchedFishDisTimeHolder = UITimerHolder:New()
  self._fishingNetRawImage:LoadImage(self._rawImageName[1])
  self._fishingNet.localScale = Vector3(1, 1, 1) * self._cfg_minigame.FishingNetModelScaleMult
  self._fishingNet.anchoredPosition = self._fishingNet.anchoredPosition + Vector2(self._cfg_minigame.FishNetOffset[1], self._cfg_minigame.FishNetOffset[2])
end

function UIN14FishingGameController:SetFontMat()
  local res = ResourceManager:GetInstance():SyncLoadAsset("uieff_n14_fishing_game_pause.mat", LoadType.Mat)
  if not res then
    return
  end
  local obj = res.Obj
  self._gameStartText.fontMaterial = obj
  self._gameEndText.fontMaterial = obj
  self._gamePauseText.fontMaterial = obj
  self._countDown.fontMaterial = obj
  self._continueClickText.fontMaterial = obj
end

function UIN14FishingGameController:GenerateGameData()
  self._skillPoint = self._cfg_minigame.SkillNeedCount
  self._clickInterval = self._cfg_minigame.SkillClickInterval
  self._skillTime = self._cfg_minigame.SkillTime
  self.fishPoolInfo = FishingGameLevelInfo:New(self._cfg_fishgame_inner.FishInfo, self._cfg_fishgame_inner.OrderFishInfo, self._cfg_fishgame_inner.TotalFish, 0, 0)
  self._currentOrder = self.fishPoolInfo.orderDetailInfo[self._currentOrderIndex]
end

function UIN14FishingGameController:InitOrderScrollView()
  if self._isFirstInitOrder then
    self._list:InitListView(self._currentOrder.orderCount, function(scrollView, index)
      return self:_InitOrderList(scrollView, index)
    end)
    self._lineList:InitListView(self._currentOrder.orderCount - 1, function(scrollView, index)
      return self:_InitOrderLineList(scrollView, index)
    end)
  else
    self:_RefreshOrderList()
  end
  self._isFirstInitOrder = false
end

function UIN14FishingGameController:_RefreshOrderList()
  local contentPos = self._list.ScrollRect.content.localPosition
  self._list:SetListItemCount(self._currentOrder.orderCount)
  self._list.ScrollRect.content.localPosition = contentPos
  self:ClearOrderList()
  self._list:RefreshAllShownItem()
  local contentPos = self._lineList.ScrollRect.content.localPosition
  self._lineList:SetListItemCount(self._currentOrder.orderCount - 1)
  self._lineList:MovePanelToItemIndex(0, 0)
  self._lineList.ScrollRect.content.localPosition = contentPos
  self._lineList:RefreshAllShownItem()
end

function UIN14FishingGameController:_InitOrderLineList(scrollView, index)
  if index < 0 then
    return nil
  end
  local item = scrollView:NewListViewItem("RowItem")
  local rowPool = self:GetUIComponentDynamic("UISelectObjectPath", item.gameObject)
  if item.IsInitHandlerCalled == false then
    item.IsInitHandlerCalled = true
    rowPool:SpawnObjects("UIN14FishingGameOrderLine", 1)
  end
  local rowList = rowPool:GetAllSpawnList()
  local itemWidget = rowList[1]
  if itemWidget then
    local itemIndex = index + 1
    if itemIndex > self._currentOrder.orderCount then
      itemWidget:GetGameObject():SetActive(false)
    else
      self:_RefreshLineItemInfo(itemWidget, itemIndex, itemIndex < self._currentFishIndex, itemIndex == #self._currentOrder.detailInfo)
    end
  end
  UIHelper.RefreshLayout(item:GetComponent("RectTransform"))
  return item
end

function UIN14FishingGameController:_RefreshLineItemInfo(itemWidget, itemIndex, isFinish, isEnd)
  itemWidget:SetData(itemIndex, isFinish, isEnd)
end

function UIN14FishingGameController:_InitOrderList(scrollView, index)
  if index < 0 then
    return nil
  end
  local item = scrollView:NewListViewItem("RowItem")
  local rowPool = self:GetUIComponentDynamic("UISelectObjectPath", item.gameObject)
  if item.IsInitHandlerCalled == false then
    item.IsInitHandlerCalled = true
    rowPool:SpawnObjects("UIN14FishingGameOrderItem", 1)
  end
  local rowList = rowPool:GetAllSpawnList()
  local itemWidget = rowList[1]
  self:AddOrderListItem(itemWidget)
  if itemWidget then
    local itemIndex = index + 1
    if itemIndex > self._currentOrder.orderCount then
      itemWidget:GetGameObject():SetActive(false)
    else
      self:RefreshOrderItemInfo(itemWidget, itemIndex, itemIndex == self._currentFishIndex, itemIndex < self._currentFishIndex, itemIndex == #self._currentOrder.detailInfo)
    end
  end
  UIHelper.RefreshLayout(item:GetComponent("RectTransform"))
  return item
end

function UIN14FishingGameController:RefreshOrderItemInfo(itemWidget, index, isCurrent, isFinish, isLast)
  itemWidget:SetData(index, self._currentOrder.detailInfo[index], isCurrent, isFinish, isLast)
end

function UIN14FishingGameController:_OnValue()
  self._timeValue:SetText(self:ParseTime(self._cfg_stage.Time))
  self._scoreValue:SetText(self._score)
  self._bounsValue:SetText(self._bonus)
  self._totalScore:SetText(self._score)
  self._roleSpine:LoadSpine(self._cfg_fishgame_inner.RoleSpine)
  self._roleSpine:SetAnimation(0, self._cfg_fishgame_inner.RoleNormalAnimName, true)
  self._fishingNetHandle.transform.localEulerAngles = Vector3(0, 0, -self._netRotateAngle)
  self._fishingNetHandleClone.transform.localEulerAngles = Vector3(0, 0, -self._netRotateAngle)
  self._currentCatchedFishObj.transform.localEulerAngles = Vector3(0, 0, self._netRotateAngle)
  self:_RefreshSkillEffect(0)
  self:_StartCountDown()
  self:LoadCatchedFishSpine()
end

function UIN14FishingGameController:LoadCatchedFishSpine()
  self._currentCatchedFishes = self._currentCatchedFishPool:SpawnObjects("UIN14FishingGameCatchedFish", 7)
  for i = 1, table.count(self._currentCatchedFishes) do
    self._currentCatchedFishes[i]:SetData(i)
  end
end

function UIN14FishingGameController:OnUpdate(deltaTimeMS)
  if self._guideing and not self:_Guideing() then
    self._guideing = false
    self:_WhenGuideDone()
  end
  self:_UpdateTime(deltaTimeMS)
  self:_UpdateOrderTime(deltaTimeMS)
  self:_UpdateFishPos(deltaTimeMS)
  self:_UpdateGenerateFishTime(deltaTimeMS)
  self:_UpdateFishingSkillTime(deltaTimeMS)
  self:_UpdateObstacleEff(deltaTimeMS)
end

function UIN14FishingGameController:OrderFinish()
  self._currentOrderTime = 0
  local orderCount = #self.fishPoolInfo.orderDetailInfo
  self._currentFishIndex = 1
  if orderCount <= self._currentOrderIndex then
    self.fishPoolInfo:GenerateOrderInfo(self.fishPoolInfo.orderInfo)
  end
  self._currentOrderIndex = self._currentOrderIndex % orderCount + 1
  self._currentOrder = self.fishPoolInfo.orderDetailInfo[self._currentOrderIndex]
  self:_RefreshOrderList()
end

function UIN14FishingGameController:_UpdateGenerateFishTime(ms)
  if (self._gameState == FishingGameState.Playing or self._gameState == FishingGameState.Skill) and self.fishPoolInfo:PoolIsFull() == false then
    self._currentGenerateFishTime = self._currentGenerateFishTime + ms * 0.001
    if self.fishPoolInfo:PoolIsEmpty() then
      if self._currentGenerateFishTime > self._cfg_minigame.PoolEmptyRefreshFishTime then
        self._currentGenerateFishTime = 0
        self:GenerateFish()
      end
      self._currentGenerateFishTime = 0
      self:GenerateFish()
    elseif self._gameState == FishingGameState.Skill then
      if self._currentGenerateFishTime > self._cfg_fishgame_inner.SupplyInterval / self._cfg_minigame.SkillSupplyIntervalMult then
        self._currentGenerateFishTime = 0
        self:GenerateFish()
      end
    elseif self._currentGenerateFishTime > self._cfg_fishgame_inner.SupplyInterval then
      self._currentGenerateFishTime = 0
      self:GenerateFish()
    end
  end
end

function UIN14FishingGameController:_UpdateOrderTime(ms)
  if self:_Guideing() then
    return
  end
  if self._gameState == FishingGameState.Playing or self._gameState == FishingGameState.Skill then
    self._currentOrderTime = self._currentOrderTime + ms * 0.001
    local wid = self._countDownWidth * self._currentOrderTime / self._currentOrder.finishTime
    self._orderCountDownImgTrans.sizeDelta = Vector2(wid, self._countDownHeight)
    local fillPercent = self._currentOrderTime / self._currentOrder.finishTime
    if fillPercent < 0.3 then
      self._orderCountDownImg.color = Color.green
    elseif fillPercent < 0.66 then
      self._orderCountDownImg.color = self._orangeColor
    else
      self._orderCountDownImg.color = Color.red
    end
    if self._currentOrderTime > self._currentOrder.finishTime then
      self:ChangeSpineMood(true)
      self:OrderFinish()
      self:OnOrderRefresh()
    end
  end
end

function UIN14FishingGameController:_UpdateTime(ms)
  if self:_Guideing() then
    return
  end
  if self._gameState == FishingGameState.Playing then
    self._elapseDeltaTime = self._elapseDeltaTime + ms * 0.001
    if self._elapseDeltaTime >= 1 then
      self._elapseTime = self._elapseTime + 1
      local remainTime = self._cfg_stage.Time - self._elapseTime
      self._timeValue:SetText(self:ParseTime(remainTime))
      self._elapseDeltaTime = 0
      if remainTime <= 0 then
        self:_GameOver(true)
      end
    end
  end
end

function UIN14FishingGameController:ParseTime(sec)
  local minute = math.floor(sec / 60)
  local second = sec % 60
  return string.format("%02d:%02d", minute, second)
end

function UIN14FishingGameController:_UpdateFishPos(deltaTime)
  if self._gameState == FishingGameState.Playing or self._gameState == FishingGameState.Skill then
    for _, value in pairs(self._fishList) do
      local fish = value
      if fish then
        if self:_Guideing() then
          return
        end
        if fish.IsRotate == false and fish:IsSwimmingState() then
          fish:CheckReachedEdge(self._poolSize[1], self._poolSize[2], self._poolSize[3], self._poolSize[4], fish:GetFishLength() / 2)
        end
        if fish:IsDead() == false then
          fish:Swim(deltaTime, self._gameState)
        end
      end
    end
  end
end

function UIN14FishingGameController:_StartCountDown()
  self._start:SetActive(true)
  self._cd = 5
  self._countDown:SetText("")
  self._StartTimer = GameGlobal.Timer():AddEventTimes(1033, TimerTriggerCount.Infinite, self._OnCountDown, self)
end

function UIN14FishingGameController:_OnCountDown()
  self._cd = self._cd - 1
  if self._cd <= 0 then
    if self._StartTimer then
      GameGlobal.Timer():CancelEvent(self._StartTimer)
      self._StartTimer = nil
      self._gameState = FishingGameState.Playing
      AudioHelperController.PauseBGM()
      AudioHelperController.PlayBGM(CriAudioIDConst.BGMMiniGame, AudioConstValue.BGMCrossFadeTime)
      GameGlobal.EventDispatcher():Dispatch(GameEventType.GuideOpenUI, GuideOpenUI.UIN14FishingGameController)
      self._guideing = self:_Guideing()
      self:_InitGuideFish()
    end
    self._start:SetActive(false)
    self:InitOrderScrollView()
  else
    if self._cd == 4 then
      AudioHelperController.PlayUISoundAutoRelease(CriAudioIDConst.Summer1GameStart)
    end
    if self._cd - 1 <= 0 then
      return
    end
    self._countDown.text = self._cd - 1
    self._cdAnimation:Stop()
    if self._cd > 2 then
      self:_LoadSpine()
      self._cdAnimation:Play("uieff_Start_Number_32")
    end
    if self._cd == 2 then
      self:_LoadSpine()
      self._cdAnimation:Play("uieff_Start_Number_1s")
    end
  end
end

function UIN14FishingGameController:PauseBtnOnClick(go)
  if self:_Guideing() then
    return
  end
  self._pause:SetActive(true)
  self._lastGameStage = self._gameState
  self._gameState = FishingGameState.Pause
end

function UIN14FishingGameController:ExitBtnOnClick(go)
  self._pause:SetActive(false)
  self:_GameOver(self._score > 0)
end

function UIN14FishingGameController:ContinueBtnOnClick(go)
  self._pause:SetActive(false)
  if self._lastGameStage then
    self._gameState = self._lastGameStage
  else
    self._gameState = FishingGameState.Playing
  end
end

function UIN14FishingGameController:FinishOnClick(go)
  if self._canExit then
    self:_PlayGameOverStory()
  end
end

function UIN14FishingGameController:_PlayGameOverStory()
  self:_Close()
  if self._playstory and table.icontains(self._cfg_stage.StoryActiveType, 2) and self._componentInfo.mission_info_list[self._stage_id].mission_info.story_mask & 2 == 0 then
    GameGlobal.GetModule(StoryModule):StartStory(self._cfg_stage.StoryID[math.max(1, table.count(self._cfg_stage.StoryID))], function()
      self:StartTask(function(TT)
        local res = AsyncRequestRes:New()
        res = self._component:HandleStoryMsg(TT, res, self._stage_id, 2)
        if self._callback then
          self._callback()
        end
        self:_Close()
      end)
    end)
  else
    if self._callback then
      self._callback()
    end
    self:_Close()
  end
end

function UIN14FishingGameController:_GameOver(playstory)
  self._gameState = MiniGameState.Over
  self._playstory = playstory
  GameGlobal.Timer():AddEvent(2000, function()
    self._canExit = true
  end)
  self:_ShowFinish()
end

function UIN14FishingGameController:_Close()
  if self._bubblePool then
    for _, bubble in pairs(self._bubblePool) do
      bubble:Dispose()
    end
  end
  self:CloseDialog()
  AudioHelperController.PlayBGM(self._lastBGMResName, AudioConstValue.BGMCrossFadeTime)
end

function UIN14FishingGameController:_ShowFinish()
  self._finish:SetActive(true)
  self._scoreValue:SetText(self._score)
  self._tempScore = 0
  self._tempScoreDelta = math.ceil(self._score / App.TargetFrame)
  AudioHelperController.PlayUISoundAutoRelease(CriAudioIDConst.Summer1GameFinish)
  self:_SendScoreToServer()
end

function UIN14FishingGameController:_SendScoreToServer()
  self:StartTask(function(TT)
    local res = AsyncRequestRes:New()
    res = self._component:HandleScoreMsg(TT, res, self._stage_id, math.floor(self._score))
    if not res:GetSucc() then
      Log.error("handle score msg fail.")
    end
  end)
end

function UIN14FishingGameController:BeginDragFishingNet(pointData)
  if self._gameState == FishingGameState.Skill or self._showPufferEff then
    return
  end
  self._posOffest = self._fishingNetHandle.transform.position - self._fishingNet.transform.position
  local pos = UIHelper.ScreenPointToWorldPointInRectangle(self._fishingNetHandle.transform.parent, pointData.position, self._camera)
  self._fishingNetHandle.transform.position = pos + self._posOffest
  self:ClearFishSpine()
  if self._bubblePool then
    for _, bubble in pairs(self._bubblePool) do
      bubble:Hide()
    end
  end
  GameGlobal.UIStateManager():Lock("FishingLock")
  self._caughtRightFish = false
  self._caughtFish = false
  self._caughtObstacle = false
  self._isCatchPufferFish = false
  self._isCatchOctopus = false
end

function UIN14FishingGameController:OnDragFishingNet(pointData)
  if self._gameState == FishingGameState.Skill or self._showPufferEff then
    return
  end
  local pos = UIHelper.ScreenPointToWorldPointInRectangle(self._fishingNetHandle.transform.parent, pointData.position, self._camera)
  self._fishingNetHandle.transform.position = pos + self._posOffest
  self._fishingNetHandleClone.transform.position = pos + self._posOffest
  if self:_Guideing() then
    self._fishingNetGuide:SetActive(false)
  end
end

function UIN14FishingGameController:EndDragFishingNet(pointData)
  if self._isRefreshing then
    self._fishingNetHandle.transform.position = self._fishingNetOriginPos
    GameGlobal.UIStateManager():UnLock("FishingLock")
    return
  end
  if self._gameState == FishingGameState.Skill or self._showPufferEff or self._gameState == MiniGameState.Over then
    GameGlobal.UIStateManager():UnLock("FishingLock")
    return
  end
  self._eff:SetActive(true)
  self:CatchFish()
  self:CatchObstacle()
  self:PlayFishingAnimation()
  self:AddScore()
  self:ShowOrderItem()
  self:ShowScoreBubble(pointData.position)
  self:RefreshSkillState()
  self:ChangeSpineMood()
  self:FishNetCloneShow(self._caughtFish)
  local waitTime = 0
  local dis, reset = self:GetDisappearAndResetTime()
  if self._caughtFish then
    waitTime = reset
  else
    waitTime = self._cfg_minigame.NotCatchedFishNetResetTime
  end
  if not self._caughtFish and self:_Guideing() then
    self._fishingNetGuide:SetActive(true)
  end
  self._caughtRightFish = false
  self._caughtFish = false
  self._caughtObstacle = false
  self:ResetFishingNetPos()
  self._isCatchPufferFish = false
  self._isCatchOctopus = false
  self._timerHolder:StartTimer("WaitForAnim", waitTime * 1000, function()
    self:FishNetCloneShow(false)
    GameGlobal.UIStateManager():UnLock("FishingLock")
  end)
end

function UIN14FishingGameController:ClearFishSpine()
  self._catchedFishIdList = {}
  self._catchedFishDisTimeHolder:StopTimer("catchedFish")
  self._currentFishSpine.gameObject:SetActive(false)
  for k, v in pairs(self._currentCatchedFishes) do
    v:Hide()
  end
end

function UIN14FishingGameController:ChangeSpineMood(orderFail)
  local changeTime = 0
  if orderFail then
    self._roleSpine:SetAnimation(0, self._cfg_fishgame_inner.OrderFailAnim, true)
    changeTime = self._cfg_fishgame_inner.OrderFailToNormalTime
  elseif self._caughtFish then
    if self._caughtRightFish then
      if self._caughtObstacle then
        if self._isCatchOctopus then
          self._roleSpine:SetAnimation(0, self._cfg_fishgame_inner.OctopusAnim, true)
          changeTime = self._cfg_fishgame_inner.FailToNormalTime
        else
          self._roleSpine:SetAnimation(0, self._cfg_fishgame_inner.FailAnim, true)
          changeTime = self._cfg_fishgame_inner.FailToNormalTime
        end
      else
        self._roleSpine:SetAnimation(0, self._cfg_fishgame_inner.SuccessAnim, true)
        changeTime = self._cfg_fishgame_inner.SuccessToNormalTime
      end
    elseif self._caughtObstacle then
      if self._isCatchOctopus then
        self._roleSpine:SetAnimation(0, self._cfg_fishgame_inner.OctopusAnim, true)
        changeTime = self._cfg_fishgame_inner.FailToNormalTime
      else
        self._roleSpine:SetAnimation(0, self._cfg_fishgame_inner.FailAnim, true)
        changeTime = self._cfg_fishgame_inner.FailToNormalTime
      end
    end
  end
  if 0 < changeTime then
    self._spineTimeHolder:StopTimer("changeSpine")
    self._spineTimeHolder:StartTimer("changeSpine", changeTime, function()
      self._roleSpine:SetAnimation(0, self._cfg_fishgame_inner.RoleNormalAnimName, true)
    end)
  end
end

function UIN14FishingGameController:_RefreshSkillEffect(percent)
  local mask_y, pos_y = self:_GetSkillEffectParam(percent)
  self._skillPointImg.fillAmount = percent
  self._skillPointMaterial:SetTextureOffset("_MaskTex", Vector2(0, mask_y))
end

function UIN14FishingGameController:PlayFishingAnimation()
  if self._caughtFish then
    local dis, reset = self:GetDisappearAndResetTime()
    local time = dis
    self._catchedFishDisTimeHolder:StopTimer("catchedFish")
    self._catchedFishDisTimeHolder:StartTimer("catchedFish", math.floor(time * 1000), function()
      self:ClearFishSpine()
    end)
    if table.count(self._catchedFishIdList) > 0 then
      for i = 1, #self._catchedFishIdList do
        for k, v in pairs(self._currentCatchedFishes) do
          if v:CheckShowName(self._catchedFishIdList[i]) then
            v:ShowFish()
            v:CheckIsRight(self._currentOrder.detailInfo[self._currentFishIndex])
            break
          end
        end
      end
    end
    self._currentFishSpine.gameObject:SetActive(true)
  end
end

function UIN14FishingGameController:ResetFishingNetPos()
  self:StartTask(function(TT)
    self:Lock("UIN14FishingGameStageController:ResetFishingNetPos")
    local ani = self:GetUIComponent("Animation", "FishingNetHandleImg")
    if not self._showPufferEff then
      self._fishingNetHandle.transform.position = self._fishingNetOriginPos
      self._fishingNetTrans.transform.localRotation = Quaternion.identity
      ani:Play("uieff_FishingNetHandleTrans_shan")
      YIELD(TT, 1000)
    else
      local cfg = Cfg.cfg_fishing_fish({})
      local time = cfg[self._caughtFishId].CatchedTime
      YIELD(TT, time * 1000)
      self._fishingNetHandle.transform:DOMove(self._fishingNetOriginPos, 0.3):OnComplete(function()
        ani:Play("uieff_FishingNetHandleTrans_shan")
      end)
      YIELD(TT, 800)
      ani:Play("uieff_FishingNetHandleTrans")
      YIELD(TT, 800)
      self._showPufferEff = false
      self._fishingNetRawImage:LoadImage(self._rawImageName[1])
    end
    self._eff:SetActive(false)
    self:UnLock("UIN14FishingGameStageController:ResetFishingNetPos")
  end, self)
end

function UIN14FishingGameController:CatchFish()
  local netScreenPos = self._camera:WorldToScreenPoint(self._fishingNetHandle.transform.position)
  local catchedFishCount = 0
  for k, v in pairs(self._fishList) do
    if v.state ~= FishingFishState.Die and v:CheckCatched(self._camera, netScreenPos, self._fishingNet.sizeDelta.x / 2 * self._cfg_minigame.JudgeRangeMult) then
      if self._caughtRightFish == false and self._currentOrder.detailInfo[self._currentFishIndex] == self._fishList[k]._fishId then
        self._caughtRightFish = true
      end
      if self._fishList[k]._fishId == FishingFishType.Octopus then
        self._caughtObstacle = true
        self._isCatchOctopus = true
      end
      if self._fishList[k]._fishId == FishingFishType.Puffer then
        self._caughtObstacle = true
        self._isCatchPufferFish = true
      end
      if self._fishList[k]._fishId == FishingFishType.Puffer then
        AudioHelperController.PlayUISoundAutoRelease(CriAudioIDConst.Summer1GameSkillStart)
      else
        AudioHelperController.PlayUISoundAutoRelease(CriAudioIDConst.Summer1GameWeight)
      end
      self:_GuideCatchFishSuccess()
      if not table.icontains(self._catchedFishIdList, self._fishList[k]._fishId) then
        catchedFishCount = catchedFishCount + 1
        self._catchedFishIdList[catchedFishCount] = self._fishList[k]._fishId
      end
      self._fishList[k]:Die()
      self.fishPoolInfo:CatchFish(self._fishList[k]._fishId)
      self._caughtFishId = self._fishList[k]._fishId
      self._caughtFish = true
    end
  end
end

function UIN14FishingGameController:CatchObstacle()
  if self._isCatchOctopus then
    self:_AddOctopusTime()
    self._showOctopusEff = true
    self._currentPufferTime = 0
    self._octopusEff:SetActive(true)
    self._effectOctopusEffAni:Play("uieff_N14_Fishing_Octopus")
  end
  if self._isCatchPufferFish then
    self._showPufferEff = true
    self._fishingNetRawImage:LoadImage(self._rawImageName[2])
  end
end

function UIN14FishingGameController:_UpdateObstacleEff(ms)
  if (self._gameState == FishingGameState.Playing or self._gameState == FishingGameState.Skill) and self._showOctopusEff then
    self._currentOctopusTime = self._currentOctopusTime + ms * 0.001
    if self._currentOctopusTime > 3 then
      self._showOctopusEff = false
      self._currentOctopusTime = 0
      self._effectOctopusEffAni:Play("uieff_N14_Fishing_Octopus_Fade")
    end
  end
end

function UIN14FishingGameController:_AddOctopusTime()
  if self._gameState == FishingGameState.Playing and self._showOctopusEff then
    self._currentOctopusTime = 0
  end
end

function UIN14FishingGameController:_UpdateFishingSkillTime(ms)
  if self._gameState ~= FishingGameState.Skill then
    return
  end
  self._clickInterval = self._clickInterval - ms * 0.001
  self._skillTime = self._skillTime - ms * 0.001
  if self._skillTime <= 0 then
    self:SkillEnd()
  end
end

function UIN14FishingGameController:AutoFishing()
  local currentFishId = self._currentOrder.detailInfo[self._currentFishIndex]
  local currentFishIndexInPool = -1
  for k, v in pairs(self._fishList) do
    if v.state ~= FishingFishState.Die and v._fishId == currentFishId then
      currentFishIndexInPool = k
      break
    end
  end
  if currentFishIndexInPool ~= -1 then
    self._fishingNetHandle.transform.position = self._fishList[currentFishIndexInPool]._spine.transform.position
    local ani = self:GetUIComponent("Animation", "FishingNetHandleImg")
    ani:Play("uieff_FishingNetHandleTrans_collect")
    self._caughtFishId = self._fishList[currentFishIndexInPool]._fishId
    self._caughtFish = true
    self._caughtRightFish = true
    table.insert(self._catchedFishIdList, self._fishList[currentFishIndexInPool]._fishId)
    self:FishNetCloneShow(self._caughtFish)
    self._fishingNetHandleClone.transform.position = self._fishingNetHandle.transform.position
    self:PlayFishingAnimation()
    self:AddScore()
    self:ChangeSpineMood(false)
    self._catchedFishIdList = {}
    self._fishList[currentFishIndexInPool]:Die()
    self.fishPoolInfo:CatchFish(self._fishList[currentFishIndexInPool]._fishId)
    self:ShowScoreBubble(self._fishingNetHandle.transform.position)
    self._clickInterval = self._cfg_minigame.SkillClickInterval
    if self._caughtFishId == FishingFishType.Puffer then
      AudioHelperController.PlayUISoundAutoRelease(CriAudioIDConst.Summer1GameSkillStart)
    else
      AudioHelperController.PlayUISoundAutoRelease(CriAudioIDConst.Summer1GameWeight)
    end
    self._timerHolder:StartTimer("WaitForAnim", 500, function()
      self:FishNetCloneShow(false)
    end)
  end
end

function UIN14FishingGameController:SkillAreaOnClick(go)
  if self._currentPufferTime > 0 or self._showPufferEff then
    return
  end
  if self._gameState == FishingGameState.Skill and 0 >= self._clickInterval then
    self._clickInterval = self._cfg_minigame.SkillClickInterval
    self:AutoFishing()
  end
end

function UIN14FishingGameController:SkillEnd()
  self:ResetFishingNetPos()
  self._skillCanStartCurrentPoint = 0
  self._clickInterval = self._cfg_minigame.SkillClickInterval
  self._skillTime = self._cfg_minigame.SkillTime
  self._skillObj:SetActive(false)
  self._gameState = FishingGameState.Playing
  self:_RefreshSkillEffect(0)
  AudioHelperController.SetBGMMixerGroup(AudioConstValue.AuroralTimeMixerGroupName, AudioConstValue.DefaultMixerValue)
end

function UIN14FishingGameController:ShowScoreBubble(pos)
  if self._caughtFish or self._gameState == FishingGameState.Skill then
    local bubble
    for k, v in pairs(self._bubblePool) do
      if v:CheckUsing() == false then
        bubble = v
        break
      end
    end
    if bubble == nil then
      bubble = UiN14FishingGameBubble:New(self._bubblePoolTrans)
      table.insert(self._bubblePool, bubble)
    end
    local pos = UIHelper.ScreenPointToWorldPointInRectangle(self._fishingNetTrans.parent, self._currentFishSpine.gameObject.transform.position, self._camera)
    bubble:Show(self._currentAddScore, self._caughtRightFish, self._currentFishSpine.gameObject.transform.position)
  end
end

function UIN14FishingGameController:AddScore()
  if self._caughtRightFish == true or self._gameState == FishingGameState.Skill then
    self:RefreshOrderState()
    self._bonus = self._bonus + self._fishingSuccessAddScoreMult
    self._currentAddScore = self._baseFishScore * self._bonus
    self._score = self._score + self._currentAddScore
    self._scoreValue:SetText(math.floor(self._score))
    self._bounsValue:SetText(self._bonus)
    self._totalScore:SetText(math.floor(self._score))
  end
end

function UIN14FishingGameController:RefreshOrderState()
  self._currentFishIndex = self._currentFishIndex + 1
  if self._currentFishIndex > table.count(self._currentOrder.detailInfo) then
    self._bonus = self._bonus + self._orderFinishBouns
    self:OrderFinish()
    self:OnOrderRefresh()
  else
    self:_RefreshOrderList()
  end
end

function UIN14FishingGameController:RefreshSkillState()
  if self._caughtRightFish == true then
    self._skillCanStartCurrentPoint = self._skillCanStartCurrentPoint + 1
    if self._skillCanStartCurrentPoint >= self._skillPoint then
      self._skillCanStartCurrentPoint = self._skillPoint
    end
    local percent = self._skillCanStartCurrentPoint / self._skillPoint
    self:_RefreshSkillEffect(percent)
    if 1 <= percent then
      self._skillReady:SetActive(true)
    end
  end
end

function UIN14FishingGameController:_GetSkillEffectParam(percent)
  if percent == 0 then
    return 0.5, -160
  end
  if percent == 1.0 then
    return 0, 215
  end
  return 0.425 - 0.335 * percent, -100 + 300 * percent
end

function UIN14FishingGameController:SKillBtnOnClick(go)
  if self._skillCanStartCurrentPoint < self._cfg_minigame.SkillNeedCount then
    return
  end
  if self._elapseTime >= self._cfg_stage.Time then
    return
  end
  if self._gameState == FishingGameState.Skill or self._gameState == FishingGameState.SkillAnim or self._showPufferEff then
    return
  end
  self._gameState = FishingGameState.SkillAnim
  self._gameState = FishingGameState.Skill
  local rw = self:GetUIComponent("RawImageLoader", "kanban")
  rw:LoadImage(self._cfg_fishgame_inner.SkillImage)
  self._skillkanban:SetActive(true)
  self._skillReady:SetActive(false)
  AudioHelperController.PlayUISoundAutoRelease(CriAudioIDConst.Summer1GameSkillLoop)
  AudioHelperController.SetBGMMixerGroup(AudioConstValue.AuroralTimeMixerGroupName, AudioConstValue.AuroralTimeMixerValue)
  GameGlobal.Timer():AddEvent(1000, function()
    self._skillkanban:SetActive(false)
    self._skillObj:SetActive(true)
  end)
end

function UIN14FishingGameController:GenerateLayerPool()
  self._layerList = {}
  for i = 1, table.count(Cfg.cfg_fishing_fish({})) do
    local layerGo = UnityEngine.GameObject:New("Layer" .. i)
    layerGo.transform.parent = self._layerPool.transform
    layerGo.transform.localPosition = Vector3.zero
    layerGo.transform.localScale = Vector3.one
    table.insert(self._layerList, layerGo)
  end
end

function UIN14FishingGameController:InitializationOriginAllFish()
  local allFishGroupList = self.fishPoolInfo.allFishInfo
  self._bornPos:SpawnObjects("UIN14FishingGameFish", self.fishPoolInfo.totalFish)
  self._fishList = self._bornPos:GetAllSpawnList()
  self._shawdowLayerPos:SpawnObjects("UIN14FishingGameFishShadow", self.fishPoolInfo.totalFish)
  self._shadowList = self._shawdowLayerPos:GetAllSpawnList()
  local currentFishIndex = 1
  for k, v in pairs(allFishGroupList) do
    for j = 1, v.currentCount do
      local bornAngel = math.random(-60, 60)
      local bornPosX = math.random(-700, 700)
      local pos = Vector3(bornPosX, -500, 0)
      local rot = Vector3(0, 0, bornAngel)
      local layer = v.fishCfg.Layer
      self._fishList[currentFishIndex]:GetGameObject().transform.parent = self._layerList[layer].transform
      self._fishList[currentFishIndex]:SetData(v.fishId, pos, rot, self._shadowList[currentFishIndex])
      self._fishList[currentFishIndex]:SetCamera(self._camera)
      currentFishIndex = currentFishIndex + 1
    end
  end
end

function UIN14FishingGameController:GenerateFish()
  local fishId = self.fishPoolInfo:GenerateFish()
  if fishId ~= -1 then
    for k, v in pairs(self._fishList) do
      if v.state == FishingFishState.Die then
        local bornAngel = math.random(-60, 60)
        local bornPosX = math.random(-700, 700)
        local pos = Vector3(bornPosX, -500, 0)
        local rot = Vector3(0, 0, bornAngel)
        v:SetData(fishId, pos, rot)
        v:SetCamera(self._camera)
        v:GetGameObject().transform.parent = self._layerList[v._fishCfg.Layer].transform
        break
      end
    end
  end
end

function UIN14FishingGameController:GetDisappearAndResetTime()
  local catchTime, resetTime = self._cfg_minigame.CatchedFishDisappearTime, self._cfg_minigame.CatchedFishNetRestTime
  for i = 1, table.count(Cfg.cfg_fishing_fish({})) do
    for k, v in ipairs(self._catchedFishIdList) do
      if Cfg.cfg_fishing_fish[i].ID == v then
        catchTime = math.max(catchTime, Cfg.cfg_fishing_fish[i].CatchedTime)
        resetTime = math.max(catchTime, Cfg.cfg_fishing_fish[i].FishNetResetTime)
      end
    end
  end
  return catchTime, resetTime
end

function UIN14FishingGameController:FishNetCloneShow(bShow)
  self._fishingNetHandleClone:SetActive(bShow)
end

function UIN14FishingGameController:AddOrderListItem(widget)
  if not self._orderList then
    self._orderList = {}
  end
  table.insert(self._orderList, widget)
end

function UIN14FishingGameController:ClearOrderList()
  self._orderList = {}
end

function UIN14FishingGameController:ShowOrderItem()
  if self._caughtFish then
    if self._caughtRightFish then
      for i, v in pairs(self._orderList) do
        if v._index == self._currentFishIndex - 1 then
          v:PlayAnimation(1)
          v:EffectDoTween(self._pathValues, 0.8, DG.Tweening.Ease.InOutCubic, function(pos)
            self._scoreEffect.transform.position = pos
            self._scoreEffect:SetActive(true)
            self:StartTask(function(TT)
              YIELD(TT, 500)
              self._scoreEffect:SetActive(false)
            end, self)
          end)
        end
      end
    else
      for i, v in pairs(self._orderList) do
        if v._index == self._currentFishIndex then
          v:PlayAnimation(3)
        end
      end
    end
  end
end

function UIN14FishingGameController:OnOrderRefresh()
  self:StartTask(function(TT)
    GameGlobal.UIStateManager():Lock("UiN14FishingAniLock")
    self._isRefreshing = true
    for i, v in pairs(self._orderList) do
      v:PlayAnimation(4)
    end
    YIELD(TT, 1200)
    self._isRefreshing = false
    GameGlobal.UIStateManager():UnLock("UiN14FishingAniLock")
  end, self)
end

function UIN14FishingGameController:_LoadSpine()
  local spineName = "n14_g_4_spine_idle"
  local aniName = "1"
  if string.isnullorempty(spineName) then
    return
  end
  self._spine = self:GetUIComponent("SpineLoader", "Spine")
  if not self._spineSke then
    self._spine:LoadSpine(spineName)
  end
  if self._spine then
    self._spineSke = self._spine.CurrentSkeleton
    if not self._spineSke then
      self._spineSke = self._spine.CurrentMultiSkeleton
    end
    if self._spineSke then
      self._spineSke.AnimationState:SetAnimation(0, aniName, true)
    end
  end
end

function UIN14FishingGameController:ShowClickEff(pointData)
  local mousePos = GameGlobal.EngineInput().mousePosition
  local pos = UIHelper.ScreenPointToWorldPointInRectangle(self._uieffClick.transform.parent, mousePos, self._camera)
  self._uieffClick.transform.position = pos
  self._uieffClick:SetActive(true)
  self:StartTask(function(TT)
    YIELD(TT, 500)
    self._uieffClick:SetActive(false)
  end, self)
end

function UIN14FishingGameController:_Guideing()
  return self._guideModule:GuideInProgress()
end

function UIN14FishingGameController:_GuideCatchFishSuccess()
  if self:_Guideing() then
    GameGlobal.EventDispatcher():Dispatch(GameEventType.FinishGuideStep, GuideType.OperationFinish)
    self._fishingNetGuide:SetActive(false)
  end
end

function UIN14FishingGameController:_InitGuideFish()
  if not self:_Guideing() then
    return
  end
  for _, _fish in pairs(self._fishList) do
    local pos = Vector3(0, 0, 0)
    local rot = Vector3(0, 0, 0)
    _fish:ForceSetPosition(pos, rot)
  end
end

function UIN14FishingGameController:_WhenGuideDone()
  self._cfg_fishgame_inner = Cfg.cfg_fishing_game_inner({
    ID = self._cfg_stage.ID
  })[1]
  self._roleSpine:LoadSpine(self._cfg_fishgame_inner.RoleSpine)
  self._roleSpine:SetAnimation(0, self._cfg_fishgame_inner.RoleNormalAnimName, true)
  self.fishPoolInfo = FishingGameLevelInfo:New(self._cfg_fishgame_inner.FishInfo, self._cfg_fishgame_inner.OrderFishInfo, self._cfg_fishgame_inner.TotalFish, 0, 0)
  self._currentOrder = self.fishPoolInfo.orderDetailInfo[self._currentOrderIndex]
  self:InitializationOriginAllFish()
  self:OrderFinish()
  self:OnOrderRefresh()
  LocalDB.SetInt(self._roleModule:GetPstId() .. "FishingGuide", 1)
end

function UIN14FishingGameController:_ShowGuideStep(param)
  if param.data.guideType == GuideType.OperationFinish then
    self._fishingNetGuide:SetActive(true)
  end
end
