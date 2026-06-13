local M = BaseClass('WeekDayCondition', BaseCommand)

function M:Execute(args)
    local arg1, _ = table.unpack(args)
    local hour = GameHelper.GetParamter(361)
    local curTime = TimeUtil.GetNowTimeStamp() - 3600 * (hour or 0)
    local day = tonumber(os.date("%w", curTime))
    if day == 0 then
        return day == arg1 or arg1 ==7
    end
    return day == arg1
end

return M
