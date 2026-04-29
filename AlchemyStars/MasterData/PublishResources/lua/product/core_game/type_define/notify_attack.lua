require("notify_type")
_class("NotifyAttackBase", INotifyBase)
NotifyAttackBase = NotifyAttackBase

function NotifyAttackBase:Constructor(attacker, defender, attackPos, targetPos)
  self._defender = defender
  self._attacker = attacker
  self._attackPos = attackPos
  self._targetPos = targetPos
end

function NotifyAttackBase:GetNotifyEntity()
  return self._attacker
end

function NotifyAttackBase:NeedCheckGameTurn()
  return true
end

function NotifyAttackBase:GetAttackerEntity()
  return self._attacker
end

function NotifyAttackBase:GetDefenderEntity()
  return self._defender
end

function NotifyAttackBase:GetAttackPos()
  return self._attackPos
end

function NotifyAttackBase:GetTargetPos()
  return self._targetPos
end

function NotifyAttackBase:GetNotifyPos()
  return self._attackPos
end

function NotifyAttackBase:SetDamageValue(damage)
  self._damage = damage
end

function NotifyAttackBase:GetDamageValue()
  return self._damage
end

function NotifyAttackBase:SetDamageType(damageType)
  self._damageType = damageType
end

function NotifyAttackBase:GetDamageType()
  return self._damageType
end

function NotifyAttackBase:SetSkillID(skillID)
  self._skillID = skillID
end

function NotifyAttackBase:GetSkillID()
  return self._skillID
end

function NotifyAttackBase:SetSkillType(skillType)
  self._skillType = skillType
end

function NotifyAttackBase:GetSkillType()
  return self._skillType
end

function NotifyAttackBase:SetEffectType(effectType)
  self._effectType = effectType
end

function NotifyAttackBase:GetEffectType()
  return self._effectType
end

function NotifyAttackBase:SetSkillStageIndex(stageIndex)
  self._stageIndex = stageIndex
end

function NotifyAttackBase:GetSkillStageIndex()
  return self._stageIndex
end

function NotifyAttackBase:GetNormalAttackIndex()
  return self._normalAttackIndex
end

function NotifyAttackBase:SetNormalAttackIndex(index)
  self._normalAttackIndex = index
end

function NotifyAttackBase:GetDefenderEntityIDList()
  return {
    self._defender:GetID()
  }
end

function NotifyAttackBase:SetMatchBuffViewLayer(layer, buffID)
  if not self._matchBuffViewLayer then
    self._matchBuffViewLayer = {}
  end
  self._matchBuffViewLayer[buffID] = layer
end

function NotifyAttackBase:GetMatchBuffViewLayer(buffID)
  if not self._matchBuffViewLayer then
    return nil
  end
  return self._matchBuffViewLayer[buffID]
end

_class("NotifyChainAttackBase", INotifyBase)
NotifyChainAttackBase = NotifyChainAttackBase

function NotifyChainAttackBase:Constructor()
  self._chainCount = 0
end

function NotifyChainAttackBase:SetChainCount(chainCount)
  self._chainCount = chainCount
end

function NotifyChainAttackBase:GetChainCount()
  return self._chainCount
end

_class("NTNormalEachAttackStart", NotifyAttackBase)
NTNormalEachAttackStart = NTNormalEachAttackStart

function NTNormalEachAttackStart:GetNotifyType()
  return NotifyType.NormalEachAttackStart
end

_class("NTNormalEachAttackEnd", NotifyAttackBase)
NTNormalEachAttackEnd = NTNormalEachAttackEnd

function NTNormalEachAttackEnd:GetNotifyType()
  return NotifyType.NormalEachAttackEnd
end

_class("NTNormalAttackCalcStart", INotifyBase)

function NTNormalAttackCalcStart:Constructor(entity, attackGridData)
  self._notifier = entity
  self._attackGridData = attackGridData
end

function NTNormalAttackCalcStart:GetNotifyType()
  return NotifyType.NormalAttackCalcStart
end

function NTNormalAttackCalcStart:GetTargetCount()
  return #self._attackGridData:GetTargetIdList()
end

function NTNormalAttackCalcStart:GetNotifyEntity()
  return self._notifier
end

_class("NTNormalAttackCalcEnd", NotifyAttackBase)
NTNormalAttackCalcEnd = NTNormalAttackCalcEnd

function NTNormalAttackCalcEnd:GetNotifyType()
  return NotifyType.NormalAttackCalcEnd
end

_class("NTNormalAttackCalcEndUseOriPos", NotifyAttackBase)
NTNormalAttackCalcEndUseOriPos = NTNormalAttackCalcEndUseOriPos

function NTNormalAttackCalcEndUseOriPos:GetNotifyType()
  return NotifyType.NormalAttackCalcEndUseOriPos
end

_class("NTNormalAttackChangeBefore", INotifyBase)

function NTNormalAttackChangeBefore:Constructor(entity, attackPos, beAttackPos)
  self._entity = entity
  self._attackPos = attackPos
  self._beAttackPos = beAttackPos
end

function NTNormalAttackChangeBefore:GetNotifyType()
  return NotifyType.NormalAttackChangeBefore
end

