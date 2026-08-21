_class("MatchEnterData", Object)
MatchEnterData = MatchEnterData

function MatchEnterData:Constructor(player_pstid, create_info, player_list)
  if player_pstid == nil then
    return
  end
  self._player_pstid = player_pstid
  self._client_create_info = create_info.client_create_info
  self._match_type = create_info.match_type
  self:SetSubMatchTypeByMatchType()
  self._linkLineType = create_info.link_line_type
  self._level_id = create_info.level_id
  self._wordBuffIds = create_info.word_ids
  self._time = create_info.m_time
  self._seed = create_info.seed
  self._joined_players = player_list
  self._sync_mode = create_info.sync_mode
  self._server_auto_fight = create_info.server_auto_fight
  self._flags = FlagValue:New(create_info.match_logic_flags)
  self._guideInfo = create_info.guide_info
  self._level_is_pass = create_info.level_is_pass
  self._assign_wave_refresh_probability = create_info.assign_wave_refresh_probability
  self.m_nHelpPetKey = create_info.m_nHelpPetKey
  self._tale_pet_buffs = create_info.tale_pet_buffs
  self._normal_pet_buffs = create_info.normal_pet_buffs
  self._tale_buff_cfgID = create_info.trail_buff_level_id
  self._double_resource_state = create_info.double_resource_state
  self._affixList = create_info.affixList
  self._hardIndex = create_info.hard_id
  self._hardID = create_info.hard_pro_id
  self._boardSeed = create_info.board_seed
  self._waveIDList = create_info.wave_id_list
  self._boardIDList = create_info.broad_id_list
  self._enlightenIDDic = create_info.pro_type_id
  local enableSeasonMazeTest = false
  if enableSeasonMazeTest then
    self._match_type = MatchType.MT_SeasonMaze
    self._subMatchType = MatchType.MT_SeasonMaze
    self._level_id = 800901
  end
end

function MatchEnterData:SetSubMatchTypeByMatchType()
  if self._match_type == MatchType.MT_Campaign then
    local campaignMissionInfo = self._client_create_info.campaign_mission_info[1]
    self._subMatchType = campaignMissionInfo.nSubMatchType
  elseif self._match_type == MatchType.MT_WorldBoss then
    local createInfo = self:GetWorldBossCreateInfo()
    local cfg = Cfg.cfg_world_boss_mission[createInfo.mission_id]
    if cfg.SubMatchType then
      self._subMatchType = cfg.SubMatchType
    end
  elseif self._match_type == MatchType.MT_SeasonMaze then
    local createInfo = self._client_create_info.season_maze_mission_info[1]
    local cfg = Cfg.cfg_world_boss_mission[createInfo.mission_id]
    self._subMatchType = createInfo.match_sub_type
  else
    self._subMatchType = self._match_type
  end
  if not self._subMatchType then
    self._subMatchType = self._match_type
  end
end

function MatchEnterData:IsHaveHelpPet()
  return self.m_nHelpPetKey and self.m_nHelpPetKey > 0
end

function MatchEnterData:GetPetHp()
  return 100, 100
end

function MatchEnterData:GetPetDie()
  return false
end

function MatchEnterData:GetMazePetInfoByPstId(pstid)
  local tab = {}
  tab.pet_pstid = pstid
  tab.power = 100
  tab.cur_hp = 50
  tab.is_dead = false
  return tab
end

function MatchEnterData:GetCalPetMaxHp(pstid)
  local mask_hp = 100
  return mask_hp
end

function MatchEnterData:GetAssignRefreshProb()
  return self._assign_wave_refresh_probability
end

function MatchEnterData:LevelIsPass()
  return self._level_is_pass
end

function MatchEnterData:GetMatchType()
  return self._match_type
end

function MatchEnterData:GetSubMatchType()
  return self._subMatchType
end

function MatchEnterData:GetLevelID()
  return self._level_id
