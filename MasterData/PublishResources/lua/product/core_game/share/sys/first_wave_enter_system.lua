require("main_state_sys")
_class("FirstWaveEnterSystem", MainStateSystem)
FirstWaveEnterSystem = FirstWaveEnterSystem

function FirstWaveEnterSystem:_GetMainStateID()
  return GameStateID.FirstWaveEnter
end

function FirstWaveEnterSystem:_OnMainStateEnter(TT)
  local teamEntity = self._world:Player():GetCurrentTeamEntity()
  self:_DoRenderShowUIBattleStart(TT, teamEntity)
  local buffseqs = self:_DoLogicGameStart()
  self:_DoRenderAutoAddBuff(TT, buffseqs)
  self:_DoLogicMonsterDead()
  self:_DoRenderMonsterDead(TT)
  self:_DoRendeDestroyBattleEnterResource(TT)
  self:_DologicGotoNextState()
end

function FirstWaveEnterSystem:_DoLogicGameStart()
  if not self._isGameStart then
    self._isGameStart = true
    local GameStartBuffs = {}
    self._world:GetService("Battle"):InitWordBuff(GameStartBuffs)
    self._world:GetService("Battle"):InitTalePetBuff(GameStartBuffs)
    self._world:GetService("Affix"):InitAffixBuff(GameStartBuffs)
    self._world:GetService("Talent"):InitTalentBuff(GameStartBuffs)
    self._world:GetService("AutoBeadLogic"):InitAutoBeadBuff(GameStartBuffs)
    self._world:GetService("Trigger"):Notify(NTGameStart:New())
    return GameStartBuffs
  end
end

function FirstWaveEnterSystem:_DologicGotoNextState()
  self._world:EventDispatcher():Dispatch(GameEventType.FirstWaveEnterFinish, 1)
end

function FirstWaveEnterSystem:_DoRenderShowUIBattleStart(TT, teamEntity)
end

function FirstWaveEnterSystem:_DoRenderAutoAddBuff(TT, buffseqs)
end

function FirstWaveEnterSystem:_DoRendeDestroyBattleEnterResource(TT)
end
