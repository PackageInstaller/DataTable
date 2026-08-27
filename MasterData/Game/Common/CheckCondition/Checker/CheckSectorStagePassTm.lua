local CheckSectorStagePassTm = {}
local ExplorationEnum = require("Game.Exploration.ExplorationEnum")

function CheckSectorStagePassTm.LengthCheck(param)
  if 3 <= #param then
    return true
  end
  return false
end

function CheckSectorStagePassTm.ParamsCheck(param)
  local sectorId = param[2]
  local passTime = param[3]
  local ok, outRange = PlayerDataCenter.sectorStage:CheckStagePassTmInRange(sectorId, passTime)
  if ok and not outRange then
    return true
  end
  return false
end

function CheckSectorStagePassTm.GetUnlockInfo(param)
  return ""
end

return CheckSectorStagePassTm
