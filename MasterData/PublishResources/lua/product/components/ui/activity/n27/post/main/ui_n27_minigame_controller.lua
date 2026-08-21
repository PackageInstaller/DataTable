_class("UIN27MiniGameController", UISideEnterCenterContentBase)
UIN27MiniGameController = UIN27MiniGameController

function UIN27MiniGameController:Constructor()
  self._wayPointCell = {}
  self._wayLineCell = {}
  self._rewardCell = {}
  self._current_waypoint_index = 0
  self._firstLevelId = 0
end

function UIN27MiniGameController:DoInit()
  self._svrTimeModule = self:GetModule(SvrTimeModule)
  self._loginModule = self:GetModule(LoginModule)
  self._component = self._data:GetComponent(ECampaignN27ComponentID.ECAMPAIGN_N27_POSTSTATON)
  self._componentInfo = self._data:GetComponentInfo(ECampaignN27ComponentID.ECAMPAIGN_N27_POSTSTATON)
end

function UIN27MiniGameController:DoShow(uiParams)
  self:StartTask(function(TT)
    self._data:ClearCampaignNew(TT)
  end)
  self._paramMissionId = uiParams[1]
  if next(uiParams) then
    self._uiParams = uiParams
  end
  local cmpID = self._component:GetComponentCfgId()
  self._cfg_stage = Cfg.cfg_component_post_station_game_mission({ComponentID = cmpID})
  table.sort(self._cfg_stage, function(a, b)
    return a.ID < b.ID
  end)
  self:SortCfgById()
  self._firstLevelId = self:GetFirstMissionId()
  self._lastBGMResName = AudioHelperController.GetCurrentBgm()
  self:_GetComponents()
  self:_OnValue()
  self:AttachEvent(GameEventType.OnN27MinigameRewardItemReceived, self.ReceiveRewardClickCallback)
  self:AttachEvent(GameEventType.OnN27MinigameRewardItemClicked, self._ShowRewardTips)
end

function UIN27MiniGameController:DoHide()
  if self._countdownTimer then
    GameGlobal.Timer():CancelEvent(self._countdownTimer)
    self._countdownTimer = nil
  end
  self:DetachEvent(GameEventType.OnN27MinigameRewardItemReceived, self.ReceiveRewardClickCallback)
  self:DetachEvent(GameEventType.OnN27MinigameRewardItemClicked, self._ShowRewardTips)
end

function UIN27MiniGameController:DoDestroy()
end

function UIN27MiniGameController:_GetComponents()
  self._remainTime = self:GetUIComponent("UILocalizationText", "Time")
  self._itemTips = self:GetUIComponent("UISelectObjectPath", "ItemTips")
  self._tips = self._itemTips:SpawnObject("UISelectInfo")
  self._content = self:GetUIComponent("RectTransform", "Content")
  self._wayPoint = self:GetUIComponent("UISelectObjectPath", "WayPoint")
  self._wayLine = self:GetUIComponent("UISelectObjectPath", "WayLine")
  self._title = self:GetUIComponent("UILocalizationText", "Title")
  self._description = self:GetUIComponent("UILocalizationText", "StageDescription")
  self._storyBtn = self:GetGameObject("StoryBtn")
  self._stageAnimation = self:GetUIComponent("Animation", "StageAnimation")
  self._blackMask = self:GetGameObject("black_mask")
  self._rewardList = self:GetUIComponent("UISelectObjectPath", "RewardList")
  self._bg = self:GetUIComponent("RawImage", "bg")
  self._ani = self.view.gameObject:GetComponent("Animation")
  self._firstShow = true
end

function UIN27MiniGameController:_RefreshRewardList()
  local itemCount = 0
  if self._current_stage_cfg.Target then
    itemCount = #self._current_stage_cfg.Target
  end
  self._rewardList:SpawnObjects("UIN27MiniGameRewardInfo", itemCount)
  self._rewardCell = self._rewardList:GetAllSpawnList()
  local mission_info = self._componentInfo.mission_infos[self:GetMissionIdByIndex(self._current_waypoint_index)]
  local endData = self:_SortRewardData(mission_info)
  for key, value in pairs(self._rewardCell) do
    value:SetData(endData[key], mission_info, self._current_stage_cfg)
  end
  self:PlayRewardItemAni()
