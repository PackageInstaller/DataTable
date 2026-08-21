_class("CalcDamageService", BaseService)
CalcDamageService = CalcDamageService

function CalcDamageService:Constructor(_)
  self.__NTMonsterHPCChangeCount = 0
end

function CalcDamageService:GetTeamLogicHP(teamEntity)
  local teamAttrConmpt = teamEntity:Attributes()
  local teamHP = teamAttrConmpt:GetCurrentHP()
  local teamMaxHP = teamAttrConmpt:CalcMaxHp()
  return teamHP, teamMaxHP
end

function CalcDamageService:AddTargetMaxHP(defenderEntityID, addValue, modifyID)
  local defender = self._world:GetEntityByID(defenderEntityID)
  return self:_DoAddTargetMaxHP(defender, addValue, modifyID)
end

function CalcDamageService:_DoAddTargetMaxHP(defender, addValue, modifyID)
  local ret = {}
  if defender:HasPetPstID() then
    Log.error("_DoAddTargetMaxHP() CANNOT ADD HP TO PET!! addHP=", addValue, " defender=", defender:GetID())
    return ret
  end
  defender:Attributes():Modify("MaxHPConstantFix", addValue, modifyID)
  ret[defender:GetID()] = defender:Attributes():CalcMaxHp()
  self._world:GetService("BuffLogic"):FixGreyHPVal(defender)
  return ret
end

function CalcDamageService:DecreaseTargetMaxHP(eid, val, modifyID)
  val = val * -1
  local e = self._world:GetEntityByID(eid)
  if e:HasPetPstID() or e:HasTeam() then
    Log.exception("DecreaseTargetMaxHP: 该接口在设计时没有考虑给玩家使用。请在对过需求之后实现正确的逻辑。")
    return {}
  end
  return self:_DoDecreaseTargetMaxHP(e, val, modifyID)
end

function CalcDamageService:_DoDecreaseTargetMaxHP(e, val, modifyID)
  local ret = {}
  e:Attributes():Modify("MaxHPConstantFix", val, modifyID)
  ret[e:GetID()] = e:Attributes():CalcMaxHp()
  self._world:GetService("BuffLogic"):FixGreyHPVal(e)
  return ret
end

function CalcDamageService:AddTargetHP(defenderEntityID, damageInfo)
  local defender = self._world:GetEntityByID(defenderEntityID)
  assert(defender)
  local damageType = damageInfo:GetDamageType()
  assert(damageType == DamageType.Recover or damageType == DamageType.RecoverTransmit)
  self:_DoAddTargetHP(defender, damageInfo)
end

function CalcDamageService:_DoAddTargetHP(defender, damageInfo)
  local val = damageInfo:GetDamageValue()
  if defender:HasPetPstID() then
    Log.error("_DoAddTargetHP() CANNOT ADD HP TO PET!! addHP=", val, " defender=", defender:GetID())
    return
  end
  damageInfo:SetChangeHP(val)
  self:_ModifyDefenderHP(defender, damageInfo)
  if defender:MonsterID() and damageInfo:GetChangeHP() > 0 then
    local stateCmpt = self._world:BattleStat()
    local monsterIDCmpt = defender:MonsterID()
    if monsterIDCmpt:IsWorldBoss() then
      stateCmpt:SubMonsterBeHitDamageValue(defender:GetID(), damageInfo:GetChangeHP())
    end
  end
  self._world:GetService("BuffLogic"):FixGreyHPVal(defender)
end

function CalcDamageService:_DoSubTargetHPPercent(casterEntity, targetEntity, percent, byMaxHP, ignoreShield, leastHP)
  local maxHp = targetEntity:Attributes():CalcMaxHp()
  local curHP = targetEntity:Attributes():GetCurrentHP()
  local subHP = 0
  if byMaxHP then
    subHP = math.ceil(maxHp * percent)
  else
    subHP = math.ceil(curHP * percent)
  end
  local damageOnHP = subHP
  local damageInfo = DamageInfo:New(subHP, DamageType.Real)
  damageInfo:SetChangeHP(-subHP)
  if ignoreShield then
    if curHP - subHP < 1 then
      if leastHP then
        subHP = subHP - leastHP
      else
        subHP = 0
      end
    end
    damageInfo:SetDamageValue(subHP)
    damageInfo:SetChangeHP(-subHP)
    damageInfo:SetAttackerEntityID(casterEntity:GetID())
    damageInfo:SetTargetEntityID(targetEntity:GetID())
    if subHP ~= 0 then
      self:_ModifyDefenderHP(targetEntity, damageInfo)
    end
  else
    local shieldCostDamage, curShield = 0, 0
    local shieldDelta = 0
    shieldCostDamage, curShield, shieldDelta = self:_CalcHealthShield(targetEntity, damageOnHP)
    local isHPShieldGuard = shieldCostDamage == damageOnHP
    damageOnHP = damageOnHP - shieldCostDamage
    if curHP - damageOnHP < 1 then
      if leastHP then
        damageOnHP = damageOnHP - leastHP
      else
        damageOnHP = 0
      end
    end
    damageInfo:SetHPShield(curShield)
    damageInfo:SetHPShieldDelta(shieldDelta)
    damageInfo:SetHPShieldGuard(isHPShieldGuard)
    damageInfo:SetShieldCostDamage(shieldCostDamage)
    damageInfo:SetDamageValue(subHP)
    damageInfo:SetChangeHP(-damageOnHP)
    damageInfo:SetAttackerEntityID(casterEntity:GetID())
    damageInfo:SetTargetEntityID(targetEntity:GetID())
    if damageOnHP ~= 0 or shieldCostDamage ~= 0 then
      self:_ModifyDefenderHP(targetEntity, damageInfo)
    end
  end
  return damageInfo
