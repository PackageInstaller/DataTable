require("wave_result_system")
_class("ClientWaveResultSystem_Render", WaveResultSystem)
ClientWaveResultSystem_Render = ClientWaveResultSystem_Render

function ClientWaveResultSystem_Render:_DoRenderNotifyWaveEnd(TT, waveNum)
  self._world:GetService("PlayBuff"):PlayBuffView(TT, NTWaveTurnEnd:New(waveNum))
end

function ClientWaveResultSystem_Render:_DoRenderChainAttackDead(TT)
  local sMonsterShowRender = self._world:GetService("MonsterShowRender")
  sMonsterShowRender:DoAllMonsterDeadRender(TT)
end

function ClientWaveResultSystem_Render:_DoRenderHandleTurnBattleResult(TT, victory, hasDeadLogic)
  GameGlobal.UAReportForceGuideEvent("BattleResult", {
    victory and 1 or 0
  }, false, true)
  if victory and hasDeadLogic then
    local sMonsterShowRender = self._world:GetService("MonsterShowRender")
    local monster_group = self._world:GetGroup(self._world.BW_WEMatchers.MonsterID)
    local monster_entities = monster_group:GetEntities()
    for _, v in pairs(monster_entities) do
      v:ReplaceRedHPAndWhitHP(0)
      v:AddDeadFlag()
    end
    sMonsterShowRender:DoAllMonsterDeadRender(TT)
  end
end

function ClientWaveResultSystem_Render:_DoRenderSendWaveEnd(TT, turnToBattleResult, victory)
  local matchMD = GameGlobal.GetModule(MatchModule)
  local waveIndex = BattleStatHelper.GetCurWaveIndex()
  if (self._world._matchType == MatchType.MT_Conquest or self._world._matchType == MatchType.MT_MiniMaze) and BattleStatHelper.GetBattleWaveResult() then
    matchMD:HandleWaveEnd(waveIndex)
  end
end
