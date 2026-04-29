_class("UISendPetQuestWidget", UICustomWidget)
UISendPetQuestWidget = UISendPetQuestWidget

function UISendPetQuestWidget:OnShow(uiParam)
  self._progressLable = self:GetUIComponent("UILocalizationText", "progrestext")
  self._descTex = self:GetUIComponent("UILocalizationText", "descTex")
  self._typeTex = self:GetUIComponent("UILocalizationText", "typeTex")
  self._progresNow = self:GetUIComponent("UILocalizationText", "progresNow")
  self._progresAll = self:GetUIComponent("UILocalizationText", "progresAll")
  self._questTypeGO = self:GetGameObject("questType")
  self._pool = self:GetUIComponent("UISelectObjectPath", "pool")
  self._noOpen = self:GetGameObject("noOpen")
  self._doing = self:GetGameObject("doing")
  self._finish = self:GetGameObject("finish")
  self._com = self:GetGameObject("com")
  self._noOpen = self:GetGameObject("noOpen")
  self._over = self:GetGameObject("over")
  self._doingTxtGO = self:GetGameObject("doingTxt")
  self._jumpBtnGO = self:GetGameObject("JumpBtn")
  self._noOpenText = self:GetUIComponent("UILocalizationText", "noOpenText")
end

function UISendPetQuestWidget:OnHide()
  if self._timer then
    GameGlobal.Timer():CancelEvent(self._timer)
  end
end

function UISendPetQuestWidget:SetData(idx, campaign, questInfo, callback, awardClickCallBack)
  self._idx = idx
  self._campaign = campaign
  self._questInfo = questInfo
  self._callback = callback
  self._awardClickCallBack = awardClickCallBack
  self._svrTimeModule = GameGlobal.GetModule(SvrTimeModule)
  self:OnRefresh()
end

function UISendPetQuestWidget:OnRefresh()
  self.component_quest = Cfg.cfg_component_quest({
    QuestID = self._questInfo.quest_id
  })
  local loginModule = GameGlobal.GetModule(LoginModule)
  self._over:SetActive(false)
  self.openTime = loginModule:GetTimeStampByTimeStr(self.component_quest[1].OpenDateTime, Enum_DateTimeZoneType.E_ZoneType_GMT)
  self.endTime = loginModule:GetTimeStampByTimeStr(self.component_quest[1].EndDateTime, Enum_DateTimeZoneType.E_ZoneType_GMT)
  if self._questInfo.ShowType == 2 then
    if self._questInfo.status <= QuestStatus.QUEST_Accepted then
      self._questInfo.cur_progress = 0
      self._questInfo.total_progress = 1
    else
      self._questInfo.cur_progress = 1
      self._questInfo.total_progress = 1
    end
  end
  local nowTime = math.ceil(self._svrTimeModule:GetServerTime() * 0.001)
  local secStart = self.openTime - nowTime
  local secEnd = nowTime - self.endTime
  local bFinish = self._questInfo.status == QuestStatus.QUEST_Taken or 0 < secEnd and self._questInfo.status == QuestStatus.QUEST_Accepted
  if bFinish then
    local finishColor = "#B0B0B0"
    local str = UIActivityHelper.GetColorText(finishColor, StringTable.Get(self._questInfo.CondDesc))
    self._descTex:SetText(str)
    self._progressLable:SetText(UIActivityHelper.GetColorText(finishColor, StringTable.Get("str_cn15_n44_6xpet_task_1")))
    self._progresNow:SetText(UIActivityHelper.GetColorText(finishColor, "   " .. self._questInfo.cur_progress))
    self._progresAll:SetText(UIActivityHelper.GetColorText(finishColor, "/" .. self._questInfo.total_progress))
  else
    local color1 = "#F7C589"
    local color2 = "#E0E0E0"
    self._descTex:SetText(UIActivityHelper.GetColorText(color2, StringTable.Get(self._questInfo.CondDesc)))
    self._progressLable:SetText(UIActivityHelper.GetColorText(color2, StringTable.Get("str_cn15_n44_6xpet_task_1")))
    if self._questInfo.cur_progress >= self._questInfo.total_progress then
      local str = UIActivityHelper.GetColorText(color1, self._questInfo.cur_progress)
      self._progresNow:SetText("   " .. str)
    else
      self._progresNow:SetText("   " .. self._questInfo.cur_progress)
    end
    self._progresAll:SetText(UIActivityHelper.GetColorText(color2, "/" .. self._questInfo.total_progress))
  end
  local awards = self._questInfo.rewards[1]
  local uiasset = self._pool:SpawnObject("UIAsset")
  local cfg_item = Cfg.cfg_item[awards.assetid]
  local params = {}
  params.quality = cfg_item.Color
  params.icon = cfg_item.Icon
  params.text = awards.count
  uiasset:SetItemData(params)
  uiasset:SetData(awards.assetid)
  self._noOpen:SetActive(0 < secStart)
  self._over:SetActive(0 < secEnd and self._questInfo.status == QuestStatus.QUEST_Accepted)
  self._doing:SetActive(self._questInfo.status == QuestStatus.QUEST_Accepted and secStart < 0 and secEnd <= 0)
  self._com:SetActive(self._questInfo.status == QuestStatus.QUEST_Completed)
  self._finish:SetActive(self._questInfo.status == QuestStatus.QUEST_Taken)
  self._doingTxtGO:SetActive(self._questInfo.status == QuestStatus.QUEST_Accepted and (self._questInfo.JumpID == nil or self._questInfo.JumpID == 0))
  self._jumpBtnGO:SetActive(self._questInfo.status == QuestStatus.QUEST_Accepted and self._questInfo.JumpID ~= nil and self._questInfo.JumpID ~= 0)
  local cfg_com_quest = Cfg.cfg_component_quest({
    QuestID = self._questInfo.quest_id
  })[1]
  local tex
  if cfg_com_quest.NeedReset then
    self._questTypeGO:SetActive(true)
    tex = "str_sakura_specialtask_daily"
  else
    self._questTypeGO:SetActive(false)
  end
  self._typeTex:SetText(StringTable.Get(tex))
  if 0 < secStart then
    self:ShowTimer()
  end
