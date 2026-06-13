local baseClass = require("DataCenter.Cycle.BaseCycleData")
local M = BaseClass("HeroSpecialDailyData", baseClass)

function M:__init()
    -- body
    self.m_cycleType = protocol.ECycleEvent.ECET_Hero_Special_Daily
end

-- 获取今日触发次数
function M:GetCount()
    local timeStamp = self.m_cycleData.Value
    if timeStamp <= 0 then
        return self.m_cycleData.Field0
    else
        -- 判断当前时间是否和上次计算时间是同一天
        local curStamp = TimeUtil.GetNowTimeStamp()
        local today = GameHelper.GetDateTime(curStamp)
        local lastDate = GameHelper.GetDateTime(timeStamp)
        local span = today:Subtract(lastDate)
        if span.Days > 0 then
            return 0
        else
            return self.m_cycleData.Field0
        end
    end
end

return M
