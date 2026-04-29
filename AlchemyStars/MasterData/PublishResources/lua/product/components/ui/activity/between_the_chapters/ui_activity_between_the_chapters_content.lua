require("ui_side_enter_center_content_base")
_class("UIActivityBetweenTheChaptersContent", UISideEnterCenterContentBase)
UIActivityBetweenTheChaptersContent = UIActivityBetweenTheChaptersContent

function UIActivityBetweenTheChaptersContent:_SetRemainingTime(widgetName, descId, endTime, customTimeStr)
  local obj = UIWidgetHelper.SpawnObject(self, widgetName, "UIActivityCommonRemainingTime")
  if customTimeStr then
    obj:SetCustomTimeStr_Common_1()
  end
  obj:SetAdvanceText(descId)
  obj:SetData(endTime, nil, function()
    self:_UpdateRemainingTime()
  end)
end

function UIActivityBetweenTheChaptersContent:DoInit(params)
  self._campaignType = params and params.campaign_type
  self._componentIds = params and params.component_ids or {}
  self._campaignId = params and params.campaign_id
  self._componentId_drop = ECampaignCelebrationComponentID.ECAMPAIGN_CELEBRATION_MISSION_DROP
  self._componentId_person = ECampaignCelebrationComponentID.ECAMPAIGN_CELEBRATION_PERSON_PROGRESS
  self._campaign = self._data
end

function UIActivityBetweenTheChaptersContent:DoShow()
  if self._campaign:CheckCampaignClose_ShowClientError() then
    return
  end
  self:StartTask(function(TT)
    self._campaign:ClearCampaignNew(TT)
  end)
  self:AddListener()
  self._clientCfg = Cfg.cfg_campaign_between_the_chapters({})
  self:_Refresh()
end

function UIActivityBetweenTheChaptersContent:DoHide()
  UIWidgetHelper.ClearWidgets(self, "_tipsPool")
  self:DetachListener()
end

function UIActivityBetweenTheChaptersContent:DoDestroy()
end

function UIActivityBetweenTheChaptersContent:_Refresh(notFirst)
  self._component_drop = self._campaign:GetComponent(self._componentId_drop)
  if not self._component_drop then
    Log.exception("UIActivityBetweenTheChaptersContent:_Refresh() drop component == nil")
  end
  self._component_person = self._campaign:GetComponent(self._componentId_person)
  if not self._component_person then
    Log.exception("UIActivityBetweenTheChaptersContent:_Refresh() person progress component == nil")
  end
  self:_SetUI()
  self:_InitData()
  self:_SetCellList()
  if not notFirst then
    self:_InitScrollPos()
    self:_PlayAnimInSeq()
  end
  self:_UpdateRemainingTime()
end