end

function UIN27MiniGameController:PlayRewardItemAni()
  if self._firstShow then
    self._firstShow = false
  end
  local lockName = "UIN27MiniGameController:PlayRewardItemAni"
  self:StartTask(function(TT)
    self:Lock(lockName)
    YIELD(TT, 100)
    for i = 1, #self._rewardCell do
      self._rewardCell[i]:PlayAni()
      YIELD(TT, 80)
    end
    self:UnLock(lockName)
  end)
end

function UIN27MiniGameController:_SortRewardData(missionInfo)
  local cangetData = {}
  local alreadyData = {}
  local normalData = {}
  local cfg = self._current_stage_cfg.Target
  
  local function checkFun1(key)
    if missionInfo.can_get_target_list then
      for index, value in pairs(missionInfo.can_get_target_list) do
        if value == key then
          return true
        end
      end
    end
    return false
  end
  
  local function checkFun2(key)
    if missionInfo.already_get_target_list then
      for index, value in pairs(missionInfo.already_get_target_list) do
        if value == key then
          return true
        end
      end
    end
    return false
  end
  
  for i = 1, #cfg do
    if not missionInfo then
      return self._current_stage_cfg.Target
    end
    if checkFun1(cfg[i]) then
      table.insert(cangetData, cfg[i])
    elseif checkFun2(cfg[i]) then
      table.insert(alreadyData, cfg[i])
    else
      table.insert(normalData, cfg[i])
    end
  end
  local enddata = {}
  for i = 1, #cangetData do
    table.insert(enddata, cangetData[i])
  end
  for i = 1, #normalData do
    table.insert(enddata, normalData[i])
  end
  for i = 1, #alreadyData do
    table.insert(enddata, alreadyData[i])
  end
  return enddata
end

function UIN27MiniGameController:_OnValue()
  self:_PlayLastStory()
  self:_SetRemainTime()
  self:_CreateStageMap()
  local mis = self:_GetCurrentSelectMission()
  self._current_waypoint_index = self:GetIndexByMissionId(mis)
  if self._uiParams and self._uiParams[1] then
    self._current_waypoint_index = self:GetIndexByMissionId(self._uiParams[1])
    self._uiParams = nil
  end
  self:_ClickWayPoint(self._current_waypoint_index)
  self:_MoveToIndex()
end

function UIN27MiniGameController:_PlayStory()
  if LocalDB.GetInt("ui_n27_mini_game_story" .. self._loginModule:GetRoleShowID()) > 0 then
    return
  end
  self:_Hide(true)
  if not self._componentInfo.m_first_story_id then
    return
  end
  GameGlobal.GetModule(StoryModule):StartStory(self._componentInfo.m_first_story_id, function()
    self:_Hide(false)
    LocalDB.SetInt("ui_n27_mini_game_story" .. self._loginModule:GetRoleShowID(), 1)
  end)
end

function UIN27MiniGameController:_SetRemainTime()
  if self._countdownTimer then
    GameGlobal.Timer():CancelEvent(self._countdownTimer)
    self._countdownTimer = nil
  end
  local time = math.floor(self._svrTimeModule:GetServerTime() * 0.001)
  time = self._componentInfo.m_close_time - time
  self._remainTime:SetText(self:_GetRemainTime(time))
  self._countdownTimer = GameGlobal.Timer():AddEventTimes(1000, TimerTriggerCount.Infinite, function()
    local time = math.floor(self._svrTimeModule:GetServerTime() * 0.001)
    time = self._componentInfo.m_close_time - time
    self._remainTime:SetText(self:_GetRemainTime(time))
    if time <= 0 then
      GameGlobal.Timer():CancelEvent(self._countdownTimer)
      self._countdownTimer = nil
    end
  end)