function NTNormalAttackChangeBefore:GetNotifyEntity()
  return self._entity
end

function NTNormalAttackChangeBefore:GetAttackPos()
  return self._attackPos
end

function NTNormalAttackChangeBefore:GetTargetPos()
  return self._beAttackPos
end

function NTNormalAttackChangeBefore:GetNotifyPos()
  return self._attackPos
end

function NTNormalAttackChangeBefore:GetPos()
  return self._attackPos
end

_class("NTMonsterEachAttackStart", NotifyAttackBase)
NTMonsterEachAttackStart = NTMonsterEachAttackStart

function NTMonsterEachAttackStart:GetNotifyType()
  return NotifyType.MonsterEachAttackStart
end

_class("NTMonsterEachAttackEnd", NotifyAttackBase)
NTMonsterEachAttackEnd = NTMonsterEachAttackEnd

function NTMonsterEachAttackEnd:GetNotifyType()
  return NotifyType.MonsterEachAttackEnd
end

_class("NTMonsterEachDamageEnd", NotifyAttackBase)
NTMonsterEachDamageEnd = NTMonsterEachDamageEnd

function NTMonsterEachDamageEnd:GetNotifyType()
  return NotifyType.MonsterEachDamageEnd
end

_class("NTTrapEachAttackStart", NotifyAttackBase)
NTTrapEachAttackStart = NTTrapEachAttackStart

function NTTrapEachAttackStart:GetNotifyType()
  return NotifyType.TrapEachAttackStart
end

_class("NTTrapEachAttackEnd", NotifyAttackBase)
NTTrapEachAttackEnd = NTTrapEachAttackEnd

function NTTrapEachAttackEnd:GetNotifyType()
  return NotifyType.TrapEachAttackEnd
end

_class("NTChainSkillEachAttackStart", NotifyAttackBase)
NTChainSkillEachAttackStart = NTChainSkillEachAttackStart

function NTChainSkillEachAttackStart:GetNotifyType()
  return NotifyType.ChainSkillEachAttackStart
end

function NTChainSkillEachAttackStart:SetChainSkillTimeIndex(idx)
  self._chainTimeIndex = idx
end

function NTChainSkillEachAttackStart:GetChainSkillTimeIndex()
  return self._chainTimeIndex
end

function NTChainSkillEachAttackStart:SetChainSkillStageIndex(idx)
  self._chainStageIndex = idx
end

function NTChainSkillEachAttackStart:GetChainSkillStageIndex()
  return self._chainStageIndex
end

function NTChainSkillEachAttackStart:SetRandHalfDamageIndex(idx)
  self._randHalfDamageIndex = idx
end

function NTChainSkillEachAttackStart:GetRandHalfDamageIndex()
  return self._randHalfDamageIndex
end

_class("NTChainSkillEachAttackEnd", NotifyAttackBase)
NTChainSkillEachAttackEnd = NTChainSkillEachAttackEnd

function NTChainSkillEachAttackEnd:GetNotifyType()
  return NotifyType.ChainSkillEachAttackEnd
end

function NTChainSkillEachAttackEnd:SetDamageValue(val)
  self._damageValue = val
end

function NTChainSkillEachAttackEnd:GetDamageValue()
  return self._damageValue
end

function NTChainSkillEachAttackEnd:SetChainSkillTimeIndex(idx)
  self._chainTimeIndex = idx
end

function NTChainSkillEachAttackEnd:GetChainSkillTimeIndex()
  return self._chainTimeIndex
end

function NTChainSkillEachAttackEnd:SetChainSkillStageIndex(idx)
  self._chainStageIndex = idx
end

function NTChainSkillEachAttackEnd:GetChainSkillStageIndex()
  return self._chainStageIndex
end

function NTChainSkillEachAttackEnd:SetRandHalfDamageIndex(idx)
  self._randHalfDamageIndex = idx
end

function NTChainSkillEachAttackEnd:GetRandHalfDamageIndex()
  return self._randHalfDamageIndex
end

function NTChainSkillEachAttackEnd:GetDamage()
  return self._damageValue
end

_class("NTActiveSkillEachAttackStart", NotifyAttackBase)
NTActiveSkillEachAttackStart = NTActiveSkillEachAttackStart

function NTActiveSkillEachAttackStart:GetNotifyType()
  return NotifyType.ActiveSkillEachAttackStart
end

_class("NTActiveSkillEachAttackEnd", NotifyAttackBase)
NTActiveSkillEachAttackEnd = NTActiveSkillEachAttackEnd

function NTActiveSkillEachAttackEnd:GetNotifyType()
  return NotifyType.ActiveSkillEachAttackEnd
end

function NTActiveSkillEachAttackEnd:SetChainSkillTimeIndex(idx)
  self._chainTimeIndex = idx
end

function NTActiveSkillEachAttackEnd:GetChainSkillTimeIndex()
  return self._chainTimeIndex
end

function NTActiveSkillEachAttackEnd:SetChainSkillStageIndex(idx)
  self._chainStageIndex = idx
end

function NTActiveSkillEachAttackEnd:GetChainSkillStageIndex()
  return self._chainStageIndex
end

