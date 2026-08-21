_class("UIActivityPowerCostController2", UIController)
UIActivityPowerCostController2 = UIActivityPowerCostController2

function UIActivityPowerCostController2:_Back()
  self:CloseDialog()
end

function UIActivityPowerCostController2:LoadDataOnEnter(TT, res, uiParams)
  self._campaignType = ECampaignType.CAMPAIGN_TYPE_POWERCOST
  self._componentId = ECampaignPowerCostComponentID.ECAMPAIGN_POWERCOST_QUEST
  self._campaign = UIActivityCampaign:New()
  self._campaign:LoadCampaignInfo(TT, res, self._campaignType, self._componentId)
  if res and not res:GetSucc() then
    self._campaign:CheckErrorCode(res.m_result, nil, nil)
    return
  end
  self._campaign:ClearCampaignNew(TT)
end

function UIActivityPowerCostController2:GetComponents()
  self._desc = self:GetUIComponent("UILocalizationText", "desc")
  self._txtProgress = self:GetUIComponent("UILocalizationText", "txtProgress")
  self._imgFill = self:GetUIComponent("Image", "imgFill")
  self._Icon = self:GetUIComponent("RawImageLoader", "Icon")
  self._time1 = self:GetUIComponent("RollingText", "time1")
  self._time2 = self:GetUIComponent("RollingText", "time2")
  local s = self:GetUIComponent("UISelectObjectPath", "itemTipsPool")
  self._tips = s:SpawnObject("UISelectInfo")
  self._lock = self:GetGameObject("lock")
  self._txt = self:GetUIComponent("UILocalizationText", "txt")
end

function UIActivityPowerCostController2:CloseBtnOnClick(go)
  self:_Back()
end

function UIActivityPowerCostController2:IconOnClick(go)
  if self._tips then
    local pos = go.transform.position
    self._tips:SetData(self.itemId, pos)
  end
end

function UIActivityPowerCostController2:OnValue()
  self:GetData()
  self:SetTime()
  self:SetQuest()
end

function UIActivityPowerCostController2:SetQuest()
  local cfg = Cfg.cfg_item[self.itemId]
  local icon = cfg.Icon
  self._Icon:LoadImage(icon)
  local progress = self._quest.cur_progress .. "/" .. self._quest.total_progress
  self._txtProgress:SetText(progress)
  local rate = self._quest.cur_progress / self._quest.total_progress
  self._imgFill.fillAmount = rate
  local desc = StringTable.Get("str_activity_powercost_intro_n29")
  self._desc:SetText(desc)
  local status = self._quest.status
  self._lock:SetActive(status ~= QuestStatus.QUEST_Completed)
  local tex
  if status == QuestStatus.QUEST_Taken then
    tex = "str_activity_powercost_2_get_btn2"
  else
    tex = "str_activity_powercost_2_get_btn"
  end
  self._txt:SetText(StringTable.Get(tex))
end

function UIActivityPowerCostController2:SetTime()
  self:SetTime2()
  self:SetTime1()
end

function UIActivityPowerCostController2:SetTime1()
  if self._timer1 then
    GameGlobal.Timer():CancelEvent(self._timer1)
  end
  self._timer1 = GameGlobal.Timer():AddEventTimes(1000, TimerTriggerCount.Infinite, function()
    self:SetTime1Tex()
  end)
  self:SetTime1Tex()
end

function UIActivityPowerCostController2:SetTime1Tex()
  local svrTime = math.floor(self._svrTimeModule:GetServerTime() * 0.001)
  local sec = self.endTime - svrTime
  if sec < 0 then
    if self._timer1 then
      GameGlobal.Timer():CancelEvent(self._timer1)
    end
    if self._timer2 then
      GameGlobal.Timer():CancelEvent(self._timer2)
    end
    local tex = "str_activity_error_107"
    self._time1:RefreshText(StringTable.Get(tex))
    self._time2:RefreshText(StringTable.Get(tex))
  else
    local timeStr = HelperProxy:GetInstance():Time2Tex(sec)
    local tex = "str_activity_powercost_2_time_tex1"
    self._time1:RefreshText(StringTable.Get(tex, timeStr))
  end
end

function UIActivityPowerCostController2:SetTime2()
  if self._timer2 then
    GameGlobal.Timer():CancelEvent(self._timer2)
  end
  self._timer2 = GameGlobal.Timer():AddEventTimes(1000, TimerTriggerCount.Infinite, function()
    self:SetTime2Tex()
  end)
  self:SetTime2Tex()
end

