_class("BuffLogicDoDamage", BuffLogicBase)
BuffLogicDoDamage = BuffLogicDoDamage

function BuffLogicDoDamage:Constructor(buffInstance, logicParam)
  self._damageParam = logicParam
end

function BuffLogicDoDamage:DoLogic(notify)
  local casterEntity = self:GetCasterEntity()
  if casterEntity:EntityType() == nil then
    casterEntity = self._entity
  end
  local defender = self._entity
  local blsvc = self._world:GetService("BuffLogic")
  local damageInfo = blsvc:DoBuffDamage(self._buffInstance:BuffID(), casterEntity, defender, self._damageParam)
  local buffResult = BuffResultDamage:New(damageInfo)
  if notify:GetNotifyType() == NotifyType.MonsterMoveOneFinish then
    local walkPos = notify:GetWalkPos()
    buffResult:SetWalkPos(walkPos)
  elseif notify:GetNotifyType() == NotifyType.HitBackEnd then
    local endPos = notify:GetPosEnd()
    buffResult:SetEndPos(endPos)
  elseif notify:GetNotifyType() == NotifyType.PlayerBeHit then
    local attack = notify:GetAttackerEntity()
    buffResult:SetAttackID(attack:GetID())
  end
  return buffResult
end
