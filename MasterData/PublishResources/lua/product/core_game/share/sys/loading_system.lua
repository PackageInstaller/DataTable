_class("LoadingSystem", MainStateSystem)
LoadingSystem = LoadingSystem

function LoadingSystem:_GetMainStateID()
  return GameStateID.Loading
end

function LoadingSystem:Filter(world)
  return true
end

function LoadingSystem:_OnMainStateEnter(TT)
  self:_DoClearCoreGameCfg()
  self:_DoCreateNetworkEntity()
  self:_DoCreateLogicBoard()
  self:_DoParseAffixData()
  self:_DoParseTalentData()
  local configService = self._world:GetService("Config")
  configService:InitConfig()
  self:_DoLogicPreLoadPetSkillConfig()
  self:_DoRenderCreateRenderBoard()
  self:_DoLogicLoading()
  self:_DoLogicCalcAndNotifyLoadingResult()
  local waitTaskIDs = {}
  local clientLoadingTaskID = self:_DoRenderLoading(TT)
  table.insert(waitTaskIDs, clientLoadingTaskID)
  self:_WaitTasksEnd(TT, waitTaskIDs)
  self:_DoRenderMatchStart(TT)
  self:_DoRenderPreloadCfg()
  self:_DoLogicMatchStart()
end

function LoadingSystem:_DoLogicCalcAndNotifyLoadingResult()
  local svc = self._world:GetService("L2R")
  svc:L2RLoadingData()
end

function LoadingSystem:_DoLogicPreLoadPetSkillConfig()
  local joinedPlayerInfo = self._world:BattleWorldEnterData():GetLocalPlayerInfo()
  local configService = self._world:GetService("Config")
  local affixService = self._world:GetService("Affix")
  for petIndex, petInfo in ipairs(joinedPlayerInfo.pet_list) do
    local petPstID = petInfo.pet_pstid
    local petData = self._world:BattleWorldEnterData():GetPetData(petPstID)
    local petId = petData:GetTemplateID()
    local awaking = petData:GetPetAwakening()
    local grade = petData:GetPetGrade()
    local skinId = petData:GetSkinId()
    local normalSkillID = petData:GetNormalSkill()
    if normalSkillID then
      configService:GetSkillConfigData(normalSkillID)
    end
    local chainSkillIDs = petData:GetChainSkillInfo()
    if chainSkillIDs then
      for i = 1, #chainSkillIDs do
        local configData = configService:GetSkillConfigData(chainSkillIDs[i].Skill)
        affixService:ChangePetChainCount(configData)
      end
    end
    local activeSkillID = petData:GetPetActiveSkill()
    if activeSkillID then
      configService:GetSkillConfigData(activeSkillID)
    end
  end
end

function LoadingSystem:_DoLogicLoading()
  local entityService = self._world:GetService("LogicEntity")
  entityService:GenerateBoardData()
  entityService:CreateBattleTeamLogic()
  local battle_archive = self._world:GetService("Maze"):GetBattleArchive()
  local eMonsters = {}
  local eTraps = {}
  if battle_archive and battle_archive.completion.cond ~= CompleteConditionType.AllRefreshMonsterDead then
    eMonsters = entityService:CreateArchivedMonsters(battle_archive.monsters)
    eTraps = entityService:CreateArchivedTraps(battle_archive.traps)
  else
    local waveNum = 1
    eMonsters = entityService:CreateWaveMonsters(waveNum)
    eTraps = entityService:CreateWaveTraps(waveNum)
    local configService = self._world:GetService("Config")
    local levelConfigData = configService:GetLevelConfigData()
    local isMultiBoardLevel = levelConfigData:IsMultiBoardLevel()
    if isMultiBoardLevel then
      local eMonstersOtherBoard = entityService:CreateWaveMonstersMultiBoard(waveNum)
      local eTrapsOtherBoard = entityService:CreateWaveTrapsMultiBoard(waveNum)
      table.appendArray(eMonsters, eMonstersOtherBoard)
      table.appendArray(eTraps, eTrapsOtherBoard)
    end
  end
  self._world:BattleStat():SetFirstWaveMonsterIDList(eMonsters)
  self._world:BattleStat():SetFirstWaveTrapIDList(eTraps)
end

function LoadingSystem:_DoLogicMatchStart()
  local svc = self._world:GetService("L2R")
  svc:L2RBoardLogicData()
  self._world:EventDispatcher():Dispatch(GameEventType.LoadingFinish, 1)
end

function LoadingSystem:_DoRenderMatchStart(TT)
end

function LoadingSystem:_DoRenderLoading(TT)
end

function LoadingSystem:_DoRenderCreateRenderBoard()
end

function LoadingSystem:_DoCreateLogicBoard()
  local entityService = self._world:GetService("LogicEntity")
  entityService:CreateBoardEntity()
end

function LoadingSystem:_DoCreateNetworkEntity()
  local entityService = self._world:GetService("LogicEntity")
  entityService:CreateNetworkEntity()
end

function LoadingSystem:_DoParseAffixData()
  local affixService = self._world:GetService("Affix")
  local words = self._world.BW_WorldInfo.wordBuffIds
  if words then
    for _, wordID in ipairs(words) do
      local cfg = Cfg.cfg_word_buff[wordID]
      if cfg and cfg.affixList then
        table.appendArray(self._world._affixList, cfg.affixList)
      end
    end
    affixService:ParseAffixData(self._world._affixList)
  end
end

function LoadingSystem:_DoParseTalentData()
  if self._world:MatchType() == MatchType.MT_MiniMaze then
    local talentSvc = self._world:GetService("Talent")
    local createInfo = self._world.BW_WorldInfo.clientCreateInfo.bloodsucker_mission_info[1]
    if createInfo then
      talentSvc:ParseTalentData_MiniMaze(createInfo.skill_info, createInfo.relics)
    end
  elseif self._world:MatchType() == MatchType.MT_Campaign then
    local talentSvc = self._world:GetService("Talent")
    local createInfo = self._world.BW_WorldInfo.clientCreateInfo.campaign_mission_info[1]
    if createInfo then
      talentSvc:ParseTalentData_Campaign(createInfo.mTalentTreeSkills)
    end
  end
end

function LoadingSystem:_DoRenderPreloadCfg()
end

function LoadingSystem:_DoClearCoreGameCfg()
  if not EDITOR or not AUTO_RELOAD_GAME_CFG then
    return
  end
  CfgClear("cfg_core_game_reload")
  for i, v in pairs(Cfg.cfg_core_game_reload()) do
    CfgClear(v.CfgName)
  end
end
