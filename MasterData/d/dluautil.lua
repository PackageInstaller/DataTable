
-- module(..., package.seeall);

DLuaUtil = {}

local DELETE = "__DELETE__"
local CLEAR = "__CLEAR__"
local REPLACE = "__REPLACE__"
DLuaUtil.DELETE = DELETE
DLuaUtil.CLEAR = CLEAR
DLuaUtil.REPLACE = REPLACE

function DLuaUtil.assert(obj)
		
end

function DLuaUtil.GetMetatableLua(obj)
	return getmetatable(obj)
end

function DLuaUtil.Swap(a, b)
	local temp = a
	a = b
	b = temp
end

function DLuaUtil.SerialiseProto(obj,level)
	if true then
	--return ""e
	end
	local lua = ""
	local t = type(obj)
	if t == "number" then
		lua = lua .. obj
	elseif t == "boolean" then
		lua = lua .. tostring(obj)
	elseif t == "string" then
		lua = lua .. string.format("%q", obj)
	elseif t == "table" then
		if level == nil then
			level = 0
		end
		local space = ""
		if level > 0 then
			space = string.rep("    ", level)
		end
		local space_2 = string.rep("    ", level + 1)
		
		lua = lua .. "{\n"
		for k, v in pairs(obj) do
			if type(k) == "string" then
				if k == "__index" then
					lua = lua .. space_2 .. k .. "=" .. "self" .. ",\n"
				else
					lua = lua .. space_2 .. k .. "=" .. DLuaUtil.SerialiseProto(v,level+1) .. ",\n"
				end
				
			else
				lua = lua .. space_2 .. "[" .. DLuaUtil.SerialiseProto(k) .. "]=" .. DLuaUtil.SerialiseProto(v,level+1) .. ",\n"
			end
		end
		local metatable = getmetatable(obj)
		if metatable ~= nil and type(metatable.__index) == "table" then
			for k, v in pairs(metatable.__index) do
				if type(k) == "string" then
					lua = lua .. space_2 .. k .. "=" .. DLuaUtil.SerialiseProto(v) .. ",\n"
				else
					lua = lua .. space_2 .. "[" .. DLuaUtil.SerialiseProto(k) .. "]=" .. DLuaUtil.SerialiseProto(v) .. ",\n"
				end
			end
		end
		lua = lua .. space .. "}"
	elseif t == "function" then
		--function
	elseif t == "userdata" then
		--userdata
	elseif t == "nil" then
		return nil
	else
		ErrorLog("can not Serialise a " .. t .. " type.")
	end

	return lua
end

function DLuaUtil.GetLuaMonoProperties( tb )
	local num = 0
	local rTable = {}
	for i,v in pairs(tb) do
		if i ~= "RefTable" and i ~= "__index" and i ~= "super" and i ~= "class" then
			rTable[num] = {i,type(v),v}
			num = num + 1
		end
	end
	return rTable
end

function DLuaUtil.TableValueIndex(t, value)
	for k,v in pairs(t) do
		if v == value then
			return k
		end
	end

	return nil
end

function DLuaUtil.TableMergeTo(to, from)
	local num = 0
	for k,v in pairs(from) do
		to[k] = v
		num = num + 1
	end
	return to, num
end

function DLuaUtil.TableMergeBack(to, from)
	local num = 0
	for k,v in ipairs(from) do
		table.insert(to, v)
		num = num + 1
	end
	return to, num
end

function DLuaUtil.TableTotalLen(tb)
	local num = 0
	for k,v in pairs(tb) do
		num = num + 1
	end
	return num
end

function DLuaUtil.ExchangePos(tb, idx1, idx2)
	local temp = tb[idx1]
	tb[idx1] = tb[idx2]
	tb[idx2] = temp
end

function DLuaUtil.GetEnumInOrder(enumTable, ...)
	local ignores = {}
	for i,v in ipairs({...}) do
		ignores[v] = true
	end

	local indexOrder = {}
	local indexKey = {}
	for k,v in pairs(enumTable) do
		if not ignores[k] then
			indexKey[v] = k
			table.insert(indexOrder, v)
		end
	end

	table.sort(indexOrder)
	local tb = {}
	for i, v in ipairs(indexOrder) do
		local name = indexKey[v]
		table.insert(tb, name)
	end

	return tb
end

function DLuaUtil.GetReverseTable(enumTable, ...)
	local tb = {}

	local ignores = {}
	for i,v in ipairs({...}) do
		ignores[v] = true
	end

	for k,v in pairs(enumTable) do
		if not ignores[k] then
			tb[v] = k
		end
	end

	return tb
end

function DLuaUtil.IsLuaFileExist(fileName)
	if GV.IsServer then
		local ok, res = pcall(require, fileName)
		return ok
	else
		return LuaMgr.Instance:IsFileExist(fileName)
	end
end
-----------------------------------------------字符串扩展-------------------------------------------------------

--功能：分割字符串
--参数：带分割字符串，分隔符
--返回：字符串表
---@return string[]
function string.split(str, delimiter)
    str = tostring(str)
    delimiter = tostring(delimiter)
    if (delimiter=='') then return false end
    local pos,arr = 0, {}
    -- for each divider found
    for st,sp in function() return string.find(str, delimiter, pos, true) end do
        table.insert(arr, string.sub(str, pos, st - 1))
        pos = sp + 1
    end
    table.insert(arr, string.sub(str, pos))
    return arr
end

