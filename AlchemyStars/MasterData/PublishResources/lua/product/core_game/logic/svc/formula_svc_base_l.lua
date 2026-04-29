require("directional_relative_pos_map_type")
_G.DirectionalRelativePosMap = {
  [DirectionalRelativePosMapType.Classical4Grid] = {
    [1] = {
      [1] = Vector2.New(0, 0),
      [2] = Vector2.New(1, 0),
      [3] = Vector2.New(0, 1),
      [4] = Vector2.New(1, 1)
    },
    [2] = {
      [1] = Vector2.New(0, 1),
      [2] = Vector2.New(0, 0),
      [3] = Vector2.New(1, 1),
      [4] = Vector2.New(1, 0)
    },
    [3] = {
      [1] = Vector2.New(1, 1),
      [2] = Vector2.New(0, 1),
      [3] = Vector2.New(1, 0),
      [4] = Vector2.New(0, 0)
    },
    [4] = {
      [1] = Vector2.New(1, 0),
      [2] = Vector2.New(1, 1),
      [3] = Vector2.New(0, 0),
      [4] = Vector2.New(0, 1)
    }
  },
  [DirectionalRelativePosMapType.Classical9Grid] = {
    [1] = {
      Vector2.New(0, 0),
      Vector2.New(1, 0),
      Vector2.New(2, 0),
      Vector2.New(0, 1),
      Vector2.New(1, 1),
      Vector2.New(2, 1),
      Vector2.New(0, 2),
      Vector2.New(1, 2),
      Vector2.New(2, 2)
    },
    [2] = {
      Vector2.New(0, 2),
      Vector2.New(0, 1),
      Vector2.New(0, 0),
      Vector2.New(1, 2),
      Vector2.New(1, 1),
      Vector2.New(1, 0),
      Vector2.New(2, 2),
      Vector2.New(2, 1),
      Vector2.New(2, 0)
    },
    [3] = {
      Vector2.New(2, 2),
      Vector2.New(1, 2),
      Vector2.New(0, 2),
      Vector2.New(2, 1),
      Vector2.New(1, 1),
      Vector2.New(0, 1),
      Vector2.New(2, 0),
      Vector2.New(1, 0),
      Vector2.New(0, 0)
    },
    [4] = {
      Vector2.New(2, 0),
      Vector2.New(2, 1),
      Vector2.New(2, 2),
      Vector2.New(1, 0),
      Vector2.New(1, 1),
      Vector2.New(1, 2),
      Vector2.New(0, 0),
      Vector2.New(0, 1),
      Vector2.New(0, 2)
    }
  },
  [DirectionalRelativePosMapType.Classical6Grid] = {
    [1] = {
      Vector2.New(0, 0),
      Vector2.New(1, 0),
      Vector2.New(2, 0),
      Vector2.New(0, 1),
      Vector2.New(1, 1),
      Vector2.New(2, 1)
    },
    [2] = {
      Vector2.New(0, 0),
      Vector2.New(0, 1),
      Vector2.New(0, 2),
      Vector2.New(1, 0),
      Vector2.New(1, 1),
      Vector2.New(1, 2)
    },
    [3] = {
      Vector2.New(0, 1),
      Vector2.New(1, 1),
      Vector2.New(2, 1),
      Vector2.New(0, 0),
      Vector2.New(1, 0),
      Vector2.New(2, 0)
    },
    [4] = {
      Vector2.New(1, 0),
      Vector2.New(1, 1),
      Vector2.New(1, 2),
      Vector2.New(0, 0),
      Vector2.New(0, 1),
      Vector2.New(0, 2)
    }
  }
}
local SpecialIgnoreDefenceFormulaID = {
  FormulaNumberType.CalcDamage_108,
  FormulaNumberType.CalcDamage_113
}
local PrimarySecondaryParamType = {TeamLeader = 1, Pet = 2}
_enum("PrimarySecondaryParamType", PrimarySecondaryParamType)
_class("FormulaService", BaseService)
FormulaService = FormulaService

function FormulaService:Constructor(world)
  self._world = world
  self._comboSegment = {
    [1] = {
      comboNum = 0,
      a = 0.02,
      b = 0
    },
    [2] = {
      comboNum = 6,
      a = 0.015,
      b = 0.025
    },
    [3] = {
      comboNum = 16,
      a = 0.01,
      b = 0.1
    },
    [4] = {
      comboNum = 26,
      a = 0.005,
      b = 0.225
    },
    [5] = {
      comboNum = 41,
      a = 0.002,
      b = 0.345
    }
  }
  self._chainSegmentNormal = {
    [1] = {
      chainNum = 0,
      a = 0,
      b = 0
    },
    [2] = {
      chainNum = 2,
      a = 0.05,
      b = -0.05
    },
    [3] = {
      chainNum = 4,
      a = 0.045,
      b = -0.035
    },
    [4] = {
      chainNum = 6,
      a = 0.04,
      b = -0.01
    },
    [5] = {
      chainNum = 8,
      a = 0.035,
      b = 0.025
    },
    [6] = {
      chainNum = 10,
      a = 0.03,
      b = 0.07
    },
    [7] = {
      chainNum = 12,
      a = 0.025,
      b = 0.125
    },
    [8] = {
      chainNum = 16,
      a = 0,
      b = 0.5
    }
  }
  self._chainSegmentChain = {
    [1] = {
      chainNum = 0,
      a = 0,
      b = 0
    },
    [2] = {
      chainNum = 3,
      a = 0.1,
      b = -0.2
    },
    [3] = {
      chainNum = 7,
      a = 0.09,
      b = -0.14
    },
    [4] = {
      chainNum = 9,
      a = 0.08,
      b = -0.06
    },
    [5] = {
      chainNum = 11,
      a = 0.07,
      b = 0.04
    },
    [6] = {
      chainNum = 13,
      a = 0.05,
      b = 0.28
    },
    [7] = {
      chainNum = 15,
      a = 0.02,
      b = 0.7
    },
    [8] = {
      chainNum = 16,
      a = 0,
      b = 1
    }
  }
  self._chainSegmentChain_PopStarPro = {
    [1] = {
      chainNum = 0,
      a = 0.02,
      b = 0
    },
    [2] = {
      chainNum = 20,
      a = 0.01,
      b = 0.2
    },
    [3] = {
      chainNum = 31,
      a = 0,
      b = 0.5
    }
  }
  self:Register()
