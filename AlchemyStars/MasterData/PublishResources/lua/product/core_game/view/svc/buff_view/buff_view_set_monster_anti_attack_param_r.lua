_class("BuffViewSetMonsterAntiAttackParam", BuffViewBase)
BuffViewSetMonsterAntiAttackParam = BuffViewSetMonsterAntiAttackParam

function BuffViewSetMonsterAntiAttackParam:IsNotifyMatch(notify)
  local result = self._buffResult
  local entityID = result:GetEntityID()
  return true
end

function BuffViewSetMonsterAntiAttackParam:PlayView(TT, notify)
  local result = self._buffResult
  local entityID = result:GetEntityID()
  GameGlobal.EventDispatcher():Dispatch(GameEventType.UpdateAntiActiveSkill, entityID)
end
