local PB = require("Common/PbHelper")
local FH = require("Logic/HelpLogic")
local AttrType = PB.enum.AttrType
local DevelopPrint = 0
local UseRandom = 0
local UseCritical = 1
local LogSwitch = 0

local function getRandomCriticalHitRate()
  local result = FH.getRandom(1, 10000)
  return result
end

local function getActionDamage(skillID, action, level, attackid)
  local damageInfo = PB.get("ActionDamage", skillID, action)
  if damageInfo ~= nil then
    local table_name = "DamageIndex"
    if attackid == 0 then
      table_name = "DamageIndexMonster"
    end
    local indexInfo = PB.get(table_name, damageInfo.index, level)
    if indexInfo ~= nil then
      return {indexInfo, true}
    elseif level ~= 1 then
      indexInfo = PB.get(table_name, damageInfo.index, 1)
      if indexInfo ~= nil then
        return {indexInfo, false}
      end
    end
    warning("GamePlay", string.format("ERROR can not find " .. table_name .. "  [ID]:%d [level]:%d", damageInfo.index, level))
  else
    warning("GamePlay", string.format("ERROR can not find ActionDamage  [ID]:%d [action]:%s", skillID, action))
  end
  return {nil, false}
end

local function GetAttrValue(attrs, vType)
  if attrs ~= nil then
    for i = 1, #attrs do
      if attrs[i].type == vType then
        return attrs[i].value
      end
    end
  end
  return 0
end

local function GetAttrValueByRatio(attrs, vType, isRatio)
  if attrs ~= nil then
    for i = 1, #attrs do
      if attrs[i].type == vType and attrs[i].isRatio == isRatio then
        return attrs[i].value
      end
    end
  end
  return 0
end

local function getEffectValue(damageInfo, vType)
  if damageInfo ~= nil then
    for i = 1, #damageInfo.hpType do
      if damageInfo.hpType[i] == vType then
        return damageInfo.hpVal[i]
      end
    end
  end
  return 0
end

local function getOneAttrVal(atorBaseAttrs, actorBuffAttrs, vType)
  local panelVal = GetAttrValue(atorBaseAttrs, vType)
  local ratioVal = 0
  local valueVal = 0
  local _, findResult = table.find(actorBuffAttrs, function(_, v)
    return v.type == vType
  end)
  if findResult then
    ratioVal = findResult.ratioValue
    valueVal = findResult.value
  end
  if ratioVal < -10000.0 then
    ratioVal = -10000.0
  end
  local finalVal = panelVal * (1 + ratioVal / 10000.0) + valueVal
  if finalVal < 0 then
    finalVal = 0
  end
  return finalVal
end

local function getDamageAdd(damageInfo, atorBaseAttrs, actorBuffAttrs, kind, attackid)
  if attackid == 0 then
    return 0
  end
  local total = 0
  if damageInfo ~= nil then
    for i = 1, #damageInfo.addAttKind do
      if damageInfo.addAttKind[i] == kind then
        total = total + getOneAttrVal(atorBaseAttrs, actorBuffAttrs, damageInfo.addAttType[i]) * damageInfo.addAttRate[i] / 10000
      end
    end
  end
  return total
end

local function getDamageAttr(actionDamage, level, final)
  local attrs = actionDamage.attrs
  if final then
    return attrs
  end
  local result_attr = {}
  if attrs ~= nil then
    local maxLevel = math.max(1, actionDamage.maxLevel - 1)
    for i = 1, #attrs do
      local new_attr = {}
      local result = 1 + (actionDamage.upRate - 10000) / 10000 * (level - 1) / maxLevel
      new_attr.value = attrs[i].value * result
      new_attr.type = attrs[i].type
      table.insert(result_attr, new_attr)
    end
  end
  return result_attr
end

