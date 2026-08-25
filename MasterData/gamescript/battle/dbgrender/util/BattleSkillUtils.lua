local BattleSkillUtils = {}

function BattleSkillUtils.GetCondListValueByIndex(condListCfg, index)
  if type(condListCfg) ~= "table" or not index then
    return nil
  end
  local entry = condListCfg[index]
  if type(entry) ~= "table" then
    return nil
  end
  return entry[2]
end

function BattleSkillUtils.RebuildDescArgsFromSkillArgs(descKey, skillArgs)
  local argMap = {}
  for i, v in ipairs(skillArgs or {}) do
    if type(v) == "number" then
      argMap[i] = math.ceil(v)
    else
      argMap[i] = v
    end
  end
  local curValues = {}
  local baseValues = {}
  local slots = SkillUtils.ParseCnDescSlots(descKey or "")
  for _, slot in ipairs(slots) do
    local value = 0
    if slot.argNum then
      value = argMap[slot.argNum] or 0
    end
    table.insert(curValues, value)
    table.insert(baseValues, value)
  end
  return {curValues = curValues, baseValues = baseValues}
end

function BattleSkillUtils.BuildDisplayBattleDesc(skillTid, condList, skillArgs, descArgs)
  local skillCfg = DT.Skill and DT.Skill[skillTid]
  if not skillCfg then
    return nil
  end
  local battleDescKey = BattleSkillUtils.GetCondListValueByIndex(skillCfg.tempBattleDesc, condList and condList.tempBattleDesc)
  battleDescKey = battleDescKey or skillCfg.BattleDesc
  if not battleDescKey then
    return nil
  end
  if type(skillArgs) == "table" and #skillArgs > 0 then
    descArgs = BattleSkillUtils.RebuildDescArgsFromSkillArgs(battleDescKey, skillArgs)
  end
  do return BattleSkillUtils.__ReplaceDescArgs, battleDescKey end
  return BattleSkillUtils.__ReplaceDescArgs, battleDescKey, descArgs or {
    curValues = {},
    baseValues = {}
  }, {}
end

function BattleSkillUtils.GetBreakAndPotencyLevel(awaker)
  local breakLevel = 0
  local potencyLevel = 0
  if awaker then
    breakLevel = awaker.breakLevel or 0
    potencyLevel = awaker.potencyLevel or 0
  end
  return breakLevel, potencyLevel
end

function BattleSkillUtils.CalcSkillManiacMax(params)
  local ulti_energy_max = params.ulti_energy_max or 0
  local ulti_energy_cost_per = params.ulti_energy_cost_per or 0
  local ulti_energy_cost_flat = params.ulti_energy_cost_flat or 0
  local ulti_energy_max_per = params.ulti_energy_max_per or 0
  local energyNormalUltlSkillMax = math.ceil(ulti_energy_max * (1 + ulti_energy_cost_per / 100)) + ulti_energy_cost_flat
  local needEnergySuperUtlSkillMax = energyNormalUltlSkillMax * (1 + ulti_energy_max_per / 100)
  return math.floor(energyNormalUltlSkillMax), math.floor(needEnergySuperUtlSkillMax)
end

function BattleSkillUtils.GetBreakSkillLevel(awaker)
  local breakSkillLevel = 0
  if awaker then
    breakSkillLevel = awaker.breakSkillLevel or 0
  end
  return breakSkillLevel
end

