require("ui_side_enter_center_content_base")
_class("UISpecialTaskV3", UISideEnterCenterContentBase)
UISpecialTaskV3 = UISpecialTaskV3

function UISpecialTaskV3:Constructor()
  self._svrTimeModule = self:GetModule(SvrTimeModule)
  self._preSelectedItem = nil
  self:AttachEvent(GameEventType.QuestUpdate, self.Refresh)
end

function UISpecialTaskV3:DoInit()
  self._campaign = UIActivityCampaign:New()
  self._campaign:LoadCampaignInfo_Local(ECampaignType.CAMPAIGN_TYPE_SPECIAL)
  self._localProcess = self._campaign:GetLocalProcess()
  self._questComponent = self._localProcess:GetComponent(ECampaignSpecialComponentID.ECAMPAIGN_SPECIAL_QUEST)
  self._questComponentInfo = self._questComponent:GetComponentInfo()
  self:_RefreshRemainTime()
end

function UISpecialTaskV3:DoShow(uiParams)
  self._callback = uiParams[1]
  self:StartTask(function(TT)
    self._campaign:ClearCampaignNew(TT)
  end)
  
  function self._tipsCallback(matid, pos)
    GameGlobal.EventDispatcher():Dispatch(GameEventType.OnCampaignCenterShowItemTips, matid, pos)
  end
  
  self:GetComponents()
  self._timeEvent = GameGlobal.Timer():AddEventTimes(1000, TimerTriggerCount.Infinite, function()
    self:_RefreshRemainTime()
  end)
  self:_SetIntro()
  self:_SetDailyTips()
  if self._questComponent:Check_CamQuestDailyReset() then
    self._questComponent:Start_HandleCamQuestDailyReset(function(TT, res)
      self:Refresh(true)
    end)
  end
  self:Refresh(true)
  self:PlayAnim()
end

function UISpecialTaskV3:GetComponents()
  self._anim = self:GetUIComponent("Animation", "Center")
end

function UISpecialTaskV3:PlayAnim()
  if self._anim then
    self._anim:Stop()
    self._anim:Play("UISpecialTaskV3_in")
    if self._timer then
      GameGlobal.Timer():CancelEvent(self._timer)
    end
    self._timer = GameGlobal.Timer():AddEvent(833, function()
      self._anim:Stop()
      self._anim:Play("UISpecialTaskV3_loop")
    end)
  end
end

function UISpecialTaskV3:DoHide()
  if self._timeEvent then
    GameGlobal.Timer():CancelEvent(self._timeEvent)
    self._timeEvent = nil
  end
  if self._callback then
    self._callback()
  end
  if self._timer then
    GameGlobal.Timer():CancelEvent(self._timer)
    self._timer = nil
  end
end

function UISpecialTaskV3:DoDestroy()
end

function UISpecialTaskV3:Refresh(first)
  self._questList = self._questComponent:GetQuestInfo()
  UISpecialTaskHelper.QuestSort(self._questList)
  self:_SetCellList()
  self:_PlayAnim_CellList(first)
  if self._callback then
    self._callback()
  end
end

function UISpecialTaskV3:_RefreshRemainTime()
  local curtime = math.floor(self._svrTimeModule:GetServerTime() * 0.001)
  local remainTime = self._questComponentInfo.m_close_time - curtime
  if 0 < remainTime then
    local textId = UISpecialTaskHelper.GetStrIdInCampaign(self._campaign, "str_special_task_time_desc")
    local text = StringTable.Get(textId, UISpecialTaskToolFunctions.GetRemainTime(remainTime))
    UIWidgetHelper.SetLocalizationText(self, "RemainTimeText", text)
  else
    self._campaign:CheckErrorCode(CampaignErrorType.E_CAMPAIGN_ERROR_TYPE_CAMPAIGN_FINISHED)
  end
end

function UISpecialTaskV3:_SetIntro()
  local textId = UISpecialTaskHelper.GetStrIdInCampaign(self._campaign, "str_special_task_main_intro")
  local text = StringTable.Get(textId)
  UIWidgetHelper.SetLocalizationText(self, "IntroText", text)
end

function UISpecialTaskV3:_SetDailyTips()
  local textId = UISpecialTaskHelper.GetStrIdInCampaign(self._campaign, "str_special_task_daily_desc")
  local text = StringTable.Get(textId)
  UIWidgetHelper.SetLocalizationText(self, "DailyTipsText", text)
end

function UISpecialTaskV3:_SetCellList()
  local objs = UIWidgetHelper.SpawnObjects(self, "Content", "UISpecialTaskV3Cell", #self._questList)
  for i, v in ipairs(objs) do
    local quest = self._questList[i]
    v:SetData(self._questComponent, quest, function(widget)
      self:OnSelectItem(widget)
    end, self._tipsCallback, function()
      self:Refresh()
    end, function(result)
      self._campaign:CheckErrorCode(result, nil, nil)
    end)
  end
  self._cells = objs
end

function UISpecialTaskV3:OnSelectItem(widget)
  if self._preSelectedItem and self._preSelectedItem ~= widget then
    self._preSelectedItem:OnSelect(false)
  end
  self._preSelectedItem = widget
end

function UISpecialTaskV3:_PlayAnim_CellList(isPlay)
  if isPlay then
    for i, v in ipairs(self._cells) do
      v:PlayAnimationInSequence(i)
    end
  end
end
