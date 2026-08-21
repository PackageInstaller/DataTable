_class("UIBattleInfo", UIController)
UIBattleInfo = UIBattleInfo

function UIBattleInfo:OnShow(uiParams)
  self._isBattleStart = uiParams[1]
  self._allStarConditionTxtList = {
    self._allStarCondition1Txt,
    self._allStarCondition2Txt,
    self._allStarCondition3Txt
  }
  self._victoryConditionTxt = self:GetUIComponent("UILocalizationText", "VictoryConditionText")
  local sop = self:GetUIComponent("UISelectObjectPath", "ConditionList")
  sop:SpawnObjects("UIBattleInfoConditionItem", 3)
  self._items = sop:GetAllSpawnList()
  self._mazeInfo = self:GetGameObject("MazeInfo")
  self._mazeRoomName = self:GetUIComponent("UILocalizationText", "MazeRoomName")
  self._allStarInfo = self:GetGameObject("AllStartInfo")
  self._victoryInfoRect = self:GetUIComponent("RectTransform", "VictoryInfo")
  self._noAllStarConditionGO = self:GetGameObject("NoAllStartCondition")
  self._noAllStarConditionGO:SetActive(false)
  self._allStarConditionList = self:GetGameObject("ConditionList")
  self._infoTex = self:GetUIComponent("UILocalizationText", "InfoText")
  local infoTex = ""
  local match = self:GetModule(MatchModule)
  local enterData = match:GetMatchEnterData()
  local isWarChess = MatchType.MT_Chess == enterData._match_type
  self:GetGameObject("Restrain"):SetActive(not isWarChess)
  self:GetGameObject("ChessRestrain"):SetActive(isWarChess)
  if MatchType.MT_Mission == enterData._match_type then
    local stageInfo = ""
    local missionID = enterData:GetMissionCreateInfo().mission_id
    local missionModule = self:GetModule(MissionModule)
    local data = missionModule:GetDiscoveryData()
    if data then
      local node = data:GetNodeDataByStageId(missionID)
      if node then
        local stage = node:GetStageById(missionID)
        if stage then
          stageInfo = stage.stageIdx .. " " .. stage.name
        end
      end
    end
    local allStarConditions = ConfigServiceHelper.GetMission3StarCondition(missionID)
    if allStarConditions and 0 < #allStarConditions then
      infoTex = stageInfo
      self:_Set3StarCondition(missionID, missionModule, allStarConditions)
    else
      infoTex = StringTable.Get("str_battle_info_title")
      self._mazeRoomName.text = stageInfo
      self._allStarInfo:SetActive(false)
      self._mazeInfo:SetActive(true)
      self._victoryInfoRect.anchoredPosition = Vector2(self._victoryInfoRect.anchoredPosition.x, 128)
    end
  elseif MatchType.MT_DifficultyMission == enterData._match_type then
    self._allStarConditionList:SetActive(false)
    self._noAllStarConditionGO:SetActive(true)
    local info = enterData:GetDifficultyMissionInfo()
    local nodeid = info.parent_mission_id
    local stageid = info.sub_mission_id
    local cfg_diff_stage = Cfg.cfg_difficulty_sub_mission[stageid]
    local stageName = cfg_diff_stage.MissionName
    infoTex = StringTable.Get(stageName)
  elseif MatchType.MT_Campaign == enterData._match_type then
    local missionID = enterData:GetMissionCreateInfo().nCampaignMissionId
    local campaignModule = self:GetModule(CampaignModule)
    local isActivityResult = false
    local campId, comId, comType = campaignModule:ParseCampaignMissionParams(enterData:GetMissionCreateInfo().CampaignMissionParams)
    local campConfig = Cfg.cfg_campaign[campId]
    if campConfig then
      local campType = campConfig.CampaignType
      if campType == ECampaignType.CAMPAIGN_TYPE_SUMMER_II then
        if comType == CampaignComType.E_CAMPAIGN_COM_SUM_II_MISSION then
          isActivityResult = true
        end
      elseif campType == ECampaignType.CAMPAIGN_TYPE_N12 and (comType == CampaignComType.E_CAMPAIGN_COM_CHALL_MISSION or comType == CampaignComType.E_CAMPAIGN_COM_DAILY_MISSION) then
        isActivityResult = true
      end
    end
    if isActivityResult then
      infoTex = StringTable.Get("str_battle_info_title")
      local config = Cfg.cfg_campaign_mission({CampaignMissionId = missionID})
      if config and config[1] then
        self._mazeRoomName:SetText(StringTable.Get(config[1].Name))
      end
      self._allStarInfo:SetActive(false)
      self._mazeInfo:SetActive(true)
      self._victoryInfoRect.anchoredPosition = Vector2(self._victoryInfoRect.anchoredPosition.x, 128)
    else
      local config = Cfg.cfg_campaign_mission({CampaignMissionId = missionID})
      if config and config[1] then
        infoTex = StringTable.Get(config[1].Name)
      end
      local allStarConditions = ConfigServiceHelper.GetCampaignMission3StarCondition(missionID)
      self:_Set3StarCondition(missionID, campaignModule, allStarConditions)
    end
  elseif MatchType.MT_ExtMission == enterData._match_type then
    local extMission = self:GetModule(ExtMissionModule)
    local matchCreateData = enterData:GetMissionCreateInfo()
    local detailExtTask = extMission:UI_GetExtTaskDetail(matchCreateData.m_nExtMissionID, matchCreateData.m_nExtTaskID)
    for i = 1, #detailExtTask.m_vecCondition do
      local conditionId = detailExtTask.m_vecCondition[i].m_nID
      local showProgress = Cfg.cfg_threestarcondition[conditionId].ShowProgress
      local progress
      if showProgress then
        progress = BattleStatHelper.Get3StarProgress(conditionId)
      end
      local str = i .. ".  " .. detailExtTask.m_vecCondition[i].m_stDest
      if progress then
        str = str .. "  " .. progress
      end
      local complete = detailExtTask.m_vecCondition[i].m_bPass
      self._items[i]:Flush(str, complete)
    end
    self._allStarConditionList:SetActive(true)
    self._noAllStarConditionGO:SetActive(false)
    local cfg_extra_mission = Cfg.cfg_extra_mission({})
    local idx1 = 0
    local idx2 = 0
    local extName = ""
    for i, v in HelperProxy:GetInstance():pairsByKeys(cfg_extra_mission) do
      idx1 = idx1 + 1
      if v.ExtMissionID == matchCreateData.m_nExtMissionID then
        local taskList = v.ExtTaskList
        for j = 1, #taskList do
          if taskList[j] == matchCreateData.m_nExtTaskID then
            idx2 = j
            break
          end
        end
        break
      end
    end
    local cfg_extra_mission_task = Cfg.cfg_extra_mission_task[matchCreateData.m_nExtTaskID]
    if cfg_extra_mission_task then
      extName = StringTable.Get(cfg_extra_mission_task.TaskName)
    else
      Log.fatal("###cfg_extra_mission_task is nil ! ID --> ", matchCreateData.m_nExtTaskID)
    end
    infoTex = idx1 .. "-" .. idx2 .. " " .. extName
  elseif MatchType.MT_ResDungeon == enterData._match_type then
    self._allStarConditionList:SetActive(false)
    self._noAllStarConditionGO:SetActive(true)
    local resModule = self:GetModule(ResDungeonModule)
    local resid = resModule:GetEnterInstanceId()
    local resCfg = Cfg.cfg_res_instance_detail[resid]
    if resCfg then
      infoTex = StringTable.Get(resCfg.Name)
    else
      Log.fatal("###res_instance_detail is nil ! id --> ", resid)
    end
  elseif MatchType.MT_Maze == enterData._match_type then
    infoTex = StringTable.Get("str_battle_info_title")
    local mazeMD = self:GetModule(MazeModule)
    local mazeRoom = mazeMD:GetCurrentRoom()
    local cfgName = StringTable.Get(Cfg.cfg_maze_room[mazeRoom.room_id].Title[1])
    self._mazeRoomName.text = cfgName
    self._allStarInfo:SetActive(false)
    self._mazeInfo:SetActive(true)
    self._victoryInfoRect.anchoredPosition = Vector2(self._victoryInfoRect.anchoredPosition.x, 128)
  elseif MatchType.MT_Tower == enterData._match_type then
    infoTex = StringTable.Get("str_battle_info_title")
    local tModule = self:GetModule(TowerModule)
    local matchInfo = tModule:GetMatchInfo()
    local tCfg = Cfg.cfg_tower_detail[matchInfo.nId]
    local name = tModule:GetTowerName(tCfg.Type)
    self._mazeRoomName.text = StringTable.Get("str_tower_tower_layer", name, tCfg.stage)
    self._allStarInfo:SetActive(false)
    self._mazeInfo:SetActive(true)
    self._victoryInfoRect.anchoredPosition = Vector2(self._victoryInfoRect.anchoredPosition.x, 128)
  elseif MatchType.MT_TalePet == enterData._match_type then
    infoTex = StringTable.Get("str_battle_info_title")
    local matchInfo = GameGlobal.GetModule(MatchModule):GetMatchEnterData():GetTalePetMissionInfo()
    local cfg = Cfg.cfg_tale_stage[matchInfo.nId]
    self._mazeRoomName:SetText(StringTable.Get(cfg.Name))
    self._allStarInfo:SetActive(false)
    self._mazeInfo:SetActive(true)
    self._victoryInfoRect.anchoredPosition = Vector2(self._victoryInfoRect.anchoredPosition.x, 128)
  elseif MatchType.MT_Conquest == enterData._match_type then
    infoTex = StringTable.Get("str_battle_info_title")
    local matchInfo = enterData:GetBattleFieldCreateInfo()
    local cfgs = Cfg.cfg_component_battlefield({
      CampaignMissionID = matchInfo.mission_id
    })
    self._mazeRoomName:SetText(StringTable.Get(cfgs[1].MissionName))
    self._mazeInfo:SetActive(true)
    self._allStarInfo:SetActive(false)
  elseif MatchType.MT_BlackFist == enterData._match_type then
    local matchInfo = enterData:GetBlackFistInfo()
    local missionid = matchInfo.mission_id
    local name
    local cfg_blackfist_mission = Cfg.cfg_blackfist_mission[missionid]
    if cfg_blackfist_mission and cfg_blackfist_mission.MissionName then
      name = StringTable.Get(cfg_blackfist_mission.MissionName)
    else
      name = StringTable.Get("str_n7_black_fight_" .. missionid)
    end
    infoTex = StringTable.Get("str_battle_info_title")
    self._mazeRoomName:SetText(name)
    self._allStarInfo:SetActive(false)
    self._mazeInfo:SetActive(true)
    self._victoryInfoRect.anchoredPosition = Vector2(self._victoryInfoRect.anchoredPosition.x, 128)
  elseif MatchType.MT_WorldBoss == enterData._match_type then
    infoTex = StringTable.Get("str_battle_info_title")
    local matchInfo = enterData:GetWorldBossCreateInfo()
    local cfg_world_boss = Cfg.cfg_world_boss_mission[matchInfo.mission_id]
    self._mazeRoomName:SetText(StringTable.Get(cfg_world_boss.MissionName))
    self._mazeInfo:SetActive(true)
    self._allStarInfo:SetActive(false)
  elseif MatchType.MT_Chess == enterData._match_type then
    local createInfo = enterData:GetChessInfo()
    local missionID = createInfo.mission_id
    local campaignModule = self:GetModule(CampaignModule)
    local config = Cfg.cfg_chess_mission({MissionID = missionID})
    if config and config[1] then
      infoTex = StringTable.Get(config[1].Name)
    end
    local allStarConditions = ConfigServiceHelper.GetChessMission3StarCondition(missionID)
    self:_Set3StarCondition(missionID, campaignModule, allStarConditions)
  elseif MatchType.MT_SailingMission == enterData._match_type then
    local missionID = enterData:GetSailingMissionInfo().mission_id
    local cfgSailingMission = Cfg.cfg_sailing_mission[missionID]
    if cfgSailingMission then
      infoTex = StringTable.Get("str_battle_info_title")
      self._mazeRoomName:SetText(StringTable.Get(cfgSailingMission.MissionName))
    end
    self._allStarInfo:SetActive(false)
    self._mazeInfo:SetActive(true)
    self._victoryInfoRect.anchoredPosition = Vector2(self._victoryInfoRect.anchoredPosition.x, 128)
  elseif MatchType.MT_MiniMaze == enterData._match_type then
    infoTex = StringTable.Get("str_battle_info_title")
    local matchInfo = enterData:GetMissionCreateInfo()
    local cfg = Cfg.cfg_component_bloodsucker({
      CampaignMissionID = matchInfo.mission_id
    })
    self._mazeRoomName:SetText(StringTable.Get(cfg[1].MissionName))
    self._mazeInfo:SetActive(true)
    self._allStarInfo:SetActive(false)
  elseif MatchType.MT_PopStar == enterData._match_type then
    self:GetGameObject("Restrain"):SetActive(false)
    local createInfo = enterData:GetMissionCreateInfo()
    local missionID = createInfo.mission_id
    local config = Cfg.cfg_popstar_mission({MissionID = missionID})
    if createInfo.is_challenge then
      infoTex = StringTable.Get("str_battle_info_title")
      self._mazeRoomName.text = StringTable.Get(config[1].Name)
      self._allStarInfo:SetActive(false)
      self._mazeInfo:SetActive(true)
      self._victoryInfoRect.anchoredPosition = Vector2(self._victoryInfoRect.anchoredPosition.x, 128)
    else
      if config and config[1] then
        infoTex = StringTable.Get(config[1].Name)
      end
      local campaignModule = self:GetModule(CampaignModule)
      local allStarConditions = ConfigServiceHelper.GetPopStar3StarCondition(missionID)
      self:_Set3StarCondition(missionID, campaignModule, allStarConditions)
    end
  elseif MatchType.MT_EightPets == enterData._match_type then
    local missionID = enterData:GetEightPetsMissionInfo().mission_id
    local config = Cfg.cfg_eight_pets_mission({MissionID = missionID})
    local name = ""
    if config and config[1] then
      name = StringTable.Get(config[1].Name)
    end
    infoTex = StringTable.Get("str_battle_info_title")
    self._mazeRoomName.text = name
    self._allStarInfo:SetActive(false)
    self._mazeInfo:SetActive(true)
    self._victoryInfoRect.anchoredPosition = Vector2(self._victoryInfoRect.anchoredPosition.x, 128)
  elseif MatchType.MT_Season == enterData._match_type then
    local missionID = enterData:GetMissionCreateInfo().mission_id
    local config = Cfg.cfg_season_mission[missionID]
    if config then
      infoTex = StringTable.Get(config.Name)
    end
    local seasonModule = self:GetModule(SeasonModule)
    local allStarConditions = ConfigServiceHelper.GetSeasonMission3StarCondition(missionID)
    self:_Set3StarCondition(missionID, seasonModule, allStarConditions)
  elseif MatchType.MT_PopStarPro == enterData:GetMatchType() then
    infoTex = StringTable.Get("str_battle_info_title")
    local createInfo = enterData:GetMissionCreateInfo()
    local cfgName = StringTable.Get(Cfg.cfg_anipop_mission[createInfo.mission_id].Name)
    self._mazeRoomName.text = cfgName
    self._allStarInfo:SetActive(false)
    self._mazeInfo:SetActive(true)
    self._victoryInfoRect.anchoredPosition = Vector2(self._victoryInfoRect.anchoredPosition.x, 128)
  elseif MatchType.MT_SeasonMaze == enterData._match_type then
    infoTex = StringTable.Get("str_battle_info_title")
    local createInfo = enterData:GetSeasonMazeMissionInfo()
    local cfgName = StringTable.Get(Cfg.cfg_season_maze_mission[createInfo.mission_id].MissionName)
    self._mazeRoomName.text = cfgName
    self._allStarInfo:SetActive(false)
    self._mazeInfo:SetActive(true)
    self._victoryInfoRect.anchoredPosition = Vector2(self._victoryInfoRect.anchoredPosition.x, 128)
  end
  self._infoTex:SetText(infoTex)
  self._victoryConditionTxt:SetText(ConfigServiceHelper.GetLevelConfigData():GetLevelCompleteConditionStr())
  if self._isBattleStart then
    self:BattleStartAnim()
  end