function BattleSkillUtils.GetSkillName(skillCfg, breakLevel, potencyLevel, params)
  if not skillCfg then
    return ""
  end
  if skillCfg.tempName then
    local parserEnv = {}
    if params then
      if params.card then
        parserEnv.card = params.card
      end
      if params.awaker then
        parserEnv.awaker = params.awaker
      elseif params.card and params.card.awaker then
        parserEnv.awaker = params.card.awaker
      end
      parserEnv.skillId = params.skillId or skillCfg.ID
    end
    local cmdParser = BattleCmdParserClient(parserEnv)
    local tempResult = CmdParserUtils.GetCfgByCond(skillCfg.tempName, cmdParser, parserEnv)
    if tempResult then
      local name = LT.Text(tempResult)
      do return BattleSkillUtils.ResolveShowIfStateText, name end
      return BattleSkillUtils.ResolveShowIfStateText, name, {
        awaker = parserEnv.awaker,
        card = parserEnv.card,
        skillId = parserEnv.skillId,
        cmdParserClient = cmdParser
      }, parserEnv.skillId
    end
  end
  local newParams = table.clone(params or {})
  newParams.breakSkillLevel = breakLevel
  newParams.potencyLevel = potencyLevel
  newParams.skillId = skillCfg.ID
  local name = BattleSkillUtils.GetMatchTQ(skillCfg.Name, newParams)
  if not name then
    return ""
  end
  name = LT.Text(name)
  do return BattleSkillUtils.ResolveShowIfStateText, name end
  return BattleSkillUtils.ResolveShowIfStateText, name, newParams, name, {
    awaker = parserEnv.awaker,
    card = parserEnv.card,
    skillId = parserEnv.skillId,
    cmdParserClient = cmdParser
  }, parserEnv.skillId
end

function BattleSkillUtils.GetSkillIcon(skillCfg, params)
  if not skillCfg then
    return ""
  end
  if skillCfg.tempIcon then
    local parserEnv = {}
    if params then
      if params.card then
        parserEnv.card = params.card
      end
      if params.awaker then
        parserEnv.awaker = params.awaker
      elseif params.card and params.card.awaker then
        parserEnv.awaker = params.card.awaker
      end
      parserEnv.skillId = params.skillId or skillCfg.ID
      parserEnv.skillLevel = params.skillLevel
    end
    local cmdParser = BattleCmdParserClient(parserEnv)
    local tempResult = CmdParserUtils.GetCfgByCond(skillCfg.tempIcon, cmdParser, parserEnv)
    if tempResult then
      return tempResult
    end
  end
  return skillCfg.Icon or ""
end

function BattleSkillUtils.ResolveShowIfStateText(str, params)
  if not str or not string.find(str, "%[ShowIfState:") then
    return str
  end
  local parserEnv = {
    awaker = params and params.awaker,
    card = params and params.card,
    skillId = params and params.skillId
  }
  if parserEnv.card and parserEnv.card.awaker and not parserEnv.awaker then
    parserEnv.awaker = parserEnv.card.awaker
  end
  if not parserEnv.awaker and not parserEnv.card then
    do return string.replace, str, "%[ShowIfState:.-%]" end
    return string.replace, str, "%[ShowIfState:.-%]", "", nil
  end
  local cmdParser = params and params.cmdParserClient or BattleCmdParserClient(parserEnv)
  do return string.gsub, str, "%[ShowIfState:(.-)%]" end
  return string.gsub, str, "%[ShowIfState:(.-)%]", function(cmd)
    local value = cmdParser:GetValueByCmd(cmd)
    if not value or 0 == value or false == value then
      return ""
    end
    local stateId = string.match(cmd, "GetStateLayer%((%d+)%)")
    if stateId then
      local stateCfg = DT.State[tonumber(stateId)]
      if stateCfg and stateCfg.Name then
        do return LT.Text end
        return LT.Text, stateCfg.Name
      end
    end
    if type(value) == "number" then
      do return tostring, math.ceil(value) end
      return tostring, math.ceil(value)
    end
    do return tostring end
    return tostring, value, math.ceil(value)
  end
end

function BattleSkillUtils.GetSkillDesc(skillCfg, breakLevel, potencyLevel, params)
  if not skillCfg then
    return nil
  end
  local newParams = table.clone(params or {})
  newParams.breakSkillLevel = breakLevel
  newParams.potencyLevel = potencyLevel
  newParams.skillId = skillCfg.ID
  local skillDesc = BattleSkillUtils.GetMatchTQ(skillCfg.Desc, newParams) or ""
  skillDesc = string.replace(skillDesc, "%[ShowIfState:.-%]", "")
  return skillDesc