_class("NTPlayerBeHit", NotifyAttackBase)
NTPlayerBeHit = NTPlayerBeHit

function NTPlayerBeHit:GetNotifyType()
  return NotifyType.PlayerBeHit
end

function NTPlayerBeHit:NeedCheckGameTurn()
  return false
end

function NTPlayerBeHit:GetNotifyEntity()
  return self._defender
end

function NTPlayerBeHit:SetDamageIndex(idx)
  self._damageIndex = idx
end

function NTPlayerBeHit:GetDamageIndex()
  return self._damageIndex
end

_class("NTMonsterBeHit", NotifyAttackBase)
NTMonsterBeHit = NTMonsterBeHit

function NTMonsterBeHit:GetNotifyType()
  return NotifyType.MonsterBeHit
end

function NTMonsterBeHit:NeedCheckGameTurn()
  return false
end

function NTMonsterBeHit:GetNotifyEntity()
  return self._defender
end

function NTMonsterBeHit:SetDamageStageIndex(idx)
  self._damageStageIndex = idx
end

function NTMonsterBeHit:GetDamageStageIndex()
  return self._damageStageIndex
end

function NTMonsterBeHit:SetCurSkillDamageIndex(val)
  self._curSkillDamageIndex = val
end

function NTMonsterBeHit:GetCurSkillDamageIndex()
  return self._curSkillDamageIndex
end

_class("NTPlayerBeHitStart", NotifyAttackBase)
NTPlayerBeHitStart = NTPlayerBeHitStart

function NTPlayerBeHitStart:GetNotifyType()
  return NotifyType.PlayerBeHitStart
end

function NTPlayerBeHitStart:NeedCheckGameTurn()
  return false
end

function NTPlayerBeHitStart:GetNotifyEntity()
  return self._defender
end

function NTPlayerBeHitStart:SetDamageIndex(idx)
  self._damageIndex = idx
end

function NTPlayerBeHitStart:GetDamageIndex()
  return self._damageIndex
end

_class("NTMonsterBeHitStart", NotifyAttackBase)
NTMonsterBeHitStart = NTMonsterBeHitStart

function NTMonsterBeHitStart:GetNotifyType()
  return NotifyType.MonsterBeHitStart
end

function NTMonsterBeHitStart:NeedCheckGameTurn()
  return false
end

function NTMonsterBeHitStart:GetNotifyEntity()
  return self._defender
end

_class("NTNormalAttackStart", INotifyBase)
NTNormalAttackStart = NTNormalAttackStart

function NTNormalAttackStart:Constructor(attacker, chainPathType, chainPath)
  self._attacker = attacker
  self._chainPathType = chainPathType
  self._chainPath = chainPath
end

function NTNormalAttackStart:GetNotifyType()
  return NotifyType.NormalAttackStart
end

function NTNormalAttackStart:GetNotifyEntity()
  return self._attacker
end

function NTNormalAttackStart:GetAttackerEntity()
  return self._attacker
end

function NTNormalAttackStart:GetChainPathType()
  return self._chainPathType
end

function NTNormalAttackStart:GetChainPath()
  return self._chainPath
end

_class("NTNormalAttackEnd", INotifyBase)
NTNormalAttackEnd = NTNormalAttackEnd

function NTNormalAttackEnd:Constructor(attacker)
  self._attacker = attacker
end

function NTNormalAttackEnd:GetNotifyType()
  return NotifyType.NormalAttackEnd
end

function NTNormalAttackEnd:GetNotifyEntity()
  return self._attacker
end

function NTNormalAttackEnd:GetAttackerEntity()
  return self._attacker
end

_class("NTBeforeCalcChainSkill", INotifyBase)
NTBeforeCalcChainSkill = NTBeforeCalcChainSkill

function NTBeforeCalcChainSkill:Constructor()
end

function NTBeforeCalcChainSkill:GetNotifyType()
  return NotifyType.BeforeCalcChainSkill
end

function NTBeforeCalcChainSkill:SetChainCount(chainCount)
  self._chainCount = chainCount
end

function NTBeforeCalcChainSkill:GetChainCount()
  return self._chainCount
end

_class("NTChainSkillAttackStart", INotifyBase)
NTChainSkillAttackStart = NTChainSkillAttackStart

function NTChainSkillAttackStart:Constructor(attacker, defenderList, attackPos, defenerPosList, defendMonsterList)
  self._attacker = attacker
  self._defenderList = defenderList
  self._attackPos = attackPos
  self._defenderPosList = defenerPosList
  self._defendMonsterList = defendMonsterList
end

function NTChainSkillAttackStart:GetNotifyType()
  return NotifyType.ChainSkillAttackStart
end

function NTChainSkillAttackStart:GetNotifyEntity()
  return self._attacker
end

function NTChainSkillAttackStart:GetAttackerEntity()
  return self._attacker
end

function NTChainSkillAttackStart:GetAttackerPos()
  return self._attackPos
end

function NTChainSkillAttackStart:GetDefenderEntityIDList()
  return self._defenderList
end

function NTChainSkillAttackStart:GetDefenderPosList()
  return self._defenderPosList
end

