local baseClass = require("DataCenter.Cycle.BaseCycleData")
local M = BaseClass("FastCollectData", baseClass)

function M:__init()
    -- body
    self.m_cycleType = protocol.ECycleEvent.ECET_Fast_Collect
end

function M:GetTimeStamp()
    -- body
    return self.m_cycleData.Value
end

function M:GetFreeCount()
    -- body
    return self.m_cycleData.Field0
end

function M:GetDiamondCount()
    -- body
    return self.m_cycleData.Field1
end

function M:GetTotalCount()
    -- body
    return self.m_cycleData.Field2
end

return M
