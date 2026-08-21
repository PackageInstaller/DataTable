local PlayerDefeatType = {
  None = 0,
  ZeroHp = 1,
  ProtectedTrapDead = 2,
  CurseTowerAllActive = 3,
  ChessAllDead = 4,
  MonsterEscapeTooMuch = 5,
  PopStarNumberNotEnough = 6
}
_enum("PlayerDefeatType", PlayerDefeatType)
_class("BattleResultSystem", MainStateSystem)
BattleResultSystem = BattleResultSystem

function BattleResultSystem:_GetMainStateID()
  return GameStateID.BattleResult
end

function BattleResultSystem:_OnMainStateEnter(TT)
  local victory, defeatType = self:_DoLogicBeforeExit()
  self:_DoRenderShowExit(TT, victory, defeatType)
  self:_DoLogicAfterExit()
  self:_DoLogicBattleResult()
end

function BattleResultSystem:_DoLogicBattleResult()
end

function BattleResultSystem:_DoLogicBeforeExit()
  local battleStatCmpt = self._world:BattleStat()
  local victory = battleStatCmpt:GetBattleLevelResult() and 1 or 0
  local defeatType = self:_DoLogicCalcDefeatType()
  self._world:GetService("Trigger"):Notify(NTGameOver:New(victory, defeatType))
  local svc = self._world:GetService("AutoTest")
  if svc then
    svc:SetGameOver_Test()
  end
  return victory, defeatType
end

function BattleResultSystem:_DoLogicCalcDefeatType()
  if self:IsPlayerDead() then
    return PlayerDefeatType.ZeroHp
  end
  local protectedTrapDead = self:IsProtectedTrapDead()
  if protectedTrapDead then
    return PlayerDefeatType.ProtectedTrapDead
  end
  local curseTowerAllActive = self:IsCurseTowerAllActive()
  if curseTowerAllActive then
    return PlayerDefeatType.CurseTowerAllActive
  end
  local allChessDead = self:IsChessCalculation()
  if allChessDead then
    return PlayerDefeatType.ChessAllDead
  end
  local monsterEscapeTooMuch = self:IsMonsterEscapeTooMuch()
  if monsterEscapeTooMuch then
    return PlayerDefeatType.MonsterEscapeTooMuch
  end
  return PlayerDefeatType.None
end

function BattleResultSystem:_DoRenderShowExit(TT, victory, defeatType)
end

function BattleResultSystem:_DoLogicAfterExit()
  local battleStatCmpt = self._world:BattleStat()
  if self._world.BW_WorldInfo.hasBonusCondition then
    local bonusCalcSvc = self._world:GetService("BonusCalc")
    bonusCalcSvc:CalcBonusObjective()
  end
  local matchType = self._world:MatchType(GetMatchTypeType.CalcBattleResult)
  self.battleMatchResult = self:_CalcBattleResult(matchType, battleStatCmpt)
  if GameSingle then
    local msg = CEventPushMatchEnd:New()
    msg.match_type = matchType
    msg.m_result = self.battleMatchResult
    local gameMatchModule = GameGlobal.GetModule(GameMatchModule)
    gameMatchModule:HandleCEventPushMatchEnd(msg)
  end
  self._world:GetDataLogger():AddDataLog("OnShowEnd")
  self._world:GetDataLogger():AddDataLog("OnBattleEnd")
end

function BattleResultSystem:_CalcBattleResult(matchType, battleStatCmpt)
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

function BattleResultSystem:_CalcLeftBlood(battleStatCmpt)
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
