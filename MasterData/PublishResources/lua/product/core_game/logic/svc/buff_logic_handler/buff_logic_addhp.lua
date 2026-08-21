_class("BuffLogicAddHP", BuffLogicBase)
BuffLogicAddHP = BuffLogicAddHP

function BuffLogicAddHP:Constructor(buffInstance, logicParam)
  self._mulValue = logicParam.mulValue or 0
  self._addValue = logicParam.addValue or 0
  self._baseType = logicParam.baseType or 1
  self._singlePet = logicParam.singlePet or 0
  self._ignoreForbidCure = logicParam.ignoreForbidCure or 0
  self._restoreToMaxHPPercent = logicParam.restoreToMaxHPPercent or 0
end

function BuffLogicAddHP:DoLogic(notify)
  local e = self._buffInstance:Entity()
  local attrCmpt = e:Attributes()
  local max_hp = attrCmpt:CalcMaxHp()
  local cur_hp = attrCmpt:GetCurrentHP()
  if cur_hp <= 0 then
    return
  end
  if self._entity:PetPstID() and self._baseType == 2 then
    local pstId = self._entity:PetPstID():GetPstID()
    local petData = self._world:GetPetData(pstId)
    max_hp = petData:GetPetHealth()
  end
  local baseValue = max_hp
  if self._baseType == 3 then
    baseValue = max_hp - cur_hp
  elseif self._baseType == 4 then
    baseValue = cur_hp
  end
  if e:HasDeadMark() or e:HasPetDeadMark() then
    return
  end
  local rate = e:Attributes():GetAttribute("AddBloodRate") or 0
  local add_value = 0
  local damageType = DamageType.Recover
  if 0 < self._restoreToMaxHPPercent then
    add_value = baseValue * self._restoreToMaxHPPercent - cur_hp
  else
    add_value = baseValue * self._mulValue + self._addValue
    if 0 <= self._mulValue and 0 <= self._addValue then
      add_value = add_value * (1 + rate)
    end
  end
  add_value = math.floor(add_value)
  Log.debug("BuffLogicAddHP TargetID=", self._entity:GetID(), "add_value=", add_value, " baseValue=", baseValue, " mulValue=", self._mulValue, " AddBloodRate=", rate)
  if 0 <= add_value then
    self._world:GetMatchLogger():BeginBuff(self._entity:GetID(), self._buffInstance:BuffID())
    local logger = self._world:GetMatchLogger()
    logger:AddBloodLog(self._entity:GetID(), {
      key = "CalcAddBlood",
      desc = "BUFF加血 攻击者[attacker] 被击者[defender] 加血量[blood] 回血系数[rate] 回血比例[mulValue] 回血加值[addValue]",
      attacker = self._entity:GetID(),
      defender = self._entity:GetID(),
      blood = add_value,
      rate = rate,
      mulValue = self._mulValue,
      addValue = self._addValue
    })
    self._world:GetMatchLogger():EndBuff(self._entity:GetID())
  end
  if max_hp < add_value + cur_hp then
    add_value = max_hp - cur_hp
  end
  if self._ignoreForbidCure == 0 then
    local teamEntity
    if e:HasTeam() then
      teamEntity = e
    elseif e:HasPet() then
      teamEntity = e:Pet():GetOwnerTeamEntity()
    end
    if 0 < add_value then
      if teamEntity and teamEntity:Attributes():GetAttribute("BuffForbidCure") then
        return
      elseif e:Attributes():GetAttribute("BuffForbidCure") then
        return
      end
    end
  end
  if add_value < 0 then
    damageType = DamageType.Real
    add_value = -add_value
  end
  local calcDamage = self._world:GetService("CalcDamage")
  local damageInfo = DamageInfo:New(add_value, damageType)
  damageInfo:SetSinglePet(self._singlePet)
  if damageType == DamageType.Recover then
    local addHPTargetEntity = e
    if e:HasPet() then
      addHPTargetEntity = e:Pet():GetOwnerTeamEntity()
    end
    calcDamage:AddTargetHP(addHPTargetEntity:GetID(), damageInfo)
  else
    local logger = self._world:GetMatchLogger()
    logger:BeginDamageLog(e:GetID(), e:GetID())
    calcDamage:_DoDamageModifyHP(e, e, damageInfo)
    logger:EndDamageLog(e:GetID())
  end
  local buffLogicService = self._world:GetService("BuffLogic")
  local curHPShield = buffLogicService:GetHPShield(e)
  damageInfo:SetHPShield(curHPShield)
  local result = BuffResultAddHP:New(damageInfo)
  if notify then
    if notify:GetNotifyType() == NotifyType.MonsterBeHit then
      local skillID = notify:GetSkillID()
      if skillID then
        local configService = self._world:GetService("Config")
        local skillConfigData = configService:GetSkillConfigData(skillID)
        local cfgEffectArray = skillConfigData:GetSkillEffect()
        for index, cfgEffectParam in ipairs(cfgEffectArray) do
          if cfgEffectParam:GetEffectType() == SkillEffectType.Teleport then
            result:SetMatchPass(true)
            break
          end
        end
      end
      result:SetNotifyAttackerPos(notify:GetAttackPos())
      result:SetNotifyDefenderPos(notify:GetTargetPos())
      result:SetNotifyAttackerID(notify:GetAttackerEntity():GetID())
      result:SetNotifyDefenderID(notify:GetDefenderEntity():GetID())
    end
    if notify:GetNotifyType() == NotifyType.TeamEachMoveEnd then
      local notifyPos = notify:GetPos()
      result:SetNotifyPos(notifyPos)
      result:SetNotifyEntityID(notify:GetEntityID())
    end
    if notify:GetNotifyType() == NotifyType.TeamLeaderEachMoveEnd or notify:GetNotifyType() == NotifyType.TeamLeaderEachMoveStart then
      local notifyPos = notify:GetPos()
      result:SetNotifyPos(notifyPos)
      result:SetNotifyEntityID(notify:GetEntityID())
    end
    if notify:GetNotifyType() == NotifyType.MonsterMoveOneFinish then
      local notifyPos = notify:GetWalkPos()
      result:SetNotifyPos(notifyPos)
      local monsterEntityID = notify:GetNotifyEntity():GetID()
      result:SetNotifyEntityID(monsterEntityID)
    end
    if notify:GetNotifyType() == NotifyType.MonsterDead then
      local monsterEntity = notify:GetNotifyEntity()
      if monsterEntity then
        local monsterEntityID = monsterEntity:GetID()
        result:SetNotifyEntityID(monsterEntityID)
      end
    end
  end
  return result
end

function BuffLogicAddHP:DoOverlap(logicParam)
  return self:DoLogic()
end
