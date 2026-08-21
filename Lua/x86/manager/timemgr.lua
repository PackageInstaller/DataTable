local var_0_0 = singletonClass("TimeMgr")

var_0_0._Timer = nil
var_0_0._sAnchorTime = 0
var_0_0._AnchorDelta = 0
var_0_0._serverUnitydelta = 0

local var_0_1 = 3600
local var_0_2 = 86400
local var_0_3 = 604800

var_0_0.DaySecs = var_0_2

local var_0_4 = 0
local var_0_5 = 345600

function var_0_0.Ctor(arg_1_0)
	arg_1_0:OnCtor()
end

function var_0_0.OnCtor(arg_2_0)
	print("initializing time manager...")

	arg_2_0._Timer = TimeUtil.NewUnityTimer()

	arg_2_0:UpdateTimeInfo()
end

function var_0_0.UpdateTimeInfo(arg_3_0)
	arg_3_0.timeZero_ = arg_3_0:CalcTimeZone()
	arg_3_0.deltaTimeZero_ = arg_3_0.timeZero_ - var_0_4
end

function var_0_0.Update(arg_4_0)
	arg_4_0._Timer:Schedule()
end

function var_0_0.AddTimer(arg_5_0, arg_5_1, arg_5_2, arg_5_3, arg_5_4)
	return arg_5_0._Timer:SetTimer(arg_5_1, arg_5_2 * 1000, arg_5_3 * 1000, arg_5_4)
end

function var_0_0.RemoveTimer(arg_6_0, arg_6_1)
	if arg_6_1 == nil or arg_6_1 == 0 then
		return
	end

	arg_6_0._Timer:DeleteTimer(arg_6_1)
end

function var_0_0.GetHour(arg_7_0, arg_7_1)
	return arg_7_1 * 60 * 60 * 1000
end

function var_0_0.GetHourInType(arg_8_0, arg_8_1, arg_8_2)
	if arg_8_2 == 1 then
		return arg_8_1 * 60
	elseif arg_8_2 == 2 then
		return arg_8_1 * 60 * 60
	elseif arg_8_2 == 3 then
		return arg_8_1 * 60 * 60 * 1000
	end
end

function var_0_0.RealtimeSinceStartup(arg_9_0)
	return math.ceil(Time.realtimeSinceStartup)
end

function var_0_0.SetServerTime(arg_10_0, arg_10_1, arg_10_2)
	arg_10_0._serverUnitydelta = arg_10_1 - arg_10_0:RealtimeSinceStartup()
	arg_10_0._sAnchorTime = arg_10_2
	var_0_4 = var_0_5 - arg_10_0._sAnchorTime
	arg_10_0._AnchorDelta = -1 * var_0_4

	arg_10_0:UpdateTimeInfo()
end

function var_0_0.GetServerTime(arg_11_0)
	return arg_11_0:RealtimeSinceStartup() + arg_11_0._serverUnitydelta
end

function var_0_0.GetServerWeek(arg_12_0)
	local var_12_0 = arg_12_0:GetServerTime() - arg_12_0._sAnchorTime

	return math.ceil((var_12_0 % var_0_3 + 1) / var_0_2)
end

function var_0_0.GetGameServerWeek(arg_13_0)
	local var_13_0 = arg_13_0:GetServerTime() - arg_13_0._sAnchorTime - GameSetting.refresh_time1.value[1][1] * 3600

	return math.ceil((var_13_0 % var_0_3 + 1) / var_0_2)
end

function var_0_0.GetServerHour(arg_14_0)
	local var_14_0 = arg_14_0:GetServerTime() - arg_14_0._sAnchorTime

	return math.floor(var_14_0 % var_0_2 / var_0_1)
end

function var_0_0.GetGameServerWeek(arg_15_0)
	local var_15_0 = arg_15_0:GetServerTime() - arg_15_0._sAnchorTime - GameSetting.refresh_time1.value[1][1] * 3600

	return math.ceil((var_15_0 % var_0_3 + 1) / var_0_2)
end

