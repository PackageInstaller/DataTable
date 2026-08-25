local DT = require("System.DataTable")
local LT = require("System.LangTable")
local CommonDefine = require("World.Enums.CommonDefine")
local AwakerDataUtils = require("Data.AwakerDataUtils")
local ItemDataUtils = require("Data.ItemDataUtils")
local bg = require("Battle.DbgRender.BattleGlobal")
local Logger = require("Utility.Logger")
local BattleSkillUtils = require("Battle.DbgRender.Util.BattleSkillUtils")
local StateDataUtils = require("Data.StateDataUtils")
local AwakerSkillMode = CommonDefine.AwakerSkillMode
local SkillUtils = {}

function SkillUtils.IsBattleAwakerData(awakerData)
  if not awakerData then
    return false
  end
  if awakerData.breakSkillLevel ~= nil then
    return true
  end
  if nil ~= awakerData.breakLevel and nil == awakerData.breakSkillUnlock then
    return true
  end
  return false
end

function SkillUtils.GetAwakerSkillTQLevels(awakerData)
  if SkillUtils.IsBattleAwakerData(awakerData) then
    local _, potency = BattleSkillUtils.GetBreakAndPotencyLevel(awakerData)
    return BattleSkillUtils.GetBreakSkillLevel(awakerData), potency
  end
  local _, potency = AwakerDataUtils.GetBreakAndPotencyLevel(awakerData)
  return AwakerDataUtils.GetBreakSkillLevel(awakerData), potency
end

function SkillUtils.ResolveExistStateLayerValue(cmdParser, layerValue)
  if nil == layerValue or "" == layerValue or false == layerValue then
    return 1
  end
  if type(layerValue) == "number" then
    return layerValue
  end
  if type(layerValue) == "string" then
    local value = cmdParser:GetValueByCmd(layerValue)
    if nil == value or "" == value or false == value then
      return 1
    end
    do return math.ceil end
    return math.ceil, tonumber(value) or value, value
  end
  return 1
end

function SkillUtils.BuildExistStateLayerMap(skillCfg, breakSkillLevel, potencyLevel, cmdParser)
  local params = cmdParser and cmdParser.parserEnv or {}
  if cmdParser then
    params.cmdParserClient = cmdParser
  end
  local existState = BattleSkillUtils.GetSkillExistState(skillCfg, breakSkillLevel, potencyLevel, params) or {}
  if 0 == #existState then
    return nil
  end
  local stateLayers = BattleSkillUtils.GetSkillStateLayer(skillCfg, breakSkillLevel, potencyLevel) or {}
  local existStateLayerMap = {}
  for i, sid in ipairs(existState) do
    local layer = SkillUtils.ResolveExistStateLayerValue(cmdParser, stateLayers[i])
    existStateLayerMap[sid] = (existStateLayerMap[sid] or 0) + layer
  end
  return existStateLayerMap
end

function SkillUtils.ExecuteSkillLevelUpArg(cmdParser, originalArgValue, coefficientStr)
  if originalArgValue and coefficientStr then
    cmdParser:SetMemberValue("GrowArgValue", originalArgValue)
    do return cmdParser.GetValueByCmd, cmdParser end
    return cmdParser.GetValueByCmd, cmdParser, coefficientStr, originalArgValue
  end
end

function SkillUtils.GetSkillLevelUpArgs(awakerData, skillId, skillLevel)
  local _, potency = AwakerDataUtils.GetBreakAndPotencyLevel(awakerData)
  local breakSkillLevel = AwakerDataUtils.GetBreakSkillLevel(awakerData)
  local parserEnv = {
    skillId = skillId,
    skillLevel = skillLevel,
    breakSkillLevel = breakSkillLevel,
    potencyLevel = potency,
    awaker = awakerData
  }
  local cmdParser = BattleCmdParserClient(parserEnv)
  do return SkillUtils.__GetSkillLevelUpArgsWithBreakthroughAndPotency end
  return SkillUtils.__GetSkillLevelUpArgsWithBreakthroughAndPotency, cmdParser
end

function SkillUtils.__GetSkillLevelUpArgsWithBreakthroughAndPotency(cmdParser)
  local parserEnv = cmdParser.parserEnv
  local skillCfg = DT.Skill[parserEnv.skillId]
  assert(skillCfg, "技能不存在:" .. parserEnv.skillId)
  local argValues = {}
  local breakSkillLevel = parserEnv.breakSkillLevel
  local potency = parserEnv.potencyLevel
  local originalCoefficientList = BattleSkillUtils.GetSkillOriginalCoefficient(skillCfg, breakSkillLevel, potency) or {}
  local coefficientStrList = BattleSkillUtils.GetSkillCoefficientTypelist(skillCfg, breakSkillLevel, potency) or {}
  for i, v in ipairs(coefficientStrList) do
    argValues[i] = SkillUtils.ExecuteSkillLevelUpArg(cmdParser, originalCoefficientList[i], v)
  end
  return argValues
end

function SkillUtils.GetAwakerPotencyDesc(awakerData, potencyTid, skillModel)
  local config = DT.AwakerPotency[potencyTid]
  local desc = LT.Text(config.PotencyDesc)
  local effList = {}
  if config.Effect then
    for _, v in ipairs(config.Effect) do
      table.insert(effList, v)
    end
  end
  local stateParams = {}
  for i, valueStr in ipairs(config.EffectPara or {}) do
    table.insert(stateParams, SkillUtils.GetPotencySkillParam(awakerData, skillModel, valueStr))
  end
  do return SkillUtils.HandleDescArg, desc, stateParams, nil end
  return SkillUtils.HandleDescArg, desc, stateParams, nil, true, table.insert, table.insert, stateParams, SkillUtils.GetPotencySkillParam(awakerData, skillModel, valueStr)
end