end

function UIN27MiniGameController:_CreateStageMap()
  local wayPointCount = table.count(self._cfg_stage)
  local maxCfg = self._cfg_stage[wayPointCount]
  if maxCfg.MapPosX then
    self._content.sizeDelta = Vector2(200 + maxCfg.MapPosX, 700)
  end
  local servertime = math.floor(self._svrTimeModule:GetServerTime() * 0.001)
  self._wayPoint:SpawnObjects("UIN27MiniGameWayPoint", wayPointCount)
  self._wayPointCell = self._wayPoint:GetAllSpawnList()
  for key, value in pairs(self._wayPointCell) do
    local missionId = self:GetMissionIdByIndex(key)
    value:SetData(self, key, self._cfg_stage[key], self._componentInfo.mission_infos[missionId], servertime, function(index)
      self:_ClickWayPoint(index)
    end, self:_IsNewUnLockMission(key), self._current_waypoint_index == key, not self:_CheckPreMission(key))
  end
  self._wayLine:SpawnObjects("UIN27MiniGameWayLine", wayPointCount - 1)
  self._wayLineCell = self._wayLine:GetAllSpawnList()
  for key, value in pairs(self._wayLineCell) do
    local n1 = Vector2(self._cfg_stage[key].MapPosX, self._cfg_stage[key].MapPosY)
    local n2 = Vector2(self._cfg_stage[key + 1].MapPosX, self._cfg_stage[key + 1].MapPosY)
    value:Flush(n1, n2)
  end
  for key, value in pairs(self._wayPointCell) do
    value:PlayAni()
  end
end

function UIN27MiniGameController:_RefreshWayPointSelectStatus(index)
  for key, value in pairs(self._wayPointCell) do
    local missionId = self:GetMissionIdByIndex(key)
    value:RefreshData(self._componentInfo.mission_infos[missionId])
    value:RefreshClickStatus(index)
    if key == index then
      value:RefreshRedNew()
    end
  end
end

function UIN27MiniGameController:_RefreshWayPointWayLineInfo()
  local servertime = math.floor(self._svrTimeModule:GetServerTime() * 0.001)
  for key, value in pairs(self._wayPointCell) do
    value:RefreshUnLockState(servertime, not self:_CheckPreMission(key))
    value:RefreshRedpointState(self._componentInfo.mission_infos[self:GetMissionIdByIndex(key)])
  end
  for key, value in pairs(self._wayLineCell) do
    value:SetData(self._componentInfo.mission_infos[self:_CheckPreMission(key + 1)])
  end
end

function UIN27MiniGameController:_IsNewUnLockMission(index)
  local nowTime = self._svrTimeModule:GetServerTime() * 0.001
  local cfg = self._cfg_stage[index]
  local loginModule = GameGlobal.GetModule(LoginModule)
  local unlockTime = loginModule:GetTimeStampByTimeStr(cfg.UnlockTime, Enum_DateTimeZoneType.E_ZoneType_GMT)
  if nowTime >= unlockTime then
    return not self:_CheckMissionPass(index)
  else
    return false
  end
  return false
end

function UIN27MiniGameController:_Close()
  local str = LocalDB.GetString("N27MiniGameNewStage" .. self._loginModule:GetRoleShowID())
  local ids = string.split(str, ",")
  local nowTime = self._svrTimeModule:GetServerTime() * 0.001
  local list = self._componentInfo.mission_infos
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
  LocalDB.SetString("N27MiniGameNewStage" .. self._loginModule:GetRoleShowID(), str)
  GameGlobal.EventDispatcher():Dispatch(GameEventType.ActivityDialogRefresh)
end

