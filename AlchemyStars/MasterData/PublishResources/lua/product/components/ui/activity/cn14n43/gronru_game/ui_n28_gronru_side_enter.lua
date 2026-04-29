_class("UIN28GronruSideEnter", UICustomWidget)
UIN28GronruSideEnter = UIN28GronruSideEnter

function UIN28GronruSideEnter:Constructor()
end

function UIN28GronruSideEnter:OnShow(uiParams)
  self:_GetComponents()
  self:AttachEvent(GameEventType.ActivityCloseEvent, self.OnCampaignClose)
  self._newTimeEvent = GameGlobal.Timer():AddEventTimes(500, TimerTriggerCount.Infinite, function()
    self:CheckNew()
  end)
end

function UIN28GronruSideEnter:OnHide()
  if self._newTimeEvent ~= nil then
    GameGlobal.Timer():CancelEvent(self._newTimeEvent)
    self._newTimeEvent = nil
  end
end

function UIN28GronruSideEnter:_GetComponents()
  self._txtTitle = self:GetUIComponent("UILocalizationText", "txtTitle")
  self._bg = self:GetUIComponent("RawImageLoader", "bg")
  self._red = self:GetGameObject("red")
  self._new = self:GetGameObject("new")
end

function UIN28GronruSideEnter:SetData(info, campaign, callback)
  self._info = info
  self._campaign = campaign
  self:SetTitle()
  self:SetBg()
end

function UIN28GronruSideEnter:SetTitle()
  local widgetName = self._info.CampaignTitle
  if widgetName then
    local cfg = Cfg.cfg_campaign[self._campaign._id]
    local strId = cfg and cfg.CampaignName
    UIWidgetHelper.SetLocalizationText(self, widgetName, StringTable.Get(strId))
  end
end

function UIN28GronruSideEnter:SetBg()
  local sideEnterIcon = self:GetSideEnterRawImage()
  UIWidgetHelper.SetRawImage(self, "bg", sideEnterIcon)
end

function UIN28GronruSideEnter:BtnOnClick(go)
  local open = self._campaign:CheckCampaignOpen()
  if not open then
    self.root:SetActive(open)
    self._setShowCallback(open)
    ToastManager.ShowToast(StringTable.Get("str_activity_finished"))
    return
  end
  local isViewed = self._db:IsViewedPlot()
  local storyID
  local cfg = Cfg.cfg_campaign[self._campaign._id]
  if cfg.FirstEnterStoryID ~= nil then
    storyID = cfg.FirstEnterStoryID[1]
  end
  if isViewed then
    self:ShowDialog(UIStateType.UIN28GronruPlatform)
  elseif storyID ~= nil then
    self:ShowDialog("UIStoryController", storyID, function()
      self:ShowDialog(UIStateType.UIN28GronruPlatform)
    end)
  else
    self:ShowDialog(UIStateType.UIN28GronruPlatform)
  end
  self._db:ViewedPlatform()
  self._db:ViewedPlot()
end

function UIN28GronruSideEnter:BtnOnClick_TestCase(go)
  self._dbNew = self._db:PrivateNewLoadDB()
  self._dbPlot = self._db:PrivatePlotLoadDB()
  self._db:ClearDB()
end

function UIN28GronruSideEnter:OnSideEnterLoad(TT, setShowCallback, setNewRedCallback)
  self._setShowCallback = setShowCallback
  self._setNewRedCallback = setNewRedCallback
  self.root = self:GetGameObject()
  local res = AsyncRequestRes:New()
  self._campaign = UIActivityCampaign:New()
  self._campaign:LoadCampaignInfo(TT, res, self._info.CampaignType, ECampaignN28MiniGameComponentID.ECAMPAIGN_BOUNCE_MISSION)
  self._campaign:ReLoadCampaignInfo_Force(TT, res)
  self._localProcess = nil
  if res and res:GetSucc() then
    self._localProcess = self._campaign:GetLocalProcess()
  end
  if self._localProcess == nil then
    self.root:SetActive(false)
    self._setShowCallback(false)
    return
  end
  self._missionComponent = self._localProcess:GetComponent(ECampaignN28MiniGameComponentID.ECAMPAIGN_BOUNCE_MISSION)
  self._db = UIN28GronruGameLocalDb:New()
  self.root:SetActive(true)
  self._setShowCallback(true)
  self:CheckNew()
end

function UIN28GronruSideEnter:GetSideEnterRawImage()
  local cfg = Cfg.cfg_campaign[self._campaign._id]
  return cfg and cfg.SideEnterIcon
end

function UIN28GronruSideEnter:OnCampaignClose(id)
  if self._campaign._id == id then
    self._setShowCallback(false)
  end
end

function UIN28GronruSideEnter:CheckNew()
  if self._db == nil then
    return
  end
  local showRed = self._db:CheckReddot()
  local showNew = self._db:CheckNew()
  self._red:SetActive(showRed)
  self._new:SetActive(showNew)
  self._setNewRedCallback(showNew, showRed)
end
