require("calc_damage_svc_l")
_class("CalcDamageService_SeasonMaze", CalcDamageService)
CalcDamageService_SeasonMaze = CalcDamageService_SeasonMaze

function CalcDamageService_SeasonMaze:Constructor(world)
  self._calcDamageSvc = self._world:GetService("CalcDamage")
end

function CalcDamageService_SeasonMaze:GetTeamLogicHP(teamEntity)
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

function CalcDamageService_SeasonMaze:DoCalcDamage(attacker, defender, damageparam, ignoreShield, damageGridPos)
  if defender:HasTeam() then
    local damageInfo = self:_DoCalcDamageTeam(attacker, defender, damageparam, ignoreShield, damageGridPos)
    return damageInfo
  else
    local damageInfo = self._calcDamageSvc:DoCalcDamage(attacker, defender, damageparam, ignoreShield, damageGridPos)
    return damageInfo
  end
end

function CalcDamageService_SeasonMaze:_DoCalcDamageTeam(attacker, defender, damageparam, ignoreShield, damageGridPos)
  local damageInfo = DamageInfo:New(0, DamageType.Real)
  self:_DoCalcDamageTeamBefore(damageInfo, attacker, defender, damageparam, ignoreShield, damageGridPos)
  self:_DoCalcDamageTeamEachPet(damageInfo, attacker, defender, damageparam, ignoreShield, damageGridPos)
  self:_DoCalcDamageTeamAfter(damageInfo, attacker, defender, damageparam, ignoreShield, damageGridPos)
  return damageInfo
end

function CalcDamageService_SeasonMaze:_DoCalcDamageTeamBefore(damageInfo, attacker, defenderTeam, damageparam, ignoreShield, damageGridPos)
  if defenderTeam:Attributes():GetAttribute("CanBeAttacked") == 0 then
    return DamageInfo:New(0, DamageType.Invalid)
  end
  local buffLogicService = self._world:GetService("BuffLogic")
  local shieldLayer = buffLogicService:GetBuffLayer(defenderTeam, BuffEffectType.LayerShield)
  damageInfo:SetShieldLayer(shieldLayer)
  local petList = defenderTeam:Team():GetTeamPetEntities()
  local alivePetCount = 0
  for id, entity in ipairs(petList) do
    if not entity:HasPetDeadMark() then
      alivePetCount = alivePetCount + 1
    end
  end
  local buffCmptTeam = defenderTeam:BuffComponent()
  local shield = buffCmptTeam:GetBuffValue("HPShield") or 0
  if shield ~= 0 then
    local petList = defenderTeam:Team():GetTeamPetEntities()
    local alivePetCount = 0
    for id, petEntity in ipairs(petList) do
      if not petEntity:HasPetDeadMark() then
        alivePetCount = alivePetCount + 1
      end
    end
    local eachShield = math.floor(shield / alivePetCount + 0.5)
    for i, petEntity in ipairs(petList) do
      if not petEntity:HasPetDeadMark() then
        local buffCmptPet = petEntity:BuffComponent()
        buffCmptPet:SetBuffValue("HPShield", eachShield)
      end
    end
    buffCmptTeam:SetBuffValue("HPShield", 0)
  end
end

function CalcDamageService_SeasonMaze:_DoCalcDamageTeamEachPet(damageInfo, attacker, defenderTeam, damageparam, ignoreShield, damageGridPos)
  if damageInfo:GetDamageType() == DamageType.Invalid then
    return
  end
  local teamDamageValue = 0
  local teamChangeHP = 0
  local petList = defenderTeam:Team():GetTeamPetEntities()
  for i, petEntity in ipairs(petList) do
    if not petEntity:HasPetDeadMark() then
      local curHpBefore = petEntity:Attributes():GetCurrentHP()
      if damageparam.formulaID == 130 and damageparam.hpPercent and attacker:HasPetPstID() then
        local maxHP = petEntity:Attributes():CalcMaxHp()
        local val = maxHP * damageparam.hpPercent
        damageparam.hp = val
      end
      local petDamageInfo = self:_DoCalcDamagePet(attacker, petEntity, damageparam, ignoreShield, damageGridPos)
      damageInfo:AddMazeTeamMemberDamageInfo(petEntity:GetID(), petDamageInfo)
      local curHpAfter = petEntity:Attributes():GetCurrentHP()
      teamDamageValue = teamDamageValue + petDamageInfo:GetDamageValue()
      local addChangeHp = petDamageInfo:GetChangeHP()
      if math.abs(curHpAfter - curHpBefore) < math.abs(addChangeHp) then
        addChangeHp = -math.abs(curHpAfter - curHpBefore)
      end
      teamChangeHP = teamChangeHP + addChangeHp
    end
  end
  damageInfo:SetDamageValue(teamDamageValue)
  damageInfo:SetChangeHP(teamChangeHP)
