_class("BuffLogicAddHPByMoveNotify", BuffLogicBase)
BuffLogicAddHPByMoveNotify = BuffLogicAddHPByMoveNotify

function BuffLogicAddHPByMoveNotify:Constructor(buffInstance, logicParam)
  self._mulValue = logicParam.mulValue or 0
  self._addValue = logicParam.addValue or 0
  self._headOut = logicParam.headout == 1
  self._baseType = logicParam.baseType or 1
  self._delay = logicParam.delay or 0
end

function BuffLogicAddHPByMoveNotify:DoLogic(notify)
  local e = self._buffInstance:Entity()
  if notify then
    if notify:GetNotifyType() ~= NotifyType.EntityMoveEnd and notify:GetNotifyType() ~= NotifyType.PlayerEachMoveEnd then
      return
    end
  else
    return
  end
  if notify:GetNotifyType() == NotifyType.EntityMoveEnd then
    local parentNotifyType = notify:GetParentNotifyType()
    if parentNotifyType == NotifyType.HitBackEnd or parentNotifyType == NotifyType.Teleport or parentNotifyType == NotifyType.DimensionTransport or parentNotifyType == NotifyType.TractionEnd or parentNotifyType == NotifyType.TransportEachMoveEnd or parentNotifyType == NotifyType.ForceMovement then
    else
      return
    end
  end
  local moveLength = self:_CalcMoveLength(notify)
  if moveLength <= 0 then
    return
  end
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
  local times = moveLength
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
  self._world:GetMatchLogger():BeginBuff(self._entity:GetID(), self._buffInstance:BuffID())
  local logger = self._world:GetMatchLogger()
  logger:AddBloodLog(self._entity:GetID(), {
    key = "CalcAddBlood",
    desc = "BUFF加血 攻击者[attacker] 被击者[defender] 加血量[blood] 回血系数[rate] 回血比例[mulValue] 回血加值[addValue] 距离[moveLength]",
    attacker = self._entity:GetID(),
    defender = self._entity:GetID(),
    blood = add_value,
    rate = rate,
    mulValue = self._mulValue,
    addValue = self._addValue,
    moveLength = moveLength
  })
  self._world:GetMatchLogger():EndBuff(self._entity:GetID())
  local res = BuffResultAddHPByMoveNotify:New(damageInfo, self._headOut, self._delay)
  local posNew = notify:GetPosNew()
  res:SetPosNew(posNew)
  return res
end

function BuffLogicAddHPByMoveNotify:_CalcMoveLength(notify)
  local utilCalcSvc = self._world:GetService("UtilCalc")
  local length = 0
  if notify:GetNotifyType() == NotifyType.EntityMoveEnd then
    local parentNotifyType = notify:GetParentNotifyType()
    if parentNotifyType == NotifyType.HitBackEnd or parentNotifyType == NotifyType.Teleport or parentNotifyType == NotifyType.DimensionTransport or parentNotifyType == NotifyType.TractionEnd or parentNotifyType == NotifyType.TransportEachMoveEnd or parentNotifyType == NotifyType.ForceMovement then
      local posNew = notify:GetPosNew()
      local posOld = notify:GetPosOld()
      if posNew and posOld then
        local ringNum = utilCalcSvc:GetGridRingNum(posNew, posOld)
        length = ringNum
      end
    end
  elseif notify:GetNotifyType() == NotifyType.PlayerEachMoveEnd then
    length = 1
  end
  return length
end