end

function CalcDamageService:SubTargetHPPercent(casterEntity, targetEntity, percent, byMaxHP, ignoreShield, leastHP)
  local subTarget
  if targetEntity:HasPetPstID() then
    subTarget = casterEntity:Pet():GetOwnerTeamEntity()
  else
    subTarget = targetEntity
  end
  return self:_DoSubTargetHPPercent(casterEntity, subTarget, percent, byMaxHP, ignoreShield, leastHP)
end

function CalcDamageService:DecreaseTargetHP(e, damageInfo)
  if e:HasPetPstID() or e:HasTeam() then
    Log.exception("DecreaseTargetHP: 该接口在设计时没有考虑给玩家使用。请在对过需求之后实现正确的逻辑。")
    return {}
  end
  self:_DoDecreaseTargetHP(e, damageInfo)
end

function CalcDamageService:_DoDecreaseTargetHP(e, damageInfo)
  self:_ModifyDefenderHP(e, damageInfo, true)
end

function CalcDamageService:DoCalcDamage(attacker, defender, damageparam, ignoreShield, damageGridPos)
  local formulaService = self._world:GetService("Formula")
  local buffLogicService = self._world:GetService("BuffLogic")
  local trapServiceLogic = self._world:GetService("TrapLogic")
  if defender:Attributes():GetAttribute("CanBeAttacked") == 0 then
    return DamageInfo:New(0, DamageType.Invalid)
  end
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
  if damageparam.GetChainIndex then
    damageInfo:SetChainIndex(damageparam:GetChainIndex())
  end
  if damageparam.damageStatisticsAttackerEntityID then
    damageInfo:SetDamageStatisticsAttackerEntityID(damageparam.damageStatisticsAttackerEntityID)
  end
  if self:_NeedCurseHpTrans(attacker, defender) then
    ignoreShield = true
  end
  damageType = buffLogicService:CheckCanBeDamage(attacker, defender, skillID, ignoreShield)
  damageInfo:SetDamageType(damageType)
  local shieldLayer = buffLogicService:GetBuffLayer(defender, BuffEffectType.LayerShield)
  damageInfo:SetShieldLayer(shieldLayer)
  if damageType == DamageType.Normal then
    damage, damageType = formulaService:CalcDamageByFormulaID(attacker, defender, damageparam, formulaID, damageGridPos)
    damageInfo:SetDamageType(damageType)
    damageInfo:SetDamageValue(damage)
    self:CalcDamageElement(attacker, damageInfo)
    self:_DoDamageModifyHP(attacker, defender, damageInfo, ignoreShield)
    self:DoDropAsset(defender, damageInfo)
    self:_DisableMonsterAI(defender)
    local isActiveSkill = false
    if attacker:HasSkillInfo() and attacker:SkillInfo():GetActiveSkillID() == skillID then
      isActiveSkill = true
    end
    trapServiceLogic:DestroyTrapAtOnce(defender:GetID(), attacker, isActiveSkill)
    local curHp = defender:Attributes():GetCurrentHP()
    if defender:HasChessPet() and curHp <= 0 then
      local t = {
        defender:GetID()
      }
      self._world:BattleStat():SetChessDeadPlayerPawnCount(t)
    end
  end
  self:_StatData(defender)
  logger:EndDamageLog(attacker:GetID())
  if attacker:SkillContext() then
    attacker:SkillContext():AddDamage(defender:GetID(), damageInfo)
  end
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
  if defender:MonsterID() and 0 > damageInfo:GetChangeHP() then
    local stateCmpt = self._world:BattleStat()
    local monsterIDCmpt = defender:MonsterID()
    if monsterIDCmpt:IsWorldBoss() then
      stateCmpt:AddMonsterBeHitDamageValue(defender:GetID(), damageInfo:GetChangeHP() * -1, skillID)
      monsterIDCmpt:AddMonsterBeHitDamage(damageInfo:GetChangeHP() * -1)
    end
  end
  if defender:HasDamageStatisticsComponent() then
    defender:DamageStatisticsComponent():Append(attacker, damageInfo:GetDamageValue())
  end
  return damageInfo
end

function CalcDamageService:_CalcElementDamageReduce(attacker, defender, damageInfo)
  if attacker == defender then
    return
  end
  local t = defender:Attributes():GetAttribute("BuffElementHarmReduce")
  if not t then
    return
  end
  local elementList = t[1]
  local rate = t[2]
  local utilSvc = self._world:GetService("UtilData")
  local element = utilSvc:GetEntityElementType(attacker, true)
  if elementList ~= nil then
    for _, el in ipairs(elementList) do
      if element == el then
        local damage = damageInfo:GetDamageValue()
        damage = damage * rate
        damageInfo:SetDamageValue(damage)
        return
      end
    end
  end
