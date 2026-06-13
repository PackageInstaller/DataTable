local TimeUtil = BaseClass("TimeUtil")
local CS_TimeHelper = CS.GameX.TimeHelper
local CS_TimeUtil = CS.GameX.TimeUtil
local ONEMIN = 60
local ONEHOUR = 3600
local ONEDAY = 86400
local HOURS8 = 28800
local month = { "Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec" }

TimeUtil.DailyRefreshTime = 5 -- 每日刷新时间

--获取当前的时间戳 19700101 开始以秒为单位
function TimeUtil.GetNowTimeStamp()
    return CS_TimeHelper.GetCurrentTimeStamp()
end

-- 获取当前小时在时间戳中的index 可以用来判断两个时间段是否是在同一个小时
function TimeUtil.GetHourIndex(timer)
    timer = timer or TimeUtil.GetNowTimeStamp()
    return math.modf(timer / ONEHOUR)
end

-- 获取当前天在时间戳中的index 可以用来判断两个时间段是否是同一天
function TimeUtil.GetDayIndex(timer)
    timer = timer or TimeUtil.GetNowTimeStamp()
    timer = timer + HOURS8 -- 时间戳是从八点开始的，所以这个地方加八个小时
    return math.modf(timer / ONEDAY)
end

-- 获取时间是在当天中的第多少秒
function TimeUtil.GetSecondIndexInDay(time)
    time = time or TimeUtil.GetNowTimeStamp()
    local timeData = TimeUtil.GetTimeByStamp(time)
    return timeData.second + ONEMIN * timeData.minute + ONEHOUR * timeData.hour
end

-- 时间戳转化成格式化的当前时间
function TimeUtil.GetTimeFormat(timer, timeFormat)
    timer = timer or TimeUtil.GetNowTimeStamp()
    timer = timer > 0 and timer or 0
    timeFormat = timeFormat or "%y-%m-%d %H:%M %S"

    return os.date(timeFormat, timer)
end

--获取当天开始的时间戳（00：00：00）
function TimeUtil.GetNowTimerStart(timer, _hour)
    if timer == nil then
        Logger.LogError("creatTick is nil")
        return 0
    end
    if _hour == nil then _hour = 0 end
    if timer == 0 then return 0 end
    local t = os.date("*t", timer)
    local tick = os.time({ year = t.year, month = t.month, day = t.day, hour = _hour })
    return tick

    --return TimeUtil.GetNowTimeStamp() - timer - HOURS8
end

--获得当天开始的时间 凌晨5点到次日5点
function TimeUtil.GetDayStart(tick)

end

function TimeUtil.GetTimeByStamp(unixTime)
    local serverZone = 8
    local HOUR = 3600
    unixTime = unixTime or TimeUtil.GetNowTimeStamp()
    unixTime = unixTime > 0 and unixTime or 0
    unixTime = unixTime + serverZone * HOUR
    local tb = {}
    tb.year = tonumber(os.date("!%Y", unixTime))
    tb.month = tonumber(os.date("!%m", unixTime))
    tb.day = tonumber(os.date("!%d", unixTime))
    tb.hour = tonumber(os.date("!%H", unixTime))
    tb.minute = tonumber(os.date("!%M", unixTime))
    tb.second = tonumber(os.date("!%S", unixTime))
    return tb
end

-- 把 秒，转化为 数字 的形式
function TimeUtil.ConvertTimeForm(second)
    local timeDay = math.floor(second / 86400)                   -- 取整数位
    local timeHour = math.fmod(math.floor(second / ONEHOUR), 24) -- 取模
    local timeMinute = math.fmod(math.floor(second / 60), 60)

    if timeDay > 0 then
        return timeDay .. "d"
    elseif timeHour > 0 then
        return timeHour .. "h"
    elseif timeMinute > 0 then
        return timeMinute .. "m"
    else
        return second .. "s"
    end
end

-- 判断时间是否是今天整点后
function TimeUtil.IsToday(timer, hour)
    if hour == nil then hour = 0 end
    local offset = hour * ONEHOUR
    local nowTime = TimeUtil.GetNowTimeStamp()
    local hour5OfTick = TimeUtil.GetHourStamp(timer - offset, hour)
    return hour5OfTick == TimeUtil.GetHourStamp(nowTime - offset, hour)
end

---判断两个时间是否是同一天
---@param timer1 any
---@param timer2 any
function TimeUtil.IsOneDay(timer1, timer2)
    return TimeUtil.GetDayIndex(timer1) == TimeUtil.GetDayIndex(timer2)
end

function TimeUtil.GetDateTime(timeStamp)
    return GameHelper.GetDateTime(timeStamp)
end

