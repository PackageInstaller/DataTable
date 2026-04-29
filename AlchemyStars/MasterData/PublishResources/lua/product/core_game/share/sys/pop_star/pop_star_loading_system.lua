_class("PopStarLoadingSystem", MainStateSystem)
PopStarLoadingSystem = PopStarLoadingSystem

function PopStarLoadingSystem:_GetMainStateID()
  return GameStateID.PopStarLoading
end

function PopStarLoadingSystem:Filter(world)
  return true
end

function PopStarLoadingSystem:_OnMainStateEnter(TT)
  self:_DoCreateNetworkEntity()
  self:_DoCreateLogicBoard()
  self:_DoParseAffixData()
  self:_DoParseTrapRefreshData()
  self:_DoParsePropRefreshData()
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

function PopStarLoadingSystem:_DoCreateNetworkEntity()
  local entityService = self._world:GetService("LogicEntity")
  entityService:CreateNetworkEntity()
end

function PopStarLoadingSystem:_DoCreateLogicBoard()
  local entityService = self._world:GetService("LogicEntity")
  entityService:CreateBoardEntity()
end

function PopStarLoadingSystem:_DoParseAffixData()
  local affixService = self._world:GetService("Affix")
  local words = self._world.BW_WorldInfo.wordBuffIds
  if words then
    for _, wordID in ipairs(words) do
      local cfg = Cfg.cfg_word_buff[wordID]
      if cfg.affixList then
        table.appendArray(self._world._affixList, cfg.affixList)
      end
    end
    affixService:ParseAffixData(self._world._affixList)
  end
end

function PopStarLoadingSystem:_DoParseTrapRefreshData()
  local popStarSvc = self._world:GetService("PopStarLogic")
  local missionID = self._world.BW_WorldInfo.missionID
  local cfgMission = Cfg.cfg_popstar_mission[missionID]
  popStarSvc:DoParseTrapRefreshData(cfgMission.TrapRefreshID)
end

function PopStarLoadingSystem:_DoParsePropRefreshData()
  local popStarSvc = self._world:GetService("PopStarLogic")
  local missionID = self._world.BW_WorldInfo.missionID
  local cfgMission = Cfg.cfg_popstar_mission[missionID]
  popStarSvc:DoParsePropRefreshData(cfgMission.PropRefreshIDList)
end

function PopStarLoadingSystem:_DoLogicPreLoadPetSkillConfig()
  local configService = self._world:GetService("Config")
  local joinedPlayerInfo = self._world.BW_WorldInfo.localPlayerInfo
  for _, petInfo in ipairs(joinedPlayerInfo.pet_list) do
    local petPstID = petInfo.pet_pstid
    local petData = self._world:GetPetData(petPstID)
    local activeSkillID = petData:GetPetActiveSkill()
    if activeSkillID then
      configService:GetSkillConfigData(activeSkillID)
    end
  end
end

function PopStarLoadingSystem:_DoLogicLoading()
  local entityService = self._world:GetService("LogicEntity")
  entityService:GenerateBoardData()
  entityService:CreateBattleTeamLogic()
  local eTraps = {}
  local waveNum = 1
  eTraps = entityService:CreateWaveTraps(waveNum)
  self._world:BattleStat():SetFirstWaveTrapIDList(eTraps)
end

function PopStarLoadingSystem:_DoLogicCalcAndNotifyLoadingResult()
  local svc = self._world:GetService("L2R")
  svc:L2RLoadingData()
end

function PopStarLoadingSystem:_DoLogicMatchStart()
  local svc = self._world:GetService("L2R")
  svc:L2RBoardLogicData()
  self._world:EventDispatcher():Dispatch(GameEventType.PopStarLoadingFinish, 1)
end

function PopStarLoadingSystem:_DoRenderCreateRenderBoard()
end

function PopStarLoadingSystem:_DoRenderLoading(TT)
end

function PopStarLoadingSystem:_DoRenderMatchStart(TT)
end

function PopStarLoadingSystem:_DoRenderPreloadCfg()
end
