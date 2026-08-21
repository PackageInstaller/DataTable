_class("BuffViewAddHP", BuffViewBase)
BuffViewAddHP = BuffViewAddHP

function BuffViewAddHP:Constructor()
end

function BuffViewAddHP:IsNotifyMatch(notify)
  if notify then
    if notify:GetNotifyType() == NotifyType.MonsterBeHit then
      local n = notify
      if self._buffResult:GetMatchPass() then
        return true
      end
      return self._buffResult:GetNotifyAttackerPos() == n:GetAttackPos() and self._buffResult:GetNotifyDefenderPos() == n:GetTargetPos() and self._buffResult:GetNotifyAttackerID() == n:GetAttackerEntity():GetID() and self._buffResult:GetNotifyDefenderID() == n:GetDefenderEntity():GetID()
    end
    if notify:GetNotifyType() == NotifyType.TeamEachMoveEnd then
      local notifyPos = notify:GetPos()
      local notifyEntityID = notify:GetEntityID()
      return self._buffResult:GetNotifyPos() == notifyPos and notifyEntityID == self._buffResult:GetNotifyEntityID()
    end
    if notify:GetNotifyType() == NotifyType.TeamLeaderEachMoveEnd or notify:GetNotifyType() == NotifyType.TeamLeaderEachMoveStart then
      local notifyPos = notify:GetPos()
      local notifyEntityID = notify:GetEntityID()
      return self._buffResult:GetNotifyPos() == notifyPos and notifyEntityID == self._buffResult:GetNotifyEntityID()
    end
    if notify:GetNotifyType() == NotifyType.MonsterMoveOneFinish then
      local notifyPos = notify:GetWalkPos()
      local notifyEntityID = notify:GetNotifyEntity():GetID()
      return self._buffResult:GetNotifyPos() == notifyPos and notifyEntityID == self._buffResult:GetNotifyEntityID()
    end
    if notify:GetNotifyType() == NotifyType.MonsterDead then
      local monsterEntity = notify:GetNotifyEntity()
      if monsterEntity then
        local monsterEntityID = monsterEntity:GetID()
        local resultEntityID = self._buffResult:GetNotifyEntityID() or 0
        return monsterEntityID == resultEntityID
      end
    end
  end
  return true
end

function BuffViewAddHP:PlayView(TT)
  local entity = self._entity
  local damageInfo = self._buffResult:GetDamageInfo()
  YIELD(TT)
  local materialEntity = entity
  if entity:HasSuperEntity() and entity:EntityType():IsSkillHolder() then
    materialEntity = entity:GetSuperEntity()
  end
  if entity:HasTeam() then
    materialEntity = entity:GetTeamLeaderPetEntity()
  end
  if materialEntity:MaterialAnimationComponent() and damageInfo:GetDamageType() == DamageType.Recover then
    materialEntity:MaterialAnimationComponent():PlayCure()
  end
  local playDamageService = self._world:GetService("PlayDamage")
  local addTargetEntity = entity
  local targetID = damageInfo:GetTargetEntityID()
  local targetEntity = self._world:GetEntityByID(targetID)
  if targetEntity then
    addTargetEntity = targetEntity
  end
  if addTargetEntity:HasSuperEntity() and addTargetEntity:EntityType():IsSkillHolder() then
    addTargetEntity = addTargetEntity:GetSuperEntity()
  end
  playDamageService:AsyncUpdateHPAndDisplayDamage(addTargetEntity, damageInfo)
end
