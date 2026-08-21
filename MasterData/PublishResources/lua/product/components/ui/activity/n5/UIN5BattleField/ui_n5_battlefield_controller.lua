_class("UIN5BattleFieldController", UIController)
UIN5BattleFieldController = UIN5BattleFieldController

function UIN5BattleFieldController:LoadDataOnEnter(TT, res, uiParams)
  self._svrTimeModule = self:GetModule(SvrTimeModule)
  self._loginModule = self:GetModule(LoginModule)
  self._campaignModule = self:GetModule(CampaignModule)
  self._campaign = UIActivityCampaign:New()
  self._campaign:LoadCampaignInfo(TT, res, ECampaignType.CAMPAIGN_TYPE_N5, ECampaignN5ComponentID.ECAMPAIGN_N5_BATTLEFIELD)
  self._campaign:ReLoadCampaignInfo_Force(TT, res)
  self._localProgress = self._campaignModule:GetCampaignLocalProcess(ECampaignType.CAMPAIGN_TYPE_N5)
  if res and not res:GetSucc() then
    self._campaignModule:CheckErrorCode(res.m_result, self._campaign._id, nil, nil)
    return
  end
  self._component = self._campaign:GetComponent(ECampaignN5ComponentID.ECAMPAIGN_N5_BATTLEFIELD)
  self._componentInfo = self._campaign:GetComponentInfo(ECampaignN5ComponentID.ECAMPAIGN_N5_BATTLEFIELD)
  local openTime = self._componentInfo.m_unlock_time
  local closeTime = self._componentInfo.m_close_time
  local nowtime = self._svrTimeModule:GetServerTime() * 0.001
  if openTime > nowtime then
    res.m_result = CampaignErrorType.E_CAMPAIGN_ERROR_TYPE_CAMPAIGN_NO_OPEN
    self._campaignModule:ShowErrorToast(res.m_result, true)
    return
  end
  if closeTime < nowtime then
    res.m_result = CampaignErrorType.E_CAMPAIGN_ERROR_TYPE_CAMPAIGN_FINISHED
    self._campaignModule:ShowErrorToast(res.m_result, true)
    return
  end
  self._day = self._componentInfo.m_battlefield_info.m_cur_index
end

function UIN5BattleFieldController:Constructor()
  self._cfg_battlefields = Cfg.cfg_component_battlefield()
  self._stageItems = nil
  self._stageItemsCount = 4
  self._stageItemPositions = {
    Vector2(-686.25, 0),
    Vector2(-228.75, 0),
    Vector2(228.75, 0),
    Vector2(686.25, 0)
  }
end

function UIN5BattleFieldController:OnShow(uiParams)
  self:_GetComponents()
  self:_OnValue()
  self:_StartResetBattleFieldTimer()
end

function UIN5BattleFieldController:_GetComponents()
  self._backBtn = self:GetUIComponent("UISelectObjectPath", "BackBtn")
  self._commonTopBtn = self._backBtn:SpawnObject("UICommonTopButton")
  self._commonTopBtn:SetData(function()
    self:_Close()
  end)
  self._uianim = self:GetGameObject("uianim")
  self._reSetTime = self:GetUIComponent("UILocalizationText", "ReSetTime")
  self._totalMilitaryExploit = self:GetUIComponent("UILocalizationText", "TotalMilitaryExploit")
  self._stage = self:GetUIComponent("UISelectObjectPath", "Stage")
  self._description = self:GetUIComponent("RollingText", "Description")
end

function UIN5BattleFieldController:_OnValue()
  self:_CreateStage()
  self:_RefreshUIInfo()
  self._description:RefreshText(StringTable.Get("str_n5_today_max_militaryexploit"))
  CutsceneManager.ExcuteCutsceneOut()
end

function UIN5BattleFieldController:_StartResetBattleFieldTimer()
  local time = math.ceil(self._componentInfo.m_battlefield_info.m_next_reset_time - self._svrTimeModule:GetServerTime() * 0.001) * 1000
  if time < 0 then
    return
  end
  self._resetTimer = GameGlobal.Timer():AddEvent(time, self._OnTimer, self)
end

function UIN5BattleFieldController:_OnTimer()
  self:StartTask(function(TT)
    local res = AsyncRequestRes:New()
    self._component:HandleBattlefieldDailyReset(TT, res)
    if res and res:GetSucc() then
      self:_ResetBattleFieldUIInfo()
      self._localProgress:RefreshRecordMilitaryExploit()
    end
  end)
end

