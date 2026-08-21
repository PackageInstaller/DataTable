_class("UIMiniGameController", UIController)
UIMiniGameController = UIMiniGameController

function UIMiniGameController:Constructor()
  self._curOrderform = Orderform:New(0, 0, 0, nil, 0, 0)
  self._gameState = MiniGameState.Start
  self._score = 0
  self._tempScore = 0
  self._tempScoreDelta = 1
  self._bonus = 0
  self._skillPoint = 0
  self._skillPointDelta = 0
  self._skillTime = 0
  self._clickInterval = 0
  self._orderformCount = 0
  self._guestOrderformList = {
    false,
    false,
    false
  }
  self._guestOrderformListLength = #self._guestOrderformList
  self._guestWidgets = {}
  self._guestOrderformWidgets = {}
  self._guestScoreWidgets = {}
  self._autoDoOrderformIndex = 0
  self._guestRecord = {}
  self._refreshTime = 0
  self._elapseDeltaTime = 0
  self._elapseTime = 0
  self._guestWidgetOffet = Vector3(0, 38, 0)
  self._orderformWidgetOffset = Vector3(-112, 215, 0)
  self._scoreWidgetOffset = Vector3(-36, 230, 0)
  self._highLightObj = {}
  self._playstory = false
  self._guideIndex = 3
  self._guideModule = self:GetModule(GuideModule)
  self._guideTime = 0
  self._createdGuideOrderform = false
end

function UIMiniGameController:OnShow(uiParams)
  self._stage_id = uiParams[1]
  self._component = uiParams[2]
  self._componentInfo = uiParams[3]
  self._lastBGMResName = uiParams[4]
  self._callback = uiParams[5]
  self._cfg_stage = Cfg.cfg_component_mini_game_mission[self._stage_id]
  self._cfg_minigame = Cfg.cfg_summer_minigame[1]
  self._bonus = self._cfg_minigame.Bonus
  self._orderformInterval = self._cfg_minigame.OrderFormInterval
  self:_GetComponents()
  self:_OnValue()
end

function UIMiniGameController:_GetComponents()
  self._pause = self:GetGameObject("Puase")
  self._start = self:GetGameObject("Start")
  self._countdown = self:GetUIComponent("UILocalizationText", "CountDown")
  self._finish = self:GetGameObject("Finish")
  self._timeValue = self:GetUIComponent("UILocalizationText", "TimeValue")
  self._scoreValue = self:GetUIComponent("UILocalizationText", "ScoreValue")
  self._bounsValue = self:GetUIComponent("UILocalizationText", "BounsValue")
  self._totalScore = self:GetUIComponent("UILocalizationText", "TotalScore")
  self._skillPointImg = self:GetUIComponent("Image", "SkillPoint")
  self._skillPointMaterial = self._skillPointImg.material
  self._guestItem = self:GetUIComponent("UISelectObjectPath", "GuestItem")
  self._guestOrderformItem = self:GetUIComponent("UISelectObjectPath", "GuestOrderformItem")
  self._guestScoreItem = self:GetUIComponent("UISelectObjectPath", "GuestScoreItem")
  self._stepImg = {}
  self._stepImg[OrderformStep.Weight] = self:GetUIComponent("Image", "Weight")
  self._stepImg[OrderformStep.Ingredient] = self:GetUIComponent("Image", "Ingredient")
  self._stepImg[OrderformStep.Jam] = self:GetUIComponent("Image", "Jam")
  self._stepAnimation = {}
  self._stepAnimation[OrderformStep.Weight] = self:GetUIComponent("Animation", "Weight")
  self._stepAnimation[OrderformStep.Ingredient] = self:GetUIComponent("Animation", "Ingredient")
  self._stepAnimation[OrderformStep.Jam] = self:GetUIComponent("Animation", "Jam")
  self._plateRoot = self:GetUIComponent("RectTransform", "root")
  self._plateRootCanvasGroup = self:GetUIComponent("CanvasGroup", "root")
  self._plateRootRectTransformPosition = self._plateRoot.anchoredPosition
  self._atlas = self:GetAsset("UISummerGame.spriteatlas", LoadType.SpriteAtlas)
  self._guestgameObject = {}
  self._guestgameObject[1] = self:GetGameObject("Guest1")
  self._guestgameObject[2] = self:GetGameObject("Guest2")
  self._guestgameObject[3] = self:GetGameObject("Guest3")
  self._guestgameObject[4] = self:GetGameObject("Guest4")
  self:_GetWeightIngredientJamObj()
  self._skillObj = self:GetGameObject("Skill")
  self._plateAnimation = self:GetUIComponent("Animation", "Plate")
  self._gameStateAnimation = self:GetUIComponent("Animation", "GameState")
  self._gameStateskillAnimation = self:GetUIComponent("Animation", "Center_Skill")
  self._cdAnimation = self:GetUIComponent("Animation", "Start")
  self._trashSpine = self:GetUIComponent("SpineLoader", "Trash")
  self._scoreAnimation = self:GetUIComponent("Animation", "ScoreEff")
  self._skillAnimation = self:GetUIComponent("Animation", "SKillBtn")
  self._skillFullFx = self:GetGameObject("FullFx")
  self._skillParticleSystemRect = self:GetUIComponent("RectTransform", "ParticleSystem")
  self._viceObj = self:GetGameObject("Vice")
  self._normalObj = self:GetGameObject("Normal")
  self._rageObj = self:GetGameObject("Rage")
  self._fireSpine = self:GetUIComponent("SpineLoader", "FireSpine")