function NTChainSkillAttackStart:GetTargetCount()
  local count = 0
  local t = {}
  for _, id in ipairs(self._defendMonsterList) do
    if not t[id] then
      count = count + 1
      t[id] = true
    end
  end
  return count
end

function NTChainSkillAttackStart:SetChainSkillTimeIndex(idx)
  self._chainTimeIndex = idx
end

function NTChainSkillAttackStart:GetChainSkillTimeIndex()
  return self._chainTimeIndex
end

function NTChainSkillAttackStart:SetChainSkillStageIndex(idx)
  self._chainStageIndex = idx
end

function NTChainSkillAttackStart:GetChainSkillStageIndex()
  return self._chainStageIndex
end

function NTChainSkillAttackStart:SetChainSkillId(chainSkillId)
  self._chainSkillId = chainSkillId
end

function NTChainSkillAttackStart:GetChainSkillId()
  return self._chainSkillId
end

function NTChainSkillAttackStart:SetChainSkillStage(chainSkillStage)
  self._chainSkillStage = chainSkillStage
end

function NTChainSkillAttackStart:GetChainSkillStage()
  return self._chainSkillStage
end

function NTChainSkillAttackStart:GetSkillID()
  return self._chainSkillId
end

_class("NTSecondChainSkillAttackStart", INotifyBase)
NTSecondChainSkillAttackStart = NTSecondChainSkillAttackStart

function NTSecondChainSkillAttackStart:Constructor(attacker, defenderList, attackPos, defenerPosList, defendMonsterList)
  self._attacker = attacker
  self._defenderList = defenderList
  self._attackPos = attackPos
  self._defenderPosList = defenerPosList
  self._defendMonsterList = defendMonsterList
end

function NTSecondChainSkillAttackStart:GetNotifyType()
  return NotifyType.SecondChainSkillAttackStart
end

function NTSecondChainSkillAttackStart:GetNotifyEntity()
  return self._attacker
end

function NTSecondChainSkillAttackStart:GetAttackerEntity()
  return self._attacker
end

function NTSecondChainSkillAttackStart:GetAttackerPos()
  return self._attackPos
end

function NTSecondChainSkillAttackStart:GetDefenderEntityIDList()
  return self._defenderList
end

function NTSecondChainSkillAttackStart:GetDefenderPosList()
  return self._defenderPosList
end

function NTSecondChainSkillAttackStart:GetTargetCount()
  local count = 0
  local t = {}
  for _, id in ipairs(self._defendMonsterList) do
    if not t[id] then
      count = count + 1
      t[id] = true
    end
  end
  return count
end

_class("NTChainSkillAttack", INotifyBase)
NTChainSkillAttack = NTChainSkillAttack

function NTChainSkillAttack:Constructor(attacker, defenderList, attackPos, defenerPosList)
  self._attacker = attacker
  self._defenderList = defenderList
  self._attackPos = attackPos
  self._defenerPosList = defenerPosList
end

function NTChainSkillAttack:GetNotifyType()
  return NotifyType.ChainSkillAttack
end

function NTChainSkillAttack:GetNotifyEntity()
  return self._attacker
end

function NTChainSkillAttack:GetAttackerEntity()
  return self._attacker
end

function NTChainSkillAttack:GetAttackerPos()
  return self._attackPos
end

function NTChainSkillAttack:GetDefenderEntityIDList()
  return self._defenderList
end

function NTChainSkillAttack:GetDefenderPosList()
  return self._defenderPosList
end

_class("NTChainSkillAttackEnd", NotifyChainAttackBase)
NTChainSkillAttackEnd = NTChainSkillAttackEnd

function NTChainSkillAttackEnd:Constructor(attacker, defenderList, attackPos, defenerPosList)
  self._attacker = attacker
  self._defenderList = defenderList
  self._attackPos = attackPos
  self._defenerPosList = defenerPosList
  self._isPetActiveLinkLine = nil
end

function NTChainSkillAttackEnd:SetPetActiveLinkLineState(state)
  self._isPetActiveLinkLine = state
end

function NTChainSkillAttackEnd:IsPetActiveLinkLine()
  return self._isPetActiveLinkLine
end

function NTChainSkillAttackEnd:GetNotifyType()
  return NotifyType.ChainSkillAttackEnd
end

function NTChainSkillAttackEnd:GetNotifyEntity()
  return self._attacker
end

function NTChainSkillAttackEnd:GetAttackerEntity()
  return self._attacker
end

function NTChainSkillAttackEnd:GetAttackerPos()
  return self._attackPos
end

function NTChainSkillAttackEnd:GetDefenderEntityIDList()
  return self._defenderList
end

function NTChainSkillAttackEnd:GetDefenderPosList()
  return self._defenderPosList
end

function NTChainSkillAttackEnd:GetTargetMap()
  if not self._defenderList then
    return {}
  end
  local map = {}
  for _, eid in ipairs(self._defenderList) do
    if not table.icontains(map, eid) then
      map[eid] = true
    end
  end
  return map
end

function NTChainSkillAttackEnd:SetChainSkillTimeIndex(idx)
  self._chainTimeIndex = idx
end

function NTChainSkillAttackEnd:GetChainSkillTimeIndex()
  return self._chainTimeIndex
end