--功能：统计字符串中字符的个数
--返回：总字符个数、英文字符数、中文字符数
function string.count(str)
  local tmpStr=str
  local _,sum=string.gsub(str,"[^\128-\193]","")
  local _,countEn=string.gsub(tmpStr,"[%z\1-\127]","")
  return sum,countEn,sum-countEn
end

--功能：计算字符串的宽度，这里一个中文等于两个英文
function string.width(str)
  local _,en,cn=string.count(str)
  return cn*2+en
end

-- 功能: 把字符串扩展为长度为len,居中对齐, 其他地方以filledChar补齐
-- 参数: str 需要被扩展的字符、数字、字符串表，len 被扩展成的长度，
--       filledChar填充字符，可以为空
function string.tocenter(str, len, filledChar)
  local function tocenter(str,len,filledChar)
      str = tostring(str);
      filledChar = filledChar or " ";
      local nRestLen = len - string.width(str); -- 剩余长度
      local nNeedCharNum = math.floor(nRestLen / string.width(filledChar)); -- 需要的填充字符的数量
      local nLeftCharNum = math.floor(nNeedCharNum / 2); -- 左边需要的填充字符的数量
      local nRightCharNum = nNeedCharNum - nLeftCharNum; -- 右边需要的填充字符的数量

      str = string.rep(filledChar, nLeftCharNum)..str..string.rep(filledChar, nRightCharNum); -- 补齐
      return str
  end
  if type(str)=="number" or type(str)=="string" then
      if not string.find(tostring(str),"\n") then
        return tocenter(str,len,filledChar)
      else
        str=string.split(str,"\n")
      end
  end
  if type(str)=="table" then
    local tmpStr=tocenter(str[1],len,filledChar)
    for i=2,#str do
      tmpStr=tmpStr.."\n"..tocenter(str[i],len,filledChar)
    end
    return tmpStr
  end

end

-- print(str)
-- 功能: 把字符串扩展为长度为len,左对齐, 其他地方用filledChar补齐
function string.toleft(str, len, filledChar)
  local function toleft(str, len, filledChar)
    str    = tostring(str);
    filledChar  = filledChar or " ";
    local nRestLen  = len - string.width(str);        -- 剩余长度
    local nNeedCharNum = math.floor(nRestLen / string.width(filledChar)); -- 需要的填充字符的数量

    str = str..string.rep(filledChar, nNeedCharNum);     -- 补齐
    return str;
  end
  if type(str)=="number" or type(str)=="string" then
      if not string.find(tostring(str),"\n") then
        return toleft(str,len,filledChar)
      else
        str=string.split(str,"\n")
      end
  end
  if type(str)=="table" then
    local tmpStr=toleft(str[1],len,filledChar)
    for i=2,#str do
      tmpStr=tmpStr.."\n"..toleft(str[i],len,filledChar)
    end
    return tmpStr
  end
end

-- 功能: 把字符串扩展为长度为len,右对齐, 其他地方用filledChar补齐
function string.toright(str, len, filledChar)
  local function toright(str, len, filledChar)
    str    = tostring(str);
    filledChar  = filledChar or " ";
    local nRestLen  = len - string.width(str);        -- 剩余长度
    local nNeedCharNum = math.floor(nRestLen / string.width(filledChar)); -- 需要的填充字符的数量

    str = string.rep(filledChar, nNeedCharNum).. str;     -- 补齐
    return str;
  end
  if type(str)=="number" or type(str)=="string" then
      if not string.find(tostring(str),"\n") then
        return toright(str,len,filledChar)
      else
        str=string.split(str,"\n")
      end
  end
  if type(str)=="table" then
    local tmpStr=toright(str[1],len,filledChar)
    for i=2,#str do
      tmpStr=tmpStr.."\n"..toright(str[i],len,filledChar)
    end
    return tmpStr
  end
end
-----------------------------------------------字符串扩展-------------------------------------------------------

function DLuaUtil.GetDHMS(time)
    local daySec = 3600 * 24
    local d = math.floor(time / daySec)
    local h = math.floor(time % daySec / 3600)
    local m = math.floor((time % 3600) / 60)
    local s = math.floor((time % 3600) % 60)

	return d, h, m, s
end

function DLuaUtil.GetDHMSStr(time)
	local d, h, m, s = DLuaUtil.GetDHMS(time)
	local str
	if d == 0 then
		return string.format("%02d:%02d:%02d", h, m, s)
	else
		return string.format("%d天%02d:%02d:%02d", d, h, m, s)
	end
end

-- 比较两个时间，返回相差的年月日时分秒
function DLuaUtil.GetTimeDiff(timelong, timeshort, isGmt)
	local dateFormatStr = "*t"
	if isGmt then
		dateFormatStr = "!*t"
	end
	
    local n_short_time, n_long_time, carry, diff = os.date(dateFormatStr, timeshort), os.date(dateFormatStr, timelong), false, {}
    local colMax = {60, 60, 24, os.date(dateFormatStr, os.time{year=n_short_time.year, month=n_short_time.month+1, day=0}).day, 12, 0}
    n_long_time.hour = n_long_time.hour - (n_long_time.isdst and 1 or 0) + (n_short_time.isdst and 1 or 0) -- handle dst
    for i, v in ipairs({'sec', 'min', 'hour', 'day', 'month', 'year'}) do
        diff[v] = n_long_time[v] - n_short_time[v] + (carry and -1 or 0)
        carry = diff[v] < 0
        if carry then
            diff[v] = diff[v] + colMax[i]
        end
    end
    return diff
end

function DLuaUtil.GetDayDiff(timelong, timeshort, isGmt)
	local diff = DLuaUtil.GetTimeDiff(timelong, timeshort, isGmt)
	return diff.year * 365 + diff.month * 30 + diff.day
