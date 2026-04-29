_class("UICN17N46FishingGameStageController", UIController)
UICN17N46FishingGameStageController = UICN17N46FishingGameStageController

function UICN17N46FishingGameStageController:Constructor()
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

function UICN17N46FishingGameStageController:LoadDataOnEnter(TT, res, uiParams)
  self._svrTimeModule = self:GetModule(SvrTimeModule)
  self._loginModule = self:GetModule(LoginModule)
  local campaignModule = self:GetModule(CampaignModule)
  self._campaign = UIActivityCampaign:New()
  self._campaign:LoadCampaignInfo(TT, res, ECampaignType.CAMPAIGN_TYPE_FISH_GAME, ECampaignFishGameComponentID.ECAMPAIGN_FISH_GAME)
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

function UICN17N46FishingGameStageController:OnShow(uiParams)
  self._callBack = uiParams[3]
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
  local curIndex = self:_GetCurrentSelectMission()
  curIndex = curIndex - 1
  if 0 < curIndex then
    local value = 1 - curIndex / 10
    self._scrollRect:DOVerticalNormalizedPos(value, 0.25, false)
  end
end

function UICN17N46FishingGameStageController:OnHide()
  self:DetachEvent(GameEventType.OnN14FishingGameRewardItemReceived, self.ReceiveRewardClickCallback)
  self:DetachEvent(GameEventType.OnN14FishingGameRewardItemClicked, self._ShowRewardTips)
  self:DetachEvent(GameEventType.AfterUILayerChanged, self.AfterUILayerChanged)
end

function UICN17N46FishingGameStageController:_GetComponents()
  self._backBtn = self:GetUIComponent("UISelectObjectPath", "BackBtn")
  self._commonTopBtn = self._backBtn:SpawnObject("UINewCommonTopButton")
  self._commonTopBtn:SetData(function()
    GameGlobal.EventDispatcher():Dispatch(GameEventType.OnCloseMinigame)
    self:CloseDialog()
    if self._callBack then
      self._callBack()
    end
  end)
  self._remainTime = self:GetUIComponent("UILocalizationText", "Time")
  self._itemTips = self:GetUIComponent("UISelectObjectPath", "ItemTips")
  self._tips = self._itemTips:SpawnObject("UISelectInfo")
  self._tipsObj = self:GetGameObject("ItemTips")
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
  self._rankBtn = self:GetGameObject("RankBtn")
  self._rankBtn:SetActive(false)
  self._rankWayPoint = self:GetUIComponent("UISelectObjectPath", "RankWayPoint")
  self._rankWayPointObj = self:GetGameObject("RankWayPoint")
  self._rankWayPointObj.gameObject:SetActive(false)
  self._scrollRect = self:GetUIComponent("ScrollRect", "ScrollView")
  self._scrollRect.verticalNormalizedPosition = 0
end

function UICN17N46FishingGameStageController:_RefreshRewardList()
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
  self._scoreList:SpawnObjects("UICN17N46FishingScoreItem", scoreCount)
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
  local offsetX = 0
  local offSetY = -40
  local space = 12
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

function UICN17N46FishingGameStageController:_OnValue()
  self:_PlayStory()
  self:_SetRemainTime()
  self:_CreateStageMap()
  self:_ClickWayPoint(self:_GetCurrentSelectMission(), false)
  self:_RefreshRewardList()
  self._description:SetText(StringTable.Get("str_fishing_game_description"))
end

function UICN17N46FishingGameStageController:GetZeMissionScore()
end

function UICN17N46FishingGameStageController:_PlayStory()
  if LocalDB.GetInt("ui_n14_fishing_first_story" .. self._loginModule:GetRoleShowID()) > 0 then
    return
  end
  self:_Hide(true)
  GameGlobal.GetModule(StoryModule):StartStory(self._componentInfo.m_first_story_id, function()
    self:_Hide(false)
    AudioHelperController.PlayBGM(self._lastBGMResName, AudioConstValue.BGMCrossFadeTime)
    LocalDB.SetInt("ui_n14_fishing_first_story" .. self._loginModule:GetRoleShowID(), 1)
  end)
end