end

function MatchEnterData:GetSeed()
  return self._seed
end

function MatchEnterData:GetServerTime()
  return self._time
end

function MatchEnterData:GetPlayerList()
  return self._joined_players
end

function MatchEnterData:GetLocalPlayerInfo()
  return self._joined_players[self._player_pstid]
end

function MatchEnterData:GetMissionCreateInfo()
  local createData
  if self._match_type == MatchType.MT_Mission then
    return self._client_create_info.mission_info[1]
  elseif MatchType.MT_ExtMission == self._match_type then
    return self._client_create_info.m_extMissionInfo[1]
  elseif MatchType.MT_Campaign == self._match_type then
    return self._client_create_info.campaign_mission_info[1]
  elseif MatchType.MT_SailingMission == self._match_type then
    return self._client_create_info.sailing_mission_info[1]
  elseif self._match_type == MatchType.MT_MiniMaze then
    return self._client_create_info.bloodsucker_mission_info[1]
  elseif self._match_type == MatchType.MT_PopStar then
    return self._client_create_info.popstar_mission_info[1]
  elseif self._match_type == MatchType.MT_Season then
    return self._client_create_info.season_mission_info[1]
  elseif self._match_type == MatchType.MT_PopStarPro then
    return self._client_create_info.anipop_mission_info[1]
  end
end

function MatchEnterData:GetMazeCreateInfo()
  if self._match_type == MatchType.MT_Maze then
    return self._client_create_info.maze_info[1]
  end
end

function MatchEnterData:GetResDungeonInfo()
  if self._match_type == MatchType.MT_ResDungeon then
    return self._client_create_info.resdungeon_info[1]
  end
end

function MatchEnterData:GetTowerInfo()
  if self._match_type == MatchType.MT_Tower then
    return self._client_create_info.tower_info[1]
  end
end

function MatchEnterData:GetCampaignMissionInfo()
  if self._match_type == MatchType.MT_Campaign then
    return self._client_create_info.campaign_mission_info[1]
  end
end

function MatchEnterData:GetSailingMissionInfo()
  if MatchType.MT_SailingMission == self._match_type then
    return self._client_create_info.sailing_mission_info[1]
  end
end

function MatchEnterData:GetTalePetMissionInfo()
  if self._match_type == MatchType.MT_TalePet then
    return self._client_create_info.tale_pet_info[1]
  end
end

function MatchEnterData:GetWorldBossCreateInfo()
  if self._match_type == MatchType.MT_WorldBoss then
    return self._client_create_info.world_boss_mission_info[1]
  end
end

function MatchEnterData:GetBlackFistInfo()
  if self._match_type == MatchType.MT_BlackFist then
    return self._client_create_info.black_fist_info[1]
  end
end

function MatchEnterData:GetChessInfo()
  if self._match_type == MatchType.MT_Chess then
    return self._client_create_info.chess_mission_info[1]
  end
end

function MatchEnterData:GetDifficultyMissionInfo()
  if self._match_type == MatchType.MT_DifficultyMission then
    return self._client_create_info.difficulty_mission_info[1]
  end
end

function MatchEnterData:GetSeasonMissionInfo()
  if self._match_type == MatchType.MT_Season then
    return self._client_create_info.season_mission_info[1]
  end
end

function MatchEnterData:GetEightPetsMissionInfo()
  if self._match_type == MatchType.MT_EightPets then
    return self._client_create_info.eight_pets_mission_info[1]
  end
end

function MatchEnterData:GetSeasonMazeMissionInfo()
  if self._match_type == MatchType.MT_SeasonMaze then
    return self._client_create_info.season_maze_mission_info[1]
  end
end

function MatchEnterData:GetAniPopStarInfo()
  if self._match_type == MatchType.MT_PopStarPro then
    return self._client_create_info.anipop_mission_info[1]
  end
end

