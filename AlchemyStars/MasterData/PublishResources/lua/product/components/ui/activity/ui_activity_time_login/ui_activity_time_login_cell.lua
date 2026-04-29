_class("UIActivityTimeLoginCell", UICustomWidget)
UIActivityTimeLoginCell = UIActivityTimeLoginCell

function UIActivityTimeLoginCell:OnShow(uiParams)
end

function UIActivityTimeLoginCell:OnHide()
end

function UIActivityTimeLoginCell:SetData(campaign, component, cfg, isSelected, componentProgress, refreshCallback, selectCallback, tipsCallback)
  self._campaign = campaign
  self._component = component
  self._cfg = cfg
  self._componentProgress = componentProgress
  self._refreshCallback = refreshCallback
  self._selectCallback = selectCallback
  self._tipsCallback = tipsCallback
  self:_Refresh()
  self:_SetSelected(isSelected)
end

function UIActivityTimeLoginCell:_Refresh()
  self:_SetDesc()
  self:_SetText()
  self:_SetItem()
  local state = self._component:GetCellState(self._cfg.ID)
  self:_SetState(state)
  self:_SetAlpha(state)
end

function UIActivityTimeLoginCell:_SetRemainingTime(widgetName, descId, endTime, customTimeStr)
  local obj = UIWidgetHelper.SpawnObject(self, widgetName, "UIActivityCommonRemainingTime")
  if customTimeStr then
    obj:SetCustomTimeStr_Common_2()
  end
  obj:SetAdvanceText(descId)
  obj:SetData(endTime, nil, self._refreshCallback)
end

function UIActivityTimeLoginCell:_SetDesc()
  local start = self._cfg.StartTime
  local close = self._cfg.CloseTime
  local startStr = self:_GetFormatStr(start)
  local closeStr = self:_GetFormatStr(close)
  local str = StringTable.Get("str_activity_time_login_cell_desc", startStr, closeStr)
  UIWidgetHelper.SetLocalizationText(self, "_desc", str)
end

function UIActivityTimeLoginCell:_GetFormatStr(timeStr)
  local loginModule = GameGlobal.GetModule(LoginModule)
  local t = loginModule:GetTimeStampByTimeStr(timeStr, Enum_DateTimeZoneType.E_ZoneType_GMT)
  local d = _time(t)
  return StringTable.Get("str_activity_time_login_cell_time_format", d.month, d.day)
end

function UIActivityTimeLoginCell:_SetText()
  local tb = {
    _txt_stateCanReceive = "str_activity_common_can_get",
    _txt_stateReceived = "str_activity_common_state_taken_3",
    _txt_stateExpireShow = "str_activity_time_login_cell_expire_lock",
    _txt_stateExpireLock = "str_activity_time_login_cell_expire_lock",
    _txt_stateCan = "str_activity_time_login_cell_expire_get"
  }
  for widgetName, id in pairs(tb) do
    local str = "- " .. StringTable.Get(id) .. " -"
    UIWidgetHelper.SetLocalizationText(self, widgetName, str)
  end
end

