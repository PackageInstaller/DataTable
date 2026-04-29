_class("UIActivityAnniversaryLoginTabMainListItem", UICustomWidget)
UIActivityAnniversaryLoginTabMainListItem = UIActivityAnniversaryLoginTabMainListItem

function UIActivityAnniversaryLoginTabMainListItem:_SetRemainingTime(widgetName, descId, endTime, customTimeStr)
  local obj = UIWidgetHelper.SpawnObject(self, widgetName, "UIActivityCommonRemainingTime")
  if customTimeStr then
    obj:SetCustomTimeStr_Common_1()
  end
  obj:SetExtraRollingText()
  obj:SetAdvanceText(descId)
  obj:SetData(endTime, nil, function(first)
    if not first then
      self._refreshCallback(1, true)
    end
  end)
end

function UIActivityAnniversaryLoginTabMainListItem:OnShow(uiParams)
end

function UIActivityAnniversaryLoginTabMainListItem:OnHide()
end

function UIActivityAnniversaryLoginTabMainListItem:SetData(component, index, timeReward, refreshCallback, tipsCallback, btnCallback)
  self._component = component
  self._index = index
  self._timeReward = timeReward
  self._refreshCallback = refreshCallback
  self._tipsCallback = tipsCallback
  self._btnCallback = btnCallback
  self:_SetState(timeReward.rec_reward_status)
  self:_SetRemainingTime("_timePool", "", timeReward.unlock_time, true)
  self._infos = timeReward.rewards
  self:_SetDynamicList()
end

function UIActivityAnniversaryLoginTabMainListItem:_SetState(state)
  self._stateObj = UIWidgetHelper.GetObjGroupByWidgetName(self, {
    [ETimeRewardRewardStatus.E_TIME_REWARD_UNKNOW] = {},
    [ETimeRewardRewardStatus.E_TIME_REWARD_CAN_RECV] = {
      "state_Completed"
    },
    [ETimeRewardRewardStatus.E_TIME_REWARD_RECVED] = {
      "state_Taken"
    },
    [ETimeRewardRewardStatus.E_TIME_REWARD_LOCK] = {
      "state_NotStart"
    }
  }, self._stateObj)
  UIWidgetHelper.SetObjGroupShow(self._stateObj, state)
end

function UIActivityAnniversaryLoginTabMainListItem:_SetDynamicList()
  self._dynamicList = self:GetUIComponent("UISelectObjectPath", "_dynamicList")
  self.groups = self._dynamicList:SpawnObjects("UIActivityAnniversaryLoginItem", #self._infos)
  for i = 1, #self.groups do
    local item = self.groups[i]
    item:SetData(self._infos[i], self._timeReward.rec_reward_status, self._tipsCallback)
  end
end

function UIActivityAnniversaryLoginTabMainListItem:ClaimBtnOnClick(go)
  if self._btnCallback then
    self._btnCallback(self._component, self._index)
  end
end
