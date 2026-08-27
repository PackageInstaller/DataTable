local CheckerBuilding = {}

function CheckerBuilding.LengthCheck(param)
  if 3 <= #param then
    return true
  end
  return false
end

function CheckerBuilding.BuildingLevel(num, id, level)
  local ok = false
  local buildingDatas = PlayerDataCenter.AllBuildingData
  local count = 0
  for _, v in pairs(buildingDatas.built) do
    if v.id == id and level <= v.level and v.state ~= proto_object_BuildingState.BuildingStateCreate then
      count = count + 1
      if num <= count then
        ok = true
        break
      end
    end
  end
  return ok
end

function CheckerBuilding.ParamsCheck(param)
  local ok = CheckerBuilding.BuildingLevel(1, param[2], param[3])
  return ok
end

function CheckerBuilding.GetUnlockInfo(param)
  local buildId = param[2]
  local buildLevel = param[3]
  local buildCfg = ConfigData.building[buildId]
  if buildCfg ~= nil then
    return string.format(ConfigData:GetTipContent(912), buildLevel, LanguageUtil.GetLocaleText(buildCfg.name))
  end
  return ""
end

return CheckerBuilding
