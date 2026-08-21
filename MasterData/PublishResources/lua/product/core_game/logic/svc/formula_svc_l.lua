require("formula_svc_base_l")
local NoFinalProcessFormulaID = {
  FormulaNumberType.CalcDamage_130,
  FormulaNumberType.AbsoluteRemainHP,
  FormulaNumberType.DeadDamage,
  FormulaNumberType.RealTransmitDamage
}
local No1DamageAtLeastFormulaID = {
  FormulaNumberType.AbsoluteRemainHP
}

function FormulaService:CalcDamageByFormulaID(attacker, defender, damageParam, formulaID, damageGridPos)
  local func = self._formulaList[formulaID]
  if not func then
    Log.exception("### [Formula] can not find func", formulaID)
    return
  end
  local val, damageType, costPercent = func(self, attacker, defender, damageParam, damageGridPos)
  local defenderFinal = self:_CalcDefenderBeHitDamageParam(defender)
  if not table.icontains(NoFinalProcessFormulaID, formulaID) then
    val = val * defenderFinal
    val = self:_ProcessFinalDamage(val, damageType, defender, attacker, damageParam, damageGridPos, formulaID)
  end
  local isRoundRequired = damageType ~= DamageType.RealDead and not table.icontains(No1DamageAtLeastFormulaID, formulaID)
  if damageParam.GetN33DamageMul and damageParam:GetN33DamageMul() > 1 then
    val = val * damageParam:GetN33DamageMul()
  end
  if isRoundRequired then
    val = self:_RET(val)
  end
  local logger = self._world:GetMatchLogger()
  logger:AddDamageLog(attacker:GetID(), {
    key = "FinalDamage",
    desc = "***被击者最终伤害增伤系数[defenderFinal] 最终伤害值[val]***",
    defenderFinal = defenderFinal,
    val = val
  })
  logger:AddDamageLog(attacker:GetID(), {
    key = "FinalDamage",
    desc = "***伤害公式内，最终加成阶段结束：最终伤害值[val]***",
    val = val
  })
  return val, damageType, costPercent
end

function FormulaService:CalcDamage_1(attacker, defender, damageParams, damageGridPos)
  local baseDamage = self:CalcBaseDamage(attacker, defender, damageGridPos)
  local damagePercent = damageParams.percent + self:_CalcSkillParam_NormalSkill(attacker) + self:_CalcSkillParam_DefenderSkillAmpfily(defender)
  local comboParam = self:CalcComboParam(attacker)
  local normalChainParam = self:CalcNormalChainParam(attacker)
  local superGridParam = self:CalcSuperGridParam(attacker)
  local poorGridParam = self:CalcPoorGridParam(attacker)
  local elementParam = self:CalcElementParam(attacker, defender)
  local normalSkillAbsorbParam = self:CalcAbsorbParam_NormalSkill(defender, damageGridPos)
  local primarySecondaryParam = self:CalcPrimarySecondaryParam(attacker)
  local critParam = self:CalcCritParam(damageParams, attacker)
  local skillIncreaseParam = self:_CalcSkillIncreaseParam_NormalSkill(attacker)
  local skillFinalParam = self:_CalcSkillFinalParam_NormalSkill(attacker)
  local val = baseDamage * (damagePercent + comboParam + normalChainParam + superGridParam + poorGridParam) * elementParam * normalSkillAbsorbParam * primarySecondaryParam * critParam * skillIncreaseParam * skillFinalParam
  val = self:_RET(val)
  local damageType = critParam == 1 and DamageType.Normal or DamageType.Critical
  local logger = self._world:GetMatchLogger()
  logger:AddDamageLog(attacker:GetID(), {
    key = "CalcDamage_1",
    desc = "公式1：攻击者[attacker] 被击者[defender] 伤害[val] = 基础伤害[baseDamage] * (普攻技能系数[damagePercent] + combo系数[comboParam] + 普攻连线系数[normalChainParam] + 强化格子系数[superGridParam] + 弱化格子系数[poorGridParam]) * 属性克制系数[elementParam] * 普攻吸收系数[normalSkillAbsorbParam] * 主副属性系数[primarySecondaryParam] * 暴击系数[critParam] * 技能提升系数[skillIncreaseParam] * 技能最终系数[skillFinalParam]",
    attacker = attacker:GetID(),
    defender = defender:GetID(),
    val = val,
    baseDamage = baseDamage,
    damagePercent = damagePercent,
    comboParam = comboParam,
    normalChainParam = normalChainParam,
    superGridParam = superGridParam,
    poorGridParam = poorGridParam,
    elementParam = elementParam,
    normalSkillAbsorbParam = normalSkillAbsorbParam,
    primarySecondaryParam = primarySecondaryParam,
    critParam = critParam,
    skillIncreaseParam = skillIncreaseParam,
    skillFinalParam = skillFinalParam
  })
  return val, damageType
end

function FormulaService:CalcDamage_2(attacker, defender, damageParams, damageGridPos)
  local baseDamage = self:CalcBaseDamage(attacker, defender, damageGridPos)
  local monsterSkillParam = self:_CalcSkillParam_MonsterSkill(attacker)
  local damagePercent = damageParams.percent + monsterSkillParam
  local elementParam = self:CalcElementParam(attacker, defender)
  local damageAbsorbParam = self:CalcAbsorbParam_Damage()
  local critParam = self:CalcCritParam(damageParams, attacker)
  local skillIncreaseParam = self:_CalcSkillIncreaseParam_MonsterSkill(attacker)
  local skillFinalParam = self:_CalcSkillFinalParam_MonsterSkill(attacker)
  local val = baseDamage * damagePercent * elementParam * damageAbsorbParam * critParam * skillIncreaseParam * skillFinalParam
  val = self:_RET(val)
  local damageType = critParam == 1 and DamageType.Normal or DamageType.Critical
  local logger = self._world:GetMatchLogger()
  logger:AddDamageLog(attacker:GetID(), {
    desc = "公式2：攻击者[attacker] 被击者[defender] 伤害[val] = 基础伤害[baseDamage] * 技能系数[damagePercent] * 属性克制[elementParam] * 吸收系数[damageAbsorbParam] * 暴击系数[critParam] * 技能提升[skillIncreaseParam] * 最终系数[skillFinalParam]",
    key = "CalcDamage_2",
    attacker = attacker:GetID(),
    defender = defender:GetID(),
    val = val,
    baseDamage = baseDamage,
    damagePercent = damagePercent,
    monsterSkillParam = monsterSkillParam,
    elementParam = elementParam,
    damageAbsorbParam = damageAbsorbParam,
    critParam = critParam,
    skillIncreaseParam = skillIncreaseParam,
    skillFinalParam = skillFinalParam
  })
  return val, damageType
end

function FormulaService:CalcDamage_3(attacker, defender, damageParam, damageGridPos)
  local trapSkillIncreaseParam = self:_CalcSkillIncreaseParam_TrapSkill(attacker)
  local val = 10000 * damageParam.percent * trapSkillIncreaseParam
  val = self:_RET(val)
  local logger = self._world:GetMatchLogger()
  logger:AddDamageLog(attacker:GetID(), {
    key = "CalcDamage_3",
    desc = "公式3：攻击者[attacker] 被击者[defender] 伤害[val] = 基础伤害[baseDamage] * 技能系数[damagePercent] * 技能提升[trapSkillIncreaseParam]",
    attacker = attacker:GetID(),
    defender = defender:GetID(),
    val = val,
    baseDamage = 10000,
    damagePercent = damageParam.percent,
    trapSkillIncreaseParam = trapSkillIncreaseParam
  })
  return val, DamageType.Real
end

function FormulaService:CalcDamage_4(attacker, defender, damageParams, damageGridPos)
  local baseDamage = self:CalcBaseDamage(attacker, defender, damageGridPos)
  local chainSkillParam = self:_CalcSkillParam_ChainSkill(attacker)
  local damagePercent = damageParams.percent + chainSkillParam
  local chainChainParam = self:CalcChainChainParam(attacker, damageParams)
  local superGridParam = self:CalcSuperGridParam(attacker, damageParams)
  local poorGridParam = self:CalcPoorGridParam(attacker, damageParams)
  local elementParam = self:CalcElementParam(attacker, defender)
  local chainSkillAbsorbParam = self:CalcAbsorbParam_ChainSkill(defender, damageGridPos)
  local primarySecondaryParam = self:CalcPrimarySecondaryParam(attacker)
  local critParam = self:CalcCritParam(damageParams, attacker)
  local skillIncreaseParam = self:_CalcSkillIncreaseParam_ChainSkill(attacker)
  local skillFinalParam = self:_CalcSkillFinalParam_ChainSkill(attacker)
  local val = baseDamage * damagePercent * (1 + chainChainParam + superGridParam + poorGridParam) * elementParam * chainSkillAbsorbParam * primarySecondaryParam * critParam * skillIncreaseParam * skillFinalParam
  val = self:_RET(val)
  local damageType = critParam == 1 and DamageType.Normal or DamageType.Critical
  local logger = self._world:GetMatchLogger()
  logger:AddDamageLog(attacker:GetID(), {
    key = "CalcDamage_4",
    desc = "公式4：攻击者[attacker] 被击者[defender] 伤害[val] = 基础伤害[baseDamage] * 技能系数[damagePercent] * (1+连锁技连锁系数[chainChainParam]+强化格子系数[superGridParam]+弱化格子系数[poorGridParam]) * 元素克制系数[elementParam] * 连锁技吸收系数[chainSkillAbsorbParam] * 主副属性系数[primarySecondaryParam] * 暴击系数[critParam] * 技能提升系数[skillIncreaseParam] * 技能最终系数[skillFinalParam]",
    attacker = attacker:GetID(),
    defender = defender:GetID(),
    val = val,
    baseDamage = baseDamage,
    damagePercent = damagePercent,
    chainSkillParam = chainSkillParam,
    chainChainParam = chainChainParam,
    superGridParam = superGridParam,
    poorGridParam = poorGridParam,
    elementParam = elementParam,
    chainSkillAbsorbParam = chainSkillAbsorbParam,
    primarySecondaryParam = primarySecondaryParam,
    critParam = critParam,
    skillIncreaseParam = skillIncreaseParam,
    skillFinalParam = skillFinalParam
  })
  return val, damageType
end

function FormulaService:CalcDamage_5(attacker, defender, damageParams, damageGridPos)
  local baseDamage = self:CalcBaseDamage(attacker, defender, damageGridPos)
  local elementParam = self:CalcElementParam(attacker, defender)
  local critParam = self:CalcCritParam(damageParams, attacker)
  local activeSkillAbsorbParam, primarySecondaryParam, activeSkillIncreaseParam, skillFinalParam, activeSkillParam = self:_GetActiveSkillParam(attacker, defender, damageGridPos)
  local damagePercent = damageParams.percent + activeSkillParam
  local val = baseDamage * damagePercent * elementParam * critParam * activeSkillAbsorbParam * activeSkillIncreaseParam * skillFinalParam
  val = self:_RET(val)
  local damageType = critParam == 1 and DamageType.Normal or DamageType.Critical
  local logger = self._world:GetMatchLogger()
  logger:AddDamageLog(attacker:GetID(), {
    key = "CalcDamage_5",
    attacker = attacker:GetID(),
    defender = defender:GetID(),
    desc = "公式5：攻击者[attacker] 被击者[defender] 伤害[val] = 基础伤害[baseDamage] * 技能系数[damagePercent] * 元素克制[elementParam] * 暴击系数[critParam] * 主动技吸收系数[activeSkillAbsorbParam] * 技能提升系数[skillIncreaseParam] * 最终系数[skillFinalParam]",
    val = val,
    baseDamage = baseDamage,
    damagePercent = damagePercent,
    elementParam = elementParam,
    activeSkillAbsorbParam = activeSkillAbsorbParam,
    primarySecondaryParam = primarySecondaryParam,
    critParam = critParam,
    skillIncreaseParam = activeSkillIncreaseParam,
    skillFinalParam = skillFinalParam
  })
  return val, damageType
end

function FormulaService:CalcDamage_6(attacker, defender, damageParam, damageGridPos)
  local baseDamage = self:CalcBaseDamage(attacker, defender, damageGridPos)
  local elementParam = self:CalcElementParam(attacker, defender)
  local val = baseDamage * elementParam * damageParam.percent
  val = self:_RET(val)
  local logger = self._world:GetMatchLogger()
  logger:AddDamageLog(attacker:GetID(), {
    key = "CalcDamage_6",
    attacker = attacker:GetID(),
    defender = defender:GetID(),
    desc = "公式6：攻击者[attacker] 被击者[defender] 伤害[val] = 基础伤害[baseDamage] * 元素克制[elementParam] * 技能系数[damagePercent]",
    val = val,
    baseDamage = baseDamage,
    elementParam = elementParam,
    damagePercent = damageParam.percent
  })
  return val, DamageType.Normal
end

function FormulaService:CalcDamage_7(attacker, defender, damageParam, damageGridPos)
  local defenderMaxHp = self:_Attributes(defender):CalcMaxHp()
  local trapSkillIncreaseParam = self:_CalcSkillIncreaseParam_TrapSkill(attacker)
  local trapElementParam = self:CalcTrapElementParam(attacker, defender)
  local val = defenderMaxHp * damageParam.percent * trapElementParam * trapSkillIncreaseParam
  val = self:_RET(val)
  local costPercent = damageParam.percent * trapElementParam * trapSkillIncreaseParam
  local damageType = DamageType.Real
  val, damageType = self:PostProcessDeadDamage(defender, val, damageType)
  local logger = self._world:GetMatchLogger()
  logger:AddDamageLog(attacker:GetID(), {
    key = "CalcDamage_7",
    desc = "公式7：攻击者[attacker] 被击者[defender] 伤害[val] = 血量上限[maxHp] * 技能系数[damagePercent] * 元素克制[trapElementParam] * 技能提升[trapSkillIncreaseParam]",
    attacker = attacker:GetID(),
    defender = defender:GetID(),
    val = val,
    maxHp = defenderMaxHp,
    damagePercent = damageParam.percent,
    trapSkillIncreaseParam = trapSkillIncreaseParam,
    trapElementParam = trapElementParam
  })
  return val, DamageType.Real, costPercent
end

function FormulaService:CalcDamage_8(attacker, defender, damageParam, damageGridPos)
  local maxHp = self:_Attributes(defender):CalcMaxHp()
  local buffElementParam = self:CalcBuffElementParam(PieceType.None, attacker, defender)
  local val = maxHp * damageParam.percent * buffElementParam
  val = self:_RET(val)
  local costPercent = damageParam.percent * buffElementParam
  local damageType = DamageType.Real
  val, damageType = self:PostProcessDeadDamage(defender, val, damageType)
  local logger = self._world:GetMatchLogger()
  logger:AddDamageLog(attacker:GetID(), {
    key = "CalcDamage_8",
    desc = "公式8：攻击者[attacker] 被击者[defender] 伤害[val] = 血量上限[maxHp] * 技能系数[damagePercent] * 元素克制[buffElementParam]",
    attacker = attacker:GetID(),
    defender = defender:GetID(),
    val = val,
    maxHp = maxHp,
    damagePercent = damageParam.percent,
    buffElementParam = buffElementParam
  })
  return val, DamageType.Real, costPercent
end

function FormulaService:CalcDamage_9(attacker, defender, damageParam, damageGridPos)
  local attack = self:CalcAttack(attacker)
  local addPercent = damageParam.addPercent or 0
  local damagePercent = damageParam.percent * (1 + addPercent)
  local val = attack * damagePercent
  val = self:_RET(val)
  local logger = self._world:GetMatchLogger()
  logger:AddDamageLog(attacker:GetID(), {
    key = "CalcDamage_9",
    desc = "公式9：攻击者[attacker] 被击者[defender] 伤害[val] = 攻击[attack] * (百分比[percent] * (1 + 百分比加成[addPercent]))",
    attacker = attacker:GetID(),
    defender = defender:GetID(),
    val = val,
    attack = attack,
    percent = damageParam.percent,
    addPercent = damageParam.addPercent,
    damagePercent = damagePercent
  })
  return val, DamageType.Real
end

function FormulaService:CalcDamage_10(attacker, defender, damageParam, damageGridPos)
  local defenderMaxHp = self:_Attributes(defender):CalcMaxHp()
  local val = defenderMaxHp * damageParam.percent
  val = self:_RET(val)
  local damageType = DamageType.Real
  val, damageType = self:PostProcessPercentDamage(defender, val, damageType)
  local logger = self._world:GetMatchLogger()
  local costPercent = damageParam.percent
  logger:AddDamageLog(attacker:GetID(), {
    key = "CalcDamage_10",
    desc = "公式10：攻击者[attacker] 被击者[defender] 伤害[val] = 血量上限[maxHp] * 百分比[damagePercent]",
    attacker = attacker:GetID(),
    defender = defender:GetID(),
    val = val,
    maxHp = defenderMaxHp,
    damagePercent = damageParam.percent
  })
  return val, damageType, costPercent
end

function FormulaService:CalcDamage_11(attacker, defender, damageParam, damageGridPos)
  local defenderHp = self:_Attributes(defender):GetCurrentHP()
  local val = defenderHp * damageParam.percent
  val = self:_RET(val)
  local damageType = DamageType.Real
  val, damageType = self:PostProcessPercentDamage(defender, val, damageType)
  local logger = self._world:GetMatchLogger()
  logger:AddDamageLog(attacker:GetID(), {
    key = "CalcDamage_11",
    desc = "公式11：攻击者[attacker] 被击者[defender] 伤害[val] = 当前血量[hp] * 百分比[damagePercent]",
    attacker = attacker:GetID(),
    defender = defender:GetID(),
    val = val,
    hp = defenderHp,
    damagePercent = damageParam.percent
  })
  return val, damageType
end

function FormulaService:CalcDamage_13(attacker, defender, damageParam, damageGridPos)
  local maxHP = defender:Attributes():CalcMaxHp()
  local curHp = defender:Attributes():GetCurrentHP()
  local increaseBleed = defender:BuffComponent():GetBuffValue("BleedIncrease") or 1
  local loseHP = maxHP - curHp
  local val = loseHP * damageParam.percent * damageParam.layer * increaseBleed
  val = self:_RET(val)
  local damageType = DamageType.Real
  val, damageType = self:PostProcessPercentDamage(defender, val, damageType)
  local logger = self._world:GetMatchLogger()
  logger:AddDamageLog(attacker:GetID(), {
    key = "CalcDamage_13",
    desc = "公式13：攻击者[attacker] 被击者[defender] 伤害[val] = 损失血量[loseHP] * 百分比[damagePercent]* 流血层数[layer]* 流血加深[inc]",
    attacker = attacker:GetID(),
    defender = defender:GetID(),
    val = val,
    loseHP = loseHP,
    damagePercent = damageParam.percent,
    layer = damageParam.layer,
    inc = increaseBleed
  })
  return val, damageType
