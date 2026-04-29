require("main_state_sys")
_class("PopStarBattleEnterSystem", MainStateSystem)
PopStarBattleEnterSystem = PopStarBattleEnterSystem

function PopStarBattleEnterSystem:_GetMainStateID()
  return GameStateID.PopStarBattleEnter
end

function PopStarBattleEnterSystem:_OnMainStateEnter(TT)
  local teamEntity = self._world:Player():GetCurrentTeamEntity()
  self:_DoLogicInitBattleState()
  self:_DoRenderShowBattleEnter(TT, teamEntity)
  local type, dir = self:_DoLogicGetPieceRefreshType()
  self:_DoRenderShowBoard(TT, type, dir)
  self:_DoLogicAssembleFeature()
  self:_DoRenderAssembleFeature(TT)
  self:_DoLogicSwitchMainFsmState()
end

function PopStarBattleEnterSystem:_DoLogicInitBattleState()
  local configSvc = self._world:GetService("Config")
  local star3CalcSvc = self._world:GetService("Star3Calc")
  local battleStatCmpt = self._world:BattleStat()
  local levelConfigData = configSvc:GetLevelConfigData()
  local roundCount = levelConfigData:GetLevelRoundCount()
  battleStatCmpt:InitLevelRound(roundCount)
  battleStatCmpt:SetTotalWaveCount(levelConfigData:GetWaveCount())
  local threeStarConditions = configSvc:GetPopStar3StarCondition(self._world.BW_WorldInfo.missionID)
  for _, conditionID in ipairs(threeStarConditions) do
    local ret = star3CalcSvc:BeZeroProgress(conditionID)
    battleStatCmpt:UpdateA3StarProgress(conditionID, ret)
  end
  battleStatCmpt._matchResult = {}
end

function PopStarBattleEnterSystem:_DoLogicGetPieceRefreshType()
  local affixSvc = self._world:GetService("Affix")
  return affixSvc:ReplacePieceRefreshType()
end

function PopStarBattleEnterSystem:_DoLogicAssembleFeature()
  local featureLogicSvc = self._world:GetService("FeatureLogic")
  if featureLogicSvc and featureLogicSvc:CanEnableFeature() then
    featureLogicSvc:DoInitFeatureList()
  end
end

function PopStarBattleEnterSystem:_DoLogicSwitchMainFsmState()
  self._world:EventDispatcher():Dispatch(GameEventType.PopStarBattleEnterFinish, 1)
end

function PopStarBattleEnterSystem:_DoRenderShowBattleEnter(TT, teamEntity)
end

function PopStarBattleEnterSystem:_DoRenderShowBoard(TT)
end

function PopStarBattleEnterSystem:_DoRenderAssembleFeature(TT)
end