end

function CalcDamageService_SeasonMaze:_DoCalcDamageTeamAfter(damageInfo, attacker, defenderTeam, damageparam, ignoreShield, damageGridPos)
  if damageInfo:GetDamageType() == DamageType.Invalid then
    return
  end
  self:_ModifyDefenderHP(defenderTeam, damageInfo)
  local shield = 0
  local petList = defenderTeam:Team():GetTeamPetEntities()
  for i, petEntity in ipairs(petList) do
    if not petEntity:HasPetDeadMark() then
      local buffCmptPet = petEntity:BuffComponent()
      local eachShield = buffCmptPet:GetBuffValue("HPShield") or 0
      shield = shield + eachShield
      buffCmptPet:SetBuffValue("HPShield", 0)
    end
  end
  local buffCmptTeam = defenderTeam:BuffComponent()
  buffCmptTeam:SetBuffValue("HPShield", shield)
  if attacker:SkillContext() then
    attacker:SkillContext():AddDamage(defenderTeam:GetID(), damageInfo)
  end
end

function CalcDamageService_SeasonMaze:_DoCalcDamagePet(attacker, defender, damageparam, ignoreShield, damageGridPos)
  local formulaService = self._world:GetService("Formula")
  local buffLogicService = self._world:GetService("BuffLogic")
  local trapServiceLogic = self._world:GetService("TrapLogic")
  local logger = self._world:GetMatchLogger()
  logger:BeginDamageLog(attacker:GetID(), defender:GetID())
  local damage = 0
  local damageType = DamageType.Normal
  local skillID = damageparam.skillID
  local formulaID = damageparam.formulaID
  local attackPos = damageparam.attackPos
  local effectType = damageparam.skillEffectType
  formulaID = self:_ProcessFormulaID(formulaID, attacker, defender)
  local damageInfo = DamageInfo:New(damage, damageType)
  damageInfo:SetAttackerEntityID(attacker:GetID())
  damageInfo:SetTargetEntityID(defender:GetID())
  damageInfo:SetAttackPos(attackPos)
  damageInfo:SetSkillEffectType(effectType)
  damageInfo:SetSkillID(skillID)
  if damageparam.damageStatisticsAttackerEntityID then
    damageInfo:SetDamageStatisticsAttackerEntityID(damageparam.damageStatisticsAttackerEntityID)
  end
  damageType = buffLogicService:CheckCanBeDamage(attacker, defender, skillID, ignoreShield)
  damageInfo:SetDamageType(damageType)
  if damageType == DamageType.Normal then
    damage, damageType = formulaService:CalcDamageByFormulaID(attacker, defender, damageparam, formulaID, damageGridPos)
    damageInfo:SetDamageType(damageType)
    damageInfo:SetDamageValue(damage)
    self:CalcDamageElement(attacker, damageInfo)
    self:_DoDamageModifyHP(attacker, defender, damageInfo, ignoreShield)
  end
  self:_StatData(defender)
  logger:EndDamageLog(attacker:GetID())
  local curHP = defender:Attributes():GetCurrentHP()
  self._world:GetSyncLogger():Trace({
    key = "DoCalcDamage",
    attackerID = attacker:GetID(),
    defenderID = defender:GetID(),
    skillID = skillID,
    damageType = damageInfo:GetDamageType(),
    damageValue = damageInfo:GetDamageValue(),
    changeHP = damageInfo:GetChangeHP(),
    curHP = curHP
  })
  self:LogNotice("DoCalcDamage() attacker=", attacker:GetID(), " defender=", defender:GetID(), " skillID=", skillID, " damage=", damageInfo:GetDamageValue(), " changeHP=", damageInfo:GetChangeHP(), " curHP=", curHP)
  return damageInfo
end