function var_0_0.Table2ServerTime(arg_16_0, arg_16_1)
	arg_16_1.isdst = false

	local var_16_0 = os.date("!*t", arg_16_0:GetServerTime() - arg_16_0._AnchorDelta)
	local var_16_1 = os.time(var_16_0) - os.time(arg_16_1)

	return arg_16_0:GetServerTime() - var_16_1
end

function var_0_0.DescCTime(arg_17_0, arg_17_1, arg_17_2)
	arg_17_2 = arg_17_2 or "!%Y%m%d%H%M%S"

	return os.date(arg_17_2, arg_17_1)
end

function var_0_0.STimeDescS(arg_18_0, arg_18_1, arg_18_2)
	arg_18_2 = arg_18_2 or "!%Y/%m/%d %H:%M:%S"

	return os.date(arg_18_2, arg_18_1 - arg_18_0._AnchorDelta)
end

function var_0_0.ServerTimeDesc(arg_19_0)
	return arg_19_0:DescCTime(arg_19_0:GetServerTime())
end

function var_0_0.GetZeroTime(arg_20_0)
	local var_20_0 = arg_20_0:GetServerTime() + var_0_4

	return math.ceil(var_20_0 / var_0_2) * var_0_2 - var_0_4
end

function var_0_0.GetTimeByHMS(arg_21_0, arg_21_1, arg_21_2, arg_21_3)
	local var_21_0 = os.date("!%Y-%m-%d", arg_21_0:GetServerTime() - arg_21_0._AnchorDelta) .. " " .. arg_21_1 .. ":" .. arg_21_2 .. ":" .. arg_21_3

	return arg_21_0:ParseTimeEx(var_21_0)
end

function var_0_0.GetLastZeroTime(arg_22_0)
	local var_22_0 = arg_22_0:GetServerTime() + var_0_4

	return math.floor(var_22_0 / var_0_2) * var_0_2 - var_0_4
end

function var_0_0.GetNextWeekStartTime(arg_23_0)
	local var_23_0 = arg_23_0:GetServerTime() - 4 * var_0_2 + var_0_4

	return math.ceil(var_23_0 / 604800) * 604800 - var_0_4 + 4 * var_0_2
end

function var_0_0.GetWeekendStartTime(arg_24_0)
	local var_24_0 = arg_24_0:GetServerTime() - 4 * var_0_2 + var_0_4

	return math.ceil(var_24_0 / 604800) * 604800 - var_0_4 + 4 * var_0_2 - 2 * var_0_2
end

function var_0_0.GetNextMonthStartTime(arg_25_0)
	local var_25_0 = arg_25_0:GetServerTime()
	local var_25_1 = tonumber(os.date("!%Y", var_25_0))
	local var_25_2 = (tonumber(os.date("!%m", var_25_0)) + 1) % 12

	if var_25_2 == 0 then
		var_25_2 = 12
	end

	if var_25_2 == 1 then
		var_25_1 = var_25_1 + 1
	end

	return os.time({
		hour = 0,
		min = 0,
		sec = 0,
		day = 1,
		year = var_25_1,
		month = var_25_2
	})
end

function var_0_0.GetNextTime(arg_26_0, arg_26_1, arg_26_2, arg_26_3, arg_26_4)
	arg_26_4 = arg_26_4 or var_0_2

	local var_26_0 = arg_26_0:GetServerTime()
	local var_26_1 = arg_26_1 * var_0_1 + arg_26_2 * 60 + arg_26_3
	local var_26_2 = var_26_0 - (arg_26_0._sAnchorTime + var_26_1)

	return math.floor(var_26_2 / arg_26_4 + 1) * arg_26_4 + arg_26_0._sAnchorTime + var_26_1
end

function var_0_0.GetNextWeekTime(arg_27_0, arg_27_1, arg_27_2, arg_27_3, arg_27_4)
	return arg_27_0:GetNextTime((arg_27_1 - 1) * 24 + arg_27_2, arg_27_3, arg_27_4, var_0_3)
end

