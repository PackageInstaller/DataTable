local HPShieldFromType = {
  OwnerHP = 1,
  CasterHP = 2,
  LastDamage = 3,
  SpecificPet = 4,
  SpilledHP = 5,
  OwnerMaxHP = 6,
  OwnerDefence = 7,
  OwnerBaseDefence = 8,
  OwnerBaseAttack = 9,
  OwnerAttack = 10,
  OwnerLostHPPercent = 11,
  OwnerMaxHPMulPopCount = 12
}
_enum("HPShieldFromType", HPShieldFromType)
_class("BuffLogicAddHPShield", BuffLogicBase)
BuffLogicAddHPShield = BuffLogicAddHPShield

function BuffLogicAddHPShield:Constructor(buffInstance, logicParam)
  self._shieldPercent = logicParam.shieldPercent
  self._shieldFromType = logicParam.shieldFromType or HPShieldFromType.OwnerHP
  self._shieldFromParam = logicParam.shieldFromParam
  self._mulChangeLayer = logicParam.mulChangeLayer
end

function BuffLogicAddHPShield:DoLogic(notify)
  local buffResultEntity
  local entity = self._buffInstance:Entity()
  if entity:HasMonsterID() then
    buffResultEntity = entity
  else
    buffResultEntity = self._world:Player():GetCurrentTeamEntity()
  end
  local value = self._buffLogicService:CalcShieldFormValue(notify, self._shieldFromType, self._shieldFromParam, entity, self._buffInstance)
  local addShield = self._shieldPercent * value
  if self._mulChangeLayer and notify.GetChangeLayer then
    local layer = notify:GetChangeLayer()
    addShield = addShield * math.abs(layer)
  end
  local curHpSh = self._buffLogicService:AddHPShield(buffResultEntity, addShield)
  local damageInfo = DamageInfo:New(0, DamageType.Recover)
  damageInfo:SetHPShield(curHpSh)
  damageInfo:IsInitShield(true)
  self._world:GetMatchLogger():BeginBuff(self._entity:GetID(), self._buffInstance:BuffID())
  local logger = self._world:GetMatchLogger()
  logger:AddHPShieldLog(self._entity:GetID(), {
    key = "CalcAddHPShield",
    desc = "BUFF加血条盾 攻击者[attacker] 被击者[defender] 加盾值[addShield] 当前血条盾[curShield] ",
    attacker = self._entity:GetID(),
    defender = buffResultEntity:GetID(),
    addShield = addShield,
    curShield = curHpSh
  })
  self._world:GetMatchLogger():EndBuff(self._entity:GetID())
  local buffResult = BuffResultAddHPShield:New(buffResultEntity:GetID(), damageInfo)
  if notify and (notify:GetNotifyType() == NotifyType.SingleChainSkillAttackBegin or notify:GetNotifyType() == NotifyType.SinglePetChainSkillAttackBegin) then
    local petEntity = notify:GetNotifyEntity()
    buffResult:SetChainPetEntityID(petEntity:GetID())
    buffResult:SetNotifyChainSkillTimeIndex(notify:GetChainSkillTimeIndex())
  end
  return buffResult
end

function BuffLogicAddHPShield:DoOverlap(logicParam)
  self._shieldPercent = logicParam.shieldPercent
  return self:DoLogic()
end

_class("BuffLogicRemoveHPShield", BuffLogicBase)
BuffLogicRemoveHPShield = BuffLogicRemoveHPShield

function BuffLogicRemoveHPShield:Constructor(buffInstance, logicParam)
  self._isOwner = logicParam.isOwner
end

function BuffLogicRemoveHPShield:DoLogic(notify)
  local entity = self._world:Player():GetCurrentTeamEntity()
  if self._isOwner then
    entity = self._buffInstance:Entity()
  end
  if not entity:BuffComponent():HasBuffEffect(BuffEffectType.ShieldToHP) then
    entity:BuffComponent():SetBuffValue("HPShield", 0)
  end
  local damageInfo = DamageInfo:New(0, DamageType.Recover)
  damageInfo:SetHPShield(0)
  local buffResult = BuffResultRemoveHPShield:New(entity:GetID(), damageInfo)
  if notify and (notify:GetNotifyType() == NotifyType.SingleChainSkillAttackBegin or notify:GetNotifyType() == NotifyType.SingleChainSkillAttackFinish) then
    local petEntity = notify:GetNotifyEntity()
    buffResult:SetChainPetEntityID(petEntity:GetID())
    buffResult:SetNotifyChainSkillTimeIndex(notify:GetChainSkillTimeIndex())
  end
  return buffResult
end

function BuffLogicRemoveHPShield:DoOverlap()
end
