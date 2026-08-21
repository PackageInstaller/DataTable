_class("UIN12EntrustStageNode", UICustomWidget)
UIN12EntrustStageNode = UIN12EntrustStageNode

function UIN12EntrustStageNode:_SpawnObject(widgetName, className)
  local pool = self:GetUIComponent("UISelectObjectPath", widgetName)
  local obj = pool:SpawnObject(className)
  return obj
end

function UIN12EntrustStageNode:_SetRemainingTime(widgetName, extraId, descId, endTime, customTimeStr)
  local obj = self:_SpawnObject(widgetName, "UIActivityCommonRemainingTime")
  if customTimeStr then
    obj:SetCustomTimeStr_Common_1()
  end
  obj:SetExtraText("txtDesc", nil, extraId)
  obj:SetAdvanceText(descId)
  obj:SetData(endTime, nil, function()
    self:_Refresh()
  end)
end

function UIN12EntrustStageNode:PlayAnim(id, widgetName, animName, delayTime, time, callback)
  local anim = self:GetUIComponent("Animation", widgetName)
  local obj = self:GetGameObject(widgetName)
  local lockName = "UIN12EntrustStageNode_PlayAnim()_" .. id .. "_" .. animName
  self:Lock(lockName)
  self:StartTask(function(TT)
    if delayTime and delayTime ~= 0 then
      obj:SetActive(false)
      YIELD(TT, delayTime)
      obj:SetActive(true)
    end
    anim:Play(animName)
    YIELD(TT, time)
    self:UnLock(lockName)
    if callback then
      callback()
    end
  end, self)
end

function UIN12EntrustStageNode:SetData(campaign, levelId)
  self._campaignType = ECampaignType.CAMPAIGN_TYPE_N12
  self._componentId = ECampaignN12ComponentID.ECAMPAIGN_N12_ENTRUST
  self._campaign = campaign
  self._levelId = levelId
  self:_SetObjGroup()
  self:_Refresh()
end

function UIN12EntrustStageNode:SetPos(pos)
  local rect = self:GetGameObject():GetComponent("RectTransform")
  rect.anchoredPosition = pos
end

function UIN12EntrustStageNode:_Refresh()
  self._state = self:_CheckState()
  UIWidgetHelper.SetObjGroupShow(self._stateObj, self._state)
  self:_SetLockTime()
  self:_SetTitleText()
  self:_SetExplorText_Once()
end

function UIN12EntrustStageNode:_CheckState()
  local component = self._campaign:GetComponent(self._componentId)
  return component:CheckStageState(self._levelId)
end

function UIN12EntrustStageNode:_SetObjGroup()
  local widgetNameGroup = {
    {
      "state_lock",
      "_remainingTimePool_lock"
    },
    {"state_lock"},
    {
      "state_unlock"
    },
    {"state_pass"}
  }
  self._stateObj = UIWidgetHelper.GetObjGroupByWidgetName(self, widgetNameGroup)
end

function UIN12EntrustStageNode:_SetLockTime()
  if self._state == EEntrustStageNodeState.LockWithTime then
    local component = self._campaign:GetComponent(self._componentId)
    local _time = component:GetStageOpenTime(self._levelId)
    self:_SetRemainingTime("_remainingTimePool_lock", nil, nil, _time, true)
  end
end

function UIN12EntrustStageNode:_SetTitleText()
  local component = self._campaign:GetComponent(self._componentId)
  local strTitle, strDesc = component:GetStageTitleDesc(self._levelId)
  local tb = {
    "_txtTitle_lock",
    "_txtTitle_lock",
    "_txtTitle_unlock",
    "_txtTitle_pass"
  }
  local widgetName = tb[self._state]
  if not string.isnullorempty(widgetName) then
    local obj = self:GetUIComponent("UILocalizationText", widgetName)
    obj:SetText(StringTable.Get(strTitle))
  end
end

function UIN12EntrustStageNode:_SetExplorText_Once()
  local component = self._campaign:GetComponent(self._componentId)
  local num = component:GetExplorNum(self._levelId)
  self:_SetExplorText(num .. "%")
end

function UIN12EntrustStageNode:_SetExplorText_Anim()
  local component = self._campaign:GetComponent(self._componentId)
  local target = component:GetExplorNum(self._levelId)
  local cfg = Cfg.cfg_n12_entrust_anim[1]
  local duration = cfg.StageExploreTime / 1000
  DoTweenHelper.DoUpdateFloat(0, 1, duration, function(percent)
    local num = DG.Tweening.DOVirtual.EasedValue(0, target, percent, DG.Tweening.Ease.OutQuad)
    self:_SetExplorText(math.floor(num) .. "%")
  end)
end

function UIN12EntrustStageNode:_SetExplorText(txt)
  local tb = {
    "",
    "",
    "_txtExplor_unlock",
    "_txtExplor_pass"
  }
  local widgetName = tb[self._state]
  if not string.isnullorempty(widgetName) then
    local obj = self:GetUIComponent("UILocalizationText", widgetName)
    obj:SetText(txt)
  end
end

function UIN12EntrustStageNode:BtnOnClick()
  Log.info("UIN12EntrustStageNode:BtnOnClick")
  if self._state == EEntrustStageNodeState.LockWithTime then
    ToastManager.ShowToast(StringTable.Get("str_n12_entrust_stage_lock_tips"))
  elseif self._state == EEntrustStageNodeState.Lock then
    ToastManager.ShowToast(StringTable.Get("str_n12_entrust_stage_lock_tips"))
  else
    self:ShowDialog("UIN12EntrustStageDetailController", self._campaign, self._componentId, self._levelId)
  end
end