function UIActivityBetweenTheChaptersContent:_SetUI()
  local maxCount = self._clientCfg[#self._clientCfg].NeedValue
  local curCount = self._component_drop:GetComponentInfo().m_total_count
  curCount = math.min(curCount, maxCount)
  local c_gray, c_yellow = "#4C4C4B", "#FEA226"
  local c1 = curCount == maxCount and c_yellow or c_gray
  local s1 = UIActivityHelper.GetColorText(c1, curCount)
  local c2 = c_yellow
  local s2 = UIActivityHelper.GetColorText(c2, maxCount)
  local txtProc = StringTable.Get("str_between_chapters_num", s1, s2)
  UIWidgetHelper.SetLocalizationText(self, "processText", txtProc)
  local txtBroad = StringTable.Get("str_between_chapters_title")
  UIWidgetHelper.SetLocalizationText(self, "broadcastText", txtBroad)
  self:_SetHourGlass(curCount)
end

function UIActivityBetweenTheChaptersContent:_SetHourGlass(curCount)
  local state = curCount <= 4 and 1 or curCount <= 9 and 2 or 3
  local objs = UIWidgetHelper.GetObjGroupByWidgetName(self, {
    {
      "hourglass_1"
    },
    {
      "hourglass_2"
    },
    {
      "hourglass_3"
    }
  })
  UIWidgetHelper.SetObjGroupShow(objs, state)
end

function UIActivityBetweenTheChaptersContent:_UpdateRemainingTime()
  local svrTimeModule = GameGlobal.GetModule(SvrTimeModule)
  local curTime = math.floor(svrTimeModule:GetServerTime() * 0.001)
  local lineComponent = self._campaign:GetComponent(ECampaignCelebrationComponentID.ECAMPAIGN_CELEBRATION_MISSION_DROP)
  local endTime = lineComponent:GetComponentInfo().m_close_time
  local stamp = endTime - curTime
  if 0 < stamp then
    self:_SetRemainingTime("reminetime", nil, endTime, true)
    return
  end
end

function UIActivityBetweenTheChaptersContent:_InitData()
  local rewards = self._component_person:GetComponentInfo().m_progress_rewards
  for key, value in ipairs(self._clientCfg) do
    value._id = value.ID
    value._title = value.Title
    value._valueNum = value.NeedValue
    value._state = self:_GetReceivedState(value.NeedValue)
    value._items = rewards[value.ID]
  end
end

function UIActivityBetweenTheChaptersContent:_SetCellList()
  local cellDatas = self._clientCfg
  self._cells = UIWidgetHelper.SpawnObjects(self, "Content", "UIActivityBetweenTheChaptersAwardCell", #cellDatas)
  for i, v in ipairs(self._cells) do
    v:SetData(i, cellDatas[i], function(index)
      for i, v in ipairs(self._cells) do
        v:SetSelected(i == index)
      end
    end, function(index)
      self:GetTotalAward(index)
    end, function(matid, pos)
      UIWidgetHelper.SetAwardItemTips(self, "_tipsPool", matid, pos)
    end)
  end
end

function UIActivityBetweenTheChaptersContent:_InitScrollPos()
  local canGetIdx = self:_CheckCanGetIndex()
  if canGetIdx ~= 0 then
    local content = self:GetUIComponent("RectTransform", "Content")
    local height = (canGetIdx - 1) * 152
    content.anchoredPosition = Vector2(content.anchoredPosition.x, height)
  end
end

function UIActivityBetweenTheChaptersContent:_CheckCanGetIndex()
  for i, v in ipairs(self._clientCfg) do
    local tb_check = {
      [ECumulativeLoginRewardStatus.E_CUMULATIVE_LOGIN_REWARD_CAN_RECV] = true,
      [ECumulativeLoginRewardStatus.E_CUMULATIVE_LOGIN_REWARD_LOCK] = true
    }
    if tb_check[v._state] then
      return i
    end
  end
  return 1
end

function UIActivityBetweenTheChaptersContent:_PlayAnimInSeq()
  local canGetIdx = self:_CheckCanGetIndex()
  for i = canGetIdx, #self._cells do
    local obj = self._cells[i]
    obj:PlayAnimationInSequence(i)
  end
end

function UIActivityBetweenTheChaptersContent:GetTotalAward(index)
  self._component_person:Start_HandleReceiveReward(index, function(res, rewards)
    self:_OnReceiveRewards(res, rewards)
  end)
end

function UIActivityBetweenTheChaptersContent:_OnReceiveRewards(res, rewards)
  if self.view == nil then
    return
  end
  if res:GetSucc() then
    UIActivityHelper.ShowUIGetRewards(rewards)
  else
    self._campaign:CheckErrorCode(res.m_result, nil, nil)
  end
end

function UIActivityBetweenTheChaptersContent:_CheckCanReceive(count)
  local corCount = self._component_drop:GetComponentInfo().m_total_count
  return count <= corCount
end

function UIActivityBetweenTheChaptersContent:_GetReceivedState(count)
  local state = ECumulativeLoginRewardStatus.E_CUMULATIVE_LOGIN_REWARD_LOCK
  local process = self._component_person:GetComponentInfo().m_received_progress
  if self:_CheckCanReceive(count) then
    state = ECumulativeLoginRewardStatus.E_CUMULATIVE_LOGIN_REWARD_CAN_RECV
  end
  for index, value in pairs(process) do
    if count == value then
      state = ECumulativeLoginRewardStatus.E_CUMULATIVE_LOGIN_REWARD_RECVED
      break
    end
  end
  return state
end

function UIActivityBetweenTheChaptersContent:AddListener()
  self:AttachEvent(GameEventType.OnUIGetItemCloseInQuest, self.OnUIGetItemCloseInQuest)
end

function UIActivityBetweenTheChaptersContent:DetachListener()
  self:DetachEvent(GameEventType.OnUIGetItemCloseInQuest, self.OnUIGetItemCloseInQuest)
end

function UIActivityBetweenTheChaptersContent:OnUIGetItemCloseInQuest()
  self:_Refresh(true)
end
