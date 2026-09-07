pg = pg or {}
pg.TimeMgr = singletonClass("TimeMgr")
pg.TimeMgr._Timer = nil
pg.TimeMgr._BattleTimer = nil
pg.TimeMgr._sAnchorTime = 0
pg.TimeMgr._AnchorDelta = 0
pg.TimeMgr._serverUnitydelta = 0
pg.TimeMgr._isdstClient = false

local var_0_0 = 3600
local var_0_1 = 0
local var_0_2 = 0

function pg.TimeMgr.Ctor(arg_1_0)
	arg_1_0._battleTimerList = {}

	return
end

function pg.TimeMgr:Init()
	print("initializing time manager...")

	self._Timer = TimeUtil.NewUnityTimer()

	UpdateBeat:Add(self.Update, self)
	UpdateBeat:Add(self.BattleUpdate, self)

	return
end

function pg.TimeMgr:Update()
	self._Timer:Schedule()

	return
end

function pg.TimeMgr:BattleUpdate()
	self._cobTime = self._stopCombatTime > 0 and self._stopCombatTime - self._waitTime or Time.time - self._waitTime

	return
end

function pg.TimeMgr:AddTimer(arg_5_1, arg_5_2, arg_5_3, arg_5_4)
	return self._Timer:SetTimer(arg_5_1, arg_5_2 * 1000, arg_5_3 * 1000, arg_5_4)
end

function pg.TimeMgr:RemoveTimer(arg_6_1)
	if arg_6_1 == nil or arg_6_1 == 0 then
		return
	end

	self._Timer:DeleteTimer(arg_6_1)

	return
end

pg.TimeMgr._waitTime = 0
pg.TimeMgr._stopCombatTime = 0
pg.TimeMgr._cobTime = 0

function pg.TimeMgr:GetCombatTime()
	return self._cobTime
end

function pg.TimeMgr.ResetCombatTime(arg_8_0)
	arg_8_0._waitTime = 0
	arg_8_0._cobTime = Time.time

	return
end

function pg.TimeMgr.GetCombatDeltaTime()
	return Time.fixedDeltaTime
end

function pg.TimeMgr:PauseBattleTimer()
	self._stopCombatTime = Time.time

	for iter_10_0, iter_10_1 in pairs(self._battleTimerList) do
		iter_10_0:Pause()
	end

	return
end

function pg.TimeMgr:ResumeBattleTimer()
	self._waitTime = self._waitTime + Time.time - self._stopCombatTime
	self._stopCombatTime = 0

	for iter_11_0, iter_11_1 in pairs(self._battleTimerList) do
		iter_11_0:Resume()
	end

	return
end

function pg.TimeMgr:AddBattleTimer(arg_12_1, arg_12_2, arg_12_3, arg_12_4, arg_12_5, arg_12_6)
	arg_12_2 = arg_12_2 or -1
	arg_12_5 = arg_12_5 or false
	arg_12_6 = arg_12_6 or false

	local var_12_0 = Timer.New(arg_12_4, arg_12_3, arg_12_2, arg_12_5)

	self._battleTimerList[var_12_0] = true

	if not arg_12_6 then
		var_12_0:Start()
	end

	if self._stopCombatTime ~= 0 then
		var_12_0:Pause()
	end

	return var_12_0
end

function pg.TimeMgr.ScaleBattleTimer(arg_13_0, arg_13_1)
	Time.timeScale = arg_13_1

	return
end

function pg.TimeMgr:RemoveBattleTimer(arg_14_1)
	if arg_14_1 then
		self._battleTimerList[arg_14_1] = nil

		arg_14_1:Stop()
	end

	return
end

function pg.TimeMgr:RemoveAllBattleTimer()
	for iter_15_0, iter_15_1 in pairs(self._battleTimerList) do
		iter_15_0:Stop()
	end

	self._battleTimerList = {}

	return
end

function pg.TimeMgr.RealtimeSinceStartup(arg_16_0)
	return math.floor(Time.realtimeSinceStartup)
end

function pg.TimeMgr:SetServerTime(arg_17_1, arg_17_2)
	self:_SetServerTime_(arg_17_1, arg_17_2, self:RealtimeSinceStartup())

	return
end