end

function DLuaUtil.Wait(time)
   local t0 = os.clock()
   while os.clock() - t0 <= time do end
end

-- 
function DLuaUtil.GetCurrPath()
	return debug.getinfo(2,'S').source:sub(2)
end

--获取格林威治时间
---@return integer
function DLuaUtil.GetGreenwichTime()
	return luautil.getGmtStamp(nil)
end

function DLuaUtil.GetLocalTime()
	local timeStamp = os.time()
	return timeStamp
end

--获取时区
---@return integer
function DLuaUtil.GetTimeZone()
	local now = os.time()
	local diff = os.difftime(now, os.time(os.date("!*t")))
	return diff/(60*60)
end

--切换格林威治时间到本地时间
---@return integer
function DLuaUtil.SwtichGreenwichToLocalTime(timeStamp)
	local now = os.time()
	local diff = os.difftime(now, os.time(os.date("!*t")))
	local time = timeStamp + diff
	return time
end

---获取格林威治零点时间戳
---@return integer
function DLuaUtil.GetGreenwichZeroHourTime(customZone, timeStamp)
	LuaLogger.ds("timeStamp===============", timeStamp)
	local zone = customZone or DLuaUtil.GetTimeZone()
	local localTime = timeStamp or DLuaUtil.GetGreenwichTime() + zone*60*60
	local timeData = os.date("*t", localTime)
	local year = timeData.year
	local month = timeData.month
	local day = timeData.day
	local zeroHourStamp = os.time({year=year,month=month,day=day,hour=0})
	return zeroHourStamp
end

---获取当天零点时间戳
---@return integer
function DLuaUtil.GetCurrZeroHourTime(customZone, timeStamp)
	local zone = customZone or DLuaUtil.GetTimeZone()
	local localTime = timeStamp or DLuaUtil.GetGreenwichTime() + zone*60*60
	local timeData = os.date("*t", localTime)
	local year = timeData.year
	local month = timeData.month
	local day = timeData.day
	local zeroHourStamp = os.time({year=year,month=month,day=day,hour=0})
	local stamp = zeroHourStamp
	if localTime <= stamp then
		stamp = stamp - 24*60*60
	end
	return stamp
end

---获取下次重置的时间
---@return integer
function DLuaUtil.GetNextResetTime(timeStamp, deltaTime, customZone)
	local zone = customZone or DLuaUtil.GetTimeZone()
	local localTime = timeStamp + zone*60*60
	local timeData = os.date("*t", localTime)
	local year = timeData.year
	local month = timeData.month
	local day = timeData.day
	local hour = timeData.hour
	local zeroHourStamp = os.time({year=year,month=month,day=day,hour=0})
	local stamp = zeroHourStamp + (deltaTime or Config.ResetHour_Default*60*60)
	if localTime > stamp then
		stamp = stamp + 24*60*60
	end
	return stamp - zone*60*60
end

--获得当前时间起始点
---@return integer
function DLuaUtil.GetCurInitiationTime(timeStamp, customZone, dailyResetTime)
	local zone = customZone or DLuaUtil.GetTimeZone()
	dailyResetTime = dailyResetTime or Config.GetConfigInfo("DailyResetTime")
	timeStamp = timeStamp + zone*60*60

	local timeData = os.date("*t", timeStamp)
	local year = timeData.year
	local month = timeData.month
	local day = timeData.day
	local hour = dailyResetTime
	local stamp = os.time({year=year,month=month,day=day,hour=hour})
	if timeStamp <= stamp then
		stamp = stamp - 24*60*60
	end
	return stamp - zone*60*60
end

--获得两个时间相距天数
---@return integer
function DLuaUtil.GetApartDays(timeStamp1, timeStamp2)
	timeStamp1 = DLuaUtil.GetCurInitiationTime(timeStamp1)
	timeStamp2 = DLuaUtil.GetCurInitiationTime(timeStamp2)
	local apart = math.floor(timeStamp2 - timeStamp1) / (3600 * 24)

	return math.abs(apart)
end

---@return integer
function DLuaUtil.GetCurrMonthDayTime(timeStamp, deltaDay)
	local zone = DLuaUtil.GetTimeZone()
	local localTime = timeStamp + zone*60*60
	local timeData = os.date("*t", localTime)
	local year = timeData.year
	local month = timeData.month
	local day = timeData.day
	local hour = timeData.hour
	local monthDayStamp = os.time({year=year,month=month,day=(deltaDay or 1),hour=0})
	return monthDayStamp - zone*60*60
end

--获取下个月的时间戳
function DLuaUtil.GetNextMonthDayTime(timeStamp, deltaDay)
	local zone = DLuaUtil.GetTimeZone()
	local localTime = timeStamp + zone * 60 * 60
	local timeData = os.date("*t", localTime)
	local year = timeData.year
	local month = timeData.month
	if month == 12 then
		year = year + 1
		month = 1
	else
		month = month + 1
	end
	local monthDayStamp = os.time({year=year,month = month,day=(deltaDay or 1),hour=0})
	return monthDayStamp - zone*60*60
end

--获取下周的时间戳
---@return integer
function DLuaUtil.GetNextWeekDayTime()
	local timeData = Me.servertime
	local nextMondayTimestamp = timeData + (8 - os.date("%w", timeData)) * 86400 + tonumber(Config.GetConfigInfo("DailyResetTime")) * 3600
	local timeDiff = nextMondayTimestamp - timeData
	return timeDiff
end