function UIActivityPowerCostController2:SetTime2Tex()
  local questId = self._quest.quest_id
  local timeInfo = self._component_quest:GetComponentInfo().m_quest_time_param_map[questId]
  local endTime = timeInfo.m_end_time
  local svrTime = math.floor(self._svrTimeModule:GetServerTime() * 0.001)
  local sec = endTime - svrTime
  if sec < 0 then
    Log.fatal("###[UIActivityPowerCostController2] 刷新任务信息")
    if self._timer2 then
      GameGlobal.Timer():CancelEvent(self._timer2)
    end
    self:Lock("RefreshQuestInfo")
    self:StartTask(function(TT)
      local res = AsyncRequestRes:New()
      self._component_quest:HandleCamQuestDailyReset(TT, res)
      self:UnLock("RefreshQuestInfo")
      if res:GetSucc() then
        self:_ReLoadData(TT, res)
      end
    end, self)
  else
    local timeStr = HelperProxy:GetInstance():Time2Tex(sec)
    local tex = "str_activity_powercost_2_time_tex2"
    self._time2:RefreshText(StringTable.Get(tex, timeStr))
  end
end

function UIActivityPowerCostController2:GetData()
  self.isOpen = true
  self._svrTimeModule = GameGlobal.GetModule(SvrTimeModule)
  self._component_quest = self._campaign:GetComponent(self._componentId)
  self._questList = self._component_quest:GetQuestInfo()
  self._questStatus = self._component_quest:GetCampaignQuestStatus(self._questList)
  local questIndex = 1
  self._quest = self._questList[questIndex]:QuestInfo()
  self.endTime = self._component_quest:GetComponentInfo().m_close_time
  self._awards = self._quest.rewards
  local reward = self._awards[1]
  self.itemId = reward.assetid
end

function UIActivityPowerCostController2:OnShow(uiParams)
  self:GetComponents()
  self:OnValue()
  self:_AttachEvents()
end

function UIActivityPowerCostController2:OnHide()
  self.isOpen = false
  if self._timer1 then
    GameGlobal.Timer():CancelEvent(self._timer1)
  end
  if self._timer2 then
    GameGlobal.Timer():CancelEvent(self._timer2)
  end
end

function UIActivityPowerCostController2:_ReLoadData(TT, res)
  self._campaign:ReLoadCampaignInfo_Force(TT, res)
  if not self._campaign:CheckCampaignOpen() then
    self:_Back()
    return
  end
  self:_Refresh()
end

function UIActivityPowerCostController2:_Refresh()
  self:_CheckQuestDailyReset()
  self:OnValue()
end

function UIActivityPowerCostController2:_CheckQuestDailyReset()
  local svrTimeModule = GameGlobal.GetModule(SvrTimeModule)
  local curTime = math.floor(svrTimeModule:GetServerTime() * 0.001)
  local component = self._component_quest
  if not component then
    Log.inof("UIActivityPowerCostController2:_CheckQuestDailyReset() component == nil")
    return
  end
  local nextTime = component:GetEarliestEndTimeInDailyQuest()
  local stamp = nextTime - curTime
  if 0 <= stamp then
    return
  end
  self:StartTask(function(TT)
    local res = AsyncRequestRes:New()
    component:HandleCamQuestDailyReset(TT, res)
    if res:GetSucc() then
      self:_ReLoadData(TT, res)
    end
  end, self)
end

function UIActivityPowerCostController2:ShowBtnOnClick(go)
  self:_ShowUI()
end

function UIActivityPowerCostController2:ClaimBtnOnClick(go)
  local status = self._quest.status
  if status ~= QuestStatus.QUEST_Completed then
    Log.debug("###[UIActivityPowerCostController2] ClaimBtnOnClick status~=QuestStatus.QUEST_Completed !")
    return
  end
  self._component_quest:Start_HandleQuestTake(self._quest.quest_id, function(res, rewards)
    if not self.isOpen then
      return
    end
    if res and res:GetSucc() then
      UIActivityHelper.ShowUIGetRewards(rewards)
    else
      self._campaign._campaign_module:CheckErrorCode(res.m_result, self._campaign._id, function()
        self:_Refresh()
      end, function()
        self:_Back()
      end)
    end
  end)
end

function UIActivityPowerCostController2:_AttachEvents()
  self:AttachEvent(GameEventType.ActivityCloseEvent, self._CheckActivityClose)
  self:AttachEvent(GameEventType.OnUIGetItemCloseInQuest, self._Refresh)
end

function UIActivityPowerCostController2:_DetachEvents()
  self:DetachEvent(GameEventType.ActivityCloseEvent, self._CheckActivityClose)
  self:DetachEvent(GameEventType.OnUIGetItemCloseInQuest, self._Refresh)
end

function UIActivityPowerCostController2:_CheckActivityClose(id)
  if self._campaign and self._campaign._id == id then
    self:SwitchState(UIStateType.UIMain)
  end
end
