_class("UIActivityMainBase", UIController)
UIActivityMainBase = UIActivityMainBase

function UIActivityMainBase:LoadDataOnEnter(TT, res, uiParams)
  self._timeModule = GameGlobal.GetModule(SvrTimeModule)
  self._activityConst = UIActivityCustomConst:New(self:GetCampaignType(), self:GetComponentIds())
  self._activityConst:LoadData(TT, res)
  if res and not res:GetSucc() then
    local campModule = GameGlobal.GetModule(CampaignModule)
    campModule:CheckErrorCode(res.m_result, self._activityConst:GetCampaignId(), nil, nil)
  end
end

function UIActivityMainBase:OnShow(uiParams)
  self._buttons = {}
  self._eventRed = self:GetGameObject("EventRed")
  self._loginRed = self:GetGameObject("LoginRed")
  self:InitTopButton(uiParams)
  self._btnPanel = self:GetGameObject("BtnPanel")
  self._showBtn = self:GetGameObject("ShowBtn")
  self._showBtn:SetActive(false)
  self:OnPlayPlot()
  self:AttachEvent(GameEventType.OnActivityTotalAwardGot, self.RefreshData)
  self:AttachEvent(GameEventType.CampaignComponentStepChange, self.RefreshData)
  self:AttachEvent(GameEventType.ActivityMainStatusRefreshEvent, self.RefreshData)
  local buttonConfigs = self:GetButtonStatusConfig()
  if buttonConfigs then
    for i = 1, #buttonConfigs do
      local config = buttonConfigs[i]
      local button = UIActivityMainButtonWidget:New(self:GetUIComponent("UIView", config.Name), self._activityConst, config.ComponentId, config.CheckRedComponentIds, config.CheckNewComponentIds, self._activityConst, config.Callback, config.RemainTimeStr, config.UnlockTimeStr, config.UnlockMissionStr, config.ExtraCustomCheckRed)
      local dayStr, hourStr, minusStr, lessOneMinusStr = self:GetCustomTimeStr()
      button:SetCustomTimeStr(dayStr, hourStr, minusStr, lessOneMinusStr)
      button:Init()
      self._buttons[config.Name] = button
    end
  end
  self._activityConst:ClearEnterNew()
  self:OnInit(uiParams)
  self:Refresh()
end

function UIActivityMainBase:OnHide()
  if self._buttons then
    for k, v in pairs(self._buttons) do
      v:Release()
    end
  end
  self._buttons = nil
  self:DetachEvent(GameEventType.OnActivityTotalAwardGot, self.RefreshData)
  self:DetachEvent(GameEventType.CampaignComponentStepChange, self.RefreshData)
  self:DetachEvent(GameEventType.ActivityMainStatusRefreshEvent, self.RefreshData)
  self:OnRelease()
  self:CloseRefreshDataTask()
end

function UIActivityMainBase:Refresh()
  for k, v in pairs(self._buttons) do
    v:Refresh()
  end
  self:RefreshRedAndNew()
  self:OnRefresh()
end

function UIActivityMainBase:CloseRefreshDataTask()
  if self._taskIdMainBaseRefreshData == nil then
    return
  end
  local task = GameGlobal.TaskManager():FindTask(self._taskIdMainBaseRefreshData)
  if task and task.state ~= TaskState.Stop then
    GameGlobal.TaskManager():KillTask(self._taskIdMainBaseRefreshData)
    self._taskIdMainBaseRefreshData = nil
    self:UnLock("UIActivityMainBase_ReLoadData")
    self:UnLock("UIActivityMainBase_ReLoadDataRefresh")
  end
end

function UIActivityMainBase:RefreshData()
  self:CloseRefreshDataTask()
  self._taskIdMainBaseRefreshData = self:StartTask(function(TT)
    self:Lock("UIActivityMainBase_ReLoadData")
    self:ReLoadData(TT, "Refresh")
    self:Refresh()
    self._taskIdMainBaseRefreshData = nil
    self:UnLock("UIActivityMainBase_ReLoadData")
  end)
end