end

function UIMiniGameController:_GetWeightIngredientJamObj()
  self._WIJObjs = {
    [OrderformStep.Weight] = {
      [1] = {
        [Weight.Small] = self:GetGameObject("SmallBtn"),
        [Weight.Big] = self:GetGameObject("BigBtn")
      },
      [2] = {
        [Weight.Small] = self:GetGameObject("SmallBtn_Pop"),
        [Weight.Big] = self:GetGameObject("BigBtn_Pop")
      }
    },
    [OrderformStep.Ingredient] = {
      [1] = {
        [Ingredient.Chocolate] = self:GetGameObject("ChocolateBtn"),
        [Ingredient.Coco] = self:GetGameObject("CocoBtn"),
        [Ingredient.Pudding] = self:GetGameObject("PuddingBtn"),
        [Ingredient.Taro] = self:GetGameObject("TaroBtn")
      },
      [2] = {
        [Ingredient.Chocolate] = self:GetGameObject("ChocolateBtn_Pop"),
        [Ingredient.Coco] = self:GetGameObject("CocoBtn_Pop"),
        [Ingredient.Pudding] = self:GetGameObject("PuddingBtn_Pop"),
        [Ingredient.Taro] = self:GetGameObject("TaroBtn_Pop")
      }
    },
    [OrderformStep.Jam] = {
      [1] = {
        [Jam.Strawberry] = self:GetGameObject("StrawberryBtn"),
        [Jam.Matcha] = self:GetGameObject("MatchaBtn"),
        [Jam.Biolac] = self:GetGameObject("BiolacBtn"),
        [Jam.Mango] = self:GetGameObject("MangoBtn")
      },
      [2] = {
        [Jam.Strawberry] = self:GetGameObject("Strawberry_Pop"),
        [Jam.Matcha] = self:GetGameObject("Matcha_Pop"),
        [Jam.Biolac] = self:GetGameObject("Biolac_Pop"),
        [Jam.Mango] = self:GetGameObject("Mango_Pop")
      }
    }
  }
end

function UIMiniGameController:_OnValue()
  self._timeValue:SetText(self._cfg_stage.Time)
  self._scoreValue:SetText(self._score)
  self._bounsValue:SetText(self._cfg_minigame.Bonus)
  self._totalScore:SetText(self._score)
  self:_RefreshSkillEffect(0)
  self:_SetWeightIngredientJamObj()
  self:_HideHighLightObj()
  self:_HideCurOrderformImg()
  self:_InitGuestWidgets()
  self:_InitGuestOrderformWights()
  self:_InitGuestScoreWights()
  self:_StartCountDown()
  self:_SetViceEffect(true)
end

function UIMiniGameController:_SetViceEffect(bool)
  self._normalObj:SetActive(bool)
  self._rageObj:SetActive(not bool)
  if not bool then
    self._fireSpine:SetAnimation(0, "move", true)
  end
end

function UIMiniGameController:_SetWeightIngredientJamObj()
  for key, value in pairs(Ingredient) do
    self._WIJObjs[OrderformStep.Ingredient][1][value]:SetActive(table.icontains(self._cfg_stage.Ingredient, value))
  end
  for key, value in pairs(Jam) do
    self._WIJObjs[OrderformStep.Jam][1][value]:SetActive(table.icontains(self._cfg_stage.Jam, value))
  end
end

function UIMiniGameController:_Close()
  self:CloseDialog()
  AudioHelperController.PlayBGM(self._lastBGMResName, AudioConstValue.BGMCrossFadeTime)
end

function UIMiniGameController:PauseBtnOnClick()
  AudioHelperController.PlayUISoundAutoRelease(CriAudioIDConst.Summer1ClickNormal)
  self._pause:SetActive(true)
  self._gameState = MiniGameState.Pause
  self._gameStateAnimation:Play(MGAnimations.MiniGameState[self._gameState])
end

function UIMiniGameController:ExitBtnOnClick()
  self._pause:SetActive(false)
  self:_GameOver(self._score > 0)
end

function UIMiniGameController:ContinueBtnOnClick()
  AudioHelperController.PlayUISoundAutoRelease(CriAudioIDConst.Summer1ClickNormal)
  self._pause:SetActive(false)
  self._gameState = MiniGameState.Playing
end

function UIMiniGameController:_StartCountDown()
  self._start:SetActive(true)
  self._gameStateAnimation:Play(MGAnimations.MiniGameState[self._gameState])
  self._cd = 4
  self._countdown:SetText("")
  self._StartTimer = GameGlobal.Timer():AddEventTimes(1033, TimerTriggerCount.Infinite, self._OnCountDown, self)
end

