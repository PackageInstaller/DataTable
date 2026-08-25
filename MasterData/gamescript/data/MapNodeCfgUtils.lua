local MapNodeCfgUtils = {}

function MapNodeCfgUtils.GetCfg(mapNodeTid)
  if not mapNodeTid then
    return nil
  end
  return DT.MapNode[mapNodeTid]
end

function MapNodeCfgUtils.GetCfgField(field, cfgTid)
  local cfg = MapNodeCfgUtils.GetCfg(cfgTid)
  if not cfg then
    return
  end
  return cfg[field]
end

function MapNodeCfgUtils.ParseEffectField(mapNodeTid)
  local mapNodeCfg = MapNodeCfgUtils.GetCfg(mapNodeTid)
  local nodeType = mapNodeCfg.NodeType
  local parseFunc = MapNodeCfgUtils.MapNodeTypeTid2EffectFieldParseFuncDict[nodeType]
  if not parseFunc then
    return nil
  end
  do return parseFunc end
  return parseFunc, mapNodeCfg.Effect2
end

function MapNodeCfgUtils.ParseSpecialShopEffectField(fieldEffect)
  if not fieldEffect then
    return {}
  end
  local stringList = StrUtils.SplitMapNodeCfgEffect2Field(fieldEffect)
  return {
    refreshType = stringList[2],
    customTitleLang = stringList[7],
    customIcon = stringList[8],
    customLimit = tonumber(fieldEffect[9] or "1")
  }
end

MapNodeCfgUtils.MapNodeTypeTid2EffectFieldParseFuncDict = {
  [DT.GetConstant("SpecialShopMapNodeType")] = MapNodeCfgUtils.ParseSpecialShopEffectField
}
return MapNodeCfgUtils