function CalcDamageService_SeasonMaze:_DoDamageModifyHP(attacker, defender, damageInfo, ignoreShield)
  if defender:HasTeam() then
    self:_CalcTeamHP(attacker, defender, damageInfo)
  elseif defender:HasPetPstID() and not defender:HasPetDeadMark() then
    self:_CalcDamageOnHP(attacker, defender, damageInfo)
    self:_ModifyDefenderHP(defender, damageInfo)
  else
    self:_CalcDamageOnHP(attacker, defender, damageInfo)
    self:_ModifyDefenderHP(defender, damageInfo)
  end
end

function CalcDamageService_SeasonMaze:_CalcTeamHP(attacker, team, damageInfo)
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
        local damageInfoPet = DamageInfo:New()
        damageInfoPet:Clone(damageInfo)
        damageInfoPet:SetDamageValue(afterDamage)
        self:_CalcDamageOnHP(attacker, defender, damageInfoPet)
        damageInfo:AddMazeTeamMemberDamageInfo(defender:GetID(), damageInfoPet)
        self:_ModifyDefenderHP(defender, damageInfoPet)
      end
    end
    self:_ModifyDefenderHP(team, damageInfo)
  end
end

function CalcDamageService_SeasonMaze:GetAlivePetCount(teamEntity)
  local petEntityList = teamEntity:Team():GetTeamPetEntities()
  local count = 0
  for _, entity in ipairs(petEntityList) do
    if not entity:HasPetDeadMark() then
      count = count + 1
    end
  end
  return count
end

function CalcDamageService_SeasonMaze:_DoAddTargetMaxHP(defender, addValue, modifyID)
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

function CalcDamageService_SeasonMaze:_AddTeamMaxHP(teamEntity, addValue, modifyID, ret)
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

function CalcDamageService_SeasonMaze:_DoAddTargetHP(defenderEntity, damageInfo)
  if defenderEntity:HasTeam() then
    self:_CalcTeamAddHPValue(defenderEntity, damageInfo)
  elseif defenderEntity:HasPetPstID() then
    self:_CalcPetAddHPValue(defenderEntity, damageInfo)
  else
    CalcDamageService_SeasonMaze.super._DoAddTargetHP(self, defenderEntity, damageInfo)
  end
end

function CalcDamageService_SeasonMaze:_CalcTeamAddHPValue(teamEntity, damageInfo)
  local petEntityList = teamEntity:Team():GetTeamPetEntities()
  local petCount = self:GetAlivePetCount(teamEntity)
  local addHP = damageInfo:GetDamageValue()
  local totalAddHP = 0
  local eachAddHP = math.floor(addHP / petCount + 0.5)
  for _, entity in ipairs(petEntityList) do
    if not entity:HasPetDeadMark() then
      local damageInfoPet = DamageInfo:New()
      damageInfoPet:Clone(damageInfo)
      damageInfoPet:SetChangeHP(eachAddHP)
      damageInfoPet:SetDamageValue(eachAddHP)
      damageInfo:AddMazeTeamMemberDamageInfo(entity:GetID(), damageInfoPet)
      totalAddHP = totalAddHP + eachAddHP
      self:_ModifyDefenderHP(entity, damageInfoPet)
    end
  end
  damageInfo:SetChangeHP(totalAddHP)
  damageInfo:SetDamageValue(totalAddHP)
  self:_ModifyDefenderHP(teamEntity, damageInfo)
end

function CalcDamageService_SeasonMaze:_CalcPetAddHPValue(defenderEntity, damageInfo)
  local team = defenderEntity:Pet():GetOwnerTeamEntity()
  local addHP = damageInfo:GetDamageValue()
  if not defenderEntity:HasPetDeadMark() then
    local damageInfoPet = DamageInfo:New()
    damageInfoPet:Clone(damageInfo)
    damageInfoPet:SetChangeHP(addHP)
    damageInfoPet:SetDamageValue(addHP)
    damageInfo:AddMazeTeamMemberDamageInfo(defenderEntity:GetID(), damageInfoPet)
    damageInfo:SetChangeHP(addHP)
    self:_ModifyDefenderHP(defenderEntity, damageInfoPet)
    self:_ModifyDefenderHP(team, damageInfo)
  end
end

function CalcDamageService_SeasonMaze:SubTargetHPPercent(casterEntity, targetEntity, percent, byMaxHP, ignoreShield)
  return CalcDamageService_SeasonMaze.super._DoSubTargetHPPercent(self, casterEntity, targetEntity, percent, byMaxHP)
end
