require("buff_type")
require("buff_logic_base")
_class("BuffLogicStealPetAttributes", BuffLogicBase)
BuffLogicStealPetAttributes = BuffLogicStealPetAttributes

function BuffLogicStealPetAttributes:Constructor(buffInstance, logicParam)
  self.hpPercent = logicParam.hpPercent or 0
  self.atkPercent = logicParam.atkPercent or 0
  self.defPercent = logicParam.defPercent or 0
end

function BuffLogicStealPetAttributes:DoLogic(notify)
  local entity = self._buffInstance:Entity()
  if entity:HasDeadMark() or entity:HasPetDeadMark() then
    return
  end
  local buffSeqID = self:GetBuffSeq()
  local casterEntity = self._buffInstance:Context() and self._buffInstance:Context().casterEntity or nil
  local teamEntity
  local battleService = self._world:GetService("Battle")
  if entity:HasPetPstID() then
    local pstId = entity:PetPstID():GetPstID()
    local petData = self._world:GetPetData(pstId)
    local atk = petData:GetPetAttack()
    local def = petData:GetPetDefence()
    teamEntity = entity:Pet():GetOwnerTeamEntity()
    local atkChange = math.floor(self.atkPercent * atk)
    local defChange = math.floor(self.defPercent * def)
    self._buffLogicService:ChangeBaseAttack(entity, buffSeqID, ModifyBaseAttackType.AttackConstantFix, -atkChange)
    self._buffLogicService:ChangeBaseAttack(casterEntity, buffSeqID, ModifyBaseAttackType.AttackConstantFix, atkChange)
    self._buffLogicService:ChangeBaseDefence(entity, buffSeqID, ModifyBaseDefenceType.DefenceConstantFix, -defChange)
    self._buffLogicService:ChangeBaseDefence(casterEntity, buffSeqID, ModifyBaseDefenceType.DefenceConstantFix, defChange)
    battleService:UpdateTeamDefenceLogic(teamEntity)
  end
  if entity:HasTeam() and self.hpPercent ~= 0 then
    teamEntity = entity
    local attributeComponent = teamEntity:Attributes()
    local maxHpBase = attributeComponent:GetAttribute("MaxHP")
    local hpReduceCeiling = math.floor(self.hpPercent * maxHpBase)
    local maxHp = attributeComponent:CalcMaxHp()
    local curHp = attributeComponent:GetCurrentHP()
    local curHpPercent = math.floor(curHp / maxHp * 10000 + 0.5) / 10000
    local newHPMax = maxHp - hpReduceCeiling
    if newHPMax < 1 then
      newHPMax = 1
      hpReduceCeiling = maxHp - newHPMax
    end
    if hpReduceCeiling ~= 0 then
      local newHp = math.floor(newHPMax * curHpPercent)
      if newHp < 1 then
        newHp = 1
      end
      self._buffLogicService:ChangeBaseMaxHP(teamEntity, buffSeqID, ModifyBaseMaxHPType.MaxHPConstantFix, -hpReduceCeiling)
      attributeComponent:Modify("HP", newHp)
      battleService:UpdateTeamHPLogic(teamEntity)
      local hpDamage = curHp - newHp
      local casterAttributeCmpt = casterEntity:Attributes()
      local maxHpCaster = casterAttributeCmpt:CalcMaxHp()
      local curHpCaster = casterAttributeCmpt:GetCurrentHP()
      self._buffLogicService:ChangeBaseMaxHP(casterEntity, buffSeqID, ModifyBaseMaxHPType.MaxHPConstantFix, hpReduceCeiling)
      local newHpCaster = curHpCaster + hpReduceCeiling
      local newHPMaxCaster = maxHpCaster + hpReduceCeiling
      casterAttributeCmpt:Modify("HP", newHpCaster)
      local buffResult = BuffResultStealPetAttributes:New(newHp, newHPMax, newHpCaster, newHPMaxCaster)
      return buffResult
    end
  end
end

_class("BuffLogicResetStealPetAttributes", BuffLogicBase)
BuffLogicResetStealPetAttributes = BuffLogicResetStealPetAttributes

function BuffLogicResetStealPetAttributes:Constructor(buffInstance, logicParam)
  self.hpPercent = logicParam.hpPercent or 0
  self.atkPercent = logicParam.atkPercent or 0
  self.defPercent = logicParam.defPercent or 0
end

function BuffLogicResetStealPetAttributes:DoLogic()
  local entity = self._buffInstance:Entity()
  if entity:HasDeadMark() or entity:HasPetDeadMark() then
    return
  end
  local casterEntity = self._buffInstance:Context() and self._buffInstance:Context().casterEntity or nil
  local teamEntity
  local buffSeqID = self:GetBuffSeq()
  local calcDamageService = self._world:GetService("CalcDamage")
  local battleService = self._world:GetService("Battle")
  if entity:HasPetPstID() then
    self._buffLogicService:RemoveBaseAttack(entity, buffSeqID, ModifyBaseAttackType.AttackConstantFix)
    self._buffLogicService:RemoveBaseDefence(entity, buffSeqID, ModifyBaseDefenceType.DefenceConstantFix)
    teamEntity = entity:Pet():GetOwnerTeamEntity()
    self._buffLogicService:RemoveBaseAttack(casterEntity, buffSeqID, ModifyBaseAttackType.AttackConstantFix)
    self._buffLogicService:RemoveBaseDefence(casterEntity, buffSeqID, ModifyBaseDefenceType.DefenceConstantFix)
    battleService:UpdateTeamDefenceLogic(teamEntity)
  end
  if entity:HasTeam() then
    teamEntity = entity
    local teamModifier = self._buffLogicService:_GetAttributeModifier(teamEntity, "MaxHPConstantFix")
    if not teamModifier then
      return
    end
    local alreadyAbsorbValue = teamModifier:GetModifyValue(buffSeqID)
    local attributeComponent = teamEntity:Attributes()
    local maxHp = attributeComponent:CalcMaxHp()
    local curHp = attributeComponent:GetCurrentHP()
    local curHpPercent = math.floor(curHp / maxHp * 10000 + 0.5) / 10000
    local newHPMax = maxHp - alreadyAbsorbValue
    local newHp = math.floor(newHPMax * curHpPercent)
    attributeComponent:Modify("HP", newHp)
    self._buffLogicService:RemoveBaseMaxHP(teamEntity, buffSeqID, ModifyBaseMaxHPType.MaxHPConstantFix)
    battleService:UpdateTeamHPLogic(teamEntity)
    local casterAttributeCmpt = casterEntity:Attributes()
    local maxHpCaster = casterAttributeCmpt:CalcMaxHp()
    local curHpCaster = casterAttributeCmpt:GetCurrentHP()
    self._buffLogicService:RemoveBaseMaxHP(casterEntity, buffSeqID, ModifyBaseMaxHPType.MaxHPConstantFix)
    local newHpCaster = curHpCaster + alreadyAbsorbValue
    local newHPMaxCaster = maxHpCaster + alreadyAbsorbValue
    casterAttributeCmpt:Modify("HP", newHpCaster)
    local buffResult = BuffResultResetStealPetAttributes:New(newHp, newHPMax, newHpCaster, newHPMaxCaster)
    return buffResult
  end
end