function MatchEnterData:HasBonusConditionArray()
  if self._match_type == MatchType.MT_Mission then
    return true
  elseif MatchType.MT_ExtMission == self._match_type then
    return true
  elseif MatchType.MT_ResDungeon == self._match_type then
    return true
  end
end

function MatchEnterData:GetBonusConditionArray()
  local bonusConditionArray = {}
  if self._match_type == MatchType.MT_Mission then
    local missionInfo = self._client_create_info.mission_info[1]
    local missionData = Cfg.cfg_mission[missionInfo.mission_id]
    local conditionID = missionData.ThreeStarCondition1
    bonusConditionArray[#bonusConditionArray + 1] = conditionID
    conditionID = missionData.ThreeStarCondition2
    bonusConditionArray[#bonusConditionArray + 1] = conditionID
    conditionID = missionData.ThreeStarCondition3
    bonusConditionArray[#bonusConditionArray + 1] = conditionID
  elseif MatchType.MT_Campaign == self._match_type then
    local missionInfo = self._client_create_info.campaign_mission_info[1]
    local missionData = Cfg.cfg_campaign_mission[missionInfo.nCampaignMissionId]
    if missionData and missionData.IgnoreThreeStar == 0 then
      local conditionID = missionData.ThreeStarCondition1
      bonusConditionArray[#bonusConditionArray + 1] = conditionID
      conditionID = missionData.ThreeStarCondition2
      bonusConditionArray[#bonusConditionArray + 1] = conditionID
      conditionID = missionData.ThreeStarCondition3
      bonusConditionArray[#bonusConditionArray + 1] = conditionID
    end
  elseif MatchType.MT_ExtMission == self._match_type then
    local extMissionInfo = self._client_create_info.m_extMissionInfo[1]
    local extTaskData = Cfg.cfg_extra_mission_task[extMissionInfo.m_nExtTaskID]
    local conditionID = 0
    conditionID = extTaskData.ThreeStarCondition1
    bonusConditionArray[#bonusConditionArray + 1] = conditionID
    conditionID = extTaskData.ThreeStarCondition2
    bonusConditionArray[#bonusConditionArray + 1] = conditionID
    conditionID = extTaskData.ThreeStarCondition3
    bonusConditionArray[#bonusConditionArray + 1] = conditionID
  elseif MatchType.MT_ResDungeon == self._match_type then
    local info = self._client_create_info.resdungeon_info[1]
    local cfg = Cfg.cfg_res_instance_detail[info.res_dungeon_id]
    local conditionID = 0
    conditionID = cfg.ThreeStarCondition1
    bonusConditionArray[#bonusConditionArray + 1] = conditionID
    conditionID = cfg.ThreeStarCondition2
    bonusConditionArray[#bonusConditionArray + 1] = conditionID
    conditionID = cfg.ThreeStarCondition3
    bonusConditionArray[#bonusConditionArray + 1] = conditionID
  elseif MatchType.MT_Season == self._match_type then
    local missionInfo = self._client_create_info.season_mission_info[1]
    local missionData = Cfg.cfg_season_mission[missionInfo.mission_id]
    if missionData and missionData.ShowCondition == 1 then
      local conditionID = missionData.ThreeStarCondition1
      bonusConditionArray[#bonusConditionArray + 1] = conditionID
      conditionID = missionData.ThreeStarCondition2
      bonusConditionArray[#bonusConditionArray + 1] = conditionID
      conditionID = missionData.ThreeStarCondition3
      bonusConditionArray[#bonusConditionArray + 1] = conditionID
    end
  end
  return bonusConditionArray
end

function MatchEnterData:IsSpeedUpEnabled()
  return self._flags:CheckFlag(MatchLogicFlags.MLF_SpeedUp)
end

function MatchEnterData:GetSyncMode()
  return self._sync_mode
end

function MatchEnterData:GetServerAutoFight()
  return self._server_auto_fight
end

function MatchEnterData:IsEnableAuroraTime()
  if self:GetSubMatchType() == MatchType.MT_PopStarPro then
    return false
  end
  return Cfg.cfg_global.EnableAuroraTime.IntValue == 1
end

function MatchEnterData:GetWordBuffIds()
  return self._wordBuffIds
end

function MatchEnterData:GetLocalMatchPets()
end

function MatchEnterData:GetRemoteMatchPets()
end

function MatchEnterData:GetTalePetBuffs()
  return self._tale_pet_buffs
end

function MatchEnterData:GetNormalPetBuffs()
  return self._normal_pet_buffs
end

function MatchEnterData:GetTaleBuffCfgID()
  return self._tale_buff_cfgID
end

function MatchEnterData:GetAffixList()
  return self._affixList
end

function MatchEnterData:GetDoubleResourceState()
  return self._double_resource_state
end

function MatchEnterData:GetAssetDoubleItemCount()
  if self._match_type == MatchType.MT_Mission then
    return self:GetMissionCreateInfo().asset_double_item_count
  elseif MatchType.MT_ResDungeon == self._match_type then
    return self:GetResDungeonInfo().asset_double_item_count
  end
  return 0
end

function MatchEnterData:GetHardID()
  return self._hardID
end

function MatchEnterData:GetHardIndex()
  return self._hardIndex
end

function MatchEnterData:GetBoardSeed()
  return self._boardSeed
end

function MatchEnterData:GetWaveIDList()
  return self._waveIDList
end

function MatchEnterData:GetBoardIDList()
  return self._boardIDList
end

function MatchEnterData:GetFsmID(matchType)
  if matchType == MatchType.MT_PopStar then
    return 2
  end
  return 1
end

function MatchEnterData:ParseEnlightenInfo()
  local enlightenInfoDic = {}
  for type, ID in pairs(self._enlightenIDDic) do
    local cfgTmp = Cfg.cfg_pet_property_cultivate[ID]
    if not cfgTmp then
      Log.error("[ParseEnlightenInfo] cfg_pet_property_cultivate is nil, ID = ", ID)
    end
    enlightenInfoDic[type] = EnlightenInfo:New(cfgTmp.Attack, cfgTmp.Defence, cfgTmp.Health, cfgTmp.PropertyRestraint, cfgTmp.MainSkillDamage, cfgTmp.SupplyPieceWeight)
  end
  return enlightenInfoDic
end

local MainWorldCreationContextType = {Client = 1, Server = 2}
_enum("MainWorldCreationContextType", MainWorldCreationContextType)

function MatchEnterData:CreateWorldInfo(type)
  local worldInfo = MainWorldCreationContext:New()
  worldInfo.fsm_id = self:GetFsmID(self:GetSubMatchType())
  worldInfo.level_id = self:GetLevelID()
  worldInfo.world_seed = self:GetSeed()
  worldInfo.players = self:GetPlayerList()
  worldInfo.localPlayerInfo = self:GetLocalPlayerInfo()
  local syncMode = self:GetSyncMode()
  if syncMode ~= 0 then
    worldInfo.network_mode = NetworkMode.Networks
  else
    worldInfo.network_mode = NetworkMode.StandAlone
  end
  worldInfo.syncMode = syncMode
  worldInfo.wordBuffIds = self:GetWordBuffIds()
  worldInfo.level_is_pass = self:LevelIsPass()
  worldInfo.assign_wave_refresh_probability = self:GetAssignRefreshProb()
  worldInfo.server_auto_fight = self:GetServerAutoFight()
  worldInfo.enable_aurora_time = self:IsEnableAuroraTime()
  worldInfo.hasBonusCondition = self:HasBonusConditionArray()
  worldInfo.matchType = self:GetMatchType()
  worldInfo.subMatchType = self:GetSubMatchType()
  worldInfo.linkLineType = self:GetLinkLineType()
  worldInfo.guideInfo = self._guideInfo
  worldInfo.clientCreateInfo = self._client_create_info
  worldInfo:InitializeBonusCondition(self._client_create_info)
  self:InitCreateContextByMatchType(worldInfo)
  if type == MainWorldCreationContextType.Server then
    worldInfo.network_mode = NetworkMode.Networks
  end
  local localMatchPets, remoteMatchPets = worldInfo:InitializePetsData()
  
  function self._func_get_local_match_pets()
    return localMatchPets, worldInfo.localPlayerInfo.pet_list
  end
  
  function self._func_get_remote_match_pets()
    return remoteMatchPets, worldInfo.remoteTeamInfo
  end
  
  worldInfo.m_nHelpPetKey = self.m_nHelpPetKey
  worldInfo.tale_pet_buffs = self:GetTalePetBuffs()
  worldInfo.normal_pet_buffs = self:GetNormalPetBuffs()
  worldInfo.affixList = self:GetAffixList()
  worldInfo.double_resource_state = self:GetDoubleResourceState()
  worldInfo.hardID = self:GetHardID()
  worldInfo.asset_double_item_count = self:GetAssetDoubleItemCount()
  worldInfo.boardSeed = self:GetBoardSeed()
  worldInfo.waveIDList = self:GetWaveIDList()
  worldInfo.boardIDList = self:GetBoardIDList()
  if 0 < self.m_nHelpPetKey then
    for _, matchPet in pairs(localMatchPets) do
      if matchPet:GetTeamSlot() == BattleConst.E_HelpPet_EnableHelpSlotIndex then
        worldInfo.localHelpPetPstID = matchPet:GetPstID()
        break
      end
    end
  end
  worldInfo.enlightenInfoDic = self:ParseEnlightenInfo()
  return worldInfo
end

function MatchEnterData:GetLinkLineType()
  return self._linkLineType
end

function MatchEnterData:SetBlackFistData(worldInfo, remoteTeamInfo)
  worldInfo.remoteTeamInfo = remoteTeamInfo
  for _, matchPetInfo in ipairs(worldInfo.remoteTeamInfo) do
    matchPetInfo.pet_power = -1
  end
end

function MatchEnterData:SetPopStarData(worldInfo, missionID)
  worldInfo.missionID = missionID
end

function MatchEnterData:InitCreateContextByMatchType(worldInfo)
  if worldInfo.matchType == MatchType.MT_Mission then
    worldInfo.missionID = self:GetMissionCreateInfo().mission_id
  elseif worldInfo.matchType == MatchType.MT_ExtMission then
    worldInfo.ext_mission_task_id = self:GetMissionCreateInfo().m_nExtTaskID
  elseif worldInfo.matchType == MatchType.MT_Maze then
    worldInfo.mazeCreateInfo = self:GetMazeCreateInfo()
  elseif worldInfo.matchType == MatchType.MT_BlackFist then
    self:SetBlackFistData(worldInfo, self:GetBlackFistInfo().black_team_info)
  elseif worldInfo.matchType == MatchType.MT_PopStar or worldInfo.matchType == MatchType.MT_PopStarPro then
    self:SetPopStarData(worldInfo, self:GetMissionCreateInfo().mission_id)
  elseif worldInfo.matchType == MatchType.MT_Campaign then
    if worldInfo.subMatchType == MatchType.MT_BlackFist then
      self:SetBlackFistData(worldInfo, self:GetCampaignMissionInfo().mBlackTeamInfo)
    elseif worldInfo.subMatchType == MatchType.MT_PopStarPro then
      self:SetPopStarData(worldInfo, self:GetCampaignMissionInfo().nCampaignMissionId)
    end
  elseif worldInfo.matchType == MatchType.MT_SeasonMaze then
    worldInfo.mazeCreateInfo = self:GetSeasonMazeMissionInfo()
  end
end