function var_0_0.ParseTime(arg_28_0, arg_28_1)
	local var_28_0 = tonumber(arg_28_1)
	local var_28_1 = var_28_0 % 100
	local var_28_2 = var_28_0 / 100
	local var_28_3 = var_28_2 % 100
	local var_28_4 = var_28_2 / 100
	local var_28_5 = var_28_4 % 100
	local var_28_6 = var_28_4 / 100
	local var_28_7 = var_28_6 % 100
	local var_28_8 = var_28_6 / 100
	local var_28_9 = var_28_8 % 100
	local var_28_10 = var_28_8 / 100

	return arg_28_0:Table2ServerTime({
		year = var_28_10,
		month = var_28_9,
		day = var_28_7,
		hour = var_28_5,
		min = var_28_3,
		sec = var_28_1
	})
end

function var_0_0.ParseTimeEx(arg_29_0, arg_29_1, arg_29_2)
	if arg_29_2 == nil then
		arg_29_2 = "(%d+)%-(%d+)%-(%d+)%s(%d+)%:(%d+)%:(%d+)"
	end

	local var_29_0, var_29_1, var_29_2, var_29_3, var_29_4, var_29_5 = arg_29_1:match(arg_29_2)

	return arg_29_0:Table2ServerTime({
		year = var_29_0,
		month = var_29_1,
		day = var_29_2,
		hour = var_29_3,
		min = var_29_4,
		sec = var_29_5
	})
end

function var_0_0.parseTimeFromConfig(arg_30_0, arg_30_1)
	return arg_30_0:Table2ServerTime({
		year = arg_30_1[1][1],
		month = arg_30_1[1][2],
		day = arg_30_1[1][3],
		hour = arg_30_1[2][1],
		min = arg_30_1[2][2],
		sec = arg_30_1[2][3]
	})
end

function var_0_0.DescCDTimeEndMinute(arg_31_0, arg_31_1)
	local var_31_0 = math.floor(arg_31_1 / 3600)

	arg_31_1 = arg_31_1 - var_31_0 * 3600

	local var_31_1 = math.floor(arg_31_1 / 60)

	return string.format("%02d:%02d", var_31_0, var_31_1)
end

function var_0_0.DescCDTime(arg_32_0, arg_32_1)
	local var_32_0 = math.floor(arg_32_1 / 3600)

	arg_32_1 = arg_32_1 - var_32_0 * 3600

	local var_32_1 = math.floor(arg_32_1 / 60)
	local var_32_2 = arg_32_1 % 60

	return string.format("%02d:%02d:%02d", var_32_0, var_32_1, var_32_2)
end

function var_0_0.DescCdTime2(arg_33_0, arg_33_1, arg_33_2)
	local var_33_0 = ""
	local var_33_1 = math.floor(arg_33_1 / 86400)
	local var_33_2 = math.fmod(math.floor(arg_33_1 / 3600), 24)
	local var_33_3 = math.fmod(math.floor(arg_33_1 / 60), 60)
	local var_33_4 = math.fmod(arg_33_1, 60)
	local var_33_5 = GetTips("DAY")
	local var_33_6 = GetTips("HOUR")
	local var_33_7 = GetTips("TIP_MINUTE")
	local var_33_8 = GetTips("SECOND")

	if var_33_1 > 0 then
		var_33_0 = SpliceI18NText({
			var_33_1,
			var_33_5,
			string.format("%02d", var_33_2),
			var_33_6,
			string.format("%02d", var_33_3),
			var_33_7
		})
	elseif var_33_2 > 0 then
		var_33_0 = SpliceI18NText({
			string.format("%02d", var_33_2),
			var_33_6,
			string.format("%02d", var_33_3),
			var_33_7
		})
	elseif var_33_3 > 0 then
		var_33_0 = SpliceI18NText({
			string.format("%02d", var_33_3),
			var_33_7,
			string.format("%02d", var_33_4),
			var_33_8
		})
	elseif var_33_4 > 0 then
		var_33_0 = SpliceI18NText({
			string.format("%02d", var_33_4),
			var_33_8
		})
	else
		var_33_0 = arg_33_2 or "--/--"
	end

	return var_33_0
end

