require("buff_type")
require("buff_logic_base")
_class("BuffLogicAddPetHpAtkDef", BuffLogicBase)
BuffLogicAddPetHpAtkDef = BuffLogicAddPetHpAtkDef

function BuffLogicAddPetHpAtkDef:Constructor(buffInstance, logicParam)
  self._addedHPPercent = logicParam.addedHPPercent or 0
  self._addedAtkPercent = logicParam.addedAtkPercent or 0
  self._addedDefPercent = logicParam.addedDefPercent or 0
  self._entity = buffInstance:Entity()
end

function BuffLogicAddPetHpAtkDef:DoLogic()
  local pstId = self._entity:PetPstID():GetPstID()
  local petData = self._world:GetPetData(pstId)
  local hp = petData:GetPetHealth()
  local atk = petData:GetPetAttack()
  local def = petData:GetPetDefence()
  local hpAdded = math.floor(self._addedHPPercent * hp)
  local atkAdded = math.floor(self._addedAtkPercent * atk)
  local defAdded = math.floor(self._addedDefPercent * def)
  local teamEntity = self._entity:Pet():GetOwnerTeamEntity()
  local attributeComponent = self._entity:Attributes()
  local targetEntity = self._entity
  local buffLogicService = self._world:GetService("BuffLogic")
  local buffSeqID = self:GetBuffSeq()
  buffLogicService:ChangeBaseAttack(targetEntity, buffSeqID, ModifyBaseAttackType.AttackPercentage, self._addedAtkPercent)
  buffLogicService:ChangeBaseDefence(targetEntity, buffSeqID, ModifyBaseDefenceType.DefencePercentage, self._addedDefPercent)
  attributeComponent:Modify("MaxHPConstantFix", hpAdded, buffSeqID)
  local damageInfo = DamageInfo:New(hpAdded, DamageType.Recover)
  local svc = self._world:GetService("CalcDamage")
  svc:AddTargetHP(self._entity, damageInfo)
  local battleService = self._world:GetService("Battle")
  battleService:UpdateTeamHPLogic(teamEntity)
  battleService:UpdateTeamDefenceLogic(teamEntity)
  local buffResult = BuffResultAddPetHpAtkDef:New(hpAdded, atkAdded, defAdded, damageInfo)
  return buffResult
end
