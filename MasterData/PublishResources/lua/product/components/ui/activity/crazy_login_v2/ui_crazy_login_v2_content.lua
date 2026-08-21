require("ui_side_enter_center_content_base")
_class("UICrazyLoginV2Content", UISideEnterCenterContentBase)
UICrazyLoginV2Content = UICrazyLoginV2Content

function UICrazyLoginV2Content:DoInit(params)
  self._campaignType = ECampaignType.CAMPAIGN_TYPE_SIGN_IN
  self._componentId = ECampaignSignInComponentID.ECAMPAIGN_SIGN_IN_CUMULATIVE_LOGIN
  self._campaignId = params and params.campaign_id
  self._campaign = self._data
end

function UICrazyLoginV2Content:DoShow()
  self:_AttachEvent()
  self._component = self._campaign:GetComponent(self._componentId)
  self._curSelectedDayNum = -1
  self:_SetUI_ByCfg()
  self:_Refresh()
end

function UICrazyLoginV2Content:DoHide()
  self:_DetachEvent()
  UIWidgetHelper.ClearWidgets(self, "_tipsPool")
end

function UICrazyLoginV2Content:DoDestroy()
end

function UICrazyLoginV2Content:_SetUI_ByCfg()
  self._lastFixed = UICrazyLoginV2Helper.GetValue(self._campaign, "LastFixed") or false
  local value = UICrazyLoginV2Helper.GetValue(self._campaign, "Bg")
  UIWidgetHelper.SetRawImage(self, "_bg", value)
  value = UICrazyLoginV2Helper.GetValue(self._campaign, "Spine", "name")
  UIWidgetHelper.SetSpineLoad(self, "_spine", value)
  local obj = self:GetUIComponent("RectTransform", "_spine")
  value = UICrazyLoginV2Helper.GetValue(self._campaign, "Spine", "pos")
  obj.anchoredPosition = Vector2(value[1], value[2])
  value = UICrazyLoginV2Helper.GetValue(self._campaign, "Spine", "scale")
  obj.localScale = Vector3(value[1], value[2], value[3])
  value = UICrazyLoginV2Helper.GetValue(self._campaign, "BgBottom")
  UIWidgetHelper.SetRawImage(self, "_bgBottom", value)
end

function UICrazyLoginV2Content:_SetSpine(name, pos, scale)
end

function UICrazyLoginV2Content:_ForceRefresh()
  self:StartTask(function(TT)
    local res = AsyncRequestRes:New()
    res:SetSucc(true)
    self._campaign:ReLoadCampaignInfo_Force(TT, res)
    if res and res:GetSucc() then
      self:_Refresh()
    end
  end, self)
end

function UICrazyLoginV2Content:_Refresh(notMove)
  if not self.view then
    return
  end
  local componentInfo = self._component:GetComponentInfo()
  self._cmptCloseTime = componentInfo and componentInfo.m_close_time
  self:_SetCellList()
  if not notMove then
    self:_InitScrollPos()
  end
  self:_SetTime_Rest()
  self:_SetTime_Next()
end

function UICrazyLoginV2Content:_SetCellList()
  local datas = self._component:GetCumulativeRewardInfo()
  self._cellData = datas
  local listCount = self._lastFixed and #datas - 1 or #datas
  local objs = UIWidgetHelper.SpawnObjects(self, "Content", "UICrazyLoginV2Cell", listCount)
  self:GetGameObject("_lastCell"):SetActive(self._lastFixed)
  if self._lastFixed then
    local lastCell = UIWidgetHelper.SpawnObject(self, "_lastCell", "UICrazyLoginV2Cell")
    table.insert(objs, lastCell)
  end
  self._cells = objs
  for i, v in ipairs(objs) do
    local lastCell = self._lastFixed and i == #objs
    v:SetData(self._campaign, i, datas[i], lastCell, function(idx)
      for i, v in ipairs(objs) do
        v:SetSelected(i == idx)
      end
    end, function(idx)
      local dayNum = datas[idx].m_login_days
      self._component:Start_HandleReceiveCumulativeLoginReward(dayNum, function(res, rewards)
        self:_OnReceiveRewards(idx, res, rewards)
      end)
    end, function(matid, pos)
      UIWidgetHelper.SetAwardItemTips(self, "_tipsPool", matid, pos)
    end)
  end