function var_0_0.DescCdTime3(arg_34_0, arg_34_1)
	local var_34_0 = ""
	local var_34_1 = math.floor(arg_34_1 / 86400)
	local var_34_2 = math.fmod(math.floor(arg_34_1 / 3600), 24)
	local var_34_3 = math.fmod(math.floor(arg_34_1 / 60), 60)
	local var_34_4 = math.fmod(arg_34_1, 60)
	local var_34_5 = GetTips("DAY")
	local var_34_6 = GetTips("HOUR")
	local var_34_7 = GetTips("MINUTE")
	local var_34_8 = GetTips("SECOND")

	if var_34_1 > 0 then
		var_34_0 = string.format("%s%s%02d:%02d:%02d", var_34_1, var_34_5, var_34_2, var_34_3, var_34_4)
	elseif var_34_2 > 0 then
		var_34_0 = string.format("%d:%02d:%02d", var_34_2, var_34_3, var_34_4)
	elseif var_34_3 > 0 then
		var_34_0 = string.format("%d:%02d:%02d", var_34_2, var_34_3, var_34_4)
	elseif var_34_4 > 0 then
		var_34_0 = string.format("%d:%02d:%02d", var_34_2, var_34_3, var_34_4)
	else
		var_34_0 = "--/--"
	end

	return var_34_0
end

function var_0_0.DescCDTime4(arg_35_0, arg_35_1)
	local var_35_0 = math.floor(arg_35_1 / 60)
	local var_35_1 = arg_35_1 % 60

	return string.format("%02d:%02d", var_35_0, var_35_1)
end

function var_0_0.parseTimeForm(arg_36_0, arg_36_1)
	local var_36_0 = math.floor(arg_36_1 / 86400)
	local var_36_1 = math.fmod(math.floor(arg_36_1 / 3600), 24)
	local var_36_2 = math.fmod(math.floor(arg_36_1 / 60), 60)
	local var_36_3 = math.fmod(arg_36_1, 60)

	return var_36_0, var_36_1, var_36_2, var_36_3
end

function var_0_0.CalcMonthDays(arg_37_0, arg_37_1, arg_37_2)
	local var_37_0 = 30
	local var_37_1 = {
		1,
		3,
		5,
		7,
		8,
		10,
		12
	}

	if arg_37_2 == 2 then
		if arg_37_1 % 100 == 0 then
			var_37_0 = arg_37_1 % 400 == 0 and 29 or 28
		else
			var_37_0 = arg_37_1 % 4 == 0 and 29 or 28
		end
	elseif table.indexof(var_37_1, arg_37_2) then
		var_37_0 = 31
	end

	return var_37_0
end

function var_0_0.WrapTimeStrWithTips(arg_38_0, arg_38_1)
	arg_38_1 = arg_38_1 or "LEFT_TIME"

	if arg_38_0 then
		return GetTipsF(arg_38_1, arg_38_0)
	end
end

local function var_0_6(arg_39_0, arg_39_1)
	return function(...)
		local var_40_0 = arg_39_0(...)

		return var_0_0.WrapTimeStrWithTips(var_40_0, arg_39_1)
	end
end

var_0_0.WrapTimeStrFunc = var_0_6

function var_0_0.GetLostTimeStr(arg_41_0, arg_41_1, arg_41_2, arg_41_3)
	local var_41_0 = 1

	if arg_41_2 then
		var_41_0 = 0
	end

	local var_41_1 = arg_41_1 - arg_41_0:GetServerTime()
	local var_41_2 = math.floor(var_41_1 / 86400)
	local var_41_3 = math.fmod(math.floor(var_41_1 / 3600), 24)
	local var_41_4 = math.fmod(math.floor(var_41_1 / 60), 60)
	local var_41_5 = math.fmod(var_41_1, 60)

	if var_41_2 > 0 then
		return var_41_2 + var_41_0 .. GetTips("DAY")
	elseif var_41_3 > 0 then
		return var_41_3 + var_41_0 .. GetTips("HOUR")
	elseif var_41_4 > 0 then
		return var_41_4 + var_41_0 .. GetTips("MINUTE")
	elseif var_41_5 > 0 then
		return var_41_5 .. GetTips("SECOND")
	elseif arg_41_3 then
		return 1 .. GetTips("SECOND")
	else
		return GetTips("TIME_OUT")
	end
end

var_0_0.GetLostTimeStrWithPrefix = var_0_6(var_0_0.GetLostTimeStr)