end

function CalcDamageService:_CalcElementReinforce(casterEntity, defenderEntity, damageInfo)
  if casterEntity == defenderEntity then
    return
  end
  if damageInfo:GetDamageType() == DamageType.Real or damageInfo:GetDamageType() == DamageType.RealReflexive then
    return
  end
  local buffLogicSvc = self._world:GetService("BuffLogic")
  local damage = damageInfo:GetDamageValue()
  local cBuff = defenderEntity:BuffComponent()
  local flagElementReinforce = buffLogicSvc:CheckElementReinforce(casterEntity, defenderEntity)
  if flagElementReinforce == 0 then
    local a = cBuff:GetBuffValue("ElementReinforceFactorA")
    if a then
      damage = damage * a
    end
  elseif flagElementReinforce == 1 then
    local c = cBuff:GetBuffValue("ElementReinforceFactorC")
    if c then
      damage = damage * c
    end
  elseif flagElementReinforce == 2 then
    local b = cBuff:GetBuffValue("ElementReinforceFactorB")
    if b then
      damage = damage * b
    end
  end
  if 0 < damage then
    return
  elseif damage == 0 and damageInfo:GetDamageType() == DamageType.RealDead then
    return
  elseif damage == 0 then
    damageInfo:SetDamageType(DamageType.Guard)
  else
    damage = -damage
    damageInfo:SetDamageType(DamageType.Recover)
  end
  damageInfo:SetDamageValue(damage)
  local val = damageInfo:GetDamageValue()
  damageInfo:SetChangeHP(val)
end

function CalcDamageService:CalcDamageElement(caster, damageInfo)
  local elementCmpt = caster:Element()
  local elementType = ElementType.ElementType_None
  if elementCmpt then
    if caster:HasPetPstID() == true then
      if elementCmpt:IsUseSecondaryType() == true then
        elementType = elementCmpt:GetSecondaryType()
      else
        elementType = elementCmpt:GetPrimaryType()
        local fettersSvc = self._world:GetService("Fetters")
        if fettersSvc and fettersSvc:IsFettersActive(caster) then
          elementType = fettersSvc:GetFettersPrimaryType(caster)
        end
      end
    else
      elementType = elementCmpt:GetPrimaryType()
    end
  end
  damageInfo:SetElementType(elementType)
end

function CalcDamageService:_DoDamageModifyHP(attacker, defender, damageInfo, ignoreShield)
  self:_CalcDamageOnHP(attacker, defender, damageInfo, ignoreShield)
  self:_ModifyDefenderHP(defender, damageInfo)
end