local function calcCriticalHitRate(criticalHitValue, atkActorAttrs, defActorAttrs, attackSkillInfo, attackTalentInfo)
  if UseCritical == 0 then
    return 1.0
  end
  local attackerCriticalHitRate = GetAttrValue(atkActorAttrs, AttrType.CriticalHitRate)
  local defenderCriticalResistanceRate = GetAttrValue(defActorAttrs, AttrType.CriticalResistanceRate)
  local attackerSkillCriticalHitRate = GetAttrValue(attackSkillInfo, 4)
  local attackerTalentCriticalHitRate = GetAttrValue(attackTalentInfo, AttrType.CriticalHitRate)
  local criticalHitRate = attackerCriticalHitRate - defenderCriticalResistanceRate + attackerSkillCriticalHitRate + attackerTalentCriticalHitRate
  if criticalHitRate < 0.0 then
    criticalHitRate = 0.0
  end
  if 10000.0 < criticalHitRate then
    criticalHitRate = 10000.0
  end
  if criticalHitValue <= criticalHitRate then
    local attackerCriticalHitDamageRate = GetAttrValue(atkActorAttrs, AttrType.CriticalHitDamageRate)
    local defenderCriticalResistanceDamageRate = GetAttrValue(defActorAttrs, AttrType.CriticalResistanceDamageRate)
    local attackerSkillCriticalHitDamageRate = GetAttrValue(attackSkillInfo, 5)
    local attackerTalentCriticalHitDamageRate = GetAttrValue(attackTalentInfo, AttrType.CriticalHitDamageRate)
    local criticalHitDamageRate = 10000.0 + attackerCriticalHitDamageRate - defenderCriticalResistanceDamageRate + attackerSkillCriticalHitDamageRate + attackerTalentCriticalHitDamageRate
    if criticalHitDamageRate < 10000.0 then
      criticalHitDamageRate = 10000.0
    end
    return criticalHitDamageRate / 10000.0
  end
  return 1.0
end