function NTChainSkillAttackEnd:SetChainSkillStageIndex(idx)
  self._chainStageIndex = idx
end

function NTChainSkillAttackEnd:GetChainSkillStageIndex()
  return self._chainStageIndex
end

function NTChainSkillAttackEnd:SetChainSkillId(chainSkillId)
  self._chainSkillId = chainSkillId
end

function NTChainSkillAttackEnd:GetChainSkillId()
  return self._chainSkillId
end

function NTChainSkillAttackEnd:SetChainSkillStage(chainSkillStage)
  self._chainSkillStage = chainSkillStage
end

function NTChainSkillAttackEnd:GetChainSkillStage()
  return self._chainSkillStage
end

function NTChainSkillAttackEnd:GetSkillID()
  return self._chainSkillId
end

function NTChainSkillAttackEnd:SetSkillDamageTargetCount(targetCount)
  self._skillDamageTargetCount = targetCount
end

function NTChainSkillAttackEnd:GetSkillDamageTargetCount()
  return self._skillDamageTargetCount
end

_class("NTSecondChainSkillAttackEnd", INotifyBase)
NTSecondChainSkillAttackEnd = NTSecondChainSkillAttackEnd

function NTSecondChainSkillAttackEnd:Constructor(attacker)
  self._attacker = attacker
end

function NTSecondChainSkillAttackEnd:GetNotifyType()
  return NotifyType.SecondChainSkillAttackEnd
end

function NTSecondChainSkillAttackEnd:GetNotifyEntity()
  return self._attacker
end

_class("NTActiveSkillAttackStart", INotifyBase)
NTActiveSkillAttackStart = NTActiveSkillAttackStart

function NTActiveSkillAttackStart:Constructor(attacker)
  self._attacker = attacker
  self.m_nSkillID = nil
  self.m_scopeResult = nil
end

function NTActiveSkillAttackStart:GetNotifyType()
  return NotifyType.ActiveSkillAttackStart
end

function NTActiveSkillAttackStart:GetNotifyEntity()
  return self._attacker
end

function NTActiveSkillAttackStart:GetAttackerEntity()
  return self._attacker
end

function NTActiveSkillAttackStart:InitSkillResult(nSkillID, scopeResult)
  self.m_nSkillID = nSkillID
  self.m_scopeResult = scopeResult
end

function NTActiveSkillAttackStart:GetScopeResult()
  return self.m_scopeResult
end

function NTActiveSkillAttackStart:GetDefenderEntityIDList()
  if not self.m_scopeResult then
    return {}
  end
  return self.m_scopeResult:GetTargetIDs()
end

function NTActiveSkillAttackStart:GetTargetCount()
  if not self.m_scopeResult then
    return 0
  end
  local targetIDs = self.m_scopeResult:GetTargetIDs()
  if not targetIDs then
    return 0
  end
  local world = self._attacker:GetOwnerWorld()
  local targetCount = 0
  for i = 1, #targetIDs do
    local targetEntity = world:GetEntityByID(targetIDs[i])
    if targetEntity and not targetEntity:HasTrapID() then
      targetCount = targetCount + 1
    end
  end
  return targetCount
end

function NTActiveSkillAttackStart:GetSkillID()
  return self.m_nSkillID
end

_class("NTActiveSkillAttackEnd", INotifyBase)
NTActiveSkillAttackEnd = NTActiveSkillAttackEnd

function NTActiveSkillAttackEnd:Constructor(attacker, skillID)
  self._attacker = attacker
  self._skillID = skillID
end

function NTActiveSkillAttackEnd:GetNotifyType()
  return NotifyType.ActiveSkillAttackEnd
end

function NTActiveSkillAttackEnd:GetNotifyEntity()
  return self._attacker
end

function NTActiveSkillAttackEnd:GetAttackerEntity()
  return self._attacker
end

function NTActiveSkillAttackEnd:SetSkillID(skillID)
  self._skillID = skillID
end

function NTActiveSkillAttackEnd:GetSkillID()
  return self._skillID
end

function NTActiveSkillAttackEnd:InitSkillResult(nSkillID, scopeResult)
  self._skillID = nSkillID
  self.m_scopeResult = scopeResult
end

function NTActiveSkillAttackEnd:GetScopeResult()
  return self.m_scopeResult
end

function NTActiveSkillAttackEnd:GetDefenderEntityIDList()
  if not self.m_scopeResult then
    return {}
  end
  return self.m_scopeResult:GetTargetIDs()
end

function NTActiveSkillAttackEnd:SetSkillDamageTargetCount(targetCount)
  self._skillDamageTargetCount = targetCount
end

function NTActiveSkillAttackEnd:GetSkillDamageTargetCount()
  return self._skillDamageTargetCount
end

_class("NTBeforeActiveSkillAttackStart", INotifyBase)
NTBeforeActiveSkillAttackStart = NTBeforeActiveSkillAttackStart

function NTBeforeActiveSkillAttackStart:Constructor(attacker)
  self._attacker = attacker
end

function NTBeforeActiveSkillAttackStart:GetNotifyType()
  return NotifyType.BeforeActiveSkillAttackStart
end

function NTBeforeActiveSkillAttackStart:GetNotifyEntity()
  return self._attacker