function var_0_0.GetLostTimeStr2(arg_42_0, arg_42_1, arg_42_2, arg_42_3)
	local var_42_0 = 1

	if arg_42_2 then
		var_42_0 = 0
	end

	local var_42_1 = arg_42_1 - arg_42_0:GetServerTime()
	local var_42_2 = math.floor(var_42_1 / 86400)
	local var_42_3 = math.fmod(math.floor(var_42_1 / 3600), 24)
	local var_42_4 = math.fmod(math.floor(var_42_1 / 60), 60)
	local var_42_5 = math.fmod(var_42_1, 60)

	if var_42_2 > 0 then
		return var_42_2 + var_42_0 .. GetTips("DAY")
	elseif var_42_3 > 0 then
		return var_42_3 + var_42_0 .. GetTips("HOUR")
	elseif var_42_4 > 0 then
		return var_42_4 + var_42_0 .. GetTips("MINUTE")
	elseif var_42_5 > 0 then
		return 1 .. GetTips("MINUTE")
	elseif arg_42_3 then
		return 1 .. GetTips("MINUTE")
	else
		return GetTips("TIME_OUT")
	end
end

var_0_0.GetLostTimeSt2WithPrefix = var_0_6(var_0_0.GetLostTimeStr2)

function var_0_0.GetLostTimeStrWith2Unit(arg_43_0, arg_43_1, arg_43_2)
	if not arg_43_1 then
		return
	end

	local var_43_0 = arg_43_1 - arg_43_0:GetServerTime()
	local var_43_1 = math.floor(var_43_0 / 86400)
	local var_43_2 = math.fmod(math.floor(var_43_0 / 3600), 24)
	local var_43_3 = math.fmod(math.floor(var_43_0 / 60), 60)
	local var_43_4 = math.fmod(var_43_0, 60)
	local var_43_5 = ""
	local var_43_6 = GetTips("DAY")
	local var_43_7 = GetTips("HOUR")
	local var_43_8 = GetTips("MINUTE")
	local var_43_9 = GetTips("SECOND")

	if var_43_1 > 0 then
		if var_43_3 > 0 or var_43_3 == 0 and var_43_4 > 0 then
			var_43_2 = var_43_2 + 1
		end

		if var_43_2 >= 24 then
			var_43_2 = var_43_2 - 24
			var_43_1 = var_43_1 + 1
		end

		var_43_5 = var_43_1 .. var_43_6 .. var_43_2 .. var_43_7
	elseif var_43_2 > 0 then
		if var_43_4 > 0 then
			var_43_3 = var_43_3 + 1
		end

		if var_43_3 >= 60 then
			var_43_3 = var_43_3 - 60
			var_43_2 = var_43_2 + 1
		end

		if var_43_2 == 24 then
			var_43_5 = 1 .. var_43_6 .. 0 .. var_43_7
		else
			var_43_5 = var_43_2 .. var_43_7 .. var_43_3 .. var_43_8
		end
	elseif var_43_3 > 0 then
		var_43_5 = var_43_3 .. var_43_8 .. var_43_4 .. var_43_9
	elseif var_43_4 > 0 then
		var_43_5 = var_43_4 .. var_43_9
	elseif arg_43_2 then
		var_43_5 = 0 .. var_43_7 .. 1 .. var_43_8
	else
		return GetTips("TIME_OUT")
	end

	return var_43_5
end

var_0_0.GetLostTimeStrWith2UnitWithPrefix = var_0_6(var_0_0.GetLostTimeStrWith2Unit)

