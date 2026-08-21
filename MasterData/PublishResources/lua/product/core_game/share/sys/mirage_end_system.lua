require("main_state_sys")
_class("MirageEndSystem", MainStateSystem)
MirageEndSystem = MirageEndSystem

function MirageEndSystem:_GetMainStateID()
  return GameStateID.MirageEnd
end

function MirageEndSystem:_OnMainStateEnter(TT)
  local battleResult = self:_IsBattleEnd()
  if battleResult then
    self:_DoLogicSwitchMainFsmState()
    return
  end
  self:_DoRenderMirageEndUI(TT)
  self:_DoRenderMirageClearWarningArea(TT)
  local isForceEnd = self:_IsMirageForceEnd()
  if isForceEnd then
    local eTraps = self:_DoLogicForceCastTrapSkill()
    self:_DoRenderForceCastTrapSkill(TT, eTraps)
  end
  local battleResult = self:_IsBattleEnd()
  if battleResult then
    self:_DoLogicSwitchMainFsmState()
    return
  end
  local eTraps = self:_DoLogicMirageCastTrapDieSkill()
  self:_DoRenderMiragePlayTrapDieSkill(TT, eTraps)
  local bossEntity = self:_DoLogicMirageBossReturn()
  self:_DoRenderMirageBossReturn(TT, bossEntity)
  self:_DoLogicSwitchMainFsmState()
end

function MirageEndSystem:_IsMirageForceEnd()
  local mirageSvc = self._world:GetService("MirageLogic")
  return mirageSvc:IsMirageForceClose()
end

function MirageEndSystem:_DoLogicForceCastTrapSkill()
  local mirageSvc = self._world:GetService("MirageLogic")
  return mirageSvc:DoMirageCastTrapSkill()
end

function MirageEndSystem:_DoLogicSwitchMainFsmState()
  self._world:EventDispatcher():Dispatch(GameEventType.BanAutoFightBtn, false)
  self._world:EventDispatcher():Dispatch(GameEventType.MirageEndFinish, 1)
  local mirageSvc = self._world:GetService("MirageLogic")
  mirageSvc:SetMirageOver()
end

function MirageEndSystem:_DoLogicMirageCastTrapDieSkill()
  local mirageSvc = self._world:GetService("MirageLogic")
  return mirageSvc:DoMirageCastTrapDieSkill()
end

function MirageEndSystem:_DoLogicMirageBossReturn()
  local mirageSvc = self._world:GetService("MirageLogic")
  return mirageSvc:DoMirageBossReturn()
end

function MirageEndSystem:_DoRenderMirageClearWarningArea(TT)
end

function MirageEndSystem:_DoRenderForceCastTrapSkill(TT, eTraps)
end

function MirageEndSystem:_DoRenderMiragePlayTrapDieSkill(TT, eTraps)
end

function MirageEndSystem:_DoRenderMirageBossReturn(TT, bossEntity)
end

function MirageEndSystem:_DoRenderMirageEndUI(TT)
end