end

_class("NTChainSkillTurnStart", INotifyBase)
NTChainSkillTurnStart = NTChainSkillTurnStart

function NTChainSkillTurnStart:Constructor(teamEntity)
  self._teamEntity = teamEntity
end

function NTChainSkillTurnStart:GetNotifyType()
  return NotifyType.ChainSkillTurnStart
end

function NTChainSkillTurnStart:GetNotifyEntity()
  return self._teamEntity
end

_class("NTChainSkillTurnStartSkipped", INotifyBase)
NTChainSkillTurnStartSkipped = NTChainSkillTurnStartSkipped

function NTChainSkillTurnStartSkipped:Constructor(teamEntity)
  self._teamEntity = teamEntity
end

function NTChainSkillTurnStartSkipped:GetNotifyType()
  return NotifyType.ChainSkillTurnStartSkipped
end

function NTChainSkillTurnStartSkipped:GetNotifyEntity()
  return self._teamEntity
end

_class("NTChainSkillTurnEnd", INotifyBase)
NTChainSkillTurnEnd = NTChainSkillTurnEnd

function NTChainSkillTurnEnd:Constructor(chainSkillCount)
  self._cnt = chainSkillCount
end

function NTChainSkillTurnEnd:GetNotifyType()
  return NotifyType.ChainSkillTurnEnd
end

function NTChainSkillTurnEnd:GetChainSkillCount()
  return self._cnt
end

_class("NTBuffCastSkillEachAttackBegin", NotifyAttackBase)
NTBuffCastSkillEachAttackBegin = NTBuffCastSkillEachAttackBegin

function NTBuffCastSkillEachAttackBegin:Constructor()
end

function NTBuffCastSkillEachAttackBegin:GetNotifyType()
  return NotifyType.BuffCastSkillEachAttackBegin
end

_class("NTBuffCastSkillEachAttackEnd", NotifyAttackBase)
NTBuffCastSkillEachAttackEnd = NTBuffCastSkillEachAttackEnd

function NTBuffCastSkillEachAttackEnd:Constructor()
end

function NTBuffCastSkillEachAttackEnd:GetNotifyType()
  return NotifyType.BuffCastSkillEachAttackEnd
end

_class("NTActiveSkillAttackEndBeforeMonsterDead", NTActiveSkillAttackEnd)

function NTActiveSkillAttackEndBeforeMonsterDead:GetNotifyType()
  return NotifyType.ActiveSkillAttackEndBeforeMonsterDead
end

function NTActiveSkillAttackEndBeforeMonsterDead:NeedCheckGameTurn()
  return true
end

_class("NTChessPetSkillAttackStart", INotifyBase)
NTChessPetSkillAttackStart = NTChessPetSkillAttackStart

function NTChessPetSkillAttackStart:Constructor(attacker, skillID)
  self._attacker = attacker
  self._skillID = skillID
end

function NTChessPetSkillAttackStart:GetNotifyType()
  return NotifyType.ChessPetSkillAttackStart
end

function NTChessPetSkillAttackStart:GetNotifyEntity()
  return self._attacker
end

function NTChessPetSkillAttackStart:GetAttackerEntity()
  return self._attacker
end

function NTChessPetSkillAttackStart:GetSkillID()
  return self._skillID
end

_class("NTChessPetSkillAttackEnd", INotifyBase)
NTChessPetSkillAttackEnd = NTChessPetSkillAttackEnd

function NTChessPetSkillAttackEnd:Constructor(attacker, skillID)
  self._attacker = attacker
  self._skillID = skillID
end

function NTChessPetSkillAttackEnd:GetNotifyType()
  return NotifyType.ChessPetSkillAttackEnd
end

function NTChessPetSkillAttackEnd:GetNotifyEntity()
  return self._attacker
end

function NTChessPetSkillAttackEnd:GetAttackerEntity()
  return self._attacker
end

function NTChessPetSkillAttackEnd:GetSkillID()
  return self._skillID
end

_class("NTSingleChainSkillAttackFinish", INotifyBase)
NTSingleChainSkillAttackFinish = NTSingleChainSkillAttackFinish

function NTSingleChainSkillAttackFinish:Constructor(attacker, chainTimeIndex, chainStageIndex)
  self._attacker = attacker
  self._chainTimeIndex = chainTimeIndex
  self._chainStageIndex = chainStageIndex
end

function NTSingleChainSkillAttackFinish:GetNotifyType()
  return NotifyType.SingleChainSkillAttackFinish
end

function NTSingleChainSkillAttackFinish:GetNotifyEntity()
  return self._attacker
end

function NTSingleChainSkillAttackFinish:GetAttackerEntity()
  return self._attacker
end

function NTSingleChainSkillAttackFinish:GetChainSkillTimeIndex()
  return self._chainTimeIndex
end

function NTSingleChainSkillAttackFinish:GetChainSkillStageIndex()
  return self._chainStageIndex or 1
end

_class("NTFeatureSkillAttackEnd", INotifyBase)
NTFeatureSkillAttackEnd = NTFeatureSkillAttackEnd

function NTFeatureSkillAttackEnd:Constructor(featureType, featureSkillID)
  self.m_nFeatureType = featureType
  self.m_nSkillID = featureSkillID