end

function FormulaService:CalcDamage_13SP(attacker, defender, damageParam, damageGridPos)
  local averageAtk = self:CalcTeamAverageAttack()
  local defence = self:CalcDefence(defender)
  local defencePercentage = self:CalcDefencePercentage(defender)
  local defenceConstantFix = self:CalcDefenceConstantFix(defender)
  local defenceFinal = math.floor(defence * (1 + defencePercentage) + defenceConstantFix)
  local curHp = self:_Attributes(defender):GetCurrentHP()
  local maxHp = self:_Attributes(defender):CalcMaxHp()
  local hpPercent = curHp / maxHp
  local increaseBleed = defender:BuffComponent():GetBuffValue("BleedIncrease") or 1
  local val = (averageAtk - defenceFinal) * damageParam.percent * (2 - hpPercent) * damageParam.layer * increaseBleed
  local damageType = DamageType.Real
  val, damageType = self:PostProcessPercentDamage(defender, val, damageType)
  val = self:_RET(val)
  local logger = self._world:GetMatchLogger()
  logger:AddDamageLog(attacker:GetID(), {
    key = "CalcDamage_13SP",
    desc = "公式13SP：攻击者[attacker] 被击者[defender] 伤害[val] = (平均攻击力[averageAtk] - 怪物防御[defenderDefence]) * 系数[damagePercent] * (2 - 怪物血量百分比[defenderHpPercent]) * 层数[layer] * 流血加深[inc]",
    attacker = attacker:GetID(),
    defender = defender:GetID(),
    val = val,
    averageAtk = averageAtk,
    defenderDefence = defence,
    damagePercent = damageParam.percent,
    defenderHpPercent = hpPercent,
    layer = damageParam.layer,
    inc = increaseBleed
  })
  return val, damageType
end

function FormulaService:CalcDamage_BleedDamagePlus(attacker, defender, damageParam, damageGridPos)
  local averageAtk = self:CalcTeamAverageAttack()
  local damageSvc = self._world:GetService("CalcDamage")
  local teamEntity = self._world:Player():GetCurrentTeamEntity()
  local curHp, maxHp = damageSvc:GetTeamLogicHP(teamEntity)
  local hpPercent = curHp / maxHp
  local increaseBleed = defender:BuffComponent():GetBuffValue("BleedIncrease") or 1
  local val = averageAtk * damageParam.bleedRatio * (1 + damageParam.layerIncrease) * (hpPercent + damageParam.baseHPPercent) * damageParam.hpDamageRatio * increaseBleed
  local damageType = DamageType.Real
  val, damageType = self:PostProcessPercentDamage(defender, val, damageType)
  val = self:_RET(val)
  local logger = self._world:GetMatchLogger()
  logger:AddDamageLog(attacker:GetID(), {
    key = "CalcDamage_BleedDamagePlus",
    desc = "公式173：攻击者[attacker] 被击者[defender] 伤害[val] = 平均攻击力[averageAtk] * 流血系数[bleedRatio] * (1 + 层数增伤[layerIncrease]) * (队伍当前血量百分比[hpPercent] + 基础血量百分比[baseHPPercent]) * 血量伤害系数[hpDamageRatio] * 流血加深[inc]",
    attacker = attacker:GetID(),
    defender = defender:GetID(),
    val = val,
    averageAtk = averageAtk,
    bleedRatio = damageParam.bleedRatio,
    layerIncrease = damageParam.layerIncrease,
    hpPercent = hpPercent,
    baseHPPercent = damageParam.baseHPPercent,
    hpDamageRatio = damageParam.hpDamageRatio,
    inc = increaseBleed
  })
  return val, damageType
end

function FormulaService:CalcDamage_14(attacker, defender, damageParam, damageGridPos)
  local defenderHp = defender:Attributes():GetCurrentHP()
  local increaseBurn = defender:BuffComponent():GetBuffValue("BurnIncrease") or 1
  local val = math.ceil(defenderHp * damageParam.percent * damageParam.layer * increaseBurn)
  val = self:_RET(val)
  local damageType = DamageType.Real
  val, damageType = self:PostProcessPercentDamage(defender, val, damageType)
  local logger = self._world:GetMatchLogger()
  logger:AddDamageLog(attacker:GetID(), {
    key = "CalcDamage_14",
    desc = "公式14：攻击者[attacker] 被击者[defender] 伤害[val] = 当前血量[curHP] * 百分比[damagePercent]* 层数[layer] * 灼烧加深[increaseBurn]",
    attacker = attacker:GetID(),
    defender = defender:GetID(),
    val = val,
    curHP = defenderHp,
    damagePercent = damageParam.percent,
    layer = damageParam.layer,
    increaseBurn = increaseBurn
  })
  return val, damageType
end

function FormulaService:CalcDamage_14SP(attacker, defender, damageParam, damageGridPos)
  local averageAtk = self:CalcTeamAverageAttack()
  local defence = self:CalcDefence(defender)
  local defencePercentage = self:CalcDefencePercentage(defender)
  local defenceConstantFix = self:CalcDefenceConstantFix(defender)
  local defenceFinal = math.floor(defence * (1 + defencePercentage) + defenceConstantFix)
  local curHp = self:_Attributes(defender):GetCurrentHP()
  local maxHp = self:_Attributes(defender):CalcMaxHp()
  local hpPercent = curHp / maxHp
  if defender:MonsterID() and defender:MonsterID():IsWorldBoss() then
    hpPercent = 1
  end
  local increaseBurn = defender:BuffComponent():GetBuffValue("BurnIncrease") or 1
  local val = (averageAtk - defenceFinal) * damageParam.percent * (1 + hpPercent) * damageParam.layer * increaseBurn
  local damageType = DamageType.Real
  val = self:_RET(val)
  local logger = self._world:GetMatchLogger()
  logger:AddDamageLog(attacker:GetID(), {
    key = "CalcDamage_14SP",
    desc = "公式14SP：攻击者[attacker] 被击者[defender] 伤害[val] = (平均攻击力[averageAtk] - 怪物防御[defenderDefence]) * 系数[damagePercent] * (1 + 怪物血量百分比[defenderHpPercent]) * 层数[layer] * 伤害加深[increaseBurn]",
    attacker = attacker:GetID(),
    defender = defender:GetID(),
    val = val,
    averageAtk = averageAtk,
    defenderDefence = defence,
    damagePercent = damageParam.percent,
    defenderHpPercent = hpPercent,
    layer = damageParam.layer,
    increaseBurn = increaseBurn
  })
  return val, damageType
end

function FormulaService:CalcDamage_15(attacker, defender, damageParam, damageGridPos)
  local defenderMaxHp = defender:Attributes():CalcMaxHp()
  local increasePoison = defender:BuffComponent():GetBuffValue("PoisonIncrease") or 1
  local val = defenderMaxHp * damageParam.percent * damageParam.layer * increasePoison
  val = self:_RET(val)
  local damageType = DamageType.Real
  val, damageType = self:PostProcessPercentDamage(defender, val, damageType)
  local logger = self._world:GetMatchLogger()
  logger:AddDamageLog(attacker:GetID(), {
    key = "CalcDamage_15",
    desc = "公式15：攻击者[attacker] 被击者[defender] 伤害[val] = 最大血量[maxHP] * 伤害系数[damagePercent]* 层数[layer]*中毒伤害加深[inc]",
    attacker = attacker:GetID(),
    defender = defender:GetID(),
    val = val,
    maxHP = defenderMaxHp,
    damagePercent = damageParam.percent,
    layer = damageParam.layer,
    inc = increasePoison
  })
  return val, damageType
end

function FormulaService:CalcDamage_15SP(attacker, defender, damageParam, damageGridPos)
  local atk = self:CalcTeamAverageAttack()
  local increasePoison = defender:BuffComponent():GetBuffValue("PoisonIncrease") or 1
  local val = atk * damageParam.percent * damageParam.layer * increasePoison
  val = self:_RET(val)
  local damageType = DamageType.Real
  val, damageType = self:PostProcessPercentDamage(defender, val, damageType)
  local logger = self._world:GetMatchLogger()
  logger:AddDamageLog(attacker:GetID(), {
    key = "CalcDamage_15SP",
    desc = "公式15SP：攻击者[attacker] 被击者[defender] 伤害[val] = 平均攻击力[averAtk] * 伤害系数[damagePercent]* 层数[layer]*中毒伤害加深[inc]",
    attacker = attacker:GetID(),
    defender = defender:GetID(),
    val = val,
    averAtk = atk,
    damagePercent = damageParam.percent,
    layer = damageParam.layer,
    inc = increasePoison
  })
  return val, damageType
end

function FormulaService:CalcDamage_16(attacker, defender, damageParam, damageGridPos)
  local val = damageParam.baseDamage * damageParam.percent
  val = self:_RET(val)
  local logger = self._world:GetMatchLogger()
  logger:AddDamageLog(attacker:GetID(), {
    key = "CalcDamage_16",
    desc = "公式16：攻击者[attacker] 被击者[defender] 伤害[val] = 基础伤害[baseDamage] * 伤害系数[damagePercent]",
    attacker = attacker:GetID(),
    defender = defender:GetID(),
    val = val,
    baseDamage = damageParam.baseDamage,
    damagePercent = damageParam.percent
  })
  return val, DamageType.Real
end

function FormulaService:CalcDamage_17(attacker, defender, damageParam, damageGridPos)
  local val = defender:Attributes():GetCurrentHP()
  if val < 0 then
    val = 0
  end
  local damageType = DamageType.RealDead
  val, damageType = self:PostProcessDeadDamage(defender, val, damageType)
  local logger = self._world:GetMatchLogger()
  logger:AddDamageLog(attacker:GetID(), {
    key = "CalcDamage_17",
    desc = "公式17：攻击者[attacker] 被击者[defender] 伤害[val]",
    attacker = attacker:GetID(),
    defender = defender:GetID(),
    val = val
  })
  return val, damageType
end

function FormulaService:CalcDamage_18(attacker, defender, damageParam, damageGridPos)
  local attack = self:CalcAttack(attacker)
  local addPercent = damageParam.addPercent or 0
  local damagePercent = damageParam.percent * (1 + addPercent)
  local val = attack * damagePercent
  val = self:_RET(val)
  local logger = self._world:GetMatchLogger()
  logger:AddDamageLog(attacker:GetID(), {
    key = "CalcDamage_18",
    desc = "公式18：攻击者[attacker] 被击者[defender] 伤害[val] = 攻击[attack] * (伤害系数[damagePercent] = 百分比[percent] * (1 + 百分比加成[addPercent]))",
    attacker = attacker:GetID(),
    defender = defender:GetID(),
    val = val,
    attack = attack,
    percent = damageParam.percent,
    addPercent = damageParam.addPercent,
    damagePercent = damagePercent
  })
  return val, DamageType.RealReflexive
end

function FormulaService:CalcDamage_19(attacker, defender, damageParam, damageGridPos)
  local val = damageParam.baseDamage * damageParam.percent
  val = self:_RET(val)
  local logger = self._world:GetMatchLogger()
  logger:AddDamageLog(attacker:GetID(), {
    key = "CalcDamage_19",
    desc = "公式19：攻击者[attacker] 被击者[defender] 伤害[val] = 基础伤害[baseDamage] * 伤害系数[damagePercent]",
    attacker = attacker:GetID(),
    defender = defender:GetID(),
    val = val,
    baseDamage = damageParam.baseDamage,
    damagePercent = damageParam.percent
  })
  return val, DamageType.RealReflexive
end

function FormulaService:CalcDamage_100(attacker, defender, damageParam, damageGridPos)
  local damagePercent = damageParam.percent
  local additionalPercent = damageParam.addPercent
  local finalAtk = self:_CalcFinalAtk(attacker)
  local rawFinalDamage = finalAtk * damagePercent * (1 + additionalPercent)
  local val = self:_RET(rawFinalDamage)
  val = self:_RET(val)
  local logger = self._world:GetMatchLogger()
  logger:AddDamageLog(attacker:GetID(), {
    key = "CalcDamage_100",
    attacker = attacker:GetID(),
    defender = defender:GetID(),
    desc = "公式100：攻击者[attacker] 被击者[defender] 伤害[val] = 攻击[finalAtk] * 伤害系数[damagePercent]* (1 + 加成[additionalPercent])",
    val = val,
    finalAtk = finalAtk,
    damagePercent = damagePercent,
    additionalPercent = additionalPercent
  })
  return val, DamageType.Real
end

function FormulaService:CalcDamage_101(attacker, defender, damageParam, damageGridPos)
  local activeSkillPercentByDefenderHP = self:_CalcActiveSkillPercentByDefenderHP(defender, damageParam)
  if not self:_CheckPercentDamage(defender) then
    activeSkillPercentByDefenderHP = 0
  end
  damageParam.percent = damageParam.percent + activeSkillPercentByDefenderHP
  local val, damageType = self:CalcDamage_5(attacker, defender, damageParam)
  return val, damageType
end

function FormulaService:CalcDamage_102(attacker, defender, damageParam, damageGridPos)
  local val = 0
  local damagePercent = damageParam:GetHpDamagePercent()
  local totalAddedHp = 0
  local targetCount = 0
  local skillEffectResultContainer = attacker:SkillContext():GetResultContainer()
  local scopeResult = skillEffectResultContainer:GetScopeResult()
  local targetIdArray = scopeResult:GetEffectTargetIdArray()
  if targetIdArray then
    targetCount = table.count(targetIdArray)
    if 0 < targetCount then
      local addBloodResultArray = skillEffectResultContainer:GetEffectResultsAsArray(SkillEffectType.AddBlood)
      if addBloodResultArray then
        for i = 1, #addBloodResultArray do
          local value = addBloodResultArray[i]:GetAddValue()
          totalAddedHp = totalAddedHp + value
        end
      end
    end
  end
  if 0 < totalAddedHp then
    val = damagePercent * totalAddedHp / targetCount
  end
  val = self:_RET(val)
  local damageType = DamageType.Real
  val, damageType = self:PostProcessPercentDamage(defender, val, damageType)
  local logger = self._world:GetMatchLogger()
  logger:AddDamageLog(attacker:GetID(), {
    key = "CalcDamage_102",
    desc = "公式102：攻击者[attacker] 被击者[defender] 伤害[val] = 总回血量[totalAddedHp] / 目标数量[targetCount] * 伤害系数[damagePercent]",
    attacker = attacker:GetID(),
    defender = defender:GetID(),
    val = val,
    damagePercent = damagePercent,
    totalAddedHp = totalAddedHp,
    targetCount = targetCount
  })
  return val, damageType
end

function FormulaService:CalcDamage_103(attacker, defender, damageParam, damageGridPos)
  local baseDamage, damageType = self:CalcDamage_5(attacker, defender, damageParam)
  local cSkillCtx = attacker:SkillContext()
  local finalDamageFixMap = cSkillCtx:GetFinalDamageFixMulVal(defender:GetID())
  local damagePercent = 1 + finalDamageFixMap
  local val = baseDamage * damagePercent
  val = self:_RET(val)
  local logger = self._world:GetMatchLogger()
  logger:AddDamageLog(attacker:GetID(), {
    key = "CalcDamage_103",
    desc = "公式103：攻击者[attacker] 被击者[defender] 伤害[val] = 基本伤害[baseDamage] * (伤害系数[damagePercent] = 1+ 距离增伤[fixMul])",
    attacker = attacker:GetID(),
    defender = defender:GetID(),
    val = val,
    damagePercent = damagePercent,
    baseDamage = baseDamage,
    fixMul = finalDamageFixMap
  })
  return val, damageType
end

function FormulaService:CalcDamage_104(attacker, defender, damageParam, damageGridPos)
  local baseDamage, damageType = self:CalcDamage_4(attacker, defender, damageParam, damageGridPos)
  local finalDamageFixChainScopeOverlap = 0
  local buffComp = attacker:BuffComponent()
  local chainScopeOverlapPosList = buffComp:GetBuffValue("ChainScopeOverlapPosList")
  if damageParam.damagePos and chainScopeOverlapPosList and 0 < #chainScopeOverlapPosList then
    local isInChainScopeOverlap = table.intable(chainScopeOverlapPosList, damageParam.damagePos)
    if isInChainScopeOverlap then
      finalDamageFixChainScopeOverlap = buffComp:GetBuffValue("ChainScopeOverlapChangeDamage")
    end
  end
  local damagePercent = 1 + finalDamageFixChainScopeOverlap
  local val = baseDamage * damagePercent
  val = self:_RET(val)
  local logger = self._world:GetMatchLogger()
  logger:AddDamageLog(attacker:GetID(), {
    key = "CalcDamage_104",
    desc = "公式104：攻击者[attacker] 被击者[defender] 伤害[val] = 基本伤害[baseDamage] * (伤害系数[damagePercent] = 1 + 范围重叠增伤[fixMul])",
    attacker = attacker:GetID(),
    defender = defender:GetID(),
    val = val,
    baseDamage = baseDamage,
    fixMul = finalDamageFixChainScopeOverlap,
    damagePercent = damagePercent
  })
  return val, damageType
end

function FormulaService:CalcDamage_105(attacker, defender, damageParam, damageGridPos)
  local elementParam = self:CalcElementParam(attacker, defender)
  local critParam = self:CalcCritParam(damageParam, attacker)
  local activeSkillAbsorbParam, primarySecondaryParam, activeSkillIncreaseParam, skillFinalParam, activeSkillParam = self:_GetActiveSkillParam(attacker, defender, damageGridPos)
  local defenderHp = self:_Attributes(defender):GetCurrentHP()
  local trueDamageFixParam = self:CalcTrueDamageFixParam(attacker)
  local damagePercent = damageParam.percent + trueDamageFixParam
  local val = defenderHp * damagePercent * elementParam * critParam * activeSkillAbsorbParam * activeSkillIncreaseParam * skillFinalParam
  local maxDamage = self:_CalcOnceMaxDamage(attacker, damageParam) or val
  val = math.min(val, maxDamage)
  local damageType = DamageType.Real
  val = self:_RET(val)
  val, damageType = self:PostProcessPercentDamage(defender, val, damageType)
  local logger = self._world:GetMatchLogger()
  logger:AddDamageLog(attacker:GetID(), {
    key = "CalcDamage_105",
    desc = "公式105：攻击者[attacker] 被击者[defender] 伤害[val] = min(伤害上限[maxDamage], 当前血量[hp] * (伤害系数[damagePercent] = 百分比[percent] + 修正系数[fixParam]) * 元素克制[elementParam] * 暴击系数[critParam] * 主动技吸收系数[activeSkillAbsorbParam] * 技能提升系数[skillIncreaseParam] * 最终系数[skillFinalParam])",
    attacker = attacker:GetID(),
    defender = defender:GetID(),
    val = val,
    hp = defenderHp,
    percent = damageParam.percent,
    fixParam = trueDamageFixParam,
    maxDamage = maxDamage,
    activeSkillParam = activeSkillParam,
    elementParam = elementParam,
    activeSkillAbsorbParam = activeSkillAbsorbParam,
    primarySecondaryParam = primarySecondaryParam,
    critParam = critParam,
    skillIncreaseParam = activeSkillIncreaseParam,
    skillFinalParam = skillFinalParam,
    damagePercent = damagePercent
  })
  return val, damageType
