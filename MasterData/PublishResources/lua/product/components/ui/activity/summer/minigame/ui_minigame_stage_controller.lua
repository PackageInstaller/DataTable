_class("UIMiniGameStageController", UIController)
UIMiniGameStageController = UIMiniGameStageController

function UIMiniGameStageController:Constructor()
  self._wayPointCell = {}
  self._wayLineCell = {}
  self._curMissionID = 0
  self._firstMissionID = 1
  self._rewards = nil
  self._textColor = {
    [true] = Color(1, 1, 1, 1),
    [false] = Color(1, 1, 1, 0.8)
  }
  self._componentID = 122110007
end

function UIMiniGameStageController:LoadDataOnEnter(TT, res, uiParams)
  self._svrTimeModule = self:GetModule(SvrTimeModule)
  self._loginModule = self:GetModule(LoginModule)
  self._campaignModule = self:GetModule(CampaignModule)
  self._gameName = "game1"
  if not uiParams or not uiParams[1] then
    local campaignType = ECampaignType.CAMPAIGN_TYPE_N48
    local componentIds = {}
    self._campaign = UIActivityHelper.LoadDataOnEnter(TT, res, campaignType, componentIds)
    if res and not res:GetSucc() then
      self._campaignModule:CheckErrorCode(res.m_result, self._campaign._id, nil, nil)
      return
    end
    self._process = self._campaign:GetLocalProcess()
    self._component = self._process:GetComponent(UIActivityN48Helper.GetComponentId("game"))
  else
    self._campaign = uiParams[1]
    self._component = uiParams[2]
  end
  self._componentInfo = self._component:GetComponentInfo()
  local openTime = self._componentInfo.m_unlock_time
  local closeTime = self._componentInfo.m_close_time
  local nowtime = self._svrTimeModule:GetServerTime() / 1000
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
end

function UIMiniGameStageController:OnShow(uiParams)
  self._cfg_stage = Cfg.cfg_component_mini_game_mission({
    ComponentID = self._componentID
  })
  table.sort(self._cfg_stage, function(a, b)
    return a.ID < b.ID
  end)
  self._firstMissionID = self._cfg_stage[1].ID
  self._lastBGMResName = AudioHelperController.GetCurrentBgm()
  self:_GetComponents()
  self:_OnValue()
end

function UIMiniGameStageController:_GetComponents()
  self._backBtn = self:GetUIComponent("UISelectObjectPath", "BackBtn")
  self._commonTopBtn = self._backBtn:SpawnObject("UICommonTopButton")
  self._commonTopBtn:SetData(function()
    self:_Close()
  end, function()
    self:ShowDialog("UIHelpController", "UIMiniGameStageController")
  end)
  self._remainTime = self:GetUIComponent("UILocalizationText", "Time")
  self._itemTips = self:GetUIComponent("UISelectObjectPath", "ItemTips")
  self._tips = self._itemTips:SpawnObject("UISelectInfo")
  self._content = self:GetUIComponent("RectTransform", "Content")
  self._wayPoint = self:GetUIComponent("UISelectObjectPath", "WayPoint")
  self._wayLine = self:GetUIComponent("UISelectObjectPath", "WayLine")
  self._title = self:GetUIComponent("UILocalizationText", "Title")
  self._stageDescription = self:GetUIComponent("UILocalizationText", "StageDescription")
  self._bestScore = self:GetUIComponent("UILocalizationText", "BestScore")
  self._description = self:GetUIComponent("UILocalizationText", "Description")
  self._reward = self:GetUIComponent("UISelectObjectPath", "Reward")
  self._selectMakt = self:GetGameObject("SelectMark")
  self._mark = self:GetGameObject("Mark")
  self._BASBtn = {}
  self._BASBtn[ScoreType.B] = self:GetGameObject("B")
  self._BASBtn[ScoreType.A] = self:GetGameObject("A")
  self._BASBtn[ScoreType.S] = self:GetGameObject("S")
  self._BASScore = {}
  self._BASScore[ScoreType.B] = self:GetUIComponent("UILocalizationText", "BScore")
  self._BASScore[ScoreType.A] = self:GetUIComponent("UILocalizationText", "AScore")
  self._BASScore[ScoreType.S] = self:GetUIComponent("UILocalizationText", "SScore")
  self._BASRedPoint = {}
  self._BASRedPoint[ScoreType.B] = self:GetGameObject("BRedPoint")
  self._BASRedPoint[ScoreType.A] = self:GetGameObject("ARedPoint")
  self._BASRedPoint[ScoreType.S] = self:GetGameObject("SRedPoint")
  self._BASState = {}
  self._BASState[ScoreType.B] = self:GetGameObject("BState")
  self._BASState[ScoreType.A] = self:GetGameObject("AState")
  self._BASState[ScoreType.S] = self:GetGameObject("SState")
  self._receiveRewardBtnText = self:GetUIComponent("UILocalizationText", "ReceiveRewardBtnText")
  self._receiveRewardBtnLock = self:GetGameObject("ReceiveRewardBtnLock")
  self._storyBtn = self:GetGameObject("StoryBtn")
  self._atlas = self:GetAsset("UISummer.spriteatlas", LoadType.SpriteAtlas)
  self._stageAnimation = self:GetUIComponent("Animation", "StageAnimation")
  self._switchAnimation = self:GetUIComponent("Animation", "Mark")
  self._light = self:GetGameObject("Light")
  self._blackMask = self:GetGameObject("black_mask")