end

function NTFeatureSkillAttackEnd:GetNotifyType()
  return NotifyType.FeatureSkillAttackEnd
end

function NTFeatureSkillAttackEnd:GetFeatureType()
  return self.m_nFeatureType
end

function NTFeatureSkillAttackEnd:GetSkillID()
  return self.m_nSkillID
end

_class("NTBuffCastSkillAttackEnd", INotifyBase)
NTBuffCastSkillAttackEnd = NTBuffCastSkillAttackEnd

function NTBuffCastSkillAttackEnd:Constructor(attacker, skillID)
  self._attacker = attacker
  self._skillID = skillID
end

function NTBuffCastSkillAttackEnd:GetNotifyType()
  return NotifyType.BuffCastSkillAttackEnd
end

function NTBuffCastSkillAttackEnd:GetNotifyEntity()
  return self._attacker
end

function NTBuffCastSkillAttackEnd:GetAttackerEntity()
  return self._attacker
end

function NTBuffCastSkillAttackEnd:GetSkillID()
  return self._skillID
end

_class("NTBuffCastSkillAttackBegin", INotifyBase)
NTBuffCastSkillAttackBegin = NTBuffCastSkillAttackBegin

function NTBuffCastSkillAttackBegin:Constructor(attacker, skillID)
  self._attacker = attacker
  self._skillID = skillID
  self._scopeResult = nil
end

function NTBuffCastSkillAttackBegin:GetNotifyType()
  return NotifyType.BuffCastSkillAttackBegin
end

function NTBuffCastSkillAttackBegin:GetNotifyEntity()
  return self._attacker
end

function NTBuffCastSkillAttackBegin:GetAttackerEntity()
  return self._attacker
end

function NTBuffCastSkillAttackBegin:GetSkillID()
  return self._skillID
end

function NTBuffCastSkillAttackBegin:InitSkillScopeResult(scopeResult)
  self._scopeResult = scopeResult
end

function NTBuffCastSkillAttackBegin:GetScopeResult()
  return self._scopeResult
end

function NTBuffCastSkillAttackBegin:GetDefenderEntityIDList()
  if not self._scopeResult then
    return {}
  end
  return self._scopeResult:GetTargetIDs()
end

function NTBuffCastSkillAttackBegin:GetTargetCount()
  if not self._scopeResult then
    return 0
  end
  local targetIDs = self._scopeResult:GetTargetIDs()
  if not targetIDs then
    return 0
  end
  local world = self._attacker:GetOwnerWorld()
  local targetCount = 0
  for i = 1, #targetIDs do
    local targetEntity = world:GetEntityByID(targetIDs[i])
    if targetEntity and not targetEntity:HasTrapID() then
      targetCount = targetCount + 1
    end
  end
  return targetCount
end

_class("NTTeamNormalAttackStart", INotifyBase)
NTTeamNormalAttackStart = NTTeamNormalAttackStart

function NTTeamNormalAttackStart:Constructor(chainPathType, chainPath)
  self._chainPathType = chainPathType
  self._chainPath = chainPath
end

function NTTeamNormalAttackStart:GetNotifyType()
  return NotifyType.TeamNormalAttackStart
end

function NTTeamNormalAttackStart:GetChainPathType()
  return self._chainPathType
end

function NTTeamNormalAttackStart:GetChainPath()
  return self._chainPath
end

_class("NTBuffLogicCastSkillCalcEffectEnd", INotifyBase)
NTBuffLogicCastSkillCalcEffectEnd = NTBuffLogicCastSkillCalcEffectEnd

function NTBuffLogicCastSkillCalcEffectEnd:Constructor(attacker, skillID)
  self._attacker = attacker
  self._skillID = skillID
end

function NTBuffLogicCastSkillCalcEffectEnd:GetNotifyType()
  return NotifyType.BuffLogicCastSkillCalcEffectEnd
end

function NTBuffLogicCastSkillCalcEffectEnd:GetNotifyEntity()
  return self._attacker
end

function NTBuffLogicCastSkillCalcEffectEnd:GetAttackerEntity()
  return self._attacker
end

function NTBuffLogicCastSkillCalcEffectEnd:GetSkillID()
  return self._skillID
end

function NTBuffLogicCastSkillCalcEffectEnd:SetSkillDamageTargetCount(targetCount)
  self._skillDamageTargetCount = targetCount
end

function NTBuffLogicCastSkillCalcEffectEnd:GetSkillDamageTargetCount()
  return self._skillDamageTargetCount
end

_class("NTSingleChainSkillAttackBegin", INotifyBase)
NTSingleChainSkillAttackBegin = NTSingleChainSkillAttackBegin

function NTSingleChainSkillAttackBegin:Constructor(attacker, chainIndex, isShadow)
  self._attacker = attacker
  self._chainSkillIndex = chainIndex
  self._isShadow = isShadow or false
end

function NTSingleChainSkillAttackBegin:GetNotifyType()
  return NotifyType.SingleChainSkillAttackBegin
end

function NTSingleChainSkillAttackBegin:GetNotifyEntity()
  return self._attacker
end

