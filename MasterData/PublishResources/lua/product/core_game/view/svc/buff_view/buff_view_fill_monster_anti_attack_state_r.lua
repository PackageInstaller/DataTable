_class("BuffViewFillMonsterAntiAttackStat", BuffViewBase)
BuffViewFillMonsterAntiAttackStat = BuffViewFillMonsterAntiAttackStat

function BuffViewFillMonsterAntiAttackStat:IsNotifyMatch(notify)
  local result = self._buffResult
  local entityID = result:GetEntityID()
  return true
end

function BuffViewFillMonsterAntiAttackStat:PlayView(TT, notify)
  local result = self._buffResult
  local entityID = result:GetEntityID()
  GameGlobal.EventDispatcher():Dispatch(GameEventType.UpdateAntiActiveSkill, entityID)
end