end

function FormulaService:_CalcFinalAtk(attacker)
  local attack = self:CalcAttack(attacker)
  local attackPercentage = self:CalcAttackPercentage(attacker)
  local attackConstantFix = self:CalcAttackConstantFix(attacker)
  local finalAtk = math.floor(attack * (1 + attackPercentage) + attackConstantFix)
  local logger = self._world:GetMatchLogger()
  logger:AddDamageLog(attacker:GetID(), {
    key = "FinalAtk",
    attacker = attacker:GetID(),
    desc = "1)最终攻击[finalAtk] = 攻击[attack] * (1 + 攻击百分比[attackPercentage]) + 攻击绝对值[attackConstantFix]",
    finalAtk = finalAtk,
    attack = attack,
    attackPercentage = attackPercentage,
    attackConstantFix = attackConstantFix
  })
  return finalAtk
end

function FormulaService:IsDefenderBodyAreaPosMatch(defender, damageGridPos, posArray)
  if damageGridPos and 0 < #posArray then
    local defGridType = self:_GetRelativePosMapDir(defender:GetGridDirection())
    local bodyAreaPosMap
    local defBodyArea = defender:BodyArea():GetArea()
    if #defBodyArea == 4 then
      bodyAreaPosMap = _G.DirectionalRelativePosMap[DirectionalRelativePosMapType.Classical4Grid]
    elseif #defBodyArea == 9 then
      bodyAreaPosMap = _G.DirectionalRelativePosMap[DirectionalRelativePosMapType.Classical9Grid]
    elseif #defBodyArea == 6 then
      bodyAreaPosMap = _G.DirectionalRelativePosMap[DirectionalRelativePosMapType.Classical6Grid]
    end
    if bodyAreaPosMap and bodyAreaPosMap[defGridType] then
      local t = {}
      for _, index in ipairs(posArray) do
        local v2Relative = bodyAreaPosMap[defGridType][index]
        table.insert(t, v2Relative + defender:GetGridPosition())
      end
      if table.Vector2Include(t, damageGridPos) then
        return true
      end
    end
  end
  return false
end

function FormulaService:_CalcFinalDef(defender, attacker, damageGridPos)
  local defence = self:CalcDefenceWithAttacker(defender, attacker)
  local defencePercentage = self:CalcDefencePercentage(defender)
  local defenceConstantFix = self:CalcDefenceConstantFix(defender)
  local directionalDefPercentage = 0
  local defenderDirectionalDefPosArray = defender:BuffComponent():GetBuffValue("DEFENDER_DIRECTIONAL_DEF_POS_ARRAY") or {}
  if self:IsDefenderBodyAreaPosMatch(defender, damageGridPos, defenderDirectionalDefPosArray) then
    local rate = defender:BuffComponent():GetBuffValue("DEFENDER_DIRECTIONAL_DEF_POS_RATE") or 0
    directionalDefPercentage = rate
  end
  local finalDef = math.floor(defence * (1 + defencePercentage + directionalDefPercentage) + defenceConstantFix)
  finalDef = math.max(0, finalDef)
  local logger = self._world:GetMatchLogger()
  logger:AddDamageLog(attacker:GetID(), {
    desc = "2)最终防御[finalDef] = 防御[defence] * (1 + 防御百分比[defencePercentage] + 身形防御百分比[directionalDefPercentage]) + 防御绝对值[defenceConstantFix]",
    key = "FinalDef",
    attacker = attacker:GetID(),
    defender = defender:GetID(),
    finalDef = finalDef,
    defence = defence,
    defencePercentage = defencePercentage,
    defenceConstantFix = defenceConstantFix,
    directionalDefPercentage = directionalDefPercentage
  })
  return finalDef
end

function FormulaService:CalcBaseDamage(attacker, defender, damageGridPos)
  local finalAtk = self:_CalcFinalAtk(attacker)
  local finalDef = self:_CalcFinalDef(defender, attacker, damageGridPos)
  local noDefence = self:_IsNoDefence(attacker)
  local rawFinalDef = finalDef
  finalDef = finalDef * (1 - noDefence)
  local result = finalAtk - finalDef
  local logger = self._world:GetMatchLogger()
  logger:AddDamageLog(attacker:GetID(), {
    key = "BaseDamage",
    attacker = attacker:GetID(),
    defender = defender:GetID(),
    desc = "3)基础伤害[baseDamage] = 最终攻击[finalAtk] - (最终防御[rawFinalDef] * (1 - 无视防御系数[noDefence]))",
    baseDamage = result,
    finalAtk = finalAtk,
    finalDef = finalDef,
    rawFinalDef = rawFinalDef,
    noDefence = noDefence
  })
  return result
end

