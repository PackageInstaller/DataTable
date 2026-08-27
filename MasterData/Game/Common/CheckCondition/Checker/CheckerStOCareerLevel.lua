local CheckerStOCareerLevel = {}
local BuildEnum = require("Game.Oasis.Data.BuildingEnum")

function CheckerStOCareerLevel.LengthCheck(param)
  if 2 <= #param then
    return true
  end
  return false
end

function CheckerStOCareerLevel.ParamsCheck(param)
  local level = param[2]
  local target = 0
  for buildId, cfg in pairs(ConfigData.building) do
    if cfg.type == BuildEnum.BuildingType.CareerMaster then
      local buildingData = PlayerDataCenter.AllBuildingData.built[buildId]
      if buildingData ~= nil then
        target = target + buildingData.level or 0
      end
    end
  end
  return level <= target
end

function CheckerStOCareerLevel.GetUnlockInfo(param)
  local level = param[2]
  return string.format(ConfigData:GetTipContent(914), level)
end

return CheckerStOCareerLevel
