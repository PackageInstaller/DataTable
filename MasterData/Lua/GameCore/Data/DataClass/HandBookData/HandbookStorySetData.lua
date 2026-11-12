local HandbookDataBase = require("GameCore.Data.DataClass.HandBookData.HandbookDataBase")
local HandbookStorySetData = class("HandbookStorySetData", HandbookDataBase)

function HandbookStorySetData:Init()
  self.nStorySetId = self:GetId()
end

function HandbookStorySetData:GetPlotId()
  return self.nStorySetId
end

function HandbookStorySetData:GetPlotCfgData()
  local plotCfgData = ConfigTable.GetData("MainScreenCG", self.nStorySetId)
  if nil == plotCfgData then
    printError("Get plot data fail!!! id = " .. self.nStorySetId)
    return
  end
  return plotCfgData
end

function HandbookStorySetData:CheckPlotL2d()
  local config = self:GetPlotCfgData()
  if config == nil then
    return false
  end
  if config.FullScreenL2D == "" then
    return false
  end
  return true
end

return HandbookStorySetData