function CalcDamageService:_CalcDamageOnHPShield(attacker, defender, damageInfo, ignoreShield)
  if damageInfo:GetDamageType() == DamageType.Recover then
    return
  end
  local damageOnHP = damageInfo:GetDamageValue()
  local damageType = damageInfo:GetDamageType()
  local shieldCostDamage, curShield = 0, 0
  local shieldDelta = 0
  if not ignoreShield then
    shieldCostDamage, curShield, shieldDelta = self:_CalcHealthShield(defender, damageOnHP)
    if 0 < shieldCostDamage then
      Log.debug("Calc damage hp shiled, defenderID: ", defender:GetID(), " shieldCostDmg: ", shieldCostDamage, " curShield: ", curShield, " curDamageOnHP: ", damageOnHP)
    end
  else
    local buffCmpt = defender:BuffComponent()
    local shield = 0
    if buffCmpt:GetBuffValue("HPShield") then
      shield = buffCmpt:GetBuffValue("HPShield")
    end
    curShield = shield
  end
  local isHPShieldGuard = shieldCostDamage == damageOnHP
  damageOnHP = damageOnHP - shieldCostDamage
  damageInfo:SetHPShield(curShield)
  damageInfo:SetHPShieldDelta(shieldDelta)
  damageInfo:SetHPShieldGuard(isHPShieldGuard)
  damageInfo:SetShieldCostDamage(shieldCostDamage)
  if attacker then
    local cAttackerBuff = attacker:BuffComponent()
    if cAttackerBuff then
      local chainIndex = damageInfo:GetChainIndex()
      if chainIndex and 1 < chainIndex then
        local doubleChainRate = cAttackerBuff:GetBuffValue("DoubleChainRate") or 1
        local doubleChainRateVal = math.floor(damageOnHP * doubleChainRate)
        damageOnHP = math.min(doubleChainRateVal, damageOnHP)
        damageInfo:SetDamageValue(damageOnHP)
      end
    end
  end
  local maxHp = defender:Attributes():CalcMaxHp()
  local curHp = defender:Attributes():GetCurrentHP()
  local cBuff = defender:BuffComponent()
  if cBuff then
    local glancingRate = cBuff:GetBuffValue("GlancingRate")
    local glancingMaxValue = cBuff:GetBuffValue("GlancingMaxValue")
    if glancingRate and glancingMaxValue then
      local val = math.floor(damageOnHP * glancingRate)
      damageOnHP = math.min(glancingMaxValue, val)
    end
    local attackIgnoreLoseHpLimit = false
    if attacker then
      local cAttackerBuff = attacker:BuffComponent()
      if cAttackerBuff then
        local attackIgnoreMaxLoseHpPercent = cAttackerBuff:GetBuffValue("AttackIgnoreMaxLoseHPPercent")
        if attackIgnoreMaxLoseHpPercent and attackIgnoreMaxLoseHpPercent == 1 then
          attackIgnoreLoseHpLimit = true
        end
      end
    end
    if not attackIgnoreLoseHpLimit then
      local t = cBuff:GetBuffValue("MaxLoseHPPercent")
      if t then
        if t.percent then
          local val = math.floor(maxHp * t.percent)
          damageOnHP = math.min(val, damageOnHP)
        elseif t.fixValue then
          damageOnHP = math.min(t.fixValue, damageOnHP)
        end
        damageInfo:SetDamageValue(damageOnHP)
      end
    end
  end
  if attacker then
    local canTransToCurseHp, transCurseCostDamage, curCurseHp, curseHpModifyVal, transCurseValue = self:_CalcCurseHpTrans(attacker, defender, damageOnHP)
    if canTransToCurseHp and transCurseCostDamage and 0 < transCurseCostDamage then
      damageOnHP = damageOnHP - transCurseCostDamage
      damageInfo:SetCurseHp(curCurseHp)
      damageInfo:SetCurseHpDelta(curseHpModifyVal)
      damageInfo:SetDamageValue(transCurseValue)
    end
  end
  local isTriggerSecKill = false
  damageOnHP, isTriggerSecKill = self:CalcSecKillBuff(defender, damageOnHP)
  damageInfo:SetTriggerSecKill(isTriggerSecKill)
  local lockCostHP, isTriggerHPLock = self:CalcLockHP(defender, damageOnHP)
  damageInfo:SetTriggerHPLock(isTriggerHPLock)
  if isTriggerHPLock then
    damageInfo:SetTriggerSecKill(false)
  end
  if damageOnHP > lockCostHP then
    damageOnHP = lockCostHP
    damageInfo:SetDamageValue(lockCostHP)
    if lockCostHP == 0 then
      damageInfo:SetDamageType(DamageType.Guard)
    end
  end
  if 0 < shieldCostDamage and defender:HasMonsterID() and defender:MonsterID():GetUIBossHPBarType() == BossUIHPType.Gold then
    damageInfo:SetDamageType(DamageType.Guard)
  end
  damageOnHP = self:DoGuideLockPlayerHPPercent(defender, damageOnHP)
  damageOnHP = math.ceil(damageOnHP)
  damageInfo:SetChangeHP(-damageOnHP)
  if attacker then
    local logger = self._world:GetMatchLogger()
    logger:AddDamageLog(attacker:GetID(), {
      key = "FinalDamage",
      desc = "***伤害公式后，最终加成阶段结束：最终伤害值[val]***",
      val = damageInfo:GetDamageValue()
    })
  end
end

function CalcDamageService:_CalcDamageOnHP(attacker, defender, damageInfo, ignoreShield)
  self:_CalcElementDamageReduce(attacker, defender, damageInfo)
  self:_CalcElementReinforce(attacker, defender, damageInfo)
  self:_CalcDamageOnHPShield(attacker, defender, damageInfo, ignoreShield)
end

