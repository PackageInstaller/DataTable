require("ui_side_enter_center_content_base")
_class("UIPetForecastNew", UISideEnterCenterContentBase)
UIPetForecastNew = UIPetForecastNew

function UIPetForecastNew:DoInit(params)
end

function UIPetForecastNew:DoShow()
  self._forecastData = self._data
  self.mSignIn = self:GetModule(SignInModule)
  self.cfg = self._forecastData.cfg
  self:InitUIComponents()
  self:AttachEvent(GameEventType.ShowItemTips, self.ShowTips)
  self:AttachEvent(GameEventType.RolePropertyChanged, self.ItemCountChanged)
  self.te = UIActivityHelper.StartTimerEvent(self.te, function()
    self:FlushLeftTime()
  end)
  self.curSelectDay = 0
  if self._forecastData and 0 < self._forecastData.id then
    local id = self._forecastData.id
    local key = UIPetForecastEnterNew.GetLocalDBKey(id)
    LocalDB.SetInt(key, 1)
    GameGlobal.EventDispatcher():Dispatch(GameEventType.CampaignComponentStepChange, -1, nil, nil)
  end
  self:Flush()
end

function UIPetForecastNew:DoHide()
  UIWidgetHelper.ClearWidgets(self, "_tipsPool")
  self:Close()
  self.te = UIActivityHelper.CancelTimerEvent(self.te)
  self:DetachEvent(GameEventType.ShowItemTips, self.ShowTips)
  self:DetachEvent(GameEventType.RolePropertyChanged, self.ItemCountChanged)
  UIWidgetHelper.DisposeLocalizedTMPMaterial(self.matReq1)
  UIWidgetHelper.DisposeLocalizedTMPMaterial(self.matReq2)
  UIWidgetHelper.DisposeLocalizedTMPMaterial(self.matReq3)
  UIWidgetHelper.DisposeLocalizedTMPMaterial(self.matReq4)
end

function UIPetForecastNew:DoDestroy()
end

function UIPetForecastNew:InitUIComponents()
  self.mainBg = self:GetUIComponent("RawImageLoader", "mainbg")
  self.beginMonth = self:GetUIComponent("UILocalizedTMP", "startmonth")
  self.beginDay = self:GetUIComponent("UILocalizedTMP", "startday")
  self.endMonth = self:GetUIComponent("UILocalizedTMP", "endmonth")
  self.endDay = self:GetUIComponent("UILocalizedTMP", "endday")
  self.spine = self:GetUIComponent("RawImageLoader", "spine")
  self.introTitle = self:GetUIComponent("UILocalizationText", "introTitle")
  self.introContent = self:GetUIComponent("UILocalizationText", "introContent")
  self.letfTimeBg = self:GetUIComponent("RawImageLoader", "letfTimeBg")
  self.tips = self:GetUIComponent("UILocalizationText", "tips")
  self.mainBg:LoadImage(self.cfg.mainBG)
  if self.cfg.forecastTitle and not string.isnullorempty(self.cfg.forecastTitle) then
    self.introTitle:SetText(StringTable.Get(self.cfg.forecastTitle))
    self.introContent:SetText(StringTable.Get(self.cfg.forecastContent))
  else
    self.introTitle.gameObject:SetActive(false)
    self.introContent.gameObject:SetActive(false)
  end
  self.spine:LoadImage(self.cfg.spine)
  self.beginMonth:SetText(self.cfg.beginTime[1])
  self.beginDay:SetText(self.cfg.beginTime[2])
  self.endMonth:SetText(self.cfg.endTime[1])
  self.endDay:SetText(self.cfg.endTime[2])
  self.letfTimeBg:LoadImage(self.cfg.leftTimeIcon)
  self.tips:SetText(StringTable.Get("str_prediction_info"))
  self:LoadTmpMat()
end

function UIPetForecastNew:LoadTmpMat()
  self.matReq1 = UIWidgetHelper.SetLocalizedTMPMaterial(self, "startmonth", "PetForecastMat.mat")
  self.matReq2 = UIWidgetHelper.SetLocalizedTMPMaterial(self, "startday", "PetForecastMat.mat")
  self.matReq3 = UIWidgetHelper.SetLocalizedTMPMaterial(self, "endmonth", "PetForecastMat.mat")
  self.matReq4 = UIWidgetHelper.SetLocalizedTMPMaterial(self, "endday", "PetForecastMat.mat")
end

function UIPetForecastNew:RequestPrediction(TT)
  local lockName = "UIPetForecastNew_RequestPrediction"
  self:Lock(lockName)
  local res = AsyncRequestRes:New()
  res:SetSucc(true)
  if not self._dataLoader then
    self._dataLoader = UIPetForecastDataLoader:New()
  end
  self._data = self._dataLoader:LoadData(TT, res)
  self._forecastData = self._data
  self:Flush()
  self:UnLock(lockName)
