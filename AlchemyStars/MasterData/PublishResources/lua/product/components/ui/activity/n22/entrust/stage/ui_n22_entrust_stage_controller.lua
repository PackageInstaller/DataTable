_class("UIN22EntrustStageController", UIController)
UIN22EntrustStageController = UIN22EntrustStageController

function UIN22EntrustStageController:_PlayAnimAndSwitchState(levelId)
  if not self._campaign:CheckComponentOpen(self._componentId) then
    local result = self._campaign:CheckComponentOpenClientError(self._componentId)
    self._campaign:ShowErrorToast(result, true)
    return
  end
  UIWidgetHelper.PlayAnimation(self, "_anim", "uieff_UIN22EntrustStageController_out", 267, function()
    self:SwitchState(UIStateType.UIN22EntrustLevelController, levelId, true)
  end)
end

function UIN22EntrustStageController:_SetCommonTopButton()
  self._backBtns = UIWidgetHelper.SpawnObject(self, "_backBtns", "UICommonTopButton")
  self._backBtns:SetData(function()
    self._campaign._campaign_module:CampaignSwitchState(true, UIStateType.UIActivityN22MainController, UIStateType.UIMain, nil, self._campaign._id)
  end, function()
    self:ShowDialog("UIIntroLoader", "UIN22Entrust_Intro")
  end, nil, false)
end

function UIN22EntrustStageController:_SetImgRT(imgRT)
  if imgRT ~= nil then
    local rt = self:GetUIComponent("RawImage", "rt")
    rt.texture = imgRT
    return true
  end
  return false
end

function UIN22EntrustStageController:LoadDataOnEnter(TT, res, uiParams)
  self._campaignType = ECampaignType.CAMPAIGN_TYPE_N22
  self._componentId = ECampaignN22ComponentID.ECAMPAIGN_N22_ENTRUST
  self._campaign = UIActivityCampaign:New()
  self._campaign:LoadCampaignInfo(TT, res, self._campaignType, self._componentId)
  if res and not res:GetSucc() then
    self._campaign:CheckErrorCode(res.m_result, nil, nil)
    return
  end
  if not self._campaign:CheckComponentOpen(self._componentId) then
    res.m_result = self._campaign:CheckComponentOpenClientError(self._componentId)
    self._campaign:ShowErrorToast(res.m_result, true)
    return
  end
  self._component = self._campaign:GetComponent(self._componentId)
end

function UIN22EntrustStageController:OnShow(uiParams)
  self:_AttachEvents()
  self:_SetImgRT(uiParams[1])
  self._isPlayEnter = uiParams[2] or false
  if self._isPlayEnter then
    UIWidgetHelper.PlayAnimation(self, "_anim", "uieff_UIN22EntrustStageController_in", 667)
  end
  self:_Init()
end

function UIN22EntrustStageController:OnHide()
  self:_DetachEvents()
end

function UIN22EntrustStageController:_Init()
  self:_ClearNew()
  self:_SetCommonTopButton()
  self:_Refresh()
end

function UIN22EntrustStageController:_ClearNew()
  self._component:EntrustStageClearNew()
end

function UIN22EntrustStageController:_Refresh()
  self:_SetNode()
  self:_SetLine()
end

function UIN22EntrustStageController:_SetNode()
  local tb = self._component:GetAllLevelId()
  local objs = UIWidgetHelper.SpawnObjects(self, "_nodes", "UIN22EntrustStageNode", table.count(tb))
  for i, v in ipairs(objs) do
    v:SetData(self._campaignType, self._componentId, self._campaign, tb[i], function(levelId)
      self:_PlayAnimAndSwitchState(levelId)
    end)
    v:SetPos(self._component:GetStagePointPos(tb[i]))
    local start = self._isPlayEnter and 200 or 0
    local interval = 30
    local delay = start + (i - 1) * interval
    local time = 500
    v:PlayAnim(i, "uieff_UIN22EntrustStage_Node_in", delay, time)
  end
end

function UIN22EntrustStageController:_SetLine()
  local tb = self._component:GetAllLevelId()
  local objs = UIWidgetHelper.SpawnObjects(self, "_lines", "UIN22EntrustStageLine", table.count(tb) - 1)
  for i, v in ipairs(objs) do
    local from = self._component:GetStagePointPos(tb[i])
    local to = self._component:GetStagePointPos(tb[i + 1])
    v:SetPos(from, to)
    local start = self._isPlayEnter and 400 or 200
    local interval = 30
    local delay = start + (i - 1) * interval
    local time = 30
    v:PlayAnim(i, nil, delay, time)
  end
end

function UIN22EntrustStageController:_AttachEvents()
  self:AttachEvent(GameEventType.ActivityCloseEvent, self._CheckActivityClose)
end

function UIN22EntrustStageController:_DetachEvents()
  self:DetachEvent(GameEventType.ActivityCloseEvent, self._CheckActivityClose)
end

function UIN22EntrustStageController:_CheckActivityClose(id)
  if self._campaign and self._campaign._id == id then
    self:SwitchState(UIStateType.UIMain)
  end
end
