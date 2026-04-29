_class("UIActivityPowerCostController", UIController)
UIActivityPowerCostController = UIActivityPowerCostController

function UIActivityPowerCostController:_SetRemainingTime(widgetName, tmpMatName, descId, endTime, customTimeStr)
  local obj = UIWidgetHelper.SpawnObject(self, widgetName, "UIActivityCommonRemainingTime")
  if customTimeStr then
    obj:SetCustomTimeStr_Common_1()
  end
  obj:SetAdvanceText(descId)
  if not string.isnullorempty(tmpMatName) then
    obj:SetLocalizedTMPMaterial(tmpMatName)
  end
  obj:SetData(endTime, nil, function()
    self:_UpdateRemainingTime()
  end)
end

function UIActivityPowerCostController:_SetCommonTopButton()
  local obj = UIWidgetHelper.SpawnObject(self, "_backBtns", "UICommonTopButton")
  obj:SetData(function()
    self:_Back()
  end, nil, nil, false, function()
    self:_HideUI()
  end)
end

function UIActivityPowerCostController:_Back()
  self:CloseDialog()
end

function UIActivityPowerCostController:_HideUI()
  self:GetGameObject("_showBtn"):SetActive(true)
end

function UIActivityPowerCostController:_ShowUI()
  self:GetGameObject("_showBtn"):SetActive(false)
end

function UIActivityPowerCostController:_SetBg()
  local url = UIActivityHelper.GetCampaignMainBg(self._campaign, 1)
  if url then
    UIWidgetHelper.SetRawImage(self, "_mainBg", url)
  end
end

function UIActivityPowerCostController:_SetImgRT(imgRT)
  if imgRT ~= nil then
    local rt = self:GetUIComponent("RawImage", "rt")
    rt.texture = imgRT
    return true
  end
  return false
end

function UIActivityPowerCostController:LoadDataOnEnter(TT, res, uiParams)
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

function UIActivityPowerCostController:OnShow(uiParams)
  self:_SetDebug()
  self._isOpen = true
  self:_AttachEvents()
  self._component_quest = self._campaign:GetComponent(self._componentId)
  self:_SetCommonTopButton()
  self._matReq1 = UIWidgetHelper.SetLocalizedTMPMaterial(self, "_txtTitle", "PowerCostMaterial.mat", self._matReq1)
  self._matReq2 = UIWidgetHelper.SetLocalizedTMPMaterial(self, "_txtDesc", "PowerCostMaterial.mat", self._matReq2)
  self._matReq3 = UIWidgetHelper.SetLocalizedTMPMaterial(self, "_txtProgress", "PowerCostMaterial.mat", self._matReq3)
  self:_Refresh()
  if self:_SetImgRT(uiParams[1]) then
    UIWidgetHelper.PlayAnimation(self, "_anim", "uieff_Main_In", 1667, function()
      self:_CheckGuide()
    end)
  else
    self:_CheckGuide()
  end
end

function UIActivityPowerCostController:OnHide()
  self._isOpen = false
  self:_DetachEvents()
end

function UIActivityPowerCostController:Destroy()
  self._matReq1 = UIWidgetHelper.DisposeLocalizedTMPMaterial(self._matReq1)
  self._matReq2 = UIWidgetHelper.DisposeLocalizedTMPMaterial(self._matReq2)
  self._matReq3 = UIWidgetHelper.DisposeLocalizedTMPMaterial(self._matReq3)
end

function UIActivityPowerCostController:_ReLoadData(TT, res)
  self._campaign:ReLoadCampaignInfo_Force(TT, res)
  if not self._campaign:CheckCampaignOpen() then
    self:_Back()
    return
  end
  self:_Refresh()
end

function UIActivityPowerCostController:_Refresh()
  self:_CheckQuestDailyReset()
  self:_SetQuest()
  self:_UpdateRemainingTime()
end

function UIActivityPowerCostController:_SetQuest()
  self._questList = self._component_quest:GetQuestInfo()
  self._questStatus = self._component_quest:GetCampaignQuestStatus(self._questList)
  local questIndex = 1
  self._quest = self._questList[questIndex]:QuestInfo()
  self._status = self._component_quest:CheckCampaignQuestStatus(self._quest)
  self:_SetQuestRewards(self._quest)
  self:_SetQuestProgress(self._quest)
  self:_SetQuestStatus(self._status)
end

