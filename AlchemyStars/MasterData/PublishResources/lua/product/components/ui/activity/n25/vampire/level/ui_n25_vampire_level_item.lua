_class("UIN25VampireLevelItem", UICustomWidget)
UIN25VampireLevelItem = UIN25VampireLevelItem

function UIN25VampireLevelItem:Constructor()
  self.mCampaign = self:GetModule(CampaignModule)
end

function UIN25VampireLevelItem:OnShow(uiParams)
  self._atlas = self:GetAsset("UIN25VampireTaskAndLevel.spriteatlas", LoadType.SpriteAtlas)
  self.titletxt1 = self:GetUIComponent("UILocalizationText", "title1")
  self.titletxt2 = self:GetUIComponent("UILocalizationText", "title2")
  self.exptxt1 = self:GetUIComponent("UILocalizationText", "count1")
  self.exptxt2 = self:GetUIComponent("UILocalizationText", "count2")
  self._time = self:GetUIComponent("UILocalizationText", "time")
  self.lockGo = self:GetGameObject("lock")
  self.root = self:GetGameObject("root")
  self.anim = self:GetUIComponent("Animation", "ani")
  self.bg1 = self:GetGameObject("bg1")
  self.bg2 = self:GetGameObject("bg2")
  self.btn = self:GetGameObject("Btn")
  self.eff = self:GetGameObject("eff")
  self:AttachEvent(GameEventType.OnVampireChallengeTaskItemClick, self.OnVampireChallengeTaskItemClick)
end

function UIN25VampireLevelItem:OnHide()
  self:DetachEvent(GameEventType.OnVampireChallengeTaskItemClick, self.OnVampireChallengeTaskItemClick)
end

function UIN25VampireLevelItem:Flush(data, manager, activity, sv, selected)
  self.root:SetActive(true)
  self.anim:Play("uieffanim_UIN25VampireLevelItem_in")
  self.manager = manager
  self.data = data
  self.itemId = data.Index
  self.activityN25Const = activity
  self._scrollRect = sv
  self.exptxt1:SetText(self.data.WaveDesc)
  self.exptxt2:SetText(self.data.WaveDesc)
  self.titletxt1:SetText(StringTable.Get(self.data.MissionName))
  self.titletxt2:SetText(StringTable.Get(self.data.MissionName))
  local lastMissionPassed = true
  if self.data.NeedMission then
    lastMissionPassed = self.activityN25Const:CheckBloodSuckerMissionPassed(self.data.NeedMission)
  end
  local passed = self.activityN25Const:CheckBloodSuckerMissionPassed(self.data.CampaignMissionID)
  self.isLock = not passed and (not lastMissionPassed or not not passed)
  self.bg2:SetActive(selected)
  self.bg1:SetActive(not selected)
  local unLockTime = 0
  self._isTimeLock, unLockTime = self:CheckIsTimeLock()
  self.lockGo:SetActive(self.isLock or self._isTimeLock)
  self.eff:SetActive(not self.isLock and not self._isTimeLock)
  if self._isTimeLock then
    self._time.gameObject:SetActive(true)
    self._time:SetText(StringTable.Get("str_n25_vampire_time_unlock", UIActivityHelper.GetFormatTimerStr(unLockTime)))
  elseif self.isLock then
    self._time.gameObject:SetActive(true)
    self._time:SetText(StringTable.Get("str_n25_vampire_level_unlock"))
  else
    self._time.gameObject:SetActive(false)
  end
  if self.btn then
    self.etl = UICustomUIEventListener.Get(self.btn)
    self:AddUICustomEventListener(self.etl, UIEvent.BeginDrag, function(eventData)
      self._draging = true
      self._scrollRect:OnBeginDrag(eventData)
    end)
    self:AddUICustomEventListener(self.etl, UIEvent.Drag, function(eventData)
      self._scrollRect:OnDrag(eventData)
    end)
    self:AddUICustomEventListener(self.etl, UIEvent.EndDrag, function(eventData)
      self._draging = false
      self._scrollRect:OnEndDrag(eventData)
    end)
  end
end

function UIN25VampireLevelItem:BtnOnClick(go)
  if self._isTimeLock then
    ToastManager.ShowToast(StringTable.Get("str_n25_vampire_time_unlock_tip"))
    return
  elseif self.isLock then
    ToastManager.ShowToast(StringTable.Get("str_n25_level_lock"))
    return
  end
  if self.manager then
    self.manager:OnSelectItem(self.itemId)
  end
end

function UIN25VampireLevelItem:OnVampireChallengeTaskItemClick(id)
  self.bg2:SetActive(self.itemId == id)
  self.bg1:SetActive(self.itemId ~= id)
end

function UIN25VampireLevelItem:OnDrag(id)
end

function UIN25VampireLevelItem:OnBeginDrag(id)
end

function UIN25VampireLevelItem:OnEndDrag(id)
end

function UIN25VampireLevelItem:CheckIsTimeLock()
  if not self.data.UnLockTime then
    return false
  end
  local loginModule = GameGlobal.GetModule(LoginModule)
  local svrTimeModule = GameGlobal.GetModule(SvrTimeModule)
  local curTime = math.floor(svrTimeModule:GetServerTime() * 0.001)
  local unLockTime = loginModule:GetTimeStampByTimeStr(self.data.UnLockTime, Enum_DateTimeZoneType.E_ZoneType_GMT)
  return curTime < unLockTime, unLockTime - curTime
end