function TimeUtil.GetDayOfYear()
    return CS_TimeHelper.GetDayOfYear()
end

function TimeUtil.GetHourOfDay()
    return CS_TimeHelper.GetHourOfDay()
end

-- 获取指定月份和年份中的天数
function TimeUtil.GetDaysInMonth(dateTime)
    return CS_TimeUtil.GetDaysInMonth(dateTime)
end

--- 通过时间戳，与当前服务器时间比较
---@param timeStamp 需要比较的时间戳
---@param passHour 偏移时间,例如早晨5点刷新
---@return int (0,表示当天)
function TimeUtil.GetDateState(timeStamp, passHour)
    passHour = passHour or 0
    local nowTimer = TimeUtil.GetNowTimeStamp() - passHour * ONEHOUR
    local timeStamp = timeStamp - passHour * ONEHOUR
    return TimeUtil.GetDayIndex(nowTimer) - TimeUtil.GetDayIndex(timeStamp)
end

-- 获得指定时间缀当日hour时的时间戳
function TimeUtil.GetHourStamp(timeStamp, hour)
    if hour == nil then hour = 0 end
    return CS_TimeHelper.GetHourStamp(timeStamp, hour)
end

-- function TimeUtil.SetLastOnlineTime(time)
--     CS_CServerTime.setLastOnlineTime(time)
-- end

function TimeUtil.SecToDays(second)
    return CS_TimeHelper.SecToDays(second)
end

function TimeUtil.TimeCountDownSpan(spanTime)
    return CS_TimeUtil.TimeCountDownSpan(spanTime)
end

function TimeUtil.CountDayByStartTime(startTick, endTick)
    return CS_TimeHelper.CountDayByStartTime(startTick, endTick)
end

function TimeUtil.TimeStampToDateTime(timeStamp, timeKind)
    return CS_TimeHelper.TimeStampToDateTime(timeStamp, timeKind)
end

function TimeUtil.TimeStampToStringFormat(timeStamp, formatType)
    if formatType == nil then formatType = 1 end
    return CS_TimeHelper.TimeStampToStringFormat(timeStamp, formatType)
end

function TimeUtil.CheckNowInTime(startTick, endTick)
    local nowTimer = TimeUtil.GetNowTimeStamp()
    return startTick <= nowTimer and endTick >= nowTimer
end

function TimeUtil.GetCurServerTimeHourMinute()
    local tb = TimeUtil.GetTimeByStamp()
    return tostring(tb.hour) .. ":" .. tb.minute
end

function TimeUtil.GetCurserverTimeMonth()
    local tb = TimeUtil.GetTimeByStamp()
    return tostring(tb.day) .. " " .. month[tb.month]
end

function TimeUtil.CanRefreshMonthCardReward(rewardTimestamp, endTimestamp)
    return CS_TimeHelper.CanRefreshMonthCardReward(rewardTimestamp, endTimestamp)
end

function TimeUtil.GetMonthCardRemainDays(endTimestamp)
    return CS_TimeHelper.GetMonthCardRemainDays(endTimestamp)
end

function TimeUtil.IsMonday()
    return CS_TimeHelper.IsMonday()
end

function TimeUtil.SecToStringFormat(second)
    local sec = second % ONEMIN
    local min = math.floor((second % ONEHOUR) / ONEMIN)
    local hour = math.floor(second / ONEHOUR)
    return string.format("%02d:%02d:%02d", hour, min, sec)
end

function TimeUtil.GetRemainDays()
    return CS_TimeHelper.GetRemainDays()
end

-- 是否在创角后的开放时间内（按凌晨5点算）
function TimeUtil.IsInCreatRoleOpenTime(second)
    local hour5OfCreatTick = TimeUtil.GetHourStamp(IPlayerData.creatTick - 5 * ONEHOUR, 5)
    local hour5AfterCreat7DaysTick = hour5OfCreatTick + second
    local curStamp = TimeUtil.GetNowTimeStamp()
    return curStamp < hour5AfterCreat7DaysTick
end

function TimeUtil.GetRefreshInterval(clock)
    return CS_TimeHelper.GetRefreshInterval(clock)
end

function TimeUtil.GetTimeStamp(clock)
    return CS_TimeHelper.GetTimeStamp(clock)
end

-- "MM/DD/YYYY HH:MM:SS" 抽卡时间转时间戳
function TimeUtil.ParseLuckDrawTime(timeStr)
    local pattern = "(%d+)/(%d+)/(%d+) (%d+):(%d+):(%d+)"
    local _month, _day, _year, _hour, _minute, _second = timeStr:match(pattern)
    return os.time({ year = _year, month = _month, day = _day, hour = _hour, min = _minute, sec = _second })
end

return TimeUtil
