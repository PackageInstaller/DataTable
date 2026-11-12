local PenguinCardUtils = {}
PenguinCardUtils.GameState = {
  Start = 0,
  Prepare = 1,
  Dealing = 2,
  Flip = 3,
  Settlement = 4,
  Complete = 5,
  Quest = 6,
  EndlessCheck = 7
}
PenguinCardUtils.SuitName = {
  [GameEnum.PenguinBaseCardSuit.Blue] = "<sprite name=\"icon_PengCard_Water_small\">",
  [GameEnum.PenguinBaseCardSuit.Red] = "<sprite name=\"icon_PengCard_Fire_small\">",
  [GameEnum.PenguinBaseCardSuit.Green] = "<sprite name=\"icon_PengCard_Wind_small\">"
}
PenguinCardUtils.SingleValueEffect = {
  [GameEnum.PenguinCardEffectType.IncreaseBasicChips] = true,
  [GameEnum.PenguinCardEffectType.IncreaseMultiplier] = true,
  [GameEnum.PenguinCardEffectType.MultiMultiplier] = true,
  [GameEnum.PenguinCardEffectType.UpgradeDiscount] = true,
  [GameEnum.PenguinCardEffectType.AddRound] = true,
  [GameEnum.PenguinCardEffectType.AddCardRollCount] = true,
  [GameEnum.PenguinCardEffectType.UpgradeRebate] = true,
  [GameEnum.PenguinCardEffectType.UpgradeDiscountAura] = true,
  [GameEnum.PenguinCardEffectType.CheckRoundAura] = true,
  [GameEnum.PenguinCardEffectType.AddRoundAura] = true,
  [GameEnum.PenguinCardEffectType.AimScoreAura] = true,
  [GameEnum.PenguinCardEffectType.ChangeHp] = true,
  [GameEnum.PenguinCardEffectType.AideScoreAura] = true
}
PenguinCardUtils.GrayColor = "#888888"

function PenguinCardUtils.CheckTriggerLimit(nTriggerLimit, tbTriggerLimitParam, nTriggerCount, nRoundTriggerCount)
  tbTriggerLimitParam = tbTriggerLimitParam or {0, 0}
  nTriggerCount = nTriggerCount or 0
  nRoundTriggerCount = nRoundTriggerCount or 0
  if nTriggerLimit == GameEnum.PenguinCardTriggerLimit.TurnAndRound then
    local nTurnLimit = tbTriggerLimitParam[1] or 0
    local nRoundLimit = tbTriggerLimitParam[2] or 0
    if 0 < nTurnLimit and nTriggerCount >= nTurnLimit then
      return false
    end
    if 0 < nRoundLimit and nRoundTriggerCount >= nRoundLimit then
      return false
    end
    return true
  end
  if nTriggerLimit ~= GameEnum.PenguinCardTriggerLimit.None and nTriggerCount >= tbTriggerLimitParam[1] then
    return false
  end
  return true
end

function PenguinCardUtils.CheckTriggerAble(nTriggerType, tbTriggerParam, nTriggerProbability, mapTriggerSource, nEffectType)
  local randomValue = math.random(0, 100)
  local bAble = false
  if nTriggerType == GameEnum.PenguinCardTriggerType.None then
    bAble = true
  elseif mapTriggerSource then
    if nTriggerType == GameEnum.PenguinCardTriggerType.SuitCards and mapTriggerSource.SuitCards then
      local nAimCount = #tbTriggerParam
      local nHasCount = 0
      for _, nAimSuit in ipairs(tbTriggerParam) do
        for _, nHasSuit in ipairs(mapTriggerSource.SuitCards) do
          if nAimSuit == nHasSuit then
            nHasCount = nHasCount + 1
          end
        end
      end
      if nAimCount <= nHasCount then
        bAble = true
      end
    elseif nTriggerType == GameEnum.PenguinCardTriggerType.SuitCount and mapTriggerSource.SuitCount then
      for k, nAimCount in pairs(tbTriggerParam) do
        if not mapTriggerSource.SuitCount[tonumber(k)] or nAimCount > mapTriggerSource.SuitCount[tonumber(k)] then
          return false
        end
      end
      bAble = true
    elseif nTriggerType == GameEnum.PenguinCardTriggerType.HandRankSuitCount and mapTriggerSource.HandRankSuitCount then
      for k, nAimCount in pairs(tbTriggerParam) do
        if not mapTriggerSource.HandRankSuitCount[tonumber(k)] or nAimCount > mapTriggerSource.HandRankSuitCount[tonumber(k)] then
          return false
        end
      end
      bAble = true
    elseif nTriggerType == GameEnum.PenguinCardTriggerType.BaseCardId and mapTriggerSource.BaseCard then
      for _, v in ipairs(tbTriggerParam) do
        if mapTriggerSource.BaseCard.nId == v then
          bAble = true
          break
        end
      end
      if nEffectType == GameEnum.PenguinCardEffectType.ReplaceBaseCard then
        if mapTriggerSource.BaseCard.bReplaced == true then
          return false
        elseif bAble and nTriggerProbability >= randomValue then
          mapTriggerSource.BaseCard.bReplaced = true
        end
      end
    elseif nTriggerType == GameEnum.PenguinCardTriggerType.RepeatHandRank and mapTriggerSource.HandRankCount and mapTriggerSource.HandRank then
      bAble = false
      for id, count in pairs(mapTriggerSource.HandRankCount) do
        if mapTriggerSource.HandRank == id and 2 <= count then
          bAble = true
          break
        end
      end
    elseif nTriggerType == GameEnum.PenguinCardTriggerType.HandRank and mapTriggerSource.HandRank then
      for _, v in ipairs(tbTriggerParam) do
        if mapTriggerSource.HandRank == v then
          bAble = true
          break
        end
      end
    end
  end
  return bAble and nTriggerProbability >= randomValue
