_class("UIN14FishingGameStageController", UIController)
UIN14FishingGameStageController = UIN14FishingGameStageController

function UIN14FishingGameStageController:Constructor()
  self._wayPointCell = {}
  self._wayLineCell = {}
  self._scoreTypeCell = {}
  self._current_waypoint_index = 0
  self._textColor = {
    [true] = Color(1, 1, 1, 1),
    [false] = Color(1, 1, 1, 0.8)
  }
  self._firstLevelId = 0
end

function UIN14FishingGameStageController:LoadDataOnEnter(TT, res, uiParams)
  self._svrTimeModule = self:GetModule(SvrTimeModule)
  self._loginModule = self:GetModule(LoginModule)
  local campaignModule = self:GetModule(CampaignModule)
  self._campaign = UIActivityCampaign:New()
  self._campaign:LoadCampaignInfo(TT, res, ECampaignType.CAMPAIGN_TYPE_N14, ECampaignN14ComponentID.ECAMPAIGN_N14_MINI_GAME)
  if res and not res:GetSucc() then
    campaignModule:CheckErrorCode(res.m_result, self._campaign._id, nil, nil)
    return
  end
  self._component = self._campaign:GetLocalProcess()._FishingComponent
  self._componentInfo = self._campaign:GetLocalProcess()._FishingComponentInfo
  local openTime = self._componentInfo.m_unlock_time
  local closeTime = self._componentInfo.m_close_time
  local nowtime = self._svrTimeModule:GetServerTime() / 1000
  if openTime > nowtime then
    res.m_result = CampaignErrorType.E_CAMPAIGN_ERROR_TYPE_CAMPAIGN_NO_OPEN
    campaignModule:ShowErrorToast(res.m_result, true)
    return
  end
  if closeTime < nowtime then
    res.m_result = CampaignErrorType.E_CAMPAIGN_ERROR_TYPE_CAMPAIGN_FINISHED
    campaignModule:ShowErrorToast(res.m_result, true)
    return
  end
end

function UIN14FishingGameStageController:OnShow(uiParams)
  self._callBack = uiParams[1]
  local cmpID = self._component:GetComponentCfgId()
  self._cfg_stage = Cfg.cfg_component_mini_game_mission({ComponentID = cmpID})
  self:SortCfgById()
  self._firstLevelId = self:GetFirstMissionId() - 1
  self._lastBGMResName = AudioHelperController.GetCurrentBgm()
  self:_GetComponents()
  self:_OnValue()
  self:AttachEvent(GameEventType.OnN14FishingGameRewardItemReceived, self.ReceiveRewardClickCallback)
  self:AttachEvent(GameEventType.OnN14FishingGameRewardItemClicked, self._ShowRewardTips)
  self:AttachEvent(GameEventType.AfterUILayerChanged, self.AfterUILayerChanged)
end

function UIN14FishingGameStageController:OnHide()
  self:DetachEvent(GameEventType.OnN14FishingGameRewardItemReceived, self.ReceiveRewardClickCallback)
  self:DetachEvent(GameEventType.OnN14FishingGameRewardItemClicked, self._ShowRewardTips)
  self:DetachEvent(GameEventType.AfterUILayerChanged, self.AfterUILayerChanged)
end