function UIMiniGameController:_OnCountDown()
  self._cd = self._cd - 1
  if self._cd <= 0 then
    if self._StartTimer then
      GameGlobal.Timer():CancelEvent(self._StartTimer)
      self._StartTimer = nil
      self._gameState = MiniGameState.Playing
      AudioHelperController.StopBGM()
      AudioHelperController.PlayBGM(CriAudioIDConst.BGMMiniGame, AudioConstValue.BGMCrossFadeTime)
      GameGlobal.EventDispatcher():Dispatch(GameEventType.GuideOpenUI, GuideOpenUI.UIMiniGameController)
    end
    self._start:SetActive(false)
  else
    if self._cd == 3 then
      AudioHelperController.PlayUISoundAutoRelease(CriAudioIDConst.Summer1GameStart)
    end
    self._countdown:SetText(self._cd)
    self._cdAnimation:Stop()
    self._cdAnimation:Play(MGAnimations.MiniGameState.Cd)
  end
end

function UIMiniGameController:_NextOrderformCreateTime()
  self._refreshTime = self:_GetOrderFormRefreshTime()
end

function UIMiniGameController:_GetTimeScore(time)
  local timescore = self._cfg_minigame.TimeScore[2]
  if time <= timescore[1] then
    return self._cfg_minigame.TimeScore[1][3]
  elseif time > timescore[2] then
    return self._cfg_minigame.TimeScore[3][3]
  else
    return timescore[3]
  end
end

function UIMiniGameController:OnUpdate(deltaTimeMS)
  self:_UpdateTime(deltaTimeMS)
  self:_UpdateSkillEffect(deltaTimeMS)
  self:_UpdateSkill(deltaTimeMS)
  self:_CreateNewOrderform(deltaTimeMS)
  self:_UpdateGuestOrderformList(deltaTimeMS)
  self:_UpdateScore(deltaTimeMS)
end

function UIMiniGameController:_UpdateSkillEffect(ms)
  if self._gameState ~= MiniGameState.Playing then
    return
  end
  if self._skillPointDelta < self._skillPoint then
    self._skillPointDelta = math.min(self._skillPointDelta + ms * 0.001, self._skillPoint)
    local percent = self._skillPointDelta / self._cfg_minigame.IceSoulPoint
    self:_RefreshSkillEffect(percent)
    if 1 <= percent then
      AudioHelperController.PlayUISoundAutoRelease(CriAudioIDConst.Summer1GameSkillStart)
      self:_PlaySkillAnimation(true)
      self:_SetViceEffect(false)
    end
  end
end

function UIMiniGameController:_UpdateSkill(ms)
  if self._gameState ~= MiniGameState.Skill then
    return
  end
  self._skillTime = self._skillTime + ms * 0.001
  self._clickInterval = self._clickInterval - ms * 0.001
  if self._skillTime > self._cfg_minigame.IceSoulTime then
    self._gameStateskillAnimation:Play(MGAnimations.MiniGameState[self._gameState].End)
    GameGlobal.Timer():AddEvent(566, function()
      self:_SetViceEffect(true)
      self._gameStateskillAnimation:Stop()
      self._skillObj:SetActive(false)
      AudioHelperController.SetBGMMixerGroup(AudioConstValue.AuroralTimeMixerGroupName, AudioConstValue.DefaultMixerValue)
    end)
    self:_AudoComplementedWhenSkillEnd()
    self:_RefreshSkillEffect(0)
    self._skillTime = 0
    self._gameState = MiniGameState.Playing
  else
    self:_RefreshSkillEffect(1 - self._skillTime / self._cfg_minigame.IceSoulTime)
  end
end

function UIMiniGameController:_AudoComplementedWhenSkillEnd()
  if self._autoDoOrderformIndex <= 0 then
    return
  end
  local orderform = self._guestOrderformList[self._autoDoOrderformIndex]
  if orderform and orderform:CanDo() and 0 < self._curOrderform._weight then
    self._curOrderform._weight = orderform._weight
    self._curOrderform._ingredient = orderform._ingredient
    self._curOrderform._jam = orderform._jam
    self._curOrderform._step = OrderformStep.Delivery
    self:_Delivery(self._autoDoOrderformIndex, true)
  else
    self:_CurOrderformClear()
  end
end

function UIMiniGameController:_CreateNewOrderform(ms)
  if self._gameState ~= MiniGameState.Playing and self._gameState ~= MiniGameState.Skill then
    return
  end
  if self._guideModule:GuideInProgress() then
    if not self._guestOrderformList[self._guideIndex] and not self._createdGuideOrderform then
      self:_CreateGuideOrderform()
      self._createdGuideOrderform = true
    end
    return
  end
  self._refreshTime = self._refreshTime - ms
  if self._refreshTime <= 0 then
    self:_CreateOrderform()
    self:_NextOrderformCreateTime()
  end
end

function UIMiniGameController:_CheckOrderformReady()
  for i = 1, self._guestOrderformListLength do
    local orderform = self._guestOrderformList[i]
    if orderform then
      local widgetIndex = orderform._widgetIndex
      if orderform:CanDo() and self._curOrderform:Equal(orderform) then
        self._guestOrderformWidgets[widgetIndex]:PlayReadyAnimation(true)
      else
        self._guestOrderformWidgets[widgetIndex]:PlayReadyAnimation(false)
      end
    end
  end
end