--计算距离下周刷新剩余时间
---@param currentTime integer 当前格林威治时间戳
---@param timeZone integer? 时区
---@return table timeMap 下次刷新时间
function DLuaUtil.getNextWeekRemainingTime(currentTime, timeZone)
	--每日重置时间
	local dailyResetTime = Config.GetConfigInfo("DailyResetTime") * 3600
    local nextWeekTime = DLuaUtil.GetNextWeekTime(currentTime, dailyResetTime, timeZone)
    return DLuaUtil.GetTimeDiff(nextWeekTime, currentTime)
end

---用本地时间计算下一个星期几的时间并返回格林尼治时间
---@return integer
function DLuaUtil.GetNextWdayTimeWithLocalTime(timeStamp, wday, diff)
	local localTime = DLuaUtil.SwtichGreenwichToLocalTime(timeStamp)
	local timeData = os.date("*t", localTime)
	local year = timeData.year
	local month = timeData.month
	local day = timeData.day
	local currWday = timeData.wday
	local deltaDay = 0
	local latestWday
	if type(wday) == "table" then
		for i, v in pairs(wday) do
			if diff and v == currWday then
			else
				if latestWday == nil then
					latestWday = v
				else
					local tmp1 = latestWday - currWday
					tmp1 = (tmp1 < 0 and (tmp1 + 7) or tmp1)
					local tmp2 = v - currWday
					tmp2 = (tmp2 < 0 and (tmp2 + 7) or tmp2)
					if tmp1 > tmp2 then
						latestWday = v
					end
				end
			end
		end
	else
		latestWday = wday
	end
	if latestWday >= currWday then
		deltaDay = latestWday - currWday
		if diff and deltaDay == 0 then
			deltaDay = 7
		end
	else
		deltaDay = latestWday - currWday + 7
	end
	local stamp = os.time({year=year,month=month,day=day,hour=0})
	stamp = stamp + 24*60*60*deltaDay
	local now = os.time()
	local diff = os.difftime(now, os.time(os.date("!*t", os.time())))
	stamp = stamp - diff
	return stamp
end

--是否在同一天
---@param timeStamp1 integer 上次时间戳
---@param timeStamp2? integer 当前时间戳
---@return boolean
function DLuaUtil.IsSameDay(timeStamp1, timeStamp2)
	--没有上次时间戳
	if not timeStamp1 or timeStamp1 == 0 then
		return false
	end

	--没有当前时间戳
	if not timeStamp2 then
		timeStamp2 = DLuaUtil.GetCurInitiationTime(DLuaUtil.GetGreenwichTime())
	end

	--当前时间小于上次时间
	if timeStamp2 <= timeStamp1 then
		return true
	end

	local timeData1 = os.date("*t", timeStamp1)
	local timeData2 = os.date("*t", timeStamp2)
	return timeData1.year == timeData2.year and timeData1.month == timeData2.month and timeData1.day == timeData2.day
end

--是否在同一周
---@param timeStamp1 integer 上次时间戳
---@param timeStamp2? integer 当前时间戳
---@return boolean
function DLuaUtil.IsSameWeek(timeStamp1, timeStamp2)
	--没有上次时间戳
	if not timeStamp1 or timeStamp1 == 0 then
		return false
	end

	--没有当前时间戳
	if not timeStamp2 then
		timeStamp2 = DLuaUtil.GetCurInitiationTime(DLuaUtil.GetGreenwichTime())
	end

	--当前时间小于上次时间
	if timeStamp2 <= timeStamp1 then
		return true
	end

	local timeData1 = os.date("*t", timeStamp1)
	local timeData2 = os.date("*t", timeStamp2)
	return timeData1.year == timeData2.year and timeData1.month == timeData2.month and math.floor(timeData1.day/7) == math.floor(timeData2.day/7)
end

--判断当前时间是周几
---@param currentTime integer 当前格林威治时间戳
---@return number? 周天数
function DLuaUtil.getWeekDayWithOffset(currentTime)
    local zone = DLuaUtil.GetTimeZone()
    local dailyResetHour = Config.GetConfigInfo("DailyResetTime")
    local zoneDeconds = zone * 3600
    local offsetSeconds = dailyResetHour * 3600
    local adjustedTime = currentTime + zoneDeconds - offsetSeconds
    local weekDayStr = os.date("%w", adjustedTime)
    local weekDay = tonumber(weekDayStr)
    if weekDay == 0 then
        weekDay = 7
    end
    return weekDay
end

--是否在同一月
---@param timeStamp1 integer 上次时间戳
---@param timeStamp2? integer 当前时间戳
---@return boolean
function DLuaUtil.IsSameMonth(timeStamp1, timeStamp2)
	--没有上次时间戳
	if not timeStamp1 or timeStamp1 == 0 then
		return false
	end

	--没有当前时间戳
	if not timeStamp2 then
		timeStamp2 = DLuaUtil.GetCurInitiationTime(DLuaUtil.GetGreenwichTime())
	end

	--当前时间小于上次时间
	if timeStamp2 <= timeStamp1 then
		return true
	end

	local timeData1 = os.date("*t", timeStamp1)
	local timeData2 = os.date("*t", timeStamp2)
	return timeData1.year == timeData2.year and timeData1.month == timeData2.month
end

