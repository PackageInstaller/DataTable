_class("BuffLogicPSPAddHPByType", BuffLogicBase)
BuffLogicPSPAddHPByType = BuffLogicPSPAddHPByType

function BuffLogicPSPAddHPByType:Constructor(buffInstance, logicParam)
  self._mulValue = logicParam.mulValue or 0
  self._modifyType = logicParam.modifyType
end

function BuffLogicPSPAddHPByType:DoLogic(notify)
  local casterEntity = self._buffInstance:Entity()
  local context = self._buffInstance:Context()
  if context then
    casterEntity = context.casterEntity
  end
  local e = casterEntity
  if casterEntity:PetPstID() then
    e = casterEntity:Pet():GetOwnerTeamEntity()
  end
  if e:Attributes():GetCurrentHP() == 0 then
    return
  end
  if e:Attributes():GetAttribute("BuffForbidCure") then
    return
  end
  local popStarProSvc = self._world:GetService("PopStarProLogic")
  if not popStarProSvc then
    return
  end
  local count = popStarProSvc:GetCountByModifyType(self._modifyType)
  if count == 0 then
    return
  end
  local attrCmpt = casterEntity:Attributes()
  local maxHP = attrCmpt:CalcMaxHp()
  if casterEntity:PetPstID() then
    local pstId = casterEntity:PetPstID():GetPstID()
    local petData = self._world:GetPetData(pstId)
    maxHP = petData:GetPetHealth()
  end
  local addVal = math.floor(maxHP * self._mulValue * count + 0.5)
  local svc = self._world:GetService("CalcDamage")
  local damageInfo = DamageInfo:New(addVal, DamageType.Recover)
  svc:AddTargetHP(e:GetID(), damageInfo)
  local res = BuffResultPSPAddHPByType:New(damageInfo, e:GetID())
  return res
end
