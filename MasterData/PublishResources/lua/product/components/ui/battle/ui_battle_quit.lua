_class("UIBattleQuit", UIController)
UIBattleQuit = UIBattleQuit

function UIBattleQuit:OnShow(uiParams)
  self._tip = self:GetUIComponent("UILocalizationText", "descText")
  self._hasQuit = false
  self._title = self:GetUIComponent("UILocalizationText", "LocalizationText")
  self._quitType = uiParams[1]
  if self._quitType == UIBattleQuitType.ReStart then
    self._title:SetText(StringTable.Get("str_battle_restart_info"))
    self._tip:SetText("")
  else
    self._title:SetText(StringTable.Get("str_battle_quit_content"))
    local match = self:GetModule(MatchModule)
    local enterData = match:GetMatchEnterData()
    local bIsFirst = 0
    local nNeedPower = 0
    local nCostPower = 0
    local text = ""
    self._matchType = enterData:GetMatchType()
    self._subMatchType = enterData:GetSubMatchType()
    if MatchType.MT_Mission == enterData._match_type then
      local mission = self:GetModule(MissionModule)
      local missionID = enterData:GetMissionCreateInfo().mission_id
      bIsFirst = not mission:IsAlreadyReturnPower(missionID)
      local costConfigID = 1
      nNeedPower = Cfg.cfg_mission[missionID].NeedPower
      nCostPower = Cfg.cfg_mission_common[costConfigID].CostPower
      local prism = StringTable.Get(Cfg.cfg_item[RoleAssetID.RoleAssetPhyPoint].Name)
      if nNeedPower == 0 then
        text = StringTable.Get("str_battle_quit_content_description_zero", nNeedPower, prism)
      elseif bIsFirst then
        text = StringTable.Get("str_battle_quit_content_description_first", nNeedPower, prism)
      else
        text = StringTable.Get("str_battle_quit_content_description_not_first", nNeedPower - nCostPower, prism, nCostPower)
      end
    elseif MatchType.MT_Campaign == enterData._match_type then
      local noTip = false
      local campaignModule = self:GetModule(CampaignModule)
      local campId, comId, comType = campaignModule:ParseCampaignMissionParams(enterData:GetMissionCreateInfo().CampaignMissionParams)
      local campConfig = Cfg.cfg_campaign[campId]
      if campConfig then
        local campType = campConfig.CampaignType
        if campType == ECampaignType.CAMPAIGN_TYPE_SUMMER_II then
          if comType == CampaignComType.E_CAMPAIGN_COM_SUM_II_MISSION then
            noTip = true
          end
        elseif campType == ECampaignType.CAMPAIGN_TYPE_N12 then
          noTip = true
        elseif campType == ECampaignType.CAMPAIGN_TYPE_SEASON_TASK_MISSION then
          noTip = true
        end
      end
      local isTactic = self:GetModule(AircraftModule):IsAircraftCartridgeMission(enterData:GetCampaignMissionInfo().nMissionComId)
      if noTip then
      elseif isTactic then
        text = StringTable.Get("str_aircraft_tactic_battle_exit_tip")
      else
        local module = self:GetModule(MissionModule)
        local missionID = enterData:GetCampaignMissionInfo().nCampaignMissionId
        bIsFirst = not module:IsAlreadyReturnPowerCamMission(missionID)
        local costConfigID = 1
        local missionCfg = Cfg.cfg_campaign_mission[missionID]
        if missionCfg.NeedAP then
          local id = missionCfg.NeedAP[1]
          local count = missionCfg.NeedAP[2]
          local name = StringTable.Get(Cfg.cfg_item[id].Name)
          text = StringTable.Get("str_battle_quit_content_description_zero", count, name)
        else
          local prism = StringTable.Get(Cfg.cfg_item[RoleAssetID.RoleAssetPhyPoint].Name)
          nNeedPower = missionCfg.NeedPower
          nCostPower = Cfg.cfg_mission_common[costConfigID].CostPower
          if nNeedPower == 0 then
            text = StringTable.Get("str_battle_quit_content_description_zero", nNeedPower, prism)
          elseif bIsFirst then
            text = StringTable.Get("str_battle_quit_content_description_first", nNeedPower, prism)
          else
            text = StringTable.Get("str_battle_quit_content_description_not_first", nNeedPower - nCostPower, prism, nCostPower)
          end
        end
      end
    elseif MatchType.MT_ExtMission == enterData._match_type then
      local createData = enterData:GetMissionCreateInfo()
      local workModule = self:GetModule(ExtMissionModule)
      bIsFirst = workModule:UI_IsFirstFail(createData.m_nExtMissionID, createData.m_nExtTaskID)
      local cfgExtTask = Cfg.cfg_extra_mission_task[createData.m_nExtTaskID]
      nNeedPower = cfgExtTask.ExpendPower
      nCostPower = cfgExtTask.MinCostPower
      local prism = StringTable.Get(Cfg.cfg_item[RoleAssetID.RoleAssetPhyPoint].Name)
      if nNeedPower == 0 then
        text = StringTable.Get("str_battle_quit_content_description_zero", nNeedPower, prism)
      elseif bIsFirst then
        text = StringTable.Get("str_battle_quit_content_description_first", nNeedPower, prism)
      else
        text = StringTable.Get("str_battle_quit_content_description_not_first", nNeedPower - nCostPower, prism, nCostPower)
      end
    elseif MatchType.MT_ResDungeon == enterData._match_type then
      local createData = enterData:GetResDungeonInfo()
      local module = self:GetModule(ResDungeonModule)
      bIsFirst = module:AlreadyReturnedPower(createData.res_dungeon_id)
      local cfgExtTask = Cfg.cfg_res_instance_detail[createData.res_dungeon_id]
      nNeedPower = cfgExtTask.NeedPower
      nCostPower = cfgExtTask.MinCostPower
      if module:IsOpenDoubleRes() then
        nNeedPower = nNeedPower * 3
      end
      local prism = StringTable.Get(Cfg.cfg_item[RoleAssetID.RoleAssetPhyPoint].Name)
      if nNeedPower == 0 then
        text = StringTable.Get("str_battle_quit_content_description_zero", nNeedPower, prism)
      elseif bIsFirst then
        text = StringTable.Get("str_battle_quit_content_description_first", nNeedPower, prism)
      else
        text = StringTable.Get("str_battle_quit_content_description_not_first", nNeedPower - nCostPower, prism, nCostPower)
      end
    elseif MatchType.MT_Maze == enterData._match_type then
      text = StringTable.Get("str_maze_tip_battle_quit")
    elseif MatchType.MT_Tower == enterData._match_type then
      text = StringTable.Get("str_tower_quit_battle_tip")
    elseif MatchType.MT_DifficultyMission == enterData._match_type then
      text = StringTable.Get("str_tower_quit_battle_tip")
    elseif MatchType.MT_Conquest == enterData._match_type then
      text = StringTable.Get("str_n5_record_militaryexploit")
    elseif MatchType.MT_WorldBoss == enterData._match_type then
      text = StringTable.Get("str_world_boss_record_damage")
    elseif MatchType.MT_SailingMission == enterData._match_type then
      text = StringTable.Get("str_sailing_mission_quit_battle_tip")
    elseif MatchType.MT_MiniMaze == enterData._match_type then
      text = StringTable.Get("str_n25_quit_battle_tip")
    elseif MatchType.MT_PopStar == enterData._match_type then
      local createInfo = enterData:GetMissionCreateInfo()
      if createInfo.is_challenge then
        self._isPopStarChallengeMission = true
        text = StringTable.Get("str_n31_popstar_quit_battle_tip")
      end
    elseif MatchType.MT_Season == enterData._match_type then
      local noTip = false
      local module = self:GetModule(MissionModule)
      local missionID = enterData:GetSeasonMissionInfo().mission_id
      bIsFirst = false
      local costConfigID = 1
      local missionCfg = Cfg.cfg_season_mission[missionID]
      if missionCfg.NeedAP then
        local id = missionCfg.NeedAP[1]
        local count = missionCfg.NeedAP[2]
        local name = StringTable.Get(Cfg.cfg_item[id].Name)
        text = StringTable.Get("str_battle_quit_content_description_zero", count, name)
      else
        local isDaily = missionCfg.Type == SeasonEventPointType.DailyLevel
        local prism = StringTable.Get(Cfg.cfg_item[RoleAssetID.RoleAssetPhyPoint].Name)
        nNeedPower = missionCfg.NeedPower
        nCostPower = Cfg.cfg_mission_common[costConfigID].CostPower
        if nNeedPower == 0 then
          if isDaily then
            text = ""
          else
            text = StringTable.Get("str_battle_quit_content_description_zero", nNeedPower, prism)
          end
        elseif bIsFirst then
          text = StringTable.Get("str_battle_quit_content_description_first", nNeedPower, prism)
        else
          text = StringTable.Get("str_battle_quit_content_description_not_first", nNeedPower - nCostPower, prism, nCostPower)
        end
      end
    elseif MatchType.MT_SeasonMaze == enterData._match_type then
      text = StringTable.Get("str_season_maze_battle_quit_desc")
    end
    self._tip:SetText(text)
  end