function UIN27MiniGameController:_ClickWayPoint(index)
  if self:_CheckCampaignClose() then
    return
  end
  local servertime = math.floor(self._svrTimeModule:GetServerTime() * 0.001)
  local loginModule = GameGlobal.GetModule(LoginModule)
  local unlockTime = loginModule:GetTimeStampByTimeStr(self._cfg_stage[index].UnlockTime, Enum_DateTimeZoneType.E_ZoneType_GMT)
  if servertime < unlockTime then
    return
  end
  local roleModule = GameGlobal.GetModule(RoleModule)
  local key = roleModule:GetPstId() .. index
  LocalDB.SetInt("UIN42MiniGameWayPoint" .. key, 1)
  if self._current_waypoint_index ~= index or self._firstShow then
    self._current_waypoint_index = index
    self:_RefreshUIInfo()
    self:_RefreshWayPointSelectStatus(index)
  end
end

function UIN27MiniGameController:_RefreshUIInfo()
  self._current_stage_cfg = self._cfg_stage[self._current_waypoint_index]
  if self._current_stage_cfg then
    self._title:SetText(StringTable.Get(self._current_stage_cfg.Title))
    self._description:SetText(StringTable.Get(self._current_stage_cfg.Description))
    self._storyBtn:SetActive(false)
    self:_RefreshRewardList()
  end
end

function UIN27MiniGameController:_ShowRewardTips(id, pos)
  self._tips:SetData(id, pos)
end

function UIN27MiniGameController:_GetCurrentClickInde()
  return self._current_waypoint_index
end

function UIN27MiniGameController:_GetRemainTime(time)
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

function UIN27MiniGameController:ReceiveRewardClickCallback(target)
  self:Lock("UIN27MiniGameController:ReceiveRewardBtnOnClick")
  self:StartTask(function(TT)
    local res = AsyncRequestRes:New()
    local result, rewards = self._component:HandleGetTargetReward(TT, res, self._cfg_stage[self._current_waypoint_index].ID, target)
    if result == 0 then
      self:ShowDialog("UIGetItemController", rewards)
      self:_RefreshUIWhenReceiveReward()
    end
    self:UnLock("UIN27MiniGameController:ReceiveRewardBtnOnClick")
  end)
end

function UIN27MiniGameController:_RefreshUIWhenReceiveReward()
  local miss_info = self._componentInfo.mission_infos[self:GetMissionIdByIndex(self._current_waypoint_index)]
  self._wayPointCell[self._current_waypoint_index]:RefreshRedpointState(miss_info)
  self:_RefreshRewardList()
end

function UIN27MiniGameController:_RefreshUIWhenGameOver()
  self._current_waypoint_index = 1
  self:_RefreshUIInfo()
  self:_RefreshWayPointWayLineInfo()
  self:_RefreshWayPointSelectStatus(self._current_waypoint_index)
end

function UIN27MiniGameController:StoryBtnOnClick()
  self:_PlayMissStory()
end

function UIN27MiniGameController:_PlayMissStory()
  local storyIds = self:GetCanReviewStory()
  if storyIds == nil or table.count(storyIds) <= 0 then
    ToastManager.ShowToast(StringTable.Get("str_discovery_no_can_review_plot"))
    return
  end
  local canReviewStages = {}
  local cfgs = Cfg.cfg_n27_story_review({})
  if cfgs then
    for i = 1, #storyIds do
      local cfg = cfgs[storyIds[i][1]]
      local curStage = DiscoveryStage:New()
      curStage.id = cfg.ID
      curStage.longDesc = StringTable.Get(cfg.Des)
      curStage.name = StringTable.Get(cfg.Name)
      curStage.stageIdx = StringTable.Get(cfg.StageIndexTitle)
      curStage.fullname = StringTable.Get(cfg.FullName)
      local storyList = DiscoveryStoryList:New()
      local slist = {}
      storyList.stageId = cfg.ID
      local storyListCfg = cfg.StoryList
      if storyIds[i][2] == 3 then
        for k = 1, #storyListCfg do
          local story = DiscoveryStory:New()
          story:Init(storyListCfg[k][1], storyListCfg[k][2])
          table.insert(slist, story)
        end
      else
        for k = 1, #storyListCfg do
          if storyIds[i][2] == storyListCfg[k][2] then
            local story = DiscoveryStory:New()
            story:Init(storyListCfg[k][1], storyListCfg[k][2])
            table.insert(slist, story)
          end
        end
      end
      storyList.list = slist
      curStage.story = storyList
      table.insert(canReviewStages, curStage)
    end
  end
  local tempStage = canReviewStages[1]
  self:ShowDialog("UIPlot", tempStage, canReviewStages, false, true, StringTable.Get("str_n27_poststation_story_review_stage_title"))