end

function FormulaService:CalcDamage_106(attacker, defender, damageParam, damageGridPos)
  local baseDamage = attacker:SkillContext():GetSplashBaseDamage()
  local damagePercent = damageParam:GetSplashRate()
  local val = baseDamage * damagePercent
  val = self:_RET(val)
  local logger = self._world:GetMatchLogger()
  logger:AddDamageLog(attacker:GetID(), {
    key = "CalcDamage_106",
    desc = "公式106：攻击者[attacker] 被击者[defender] 伤害[val] = 基本伤害[baseDamage] * 溅射伤害系数[damagePercent]",
    attacker = attacker:GetID(),
    defender = defender:GetID(),
    val = val,
    baseDamage = baseDamage,
    damagePercent = damagePercent
  })
  return val, DamageType.Normal
end

function FormulaService:CalcDamage_107(attacker, defender, damageParam, damageGridPos)
  local battle_svc = self._world:GetService("Battle")
  local curHP, maxHP = battle_svc:GetCasterHP(attacker)
  local val = maxHP - curHP
  val = self:_RET(val)
  local logger = self._world:GetMatchLogger()
  logger:AddDamageLog(attacker:GetID(), {
    key = "CalcDamage_107",
    desc = "公式107：攻击者[attacker] 被击者[defender] 伤害[val] = 最大血量[MaxHP] - 当前血量[HP]",
    attacker = attacker:GetID(),
    defender = defender:GetID(),
    val = val,
    maxHP = maxHP,
    HP = curHP
  })
  return val, DamageType.Real
end

function FormulaService:CalcDamage_108(attacker, defender, damageParam, damageGridPos)
  local finalAtk = self:_CalcFinalAtk(attacker)
  local elementParam = self:CalcElementParam(attacker, defender)
  local critParam = self:CalcCritParam(damageParam, attacker)
  local activeSkillAbsorbParam, primarySecondaryParam, activeSkillIncreaseParam, skillFinalParam, activeSkillParam = self:_GetActiveSkillParam(attacker, defender, damageGridPos)
  local damagePercent = damageParam.percent + activeSkillParam
  local val = finalAtk * damagePercent * elementParam * critParam * activeSkillAbsorbParam * activeSkillIncreaseParam * skillFinalParam
  val = self:_RET(val)
  local damageType = critParam == 1 and DamageType.Normal or DamageType.Critical
  local logger = self._world:GetMatchLogger()
  logger:AddDamageLog(attacker:GetID(), {
    key = "CalcDamage_108",
    attacker = attacker:GetID(),
    defender = defender:GetID(),
    desc = "公式108：攻击者[attacker] 被击者[defender] 伤害[val] = 基础攻击力[finalAtk] * 伤害系数[damagePercent] * 元素克制[elementParam] * 主动技吸收系数[activeSkillAbsorbParam] * 技能提升系数[skillIncreaseParam] * 最终系数[skillFinalParam]",
    val = val,
    finalAtk = finalAtk,
    damagePercent = damagePercent,
    activeSkillParam = activeSkillParam,
    elementParam = elementParam,
    activeSkillAbsorbParam = activeSkillAbsorbParam,
    primarySecondaryParam = primarySecondaryParam,
    critParam = critParam,
    skillIncreaseParam = activeSkillIncreaseParam,
    skillFinalParam = skillFinalParam
  })
  return val, damageType
end

function FormulaService:CalcDamage_109(attacker, defender, damageParam, damageGridPos)
  local finalAtk = self:_CalcFinalAtk(attacker)
  local buffLayer = damageParam.buffLayer
  local atkPercent = damageParam.percent
  local damagePercent = atkPercent * buffLayer
  local val = finalAtk * damagePercent
  val = self:_RET(val)
  local damageType = DamageType.Normal
  local logger = self._world:GetMatchLogger()
  logger:AddDamageLog(attacker:GetID(), {
    key = "CalcDamage_109",
    attacker = attacker:GetID(),
    defender = defender:GetID(),
    desc = "公式109：攻击者[attacker] 被击者[defender] 伤害[val] = 基础攻击力[finalAtk] * (伤害系数[damagePercent] = Buff层数[buffLayer] *攻击力百分比[atkPercent])",
    val = val,
    finalAtk = finalAtk,
    buffLayer = buffLayer,
    atkPercent = atkPercent,
    damagePercent = damagePercent
  })
  return val, damageType
end

function FormulaService:CalcDamage_110(attacker, defender, damageParam, damageGridPos)
  local cSkillContext = attacker:SkillContext()
  local baseDamage = cSkillContext:GetConductBaseDamage()
  local damagePercent = cSkillContext:GetCurrentConductRate()
  local damageType = DamageType.Real
  local val = baseDamage * damagePercent
  local logger = self._world:GetMatchLogger()
  logger:AddDamageLog(attacker:GetID(), {
    key = "CalcDamage_110",
    attacker = attacker:GetID(),
    defender = defender:GetID(),
    desc = "传导伤害公式110：攻击者[attacker] 被击者[defender] 伤害[val] = 核心伤害[baseDamage] * 传导系数[damagePercent]",
    val = val,
    baseDamage = baseDamage,
    damagePercent = damagePercent
  })
  return val, damageType
end

function FormulaService:CalcDamage_111(attacker, defender, damageParam, damageGridPos)
  local baseDamage = self:CalcBaseDamage(attacker, defender, damageGridPos)
  local elementParam = self:CalcElementParam(attacker, defender)
  local critParam = self:CalcCritParam(damageParam, attacker)
  local activeSkillAbsorbParam, primarySecondaryParam, activeSkillIncreaseParam, skillFinalParam, activeSkillParam = self:_GetActiveSkillParam(attacker, defender, damageGridPos)
  local damagePercent = activeSkillIncreaseParam - 1
  local val = baseDamage * damagePercent * elementParam * critParam * activeSkillAbsorbParam * skillFinalParam
  val = self:_RET(val)
  local damageType = critParam == 1 and DamageType.Normal or DamageType.Critical
  local logger = self._world:GetMatchLogger()
  logger:AddDamageLog(attacker:GetID(), {
    key = "CalcDamage_111",
    attacker = attacker:GetID(),
    defender = defender:GetID(),
    desc = "公式111：攻击者[attacker] 被击者[defender] 伤害[val] = 基础伤害[baseDamage] * (伤害系数[damagePercent] = 技能提升系数[skillIncreaseParam] - 1) * 元素克制[elementParam] * 暴击系数[critParam] * 主动技吸收系数[activeSkillAbsorbParam] * 最终系数[skillFinalParam]",
    val = val,
    baseDamage = baseDamage,
    damagePercent = damagePercent,
    activeSkillParam = activeSkillParam,
    elementParam = elementParam,
    activeSkillAbsorbParam = activeSkillAbsorbParam,
    primarySecondaryParam = primarySecondaryParam,
    critParam = critParam,
    skillIncreaseParam = activeSkillIncreaseParam,
    skillFinalParam = skillFinalParam
  })
  return val, damageType
end

function FormulaService:CalcDamage_112(attacker, defender, damageParam, damageGridPos)
  local finalAtk = self:_CalcFinalAtk(attacker)
  local elementParam = self:CalcElementParam(attacker, defender)
  local critParam = self:CalcCritParam(damageParam, attacker)
  local activeSkillAbsorbParam, primarySecondaryParam, activeSkillIncreaseParam, skillFinalParam, activeSkillParam = self:_GetActiveSkillParam(attacker, defender, damageGridPos)
  local damagePercent = activeSkillIncreaseParam - 1
  local val = finalAtk * elementParam * critParam * activeSkillAbsorbParam * damagePercent * skillFinalParam
  val = self:_RET(val)
  local damageType = critParam == 1 and DamageType.Normal or DamageType.Critical
  local logger = self._world:GetMatchLogger()
  logger:AddDamageLog(attacker:GetID(), {
    key = "CalcDamage_112",
    attacker = attacker:GetID(),
    defender = defender:GetID(),
    desc = "公式112：攻击者[attacker] 被击者[defender] 伤害[val] = 基础攻击力[finalAtk] * 元素克制[elementParam] * 主动技吸收系数[activeSkillAbsorbParam] * (伤害系数[damagePercent] = 技能提升系数[skillIncreaseParam] - 1) * 最终系数[skillFinalParam]",
    val = val,
    finalAtk = finalAtk,
    damagePercent = damagePercent,
    activeSkillParam = activeSkillParam,
    elementParam = elementParam,
    activeSkillAbsorbParam = activeSkillAbsorbParam,
    primarySecondaryParam = primarySecondaryParam,
    critParam = critParam,
    skillIncreaseParam = activeSkillIncreaseParam,
    skillFinalParam = skillFinalParam
  })
  return val, damageType
end

function FormulaService:CalcDamage_113(attacker, defender, damageParam, damageGridPos)
  local finalAtk = self:_CalcFinalAtk(attacker)
  local elementParam = self:CalcElementParam(attacker, defender)
  local critParam = self:CalcCritParam(damageParam, attacker)
  local activeSkillAbsorbParam, primarySecondaryParam, activeSkillIncreaseParam, skillFinalParam, activeSkillParam = self:_GetActiveSkillParam(attacker, defender, damageGridPos)
  local cSkillContext = attacker:SkillContext()
  local buffEffectType = cSkillContext:GetDamagePctIncreaseBuffEffectType()
  local buffMul = cSkillContext:GetDamagePctIncreaseMul()
  local lbfsvc = self._world:GetService("BuffLogic")
  local layer = lbfsvc:GetBuffLayer(defender, buffEffectType)
  local increasedPercent = layer * buffMul
  local cBuffAttacker = attacker:BuffComponent()
  if attacker:SuperEntityComponent() then
    cBuffAttacker = attacker:GetSuperEntity():BuffComponent()
  end
  local rawLimit = cBuffAttacker:GetBuffValue("SmokeyParamLimit")
  local limit = rawLimit or 1 + increasedPercent
  local damagePercent = damageParam.percent + activeSkillParam
  local val = finalAtk * damagePercent * elementParam * critParam * activeSkillAbsorbParam * activeSkillIncreaseParam * skillFinalParam * math.max(1 + increasedPercent, limit)
  val = self:_RET(val)
  local damageType = critParam == 1 and DamageType.Normal or DamageType.Critical
  local logger = self._world:GetMatchLogger()
  logger:AddDamageLog(attacker:GetID(), {
    key = "CalcDamage_113",
    attacker = attacker:GetID(),
    defender = defender:GetID(),
    desc = "公式113：攻击者[attacker] 被击者[defender] 伤害[val] = 基础攻击力[finalAtk] * (伤害系数[damagePercent] = 百分比[percent]+主动技系数buff[activeSkillParam]) * 元素克制[elementParam] * 暴击系数[critParam] * 主动技吸收系数[activeSkillAbsorbParam] * 技能提升系数[skillIncreaseParam] * 最终系数[skillFinalParam] * math.max((1 + (斯莫奇系数[increasedPercent])), 衰减底线[limit])。【原始衰减底线=[rawLimit]】",
    val = val,
    finalAtk = finalAtk,
    damagePercent = damagePercent,
    activeSkillParam = activeSkillParam,
    elementParam = elementParam,
    activeSkillAbsorbParam = activeSkillAbsorbParam,
    primarySecondaryParam = primarySecondaryParam,
    critParam = critParam,
    skillIncreaseParam = activeSkillIncreaseParam,
    skillFinalParam = skillFinalParam,
    increasedPercent = increasedPercent,
    percent = damageParam.percent,
    damagePercent = damagePercent,
    limit = limit,
    rawLimit = rawLimit
  })
  return val, damageType
end

function FormulaService:CalcDamage_114(attacker, defender, damageParam, damageGridPos)
  local attackerDefence = self:CalcDefence(attacker)
  local attackerDefencePercentage = self:CalcDefencePercentage(attacker)
  local attackerDefenceConstantFix = self:CalcDefenceConstantFix(attacker)
  local attackerDefenceFianal = math.floor(attackerDefence * (1 + attackerDefencePercentage) + attackerDefenceConstantFix)
  local val = attackerDefenceFianal * damageParam.percent
  val = self:_RET(val)
  local damageType = DamageType.Real
  local logger = self._world:GetMatchLogger()
  logger:AddDamageLog(attacker:GetID(), {
    key = "CalcDamage_114",
    desc = "公式114：攻击者[attacker] 被击者[defender] 伤害[val] = (攻击者防御力[attackerDefence] * (1 + 攻击者防御力百分比加成系数[attackerDefencePercentage] ) + 攻击者的防御加成绝对值[attackerDefenceConstantFix]) * 伤害系数[damagePercent]",
    attacker = attacker:GetID(),
    defender = defender:GetID(),
    val = val,
    attackerDefence = attackerDefence,
    attackerDefencePercentage = attackerDefencePercentage,
    attackerDefenceConstantFix = attackerDefenceConstantFix,
    damagePercent = damageParam.percent
  })
  return val, damageType
end

function FormulaService:CalcDamage_115(attacker, defender, damageParam, damageGridPos)
  local baseDamage = self:CalcBaseDamage(attacker, defender, damageGridPos)
  local elementParam = self:CalcElementParam(attacker, defender)
  local critParam = self:CalcCritParam(damageParam, attacker)
  local activeSkillAbsorbParam, primarySecondaryParam, activeSkillIncreaseParam, skillFinalParam, activeSkillParam = self:_GetActiveSkillParam(attacker, defender, damageGridPos)
  local damagePercent = damageParam.percent + activeSkillParam
  local degressiveParam = attacker:SkillContext():GetDegressiveDamageParam()
  local val = baseDamage * damagePercent * elementParam * critParam * activeSkillAbsorbParam * activeSkillIncreaseParam * skillFinalParam * degressiveParam
  val = self:_RET(val)
  local damageType = critParam == 1 and DamageType.Normal or DamageType.Critical
  local logger = self._world:GetMatchLogger()
  logger:AddDamageLog(attacker:GetID(), {
    key = "CalcDamage_115",
    attacker = attacker:GetID(),
    defender = defender:GetID(),
    desc = "公式115：攻击者[attacker] 被击者[defender] 伤害[val] = 基础伤害[baseDamage] * 伤害系数[damagePercent] * 元素克制[elementParam] * 暴击系数[critParam] * 主动技吸收系数[activeSkillAbsorbParam] * 技能提升系数[skillIncreaseParam] * 最终系数[skillFinalParam] * 伤害衰减系数[degressiveParam]",
    val = val,
    baseDamage = baseDamage,
    damagePercent = damagePercent,
    activeSkillParam = activeSkillParam,
    elementParam = elementParam,
    activeSkillAbsorbParam = activeSkillAbsorbParam,
    primarySecondaryParam = primarySecondaryParam,
    critParam = critParam,
    skillIncreaseParam = activeSkillIncreaseParam,
    skillFinalParam = skillFinalParam,
    degressiveParam = degressiveParam
  })
  return val, damageType
end

function FormulaService:CalcDamage_116(attacker, defender, damageParam, damageGridPos)
  local baseDamage = self:CalcDamage_2(attacker, defender, damageParam)
  local critParam = self:CalcCritParam(damageParam, attacker)
  local battleService = self._world:GetService("Battle")
  local curHP, maxHP = battleService:GetCasterHP(defender)
  local val = baseDamage
  local percentDamage = damageParam:GetMaxHPDamagePercent() * maxHP
  if not self:_CheckPercentDamage(defender) then
    percentDamage = 0
  end
  val = val + percentDamage
  val = self:_RET(val)
  local damageType = critParam == 1 and DamageType.Normal or DamageType.Critical
  local logger = self._world:GetMatchLogger()
  logger:AddDamageLog(attacker:GetID(), {
    key = "CalcDamage_116",
    attacker = attacker:GetID(),
    defender = defender:GetID(),
    desc = "公式116：攻击者[attacker] 被击者[defender] 伤害[val] = 傷害公式2[baseDamage] + 伤害百分比[percent] * 最大血量[maxHP]",
    val = val,
    baseDamage = baseDamage,
    percent = damageParam:GetMaxHPDamagePercent(),
    maxHP = maxHP
  })
  return val, damageType
end

function FormulaService:CalcDamage_117(attacker, defender, damageParam, damageGridPos)
  local baseDamage = self:CalcBaseDamage(attacker, defender, damageGridPos)
  local monsterSkillParam = self:_CalcSkillParam_MonsterSkill(attacker)
  local damagePercent = damageParam.percent + monsterSkillParam
  local elementParam = self:CalcElementParam(attacker, defender)
  local damageAbsorbParam = self:CalcAbsorbParam_Damage()
  local critParam = self:CalcCritParam(damageParam, attacker)
  local skillIncreaseParam = self:_CalcSkillIncreaseParam_MonsterSkill(attacker)
  local skillFinalParam = self:_CalcSkillFinalParam_MonsterSkill(attacker)
  local val = baseDamage * damagePercent * elementParam * damageAbsorbParam * critParam * skillIncreaseParam * skillFinalParam
  local cAttributes = defender:Attributes()
  local curHP = cAttributes:GetCurrentHP()
  local maxHP = cAttributes:CalcMaxHp()
  local percentHP = curHP / maxHP
  local defEntityHPThreshold = damageParam:GetHPThresholdFormula117()
  local increaseRate = damageParam:GetDamageIncreaseRateFormula117()
  local increaseIndex = 0
  for index, percent in ipairs(defEntityHPThreshold) do
    if percent >= percentHP then
      increaseIndex = index
    end
  end
  local specialIncreaseRate = increaseRate[increaseIndex] or 0
  val = val * (1 + specialIncreaseRate)
  val = self:_RET(val)
  local damageType = critParam == 1 and DamageType.Normal or DamageType.Critical
  local logger = self._world:GetMatchLogger()
  logger:AddDamageLog(attacker:GetID(), {
    desc = "公式117：攻击者[attacker] 被击者[defender] 伤害[val] = 基础伤害[baseDamage] * 伤害系数[damagePercent] * 属性克制[elementParam] * 吸收系数[damageAbsorbParam] * 暴击系数[critParam] * 技能提升[skillIncreaseParam] * 最终系数[skillFinalParam] * (1 + 特殊系数[specialIncreaseRate])",
    key = "CalcDamage_117",
    attacker = attacker:GetID(),
    defender = defender:GetID(),
    val = val,
    baseDamage = baseDamage,
    damagePercent = damagePercent,
    monsterSkillParam = monsterSkillParam,
    elementParam = elementParam,
    damageAbsorbParam = damageAbsorbParam,
    critParam = critParam,
    skillIncreaseParam = skillIncreaseParam,
    skillFinalParam = skillFinalParam,
    specialIncreaseRate = specialIncreaseRate
  })
  return val, damageType
