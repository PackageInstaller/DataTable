_class("UICampainEnterController", UIController)
UICampainEnterController = UICampainEnterController

function UICampainEnterController:Constructor(Params)
  self._localData = UICampainEnterLocalData:New()
end

function UICampainEnterController:LoadDataOnEnter(TT, res, uiParams)
  self:GetCampaignData(TT, res)
  self.strsLeftTime = {
    "str_homeland_campainenter_time_d_h",
    "str_homeland_campainenter_time_h_m",
    "str_homeland_campainenter_time_m"
  }
end

function UICampainEnterController:GetCampaignData(TT, res)
  self._campaignType = ECampaignType.CAMPAIGN_TYPE_N19_COMMON
  local componentId = ECampaignN19CommonComponentID.PANGOLIN
  self._campaign = UIActivityCampaign:New()
  self._campaign:LoadCampaignInfo(TT, res, self._campaignType, componentId)
  if res and not res:GetSucc() then
    self._campaign:CheckErrorCode(res.m_result, nil, nil)
    return
  end
  if not self._campaign:CheckComponentOpen(componentId) then
    res.m_result = self._campaign:CheckComponentOpenClientError(componentId) or res.m_result
    self._campaign:ShowErrorToast(res.m_result, true)
    return
  end
  self._component = self._campaign:GetComponent(componentId)
  self._component:SetPrefsComponentNew("N19TaskComp")
  Log.fatal("")
end

function UICampainEnterController:OnShow(uiParams)
  self._enterType = uiParams[1]
  self._componentId = uiParams[2]
  self:_GetComponents()
  self:Refresh()
  self.teActivity = UIActivityHelper.StartTimerEvent(self.teActivity, function()
    self:FlushCDActivity()
  end, 5000)
  self:_AttachEvents()
end

function UICampainEnterController:OnHide(uiParams)
  if self.teActivity then
    self.teActivity = UIActivityHelper.CancelTimerEvent(self.teActivity)
  end
  self:_DetachEvents()
end

function UICampainEnterController:_GetComponents()
  self._content = self:GetUIComponent("UISelectObjectPath", "content")
  self._spine = self:GetUIComponent("SpineLoader", "spine")
  self._timeText = self:GetUIComponent("RollingText", "timeText")
  self._titleText = self:GetUIComponent("UILocalizationText", "titleText")
  self._goText = self:GetUIComponent("UILocalizationText", "goText")
  self._bgImg = self:GetUIComponent("RawImageLoader", "bgImage")
end

function UICampainEnterController:Refresh()
  self._titleText:SetText(StringTable.Get("str_homeland_campainenter_title"))
  if self._enterType == 1 then
    self._goText:SetText(StringTable.Get("str_homeland_campainenter_goto"))
  else
    self._goText:SetText(StringTable.Get("str_homeland_campainenter_open"))
  end
  self:GetCfgData()
  self._container = self._content:SpawnObject("UICampainEnterContainer")
  self._container:SetData(self._cfg, self)
end

function UICampainEnterController:GetCfgData()
  self._taskLibrary = Cfg.cfg_homeland_task({})
  self._cfg = Cfg.cfg_component_homeland_task({
    ComponentID = self._componentId
  })
end

function UICampainEnterController:GetItemInfo(Id)
  return self._cfg[Id]
end

function UICampainEnterController:GetTaskItemCfg(taskId)
  return self._taskLibrary[taskId]
end

function UICampainEnterController:GetTaskState(taskId)
  return self._component:GetTaskState(taskId)
end

function UICampainEnterController:GetReward(cfgId)
  self:StartTask(function(TT)
    local res = AsyncRequestRes:New()
    self._component:HandlePangolinGet(TT, res, cfgId)
    if res:GetSucc() then
      self._container:Refresh()
    end
  end, self)
end

function UICampainEnterController:_AttachEvents()
  self:AttachEvent(GameEventType.QuestUpdate, self.DataUpdate)
end

function UICampainEnterController:_DetachEvents()
  self:DetachEvent(GameEventType.QuestUpdate, self.DataUpdate)
end

function UICampainEnterController:FlushCDActivity()
  local nowTimestamp = UICommonHelper.GetNowTimestamp()
  local cs = self._component:GetComponentInfo()
  if nowTimestamp < cs.m_close_time then
    self:FlushCDText(self._timeText, cs.m_close_time, self.strsLeftTime)
  else
    self._timeText:RefreshText("")
    self.teActivity = UIActivityHelper.CancelTimerEvent(self.teActivity)
  end
end

function UICampainEnterController:FlushCDText(uiText, time, strs)
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

function UICampainEnterController:GoBtnOnClick(go)
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
    GameGlobal.GetModule(HomelandModule):SetCampainEnter(true, self._cfg[1].StoryTaskID)
    GameGlobal.GetModule(HomelandModule):GetUIModule():LoadHomeland()
  else
    self:ShowDialog("UIHomelandStoryTaskController")
    self:CloseDialog()
  end
end

function UICampainEnterController:BackBtnOnClick(go)
  self:CloseDialog()
end

function UICampainEnterController:DataUpdate(go)
  self:Refresh()
end

function UICampainEnterController:SetLocalDb(taskIndex)
  if self._component then
    self._component:SetDB(taskIndex, "N19TaskComp", "red")
  end
end

function UICampainEnterController:GetLocalDb(taskIndex)
  if self._component then
    return self._component:GetDB(taskIndex, "N19TaskComp", "red")
  end
end

function UICampainEnterController:GetLocalDbIsNew(campId, taskId)
  if self._component then
    local data = self._component:HasPrefsNew(campId, taskId)
    if not data then
      self._component:SetPrefsNew(campId, taskId)
    end
    data = self._component:GetPrefsNew(campId, taskId)
    return data
  end
end

function UICampainEnterController:SetLocalDbIsNew(campId, taskId)
  if self._component then
    self._component:SetPrefsNew(campId, taskId, 1)
  end
end