end

function BattleSkillUtils.GetOverLimitUtlSkillDesc(skillCfg, breakLevel, potencyLevel, params)
  if not skillCfg then
    return nil
  end
  local newParams = table.clone(params or {})
  newParams.breakSkillLevel = breakLevel
  newParams.potencyLevel = potencyLevel
  newParams.skillId = skillCfg.ID
  local skillDesc = BattleSkillUtils.GetMatchTQ(SkillCfgUtils.GetOverLimitUtlSkillDesc(skillCfg.ID, nil, {
    awaker = params.awaker
  }), newParams) or ""
  skillDesc = string.replace(skillDesc, "%[ShowIfState:.-%]", "")
  return skillDesc
end

function BattleSkillUtils.GetSkillBattleDesc(skillCfg, breakLevel, potencyLevel, params)
  if not skillCfg then
    return nil
  end
  local newParams = table.clone(params or {})
  newParams.breakSkillLevel = breakLevel
  newParams.potencyLevel = potencyLevel
  newParams.skillId = skillCfg.ID
  do return BattleSkillUtils.GetMatchTQ, (SkillCfgUtils.GetFieldBattleDesc(skillCfg.ID, nil, {
    awaker = params.awaker
  })) end
  return BattleSkillUtils.GetMatchTQ, SkillCfgUtils.GetFieldBattleDesc(skillCfg.ID, nil, {
    awaker = params.awaker
  }), newParams, nil, {
    awaker = params.awaker
  }, params.awaker
end

function BattleSkillUtils.IsXCostText(costText)
  return type(costText) == "string" and costText:startswith("X")
end

function BattleSkillUtils.GetSkillCost(skillCfg, breakLevel, potencyLevel, params)
  if not skillCfg then
    return 0
  end
  local newParams = table.clone(params or {})
  newParams.breakSkillLevel = breakLevel
  newParams.potencyLevel = potencyLevel
  newParams.skillId = skillCfg.ID
  do return BattleSkillUtils.GetMatchTQ, skillCfg.Cost end
  return BattleSkillUtils.GetMatchTQ, skillCfg.Cost, newParams
end

function BattleSkillUtils.GetResolvedSkillCost(skillCfg, breakLevel, potencyLevel, params)
  if not skillCfg then
    return 0
  end
  local newParams = table.clone(params or {})
  newParams.breakSkillLevel = breakLevel
  newParams.potencyLevel = potencyLevel
  newParams.skillId = skillCfg.ID
  local cost = BattleSkillUtils.GetMatchTQ(skillCfg.Cost, newParams)
  if nil == cost then
    return cost
  end
  if BattleSkillUtils.IsXCostText(cost) then
    return "X"
  end
  if tonumber(cost) then
    do return tonumber end
    return tonumber, cost, nil, nil, nil, nil, nil
  end
  local parserEnv = {
    awaker = newParams.awaker,
    card = newParams.card,
    skillId = skillCfg.ID
  }
  if parserEnv.card and parserEnv.card.awaker and not parserEnv.awaker then
    parserEnv.awaker = parserEnv.card.awaker
  end
  local cmdParser = newParams.cmdParserClient or BattleCmdParserClient(parserEnv)
  local value = cmdParser:GetValueByCmd(cost)
  if type(value) == "number" then
    do return math.max, 0, math.ceil(value) end
    return math.max, 0, math.ceil(value)
  end
  return value
end

