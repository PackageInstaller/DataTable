_class("UITimeLoginV2Cell", UICustomWidget)
UITimeLoginV2Cell = UITimeLoginV2Cell

function UITimeLoginV2Cell:OnShow(uiParams)
end

function UITimeLoginV2Cell:OnHide()
end

function UITimeLoginV2Cell:SetData(campaign, component, cfg, isSelected, componentProgress, refreshCallback, selectCallback, tipsCallback)
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

function UITimeLoginV2Cell:_Refresh()
  self:_SetDesc()
  self:_SetItem()
  self._state = self._component:GetCellState(self._cfg.ID)
  self:_SetState(self._state)
end

function UITimeLoginV2Cell:_SetRemainingTime(widgetName, descId, endTime, customTimeStr)
  local obj = UIWidgetHelper.SpawnObject(self, widgetName, "UIActivityCommonRemainingTime")
  if customTimeStr then
    obj:SetCustomTimeStr_Common_2()
  end
  obj:SetAdvanceText(descId)
  obj:SetData(endTime, nil, self._refreshCallback)
end

function UITimeLoginV2Cell:_SetDesc()
  local start = self._cfg.StartTime
  local close = self._cfg.CloseTime
  local startStr = self:_GetFormatStr(start)
  local closeStr = self:_GetFormatStr(close)
  local str = StringTable.Get("str_activity_time_login_cell_desc", startStr, closeStr)
  UIWidgetHelper.SetLocalizationText(self, "_desc", str)
end

function UITimeLoginV2Cell:_GetFormatStr(timeStr)
  local loginModule = GameGlobal.GetModule(LoginModule)
  local t = loginModule:GetTimeStampByTimeStr(timeStr, Enum_DateTimeZoneType.E_ZoneType_GMT)
  local d = _time(t)
  return StringTable.Get("str_activity_time_login_cell_time_format", d.month, d.day)
end

function UITimeLoginV2Cell:_SetItem()
  local rewards = {}
  for _, v in ipairs(self._cfg.Rewards) do
    local roleAsset = RoleAsset:New()
    roleAsset.assetid = v[1]
    roleAsset.count = v[2]
    table.insert(rewards, roleAsset)
  end
  rewards = self._componentProgress:RemoveProgressItemInTable(rewards)
  local objs = UIWidgetHelper.SpawnObjects(self, "_itemPool", "UITimeLoginV2CellItem", #rewards)
  for i, v in ipairs(objs) do
    v:SetData(rewards[i], self._tipsCallback)
  end
end

function UITimeLoginV2Cell:_SetState(state)
  local tb = {
    [ETimeLoginRewardStatus.E_TIME_LOGIN_REWARD_LOCK] = {
      "_state_lock"
    },
    [ETimeLoginRewardStatus.E_TIME_LOGIN_REWARD_CAN_RECV] = {
      "_state_canReceive"
    },
    [ETimeLoginRewardStatus.E_TIME_LOGIN_REWARD_RECVED] = {
      "_state_received"
    },
    [ETimeLoginRewardStatus.E_TIME_LOGIN_REWARD_EXPIRE_SHOW] = {
      "_state_expire",
      "_state_expireShow"
    },
    [ETimeLoginRewardStatus.E_TIME_LOGIN_REWARD_EXPIRE_LOCK] = {
      "_state_expire",
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

function UITimeLoginV2Cell:_SetState_LockTime()
  local start = self._cfg.StartTime
  local loginModule = GameGlobal.GetModule(LoginModule)
  local endTime = loginModule:GetTimeStampByTimeStr(start, Enum_DateTimeZoneType.E_ZoneType_GMT)
  self:_SetRemainingTime("_timePool", "str_activity_time_login_cell_wait_get", endTime, true)
end

function UITimeLoginV2Cell:_SetState_RecvTime()
  local start = self._cfg.CloseTime
  local loginModule = GameGlobal.GetModule(LoginModule)
  local endTime = loginModule:GetTimeStampByTimeStr(start, Enum_DateTimeZoneType.E_ZoneType_GMT)
  self:_SetRemainingTime("_timePool", "str_activity_time_login_cell_wait_get", endTime, true)
end

function UITimeLoginV2Cell:_SetState_ExpireProgress()
  local count = self._component:GetCellPointCount(self._cfg.ID)
  local maxCount = self._cfg.PointCount
  UIWidgetHelper.SetLocalizationText(self, "_txt_stateExpireShowProgress", count .. "/" .. maxCount)
end

function UITimeLoginV2Cell:_SetSelected(isSelected)
  self:GetGameObject("_selectedFg"):SetActive(isSelected)
end

function UITimeLoginV2Cell:_OnRecvClick()
  local id = self._cfg.ID or -1
  self._component:Start_HandleReceiveTimeLoginReward(id, function(res, rewards)
    self:_OnReceiveRewards(res, rewards, id)
  end)
end

function UITimeLoginV2Cell:_OnReceiveRewards(res, rewards, id)
  if rewards == nil then
    Log.error("UITimeLoginV2Cell:_OnReceiveRewards() id = ", id, ", rewards = nil")
  end
  if self.view == nil then
    return
  end
  if res:GetSucc() then
    rewards = self._componentProgress:RemoveProgressItemInTable(rewards)
    UIActivityHelper.ShowUIGetRewards(rewards)
  else
    self._campaign:CheckErrorCode(res.m_result, function()
      self:_Refresh()
    end)
  end
end

function UITimeLoginV2Cell:BtnOnClick(go)
  local function onRecvClick()
    self:_OnRecvClick()
  end
  
  local tb = {
    [ETimeLoginRewardStatus.E_TIME_LOGIN_REWARD_LOCK] = nil,
    [ETimeLoginRewardStatus.E_TIME_LOGIN_REWARD_CAN_RECV] = onRecvClick,
    [ETimeLoginRewardStatus.E_TIME_LOGIN_REWARD_RECVED] = nil,
    [ETimeLoginRewardStatus.E_TIME_LOGIN_REWARD_EXPIRE_SHOW] = nil,
    [ETimeLoginRewardStatus.E_TIME_LOGIN_REWARD_EXPIRE_LOCK] = nil,
    [ETimeLoginRewardStatus.E_TIME_LOGIN_REWARD_EXPIRE_CAN] = onRecvClick
  }
  Log.info("UITimeLoginV2Cell:BtnOnClick()")
  local func = tb[self._state]
  if func then
    func()
  end
  if self._selectCallback then
    self._selectCallback()
  end
end

function UITimeLoginV2Cell:PlayAnimationInSequence(index)
  local delay = 0 + (index - 1) * 30
  UIWidgetHelper.PlayAnimationInSequence(self, "_anim", "_root", "uieff_UITimeLoginV2Cell_in", delay)
end