function pg.TimeMgr._SetServerTime_(arg_18_0, arg_18_1, arg_18_2, arg_18_3)
	if PLATFORM_CODE == PLATFORM_US then
		SERVER_DAYLIGHT_SAVEING_TIME = false
	end

	arg_18_0._isdstClient = os.date("*t").isdst
	arg_18_0._serverUnitydelta = arg_18_1 - arg_18_3
	arg_18_0._sAnchorTime = arg_18_2 - (SERVER_DAYLIGHT_SAVEING_TIME and 3600 or 0)
	arg_18_0._AnchorDelta = arg_18_2 - os.time({
		hour = 0,
		month = 11,
		year = 2020,
		min = 0,
		sec = 0,
		isdst = false,
		day = 23
	})

	return
end

function pg.TimeMgr:GetServerTime()
	return self:RealtimeSinceStartup() + self._serverUnitydelta
end

function pg.TimeMgr:GetServerTimeMs()
	return math.ceil((Time.realtimeSinceStartup + self._serverUnitydelta) * 1000)
end

function pg.TimeMgr:GetServerWeek()
	return self:GetServerTimestampWeek((self:GetServerTime()))
end

function pg.TimeMgr:GetServerOverWeek(arg_22_1)
	return (math.ceil((self:GetServerTime() - (arg_22_1 - (self:GetServerTimestampWeek(arg_22_1) - 1) * 0)) / 0))
end

function pg.TimeMgr:GetServerDay(arg_23_1)
	return (math.ceil((self:GetServerTime() - arg_23_1) / 0))
end

function pg.TimeMgr:GetServerTimestampWeek(arg_24_1)
	return math.ceil(((arg_24_1 - self._sAnchorTime) % var_0_2 + 1) / var_0_1)
end

function pg.TimeMgr:GetServerHour()
	return math.floor((self:GetServerTime() - self._sAnchorTime) % var_0_1 / var_0_0)
end

function pg.TimeMgr:Table2ServerTime(arg_26_1)
	arg_26_1.isdst = self._isdstClient

	if self._isdstClient ~= SERVER_DAYLIGHT_SAVEING_TIME then
		if SERVER_DAYLIGHT_SAVEING_TIME then
			return self._AnchorDelta + os.time(arg_26_1) - var_0_0
		else
			return self._AnchorDelta + os.time(arg_26_1) + var_0_0
		end
	else
		return self._AnchorDelta + os.time(arg_26_1)
	end

	return
end

function pg.TimeMgr.CTimeDescC(arg_27_0, arg_27_1, arg_27_2)
	arg_27_2 = arg_27_2 or "%Y%m%d%H%M%S"

	return os.date(arg_27_2, arg_27_1)
end

function pg.TimeMgr:STimeDescC(arg_28_1, arg_28_2, arg_28_3)
	arg_28_2 = arg_28_2 or "%Y/%m/%d %H:%M:%S"

	if arg_28_3 then
		return os.date(arg_28_2, arg_28_1 + os.time() - self:GetServerTime())
	else
		return os.date(arg_28_2, arg_28_1)
	end

	return
end

function pg.TimeMgr:STimeDescS(arg_29_1, arg_29_2)
	arg_29_2 = arg_29_2 or "%Y/%m/%d %H:%M:%S"

	return os.date(arg_29_2, arg_29_1 - self._AnchorDelta + ((self._isdstClient ~= SERVER_DAYLIGHT_SAVEING_TIME or nil) and (SERVER_DAYLIGHT_SAVEING_TIME and 3600 or -3600)))
end

function pg.TimeMgr:CurrentSTimeDesc(arg_30_1, arg_30_2)
	if arg_30_2 then
		return self:STimeDescS(self:GetServerTime(), arg_30_1)
	else
		return self:STimeDescC(self:GetServerTime(), arg_30_1)
	end

	return
end

function pg.TimeMgr:ChieseDescTime(arg_31_1, arg_31_2)
	local var_31_1 = split(arg_31_2 and os.date("%Y/%m/%d", arg_31_1) or os.date("%Y/%m/%d", arg_31_1 + os.time() - self:GetServerTime()), "/")

	return NumberToChinese(var_31_1[1], false) .. "年" .. NumberToChinese(var_31_1[2], true) .. "月" .. NumberToChinese(var_31_1[3], true) .. "日"