--获得下一周刷新时间
function DLuaUtil.GetNextWeekTime(timeStamp, deltaTime, customZone)
	timeStamp = timeStamp or os.time()
	deltaTime = deltaTime or Config.GetConfigInfo("DailyResetTime") * 3600
    customZone = customZone or DLuaUtil.GetTimeZone()
    local oneDaySecond = 24 * 3600  -- 补充定义
    local timeData = os.date("*t", timeStamp + customZone*3600)

    -- 计算到下一个周一的天数（Lua周日=1,周一=2）
    local daysToAdd = (2 - timeData.wday) % 7
    if daysToAdd == 0 then daysToAdd = 7 end  -- 当前是周一则取下周

    -- 构建时间表（保留夏令时状态）
    local nextMonday = {
        year = timeData.year,
        month = timeData.month,
        day = timeData.day + daysToAdd,
        hour = 0, min = 0, sec = 0,
        isdst = timeData.isdst  -- 新增
    }
	-- 自动处理跨月/跨年
    local refreshTime = os.time(nextMonday) + deltaTime

    -- 处理时间戳超过目标时间的情况
    if timeStamp >= refreshTime then
        refreshTime = refreshTime + 7 * oneDaySecond
    end

    return refreshTime - customZone*3600
end


--一个月开头时间
function DLuaUtil.getMonthFirstTime(time)
	local timeData = os.date("*t", time)
	local year = timeData.year
	local month = timeData.month + 1
	if month > 12 then
		month = 1
		year = year + 1
	end


	return os.time({year=year,month=month,day=1,hour=0})
end

--获得下个月刷新时间
function DLuaUtil.GetNextMonthTime(timeStamp, deltaTime, customZone)
	local zone = customZone or DLuaUtil.GetTimeZone()
	local localTime = timeStamp + zone*60*60

	local monthTime = DLuaUtil.getMonthFirstTime(localTime)
	local refreshTime = monthTime + deltaTime

	return refreshTime - zone*60*60
end

---@return string
function DLuaUtil.SecondsToTimeStr(ts)
	if ts < 0 then
		ts = 0
	end
	ts = math.floor(ts)
	local seconds = math.fmod(ts, 60)
	local min = math.floor(ts/60)
	local hour = math.floor(min/60)
	local day = math.floor(hour/24)

	local str = ""

	if tonumber(seconds) >= 0 and tonumber(seconds) < 60 then
		str = ""..seconds.. LocalStrEnum.Second ..str
	end

	if tonumber(min - hour*60)>0 and tonumber(min - hour*60)<60 then
		str = ""..(min - hour*60).. LocalStrEnum.Minus..str
	end

	if tonumber(hour - day*24)>0 and tonumber(hour - day*60)<24 then
		str = (hour - day*24).. LocalStrEnum.Hour..str
	end

	if tonumber(day) > 0 then
		str = day.. LocalStrEnum.Day..str
	end

	return str
end

---@return string
function DLuaUtil.SecondsToTimeStr2(ts)
	ts = math.floor(ts)
	local seconds = math.fmod(ts, 60)
	local min = math.floor(ts/60)
	local hour = math.floor(min/60)
	local day = math.floor(hour/24)

	local str = string.format("%02d:%02d:%02d", hour, min%60, seconds)
	return str
end

---@return string
function DLuaUtil.SecondsToTimeStr3(ts)
	ts = math.floor(ts)
	local seconds = math.fmod(ts, 60)
	local min = math.floor(ts/60)
	local hour = math.floor(min/60)
	local day = math.floor(hour/24)

	if hour > 0 then
		local str = string.format("%02d:%02d:%02d", hour, min%60, seconds)
		return str
	else
		local str = string.format("%02d:%02d", min%60, seconds)
		return str
	end
end

---@return string
function DLuaUtil.SecondsToTimeStr4(ts)
	ts = math.floor(ts)
	local seconds = math.fmod(ts, 60)
	local min = math.floor(ts/60)
	local hour = math.floor(min/60)
	local day = 0

	local str = ""

	if tonumber(min - hour*60)>0 and tonumber(min - hour*60)<60 then
		str = ""..(min - hour*60).. LocalStrEnum.Minus..str
	end

	if tonumber(hour - day*24)>0 then
		str = (hour - day*24).. LocalStrEnum.Hour..str
	end

	return str
end

---@return string
function DLuaUtil.SecondsToTimeStr5(ts)
	ts = math.floor(ts)
	local seconds = math.fmod(ts, 60)
	local min = math.floor(ts/60)
	local hour = math.floor(min/60)
	local day = math.floor(hour/24)

	if day > 0 then
		local str = string.format("%d%s%02d%s%02d%s", day, LocalStrEnum.Day, hour%24, LocalStrEnum.Hour, min%60, LocalStrEnum.Minus)
		return str
	else
		local str = string.format("%02d%s%02d%s%02d%s", hour, LocalStrEnum.Hour, min%60, LocalStrEnum.Minus, seconds, LocalStrEnum.Second)
		return str
	end
end

---@return string
function DLuaUtil.SecondsToTimeStr6(ts)
	ts = math.floor(ts)
	local seconds = math.fmod(ts, 60)
	local min = math.floor(ts/60)
	local hour = math.floor(min/60)
	local day = math.floor(hour/24)

	local str = string.format("%d%s%02d%s\n%02d%s%02d%s", day, LocalStrEnum.Day, hour%24, LocalStrEnum.Hour, min%60, LocalStrEnum.Minus, seconds, LocalStrEnum.Second)
	return str
end

---@return string
function DLuaUtil.SecondsToTimeStr7(ts)
	ts = math.floor(ts)
	local seconds = math.fmod(ts, 60)
	local min = math.floor(ts/60)
	local hour = math.floor(min/60)

	local str = ""

	if hour > 0 then
		str = hour.."h"
	elseif min > 0 then
		str = min.."min"
	else
		str = seconds.."s"
	end

	return str
end