end

function FormulaService:CalcDamage_118(attacker, defender, damageParam, damageGridPos)
  local baseDamage = self:CalcBaseDamage(attacker, defender, damageGridPos)
  local basicPercent = damageParam.percent
  local additionalPercent = damageParam.addPercent
  local rawFinalDamage = baseDamage * basicPercent * (1 + additionalPercent)
  local val = self:_RET(rawFinalDamage)
  val = self:_RET(val)
  local logger = self._world:GetMatchLogger()
  logger:AddDamageLog(attacker:GetID(), {
    key = "CalcDamage_118",
    attacker = attacker:GetID(),
    defender = defender:GetID(),
    desc = "公式118：攻击者[attacker] 被击者[defender] 伤害[val] = 基础伤害[baseDamage] * 百分比[basicPercent]* (1 + 加成[additionalPercent])",
    val = val,
    baseDamage = baseDamage,
    basicPercent = basicPercent,
    additionalPercent = additionalPercent
  })
  return val, DamageType.Normal
end

function FormulaService:CalcDamage_119(attacker, defender, damageParam, damageGridPos)
  local baseDamage, damageType = self:CalcDamage_5(attacker, defender, damageParam, damageGridPos)
  local defBodyArea = defender:BodyArea():GetArea()
  local defBodyCount = #defBodyArea
  local pow = damageParam.BodyAreaPow_119
  local damagePercent = defBodyCount ^ pow
  local val = self:_RET(baseDamage * damagePercent)
  local logger = self._world:GetMatchLogger()
  logger:AddDamageLog(attacker:GetID(), {
    key = "CalcDamage_119",
    desc = "公式119：攻击者[attacker] 被击者[defender] 伤害[val] = 5号公式结果[baseDamage] * (伤害系数[damagePercent] = 受击者占格数[defBodyCount] ^ 幂系数[pow])",
    attacker = attacker:GetID(),
    defender = defender:GetID(),
    baseDamage = baseDamage,
    pow = pow,
    defBodyCount = defBodyCount,
    damagePercent = damagePercent,
    val = val
  })
  return val, damageType
end

function FormulaService:CalcDamage_120(attacker, defender, damageParam, damageGridPos)
  local baseDamage = self:CalcBaseDamage(attacker, defender, damageGridPos)
  local damagePercent = damageParam.percent + self:_CalcSkillParam_NormalSkill(attacker) + self:_CalcSkillParam_DefenderSkillAmpfily(defender)
  local comboParam = self:CalcComboParam(attacker)
  local normalChainParam = self:CalcNormalChainParam(attacker)
  local superGridParam = self:CalcSuperGridParam(attacker)
  local poorGridParam = self:CalcPoorGridParam(attacker)
  local elementParam = self:CalcElementParam(attacker, defender)
  local normalSkillAbsorbParam = self:CalcAbsorbParam_NormalSkill(defender, damageGridPos)
  local primarySecondaryParam = self:CalcPrimarySecondaryParam(attacker)
  local critParam = self:CalcCritParamWithCombo(attacker, damageParam)
  local skillIncreaseParam = self:_CalcSkillIncreaseParam_NormalSkill(attacker)
  local skillFinalParam = self:_CalcSkillFinalParam_NormalSkill(attacker)
  local val = baseDamage * (damagePercent + comboParam + normalChainParam + superGridParam + poorGridParam) * elementParam * normalSkillAbsorbParam * primarySecondaryParam * critParam * skillIncreaseParam * skillFinalParam
  val = self:_RET(val)
  local damageType = critParam == 1 and DamageType.Normal or DamageType.Critical
  local logger = self._world:GetMatchLogger()
  logger:AddDamageLog(attacker:GetID(), {
    key = "CalcDamage_120",
    desc = "公式120：攻击者[attacker] 被击者[defender] 伤害[val] = 基础伤害[baseDamage] * (普攻伤害系数[damagePercent] + combo系数[comboParam] + 普攻连线系数[normalChainParam] + 强化格子系数[superGridParam] + 弱化格子系数[poorGridParam]) * 属性克制系数[elementParam] * 普攻吸收系数[normalSkillAbsorbParam] * 主副属性系数[primarySecondaryParam] * 暴击系数[critParam] * 技能提升系数[skillIncreaseParam] * 技能最终系数[skillFinalParam]",
    attacker = attacker:GetID(),
    defender = defender:GetID(),
    val = val,
    baseDamage = baseDamage,
    damagePercent = damagePercent,
    comboParam = comboParam,
    normalChainParam = normalChainParam,
    superGridParam = superGridParam,
    poorGridParam = poorGridParam,
    elementParam = elementParam,
    normalSkillAbsorbParam = normalSkillAbsorbParam,
    primarySecondaryParam = primarySecondaryParam,
    critParam = critParam,
    skillIncreaseParam = skillIncreaseParam,
    skillFinalParam = skillFinalParam
  })
  return val, damageType
end

function FormulaService:CalcDamage_121(attacker, defender, damageParam, damageGridPos)
  local activeSkillCmpt = defender:ActiveSkill()
  local lastCastSkillEntity = self._world:GetEntityByID(activeSkillCmpt:GetActiveSkillCasterEntityID())
  local battleSvc = self._world:GetService("Battle")
  local attack = lastCastSkillEntity:MatchPet():GetMatchPet():GetPetAttack()
  local val = damageParam.percent * attack
  val = self:_RET(val)
  local damageType = DamageType.Normal
  local logger = self._world:GetMatchLogger()
  logger:AddDamageLog(attacker:GetID(), {
    key = "CalcDamage_121",
    desc = "公式121：攻击者[attacker] 被击者[defender] 伤害[val] = 释放主动技宝宝基础攻击力[finalAtk] * 伤害系数[damagePercent]",
    attacker = attacker:GetID(),
    defender = defender:GetID(),
    val = val,
    finalAtk = attack,
    damagePercent = damageParam.percent
  })
  return val, damageType
end

function FormulaService:CalcDamage_122(attacker, defender, damageParam, damageGridPos)
  local finalAtk = self:_CalcFinalAtk(attacker)
  local elementParam = self:CalcElementParam(attacker, defender)
  local critParam = self:CalcCritParam(damageParam, attacker)
  local activeSkillAbsorbParam, primarySecondaryParam, activeSkillIncreaseParam, skillFinalParam, activeSkillParam = self:_GetActiveSkillParam(attacker, defender, damageGridPos)
  local damagePercent = damageParam.percent + activeSkillParam
  local damageValue = damageParam.damageValue
  local val = damageValue * damagePercent * elementParam * critParam * activeSkillAbsorbParam * activeSkillIncreaseParam * skillFinalParam
  val = self:_RET(val)
  local damageType = critParam == 1 and DamageType.Normal or DamageType.Critical
  local logger = self._world:GetMatchLogger()
  logger:AddDamageLog(attacker:GetID(), {
    key = "CalcDamage_122",
    attacker = attacker:GetID(),
    defender = defender:GetID(),
    desc = "公式122：攻击者[attacker] 被击者[defender] 伤害[val] = 传入的伤害值[baseDamage] *伤害系数[damagePercent] * 元素克制[elementParam] * 主动技吸收系数[activeSkillAbsorbParam] * 技能提升系数[skillIncreaseParam] * 最终系数[skillFinalParam]",
    val = val,
    baseDamage = damageValue,
    damagePercent = damagePercent,
    activeSkillParam = activeSkillParam,
    elementParam = elementParam,
    activeSkillAbsorbParam = activeSkillAbsorbParam,
    primarySecondaryParam = primarySecondaryParam,
    critParam = critParam,
    skillIncreaseParam = activeSkillIncreaseParam,
    skillFinalParam = skillFinalParam
  })
  return val, damageType
end

function FormulaService:CalcDamage_123(attacker, defender, damageParam, damageGridPos)
  local baseDamage, damageType = self:CalcDamage_5(attacker, defender, damageParam, damageGridPos)
  local damagePercent = damageParam:GetAngleDamageRate()
  local val = self:_RET(baseDamage * damagePercent)
  local logger = self._world:GetMatchLogger()
  logger:AddDamageLog(attacker:GetID(), {
    key = "CalcDamage_123",
    desc = "公式123：攻击者[attacker] 被击者[defender] 伤害[val] = 5号公式结果[baseDamage] * (传入的伤害系数[damagePercent])",
    attacker = attacker:GetID(),
    defender = defender:GetID(),
    baseDamage = baseDamage,
    damagePercent = damagePercent,
    val = val
  })
  return val, damageType
end

function FormulaService:CalcDamage_124(attacker, defender, damageParams, damageGridPos)
  local baseDamage = self:CalcBaseDamage(attacker, defender)
  local monsterSkillParam = self:_CalcSkillParam_MonsterSkill(attacker)
  local damagePercent = damageParams.percent + monsterSkillParam
  local damageAbsorbParam = self:CalcAbsorbParam_Damage()
  local critParam = self:CalcCritParam(damageParams, attacker)
  local skillIncreaseParam = self:_CalcSkillIncreaseParam_MonsterSkill(attacker)
  local skillFinalParam = self:_CalcSkillFinalParam_MonsterSkill(attacker)
  local val = baseDamage * damagePercent * damageAbsorbParam * critParam * skillIncreaseParam * skillFinalParam
  val = self:_RET(val)
  local damageType = DamageType.NoElementNormal
  local logger = self._world:GetMatchLogger()
  logger:AddDamageLog(attacker:GetID(), {
    desc = "公式124：攻击者[attacker] 被击者[defender] 伤害[val] = 基础伤害[baseDamage] * 伤害系数[damagePercent] * 吸收系数[damageAbsorbParam] * 暴击系数[critParam] * 技能提升[skillIncreaseParam] * 最终系数[skillFinalParam]",
    key = "CalcDamage_124",
    attacker = attacker:GetID(),
    defender = defender:GetID(),
    val = val,
    baseDamage = baseDamage,
    damagePercent = damagePercent,
    monsterSkillParam = monsterSkillParam,
    damageAbsorbParam = damageAbsorbParam,
    critParam = critParam,
    skillIncreaseParam = skillIncreaseParam,
    skillFinalParam = skillFinalParam
  })
  return val, damageType
end

function FormulaService:CalcDamage_125(attacker, defender, damageParam, damageGridPos)
  local defenderHp = self:_Attributes(defender):GetCurrentHP()
  local val = defenderHp * damageParam.percent
  local damageType = DamageType.Real
  val, damageType = self:PostProcessPercentDamage(defender, val, damageType)
  local attackerDefence = self:CalcDefence(attacker)
  local attackPercentage = damageParam:GetAttackPercentFormula125()
  local val2 = attackerDefence * attackPercentage
  val = self:_RET(val)
  val2 = self:_RET(val2)
  if val <= val2 then
    damageType = DamageType.Real
  end
  val = math.max(val, val2)
  local logger = self._world:GetMatchLogger()
  logger:AddDamageLog(attacker:GetID(), {
    key = "CalcDamage_125",
    desc = "公式125：攻击者[attacker] 被击者[defender] 伤害[val] = max((被击者当前血量[hp] * 百分比[damagePercent]),(攻击基础防御力[defense] * 百分比[attackPercentage]))",
    attacker = attacker:GetID(),
    defender = defender:GetID(),
    val = val,
    hp = defenderHp,
    damagePercent = damageParam.percent,
    defense = attackerDefence,
    attackPercentage = attackPercentage
  })
  return val, damageType
end

function FormulaService:CalcDamage_126(attacker, defender, damageParam, damageGridPos)
  local changeHp = math.abs(damageParam.changeHp)
  local damagePercent = damageParam.percent
  local val = changeHp * damagePercent
  val = self:_RET(val)
  local logger = self._world:GetMatchLogger()
  logger:AddDamageLog(attacker:GetID(), {
    key = "CalcDamage_126",
    desc = "公式126：攻击者[attacker] 被击者[defender] 伤害[val] = 传递者[transer]的流失血量[baseDamage] * 系数[damagePercent]",
    attacker = attacker:GetID(),
    defender = defender:GetID(),
    transer = damageParam.transerID,
    val = val,
    baseDamage = changeHp,
    damagePercent = damagePercent
  })
  return val, DamageType.RealReflexive
end

function FormulaService:CalcDamage_127(attacker, defender, damageParam, damageGridPos)
  local val, damageType = self:CalcDamage_3(attacker, defender, damageParam)
  local battleService = self._world:GetService("Battle")
  local curHP, maxHP = battleService:GetCasterHP(defender)
  local maxPercent = damageParam:GetMaxHPDamagePercent()
  local exValue = maxPercent * maxHP
  if not self:_CheckPercentDamage(defender) then
    exValue = 0
  end
  local retValue = val + exValue
  retValue = self:_RET(retValue)
  local logger = self._world:GetMatchLogger()
  logger:AddDamageLog(attacker:GetID(), {
    key = "CalcDamage_127",
    desc = "公式127：攻击者[attacker] 被击者[defender] 伤害[retValue] = 公式3伤害[baseDamage]+最大血量百分比[damagePercent] * 目标最大血量[maxHP]",
    attacker = attacker:GetID(),
    defender = defender:GetID(),
    retValue = retValue,
    baseDamage = val,
    damagePercent = maxPercent,
    maxHP = maxHP
  })
  return retValue, damageType
end

function FormulaService:CalcDamage_128(attacker, defender, damageParam, damageGridPos)
  local pureDamage = damageParam:GetPureDamage()
  return pureDamage, DamageType.Real
end

function FormulaService:CalcDamage_129(attacker, defender, damageParam, damageGridPos)
  local simpleDamage = damageParam.simpleDamage or 0
  simpleDamage = damageParam.percent * simpleDamage
  return simpleDamage, DamageType.Real
end

function FormulaService:CalcDamage_130(attacker, defender, damageParam, damageGridPos)
  local val = self:_RET(damageParam.hp)
  local logger = self._world:GetMatchLogger()
  logger:AddDamageLog(attacker:GetID(), {
    key = "CalcDamage_130",
    desc = "对局机制专用公式130：被击者[defender] 最终伤害[val]由逻辑计算得出，公式不做处理，不受伤害加重及受伤减轻影响。",
    attacker = attacker:GetID(),
    defender = defender:GetID(),
    val = val
  })
  return val, DamageType.Real
end

function FormulaService:CalcDamage_131(attacker, defender, damageParam, damageGridPos)
  local eCaster = attacker
  if attacker:HasSuperEntity() then
    eCaster = attacker:GetSuperEntity()
  end
  local eAttackerTeam = eCaster:Pet():GetOwnerTeamEntity()
  local maxHP = eAttackerTeam:Attributes():CalcMaxHp()
  local percent = damageParam.percent
  local elementParam = self:CalcElementParam(attacker, defender)
  local activeSkillFinal = self:_CalcSkillFinalParam_ActiveSkill(attacker)
  local val = maxHP * percent * elementParam * activeSkillFinal
  val = self:_RET(val)
  local logger = self._world:GetMatchLogger()
  logger:AddDamageLog(attacker:GetID(), {
    key = "CalcDamage_131",
    desc = "公式131：攻击者[attacker] 被击者[defender] 最终伤害[val] = 最大生命值[maxHP] * 技能系数[damagePercent] * 元素加成[elementParam] * buff终伤加成[skillFinalParam] 【觉3加成在最终处理内】",
    attacker = attacker:GetID(),
    defender = defender:GetID(),
    val = val,
    maxHP = maxHP,
    damagePercent = percent,
    elementParam = elementParam,
    skillFinalParam = activeSkillFinal
  })
  return val, DamageType.Real
end

function FormulaService:CalcDamage_132(attacker, defender, damageParams, damageGridPos)
  local baseDamage = self:CalcBaseDamage(attacker, defender, damageGridPos)
  local chainSkillParam = self:_CalcSkillParam_ChainSkill(attacker)
  local damagePercent = damageParams.percent + chainSkillParam
  local elementParam = self:CalcElementParam(attacker, defender)
  local chainSkillAbsorbParam = self:CalcAbsorbParam_ChainSkill(defender, damageGridPos)
  local primarySecondaryParam = self:CalcPrimarySecondaryParam(attacker)
  local critParam = self:CalcCritParam(damageParams, attacker)
  local skillIncreaseParam = self:_CalcSkillIncreaseParam_ChainSkill(attacker)
  local skillFinalParam = self:_CalcSkillFinalParam_ChainSkill(attacker)
  local val = baseDamage * damagePercent * elementParam * chainSkillAbsorbParam * primarySecondaryParam * critParam * skillIncreaseParam * skillFinalParam
  val = self:_RET(val)
  local damageType = critParam == 1 and DamageType.Normal or DamageType.Critical
  local logger = self._world:GetMatchLogger()
  logger:AddDamageLog(attacker:GetID(), {
    key = "CalcDamage_132",
    desc = "公式132：攻击者[attacker] 被击者[defender] 伤害[val] = 基础伤害[baseDamage] * 技能系数[damagePercent] * 元素克制系数[elementParam] * 连锁技吸收系数[chainSkillAbsorbParam] * 主副属性系数[primarySecondaryParam] * 暴击系数[critParam] * 技能提升系数[skillIncreaseParam] * 技能最终系数[skillFinalParam]",
    attacker = attacker:GetID(),
    defender = defender:GetID(),
    val = val,
    baseDamage = baseDamage,
    damagePercent = damagePercent,
    chainSkillParam = chainSkillParam,
    elementParam = elementParam,
    chainSkillAbsorbParam = chainSkillAbsorbParam,
    primarySecondaryParam = primarySecondaryParam,
    critParam = critParam,
    skillIncreaseParam = skillIncreaseParam,
    skillFinalParam = skillFinalParam
  })
  return val, damageType
