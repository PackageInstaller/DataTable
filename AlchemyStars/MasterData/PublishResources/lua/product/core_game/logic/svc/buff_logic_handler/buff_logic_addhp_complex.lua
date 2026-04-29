_class("BuffLogicAddHPComplex", BuffLogicBase)
BuffLogicAddHPComplex = BuffLogicAddHPComplex

function BuffLogicAddHPComplex:Constructor(buffInstance, logicParam)
  self._mulValue = logicParam.mulValue or 0
  self._addValue = logicParam.addValue or 0
  self._headOut = logicParam.headout == 1
  self._baseType = logicParam.baseType or 1
  self._delay = logicParam.delay or 0
end

function BuffLogicAddHPComplex:DoLogic(notify)
  local e = self._buffInstance:Entity()
  local attrCmpt = e:Attributes()
  local max_hp = attrCmpt:CalcMaxHp()
  if e:PetPstID() then
    if self._baseType == 2 then
      local pstId = e:PetPstID():GetPstID()
      local petData = self._world:GetPetData(pstId)
      max_hp = petData:GetPetHealth()
    elseif self._baseType == 3 then
      local pstId = e:PetPstID():GetPstID()
      local petData = self._world:GetPetData(pstId)
      max_hp = petData:GetPetAttack()
    elseif self._baseType == 4 then
      max_hp = attrCmpt:GetAttack()
    end
  end
  if self._baseType == 5 then
    max_hp = attrCmpt:CalcMaxHp() - attrCmpt:GetCurrentHP()
  end
  if e:PetPstID() then
    e = e:Pet():GetOwnerTeamEntity()
  end
  local cur_hp = e:Attributes():GetCurrentHP()
  if cur_hp <= 0 then
    return
  end
  if e:Attributes():GetAttribute("BuffForbidCure") then
    return
  end
  local times = 1
  if notify ~= nil and notify:GetNotifyType() == NotifyType.GridConvert and notify.GetConvertWaterCount then
    local bluePieceNum = notify:GetConvertWaterCount()
    if bluePieceNum and 0 < bluePieceNum then
      times = bluePieceNum
    end
  end
  local rate = e:Attributes():GetAttribute("AddBloodRate") or 0
  local add_value = 0
  add_value = max_hp * self._mulValue + self._addValue
  add_value = add_value * times
  add_value = add_value * (1 + rate)
  add_value = math.floor(add_value)
  local damageType = DamageType.Recover
  local svc = self._world:GetService("CalcDamage")
  local damageInfo = DamageInfo:New(add_value, damageType)
  local curHp = svc:AddTargetHP(e:GetID(), damageInfo)
  local res = BuffResultAddHPComplex:New(damageInfo, self._headOut, self._delay)
  if notify then
    if notify:GetNotifyType() == NotifyType.NotifyLayerChange then
      local n = notify
      res:SetLayerName(n:GetLayerName())
      res:SetLayerTotalCount(n:GetTotalCount())
    elseif notify:GetNotifyType() == NotifyType.NormalEachAttackEnd or notify:GetNotifyType() == NotifyType.ChainSkillEachAttackEnd then
      res.attacker = notify:GetAttackerEntity()
      res.defender = notify:GetDefenderEntity()
      res.attackPos = notify:GetAttackPos()
      res.targetPos = notify:GetTargetPos()
    end
  end
  return res
end