function UIMiniGameController:_Guideing(ms)
  if self._guideTime > 0 then
    self._guideTime = self._guideTime - ms * 0.001
    return false
  end
  local orderform = self._guestOrderformList[self._guideIndex] and self._guestOrderformList[self._guideIndex]:CanDo()
  return self._guideModule:GuideInProgress() and (orderform or self._guideTime < 0)
end

function UIMiniGameController:_UpdateGuestOrderformList(ms)
  if self._gameState ~= MiniGameState.Playing and self._gameState ~= MiniGameState.Skill then
    return
  end
  if self:_Guideing(ms) then
    return
  end
  for i = 1, self._guestOrderformListLength do
    local orderform = self._guestOrderformList[i]
    if orderform then
      local widgetIndex = orderform._widgetIndex
      local guest = orderform._guest
      if orderform._state == OrderformState.Appearing then
        orderform._appearingTime = orderform._appearingTime - ms * 0.001
        if orderform._appearingTime <= 0 then
          orderform._state = OrderformState.Waiting
          self:_CheckOrderformReady()
        end
      elseif orderform._state == OrderformState.Waiting then
        orderform._elapseWaitingTime = orderform._elapseWaitingTime + ms * 0.001
        if orderform._elapseWaitingTime >= orderform._waitingTime then
          orderform._state = OrderformState.TimeOut
        else
          local preMood = self._guestOrderformWidgets[widgetIndex]:GetCurrentMood()
          self._guestOrderformWidgets[widgetIndex]:_Update(ms)
          local curMood = self._guestOrderformWidgets[widgetIndex]:GetCurrentMood()
          if preMood ~= curMood and curMood == GuestMood.Impatient then
            self._guestOrderformWidgets[widgetIndex]:PlayAnimation("twinkle01")
          end
          self._guestWidgets[guest]:_Update(curMood)
        end
      elseif orderform._state == OrderformState.TimeOut then
        AudioHelperController.PlayUISoundAutoRelease(CriAudioIDConst.Summer1GameFail)
        self._guestOrderformWidgets[widgetIndex]:_Update(ms)
        self._guestOrderformWidgets[widgetIndex]:PlayAnimation("twinkle02")
        self._guestWidgets[guest]:_Update(GuestMood.Impatient)
        orderform._state = OrderformState.TimeOutAnimation
      elseif orderform._state == OrderformState.TimeOutAnimation then
        orderform._timeOutAnimation = orderform._timeOutAnimation - ms * 0.001
        if 0 >= orderform._timeOutAnimation then
          self._guestOrderformWidgets[widgetIndex]:PlayAnimation("out")
          self._guestWidgets[guest]:PlayAnimation(GuestMood.Impatient)
          orderform._state = OrderformState.DisAppearing
        end
      elseif orderform._state == OrderformState.Fail then
        self._guestOrderformWidgets[widgetIndex]:PlayAnimation("out")
        self._guestWidgets[guest]:_Update(GuestMood.Impatient)
        self._guestWidgets[guest]:PlayAnimation(GuestMood.Impatient)
        orderform._state = OrderformState.DisAppearing
      elseif orderform._state == OrderformState.Success then
        self._guestOrderformWidgets[widgetIndex]:SetActive(false)
        self:_ShowGuestScore(orderform._score, widgetIndex)
        self._guestWidgets[guest]:_Update(GuestMood.Happy)
        self._guestWidgets[guest]:Happy(orderform, GuestMood.Happy)
        orderform._state = OrderformState.DisAppearing
      elseif orderform._state == OrderformState.DisAppearing then
        orderform._disAppearingTime = orderform._disAppearingTime - ms * 0.001
        if 0 >= orderform._disAppearingTime then
          self._guestOrderformList[i] = false
          self._guestWidgets[guest]:SetActive(false)
          self._guestOrderformWidgets[widgetIndex]:SetActive(false)
          self._guestScoreWidgets[widgetIndex]:SetActive(false)
        end
      end
    end
  end
end

function UIMiniGameController:_ClearGuestOrderformList()
  for i = 1, self._guestOrderformListLength do
    if self._guestOrderformList[i] then
      self._guestOrderformWidgets[self._guestOrderformList[i]._widgetIndex]:SetActive(false)
      self._guestOrderformList[i] = false
    end
  end
end

function UIMiniGameController:_UpdateScore(ms)
  if (self._gameState == MiniGameState.Playing or self._gameState == MiniGameState.Skill) and self._tempScore < self._score then
    self._tempScore = self._tempScore + self._tempScoreDelta
    if self._tempScore >= self._score then
      self._tempScore = self._score
    end
    self._scoreValue:SetText(self._tempScore)
  end
  if self._gameState == MiniGameState.Over and self._tempScore < self._score then
    self._tempScore = self._tempScore + self._tempScoreDelta
    if self._tempScore >= self._score then
      self._tempScore = self._score
    end
    self._totalScore:SetText(self._tempScore)
  end
end

