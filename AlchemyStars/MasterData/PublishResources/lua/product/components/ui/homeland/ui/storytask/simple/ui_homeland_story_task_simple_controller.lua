_class("UIHomelandStoryTaskSimpleController", UIController)
UIHomelandStoryTaskSimpleController = UIHomelandStoryTaskSimpleController

function UIHomelandStoryTaskSimpleController:LoadDataOnEnter(TT, res, uiParams)
  self._enterType = uiParams[1]
  self._campaignType = uiParams[2]
  self._componentId = uiParams[3]
  self._campaign = UIActivityCampaign:New()
  self._campaign:LoadCampaignInfo(TT, res, self._campaignType, self._componentId)
  self._campaign:ReLoadCampaignInfo_Force(TT, res)
  if res and not res:GetSucc() then
    self._campaign:CheckErrorCode(res.m_result, nil, nil)
    return
  end
  if not self._campaign:CheckComponentOpen(self._componentId) then
    res.m_result = self._campaign:CheckComponentOpenClientError(self._componentId) or res.m_result
    self._campaign:ShowErrorToast(res.m_result, true)
    return
  end
  self._component = self._campaign:GetComponent(self._componentId)
  self._component:SetPrefsComponentNew("N19TaskComp")
  local cmptId = self._component:GetComponentCfgId()
  local cfgClient = Cfg.cfg_homeland_story_task_client[cmptId]
  if not cfgClient then
    Log.exception("UIHomelandStoryTaskSimpleController:LoadDataOnEnter() cfg_homeland_story_task_client[", cmptId, "] = nil")
  end
  UIWidgetHelper.SetRawImage(self, "img_Bg", cfgClient.Bg)
  UIWidgetHelper.SetRawImage(self, "img_Main", cfgClient.Main)
  UIWidgetHelper.SetRawImage(self, "img_Title", cfgClient.Title)
  local offset = cfgClient.TitleOffset
  if offset then
    local rt = self:GetUIComponent("RectTransform", "img_Title")
    rt.localPosition = Vector3(offset[1], offset[2], 0)
    rt.sizeDelta = Vector2(offset[3], offset[4])
  end
end

function UIHomelandStoryTaskSimpleController:OnShow(uiParams)
  self:_GetComponents()
  self:Refresh()
  self.teActivity = UIActivityHelper.StartTimerEvent(self.teActivity, function()
    self:FlushCDActivity()
  end, 5000)
  self:_AttachEvents()
end

function UIHomelandStoryTaskSimpleController:OnHide(uiParams)
  if self.teActivity then
    self.teActivity = UIActivityHelper.CancelTimerEvent(self.teActivity)
  end
  self:_DetachEvents()
end

function UIHomelandStoryTaskSimpleController:_GetComponents()
  self._timeText = self:GetUIComponent("RollingText", "timeText")
  self._titleText = self:GetUIComponent("UILocalizationText", "titleText")
  self._goText = self:GetUIComponent("UILocalizationText", "goText")
  local cfgClient = Cfg.cfg_homeland_story_task_client[self._component:GetComponentCfgId()]
  self._titleText:SetText(StringTable.Get(cfgClient.Info))
end

function UIHomelandStoryTaskSimpleController:Refresh()
  if self._enterType == 1 then
    self._goText:SetText(StringTable.Get("str_homeland_campainenter_goto"))
  else
    self._goText:SetText(StringTable.Get("str_homeland_campainenter_open"))
  end
  self:GetCfgData()
  self._container = UIWidgetHelper.SpawnObject(self, "content", "UIHomelandStoryTaskSimpleContainer")
  self._container:SetData(self._cfg, self)
end

function UIHomelandStoryTaskSimpleController:FlushCDActivity()
  if not self.strsLeftTime then
    self.strsLeftTime = {
      "str_homeland_campainenter_time_d_h",
      "str_homeland_campainenter_time_h_m",
      "str_homeland_campainenter_time_m"
    }
  end
  local nowTimestamp = UICommonHelper.GetNowTimestamp()
  local cs = self._component:GetComponentInfo()
  if nowTimestamp < cs.m_close_time then
    self:FlushCDText(self._timeText, cs.m_close_time, self.strsLeftTime)
  else
    self._timeText:RefreshText("")
    self.teActivity = UIActivityHelper.CancelTimerEvent(self.teActivity)
  end