function FormulaService:CalcBaseDamageWithSpecificFinalAttack(attacker, defender, spFinalAtk, damageGridPos)
  local finalAtk = 0
  if spFinalAtk then
    finalAtk = spFinalAtk
  else
    finalAtk = self:_CalcFinalAtk(attacker)
  end
  local finalDef = self:_CalcFinalDef(defender, attacker, damageGridPos)
  local noDefence = self:_IsNoDefence(attacker)
  local rawFinalDef = finalDef
  finalDef = finalDef * (1 - noDefence)
  local result = finalAtk - finalDef
  local logger = self._world:GetMatchLogger()
  logger:AddDamageLog(attacker:GetID(), {
    key = "BaseDamage",
    attacker = attacker:GetID(),
    defender = defender:GetID(),
    desc = "3)基础伤害[baseDamage] = 最终攻击[finalAtk] - (最终防御[rawFinalDef] * (1 - 无视防御系数[noDefence]))",
    baseDamage = result,
    finalAtk = finalAtk,
    finalDef = finalDef,
    rawFinalDef = rawFinalDef,
    noDefence = noDefence
  })
  return result
end

function FormulaService:_RET(val)
  if val < 1 then
    return 1
  end
  val = math.ceil(val)
  return val
end

function FormulaService:_Attributes(entity)
  return entity:Attributes()
end

function FormulaService:CalcAttack(entity)
  local val = self:_Attributes(entity):GetAttribute("Attack") or 1
  return val
end

function FormulaService:CalcAttackPercentage(entity)
  local val = self:_Attributes(entity):GetAttribute("AttackPercentage") or 0
  return val
end

function FormulaService:CalcAttackConstantFix(entity)
  local val = self:_Attributes(entity):GetAttribute("AttackConstantFix") or 0
  return val
end

function FormulaService:CalcDefenceWithAttacker(entity, attacker)
  if attacker then
    local useLowestTeamMemberDefence = self:_IsUseLowestTeamMemberDefence(attacker)
    if 0 < useLowestTeamMemberDefence then
      return self:CalcDefenceUseLowestTeamMember(entity)
    end
    local ignoreTeamMemberDefence = self:_IsIgnoreTeamMemberDefence(attacker)
    if 0 < ignoreTeamMemberDefence then
      return self:CalcDefenceIgnoreTeamMember(entity, ignoreTeamMemberDefence)
    end
  end
  return self:CalcDefence(entity)
end

function FormulaService:CalcDefence(entity)
  local defense = self:_Attributes(entity):GetAttribute("Defense")
  local val = defense or 1
  return val
end

function FormulaService:CalcDefenceIgnoreTeamMember(entity, ignoreTeamMemberDefence)
  if entity:HasTeam() then
    local def = 0
    local teamMembers = entity:Team():GetTeamPetEntities()
    local teamLeaderId = entity:Team():GetTeamLeaderEntityID()
    for _, e in ipairs(teamMembers) do
      local memberId = e:GetID()
      local memDef = self:_Attributes(e):GetAttribute("Defense")
      if teamLeaderId == memberId then
      else
        memDef = memDef * (1 - ignoreTeamMemberDefence)
      end
      def = def + memDef
    end
    return def
  else
    return self:CalcDefence(entity)
  end
end

function FormulaService:CalcDefenceUseLowestTeamMember(entity)
  if entity:HasTeam() then
    local teamMembers = entity:Team():GetTeamPetEntities()
    local lowestDef = -1
    for _, e in ipairs(teamMembers) do
      local memDef = self:_Attributes(e):GetAttribute("Defense")
      if lowestDef < 0 or lowestDef > memDef then
        lowestDef = memDef
      end
    end
    return lowestDef
  else
    return self:CalcDefence(entity)
  end
end

function FormulaService:CalcDefencePercentage(entity)
  local val = self:_Attributes(entity):GetAttribute("DefencePercentage") or 0
  return val
end

function FormulaService:CalcDefenceConstantFix(entity)
  local val = self:_Attributes(entity):GetAttribute("DefenceConstantFix") or 0
  return val
end

function FormulaService:CalcComboParam(entity)
  local battleService = self._world:GetService("Battle")
  local logicComboNum = battleService:GetLogicComboNum()
  for i = table.count(self._comboSegment), 1, -1 do
    local v = self._comboSegment[i]
    if logicComboNum >= v.comboNum then
      return v.a * logicComboNum + v.b
    end
  end
  return 0
end

function FormulaService:GetEntityPetAtkDataCmpt(entity)
  if entity:HasSuperEntity() and entity:SuperEntityComponent():IsUseSuperPetAttackData() then
    local superEntity = entity:SuperEntityComponent():GetSuperEntity()
    return superEntity:SkillPetAttackData()
  end
  return entity:SkillPetAttackData()
end

function FormulaService:CalcSuperGridParam(entity, damageParams)
  local petAtkComponent = self:GetEntityPetAtkDataCmpt(entity)
  local superGridNum = petAtkComponent:GetCurrentSuperGridNum()
  if damageParams and damageParams.skillID then
    superGridNum = petAtkComponent:GetChainSuperGridNumList(damageParams.skillID)
  end
  return superGridNum * BattleConst.EachSuperGridDamageParam
end

function FormulaService:CalcSuperGridParam_ChenNiEquip(entity)
  if not entity:HasSuperEntity() then
    Log.error("攻击者必须是SkillHolder， attackID = ", entity:GetID())
    return 0
  end
  local utilCalcSvc = self._world:GetService("UtilCalc")
  local superGridNum = utilCalcSvc:GetCurrentSupperGridNum_ChenNiEquip(entity) or 0
  return superGridNum * BattleConst.EachSuperGridDamageParam
end

function FormulaService:CalcPoorGridParam(entity, damageParams)
  local petAtkComponent = self:GetEntityPetAtkDataCmpt(entity)
  local superGridNum = petAtkComponent:GetCurrentPoorGridNum()
  if damageParams and damageParams.skillID then
    superGridNum = petAtkComponent:GetChainPoorGridNumList(damageParams.skillID)
  end
  return superGridNum * BattleConst.EachPoorGridDamageParam