function NTSingleChainSkillAttackBegin:GetAttackerEntity()
  return self._attacker
end

function NTSingleChainSkillAttackBegin:GetChainSkillTimeIndex()
  return self._chainSkillIndex
end

function NTSingleChainSkillAttackBegin:IsShadow()
  return self._isShadow
end

_class("NTSinglePetChainSkillAttackBegin", INotifyBase)
NTSinglePetChainSkillAttackBegin = NTSinglePetChainSkillAttackBegin

function NTSinglePetChainSkillAttackBegin:Constructor(attacker, chainIndex)
  self._attacker = attacker
  self._chainSkillIndex = chainIndex
end

function NTSinglePetChainSkillAttackBegin:GetNotifyType()
  return NotifyType.SinglePetChainSkillAttackBegin
end

function NTSinglePetChainSkillAttackBegin:GetNotifyEntity()
  return self._attacker
end

function NTSinglePetChainSkillAttackBegin:GetAttackerEntity()
  return self._attacker
end

function NTSinglePetChainSkillAttackBegin:GetChainSkillTimeIndex()
  return self._chainSkillIndex
end

_class("NTExtraChainSkillAttackBegin", NTSingleChainSkillAttackBegin)
NTExtraChainSkillAttackBegin = NTExtraChainSkillAttackBegin

function NTExtraChainSkillAttackBegin:GetNotifyType()
  return NotifyType.ExtraChainSkillAttackBegin
end

_class("NTExtraChainSkillAttackFinish", NTSingleChainSkillAttackFinish)
NTExtraChainSkillAttackFinish = NTExtraChainSkillAttackFinish

function NTExtraChainSkillAttackFinish:GetNotifyType()
  return NotifyType.ExtraChainSkillAttackFinish
end

_class("NTNormalAttackChangeAfter", NTNormalAttackChangeBefore)
NTNormalAttackChangeAfter = NTNormalAttackChangeAfter

function NTNormalAttackChangeAfter:GetNotifyType()
  return NotifyType.NormalAttackChangeAfter
end

_class("NTAutoBeadSkillEachAttackStart", NotifyAttackBase)
NTAutoBeadSkillEachAttackStart = NTAutoBeadSkillEachAttackStart

function NTAutoBeadSkillEachAttackStart:GetNotifyType()
  return NotifyType.AutoBeadSkillEachAttackStart
end

_class("NTAutoBeadSkillEachAttackEnd", NotifyAttackBase)
NTAutoBeadSkillEachAttackEnd = NTAutoBeadSkillEachAttackEnd

function NTAutoBeadSkillEachAttackEnd:GetNotifyType()
  return NotifyType.AutoBeadSkillEachAttackEnd
end

function NTAutoBeadSkillEachAttackEnd:SetDamageValue(val)
  self._damageValue = val
end

function NTAutoBeadSkillEachAttackEnd:GetDamageValue()
  return self._damageValue
end

function NTAutoBeadSkillEachAttackEnd:SetAutoBeadSkillIndex(skillIndex)
  self._autoBeadSkillIndex = skillIndex
end

function NTAutoBeadSkillEachAttackEnd:GetAutoBeadSkillIndex()
  return self._autoBeadSkillIndex
end

_class("NTAutoBeadSkillEachStart", INotifyBase)
NTAutoBeadSkillEachStart = NTAutoBeadSkillEachStart

function NTAutoBeadSkillEachStart:Constructor(attacker, skillID, autoBeadID)
  self._attacker = attacker
  self._skillID = skillID
  self._autoBeadID = autoBeadID
end

function NTAutoBeadSkillEachStart:GetNotifyType()
  return NotifyType.AutoBeadSkillEachStart
end

function NTAutoBeadSkillEachStart:GetNotifyEntity()
  return self._attacker
end

function NTAutoBeadSkillEachStart:GetAttackerEntity()
  return self._attacker
end

function NTAutoBeadSkillEachStart:GetSkillID()
  return self._skillID
end

function NTAutoBeadSkillEachStart:GetAutoBeadID()
  return self._autoBeadID
end

_class("NTAutoBeadSkillEachEnd", INotifyBase)
NTAutoBeadSkillEachEnd = NTAutoBeadSkillEachEnd

function NTAutoBeadSkillEachEnd:Constructor(attacker, skillID, autoBeadID)
  self._attacker = attacker
  self._skillID = skillID
  self._autoBeadID = autoBeadID
end

function NTAutoBeadSkillEachEnd:GetNotifyType()
  return NotifyType.AutoBeadSkillEachEnd
end

function NTAutoBeadSkillEachEnd:GetNotifyEntity()
  return self._attacker
end

function NTAutoBeadSkillEachEnd:GetAttackerEntity()
  return self._attacker
end

function NTAutoBeadSkillEachEnd:GetSkillID()
  return self._skillID
end

function NTAutoBeadSkillEachEnd:GetAutoBeadID()
  return self._autoBeadID
end

function NTAutoBeadSkillEachEnd:SetAutoBeadSkillIndex(skillIndex)
  self._autoBeadSkillIndex = skillIndex
end

function NTAutoBeadSkillEachEnd:GetAutoBeadSkillIndex()
  return self._autoBeadSkillIndex
end