end

function FormulaService:CalcDamage_133(attacker, defender, damageParams, damageGridPos)
  local baseDamage = self:CalcBaseDamage(attacker, defender, damageGridPos)
  local chainSkillParam = self:_CalcSkillParam_ChainSkill(attacker)
  local damagePercent = damageParams.percent + chainSkillParam
  local elementParam = self:CalcElementParam(attacker, defender)
  local chainSkillAbsorbParam = self:CalcAbsorbParam_ChainSkill(defender, damageGridPos)
  local primarySecondaryParam = self:CalcPrimarySecondaryParam(attacker)
  local critParam = self:CalcCritParam(damageParams, attacker)
  local skillIncreaseParam = self:_CalcSkillIncreaseParam_ChainSkill(attacker)
  local skillFinalParam = self:_CalcSkillFinalParam_ChainSkill(attacker)
  local splashRate = damageParams:GetSplashRate()
  local val = baseDamage * damagePercent * elementParam * chainSkillAbsorbParam * primarySecondaryParam * critParam * skillIncreaseParam * skillFinalParam * splashRate
  val = self:_RET(val)
  local damageType = critParam == 1 and DamageType.Normal or DamageType.Critical
  local logger = self._world:GetMatchLogger()
  logger:AddDamageLog(attacker:GetID(), {
    key = "CalcDamage_133",
    desc = "公式133：攻击者[attacker] 被击者[defender] 伤害[val] = 基础伤害[baseDamage] * 技能系数[damagePercent] * 元素克制系数[elementParam] * 连锁技吸收系数[chainSkillAbsorbParam] * 主副属性系数[primarySecondaryParam] * 暴击系数[critParam] * 技能提升系数[skillIncreaseParam] * 技能最终系数[skillFinalParam] *溅射系数[splashRate]",
    attacker = attacker:GetID(),
    defender = defender:GetID(),
    val = val,
    baseDamage = baseDamage,
    damagePercent = damagePercent,
    chainSkillParam = chainSkillParam,
    elementParam = elementParam,
    chainSkillAbsorbParam = chainSkillAbsorbParam,
    primarySecondaryParam = primarySecondaryParam,
    critParam = critParam,
    skillIncreaseParam = skillIncreaseParam,
    skillFinalParam = skillFinalParam,
    splashRate = splashRate
  })
  return val, damageType
end

function FormulaService:CalcDamage_134(attacker, defender, damageParams, damageGridPos)
  local oriAttack = self:CalcAttack(attacker)
  local trapAttack = 0
  local trapFinalAttack = 0
  if damageParams:GetUseTrapAttackTrapID() then
    local utilDataSvc = self._world:GetService("UtilData")
    local trapEntitys = utilDataSvc:GetTrapByID(damageParams:GetUseTrapAttackTrapID())
    local useAtkEntity
    if 0 < #trapEntitys then
      useAtkEntity = trapEntitys[1]
    end
    if useAtkEntity then
      trapFinalAttack = self:_CalcFinalAtk(useAtkEntity)
    end
  end
  local baseDamage = self:CalcBaseDamageWithSpecificFinalAttack(attacker, defender, trapFinalAttack, damageGridPos)
  local elementParam = self:CalcElementParam(attacker, defender)
  local critParam = self:CalcCritParam(damageParams, attacker)
  local activeSkillAbsorbParam, primarySecondaryParam, activeSkillIncreaseParam, skillFinalParam, activeSkillParam = self:_GetActiveSkillParam(attacker, defender, damageGridPos)
  local damagePercent = damageParams.percent + activeSkillParam
  local val = baseDamage * damagePercent * elementParam * critParam * activeSkillAbsorbParam * activeSkillIncreaseParam * skillFinalParam
  val = self:_RET(val)
  local damageType = critParam == 1 and DamageType.Normal or DamageType.Critical
  local logger = self._world:GetMatchLogger()
  logger:AddDamageLog(attacker:GetID(), {
    key = "CalcDamage_134",
    attacker = attacker:GetID(),
    defender = defender:GetID(),
    desc = "公式134：攻击者[attacker] 被击者[defender] 伤害[val] = 基础伤害[baseDamage] * 技能系数[damagePercent] * 元素克制[elementParam] * 暴击系数[critParam] * 主动技吸收系数[activeSkillAbsorbParam] * 技能提升系数[skillIncreaseParam] * 最终系数[skillFinalParam]",
    val = val,
    baseDamage = baseDamage,
    damagePercent = damagePercent,
    elementParam = elementParam,
    activeSkillAbsorbParam = activeSkillAbsorbParam,
    primarySecondaryParam = primarySecondaryParam,
    critParam = critParam,
    skillIncreaseParam = activeSkillIncreaseParam,
    skillFinalParam = skillFinalParam
  })
  return val, damageType
end

function FormulaService:CalcDamage_135(attacker, defender, damageParams, damageGridPos)
  local oriAttack = self:CalcAttack(attacker)
  local trapAttack = 0
  local trapFinalAttack = 0
  if damageParams:GetUseTrapAttackTrapID() then
    local utilDataSvc = self._world:GetService("UtilData")
    local trapEntitys = utilDataSvc:GetTrapByID(damageParams:GetUseTrapAttackTrapID())
    local useAtkEntity
    if 0 < #trapEntitys then
      useAtkEntity = trapEntitys[1]
    end
    if useAtkEntity then
      trapFinalAttack = self:_CalcFinalAtk(useAtkEntity)
    end
  end
  local baseDamage = self:CalcBaseDamageWithSpecificFinalAttack(attacker, defender, trapFinalAttack, damageGridPos)
  local chainSkillParam = self:_CalcSkillParam_ChainSkill(attacker)
  local damagePercent = damageParams.percent + chainSkillParam
  local chainChainParam = self:CalcChainChainParam(attacker, damageParams)
  local superGridParam = self:CalcSuperGridParam(attacker, damageParams)
  local poorGridParam = self:CalcPoorGridParam(attacker, damageParams)
  local elementParam = self:CalcElementParam(attacker, defender)
  local chainSkillAbsorbParam = self:CalcAbsorbParam_ChainSkill(defender, damageGridPos)
  local primarySecondaryParam = self:CalcPrimarySecondaryParam(attacker)
  local critParam = self:CalcCritParam(damageParams, attacker)
  local skillIncreaseParam = self:_CalcSkillIncreaseParam_ChainSkill(attacker)
  local skillFinalParam = self:_CalcSkillFinalParam_ChainSkill(attacker)
  local val = baseDamage * damagePercent * (1 + chainChainParam + superGridParam + poorGridParam) * elementParam * chainSkillAbsorbParam * primarySecondaryParam * critParam * skillIncreaseParam * skillFinalParam
  val = self:_RET(val)
  local damageType = critParam == 1 and DamageType.Normal or DamageType.Critical
  local logger = self._world:GetMatchLogger()
  logger:AddDamageLog(attacker:GetID(), {
    key = "CalcDamage_135",
    desc = "公式135：攻击者[attacker] 被击者[defender] 伤害[val] = 基础伤害[baseDamage] * 技能系数[damagePercent] * (1+连锁技连锁系数[chainChainParam]+强化格子系数[superGridParam]+弱化格子系数[poorGridParam]) * 元素克制系数[elementParam] * 连锁技吸收系数[chainSkillAbsorbParam] * 主副属性系数[primarySecondaryParam] * 暴击系数[critParam] * 技能提升系数[skillIncreaseParam] * 技能最终系数[skillFinalParam]",
    attacker = attacker:GetID(),
    defender = defender:GetID(),
    val = val,
    baseDamage = baseDamage,
    damagePercent = damagePercent,
    chainSkillParam = chainSkillParam,
    chainChainParam = chainChainParam,
    superGridParam = superGridParam,
    poorGridParam = poorGridParam,
    elementParam = elementParam,
    chainSkillAbsorbParam = chainSkillAbsorbParam,
    primarySecondaryParam = primarySecondaryParam,
    critParam = critParam,
    skillIncreaseParam = skillIncreaseParam,
    skillFinalParam = skillFinalParam
  })
  return val, damageType
end

function FormulaService:CalcDamage_136(attacker, defender, damageParams, damageGridPos)
  local trapFinalAttack = 0
  local trapElementParam = 1
  local val = 0
  if damageParams:GetUseTrapAttackTrapID() then
    local utilDataSvc = self._world:GetService("UtilData")
    local trapEntitys = utilDataSvc:GetTrapByID(damageParams:GetUseTrapAttackTrapID())
    local useAtkEntity
    if 0 < #trapEntitys then
      useAtkEntity = trapEntitys[1]
    end
    if useAtkEntity then
      trapFinalAttack = self:_CalcFinalAtk(useAtkEntity)
      trapElementParam = self:CalcTrapElementParam(attacker, defender)
    end
  end
  val = trapFinalAttack * damageParams.percent * trapElementParam
  val = self:_RET(val)
  local damageType = DamageType.Real
  local logger = self._world:GetMatchLogger()
  logger:AddDamageLog(attacker:GetID(), {
    key = "CalcDamage_136",
    desc = "公式136：攻击者[attacker] 被击者[defender] 伤害[val] = 攻击[finalAtk] * 技能系数[damagePercent] * 元素克制[elementParam]",
    attacker = attacker:GetID(),
    defender = defender:GetID(),
    val = val,
    finalAtk = trapFinalAttack,
    damagePercent = damageParams.percent,
    elementParam = trapElementParam
  })
  return val, DamageType.Real
end

function FormulaService:CalcDamage_137(attacker, defender, damageParams, damageGridPos)
  local teamEntity = self._world:Player():GetCurrentTeamEntity()
  local baseDamage = self:CalcBaseDamage(attacker, defender, damageGridPos)
  local elementParam = 1
  local critParam = self:CalcCritParam(damageParams, attacker)
  local activeSkillAbsorbParam, primarySecondaryParam, activeSkillIncreaseParam, skillFinalParam, activeSkillParam = self:_GetActiveSkillParam(attacker, defender, damageGridPos)
  local damagePercent = damageParams.percent + activeSkillParam
  local val = baseDamage * damagePercent * elementParam * critParam * activeSkillAbsorbParam * activeSkillIncreaseParam * skillFinalParam
  local spParams = damageParams:GetDamageSpParamsFormula137()
  local buffLayer = 1
  if spParams.layerBuffEffect then
    local buffLogicService = self._world:GetService("BuffLogic")
    buffLayer = buffLogicService:GetBuffLayer(defender, spParams.layerBuffEffect)
  end
  local bWeak = false
  local cBuff = defender:BuffComponent()
  if spParams.weakBuffEffect and cBuff and cBuff:HasBuffEffect(spParams.weakBuffEffect) then
    bWeak = true
  end
  local p5PetCount = 1
  local featureLogicSvc = self._world:GetService("FeatureLogic")
  if featureLogicSvc then
    p5PetCount = featureLogicSvc:GetPersonaPetCount()
  end
  local defBodyArea = defender:BodyArea():GetArea()
  local defBodyCount = #defBodyArea
  local weakParam = bWeak and spParams.d or 0
  val = val * defBodyCount ^ spParams.a * (spParams.b + spParams.c * buffLayer + weakParam) * (spParams.e + spParams.f * p5PetCount)
  val = self:_RET(val)
  local damageType = DamageType.Real
  local logger = self._world:GetMatchLogger()
  logger:AddDamageLog(attacker:GetID(), {
    key = "CalcDamage_137",
    attacker = attacker:GetID(),
    defender = defender:GetID(),
    desc = "公式137：攻击者[attacker] 被击者[defender] 伤害[val] = 基础伤害[baseDamage] * 技能系数[damagePercent] * 元素克制[elementParam] * 暴击系数[critParam] * 主动技吸收系数[activeSkillAbsorbParam] * 技能提升系数[skillIncreaseParam] * 最终系数[skillFinalParam]" .. " * 被击者身形[defBodyCount] ^ 参数a[paramA] * (参数b[paramB] + 参数c[paramC] * 层数[buffLayer] + weak加成[weakParam]) * (参数e[paramE] + 参数f[paramF] * p5光灵数[p5PetNum])",
    val = val,
    baseDamage = baseDamage,
    damagePercent = damagePercent,
    elementParam = elementParam,
    activeSkillAbsorbParam = activeSkillAbsorbParam,
    primarySecondaryParam = primarySecondaryParam,
    critParam = critParam,
    skillIncreaseParam = activeSkillIncreaseParam,
    skillFinalParam = skillFinalParam,
    defBodyCount = defBodyCount,
    paramA = spParams.a,
    paramB = spParams.b,
    paramC = spParams.c,
    paramE = spParams.e,
    paramF = spParams.f,
    buffLayer = buffLayer,
    weakParam = weakParam,
    p5PetNum = p5PetCount
  })
  return val, damageType
end

function FormulaService:CalcDamage_138(attacker, defender, damageParams, damageGridPos)
  local mulMin = damageParams._damageMulMin138 * 100
  local mulMax = damageParams._damageMulMax138 * 100
  local baseDamage = self:CalcBaseDamage(attacker, defender, damageGridPos)
  local damagePercent = damageParams.percent + self:_CalcSkillParam_NormalSkill(attacker) + self:_CalcSkillParam_DefenderSkillAmpfily(defender)
  local comboParam = self:CalcComboParam(attacker)
  local normalChainParam = self:CalcNormalChainParam(attacker)
  local superGridParam = self:CalcSuperGridParam(attacker)
  local poorGridParam = self:CalcPoorGridParam(attacker)
  local elementParam = self:CalcElementParam(attacker, defender)
  local normalSkillAbsorbParam = self:CalcAbsorbParam_NormalSkill(defender, damageGridPos)
  local primarySecondaryParam = self:CalcPrimarySecondaryParam(attacker)
  local critParam = self:CalcCritParam(damageParams, attacker)
  local skillIncreaseParam = self:_CalcSkillIncreaseParam_NormalSkill(attacker)
  local skillFinalParam = self:_CalcSkillFinalParam_NormalSkill(attacker)
  local val = baseDamage * (damagePercent + comboParam + normalChainParam + superGridParam + poorGridParam) * elementParam * normalSkillAbsorbParam * primarySecondaryParam * critParam * skillIncreaseParam * skillFinalParam
  local randomSvc = self._world:GetService("RandomLogic")
  local mul = randomSvc:LogicRand(mulMin, mulMax) * 0.01
  val = val * mul
  val = self:_RET(val)
  local damageType = DamageType.Critical
  local logger = self._world:GetMatchLogger()
  logger:AddDamageLog(attacker:GetID(), {
    key = "CalcDamage_138",
    desc = "公式138：攻击者[attacker] 被击者[defender] 伤害[val] = 基础伤害[baseDamage] * (普攻技能系数[damagePercent] + combo系数[comboParam] + 普攻连线系数[normalChainParam] + 强化格子系数[superGridParam] + 弱化格子系数[poorGridParam]) * 属性克制系数[elementParam] * 普攻吸收系数[normalSkillAbsorbParam] * 主副属性系数[primarySecondaryParam] * 暴击系数[critParam] * 技能提升系数[skillIncreaseParam] * 技能最终系数[skillFinalParam] * 最终浮动系数[floatRate]",
    attacker = attacker:GetID(),
    defender = defender:GetID(),
    val = val,
    baseDamage = baseDamage,
    damagePercent = damagePercent,
    comboParam = comboParam,
    normalChainParam = normalChainParam,
    superGridParam = superGridParam,
    poorGridParam = poorGridParam,
    elementParam = elementParam,
    normalSkillAbsorbParam = normalSkillAbsorbParam,
    primarySecondaryParam = primarySecondaryParam,
    critParam = critParam,
    skillIncreaseParam = skillIncreaseParam,
    skillFinalParam = skillFinalParam,
    floatRate = mul
  })
  return val, damageType
end

function FormulaService:CalcDamage_139(attacker, defender, damageParams, damageGridPos)
  local casterEntity = attacker
  if casterEntity:HasSuperEntity() then
    casterEntity = casterEntity:GetSuperEntity()
  end
  if casterEntity:HasPetPstID() then
    local teamEntity = casterEntity:Pet():GetOwnerTeamEntity()
    casterEntity = teamEntity
  end
  local buffLogicService = self._world:GetService("BuffLogic")
  local baseDamage = buffLogicService:GetHPShield(casterEntity)
  local damagePercent = damageParams.percent
  local val = baseDamage * damagePercent
  val = self:_RET(val)
  local damageType = DamageType.Real
  local logger = self._world:GetMatchLogger()
  logger:AddDamageLog(casterEntity:GetID(), {
    key = "CalcDamage_139",
    desc = "公式139：攻击者[attacker] 被击者[defender] 伤害[val] = 护盾数值[baseDamage]* 技能系数[damagePercent]",
    attacker = casterEntity:GetID(),
    defender = defender:GetID(),
    val = val,
    baseDamage = baseDamage,
    damagePercent = damagePercent
  })
  return val, damageType
end

function FormulaService:CalcDamage_140(attacker, defender, damageParams, damageGridPos)
  local baseDamage = self:CalcBaseDamage(attacker, defender, damageGridPos)
  local elementParam = self:CalcElementParam(attacker, defender)
  local critParam = self:CalcCritParam(damageParams, attacker)
  local activeSkillAbsorbParam, primarySecondaryParam, activeSkillIncreaseParam, skillFinalParam, activeSkillParam = self:_GetActiveSkillParam(attacker, defender, damageGridPos)
  local damagePercent = damageParams.percent
  local val = baseDamage * damagePercent * elementParam * critParam * activeSkillAbsorbParam * activeSkillIncreaseParam * skillFinalParam
  val = self:_RET(val)
  local damageType = critParam == 1 and DamageType.Normal or DamageType.Critical
  local logger = self._world:GetMatchLogger()
  logger:AddDamageLog(attacker:GetID(), {
    key = "CalcDamage_140",
    attacker = attacker:GetID(),
    defender = defender:GetID(),
    desc = "公式140：攻击者[attacker] 被击者[defender] 伤害[val] = 基础伤害[baseDamage] * 技能系数[damagePercent] * 元素克制[elementParam] * 暴击系数[critParam] * 主动技吸收系数[activeSkillAbsorbParam] * 技能提升系数[skillIncreaseParam] * 最终系数[skillFinalParam]",
    val = val,
    baseDamage = baseDamage,
    damagePercent = damagePercent,
    elementParam = elementParam,
    activeSkillAbsorbParam = activeSkillAbsorbParam,
    primarySecondaryParam = primarySecondaryParam,
    critParam = critParam,
    skillIncreaseParam = activeSkillIncreaseParam,
    skillFinalParam = skillFinalParam
  })
  return val, damageType