function UIMiniGameController:_UpdateHighLightObj(step)
  if self._curOrderform then
    if step == OrderformStep.Weight then
      self._highLightObj[OrderformStep.Weight] = self._WIJObjs[OrderformStep.Weight][2][self._curOrderform._weight]
      self._highLightObj[OrderformStep.Weight]:SetActive(true)
    end
    if step == OrderformStep.Ingredient then
      self._highLightObj[OrderformStep.Ingredient] = self._WIJObjs[OrderformStep.Ingredient][2][self._curOrderform._ingredient]
      self._highLightObj[OrderformStep.Ingredient]:SetActive(true)
    end
    if step == OrderformStep.Jam then
      self._highLightObj[OrderformStep.Jam] = self._WIJObjs[OrderformStep.Jam][2][self._curOrderform._jam]
      self._highLightObj[OrderformStep.Jam]:SetActive(true)
    end
  end
end

function UIMiniGameController:_UpdateTime(ms)
  if self._gameState ~= MiniGameState.Playing then
    return
  end
  if self:_Guideing(ms) then
    return
  end
  self._elapseDeltaTime = self._elapseDeltaTime + ms * 0.001
  if self._elapseDeltaTime >= 1 then
    self._elapseTime = self._elapseTime + 1
    local remainTime = self._cfg_stage.Time - self._elapseTime
    self._timeValue:SetText(remainTime)
    self._elapseDeltaTime = 0
    if remainTime <= 0 then
      self:_GameOver(true)
    end
  end
end

function UIMiniGameController:_GetOrderFormRefreshTime()
  local min = 0
  local max = 0
  if self._gameState == MiniGameState.Playing then
    min = self._cfg_stage.RefreshTimeZone[1]
    max = self._cfg_stage.RefreshTimeZone[2]
  elseif self._gameState == MiniGameState.Skill then
    min = self._cfg_stage.RefreshTimeZoneFever[1]
    max = self._cfg_stage.RefreshTimeZoneFever[2]
  end
  return math.random(math.floor(min * 1000), math.floor(max * 1000))
end

function UIMiniGameController:_CreateOrderform()
  local index = self:_RandomGuestIndex()
  if index <= 0 then
    return
  end
  local cfg_orderform = self:_RandomOrderformCfg()
  if cfg_orderform then
    self._guestOrderformList[index] = Orderform:New(cfg_orderform.Weight, cfg_orderform.Ingredient, cfg_orderform.Jam, cfg_orderform.Guest, cfg_orderform.WaitTime, index)
    self:_ShowGuestWidget(cfg_orderform.Guest, index)
    self:_ShowGuestOrderformWidget(index)
  end
end

function UIMiniGameController:_CreateGuideOrderform()
  local index = self._guideIndex
  local cfg_orderform = Cfg.cfg_summer_minigame_orderforms[self._cfg_minigame.GuideOrderform]
  self._guestOrderformList[index] = Orderform:New(cfg_orderform.Weight, cfg_orderform.Ingredient, cfg_orderform.Jam, cfg_orderform.Guest, cfg_orderform.WaitTime, index)
  self._guestOrderformList[index]._state = OrderformState.Waiting
  self:_ShowGuestWidget(cfg_orderform.Guest, index)
  self:_ShowGuestOrderformWidget(index)
end

