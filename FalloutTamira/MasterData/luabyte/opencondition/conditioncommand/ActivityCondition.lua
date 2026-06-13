-- 活动是否开启
local M = BaseClass("ActivityCondition", BaseCommand)

function M:Execute(args)
    local arg1, _ = table.unpack(args)
    local activity = ConfigHelper.GetCfgByLua("activity", arg1)
    if not activity or (activity.openType ~= 2) or (activity.ifOpen == 0) then return false end
    local nowTime = TimeUtil.GetNowTimeStamp()
    return nowTime >= activity.startTime and nowTime <= activity.endTime
end

return M