end

function UIBattleInfo:_Set3StarCondition(missionID, module, allStarConditions)
  local flag = true
  if not module:Has3StarCondition(missionID) then
    flag = false
  end
  if not allStarConditions or table.count(allStarConditions) == 0 then
    flag = false
  end
  if not flag then
    self._noAllStarConditionGO:SetActive(true)
    self._allStarConditionList:SetActive(false)
    return
  end
  BattleStatHelper.CalcBonusObjective()
  for i = 1, #allStarConditions do
    local showProgress = Cfg.cfg_threestarcondition[allStarConditions[i]].ShowProgress
    local cur3StarProgress = BattleStatHelper.Get3StarProgress(allStarConditions[i])
    local cur3StarMatchResult = BattleStatHelper.GetBonusMatchResult()
    local strCond = ""
    if showProgress then
      strCond = i .. ".  " .. module:Get3StarConditionDesc(allStarConditions[i], "41F4FF") .. "  " .. cur3StarProgress
    else
      strCond = i .. ".  " .. module:Get3StarConditionDesc(allStarConditions[i], "41F4FF")
    end
    local checkComplete = false
    for _, conditionId in ipairs(cur3StarMatchResult) do
      if conditionId == allStarConditions[i] then
        checkComplete = true
        break
      end
    end
    local item = self._items[i]
    if item then
      item:Flush(strCond, checkComplete)
    else
      Log.fatal("### UIBattleInfo", i)
    end
  end
