pg = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
pg = pg
singletonClass = var_0_10001
var_0.TimeMgr = var_0_10001("TimeMgr")

local var_0_1 = var_0.TimeMgr

var_0_1._Timer = nil
var_0_1._BattleTimer = nil
var_0_1._sAnchorTime = 0
var_0_1._AnchorDelta = 0
var_0_1._serverUnitydelta = 0
var_0_1._isdstClient = false

local var_0_2 = 3600
local var_0_3 = 0
local var_0_4 = 0

function var_0_1.Ctor(arg_1_0)
	arg_1_0._battleTimerList = {}

	return
end

function var_0_1.Init(arg_2_0)
	print = var_1_10001

	var_1_10001("initializing time manager...")

	TimeUtil = var_1_10001
	arg_2_0._Timer = var_1_10001.NewUnityTimer()
	UpdateBeat = var_1

	var_1:Add(arg_2_0.Update, arg_2_0)

	UpdateBeat = var_1

	var_1:Add(arg_2_0.BattleUpdate, arg_2_0)

	return
end

function var_0_1.Update(arg_3_0)
	local var_3_0 = arg_3_0._Timer

	var_1.Schedule(var_3_0)

	return
end

function var_0_1.BattleUpdate(arg_4_0)
	if arg_4_0._stopCombatTime > 0 then
		arg_4_0._cobTime = arg_4_0._stopCombatTime - arg_4_0._waitTime
	else
		Time = var_1
		arg_4_0._cobTime = var_1.time - arg_4_0._waitTime
	end

	return
end

function var_0_1.AddTimer(arg_5_0, arg_5_1, arg_5_2, arg_5_3, arg_5_4)
	local var_5_0 = arg_5_0._Timer

	return var_5.SetTimer(var_5_0, arg_5_1, arg_5_2 * 1000, arg_5_3 * 1000, arg_5_4)
end

function var_0_1.RemoveTimer(arg_6_0, arg_6_1)
	if arg_6_1 == nil or arg_6_1 == 0 then
		return
	end

	local var_6_0 = arg_6_0._Timer

	var_2.DeleteTimer(var_6_0, arg_6_1)

	return
end

var_0_1._waitTime = 0
var_0_1._stopCombatTime = 0
var_0_1._cobTime = 0

function var_0_1.GetCombatTime(arg_7_0)
	return arg_7_0._cobTime
end

function var_0_1.ResetCombatTime(arg_8_0)
	arg_8_0._waitTime = 0
	Time = var_1
	arg_8_0._cobTime = var_1.time

	return
end

function var_0_1.GetCombatDeltaTime()
	Time = var_1_10000

	return var_1_10000.fixedDeltaTime
end

function var_0_1.PauseBattleTimer(arg_10_0)
	Time = var_1_10001
	arg_10_0._stopCombatTime = var_1_10001.time
	pairs = var_1

	for iter_10_0, iter_10_1 in var_1(arg_10_0._battleTimerList) do
		iter_10_0:Pause()
	end

	return
end

function var_0_1.ResumeBattleTimer(arg_11_0)
	local var_11_0 = arg_11_0._waitTime

	Time = var_1_10002
	arg_11_0._waitTime = var_11_0 + var_1_10002.time - arg_11_0._stopCombatTime
	arg_11_0._stopCombatTime = 0
	pairs = var_1

	for iter_11_0, iter_11_1 in var_1(arg_11_0._battleTimerList) do
		iter_11_0:Resume()
	end

	return
end

function var_0_1.AddBattleTimer(arg_12_0, arg_12_1, arg_12_2, arg_12_3, arg_12_4, arg_12_5, arg_12_6)
	arg_12_2 = arg_12_2 or -1
	arg_12_5 = arg_12_5 or false
	arg_12_6 = arg_12_6 or false
	Timer = var_1_10007

	local var_12_0 = var_1_10007.New(arg_12_4, arg_12_3, arg_12_2, arg_12_5)

	arg_12_0._battleTimerList[var_12_0] = true

	if not arg_12_6 then
		var_12_0:Start()
	end

	if arg_12_0._stopCombatTime ~= 0 then
		var_12_0:Pause()
	end

	return var_12_0
end

function var_0_1.ScaleBattleTimer(arg_13_0, arg_13_1)
	Time = var_1_10002
	var_1_10002.timeScale = arg_13_1

	return
end

function var_0_1.RemoveBattleTimer(arg_14_0, arg_14_1)
	if arg_14_1 then
		arg_14_0._battleTimerList[arg_14_1] = nil

		arg_14_1:Stop()
	end

	return