local function getHurtVal(param, dungeonType)
  local result = {}
  result.result = 0
  result.critical = false
  result.boundVal = 0
  result.physical = 0
  result.magical = 0
  result.showType = 0
  local attackid = param.attackId
  local targetid = param.targetId
  local level = param.skillLevel
  local fun_damage_0 = getActionDamage(param.skillId, param.skillAction, level, 0)
  local fun_damage_1 = getActionDamage(param.skillId, param.skillAction, level, 1)
  local fun_damage = fun_damage_0
  if attackid ~= 0 then
    fun_damage = fun_damage_1
  end
  local actionDamage = fun_damage[1]
  local final = fun_damage[2]
  if actionDamage == nil then
    return result
  end
  local criticalHitRate = getRandomCriticalHitRate()
  local atkActorAttrs = param.attackAttrs
  local defActorAttrs = param.targetAttrs
  local atkActorBaseAttrs = param.attackBaseAttrs
  local defActorBaseAttrs = param.targetBaseAttrs
  local atkActorBuffAttrs = param.attackBuffAttrs
  local defActorBuffAttrs = param.targetBuffAttrs
  local attackCount = param.attackCount * param.addroleCount
  local attackType = param.attackType
  local attackSkillInfo = getDamageAttr(actionDamage, level, final)
  local attackTalentInfo = param.attackSkillAttrs
  local hitCount = param.totalHitCount
  if hitCount == nil or hitCount == 0 then
    hitCount = 1
  end
  local blockParam = 2
  local criticalHitDamageRate = 0.0
  if attackType == PB.enum.AttackTypeEnum.AttackType_AddHp or attackType == PB.enum.AttackTypeEnum.AttackType_AddHpALL then
    local skillHpRate = GetAttrValue(attackSkillInfo, 3) + GetAttrValue(attackTalentInfo, AttrType.SkillHpHealRate)
    if skillHpRate == 0 then
      return result
    end
    if dungeonType == PB.enum.DungeonType.BurstLinkPvp then
      skillHpRate = skillHpRate * 2.8
    end
    local healValue = 0
    local attackerAtkForHeal = getOneAttrVal(atkActorBaseAttrs, atkActorBuffAttrs, AttrType.Attack)
    local attackerMaxHpForHeal = GetAttrValue(atkActorBaseAttrs, AttrType.Hp)
    local atkPercent = getEffectValue(actionDamage, AttrType.Attack) / 10000.0
    local maxHpPercent = getEffectValue(actionDamage, AttrType.Hp) / 10000.0
    healValue = (attackerAtkForHeal * atkPercent + attackerMaxHpForHeal * maxHpPercent) * (skillHpRate / 10000)
    if 0 < healValue then
      criticalHitDamageRate = calcCriticalHitRate(criticalHitRate, atkActorAttrs, defActorAttrs, attackSkillInfo, attackTalentInfo)
      if 1 < criticalHitDamageRate then
        healValue = healValue * criticalHitDamageRate
        result.critical = true
      end
    end
    if LogSwitch == 1 then
      print("GamePlay", "\229\138\160\232\161\128\232\128\133\231\154\132\230\148\187\229\135\187= " .. attackerAtkForHeal .. "\230\157\131\233\135\141\228\184\186\239\188\154" .. atkPercent)
      print("GamePlay", "\229\138\160\232\161\128\232\128\133\231\154\132\230\156\128\229\164\167\231\148\159\229\145\189\229\128\188= " .. attackerMaxHpForHeal .. "\230\157\131\233\135\141\228\184\186\239\188\154" .. maxHpPercent)
      print("GamePlay", "\229\138\160\232\161\128\232\128\133\231\154\132\230\138\128\232\131\189\229\138\160\232\161\128\229\128\141\231\142\135+\229\164\169\232\181\139\232\162\171\229\138\168\229\138\160\232\161\128\229\128\141\231\142\135= " .. skillHpRate)
      print("GamePlay", "\229\138\160\232\161\128\229\128\188\229\128\188= " .. healValue)
      print("GamePlay", "attackCount= " .. attackCount)
    end
    if 1 < attackCount then
      healValue = healValue / attackCount
    end
    result.result = math.max(math.floor(healValue), 1)
  else
    local skillPhysicalDamageRate = GetAttrValue(attackSkillInfo, 1) + GetAttrValue(attackTalentInfo, AttrType.AttackRate)
    local basePhysicalDamage = 0
    local physicalDamage = 0
    local attackerFinalPhysicalDamageRate = 0
    local skillMagicalDamageRate = GetAttrValue(attackSkillInfo, 2) + GetAttrValue(attackTalentInfo, AttrType.AttackRate)
    local baseMagicalDamage = 0
    local magicalDamage = 0
    local attackerFinalMagicalDamageRate = 0
    if skillPhysicalDamageRate == 0 and skillMagicalDamageRate == 0 then
      return result
    end
    local attackerAtk = getOneAttrVal(atkActorBaseAttrs, atkActorBuffAttrs, AttrType.Attack)
    attackerAtk = attackerAtk + getDamageAdd(actionDamage, atkActorBaseAttrs, atkActorBuffAttrs, 2, attackid)
    local attackerPen = getOneAttrVal(atkActorBaseAttrs, atkActorBuffAttrs, AttrType.Penetration)
    if LogSwitch == 1 then
      print("GamePlay", "\230\148\187\229\135\187\229\128\188\230\148\187\229\135\187\229\138\155= " .. attackerAtk)
      print("GamePlay", "\230\148\187\229\135\187\232\128\133\231\169\191\233\128\143\229\128\188= " .. attackerPen)
    end
    if 0 < skillPhysicalDamageRate then
      local defenderPhysicalDefense = 0
      local defenderPanelPhysicalDefense = GetAttrValue(defActorBaseAttrs, AttrType.PhysicalDefense)
      local defenderPhysicalDefenseRatio = 0
      local defenderPhysicalDefenseValue = 0
      local _, findResult = table.find(defActorBuffAttrs, function(_, v)
        return v.type == AttrType.PhysicalDefense
      end)
      if findResult then
        defenderPhysicalDefenseRatio = findResult.ratioValue
        defenderPhysicalDefenseValue = findResult.value
      end
      if defenderPhysicalDefenseRatio < -10000.0 then
        defenderPhysicalDefenseRatio = -10000.0
      end
      local actualDefenderPanelPhysicalDefense = defenderPanelPhysicalDefense - attackerPen + defenderPhysicalDefenseValue
      if actualDefenderPanelPhysicalDefense < 0 then
        defenderPhysicalDefense = actualDefenderPanelPhysicalDefense * blockParam
      elseif defenderPanelPhysicalDefense - attackerPen < 0 then
        defenderPhysicalDefense = actualDefenderPanelPhysicalDefense
      else
        defenderPhysicalDefense = (defenderPanelPhysicalDefense - attackerPen) * (1 + defenderPhysicalDefenseRatio / 10000.0) + defenderPhysicalDefenseValue
      end
      basePhysicalDamage = (attackerAtk - defenderPhysicalDefense) * (skillPhysicalDamageRate / 10000.0)
      if basePhysicalDamage < 0 then
        basePhysicalDamage = 0
      end
      attackerFinalPhysicalDamageRate = GetAttrValue(atkActorAttrs, AttrType.FinalDamageRate) + GetAttrValue(defActorAttrs, AttrType.FinalDamageRateHurt)
      if attackerFinalPhysicalDamageRate < -8000.0 then
        attackerFinalPhysicalDamageRate = -8000.0
      end
      physicalDamage = basePhysicalDamage * (1 + attackerFinalPhysicalDamageRate / 10000.0) + GetAttrValue(atkActorAttrs, AttrType.FinalDamage) / hitCount + GetAttrValue(defActorAttrs, AttrType.FinalDamageHurt) / hitCount
      physicalDamage = physicalDamage + getDamageAdd(actionDamage, atkActorBaseAttrs, atkActorBuffAttrs, 1, attackid) / hitCount
      if physicalDamage < 0 then
        physicalDamage = 0
      end
      if LogSwitch == 1 then
        print("GamePlay", "\229\143\151\229\135\187\232\128\133\231\137\169\231\144\134\233\152\178\229\190\161= " .. defenderPhysicalDefense)
        print("GamePlay", "\230\148\187\229\135\187\232\128\133\231\137\169\231\144\134\230\138\128\232\131\189\229\128\141\231\142\135+\229\164\169\232\181\139\232\162\171\229\138\168\231\137\169\231\144\134\230\148\187\229\135\187\229\128\141\231\142\135= " .. skillPhysicalDamageRate)
        print("GamePlay", "\230\156\128\231\187\136\231\137\169\231\144\134\228\188\164\229\174\179= " .. physicalDamage)
        print("GamePlay", "hitCount= " .. hitCount)
        print("GamePlay", "attackCount= " .. attackCount)
      end
    end
    if 0 < skillMagicalDamageRate then
      local defenderMagicalDefense = 0
      local defenderPanelMagicalDefense = GetAttrValue(defActorBaseAttrs, AttrType.MagicalDefense)
      local defenderMagicalDefenseRatio = 0
      local defenderMagicalDefenseValue = 0
      local _, findResult = table.find(defActorBuffAttrs, function(_, v)
        return v.type == AttrType.MagicalDefense
      end)
      if findResult then
        defenderMagicalDefenseRatio = findResult.ratioValue
        defenderMagicalDefenseValue = findResult.value
      end
      if defenderMagicalDefenseRatio < -10000.0 then
        defenderMagicalDefenseRatio = -10000.0
      end
      local actualDefenderPanelMagicalDefense = defenderPanelMagicalDefense - attackerPen + defenderMagicalDefenseValue
      if actualDefenderPanelMagicalDefense < 0 then
        defenderMagicalDefense = actualDefenderPanelMagicalDefense * blockParam
      elseif defenderPanelMagicalDefense - attackerPen < 0 then
        defenderMagicalDefense = actualDefenderPanelMagicalDefense
      else
        defenderMagicalDefense = (defenderPanelMagicalDefense - attackerPen) * (1 + defenderMagicalDefenseRatio / 10000.0) + defenderMagicalDefenseValue
      end
      baseMagicalDamage = (attackerAtk - defenderMagicalDefense) * (skillMagicalDamageRate / 10000.0)
      if baseMagicalDamage < 0 then
        baseMagicalDamage = 0
      end
      attackerFinalMagicalDamageRate = GetAttrValue(atkActorAttrs, AttrType.FinalDamageRate) + GetAttrValue(defActorAttrs, AttrType.FinalDamageRateHurt)
      if attackerFinalMagicalDamageRate < -8000.0 then
        attackerFinalMagicalDamageRate = -8000.0
      end
      magicalDamage = baseMagicalDamage * (1 + attackerFinalMagicalDamageRate / 10000.0) + GetAttrValue(atkActorAttrs, AttrType.FinalDamage) / hitCount + GetAttrValue(defActorAttrs, AttrType.FinalDamageHurt) / hitCount
      magicalDamage = magicalDamage + getDamageAdd(actionDamage, atkActorBaseAttrs, atkActorBuffAttrs, 1, attackid) / hitCount
      if magicalDamage < 0 then
        magicalDamage = 0
      end
      if LogSwitch == 1 then
        print("GamePlay", "\229\143\151\229\135\187\232\128\133\229\188\130\232\131\189\233\152\178\229\190\161= " .. defenderMagicalDefense)
        print("GamePlay", "\230\148\187\229\135\187\232\128\133\233\173\148\230\179\149\230\138\128\232\131\189\229\128\141\231\142\135+\229\164\169\232\181\139\232\162\171\229\138\168\233\173\148\230\179\149\230\148\187\229\135\187\229\128\141\231\142\135= " .. skillMagicalDamageRate)
        print("GamePlay", "\230\156\128\231\187\136\233\173\148\230\179\149\228\188\164\229\174\179= " .. magicalDamage)
        print("GamePlay", "hitCount= " .. hitCount)
        print("GamePlay", "attackCount= " .. attackCount)
      end
    end
    if 0 < basePhysicalDamage or 0 < baseMagicalDamage then
      criticalHitDamageRate = calcCriticalHitRate(criticalHitRate, atkActorAttrs, defActorAttrs, attackSkillInfo, attackTalentInfo)
      if 1 < criticalHitDamageRate then
        physicalDamage = basePhysicalDamage * criticalHitDamageRate
        magicalDamage = baseMagicalDamage * criticalHitDamageRate
        physicalDamage = physicalDamage * (1 + attackerFinalPhysicalDamageRate / 10000.0) + GetAttrValue(atkActorAttrs, AttrType.FinalDamage) / hitCount
        magicalDamage = magicalDamage * (1 + attackerFinalMagicalDamageRate / 10000.0) + GetAttrValue(atkActorAttrs, AttrType.FinalDamage) / hitCount
        physicalDamage = physicalDamage + getDamageAdd(actionDamage, atkActorBaseAttrs, atkActorBuffAttrs, 1, attackid) / hitCount
        magicalDamage = magicalDamage + getDamageAdd(actionDamage, atkActorBaseAttrs, atkActorBuffAttrs, 1, attackid) / hitCount
        if physicalDamage < 0 then
          physicalDamage = 0
        end
        if magicalDamage < 0 then
          magicalDamage = 0
        end
        result.critical = true
      end
    end
    local randomRate = 0
    if UseRandom == 0 then
      randomRate = 0
    end
    physicalDamage = physicalDamage * (1 + randomRate)
    magicalDamage = magicalDamage * (1 + randomRate)
    if 1 < attackCount then
      physicalDamage = physicalDamage / attackCount
      magicalDamage = magicalDamage / attackCount
    end
    result.physical = -math.ceil(physicalDamage)
    result.magical = -math.ceil(magicalDamage)
    result.result = result.physical + result.magical
    if result.result == 0 then
      if 0 < skillPhysicalDamageRate then
        result.physical = -1
        result.magical = 0
      end
      if 0 < skillMagicalDamageRate then
        result.physical = 0
        result.magical = -1
      end
      result.result = -1
    end
  end
  return result
end

return getHurtVal
