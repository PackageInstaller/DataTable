_class("BuffViewDamageByMoveAndBuffLayer", BuffViewBase)
BuffViewDamageByMoveAndBuffLayer = BuffViewDamageByMoveAndBuffLayer

function BuffViewDamageByMoveAndBuffLayer:PlayView(TT)
  local playBuffSvc = self._world:GetService("PlayBuff")
  playBuffSvc:PlayDamageBuff(TT, self)
end

function BuffViewDamageByMoveAndBuffLayer:IsNotifyMatch(notify)
  local result = self._buffResult
  local entity = self._entity
  if notify:GetNotifyType() == NotifyType.MonsterMoveOneFinish then
    return entity:GetID() == notify:GetNotifyEntity():GetID() and result:GetWalkPos() == notify:GetWalkPos()
  end
  if notify:GetNotifyType() == NotifyType.TeamLeaderEachMoveEnd then
    return result:GetWalkPos() == notify:GetPos()
  end
  return true
end
