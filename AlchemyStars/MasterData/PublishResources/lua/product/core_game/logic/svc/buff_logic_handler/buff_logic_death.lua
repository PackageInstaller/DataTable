_class("BuffLogicDeath", BuffLogicBase)
BuffLogicDeath = BuffLogicDeath

function BuffLogicDeath:Constructor(buffInstance, logicParam)
  self._killHPPercent = logicParam.killHPPercent
end

function BuffLogicDeath:DoLogic(notify)
  if self._entity:HasDeadMark() then
    return
  end
  local buffLogicSvc = self:GetBuffLogicService()
  if not buffLogicSvc:IsTargetCanBeToDie(self._entity) then
    return
  end
  self._entity:BuffComponent():SetBuffValue("SecKillHPPercent", self._killHPPercent)
  self._world:EventDispatcher():Dispatch(GameEventType.DataBuffValue, self._entity:GetID(), "SecKillHPPercent", self._killHPPercent)
end
