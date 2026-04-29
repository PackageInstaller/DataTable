require("base_world_creation_context")
require("components_lookup")
_class("MainWorldCreationContext", BaseWorldCreationContext)
MainWorldCreationContext = MainWorldCreationContext

function MainWorldCreationContext:Constructor()
  self.WCC_StartCreationIndex = 1
  self.WCC_EntityCreationProto = Entity
  local wEComponents = ComponentsLookup:New({})
  local wUniqueComponents = ComponentsLookup:New({})
  local wEMatchers = {}
  MatchPackInstaller:InstallEntityComponentsLookup(wEComponents)
  MatchPackInstaller:InstallUniqueComponentsLookup(wUniqueComponents)
  self._sharedComponentStartIndex = wEComponents.SharedStartIndex
  self._logicComponentStartIndex = wEComponents.LogicStartIndex
  self._renderComponentStartIndex = wEComponents.RenderStartIndex
  self._logicCmptUniqueStartIndex = wUniqueComponents.LogicUniqueStartIndex
  self._renderCmptUniqueStartIndex = wUniqueComponents.RenderUniqueStartIndex
  self._sharedCmptUniqueStartIndex = wUniqueComponents.SharedUniqueStartIndex
  BasePackInstaller:InstallEntityMatchers(wEMatchers, wEComponents)
  CombatPackInstaller:InstallEntityMatchers(wEMatchers, wEComponents)
  MatchPackInstaller:InstallEntityMatchers(wEMatchers, wEComponents)
  self.BWCC_EComponentsEnum = wEComponents
  self.BWCC_WUniqueComponentsEnum = wUniqueComponents
  self.BWCC_EMatchers = wEMatchers
  self.network_mode = NetworkMode.StandAlone
  self.level_id = 0
  self.game_mode = 0
  self.world_seed = 0
  self.local_player_id = 1
  self.localPlayerInfo = nil
  self.server_auto_fight = false
  self.enable_aurora_time = false
  self.totalComponents = wEComponents.TotalComponents
  self.matchType = MatchType.MT_Mission
  self.subMatchType = self.matchType
  self.missionID = -1
  self.ext_mission_task_id = -1
  self.clientCreateInfo = nil
  self.wordBuffIds = nil
  self.level_is_pass = false
  self.assign_wave_refresh_probability = 0
  self.players = {}
  self.localMatchPets = {}
  self.localMatchPetDict = {}
  self.guideInfo = nil
  self.syncMode = 0
  self.m_nHelpPetKey = nil
  self.tale_pet_buffs = nil
  self.normal_pet_buffs = nil
  self.double_resource_state = false
  self.asset_double_item_count = 0
  self.affixList = {}
  self.hardID = nil
  self.boardSeed = 0
  self.waveIDList = {}
  self.boardIDList = {}
  self.remoteTeamInfo = nil
  self.remotePlayerPos = Vector2(5, 5)
  self.remoteMatchPets = {}
  self.remoteMatchPetDict = {}
  self._enlightenInfoDic = {}
  self.linkLineType = ELinkLineType.ELLT_LINE_Common
end