function UIActivityPowerCostController:_SetQuestRewards(quest)
  self._rewards = quest.rewards
  local objs = UIWidgetHelper.SpawnObjects(self, "_rewardPool", "UIActivityPowerCostItem", #self._rewards)
  for i, v in ipairs(objs) do
    v:SetData(i, self._rewards[i], function(matid, pos)
      UIWidgetHelper.SetAwardItemTips(self, "_itemTipsPool", matid, pos)
    end)
  end
end

function UIActivityPowerCostController:_SetQuestProgress(quest)
  local cur_progress = quest.cur_progress
  local total_progress = quest.total_progress
  UIWidgetHelper.SetSliderValue(self, "_progress", cur_progress, total_progress)
  local strProgress = ""
  if quest.ShowType == 1 then
    local c, d = math.modf(cur_progress * 100 / total_progress)
    if c < 1 and 0 < d then
      c = 1
    end
    strProgress = c .. "%"
  else
    strProgress = string.format("<color=#FFD325><size=52>%s</size></color><color=#C1C0C0><size=32>/%s</size></color>", cur_progress, total_progress)
  end
  UIWidgetHelper.SetLocalizedTMPText(self, "_txtProgress", strProgress)
end

function UIActivityPowerCostController:_SetQuestStatus(status)
  if not self._questStateObjs then
    self._questStateObjs = UIActivityHelper.GetObjGroupByWidgetName(self, {
      {
        "_ClaimBtn_Disable"
      },
      {
        "_ClaimBtn_Disable"
      },
      {
        "_ClaimBtn",
        "eff01",
        "eff02"
      },
      {
        "_ClaimBtn_Disable"
      },
      {
        "_ClaimBtn_Disable"
      }
    })
  end
  UIActivityHelper.SetObjGroupShow(self._questStateObjs, status)
  local show = status == CampaignQuestStatus.CQS_Completed
  local pool = self:GetUIComponent("UISelectObjectPath", "_rewardPool")
  local objs = pool:GetAllSpawnList()
  for i, v in ipairs(objs) do
    v:SetEffShow(show)
  end
end

function UIActivityPowerCostController:_UpdateRemainingTime()
  local svrTimeModule = GameGlobal.GetModule(SvrTimeModule)
  local curTime = math.floor(svrTimeModule:GetServerTime() * 0.001)
  local endTime = self._component_quest:GetComponentInfo().m_close_time
  local stamp = endTime - curTime
  if 0 < stamp then
    self:_SetRemainingTime("_timePool_Main", "PowerCostMaterial.mat", "str_activity_powercost_time_main", endTime, true)
  end
  local questId = self._quest.quest_id
  local timeInfo = self._component_quest:GetComponentInfo().m_quest_time_param_map[questId]
  local state2time = {
    [CampaignQuestStatus.CQS_NotStart] = timeInfo.m_open_time,
    [CampaignQuestStatus.CQS_Accepted] = timeInfo.m_end_time,
    [CampaignQuestStatus.CQS_Completed] = timeInfo.m_end_time,
    [CampaignQuestStatus.CQS_Taken] = timeInfo.m_end_time
  }
  endTime = state2time[self._status] or 0
  stamp = endTime - curTime
  if 0 < stamp then
    self:_SetRemainingTime("_timePool_Refresh", "", "str_activity_powercost_time_refresh", endTime)
  end
end

function UIActivityPowerCostController:_CheckQuestDailyReset()
  local svrTimeModule = GameGlobal.GetModule(SvrTimeModule)
  local curTime = math.floor(svrTimeModule:GetServerTime() * 0.001)
  local component = self._component_quest
  if not component then
    Log.inof("UIActivityPowerCostController:_CheckQuestDailyReset() component == nil")
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

function UIActivityPowerCostController:ShowBtnOnClick(go)
  self:_ShowUI()
end

function UIActivityPowerCostController:ClaimBtnOnClick(go)
  self._component_quest:Start_HandleQuestTake(self._quest.quest_id, function(res, rewards)
    if not self._isOpen then
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

function UIActivityPowerCostController:CloseBtnOnClick(go)
  self:_Back()
end

function UIActivityPowerCostController:_AttachEvents()
  self:AttachEvent(GameEventType.ActivityCloseEvent, self._CheckActivityClose)
  self:AttachEvent(GameEventType.OnUIGetItemCloseInQuest, self._Refresh)
end

function UIActivityPowerCostController:_DetachEvents()
  self:DetachEvent(GameEventType.ActivityCloseEvent, self._CheckActivityClose)
  self:DetachEvent(GameEventType.OnUIGetItemCloseInQuest, self._Refresh)
end

function UIActivityPowerCostController:_CheckActivityClose(id)
  if self._campaign and self._campaign._id == id then
    self:SwitchState(UIStateType.UIMain)
  end
end

function UIActivityPowerCostController:_CheckGuide()
  GameGlobal.EventDispatcher():Dispatch(GameEventType.GuideOpenUI, GuideOpenUI.UIActivityPowerCostController)
end

function UIActivityPowerCostController:_SetDebug()
  local show = UIActivityHelper.CheckDebugOpen()
  self:GetGameObject("_debug"):SetActive(show)
end

function UIActivityPowerCostController:TestBtnOnClick(go)
  local questId = self._quest.quest_id
  UIGMHelper.ChangeQuestStatus(questId, 1, 1, function()
    self:_Refresh()
  end)
end