end

function FormulaService:CalcPoorGridParam_ChenNiEquip(entity)
  if not entity:HasSuperEntity() then
    Log.error("攻击者必须是SkillHolder， attackID = ", entity:GetID())
    return 0
  end
  local utilCalcSvc = self._world:GetService("UtilCalc")
  local poorGridNum = utilCalcSvc:GetCurrentPoorGridNum_ChenNiEquip(entity) or 0
  return poorGridNum * BattleConst.EachPoorGridDamageParam
end

function FormulaService:CalcNormalChainParam(entity)
  return self:_GetChainSegment(self._chainSegmentNormal, entity)
end

function FormulaService:CalcNormalChainParam_ChenNiEquip(entity)
  if not entity:HasSuperEntity() then
    Log.error("攻击者必须是SkillHolder， attackID = ", entity:GetID())
    return 0
  end
  local utilCalcSvc = self._world:GetService("UtilCalc")
  local chainNum = utilCalcSvc:GetCurrentChainRate_ChenNiEquip(entity)
  for i = table.count(self._chainSegmentNormal), 1, -1 do
    local v = self._chainSegmentNormal[i]
    if chainNum >= v.chainNum then
      return v.a * chainNum + v.b
    end
  end
  return 0
end

function FormulaService:CalcChainChainParam(entity, damageParams)
  if self._world:MatchType(GetMatchTypeType.NoLinkLine) == MatchType.MT_PopStarPro then
    return self:_GetChainSegment(self._chainSegmentChain_PopStarPro, entity, damageParams)
  end
  return self:_GetChainSegment(self._chainSegmentChain, entity, damageParams)
end

function FormulaService:_GetChainSegment(segment, entity, damageParams)
  local petAtkComponent = self:GetEntityPetAtkDataCmpt(entity)
  local chainNum = petAtkComponent:GetCurrentChainDamageRate()
  if damageParams and damageParams.skillID then
    chainNum = petAtkComponent:GetChainRateList(damageParams.skillID)
  end
  for i = table.count(segment), 1, -1 do
    local v = segment[i]
    if chainNum >= v.chainNum then
      return v.a * chainNum + v.b
    end
  end
  return 0
end

function FormulaService:CalcPrimarySecondaryParam_ActiveSkill(attacker)
  return BattleConst.PrimarySecondaryActiveParam
end

function FormulaService:CalcPrimarySecondaryParam(attacker)
  local val = self:_Attributes(attacker):GetAttribute("PrimarySecondaryParam") or 1
  return val
end

function FormulaService:_GetMonsterAbsorbData(monsterEntity, nType, damagePos)
  local nReturn = 1
  local compMonsterID = monsterEntity:MonsterID()
  if compMonsterID then
    local nMonsterID = compMonsterID:GetMonsterID()
    local cfgService = self._world:GetService("Config")
    local monsterConfigData = cfgService:GetMonsterConfigData()
    local posArray, rate
    if MonsterSkillAbsorbType.NormalSkill == nType then
      nReturn = monsterEntity:Attributes():GetAttribute("AbsorbNormal") or -1
      posArray = monsterEntity:BuffComponent():GetBuffValue("defender_normal_absorb_rate_array") or {}
      rate = monsterEntity:BuffComponent():GetBuffValue("defender_normal_absorb_rate") or 0
    elseif MonsterSkillAbsorbType.ChainSkill == nType then
      nReturn = monsterEntity:Attributes():GetAttribute("AbsorbChain") or -1
      posArray = monsterEntity:BuffComponent():GetBuffValue("defender_chain_absorb_rate_array") or {}
      rate = monsterEntity:BuffComponent():GetBuffValue("defender_chain_absorb_rate") or 0
    elseif MonsterSkillAbsorbType.ActiveSkill == nType then
      nReturn = monsterEntity:Attributes():GetAttribute("AbsorbActive") or -1
      posArray = monsterEntity:BuffComponent():GetBuffValue("defender_active_absorb_rate_array") or {}
      rate = monsterEntity:BuffComponent():GetBuffValue("defender_active_absorb_rate") or 0
    end
    if self:IsDefenderBodyAreaPosMatch(monsterEntity, damagePos, posArray) then
      Log.info("GridDamage Change AbsorbData source:", nReturn, " new:", rate)
      nReturn = rate
    end
  end
  return nReturn
end

function FormulaService:CalcAbsorbParam_NormalSkill(defender, damagePos)
  return self:_GetMonsterAbsorbData(defender, MonsterSkillAbsorbType.NormalSkill, damagePos)
end

function FormulaService:CalcAbsorbParam_ChainSkill(defender, damagePos)
  return self:_GetMonsterAbsorbData(defender, MonsterSkillAbsorbType.ChainSkill, damagePos)
end

function FormulaService:CalcAbsorbParam_ActiveSkill(defender, damagePos)
  return self:_GetMonsterAbsorbData(defender, MonsterSkillAbsorbType.ActiveSkill, damagePos)
end

function FormulaService:CalcAbsorbParam_Damage()
  return 1
end

function FormulaService:CalcCritParam(damageParam, attacker)
  if not damageParam.critProb or not damageParam.crit then
    return 1
  end
  local cAttr = attacker:Attributes()
  local critProb = damageParam.critProb + (cAttr:GetAttribute("AdditionalCritProb") or 0)
  if critProb <= 0 then
    return 1
  end
  local critParam = damageParam.crit + (cAttr:GetAttribute("AdditionalCritParam") or 0)
  local randomSvc = self._world:GetService("RandomLogic")
  local r = randomSvc:LogicRand()
  local val = critProb > r and critParam or 1
  return val