end

function UIN27MiniGameController:GetCanReviewStory()
  local results = {}
  local keyStr = "PlayFirstPlot_Component_" .. self._data._id .. "_" .. ECampaignN27ComponentID.ECAMPAIGN_N27_POSTSTATON
  keyStr = UIActivityHelper.GetLocalDBKeyWithPstId(keyStr .. "_")
  if LocalDB.GetInt(keyStr) > 0 then
    table.insert(results, {0, 1})
  end
  if not self._componentInfo.mission_infos then
    return results
  end
  for key, value in pairs(self._componentInfo.mission_infos) do
    if value.story_mask ~= nil then
      table.insert(results, {
        value.mission_id,
        value.story_mask
      })
    end
  end
  table.sort(results, function(a, b)
    return a[1] < b[1]
  end)
  return results
end

function UIN27MiniGameController:GameBtnOnClick()
  AudioHelperController.PlayUISoundAutoRelease(CriAudioIDConst.Summer1GameSkillLoop)
  if self:_CheckCampaignClose() then
    return
  end
  if not self:_CheckPreMission(self._current_waypoint_index) then
    ToastManager.ShowToast(StringTable.Get("str_n27_poststation_lock_mission_tip"))
    return
  end
  local info = self._componentInfo.mission_infos[self:GetMissionIdByIndex(self._current_waypoint_index)]
  local storymask = true
  if info ~= nil then
    storymask = info.story_mask == 0
  end
  if storymask and self._current_stage_cfg.StoryActiveType[1] == 1 then
    GameGlobal.GetModule(StoryModule):StartStory(self._current_stage_cfg.StoryID[1], function()
      self:StartTask(function(TT)
        local res = AsyncRequestRes:New()
        res = self._component:HandleStory(TT, res, self._current_stage_cfg.ID, self._current_stage_cfg.StoryActiveType[1])
        if res == 0 then
          self:SwitchState(UIStateType.UIN27PostInnerGameController, self._current_stage_cfg.ID)
        end
      end)
    end, false)
  else
    self:SwitchState(UIStateType.UIN27PostInnerGameController, self._current_stage_cfg.ID)
  end
end

function UIN27MiniGameController:_PlayLastStory()
  if self:_CheckCampaignClose() then
    return
  end
  if not self._paramMissionId then
    return
  end
  local info = self._componentInfo.mission_infos[self._paramMissionId]
  local storymask = true
  if info ~= nil then
    storymask = info.story_mask < 2
  end
  local story = self:_GetMissionLastStoryCfg(self._paramMissionId)
  if storymask and story then
    GameGlobal.GetModule(StoryModule):StartStory(story, function()
      self:StartTask(function(TT)
        local res = AsyncRequestRes:New()
        res = self._component:HandleStory(TT, res, self._paramMissionId, 2)
        if res == 0 then
        end
      end)
    end)
  else
  end
end

function UIN27MiniGameController:_CheckCampaignClose()
  local time = self._componentInfo.m_close_time - math.floor(self._svrTimeModule:GetServerTime() * 0.001)
  if time <= 0 then
    ToastManager.ShowToast(StringTable.Get("str_n27_poststation_lock"))
    local campaignModule = GameGlobal.GetModule(CampaignModule)
    campaignModule:CampaignSwitchState(true, UIStateType.UIN27Main, UIStateType.UIMain, nil, self._data._id)
    return true
  end
  return false