function CalcDamageService:_ModifyDefenderHP(defender, damageInfo, noTrigger)
  local originalHP = defender:Attributes():GetCurrentHP()
  local maxHP = defender:Attributes():CalcMaxHp()
  local curHP = defender:Attributes():GetCurrentHP()
  local changeHP = damageInfo:GetChangeHP()
  local damageType = damageInfo:GetDamageType()
  if curHP == 0 and 0 < changeHP then
    Log.error("ModifyDefenderHP add hp to a dead entity:", defender:GetID())
  end
  local spilled = 0
  if maxHP < changeHP + curHP then
    spilled = changeHP + curHP - maxHP
  end
  local hpAndShieldChangeValue = 0
  if damageType == DamageType.Recover then
    hpAndShieldChangeValue = changeHP - spilled
  else
    hpAndShieldChangeValue = math.max(changeHP, -curHP)
    local shieldCostDamage = damageInfo:GetShieldCostDamage()
    if shieldCostDamage then
      hpAndShieldChangeValue = hpAndShieldChangeValue - damageInfo:GetShieldCostDamage()
    end
  end
  local svcTrigger = self._world:GetService("Trigger")
  damageInfo:SetHpAndShieldChangeValue(hpAndShieldChangeValue)
  curHP = curHP + changeHP
  if defender:HasMonsterID() and defender:MonsterID():IsMultiHPMonster() and curHP <= 0 and defender:MonsterID():HasNextMultiStageHPData() then
    local curMultiHPStage = defender:MonsterID():GetMultiHPStage()
    local newMultiHPStage, switchCount
    maxHP, curHP, newMultiHPStage, switchCount = defender:MonsterID():GetNextMultiStageHPData(curHP)
    defender:Attributes():Modify("MaxHP", maxHP)
    damageInfo:SetMultiHPSwitch(true)
    damageInfo:SetNewMultiHPStage(newMultiHPStage)
    damageInfo:SetMultiHPFinalHP(curHP)
    damageInfo:SetMultiHPCurMaxHP(maxHP)
    damageInfo:SetMultiHPSwitchCount(switchCount)
    local round = self._world:BattleStat():GetLevelTotalRoundCount()
    defender:MonsterID():AddMultiHPSwitchRound(round)
    for i = curMultiHPStage + 1, newMultiHPStage do
      svcTrigger:Notify(NTMultiHPSwitch:New(i))
    end
    Log.info("Logic Switch RedHP:", curHP, "MaxHP:", maxHP, "NewMultiHPStage:", newMultiHPStage, "SwitchCount:", switchCount)
  end
  curHP = math.floor(math.max(math.min(curHP, maxHP), 0))
  Log.info("Logic HP Percent: ", curHP / maxHP, " CurHP:", curHP, " MaxHP:", maxHP, " EntityID:", defender:GetID())
  defender:Attributes():Modify("HP", curHP)
  local battleDamageStatisticsServiceLogic = self._world:GetService("BattleDamageStatisticsLogic")
  battleDamageStatisticsServiceLogic:AddDamageStatisticsInfo(damageInfo)
  if defender:HasMonsterID() and defender:MonsterID():IsWorldBoss() then
    defender:Attributes():Modify("HP", BattleConst.WorldBossHP)
  end
  self._world:GetSyncLogger():Trace({
    key = "_ModifyDefenderHP",
    entityID = defender:GetID(),
    changeHP = changeHP,
    curHP = curHP,
    maxHP = maxHP
  })
  self:LogNotice(" _ModifyDefenderHP() entityID=", defender:GetID(), " changeHP=", changeHP, " curHP=", curHP, " MaxHP=", maxHP)
  if noTrigger then
    return
  end
  local damageSrcID = damageInfo:GetAttackerEntityID()
  if defender:HasPetPstID() or defender:HasTeam() then
    local nt = NTPlayerHPChange:New(defender, curHP, maxHP, spilled, changeHP, damageSrcID)
    nt:SetDamageType(damageInfo:GetDamageType())
    nt:SetAttackPos(damageInfo:GetAttackPos())
    nt:SetDamageInfo(damageInfo)
    svcTrigger:Notify(nt)
    if changeHP < 0 then
      self._world:GetDataLogger():AddDataLog("OnPetBehit", defender, damageInfo:GetDamageValue())
    else
      self._world:GetDataLogger():AddDataLog("OnPetAddBlood", changeHP, spilled)
    end
    if curHP == 0 and defender:HasTeam() then
      defender:AddTeamDeadMark()
    end
  elseif defender:HasMonsterID() then
    self:MonsterHPChangeNT(defender, curHP, maxHP, changeHP, damageSrcID, damageInfo)
    if originalHP ~= 0 and curHP == 0 then
      local skillID = damageInfo:GetSkillID()
      if not table.icontains(BattleConst.PetMiyaNotCollectSoulsSkillIDs, skillID) then
        local casterEntity = self._world:GetEntityByID(damageSrcID)
        local effectType = damageInfo:GetSkillEffectType()
        local gameFsmCmpt = self._world:GameFSM()
        if casterEntity and effectType ~= SkillEffectType.RandAttack and gameFsmCmpt:CurStateID() == GameStateID.ActiveSkill then
          if casterEntity:HasSuperEntity() then
            casterEntity = casterEntity:GetSuperEntity()
          end
          if casterEntity:HasPetPstID() then
            local ntCollectSouls = NTCollectSouls:New(casterEntity, 1, {defender})
            svcTrigger:Notify(ntCollectSouls)
          end
        end
      end
      local stateCmpt = self._world:BattleStat()
      stateCmpt:AddMonsterKilledRecordData(damageSrcID, defender:GetID())
    end
  elseif defender:Trap() then
    local nt = NTTrapHpChange:New(defender, curHP, maxHP)
    nt:SetChangeHP(changeHP)
    nt:SetDamageSrcEntityID(damageSrcID)
    nt:SetDamageType(damageInfo:GetDamageType())
    nt:SetDamageInfo(damageInfo)
    nt:SetAttackPos(damageInfo:GetAttackPos())
    svcTrigger:Notify(nt)
  elseif defender:ChessPet() then
    local nt = NTChessHPChange:New(defender, curHP, maxHP)
    nt:SetChangeHP(changeHP)
    nt:SetDamageSrcEntityID(damageSrcID)
    nt:SetDamageType(damageInfo:GetDamageType())
    nt:SetAttackPos(damageInfo:GetAttackPos())
    nt:SetDamageInfo(damageInfo)
    svcTrigger:Notify(nt)
  end
  if defender:HasMonsterID() and defender:MonsterID():GetDamageSyncMonsterID() then
    local utilDataSvc = self._world:GetService("UtilData")
    local entityList = utilDataSvc:FindSyncMonsterTargetList(defender)
    for i, entity in ipairs(entityList) do
      if not entity:HasDeadMark() then
        local newDamageInfo = DamageInfo:New()
        newDamageInfo:Clone(damageInfo)
        local skillID = damageInfo:GetSkillID()
        newDamageInfo:SetSkillID(skillID)
        local originalDamageCaster = damageInfo:GetAttackerEntityID()
        newDamageInfo:SetAttackerEntityID(originalDamageCaster)
        newDamageInfo:SetTargetEntityID(entity:GetID())
        self:_CalcDamageOnHPShield(nil, entity, newDamageInfo, nil)
        self:_ModifyDefenderHP(entity, newDamageInfo)
        local syncMaxHP = entity:Attributes():CalcMaxHp()
        local syncCurHP = entity:Attributes():GetCurrentHP()
        local syncChangeHP = newDamageInfo:GetChangeHP()
        syncCurHP = math.floor(math.max(math.min(syncCurHP + syncChangeHP, syncMaxHP), 0))
        self:LogNotice(" _ModifyDefenderHP() entityID=", entity:GetID(), " changeHP=", syncChangeHP, " curHP=", syncCurHP)
        local stateCmpt = self._world:BattleStat()
        local syncMonsterIDCmpt = entity:MonsterID()
        if syncMonsterIDCmpt:IsWorldBoss() and syncChangeHP < 0 then
          stateCmpt:AddMonsterBeHitDamageValue(entity:GetID(), syncChangeHP * -1, 0)
          syncMonsterIDCmpt:AddMonsterBeHitDamage(syncChangeHP * -1)
        end
        damageInfo:AddSyncDamageInfo(newDamageInfo)
      end
    end
  end
