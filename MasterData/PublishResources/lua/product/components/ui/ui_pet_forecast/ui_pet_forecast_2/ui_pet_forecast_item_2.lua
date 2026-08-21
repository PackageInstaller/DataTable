_class("UIPetForecastItem2", UICustomWidget)
UIPetForecastItem2 = UIPetForecastItem2

function UIPetForecastItem2:OnShow()
  self.atlas = self:GetAsset("UIPetForecast.spriteatlas", LoadType.SpriteAtlas)
  self.root = self:GetGameObject():GetComponent(typeof(UnityEngine.RectTransform))
  self.imgClick = self:GetUIComponent("Image", "imgClick")
  self.imgComic = self:GetUIComponent("RawImageLoader", "imgComic")
  self.imgSelect = self:GetUIComponent("RawImageLoader", "imgSelect")
  self.imgSelectRaw = self:GetUIComponent("RawImage", "imgSelect")
  self.imgUnlock = self:GetUIComponent("RawImageLoader", "imgUnlock")
  self.imgLock = self:GetUIComponent("Image", "imgLock")
  self.goDayOffset = self:GetGameObject("dayOffset")
  self.dayOffset = self.goDayOffset:GetComponent(typeof(UnityEngine.RectTransform))
  self.txtDay = self:GetUIComponent("UILocalizationText", "txtDay")
  self.sldProgress = self:GetUIComponent("Slider", "sldProgress")
  self.txtProgress = self:GetUIComponent("UILocalizationText", "txtProgress")
  self.goAwards = self:GetGameObject("awards")
  self.awards = self:GetUIComponent("UISelectObjectPath", "awards")
  self.tranAwards = self:GetGameObject("awards"):GetComponent(typeof(UnityEngine.RectTransform))
  self.awardsGrid = self:GetGameObject("awards"):GetComponent(typeof(UnityEngine.UI.GridLayoutGroup))
  self:Select(false)
  self:AttachEvent(GameEventType.PredictionStateChanged, self.PredictionStateChanged)
  self.mSignIn = self:GetModule(SignInModule)
  self.data = self.mSignIn:GetPredictionData()
end

function UIPetForecastItem2:OnHide()
  self.imgComic:DestoryLastImage()
  self.imgSelect:DestoryLastImage()
  self:DetachEvent(GameEventType.PredictionStateChanged, self.PredictionStateChanged)
end

function UIPetForecastItem2:Flush(day, selectCallback)
  self.day = day
  local piece = self.data:GetPiece(day)
  self.selectCallback = selectCallback
  local v05 = Vector2.one * 0.5
  self.root.anchorMin = v05
  self.root.anchorMax = v05
  self.root.anchoredPosition = piece.pos
  self.root.sizeDelta = piece.wh
  self.tranAwards.anchoredPosition = piece.apos
  self.tranAwards.sizeDelta = piece.awh
  self.awardsGrid.cellSize = piece.awh
  self.dayOffset.anchoredPosition = piece.ppos
  self:FlushState()
end

