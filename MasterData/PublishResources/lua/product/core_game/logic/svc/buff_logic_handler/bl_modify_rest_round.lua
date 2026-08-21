_class("BuffLogicModifyRestRound", BuffLogicBase)
BuffLogicModifyRestRound = BuffLogicModifyRestRound

function BuffLogicModifyRestRound:Constructor(buffInstance, logicParam)
  self._modifyRound = logicParam.modifyRound
end

function BuffLogicModifyRestRound:DoLogic(notify)
  local battleStatCmpt = self._world:BattleStat()
  local subValue = -1 * self._modifyRound
  local curWaveRound = battleStatCmpt:SubCurWaveRoundByEffect(subValue)
  local buffResult = BuffResultModifyRestRound:New(curWaveRound, self._modifyRound)
  if notify:GetNotifyType() == NotifyType.PlayerBeHit then
    buffResult.damageIndex = notify:GetDamageIndex()
  end
  if notify.GetAttackPos and notify.GetTargetPos then
    buffResult.attackPos = notify:GetAttackPos()
    buffResult.targetPos = notify:GetTargetPos()
  end
  if notify.GetAttackerEntity and notify.GetDefenderEntity then
    buffResult.attackerEntity = notify:GetAttackerEntity()
    buffResult.defenderEntity = notify:GetDefenderEntity()
  end
  if notify:GetNotifyType() == NotifyType.MonsterDead or notify:GetNotifyType() == NotifyType.MonsterDeadEnd or notify:GetNotifyType() == NotifyType.MonsterDeadStart then
    local entity = notify:GetNotifyEntity()
    buffResult.deadMonsterEntityID = entity:GetID()
  end
  return buffResult
end