end

function CalcDamageService:MonsterHPChangeNT(defender, curHP, maxHP, changeHP, damageSrcID, damageInfo)
  local svcTrigger = self._world:GetService("Trigger")
  local nt = NTMonsterHPCChange:New(defender, curHP, maxHP, self.__NTMonsterHPCChangeCount)
  nt:SetChangeHP(changeHP)
  nt:SetDamageSrcEntityID(damageSrcID)
  nt:SetDamageType(damageInfo:GetDamageType())
  nt:SetAttackPos(damageInfo:GetAttackPos())
  nt:SetDamageInfo(damageInfo)
  svcTrigger:Notify(nt)
  self.__NTMonsterHPCChangeCount = self.__NTMonsterHPCChangeCount + 1
end

function CalcDamageService:_CalcHealthShield(defenderEntity, damage)
  local shieldCostDamage = 0
  local buffCmpt = defenderEntity:BuffComponent()
  local shield = buffCmpt:GetBuffValue("HPShield") or 0
  local shieldDelta = 0
  if shield == 0 then
    return shieldCostDamage, shield, shieldDelta
  end
  Log.debug("Calc damage hp shiled, defenderID: ", defenderEntity:GetID(), " shield: ", shield)
  local buffCmpt = defenderEntity:BuffComponent()
  if not buffCmpt then
    return shieldCostDamage, shield, shieldDelta
  end
  if 0 < shield and damage > shield and buffCmpt:GetBuffValue("HPShieldLockHP") then
    shieldDelta = -shield
    buffCmpt:SetBuffValue("HPShield", 0)
    return damage, 0, shieldDelta
  end
  local curShield = shield - damage
  if 0 < curShield then
    shieldCostDamage = damage
  else
    shieldCostDamage = shield
  end
  if curShield <= 0 then
    curShield = 0
  end
  shieldDelta = curShield - shield
  buffCmpt:SetBuffValue("HPShield", curShield)
  return shieldCostDamage, curShield, shieldDelta
end

function CalcDamageService:_NeedCurseHpTrans(attackerEntity, defenderEntity)
  local canTrans = false
  local attackerBuffCmpt = attackerEntity:BuffComponent()
  local defenderBuffCmpt = defenderEntity:BuffComponent()
  if not attackerBuffCmpt or not defenderBuffCmpt then
    return canTrans
  end
  local defenderHasCurseHp = defenderBuffCmpt:IsCurseHPEnabled()
  if not defenderHasCurseHp then
    return canTrans
  end
  local attackerTransPercent = attackerBuffCmpt:GetBuffValue("TransDamageToCurseHp")
  if not attackerTransPercent then
    return canTrans
  end
  canTrans = true
  return canTrans
end

function CalcDamageService:_CalcCurseHpTrans(attackerEntity, defenderEntity, damage)
  local canTrans = false
  local attackerBuffCmpt = attackerEntity:BuffComponent()
  local defenderBuffCmpt = defenderEntity:BuffComponent()
  if not attackerBuffCmpt or not defenderBuffCmpt then
    return canTrans
  end
  local defenderHasCurseHp = defenderBuffCmpt:IsCurseHPEnabled()
  if not defenderHasCurseHp then
    return canTrans
  end
  local attackerTransPercent = attackerBuffCmpt:GetBuffValue("TransDamageToCurseHp")
  if not attackerTransPercent then
    return canTrans
  end
  canTrans = true
  local transCurseValue = math.ceil(damage * attackerTransPercent)
  local bufflsvc = self._world:GetService("BuffLogic")
  local beforeCurseHpVal = defenderBuffCmpt:GetCurseHPValue(true)
  local afterCurseHpVal = bufflsvc:ChangeCurseHP(defenderEntity, transCurseValue)
  local curseHpModifyVal = afterCurseHpVal - beforeCurseHpVal
  local costDamage = damage
  return canTrans, costDamage, afterCurseHpVal, curseHpModifyVal, transCurseValue
