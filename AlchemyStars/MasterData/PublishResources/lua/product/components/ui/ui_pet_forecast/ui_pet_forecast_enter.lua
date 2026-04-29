require("ui_side_enter_item_base")
_class("UIPetForecastEnter", UISideEnterItem_Base)
UIPetForecastEnter = UIPetForecastEnter

function UIPetForecastEnter.GetLocalDBKey(id)
  local str = "UIPetForecastEnter_New_" .. id
  local key = UIActivityHelper.GetLocalDBKeyWithPstId(str .. "_")
  return key
end

function UIPetForecastEnter:OnShow()
  self.mSignIn = self:GetModule(SignInModule)
  self.data = self.mSignIn:GetPredictionData()
  self.root = self:GetGameObject()
  self:AttachEvent(GameEventType.ActivityCloseEvent, self._CheckClose)
  self:AttachEvent(GameEventType.CampaignComponentStepChange, self._OnCampaignComponentStepChange)
  self:AttachEvent(GameEventType.PredictionDataChanged, self.PredictionDataUpdate)
  self:AttachEvent(GameEventType.PredictionStateChanged, self.PredictionDataUpdate)
  self:AttachEvent(GameEventType.RolePropertyChanged, self.PredictionDataChanged)
  self:AttachEvent(GameEventType.ItemCountChanged, self.PredictionDataChanged)
  self:_SetTitle()
end

function UIPetForecastEnter:OnHide()
  self.root = nil
  self:DetachEvent(GameEventType.ActivityCloseEvent, self._CheckClose)
  self:DetachEvent(GameEventType.CampaignComponentStepChange, self._OnCampaignComponentStepChange)
  self:DetachEvent(GameEventType.PredictionDataChanged, self.PredictionDataUpdate)
  self:DetachEvent(GameEventType.PredictionStateChanged, self.PredictionDataUpdate)
  self:DetachEvent(GameEventType.RolePropertyChanged, self.PredictionDataChanged)
  self:DetachEvent(GameEventType.ItemCountChanged, self.PredictionDataChanged)
  self:CancelTimerEvent()
end

function UIPetForecastEnter:CancelTimerEvent()
  if self.te then
    GameGlobal.Timer():CancelEvent(self.te)
  end
end

function UIPetForecastEnter:_CheckOpen(TT)
  local res, replyEvent = self.mSignIn:PredictionReq(TT)
  if PetForecastData.CheckCode(res:GetResult(), false) then
    self.data:Init(replyEvent.info)
  else
    self.data.id = 0
  end
  return self.data and self.data.id > 0 and self.data.cfg.cg
end

function UIPetForecastEnter:GetSideEnterRawImage()
  return self.data:GetCfg_cg("enter")
end

function UIPetForecastEnter:DoShow()
  self:_SetTitle()
  self:_SetBg()
end

function UIPetForecastEnter:_CalcNew()
  if self.data and self.data.id > 0 then
    local id = self.data.id
    local key = UIPetForecastEnter.GetLocalDBKey(id)
    return not LocalDB.HasKey(key)
  end
  return false
end

function UIPetForecastEnter:_CalcRed()
  if self.data and self.data.pieces then
    for i, p in ipairs(self.data.pieces) do
      if p.state == PredictionStatus.PRES_UnAccept then
        return true
      end
    end
  end
  return false
end

function UIPetForecastEnter:_CheckClose(id)
  if id == -1 then
    self:StartTask(function(TT)
      local lockName = "UIPetForecastEnter_CheckClose"
      self:Lock(lockName)
      local isOpen = self:_CheckOpen(TT)
      self:UnLock(lockName)
      if not isOpen then
        self._setShowCallback(false)
      end
    end)
  end
end

function UIPetForecastEnter:_OnCampaignComponentStepChange(id)
  if id == -1 then
    self:_CheckPoint()
  end
end

function UIPetForecastEnter:_Refresh(TT)
  self:CancelTimerEvent()
  if self._refreshTask then
    return
  end
  self._refreshTask = true
  local lockName = "UIPetForecastEnter_Refresh"
  self:Lock(lockName)
  local isOpen = self:_CheckOpen(TT)
  if isOpen then
    local nowTimestamp = UICommonHelper.GetNowTimestamp()
    if nowTimestamp < self.data.endTime then
      self.te = GameGlobal.Timer():AddEvent((self.data.endTime - nowTimestamp) * 1000, function()
        self:PredictionDataChanged()
      end)
    end
  else
    self._setShowCallback(false)
  end
  self:_CheckPoint()
  self:UnLock(lockName)
  self._refreshTask = false
end

function UIPetForecastEnter:PredictionDataChanged()
  if not self.root then
    return
  end
  if self.data:IsVigorousChanged() then
    self:StartTask(self._Refresh, self)
  end
end

function UIPetForecastEnter:PredictionDataUpdate()
  if not self.root then
    return
  end
  self:StartTask(self._Refresh, self)
end

function UIPetForecastEnter:_SetTitle()
  local widgetName = "txtTitle"
  local strId = "str_prediction_title_2"
  if widgetName and strId then
    UIWidgetHelper.SetLocalizationText(self, widgetName, StringTable.Get(strId))
  end
end

function UIPetForecastEnter:_SetBg(sideEnterIcon)
  local widgetName = "bg"
  local sideEnterIcon = self:GetSideEnterRawImage()
  if widgetName and sideEnterIcon then
    UIWidgetHelper.SetRawImage(self, widgetName, sideEnterIcon)
  end
end

function UIPetForecastEnter:BtnOnClick(go)
  local prefabName = self.data.prefab
  self:ShowDialog(prefabName)
end