end

function var_0_1.RemoveAllBattleTimer(arg_15_0)
	pairs = var_1_10001

	for iter_15_0, iter_15_1 in var_1_10001(arg_15_0._battleTimerList) do
		iter_15_0:Stop()
	end

	arg_15_0._battleTimerList = {}

	return
end

function var_0_1.RealtimeSinceStartup(arg_16_0)
	math = var_1_10001

	local var_16_0 = var_1_10001.floor

	Time = var_1_10003

	return var_16_0(var_1_10003.realtimeSinceStartup)
end

function var_0_1.SetServerTime(arg_17_0, arg_17_1, arg_17_2)
	arg_17_0:_SetServerTime_(arg_17_1, arg_17_2, arg_17_0:RealtimeSinceStartup())

	return
end

function var_0_1._SetServerTime_(arg_18_0, arg_18_1, arg_18_2, arg_18_3)
	PLATFORM_CODE = var_1_10004
	PLATFORM_US = var_1_10005

	if var_1_10004 == var_1_10005 then
		var_1_10004 = false
		var_1_10004 = SERVER_DAYLIGHT_SAVEING_TIME
	end

	os = var_1_10004
	arg_18_0._isdstClient = var_1_10004.date("*t").isdst
	arg_18_0._serverUnitydelta = arg_18_1 - arg_18_3
	SERVER_DAYLIGHT_SAVEING_TIME = var_4
	arg_18_0._sAnchorTime = arg_18_2 - (var_4 and 3600 or 0)
	os = var_4
	arg_18_0._AnchorDelta = arg_18_2 - var_4.time({
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

function var_0_1.GetServerTime(arg_19_0)
	return arg_19_0:RealtimeSinceStartup() + arg_19_0._serverUnitydelta
end

function var_0_1.GetServerTimeMs(arg_20_0)
	math = var_1_10001

	local var_20_0 = var_1_10001.ceil

	Time = var_1_10003

	return var_20_0((var_1_10003.realtimeSinceStartup + arg_20_0._serverUnitydelta) * 1000)
end

function var_0_1.GetServerWeek(arg_21_0)
	local var_21_0 = arg_21_0:GetServerTime()

	return arg_21_0:GetServerTimestampWeek(var_21_0)
end

function var_0_1.GetServerOverWeek(arg_22_0, arg_22_1)
	local var_22_0 = arg_22_1 - (arg_22_0:GetServerTimestampWeek(arg_22_1) - 1) * 0

	math = var_5

	return (var_5.ceil((arg_22_0:GetServerTime() - var_22_0) / 0))
end

function var_0_1.GetServerDay(arg_23_0, arg_23_1)
	math = var_1_10002

	return (var_1_10002.ceil((arg_23_0:GetServerTime() - arg_23_1) / 0))
end

function var_0_1.GetServerTimestampWeek(arg_24_0, arg_24_1)
	local var_24_0 = arg_24_1 - arg_24_0._sAnchorTime

	math = var_1_10003

	return var_1_10003.ceil((var_24_0 % var_0_4 + 1) / var_0_3)
end

function var_0_1.GetServerHour(arg_25_0)
	local var_25_0 = arg_25_0
	local var_25_1 = arg_25_0.GetServerTime(var_25_0) - arg_25_0._sAnchorTime

	math = var_25_0

	return var_25_0.floor(var_25_1 % var_0_3 / var_0_2)
end

function var_0_1.Table2ServerTime(arg_26_0, arg_26_1)
	arg_26_1.isdst = arg_26_0._isdstClient

	local var_26_0 = arg_26_0._isdstClient

	SERVER_DAYLIGHT_SAVEING_TIME = var_1_10003

	if var_26_0 ~= var_1_10003 then
		SERVER_DAYLIGHT_SAVEING_TIME = var_26_0

		if var_26_0 then
			local var_26_1 = arg_26_0._AnchorDelta

			os = var_1_10003

			return var_26_1 + var_1_10003.time(arg_26_1) - var_0_2
		else
			local var_26_2 = arg_26_0._AnchorDelta

			os = var_1_10003

			return var_26_2 + var_1_10003.time(arg_26_1) + var_0_2
		end
	else
		local var_26_3 = arg_26_0._AnchorDelta

		os = var_1_10003

		return var_26_3 + var_1_10003.time(arg_26_1)
	end

	return
end

function var_0_1.CTimeDescC(arg_27_0, arg_27_1, arg_27_2)
	arg_27_2 = arg_27_2 or "%Y%m%d%H%M%S"
	os = var_1_10003

	return var_1_10003.date(arg_27_2, arg_27_1)
end

function var_0_1.STimeDescC(arg_28_0, arg_28_1, arg_28_2, arg_28_3)
	arg_28_2 = arg_28_2 or "%Y/%m/%d %H:%M:%S"

	if arg_28_3 then
		os = var_1_10004
		var_1_10004 = var_1_10004.date

		local var_28_0 = arg_28_2

		os = var_1_10007

		return var_1_10004(var_28_0, arg_28_1 + var_1_10007.time() - arg_28_0:GetServerTime())
	else
		os = var_1_10004

		return var_1_10004.date(arg_28_2, arg_28_1)
	end

	return
end

function var_0_1.STimeDescS(arg_29_0, arg_29_1, arg_29_2)
	arg_29_2 = arg_29_2 or "%Y/%m/%d %H:%M:%S"

	local var_29_0 = 0
	local var_29_1 = arg_29_0._isdstClient

	SERVER_DAYLIGHT_SAVEING_TIME = var_1_10005

	if var_29_1 ~= var_1_10005 then
		SERVER_DAYLIGHT_SAVEING_TIME = var_29_1
		var_29_0 = var_29_1 and 3600 or -3600
	end

	os = var_29_1

	return var_29_1.date(arg_29_2, arg_29_1 - arg_29_0._AnchorDelta + var_29_0)
end

function var_0_1.CurrentSTimeDesc(arg_30_0, arg_30_1, arg_30_2)
	if arg_30_2 then
		return arg_30_0:STimeDescS(arg_30_0:GetServerTime(), arg_30_1)
	else
		return arg_30_0:STimeDescC(arg_30_0:GetServerTime(), arg_30_1)
	end

	return
end

function var_0_1.ChieseDescTime(arg_31_0, arg_31_1, arg_31_2)
	local var_31_0 = "%Y/%m/%d"
	local var_31_1

	if arg_31_2 then
		os = var_1_10005
		var_31_1 = var_1_10005.date(var_31_0, arg_31_1)
	else
		os = var_1_10005
		var_1_10005 = var_1_10005.date

		local var_31_2 = var_31_0

		os = var_1_10008
		var_31_1 = var_1_10005(var_31_2, arg_31_1 + var_1_10008.time() - arg_31_0:GetServerTime())
	end

	split = var_1_10005

	local var_31_3 = var_1_10005(var_31_1, "/")

	NumberToChinese = var_1_10006

	local var_31_4 = var_1_10006(var_31_3[1], false)
	local var_31_5 = "年"

	NumberToChinese = var_8

	local var_31_6 = var_8(var_31_3[2], true)
	local var_31_7 = "月"

	NumberToChinese = var_10

	return var_31_4 .. var_31_5 .. var_31_6 .. var_31_7 .. var_10(var_31_3[3], true) .. "日"
end

function var_0_1.GetTimeToNextTime(arg_32_0, arg_32_1, arg_32_2, arg_32_3)
	arg_32_1 = arg_32_1 or arg_32_0:GetServerTime()
	arg_32_2 = arg_32_2 or var_0_3
	arg_32_3 = arg_32_3 or 0

	local var_32_0 = arg_32_1 - (arg_32_0._sAnchorTime + arg_32_3)

	math = var_1_10005

	return var_1_10005.floor(var_32_0 / arg_32_2 + 1) * arg_32_2 + arg_32_0._sAnchorTime + arg_32_3
end

function var_0_1.GetNextTime(arg_33_0, arg_33_1, arg_33_2, arg_33_3, arg_33_4)
	return arg_33_0:GetTimeToNextTime(nil, arg_33_4, arg_33_1 * var_0_2 + arg_33_2 * 60 + arg_33_3)
end

function var_0_1.GetNextTimeByTimeStamp(arg_34_0, arg_34_1)
	return arg_34_0:GetTimeToNextTime(arg_34_1) - var_0_3
end

function var_0_1.GetNextWeekTime(arg_35_0, arg_35_1, arg_35_2, arg_35_3, arg_35_4)
	return arg_35_0:GetNextTime((arg_35_1 - 1) * 24 + arg_35_2, arg_35_3, arg_35_4, var_0_4)
end

function var_0_1.ParseTime(arg_36_0, arg_36_1)
	tonumber = var_1_10002

	local var_36_0 = var_1_10002(arg_36_1) % 100
	local var_36_1 = var_2 / 100 % 100
	local var_36_2 = var_2 / 100 % 100
	local var_36_3 = var_2 / 100 % 100
	local var_36_4 = var_2 / 100 % 100
	local var_36_5 = var_2 / 100

	return arg_36_0:Table2ServerTime({
		year = var_36_5,
		month = var_36_4,
		day = var_36_3,
		hour = var_36_2,
		min = var_36_1,
		sec = var_36_0
	})
end

function var_0_1.ParseTimeEx(arg_37_0, arg_37_1, arg_37_2)
	if arg_37_2 == nil then
		arg_37_2 = "(%d+)%-(%d+)%-(%d+)%s(%d+)%:(%d+)%:(%d+)"
	end

	local var_37_0, var_37_1, var_37_2, var_37_3, var_37_4, var_37_5 = arg_37_1:match(arg_37_2)

	return arg_37_0:Table2ServerTime({
		year = var_37_0,
		month = var_37_1,
		day = var_37_2,
		hour = var_37_3,
		min = var_37_4,
		sec = var_37_5
	})
end

function var_0_1.parseTimeFromConfig(arg_38_0, arg_38_1)
	return arg_38_0:Table2ServerTime({
		year = arg_38_1[1][1],
		month = arg_38_1[1][2],
		day = arg_38_1[1][3],
		hour = arg_38_1[2][1],
		min = arg_38_1[2][2],
		sec = arg_38_1[2][3]
	})
end

function var_0_1.DescDateFromConfig(arg_39_0, arg_39_1, arg_39_2)
	arg_39_2 = arg_39_2 or "%d.%02d.%02d"
	string = var_1_10003

	return var_1_10003.format(arg_39_2, arg_39_1[1][1], arg_39_1[1][2], arg_39_1[1][3])
end

function var_0_1.DescCDTime(arg_40_0, arg_40_1)
	math = var_1_10002

	local var_40_0 = var_1_10002.floor(arg_40_1 / 16)

	arg_40_1 = arg_40_1 % 16
	math = var_1_10003

	local var_40_1 = var_1_10003.floor(arg_40_1 / 60)

	arg_40_1 = arg_40_1 % 60
	string = var_4

	return var_4.format("%02d:%02d:%02d", var_40_0, var_40_1, arg_40_1)
end

function var_0_1.DescCDTimeForMinute(arg_41_0, arg_41_1)
	math = var_1_10002

	local var_41_0 = var_1_10002.floor(arg_41_1 / 16)

	arg_41_1 = arg_41_1 % 16
	math = var_1_10003

	local var_41_1 = var_1_10003.floor(arg_41_1 / 60)

	arg_41_1 = arg_41_1 % 60
	string = var_4

	return var_4.format("%02d:%02d", var_41_1, arg_41_1)
end

function var_0_1.parseTimeFrom(arg_42_0, arg_42_1)
	math = var_1_10002

	local var_42_0 = var_1_10002.floor(arg_42_1 / var_0_3)

	math = var_1_10003

	local var_42_1 = var_1_10003.fmod

	math = var_1_10005

	local var_42_2 = var_42_1(var_1_10005.floor(arg_42_1 / 16), 24)

	math = var_4

	local var_42_3 = var_4.fmod

	math = var_6

	local var_42_4 = var_42_3(var_6.floor(arg_42_1 / 60), 60)

	math = var_5

	local var_42_5 = var_5.fmod(arg_42_1, 60)

	return var_42_0, var_42_2, var_42_4, var_42_5
end

function var_0_1.DiffDay(arg_43_0, arg_43_1, arg_43_2)
	math = var_1_10003

	local var_43_0 = var_1_10003.floor((arg_43_2 - arg_43_0._sAnchorTime) / var_0_3)

	math = var_1_10004

	return var_43_0 - var_1_10004.floor((arg_43_1 - arg_43_0._sAnchorTime) / var_0_3)
end

function var_0_1.IsSameDay(arg_44_0, arg_44_1, arg_44_2)
	math = var_1_10003

	local var_44_0 = var_1_10003.floor((arg_44_1 - arg_44_0._sAnchorTime) / var_0_3)

	math = var_1_10004

	return var_44_0 == var_1_10004.floor((arg_44_2 - arg_44_0._sAnchorTime) / var_0_3)
end

function var_0_1.IsSameWeek(arg_45_0, arg_45_1, arg_45_2)
	math = var_1_10003

	local var_45_0 = var_1_10003.floor((arg_45_1 - arg_45_0._sAnchorTime) / var_0_4)

	math = var_1_10004

	return var_45_0 == var_1_10004.floor((arg_45_2 - arg_45_0._sAnchorTime) / var_0_4)
end

function var_0_1.IsPassTimeByZero(arg_46_0, arg_46_1, arg_46_2)
	math = var_1_10003

	return arg_46_2 < var_1_10003.fmod(arg_46_1 - arg_46_0._sAnchorTime, var_0_3)
end

function var_0_1.GetZeroTimeStamp(arg_47_0, arg_47_1)
	return arg_47_1 - (arg_47_1 - arg_47_0._sAnchorTime) % var_0_3
end

function var_0_1.CalcMonthDays(arg_48_0, arg_48_1, arg_48_2)
	local var_48_0 = 30

	if arg_48_2 == 2 then
		var_48_0 = (arg_48_1 % 4 == 0 and arg_48_1 % 100 ~= 0 or arg_48_1 % 16 == 0) and 29 or 28
	else
		_ = var_1_10004

		if var_1_10004.include({
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
	end

	return var_48_0
end

function var_0_1.inPeriod(arg_49_0, arg_49_1, arg_49_2)
	if arg_49_1 then
		type = var_1_10003

		if var_1_10003(arg_49_1) == "string" then
			return arg_49_1 == "always"
		end
	end

	if not arg_49_1 or not arg_49_2 then
		return true
	end

	local function var_49_0(arg_50_0)
		return arg_50_0[1] * var_0_2 + arg_50_0[2] * 60 + arg_50_0[3]
	end

	local var_49_1 = (arg_49_0:GetServerTime() - arg_49_0._sAnchorTime) % var_0_3
	local var_49_2 = var_49_0(arg_49_1)
	local var_49_3 = var_49_0(arg_49_2)

	return var_49_2 <= var_49_1 and var_49_1 <= var_49_3
end

function var_0_1.inTime(arg_51_0, arg_51_1, arg_51_2)
	if not arg_51_1 then
		return true
	end

	type = var_1_10003

	local var_51_0

	if var_1_10003(arg_51_1) == "string" then
		var_51_0 = arg_51_1 == "always"

		return var_51_0
	end

	type = var_51_0

	if var_51_0(arg_51_1[1]) == "string" then
		arg_51_1 = {
			arg_51_1[2],
			arg_51_1[3]
		}
	end

	local function var_51_1(arg_52_0)
		return {
			year = arg_52_0[1][1],
			month = arg_52_0[1][2],
			day = arg_52_0[1][3],
			hour = arg_52_0[2][1],
			min = arg_52_0[2][2],
			sec = arg_52_0[2][3]
		}
	end

	local var_51_2

	if #arg_51_1 > 0 then
		local var_51_3 = var_51_1
		local var_51_4

		if not arg_51_1[1] then
			var_51_4 = {
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
			}
		end

		var_51_2 = var_51_3(var_51_4)
	end

	local var_51_5

	if #arg_51_1 > 1 then
		local var_51_6 = var_51_1
		local var_51_7

		if not arg_51_1[2] then
			var_51_7 = {
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
			}
		end

		var_51_5 = var_51_6(var_51_7)
	end

	local var_51_8

	if var_51_2 and var_51_5 then
		local var_51_9 = arg_51_2 or arg_51_0:GetServerTime()
		local var_51_10 = arg_51_0:Table2ServerTime(var_51_2)
		local var_51_11 = arg_51_0:Table2ServerTime(var_51_5)

		if var_51_9 < var_51_10 then
			return false, var_51_2
		end

		if var_51_11 < var_51_9 then
			return false, nil
		end

		var_51_8 = var_51_5
	end

	return true, var_51_8
end

function var_0_1.passTime(arg_53_0, arg_53_1)
	if not arg_53_1 then
		return true
	end

	if (function(arg_54_0)
		local var_54_0 = {}

		unpack = var_2_10002

		local var_54_1, var_54_2, var_54_3 = var_2_10002(arg_54_0[1])

		var_54_0.day = var_54_3
		var_54_0.month = var_54_2
		var_54_0.year = var_54_1
		unpack = var_54_1
		var_54_0.hour, var_54_0.min, var_54_0.sec = var_54_1(arg_54_0[2])

		return var_54_0
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
	}) then
		return arg_53_0:GetServerTime() > arg_53_0:Table2ServerTime(var_3)
	end

	return true
end

return
