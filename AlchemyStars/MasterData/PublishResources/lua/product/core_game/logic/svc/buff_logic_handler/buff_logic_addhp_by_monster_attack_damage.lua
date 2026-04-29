_class("BuffLogicAddHPByMonsterAttackDamage", BuffLogicBase)
BuffLogicAddHPByMonsterAttackDamage = BuffLogicAddHPByMonsterAttackDamage

function BuffLogicAddHPByMonsterAttackDamage:Constructor(buffInstance, logicParam)
  self._addPercent = logicParam.addPercent or 0
  self._checkMonsterIDList = logicParam.checkMonsterIDList
end

function BuffLogicAddHPByMonsterAttackDamage:DoLogic(notify)
  local casterEntity = self._buffInstance:Entity()
  local e = casterEntity
  local rate = e:Attributes():GetAttribute("AddBloodRate") or 0
  if casterEntity:PetPstID() then
    e = casterEntity:Pet():GetOwnerTeamEntity()
  end
  if e:Attributes():GetCurrentHP() == 0 then
    return
  end
  if e:Attributes():GetAttribute("BuffForbidCure") then
    return
  end
  local attrCmpt = casterEntity:Attributes()
  local max_hp = attrCmpt:CalcMaxHp()
  if casterEntity:PetPstID() then
    local pstId = casterEntity:PetPstID():GetPstID()
    local petData = self._world:GetPetData(pstId)
    max_hp = petData:GetPetHealth()
  end
  local damage = 0
  local sourceEntityID, sourceEntity
  if notify:GetNotifyType() == NotifyType.MonsterAttackOrSkillDamageEnd then
    local dmgNotify = notify
    damage = dmgNotify:GetDamage()
    sourceEntity = dmgNotify:GetNotifyEntity()
    if sourceEntity then
      sourceEntityID = sourceEntity:GetID()
    end
  end
  if damage <= 0 then
    return
  end
  local sourceCheckOk = false
  if self._checkMonsterIDList and 0 < #self._checkMonsterIDList then
    if sourceEntity and sourceEntity:HasMonsterID() then
      local monsterTemplateID = sourceEntity:MonsterID():GetMonsterID()
      if table.icontains(self._checkMonsterIDList, monsterTemplateID) then
        sourceCheckOk = true
      end
    end
  else
    sourceCheckOk = true
  end
  if not sourceCheckOk then
    return
  end
  local add_value = 0
  add_value = damage * self._addPercent
  local damageType = DamageType.Recover
  add_value = add_value * (1 + rate)
  local svc = self._world:GetService("CalcDamage")
  local damageInfo = DamageInfo:New(add_value, damageType)
  svc:AddTargetHP(e:GetID(), damageInfo)
  local res = BuffResultAddHPByMonsterAttackDamage:New(damageInfo, e:GetID(), sourceEntityID)
  return res
end