function UICN17N46FishingGameStageController:_SetRemainTime()
  local time = math.floor(self._svrTimeModule:GetServerTime() * 0.001)
  time = self._componentInfo.m_close_time - time
  self._remainTime:SetText(self:_GetRemainTime(time))
end

function UICN17N46FishingGameStageController:_CreateStageMap()
  local wayPointCount = table.count(self._cfg_stage)
  local vector = Vector2(0.5, 0.5)
  local waypoint_offset_y = -346
  local rotation_z = {
    [0] = 19,
    [1] = -19
  }
  local servertime = math.floor(self._svrTimeModule:GetServerTime() * 0.001)
  self._wayPoint:SpawnObjects("UICN17N46FishingGameWayPoint", wayPointCount)
  self._wayPointCell = self._wayPoint:GetAllSpawnList()
  for key, value in pairs(self._wayPointCell) do
    local missionId = self:GetMissionIdByIndex(key)
    value:SetData(self, key, self._cfg_stage[key], self._componentInfo.mission_info_list[missionId], servertime, function(index)
      self:_ClickWayPoint(index, true)
      self._ani:Play("uieff_N14_Fishing_Switch")
    end, self:_IsNewUnLockMission(missionId), self._current_waypoint_index == key, not self:_CheckPreMission(key), wayPointCount, self._campaign, function()
      self._tipsObj:SetActive(false)
    end)
  end
  self:RefreshRankMission()
  self._wayLine:SpawnObjects("UICN17N46FishingGameWayLine", wayPointCount - 1)
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

function UICN17N46FishingGameStageController:RefreshRankMission()
  local cfg = Cfg.cfg_campaign_component({
    CampaignID = self._campaign._id
  })[1]
  local subKey = cfg.RankSubKey[1]
  local servertime = math.floor(self._svrTimeModule:GetServerTime() * 0.001)
  local curClearCount = 0
  local wayPointCount = table.count(self._cfg_stage)
  for key, value in pairs(self._componentInfo.mission_info_list) do
    if 0 < value.mission_info.max_score then
      curClearCount = curClearCount + 1
    end
  end
  if 2 <= curClearCount then
    local cmpID = self._component:GetComponentCfgId()
    local cfgs = Cfg.cfg_component_mini_game_mission({ComponentID = cmpID})
    local rankCfg
    local rankIndex = 1
    for i = 1, #cfgs do
      if cfgs[i].ID == subKey then
        rankCfg = cfgs[i]
        rankIndex = i
        self.rankCfg = rankCfg
      end
    end
    if rankCfg == nil then
      return
    end
    self._rankWayPointObj.gameObject:SetActive(true)
    self._rankWayPointCell = self._rankWayPoint:SpawnObject("UICN17N46FishingGameWayPoint")
    self._rankWayPointCell:SetData(self, rankIndex, rankCfg, self._componentInfo.mission_info_list[subKey], servertime, function(index)
      self:_ClickWayPoint(index, true)
      self._ani:Play("uieff_N14_Fishing_Switch")
      self._rankBtn:SetActive(true)
      self._storyBtn:SetActive(false)
    end, true, 0, false, wayPointCount, self._campaign, function()
      self._tipsObj:SetActive(false)
    end)
  end
end

function UICN17N46FishingGameStageController:_RefreshWayPointSelectStatus(index)
  for key, value in pairs(self._wayPointCell) do
    local missionId = self:GetMissionIdByIndex(key)
    value:RefreshData(self._componentInfo.mission_info_list[missionId])
    value:RefreshClickStatus(index)
  end
  if self._rankWayPointCell then
    self._rankWayPointCell:RefreshClickStatus(index)
  end
end

function UICN17N46FishingGameStageController:_RefreshWayPointWayLineInfo()
  local servertime = math.floor(self._svrTimeModule:GetServerTime() * 0.001)
  for key, value in pairs(self._wayPointCell) do
    value:RefreshUnLockState(servertime, not self:_CheckPreMission(key))
    value:RefreshRedpointStateZi(self._componentInfo.mission_info_list[self:GetMissionIdByIndex(key)].mission_info)
  end
  for key, value in pairs(self._wayLineCell) do
    value:SetData(servertime >= self._componentInfo.mission_info_list[self:GetMissionIdByIndex(key + 1)].unlock_time and self:_CheckPreMission(key + 1))
  end
