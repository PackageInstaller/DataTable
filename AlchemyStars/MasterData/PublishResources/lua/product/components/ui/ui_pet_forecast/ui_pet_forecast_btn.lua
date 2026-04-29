_class("UIPetForecastBtn", UICustomWidget)
UIPetForecastBtn = UIPetForecastBtn

function UIPetForecastBtn:OnShow()
  self.imgFull = self:GetUIComponent("Image", "imgFull")
  self.imgFull.alphaHitTestMinimumThreshold = 0.1
  self.mask = self:GetUIComponent("Image", "mask")
  self.mask.alphaHitTestMinimumThreshold = 0.1
  self.mSignIn = self:GetModule(SignInModule)
  self._forecastData = self.mSignIn:GetPredictionData()
  self:AttachEvent(GameEventType.PredictionStateChanged, self.PredictionStateChanged)
end

function UIPetForecastBtn:OnHide()
  self:DetachEvent(GameEventType.PredictionStateChanged, self.PredictionStateChanged)
end

function UIPetForecastBtn:Flush(day, selectCallback, isShow, refreshCallBack, isDebug)
  self.day = day
  self.isShow = isShow
  self._isDebug = isDebug
  self.selectCallback = selectCallback
  self.refreshCallBack = refreshCallBack
  local piece = self._forecastData:GetPiece(day)
  local v05 = Vector2.one * 0.5
  self._forecastData:SetObjTransform(self, v05, v05, piece.pos, piece.wh)
  self.tranAwards = self:GetGameObject("awards"):GetComponent(typeof(UnityEngine.RectTransform))
  self.tranAwards.anchoredPosition = piece.apos
  self.tranAwards.sizeDelta = piece.awh
  self.awardsGrid = self:GetGameObject("awards"):GetComponent(typeof(UnityEngine.UI.GridLayoutGroup))
  self.awardsGrid.cellSize = piece.awh
  self.dayOffset = self:GetGameObject("dayOffset"):GetComponent(typeof(UnityEngine.RectTransform))
  self.dayOffset.anchoredPosition = piece.ppos
  local atlasName, spriteName = self._forecastData:GetCfg_cg("atlasName"), self._forecastData:GetCfg_imgs(self.day, "btn")
  UIWidgetHelper.SetImageSprite(self, "imgFull", atlasName, spriteName)
  UIWidgetHelper.SetImageSprite(self, "mask", atlasName, spriteName)
  local img = self:GetUIComponent("Image", "imgFull")
  img.color = self._isDebug and Color(1, 1, 1, 1) or Color(1, 1, 1, 0)
  self:FlushState()
end

function UIPetForecastBtn:FlushState()
  local piece = self._forecastData:GetPiece(self.day)
  local unlock = piece.state == PredictionStatus.PRES_Accepted
  self:GetGameObject("lock"):SetActive(not unlock)
  self:GetGameObject("unlock"):SetActive(unlock)
  self:_SetReward(piece)
  self:_SetProgress(piece)
end

function UIPetForecastBtn:_SetReward(piece)
  if piece.state ~= PredictionStatus.PRES_Accepted then
    local text = StringTable.Get("str_prediction_day_n", self.day)
    UIWidgetHelper.SetLocalizationText(self, "txtDay", text)
    local len = table.count(piece.awards)
    local objs = UIWidgetHelper.SpawnObjects(self, "awards", "UIPetForecastAwardItem", len)
    for i, v in ipairs(objs) do
      local awardInfo = piece.awards[i]
      local tplId = awardInfo[1]
      v:Flush(tplId, awardInfo[2], function()
        if piece and piece.state == PredictionStatus.PRES_UnAccept then
          self:BtnOnClick(self:GetGameObject())
        else
          GameGlobal.EventDispatcher():Dispatch(GameEventType.ShowItemTips, tplId, v:Trans().transform.position)
        end
      end)
    end
  end
end

function UIPetForecastBtn:_SetProgress(piece)
  local sldProgress = self:GetUIComponent("Slider", "sldProgress")
  local isShow = false
  if piece.state == PredictionStatus.PRES_UnReach and piece:IsCurDay() then
    isShow = true
    sldProgress.value = piece.curValue / piece.maxValue
    local text = piece.curValue .. "/" .. piece.maxValue
    UIWidgetHelper.SetLocalizationText(self, "txtProgress", text)
  end
  sldProgress.gameObject:SetActive(isShow)
end

function UIPetForecastBtn:PredictionStateChanged(day)
  if self.day == day then
    self:FlushState()
  end
end

function UIPetForecastBtn:BtnOnClick(go)
  local piece = self._forecastData:GetPiece(self.day)
  local canGet = piece.state == PredictionStatus.PRES_UnAccept
  local unlock = piece.state == PredictionStatus.PRES_Accepted
  if canGet then
    self:_Start_Req()
  end
  if unlock and self.selectCallback then
    self.selectCallback(self.day)
  end
end

function UIPetForecastBtn:_Start_Req()
  self:StartTask(function(TT)
    local lockName = "UIPetForecastBtn:_Start_Req"
    local toNewUnlockLastState = false
    self:Lock(lockName)
    local toClose = false
    local res, replyEvent = self.mSignIn:PredictionAwardReq(TT, self.day, self._forecastData.id)
    if res:GetResult() == Prediction_Result_Code.PREDICTION_SWITCH then
      ToastManager.ShowToast(StringTable.Get("str_prediction_error_activity_finished"))
      toClose = true
    elseif PetForecastData.CheckCode(res:GetResult(), true) then
      self._forecastData:UpdateState(self.day, PredictionStatus.PRES_Accepted)
      self:FlushState()
      YIELD(TT, 800)
      local t = {}
      local piece = self._forecastData:GetPiece(self.day)
      if piece and piece.awards then
        for i, award in ipairs(piece.awards) do
          if award then
            local a = RoleAsset:New()
            a.assetid = award[1]
            a.count = award[2]
            table.insert(t, a)
          end
        end
      end
      if t and table.count(t) > 0 then
        GameGlobal.UIStateManager():ShowDialog("UIGetItemController", t)
        while not GameGlobal.UIStateManager():IsShow("UIGetItemController") do
          YIELD(TT)
        end
      end
      toNewUnlockLastState = self._forecastData:IsAllAccepted() and self._forecastData:HasNewPieceImage()
      GameGlobal.EventDispatcher():Dispatch(GameEventType.CampaignComponentStepChange, -1, nil, nil)
    end
    self:UnLock(lockName)
    if toClose then
      GameGlobal.EventDispatcher():Dispatch(GameEventType.PredictionDataChanged)
    end
    if toNewUnlockLastState then
      while GameGlobal.UIStateManager():IsShow("UIGetItemController") do
        YIELD(TT)
      end
      local uiPetForecast = self:RootUIOwner()
      uiPetForecast.fsm:ChangeState(StatePetForecast.NewUnlockLast)
    end
    if self.refreshCallBack then
      self.refreshCallBack()
    end
  end, self)
end