function SkillUtils.GetPotencySkillParam(awakerData, skillModel, valueStr)
  local indexStart = string.find(valueStr, "%(")
  local indexEnd = string.find(valueStr, "%)")
  local paramStr = string.sub(valueStr, indexStart + 1, indexEnd - 1)
  local paramArray = string.split(paramStr, ",")
  local skillId = tonumber(paramArray[1])
  local potency = tonumber(paramArray[2] or 0)
  local indexParam = tonumber(paramArray[3] or 0)
  local mulPercent = tonumber(paramArray[4] or 0)
  local breakSkillLevel = AwakerDataUtils.GetBreakSkillLevel(awakerData)
  local skillCfg = DT.Skill[skillId]
  local skillLevel = skillModel:GetSkillLevel(CommonDefine.AwakerSkillSlot[skillCfg.Slot], AwakerSkillMode.DBG)
  local parserEnv = {
    skillId = skillId,
    skillLevel = skillLevel or 1,
    breakSkillLevel = breakSkillLevel,
    potencyLevel = potency,
    awaker = awakerData
  }
  local cmdParser = BattleCmdParserClient(parserEnv)
  local argValues = SkillUtils.__GetSkillLevelUpArgsWithBreakthroughAndPotency(cmdParser)
  local val = argValues[indexParam]
  if 0 ~= mulPercent then
    val = SkillUtils.ToPropertyValueDisplayString(val * 100)
  else
    val = SkillUtils.ToPropertyValueDisplayString(val)
  end
  return val
end

function SkillUtils.GetColoredArgsDesc(desc, argsColor)
  if not desc or not argsColor then
    return desc
  end
  local tags = {}
  local tagTokenPrefix = "__SKILL_TAG_TOKEN_"
  local tagTokenSuffix = "__"
  local descWithoutTags = string.gsub(desc, "<[^>]->", function(tag)
    local idx = #tags + 1
    tags[idx] = tag
    return tagTokenPrefix .. idx .. tagTokenSuffix
  end)
  local coloredDesc = string.gsub(descWithoutTags, "%[Arg%d+%]", function(arg)
    do return string.format, "<color=%s>%s</color>", argsColor end
    return string.format, "<color=%s>%s</color>", argsColor, arg
  end)
  do return string.gsub, coloredDesc, tagTokenPrefix .. "(%d+)" .. tagTokenSuffix end
  return string.gsub, coloredDesc, tagTokenPrefix .. "(%d+)" .. tagTokenSuffix, function(idx)
    return tags[tonumber(idx)] or ""
  end, tagTokenSuffix
end

function SkillUtils.GetAwakerTalentDesc(talentTid, level, argsColor)
  local config = DT.AwakerTalent[talentTid]
  if not level or 0 == level then
    level = 1
  end
  local talentCfg = config and config.data_list[level]
  if not talentCfg then
    return ""
  end
  local desc = LT.Text(talentCfg.TalentDesc)
  desc = SkillUtils.GetColoredArgsDesc(desc, argsColor)
  local awakerTid = talentCfg.AwakerID
  local awakerData = CopyAwakerDataUtils.GetBattleAwakerData(awakerTid) or AwakerDataUtils.GetAwakerData(awakerTid)
  local stateParams = {}
  local parserEnv = {
    talentLevel = level or 1,
    awaker = awakerData
  }
  local attrTalentMap = AwakerDataUtils.GetTalentAttrMap(talentTid, awakerData, level)
  local cmdParser = BattleCmdParserClient(parserEnv)
  table.append(stateParams, cmdParser:GetValueByCmdList(talentCfg.TalentEffectPara1 or {}))
  table.append(stateParams, cmdParser:GetValueByCmdList(talentCfg.TalentEffectPara2 or {}))
  desc = SkillUtils.HandleDescArg(desc, stateParams, attrTalentMap, true)
  return desc
end