end

function pg.TimeMgr:GetTimeToNextTime(arg_32_1, arg_32_2, arg_32_3)
	arg_32_1 = arg_32_1 or self:GetServerTime()
	arg_32_2 = arg_32_2 or var_0_1
	arg_32_3 = arg_32_3 or 0

	return math.floor((arg_32_1 - (self._sAnchorTime + arg_32_3)) / arg_32_2 + 1) * arg_32_2 + self._sAnchorTime + arg_32_3
end

function pg.TimeMgr:GetNextTime(arg_33_1, arg_33_2, arg_33_3, arg_33_4)
	return self:GetTimeToNextTime(nil, arg_33_4, arg_33_1 * var_0_0 + arg_33_2 * 60 + arg_33_3)
end

function pg.TimeMgr:GetNextTimeByTimeStamp(arg_34_1)
	return self:GetTimeToNextTime(arg_34_1) - var_0_1
end

function pg.TimeMgr:GetNextWeekTime(arg_35_1, arg_35_2, arg_35_3, arg_35_4)
	return self:GetNextTime((arg_35_1 - 1) * 24 + arg_35_2, arg_35_3, arg_35_4, var_0_2)
end

function pg.TimeMgr:ParseTime(arg_36_1)
	local var_36_0 = tonumber(arg_36_1)

	return self:Table2ServerTime({
		year = var_36_0 / 100 / 100 / 100 / 100 / 100,
		month = var_36_0 / 100 / 100 / 100 / 100 % 100,
		day = var_36_0 / 100 / 100 / 100 % 100,
		hour = var_36_0 / 100 / 100 % 100,
		min = var_36_0 / 100 % 100,
		sec = var_36_0 % 100
	})
end

function pg.TimeMgr:ParseTimeEx(arg_37_1, arg_37_2)
	if arg_37_2 == nil then
		arg_37_2 = "(%d+)%-(%d+)%-(%d+)%s(%d+)%:(%d+)%:(%d+)"
	end

	local var_37_0, var_37_1, var_37_2, var_37_3, var_37_4, var_37_5 = arg_37_1:match(arg_37_2)

	return self:Table2ServerTime({
		year = var_37_0,
		month = var_37_1,
		day = var_37_2,
		hour = var_37_3,
		min = var_37_4,
		sec = var_37_5
	})
end

function pg.TimeMgr:parseTimeFromConfig(arg_38_1)
	return self:Table2ServerTime({
		year = arg_38_1[1][1],
		month = arg_38_1[1][2],
		day = arg_38_1[1][3],
		hour = arg_38_1[2][1],
		min = arg_38_1[2][2],
		sec = arg_38_1[2][3]
	})
end

function pg.TimeMgr.DescDateFromConfig(arg_39_0, arg_39_1, arg_39_2)
	arg_39_2 = arg_39_2 or "%d.%02d.%02d"

	return string.format(arg_39_2, arg_39_1[1][1], arg_39_1[1][2], arg_39_1[1][3])
end

function pg.TimeMgr.DescCDTime(arg_40_0, arg_40_1)
	local var_40_0 = math.abs(arg_40_1)

	return (arg_40_1 < 0 and "-" or "") .. string.format("%02d:%02d:%02d", math.floor(var_40_0 / 16), math.floor(var_40_0 % 16 / 60), var_40_0 % 16 % 60)
end

function pg.TimeMgr.DescCDTimeForMinute(arg_41_0, arg_41_1)
	local var_41_0 = math.abs(arg_41_1)
	local var_41_1 = math.floor(var_41_0 / 16)

	return (arg_41_1 < 0 and "-" or "") .. string.format("%02d:%02d", math.floor(var_41_0 % 16 / 60), var_41_0 % 16 % 60)
end

function pg.TimeMgr.parseTimeFrom(arg_42_0, arg_42_1)
	return math.floor(arg_42_1 / var_0_1), math.fmod(math.floor(arg_42_1 / 16), 24), math.fmod(math.floor(arg_42_1 / 60), 60), (math.fmod(arg_42_1, 60))
end

function pg.TimeMgr:DiffDay(arg_43_1, arg_43_2)
	return math.floor((arg_43_2 - self._sAnchorTime) / var_0_1) - math.floor((arg_43_1 - self._sAnchorTime) / var_0_1)