end

function UIMiniGameStageController:_OnValue()
  self:_PlayStory()
  self:_SetRemainTime()
  self:_CreateStageMap()
  self:_ClickWayPoint(self._cfg_stage[1].ID, false)
  self._description:SetText(StringTable.Get("str_summer_minigame_description"))
end

function UIMiniGameStageController:_PlayStory()
  if LocalDB.GetInt("ui_minigame_first_story" .. self._loginModule:GetRoleShowID()) > 0 then
    return
  end
  self:_hide(true)
  GameGlobal.GetModule(StoryModule):StartStory(self._componentInfo.m_first_story_id, function()
    self:_hide(false)
    AudioHelperController.PlayBGM(self._lastBGMResName, AudioConstValue.BGMCrossFadeTime)
    LocalDB.SetInt("ui_minigame_first_story" .. self._loginModule:GetRoleShowID(), 1)
  end)
end

function UIMiniGameStageController:_SetRemainTime()
  local time = math.floor(self._svrTimeModule:GetServerTime() * 0.001)
  time = self._componentInfo.m_close_time - time
  self._remainTime:SetText(self:_GetRemainTime(time))
end

function UIMiniGameStageController:_CreateStageMap()
  local wayPointCount = table.count(self._cfg_stage)
  local vector = Vector2(0.5, 0.5)
  local waypoint_offset_y = {
    [0] = -145,
    [1] = 154
  }
  local rotation_z = {
    [0] = 19,
    [1] = -19
  }
  if 5 < wayPointCount then
    self._content.sizeDelta = Vector2(1500 + (wayPointCount - 5) * 500, 0)
  end
  local servertime = math.floor(self._svrTimeModule:GetServerTime() * 0.001)
  self._wayPoint:SpawnObjects("UIMiniGameWayPoint", wayPointCount)
  self._wayPointCell = self._wayPoint:GetAllSpawnList()
  for key, value in pairs(self._wayPointCell) do
    self:_SetWayInfo(value.view.transform, vector, Vector3(self._content.sizeDelta.x * -0.5 + 250 + (key - 1) * 295, waypoint_offset_y[key % 2], 0), Vector3.zero)
    local missionID = self._cfg_stage[key].ID
    value:SetData(self, missionID, self._cfg_stage[key], self._componentInfo.mission_info_list[missionID], servertime, function(missionID)
      self:_ClickWayPoint(missionID, true)
    end, self:_IsNewUnLockMission(missionID))
  end
  self._wayLine:SpawnObjects("UIMiniGameWayLine", wayPointCount - 1)
  self._wayLineCell = self._wayLine:GetAllSpawnList()
  for key, value in pairs(self._wayLineCell) do
    self:_SetWayInfo(value.view.transform, vector, Vector3(self._content.sizeDelta.x * -0.5 + 397.5 + (key - 1) * 295, -25, 0), Vector3(0, 0, rotation_z[key % 2]))
    value:SetData(servertime >= self._componentInfo.mission_info_list[self._cfg_stage[key + 1].ID].unlock_time)
  end
end

function UIMiniGameStageController:_RefreshWayPointWayLineInfo()
  local servertime = math.floor(self._svrTimeModule:GetServerTime() * 0.001)
  for key, value in pairs(self._wayPointCell) do
    value:RefreshUnLockState(servertime)
  end
  for key, value in pairs(self._wayLineCell) do
    value:SetData(servertime >= self._componentInfo.mission_info_list[self._cfg_stage[key + 1].ID].unlock_time)
  end
end

function UIMiniGameStageController:_SetWayInfo(transform, vector2, vector3, eulerAngles)
  transform.anchorMin = vector2
  transform.anchorMax = vector2
  transform.pivot = vector2
  transform.anchoredPosition = vector3
  transform.eulerAngles = eulerAngles