function var_0_0.GetLostTimeStrWith3Unit(arg_44_0, arg_44_1, arg_44_2)
	if not arg_44_1 then
		return
	end

	local var_44_0 = arg_44_1 - arg_44_0:GetServerTime()
	local var_44_1 = math.floor(var_44_0 / 86400)
	local var_44_2 = math.fmod(math.floor(var_44_0 / 3600), 24)
	local var_44_3 = math.fmod(math.floor(var_44_0 / 60), 60)
	local var_44_4 = math.fmod(var_44_0, 60)
	local var_44_5 = ""
	local var_44_6 = GetTips("DAY")
	local var_44_7 = GetTips("HOUR")
	local var_44_8 = GetTips("MINUTE")
	local var_44_9 = GetTips("SECOND")

	if var_44_1 > 0 then
		if var_44_4 > 0 then
			var_44_3 = var_44_3 + 1
		end

		if var_44_3 >= 60 then
			var_44_3 = var_44_3 - 60
			var_44_2 = var_44_2 + 1
		end

		if var_44_2 >= 24 then
			var_44_2 = var_44_2 - 24
			var_44_1 = var_44_1 + 1
		end

		var_44_5 = var_44_1 .. var_44_6 .. var_44_2 .. var_44_7 .. var_44_3 .. var_44_8
	elseif var_44_2 > 0 then
		if var_44_3 >= 60 then
			var_44_3 = var_44_3 - 60
			var_44_2 = var_44_2 + 1
		end

		if var_44_2 == 24 then
			var_44_5 = 1 .. var_44_6 .. 0 .. var_44_7 .. var_44_4 .. var_44_9
		else
			var_44_5 = var_44_2 .. var_44_7 .. var_44_3 .. var_44_8 .. var_44_4 .. var_44_9
		end
	elseif var_44_3 > 0 then
		var_44_5 = 0 .. var_44_7 .. var_44_3 .. var_44_8 .. var_44_4 .. var_44_9
	elseif var_44_4 > 0 then
		var_44_5 = 0 .. var_44_7 .. 0 .. var_44_8 .. var_44_4 .. var_44_9
	elseif arg_44_2 then
		var_44_5 = 0 .. var_44_7 .. 1 .. var_44_8
	else
		return GetTips("TIME_OUT")
	end

	return var_44_5
end

function var_0_0.GetLostTimeLongStr(arg_45_0, arg_45_1)
	local var_45_0 = arg_45_1 - arg_45_0:GetServerTime()
	local var_45_1 = math.floor(var_45_0 / 86400)
	local var_45_2 = math.fmod(math.floor(var_45_0 / 3600), 24)
	local var_45_3 = math.fmod(math.floor(var_45_0 / 60), 60)
	local var_45_4 = math.fmod(var_45_0, 60)
	local var_45_5 = ""
	local var_45_6 = GetTips("DAY")
	local var_45_7 = GetTips("HOUR")
	local var_45_8 = GetTips("MINUTE")
	local var_45_9 = GetTips("SECOND")

	if var_45_1 > 0 then
		var_45_5 = SpliceI18NText({
			var_45_1,
			var_45_6,
			string.format("%02d", var_45_2),
			var_45_7,
			string.format("%02d", var_45_3),
			var_45_8
		})
	elseif var_45_2 > 0 then
		var_45_5 = SpliceI18NText({
			string.format("%02d", var_45_2),
			var_45_7,
			string.format("%02d", var_45_3),
			var_45_8
		})
	elseif var_45_3 > 0 then
		var_45_5 = SpliceI18NText({
			string.format("%02d", var_45_3),
			var_45_8
		})
	elseif var_45_4 > 0 then
		var_45_5 = string.format("1%s", var_45_8)
	else
		var_45_5 = GetTips("TIME_OUT")
	end

	return var_45_5
end

var_0_0.GetLostTimeLongStrWithPrefix = var_0_6(var_0_0.GetLostTimeLongStr)

function var_0_0.GetBeforeTimeStr(arg_46_0, arg_46_1)
	local var_46_0 = arg_46_0:GetServerTime() - arg_46_1
	local var_46_1 = math.floor(var_46_0 / 86400)
	local var_46_2 = math.fmod(math.floor(var_46_0 / 3600), 24)
	local var_46_3 = math.fmod(math.floor(var_46_0 / 60), 60)
	local var_46_4 = math.fmod(var_46_0, 60)

	if var_46_1 > 0 then
		return SpliceI18NText({
			var_46_1 + 1,
			GetTips("DAY"),
			GetTips("BEFORE")
		})
	elseif var_46_2 > 0 then
		return SpliceI18NText({
			var_46_2 + 1,
			GetTips("HOUR"),
			GetTips("BEFORE")
		})
	elseif var_46_3 > 0 then
		return SpliceI18NText({
			var_46_3 + 1,
			GetTips("MINUTE"),
			GetTips("BEFORE")
		})
	elseif var_46_4 > 0 then
		return SpliceI18NText({
			var_46_4,
			GetTips("SECOND"),
			GetTips("BEFORE")
		})
	else
		return GetTips("BLANK")
	end
