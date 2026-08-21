-- 防沉迷逻辑

local AddictionPrevention = {}

local _statutoryHolidays = {
    statutoryHoliday20 = {
    },

    statutoryHoliday21 = {
        {m = 1, d = 1}, -- 元旦
        {m = 1, d = 12},-- 除夕
        {m = 1, d = 13},
        {m = 1, d = 14},
        {m = 4, d = 5}, -- 清明
        {m = 5, d = 1}, -- 劳动节
        {m = 6, d = 14}, -- 端午节
        {m = 9, d = 21}, -- 中秋节
        {m = 10, d = 1}, -- 国庆节
        {m = 10, d = 2},
        {m = 10, d = 3},
    },

    statutoryHoliday22 = {
        {m = 1, d = 1}, -- 元旦
        {m = 2, d = 1},-- 除夕
        {m = 2, d = 2},
        {m = 2, d = 3},
        {m = 4, d = 4}, -- 清明
        {m = 5, d = 1}, -- 劳动节
        {m = 6, d = 3}, -- 端午节
        {m = 9, d = 10}, -- 中秋节
        {m = 10, d = 1}, -- 国庆节
        {m = 10, d = 2},
        {m = 10, d = 3},
    },

    statutoryHoliday23 = {
        {m = 1, d = 1}, -- 元旦
        {m = 1, d = 22},-- 除夕
        {m = 1, d = 23},
        {m = 1, d = 24},
        {m = 4, d = 5}, -- 清明
        {m = 5, d = 1}, -- 劳动节
        {m = 6, d = 22}, -- 端午节
        {m = 9, d = 29}, -- 中秋节
        {m = 10, d = 1}, -- 国庆节
        {m = 10, d = 2},
        {m = 10, d = 3},
    },

    statutoryHoliday24 = {
        {m = 1, d = 1}, -- 元旦
        {m = 2, d = 10},-- 除夕
        {m = 2, d = 11},
        {m = 2, d = 12},
        {m = 4, d = 4}, -- 清明
        {m = 5, d = 1}, -- 劳动节
        {m = 6, d = 10}, -- 端午节
        {m = 9, d = 17}, -- 中秋节
        {m = 10, d = 1}, -- 国庆节
        {m = 10, d = 2},
        {m = 10, d = 3},
    },

    statutoryHoliday25 = {
        {m = 1, d = 1}, -- 元旦
        {m = 1, d = 28},-- 除夕
        {m = 1, d = 29},-- 除夕
        {m = 1, d = 30},-- 除夕
        {m = 1, d = 31},-- 除夕
        {m = 4, d = 4}, -- 清明
        {m = 5, d = 1}, -- 劳动节
        {m = 5, d = 2}, -- 劳动节
        {m = 5, d = 31}, -- 端午节
        {m = 10, d = 6}, -- 中秋节
        {m = 10, d = 1}, -- 国庆节
        {m = 10, d = 2},
        {m = 10, d = 3},
    }
}

local function _getStatutoryHoliday(stamp)
    local year00 = os.date('*t', stamp).year % 100
    -- 根据今天得到的法定假日列表
    local dayStatutoryHoliday = _statutoryHolidays["statutoryHoliday"..year00]
    return dayStatutoryHoliday
end

local _dayStatutoryHoliday = _getStatutoryHoliday()

-- stamp为nil的时候为当前时间
function AddictionPrevention.IsStatutoryHoliday(stamp)
    local days
    if stamp then
        days = _getStatutoryHoliday(stamp)
    else
        days = _dayStatutoryHoliday
        if not days then
            return false -- 找不到就当非法定假日
        end
    end

    local t = os.date('*t', stamp)
    for i, v in ipairs(days) do
        if v.m == t.month and v.d == t.day then
            return true
        end
    end

    return false
end

local _fullTime = 3600 * 24 + 1
local _holidayHours = 3
local _normalHours = 1.5
local _holidaySeconds = 3600 * _holidayHours
local _normalSeconds = 3600 * _normalHours
-- yearsOld周岁的玩家今天可以玩的累积时长(秒)
function AddictionPrevention.MaxSecondsToday(yearsOld)
    if not yearsOld or yearsOld >= 18 then
        return _fullTime
    elseif AddictionPrevention.IsStatutoryHoliday() then
        return _holidaySeconds
    else
        return _normalSeconds
    end
end

function AddictionPrevention.MaxHoursToday()
    if AddictionPrevention.IsStatutoryHoliday() then
        return _holidayHours
    else
        return _normalHours
    end
end

-- 未成年人在22:00-8:00之间无法登录游戏
function AddictionPrevention.CanEnterGameTimePeriod(yearsOld)
    if not yearsOld or yearsOld >= 18 then
        return true
    end

    local t = os.date('*t')
    return t.hour >= 8 and t.hour < 22
end

function AddictionPrevention.IsMinor(yearsOld)
    return yearsOld and yearsOld < 18
end

-------------------------- 新政策 --------------------------
-- 未成年人 法定假日，或者周五、周六、周日的20:00至21:00才能玩游戏
function AddictionPrevention.CanEnterGameNewPolicy1(yearsOld)
    if not yearsOld or yearsOld >= 18 then
        return true
    end

    local t = os.date('*t')
    --LuaLogger.ds("CanEnterGameNewPolicy1", tablex.dump(t))
    if not (AddictionPrevention.IsStatutoryHoliday() or t.wday == 6 or t.wday == 7 or t.wday == 1) then
        return false
    end

    return t.hour >= 20 and t.hour < 21
end

-- 最小年龄限制登录
function AddictionPrevention.CanEnterUnderAgeLimit(yearsOld)
    local minAgeLimit = GF.getMinAgeLimit()
    if not yearsOld or minAgeLimit <= 0 then
        return true
    end

    return yearsOld >= minAgeLimit
end

return AddictionPrevention