function SkillUtils.HandleDescArg(desc, stateParams, attrTalentMap, withoutCeil, wrapperType)
  local wrapper = wrapperType and "%b" .. wrapperType or "%b[]"
  for gainStr in string.gmatch(desc, wrapper) do
    gainStr = string.sub(gainStr, 2, #gainStr - 1)
    local replaceStr
    if string.find(gainStr, "Arg") then
      local index = string.sub(gainStr, #"Arg" + 1, -1)
      if nil ~= index and not stateParams[tonumber(index)] then
        Logger.Error("描述参数和实际不匹配:%s 找不到对应值 %s", gainStr, desc)
      end
      if nil ~= index and stateParams[tonumber(index)] then
        local showVal = stateParams[tonumber(index)]
        local prefixChar = string.sub(showVal, 1, 1)
        if StrUtils.prefixSymbolFuncMap[prefixChar] then
          replaceStr = SkillUtils.HandleNumberWithPrefixSymbol(showVal)
        else
          replaceStr = withoutCeil and stateParams[tonumber(index)] or math.ceil(stateParams[tonumber(index)])
        end
      end
    elseif attrTalentMap and attrTalentMap[gainStr] then
      replaceStr = attrTalentMap[gainStr]
    end
    if replaceStr then
      desc = string.gsub(desc, wrapper, replaceStr or "0", 1)
    end
  end
  return desc
end

function SkillUtils.GetAwakerSkillDesc(awakerData, skillId, skillLevel, skillArgs, card, stateList, isSuper, useBattleDesc)
  if not awakerData then
    return
  end
  local skillCfg = DT.Skill[skillId]
  if not skillCfg then
    return ""
  end
  local breakSkillLevel, potency = SkillUtils.GetAwakerSkillTQLevels(awakerData)
  local skillDesc
  local params = {
    breakSkillLevel = breakSkillLevel,
    potencyLevel = potency,
    skillId = skillId,
    awaker = awakerData
  }
  if not isSuper then
    skillDesc = BattleSkillUtils.GetSkillDesc(skillCfg, breakSkillLevel, potency, params)
  else
    skillDesc = BattleSkillUtils.GetOverLimitUtlSkillDesc(skillCfg, breakSkillLevel, potency, params)
  end
  local skillType = BattleSkillUtils.GetSkillType(skillCfg, breakSkillLevel, potency)
  local SceneMgr = require("Managers.Scene.SceneMgr")
  local inBattle = true == useBattleDesc or false ~= useBattleDesc and (SceneMgr.Instance and SceneMgr.Instance:IsInCopies() or bg.battleScene)
  if inBattle then
    if not isSuper then
      skillDesc = BattleSkillUtils.GetSkillBattleDesc(skillCfg, breakSkillLevel, potency, params) or skillDesc
    else
      skillDesc = BattleSkillUtils.GetOverLimitUtlSkillDesc(skillCfg, breakSkillLevel, potency, params)
    end
  end
  if not skillDesc then
    return ""
  end
  local parserEnv = {
    skillId = skillId,
    skillLevel = skillLevel,
    breakSkillLevel = breakSkillLevel,
    potencyLevel = potency,
    awaker = awakerData,
    card = card
  }
  local cmdParser = BattleCmdParserClient(parserEnv)
  parserEnv.existStateLayerMap = SkillUtils.BuildExistStateLayerMap(skillCfg, breakSkillLevel, potency, cmdParser)
  local desc = SkillUtils.FillAwakerSkillDesc(cmdParser, skillDesc, skillArgs)
  local ignoreStateDesc = card and card.ignoreStateDesc
  if not ignoreStateDesc then
    if skillType and skillType[1] and not string.find(skillType[1], "Card") then
      desc = SkillUtils.__AppendSkillStateDesc(awakerData, skillId, skillLevel, desc, cmdParser)
    else
      desc = SkillUtils.__ApendCardStateDesc(awakerData, skillId, skillLevel, desc, card, cmdParser, stateList)
    end
  end
  return desc
end

function SkillUtils.GetSkillDescStateInfoList(awakerData, skillId, skillLevel)
  local stateInfoList = {}
  local skillCfg = DT.Skill[skillId]
  local SceneMgr = require("Managers.Scene.SceneMgr")
  local inCopyOrBattle = SceneMgr.Instance and SceneMgr.Instance:IsInCopies() or bg.battleScene
  if inCopyOrBattle and not bg.isPVP and skillCfg.Type[1] == bc.SkillType.Ulti_Skill then
    local runtimeList = {}
    if bg.battleScene then
      runtimeList = bg.battleDataCenter.stateData:GetStateListByOwner(awakerData.uid)
    elseif awakerData and awakerData.uid then
      runtimeList = StateDataUtils.GetStateListByOwner(awakerData.uid)
    end
    local stateList = SkillUtils.MergeCardExistAndRuntimeStates(awakerData, skillId, skillLevel, runtimeList, nil) or {}
    local parserEnv = {
      awaker = awakerData,
      skillId = skillId,
      skillLevel = skillLevel
    }
    local cmdParser = BattleCmdParserClient(parserEnv)
    for _, state in ipairs(stateList) do
      local stateCfg = DT.State[state.stateId]
      if not stateCfg then
      elseif stateCfg.ShowType ~= CommonDefine.StateShowType.Describe and stateCfg.ShowType ~= CommonDefine.StateShowType.Affix then
      else
        cmdParser:SetParserEnv("state", state)
        if stateCfg.ShowJudgement and not cmdParser:GetValueByCmd(stateCfg.ShowJudgement) then
        else
          local icon
          if stateCfg.Icon ~= nil then
            icon = bc.ICON_PATH_PERFIX .. stateCfg.Icon
          end
          local name, desc
          if bg.battleScene and state.stateUid then
            local stateDataClient = BattleStateDataClient(state, true)
            name = stateDataClient:GetBuffName()
            desc = stateDataClient:GetDesc()
          else
            local stateCompute = OuterStateCompute(state.stateId, awakerData, state.layer or 1, state.stateParams, state, nil, skillId)
            desc = stateCompute:GetDesc()
            name = stateCompute:GetBuffName()
          end
          local stateInfo = {
            stateId = state.stateId,
            icon = icon,
            name = name,
            desc = desc
          }
          table.insert(stateInfoList, stateInfo)
        end
      end
    end
  else
    stateInfoList = SkillUtils.GetSkillExistStateInfo(awakerData, skillId, skillLevel) or {}
  end
  table.sort(stateInfoList, function(a, b)
    local aCfg = DT.State[a.stateId]
    local bCfg = DT.State[b.stateId]
    local aSort = aCfg.ShowSortOrder or 0
    local bSort = bCfg.ShowSortOrder or 0
    if aSort ~= bSort then
      return aSort > bSort
    end
    return aCfg.BaseSortID > bCfg.BaseSortID
  end)
  return stateInfoList
end

function SkillUtils.__AppendSkillStateDesc(awakerData, skillId, skillLevel, desc, cmdParser)
  local stateInfoList = SkillUtils.GetSkillDescStateInfoList(awakerData, skillId, skillLevel)
  for _, stateInfo in ipairs(stateInfoList) do
    local stateCfg = DT.State[stateInfo.stateId]
    if stateCfg.ShowType == CommonDefine.StateShowType.Describe then
      desc = SkillUtils.AppendStateShowNameToDesc(desc, stateInfo.name)
    end
  end
  return desc
end

function SkillUtils.ShouldSkipDescribeStateByDescArg(stateCfg, baseArgs)
  if stateCfg.ShowType ~= CommonDefine.StateShowType.Describe then
    return false
  end
  if not stateCfg.DescPara or not next(stateCfg.DescPara) then
    return false
  end
  return 0 == (baseArgs.DescArg1 or 0)
end

function SkillUtils.AppendStateShowNameToDesc(desc, name)
  if not name then
    return desc
  end
  local showName = StrUtils.ClearRichText(name)
  if nil == showName or "" == showName then
    return desc
  end
  if LangTable.NeedJoinSpaceBetweenDesc() then
    do return LangTable.JoinWesternDescSegment, desc, StrUtils.ToWesternNoBreakNameText(name) end
    return LangTable.JoinWesternDescSegment, desc, StrUtils.ToWesternNoBreakNameText(name)
  end
  do return string.format, "%s%s%s", desc, name, LT.Text("Dot") end
  return string.format, "%s%s%s", desc, name, LT.Text("Dot")
end

function SkillUtils.ResolveCardStateShowName(stateData, stateCfg, awakerData, card, skillId)
  if not (stateData and stateCfg) or not card then
    return nil
  end
  local runtimeState
  if card.uid then
    for _, state in ipairs(StateDataUtils.GetStateListByOwner(card.uid) or {}) do
      if state.stateId == stateData.stateId then
        runtimeState = state
        break
      end
    end
  end
  local layer = runtimeState and runtimeState.layer or stateData.layer or 1
  local stateCompute = OuterStateCompute(stateData.stateId, awakerData, layer, nil, runtimeState or stateData, card, skillId)
  if not stateCompute:ShowJudgement() then
    return nil
  end
  if SkillUtils.ShouldSkipDescribeStateByDescArg(stateCfg, stateCompute:GetBaseArgs()) then
    return nil
  end
  do return stateCompute.GetBuffName end
  return stateCompute.GetBuffName, stateCompute, stateCompute:GetBaseArgs()
end

function SkillUtils.MergeCardExistAndRuntimeStates(awakerData, skillId, skillLevel, runtimeStateList, card)
  local mergedMap = {}
  local mergedOrder = {}
  local existList = SkillUtils.GetSkillExistStateInfo(awakerData, skillId, skillLevel, card) or {}
  for _, stateInfo in ipairs(existList) do
    local stateId = stateInfo.stateId
    if stateId and not mergedMap[stateId] then
      mergedMap[stateId] = stateInfo
      table.insert(mergedOrder, stateId)
    end
  end
  for _, stateData in ipairs(runtimeStateList or {}) do
    local stateId = stateData.stateId
    if not stateId then
    elseif mergedMap[stateId] then
      for k, v in pairs(stateData) do
        mergedMap[stateId][k] = v
      end
    else
      mergedMap[stateId] = stateData
      table.insert(mergedOrder, stateId)
    end
  end
  local result = {}
  for _, stateId in ipairs(mergedOrder) do
    table.insert(result, mergedMap[stateId])
  end
  return result
end

function SkillUtils.IsCardMatchingSkill(card, skillId)
  if not card then
    return false
  end
  if not skillId then
    return true
  end
  local cardSkillId = card.configId or card.tid
  return cardSkillId == skillId
end

function SkillUtils.__ApendCardStateDesc(awakerData, skillId, skillLevel, desc, card, cmdParser, stateList)
  local stateDataList = {}
  local useCardRuntime = SkillUtils.IsCardMatchingSkill(card, skillId)
  if bg.battleData and bg.battleData.isMock and bg.battleScene then
    if useCardRuntime then
      stateDataList = bg.battleDataCenter:GetCardStateList(card.uid)
    else
      stateDataList = SkillUtils.GetSkillExistStateInfo(awakerData, skillId, skillLevel, card) or {}
    end
    if bg.isPVP_TRAIN then
      stateDataList = SkillUtils.GetSkillExistStateInfo(awakerData, skillId, skillLevel) or {}
    end
  elseif not (WorldStageManager.Instance:IsInStage() and useCardRuntime) or bg.isPVP_TRAIN then
    if not stateList then
      stateDataList = SkillUtils.GetSkillExistStateInfo(awakerData, skillId, skillLevel, card) or {}
    end
    if stateList and #stateList > 0 then
      for _, state in ipairs(stateList or {}) do
        local stateCfg = type(state.stateId) == "number" and DT.State[state.stateId]
        if stateCfg then
          local stateCompute = OuterStateCompute(state.stateId, awakerData, state.layer, state.stateParams, state)
          local desc = stateCompute:GetDesc()
          local name = stateCompute:GetBuffName()
          local icon
          if stateCfg.Icon ~= nil then
            icon = bc.ICON_PATH_PERFIX .. stateCfg.Icon
          end
          if stateCompute:ShowJudgement() then
            local stateInfo = {
              stateId = state.stateId,
              icon = icon,
              name = name,
              desc = desc,
              source = state.source
            }
            table.insert(stateDataList, stateInfo)
          end
        end
      end
    end
  elseif bg.battleScene and useCardRuntime then
    stateDataList = bg.battleDataCenter:GetCardStateList(card.uid)
  elseif WorldStageManager.Instance:IsInStage() and useCardRuntime then
    local runtimeStateList = table.clone(StateDataUtils.GetStateListByOwner(card.uid) or {})
    if card.composeCardUids then
      for _, uid in ipairs(card.composeCardUids) do
        table.append(runtimeStateList, StateDataUtils.GetStateListByOwner(uid) or {})
      end
    end
    stateDataList = SkillUtils.MergeCardExistAndRuntimeStates(awakerData, skillId, skillLevel, runtimeStateList, card)
  end
  for i = 1, #stateDataList do
    if not DT.State[stateDataList[i].stateId] then
      Logger.LogError("SkillUtils.__ApendCardStateDesc: DT.State is nil for stateId = " .. tostring(stateDataList[i].stateId))
    end
  end
  table.sort(stateDataList, function(a, b)
    local aCfg = DT.State[a.stateId]
    local bCfg = DT.State[b.stateId]
    if not aCfg or not bCfg then
      if aCfg ~= bCfg then
        return nil ~= aCfg
      end
      return false
    end
    local aSort = aCfg.ShowSortOrder or 0
    local bSort = bCfg.ShowSortOrder or 0
    if aSort ~= bSort then
      return aSort > bSort
    end
    return aCfg.BaseSortID > bCfg.BaseSortID
  end)
  local usedStates = {}
  for _, stateData in ipairs(stateDataList) do
    if usedStates[stateData.stateId] then
    else
      usedStates[stateData.stateId] = true
      local stateCfg = DT.State[stateData.stateId]
      cmdParser:SetParserEnv("state", stateData)
      if stateCfg.ShowJudgement and not cmdParser:GetValueByCmd(stateCfg.ShowJudgement) then
      elseif stateCfg.ShowType ~= CommonDefine.StateShowType.Normal and stateCfg.ShowType ~= CommonDefine.StateShowType.Describe then
      else
        local name
        if WorldStageManager.Instance:IsInStage() and useCardRuntime then
          name = SkillUtils.ResolveCardStateShowName(stateData, stateCfg, awakerData, card, cmdParser.parserEnv.skillId)
          if not name then
            goto lbl_309
          end
        else
          name = stateData.name or LT.Text(stateCfg.Name)
          if stateData.nameArgs then
            name = CardDataUtils.ReplaceDescArgs(LT.Text(stateCfg.Name), stateData.nameArgs, stateCfg.Name)
          end
        end
        desc = SkillUtils.AppendStateShowNameToDesc(desc, name)
      end
    end
    ::lbl_309::
  end
  return desc
end

function SkillUtils.__GetSkillArgs(cmdParser)
  local skillInfo = cmdParser.parserEnv
  local skillId = skillInfo.skillId
  local skillLevel = skillInfo.level or 1
  local breakSkillLevel = skillInfo.breakSkillLevel or 0
  local potencyLevel = skillInfo.potencyLevel or 0
  local skillPara = skillInfo.skillPara
  local skillCfg = DT.Skill[skillId]
  skillPara = skillPara or BattleSkillUtils.GetSkillPara(skillCfg, breakSkillLevel, potencyLevel)
  local args = cmdParser:GetValueListByCmd(skillPara)
  local finalValues = {}
  for i = 1, 10 do
    finalValues["Arg" .. i] = args[i] or 0
  end
  return finalValues
end

SkillUtils.NonNegativeDescArgTags = {
  Damage = true,
  Block = true,
  Heal = true,
  AttackTimes = true,
  Blood = true,
  Energy = true,
  Poison = true,
  Counterattack = true,
  Bleed = true,
  Exhaustion = true,
  Power = true,
  TentaclePower = true,
  FateCut = true
}

function SkillUtils.__DrillDescBracketToLeaf(gainStr)
  if string.find(gainStr, "[", 2, true) then
    local gainStrExBrackets = string.sub(gainStr, 2, #gainStr - 1)
    for subGainStr in string.gmatch(gainStrExBrackets, "%b[]") do
      return SkillUtils.__DrillDescBracketToLeaf(subGainStr)
    end
  end
  return gainStr
end

function SkillUtils.__ParseDescPlaceholderLeaf(gainStr)
  local leaf = SkillUtils.__DrillDescBracketToLeaf(gainStr)
  local inner = string.sub(leaf, 2, #leaf - 1)
  local subStrs = string.split(inner, ":")
  local firstStr, secondStr = subStrs[1], subStrs[2]
  local tagStr = secondStr and firstStr or nil
  local nameKey = subStrs[#subStrs]
  local argNumStr = nameKey and nameKey:match("^Arg(%d+)$")
  return {
    leaf = leaf,
    tagStr = tagStr,
    name = nameKey,
    argNum = argNumStr and tonumber(argNumStr) or nil
  }
end

function SkillUtils.ParseCnDescSlots(cnDesc)
  local slots = {}
  for gainStr in string.gmatch(cnDesc, "%b[]") do
    table.insert(slots, SkillUtils.__ParseDescPlaceholderLeaf(gainStr))
  end
  return slots
end

function SkillUtils.CollectDescLeafPlaceholders(desc)
  local holders = {}
  local collectFunc
  
  function collectFunc(gainStr)
    if string.find(gainStr, "[", 2, true) then
      local gainStrExBrackets = string.sub(gainStr, 2, #gainStr - 1)
      for subGainStr in string.gmatch(gainStrExBrackets, "%b[]") do
        collectFunc(subGainStr)
      end
      return
    end
    table.insert(holders, gainStr)
  end
  
  for gainStr in string.gmatch(desc, "%b[]") do
    collectFunc(gainStr)
  end
  return holders
end

function SkillUtils.CollectDescArgPlaceholders(desc)
  local holders = {}
  for _, leaf in ipairs(SkillUtils.CollectDescLeafPlaceholders(desc)) do
    local slot = SkillUtils.__ParseDescPlaceholderLeaf(leaf)
    if slot.argNum then
      table.insert(holders, leaf)
    end
  end
  return holders
end

function SkillUtils.__LeafMatchesDescSlot(leafHolder, slot)
  local leafSlot = SkillUtils.__ParseDescPlaceholderLeaf(leafHolder)
  if slot.argNum and leafSlot.argNum == slot.argNum then
    return true
  end
  if not slot.argNum and slot.name and leafSlot.name == slot.name then
    return true
  end
  return false
end

function SkillUtils.__FindTranslatedLeafHolder(transLeaves, slot, index)
  local candidate = transLeaves[index]
  if candidate and SkillUtils.__LeafMatchesDescSlot(candidate, slot) then
    return candidate
  end
  for _, leafHolder in ipairs(transLeaves) do
    if SkillUtils.__LeafMatchesDescSlot(leafHolder, slot) then
      return leafHolder
    end
  end
  return nil
end

function SkillUtils.ReplaceDescArgPlaceholders(translatedDesc, slots, replaceParam)
  local transLeaves = SkillUtils.CollectDescLeafPlaceholders(translatedDesc)
  for index, slot in ipairs(slots) do
    local replaceValue = replaceParam[index]
    if nil == replaceValue then
      break
    end
    local holder = SkillUtils.__FindTranslatedLeafHolder(transLeaves, slot, index)
    if not holder then
      Logger.Warn(string.format("ReplaceDescArgPlaceholders: 译文占位符不足 desc=%s slotIndex=%d name=%s", translatedDesc, index, slot.name or ""))
      break
    end
    replaceValue = tostring(replaceValue)
    translatedDesc = string.replace(translatedDesc, holder, replaceValue, true)
    translatedDesc = StrUtils.ReplaceWesternParamBoundarySpace(translatedDesc, replaceValue)
  end
  return translatedDesc
end

function SkillUtils.BuildDescArgsReplaceParam(slots, curValues)
  local replaceParam = {}
  for index, slot in ipairs(slots) do
    local curValue = curValues[index] or 0
    if slot.tagStr ~= "Float" then
      curValue = math.ceil(curValue)
    end
    replaceParam[index] = SkillUtils.FormatDescArgShowValue(slot.tagStr, curValue)
  end
  return replaceParam
end

function SkillUtils.FormatDescArgShowValue(tagStr, value)
  if tagStr and SkillUtils.NonNegativeDescArgTags[tagStr] then
    do return math.max, 0 end
    return math.max, 0, value
  end
  return value
end

function SkillUtils.GetShowValue(cmdParser, prefix, value, paraPlusName)
  if "Damage" == prefix then
    do return cmdParser.__GetShowDamage, cmdParser, value end
    return cmdParser.__GetShowDamage, cmdParser, value, paraPlusName
  end
  if "Block" == prefix then
    do return cmdParser.__GetShowBlock, cmdParser, value end
    return cmdParser.__GetShowBlock, cmdParser, value, paraPlusName
  end
  if "Heal" == prefix then
    do return cmdParser.__GetShowHeal, cmdParser, value end
    return cmdParser.__GetShowHeal, cmdParser, value, paraPlusName
  end
  if "AttackTimes" == prefix then
    do return cmdParser.__GetAttackTimes, cmdParser end
    return cmdParser.__GetAttackTimes, cmdParser, value, paraPlusName
  end
  if "Blood" == prefix then
    cmdParser:SetMemberValue("DynamicScarleBlood", value)
    do return cmdParser.GetValueByCmd, cmdParser end
    return cmdParser.GetValueByCmd, cmdParser, "SetScarletBloodFormula", value
  end
  if "Energy" == prefix then
    do return cmdParser.__GetShowUltiEnergy, cmdParser end
    return cmdParser.__GetShowUltiEnergy, cmdParser, value, value
  end
  if "Poison" == prefix then
    do return cmdParser.__GetShowPoison, cmdParser end
    return cmdParser.__GetShowPoison, cmdParser, value, value
  end
  if "Counterattack" == prefix then
    do return cmdParser.__GetShowCounterattack, cmdParser end
    return cmdParser.__GetShowCounterattack, cmdParser, value, value
  end
  if "Bleed" == prefix then
    do return cmdParser.__GetShowBleed, cmdParser end
    return cmdParser.__GetShowBleed, cmdParser, value, value
  end
  if "Exhaustion" == prefix then
    do return cmdParser.__GetShowExhaustion, cmdParser end
    return cmdParser.__GetShowExhaustion, cmdParser, value, value
  end
  if "Power" == prefix then
    do return cmdParser.__GetShowPower, cmdParser end
    return cmdParser.__GetShowPower, cmdParser, value, value
  end
  if "TentaclePower" == prefix then
    do return cmdParser.__GetShowTentaclePower, cmdParser end
    return cmdParser.__GetShowTentaclePower, cmdParser, value, value
  end
  if "FateCut" == prefix then
    do return cmdParser.__GetShowFateCut, cmdParser end
    return cmdParser.__GetShowFateCut, cmdParser, value, value
  end
  return value
end

function SkillUtils.FillAwakerSkillDesc(cmdParser, skillDesc, skillArgs)
  local finalValues
  if not skillArgs or not skillArgs.curValues then
    finalValues = SkillUtils.__GetSkillArgs(cmdParser)
  end
  local langKey = LT.ParseTextCfg(skillDesc)
  local cnDesc = skillDesc
  skillDesc = LT.Text(skillDesc)
  local slots = SkillUtils.ParseCnDescSlots(cnDesc)
  local replaceParam = {}
  for index, slot in ipairs(slots) do
    local replaceStr
    if skillArgs and skillArgs.curValues then
      replaceStr = skillArgs.curValues[index]
    elseif slot.argNum then
      local argName = "Arg" .. slot.argNum
      if not slot.tagStr then
        replaceStr = math.ceil(finalValues[argName])
      else
        local paraPlusName = string.gsub(argName, "Arg", "ParaPlus")
        local v = finalValues[argName] or 0
        if slot.tagStr ~= "Float" then
          v = math.ceil(v)
        end
        replaceStr = SkillUtils.GetShowValue(cmdParser, slot.tagStr, v, paraPlusName)
      end
    else
      replaceStr = "0"
      Logger.Warn(string.format("%s 解析错误 %s", skillDesc, slot.leaf or ""), debug.traceback())
    end
    replaceParam[index] = replaceStr
  end
  skillDesc = SkillUtils.ReplaceDescArgPlaceholders(skillDesc, slots, replaceParam)
  LT.InsertTextAndKey(skillDesc, langKey)
  do return StateDataUtils.ReplacePosAwakerNameText end
  return StateDataUtils.ReplacePosAwakerNameText, skillDesc, langKey, replaceParam, nil, nil, "0", Logger.Warn, string.format("%s 解析错误 %s", skillDesc, slot.leaf or ""), debug.traceback()
end

function SkillUtils.GetExistStateLayerBySkill(awakerData, skillId, skillLevel, stateId, card)
  local skillConfig = DT.Skill[skillId]
  if not skillConfig or not stateId then
    return 1
  end
  local parserEnv = {
    awaker = awakerData,
    skillId = skillId,
    skillLevel = skillLevel,
    card = card
  }
  local cmdParser = BattleCmdParserClient(parserEnv)
  parserEnv.cmdParserClient = cmdParser
  local breakSkillLevel, potencyLevel = SkillUtils.GetAwakerSkillTQLevels(awakerData)
  local existState = BattleSkillUtils.GetSkillExistState(skillConfig, breakSkillLevel, potencyLevel, parserEnv) or {}
  local stateLayerList = BattleSkillUtils.GetSkillStateLayer(skillConfig, breakSkillLevel, potencyLevel) or {}
  local layer = 0
  for i, id in ipairs(existState) do
    if id == stateId then
      layer = layer + SkillUtils.ResolveExistStateLayerValue(cmdParser, stateLayerList[i])
    end
  end
  if layer <= 0 then
    return 1
  end
  return layer
end

function SkillUtils.GetStateDescBySkill(awakerData, skillId, skillLevel, stateId, card)
  local skillConfig = DT.Skill[skillId]
  if not skillConfig then
    return
  end
  local parserEnv = {
    awaker = awakerData,
    skillId = skillId,
    skillLevel = skillLevel,
    card = card
  }
  local cmdParser = BattleCmdParserClient(parserEnv)
  local breakSkillLevel, potencyLevel = SkillUtils.GetAwakerSkillTQLevels(awakerData)
  local statePara = BattleSkillUtils.GetSkillStatePara(skillConfig, breakSkillLevel, potencyLevel)
  local stateParams = cmdParser:GetValueByCmdList(statePara or {})
  local layer = SkillUtils.GetExistStateLayerBySkill(awakerData, skillId, skillLevel, stateId, card)
  local stateCompute = OuterStateCompute(stateId, awakerData, layer, stateParams, nil, card, skillId)
  local desc = stateCompute:GetDesc()
  local name = stateCompute:GetBuffName()
  return desc, name
end

function SkillUtils.GetSkillExistStateInfo(awakerData, skillId, skillLevel, card)
  local stateInfoList = {}
  local skillConfig = DT.Skill[skillId]
  if not skillConfig then
    return stateInfoList
  end
  local parserEnv = {
    awaker = awakerData,
    skillId = skillId,
    skillLevel = skillLevel,
    card = card
  }
  local cmdParser = BattleCmdParserClient(parserEnv)
  parserEnv.cmdParserClient = cmdParser
  local breakSkillLevel, potencyLevel = SkillUtils.GetAwakerSkillTQLevels(awakerData)
  local existState = BattleSkillUtils.GetSkillExistState(skillConfig, breakSkillLevel, potencyLevel, parserEnv) or {}
  local stateLayerList = BattleSkillUtils.GetSkillStateLayer(skillConfig, breakSkillLevel, potencyLevel) or {}
  local statePara = BattleSkillUtils.GetSkillStatePara(skillConfig, breakSkillLevel, potencyLevel)
  local stateParams = cmdParser:GetValueByCmdList(statePara or {})
  local layers = {}
  local uniqueExistState = {}
  local seenState = {}
  for i, stateId in ipairs(existState) do
    local layer = SkillUtils.ResolveExistStateLayerValue(cmdParser, stateLayerList[i])
    layers[stateId] = (layers[stateId] or 0) + layer
    if not seenState[stateId] then
      seenState[stateId] = true
      table.insert(uniqueExistState, stateId)
    end
  end
  for _, stateId in ipairs(uniqueExistState) do
    local stateCfg = DT.State[stateId]
    if not stateCfg then
    else
      local icon
      if stateCfg.Icon ~= nil then
        icon = bc.ICON_PATH_PERFIX .. stateCfg.Icon
      end
      local stateCompute = OuterStateCompute(stateId, awakerData, layers[stateId], stateParams, nil, card, skillId)
      local desc = stateCompute:GetDesc()
      local name = stateCompute:GetBuffName()
      if not stateCompute:ShowJudgement() then
      elseif SkillUtils.ShouldSkipDescribeStateByDescArg(stateCfg, stateCompute:GetBaseArgs()) then
      else
        table.insert(stateInfoList, {
          stateId = stateId,
          icon = icon,
          name = name,
          desc = desc
        })
      end
    end
  end
  return stateInfoList
end

function SkillUtils.GetSkillKeyWordTips(awakerData, skillId, skillLevel)
  local keyWordTips = {}
  local skillConfig = DT.Skill[skillId]
  if not skillConfig then
    return keyWordTips
  end
  local stateInfoList = SkillUtils.GetSkillDescStateInfoList(awakerData, skillId, skillLevel)
  for _, stateInfo in ipairs(stateInfoList) do
    local stateCfg = DT.State[stateInfo.stateId]
    if stateCfg.ShowType ~= CommonDefine.StateShowType.Normal and stateCfg.ShowType ~= CommonDefine.StateShowType.Affix then
    else
      table.insert(keyWordTips, {
        icon = stateInfo.icon,
        name = stateInfo.name,
        desc = stateInfo.desc
      })
    end
  end
  return keyWordTips
end

function SkillUtils.GetKeyWordEffectDescGroup(keyWordTips)
  local descGroup = {}
  descGroup.name = LT.Text("WordItemDesc")
  descGroup.descList = {}
  local tips = keyWordTips
  if tips then
    for _, tip in ipairs(tips) do
      local desc = {}
      desc.icon = tip.icon
      desc.name = LT.Text(tip.name)
      desc.desc = tip.desc
      desc.subDesc = tip.subDesc
      desc.subDescColor = tip.subDescColor
      desc.layerCountList = {}
      table.insert(descGroup.descList, desc)
    end
  end
  return descGroup
end

function SkillUtils.GetSkillPropertyListDesc(skillCfg, awakerData, skillLevel)
  local _, potency = AwakerDataUtils.GetBreakAndPotencyLevel(awakerData)
  local breakSkillLevel = AwakerDataUtils.GetBreakSkillLevel(awakerData)
  local propertyNameText = BattleSkillUtils.GetSkillPropertyNameList(skillCfg, breakSkillLevel, potency)
  propertyNameText = LT.Text(propertyNameText)
  local propertyNameList = string.split(propertyNameText, ",")
  if not propertyNameList then
    return
  end
  local currAgrs = SkillUtils.GetSkillLevelUpArgs(awakerData, skillCfg.ID, skillLevel)
  local propertyNameDescList = {}
  local originArgs = {}
  for i = 1, #propertyNameList do
    local propertyName = propertyNameList[i]
    local originIndex = 0
    for gainStr in string.gmatch(propertyName, "%$GrowValue%d+") do
      local indexStr = string.sub(gainStr, string.find(gainStr, "%d+"))
      originIndex = tonumber(indexStr or 0)
      local replaceStr = SkillUtils.ToPropertyValueDisplayString(currAgrs[originIndex])
      propertyName = string.gsub(propertyName, "%$GrowValue%d+", replaceStr, 1)
    end
    for gainStr in string.gmatch(propertyName, "#GrowValue%d+") do
      local indexStr = string.sub(gainStr, string.find(gainStr, "%d+"))
      originIndex = tonumber(indexStr or 0)
      local replaceStr = SkillUtils.ToPropertyValueDisplayString(currAgrs[originIndex])
      propertyName = string.gsub(propertyName, "#GrowValue%d+", replaceStr, 1)
    end
    for gainStr in string.gmatch(propertyName, "GrowValue%d+") do
      local indexStr = string.sub(gainStr, string.find(gainStr, "%d+"))
      originIndex = tonumber(indexStr or 0)
      local replaceStr = SkillUtils.ToPropertyValueDisplayString(currAgrs[originIndex] * 100)
      replaceStr = replaceStr .. "%%"
      propertyName = string.gsub(propertyName, "GrowValue%d+", replaceStr, 1)
    end
    propertyNameDescList[i] = propertyName
    originArgs[i] = currAgrs[originIndex] or 0
  end
  return propertyNameDescList, originArgs
end

function SkillUtils.ToPropertyValueDisplayString(currValue)
  local replaceStr = string.format("%0.2f", currValue or 0)
  if string.find(replaceStr, "%.") then
    replaceStr = string.gsub(replaceStr, "0+$", "")
    replaceStr = string.gsub(replaceStr, "[%.]$", "")
  end
  return replaceStr
end

function SkillUtils.__GetWeaponBattleDesc(weaponTid, awakerUid)
  local desc = ""
  local weaponConfig = DT.Item[weaponTid]
  if not weaponConfig then
    return desc
  end
  if weaponConfig.State2 then
    for _, stateId in ipairs(weaponConfig.State2) do
      local d = SkillUtils.__GetWeaponBattleDescByStateId(weaponTid, awakerUid, stateId)
      if d then
        return d
      end
    end
  end
  local stateCfg = DT.State[weaponConfig.State1]
  if not stateCfg then
    return desc
  end
  desc = SkillUtils.__GetWeaponBattleDescByStateId(weaponTid, awakerUid, weaponConfig.State1) or desc
  return desc
end

function SkillUtils.__GetWeaponBattleDescByStateId(weaponTid, awakerUid, stateId)
  local weaponConfig = DT.Item[weaponTid]
  if not weaponConfig then
    return
  end
  local stateCfg = DT.State[stateId]
  if not stateCfg then
    return
  end
  local desc = stateCfg.WeaponDesc
  local weaponStates = StateDataUtils.GetStateByIdAndSource(stateId, "Weapon", weaponTid, awakerUid)
  local awaker = AwakerDataUtils.GetAwakerDataByUid(awakerUid)
  if bg.battleScene then
    weaponStates = bg.battleDataCenter.stateData:GetStateByIdAndSource(stateId, "Weapon", weaponTid, awakerUid)
    awaker = bg.battleScene:GetAwakerByUid(awakerUid)
  end
  if not awaker and not bg.battleScene then
    local battleAwakerMap = DataCenter.copiesData and DataCenter.copiesData.battleAwakerMap
    if battleAwakerMap then
      for _, bAwaker in pairs(battleAwakerMap) do
        if bAwaker.uid == awakerUid then
          awaker = bAwaker
          break
        end
      end
    end
  end
  if not weaponStates or next(weaponStates) == nil then
    return
  end
  local state = weaponStates[1]
  local parserEnv = {state = state, awaker = awaker}
  local cmdParser = BattleCmdParserClient(parserEnv)
  if stateCfg.ShowJudgement and not cmdParser:GetValueByCmd(stateCfg.ShowJudgement) then
    return
  end
  desc = LT.Text(desc)
  local curValues = state.descArgs and state.descArgs.curValues or {}
  local i = 1
  if bg.battleScene then
    for _ in string.gmatch(desc, "%b[]") do
      local replaceStr = curValues[i] or 0
      desc = string.gsub(desc, "%b[]", replaceStr or "0", 1)
      i = i + 1
    end
  else
    for _ in string.gmatch(desc, "%b[]") do
      local gainStr = string.sub(desc:match("%b[]"), 2, -2)
      local subStrs = string.split(gainStr, ":")
      local tagStr = #subStrs > 1 and subStrs[1] or nil
      local value = curValues[i] or 0
      if "string" == type(value) then
        value = tonumber(value) or 0
      end
      if "Float" ~= tagStr then
        value = math.ceil(value)
      end
      value = SkillUtils.GetShowValue(cmdParser, tagStr, value)
      local replaceStr = ItemDataUtils.RemoveDotZero(value)
      desc = string.gsub(desc, "%b[]", replaceStr or "0", 1)
      i = i + 1
    end
  end
  return desc
end

function SkillUtils.__GetWeaponDesc(weaponTid, weaponLevel)
  local weaponConfig = DT.Item[weaponTid]
  if not weaponConfig then
    return ""
  end
  local state = DT.State[weaponConfig.State1]
  if not state then
    return ""
  end
  local desc = state.Desc
  if not desc then
    return ""
  end
  desc = LT.Text(desc)
  local RefineSkillLevel = DT.GetConstant("WeaponRefineSkillParaNum")
  weaponLevel = math.min(weaponLevel or 0, RefineSkillLevel)
  local parserEnv = {}
  local cmdParser = BattleCmdParserClient(parserEnv)
  cmdParser:SetMemberValue("RefiningLevel", weaponLevel)
  local stateParams = {}
  for _, valueStr in ipairs(weaponConfig.StatePara or {}) do
    table.insert(stateParams, cmdParser:GetValueByCmd(valueStr))
  end
  for gainStr in string.gmatch(desc, "%b[]") do
    gainStr = string.sub(gainStr, 2, #gainStr - 1)
    local subStrs = string.split(gainStr, ":")
    local tagStr = #subStrs > 1 and subStrs[1] or nil
    local argPart = subStrs[#subStrs]
    local replaceStr
    local value = 0
    local startPos = string.find(argPart, "StateArg")
    if startPos then
      local index = string.sub(argPart, startPos + #"StateArg", -1)
      if nil ~= index then
        value = stateParams[tonumber(index)] or 0
      end
    else
      value = tonumber(argPart) or 0
    end
    local keepDecimal = "Float" == tagStr or nil == tagStr and 0 ~= value % 1
    if not keepDecimal then
      value = math.ceil(value)
    end
    value = SkillUtils.GetShowValue(cmdParser, tagStr, value)
    if keepDecimal then
      replaceStr = SkillUtils.ToPropertyValueDisplayString(value)
    else
      replaceStr = ItemDataUtils.RemoveDotZero(value)
    end
    desc = string.gsub(desc, "%b[]", replaceStr or "0", 1)
  end
  return desc
end

function SkillUtils.GetWeaponStateDesc(weaponTid, weaponLevel, inBattle, awakerUid)
  local isMock = bg.battleData and bg.battleData.isMock
  if inBattle and not isMock then
    local desc = SkillUtils.__GetWeaponBattleDesc(weaponTid, awakerUid)
    if not desc or 0 == #desc then
      desc = SkillUtils.__GetWeaponDesc(weaponTid, weaponLevel)
    end
    return desc
  else
    do return SkillUtils.__GetWeaponDesc, weaponTid end
    return SkillUtils.__GetWeaponDesc, weaponTid, weaponLevel, weaponLevel
  end
end

function SkillUtils.GetEnchantDesc(enchantId, stageTid)
  local cmdParser = BattleCmdParserClient({})
  local enchantCfg = DT.EnchantConfig[enchantId]
  if not enchantCfg then
    return ""
  end
  if stageTid then
    cmdParser:SetMemberValue(CommonDefine.OutsideStageMemberField, stageTid)
  end
  local desc = enchantCfg.Desc
  local SceneMgr = require("Managers.Scene.SceneMgr")
  desc = (SceneMgr.Instance and SceneMgr.Instance:IsInCopies() or bg.battleScene) and enchantCfg.BattleDesc or desc
  local params = {}
  for _, valueStr in ipairs(enchantCfg.StatePara or {}) do
    table.insert(params, cmdParser:GetValueByCmd(valueStr))
  end
  if not desc then
    return ""
  end
  desc = LT.Text(desc)
  for i = 1, 10 do
    if params[i] then
      desc = string.replace(desc, string.format("[Arg%s]", i), params[i] or 0, true)
    end
  end
  cmdParser:SetMemberValue(CommonDefine.OutsideStageMemberField, nil)
  return desc
end

function SkillUtils.HandleNumberWithPrefixSymbol(str)
  local rst = str
  local prefixChar = string.sub(str, 1, 1)
  print("HandleNumberWithPrefixSymbol called, str:", str, "prefixChar:", prefixChar)
  if StrUtils.prefixSymbolFuncMap[prefixChar] then
    local remainingStr = string.sub(str, 2)
    print("Using prefixSymbolFuncMap for prefixChar:", prefixChar, "remainingStr:", remainingStr)
    rst = StrUtils.prefixSymbolFuncMap[prefixChar](remainingStr)
    print("Result after prefix function:", rst)
  end
  return rst
end

return SkillUtils
