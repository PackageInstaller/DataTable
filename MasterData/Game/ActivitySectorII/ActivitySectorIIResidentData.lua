local base = require("Game.ActivitySectorII.ActivitySectorIIData")
local ActivitySectorIIResidentData = class("ActivitySectorIIResidentData", base)

function ActivitySectorIIResidentData:InitActSctIIResidentData(sectorId, autoSelectStageCfg)
  self:GenAWSectorDatas(sectorId)
  self._autoSelectStageCfg = autoSelectStageCfg
end

function ActivitySectorIIResidentData:GetActSctIIDataAutoSelectStage()
  return self._autoSelectStageCfg
end

function ActivitySectorIIResidentData:IsActivityRunning()
  return true
end

function ActivitySectorIIResidentData:RefreshSectorIIReddot4Avg()
end

function ActivitySectorIIResidentData:GetSectorII_UnlockedBuffList()
  return table.emptytable
end

return ActivitySectorIIResidentData