end

function UIMiniGameStageController:_IsNewUnLockMission(id)
  local str = LocalDB.GetString("MiniGameNewStage" .. self._loginModule:GetRoleShowID())
  local ids = string.split(str, ",")
  local nowTime = self._svrTimeModule:GetServerTime() * 0.001
  local mission = self._componentInfo.mission_info_list[id]
  if nowTime >= mission.unlock_time then
    for i = 1, #ids do
      if ids[i] == tostring(id) then
        return false
      end
    end
    return true
  else
    return false
  end
end

function UIMiniGameStageController:_Close()
  local str = LocalDB.GetString("MiniGameNewStage" .. self._loginModule:GetRoleShowID())
  local ids = string.split(str, ",")
  local nowTime = self._svrTimeModule:GetServerTime() * 0.001
  local list = self._componentInfo.mission_info_list
  for key, value in pairs(list) do
    if nowTime >= value.unlock_time then
      local recorded = false
      for j = 1, #ids do
        if ids[j] == tostring(key) then
          recorded = true
        end
      end
      if not recorded then
        str = str .. key .. ","
      end
    end
  end
  LocalDB.SetString("MiniGameNewStage" .. self._loginModule:GetRoleShowID(), str)
  self:CloseDialog()
  if self._callBack then
    self._callBack()
  end
  GameGlobal.EventDispatcher():Dispatch(GameEventType.ActivityDialogRefresh)
end

function UIMiniGameStageController:_ClickWayPoint(missionID, manual)
  if manual then
    AudioHelperController.PlayUISoundAutoRelease(CriAudioIDConst.Summer1ClickNormal)
  end
  if self:_CheckCampaignClose() then
    return
  end
  if manual then
    self._stageAnimation:Play(MGAnimations.Other.Switch)
  end
  self._switchAnimation:Play(MGAnimations.Other.SwitchMark)
  local servertime = math.floor(self._svrTimeModule:GetServerTime() * 0.001)
  local miss_info = self._componentInfo.mission_info_list[missionID]
  if servertime < miss_info.unlock_time then
    ToastManager.ShowToast(StringTable.Get("str_summer_minigame_lock"))
    return
  end
  if self._curMissionID ~= missionID then
    self._curMissionID = missionID
    self:_RefreshUIInfo()
    self:_RefreshSelectMark()
  end
end

function UIMiniGameStageController:_RefreshUIInfo()
  self._current_stage_cfg = self._cfg_stage[self:_GetMissionIndex(self._curMissionID)]
  if self._current_stage_cfg then
    self._title:SetText(StringTable.Get(self._current_stage_cfg.Title))
    self._stageDescription:SetText(StringTable.Get(self._current_stage_cfg.Description))
    local mission_info = self._componentInfo.mission_info_list[self._curMissionID].mission_info
    self._bestScore:SetText(mission_info.max_score)
    self:_RefreshBASInfo(mission_info, self._current_stage_cfg)
    self:_RefreshRewards(ScoreType.B)
    self._storyBtn:SetActive(mission_info.story_mask > 0)
  end
end

function UIMiniGameStageController:_RefreshBASInfo(miss_info, cfg_stage)
  for key, value in pairs(ScoreType) do
    self._BASScore[value]:SetText(cfg_stage.Score[math.min(value, 3)])
    local showredpoint = value <= miss_info.mission_grade and miss_info.reward_mask & value == 0
    self._BASRedPoint[value]:SetActive(showredpoint)
    self._BASState[value]:SetActive(value <= miss_info.mission_grade and not showredpoint)
  end
end

function UIMiniGameStageController:_ReceiveRewardBtnState(mission_info, scoretype)
  local str = ""
  if scoretype > mission_info.mission_grade then
    str = StringTable.Get("str_summer_minigame_notreached")
  elseif mission_info.reward_mask & scoretype == 0 then
    str = StringTable.Get("str_summer_minigame_getaward")
  else
    str = StringTable.Get("str_summer_minigame_gotaward")
  end
  local state = mission_info.reward_mask & scoretype == 0 and scoretype <= mission_info.mission_grade
  self._receiveRewardBtnText:SetText(str)
  self._receiveRewardBtnText.color = self._textColor[state]
  self._receiveRewardBtnLock:SetActive(not state)
  self._light:SetActive(state)
end

function UIMiniGameStageController:_RewardState(mission_info)
  if self._rewards then
    for i = 1, #self._rewards do
      self._rewards[i]:RefreshUIInfo(mission_info)
    end
  end