end

function FormulaService:CalcCritParamWithCombo(attacker, damageParam)
  local battleService = self._world:GetService("Battle")
  local logicComboNum = battleService:GetLogicComboNum()
  local critProb = damageParam.critProb
  local eachComboIncreaseCritProb = attacker:BuffComponent():GetBuffValue("EachComboIncreaseCritProb") or 0
  local comboIncreaseCritProbMax = attacker:BuffComponent():GetBuffValue("ComboIncreaseCritProbMax") or 0
  if eachComboIncreaseCritProb ~= 0 then
    local critProbIncrease = logicComboNum * eachComboIncreaseCritProb
    if comboIncreaseCritProbMax ~= 0 and comboIncreaseCritProbMax < critProbIncrease then
      critProbIncrease = comboIncreaseCritProbMax
    end
    critProb = critProb + critProbIncrease
  end
  if not critProb or not damageParam.crit then
    return 1
  end
  if critProb <= 0 then
    return 1
  end
  local cAttr = attacker:Attributes()
  local critParam = damageParam.crit + (cAttr:GetAttribute("AdditionalCritParam") or 0)
  local randomSvc = self._world:GetService("RandomLogic")
  local r = randomSvc:LogicRand()
  local val = critProb > r and critParam or 1
  return val
end

function FormulaService:_CalcSkillParam_NormalSkill(caster)
  local val = self:_Attributes(caster):GetAttribute("NormalSkillParam") or 0
  return val
end

function FormulaService:_CalcSkillParam_ChainSkill(caster)
  local val = self:_Attributes(caster):GetAttribute("ChainSkillParam") or 0
  return val
end

function FormulaService:_CalcSkillParam_ActiveSkill(caster)
  local val = self:_Attributes(caster):GetAttribute("ActiveSkillParam") or 0
  return val
end

function FormulaService:_CalcSkillParam_MonsterSkill(caster)
  local val = self:_Attributes(caster):GetAttribute("MonsterSkillParam") or 0
  return val
end

function FormulaService:_CalcSkillIncreaseParam_NormalSkill(caster)
  local val = self:_Attributes(caster):GetAttribute("NormalSkillIncreaseParam") or 1
  return val
end

function FormulaService:_CalcSkillIncreaseParam_ChainSkill(caster)
  local val = self:_Attributes(caster):GetAttribute("ChainSkillIncreaseParam") or 1
  return val
end

function FormulaService:_CalcSkillIncreaseParam_ActiveSkill(caster)
  local val = self:_Attributes(caster):GetAttribute("ActiveSkillIncreaseParam") or 1
  return val
end

function FormulaService:_CalcSkillIncreaseParam_MonsterSkill(caster)
  local val = self:_Attributes(caster):GetAttribute("MonsterSkillIncreaseParam") or 1
  return val
end

function FormulaService:_CalcSkillIncreaseParam_TrapSkill(caster)
  local val = self:_Attributes(caster):GetAttribute("TrapSkillIncreaseParam") or 1
  return val
end

function FormulaService:_CalcSkillIncreaseParam_CampSkill(caster)
  local val = self:_Attributes(caster):GetAttribute("CampSkillIncreaseParam") or 1
  return val
end

function FormulaService:_CalcSkillFinalParam_NormalSkill(caster)
  local val = self:_Attributes(caster):GetAttribute("NormalSkillFinalParam") or 1
  return val
end

function FormulaService:_CalcSkillFinalParam_ChainSkill(caster)
  local val = self:_Attributes(caster):GetAttribute("ChainSkillFinalParam") or 1
  return val
end

function FormulaService:_CalcSkillFinalParam_ActiveSkill(caster)
  local val = self:_Attributes(caster):GetAttribute("ActiveSkillFinalParam") or 1
  return val
end

function FormulaService:_CalcSkillFinalParam_MonsterSkill(caster)
  local val = self:_Attributes(caster):GetAttribute("MonsterSkillFinalParam") or 1
  return val
end

function FormulaService:_CalcSkillFinalParam_CampSkill(caster)
  local val = self:_Attributes(caster):GetAttribute("CampSkillFinalParam") or 1
  return val
end

function FormulaService:_CalcSkillFinalParam_AutoBeadSkill(caster)
  local val = self:_Attributes(caster):GetAttribute("AutoBeadSkillFinalParam") or 1
  return val
end

function FormulaService:_CalcDefenderBeHitDamageParam(defender)
  local val = self:_Attributes(defender):GetAttribute("FinalBehitDamageParam") or 1
  return val
end

function FormulaService:_CalcDefenderBeHitByTeamLeaderDamageParam(defender)
  local val = self:_Attributes(defender):GetAttribute("FinalBehitByTeamLeaderDamageParam") or 1
  return val
end

function FormulaService:_CalcDefenderBeHitByTeamMemberDamageParam(defender)
  local val = self:_Attributes(defender):GetAttribute("FinalBehitByTeamMemberDamageParam") or 1
  return val
end

function FormulaService:_GetAbsolutePosArrayByRelativeOne()
end

