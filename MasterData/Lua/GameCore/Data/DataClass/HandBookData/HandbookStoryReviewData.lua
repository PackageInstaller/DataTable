local HandbookDataBase = require("GameCore.Data.DataClass.HandBookData.HandbookDataBase")
local HandbookStoryReviewData = class("HandbookStoryReviewData", HandbookDataBase)

function HandbookStoryReviewData:Init()
  self.nStoryReviewId = self:GetId()
end

function HandbookStoryReviewData:GetPlotId()
  return self.nStoryReviewId
end

function HandbookStoryReviewData:GetPlotCfgData()
  local plotCfgData = ConfigTable.GetData("MainScreenCG", self.nStoryReviewId)
  if nil == plotCfgData then
    printError("Get plot data fail!!! id = " .. self.nStoryReviewId)
    return
  end
  return plotCfgData
end

function HandbookStoryReviewData:CheckPlotL2d()
  local config = self:GetPlotCfgData()
  if config == nil then
    return false
  end
  if config.FullScreenL2D == "" then
    return false
  end
  return true
end

return HandbookStoryReviewData