end

function UIBattleInfo:BattleStartAnim()
  self.networkMonitorPopup = PopupManager.Alert("UICommonMessageBox", PopupPriority.Network, PopupMsgBoxType.OkCancel, "", txt, function()
    self.networkMonitorPopup = nil
    if func1 then
      func1()
    end
  end, nil, function()
    self.networkMonitorPopup = nil
    if func2 then
      func2()
    end
  end, nil)
end

function UIBattleInfo:RestartBtnOnClick(go)
  GameGlobal.GameRecorder():RecordAction(GameRecordAction.UIInput, {
    ui = "UIBattleInfo",
    input = "RestartBtnOnClick",
    args = {}
  })
  self:ShowDialog("UIBattleQuit", UIBattleQuitType.ReStart)
  self:CloseDialog()
end

function UIBattleInfo:QuitBtnOnClick(go)
  GameGlobal.GameRecorder():RecordAction(GameRecordAction.UIInput, {
    ui = "UIBattleInfo",
    input = "QuitBtnOnClick",
    args = {}
  })
  self:ShowDialog("UIBattleQuit", UIBattleQuitType.Quit)
  self:CloseDialog()
end

function UIBattleInfo:CancelBtnOnClick(go)
  GameGlobal.GameRecorder():RecordAction(GameRecordAction.UIInput, {
    ui = "UIBattleInfo",
    input = "CancelBtnOnClick",
    args = {}
  })
  self:CloseDialog()
  AudioHelperController.PlayUISoundAutoRelease(CriAudioIDConst.SoundCancel)
end