end

function var_0_0.CheckIsToday(arg_47_0, arg_47_1, arg_47_2)
	local var_47_0 = arg_47_1 + var_0_4 - GameSetting.refresh_time1.value[1][1] * 3600
	local var_47_1 = arg_47_2 + var_0_4 - GameSetting.refresh_time1.value[1][1] * 3600

	return math.floor(var_47_0 / 86400) == math.floor(var_47_1 / 86400)
end

function var_0_0.GetDeltaToday(arg_48_0)
	return arg_48_0:GetToday(manager.time:GetServerTime() - GameSetting.refresh_time1.value[1][1] * 3600)
end

function var_0_0.GetNextFreshTime(arg_49_0)
	return arg_49_0:GetTodayFreshTime() + var_0_2
end

function var_0_0.GetTodayFreshTime(arg_50_0)
	local var_50_0 = arg_50_0:GetServerTime()

	if tonumber(arg_50_0:STimeDescS(var_50_0, "!%H")) < GameSetting.refresh_time1.value[1][1] then
		return manager.time:GetTimeByHMS(GameSetting.refresh_time1.value[1][1], 0, 0) - var_0_2
	else
		return manager.time:GetTimeByHMS(GameSetting.refresh_time1.value[1][1], 0, 0)
	end
end

function var_0_0.GetToday(arg_51_0, arg_51_1, arg_51_2)
	local var_51_0 = arg_51_1 or arg_51_0:GetServerTime()

	arg_51_2 = arg_51_2 or "!%d"

	return tonumber(arg_51_0:STimeDescS(var_51_0, arg_51_2))
end

function var_0_0.IsToday(arg_52_0, arg_52_1)
	local var_52_0 = arg_52_1 + var_0_4
	local var_52_1 = arg_52_0:GetServerTime() + var_0_4

	return math.floor(var_52_0 / 86400) == math.floor(var_52_1 / 86400)
end

function var_0_0.DiffDay(arg_53_0, arg_53_1, arg_53_2)
	return math.floor((arg_53_2 - arg_53_0._sAnchorTime) / var_0_2) - math.floor((arg_53_1 - arg_53_0._sAnchorTime) / var_0_2)
end

function var_0_0.DiffDay2(arg_54_0, arg_54_1, arg_54_2)
	local var_54_0
	local var_54_1 = math.floor(arg_54_1 / 86400)
	local var_54_2 = math.fmod(math.floor(arg_54_1 / 3600), 24)
	local var_54_3 = math.fmod(math.floor(arg_54_1 / 60), 60)
	local var_54_4 = math.fmod(arg_54_1, 60)
	local var_54_5 = math.floor(arg_54_2 / 86400)
	local var_54_6 = math.fmod(math.floor(arg_54_2 / 3600), 24)
	local var_54_7 = math.fmod(math.floor(arg_54_2 / 60), 60)
	local var_54_8 = math.fmod(arg_54_2, 60)

	return var_54_5 - var_54_1
end

function var_0_0.IsSameDay(arg_55_0, arg_55_1, arg_55_2)
	return math.floor((arg_55_1 - arg_55_0._sAnchorTime) / var_0_2) == math.floor((arg_55_2 - arg_55_0._sAnchorTime) / var_0_2)
end

function var_0_0.GetMonth(arg_56_0, arg_56_1, arg_56_2)
	local var_56_0 = arg_56_1 or arg_56_0:GetServerTime()

	arg_56_2 = arg_56_2 or "!%m"

	return tonumber(arg_56_0:STimeDescS(var_56_0, arg_56_2))
end

function var_0_0.GetMonthEn(arg_57_0, arg_57_1)
	local var_57_0 = tonumber(os.date("!%m", arg_57_1))

	if var_57_0 == 1 then
		return "Jan."
	end

	if var_57_0 == 2 then
		return "Feb."
	end

	if var_57_0 == 3 then
		return "Mar."
	end

	if var_57_0 == 4 then
		return "Apr."
	end

	if var_57_0 == 5 then
		return "May."
	end

	if var_57_0 == 6 then
		return "Jun."
	end

	if var_57_0 == 7 then
		return "Jul."
	end

	if var_57_0 == 8 then
		return "Aug."
	end

	if var_57_0 == 9 then
		return "Sep."
	end

	if var_57_0 == 10 then
		return "Oct."
	end

	if var_57_0 == 11 then
		return "Nov."
	end

	if var_57_0 == 12 then
		return "Dec."
	end