end

function UICN17N46FishingGameStageController:_SetWayInfo(transform, vector2, vector3, eulerAngles)
  transform.anchorMin = vector2
  transform.anchorMax = vector2
  transform.pivot = vector2
  transform.anchoredPosition = vector3
  transform.eulerAngles = eulerAngles
end

function UICN17N46FishingGameStageController:_IsNewUnLockMission(id)
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

function UICN17N46FishingGameStageController:_Close()
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

function UICN17N46FishingGameStageController:_ClickWayPoint(index, manual)
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
    self._tipsObj:SetActive(false)
    return
  end
  if self._current_waypoint_index ~= index then
    self._current_waypoint_index = index
    self:_RefreshUIInfo()
    self:_RefreshWayPointSelectStatus(index)
  end
  self._rankBtn:SetActive(false)
end

function UICN17N46FishingGameStageController:_RefreshUIInfo()
  if self._current_waypoint_index > #self._cfg_stage then
    self._current_stage_cfg = self.rankCfg
    if self._current_stage_cfg then
      self._title:SetText(StringTable.Get(self._current_stage_cfg.Title))
      self._stageDescription:SetText(StringTable.Get(self._current_stage_cfg.Description))
      local mission_info = self._componentInfo.mission_info_list[self:GetMissionIdByIndex(self._current_waypoint_index)].mission_info
      self._bestScore:SetText(mission_info.max_score)
      self:_RefreshStoryBtn(mission_info)
      self:_RefreshRewardList()
    end
  else
    self._current_stage_cfg = self._cfg_stage[self._current_waypoint_index]
    if self._current_stage_cfg then
      self._title:SetText(StringTable.Get(self._current_stage_cfg.Title))
      self._stageDescription:SetText(StringTable.Get(self._current_stage_cfg.Description))
      local mission_info = self._componentInfo.mission_info_list[self:GetMissionIdByIndex(self._current_waypoint_index)].mission_info
      self._bestScore:SetText(mission_info.max_score)
      self:_RefreshStoryBtn(mission_info)
      self:_RefreshRewardList()
    end
  end
  self._tipsObj:SetActive(false)
end

function UICN17N46FishingGameStageController:_ShowRewardTips(id, pos)
  self._tipsObj:SetActive(true)
  self._tips:SetData(id, pos)
end

function UICN17N46FishingGameStageController:_GetCurrentClickInde()
  return self._current_waypoint_index
end

function UICN17N46FishingGameStageController:_GetRemainTime(time)
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

function UICN17N46FishingGameStageController:ReceiveRewardClickCallback(scoretype)
  self._current_scoretype = scoretype
  self:Lock("UICN17N46FishingGameStageController:ReceiveRewardBtnOnClick")
  self:StartTask(function(TT)
    local res = AsyncRequestRes:New()
    local index = 0
    if self._current_waypoint_index > #self._cfg_stage then
      local cfg = Cfg.cfg_campaign_component({
        CampaignID = self._campaign._id
      })[1]
      local subKey = cfg.RankSubKey[1]
      index = subKey
    else
      index = self._cfg_stage[self._current_waypoint_index].ID
    end
    local result, rewards = self._component:HandleRecvRewardMsg(TT, res, index, self._current_scoretype)
    if result and result:GetSucc() then
      self:ShowDialog("UIGetItemController", rewards)
      self:_RefreshUIWhenReceiveReward()
    else
      self:_Close()
    end
    self:UnLock("UICN17N46FishingGameStageController:ReceiveRewardBtnOnClick")
  end)
end

function UICN17N46FishingGameStageController:_RefreshUIWhenReceiveReward()
  local miss_info = self._componentInfo.mission_info_list[self:GetMissionIdByIndex(self._current_waypoint_index)].mission_info
  local cfg = Cfg.cfg_campaign_component({
    CampaignID = self._campaign._id
  })[1]
  local subKey = cfg.RankSubKey[1]
  if self:GetMissionIdByIndex(self._current_waypoint_index) ~= subKey then
    self._wayPointCell[self._current_waypoint_index]:RefreshRedpointStateZi(miss_info)
  else
    self._rankWayPointCell:RefreshRedpointStateZi(miss_info)
  end
  self:_RefreshRewardList()