function MainWorldCreationContext:InitializePetsData()
  local petList = self.localPlayerInfo.pet_list
  for k, v in ipairs(petList) do
    local petData
    if self.matchType == MatchType.MT_PopStar then
      petData = PopStarMatchPet:New(v)
    else
      petData = MatchPet:New(v)
    end
    self.localMatchPets[#self.localMatchPets + 1] = petData
    self.localMatchPetDict[v.pet_pstid] = petData
  end
  if self.remoteTeamInfo then
    petList = self.remoteTeamInfo
    for k, v in ipairs(petList) do
      local petInfo = v
      petInfo.pet_pstid = k
      local petData = MatchPet:New(petInfo)
      self.remoteMatchPets[#self.remoteMatchPets + 1] = petData
      self.remoteMatchPetDict[petInfo.pet_pstid] = petData
    end
  end
  self.TeamLeaderPetPstID = -1
  return self.localMatchPetDict, self.remoteMatchPetDict
end

function MainWorldCreationContext:InitializeBonusCondition(clientCreateInfo)
  self.clientCreateInfo = clientCreateInfo
  self.bonusCondition = self:_CalcBonusConditionArray()
  if #self.bonusCondition > 1 then
    self.hasBonusCondition = true
  end
end

function MainWorldCreationContext:_CalcBonusConditionArray()
  local bonusConditionArray = {}
  if self.matchType == MatchType.MT_Mission then
    local missionInfo = self.clientCreateInfo.mission_info[1]
    local missionData = Cfg.cfg_mission[missionInfo.mission_id]
    local conditionID = missionData.ThreeStarCondition1
    bonusConditionArray[#bonusConditionArray + 1] = conditionID
    conditionID = missionData.ThreeStarCondition2
    bonusConditionArray[#bonusConditionArray + 1] = conditionID
    conditionID = missionData.ThreeStarCondition3
    bonusConditionArray[#bonusConditionArray + 1] = conditionID
  elseif self.matchType == MatchType.MT_Campaign then
    local missionInfo = self.clientCreateInfo.campaign_mission_info[1]
    local missionData = Cfg.cfg_campaign_mission[missionInfo.nCampaignMissionId]
    if missionData and missionData.IgnoreThreeStar == 0 then
      local conditionID = missionData.ThreeStarCondition1
      bonusConditionArray[#bonusConditionArray + 1] = conditionID
      conditionID = missionData.ThreeStarCondition2
      bonusConditionArray[#bonusConditionArray + 1] = conditionID
      conditionID = missionData.ThreeStarCondition3
      bonusConditionArray[#bonusConditionArray + 1] = conditionID
    end
  elseif MatchType.MT_ExtMission == self.matchType then
    local extMissionInfo = self.clientCreateInfo.m_extMissionInfo[1]
    local extTaskData = Cfg.cfg_extra_mission_task[extMissionInfo.m_nExtTaskID]
    local conditionID = 0
    conditionID = extTaskData.ThreeStarCondition1
    bonusConditionArray[#bonusConditionArray + 1] = conditionID
    conditionID = extTaskData.ThreeStarCondition2
    bonusConditionArray[#bonusConditionArray + 1] = conditionID
    conditionID = extTaskData.ThreeStarCondition3
    bonusConditionArray[#bonusConditionArray + 1] = conditionID
  elseif MatchType.MT_ResDungeon == self.matchType then
    local info = self.clientCreateInfo.resdungeon_info[1]
    local cfg = Cfg.cfg_res_instance_detail[info.res_dungeon_id]
    local conditionID = 0
    conditionID = cfg.ThreeStarCondition1
    bonusConditionArray[#bonusConditionArray + 1] = conditionID
    conditionID = cfg.ThreeStarCondition2
    bonusConditionArray[#bonusConditionArray + 1] = conditionID
    conditionID = cfg.ThreeStarCondition3
    bonusConditionArray[#bonusConditionArray + 1] = conditionID
  elseif self.matchType == MatchType.MT_Chess then
    local info = self.clientCreateInfo.chess_mission_info[1]
    local cfg = Cfg.cfg_chess_mission[info.mission_id]
    local conditionID = 0
    conditionID = cfg.ThreeStarCondition1
    bonusConditionArray[#bonusConditionArray + 1] = conditionID
    conditionID = cfg.ThreeStarCondition2
    bonusConditionArray[#bonusConditionArray + 1] = conditionID
    conditionID = cfg.ThreeStarCondition3
    bonusConditionArray[#bonusConditionArray + 1] = conditionID
  elseif self.matchType == MatchType.MT_PopStar then
    local missionInfo = self.clientCreateInfo.popstar_mission_info[1]
    local missionData = Cfg.cfg_popstar_mission[missionInfo.mission_id]
    if missionData and missionData.IgnoreThreeStar == 0 then
      local conditionID = missionData.ThreeStarCondition1
      bonusConditionArray[#bonusConditionArray + 1] = conditionID
      conditionID = missionData.ThreeStarCondition2
      bonusConditionArray[#bonusConditionArray + 1] = conditionID
      conditionID = missionData.ThreeStarCondition3
      bonusConditionArray[#bonusConditionArray + 1] = conditionID
    end
  elseif self.matchType == MatchType.MT_Season then
    local info = self.clientCreateInfo.season_mission_info[1]
    local cfg = Cfg.cfg_season_mission[info.mission_id]
    local conditionID = 0
    conditionID = cfg.ThreeStarCondition1
    bonusConditionArray[#bonusConditionArray + 1] = conditionID
    conditionID = cfg.ThreeStarCondition2
    bonusConditionArray[#bonusConditionArray + 1] = conditionID
    conditionID = cfg.ThreeStarCondition3
    bonusConditionArray[#bonusConditionArray + 1] = conditionID
  elseif self.matchType == MatchType.MT_PopStarPro then
  end
  return bonusConditionArray
end

function MainWorldCreationContext:GetLocalMatchPetList()
  return self.localMatchPets
end

function MainWorldCreationContext:GetRemoteMatchPetList()
  return self.remoteMatchPets
end

function MainWorldCreationContext:GetRemotePlayerPosition()
  return self.remotePlayerPos
end

function MainWorldCreationContext:GetPetData(pstid)
  return self.localMatchPetDict[pstid] or self.remoteMatchPetDict[pstid]
end

function MainWorldCreationContext:GetPlayerPstID()
  return self.localPlayerInfo.pstid
end

function MainWorldCreationContext:GetPlayerLevel()
  return self.localPlayerInfo.nLevel
end

function MainWorldCreationContext:AvailableInRender(index)
  return index >= self._sharedComponentStartIndex
end

function MainWorldCreationContext:UniqueCmptAvailableInRender(index)
  return index >= self._sharedCmptUniqueStartIndex
end

function MainWorldCreationContext:GetConquestCreateInfo()
  return self.clientCreateInfo.conquest_mission_info[1]
end

function MainWorldCreationContext:GetSimpleConquestCreateInfo()
  return self.clientCreateInfo.simple_conquest_mission_info[1]
end

function MainWorldCreationContext:GetLocalHelpPetPstID()
  return self.localHelpPetPstID
end

function MainWorldCreationContext:GetPopStarProCreateInfo()
  return self.clientCreateInfo.anipop_mission_info[1]
end

function MainWorldCreationContext:GetSeasonMazeCreateInfo()
  return self.clientCreateInfo.season_maze_mission_info[1]
end

WorldRunPostion = {
  AtServer = 1,
  AtClient = 2,
  Cutscene = 3,
  Performance = 4
}
_enum("WorldRunPostion", WorldRunPostion)
_class("PlayerCreationContext", Object)
PlayerCreationContext = PlayerCreationContext

function PlayerCreationContext:Constructor()
  self.player_id = 0
  self.player_runtime_data = nil
  self.character_context = nil
  self.pet_contexts = {}
end

function PlayerCreationContext:Destructor()
  self.character_context = nil
  self.player_runtime_data = nil
  self.pet_contexts = nil
end

_class("EntityCreationContext", Object)
EntityCreationContext = EntityCreationContext

function EntityCreationContext:Constructor()
  self.entity_config_id = 0
  self.bShow = true
  self.entity_config = nil
  self.entity_runtime_data = nil
end