function UIN14FishingGameStageController:_GetComponents()
  self._backBtn = self:GetUIComponent("UISelectObjectPath", "BackBtn")
  self._commonTopBtn = self._backBtn:SpawnObject("UICommonTopButton")
  self._commonTopBtn:SetData(function()
    GameGlobal.EventDispatcher():Dispatch(GameEventType.OnCloseMinigame)
    self:CloseDialog()
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
  self._storyBtn = self:GetGameObject("StoryBtn")
  self._stageAnimation = self:GetUIComponent("Animation", "StageAnimation")
  self._blackMask = self:GetGameObject("black_mask")
  self._scoreList = self:GetUIComponent("UISelectObjectPath", "ScoreList")
  self._bg = self:GetUIComponent("RawImage", "bg")
  self._ani = self.view.gameObject:GetComponent("Animation")
end

function UIN14FishingGameStageController:_RefreshRewardList()
  local scoreCount = 0
  if self._current_stage_cfg.ScoreBReward then
    scoreCount = scoreCount + 1
  end
  if self._current_stage_cfg.ScoreAReward then
    scoreCount = scoreCount + 1
  end
  if self._current_stage_cfg.ScoreSReward then
    scoreCount = scoreCount + 1
  end
  self._scoreList:SpawnObjects("UIN14FishingScoreItem", scoreCount)
  self._scoreTypeCell = self._scoreList:GetAllSpawnList()
  scoreCount = 1
  local mission_info = self._componentInfo.mission_info_list[self:GetMissionIdByIndex(self._current_waypoint_index)].mission_info
  if self._current_stage_cfg.ScoreBReward then
    self._scoreTypeCell[scoreCount]:RefreshRewards(ScoreType.B, mission_info, self._current_stage_cfg, self.ReceiveRewardClickCallback)
    scoreCount = scoreCount + 1
  end
  if self._current_stage_cfg.ScoreAReward then
    self._scoreTypeCell[scoreCount]:RefreshRewards(ScoreType.A, mission_info, self._current_stage_cfg, self.ReceiveRewardClickCallback)
    scoreCount = scoreCount + 1
  end
  if self._current_stage_cfg.ScoreSReward then
    self._scoreTypeCell[scoreCount]:RefreshRewards(ScoreType.S, mission_info, self._current_stage_cfg, self.ReceiveRewardClickCallback)
  end
  local cellWidth = 0
  local cellHeight = 0
  local offsetX = 20
  local offSetY = -50
  local space = 17
  if 0 < scoreCount then
    local rect = self._scoreTypeCell[1].view:GetUIComponent("RectTransform", "bg")
    cellWidth = math.floor(rect.sizeDelta.x)
    cellHeight = math.floor(rect.sizeDelta.y)
  end
  for i = 1, scoreCount do
    local tmpPos = self._scoreTypeCell[i].view.transform.localPosition
    tmpPos.x = cellWidth / 2 + offsetX * (i - 1)
    tmpPos.y = offSetY - (cellHeight + space) * (i - 1)
    self._scoreTypeCell[i].view.transform.localPosition = tmpPos
  end
end

function UIN14FishingGameStageController:_OnValue()
  self:_PlayStory()
  self:_SetRemainTime()
  self:_CreateStageMap()
  self:_ClickWayPoint(self:_GetCurrentSelectMission(), false)
  self:_RefreshRewardList()
  self._description:SetText(StringTable.Get("str_fishing_game_description"))
end

function UIN14FishingGameStageController:GetZeMissionScore()
end

function UIN14FishingGameStageController:_PlayStory()
  if LocalDB.GetInt("ui_n14_fishing_first_story" .. self._loginModule:GetRoleShowID()) > 0 then
    return
  end
  self:_hide(true)
  GameGlobal.GetModule(StoryModule):StartStory(self._componentInfo.m_first_story_id, function()
    self:_hide(false)
    AudioHelperController.PlayBGM(self._lastBGMResName, AudioConstValue.BGMCrossFadeTime)
    LocalDB.SetInt("ui_n14_fishing_first_story" .. self._loginModule:GetRoleShowID(), 1)
  end)
end

function UIN14FishingGameStageController:_SetRemainTime()
  local time = math.floor(self._svrTimeModule:GetServerTime() * 0.001)
  time = self._componentInfo.m_close_time - time
  self._remainTime:SetText(self:_GetRemainTime(time))
end

function UIN14FishingGameStageController:_CreateStageMap()
  local wayPointCount = table.count(self._cfg_stage)
  local vector = Vector2(0.5, 0.5)
  local waypoint_offset_y = -346
  local rotation_z = {
    [0] = 19,
    [1] = -19
  }
  if 5 < wayPointCount then
    self._content.sizeDelta = Vector2(1500 + (wayPointCount - 5) * 500, 0)
  end
  local servertime = math.floor(self._svrTimeModule:GetServerTime() * 0.001)
  self._wayPoint:SpawnObjects("UIN14FishingGameWayPoint", wayPointCount)
  self._wayPointCell = self._wayPoint:GetAllSpawnList()
  for key, value in pairs(self._wayPointCell) do
    local keyIndex = key % 7
    local offsetX = 0
    local originOffsetX = -72
    local originOffsetY = 226
    local secondLineOffsetX = 56
    if keyIndex <= 3 then
      offsetX = 323 - 323 * keyIndex
    else
      offsetX = 323 * keyIndex - 1947 + secondLineOffsetX
    end
    self:_SetWayInfo(value.view.transform, vector, Vector3(self._content.sizeDelta.x * -0.05 + offsetX + originOffsetX, waypoint_offset_y * (key // 4) + originOffsetY, 0), Vector3.zero)
    local missionId = self:GetMissionIdByIndex(key)
    value:SetData(self, key, self._cfg_stage[key], self._componentInfo.mission_info_list[missionId], servertime, function(index)
      self:_ClickWayPoint(index, true)
      self._ani:Play("uieff_N14_Fishing_Switch")
    end, self:_IsNewUnLockMission(missionId), self._current_waypoint_index == key, not self:_CheckPreMission(key))
  end
  self._wayLine:SpawnObjects("UIN14FishingGameWayLine", wayPointCount - 1)
  self._wayLineCell = self._wayLine:GetAllSpawnList()
  for key, value in pairs(self._wayLineCell) do
    local keyIndex = key % 7
    local offsetX = 0
    local offsetY = 230
    local rotationZ = 0
    if keyIndex % 3 == 0 then
      offsetY = offsetY - 100 * key // 3
      if key / 3 % 2 == 1 then
        offsetX = -804
      else
        offsetX = 226
      end
      rotationZ = -78
    else
      offsetY = offsetY - 325 * (key // 3)
      if keyIndex <= 2 then
        offsetX = -300 * keyIndex
      else
        offsetX = 300 * keyIndex - 1800
      end
    end
    self:_SetWayInfo(value.view.transform, vector, Vector3(offsetX, offsetY, 0), Vector3(0, 0, rotationZ))
    value:SetData(servertime >= self._componentInfo.mission_info_list[self:GetMissionIdByIndex(key + 1)].unlock_time and self:_CheckPreMission(key + 1))
  end
end

function UIN14FishingGameStageController:_RefreshWayPointSelectStatus(index)
  for key, value in pairs(self._wayPointCell) do
    local missionId = self:GetMissionIdByIndex(key)
    value:RefreshData(self._componentInfo.mission_info_list[missionId])
    value:RefreshClickStatus(index)
  end
end

function UIN14FishingGameStageController:_RefreshWayPointWayLineInfo()
  local servertime = math.floor(self._svrTimeModule:GetServerTime() * 0.001)
  for key, value in pairs(self._wayPointCell) do
    value:RefreshUnLockState(servertime, not self:_CheckPreMission(key))
    value:RefreshRedpointStateZi(self._componentInfo.mission_info_list[self:GetMissionIdByIndex(key)].mission_info)
  end
  for key, value in pairs(self._wayLineCell) do
    value:SetData(servertime >= self._componentInfo.mission_info_list[self:GetMissionIdByIndex(key + 1)].unlock_time and self:_CheckPreMission(key + 1))
  end
end

function UIN14FishingGameStageController:_SetWayInfo(transform, vector2, vector3, eulerAngles)
  transform.anchorMin = vector2
  transform.anchorMax = vector2
  transform.pivot = vector2
  transform.anchoredPosition = vector3
  transform.eulerAngles = eulerAngles
end

function UIN14FishingGameStageController:_IsNewUnLockMission(id)
  local str = LocalDB.GetString("FishingGameNewStage" .. self._loginModule:GetRoleShowID())
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

function UIN14FishingGameStageController:_Close()
  local str = LocalDB.GetString("FishingGameNewStage" .. self._loginModule:GetRoleShowID())
  local ids = string.split(str, ",")
  local nowTime = self._svrTimeModule:GetServerTime() * 0.001
  local list = self._componentInfo.mission_info_list
  for k, v in pairs(list) do
    if nowTime >= v.unlock_time then
      local recorded = false
      for j = 1, #ids do
        if ids[j] == tostring(k) then
          recorded = true
        end
      end
      if not recorded then
        str = str .. k .. ","
      end
    end
  end
  LocalDB.SetString("FishingGameNewStage" .. self._loginModule:GetRoleShowID(), str)
  self:CloseDialog()
  if self._callBack then
    self._callBack()
  end
  GameGlobal.EventDispatcher():Dispatch(GameEventType.ActivityDialogRefresh)
end

function UIN14FishingGameStageController:_ClickWayPoint(index, manual)
  if self:_CheckCampaignClose() then
    return
  end
  if manual then
    self._stageAnimation:Play(MGAnimations.Other.Switch)
  end
  local servertime = math.floor(self._svrTimeModule:GetServerTime() * 0.001)
  local miss_info = self._componentInfo.mission_info_list[self:GetMissionIdByIndex(index)]
  if servertime < miss_info.unlock_time then
    ToastManager.ShowToast(StringTable.Get("str_fishing_game_lock"))
    return
  end
  if self._current_waypoint_index ~= index then
    self._current_waypoint_index = index
    self:_RefreshUIInfo()
    self:_RefreshWayPointSelectStatus(index)
  end
end

function UIN14FishingGameStageController:_RefreshUIInfo()
  self._current_stage_cfg = self._cfg_stage[self._current_waypoint_index]
  if self._current_stage_cfg then
    self._title:SetText(StringTable.Get(self._current_stage_cfg.Title))
    self._stageDescription:SetText(StringTable.Get(self._current_stage_cfg.Description))
    local mission_info = self._componentInfo.mission_info_list[self:GetMissionIdByIndex(self._current_waypoint_index)].mission_info
    self._bestScore:SetText(mission_info.max_score)
    self._storyBtn:SetActive(mission_info.max_score > 0)
    self:_RefreshRewardList()
  end
end

function UIN14FishingGameStageController:_ShowRewardTips(id, pos)
  self._tips:SetData(id, pos)
end

function UIN14FishingGameStageController:_GetCurrentClickInde()
  return self._current_waypoint_index
end

function UIN14FishingGameStageController:_GetRemainTime(time)
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

function UIN14FishingGameStageController:ReceiveRewardClickCallback(scoretype)
  self._current_scoretype = scoretype
  self:Lock("UIN14FishingGameStageController:ReceiveRewardBtnOnClick")
  self:StartTask(function(TT)
    local res = AsyncRequestRes:New()
    local result, rewards = self._component:HandleRecvRewardMsg(TT, res, self._cfg_stage[self._current_waypoint_index].ID, self._current_scoretype)
    if result and result:GetSucc() then
      self:ShowDialog("UIGetItemController", rewards)
      self:_RefreshUIWhenReceiveReward()
    else
      self:_Close()
    end
    self:UnLock("UIN14FishingGameStageController:ReceiveRewardBtnOnClick")
  end)
end

function UIN14FishingGameStageController:_RefreshUIWhenReceiveReward()
  local miss_info = self._componentInfo.mission_info_list[self:GetMissionIdByIndex(self._current_waypoint_index)].mission_info
  self._wayPointCell[self._current_waypoint_index]:RefreshRedpointStateZi(miss_info)
  self:_RefreshRewardList()
end

function UIN14FishingGameStageController:_RefreshUIWhenGameOver()
  self._current_waypoint_index = self:_GetCurrentSelectMission()
  local mission_info = self._componentInfo.mission_info_list[self:GetMissionIdByIndex(self._current_waypoint_index)].mission_info
  self._bestScore:SetText(mission_info.max_score)
  self._storyBtn:SetActive(mission_info.max_score > 0)
  self:_RefreshUIInfo()
  self:_RefreshWayPointWayLineInfo()
  self:_RefreshRewardList()
  self:_RefreshWayPointSelectStatus(self._current_waypoint_index)
end

function UIN14FishingGameStageController:StoryBtnOnClick()
  self:_PlayMissStory()
end

function UIN14FishingGameStageController:_PlayMissStory()
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

function UIN14FishingGameStageController:GameBtnOnClick()
  if self:_CheckCampaignClose() then
    return
  end
  if not self:_CheckPreMission(self._current_waypoint_index) then
    ToastManager.ShowToast(StringTable.Get("str_fishing_game_premissionunfinished"))
    return
  end
  local con = table.icontains(self._current_stage_cfg.StoryActiveType, 1)
  local storymask = self._componentInfo.mission_info_list[self:GetMissionIdByIndex(self._current_waypoint_index)].mission_info.story_mask & 1 == 0
  if con and storymask then
    self:_hide(true)
    GameGlobal.GetModule(StoryModule):StartStory(self._current_stage_cfg.StoryID[1], function()
      self:StartTask(function(TT)
        local res = AsyncRequestRes:New()
        res = self._component:HandleStoryMsg(TT, res, self._current_stage_cfg.ID, 1)
        if res:GetSucc() then
          self:ShowDialog("UIN14FishingGameController", self._current_stage_cfg.ID, self._component, self._componentInfo, self._lastBGMResName, function()
            self:_hide(false)
            self:_RefreshUIWhenGameOver()
          end)
        end
      end)
    end)
  else
    self:ShowDialog("UIN14FishingGameController", self._current_stage_cfg.ID, self._component, self._componentInfo, self._lastBGMResName, function()
      self:_hide(false)
      self:_RefreshUIWhenGameOver()
    end)
  end
end

function UIN14FishingGameStageController:_CheckCampaignClose()
  local time = self._componentInfo.m_close_time - math.floor(self._svrTimeModule:GetServerTime() * 0.001)
  if time <= 0 then
    ToastManager.ShowToast(StringTable.Get("str_activity_common_notice_content"))
    local campaignModule = GameGlobal.GetModule(CampaignModule)
    campaignModule:CampaignSwitchState(true, UIStateType.UIN14Main, UIStateType.UIMain, nil, self._campaign._id)
    return true
  end
  return false
end

function UIN14FishingGameStageController:_CheckPreMission(index)
  if index == 1 then
    return true
  end
  return self._componentInfo.mission_info_list[self:GetMissionIdByIndex(index - 1)].mission_info.max_score > 0
end

function UIN14FishingGameStageController:_GetCurrentSelectMission()
  local servertime = math.floor(self._svrTimeModule:GetServerTime() * 0.001)
  for i = 1, table.count(self._cfg_stage) do
    local index = self:GetMissionIdByIndex(i)
    if self._componentInfo.mission_info_list[index].mission_info.max_score == 0 and servertime >= self._componentInfo.mission_info_list[index].unlock_time then
      return i
    end
  end
  return 1
end

function UIN14FishingGameStageController:_hide(hide)
  self._blackMask:SetActive(hide)
end

function UIN14FishingGameStageController:GetFirstMissionId()
  local firstId = self._cfg_stage[1].ID
  for k, v in pairs(self._cfg_stage) do
    if firstId > v.ID then
      firstId = v.ID
    end
  end
  return firstId
end

function UIN14FishingGameStageController:GetMissionIdByIndex(index)
  return self._cfg_stage[index].ID
end

function UIN14FishingGameStageController:SortCfgById()
  table.sort(self._cfg_stage, function(a, b)
    return a.ID < b.ID
  end)
  local sortStage = {}
  for k, v in pairs(self._cfg_stage) do
    if v.NeedMissionID == nil then
      sortStage[1] = v
      break
    end
  end
  if sortStage[1] == nil then
    Log.error("UIN14FishingGameStageController first level dont exist!!")
    return
  end
  local nextLevel = Cfg.cfg_component_mini_game_mission({
    NeedMissionID = sortStage[1].ID
  })
  local currentIndex = 1
  while nextLevel do
    currentIndex = currentIndex + 1
    sortStage[currentIndex] = nextLevel[1]
    nextLevel = Cfg.cfg_component_mini_game_mission({
      NeedMissionID = sortStage[currentIndex].ID
    })
    if currentIndex >= table.count(self._cfg_stage) then
      break
    end
  end
  self._cfg_stage = sortStage
end

function UIN14FishingGameStageController:storyNewOnClick(go)
  local cfgs = {50210001}
  if cfgs[1] then
    self:_hide(true)
    GameGlobal.GetModule(StoryModule):StartStory(cfgs[1], function()
      self:_hide(false)
      if cfgs[2] then
        self:_hide(true)
        GameGlobal.GetModule(StoryModule):StartStory(cfgs[2], function()
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

function UIN14FishingGameStageController:AfterUILayerChanged(go)
  if not self._current_waypoint_index then
    self._current_waypoint_index = 1
  end
  local mission_info = self._componentInfo.mission_info_list[self:GetMissionIdByIndex(self._current_waypoint_index)].mission_info
  self._bestScore:SetText(mission_info.max_score)
  self._storyBtn:SetActive(mission_info.max_score > 0)
  self:_RefreshUIInfo()
  self:_RefreshWayPointWayLineInfo()
  self:_RefreshRewardList()
  self:_RefreshWayPointSelectStatus(self._current_waypoint_index)
end