end

function UIBattleQuit:CancelBtnOnClick(go)
  GameGlobal.GameRecorder():RecordAction(GameRecordAction.UIInput, {
    ui = "UIBattleQuit",
    input = "CancelBtnOnClick",
    args = {}
  })
  self:CloseDialog()
  AudioHelperController.PlayUISoundAutoRelease(CriAudioIDConst.SoundCancel)
  if self._quitType == UIBattleQuitType.ReStart then
    self:ShowDialog("UIBattleInfo")
  end
end

function UIBattleQuit:OKBtnOnClick(go)
  if self._hasQuit then
    Log.warn("**********repeat click quit button***********")
    return
  end
  InnerGameHelperRender.SetGlobalOutLine(false)
  if AUTO_RELOAD_GAME_CFG and EDITOR then
    ConfigServiceHelper.ClearSkillConfigData()
  end
  local hpm = self:GetModule(HelpPetModule)
  hpm:UI_ClearHelpPet()
  GameGlobal.GameRecorder():RecordAction(GameRecordAction.UIInput, {
    ui = "UIBattleQuit",
    input = "OKBtnOnClick",
    args = {}
  })
  if self._quitType == UIBattleQuitType.ReStart then
    GameGlobal.EventDispatcher():Dispatch(GameEventType.MatchClosed, true)
    local match = self:GetModule(MatchModule)
    match:SetReStartMatchState(true)
  else
    Log.notice("----------- quit battle -----------")
    local match = self:GetModule(MatchModule)
    match:SetReStartMatchState(false)
    if self:CheckNeedSendSpQuitGame() then
      GameGlobal.EventDispatcher():Dispatch(GameEventType.SpecialMissionQuitGame)
    else
      GameGlobal.EventDispatcher():Dispatch(GameEventType.MatchClosed)
    end
  end
  self._hasQuit = true
end

function UIBattleQuit:SwitchUI(type, param)
  GameGlobal.LoadingManager():StartLoading(LoadingHandlerName.Battle_Exit, "UI", type, param)
end

function UIBattleQuit:CheckNeedSendSpQuitGame()
  if self._matchType == MatchType.MT_Conquest or self._matchType == MatchType.MT_WorldBoss or self._matchType == MatchType.MT_MiniMaze or self._isPopStarChallengeMission then
    return true
  end
  if self._matchType == MatchType.MT_SeasonMaze and self._subMatchType == MatchType.MT_WorldBoss then
    return true
  end
  return false
end

local UIBattleQuitType = {Quit = 1, ReStart = 2}
_enum("UIBattleQuitType", UIBattleQuitType)