--将秒转化成小时和分钟
---@return integer
---@return integer
function DLuaUtil.SecondsToHourMinute(second, up)
	local hour = math.modf(second / 3600)
	local min = second % 3600

	if up then
		min = math.ceil(min / 60)
	else
		min = math.floor(min / 60)
	end
	
	return hour, min
end

--将时间戳转化成时间字符串
---@return string
function DLuaUtil.TimeStampToTimeStr(ts, needTimeZone, needType)
	local zone = 0
	if needTimeZone then
		zone = DLuaUtil.GetTimeZone()
	end
	local localTime = ts + zone*60*60
	local timeData = os.date("*t", localTime)
	local year = timeData.year
	local month = timeData.month
	local day = timeData.day
	local hour = timeData.hour
	local min = timeData.min
	if needType == 1 then--20XX-XX-XX
		return string.format("%02d-%02d-%02d", year, month, day)
	elseif needType == 2 then--20XX年XX月XX日
		return string.format("%02d%s%02d%s%02d%s", year, LocalStrEnum.TipYear, month, LocalStrEnum.TipMonth, day, LocalStrEnum.TipDay)
	end
	return string.format("%02d:%02d", hour, min)
end

--将对应格式时间字符串转为时间戳
---@param strTime string 配置表中的数据 2008-03-27 23:28:38
---@return integer
function DLuaUtil.ParseConfigTime(strTime)
	local timestamp = 0
	if strTime == nil then
		return timestamp
	end
	local ymd_hms = string.split(strTime, " ")
	--LuaLogger.ds("^^^^^%%%%%^^^^^",tablex.dump(ymd_hms))
	if #ymd_hms == 2 then
		local ymd = string.split(ymd_hms[1], "-")
		local hms = string.split(ymd_hms[2], ":")
		if #ymd == 3 and #hms == 3 then
			local date = 
			{
				year = tonumber(ymd[1]),
				month = tonumber(ymd[2]),
				day = tonumber(ymd[3]),
				hour = tonumber(hms[1]),
				min = tonumber(hms[2]),
				sec = tonumber(hms[3]),
			}

			timestamp = os.time(date)

			--转换成格林威治时间
			timestamp = timestamp - DLuaUtil.GetTimeZone() * 3600
		end
	end
	return timestamp
end

--将对应格式时间字符串转为时间戳 前端用 需要比较本地时区
---@param strTime string 配置表中的数据 2008-03-27 23:28:38
---@return integer
function DLuaUtil.ParseConfigTimeClient(strTime)
	local timestamp = 0
	if strTime == nil then
		return timestamp
	end
	local ymd_hms = string.split(strTime, " ")

	if #ymd_hms == 2 then
		local ymd = string.split(ymd_hms[1], "-")
		local hms = string.split(ymd_hms[2], ":")
		if #ymd == 3 and #hms == 3 then
			local date = 
			{
				year = tonumber(ymd[1]),
				month = tonumber(ymd[2]),
				day = tonumber(ymd[3]),
				hour = tonumber(hms[1]),
				min = tonumber(hms[2]),
				sec = tonumber(hms[3]),
			}
			local server_time_zone = 8 * 3600	--服务区所在时区 * 3600
			timestamp = os.time(date) + os.difftime(os.time(), os.time(os.date("!*t", os.time()))) - server_time_zone
		end
	end
	return timestamp
end

--根据身份证获得area、sex、birthday
--@param {string} idCard
function DLuaUtil.GetIdCardInfo(idCard)
	local area, sex, birthday
	if string.len(idCard) == 18 then
		birthday = string.sub(idCard,7,14)

		local sex_code = tonumber(string.sub(idCard, 17, 17))
		if sex_code % 2 == 0 then
			sex = "女"
		else
			sex = "男"
		end
	elseif string.len(idCard) == 15 then
		birthday = string.sub(idCard,7,12)
		birthday = "19" .. birthday

		local sex_code = tonumber(string.sub(idCard, 15, 15))
		if sex_code % 2 == 0 then
			sex = "女"
		else
			sex = "男"
		end
	else
		return
	end
	area = string.sub(idCard,1,6)
	birthday = string.format("%s-%s-%s",string.sub(birthday,1,4),string.sub(birthday,5,6),string.sub(birthday,7,8))

	return area, sex, birthday
end

--清空子节点所有预制体
---@param trans UnityEngine.Transform 父节点
function DLuaUtil.ClearChildren(trans)
	local childcount = trans.childCount
	if childcount and childcount > 0 then
		for i = 1, childcount do
			DUtil.DestroyImmediate(trans:GetChild(0).gameObject)
		end
	end
end

--根据权重列表获取随机结果
--data {table} 索引和权重 {{index=index, weight=weight},{index=index, weight=weight}, ........}
---@param random Random 随机数生成器
function DLuaUtil.getRandomIndexLinear(data, random)
    local weightAll = 0   
    for i = 1, #data do
        weightAll = weightAll + data[i].weight
    end
    local random_data = random:range(1, weightAll)
    for i = 1, #data do
        random_data = random_data - data[i].weight
        if random_data <= 0 then
            return data[i].index
        end
    end
    return -1
end

--根据权重列表获取随机结果
--data {table} 索引和权重 {{index, weight},{index, weight}, ........}
---@param random Random 随机数生成器
function DLuaUtil.getRandomIndexLinear2(data, random)
	if not data or #data == 0 then
		return
	end

    local weightAll = 0   
    for i = 1, #data do
        weightAll = weightAll + data[i][2]
    end

    local random_data = random:range(1, weightAll)
    for i = 1, #data do
        random_data = random_data - data[i][2]
        if random_data <= 0 then
            return data[i][1]
        end
    end
