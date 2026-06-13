local baseClass = require("DataCenter.Cycle.BaseCycleData")
local M = BaseClass("ActivityWeeklyData", baseClass)

function M:__init()
    -- body
    self.m_cycleType = protocol.ECycleEvent.ECET_Weekly_Task
end

function M:GetIntegerSomeBit(_Mask)
    -- body
    return self.m_cycleData.Field1 >> _Mask & 1
end

return M