end

function FormulaService:CalcDamage_141(attacker, defender, damageParam, damageGridPos)
  local changeHp = math.abs(damageParam.changeHp)
  local damagePercent = damageParam.percent
  local val = changeHp * damagePercent
  val = self:_RET(val)
  local logger = self._world:GetMatchLogger()
  logger:AddDamageLog(attacker:GetID(), {
    key = "CalcDamage_141",
    desc = "公式141：攻击者[attacker] 被击者[defender] 伤害[val] = 血量变化[baseDamage] * 传导系数[transPercent]",
    attacker = attacker:GetID(),
    defender = defender:GetID(),
    val = val,
    baseDamage = changeHp,
    transPercent = damagePercent
  })
  return val, DamageType.RealTransmit
end

function FormulaService:CalcDamage_AkxyCasterLayerToDamage(attacker, defender, damageParams, damageGridPos)
  local baseDamage = self:CalcBaseDamage(attacker, defender, damageGridPos)
  local elementParam = self:CalcElementParam(attacker, defender)
  local critParam = self:CalcCritParam(damageParams, attacker)
  local activeSkillAbsorbParam, primarySecondaryParam, activeSkillIncreaseParam, skillFinalParam, activeSkillParam = self:_GetActiveSkillParam(attacker, defender, damageGridPos)
  local blsvc = self._world:GetService("BuffLogic")
  local curLayer = blsvc:GetBuffLayer(attacker, damageParams:GetBuffLayerTypeFormula143())
  local percentByLayer = damageParams:GetPercentByLayerFormula143()
  local damagePercent = curLayer * percentByLayer + activeSkillParam
  local val = baseDamage * damagePercent * elementParam * critParam * activeSkillAbsorbParam * activeSkillIncreaseParam * skillFinalParam
  val = self:_RET(val)
  local damageType = critParam == 1 and DamageType.Normal or DamageType.Critical
  local logger = self._world:GetMatchLogger()
  logger:AddDamageLog(attacker:GetID(), {
    key = "CalcDamage_142",
    attacker = attacker:GetID(),
    defender = defender:GetID(),
    desc = "公式142：攻击者[attacker] 被击者[defender] 伤害[val] = 基础伤害[baseDamage] * 技能系数[damagePercent] * 元素克制[elementParam] * 暴击系数[critParam] * 主动技吸收系数[activeSkillAbsorbParam] * 技能提升系数[skillIncreaseParam] * 最终系数[skillFinalParam]",
    val = val,
    baseDamage = baseDamage,
    damagePercent = damagePercent,
    elementParam = elementParam,
    activeSkillAbsorbParam = activeSkillAbsorbParam,
    primarySecondaryParam = primarySecondaryParam,
    critParam = critParam,
    skillIncreaseParam = activeSkillIncreaseParam,
    skillFinalParam = skillFinalParam
  })
  return val, damageType
end

function FormulaService:CalcDamage_PoisonByAttack(attacker, defender, damageParam)
  local val = damageParam.attack * damageParam.percent * damageParam.layer
  val = self:_RET(val)
  local damageType = DamageType.Real
  local logger = self._world:GetMatchLogger()
  logger:AddDamageLog(attacker:GetID(), {
    key = "CalcDamage_PoisonByAttack",
    desc = "公式142：攻击者[attacker] 被击者[defender] 伤害[val] = 最终攻击力[finalAtk] * 伤害系数[damagePercent] * 层数[layer]",
    attacker = attacker:GetID(),
    defender = defender:GetID(),
    val = val,
    finalAtk = damageParam.attack,
    damagePercent = damageParam.percent,
    layer = damageParam.layer
  })
  return val, damageType
end

function FormulaService:CalcDamage_WeikeCompanionNormalAttack(attacker, defender, damageParams, damageGridPos)
  local baseDamage = self:CalcBaseDamage(attacker, defender, damageGridPos)
  local damagePercent = damageParams.percent + self:_CalcSkillParam_NormalSkill(attacker) + self:_CalcSkillParam_DefenderSkillAmpfily(defender)
  local elementParam = self:CalcElementParam(attacker, defender)
  local normalSkillAbsorbParam = self:CalcAbsorbParam_NormalSkill(defender, damageGridPos)
  local primarySecondaryParam = self:CalcPrimarySecondaryParam(attacker)
  local critParam = self:CalcCritParam(damageParams, attacker)
  local skillIncreaseParam = self:_CalcSkillIncreaseParam_NormalSkill(attacker)
  local skillFinalParam = self:_CalcSkillFinalParam_NormalSkill(attacker)
  local val = baseDamage * damagePercent * elementParam * normalSkillAbsorbParam * primarySecondaryParam * critParam * skillIncreaseParam * skillFinalParam
  val = self:_RET(val)
  local damageType = critParam == 1 and DamageType.Normal or DamageType.Critical
  local logger = self._world:GetMatchLogger()
  logger:AddDamageLog(attacker:GetID(), {
    key = "CalcDamage_WeikeCompanionNormalAttack",
    desc = "公式144：攻击者[attacker] 被击者[defender] 伤害[val] = 基础伤害[baseDamage] * (普攻技能系数[damagePercent]) * 属性克制系数[elementParam] * 普攻吸收系数[normalSkillAbsorbParam] * 主副属性系数[primarySecondaryParam] * 暴击系数[critParam] * 技能提升系数[skillIncreaseParam] * 技能最终系数[skillFinalParam]",
    attacker = attacker:GetID(),
    defender = defender:GetID(),
    val = val,
    baseDamage = baseDamage,
    damagePercent = damagePercent,
    elementParam = elementParam,
    normalSkillAbsorbParam = normalSkillAbsorbParam,
    primarySecondaryParam = primarySecondaryParam,
    critParam = critParam,
    skillIncreaseParam = skillIncreaseParam,
    skillFinalParam = skillFinalParam
  })
  return val, damageType
end

function FormulaService:CalcDamage_AbsoluteRemainHP(attacker, defender, damageParam, damageGridPos)
  local cAttr = defender:Attributes()
  local currentHP = cAttr:GetCurrentHP()
  local val = self:_RET(currentHP - damageParam:GetAbsoluteRemainHPFormula145())
  if currentHP - val <= 0 then
    val = currentHP - 1
  end
  local logger = self._world:GetMatchLogger()
  logger:AddDamageLog(attacker:GetID(), {
    key = "CalcDamage_145",
    desc = "公式145：【boss特殊机制】被击者[defender] 最终伤害[val] 公式不做处理，不受伤害加重及受伤减轻影响。",
    attacker = attacker:GetID(),
    defender = defender:GetID(),
    val = val
  })
  return val, DamageType.Real
end

function FormulaService:CalcDamage_RealDamageByLoseHP(attacker, defender, damageParam, damageGridPos)
  local cAttr = defender:Attributes()
  local maxHP = cAttr:CalcMaxHp()
  local currentHP = cAttr:GetCurrentHP()
  local loseHP = maxHP - currentHP
  local damagePercent = damageParam.percent
  local val = loseHP * damagePercent
  val = self:_RET(val)
  local logger = self._world:GetMatchLogger()
  logger:AddDamageLog(attacker:GetID(), {
    key = "CalcDamage_RealDamageByLoseHP",
    desc = "公式146：攻击者[attacker] 被击者[defender] 伤害[val] = 损失血量[loseHP] * 技能系数[damagePercent]",
    attacker = attacker:GetID(),
    defender = defender:GetID(),
    val = val,
    loseHP = loseHP,
    damagePercent = damagePercent
  })
  return val, DamageType.Real
end

function FormulaService:CalcDamage_AntiSetNoPercentDamage(attacker, defender, damageParam, damageGridPos)
  local elementParam = self:CalcElementParam(attacker, defender)
  local critParam = self:CalcCritParam(damageParam, attacker)
  local activeSkillAbsorbParam, primarySecondaryParam, activeSkillIncreaseParam, skillFinalParam, activeSkillParam = self:_GetActiveSkillParam(attacker, defender, damageGridPos)
  local defenderHp = self:_Attributes(defender):GetCurrentHP()
  local trueDamageFixParam = self:CalcTrueDamageFixParam(attacker)
  local damagePercent = damageParam.percent + trueDamageFixParam
  local val = defenderHp * damagePercent * elementParam * critParam * activeSkillAbsorbParam * activeSkillIncreaseParam * skillFinalParam
  local maxDamage = self:_CalcOnceMaxDamage(attacker, damageParam) or val
  val = math.min(val, maxDamage)
  local minDamage = self:_CalcOnceMinDamage(attacker, damageParam) or val
  val = math.max(val, minDamage)
  local damageType = DamageType.Real
  local buffLogicSvc = self._world:GetService("BuffLogic")
  if not buffLogicSvc:IsTargetCanBePercentDamage(defender) then
    val = minDamage
  end
  val = self:_RET(val)
  local logger = self._world:GetMatchLogger()
  logger:AddDamageLog(attacker:GetID(), {
    key = "CalcDamage_AntiSetNoPercentDamage",
    desc = "公式147：攻击者[attacker] 被击者[defender] 伤害[val] = min(伤害上限[maxDamage], 当前血量[hp] * (伤害系数[damagePercent] = 百分比[percent] + 修正系数[fixParam]) * 元素克制[elementParam] * 暴击系数[critParam] * 主动技吸收系数[activeSkillAbsorbParam] * 技能提升系数[skillIncreaseParam] * 最终系数[skillFinalParam])",
    attacker = attacker:GetID(),
    defender = defender:GetID(),
    val = val,
    hp = defenderHp,
    percent = damageParam.percent,
    fixParam = trueDamageFixParam,
    maxDamage = maxDamage,
    activeSkillParam = activeSkillParam,
    elementParam = elementParam,
    activeSkillAbsorbParam = activeSkillAbsorbParam,
    primarySecondaryParam = primarySecondaryParam,
    critParam = critParam,
    skillIncreaseParam = activeSkillIncreaseParam,
    skillFinalParam = skillFinalParam,
    damagePercent = damagePercent
  })
  return val, damageType
end

function FormulaService:CalcDamage_AntiSetNoPercentDamageMaxHPPercent(attacker, defender, damageParam, damageGridPos)
  local elementParam = self:CalcElementParam(attacker, defender)
  local critParam = self:CalcCritParam(damageParam, attacker)
  local activeSkillAbsorbParam, primarySecondaryParam, activeSkillIncreaseParam, skillFinalParam, activeSkillParam = self:_GetActiveSkillParam(attacker, defender, damageGridPos)
  local defenderHp = self:_Attributes(defender):CalcMaxHp()
  local trueDamageFixParam = self:CalcTrueDamageFixParam(attacker)
  local damagePercent = damageParam.percent + trueDamageFixParam
  local val = defenderHp * damagePercent * elementParam * critParam * activeSkillAbsorbParam * activeSkillIncreaseParam * skillFinalParam
  local maxDamage = self:_CalcOnceMaxDamage(attacker, damageParam) or val
  val = math.min(val, maxDamage)
  local minDamage = self:_CalcOnceMinDamage(attacker, damageParam) or val
  val = math.max(val, minDamage)
  local damageType = DamageType.Real
  local buffLogicSvc = self._world:GetService("BuffLogic")
  if not buffLogicSvc:IsTargetCanBePercentDamage(defender) then
    val = minDamage
  end
  val = self:_RET(val)
  local logger = self._world:GetMatchLogger()
  logger:AddDamageLog(attacker:GetID(), {
    key = "CalcDamage_AntiSetNoPercentDamageMaxHPPercent",
    desc = "公式148：攻击者[attacker] 被击者[defender] 伤害[val] = min(伤害上限[maxDamage], 当前血量[hp] * (伤害系数[damagePercent] = 百分比[percent] + 修正系数[fixParam]) * 元素克制[elementParam] * 暴击系数[critParam] * 主动技吸收系数[activeSkillAbsorbParam] * 技能提升系数[skillIncreaseParam] * 最终系数[skillFinalParam])",
    attacker = attacker:GetID(),
    defender = defender:GetID(),
    val = val,
    hp = defenderHp,
    percent = damageParam.percent,
    fixParam = trueDamageFixParam,
    maxDamage = maxDamage,
    activeSkillParam = activeSkillParam,
    elementParam = elementParam,
    activeSkillAbsorbParam = activeSkillAbsorbParam,
    primarySecondaryParam = primarySecondaryParam,
    critParam = critParam,
    skillIncreaseParam = activeSkillIncreaseParam,
    skillFinalParam = skillFinalParam,
    damagePercent = damagePercent
  })
  return val, damageType
end

function FormulaService:CalcDamage_ActiveAttackNoAbsorb(attacker, defender, damageParams, damageGridPos)
  local baseDamage = self:CalcBaseDamage(attacker, defender, damageGridPos)
  local elementParam = self:CalcElementParam(attacker, defender)
  local critParam = self:CalcCritParam(damageParams, attacker)
  local activeSkillAbsorbParam, primarySecondaryParam, activeSkillIncreaseParam, skillFinalParam = self:_GetActiveSkillParam(attacker, defender, damageGridPos)
  local damagePercent = damageParams.percent
  local val = baseDamage * damagePercent * elementParam * critParam * activeSkillIncreaseParam
  val = self:_RET(val)
  local damageType = critParam == 1 and DamageType.Normal or DamageType.Critical
  local logger = self._world:GetMatchLogger()
  logger:AddDamageLog(attacker:GetID(), {
    key = "CalcDamage_149",
    attacker = attacker:GetID(),
    defender = defender:GetID(),
    desc = "公式149：攻击者[attacker] 被击者[defender] 伤害[val] = 基础伤害[baseDamage] * 技能系数[damagePercent] * 元素克制[elementParam] * 暴击系数[critParam] * 技能提升系数[skillIncreaseParam] ",
    val = val,
    baseDamage = baseDamage,
    damagePercent = damagePercent,
    elementParam = elementParam,
    critParam = critParam,
    skillIncreaseParam = activeSkillIncreaseParam
  })
  return val, damageType
end

function FormulaService:CalcDamage_Formula11AntiSetNoPercentDamage(attacker, defender, damageParam, damageGridPos)
  local defenderHp = self:_Attributes(defender):GetCurrentHP()
  local val = defenderHp * damageParam.percent
  val = self:_RET(val)
  local damageType = DamageType.Real
  val, damageType = self:PostProcessPercentDamage(defender, val, damageType)
  local maxDamage = self:_CalcOnceMaxDamage(attacker, damageParam) or val
  val = math.min(val, maxDamage)
  local minDamage = self:_CalcOnceMinDamage(attacker, damageParam) or val
  val = math.max(val, minDamage)
  local buffLogicSvc = self._world:GetService("BuffLogic")
  if not buffLogicSvc:IsTargetCanBePercentDamage(defender) then
    val = minDamage
    damageType = DamageType.Real
  end
  local logger = self._world:GetMatchLogger()
  logger:AddDamageLog(attacker:GetID(), {
    key = "CalcDamage_150",
    desc = "公式150：攻击者[attacker] 被击者[defender] 伤害[val] = 当前血量[hp] * 百分比[damagePercent]，最低值[min]",
    attacker = attacker:GetID(),
    defender = defender:GetID(),
    val = val,
    hp = defenderHp,
    damagePercent = damageParam.percent,
    min = minDamage
  })
  return val, damageType
end

function FormulaService:CalcDamage_Formula105NoSkillParam(attacker, defender, damageParam, damageGridPos)
  local elementParam = self:CalcElementParam(attacker, defender)
  local critParam = self:CalcCritParam(damageParam, attacker)
  local defenderHp = self:_Attributes(defender):GetCurrentHP()
  local trueDamageFixParam = self:CalcTrueDamageFixParam(attacker)
  local damagePercent = damageParam.percent + trueDamageFixParam
  local val = defenderHp * damagePercent * elementParam * critParam
  local maxDamage = self:_CalcOnceMaxDamage(attacker, damageParam) or val
  val = math.min(val, maxDamage)
  local damageType = DamageType.Real
  val = self:_RET(val)
  val, damageType = self:PostProcessPercentDamage(defender, val, damageType)
  local logger = self._world:GetMatchLogger()
  logger:AddDamageLog(attacker:GetID(), {
    key = "CalcDamage_Formula105NoSkillParam",
    desc = "公式151：攻击者[attacker] 被击者[defender] 伤害[val] = min(伤害上限[maxDamage], 当前血量[hp] * (伤害系数[damagePercent] = 百分比[percent] + 修正系数[fixParam]) * 元素克制[elementParam] * 暴击系数[critParam])",
    attacker = attacker:GetID(),
    defender = defender:GetID(),
    val = val,
    hp = defenderHp,
    percent = damageParam.percent,
    fixParam = trueDamageFixParam,
    maxDamage = maxDamage,
    elementParam = elementParam,
    critParam = critParam,
    damagePercent = damagePercent
  })
  return val, damageType
end

function FormulaService:CalcDamage_Formula147NoSkillParam(attacker, defender, damageParam, damageGridPos)
  local elementParam = self:CalcElementParam(attacker, defender)
  local critParam = self:CalcCritParam(damageParam, attacker)
  local defenderHp = self:_Attributes(defender):GetCurrentHP()
  local trueDamageFixParam = self:CalcTrueDamageFixParam(attacker)
  local damagePercent = damageParam.percent + trueDamageFixParam
  local val = defenderHp * damagePercent * elementParam * critParam
  local maxDamage = self:_CalcOnceMaxDamage(attacker, damageParam) or val
  val = math.min(val, maxDamage)
  local minDamage = self:_CalcOnceMinDamage(attacker, damageParam) or val
  val = math.max(val, minDamage)
  local damageType = DamageType.Real
  local buffLogicSvc = self._world:GetService("BuffLogic")
  if not buffLogicSvc:IsTargetCanBePercentDamage(defender) then
    val = minDamage
  end
  val = self:_RET(val)
  local logger = self._world:GetMatchLogger()
  logger:AddDamageLog(attacker:GetID(), {
    key = "CalcDamage_Formula147NoSkillParam",
    desc = "公式152：攻击者[attacker] 被击者[defender] 伤害[val] = min(伤害上限[maxDamage], 当前血量[hp] * (伤害系数[damagePercent] = 百分比[percent] + 修正系数[fixParam]) * 元素克制[elementParam] * 暴击系数[critParam] )",
    attacker = attacker:GetID(),
    defender = defender:GetID(),
    val = val,
    hp = defenderHp,
    percent = damageParam.percent,
    fixParam = trueDamageFixParam,
    maxDamage = maxDamage,
    elementParam = elementParam,
    critParam = critParam,
    damagePercent = damagePercent
  })
  return val, damageType
