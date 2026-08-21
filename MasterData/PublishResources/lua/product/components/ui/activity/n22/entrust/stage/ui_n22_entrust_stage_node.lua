_class("UIN22EntrustStageNode", UICustomWidget)
UIN22EntrustStageNode = UIN22EntrustStageNode

function UIN22EntrustStageNode:_SetRemainingTime(widgetName, extraId, descId, endTime, customTimeStr)
  local obj = UIWidgetHelper.SpawnObject(self, widgetName, "UIActivityCommonRemainingTime")
  if customTimeStr then
    obj:SetCustomTimeStr_Common_1()
  end
  obj:SetExtraText("txtDesc", nil, extraId)
  obj:SetAdvanceText(descId)
  obj:SetData(endTime, nil, function()
    self:_Refresh()
  end)
end

function UIN22EntrustStageNode:PlayAnim(id, animName, delay, duration, callback)
  local widgetName = "_anim"
  local hideWidget = "_anim"
  UIWidgetHelper.PlayAnimationInSequence(self, widgetName, hideWidget, animName, delay, duration, callback)
end

function UIN22EntrustStageNode:SetData(campaignType, componentId, campaign, levelId, switchCallback)
  self._campaignType = campaignType
  self._componentId = componentId
  self._campaign = campaign
  self._levelId = levelId
  self._switchCallback = switchCallback
  self._component = self._campaign:GetComponent(self._componentId)
  self:_Refresh()
end

function UIN22EntrustStageNode:SetPos(pos)
  local rect = self:GetGameObject():GetComponent("RectTransform")
  rect.anchoredPosition = pos
end

function UIN22EntrustStageNode:_Refresh()
  self._state = self:_CheckState()
  self:_SetObjGroup(self._state)
  self:_SetLockTime()
  self:_SetTitleText()
  self:_SetExplorText_Once()
  self:_SetEffectImage()
end

function UIN22EntrustStageNode:_CheckState()
  return self._component:CheckStageState(self._levelId)
end

function UIN22EntrustStageNode:_SetObjGroup(state)
  local widgetNameGroup = {
    {
      "_bg_lock",
      "_remainingTimePool_lock"
    },
    {"_bg_lock"},
    {"_bg_unlock", "_explor"},
    {"_bg_pass", "_explor"}
  }
  self._stateObj = UIWidgetHelper.GetObjGroupByWidgetName(self, widgetNameGroup, self._stateObj)
  UIWidgetHelper.SetObjGroupShow(self._stateObj, state)
end

function UIN22EntrustStageNode:_SetLockTime()
  if self._state == EEntrustStageNodeState.LockWithTime then
    local time = self._component:GetStageOpenTime(self._levelId)
    self:_SetRemainingTime("_remainingTimePool_lock", nil, nil, time, true)
  end
end

function UIN22EntrustStageNode:_SetTitleText()
  local strTitle, strDesc = self._component:GetStageTitleDesc(self._levelId)
  UIWidgetHelper.SetLocalizationText(self, "_txtTitle", StringTable.Get(strTitle))
end

function UIN22EntrustStageNode:_SetExplorText_Once()
  local num = self._component:GetExplorNum(self._levelId)
  UIWidgetHelper.SetLocalizationText(self, "_txtExplor", num .. "%")
end

function UIN22EntrustStageNode:_SetEffectImage()
  local index = UIN22EntrustHelper.GetLevelIndex(self._component, self._levelId) or 0
  local widgetNameGroup = {
    [1] = {"01"},
    [2] = {"02"},
    [3] = {"03"},
    [4] = {"04"},
    [5] = {"05"},
    [6] = {"06"}
  }
  local trans = self:GetUIComponent("RectTransform", "_eff")
  self._effObj = UIWidgetHelper.GetObjGroupByTransformFind(trans, widgetNameGroup, self._effObj)
  UIWidgetHelper.SetObjGroupShow(self._effObj, index)
  local trans2 = self:GetUIComponent("RectTransform", "_effect")
  self._effObj2 = UIWidgetHelper.GetObjGroupByTransformFind(trans2, widgetNameGroup, self._effObj2)
  UIWidgetHelper.SetObjGroupShow(self._effObj2, index)
end

function UIN22EntrustStageNode:BtnOnClick()
  Log.info("UIN22EntrustStageNode:BtnOnClick")
  if self._state == EEntrustStageNodeState.LockWithTime then
    ToastManager.ShowToast(StringTable.Get("str_n22_entrust_stage_lock_tips"))
  elseif self._state == EEntrustStageNodeState.Lock then
    ToastManager.ShowToast(StringTable.Get("str_n22_entrust_stage_lock_tips"))
  else
    self:ShowDialog("UIN22EntrustStageDetailController", self._campaign, self._componentId, self._levelId, function()
      self._component:SetCurLevelId(self._levelId)
      self._component:SetPlayerPos(0)
      self._component:SetBannerState(0)
      if self._switchCallback then
        self._switchCallback(self._levelId)
      end
    end)
  end
end