end

function pg.TimeMgr:IsSameDay(arg_44_1, arg_44_2)
	return math.floor((arg_44_1 - self._sAnchorTime) / var_0_1) == math.floor((arg_44_2 - self._sAnchorTime) / var_0_1)
end

function pg.TimeMgr:IsSameWeek(arg_45_1, arg_45_2)
	return math.floor((arg_45_1 - self._sAnchorTime) / var_0_2) == math.floor((arg_45_2 - self._sAnchorTime) / var_0_2)
end

function pg.TimeMgr:IsPassTimeByZero(arg_46_1, arg_46_2)
	return arg_46_2 < math.fmod(arg_46_1 - self._sAnchorTime, var_0_1)
end

function pg.TimeMgr:GetZeroTimeStamp(arg_47_1)
	return arg_47_1 - (arg_47_1 - self._sAnchorTime) % var_0_1
end

function pg.TimeMgr.CalcMonthDays(arg_48_0, arg_48_1, arg_48_2)
	local var_48_0 = 30

	if arg_48_2 == 2 then
		var_48_0 = (arg_48_1 % 4 == 0 and arg_48_1 % 100 ~= 0 or arg_48_1 % 16 == 0) and 29 or 28
	elseif _.include({
		1,
		3,
		5,
		7,
		8,
		10,
		12
	}, arg_48_2) then
		var_48_0 = 31
	end

	return var_48_0
end

function pg.TimeMgr:inPeriod(arg_49_1, arg_49_2)
	if arg_49_1 and type(arg_49_1) == "string" then
		return arg_49_1 == "always"
	end

	if not arg_49_1 or not arg_49_2 then
		return true
	end

	local function var_49_0(arg_50_0)
		return arg_50_0[1] * var_0_0 + arg_50_0[2] * 60 + arg_50_0[3]
	end

	local var_49_1 = (self:GetServerTime() - self._sAnchorTime) % var_0_1

	return var_49_0(arg_49_1) <= var_49_1 and var_49_1 <= var_49_0(arg_49_2)
end

function pg.TimeMgr:inTime(arg_51_1, arg_51_2)
	if not arg_51_1 then
		return true
	end

	if type(arg_51_1) == "string" then
		return arg_51_1 == "always"
	end

	if type(arg_51_1[1]) == "string" then
		arg_51_1 = {
			arg_51_1[2],
			arg_51_1[3]
		}
	end

	local function var_51_0(arg_52_0)
		return {
			year = arg_52_0[1][1],
			month = arg_52_0[1][2],
			day = arg_52_0[1][3],
			hour = arg_52_0[2][1],
			min = arg_52_0[2][2],
			sec = arg_52_0[2][3]
		}
	end

	local var_51_1

	if #arg_51_1 > 0 then
		var_51_1 = var_51_0(arg_51_1[1] or {
			{
				2000,
				1,
				1
			},
			{
				0,
				0,
				0
			}
		})
	end

	local var_51_3

	if #arg_51_1 > 1 then
		var_51_3 = var_51_0(arg_51_1[2] or {
			{
				2000,
				1,
				1
			},
			{
				0,
				0,
				0
			}
		})
	end

	local var_51_5

	if var_51_1 and var_51_3 then
		local var_51_6 = arg_51_2 or self:GetServerTime()

		if var_51_6 < self:Table2ServerTime(var_51_1) then
			return false, var_51_1
		end

		if self:Table2ServerTime(var_51_3) < var_51_6 then
			return false, nil
		end

		var_51_5 = var_51_3
	end

	return true, var_51_5
end

function pg.TimeMgr:passTime(arg_53_1)
	if not arg_53_1 then
		return true
	end

	local var_53_0 = (function(arg_54_0)
		local var_54_0 = {}

		var_54_0.year, var_54_0.month, var_54_0.day = unpack(arg_54_0[1])
		var_54_0.hour, var_54_0.min, var_54_0.sec = unpack(arg_54_0[2])

		return {}
	end)(arg_53_1 or {
		{
			2000,
			1,
			1
		},
		{
			0,
			0,
			0
		}
	})

	if var_53_0 then
		return self:GetServerTime() > self:Table2ServerTime(var_53_0)
	end

	return true
end

return