function UIActivityTimeLoginCell:_SetItem()
  local rewards = {}
  for _, v in ipairs(self._cfg.Rewards) do
    local roleAsset = RoleAsset:New()
    roleAsset.assetid = v[1]
    roleAsset.count = v[2]
    table.insert(rewards, roleAsset)
  end
  rewards = self._componentProgress:RemoveProgressItemInTable(rewards)
  local objs = UIWidgetHelper.SpawnObjects(self, "_itemPool", "UIActivityTimeLoginCellItem", #rewards)
  for i, v in ipairs(objs) do
    v:SetData(rewards[i], self._tipsCallback)
  end
end

function UIActivityTimeLoginCell:_SetState(state)
  local tb = {
    [ETimeLoginRewardStatus.E_TIME_LOGIN_REWARD_LOCK] = {
      "_state_lock"
    },
    [ETimeLoginRewardStatus.E_TIME_LOGIN_REWARD_CAN_RECV] = {
      "_state_canReceive"
    },
    [ETimeLoginRewardStatus.E_TIME_LOGIN_REWARD_RECVED] = {
      "_state_received",
      "_txt_stateReceived"
    },
    [ETimeLoginRewardStatus.E_TIME_LOGIN_REWARD_EXPIRE_SHOW] = {
      "_state_expireShow"
    },
    [ETimeLoginRewardStatus.E_TIME_LOGIN_REWARD_EXPIRE_LOCK] = {
      "_state_expireLock"
    },
    [ETimeLoginRewardStatus.E_TIME_LOGIN_REWARD_EXPIRE_CAN] = {
      "_state_expireCan"
    }
  }
  local objs = UIWidgetHelper.GetObjGroupByWidgetName(self, tb)
  UIWidgetHelper.SetObjGroupShow(objs, state)
  if state == ETimeLoginRewardStatus.E_TIME_LOGIN_REWARD_LOCK then
    self:_SetState_LockTime()
  elseif state == ETimeLoginRewardStatus.E_TIME_LOGIN_REWARD_CAN_RECV then
    self:_SetState_RecvTime()
  elseif state == ETimeLoginRewardStatus.E_TIME_LOGIN_REWARD_EXPIRE_SHOW then
    self:_SetState_ExpireProgress()
  end
end

function UIActivityTimeLoginCell:_SetState_LockTime()
  local start = self._cfg.StartTime
  local loginModule = GameGlobal.GetModule(LoginModule)
  local endTime = loginModule:GetTimeStampByTimeStr(start, Enum_DateTimeZoneType.E_ZoneType_GMT)
  self:_SetRemainingTime("_timePool", "str_activity_time_login_cell_wait_get", endTime, true)
end

function UIActivityTimeLoginCell:_SetState_RecvTime()
  local start = self._cfg.CloseTime
  local loginModule = GameGlobal.GetModule(LoginModule)
  local endTime = loginModule:GetTimeStampByTimeStr(start, Enum_DateTimeZoneType.E_ZoneType_GMT)
  self:_SetRemainingTime("_timePool", "str_activity_time_login_cell_wait_get", endTime, true)
end

function UIActivityTimeLoginCell:_SetState_ExpireProgress()
  local count = self._component:GetCellPointCount(self._cfg.ID)
  local maxCount = self._cfg.PointCount
  UIWidgetHelper.SetLocalizationText(self, "_txt_stateExpireShowProgress", count .. "/" .. maxCount)
end

function UIActivityTimeLoginCell:_SetSelected(isSelected)
  self:GetGameObject("_selectedFg"):SetActive(isSelected)
end

function UIActivityTimeLoginCell:_SetAlpha(state)
  local alpha = state == ETimeLoginRewardStatus.E_TIME_LOGIN_REWARD_RECVED and 0.5 or 1
  local obj = self:GetUIComponent("CanvasGroup", "_alphaGroup")
  obj.alpha = alpha
end

function UIActivityTimeLoginCell:_OnRecvClick()
  local id = self._cfg.ID or -1
  self._component:Start_HandleReceiveTimeLoginReward(id, function(res, rewards)
    if rewards == nil then
      Log.error("UIActivityTimeLoginCell:_OnRecvClick() id = ", id, ", rewards = nil")
    end
    self:_OnReceiveRewards(res, rewards)
  end)
end

function UIActivityTimeLoginCell:_OnReceiveRewards(res, rewards)
  if self.view == nil then
    return
  end
  if res:GetSucc() then
    self:_SetState(ETimeLoginRewardStatus.E_TIME_LOGIN_REWARD_RECVED)
    local animName = "uieff_UIActivityTimeLogin_Cell_Cell_Get"
    UIWidgetHelper.PlayAnimation(self, "_anim", animName, 333, function()
      rewards = self._componentProgress:RemoveProgressItemInTable(rewards)
      UIActivityHelper.ShowUIGetRewards(rewards)
    end)
  else
    self._campaign:CheckErrorCode(res.m_result, function()
      self:_Refresh()
    end, function()
    end)
  end
end

function UIActivityTimeLoginCell:BgOnClick(go)
  if self._selectCallback then
    self._selectCallback()
  end
end

function UIActivityTimeLoginCell:CanRecvBtnOnClick(go)
  self:_OnRecvClick()
end

function UIActivityTimeLoginCell:ExpireCanRecvBtnOnClick(go)
  self:_OnRecvClick()
end

function UIActivityTimeLoginCell:PlayAnimationInSequence(index)
  local delay = 0 + (index - 1) * 30
  UIWidgetHelper.PlayAnimationInSequence(self, "_anim", "_anim", "uieff_UIActivityTimeLogin_Cell_in", delay)
end