end

function FormulaService:CalcDamage_Formula148NoSkillParam(attacker, defender, damageParam, damageGridPos)
  local elementParam = self:CalcElementParam(attacker, defender)
  local critParam = self:CalcCritParam(damageParam, attacker)
  local defenderHp = self:_Attributes(defender):CalcMaxHp()
  local trueDamageFixParam = self:CalcTrueDamageFixParam(attacker)
  local damagePercent = damageParam.percent + trueDamageFixParam
  local val = defenderHp * damagePercent * elementParam * critParam
  local maxDamage = self:_CalcOnceMaxDamage(attacker, damageParam) or val
  val = math.min(val, maxDamage)
  local minDamage = self:_CalcOnceMinDamage(attacker, damageParam) or val
  val = math.max(val, minDamage)
  local damageType = DamageType.Real
  local buffLogicSvc = self._world:GetService("BuffLogic")
  if not buffLogicSvc:IsTargetCanBePercentDamage(defender) then
    val = minDamage
  end
  val = self:_RET(val)
  local logger = self._world:GetMatchLogger()
  logger:AddDamageLog(attacker:GetID(), {
    key = "CalcDamage_Formula148NoSkillParam",
    desc = "公式153：攻击者[attacker] 被击者[defender] 伤害[val] = min(伤害上限[maxDamage], 当前血量[hp] * (伤害系数[damagePercent] = 百分比[percent] + 修正系数[fixParam]) * 元素克制[elementParam] * 暴击系数[critParam] )",
    attacker = attacker:GetID(),
    defender = defender:GetID(),
    val = val,
    hp = defenderHp,
    percent = damageParam.percent,
    fixParam = trueDamageFixParam,
    maxDamage = maxDamage,
    elementParam = elementParam,
    critParam = critParam,
    damagePercent = damagePercent
  })
  return val, damageType
end

function FormulaService:CalcDamage_Formula9AddElementParam(attacker, defender, damageParam, damageGridPos)
  local attack = self:CalcAttack(attacker)
  local addPercent = damageParam.addPercent or 0
  local damagePercent = damageParam.percent * (1 + addPercent)
  local elementParam = self:CalcElementParam(attacker, defender)
  local val = attack * damagePercent * elementParam
  val = self:_RET(val)
  local logger = self._world:GetMatchLogger()
  logger:AddDamageLog(attacker:GetID(), {
    key = "Formula9AddElementParam",
    desc = "公式154：攻击者[attacker] 被击者[defender] 伤害[val] = 攻击[attack] * (百分比[percent] * (1 + 百分比加成[addPercent])) * 元素克制[elementParam]",
    attacker = attacker:GetID(),
    defender = defender:GetID(),
    val = val,
    attack = attack,
    elementParam = elementParam,
    percent = damageParam.percent,
    addPercent = damageParam.addPercent,
    damagePercent = damagePercent
  })
  return val, DamageType.Real
end

function FormulaService:CalcDamage_RealDamageByAddBlood(attacker, defender, damageParam, damageGridPos)
  local changeHP = damageParam.changeHP
  local damagePercent = damageParam.percent
  local val = changeHP * damagePercent
  val = self:_RET(val)
  local logger = self._world:GetMatchLogger()
  logger:AddDamageLog(attacker:GetID(), {
    key = "RealDamageByAddBlood",
    desc = "公式155：攻击者[attacker] 被击者[defender] 伤害[val] = 加血量[baseDamage] * 系数[damagePercent]",
    attacker = attacker:GetID(),
    defender = defender:GetID(),
    val = val,
    baseDamage = changeHP,
    damagePercent = damagePercent
  })
  return val, DamageType.Real
end

function FormulaService:CalcDamage_Monster2003301SacrificeDamage(attacker, defender, damageParam, damageGridPos)
  local battle_svc = self._world:GetService("Battle")
  local curHP, maxHP = battle_svc:GetCasterHP(attacker)
  local cSkillContext = attacker:SkillContext()
  local val = cSkillContext:GetSacrificedHP() * damageParam.percent
  val = self:_RET(val)
  local logger = self._world:GetMatchLogger()
  logger:AddDamageLog(attacker:GetID(), {
    key = "CalcDamage_156",
    desc = "公式156：攻击者[attacker] 被击者[defender] 伤害[val] = 最大血量[MaxHP] - 当前血量[HP]",
    attacker = attacker:GetID(),
    defender = defender:GetID(),
    val = val,
    maxHP = maxHP,
    HP = curHP
  })
  return val, DamageType.Real
end

function FormulaService:CalcDamage_TeamCurHpRealDamage(attacker, defender, damageParam, damageGridPos)
  local lsvcCalcDamage = self._world:GetService("CalcDamage")
  local eCaster = attacker
  if attacker:HasSuperEntity() then
    eCaster = attacker:GetSuperEntity()
  end
  local eAttackerTeam = eCaster:Pet():GetOwnerTeamEntity()
  local teamHP, teamMaxHP = lsvcCalcDamage:GetTeamLogicHP(eAttackerTeam)
  local currentHP = teamHP
  local damagePercent = damageParam.percent
  local val = currentHP * damagePercent
  val = self:_RET(val)
  local logger = self._world:GetMatchLogger()
  logger:AddDamageLog(attacker:GetID(), {
    key = "CalcDamage_RealDamageByLoseHP",
    desc = "公式157：攻击者[attacker] 被击者[defender] 伤害[val] = 队伍当前血量[teamHP] * 技能系数[damagePercent]",
    attacker = attacker:GetID(),
    defender = defender:GetID(),
    val = val,
    teamHP = currentHP,
    damagePercent = damagePercent
  })
  return val, DamageType.Real
end

function FormulaService:CalcDamage_Formula4UseChainCount(attacker, defender, damageParams, damageGridPos)
  local baseDamage = self:CalcBaseDamage(attacker, defender, damageGridPos)
  local chainSkillParam = self:_CalcSkillParam_ChainSkill(attacker)
  local damagePercent = damageParams.percent + chainSkillParam
  local petAtkComponent = self:GetEntityPetAtkDataCmpt(attacker)
  local chainCount = petAtkComponent:GetChainRateList(damageParams.skillID)
  local chainChainParam = damageParams:GetChainBasePercentFormula158() * chainCount
  local superGridParam = self:CalcSuperGridParam(attacker, damageParams)
  local poorGridParam = self:CalcPoorGridParam(attacker, damageParams)
  local elementParam = self:CalcElementParam(attacker, defender)
  local chainSkillAbsorbParam = self:CalcAbsorbParam_ChainSkill(defender, damageGridPos)
  local primarySecondaryParam = self:CalcPrimarySecondaryParam(attacker)
  local critParam = self:CalcCritParam(damageParams, attacker)
  local skillIncreaseParam = self:_CalcSkillIncreaseParam_ChainSkill(attacker)
  local skillFinalParam = self:_CalcSkillFinalParam_ChainSkill(attacker)
  local val = baseDamage * damagePercent * (1 + chainChainParam + superGridParam + poorGridParam) * elementParam * chainSkillAbsorbParam * primarySecondaryParam * critParam * skillIncreaseParam * skillFinalParam
  val = self:_RET(val)
  local damageType = critParam == 1 and DamageType.Normal or DamageType.Critical
  local logger = self._world:GetMatchLogger()
  logger:AddDamageLog(attacker:GetID(), {
    key = "CalcDamage_Formula4UseChainCount",
    desc = "公式158：攻击者[attacker] 被击者[defender] 伤害[val] = 基础伤害[baseDamage] * 技能系数[damagePercent] * (1+连锁技连锁系数[chainChainParam]+强化格子系数[superGridParam]+弱化格子系数[poorGridParam]) * 元素克制系数[elementParam] * 连锁技吸收系数[chainSkillAbsorbParam] * 主副属性系数[primarySecondaryParam] * 暴击系数[critParam] * 技能提升系数[skillIncreaseParam] * 技能最终系数[skillFinalParam]",
    attacker = attacker:GetID(),
    defender = defender:GetID(),
    val = val,
    baseDamage = baseDamage,
    damagePercent = damagePercent,
    chainSkillParam = chainSkillParam,
    chainChainParam = chainChainParam,
    superGridParam = superGridParam,
    poorGridParam = poorGridParam,
    elementParam = elementParam,
    chainSkillAbsorbParam = chainSkillAbsorbParam,
    primarySecondaryParam = primarySecondaryParam,
    critParam = critParam,
    skillIncreaseParam = skillIncreaseParam,
    skillFinalParam = skillFinalParam
  })
  return val, damageType
end

function FormulaService:CalcDamage_Formula105SimpleParam(attacker, defender, damageParam, damageGridPos)
  local defenderHp = self:_Attributes(defender):GetCurrentHP()
  local trueDamageFixParam = self:CalcTrueDamageFixParam(attacker)
  local damagePercent = damageParam.percent + trueDamageFixParam
  local val = defenderHp * damagePercent
  local maxDamage = self:_CalcOnceMaxDamage(attacker, damageParam) or val
  val = math.min(val, maxDamage)
  local damageType = DamageType.Real
  val = self:_RET(val)
  val, damageType = self:PostProcessPercentDamage(defender, val, damageType)
  local logger = self._world:GetMatchLogger()
  logger:AddDamageLog(attacker:GetID(), {
    key = "CalcDamage_Formula105SimpleParam",
    desc = "公式159：攻击者[attacker] 被击者[defender] 伤害[val] = min(伤害上限[maxDamage], 当前血量[hp] * (伤害系数[damagePercent] = 百分比[percent] + 修正系数[fixParam]))",
    attacker = attacker:GetID(),
    defender = defender:GetID(),
    val = val,
    hp = defenderHp,
    percent = damageParam.percent,
    fixParam = trueDamageFixParam,
    maxDamage = maxDamage,
    damagePercent = damagePercent
  })
  return val, damageType
end

function FormulaService:CalcDamage_RebeccaPoisonRealDamage(attacker, defender, damageParam, damageGridPos)
  local damagePercent = damageParam.percent
  local finalAtk = self:_CalcFinalAtk(attacker)
  local elementParam = self:CalcElementParam(attacker, defender)
  local increasePoison = defender:BuffComponent():GetBuffValue("RebeccaPoisonIncrease") or 1
  local rawFinalDamage = finalAtk * damagePercent * elementParam * increasePoison
  local val = self:_RET(rawFinalDamage)
  val = self:_RET(val)
  local logger = self._world:GetMatchLogger()
  logger:AddDamageLog(attacker:GetID(), {
    key = "CalcDamage_RebeccaPoisonRealDamage",
    attacker = attacker:GetID(),
    defender = defender:GetID(),
    desc = "公式160：攻击者[attacker] 被击者[defender] 伤害[val] = 攻击[finalAtk] * 伤害系数[damagePercent] * 元素克制系数[elementParam] * 丽蓓卡中毒伤害加深[inc]  ",
    val = val,
    finalAtk = finalAtk,
    damagePercent = damagePercent,
    elementParam = elementParam,
    inc = increasePoison
  })
  return val, DamageType.Real
end

function FormulaService:CalcDamage_MonsterAttackAndTargetHpPercent(attacker, defender, damageParams, damageGridPos)
  local defenderHp = self:_Attributes(defender):GetCurrentHP()
  local damageForDefenderCurHp = math.floor(defenderHp * damageParams:GetHpPercent161())
  local baseDamage = self:CalcBaseDamage(attacker, defender, damageGridPos)
  local monsterSkillParam = self:_CalcSkillParam_MonsterSkill(attacker)
  local damagePercent = damageParams.percent + monsterSkillParam
  local elementParam = self:CalcElementParam(attacker, defender)
  local damageAbsorbParam = self:CalcAbsorbParam_Damage()
  local critParam = self:CalcCritParam(damageParams, attacker)
  local skillIncreaseParam = self:_CalcSkillIncreaseParam_MonsterSkill(attacker)
  local skillFinalParam = self:_CalcSkillFinalParam_MonsterSkill(attacker)
  local val = baseDamage * damagePercent * elementParam * damageAbsorbParam * critParam * skillIncreaseParam * skillFinalParam
  val = self:_RET(val)
  val = val + damageForDefenderCurHp
  local damageType = critParam == 1 and DamageType.Normal or DamageType.Critical
  local logger = self._world:GetMatchLogger()
  logger:AddDamageLog(attacker:GetID(), {
    desc = "公式161：攻击者[attacker] 被击者[defender] 伤害[val] = (基础伤害[baseDamage] * 技能系数[damagePercent] * 属性克制[elementParam] * 吸收系数[damageAbsorbParam] * 暴击系数[critParam] * 技能提升[skillIncreaseParam] * 最终系数[skillFinalParam]) + 目标当前血量造成的伤害[damageForDefenderCurHp]",
    key = "CalcDamage_161",
    attacker = attacker:GetID(),
    defender = defender:GetID(),
    val = val,
    baseDamage = baseDamage,
    damagePercent = damagePercent,
    monsterSkillParam = monsterSkillParam,
    elementParam = elementParam,
    damageAbsorbParam = damageAbsorbParam,
    critParam = critParam,
    skillIncreaseParam = skillIncreaseParam,
    skillFinalParam = skillFinalParam,
    damageForDefenderCurHp = damageForDefenderCurHp
  })
  return val, damageType
end

function FormulaService:CalcDamage_NormalAttackUseTeamAverageAttack(attacker, defender, damageParams, damageGridPos)
  local sourceAttackID = attacker:GetID()
  local normalChainParam = self:CalcNormalChainParam(attacker)
  local superGridParam = self:CalcSuperGridParam(attacker)
  local poorGridParam = self:CalcPoorGridParam(attacker)
  if attacker:HasSuperEntity() then
    normalChainParam = self:CalcNormalChainParam_ChenNiEquip(attacker)
    superGridParam = self:CalcSuperGridParam_ChenNiEquip(attacker)
    poorGridParam = self:CalcPoorGridParam_ChenNiEquip(attacker)
    attacker = attacker:GetSuperEntity()
  end
  local finalAtk
  local cTeam = attacker:Pet():GetOwnerTeamEntity():Team()
  local petEntities = cTeam:GetTeamPetEntities()
  local totalAtk = 0
  local petCount = 0
  for _, petEntity in pairs(petEntities) do
    if not petEntity:HasDeadMark() then
      local petAtk = petEntity:Attributes():GetAttack()
      totalAtk = totalAtk + petAtk
      petCount = petCount + 1
    end
  end
  finalAtk = self:_RET(totalAtk / petCount)
  local baseDamage = self:CalcBaseDamageWithSpecificFinalAttack(attacker, defender, finalAtk, damageGridPos)
  local damagePercent = damageParams.percent + self:_CalcSkillParam_NormalSkill(attacker) + self:_CalcSkillParam_DefenderSkillAmpfily(defender)
  local comboParam = self:CalcComboParam(attacker)
  local elementParam = self:CalcElementParam(attacker, defender)
  local normalSkillAbsorbParam = self:CalcAbsorbParam_NormalSkill(defender, damageGridPos)
  local primarySecondaryParam = self:CalcPrimarySecondaryParam(attacker)
  local critParam = self:CalcCritParam(damageParams, attacker)
  local skillIncreaseParam = self:_CalcSkillIncreaseParam_NormalSkill(attacker)
  local skillFinalParam = self:_CalcSkillFinalParam_NormalSkill(attacker)
  local val = baseDamage * (damagePercent + comboParam + normalChainParam + superGridParam + poorGridParam) * elementParam * normalSkillAbsorbParam * primarySecondaryParam * critParam * skillIncreaseParam * skillFinalParam
  val = self:_RET(val)
  local damageType = critParam == 1 and DamageType.Normal or DamageType.Critical
  local logger = self._world:GetMatchLogger()
  logger:AddDamageLog(sourceAttackID, {
    key = "CalcDamage_162",
    desc = "公式162：攻击者[attacker] 被击者[defender] 伤害[val] = 基础伤害[baseDamage] * (普攻技能系数[damagePercent] + combo系数[comboParam] + 普攻连线系数[normalChainParam] + 强化格子系数[superGridParam] + 弱化格子系数[poorGridParam]) * 属性克制系数[elementParam] * 普攻吸收系数[normalSkillAbsorbParam] * 主副属性系数[primarySecondaryParam] * 暴击系数[critParam] * 技能提升系数[skillIncreaseParam] * 技能最终系数[skillFinalParam]",
    attacker = sourceAttackID,
    defender = defender:GetID(),
    val = val,
    baseDamage = baseDamage,
    damagePercent = damagePercent,
    comboParam = comboParam,
    normalChainParam = normalChainParam,
    superGridParam = superGridParam,
    poorGridParam = poorGridParam,
    elementParam = elementParam,
    normalSkillAbsorbParam = normalSkillAbsorbParam,
    primarySecondaryParam = primarySecondaryParam,
    critParam = critParam,
    skillIncreaseParam = skillIncreaseParam,
    skillFinalParam = skillFinalParam
  })
  return val, damageType
end

function FormulaService:CalcDamage_TeamCurHpPercentRealDamage(attacker, defender, damageParam, damageGridPos)
  local lsvcCalcDamage = self._world:GetService("CalcDamage")
  local eCaster = attacker
  if attacker:HasSuperEntity() then
    eCaster = attacker:GetSuperEntity()
  end
  local teamEntity
  if eCaster:HasTeam() then
    teamEntity = eCaster
  elseif eCaster:HasPet() then
    teamEntity = eCaster:Pet():GetOwnerTeamEntity()
  end
  local teamHP, teamMaxHP = lsvcCalcDamage:GetTeamLogicHP(teamEntity)
  local currentHP = teamHP
  local damagePercent = damageParam.percent
  local damagePercent1 = damageParam:GetPercent163() or 1
  local val = currentHP * damagePercent * damagePercent1
  val = self:_RET(val)
  local logger = self._world:GetMatchLogger()
  logger:AddDamageLog(attacker:GetID(), {
    key = "CalcDamage_TeamCurHpPercentRealDamage",
    desc = "公式163：攻击者[attacker] 被击者[defender] 伤害[val] = 队伍当前血量[teamHP] * 技能系数[damagePercent] * 技能系数1[damagePercent1]",
    attacker = attacker:GetID(),
    defender = defender:GetID(),
    val = val,
    teamHP = currentHP,
    damagePercent = damagePercent,
    damagePercent1 = damagePercent1
  })
  return val, DamageType.Real
end