end

---战斗中播放角色语音，采用unity的随机数生成器
function DLuaUtil.getUnityRandomIndexLinear(data)
	---@type UnityEngine.Random
	local random = UnityEngine.Random
    local weightAll = 0
	local dataCount = #data
    for i = 1, dataCount do
		local weight = data[i][2]
        weightAll = weightAll + weight
    end
    local random_data = random.Range(1, weightAll + 1)
    for i = 1, dataCount do
		local d = data[i]
		local weight = d[2]
        random_data = random_data - weight
        if random_data <= 0 then
            return d[1], d[3]
        end
    end
    return -1
end

function DLuaUtil.IsNumber(str)
	return tonumber(str) ~= nil
end

-- 传入百分比（如30），返回true表示命中概率，否则false
---@param percent integer 百分比
---@param random Random 随机数生成器
---@return boolean 是否命中
function DLuaUtil.randomByPercent(percent, random)
    local randomValue = random and random:range(1, 100) or math.random(1, 100)
    return randomValue <= percent
end

-- cos获得当前渠道目录
function DLuaUtil.GetCurrentChannelDir()
	local skynet = require "skynet"
    local channel_cos = skynet.getenv("channel_cos")
	local nodename = skynet.getenv("nodename")
	local zeroPath = nodename

	--center、game节点分区服
	if string.find(nodename, "center") or string.find(nodename, "game") then
		zeroPath = string.format("server_%d", tonumber(skynet.getenv("zone")))
	end

    return string.format("%s/%s/", channel_cos, zeroPath)
end

---获取子节点的路径
---@param child UnityEngine.Transform 子节点
---@param parent UnityEngine.Transform? 父节点
---@return string 路径
function DLuaUtil.GetHierarchyPath(child, parent) 
	if child == nil then
		return ""
	end
	local path = child.name

	while (child.parent ~= nil and child.parent ~= parent) do
		child = child.parent
		path = child.name .. "/" .. path
	end
	return path
end



---递归更新table
---@param dest table 目标table
---@param src table 更新table
function DLuaUtil.UpdateTable(dest, src)
	if not dest or not src then
		return
	end
	for k, v in pairs(src) do
		if type(v) == "table" then
			if tablex.empty(v) then
 				dest[k] = nil   -- 删除字段
			else
				if dest[k] == nil then
					dest[k] = v
				else
					-- 如果两个都是table，递归合并
					DLuaUtil.UpdateTable(dest[k], v)
				end
			end
        else
            dest[k] = v
        end
    end
end


----合并所有数字形式字符串key值转换数字类型
---@param dest table 新table
---@param src table 数据源
function DLuaUtil.MergeParseNumbers(dest, src)
	if not dest or not src then
		return
	end
	for k, v in pairs(src) do
		local kk = tonumber(k)
		if kk == nil then
			kk = k
		end
		if type(v) == "table" then
			if dest[kk] == nil then
				dest[kk] = {}
			end
			DLuaUtil.MergeParseNumbers(dest[kk], v)
        else
            dest[kk] = v
        end
    end
end




--regine
local unpack = unpack or table.unpack
-- 解决原生pack的nil截断问题，SafePack与SafeUnpack要成对使用
function SafePack(...)
	local params = {...}
	params.n = select('#', ...)
	return params
end

-- 解决原生unpack的nil截断问题，SafePack与SafeUnpack要成对使用
function SafeUnpack(safe_pack_tb)
	return unpack(safe_pack_tb, 1, safe_pack_tb.n)
end

-- 对两个SafePack的表执行连接
function ConcatSafePack(safe_pack_l, safe_pack_r)
	local concat = {}
	for i = 1,safe_pack_l.n do
		concat[i] = safe_pack_l[i]
	end
	for i = 1,safe_pack_r.n do
		concat[safe_pack_l.n + i] = safe_pack_r[i]
	end
	concat.n = safe_pack_l.n + safe_pack_r.n
	return concat
end

-- 闭包绑定
function Bind(self, func, ...)
	assert(self == nil or type(self) == "table")
	assert(func ~= nil and type(func) == "function")
	local params = nil
	if self == nil then
		params = SafePack(...)
	else
		params = SafePack(self, ...)
	end
	return function(...)
		local args = ConcatSafePack(params, SafePack(...))
		local data = func(SafeUnpack(args))
		return data
	end
end

-- 回调绑定
-- 重载形式：
-- 1、成员函数、私有函数绑定：BindCallback(obj, callback, ...)
-- 2、闭包绑定：BindCallback(callback, ...)
function BindCallback(...)
	local bindFunc = nil
	local params = SafePack(...)
	assert(params.n >= 1, "BindCallback : error params count!")
	if type(params[1]) == "table" and type(params[2]) == "function" then
		bindFunc = Bind(...)
	elseif type(params[1]) == "function" then
		bindFunc = Bind(nil, ...)
	else
		error("BindCallback : error params list!")
	end
	return bindFunc
end


-- 闭包绑定
function BindSelf(self, func)
	assert(self == nil or type(self) == "table")
	assert(func ~= nil and type(func) == "function")
	return function(...)
		return func(self, ...)
	end
end

-- 回调绑定
-- 重载形式：
-- 1、成员函数、私有函数绑定：BindCallback(obj, callback, ...)
-- 2、闭包绑定：BindCallback(callback, ...)
function BindCallback_NoParams(callobj, func)
	local bindFunc = nil
	bindFunc = BindSelf(callobj, func)
	return bindFunc
end