end

function UIPetForecastNew:Flush(isShow)
  if not self._forecastData then
    Log.warn("### self._forecastData nil.")
    return
  end
  self:FlushLeftTime()
  self:_SetPieceBtn(isShow)
end

function UIPetForecastNew:FlushLeftTime()
  local text = ""
  local nowTimestamp = UICommonHelper.GetNowTimestamp()
  if HelperProxy:IsCrossDayTo(nowTimestamp) then
    self:StartTask(self.RequestPrediction, self)
  end
  if self._forecastData and nowTimestamp < self._forecastData.endTime then
    local leftSeconds = UICommonHelper.CalcLeftSeconds(self._forecastData.endTime)
    local d, h, m, s = UICommonHelper.S2DHMS(leftSeconds)
    if 1 <= d then
      text = StringTable.Get("str_prediction_left_time_d_h", math.floor(d), math.floor(h))
    elseif 1 <= h then
      text = StringTable.Get("str_prediction_left_time_h_m", math.floor(h), math.floor(m))
    elseif 1 <= m then
      text = StringTable.Get("str_prediction_left_time_m", math.floor(m))
    else
      text = StringTable.Get("str_prediction_left_time_m", "<" .. 1)
    end
  else
    text = StringTable.Get("str_prediction_error_code_1")
    UIActivityHelper.CancelTimerEvent(self.te)
  end
  local color = self.cfg.leftTime
  text = StringTable.Get("str_prediction_left_remain_time", text)
  if color then
    text = "<color=" .. color .. ">" .. text .. "</color>"
  end
  UIWidgetHelper.SetLocalizationText(self, "txtLeftTime", text)
end

function UIPetForecastNew:_SetPieceBtn()
  local isAllAccepted = self._forecastData:IsAllAccepted()
  local len = table.count(self._forecastData.pieces)
  local horizonLayout = self:GetUIComponent("HorizontalLayoutGroup", "Rewards")
  if len == 5 then
    horizonLayout.spacing = 240
  end
  local pieceList = UIWidgetHelper.SpawnObjects(self, "Rewards", "UIPetForecastAwardItemNew", len)
  for i, v in ipairs(pieceList) do
    local awardInfo = self._forecastData.pieces[i].awards[1]
    local tplId = awardInfo[1]
    local count = awardInfo[2]
    v:Flush(i, tplId, count, self._forecastData.curDay == i, self._forecastData.pieces[i].state, function(TT)
      if self._forecastData.pieces[i] and self._forecastData.pieces[i].state == PredictionStatus.PRES_UnAccept then
        self:GetRewards(len)
      else
        GameGlobal.EventDispatcher():Dispatch(GameEventType.ShowItemTips, tplId, v:Trans().transform.position)
      end
    end)
  end
end

function UIPetForecastNew:ShowTips(matid, pos)
  UIWidgetHelper.SetAwardItemTips(self, "_tipsPool", matid, pos)
end

function UIPetForecastNew:Close()
end

function UIPetForecastNew:ItemCountChanged()
  self:StartTask(self.RequestPrediction, self)
end

function UIPetForecastNew:GetRewards(len)
  self:StartTask(function(TT)
    local lockName = "UIPetForecastBtn:_Start_Req"
    local toNewUnlockLastState = false
    self:Lock(lockName)
    local toClose = false
    local t = {}
    for i = 1, len do
      if self._forecastData.pieces[i].state == PredictionStatus.PRES_UnAccept then
        local res, replyEvent = self.mSignIn:PredictionAwardReq(TT, i, self._forecastData.id)
        if res:GetResult() == Prediction_Result_Code.PREDICTION_SWITCH then
          ToastManager.ShowToast(StringTable.Get("str_prediction_error_activity_finished"))
          toClose = true
        elseif PetForecastData.CheckCode(res:GetResult(), true) then
          self._forecastData:UpdateState(i, PredictionStatus.PRES_Accepted)
          local piece = self._forecastData:GetPiece(i)
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
        end
      end
    end
    YIELD(TT, 800)
    if t and table.count(t) > 0 then
      GameGlobal.UIStateManager():ShowDialog("UIGetItemController", t, function()
        self:Flush()
      end)
      while not GameGlobal.UIStateManager():IsShow("UIGetItemController") do
        YIELD(TT)
      end
    end
    toNewUnlockLastState = self._forecastData:IsAllAccepted()
    GameGlobal.EventDispatcher():Dispatch(GameEventType.CampaignComponentStepChange, -1, nil, nil)
    self:UnLock(lockName)
    if toClose then
      GameGlobal.EventDispatcher():Dispatch(GameEventType.PredictionDataChanged)
    end
    if toNewUnlockLastState then
      while GameGlobal.UIStateManager():IsShow("UIGetItemController") do
        YIELD(TT)
      end
      local uiPetForecast = self:RootUIOwner()
    end
  end, self)
end