function UIN5BattleFieldController:_RefreshUIInfo()
  local remainTime = self._componentInfo.m_battlefield_info.m_next_reset_time - self._svrTimeModule:GetServerTime() * 0.001
  self._reSetTime:SetText(StringTable.Get("str_n5_battlefield_resettime", self:_GetRemainTime(remainTime)))
  self._totalMilitaryExploit:SetText(UIActivityHelper.AddZeroFrontNum(6, self._componentInfo.m_battlefield_info.m_accumulated_military_exploit))
end

function UIN5BattleFieldController:_ResetBattleFieldUIInfo()
  self:_RefreshUIInfo()
  for key, value in pairs(self._stageItems) do
    value:RefreshMilitaryExploit(self._componentInfo.m_battlefield_info.m_cur_max_military_exploit, self._componentInfo.m_battlefield_info.m_challenge_mission_info[self._cfg_battlefields[key].CampaignMissionID].military_exploit)
  end
end

function UIN5BattleFieldController:_CreateStage()
  local v2 = Vector2(0.5, 0.5)
  self._stage:SpawnObjects("UIN5BattleFieldItem", self._stageItemsCount)
  self._stageItems = self._stage:GetAllSpawnList()
  for i = 1, self._stageItemsCount do
    self._stageItems[i].view.transform.anchorMin = v2
    self._stageItems[i].view.transform.anchorMax = v2
    self._stageItems[i].view.transform.pivot = v2
    self._stageItems[i].view.transform.anchoredPosition = self._stageItemPositions[i]
    self._stageItems[i]:SetData(i, self._cfg_battlefields[i], self._componentInfo.m_battlefield_info.m_cur_max_military_exploit, self._componentInfo.m_battlefield_info.m_challenge_mission_info[self._cfg_battlefields[i].CampaignMissionID], function(index)
      self:_OnClickItem(index)
    end)
  end
end

function UIN5BattleFieldController:_OnClickItem(index)
  self:Lock("UIN5BattleFieldController:_OnClickItem")
  GameGlobal.Timer():AddEvent(333, function()
    self:_ShowBattleFieldStageInfo(index)
    self:UnLock("UIN5BattleFieldController:_OnClickItem")
  end)
end

function UIN5BattleFieldController:_ShowBattleFieldStageInfo(index)
  local missionId = self._cfg_battlefields[index].CampaignMissionID
  local cfg_conquest_mission = Cfg.cfg_conquest_mission({
    MissionID = missionId,
    RandomID = self._day
  })
  if not cfg_conquest_mission then
    Log.error(string.format("cfg_conquest_mission error: missionid:%d, day:%d", missionId, self._day))
    return
  end
  self:ShowDialog("UIN5BattleFieldStageInfo", self._cfg_battlefields[index], cfg_conquest_mission, self._componentInfo)
end

function UIN5BattleFieldController:_Close()
  AudioHelperController.PlayUISoundAutoRelease(CriAudioIDConst.N5CloseDoor)
  CutsceneManager.ExcuteCutsceneIn(UIStateType.UIActivityN5, function()
    self._campaignModule:CampaignSwitchState(true, UIStateType.UIActivityN5, UIStateType.UIMain, nil, self._campaign._id)
  end)
end

function UIN5BattleFieldController:OnHide()
  if self._resetTimer then
    GameGlobal.Timer():CancelEvent(self._resetTimer)
    self._resetTimer = nil
  end
end

function UIN5BattleFieldController:MilitaryExploitOnClick(go)
  self:ShowDialog("UIN5ProgressController", ECampaignType.CAMPAIGN_TYPE_N5)
end

function UIN5BattleFieldController:_GetRemainTime(time)
  local day, hour, minute
  day = math.floor(time / 86400)
  hour = math.floor(time / 3600) % 24
  minute = math.floor(time / 60) % 60
  local timestring = ""
  if 0 < day then
    timestring = "<color=#E03D22>" .. day .. "</color>" .. StringTable.Get("str_activity_common_day") .. "<color=#E03D22>" .. hour .. "</color>" .. StringTable.Get("str_activity_common_hour")
  elseif 0 < hour then
    timestring = "<color=#E03D22>" .. hour .. "</color>" .. StringTable.Get("str_activity_common_hour") .. "<color=#E03D22>" .. minute .. "</color>" .. StringTable.Get("str_activity_common_minute")
  elseif 0 < minute then
    timestring = "<color=#E03D22>" .. minute .. "</color>" .. StringTable.Get("str_activity_common_minute")
  else
    timestring = StringTable.Get("str_activity_common_less_minute")
  end
  return string.format(StringTable.Get("str_activity_common_over"), timestring)
end
