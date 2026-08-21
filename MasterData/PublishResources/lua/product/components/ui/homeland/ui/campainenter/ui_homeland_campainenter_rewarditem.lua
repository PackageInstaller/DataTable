_class("UICampainEnterRewardItem", UICustomWidget)
UICampainEnterRewardItem = UICampainEnterRewardItem

function UICampainEnterRewardItem:Constructor()
end

function UICampainEnterRewardItem:OnShow(uiParams)
  self:_GetComponents()
end

function UICampainEnterRewardItem:OnHide()
  if self:CheckOpen(self._info.UnlockTime) then
    self._controller:SetLocalDb(self._info.ID)
  end
  if self.teActivity then
    self.teActivity = UIActivityHelper.CancelTimerEvent(self.teActivity)
    self.teActivity = nil
  end
  if self._coro then
    GameGlobal.TaskManager():KillTask(self._coro)
  end
end

function UICampainEnterRewardItem:FlushTaskCD()
  local unlockTime = self._info.UnlockTime
  if not self:CheckOpen(unlockTime) then
    local svrTimeModule = GameGlobal.GameLogic():GetModule(SvrTimeModule)
    local servertime = math.floor(svrTimeModule:GetServerTime() * 0.001)
    local loginModule = GameGlobal.GetModule(LoginModule)
    local time = loginModule:GetTimeStampByTimeStr(unlockTime, Enum_DateTimeZoneType.E_ZoneType_GMT)
    local timeStr = UIActivityHelper.GetFormatTimerStr(time - servertime, self._customStr)
    self._lockText:SetText(timeStr)
  else
    self:Flush()
    self._lockText:SetText("")
    self.teActivity = UIActivityHelper.CancelTimerEvent(self.teActivity)
    self.teActivity = nil
  end
end

function UICampainEnterRewardItem:SetData(info, controller)
  self._info = info
  self._controller = controller
  self:GetTaskInfo()
  self:Flush()
  if self.teActivity then
    self.teActivity = UIActivityHelper.CancelTimerEvent(self.teActivity)
    self.teActivity = nil
  end
  self.teActivity = UIActivityHelper.StartTimerEvent(self.teActivity, function()
    self:FlushTaskCD()
  end, 1000)
  self._coro = self:StartTask(self.ShowAnim, self)
end

function UICampainEnterRewardItem:Flush()
  local unlockTime = self._info.UnlockTime
  local unlock = self:CheckOpen(unlockTime)
  if unlock then
    local isNew = self._controller:GetLocalDb(self._info.ID)
    local stata = self._controller:GetTaskState(self._info.ID)
    self._new:SetActive(isNew == 0 and stata <= Enum_CMP_HomelandTaskState.EPTS_UnComplete)
  else
    self._new:SetActive(false)
  end
  self._titleText:SetText(StringTable.Get(self._info.Content))
  self:SetRewardItem(self._info)
  self:SetState()
end

function UICampainEnterRewardItem:_GetComponents()
  self._rewards = self:GetUIComponent("UISelectObjectPath", "Rewards")
  self._titleText = self:GetUIComponent("UILocalizationText", "Title")
  self._contentText = self:GetUIComponent("UILocalizationText", "Content")
  self._stateText = self:GetUIComponent("UILocalizationText", "StateText")
  self._lockText = self:GetUIComponent("UILocalizationText", "lockText")
  self._getRewardBtn = self:GetGameObject("GetRewardBtn")
  self._ani = self:GetUIComponent("Animation", "root")
  self._stateBg1 = self:GetGameObject("State1")
  self._stateBg2 = self:GetGameObject("State2")
  self._stateBg3 = self:GetGameObject("State3")
  self._new = self:GetGameObject("new")
  self._got = self:GetGameObject("Gray")
  self._lockimg = self:GetGameObject("LockImg")
  self:SetCustomTimeStr_Common()
end

function UICampainEnterRewardItem:SetState()
  self._stata = self._controller:GetTaskState(self._info.ID)
  local stateDtr = ""
  if self._stata == Enum_CMP_HomelandTaskState.EPTS_UnComplete then
    stateDtr = "str_homeland_campainenter_itemstate"
  end
  self._stateBg1:SetActive(self._stata == Enum_CMP_HomelandTaskState.EPTS_UnComplete)
  self._stateBg2:SetActive(self._stata == Enum_CMP_HomelandTaskState.EPTS_UnHave)
  self._stateBg3:SetActive(self._stata == Enum_CMP_HomelandTaskState.EPTS_HaveGet or self._stata == Enum_CMP_HomelandTaskState.EPTS_Unlock)
  self._stateText:SetText(StringTable.Get(stateDtr))
  self._getRewardBtn:SetActive(false)
  self._lockimg:SetActive(self._stata == Enum_CMP_HomelandTaskState.EPTS_Unlock)
  self._got:SetActive(self._stata == Enum_CMP_HomelandTaskState.EPTS_HaveGet or self._stata == Enum_CMP_HomelandTaskState.EPTS_UnHave)
end

function UICampainEnterRewardItem:GetRewardBtnOnClick()
  self._controller:GetReward(self._info.ID)
end

function UICampainEnterRewardItem:SetRewardItem(info)
  local rewards = info.Rewards
  local count = #rewards
  if count <= 0 then
    return
  end
  self._rewards:SpawnObjects("UIItemHomeland", count)
  local items = self._rewards:GetAllSpawnList()
  for i = 1, #items do
    if rewards[i] then
      local rew = {}
      rew.assetid = rewards[i][1]
      rew.count = rewards[i][2]
      items[i]:Flush(rew)
    end
  end
end

function UICampainEnterRewardItem:GetTaskInfo()
  self._holdTask = self._info.TaskID
  self._taskCfg = self._controller:GetTaskItemCfg(self._holdTask)
end

function UICampainEnterRewardItem:CheckOpen(beginTime, timetype)
  local svrTimeModule = GameGlobal.GameLogic():GetModule(SvrTimeModule)
  local curTime = math.floor(svrTimeModule:GetServerTime() * 0.001)
  local loginModule = GameGlobal.GetModule(LoginModule)
  timetype = timetype or 0
  local type = timetype == 0 and Enum_DateTimeZoneType.E_ZoneType_GMT or Enum_DateTimeZoneType.E_ZoneType_ServerTimeZone
  local beginTime = loginModule:GetTimeStampByTimeStr(beginTime, type)
  if curTime >= beginTime then
    return true
  end
  return false
end

function UICampainEnterRewardItem:SetCustomTimeStr_Common()
  self:SetCustomTimeStr({
    day = "str_activity_common_day",
    hour = "str_activity_common_hour",
    min = "str_activity_common_minute",
    zero = "str_activity_common_less_minute",
    over = "str_activity_common_less_minute"
  })
end

function UICampainEnterRewardItem:SetCustomTimeStr(customStr)
  self._customStr = customStr
end

function UICampainEnterRewardItem:GetLocalDbIsNew(taskId)
  return self._controller:GetLocalDbIsNew("N19TaskComp", taskId)
end

function UICampainEnterRewardItem:SetLocalDbIsNew(taskId)
  self._controller:SetLocalDbIsNew("N19TaskComp", taskId)
end

function UICampainEnterRewardItem:ShowAnim(TT)
  YIELD(TT, 48)
  self._ani:Play("uieff_N19_CampainEnterItem_in")
end
