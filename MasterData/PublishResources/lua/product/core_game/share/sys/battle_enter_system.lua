require("main_state_sys")
_class("BattleEnterSystem", MainStateSystem)
BattleEnterSystem = BattleEnterSystem

function BattleEnterSystem:_GetMainStateID()
  return GameStateID.BattleEnter
end

function BattleEnterSystem:_OnMainStateEnter(TT)
  local teamEntity = self._world:Player():GetCurrentTeamEntity()
  self:_DoLogicInitBattleState()
  self:_DoRenderShowBattleEnter(TT, teamEntity)
  local type, dir = self:_DoLogicGetPieceRefreshType()
  self:_DoRenderShowBoard(TT, type, dir)
  self:_DoLogicAssembleFeature()
  self:_DoRenderAssembleFeature(TT)
  self:_DoCreateIntensifyBuffMap()
  self:_DoLogicSetPetIntensifyBuff()
  self:_DoLogicSetEquipRefineBuff()
  self:_DoLogicCreateEquipRefineIntensifyBuffMap()
  self:_DoLogicInitAutoBead()
  self:_DoRenderInitAutoBead(TT)
  self:_DoLogicInitRelic()
  self:_DoLogicSetPetPassiveSkill()
  self:_DoLogicNotifyPetCreate(teamEntity)
  self:_DoRenderShowPet(TT, teamEntity)
  self:_DoLogicSwitchMainFsmState()
end

function BattleEnterSystem:_DoLogicInitBattleState()
  local configService = self._world:GetService("Config")
  local battleStatCmpt = self._world:BattleStat()
  local levelConfigData = configService:GetLevelConfigData()
  local turnCount = levelConfigData:GetLevelRoundCount()
  if self._world:MatchType() == MatchType.MT_Maze then
    local mazeService = self._world:GetService("Maze")
    turnCount = mazeService:GetLightCount()
  elseif self._world:MatchType(GetMatchTypeType.SeasonMazeWorldBoss) == MatchType.MT_SeasonMaze then
    local seasonMazeService = self._world:GetService("SeasonMaze")
    turnCount = seasonMazeService:GetRoundCount()
  end
  battleStatCmpt:InitLevelRound(turnCount)
  battleStatCmpt:SetTotalWaveCount(levelConfigData:GetWaveCount())
  if self._world:MatchType() == MatchType.MT_Mission or self._world:MatchType() == MatchType.MT_Campaign then
    local threeStarConditions = {}
    if self._world:MatchType() == MatchType.MT_Mission then
      threeStarConditions = configService:GetMission3StarCondition(self._world.BW_WorldInfo.missionID)
    elseif self._world:MatchType() == MatchType.MT_Campaign then
      threeStarConditions = configService:GetCampaignMission3StarCondition(self._world.BW_WorldInfo.missionID)
    end
    local star3CalcService = self._world:GetService("Star3Calc")
    for _, conditionId in ipairs(threeStarConditions) do
      local ret = star3CalcService:BeZeroProgress(conditionId)
      battleStatCmpt:UpdateA3StarProgress(conditionId, ret)
    end
  elseif self._world:MatchType() == MatchType.MT_ExtMission then
    local threeStarConditions = configService:GetExtMission3StarCondition(self._world.BW_WorldInfo.ext_mission_task_id)
    local star3CalcService = self._world:GetService("Star3Calc")
    for _, conditionId in ipairs(threeStarConditions) do
      local ret = star3CalcService:CalcProgress(conditionId)
      battleStatCmpt:UpdateA3StarProgress(conditionId, ret)
    end
  elseif self._world:MatchType() == MatchType.MT_Season then
    local threeStarConditions = configService:GetSeasonMission3StarCondition(self._world.BW_WorldInfo.missionID)
    local star3CalcService = self._world:GetService("Star3Calc")
    for _, conditionId in ipairs(threeStarConditions) do
      local ret = star3CalcService:CalcProgress(conditionId)
      battleStatCmpt:UpdateA3StarProgress(conditionId, ret)
    end
  end
  battleStatCmpt._matchResult = {}
end

function BattleEnterSystem:_DoLogicSwitchMainFsmState()
  self._world:EventDispatcher():Dispatch(GameEventType.BattleEnterFinish, 1)
end

function BattleEnterSystem:_DoCreateIntensifyBuffMap()
  local petGroup = self._world:GetGroup(self._world.BW_WEMatchers.PetPstID)
  local pets = petGroup:GetEntities()
  local battleStatCmpt = self._world:BattleStat()
  for _, petEntity in ipairs(pets) do
    local equipIntensifyParams = petEntity:SkillInfo():GetEquipIntensifyParam()
    if equipIntensifyParams then
      battleStatCmpt:AddBuffIntensifyParam(equipIntensifyParams)
    end
  end