end

function UISendPetQuestWidget:GetBtnOnClick(go)
  if self:CheckActivityOver() then
    return
  end
  if self._callback then
    self._callback(self._questInfo.quest_id)
  end
end

function UISendPetQuestWidget:JumpBtnOnClick(go)
  if self._questInfo and self._questInfo.status >= QuestStatus.QUEST_Completed then
    return
  end
  local isOver = self._questInfo.status == QuestStatus.QUEST_Completed
  if isOver then
    return
  end
  if self:CheckActivityOver() then
    return
  end
  local questModule = GameGlobal.GetModule(QuestModule)
  local jumpModule = questModule.uiModule
  local jumpType = self._questInfo.JumpID
  local jumpParams = self._questInfo.JumpParam
  if jumpType == 0 then
    return
  end
  if jumpType == UIJumpType.UI_JumpSeasonMainKV then
    local isLock, isTime, isMission = self:GetLockReason()
    if isLock then
      if isTime then
        local tips = StringTable.Get("str_activity_error_110")
        ToastManager.ShowToast(tips)
      elseif isMission then
        local tips = StringTable.Get("str_function_lock_season_tips")
        ToastManager.ShowToast(tips)
      else
        Log.error("###[UIMainLobbySeasonEntry] season is lock , reason is other ?")
      end
      return
    end
  end
  jumpModule:SetJumpUIData(jumpType, jumpParams)
  jumpModule:Jump()
end

function UISendPetQuestWidget:AwardBtnOnClick(go)
  if self._awardClickCallBack then
    self._awardClickCallBack(self._questInfo.rewards[1].assetid, go.transform.position)
  end
end

function UISendPetQuestWidget:ShowTimer()
  if self._timer then
    GameGlobal.Timer():CancelEvent(self._timer)
  end
  self._timer = GameGlobal.Timer():AddEventTimes(1000, TimerTriggerCount.Infinite, function()
    self:ShowTimeTex()
  end)
  self:ShowTimeTex()
end

function UISendPetQuestWidget:ShowTimeTex()
  local loginModule = GameGlobal.GetModule(LoginModule)
  self.openTime = loginModule:GetTimeStampByTimeStr(self.component_quest[1].OpenDateTime, Enum_DateTimeZoneType.E_ZoneType_GMT)
  self.endTime = loginModule:GetTimeStampByTimeStr(self.component_quest[1].EndDateTime, Enum_DateTimeZoneType.E_ZoneType_GMT)
  local nowTime = math.ceil(self._svrTimeModule:GetServerTime() * 0.001)
  local secStart = self.openTime - nowTime
  if 0 <= secStart then
    local secStr = HelperProxy:GetInstance():Time2Tex(secStart)
    self._noOpenText:SetText(StringTable.Get("str_n13_garden_remaining_open_time", secStr))
  else
    self:OnRefresh()
  end
end

function UISendPetQuestWidget:CheckActivityOver()
  local sample = self._campaign:GetSample()
  if not sample then
    ToastManager.ShowToast(StringTable.Get("str_activity_common_notice_content"))
    GameGlobal.EventDispatcher():Dispatch(GameEventType.ActivityCloseEvent, self._campaign._id)
    self:RootUIOwner():CloseDialog()
    return true
  end
  local curTime = self._svrTimeModule:GetServerTime() * 0.001
  local endTime = sample.end_time
  if curTime < endTime then
    return false
  else
    ToastManager.ShowToast(StringTable.Get("str_activity_common_notice_content"))
    GameGlobal.EventDispatcher():Dispatch(GameEventType.ActivityCloseEvent, self._campaign._id)
    self:RootUIOwner():CloseDialog()
    return true
  end
end

function UISendPetQuestWidget:GetLockReason()
  local isTime = false
  local isMission = false
  local lock = false
  Log.debug("###[UIMainLobbySeasonEntry] start check season entry open .")
  local cfg_campaings = Cfg.cfg_campaign({
    CampaignType = ECampaignType.CAMPAIGN_TYPE_INLAND_SEASON
  })
  local season_cfg
  if cfg_campaings and next(cfg_campaings) then
    local svrTime = GameGlobal.GetModule(SvrTimeModule):GetServerTime() * 0.001
    for key, value in pairs(cfg_campaings) do
      local loginModule = GameGlobal.GetModule(LoginModule)
      local openTime = value.BeginTime
      local closeTime = value.EndTime
      local open = loginModule:GetTimeStampByTimeStr(openTime, Enum_DateTimeZoneType.E_ZoneType_ServerTimeZone)
      local close = loginModule:GetTimeStampByTimeStr(closeTime, Enum_DateTimeZoneType.E_ZoneType_ServerTimeZone)
      if svrTime >= open and svrTime < close then
        season_cfg = value
        break
      end
    end
  end
  if season_cfg then
    local missionid = season_cfg.NeedMissionID
    local missionModule = GameGlobal.GetModule(MissionModule)
    local ispass = missionModule:IsPassMissionID(missionid)
    if ispass then
      Log.debug("###[UIMainLobbySeasonEntry] season entry is open !")
    else
      lock = true
      isMission = true
    end
  else
    lock = true
    isTime = true
  end
  return lock, isTime, isMission
end