end

function PenguinCardUtils.CheckGrowthLayer(nGrowthTriggerType, tbGrowthTriggerParam, mapTriggerSource)
  local nAdd = 0
  if nGrowthTriggerType == GameEnum.PenguinCardGrowthTriggerType.None then
    nAdd = 1
  elseif nGrowthTriggerType == GameEnum.PenguinCardGrowthTriggerType.HandRank and mapTriggerSource.HandRank then
    for _, v in ipairs(tbGrowthTriggerParam) do
      if mapTriggerSource.HandRank == v then
        nAdd = 1
        break
      end
    end
  elseif nGrowthTriggerType == GameEnum.PenguinCardGrowthTriggerType.LevelCount and mapTriggerSource.PenguinCardLevel then
    nAdd = mapTriggerSource.PenguinCardLevel
  elseif nGrowthTriggerType == GameEnum.PenguinCardGrowthTriggerType.SuitCountInCard and mapTriggerSource.BaseCard then
    local nAimSuit = tbGrowthTriggerParam[1]
    local mapCfg = ConfigTable.GetData("PenguinBaseCard", mapTriggerSource.BaseCard.nId)
    if mapCfg then
      for i = 1, 3 do
        if 0 < mapCfg["Suit" .. i] and 0 < mapCfg["SuitCount" .. i] and nAimSuit == mapCfg["Suit" .. i] then
          nAdd = mapCfg["SuitCount" .. i]
          break
        end
      end
    end
  end
  return nAdd
end