end

function UIMiniGameStageController:_RefreshSelectMark()
  local gameObject = self._wayPointCell[self:_GetMissionIndex(self._curMissionID)]._di
  self._mark.transform.position = gameObject.transform.position
  self._mark.transform.localPosition = Vector3(self._mark.transform.localPosition.x - 20, self._mark.transform.localPosition.y + 26)
end

function UIMiniGameStageController:_RefreshRewards(scoretype)
  if self._current_stage_cfg then
    self._current_scoretype = scoretype
    local rewards
    if scoretype == ScoreType.B then
      rewards = self._current_stage_cfg.ScoreBReward
    elseif scoretype == ScoreType.A then
      rewards = self._current_stage_cfg.ScoreAReward
    elseif scoretype == ScoreType.S then
      rewards = self._current_stage_cfg.ScoreSReward
    end
    self._selectMakt.transform.localPosition = Vector3(self._BASBtn[scoretype].transform.localPosition.x, 81.6)
    local mission_info = self._componentInfo.mission_info_list[self._curMissionID].mission_info
    self:_ReceiveRewardBtnState(mission_info, scoretype)
    local count = table.count(rewards)
    if 0 < count then
      self._reward:SpawnObjects("UIMiniGameRewardItem", count)
      self._rewards = self._reward:GetAllSpawnList()
      for i = 1, #self._rewards do
        self._rewards[i]:SetData(rewards[i], scoretype, mission_info, function(id, pos)
          self:_ShowRewardTips(id, pos)
        end)
      end
    end
  end
end

function UIMiniGameStageController:_ShowRewardTips(id, pos)
  self._tips:SetData(id, pos)
end

function UIMiniGameStageController:_GetRemainTime(time)
  local day, hour, minute
  day = math.floor(time / 86400)
  hour = math.floor(time / 3600) % 24
  minute = math.floor(time / 60) % 60
  local timestring = ""
  if 0 < day then
    timestring = day .. StringTable.Get("str_activity_common_day") .. hour .. StringTable.Get("str_activity_common_hour")
  elseif 0 < hour then
    timestring = hour .. StringTable.Get("str_activity_common_hour") .. minute .. StringTable.Get("str_activity_common_minute")
  elseif 0 < minute then
    timestring = minute .. StringTable.Get("str_activity_common_minute")
  else
    timestring = StringTable.Get("str_activity_common_less_minute")
  end
  return string.format(StringTable.Get("str_activity_common_over"), timestring)
end

function UIMiniGameStageController:BOnClick()
  AudioHelperController.PlayUISoundAutoRelease(CriAudioIDConst.Summer1ClickNormal)
  self:_RefreshRewards(ScoreType.B)
end

function UIMiniGameStageController:AOnClick()
  AudioHelperController.PlayUISoundAutoRelease(CriAudioIDConst.Summer1ClickNormal)
  self:_RefreshRewards(ScoreType.A)
end

function UIMiniGameStageController:SOnClick()
  AudioHelperController.PlayUISoundAutoRelease(CriAudioIDConst.Summer1ClickNormal)
  self:_RefreshRewards(ScoreType.S)
end

function UIMiniGameStageController:ReceiveRewardBtnOnClick()
  AudioHelperController.PlayUISoundAutoRelease(CriAudioIDConst.Summer1ClickNormal)
  if self._receiveRewardBtnLock.activeSelf then
    return
  end
  self:Lock("UIMiniGameStageController:ReceiveRewardBtnOnClick")
  self:StartTask(function(TT)
    local res = AsyncRequestRes:New()
    local result, rewards = self._component:HandleRecvRewardMsg(TT, res, self._cfg_stage[self:_GetMissionIndex(self._curMissionID)].ID, self._current_scoretype)
    if result and result:GetSucc() then
      self:ShowDialog("UIGetItemController", rewards)
      self:_RefreshUIWhenReceiveReward()
    else
      self:_Close()
    end
    self:UnLock("UIMiniGameStageController:ReceiveRewardBtnOnClick")
  end)
end

function UIMiniGameStageController:_RefreshUIWhenReceiveReward()
  local miss_info = self._componentInfo.mission_info_list[self._curMissionID].mission_info
  local showredpoint = miss_info.mission_grade >= self._current_scoretype and miss_info.reward_mask & self._current_scoretype == 0
  self._BASRedPoint[self._current_scoretype]:SetActive(showredpoint)
  self._BASState[self._current_scoretype]:SetActive(not showredpoint and miss_info.mission_grade >= self._current_scoretype)
  self:_ReceiveRewardBtnState(miss_info, self._current_scoretype)
  self:_RewardState(miss_info)
  self._wayPointCell[self:_GetMissionIndex(self._curMissionID)]:RefreshRedpointStateZi(miss_info)