function BattleSkillUtils.GetSkillType(skillCfg, breakLevel, potencyLevel)
  if not skillCfg then
    return
  end
  assert(skillCfg.Type, string.format("skillCfg.Type is nil, skillCfg.Name = %s", skillCfg.Name))
  do return BattleUtilServer.GetTQList, skillCfg.Type, breakLevel end
  return BattleUtilServer.GetTQList, skillCfg.Type, breakLevel, potencyLevel, string.format("skillCfg.Type is nil, skillCfg.Name = %s", skillCfg.Name)
end

function BattleSkillUtils.GetSkillGlowCond(skillCfg, breakLevel, potencyLevel)
  if not skillCfg then
    return nil
  end
  local params = {
    breakSkillLevel = breakLevel,
    potencyLevel = potencyLevel,
    skillId = skillCfg.ID
  }
  do return BattleSkillUtils.GetMatchTQ, skillCfg.GlowCond end
  return BattleSkillUtils.GetMatchTQ, skillCfg.GlowCond, params
end

function BattleSkillUtils.GetSkillCmdList(skillCfg, breakLevel, potencyLevel)
  if not skillCfg then
    return 0
  end
  local params = {
    breakSkillLevel = breakLevel,
    potencyLevel = potencyLevel,
    skillId = skillCfg.ID
  }
  do return BattleSkillUtils.GetMatchTQ, skillCfg.CmdList end
  return BattleSkillUtils.GetMatchTQ, skillCfg.CmdList, params
end

function BattleSkillUtils.GetSkillCmdTarget(skillCfg, breakLevel, potencyLevel)
  if not skillCfg then
    return nil
  end
  local params = {
    breakSkillLevel = breakLevel,
    potencyLevel = potencyLevel,
    skillId = skillCfg.ID
  }
  do return BattleSkillUtils.GetMatchTQ, skillCfg.CmdTarget end
  return BattleSkillUtils.GetMatchTQ, skillCfg.CmdTarget, params
end

function BattleSkillUtils.GetSkillPara(skillCfg, breakLevel, potencyLevel)
  if not skillCfg then
    return nil
  end
  local params = {
    breakSkillLevel = breakLevel,
    potencyLevel = potencyLevel,
    skillId = skillCfg.ID
  }
  do return BattleSkillUtils.GetMatchTQ, skillCfg.Para end
  return BattleSkillUtils.GetMatchTQ, skillCfg.Para, params
end

function BattleSkillUtils.GetSkillExistState(skillCfg, breakLevel, potencyLevel, params)
  if not skillCfg then
    return {}
  end
  params = params or {}
  params.breakSkillLevel = breakLevel
  params.potencyLevel = potencyLevel
  params.skillId = skillCfg.ID
  if params.awaker == nil and params.card and params.card.awaker then
    params.awaker = params.card.awaker
  end
  return BattleSkillUtils.GetMatchTQList(skillCfg.ExistState, params) or {}
end

function BattleSkillUtils.GetSkillStatePara(skillCfg, breakLevel, potencyLevel)
  do return BattleUtilServer.GetTQList, skillCfg.StatePara, breakLevel end
  return BattleUtilServer.GetTQList, skillCfg.StatePara, breakLevel, potencyLevel
end

function BattleSkillUtils.GetSkillStateLayer(skillCfg, breakLevel, potencyLevel)
  if not skillCfg then
    return {}
  end
  do return BattleUtilServer.GetTQList, skillCfg.StateLayer, breakLevel end
  return BattleUtilServer.GetTQList, skillCfg.StateLayer, breakLevel, potencyLevel
end

function BattleSkillUtils.GetSkillOriginalCoefficient(skillCfg, breakLevel, potencyLevel)
  do return BattleUtilServer.GetTQList, skillCfg.OriginalCoefficient, breakLevel end
  return BattleUtilServer.GetTQList, skillCfg.OriginalCoefficient, breakLevel, potencyLevel
end

function BattleSkillUtils.GetSkillCoefficientTypelist(skillCfg, breakLevel, potencyLevel)
  do return BattleUtilServer.GetTQList, skillCfg.CoefficientTypelist, breakLevel end
  return BattleUtilServer.GetTQList, skillCfg.CoefficientTypelist, breakLevel, potencyLevel