end

function BattleEnterSystem:_DoLogicSetPetPassiveSkill()
  local buffLogicService = self._world:GetService("BuffLogic")
  local teamEntities = self._world:Player():GetAllTeamEntities()
  for _, teamEntity in ipairs(teamEntities) do
    buffLogicService:BuildPetPassiveSkill(teamEntity)
  end
end

function BattleEnterSystem:_DoLogicSetPetIntensifyBuff()
  local teamEntities = self._world:Player():GetAllTeamEntities()
  local buffLogicService = self._world:GetService("BuffLogic")
  for _, teamEntity in ipairs(teamEntities) do
    buffLogicService:BuildPetIntensifyBuff(teamEntity)
  end
end

function BattleEnterSystem:_DoLogicGetPieceRefreshType()
  local affixSvc = self._world:GetService("Affix")
  return affixSvc:ReplacePieceRefreshType()
end

function BattleEnterSystem:_DoLogicAssembleFeature()
  local featureLogicSvc = self._world:GetService("FeatureLogic")
  if featureLogicSvc and featureLogicSvc:CanEnableFeature() then
    featureLogicSvc:DoInitFeatureList()
  end
end

function BattleEnterSystem:_DoLogicCreateEquipRefineIntensifyBuffMap()
  local petGroup = self._world:GetGroup(self._world.BW_WEMatchers.PetPstID)
  local pets = petGroup:GetEntities()
  local battleStatCmpt = self._world:BattleStat()
  for _, petEntity in ipairs(pets) do
    local equipIntensifyParams = petEntity:EquipRefine():GetEquipRefineIntensifyParam()
    if equipIntensifyParams then
      battleStatCmpt:AddBuffEquipRefineParam(equipIntensifyParams)
    end
  end
end

function BattleEnterSystem:_DoLogicSetEquipRefineBuff()
  local buffLogicService = self._world:GetService("BuffLogic")
  local teamEntities = self._world:Player():GetAllTeamEntities()
  for _, teamEntity in ipairs(teamEntities) do
    buffLogicService:BuildPetEquipRefineBuff(teamEntity)
  end
end

function BattleEnterSystem:_DoLogicSetEquipRefineIntensifyBuff()
end

function BattleEnterSystem:_DoLogicInitAutoBead()
  local autoBeadServiceLogic = self._world:GetService("AutoBeadLogic")
  local teamEntities = self._world:Player():GetAllTeamEntities()
  for _, teamEntity in ipairs(teamEntities) do
    local holderEntity = autoBeadServiceLogic:GetAutoBeadSkillHolder(teamEntity)
    if holderEntity then
      autoBeadServiceLogic:InitAutoBead(teamEntity)
    end
  end
end

function BattleEnterSystem:_DoLogicNotifyPetCreate(teamEntity)
  if not teamEntity then
    Log.warn("no team entity created")
    return
  end
  local teamEntities = teamEntity:Team():GetTeamPetEntities()
  for _, petEntity in ipairs(teamEntities) do
    local elementComponent = petEntity:Element()
    local element = elementComponent:GetPrimaryType()
    local petPstIDComponent = petEntity:PetPstID()
    local campID = petPstIDComponent:GetPetCampID()
    local petData = self._world:GetPetData(petPstIDComponent:GetPstID())
    local petJob = petData:GetJob()
    self._world:GetService("Trigger"):Notify(NTPetCreate:New(element, campID, petEntity, petJob))
  end
end

function BattleEnterSystem:_DoLogicSetPetPassiveSkill()
  local buffLogicService = self._world:GetService("BuffLogic")
  local teamEntities = self._world:Player():GetAllTeamEntities()
  for _, teamEntity in ipairs(teamEntities) do
    buffLogicService:BuildPetPassiveSkill(teamEntity)
  end
end

function BattleEnterSystem:_DoLogicInitRelic()
  if self._world:MatchType(GetMatchTypeType.SeasonMazeWorldBoss) == MatchType.MT_SeasonMaze then
    local seasonMazeSvc = self._world:GetService("SeasonMaze")
    seasonMazeSvc:InitRelics()
  end
end

function BattleEnterSystem:_DoRenderShowBattleEnter(TT, teamEntity)
end

function BattleEnterSystem:_DoRenderShowBoard(TT)
end

function BattleEnterSystem:_DoRenderShowPet(TT, teamEntity)
end

function BattleEnterSystem:_DoRenderAssembleFeature(TT)
end

function BattleEnterSystem:_DoRenderInitAutoBead(TT)
end
