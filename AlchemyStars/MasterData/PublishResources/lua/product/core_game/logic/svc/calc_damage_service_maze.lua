require("calc_damage_svc_l")
_class("CalcDamageServiceMaze", CalcDamageService)
CalcDamageServiceMaze = CalcDamageServiceMaze

function CalcDamageServiceMaze:Constructor(world)
end

function CalcDamageServiceMaze:GetTeamLogicHP(teamEntity)
  local petList = teamEntity:Team():GetTeamPetEntities()
  local teamHP, teamMaxHP = 0, 0
  for i, entity in ipairs(petList) do
    local attrCmpt = entity:Attributes()
    local maxHp = attrCmpt:CalcMaxHp()
    local curHP = attrCmpt:GetCurrentHP()
    teamHP = curHP + teamHP
    teamMaxHP = teamMaxHP + maxHp
  end
  return teamHP, teamMaxHP
end

function CalcDamageServiceMaze:_DoDamageModifyHP(attacker, defender, damageInfo, ignoreShield)
  if defender:HasTeam() then
    self:_CalcTeamHP(attacker, defender, damageInfo)
  elseif defender:HasPetPstID() and not defender:HasPetDeadMark() then
    self:_CalcDamageOnHP(attacker, defender, damageInfo)
    self:_ModifyDefenderHP(defender, damageInfo)
    local team = defender:Pet():GetOwnerTeamEntity()
    self:_ModifyDefenderHP(team, damageInfo)
  else
    self:_CalcDamageOnHP(attacker, defender, damageInfo)
    self:_ModifyDefenderHP(defender, damageInfo)
  end
end

function CalcDamageServiceMaze:_CalcTeamHP(attacker, team, damageInfo)
  self:_CalcDamageOnHP(attacker, team, damageInfo)
  local damageOnHP = -damageInfo:GetChangeHP()
  local count = self:GetAlivePetCount(team)
  local returnHP = 0
  if 0 < damageOnHP then
    local curDamage = math.floor(damageOnHP / count + 0.5)
    if curDamage <= 0 then
      curDamage = 1
    end
    local entitiesList = team:Team():GetTeamPetEntities()
    for id, defender in ipairs(entitiesList) do
      if not defender:HasPetDeadMark() then
        local afterDamagePercent = defender:Attributes():GetAttribute("AfterDamage") or 0
        local afterDamage = curDamage * (1 + afterDamagePercent)
        damageInfo:SetDamageValue(afterDamage)
        self:_CalcDamageOnHP(attacker, defender, damageInfo)
        damageInfo:AddMazeDamage(defender:GetID(), damageInfo:GetChangeHP())
        self:_ModifyDefenderHP(defender, damageInfo)
        self:_ModifyDefenderHP(team, damageInfo)
      end
    end
  end
end

function CalcDamageServiceMaze:GetAlivePetCount(teamEntity)
  local petEntityList = teamEntity:Team():GetTeamPetEntities()
  local count = 0
  for _, entity in ipairs(petEntityList) do
    if not entity:HasPetDeadMark() then
      count = count + 1
    end
  end
  return count
end

function CalcDamageServiceMaze:_DoAddTargetMaxHP(defender, addValue, modifyID)
  local ret = {}
  defender:Attributes():Modify("MaxHPConstantFix", addValue, modifyID)
  ret[defender:GetID()] = defender:Attributes():CalcMaxHp()
  if defender:HasTeam() then
    self:_AddTeamMaxHP(defender, addValue, modifyID, ret)
  elseif defender:HasPetPstID() then
    local teamEntity = defender:Pet():GetOwnerTeamEntity()
    teamEntity:Attributes():Modify("MaxHPConstantFix", addValue, modifyID)
    ret[teamEntity:GetID()] = teamEntity:Attributes():CalcMaxHp()
    local buffLogicService = self._world:GetService("BuffLogic")
    buffLogicService:FixGreyHPVal(defender)
    buffLogicService:FixGreyHPVal(teamEntity)
  end
  return ret