end

function UIMiniGameStageController:_RefreshUIWhenGameOver()
  local mission_info = self._componentInfo.mission_info_list[self._curMissionID].mission_info
  self._bestScore:SetText(mission_info.max_score)
  self:_RefreshBASInfo(mission_info, self._current_stage_cfg)
  self:_ReceiveRewardBtnState(mission_info, self._current_scoretype)
  self:_RewardState(mission_info)
  self._wayPointCell[self:_GetMissionIndex(self._curMissionID)]:RefreshRedpointStateZi(mission_info)
  self._storyBtn:SetActive(mission_info.story_mask > 0)
  self:_RefreshWayPointWayLineInfo()
end

function UIMiniGameStageController:StoryBtnOnClick()
  AudioHelperController.PlayUISoundAutoRelease(CriAudioIDConst.Summer1ClickNormal)
  if self._curMissionID == self._firstMissionID then
    self:_hide(true)
    GameGlobal.GetModule(StoryModule):StartStory(self._componentInfo.m_first_story_id, function()
      self:_hide(false)
      self:_PlayMissStory()
    end)
  else
    self:_PlayMissStory()
  end
end

function UIMiniGameStageController:_PlayMissStory()
  if self._current_stage_cfg.StoryID[1] then
    self:_hide(true)
    GameGlobal.GetModule(StoryModule):StartStory(self._current_stage_cfg.StoryID[1], function()
      self:_hide(false)
      if self._current_stage_cfg.StoryID[2] then
        self:_hide(true)
        GameGlobal.GetModule(StoryModule):StartStory(self._current_stage_cfg.StoryID[2], function()
          self:_hide(false)
          AudioHelperController.PlayBGM(self._lastBGMResName, AudioConstValue.BGMCrossFadeTime)
        end)
      else
        AudioHelperController.PlayBGM(self._lastBGMResName, AudioConstValue.BGMCrossFadeTime)
      end
    end)
  else
    AudioHelperController.PlayBGM(self._lastBGMResName, AudioConstValue.BGMCrossFadeTime)
  end
end

function UIMiniGameStageController:GameBtnOnClick()
  AudioHelperController.PlayUISoundAutoRelease(CriAudioIDConst.Summer1ClickNormal)
  if self:_CheckCampaignClose() then
    return
  end
  if not self:_CheckPreMission(self._curMissionID) then
    ToastManager.ShowToast(StringTable.Get("str_summer_minigame_premissionunfinished"))
    return
  end
  if table.icontains(self._current_stage_cfg.StoryActiveType, 1) and self._componentInfo.mission_info_list[self._curMissionID].mission_info.story_mask & 1 == 0 then
    self:_hide(true)
    GameGlobal.GetModule(StoryModule):StartStory(self._current_stage_cfg.StoryID[1], function()
      self:StartTask(function(TT)
        local res = AsyncRequestRes:New()
        res = self._component:HandleStoryMsg(TT, res, self._cfg_stage[self:_GetMissionIndex(self._curMissionID)].ID, 1)
        if res:GetSucc() then
          self:ShowDialog("UIMiniGameController", self._current_stage_cfg.ID, self._component, self._componentInfo, self._lastBGMResName, function()
            self:_hide(false)
            self:_RefreshUIWhenGameOver()
          end)
        end
      end)
    end)
  else
    self:ShowDialog("UIMiniGameController", self._current_stage_cfg.ID, self._component, self._componentInfo, self._lastBGMResName, function()
      self:_hide(false)
      self:_RefreshUIWhenGameOver()
    end)
  end
end

function UIMiniGameStageController:_CheckCampaignClose()
  local time = self._componentInfo.m_close_time - math.floor(self._svrTimeModule:GetServerTime() * 0.001)
  if time <= 0 then
    ToastManager.ShowToast(StringTable.Get("str_activity_common_notice_content"))
    self:_Close()
    return true
  end
  return false
end

function UIMiniGameStageController:_CheckPreMission(missionID)
  if missionID == self._firstMissionID then
    return true
  end
  return self._componentInfo.mission_info_list[missionID - 1].mission_info.max_score > 0
end

function UIMiniGameStageController:_hide(hide)
  self._blackMask:SetActive(hide)
end

function UIMiniGameStageController:_GetMissionIndex(missionID)
  for key, value in pairs(self._cfg_stage) do
    if value.ID == missionID then
      return key
    end
  end
  return 1
end
