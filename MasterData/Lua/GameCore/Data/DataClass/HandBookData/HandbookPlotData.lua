local HandbookDataBase = require("GameCore.Data.DataClass.HandBookData.HandbookDataBase")
local HandbookPlotData = class("HandbookPlotData", HandbookDataBase)

function HandbookPlotData:Init()
  self.nPlotId = self:GetId()
end

function HandbookPlotData:GetPlotId()
  return self.nPlotId
end

function HandbookPlotData:GetPlotCfgData()
  local plotCfgData = ConfigTable.GetData("MainScreenCG", self.nPlotId)
  if nil == plotCfgData then
    printError("Get plot data fail!!! id = " .. self.nPlotId)
    return
  end
  return plotCfgData
end

function HandbookPlotData:CheckPlotL2d()
  local config = self:GetPlotCfgData()
  if config == nil then
    return false
  end
  if config.FullScreenL2D == "" then
    return false
  end
  return true
end

return HandbookPlotData