function UIActivityMainBase:ReLoadData(TT, key)
  self:Lock("UIActivityMainBase_ReLoadData" .. key)
  local res = AsyncRequestRes:New()
  res:SetSucc(true)
  self._activityConst:LoadData(TT, res)
  self:UnLock("UIActivityMainBase_ReLoadData" .. key)
end

function UIActivityMainBase:InitTopButton(uiParams)
  local btns = self:GetUIComponent("UISelectObjectPath", "TopBtn")
  local backBtn = btns:SpawnObject("UICommonTopButton")
  backBtn:SetData(function()
    GameGlobal.TaskManager():StartTask(self.CloseCoro, self)
  end, nil, nil, false, function()
    GameGlobal.TaskManager():StartTask(self.SetButtonShowStatusCoro, self, false)
  end)
end

function UIActivityMainBase:CloseCoro(TT)
  self:Lock("UIActivityN21CCMainController_CloseCoro")
  self:Close(TT)
  self:UnLock("UIActivityN21CCMainController_CloseCoro")
end

function UIActivityMainBase:SetButtonShowStatusCoro(TT, isShow)
  self:SetPanelStatus(TT, isShow)
end

function UIActivityMainBase:PlayComponentPlot(componetId, callback)
  UIActivityHelper.PlayFirstPlot_Component(self._activityConst:GetCampaign(), componetId, function()
    if callback then
      callback()
    end
  end, false)
end

function UIActivityMainBase:PlayPlot(callback)
  UIActivityHelper.PlayFirstPlot_Campaign(self._activityConst:GetCampaign(), callback)
end

function UIActivityMainBase:OnPlayPlot()
  self:PlayPlot()
end

function UIActivityMainBase:RefreshRedAndNew()
  self._eventRed:SetActive(self._activityConst:IsShowBattlePassRed())
  self._loginRed:SetActive(self._activityConst:IsShowComponentRed(self:GetLoginComponentId()))
  if self._buttons then
    for k, v in pairs(self._buttons) do
      v:RefreshRedAndNew()
    end
  end
end

function UIActivityMainBase:ClickButton(name)
  if self._buttons == nil then
    return
  end
  local button = self._buttons[name]
  button:BtnOnClick()
end

function UIActivityMainBase:InfoOnClick()
  local campaign = self._activityConst:GetCampaign()
  local sample = campaign:GetSample()
  if sample == nil then
    ToastManager.ShowToast(StringTable.Get("str_activity_finished"))
    return
  end
  local campId = sample.id
  local introCfg = Cfg.cfg_activity_intro_in_discovery[campId]
  self:ShowDialog("UIIntroLoader", introCfg.IntroLoaderKey)
end

function UIActivityMainBase:EventOnClick()
  UIActivityBattlePassHelper.OpenMainController()
end

function UIActivityMainBase:LoginOnClick()
  local status, time = self._activityConst:GetComponentStatus(self:GetLoginComponentId())
  if status == ActivityComponentStatus.Close or status == ActivityComponentStatus.ActivityEnd then
    ToastManager.ShowToast(StringTable.Get("str_activity_finished"))
    if status == ActivityComponentStatus.ActivityEnd then
      self:SwitchState(UIStateType.UIMain)
    end
    return
  end
  self:ShowDialog("UIActivityTotalLoginAwardController", false, self:GetCampaignType(), self:GetLoginComponentId())
end

function UIActivityMainBase:ShowBtnOnClick()
  GameGlobal.TaskManager():StartTask(self.SetButtonShowStatusCoro, self, true)
end

function UIActivityMainBase:OnInit()
end

function UIActivityMainBase:OnRelease()
end

function UIActivityMainBase:OnRefresh()
end

function UIActivityMainBase:Close(TT)
  self:SwitchState(UIStateType.UIMain)
end

function UIActivityMainBase:SetPanelStatus(TT, isShow)
  self._showBtn:SetActive(not isShow)
  self._btnPanel:SetActive(isShow)
end

function UIActivityMainBase:GetCampaignType()
  return nil
end

function UIActivityMainBase:GetComponentIds()
  return nil
end

function UIActivityMainBase:GetLoginComponentId()
  return nil
end

function UIActivityMainBase:GetButtonStatusConfig()
  return {}
end

function UIActivityMainBase:GetCustomTimeStr()
  return nil
end
