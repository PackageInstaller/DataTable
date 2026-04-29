_class("UIActivityCommonCampaignEnter", UICustomWidget)
UIActivityCommonCampaignEnter = UIActivityCommonCampaignEnter

function UIActivityCommonCampaignEnter:OnShow(uiParams)
  self:_AttachEvents()
end

function UIActivityCommonCampaignEnter:OnHide()
  self:_DetachEvents()
end

function UIActivityCommonCampaignEnter:SetData(campaign, useStateUI, callback)
  self._campaign = campaign
  self._useStateUI = useStateUI
  self._callback = callback
  self:_CheckPoint()
end

function UIActivityCommonCampaignEnter:BtnOnClick()
  if self._callback then
    self._callback()
  else
    UIActivityHelper.PlayFirstPlot_Campaign(self._campaign, function()
      self._campaign:OpenMainUI(self._useStateUI)
    end, false)
  end
end

function UIActivityCommonCampaignEnter:_AttachEvents()
  self:AttachEvent(GameEventType.CampaignComponentStepChange, self._OnComponentStepChange)
  self:AttachEvent(GameEventType.QuestUpdate, self._OnQuestUpdate)
end

function UIActivityCommonCampaignEnter:_DetachEvents()
  self:DetachEvent(GameEventType.CampaignComponentStepChange, self._OnComponentStepChange)
  self:DetachEvent(GameEventType.QuestUpdate, self._OnQuestUpdate)
end

function UIActivityCommonCampaignEnter:_OnComponentStepChange(campaign_id, component_id, component_step)
  if self._campaign and self._campaign._id == campaign_id then
    self:_CheckPoint()
  end
end

function UIActivityCommonCampaignEnter:_OnQuestUpdate()
  self:_CheckPoint()
end

function UIActivityCommonCampaignEnter:_CheckPoint()
  local newObj = self:GetGameObject("new")
  local redObj = self:GetGameObject("red")
  local new = UIActivityHelper.CheckCampaignSampleNewPoint(self._campaign)
  local red = UIActivityHelper.CheckCampaignSampleRedPoint(self._campaign)
  UIActivityHelper.SetWidgetNewAndRed(newObj, new, redObj, red)
end