function FormulaService:_ProcessFinalDamage(damage, damageType, defender, attacker, damageParam, damageGridPos, formulaID)
  local logger = self._world:GetMatchLogger()
  local val = damage
  if attacker:HasPet() then
    local teamEntity = attacker:Pet():GetOwnerTeamEntity()
    if teamEntity then
      local isTeamLeader = teamEntity:Team():IsTeamLeaderByEntityId(attacker:GetID())
      if isTeamLeader then
        local beAttackParam = self:_CalcDefenderBeHitByTeamLeaderDamageParam(defender)
        val = val * beAttackParam
        logger:AddDamageLog(attacker:GetID(), {
          key = "FinalDamage",
          desc = "***光灵作为队长时最终伤害增伤系数[finalBehitByTeamLeaderDamageParam] 最终伤害值[val]***",
          finalBehitByTeamLeaderDamageParam = beAttackParam,
          val = val
        })
      else
        local beAttackParam = self:_CalcDefenderBeHitByTeamMemberDamageParam(defender)
        val = val * beAttackParam
        logger:AddDamageLog(attacker:GetID(), {
          key = "FinalDamage",
          desc = "***光灵作为队长时最终伤害增伤系数[finalBehitByTeamMemberDamageParam] 最终伤害值[val]***",
          finalBehitByTeamMemberDamageParam = beAttackParam,
          val = val
        })
      end
    end
  end
  if damageParam then
    local skillID = damageParam.skillID
    if skillID and 0 < skillID then
      local skillLogicService = self._world:GetService("SkillLogic")
      local isSingleEntitySkill = skillLogicService:IsSelectEntitySkill(skillID)
      if isSingleEntitySkill and defender:MonsterID() then
        local attributeCmpt = defender:Attributes()
        local dmgParamSingleTypeSkill = attributeCmpt:GetAttribute("DmgParamSingleTypeSkill")
        if dmgParamSingleTypeSkill then
          val = val * dmgParamSingleTypeSkill
          logger:AddDamageLog(attacker:GetID(), {
            key = "FinalDamage",
            desc = "***怪受单体攻击时最终伤害增伤系数[dmgParamSingleTypeSkill] 最终伤害值[val]***",
            dmgParamSingleTypeSkill = dmgParamSingleTypeSkill,
            val = val
          })
        end
      end
    end
  end
  local attackerSanFinal = 1 + (self:_Attributes(attacker):GetAttribute("SanSkillFinalParam") or 0)
  val = val * attackerSanFinal
  logger:AddDamageLog(attacker:GetID(), {
    key = "FinalDamage",
    desc = "***san技能最终伤害系数[attackerSanFinal] 最终伤害值[val]***",
    attackerSanFinal = attackerSanFinal,
    val = val
  })
  if damageGridPos then
    local defenderFinalBeHitArray = defender:BuffComponent():GetBuffValue("DEFENDER_FINAL_BE_HIT_POS_ARRAY") or {}
    if self:IsDefenderBodyAreaPosMatch(defender, damageGridPos, defenderFinalBeHitArray) then
      local rate = defender:BuffComponent():GetBuffValue("DEFENDER_FINAL_BE_HIT_POS_RATE") or 0
      val = val * (1 - rate)
      logger:AddDamageLog(attacker:GetID(), {
        key = "FinalDamage",
        desc = "***身形减伤[rate] 最终伤害值[val]***",
        rate = rate,
        val = val
      })
    end
  end
  local affixSvc = self._world:GetService("Affix")
  if affixSvc:HasIncreasePetNoDefenceDamage() then
    local increasePercent = affixSvc:GetIncreasePetNoDefenceDamageParam()
    local needIncrease = false
    local useAttacker = attacker
    if useAttacker then
      local localTeamEntity = self._world:Player():GetLocalTeamEntity()
      if defender then
        local defenderCheckOk = false
        local enemyTeam = localTeamEntity:Team():GetEnemyTeamEntity()
        if defender:HasMonsterID() then
          defenderCheckOk = true
        elseif enemyTeam and enemyTeam == defender then
          defenderCheckOk = true
        end
        if defenderCheckOk then
          if damageType == DamageType.Real then
            needIncrease = true
          else
            local finalDef = self:_CalcFinalDef(defender, attacker, damageGridPos)
            local noDefence = self:_IsNoDefence(attacker)
            if noDefence and noDefence == 1 then
              needIncrease = true
            elseif finalDef and finalDef <= 0 then
              needIncrease = true
            end
          end
          if not needIncrease and table.icontains(SpecialIgnoreDefenceFormulaID, formulaID) then
            needIncrease = true
          end
        end
      end
    end
    if needIncrease then
      local petNoDefenceDamageIncreaseParam = increasePercent
      val = val * (1 + petNoDefenceDamageIncreaseParam)
      logger:AddDamageLog(attacker:GetID(), {
        key = "FinalDamage",
        desc = "***无视防御伤害提高系数[petNoDefenceDamageIncreaseParam] 最终伤害值[val]***",
        petNoDefenceDamageIncreaseParam = petNoDefenceDamageIncreaseParam,
        val = val
      })
    end
  end
  if defender:HasMonsterID() then
    local buffCmpt = defender:BuffComponent()
    if buffCmpt then
      local rateVal = buffCmpt:GetBuffValue("BuffDecreaseFirstDmgFromPet")
      if rateVal then
        local attackSourceEntity = attacker
        if attacker:HasSuperEntity() then
          attackSourceEntity = attacker:GetSuperEntity()
        end
        if attackSourceEntity:HasPet() then
          local atkID = attackSourceEntity:GetID()
          local records = buffCmpt:GetBuffValue("BuffDecreaseFirstDmgFromPetRecords")
          if records then
            if records[atkID] then
            else
              records[atkID] = 1
              val = math.floor(val * rateVal)
            end
          else
            local newRecords = {}
            newRecords[atkID] = 1
            buffCmpt:SetBuffValue("BuffDecreaseFirstDmgFromPetRecords", newRecords)
            val = math.floor(val * rateVal)
          end
        end
      end
    end
  end
  return val
end