end

function UICN17N46FishingGameStageController:_RefreshUIWhenGameOver()
  self._current_waypoint_index = self:_GetCurrentSelectMission()
  local mission_info = self._componentInfo.mission_info_list[self:GetMissionIdByIndex(self._current_waypoint_index)].mission_info
  self._bestScore:SetText(mission_info.max_score)
  self:_RefreshStoryBtn(mission_info)
  self:_RefreshUIInfo()
  self:_RefreshWayPointWayLineInfo()
  self:_RefreshRewardList()
  self:_RefreshWayPointSelectStatus(self._current_waypoint_index)
end

function UICN17N46FishingGameStageController:_RefreshStoryBtn(mission_info)
  if self._current_stage_cfg.StoryID == nil then
    self._storyBtn:SetActive(false)
    local cfg = Cfg.cfg_campaign_component({
      CampaignID = self._campaign._id
    })[1]
    local subKey = cfg.RankSubKey[1]
    if self:GetMissionIdByIndex(self._current_waypoint_index) ~= subKey then
      self._rankBtn:SetActive(false)
    else
      self._rankBtn:SetActive(true)
    end
    return
  end
  self._storyBtn:SetActive(mission_info.max_score > 0)
  if mission_info.max_score > 0 then
    self._rankBtn:SetActive(false)
  end
end

function UICN17N46FishingGameStageController:StoryBtnOnClick()
  self:_PlayMissStory()
  self._tipsObj:SetActive(false)
end

function UICN17N46FishingGameStageController:RankBtnOnClick()
  if self:_CheckCampaignClose() then
    return
  end
  self:ShowDialog("UICN17N46FishingGameRankingList", self._campaign)
  self._tipsObj:SetActive(false)
end

