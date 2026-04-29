require("ui_side_enter_item_base")
_class("UISideEnterItem_Campaign", UISideEnterItem_Base)
UISideEnterItem_Campaign = UISideEnterItem_Campaign

function UISideEnterItem_Campaign:OnShow(uiParams)
  self:_AttachEvents()
end

function UISideEnterItem_Campaign:OnHide()
  self:_DetachEvents()
end

function UISideEnterItem_Campaign:_LoadCampaign(TT)
  local campaignType, campaignId = self._btnCfg.CampaignType, self._btnCfg.CampaignId
  local customFunc = UIActivityHelper.CheckCampaignSampleRedPoint_CustomFunc(campaignType)
  self._campaign = nil
  if customFunc then
    local res = AsyncRequestRes:New()
    self._campaign = UIActivityHelper.LoadCampaign(TT, res, campaignType, campaignId)
  else
    self._campaign = UIActivityHelper.LoadCampaign_Local(campaignType, campaignId)
  end
end

function UISideEnterItem_Campaign:_CheckOpen(TT)
  self:_LoadCampaign(TT)
  return self._campaign:CheckCampaignOpen()
end

function UISideEnterItem_Campaign:GetSideEnterRawImage()
  local cfg = Cfg.cfg_campaign[self._campaign._id]
  return cfg and cfg.SideEnterIcon
end

function UISideEnterItem_Campaign:DoShow()
  self:_SetTitle()
  self:_SetBg()
end

function UISideEnterItem_Campaign:_CalcNew()
  return UIActivityHelper.CheckCampaignSampleNewPoint(self._campaign) and 1 or 0
end

function UISideEnterItem_Campaign:_CalcRed()
  return UIActivityHelper.CheckCampaignSampleRedPoint(self._campaign) and 1 or 0
end

function UISideEnterItem_Campaign:_SetTitle()
  local widgetName = self._btnCfg.AutoUITitle
  local cfg = Cfg.cfg_campaign[self._campaign._id]
  local strId = cfg and cfg.CampaignName
  if widgetName and strId then
    UIWidgetHelper.SetLocalizationText(self, widgetName, StringTable.Get(strId))
  end
end

function UISideEnterItem_Campaign:_SetBg()
  local widgetName = self._btnCfg.AutoUIBg
  local sideEnterIcon = self:GetSideEnterRawImage()
  if widgetName and sideEnterIcon then
    UIWidgetHelper.SetRawImage(self, widgetName, sideEnterIcon)
  end
end

function UISideEnterItem_Campaign:_AttachEvents()
  self:AttachEvent(GameEventType.AfterUILayerChanged, self._OnAfterUILayerChanged)
  self:AttachEvent(GameEventType.ActivityCloseEvent, self._OnCampaignClose)
  self:AttachEvent(GameEventType.CampaignComponentStepChange, self._OnComponentStepChange)
  self:AttachEvent(GameEventType.QuestUpdate, self._OnQuestUpdate)
  self:AttachEvent(GameEventType.UISideEnterItemRefreshRedNew, self._OnUISideEnterItemRefreshRedNew)
end

function UISideEnterItem_Campaign:_DetachEvents()
  self:DetachEvent(GameEventType.AfterUILayerChanged, self._OnAfterUILayerChanged)
  self:DetachEvent(GameEventType.ActivityCloseEvent, self._OnCampaignClose)
  self:DetachEvent(GameEventType.CampaignComponentStepChange, self._OnComponentStepChange)
  self:DetachEvent(GameEventType.QuestUpdate, self._OnQuestUpdate)
  self:DetachEvent(GameEventType.UISideEnterItemRefreshRedNew, self._OnUISideEnterItemRefreshRedNew)
end

function UISideEnterItem_Campaign:_OnComponentStepChange(campaign_id, component_id, component_step)
  if self._campaign and self._campaign._id == campaign_id then
    self:_CheckPoint()
  end
end

function UISideEnterItem_Campaign:_OnQuestUpdate()
  if self._campaign then
    self:_CheckPoint()
  end
end

function UISideEnterItem_Campaign:_OnUISideEnterItemRefreshRedNew()
  if self._campaign then
    self:_CheckPoint()
  end
end

function UISideEnterItem_Campaign:_OnAfterUILayerChanged()
  if self._campaign then
    self:_CheckPoint()
  end
end

function UISideEnterItem_Campaign:_OnCampaignClose(id)
  if self._campaign and self._campaign._id == id then
    self._setShowCallback(false)
  end
end
