require("battle_result_system")
_class("PopStarBattleResultSystem", MainStateSystem)
PopStarBattleResultSystem = PopStarBattleResultSystem

function PopStarBattleResultSystem:_GetMainStateID()
  return GameStateID.PopStarBattleResult
end

function PopStarBattleResultSystem:_OnMainStateEnter(TT)
  local victory, defeatType = self:_DoLogicBeforeExit()
  self:_DoRenderShowExit(TT, victory, defeatType)
  self:_DoLogicAfterExit()
  self:_DoLogicBattleResult()
  self:_DoRenderBattleResult()
end

function PopStarBattleResultSystem:_DoLogicBeforeExit()
  local battleStatCmpt = self._world:BattleStat()
  local victory = battleStatCmpt:GetBattleLevelResult() and 1 or 0
  local defeatType = self:_DoCalculateDefeatType()
  self._world:GetService("Trigger"):Notify(NTGameOver:New(victory, defeatType))
  local svc = self._world:GetService("AutoTest")
  if svc then
    svc:SetGameOver_Test()
  end
  return victory, defeatType
end

function PopStarBattleResultSystem:_DoCalculateDefeatType()
  local battleService = self._world:GetService("Battle")
  local popStarNumNotEnough = battleService:HandlePopStarNumber()
  if popStarNumNotEnough then
    return PlayerDefeatType.PopStarNumberNotEnough
  end
  return PlayerDefeatType.None
end

function PopStarBattleResultSystem:_DoLogicAfterExit()
  if self._world:BattleWorldEnterData():IsHaveBonusCondition() then
    local bonusCalcSvc = self._world:GetService("BonusCalc")
    bonusCalcSvc:CalcBonusObjective()
  end
  local battleStatCmpt = self._world:BattleStat()
  local matchType = self._world:MatchType()
  self.battleMatchResult = self:_CalcBattleResult(matchType, battleStatCmpt)
  self._world:GetDataLogger():AddDataLog("OnShowEnd")
  self._world:GetDataLogger():AddDataLog("OnBattleEnd")
end

function PopStarBattleResultSystem:_CalcBattleResult(matchType, battleStatCmpt)
  local battleService = self._world:GetService("Battle")
  local result = battleService:CalcBattleResultLogic(matchType, battleStatCmpt:GetBattleLevelResult())
  result.battle_statistics.ActiveSkill = battleStatCmpt:GetActiveSkillCount()
  result.battle_statistics.Blood = self:_CalcLeftBlood(battleStatCmpt)
  result.battle_statistics.ChainSkill = battleStatCmpt:GetChainSkillCount()
  result.battle_statistics.ColorSkill = battleStatCmpt:GetColorSkillCount()
  result.battle_statistics.KillBoss = battleStatCmpt:GetKillBossCount()
  result.battle_statistics.KillMonster = battleStatCmpt:GetKillMonsterCount()
  result.battle_statistics.LeftTurn = battleStatCmpt:GetLevelLeftRoundCount()
  result.battle_statistics.MaxChain = battleStatCmpt:GetOneMatchMaxNum()
  result.battle_statistics.OneActiveSkillKill = battleStatCmpt:GetOneActiveSkillKillCount()
  result.battle_statistics.OneChainKillMonster = battleStatCmpt:GetOneChainKillCount()
  result.battle_statistics.OneChainNormalAttack = battleStatCmpt:GetOneChainNormalAttackCount()
  result.battle_statistics.SuperChain = battleStatCmpt:GetAuroraTimeCount()
  result.battle_statistics.UseTurn = battleStatCmpt:GetLevelTotalRoundCount() - 1
  result.battle_statistics.AutoFight = battleStatCmpt:GetEverAutoFight()
  result.battle_statistics.changeTeamLeaderNum = battleStatCmpt:GetTeamLeaderChangeNum()
  result.battle_statistics.passivechangeLeaderNum = battleStatCmpt:GetPassiveTeamLeaderChangeNum()
  result.battle_statistics.line_time = battleStatCmpt:GetTotalChainNum()
  result.battle_statistics.step_num = battleStatCmpt:GetTotalMatchNum()
  result.battle_statistics.MazeAddLight = battleStatCmpt:GetMazeAddLight()
  result.battle_statistics.EraseSquare = battleStatCmpt:GetElementMatchNum()
  local renderBattleStat = self._world:RenderBattleStat()
  if renderBattleStat then
    result.battle_statistics.DoubleSpeed = renderBattleStat:GetEverSpeed()
  end
  return result
end

function PopStarBattleResultSystem:_CalcLeftBlood(battleStatCmpt)
  local hpPercent = battleStatCmpt:GetLeftBlood()
  if hpPercent <= 0 then
    hpPercent = 0
  elseif hpPercent <= 0.01 then
    hpPercent = 1
  else
    hpPercent = math.floor(hpPercent * 100 + 0.5)
  end
  hpPercent = hpPercent / 100
  return hpPercent
end

function PopStarBattleResultSystem:_DoLogicBattleResult()
end

function PopStarBattleResultSystem:_DoRenderShowExit(TT, victory, defeatType)
end

function PopStarBattleResultSystem:_DoRenderBattleResult()
end