end

function UICrazyLoginV2Content:_InitScrollPos()
  local canGetIdx = UICrazyLoginV2Helper.CheckCanGetIndex(self._cellData)
  if canGetIdx ~= 0 then
    local content = self:GetUIComponent("RectTransform", "Content")
    local height = (canGetIdx - 1) * 139
    content.anchoredPosition = Vector2(content.anchoredPosition.x, height)
  end
end

function UICrazyLoginV2Content:_OnReceiveRewards(idx, res, rewards)
  if self.view == nil then
    return
  end
  if res:GetSucc() then
    self._cells[idx]:OnAwardGot(rewards)
  else
    self._campaign:CheckErrorCode(res.m_result, nil, nil)
  end
end

function UICrazyLoginV2Content:_SetRemainingTime(widgetName, endTime, extraId)
  local isShow = endTime ~= nil
  local obj = UIWidgetHelper.SpawnObject(self, widgetName, "UIActivityCommonRemainingTime")
  obj:GetGameObject():SetActive(isShow)
  if not isShow then
    return
  end
  local value = UICrazyLoginV2Helper.GetValue(self._campaign, "Time", "bg")
  UIWidgetHelper.SetRawImage(obj, "bg", value)
  local color = UICrazyLoginV2Helper.GetValue(self._campaign, "Time", "text")
  UICrazyLoginV2Helper.SetTextColorByCfg(obj, "txtDesc", color)
  UICrazyLoginV2Helper.SetTextColorByCfg(obj, "txtTime", color)
  obj:SetExtraText("txtDesc", nil, extraId)
  obj:SetData(endTime, nil, function(isFirst)
    if not isFirst then
      self:_ForceRefresh()
    end
  end)
end

function UICrazyLoginV2Content:_SetTime_Rest()
  local stopTime = self._cmptCloseTime
  local strId = "str_activity_common_login_reward_remainingtime"
  self:_SetRemainingTime("RestTimeArea", stopTime, strId)
end

function UICrazyLoginV2Content:_SetTime_Next()
  local isAllUnlocked = UICrazyLoginV2Helper.CheckAllUnlocked(self._cellData)
  local nextTime, complateFlag = self:_GetRefreshTime()
  local stopTime = self._cmptCloseTime
  local isNotEnoughTime = nextTime == nil or nextTime >= stopTime
  if isAllUnlocked or isNotEnoughTime then
    self:_SetRemainingTime("NextTimeArea")
    return
  end
  local strId = "str_activity_common_login_reward_next_remain_time"
  self:_SetRemainingTime("NextTimeArea", nextTime, strId)
end

function UICrazyLoginV2Content:_GetRefreshTime()
  local sample = self._campaign:GetSample()
  if sample then
    local time = sample.m_extend_info_time[CampainExtendKey.E_CAMPAIGN_EXTEND_KEY_NEXT_REFRESH_TIME]
    local flag = sample.m_extend_info[CampainExtendKey.E_CAMPAIGN_EXTEND_KEY_CUMULATIVE_LOGIN_COMPLATE]
    return time, flag
  end
end

function UICrazyLoginV2Content:_AttachEvent()
  self:AttachEvent(GameEventType.OnUIGetItemCloseInQuest, self.OnUIGetItemCloseInQuest)
end

function UICrazyLoginV2Content:_DetachEvent()
  self:DetachEvent(GameEventType.OnUIGetItemCloseInQuest, self.OnUIGetItemCloseInQuest)
end

function UICrazyLoginV2Content:OnUIGetItemCloseInQuest()
  self:_Refresh(true)
end
