_class("BuffViewDoDamage", BuffViewBase)
BuffViewDoDamage = BuffViewDoDamage

function BuffViewDoDamage:PlayView(TT)
  local playBuffSvc = self._world:GetService("PlayBuff")
  playBuffSvc:PlayDamageBuff(TT, self)
end

function BuffViewDoDamage:IsNotifyMatch(notify)
  local result = self._buffResult
  local entity = self._entity
  if notify:GetNotifyType() == NotifyType.MonsterMoveOneFinish then
    return entity:GetID() == notify:GetNotifyEntity():GetID() and result:GetWalkPos() == notify:GetWalkPos()
  elseif notify:GetNotifyType() == NotifyType.HitBackEnd then
    local bPass = entity:GetID() == notify:GetDefenderId() and result:GetEndPos() == notify:GetPosEnd()
    return bPass
  elseif notify:GetNotifyType() == NotifyType.PlayerBeHit then
    local attackEntity = notify:GetAttackerEntity()
    return attackEntity and result:GetAttackID() == attackEntity:GetID()
  end
  return true
end
