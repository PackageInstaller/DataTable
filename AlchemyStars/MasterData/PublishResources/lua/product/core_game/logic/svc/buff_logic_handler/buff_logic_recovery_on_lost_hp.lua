require("buff_logic_base")
_class("BuffLogicRecoveryOnLostHP", BuffLogicBase)
BuffLogicRecoveryOnLostHP = BuffLogicRecoveryOnLostHP

function BuffLogicRecoveryOnLostHP:Constructor(instance, param)
  self._mulValue = param.mulValue or 0
  self._maxRate = param.maxRate or 0
  self._onlyOwner = param.onlyOwner
end

function BuffLogicRecoveryOnLostHP:DoLogic()
  local e = self._buffInstance:Entity()
  local matchType = self._world:MatchType()
  if not e:HasPetPstID() then
    return
  end
  local teamEntity = e:Pet():GetOwnerTeamEntity()
  local casterEntity
  if not self._onlyOwner then
    if not self._buffInstance:Context().casterEntity then
      return
    end
    casterEntity = self._buffInstance:Context().casterEntity
  else
    casterEntity = e
  end
  if teamEntity and teamEntity:Attributes():GetAttribute("BuffForbidCure") then
    return
  elseif e:Attributes():GetAttribute("BuffForbidCure") then
    return
  end
  local addHPTargetEntity = e
  if e:HasPet() then
    addHPTargetEntity = e:Pet():GetOwnerTeamEntity()
  end
  local add_value = 0
  if self._onlyOwner then
    local maxHP
    add_value, maxHP = self:CalcOnlyOwnerAddHP(e)
    addHPTargetEntity = e
    local max = math.floor(maxHP * self._maxRate)
    add_value = math.min(max, add_value)
  else
    if matchType ~= MatchType.MT_Maze and self._world:MatchType(GetMatchTypeType.SeasonMazeWorldBoss) ~= MatchType.MT_SeasonMaze then
      e = teamEntity
      local attrCmpt = teamEntity:Attributes()
      local max_hp = attrCmpt:CalcMaxHp()
      local cur_hp = teamEntity:Attributes():GetCurrentHP()
      add_value = math.floor((max_hp - cur_hp) * self._mulValue)
    else
      local globalPetEntities = teamEntity:Team():GetTeamPetEntities()
      for _, pet in ipairs(globalPetEntities) do
        local cAttribute = pet:Attributes()
        local max_hp = cAttribute:CalcMaxHp()
        local cur_hp = cAttribute:GetCurrentHP()
        add_value = add_value + math.floor((max_hp - cur_hp) * self._mulValue)
      end
    end
    local max = math.floor(casterEntity:Attributes():CalcMaxHp() * self._maxRate)
    add_value = math.min(max, add_value)
  end
  local calcDamage = self._world:GetService("CalcDamage")
  local damageInfo = DamageInfo:New(add_value, DamageType.Recover)
  calcDamage:AddTargetHP(addHPTargetEntity:GetID(), damageInfo)
  local res = BuffResultRecoveryOnLostHP:New(damageInfo)
  return res
end

function BuffLogicRecoveryOnLostHP:CalcOnlyOwnerAddHP(casterEntity)
  local battleSvc = self._world:GetService("Battle")
  local curHP, maxHP = battleSvc:GetCasterHP(casterEntity)
  local add_value = math.floor((maxHP - curHP) * self._mulValue)
  return add_value, maxHP
end