end

function BattleSkillUtils.GetSkillEffectNameList(skillCfg, breakLevel, potencyLevel)
  local params = {
    breakSkillLevel = breakLevel,
    potencyLevel = potencyLevel,
    skillId = skillCfg.ID
  }
  do return BattleSkillUtils.GetMatchTQ, skillCfg.EffectNameList end
  return BattleSkillUtils.GetMatchTQ, skillCfg.EffectNameList, params
end

function BattleSkillUtils.GetSkillPropertyNameList(skillCfg, breakLevel, potencyLevel)
  local params = {
    breakSkillLevel = breakLevel,
    potencyLevel = potencyLevel,
    skillId = skillCfg.ID
  }
  do return BattleSkillUtils.GetMatchTQ, skillCfg.PropertyNameList end
  return BattleSkillUtils.GetMatchTQ, skillCfg.PropertyNameList, params
end

function BattleSkillUtils.GetSkillNameByTid(skillTid, ownerAwakerOrNil)
  local skillCfg = DT.Skill[skillTid]
  if not skillCfg then
    return ""
  end
  local _, potencyLevel = BattleSkillUtils.GetBreakAndPotencyLevel(ownerAwakerOrNil)
  local breakSkillLevel = BattleSkillUtils.GetBreakSkillLevel(ownerAwakerOrNil)
  do return BattleSkillUtils.GetSkillName, skillCfg, breakSkillLevel end
  return BattleSkillUtils.GetSkillName, skillCfg, breakSkillLevel, potencyLevel
end

function BattleSkillUtils.GetCardDesc(skillId, ownerAwaker, skillLevel, cardArgs, card)
  local DT = bg.DT
  local skillCfg = DT.Skill[skillId]
  if not skillCfg then
    return ""
  end
  local _, potency = BattleSkillUtils.GetBreakAndPotencyLevel(ownerAwaker)
  local breakSkillLevel = BattleSkillUtils.GetBreakSkillLevel(ownerAwaker)
  local desc = BattleSkillUtils.GetSkillDesc(skillCfg, breakSkillLevel, potency, {awaker = ownerAwaker, card = card})
  if SceneMgr.Instance and SceneMgr.Instance:IsInCopies() or bg.battleScene then
    local params = {awaker = ownerAwaker, card = card}
    desc = BattleSkillUtils.GetSkillBattleDesc(skillCfg, breakSkillLevel, potency, params) or desc
  end
  if not desc then
    return ""
  end
  local cmdParser = BattleCmdParserClient({awaker = ownerAwaker, card = card})
  cmdParser:SetMemberValue("SkillLevel", skillLevel or 1)
  cardArgs = cardArgs or {
    curValues = {},
    baseValues = {}
  }
  do return BattleSkillUtils.__ReplaceDescArgs, desc end
  return BattleSkillUtils.__ReplaceDescArgs, desc, cardArgs, skillLevel or 1, params
end

function BattleSkillUtils.GetCardEnchantSmallIcon(runeTid, cardUid)
  local runeCfg = DT.EnchantConfig[runeTid]
  local path = runeCfg.SmallIcon
  local inBattle = SceneMgr.Instance:IsInBattle()
  local isGray = false
  if cardUid and runeCfg.InvalidPond and inBattle then
    local thisCard = bg.battleRender.cardMgr:GetCardByUid(cardUid)
    local ownerAwaker = thisCard.awaker
    local cmdParser = BattleCmdParserClient({awaker = ownerAwaker, card = thisCard})
    local value = cmdParser:GetValueByCmd(runeCfg.InvalidPond)
    if true == value then
      if runeCfg.InvalidIcon then
        return runeCfg.InvalidIcon
      end
      isGray = true
    end
  end
  return path, isGray
