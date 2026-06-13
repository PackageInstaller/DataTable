local ThreeDayLoginAwardChecker = BaseClass("ThreeDayLoginAwardChecker",require("DataCenter.RedPoint.BaseRedPointChecker"))
local M = ThreeDayLoginAwardChecker

function M:Check()
    Logger.Log("请小伙伴实现【三日奖励】红点功能")
    self.checkResult = 0
end

return ThreeDayLoginAwardChecker