function PenguinCardUtils.JoinAllLevelValue(tbValue, nCurLevel, sSuffix)
  nCurLevel = math.max(1, math.min(nCurLevel, #tbValue))
  sSuffix = sSuffix or ""
  local sPre, sCur, sSuf = "", "", ""
  for i, value in ipairs(tbValue) do
    if i < nCurLevel then
      sPre = sPre .. tostring(value) .. sSuffix .. "/"
    elseif i == nCurLevel then
      sCur = tostring(value) .. sSuffix
    else
      sSuf = sSuf .. "/" .. tostring(value) .. sSuffix
    end
  end
  if sPre ~= "" then
    sPre = string.format("<color=%s>%s</color>", PenguinCardUtils.GrayColor, sPre)
  end
  if sSuf ~= "" then
    sSuf = string.format("<color=%s>%s</color>", PenguinCardUtils.GrayColor, sSuf)
  end
  return sPre .. sCur .. sSuf
end

function PenguinCardUtils.SetEffectDesc(mapCfg, nGrowthLayer)
  local nTriggerType = mapCfg.TriggerType
  local nEffectType = mapCfg.EffectType
  local nGrowthTriggerType = mapCfg.GrowthTriggerType
  nGrowthLayer = nGrowthLayer or 0
  local sError = "<color=#BD3059>Error:Parameter mismatch</color>"
  
  local function ParseTriggerParam(tbParam, nIndex)
    if nTriggerType == GameEnum.PenguinCardTriggerType.SuitCards then
      local nSuit = tbParam[nIndex]
      if nSuit == nil then
        return sError
      end
      return PenguinCardUtils.SuitName[nSuit]
    elseif nTriggerType == GameEnum.PenguinCardTriggerType.BaseCardId then
      local nBaseCardId = tbParam[nIndex]
      if nBaseCardId == nil then
        return sError
      end
      local mapBase = ConfigTable.GetData("PenguinBaseCard", nBaseCardId)
      if mapBase then
        return mapBase.Title
      end
    elseif nTriggerType == GameEnum.PenguinCardTriggerType.SuitCount or nTriggerType == GameEnum.PenguinCardTriggerType.HandRankSuitCount then
      local mapSuit = {}
      for k, v in pairs(tbParam) do
        local nSuit = tonumber(k)
        if nSuit then
          mapSuit[nSuit] = v
        end
      end
      local i = 1
      for nSuit, v in ipairsSorted(mapSuit) do
        if i == nIndex then
          local sName = ""
          for _ = 1, v do
            sName = sName .. PenguinCardUtils.SuitName[nSuit]
          end
          return sName
        end
        i = i + 1
      end
    elseif nTriggerType == GameEnum.PenguinCardTriggerType.HandRank then
      if tbParam[nIndex] == nil then
        return sError
      end
      local mapHandRank = ConfigTable.GetData("PenguinCardHandRank", tbParam[nIndex])
      if mapHandRank then
        return mapHandRank.Title
      end
    end
  end
  
  local function ParseEffectParam(tbParam, nIndex)
    if nEffectType == GameEnum.PenguinCardEffectType.AddBaseCardWeight or nEffectType == GameEnum.PenguinCardEffectType.ReplaceBaseCard then
      local tbId = {}
      for k, _ in pairs(tbParam) do
        local nId = tonumber(k)
        if nId then
          table.insert(tbId, nId)
        end
      end
      table.sort(tbId, function(a, b)
        return a < b
      end)
      local nBaseCardId = tbId[nIndex]
      if nBaseCardId == nil then
        return sError
      end
      local mapBase = ConfigTable.GetData("PenguinBaseCard", nBaseCardId)
      if mapBase then
        return mapBase.Title
      end
    elseif nEffectType == GameEnum.PenguinCardEffectType.RollSpecificCard then
      local nCardId = tbParam[nIndex]
      if nCardId == nil then
        return sError
      end
      local mapCard = ConfigTable.GetData("PenguinCard", nCardId)
      if mapCard then
        return mapCard.Title
      end
    elseif PenguinCardUtils.SingleValueEffect[nEffectType] or nEffectType == GameEnum.PenguinCardEffectType.CardLevel then
      if tbParam[nIndex] == nil then
        return sError
      end
      return math.abs(tbParam[nIndex])
    else
      return ""
    end
  end
  
  local function ParseGrowthTriggerParam(tbParam, nIndex)
    if nGrowthTriggerType == GameEnum.PenguinCardGrowthTriggerType.SuitCountInCard then
      if tbParam[nIndex] == nil then
        return sError
      end
      return PenguinCardUtils.SuitName[tbParam[nIndex]]
    elseif nGrowthTriggerType == GameEnum.PenguinCardGrowthTriggerType.HandRank then
      if tbParam[nIndex] == nil then
        return sError
      end
      local mapHandRank = ConfigTable.GetData("PenguinCardHandRank", tbParam[nIndex])
      if mapHandRank then
        return mapHandRank.Title
      end
    end
  end
  
  local function ParseTotalEffectParam(tbEffectParam, tbGrowthParam, nIndex)
    if PenguinCardUtils.SingleValueEffect[nEffectType] or nEffectType == GameEnum.PenguinCardEffectType.CardLevel then
      if tbEffectParam[nIndex] == nil or tbGrowthParam[nIndex] == nil then
        return sError
      end
      local nValue = tbEffectParam[nIndex] + nGrowthLayer * tbGrowthParam[nIndex]
      if nValue < 0 then
        nValue = 0
      end
      return nValue
    else
      return ""
    end
  end
  
  local function GetAllLevelValue(fnGetValue)
    if mapCfg.GroupId == nil or mapCfg.Level == nil or mapCfg.MaxLevel == nil or mapCfg.MaxLevel <= 1 then
      return nil
    end
    local tbValue = {}
    for nLevel = 1, mapCfg.MaxLevel do
      local mapLevelCfg = ConfigTable.GetData("PenguinCard", mapCfg.GroupId * 100 + nLevel)
      if mapLevelCfg == nil then
        return nil
      end
      local value = fnGetValue(mapLevelCfg)
      if value == nil or value == sError then
        return nil
      end
      tbValue[nLevel] = value
    end
    return tbValue
  end
  
  local function ParseAllToken(sToken, sName)
    local sBody = string.match(sToken, "^{" .. sName .. "_All(.*)}$")
    if sBody == nil then
      return false, nil, nil
    end
    local sSuffix
    local sHead, sTail = string.match(sBody, "^(.-)%((.*)%)$")
    if sHead == nil then
      sHead, sTail = string.match(sBody, "^(.-)（(.*)）$")
    end
    if sHead ~= nil then
      sBody = sHead
      sSuffix = sTail
    end
    local nIdx
    if sBody ~= "" then
      local sIdx = string.match(sBody, "^_(%d+)$")
      if sIdx == nil then
        return false, nil, nil
      end
      nIdx = tonumber(sIdx)
    end
    return true, nIdx, sSuffix
  end
  
  local function AppendSuffix(str, sSuffix)
    if sSuffix == nil or sSuffix == "" or str == nil or str == "" or str == sError then
      return str
    end
    return tostring(str) .. sSuffix
  end
  
  local result = string.gsub(mapCfg.Desc, "%b{}", function(token)
    local content = string.match(token, "^{(.-)}$")
    local sParameterKey, lang, langIdx = ParseLanguageParam(content)
    if lang ~= nil then
      token = string.format("{%s}", sParameterKey)
    end
    if token == "{TriggerProbability}" then
      return mapCfg.TriggerProbability
    elseif token == "{TriggerLimitParam}" then
      local tbLimitParam = mapCfg.TriggerLimitParam
      return tbLimitParam[1] or sError
    elseif token == "{DurationParam}" then
      return mapCfg.DurationParam
    elseif token == "{GrowthLimit}" then
      return mapCfg.GrowthLimit
    elseif token == "{GrowthLayer}" then
      return nGrowthLayer
    end
    local bProbAll, probAllIdx, sProbSuffix = ParseAllToken(token, "TriggerProbability")
    if bProbAll and probAllIdx == nil then
      local tbValue = GetAllLevelValue(function(mapLevelCfg)
        return mapLevelCfg.TriggerProbability
      end)
      if tbValue == nil then
        return AppendSuffix(mapCfg.TriggerProbability, sProbSuffix)
      end
      return PenguinCardUtils.JoinAllLevelValue(tbValue, mapCfg.Level, sProbSuffix)
    end
    local limitIdx = string.match(token, "^{TriggerLimitParam_(%d+)}$")
    if limitIdx then
      local tbLimitParam = mapCfg.TriggerLimitParam
      local str = tbLimitParam[tonumber(limitIdx)] or sError
      str = LanguagePost(lang, langIdx, str)
      return str
    end
    local bLimitAll, limitAllIdx, sLimitSuffix = ParseAllToken(token, "TriggerLimitParam")
    if bLimitAll and limitAllIdx ~= nil then
      local tbValue = GetAllLevelValue(function(mapLevelCfg)
        local tbLevelLimitParam = mapLevelCfg.TriggerLimitParam
        if tbLevelLimitParam == nil then
          return nil
        end
        return tbLevelLimitParam[limitAllIdx]
      end)
      local str
      if tbValue == nil then
        local tbLimitParam = mapCfg.TriggerLimitParam
        str = AppendSuffix(tbLimitParam[limitAllIdx] or sError, sLimitSuffix)
      else
        str = PenguinCardUtils.JoinAllLevelValue(tbValue, mapCfg.Level, sLimitSuffix)
      end
      str = LanguagePost(lang, langIdx, str)
      return str
    end
    local trigIdx = string.match(token, "^{TriggerParam_(%d+)}$")
    if trigIdx then
      local idx = tonumber(trigIdx)
      local str = ParseTriggerParam(decodeJson(mapCfg.TriggerParam), idx)
      str = LanguagePost(lang, langIdx, str)
      return str
    end
    local effectIdx = string.match(token, "^{EffectParam_(%d+)}$")
    if effectIdx then
      local idx = tonumber(effectIdx)
      local str = ParseEffectParam(decodeJson(mapCfg.EffectParam), idx)
      str = LanguagePost(lang, langIdx, str)
      return str
    end
    local bEffectAll, effectAllIdx, sEffectSuffix = ParseAllToken(token, "EffectParam")
    if bEffectAll and effectAllIdx ~= nil then
      local tbValue = GetAllLevelValue(function(mapLevelCfg)
        return ParseEffectParam(decodeJson(mapLevelCfg.EffectParam), effectAllIdx)
      end)
      local str
      if tbValue == nil then
        str = AppendSuffix(ParseEffectParam(decodeJson(mapCfg.EffectParam), effectAllIdx), sEffectSuffix)
      else
        str = PenguinCardUtils.JoinAllLevelValue(tbValue, mapCfg.Level, sEffectSuffix)
      end
      str = LanguagePost(lang, langIdx, str)
      return str
    end
    local trigGrowthIdx = string.match(token, "^{GrowthTriggerParam_(%d+)}$")
    if trigGrowthIdx then
      local idx = tonumber(trigGrowthIdx)
      local str = ParseGrowthTriggerParam(decodeJson(mapCfg.GrowthTriggerParam), idx)
      str = LanguagePost(lang, langIdx, str)
      return str
    end
    local effectGrowthIdx = string.match(token, "^{GrowthEffectParam_(%d+)}$")
    if effectGrowthIdx then
      local idx = tonumber(effectGrowthIdx)
      local str = ParseEffectParam(decodeJson(mapCfg.GrowthEffectParam), idx)
      str = LanguagePost(lang, langIdx, str)
      return str
    end
    local effectTotalIdx = string.match(token, "^{TotalEffectParam_(%d+)}$")
    if effectTotalIdx then
      local idx = tonumber(effectTotalIdx)
      local str = ParseTotalEffectParam(decodeJson(mapCfg.EffectParam), decodeJson(mapCfg.GrowthEffectParam), idx)
      str = LanguagePost(lang, langIdx, str)
      return str
    end
    return token
  end)
  return result
end

function PenguinCardUtils.SetAideAddScoreDesc(tbScore, nLevel)
  local sLevelValue = PenguinCardUtils.JoinAllLevelValue(tbScore, nLevel)
  local sScoreDesc = orderedFormat(ConfigTable.GetUIText("PenguinCard_AideInfo_PassiveDesc"), sLevelValue)
  return sScoreDesc
end

function PenguinCardUtils.WeightedRandom(tbId, tbWeight, n, tbExcludeGroupId, bDuplicate, bAide)
  if #tbId ~= #tbWeight then
    printError("tbId 和 tbWeight 长度必须相同")
  end
  tbExcludeGroupId = tbExcludeGroupId or {}
  local tbExcludeSet = {}
  for _, v in ipairs(tbExcludeGroupId) do
    tbExcludeSet[v] = true
  end
  local tbCandidates = {}
  for i = 1, #tbId do
    local id = tbId[i]
    local w = tbWeight[i]
    if next(tbExcludeSet) == nil then
      table.insert(tbCandidates, {id = id, weight = w})
    elseif bAide then
      if not tbExcludeSet[id] then
        table.insert(tbCandidates, {id = id, weight = w})
      end
    else
      local mapCfg = ConfigTable.GetData("PenguinCard", id)
      if mapCfg and not tbExcludeSet[mapCfg.GroupId] then
        table.insert(tbCandidates, {id = id, weight = w})
      end
    end
  end
  if #tbCandidates == 0 then
    return {}
  end
  local result = {}
  if bDuplicate then
    local totalWeight = 0
    for _, item in ipairs(tbCandidates) do
      totalWeight = totalWeight + item.weight
    end
    for _ = 1, n do
      local r = math.random() * totalWeight
      local cum = 0
      for _, item in ipairs(tbCandidates) do
        cum = cum + item.weight
        if r < cum then
          table.insert(result, item.id)
          break
        end
      end
    end
  else
    local actualN = math.min(n, #tbCandidates)
    for _ = 1, actualN do
      local totalWeight = 0
      for _, item in ipairs(tbCandidates) do
        totalWeight = totalWeight + item.weight
      end
      if totalWeight <= 0 then
        break
      end
      local r = math.random() * totalWeight
      local cum = 0
      for i, item in ipairs(tbCandidates) do
        cum = cum + item.weight
        if r < cum then
          table.insert(result, item.id)
          table.remove(tbCandidates, i)
          break
        end
      end
    end
  end
  return result
end

return PenguinCardUtils