function UIMiniGameController:_RandomGuestIndex()
  local temp = {}
  for i = 1, #self._guestOrderformList do
    if not self._guestOrderformList[i] then
      table.insert(temp, i)
    end
  end
  if 0 < #temp then
    return temp[math.random(1, #temp)]
  end
  return 0
end

function UIMiniGameController:_RandomOrderformCfg()
  local ids = self._cfg_stage.OrderFormID
  local cfg_orderforms = Cfg.cfg_summer_minigame_orderforms
  local orderforms = {}
  for i = 1, #ids do
    local cfg_orderform = cfg_orderforms[ids[i]]
    if self:_Eliminate(cfg_orderform.Guest) then
      table.insert(orderforms, cfg_orderform)
    end
  end
  if table.count(orderforms) > 0 then
    return orderforms[math.random(1, #orderforms)]
  end
  return nil
end

function UIMiniGameController:SmallBtnOnClick(go)
  self:_Do(OrderformStep.Weight, Weight.Small)
end

function UIMiniGameController:BigBtnOnClick(go)
  self:_Do(OrderformStep.Weight, Weight.Big)
end

function UIMiniGameController:ChocolateBtnOnClick(go)
  self:_Do(OrderformStep.Ingredient, Ingredient.Chocolate)
end

function UIMiniGameController:PuddingBtnOnClick(go)
  self:_Do(OrderformStep.Ingredient, Ingredient.Pudding)
end

function UIMiniGameController:CocoBtnOnClick(go)
  self:_Do(OrderformStep.Ingredient, Ingredient.Coco)
end

function UIMiniGameController:TaroBtnOnClick(go)
  self:_Do(OrderformStep.Ingredient, Ingredient.Taro)
end

function UIMiniGameController:StrawberryRealBtnOnClick(go)
  self:_Do(OrderformStep.Jam, Jam.Strawberry)
end

function UIMiniGameController:MatchaRealBtnOnClick(go)
  self:_Do(OrderformStep.Jam, Jam.Matcha)
end

function UIMiniGameController:BiolacRealBtnOnClick(go)
  self:_Do(OrderformStep.Jam, Jam.Biolac)
end

function UIMiniGameController:MangoRealBtnOnClick(go)
  self:_Do(OrderformStep.Jam, Jam.Mango)
end

function UIMiniGameController:Guest1OnClick(go)
  self:_Delivery(1, false)
end

function UIMiniGameController:Guest2OnClick(go)
  self:_Delivery(2, false)
end

function UIMiniGameController:Guest3OnClick(go)
  self:_Delivery(3, false)
end

function UIMiniGameController:Guest4OnClick(go)
  self:_Delivery(4, false)
end

function UIMiniGameController:_Do(step, param)
  if not self._curOrderform:Do(step, param) then
    return
  end
  local imgs = OrderformImg.Img
  local img
  if step <= OrderformStep.Weight then
    img = self._atlas:GetSprite(imgs[step][param])
  else
    img = self._atlas:GetSprite(imgs[step][self._curOrderform._weight][param])
  end
  self._stepImg[step].sprite = img
  self._stepImg[step].color = OrderformImg.ImgColor[true]
  AudioHelperController.PlayUISoundAutoRelease(StepAudio[step])
  self._stepAnimation[step]:Play(MGAnimations.OrderformStep[step])
  self:_UpdateHighLightObj(step)
  if self._curOrderform._step == OrderformStep.Delivery then
    self:_CheckOrderformReady()
  end
end

function UIMiniGameController:_HideCurOrderformImg()
  for key, value in pairs(OrderformStep) do
    if value <= OrderformStep.Jam then
      self._stepImg[value].color = OrderformImg.ImgColor[false]
    end
  end
end

function UIMiniGameController:_InitGuestOrderformWights()
  local v2 = Vector2(0.5, 0.5)
  self._guestOrderformItem:SpawnObjects("UIMiniGameOrderformItem", self._guestOrderformListLength)
  self._guestOrderformWidgets = self._guestOrderformItem:GetAllSpawnList()
  for key, value in pairs(self._guestOrderformWidgets) do
    value.view.transform.anchorMin = v2
    value.view.transform.anchorMax = v2
    value.view.transform.pivot = v2
    value:SetActive(false)
  end
end

function UIMiniGameController:_ShowGuestOrderformWidget(index)
  self._guestOrderformWidgets[index]:SetActive(true)
  self._guestOrderformWidgets[index]:SetPosition(self._guestgameObject[index].transform.position, self._orderformWidgetOffset)
  self._guestOrderformWidgets[index]:SetData(self._guestOrderformList[index])
end

function UIMiniGameController:_InitGuestScoreWights()
  local v2 = Vector2(0.5, 0.5)
  self._guestScoreItem:SpawnObjects("UIMiniGameScore", self._guestOrderformListLength)
  self._guestScoreWidgets = self._guestScoreItem:GetAllSpawnList()
  for key, value in pairs(self._guestScoreWidgets) do
    value.view.transform.anchorMin = v2
    value.view.transform.anchorMax = v2
    value.view.transform.pivot = v2
    value:SetActive(false)
  end
end

function UIMiniGameController:_ShowGuestScore(score, index)
  self._guestScoreWidgets[index]:SetActive(true)
  self._guestScoreWidgets[index]:SetPosition(self._guestgameObject[index].transform.position, self._scoreWidgetOffset)
  self._guestScoreWidgets[index]:SetData(score)
end

function UIMiniGameController:_InitGuestWidgets()
  local ids = self._cfg_stage.OrderFormID
  local cfg_orderforms = Cfg.cfg_summer_minigame_orderforms
  local guestIds = {}
  for i = 1, #ids do
    local cfg_orderform = cfg_orderforms[ids[i]]
    if not table.icontains(guestIds, cfg_orderform.Guest) then
      table.insert(guestIds, cfg_orderform.Guest)
    end
  end
  if 0 < #guestIds then
    local widgets = self._guestItem:SpawnObjects("UIMiniGameGuest", #guestIds)
    for i = 1, #guestIds do
      self._guestWidgets[guestIds[i]] = widgets[i]
      self._guestWidgets[guestIds[i]]:SetActive(false)
    end
  end
end

function UIMiniGameController:_ShowGuestWidget(id, index)
  if self._guestWidgets[id] then
    self._guestWidgets[id]:SetActive(true)
    self._guestWidgets[id]:SetPosition(self._guestgameObject[index].transform.position, self._guestWidgetOffet)
    self._guestWidgets[id]:SetData(id)
    AudioHelperController.PlayUISoundAutoRelease(CriAudioIDConst.Summer1GameGuestAppear)
  end
end

function UIMiniGameController:SKillBtnOnClick(go)
  if self._skillPointDelta < self._cfg_minigame.IceSoulPoint then
    return
  end
  if self._elapseTime >= self._cfg_stage.Time then
    return
  end
  if self._gameState == MiniGameState.Skill then
    return
  end
  self._gameState = MiniGameState.Skill
  self._viceObj:SetActive(true)
  AudioHelperController.PlayUISoundAutoRelease(CriAudioIDConst.Summer1GameSkillLoop)
  AudioHelperController.SetBGMMixerGroup(AudioConstValue.AuroralTimeMixerGroupName, AudioConstValue.AuroralTimeMixerValue)
  GameGlobal.Timer():AddEvent(1000, function()
    self._viceObj:SetActive(false)
    self:_DoSkill()
  end)
end

function UIMiniGameController:_DoSkill()
  self._skillPoint = 0
  self._skillPointDelta = 0
  self._skillTime = 0
  self._clickInterval = 0
  self._autoDoOrderformIndex = 0
  self._skillObj:SetActive(true)
  self._fireSpine:SetAnimation(0, "crazy", true)
  self:_PlaySkillAnimation(false)
  self:_CurOrderformClear()
  self._gameStateskillAnimation:Play(MGAnimations.MiniGameState[self._gameState].Start)
  GameGlobal.Timer():AddEvent(633, function()
    self._gameStateskillAnimation:Play(MGAnimations.MiniGameState[self._gameState].Loop)
  end)
end

function UIMiniGameController:_PlaySkillAnimation(enable)
  self._skillFullFx:SetActive(enable)
  if enable then
    self._skillAnimation:Play(MGAnimations.Other.Skill)
  else
    self._skillAnimation:Stop()
  end
end

function UIMiniGameController:SkillAreaOnClick(go)
  if self._gameState == MiniGameState.Skill and self._clickInterval <= 0 then
    self._clickInterval = self._cfg_minigame.ClickInterval
    self:_AutoDo()
  end
end

function UIMiniGameController:_AutoDo()
  self:_RefreshAutoOrderformIndex()
  if self._autoDoOrderformIndex <= 0 then
    return
  end
  local orderform = self._guestOrderformList[self._autoDoOrderformIndex]
  if orderform then
    local step = 0
    local param = 0
    if orderform._step == OrderformStep.Weight then
      step = orderform._step
      param = orderform._weight
    elseif orderform._step == OrderformStep.Ingredient then
      step = orderform._step
      param = orderform._ingredient
    elseif orderform._step == OrderformStep.Jam then
      step = orderform._step
      param = orderform._jam
    elseif orderform._step == OrderformStep.Delivery then
      self:_Delivery(self._autoDoOrderformIndex, false)
      step = 0
      param = 0
    end
    if 0 < step and 0 < param then
      self:_Do(step, param)
      orderform:NextStep()
    end
  end
end

function UIMiniGameController:_RefreshAutoOrderformIndex()
  if self._autoDoOrderformIndex <= 0 then
    self._autoDoOrderformIndex = self:_GetACandoOrderformIndex()
  else
    local orderform = self._guestOrderformList[self._autoDoOrderformIndex]
    if not orderform or not orderform:CanDo() then
      if self._curOrderform._step > OrderformStep.Weight then
        local newIndex = self:_GetReplaceAutoOrderformIndex()
        if newIndex <= 0 then
          self:_CurOrderformClear()
        else
          self._guestOrderformList[newIndex]._step = self._curOrderform._step
          self._autoDoOrderformIndex = newIndex
        end
      else
        self._autoDoOrderformIndex = self:_GetACandoOrderformIndex()
      end
    end
  end
end

function UIMiniGameController:_GetReplaceAutoOrderformIndex()
  for i = 1, self._guestOrderformListLength do
    local orderform = self._guestOrderformList[i]
    if orderform and orderform:CanDo() and not self:_IsWrong(orderform) then
      return i
    end
  end
  return 0
end

function UIMiniGameController:_GetACandoOrderformIndex()
  for i = 1, self._guestOrderformListLength do
    if self._guestOrderformList[i] and self._guestOrderformList[i]:CanDo() then
      return i
    end
  end
  return 0
end

function UIMiniGameController:_IsWrong(orderform)
  if self._curOrderform._weight > 0 and self._curOrderform._weight ~= orderform._weight then
    return true
  end
  if 0 < self._curOrderform._ingredient and self._curOrderform._ingredient ~= orderform._ingredient then
    return true
  end
  if 0 < self._curOrderform._jam and self._curOrderform._jam ~= orderform._jam then
    return true
  end
  return false
end

function UIMiniGameController:TrashBtnOnClick(go)
  self:Lock("UIMiniGameController:Trash")
  self._plateAnimation:Play(MGAnimations.Other.Trash)
  self._trashSpine:SetAnimation(0, "open", false)
  GameGlobal.Timer():AddEvent(1067, function()
    self._plateAnimation:Stop()
    self:_CurOrderformClear()
    self:_ReSetPlatePosition()
    AudioHelperController.PlayUISoundAutoRelease(CriAudioIDConst.Summer1GameTrash)
    self:UnLock("UIMiniGameController:Trash")
  end)
end

function UIMiniGameController:_ReSetPlatePosition()
  self._plateRoot.anchoredPosition = self._plateRootRectTransformPosition
  self._plateRootCanvasGroup.alpha = 1
end

function UIMiniGameController:_CurOrderformClear()
  self._curOrderform:Clear()
  self:_HideCurOrderformImg()
  self:_HideHighLightObj()
  self:_CheckOrderformReady()
end

function UIMiniGameController:_HideHighLightObj()
  for key, value in pairs(OrderformStep) do
    if self._highLightObj[value] then
      self._highLightObj[value]:SetActive(false)
    end
  end
end

function UIMiniGameController:ConfirmBtnOnClick(go)
  AudioHelperController.PlayUISoundAutoRelease(CriAudioIDConst.Summer1ClickNormal)
  self:_PlayGameOverStory()
end

function UIMiniGameController:_Delivery(index, ignoreState)
  if self._curOrderform._step == OrderformStep.Delivery then
    local waitingOrderform = self._guestOrderformList[index]
    if waitingOrderform and (waitingOrderform._state == OrderformState.Waiting or ignoreState) then
      if self._curOrderform:Equal(waitingOrderform) then
        self:_GuideGameing()
        self:_WhenOrderformSuccess(index)
      else
        self:_WhenOrderformFail(index)
      end
      self:_RecordGuest(waitingOrderform._guest)
      self:_CurOrderformClear()
    end
  else
    ToastManager.ShowToast(StringTable.Get("str_summer_minigame_unfinished"))
  end
end

function UIMiniGameController:_WhenOrderformSuccess(index)
  self._orderformCount = self._orderformCount + 1
  if self._gameState == MiniGameState.Playing then
    self._skillPoint = math.min(self._skillPoint + 1, self._cfg_minigame.IceSoulPoint)
  end
  local time = 1 - self._guestOrderformList[index]._elapseWaitingTime / self._guestOrderformList[index]._waitingTime
  local scoreDelta = math.floor(self._cfg_stage.BaseScore * self:_GetTimeScore(time * 100) * self._bonus)
  self._score = self._score + scoreDelta
  self._bonus = self._cfg_minigame.Bonus + self._cfg_minigame.BonusDelta * self._orderformCount
  self._bounsValue:SetText(self._bonus)
  self._guestOrderformList[index]._score = scoreDelta
  self._guestOrderformList[index]._state = OrderformState.Success
  self._tempScoreDelta = math.ceil((self._score - self._tempScore) / App.TargetFrame * 2)
  self._scoreAnimation:Play(MGAnimations.Other.Score)
  AudioHelperController.PlayUISoundAutoRelease(CriAudioIDConst.Summer1GameSuccess)
end

function UIMiniGameController:_GuideGameing()
  if self:_Guideing() then
    self._guideTime = 1.5
  end
end

function UIMiniGameController:_WhenOrderformFail(index)
  self._guestOrderformList[index]._score = 0
  self._guestOrderformList[index]._state = OrderformState.Fail
  AudioHelperController.PlayUISoundAutoRelease(CriAudioIDConst.Summer1GameFail)
end

function UIMiniGameController:_RefreshSkillEffect(percent)
  local mask_y, pos_y = self:_GetSkillEffectParam(percent)
  self._skillPointMaterial:SetTextureOffset("_MaskTex", Vector2(0, mask_y))
  self._skillParticleSystemRect.anchoredPosition = Vector3(0, pos_y, 0)
end

function UIMiniGameController:_GetSkillEffectParam(percent)
  if percent == 0 then
    return 0.5, -160
  end
  if percent == 1.0 then
    return 0, 215
  end
  return 0.425 - 0.335 * percent, -100 + 300 * percent
end

function UIMiniGameController:_RecordGuest(guest)
  local temp = {}
  local flag = false
  for key, value in pairs(self._guestRecord) do
    self._guestRecord[key] = self._guestRecord[key] + 1
    if self._guestRecord[key] >= self._orderformInterval then
      table.insert(temp, key)
    end
    if key == guest then
      flag = true
    end
  end
  for i = 1, #temp do
    self._guestRecord[temp[i]] = nil
  end
  if not flag and guest then
    self._guestRecord[guest] = 1
  end
end

function UIMiniGameController:_Eliminate(guest)
  for i = 1, #self._guestOrderformList do
    if self._guestOrderformList[i] and self._guestOrderformList[i]._guest == guest then
      return false
    end
  end
  for key, value in pairs(self._guestRecord) do
    if key == guest then
      return false
    end
  end
  return true
end

function UIMiniGameController:_GameOver(playstory)
  self._gameState = MiniGameState.Over
  self._playstory = playstory
  self:_ShowFinish()
end

function UIMiniGameController:_PlayGameOverStory()
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

function UIMiniGameController:_ShowFinish()
  self._finish:SetActive(true)
  self._scoreValue:SetText(self._score)
  self._tempScore = 0
  self._tempScoreDelta = math.ceil(self._score / App.TargetFrame)
  self._gameStateAnimation:Play(MGAnimations.MiniGameState[self._gameState])
  AudioHelperController.PlayUISoundAutoRelease(CriAudioIDConst.Summer1GameFinish)
  self:_SendScoreToServer()
end

function UIMiniGameController:_SendScoreToServer()
  self:StartTask(function(TT)
    local res = AsyncRequestRes:New()
    res = self._component:HandleScoreMsg(TT, res, self._stage_id, self._score)
    if not res:GetSucc() then
      Log.error("handle score msg fail.")
    end
  end)
end

function UIMiniGameController:GuideGameGuest()
  local cfg_orderform = Cfg.cfg_summer_minigame_orderforms[self._cfg_minigame.GuideOrderform]
  if cfg_orderform and self._guestWidgets[cfg_orderform.Guest] then
    return self._guestWidgets[cfg_orderform.Guest].view.gameObject
  end
  return nil
end

function UIMiniGameController:GuideOrderformItem()
  return self._guestOrderformWidgets[self._guideIndex].view.gameObject
end