end

function CalcDamageService:CalcSecKillBuff(defenderEntity, damage)
  local buffCmpt = defenderEntity:BuffComponent()
  if buffCmpt == nil then
    return damage
  end
  local isTriggerSecKill = false
  local percent = buffCmpt:GetBuffValue("SecKillHPPercent")
  if percent then
    local maxHP = defenderEntity:Attributes():CalcMaxHp()
    local curHP = defenderEntity:Attributes():GetCurrentHP()
    local killHP = maxHP * percent
    if killHP > curHP - damage then
      damage = curHP
      isTriggerSecKill = true
    end
  end
  return damage, isTriggerSecKill
end

function CalcDamageService:CalcLockHP(defenderEntity, damage)
  local buffCmpt = defenderEntity:BuffComponent()
  if buffCmpt == nil then
    return damage
  end
  local bufflsvc = self._world:GetService("BuffLogic")
  local hasLockHPBuff, isLock = bufflsvc:CheckEntityLockHP(defenderEntity)
  local isTriggerHPLock = false
  if hasLockHPBuff then
    if isLock then
      damage = 0
      return damage
    end
    damage, isTriggerHPLock = self:DoLockCostHp(defenderEntity, buffCmpt, damage)
    return damage, isTriggerHPLock
  end
  if not hasLockHPBuff and buffCmpt:GetBuffValue("NumLockHP") then
    damage, isTriggerHPLock = self:DoNumLockCostHp(defenderEntity, buffCmpt, damage)
    return damage, isTriggerHPLock
  end
  return damage
end

function CalcDamageService:DoNumLockCostHp(defenderEntity, buffComponent, damage)
  local curHp = defenderEntity:Attributes():GetCurrentHP()
  local maxHp = defenderEntity:Attributes():CalcMaxHp()
  curHp = curHp - damage
  if curHp < 0 then
    curHp = 0
  end
  local isTriggerHPLock = false
  local numLockHP = buffComponent:GetBuffValue("NumLockHP")
  if curHp < numLockHP then
    curHp = numLockHP
    isTriggerHPLock = true
    damage = defenderEntity:Attributes():GetCurrentHP() - numLockHP
  end
  return damage, isTriggerHPLock
end

function CalcDamageService:DoLockCostHp(defenderEntity, buffComponent, damage)
  local lockHpList = buffComponent:GetBuffValue("LockHPList")
  local curHp = defenderEntity:Attributes():GetCurrentHP()
  local maxHp = defenderEntity:Attributes():CalcMaxHp()
  curHp = curHp - damage
  if curHp < 0 then
    curHp = 0
  end
  local leftHpPercent = curHp / maxHp * 100
  local buffsvc = self._world:GetService("BuffLogic")
  local lockHpPercent, index = buffsvc:GetLockHPInfo(defenderEntity, damage)
  local isTriggerHPLock = false
  if lockHpPercent ~= 0 then
    local curRound = self._world:BattleStat():GetCurWaveTotalRoundCount()
    local gameFsmStateID
    local hasGameFsm = self._world:HasGameFSM()
    if hasGameFsm then
      local gameFsmCmpt = self._world:GameFSM()
      gameFsmStateID = gameFsmCmpt:CurStateID()
    end
    isTriggerHPLock = true
    buffComponent:AddHpLockState(curRound, lockHpPercent, index, gameFsmStateID)
    damage = defenderEntity:Attributes():GetCurrentHP() - math.floor(maxHp * (lockHpPercent / 100))
    self._world:GetService("Trigger"):Notify(NTHPLock:New(index, lockHpPercent, defenderEntity))
  end
  local numLockHP = buffComponent:GetBuffValue("NumLockHP")
  if numLockHP and curHp < numLockHP then
    curHp = numLockHP
    isTriggerHPLock = true
  end
  return damage, isTriggerHPLock
end

function CalcDamageService:ResetLockHp(defenderEntity, buffInstance)
  local buffComponent = buffInstance:Entity():BuffComponent()
  buffComponent:ResetHPLockState()
end

function CalcDamageService:DoGuideLockPlayerHPPercent(defenderEntity, damageOnHP)
  local buffComponent = defenderEntity:BuffComponent()
  local buffInstance = buffComponent:GetSingleBuffByBuffEffect(BuffEffectType.GuideLockPlayerHPPercent)
  if buffInstance then
    local attrCmpt = defenderEntity:Attributes()
    local curHp = attrCmpt:GetCurrentHP()
    local maxHp = attrCmpt:CalcMaxHp()
    local lockPercent = buffComponent:GetBuffValue("GuideLockHPPercent")
    local minHP = math.floor(maxHp * lockPercent / 100)
    local leftHP = math.max(0, curHp - damageOnHP)
    if minHP > leftHP then
      damageOnHP = math.max(0, curHp - minHP)
    end
  end
  return damageOnHP