function FormulaService:CalcDamage_CampSkillAttack(attacker, defender, damageParam, damageGridPos)
  local baseDamage = self:CalcBaseDamage(attacker, defender, damageGridPos)
  local elementParam = self:CalcElementParam(attacker, defender)
  local increaseParam = self:_CalcSkillIncreaseParam_CampSkill(attacker)
  local finalParam = self:_CalcSkillFinalParam_CampSkill(attacker)
  local val = baseDamage * elementParam * damageParam.percent * increaseParam * finalParam
  val = self:_RET(val)
  local logger = self._world:GetMatchLogger()
  logger:AddDamageLog(attacker:GetID(), {
    key = "CalcDamage_CampSkillAttack",
    desc = "公式164：攻击者[attacker] 被击者[defender] 伤害[val] = 基础伤害[baseDamage] * 元素克制[elementParam] * 技能系数[damagePercent] * 技能提升系数[skillIncreaseParam] * 技能最终系数[skillFinalParam]",
    attacker = attacker:GetID(),
    defender = defender:GetID(),
    val = val,
    baseDamage = baseDamage,
    elementParam = elementParam,
    damagePercent = damageParam.percent,
    skillIncreaseParam = increaseParam,
    skillFinalParam = finalParam
  })
  return val, DamageType.Real
end

function FormulaService:CalcDamage_AutoBeadSkillDamage(attacker, defender, damageParam, damageGridPos)
  local autoBeadAttackDataCmpt = attacker:SkillAutoBeadAttackData()
  if not autoBeadAttackDataCmpt then
    return
  end
  local curAutoBeadID = autoBeadAttackDataCmpt:GetCurrentAutoBeadID()
  if curAutoBeadID and 0 < curAutoBeadID then
  else
    return
  end
  local autoBeadCmpt = attacker:LogicAutoBead()
  if not autoBeadCmpt then
    return
  end
  local autoBeadData = autoBeadCmpt:GetAutoBeadInnerDataByID(curAutoBeadID)
  if not autoBeadData then
    return
  end
  local randomSvc = self._world:GetService("RandomLogic")
  local baseDamage = autoBeadData:GetAutoBeadAttr(ESeasonMazeAutoBeadAttr.ESeasonMazeAutoBeadAttr_Hurt)
  local randDamageRange = autoBeadData:GetAutoBeadAttr(ESeasonMazeAutoBeadAttr.ESeasonMazeAutoBeadAttr_HurtFload)
  randDamageRange = randDamageRange / 1000
  local attackerBuffCmpt = attacker:BuffComponent()
  if attackerBuffCmpt then
    local extraRandRange = attacker:BuffComponent():GetBuffValue("AutoBeadDamageRandRangeExtra") or 0
    if extraRandRange and extraRandRange ~= 0 then
      Log.debug("auto bead damage, rand extraRange, baseRange:", randDamageRange, " extraRange:", extraRandRange)
    end
    randDamageRange = randDamageRange + extraRandRange
  end
  local randDamageRangeVal = math.floor(baseDamage * randDamageRange)
  local randDamageMin = baseDamage - randDamageRangeVal
  randDamageMin = math.max(0, randDamageMin)
  local randDamageMax = baseDamage + randDamageRangeVal
  local randDamage = randomSvc:LogicRand(randDamageMin, randDamageMax)
  local attackerBuffCmpt = attacker:BuffComponent()
  if attackerBuffCmpt then
    local randTwice = attacker:BuffComponent():GetBuffValue("AutoBeadDamageRandTwice") or 0
    if randTwice and randTwice == 1 then
      local randDamageSecond = randomSvc:LogicRand(randDamageMin, randDamageMax)
      Log.debug("auto bead damage, rand twice, first:", randDamage, " second:", randDamageSecond, " randDamageMin:", randDamageMin, " randDamageMax:", randDamageMax)
      randDamage = math.max(randDamage, randDamageSecond)
    end
  end
  local skillFinalParam = self:_CalcSkillFinalParam_AutoBeadSkill(attacker)
  local critDamageRate = autoBeadData:GetAutoBeadAttr(ESeasonMazeAutoBeadAttr.ESeasonMazeAutoBeadAttr_CritHurt)
  critDamageRate = critDamageRate / 1000
  local critChance = autoBeadData:GetAutoBeadAttr(ESeasonMazeAutoBeadAttr.ESeasonMazeAutoBeadAttr_Crit)
  local critProb = critChance / 1000
  local critParam = self:CalcAutoBeadCritParam(critProb, critDamageRate, attacker)
  local val = randDamage * skillFinalParam * critParam
  val = self:_RET(val)
  local damageType = critParam == 1 and DamageType.Real or DamageType.Critical
  local logger = self._world:GetMatchLogger()
  logger:AddDamageLog(attacker:GetID(), {
    key = "CalcDamage_AutoBeadSkillDamage",
    desc = "公式168：攻击者[attacker] 被击者[defender] 伤害[val] = 浮动伤害[randDamage] * 技能最终系数[skillFinalParam] * 自动珠暴击系数[autoBeadCritParam] ",
    attacker = attacker:GetID(),
    defender = defender:GetID(),
    val = val,
    randDamage = randDamage,
    skillFinalParam = skillFinalParam,
    autoBeadCritParam = critParam
  })
  return val, damageType
end

function FormulaService:CalcDamage_AutoBeadSkillDamageSP(attacker, defender, damageParam, damageGridPos)
  local randomSvc = self._world:GetService("RandomLogic")
  local baseDamage = damageParam.Damage
  local randDamageRange = damageParam.DamageFloatRate
  randDamageRange = randDamageRange / 1000
  local randDamageRangeVal = math.floor(baseDamage * randDamageRange)
  local randDamageMin = baseDamage - randDamageRangeVal
  randDamageMin = math.max(0, randDamageMin)
  local randDamageMax = baseDamage + randDamageRangeVal
  local randDamage = randomSvc:LogicRand(randDamageMin, randDamageMax)
  local skillFinalParam = self:_CalcSkillFinalParam_AutoBeadSkill(attacker)
  local critDamageRate = damageParam.CritRate
  critDamageRate = critDamageRate / 1000
  local critProb = damageParam.CritProb
  critProb = critProb / 1000
  local critParam = self:CalcAutoBeadCritParam(critProb, critDamageRate, attacker)
  local val = randDamage * skillFinalParam * critParam
  val = self:_RET(val)
  local damageType = critParam == 1 and DamageType.Real or DamageType.Critical
  local logger = self._world:GetMatchLogger()
  logger:AddDamageLog(attacker:GetID(), {
    key = "CalcDamage_AutoBeadSkillDamageSP",
    desc = "公式170：攻击者[attacker] 被击者[defender] 伤害[val] = 浮动伤害[randDamage] * 技能最终系数[skillFinalParam] * 自动珠暴击系数[autoBeadCritParam] ",
    attacker = attacker:GetID(),
    defender = defender:GetID(),
    val = val,
    randDamage = randDamage,
    skillFinalParam = skillFinalParam,
    autoBeadCritParam = critParam
  })
  return val, damageType
end

function FormulaService:CalcDamage_FixedDamage(attacker, defender, damageParam, damageGridPos)
  local fixedDamage = damageParam.fixedDamage or damageParam:GetFixedDamage()
  local layer = damageParam.layer or damageParam:GetLayerForFixedDamage()
  local val = fixedDamage * layer
  val = self:_RET(val)
  local damageType = DamageType.Real
  local logger = self._world:GetMatchLogger()
  logger:AddDamageLog(attacker:GetID(), {
    key = "CalcDamage_FixedDamage",
    desc = "公式169：攻击者[attacker] 被击者[defender] 伤害[val] = 固定伤害[fixedDamage] * 层数[layer] ",
    attacker = attacker:GetID(),
    defender = defender:GetID(),
    val = val,
    fixedDamage = fixedDamage,
    layer = layer
  })
  return val, damageType
end

function FormulaService:CalcDamage_LossDamagePercent(attacker, defender, damageParam, damageGridPos)
  local attackEntity = attacker
  if attacker:HasSuperEntity() and attacker:GetSuperEntity() then
    attackEntity = attacker:GetSuperEntity()
  end
  local battle_svc = self._world:GetService("Battle")
  local curHP, maxHP = battle_svc:GetCasterHP(attackEntity)
  local lossHP = maxHP - curHP
  local val = lossHP * damageParam.percent
  val = self:_RET(val)
  local damageType = DamageType.Real
  local logger = self._world:GetMatchLogger()
  logger:AddDamageLog(attackEntity:GetID(), {
    key = "CalcDamage_LossDamagePercent",
    desc = "公式171：攻击者[attacker] 被击者[defender] 伤害[val] = 施法者损失血量[hp] * 百分比[damagePercent]",
    attacker = attackEntity:GetID(),
    defender = attackEntity:GetID(),
    val = val,
    hp = lossHP,
    damagePercent = damageParam.percent
  })
  return val, damageType
end

function FormulaService:CalcDamage_RebeccaPoisonNormalDamage(attacker, defender, damageParam, damageGridPos)
  local baseDamage = self:CalcBaseDamage(attacker, defender, damageGridPos)
  local elementParam = self:CalcElementParam(attacker, defender)
  local increasePoison = defender:BuffComponent():GetBuffValue("RebeccaPoisonIncrease") or 1
  local val = baseDamage * elementParam * damageParam.percent * increasePoison
  val = self:_RET(val)
  local logger = self._world:GetMatchLogger()
  logger:AddDamageLog(attacker:GetID(), {
    key = "CalcDamage_RebeccaPoisonNormalDamage",
    attacker = attacker:GetID(),
    defender = defender:GetID(),
    desc = "公式172：攻击者[attacker] 被击者[defender] 伤害[val] = 基础伤害[baseDamage] * 元素克制[elementParam] * 技能系数[damagePercent] * 丽蓓卡中毒伤害加深[inc]",
    val = val,
    baseDamage = baseDamage,
    elementParam = elementParam,
    damagePercent = damageParam.percent,
    inc = increasePoison
  })
  return val, DamageType.Normal
end

function FormulaService:CalcDamage_LossHp2RealDamage(attacker, defender, damageParams, damageGridPos)
  local lsvcCalcDamage = self._world:GetService("CalcDamage")
  local caster = attacker
  if attacker:HasSuperEntity() then
    caster = attacker:GetSuperEntity()
  end
  local attackerTeam = caster:Pet():GetOwnerTeamEntity()
  local teamHP, teamMaxHP = lsvcCalcDamage:GetTeamLogicHP(attackerTeam)
  local baseDamage = teamMaxHP - teamHP
  baseDamage = baseDamage + damageParams:GetFixedDamage()
  local elementParam = self:CalcElementParam(attacker, defender)
  local critParam = self:CalcCritParam(damageParams, attacker)
  local activeSkillAbsorbParam, primarySecondaryParam, activeSkillIncreaseParam, skillFinalParam, activeSkillParam = self:_GetActiveSkillParam(attacker, defender, damageGridPos)
  local damagePercent = damageParams.percent + activeSkillParam
  local val = baseDamage * damagePercent * elementParam * critParam * activeSkillAbsorbParam * activeSkillIncreaseParam * skillFinalParam
  val = self:_RET(val)
  local damageType = DamageType.Real
  local logger = self._world:GetMatchLogger()
  logger:AddDamageLog(attacker:GetID(), {
    key = "CalcDamage_LossHp2RealDamage",
    attacker = attacker:GetID(),
    defender = defender:GetID(),
    desc = "公式174：攻击者[attacker] 被击者[defender] 伤害[val] = 基础伤害[baseDamage] * 技能系数[damagePercent] * 元素克制[elementParam] * 暴击系数[critParam] * 主动技吸收系数[activeSkillAbsorbParam] * 技能提升系数[skillIncreaseParam] * 最终系数[skillFinalParam]",
    val = val,
    baseDamage = baseDamage,
    damagePercent = damagePercent,
    elementParam = elementParam,
    activeSkillAbsorbParam = activeSkillAbsorbParam,
    primarySecondaryParam = primarySecondaryParam,
    critParam = critParam,
    skillIncreaseParam = activeSkillIncreaseParam,
    skillFinalParam = skillFinalParam
  })
  return val, damageType
end

function FormulaService:CalcDamage_UseTeamAverageAttackCostBuffLayerPct(attacker, defender, damageParams, damageGridPos)
  local baseDamage = self:CalcBaseDamage(attacker, defender, damageGridPos)
  local chainSkillParam = self:_CalcSkillParam_ChainSkill(attacker)
  local damagePercent = damageParams.percent + chainSkillParam
  local petAtkComponent = self:GetEntityPetAtkDataCmpt(attacker)
  local superGridParam = self:CalcSuperGridParam(attacker, damageParams)
  local poorGridParam = self:CalcPoorGridParam(attacker, damageParams)
  local elementParam = self:CalcElementParam(attacker, defender)
  local chainSkillAbsorbParam = self:CalcAbsorbParam_ChainSkill(defender, damageGridPos)
  local primarySecondaryParam = self:CalcPrimarySecondaryParam(attacker)
  local critParam = self:CalcCritParam(damageParams, attacker)
  local skillIncreaseParam = self:_CalcSkillIncreaseParam_ChainSkill(attacker)
  local skillFinalParam = self:_CalcSkillFinalParam_ChainSkill(attacker)
  local teamAvgDmg = self:CalcTeamAverageAttack()
  local buffID = damageParams:GetBuffID()
  local layerCostPct = damageParams:GetLayerCostPct()
  local layerDmgPct = damageParams:GetLayerDmgPct()
  local buffDamage = 0
  local costLayer = 0
  local finalDef = 0
  if buffID then
    local blsvc = self._world:GetService("BuffLogic")
    local curLayer = blsvc:GetBuffLayer(attacker, buffID)
    local leftLayer = math.max(0, math.floor(curLayer * layerCostPct))
    costLayer = curLayer - leftLayer
    local finalAtk = teamAvgDmg * layerDmgPct * costLayer
    finalDef = self:_CalcFinalDef(defender, attacker, damageGridPos)
    buffDamage = finalAtk - finalDef
  end
  buffDamage = math.max(0, buffDamage)
  local val = baseDamage * damagePercent * (1 + superGridParam + poorGridParam) * elementParam * chainSkillAbsorbParam * primarySecondaryParam * critParam * skillIncreaseParam * skillFinalParam + buffDamage
  val = self:_RET(val)
  local damageType = critParam == 1 and DamageType.Normal or DamageType.Critical
  local logger = self._world:GetMatchLogger()
  logger:AddDamageLog(attacker:GetID(), {
    key = "CalcDamage_175",
    desc = "公式175：攻击者[attacker] 被击者[defender] 伤害[val] = (基础伤害[baseDamage] * 技能系数[damagePercent] * (1+强化格子系数[superGridParam]+弱化格子系数[poorGridParam]) * 元素克制系数[elementParam] * 连锁技吸收系数[chainSkillAbsorbParam] * 主副属性系数[primarySecondaryParam] * 暴击系数[critParam] * 技能提升系数[skillIncreaseParam] * 技能最终系数[skillFinalParam]) + math.max((全队平均攻击力[teamAvgDmg] * 消耗层数[costLayer] * 每层伤害系数[layerDmgPct]) - 目标防御力[finalDef]), 0)",
    attacker = attacker:GetID(),
    defender = defender:GetID(),
    val = val,
    baseDamage = baseDamage,
    damagePercent = damagePercent,
    chainSkillParam = chainSkillParam,
    superGridParam = superGridParam,
    poorGridParam = poorGridParam,
    elementParam = elementParam,
    chainSkillAbsorbParam = chainSkillAbsorbParam,
    primarySecondaryParam = primarySecondaryParam,
    critParam = critParam,
    skillIncreaseParam = skillIncreaseParam,
    skillFinalParam = skillFinalParam,
    teamAvgDmg = teamAvgDmg,
    layerDmgPct = layerDmgPct,
    costLayer = costLayer,
    finalDef = finalDef
  })
  return val, damageType
end

function FormulaService:CalcDamage_CalDmgByDistance(attacker, defender, damageParams, damageGridPos)
  local sourceAttackID = attacker:GetID()
  if attacker:HasSuperEntity() then
    attacker = attacker:GetSuperEntity()
  end
  local baseDamage = self:CalcBaseDamage(attacker, defender, damageGridPos)
  local gridDis = self:CalGridDistance(attacker, defender)
  local bonusPerGrid = damageParams:GetBonusPerGrid()
  local damagePercent = damageParams.percent + self:_CalcSkillParam_NormalSkill(attacker) + self:_CalcSkillParam_DefenderSkillAmpfily(defender)
  local normalChainParam = self:CalcNormalChainParam(attacker)
  local comboParam = self:CalcComboParam(attacker)
  local elementParam = self:CalcElementParam(attacker, defender)
  local normalSkillAbsorbParam = self:CalcAbsorbParam_NormalSkill(defender, damageGridPos)
  local primarySecondaryParam = self:CalcPrimarySecondaryParam(attacker)
  local critParam = self:CalcCritParam(damageParams, attacker)
  local skillIncreaseParam = self:_CalcSkillIncreaseParam_NormalSkill(attacker)
  local skillFinalParam = self:_CalcSkillFinalParam_NormalSkill(attacker)
  local val = baseDamage * (gridDis * bonusPerGrid + damagePercent + normalChainParam + comboParam) * elementParam * normalSkillAbsorbParam * primarySecondaryParam * critParam * skillIncreaseParam * skillFinalParam
  val = self:_RET(val)
  local damageType = critParam == 1 and DamageType.Normal or DamageType.Critical
  local logger = self._world:GetMatchLogger()
  logger:AddDamageLog(sourceAttackID, {
    key = "CalcDamage_176",
    desc = "公式176：攻击者[attacker] 被击者[defender] 伤害[val] = 基础伤害[baseDamage] * (两人Grid间隔[gridDis] * 每隔一个Grid增伤系数[bonusPerGrid] + 普攻技能系数[damagePercent] + 连锁系数[normalChainParam] + combo系数[comboParam]) * 属性克制系数[elementParam] * 普攻吸收系数[normalSkillAbsorbParam] * 主副属性系数[primarySecondaryParam] * 暴击系数[critParam] * 技能提升系数[skillIncreaseParam] * 技能最终系数[skillFinalParam]",
    attacker = sourceAttackID,
    defender = defender:GetID(),
    val = val,
    baseDamage = baseDamage,
    gridDis = gridDis,
    bonusPerGrid = bonusPerGrid,
    damagePercent = damagePercent,
    normalChainParam = normalChainParam,
    comboParam = comboParam,
    elementParam = elementParam,
    normalSkillAbsorbParam = normalSkillAbsorbParam,
    primarySecondaryParam = primarySecondaryParam,
    critParam = critParam,
    skillIncreaseParam = skillIncreaseParam,
    skillFinalParam = skillFinalParam
  })
  return val, damageType
end
