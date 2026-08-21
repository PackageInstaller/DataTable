_class("UIPetForecastItem", UICustomWidget)
UIPetForecastItem = UIPetForecastItem

function UIPetForecastItem:OnShow()
  self.atlas = self:GetAsset("UIPetForecast.spriteatlas", LoadType.SpriteAtlas)
  self.root = self:GetGameObject():GetComponent(typeof(UnityEngine.RectTransform))
  self.lock = self:GetGameObject("lock")
  self.imgFull = self:GetUIComponent("Image", "imgFull")
  self.imgFull.alphaHitTestMinimumThreshold = 0.1
  self.dayOffset = self:GetGameObject("dayOffset"):GetComponent(typeof(UnityEngine.RectTransform))
  self.txtDay = self:GetUIComponent("UILocalizationText", "txtDay")
  self.sldProgress = self:GetUIComponent("Slider", "sldProgress")
  self.txtProgress = self:GetUIComponent("UILocalizationText", "txtProgress")
  self.awards = self:GetUIComponent("UISelectObjectPath", "awards")
  self.tranAwards = self:GetGameObject("awards"):GetComponent(typeof(UnityEngine.RectTransform))
  self.awardsGrid = self:GetGameObject("awards"):GetComponent(typeof(UnityEngine.UI.GridLayoutGroup))
  self.unlock = self:GetGameObject("unlock")
  self.mask = self:GetUIComponent("Image", "mask")
  self.mask.alphaHitTestMinimumThreshold = 0.1
  self.imgPet = self:GetUIComponent("RawImageLoader", "imgPet")
  self.imgSelect = self:GetUIComponent("RawImageLoader", "imgSelect")
  self.imgSelectRaw = self:GetUIComponent("RawImage", "imgSelect")
  self:Select(false)
  self:AttachEvent(GameEventType.PredictionStateChanged, self.PredictionStateChanged)
  self.mSignIn = self:GetModule(SignInModule)
  self.data = self.mSignIn:GetPredictionData()
end

function UIPetForecastItem:OnHide()
  self.imgPet:DestoryLastImage()
  self.imgSelect:DestoryLastImage()
  self:DetachEvent(GameEventType.PredictionStateChanged, self.PredictionStateChanged)
end

function UIPetForecastItem:Flush(day, selectCallback, isShow, refreshCallBack)
  self.day = day
  self.isShow = isShow
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
  self.refreshCallBack = refreshCallBack
  self:FlushState()
end

function UIPetForecastItem:FlushState()
  local piece = self.data:GetPiece(self.day)
  if piece.state == PredictionStatus.PRES_Accepted then
    self.lock:SetActive(false)
    self.unlock:SetActive(true)
    if self.isShow then
      self.imgPet:LoadImage(piece.imgComicUnlock)
      self.mask.sprite = self.atlas:GetSprite(piece.imgBGUnlock)
      self.imgSelect:LoadImage(piece.imgSelectUnlock)
    else
      self.imgPet:LoadImage(piece.imgComic)
      self.mask.sprite = self.atlas:GetSprite(piece.imgBG)
      self.imgSelect:LoadImage(piece.imgSelect)
    end
  else
    self.lock:SetActive(true)
    self.unlock:SetActive(false)
    self.txtDay:SetText(StringTable.Get("str_prediction_day_n", self.day))
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
    if piece.state == PredictionStatus.PRES_UnReach then
      self.imgFull.raycastTarget = false
      self.imgFull.color = self.data.colorUnlock
      if piece:IsCurDay() then
        self.sldProgress.gameObject:SetActive(true)
        self.sldProgress.value = piece.curValue / piece.maxValue
        self.txtProgress:SetText(piece.curValue .. "/" .. piece.maxValue)
      else
        self.sldProgress.gameObject:SetActive(false)
      end
    else
      self.imgFull.color = Color.white
      self.sldProgress.gameObject:SetActive(false)
      self.imgFull.raycastTarget = true
    end
    if self.isShow then
      self.imgFull.sprite = self.atlas:GetSprite(piece.imgFullUnlock)
    else
      self.imgFull.sprite = self.atlas:GetSprite(piece.imgFull)
    end
  end
end

function UIPetForecastItem:PredictionStateChanged(day)
  if self.day == day then
    self:FlushState()
  end
end

function UIPetForecastItem:imgFullOnClick(go)
  self:StartTask(function(TT)
    local toNewUnlockLastState = false
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
        while not GameGlobal.UIStateManager():IsShow("UIGetItemController") do
          YIELD(TT)
        end
      end
      if self.maskOnClick then
        self:maskOnClick(go)
      end
      toNewUnlockLastState = self.data:IsAllAccepted() and self.data:HasNewPieceImage()
      GameGlobal.EventDispatcher():Dispatch(GameEventType.CampaignComponentStepChange, -1, nil, nil)
    end
    self:UnLock("UIPetForecastItem_imgFullOnClick")
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

function UIPetForecastItem:maskOnClick(go)
  if self.selectCallback then
    self.selectCallback(self.day)
  end
end

function UIPetForecastItem:Select(isSelect)
  if isSelect then
    self.imgSelectRaw.color = Color(1, 1, 1, 1)
  else
    self.imgSelectRaw.color = Color(1, 1, 1, 0)
  end
end
