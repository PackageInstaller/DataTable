local CalcChangeTargetAttributeType = {
  None = 0,
  MaxHP = 1,
  MAX = 9
}
_enum("CalcChangeTargetAttributeType", CalcChangeTargetAttributeType)
require("buff_logic_base")
_class("BuffLogicChangeAttributeBasedOnDamage", BuffLogicBase)
BuffLogicChangeAttributeBasedOnDamage = BuffLogicChangeAttributeBasedOnDamage

function BuffLogicChangeAttributeBasedOnDamage:Constructor(buffInstance, logicParam)
  self._mulValue = logicParam.mulValue or 0
  self._addValue = logicParam.addValue or 0
  self._attributeType = logicParam.attributeType or CalcChangeTargetAttributeType.MaxHP
  buffInstance.__AddHPMax_AddValue = 0
end

function BuffLogicChangeAttributeBasedOnDamage:DoLogic(notify)
  local context = self._buffInstance:Context()
  if not context then
    return
  end
  local e = self._buffInstance:Entity()
  if e:HasDeadMark() then
    return
  end
  if e:Attributes():GetCurrentHP() == 0 then
    return
  end
  local casterEntity = context.casterEntity
  local skillEffectResultContainer = casterEntity:SkillContext():GetResultContainer()
  local damageResultArray = skillEffectResultContainer:GetEffectResultsAsArray(SkillEffectType.Damage)
  if not damageResultArray or #damageResultArray == 0 then
    return
  end
  local damageValue = 0
  for _, v in ipairs(damageResultArray) do
    local damageResult = v
    local targetEntityID = damageResult:GetTargetID()
    if targetEntityID == e:GetID() then
      local damageInfo = damageResult:GetDamageInfo(1)
      if damageInfo and damageInfo:GetDamageType() ~= DamageType.Miss and damageInfo:GetDamageType() ~= DamageType.Guard then
        damageValue = damageValue + damageInfo:GetDamageValue()
      end
    end
  end
  if damageValue == 0 then
    return
  end
  local addHpMaxValue = math.floor(damageValue * self._mulValue + self._addValue)
  if addHpMaxValue < 0 then
    addHpMaxValue = 0
  end
  if self._attributeType == CalcChangeTargetAttributeType.MaxHP then
    local curHp = e:Attributes():GetCurrentHP()
    local maxHp = e:Attributes():CalcMaxHp()
    local curPercent = curHp / maxHp
    local calcDamage = self._world:GetService("CalcDamage")
    self._buffInstance.__AddHPMax_AddValue = self._buffInstance.__AddHPMax_AddValue + addHpMaxValue
    local ret = calcDamage:AddTargetMaxHP(e:GetID(), self._buffInstance.__AddHPMax_AddValue, self:GetBuffSeq())
    local maxHpNew = e:Attributes():CalcMaxHp()
    local curHpNew = math.floor(maxHpNew * curPercent + 0.5)
    local addHp = curHpNew - curHp
    local damageInfoRecover
    if 0 < addHp then
      damageInfoRecover = DamageInfo:New(addHp, DamageType.Recover)
      calcDamage:AddTargetHP(e:GetID(), damageInfoRecover)
    end
    local teamEntity
    if e:HasPetPstID() then
      teamEntity = e:Pet():GetOwnerTeamEntity()
    end
    if e:HasTeam() then
      teamEntity = e
    end
    local battleService = self._world:GetService("Battle")
    battleService:UpdateTeamHPLogic(teamEntity)
    local buffResult = BuffResultChangeAttributeBasedOnDamage:New(e:GetID(), damageInfoRecover, ret)
    return buffResult
  end
end