function FormulaService:_GetRelativePosMapDir(gridDir)
  local dir = gridDir:Clone()
  if dir.x > 0 then
    dir.x = 1
  elseif dir.x < 0 then
    dir.x = -1
  end
  if 0 < dir.y then
    dir.y = 1
  elseif 0 > dir.y then
    dir.y = -1
  end
  local dirType = 0
  if dir == Vector2.down then
    dirType = 1
  elseif dir == Vector2.left then
    dirType = 2
  elseif dir == Vector2.up then
    dirType = 3
  elseif dir == Vector2.right then
    dirType = 4
  else
    Log.error("身形减伤判定错误：方向不受支持：", tostring(gridDir))
  end
  return dirType
end

function FormulaService:CalcElementParam(hero, monster)
  local utilSvc = self._world:GetService("UtilData")
  local buffLogicSvc = self._world:GetService("BuffLogic")
  local cBuff = monster:BuffComponent()
  local val = 1
  local t1 = utilSvc:GetEntityElementType(hero, true)
  local t2 = utilSvc:GetEntityElementType(monster)
  if t1 == nil or t2 == nil then
    Log.fatal("can not find element type")
    return val
  end
  local flag = self:GetRestrainFlag(t1, t2, hero, monster)
  self._world:GetSyncLogger():Trace({
    key = "CalcElementParam",
    t1 = t1,
    t2 = t2
  })
  if flag == ElementRelationFlag.Counter then
    val = val + BattleConst.Strong
    local ExElementParam = self:CalcExElementParam(hero)
    local ExBeHitElementParam = self:CalcExBeHitElementParam(monster)
    val = val + ExElementParam + ExBeHitElementParam
    local a = cBuff:GetBuffValue("ElementReinforceFactorA")
    if a and 0 < a then
      val = val * a
    end
  elseif flag == ElementRelationFlag.BeCountered then
    val = val - BattleConst.Counter
    local c = cBuff:GetBuffValue("ElementReinforceFactorC")
    if c and 0 < c then
      val = val * c
    end
  elseif flag == ElementRelationFlag.Normal then
    local b = cBuff:GetBuffValue("ElementReinforceFactorB")
    if b and 0 < b then
      val = val * b
    end
  end
  return val
end

function FormulaService:GetRestrainFlag(t1, t2, attacker, defender)
  if attacker then
    local attr = self:_Attributes(attacker)
    if attr then
      local forceRestrain = attr:GetAttribute("BuffForceElementRestrained") or 0
      if forceRestrain == 1 then
        return ElementRelationFlag.Counter
      end
    end
  end
  if ElementRelation[t1].lt == t2 then
    return ElementRelationFlag.BeCountered
  elseif ElementRelation[t1].bt == t2 then
    return ElementRelationFlag.Counter
  else
    return ElementRelationFlag.Normal
  end
end

function FormulaService:CalcExElementParam(entity)
  local val = self:_Attributes(entity):GetAttribute("ExElementParam") or 0
  return val
end

function FormulaService:CalcExBeHitElementParam(entity)
  return self:_Attributes(entity):GetAttribute("ExBeHitElementParam") or 0
end

function FormulaService:CalcTrueDamageFixParam(entity)
  return self:_Attributes(entity):GetAttribute("TrueDamageFixParam") or 0
end

function FormulaService:CalcElementParamM(hero, monster)
  local t1 = PieceType.None
  local t2 = PieceType.None
  if hero:Element() ~= nil and hero:Element():GetPrimaryType() ~= nil then
    t1 = hero:Element():GetPrimaryType()
  end
  if monster:Element() ~= nil and monster:Element():GetPrimaryType() ~= nil then
    t2 = monster:Element():GetPrimaryType()
  end
  if t1 == PieceType.None or t2 == PieceType.None then
    return 1
  end
  local flag = self:GetRestrainFlag(t1, t2, hero, monster)
  if flag == ElementRelationFlag.BeCountered then
    return 0.8
  end
  if flag == ElementRelationFlag.Counter then
    return 1.2
  end
  return 1
end

function FormulaService:CalcBuffElementParam(element, attacker, monster)
  local t1 = element or PieceType.None
  local t2 = PieceType.None
  if monster:Element() ~= nil and monster:Element():GetPrimaryType() ~= nil then
    t2 = monster:Element():GetPrimaryType()
  end
  if t1 == PieceType.None or t2 == PieceType.None then
    return 1
  end
  local flag = self:GetRestrainFlag(t1, t2, attacker, monster)
  if flag == ElementRelationFlag.BeCountered then
    return 1 - BattleConst.Counter
  end
  if flag == ElementRelationFlag.Counter then
    return 1 + BattleConst.Strong
  end
  return 1
end

function FormulaService:CalcTrapElementParam(trap, target)
  local t1 = PieceType.None
  local t2 = PieceType.None
  if trap:Element() ~= nil and trap:Element():GetPrimaryType() ~= nil then
    t1 = trap:Element():GetPrimaryType()
  end
  if target:Element() ~= nil and target:Element():GetPrimaryType() ~= nil then
    t2 = target:Element():GetPrimaryType()
  end
  if t1 == PieceType.None or t2 == PieceType.None then
    return 1
  end
  local flag = self:GetRestrainFlag(t1, t2, trap, target)
  if flag == ElementRelationFlag.BeCountered then
    return 1 - BattleConst.Counter
  end
  if flag == ElementRelationFlag.Counter then
    return 1 + BattleConst.Strong
  end
  return 1
end

function FormulaService:CalcBaseByPercent(base, percent)
  return base * percent
end

function FormulaService:_CalcSkillParam_DefenderSkillAmpfily(entity)
  local cAttr = entity:Attributes()
  if not cAttr then
    return 0
  end
  local nAttrDamageAmpfily = cAttr:GetAttribute("DamagePercentAmpfily")
  return nAttrDamageAmpfily or 0
end

