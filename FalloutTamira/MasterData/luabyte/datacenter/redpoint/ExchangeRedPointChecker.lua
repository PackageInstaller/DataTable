local ExchangeRedPointChecker = BaseClass("ExchangeRedPointChecker",require("DataCenter.RedPoint.BaseRedPointChecker"))
local M = ExchangeRedPointChecker

function M:Check(activityId)
    if not self:OnChanged(activityId) then
        return
    end
    self.checkResult = ActivityHelper.CheckExchangeRedPoint(activityId)
end

return ExchangeRedPointChecker