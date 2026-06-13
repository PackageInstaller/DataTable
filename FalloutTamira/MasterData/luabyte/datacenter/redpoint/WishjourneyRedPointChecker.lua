--远征红点
local M = BaseClass("WishjourneyRedPointChecker", require("DataCenter.RedPoint.BaseRedPointChecker"))

function M:__init()
    self.dataCenterId = {EGetterID.OtakuData}    
end

function M:Check()
    self.checkResult = OtakuRedPointMgr.SurveyFinish() and 1 or 0
end

return M