-- 将字符串转换为boolean值
function ToBoolean(s)
	local transform_map = {
		["true"] = true,
		["false"] = false,
	}

	return transform_map[s]
end

-- 深拷贝对象
function DeepCopy(object)
	local lookup_table = {}
	
	local function _copy(object)
		if type(object) ~= "table" then
			return object
		elseif lookup_table[object] then
			return lookup_table[object]
		end

		local new_table = {}
		lookup_table[object] = new_table
		for index, value in pairs(object) do
			new_table[_copy(index)] = _copy(value)
		end

		return setmetatable(new_table, getmetatable(object))
	end

	return _copy(object)
end

-- 序列化表
function Serialize(tb, flag)
	local result = ""
	result = string.format("%s{", result)

	local filter = function(str)
		str = string.gsub(str, "%[", " ")
		str = string.gsub(str, "%]", " ")
		str = string.gsub(str, '\"', " ")
		str	= string.gsub(str, "%'", " ")
		str	= string.gsub(str, "\\", " ")
		str	= string.gsub(str, "%%", " ")
		return str
	end

	for k,v in pairs(tb) do
		if type(k) == "number" then
			if type(v) == "table" then
				result = string.format("%s[%d]=%s,", result, k, Serialize(v))
			elseif type(v) == "number" then
				result = string.format("%s[%d]=%d,", result, k, v)
			elseif type(v) == "string" then
				result = string.format("%s[%d]=%q,", result, k, v)
			elseif type(v) == "boolean" then
				result = string.format("%s[%d]=%s,", result, k, tostring(v))
			else
				if flag then
					result = string.format("%s[%d]=%q,", result, k, type(v))
				else
					error("the type of value is a function or userdata")
				end
			end
		else
			if type(v) == "table" then
				result = string.format("%s%s=%s,", result, k, Serialize(v, flag))
			elseif type(v) == "number" then
				result = string.format("%s%s=%d,", result, k, v)
			elseif type(v) == "string" then
				result = string.format("%s%s=%q,", result, k, v)
			elseif type(v) == "boolean" then
				result = string.format("%s%s=%s,", result, k, tostring(v))
			else
				if flag then
					result = string.format("%s[%s]=%q,", result, k, type(v))
				else
					error("the type of value is a function or userdata")
				end
			end
		end
	end
	result = string.format("%s}", result)
	return result
end


function IsNull(unity_object)
	if unity_object == nil then
		return true
	end
	--[[
	if type(unity_object) == "userdata" and unity_object.IsNull ~= nil then
		return unity_object:IsNull()
	end
	
	return false
	]]
	if type(unity_object) == "userdata" and unity_object.Equals ~= nil then
		return unity_object:Equals(nil)
	end
	
	return false
end

function string.isNullOrEmpty(str)
	return str == nil or str == ''
end


function string.CS_Format(fmt, ...)
	assert(fmt ~= nil,"Format error:Invalid Format String")
	local parms = {...}
	
	local function search(k)
	  --从 C# 数组习惯转到 Lua
	  k = k+1
	  assert(k <= #parms and k >=0 ,"Format error:IndexOutOfRange")
	  return tostring(parms[k])
	end
	
	return (string.gsub(fmt,"{(%d)}",search))
end

---计算危境攻坚剩余时间
---@param closingTime integer 当前期数结束时间（格林威治时间）
---@param serverTime? integer 当前格林威治时间
---@return table timeMap 剩余时间信息 {day, hour, min, sec, totalSeconds}
function DLuaUtil.getBossActivityRemainingTime(closingTime, serverTime)
    -- 获取当前服务器时间
    local currentTime
	if GV.IsServer then
		currentTime = serverTime or DLuaUtil.GetGreenwichTime()
	else
		currentTime = serverTime or Me.servertime
	end

    -- 计算剩余秒数
    local remainingSeconds = closingTime - currentTime

    -- 如果剩余时间为负数，说明活动已结束
    if remainingSeconds < 0 then
        remainingSeconds = 0
    end

    -- 直接通过秒数计算天、小时、分钟、秒（避开时区影响）
    local day = math.floor(remainingSeconds / (24 * 3600))
    local hour = math.floor((remainingSeconds % (24 * 3600)) / 3600)
    local min = math.floor((remainingSeconds % 3600) / 60)
    local sec = remainingSeconds % 60

    return {
        day = day,
        hour = hour,
        min = min,
        sec = sec,
        totalSeconds = remainingSeconds
    }
end

--将字符串超长的部分用...代替
---comment
---@param str string
---@param maxChars integer 最大字符数（汉字算两个字符）
---@return string
function DLuaUtil.SetOverLengthStrToEllipsis(str, maxChars)
	if not str or type(str) ~= "string" then return str end
    local count = 0
    local out = {}
    for uchar in str:gmatch("[%z\1-\127\194-\244][\128-\191]*") do
        local _, num = string.gsub(uchar,"[%z\1-\127]","")
        if num == 0 then
            count = count + 2--汉字算两个字符
        else
            count = count + 1
        end
        if count <= maxChars then
            table.insert(out, uchar)
        else
            table.insert(out, "...")
            break
        end
    end
    if count <= maxChars then
        return str
    end
    return table.concat(out)
end

--计算字符串去除富文本标签后的字符数（汉字算2，英文算1）
---@param str string
---@return integer
function DLuaUtil.GetStrLenWithoutRichText(str)
    if not str or type(str) ~= "string" then return 0 end
    local stripped = string.gsub(str, "<[^>]+>", "")
    local total = string.count(stripped)
    return total
end

return DLuaUtil