function UIPetForecastItem2:FlushState()
  local piece = self.data:GetPiece(self.day)
  local spriteBG = self.atlas:GetSprite(piece.imgBG)
  self.imgClick.sprite = spriteBG
  if piece.state == PredictionStatus.PRES_UnReach then
    self:SetImageActive(self.imgUnlock, true)
    self.imgLock.gameObject:SetActive(true)
    self.goDayOffset:SetActive(true)
    self.goAwards:SetActive(true)
    self:SetImageActive(self.imgComic, false)
    self:SetImageActive(self.imgSelect, false)
    self.imgUnlock:LoadImage(piece.imgFull)
    self.imgLock.sprite = spriteBG
    if piece:IsCurDay() then
      self.sldProgress.gameObject:SetActive(true)
      self.sldProgress.value = piece.curValue / piece.maxValue
      self.txtProgress:SetText(piece.curValue .. "/" .. piece.maxValue)
    else
      self.sldProgress.gameObject:SetActive(false)
    end
    self:FlushDay()
    self:FlushAward()
  elseif piece.state == PredictionStatus.PRES_UnAccept then
    self:SetImageActive(self.imgUnlock, true)
    self.imgLock.gameObject:SetActive(false)
    self.sldProgress.gameObject:SetActive(false)
    self.goDayOffset:SetActive(true)
    self.goAwards:SetActive(true)
    self:SetImageActive(self.imgComic, false)
    self:SetImageActive(self.imgSelect, false)
    self.imgUnlock:LoadImage(piece.imgFull)
    self:FlushDay()
    self:FlushAward()
  elseif piece.state == PredictionStatus.PRES_Accepted then
    self:SetImageActive(self.imgUnlock, false)
    self.imgLock.gameObject:SetActive(false)
    self.sldProgress.gameObject:SetActive(false)
    self.goDayOffset:SetActive(false)
    self.goAwards:SetActive(false)
    self:SetImageActive(self.imgComic, true)
    self:SetImageActive(self.imgSelect, true)
    self.imgComic:LoadImage(piece.imgComic)
    self.imgSelect:LoadImage(piece.imgSelect)
  else
    Log.error("### invalid state. ", piece.state)
  end
end

function UIPetForecastItem2:FlushDay()
  self.txtDay:SetText(StringTable.Get("str_prediction_day_n", self.day))
end

function UIPetForecastItem2:FlushAward()
  local piece = self.data:GetPiece(self.day)
  local len = table.count(piece.awards)
  self.awards:SpawnObjects("UIPetForecastAwardItem", len)
  local awards = self.awards:GetAllSpawnList()
  for i, v in ipairs(awards) do
    local awardInfo = piece.awards[i]
    local tplId = awardInfo[1]
    v:Flush(tplId, awardInfo[2], function()
      if piece and piece.state == PredictionStatus.PRES_UnAccept then
        self:imgFullOnClick(self:GetGameObject())
      else
        GameGlobal.EventDispatcher():Dispatch(GameEventType.ShowItemTips, tplId, v:Trans().transform.position)
      end
    end)
  end
end

function UIPetForecastItem2:SetImageActive(img, isShow)
  local go = self:GetGameObject(img.name)
  go:SetActive(isShow)
end

function UIPetForecastItem2:PredictionStateChanged(day)
  if self.day == day then
    self:FlushState()
  end
end

function UIPetForecastItem2:imgFullOnClick(go)
  self:StartTask(function(TT)
    self:Lock("UIPetForecastItem_imgFullOnClick")
    local toClose = false
    local res, replyEvent = self.mSignIn:PredictionAwardReq(TT, self.day, self.data.id)
    if res:GetResult() == Prediction_Result_Code.PREDICTION_SWITCH then
      ToastManager.ShowToast(StringTable.Get("str_prediction_error_activity_finished"))
      toClose = true
    elseif PetForecastData.CheckCode(res:GetResult(), true) then
      self.data:UpdateState(self.day, PredictionStatus.PRES_Accepted)
      self:FlushState()
      YIELD(TT, 800)
      local t = {}
      local piece = self.data:GetPiece(self.day)
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
        GameGlobal.EventDispatcher():Dispatch(GameEventType.CampaignComponentStepChange, -1, nil, nil)
      end
      if self.imgClickOnClick then
        self:imgClickOnClick(go)
      end
    end
    self:UnLock("UIPetForecastItem_imgFullOnClick")
    if toClose then
      GameGlobal.EventDispatcher():Dispatch(GameEventType.PredictionDataChanged)
    end
  end, self)
end

function UIPetForecastItem2:imgClickOnClick(go)
  if self.selectCallback then
    self.selectCallback(self.day)
  end
end

function UIPetForecastItem2:Select(isSelect)
  if isSelect then
    self.imgSelectRaw.color = Color(1, 1, 1, 1)
  else
    self.imgSelectRaw.color = Color(1, 1, 1, 0)
  end
end