end

function BattleSkillUtils.__ReplaceDescArgs(desc, cardArgs, cnDesc)
  if not cnDesc or type(cnDesc) ~= "string" then
    cnDesc = desc
  end
  desc = LT.Text(desc) or ""
  local slots = SkillUtils.ParseCnDescSlots(cnDesc)
  local replaceParam = SkillUtils.BuildDescArgsReplaceParam(slots, cardArgs.curValues)
  desc = SkillUtils.ReplaceDescArgPlaceholders(desc, slots, replaceParam)
  do return StateDataUtils.ReplacePosAwakerNameText end
  return StateDataUtils.ReplacePosAwakerNameText, desc, slots, replaceParam
end

function BattleSkillUtils.IsColdBloodRecoverTimes()
  local max = bc.BoutBloodSkillMaxTimes
  local cur = bg.battleDataCenter.boutBloodRecoverTimes.value or 0
  return max <= cur
end

function BattleSkillUtils.IsColdBloodInCd()
  local cmdParser = BattleCmdParserClient({})
  local cond = DT.BattleApi.BloodAbilityCond.Data
  local ret = cmdParser:GetValueByCmd(cond)
  return true ~= ret
end

function BattleSkillUtils.IsDimensionSchoolSkillInCd()
  local cmdParser = BattleCmdParserClient({})
  local cond = DT.BattleApi.DimensionAbilityCond.Data
  local ret = cmdParser:GetValueByCmd(cond)
  return true ~= ret
end

function BattleSkillUtils.IsDimensionCardEmpty()
  local dimensionCards = bg.battleRender.cardMgr:GetCardListByDeck(bc.CardDeck.DimensionDeck)
  return 0 == #dimensionCards
end

function BattleSkillUtils.IsDimensionSkillRecoverTimes()
  local playRole = bg.battleDataCenter:GetPlayerRoleDataModel()
  local usedTime = playRole:GetProperty(bc.BattleProperty.bout_dskill_use_times) or 0
  return usedTime >= 1
end

function BattleSkillUtils.GetMatchTQList(tqListOrCondList, params)
  params = params or {}
  local breakSkillLevel = params.breakSkillLevel or 0
  local potencyLevel = params.potencyLevel or 0
  if type(tqListOrCondList) == "table" then
    local result = CmdParserUtils.GetCfgByCond(tqListOrCondList, params.cmdParserClient, params)
    if nil ~= result then
      return result
    end
  end
  do return BattleUtilServer.GetTQList, tqListOrCondList, breakSkillLevel end
  return BattleUtilServer.GetTQList, tqListOrCondList, breakSkillLevel, potencyLevel
end

function BattleSkillUtils.GetMatchTQ(tqTextOrCondText, params)
  params = params or {}
  local breakSkillLevel = params.breakSkillLevel or 0
  local potencyLevel = params.potencyLevel or 0
  if type(tqTextOrCondText) == "table" then
    local result = CmdParserUtils.GetCfgByCond(tqTextOrCondText, params.cmdParserClient, params)
    if nil ~= result then
      return result
    end
  end
  do return BattleUtilServer.GetTQText, tqTextOrCondText, breakSkillLevel end
  return BattleUtilServer.GetTQText, tqTextOrCondText, breakSkillLevel, potencyLevel
end

function BattleSkillUtils.GetBlessingCardMarkStateId()
  do return DT.GetOriginalConstant end
  return DT.GetOriginalConstant, "BlessingCardType"
end

function BattleSkillUtils.IsBlessingCard(cardUid)
  local stateId = BattleSkillUtils.GetBlessingCardMarkStateId()
  if not stateId or not cardUid then
    return false
  end
  local stateData = bg.battleDataCenter and bg.battleDataCenter.stateData
  if not stateData then
    return false
  end
  return stateData:GetRoleState(cardUid, stateId) ~= nil
end

return BattleSkillUtils