function UICN17N46FishingGameStageController:_PlayMissStory()
  if self._current_stage_cfg.StoryID[1] then
    self:_Hide(true)
    GameGlobal.GetModule(StoryModule):StartStory(self._current_stage_cfg.StoryID[1], function()
      self:_Hide(false)
      if self._current_stage_cfg.StoryID[2] then
        self:_Hide(true)
        GameGlobal.GetModule(StoryModule):StartStory(self._current_stage_cfg.StoryID[2], function()
          self:_Hide(false)
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

function UICN17N46FishingGameStageController:GameBtnOnClick()
  if self:_CheckCampaignClose() then
    return
  end
  self._tipsObj:SetActive(false)
  if not self:_CheckPreMission(self._current_waypoint_index) then
    ToastManager.ShowToast(StringTable.Get("str_fishing_game_premissionunfinished"))
    return
  end
  local con = table.icontains(self._current_stage_cfg.StoryActiveType, 1)
  local storymask = self._componentInfo.mission_info_list[self:GetMissionIdByIndex(self._current_waypoint_index)].mission_info.story_mask & 1 == 0
  if con and storymask then
    self:_Hide(true)
    GameGlobal.GetModule(StoryModule):StartStory(self._current_stage_cfg.StoryID[1], function()
      self:StartTask(function(TT)
        local res = AsyncRequestRes:New()
        res = self._component:HandleStoryMsg(TT, res, self._current_stage_cfg.ID, 1)
        if res:GetSucc() then
          self:ShowDialog("UICN17N46FishingGameController", self._current_stage_cfg.ID, self._component, self._componentInfo, CriAudioIDConst.BGMN13Build, function()
            self:_Hide(false)
            self:_RefreshUIWhenGameOver()
            self:RefreshRankMission()
            AudioHelperController.PlayBGM(CriAudioIDConst.BGMN13Build, AudioConstValue.BGMCrossFadeTime)
          end)
        end
      end)
    end)
  else
    self:ShowDialog("UICN17N46FishingGameController", self._current_stage_cfg.ID, self._component, self._componentInfo, CriAudioIDConst.BGMN13Build, function()
      self:_Hide(false)
      self:_RefreshUIWhenGameOver()
      self:RefreshRankMission()
      AudioHelperController.PlayBGM(CriAudioIDConst.BGMN13Build, AudioConstValue.BGMCrossFadeTime)
    end)
  end
end

function UICN17N46FishingGameStageController:_CheckCampaignClose()
  local time = self._componentInfo.m_close_time - math.floor(self._svrTimeModule:GetServerTime() * 0.001)
  if time <= 0 then
    ToastManager.ShowToast(StringTable.Get("str_activity_common_notice_content"))
    local campaignModule = GameGlobal.GetModule(CampaignModule)
    campaignModule:CampaignSwitchState(true, UIStateType.UICN17N46Main, UIStateType.UIMain, nil, self._campaign._id)
    return true
  end
  return false
end

function UICN17N46FishingGameStageController:_CheckPreMission(index)
  if index == 1 then
    return true
  end
  if index > #self._cfg_stage then
    return true
  end
  return self._componentInfo.mission_info_list[self:GetMissionIdByIndex(index - 1)].mission_info.max_score > 0
end

function UICN17N46FishingGameStageController:_GetCurrentSelectMission()
  local servertime = math.floor(self._svrTimeModule:GetServerTime() * 0.001)
  local missionCount = 1
  for i = 1, table.count(self._cfg_stage) do
    local index = self:GetMissionIdByIndex(i)
    if self._componentInfo.mission_info_list[index].mission_info.max_score == 0 and servertime >= self._componentInfo.mission_info_list[index].unlock_time then
      return i
    end
    if servertime < self._componentInfo.mission_info_list[index].unlock_time then
      local id = missionCount - 1
      if id <= 0 then
        id = 1
      end
      return id
    end
    if self._componentInfo.mission_info_list[index].mission_info.max_score > 0 and servertime >= self._componentInfo.mission_info_list[index].unlock_time then
      missionCount = missionCount + 1
    end
  end
  return 1
end

function UICN17N46FishingGameStageController:_Hide(hide)
  self._blackMask:SetActive(hide)
end

function UICN17N46FishingGameStageController:GetFirstMissionId()
  local firstId = self._cfg_stage[1].ID
  for k, v in pairs(self._cfg_stage) do
    if firstId > v.ID then
      firstId = v.ID
    end
  end
  return firstId
end

function UICN17N46FishingGameStageController:GetMissionIdByIndex(index)
  if index <= #self._cfg_stage then
    return self._cfg_stage[index].ID
  end
  if index > #self._cfg_stage then
    return self.rankCfg.ID
  end
end

function UICN17N46FishingGameStageController:SortCfgById()
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
    Log.error("UICN17N46FishingGameStageController first level dont exist!!")
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
  local cfg = Cfg.cfg_campaign_component({
    CampaignID = self._campaign._id
  })[1]
  local subKey = cfg.RankSubKey[1]
  local sortFinalStage = {}
  for i = 1, #sortStage do
    if sortStage[i] ~= subKey then
      sortFinalStage[#sortFinalStage + 1] = sortStage[i]
    end
  end
  self._cfg_stage = sortFinalStage
end

function UICN17N46FishingGameStageController:StoryNewOnClick(go)
  local cfgs = {50210001}
  if cfgs[1] then
    self:_Hide(true)
    GameGlobal.GetModule(StoryModule):StartStory(cfgs[1], function()
      self:_Hide(false)
      if cfgs[2] then
        self:_Hide(true)
        GameGlobal.GetModule(StoryModule):StartStory(cfgs[2], function()
          self:_Hide(false)
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

function UICN17N46FishingGameStageController:AfterUILayerChanged(go)
  if not self._current_waypoint_index then
    self._current_waypoint_index = 1
  end
  local mission_info = self._componentInfo.mission_info_list[self:GetMissionIdByIndex(self._current_waypoint_index)].mission_info
  self._bestScore:SetText(mission_info.max_score)
  self:_RefreshStoryBtn(mission_info)
  self:_RefreshUIInfo()
  self:_RefreshWayPointWayLineInfo()
  self:_RefreshRewardList()
  self:_RefreshWayPointSelectStatus(self._current_waypoint_index)
end