end

function var_0_0.FormatTime(arg_58_0, arg_58_1)
	local var_58_0 = tonumber(os.date("!%Y", arg_58_1))
	local var_58_1 = arg_58_0:GetServerTime()

	if var_58_0 ~= tonumber(os.date("!%Y", var_58_1)) then
		return os.date("%Y/%m/%d %H:%M", arg_58_1)
	elseif not arg_58_0:IsSameDay(arg_58_1, var_58_1) then
		return os.date("%m/%d %H:%M", arg_58_1)
	else
		return os.date("%H:%M", arg_58_1)
	end
end

function var_0_0.FormatChatTime(arg_59_0, arg_59_1)
	local var_59_0 = tonumber(os.date("!%Y", arg_59_1))
	local var_59_1 = arg_59_0:GetServerTime()

	if var_59_0 ~= tonumber(os.date("!%Y", var_59_1)) then
		return os.date("%Y/%m/%d", arg_59_1)
	elseif not arg_59_0:IsSameDay(arg_59_1, var_59_1) then
		return os.date("%m/%d", arg_59_1)
	else
		return os.date("%H:%M", arg_59_1)
	end
end

function var_0_0.GetOnLineText(arg_60_0, arg_60_1)
	if arg_60_1 == 0 then
		return GetTips("ONLINE")
	end

	local var_60_0 = arg_60_0:GetServerTime() - arg_60_1

	if var_60_0 < 3600 then
		return GetTips("FRIEND_ONLINE_TIME_WITHIN_AN_HOUR")
	elseif var_60_0 < 86400 then
		return GetTips("FRIEND_ONLINE_TIME_IN_ONE_DAY")
	elseif var_60_0 < 2592000 then
		local var_60_1 = var_60_0 / 86400

		return string.format(GetTips("FRIEND_ONLINE_TIME_ONE_DAY_AGO"), math.floor(var_60_1))
	else
		return string.format(GetTips("FRIEND_ONLINE_TIME_ONE_DAY_AGO"), 30)
	end
end

function var_0_0.GetIsSameDate(arg_61_0, arg_61_1, arg_61_2)
	local var_61_0 = arg_61_0:GetServerTime()
	local var_61_1 = tonumber(os.date("!%m", var_61_0))
	local var_61_2 = tonumber(os.date("!%d", var_61_0))

	if arg_61_1 == var_61_1 and var_61_2 == arg_61_2 then
		return true
	end

	return false
end

function var_0_0.CalcTimeZone(arg_62_0)
	local var_62_0 = os.time()

	return os.difftime(var_62_0, os.time(os.date("!*t", var_62_0)))
end

function var_0_0.GetTimeZone(arg_63_0)
	return arg_63_0.timeZero_
end

function var_0_0.GetDeltaTimeZone(arg_64_0)
	return arg_64_0.deltaTimeZero_
end

function var_0_0.GetTwelveHourClockTimeText(arg_65_0)
	local var_65_0 = os.time()
	local var_65_1 = os.difftime(var_65_0, os.time(os.date("!*t", var_65_0)))
	local var_65_2 = os.date("!*t", var_65_0 + var_65_1)

	if var_65_2.hour >= 12 then
		if var_65_2.hour == 12 then
			return string.format("%02d:%02dPM", tonumber(var_65_2.hour), tonumber(var_65_2.min))
		else
			return string.format("%02d:%02dPM", tonumber(var_65_2.hour) - 12, tonumber(var_65_2.min))
		end
	elseif var_65_2.hour == 0 then
		return string.format("%02d:%02dAM", 12, tonumber(var_65_2.min))
	else
		return string.format("%02d:%02dAM", tonumber(var_65_2.hour), tonumber(var_65_2.min))
	end

	return ""
end

return var_0_0