end

function CalcDamageService:DoDropAsset(defenderEntity, damageInfo)
  local buffCmpt = defenderEntity:BuffComponent()
  if buffCmpt == nil then
    return
  end
  local dropService = self._world:GetService("Drop")
  local buffDataArray = buffCmpt:GetBuffArray()
  local dropIDArray = {}
  for index = #buffDataArray, 1, -1 do
    local buffInstance = buffDataArray[index]
    local buffEffectType = buffInstance:GetBuffEffectType()
    local dropID = 0
    local effectID = 0
    if buffEffectType == BuffEffectType.HitDropByCount then
      dropID, effectID = self:_DoDropAssetByHit(defenderEntity, buffInstance)
    end
    if buffEffectType == BuffEffectType.HitDropByHP then
      dropID, effectID = self:_DoDropAssetByHp(defenderEntity, buffInstance)
    end
    if dropID ~= 0 then
      table.insert(dropIDArray, {id = dropID, effect = effectID})
    end
  end
  local dropService = self._world:GetService("Drop")
  local dropAssetList = {}
  for _, v in ipairs(dropIDArray) do
    local dropAsset = dropService:DoActorDrop(v.id, defenderEntity:GetID())
    if dropAsset then
      table.insert(dropAssetList, {
        asset = dropAsset,
        effect = v.effect
      })
    end
  end
  damageInfo:SetDropAssetList(dropAssetList)
end

function CalcDamageService:_DoDropAssetByHit(defenderEntity, buffInstance)
  local buffComponent = buffInstance:Entity():BuffComponent()
  local hitCount = buffComponent:GetBuffValue("DropHitCount")
  local dropList = buffComponent:GetBuffValue("DropListByHit")
  local hitIndex = buffComponent:AddHitIndex()
  local dropID = 0
  local effectID = 0
  if hitCount >= hitIndex then
    if hitIndex > #dropList then
      dropID = 0
    else
      dropID = dropList[hitIndex].DropGroupID
    end
    effectID = buffComponent:GetBuffValue("DropByCountEffectID")
  end
  return dropID, effectID
end

function CalcDamageService:_DoDropAssetByHp(defenderEntity, buffInstance)
  local buffComponent = buffInstance:Entity():BuffComponent()
  local attrCmpt = defenderEntity:Attributes()
  local curHp = attrCmpt:GetCurrentHP()
  local maxHp = attrCmpt:CalcMaxHp()
  local leftHpPercent = curHp / maxHp * 100
  local dropList = buffComponent:GetBuffValue("DropListByHP")
  local saveHpPercent, dropID
  for _, v in ipairs(dropList) do
    if leftHpPercent <= v.hpPercentEnd and leftHpPercent > v.hpPercentBegin then
      saveHpPercent = v.hpPercentEnd
      dropID = v.DropGroupID
    end
  end
  local effectID = buffComponent:GetBuffValue("DropByHPEffectID")
  if saveHpPercent and not buffComponent:IsHPPercentHasDrop(saveHpPercent) and dropID then
    buffComponent:AddHasDropHpPercent(saveHpPercent)
    return dropID, effectID
  end
  return 0, effectID
end

function CalcDamageService:_DisableMonsterAI(defenderEntity)
  local curHp = defenderEntity:Attributes():GetCurrentHP()
  if curHp == nil or 0 < curHp then
    return
  end
  if not defenderEntity:HasMonsterID() then
    return
  end
  local gameFsmCmpt = self._world:GameFSM()
  local curStateID = gameFsmCmpt:CurStateID()
  if curStateID ~= GameStateID.MonsterTurn then
    return
  end
  if not defenderEntity:HasDeadMark() then
    if defenderEntity:HasMonsterID() then
      local mstrsvc = self._world:GetService("MonsterShowLogic")
      mstrsvc:AddMonsterDeadMark(defenderEntity)
    else
      defenderEntity:AddDeadMark()
    end
  end
  local aiCmpt = defenderEntity:AI()
  if aiCmpt ~= nil then
    aiCmpt:CancelLogic()
  end
end

function CalcDamageService:_StatData(defender)
  if defender:HasPetPstID() or defender:HasTeam() then
    local battleStatCmpt = self._world:BattleStat()
    battleStatCmpt:AddPlayerBeHitCount(1)
  end
end

function CalcDamageService:_ProcessFormulaID(oriFormulaID, attacker, defender)
  local formulaID = oriFormulaID
  if defender then
    local buffCmpt = defender:BuffComponent()
    if buffCmpt then
      local replaceDic = buffCmpt:GetBuffValue("DefenderChangeFormulaIDDic")
      if replaceDic and replaceDic[oriFormulaID] then
        formulaID = replaceDic[oriFormulaID]
        Log.debug("Calc damage,replace formula ID,oriFormulaID: ", oriFormulaID, " newFormulaID: ", formulaID, " defender: ", defender:GetID())
      end
    end
  end
  return formulaID
end
