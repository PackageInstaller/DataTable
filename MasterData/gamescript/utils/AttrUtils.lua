local AttrUtils = {}
AttrUtils.AttrTypeMap = nil
AttrUtils.IncreaseKey = "_per"
AttrUtils.RatioKey = "Initial"

function AttrUtils.InitAttrTypeMap()
  AttrUtils.AttrTypeMap = {}
  for k, v in pairs(DT.ActorAttrType) do
    if not AttrUtils.AttrTypeMap[v.Name] then
      AttrUtils.AttrTypeMap[v.Name] = v.ID
    end
  end
end

function AttrUtils.GetAttrTypeMap()
  return AttrUtils.AttrTypeMap
end

function AttrUtils.GetAttrShowVal(val)
  if 0 == val % 1 then
    do return string.format, "%d" end
    return string.format, "%d", val
  else
    do return tostring end
    return tostring, val, val
  end
end

function AttrUtils.GetAwakerFinalAttr(attrVal, increase)
  if not increase then
    return attrVal
  end
  local result = attrVal * (1 + increase)
  do return math.ceil end
  return math.ceil, result
end

function AttrUtils.GetAwakerPhysique(attrVal, increase, breakRate)
  if not increase then
    return attrVal
  end
  local result = attrVal * (1 + increase) * breakRate
  do return math.ceil end
  return math.ceil, result
end

function AttrUtils.GetAttrConfig(tid)
  if not tid then
    return
  end
  return DT.ActorAttrType[tid]
end

function AttrUtils.GetAttrCfgByField(field, tid)
  local cfg = AttrUtils.GetAttrConfig(tid)
  if not cfg then
    return
  end
  return cfg[field]
end

function AttrUtils.GetAttrDesc(tid)
  local config = AttrUtils.GetAttrConfig(tid)
  if not config then
    return
  end
  do return LT.Text end
  return LT.Text, config.AttributeDesc
end

function AttrUtils.CalAttrDesc(awaker, attrDesc, attrKey, attrTid, addValue)
  addValue = addValue or 0
  if attrTid and DT.ActorAttrType[attrTid] and DT.ActorAttrType[attrTid].AttriDescArg then
    local battleApiKey = DT.ActorAttrType[attrTid].AttriDescArg
    local parserEnv = {awaker = awaker}
    local cmdParser = BattleCmdParserClient(parserEnv)
    local value = cmdParser:GetValueByCmd("Formula_" .. battleApiKey)
    do return LT.Textf, attrDesc end
    return LT.Textf, attrDesc, value, nil, nil
  end
  local attrVal = awaker.attrs[attrKey] or 0
  attrKey = string.gsub(attrKey, AttrUtils.IncreaseKey, "")
  local increase = (awaker.attrs[attrKey .. AttrUtils.IncreaseKey] or 0) / 100
  local val = AttrUtils.GetAwakerFinalAttr(attrVal, increase)
  local awakerCfg = AwakerDataUtils.GetAwakerConfig(awaker.tid) or {}
  local awakerName = LT.Text(awakerCfg.Name)
  if "physique" == attrKey or "physique_per" == attrKey then
    val = AttrUtils.PhysiqueToMaxHp(awaker, val)
  end
  attrDesc = LT.Textf(attrDesc, awakerName, val + addValue)
  return attrDesc
end

function AttrUtils.PhysiqueToMaxHp(awaker, physique)
  local AwakerDataUtils = require("Data.AwakerDataUtils")
  local currBreakthroughStar, _ = AwakerDataUtils.GetBreakAndPotencyLevel(awaker)
  local hpMultipliers = DT.Constant.HpMultiplier.Data
  do return math.ceil end
  return math.ceil, physique * (hpMultipliers[currBreakthroughStar + 1] or 1)
end

function AttrUtils.GetAwakersAccountLvBattleCurve(targetAwakerTidList, awakerLevelDict, playerLevel)
  local awakerTidList = {}
  for _, awakerTid in pairs(targetAwakerTidList or {}) do
    if 0 ~= awakerTid then
      table.insert(awakerTidList, awakerTid)
    end
  end
  playerLevel = playerLevel or PlayerDataUtils.GetLevel()
  if not awakerTidList or 0 == #awakerTidList then
    return playerLevel
  end
  local totalLevel = 0
  local validCount = 0
  for _, awakerTid in pairs(awakerTidList) do
    local awakerLevel = awakerLevelDict and awakerLevelDict[awakerTid]
    if not awakerLevel then
      local awakerData = AwakerDataUtils.GetAwakerData(awakerTid)
      awakerLevel = awakerData and awakerData.level or 0
    end
    totalLevel = totalLevel + awakerLevel
    validCount = validCount + 1
  end
  local averageLevel = math.ceil(totalLevel / 4)
  if playerLevel <= averageLevel then
    do return math.ceil end
    return math.ceil, (averageLevel + playerLevel) / 2, pairs(awakerTidList)
  else
    return playerLevel
  end
end

return AttrUtils