end

function UIN27MiniGameController:_CheckPreMission(index)
  if index == 1 then
    return true
  end
  return self._componentInfo.mission_infos[self:GetMissionIdByIndex(index - 1)] and self._componentInfo.mission_infos[self:GetMissionIdByIndex(index - 1)].suc > 0
end

function UIN27MiniGameController:_CheckMissionPass(index)
  return self._componentInfo.mission_infos[self:GetMissionIdByIndex(index)] and self._componentInfo.mission_infos[self:GetMissionIdByIndex(index)].suc > 0
end

function UIN27MiniGameController:_GetCurrentSelectMission()
  local mission = self._cfg_stage[1].ID
  for key, value in ipairs(self._cfg_stage) do
    if self:_IsNewUnLockMission(key) then
      mission = value.ID
    end
  end
  for i = 1, table.count(self._cfg_stage) do
    local Id = self:GetMissionIdByIndex(i)
    if (not self._componentInfo.mission_infos[Id] or self._componentInfo.mission_infos[Id].suc == 0 or 0 < #self._componentInfo.mission_infos[Id].can_get_target_list or #self._componentInfo.mission_infos[Id].already_get_target_list ~= 3) and self:_IsNewUnLockMission(i) then
      mission = Id
      return mission
    end
  end
  return mission
end

function UIN27MiniGameController:_Hide(hide)
  self._blackMask:SetActive(hide)
end

function UIN27MiniGameController:GetFirstMissionId()
  local firstId = self._cfg_stage[1].ID
  for k, v in pairs(self._cfg_stage) do
    if firstId > v.ID then
      firstId = v.ID
    end
  end
  return firstId
end

function UIN27MiniGameController:GetMissionIdByIndex(index)
  return self._cfg_stage[index].ID
end

function UIN27MiniGameController:_GetMissionLastStoryCfg(missionId)
  for index, value in ipairs(self._cfg_stage) do
    if value.ID == missionId then
      for i = 1, #value.StoryActiveType do
        if value.StoryActiveType[i] == 2 then
          return value.StoryID[i]
        end
      end
    end
  end
  return
end

function UIN27MiniGameController:GetIndexByMissionId(missionId)
  for i = 1, #self._cfg_stage do
    if self._cfg_stage[i].ID == missionId then
      return i
    end
  end
  return 1
end

function UIN27MiniGameController:SortCfgById()
  table.sort(self._cfg_stage, function(a, b)
    return a.ID < b.ID
  end)
end

function UIN27MiniGameController:StoryNewOnClick(go)
  self:_PlayMissStory()
end

function UIN27MiniGameController:AfterUILayerChanged(go)
  if not self._current_waypoint_index then
    self._current_waypoint_index = 1
  end
  self:_RefreshUIInfo()
  self:_RefreshWayPointWayLineInfo()
  self:_RefreshWayPointSelectStatus(self._current_waypoint_index)
end

function UIN27MiniGameController:InfobtnOnClick(go)
  self:ShowDialog("UIIntroLoader", "UIN27MiniGameIntro")
end

function UIN27MiniGameController:ButtonBackOnClick(go)
  self:SwitchState(UIStateType.UIN27Controller)
end

function UIN27MiniGameController:ButtonThumbOnClick(go)
  self:SwitchState(UIStateType.UIMain)
end

function UIN27MiniGameController:_MoveToIndex()
  local selectWayPoint
  self._wayPointCell = self._wayPoint:GetAllSpawnList()
  for key, value in pairs(self._wayPointCell) do
    if key == self._current_waypoint_index then
      selectWayPoint = value
      break
    end
  end
  local rc = selectWayPoint:GetRectTransform()
  local posx = rc.anchoredPosition.x
  local endPointX = 0
  endPointX = Mathf.Min(0, 915.0 - posx)
  self._content.anchoredPosition = Vector2(endPointX, 0)
end