function FormulaService:_CalcActiveSkillPercentByDefenderHP(defender, damageParam)
  local addedPercent = 0
  local addDamagePercent = damageParam:GetAddDamagePercent()
  if addDamagePercent then
    local maxAddedDamagePercent = damageParam:GetMaxAddedDamagePercent()
    local cAttr = defender:Attributes()
    local p = 0
    if cAttr then
      local maxHp = cAttr:CalcMaxHp() or 1
      local curHp = cAttr:GetCurrentHP() or 0
      p = (maxHp - curHp) / maxHp * 100
    end
    addedPercent = p * addDamagePercent
    addedPercent = math.min(addedPercent, maxAddedDamagePercent)
  end
  return addedPercent
end

function FormulaService:_CalcOnceMaxDamage(casterEntity, damageParam)
  local onceMaxDamageType = damageParam:GetOnceMaxDamageType()
  local onceMaxDamageParam = damageParam:GetOnceMaxDamageParam()
  if onceMaxDamageType == OnceMaxDamageType.CasterBaseATK then
    if not onceMaxDamageParam then
      return nil
    end
    local cAttr = casterEntity:Attributes()
    local baseAtk = cAttr:GetAttribute("Attack")
    local final = baseAtk * onceMaxDamageParam
    return self:_RET(final)
  end
  return nil
end

function FormulaService:_CalcOnceMinDamage(casterEntity, damageParam)
  local onceMaxDamageType = damageParam:GetOnceMaxDamageType()
  local onceMinDamageParam = damageParam:GetOnceMinDamageParam()
  if onceMaxDamageType == OnceMaxDamageType.CasterBaseATK then
    if not onceMinDamageParam then
      return nil
    end
    local cAttr = casterEntity:Attributes()
    local baseAtk = cAttr:GetAttribute("Attack")
    local final = baseAtk * onceMinDamageParam
    return self:_RET(final)
  end
  return nil
end

function FormulaService:_GetActiveSkillParam(attacker, defender, damageGridPos)
  local activeSkillParam = self:_CalcSkillParam_ActiveSkill(attacker)
  local activeSkillAbsorbParam = self:CalcAbsorbParam_ActiveSkill(defender, damageGridPos)
  local primarySecondaryParam = self:CalcPrimarySecondaryParam_ActiveSkill(attacker)
  local skillIncreaseParam = self:_CalcSkillIncreaseParam_ActiveSkill(attacker)
  local skillFinalParam = self:_CalcSkillFinalParam_ActiveSkill(attacker)
  return activeSkillAbsorbParam, primarySecondaryParam, skillIncreaseParam, skillFinalParam, activeSkillParam
end

function FormulaService:_IsNoDefence(attacker)
  local val = self:_Attributes(attacker):GetAttribute("NoDefence") or 0
  if 1 < val then
    val = 1
  elseif val < 0 then
    val = 0
  end
  return val
end

function FormulaService:_IsIgnoreTeamMemberDefence(attacker)
  local val = self:_Attributes(attacker):GetAttribute("IgnoreTeamMemberDefence") or 0
  if 1 < val then
    val = 1
  elseif val < 0 then
    val = 0
  end
  return val
end

function FormulaService:_IsUseLowestTeamMemberDefence(attacker)
  local val = self:_Attributes(attacker):GetAttribute("UseLowestTeamMemberDefence") or 0
  if 1 < val then
    val = 1
  elseif val < 0 then
    val = 0
  end
  return val
end

function FormulaService:PostProcessPercentDamage(defender, val, damageType)
  local buffLogicSvc = self._world:GetService("BuffLogic")
  if not buffLogicSvc:IsTargetCanBePercentDamage(defender) then
    return 0, DamageType.Miss
  end
  return val, damageType
end

function FormulaService:PostProcessDeadDamage(defender, val, damageType)
  local buffLogicSvc = self._world:GetService("BuffLogic")
  if not buffLogicSvc:IsTargetCanBeToDie(defender) then
    return 0, DamageType.Miss
  end
  return val, damageType
end

function FormulaService:_CheckPercentDamage(defender)
  local buffLogicSvc = self._world:GetService("BuffLogic")
  return buffLogicSvc:IsTargetCanBePercentDamage(defender)
end

function FormulaService:_CheckDeadDamage(defender)
  local buffLogicSvc = self._world:GetService("BuffLogic")
  return buffLogicSvc:IsTargetCanBeToDie(defender)
end

function FormulaService:CalcTeamAverageAttack()
  local teamEntity = self._world:Player():GetCurrentTeamEntity()
  if not teamEntity then
    return 0
  end
  local petEntities = teamEntity:Team():GetTeamPetEntities()
  local totalAtk = 0
  local petCount = 0
  for _, petEntity in pairs(petEntities) do
    if not petEntity:HasDeadMark() then
      local petAtk = self:_CalcFinalAtk(petEntity)
      totalAtk = totalAtk + petAtk
      petCount = petCount + 1
    end
  end
  return self:_RET(totalAtk / petCount)
end

function FormulaService:CalcAutoBeadCritParam(critChance, critDamageRate, attacker)
  if not critChance or not critDamageRate then
    return 1
  end
  local critProb = critChance
  if critProb <= 0 then
    return 1
  end
  local critParam = critDamageRate
  local randomSvc = self._world:GetService("RandomLogic")
  local r = randomSvc:LogicRand()
  local val = critProb > r and critParam or 1
  return val
end

function FormulaService:CalGridDistance(attacker, defender)
  if not defender then
    return 0
  end
  local attackGPos = attacker:GridLocation().Position
  local defenderGPos = defender:GridLocation().Position
  return math.max(math.abs(defenderGPos.x - attackGPos.x), math.abs(defenderGPos.y - attackGPos.y))
end