end

function CalcDamageServiceMaze:_AddTeamMaxHP(teamEntity, addValue, modifyID, ret)
  local petEntityList = teamEntity:Team():GetTeamPetEntities()
  local petCount = self:GetAlivePetCount(teamEntity)
  local addHPMax = math.floor(addValue / petCount + 0.5)
  for _, entity in ipairs(petEntityList) do
    if not entity:HasPetDeadMark() then
      entity:Attributes():Modify("MaxHPConstantFix", addHPMax, modifyID)
      ret[entity:GetID()] = entity:Attributes():CalcMaxHp()
      self._world:GetService("BuffLogic"):FixGreyHPVal(entity)
    end
  end
end

function CalcDamageServiceMaze:_DoAddTargetHP(defenderEntity, damageInfo)
  if defenderEntity:HasTeam() then
    self:_CalcTeamAddHPValue(defenderEntity, damageInfo)
  elseif defenderEntity:HasPetPstID() then
    self:_CalcPetAddHPValue(defenderEntity, damageInfo)
  else
    CalcDamageServiceMaze.super._DoAddTargetHP(self, defenderEntity, damageInfo)
  end
end

function CalcDamageServiceMaze:_CalcTeamAddHPValue(teamEntity, damageInfo)
  local petEntityList = teamEntity:Team():GetTeamPetEntities()
  local petCount = self:GetAlivePetCount(teamEntity)
  local addHP = damageInfo:GetDamageValue()
  local totalAddHP = 0
  addHP = math.floor(addHP / petCount + 0.5)
  for _, entity in ipairs(petEntityList) do
    if not entity:HasPetDeadMark() then
      damageInfo:AddMazeDamage(entity:GetID(), addHP)
      damageInfo:SetChangeHP(addHP)
      totalAddHP = totalAddHP + addHP
      self:_ModifyDefenderHP(entity, damageInfo)
    end
  end
  damageInfo:SetChangeHP(totalAddHP)
  self:_ModifyDefenderHP(teamEntity, damageInfo)
end

function CalcDamageServiceMaze:_CalcPetAddHPValue(defenderEntity, damageInfo)
  local team = defenderEntity:Pet():GetOwnerTeamEntity()
  local addHP = damageInfo:GetDamageValue()
  if not defenderEntity:HasPetDeadMark() then
    damageInfo:AddMazeDamage(defenderEntity:GetID(), addHP)
    damageInfo:SetChangeHP(addHP)
    self:_ModifyDefenderHP(defenderEntity, damageInfo)
    self:_ModifyDefenderHP(team, damageInfo)
  end
end

function CalcDamageServiceMaze:SubTargetHPPercent(casterEntity, targetEntity, percent, byMaxHP, ignoreShield)
  if targetEntity:HasPetPstID() then
    local teamEntity = targetEntity:Pet():GetOwnerTeamEntity()
    local petEntityList = teamEntity:Team():GetTeamPetEntities()
    local damageInfo = DamageInfo:New(0, DamageType.Real)
    for _, entity in ipairs(petEntityList) do
      if not entity:HasPetDeadMark() then
        local tmpDamageInfo = CalcDamageServiceMaze.super._DoSubTargetHPPercent(self, casterEntity, entity, percent, byMaxHP)
        damageInfo:AddMazeDamage(entity:GetID(), tmpDamageInfo:GetChangeHP())
        if entity:GetID() == targetEntity:GetID() then
          damageInfo:SetDamageValue(tmpDamageInfo:GetDamageValue())
          damageInfo:SetChangeHP(tmpDamageInfo:GetChangeHP())
        end
      end
    end
    return damageInfo
  else
    return CalcDamageServiceMaze.super.SubTargetHPPercent(self, casterEntity, targetEntity, percent, byMaxHP)
  end
end