end

function UIHomelandStoryTaskSimpleController:FlushCDText(uiText, time, strs)
  local leftSeconds = UICommonHelper.CalcLeftSeconds(time)
  local d, h, m, s = UICommonHelper.S2DHMS(leftSeconds)
  if 1 <= d then
    uiText:RefreshText(StringTable.Get(strs[1], math.floor(d), math.floor(h)))
  elseif 1 <= h then
    uiText:RefreshText(StringTable.Get(strs[2], math.floor(h), math.floor(m)))
  elseif 1 <= m then
    uiText:RefreshText(StringTable.Get(strs[3], math.floor(m)))
  else
    uiText:RefreshText(StringTable.Get(strs[3], "<1"))
  end
end

function UIHomelandStoryTaskSimpleController:GetCfgData()
  self._taskLibrary = Cfg.cfg_homeland_task({})
  self._cfg = Cfg.cfg_component_homeland_task({
    ComponentID = self._component:GetComponentCfgId()
  })
end

function UIHomelandStoryTaskSimpleController:GetTaskItemCfg(taskId)
  return self._taskLibrary[taskId]
end

function UIHomelandStoryTaskSimpleController:GetTaskState(taskId)
  return self._component:GetTaskState(taskId)
end

function UIHomelandStoryTaskSimpleController:GetReward(cfgId)
  self:StartTask(function(TT)
    local res = AsyncRequestRes:New()
    self._component:HandlePangolinGet(TT, res, cfgId)
    if res:GetSucc() then
      self._container:Refresh()
    end
  end, self)
end

function UIHomelandStoryTaskSimpleController:SetLocalDb(taskIndex)
  if self._component then
    self._component:SetDB(taskIndex)
  end
end

function UIHomelandStoryTaskSimpleController:GetLocalDb(taskIndex)
  if self._component then
    return self._component:GetDB(taskIndex)
  end
end

function UIHomelandStoryTaskSimpleController:BackBtnOnClick(go)
  self:CloseDialog()
end

function UIHomelandStoryTaskSimpleController:WhiteBtnOnClick(go)
  self:CloseDialog()
end

function UIHomelandStoryTaskSimpleController:GoBtnOnClick(go)
  if self._enterType == 1 then
    self._functionId = 34
    local functionLockCfg = Cfg.cfg_module_unlock[self._functionId]
    if not functionLockCfg then
      Log.debug("don't have function config")
      return
    end
    local module = GameGlobal.GetModule(RoleModule)
    if module:CheckModuleUnlock(self._functionId) == false then
      local cfg = Cfg.cfg_module_unlock[self._functionId]
      if cfg then
        ToastManager.ShowToast(StringTable.Get(cfg.Tips))
      end
      return
    end
    GameGlobal.GetModule(HomelandModule):SetStoryTaskAutoReq(true, self._cfg[1].StoryTaskID)
    GameGlobal.GetModule(HomelandModule):GetUIModule():LoadHomeland()
  else
    self:StartTask(function(TT)
      GameGlobal.GetModule(HomelandModule):SetStoryTaskAutoReq(true, self._cfg[1].StoryTaskID)
      GameGlobal.GetModule(HomelandModule):HomelandStoryTaskAutoTraceReq(TT)
      self:ShowDialog("UIHomelandStoryTaskController")
      self:CloseDialog()
    end)
  end
end

function UIHomelandStoryTaskSimpleController:_AttachEvents()
  self:AttachEvent(GameEventType.QuestUpdate, self.Refresh)
end

function UIHomelandStoryTaskSimpleController:_DetachEvents()
  self:DetachEvent(GameEventType.QuestUpdate, self.Refresh)
end
