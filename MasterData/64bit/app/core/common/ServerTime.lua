local ServerTime = class("ServerTime")
local var_0_1 = table.concat

local function var_0_2()
	local var_1_0 = os.time()

	return os.difftime(var_1_0, os.time(os.date("!*t", var_1_0)))
end

function ServerTime:ctor(arg_2_1, arg_2_2)
	self._zone = 8
	self._diff = 0
	self._t = os.time()
	self._lastSetTime = self._t
	self._openTime = 0
end

function ServerTime:setTime(arg_3_1, arg_3_2)
	self._t = arg_3_1
	self._zone = arg_3_2
	self._lastSetTime = os.time()
	self._diff = var_0_2() - arg_3_2 * 3600
end

function ServerTime:_getDiff(arg_4_1)
	if os.date("*t", arg_4_1 - self._diff).isdst then
		return self._diff + 3600
	end

	return self._diff
end

function ServerTime:getTime()
	return self._t + (os.time() - self._lastSetTime)
end

function ServerTime:getDateObject(arg_6_1)
	if arg_6_1 == nil or arg_6_1 == 0 then
		arg_6_1 = self:getTime()
	end

	return (os.date("*t", arg_6_1 - self:_getDiff(arg_6_1)))
end

function ServerTime:getDate(arg_7_1)
	local var_7_0 = self:getDateObject(arg_7_1)

	return string.format("%04d-%02d-%02d", var_7_0.year, var_7_0.month, var_7_0.day)
end

function ServerTime:getTimeString(arg_8_1)
	if arg_8_1 == nil then
		arg_8_1 = self:getTime()
	end

	local var_8_0 = os.date("*t", arg_8_1 - self:_getDiff(arg_8_1))

	return string.format("%04d-%02d-%02d %02d:%02d:%02d", var_8_0.year, var_8_0.month, var_8_0.day, var_8_0.hour, var_8_0.min, var_8_0.sec)
end

function ServerTime:getTimeStringEx(arg_9_1, arg_9_2)
	if arg_9_1 == nil then
		arg_9_1 = self:getTime()
	end

	local var_9_0 = os.date("*t", arg_9_1 - self:_getDiff(arg_9_1))

	if arg_9_2 then
		return string.format("%04d.%02d.%02d", var_9_0.year, var_9_0.month, var_9_0.day)
	end

	return string.format("%02d-%02d %02d:%02d", var_9_0.month, var_9_0.day, var_9_0.hour, var_9_0.min)
end

function ServerTime:getTimeStringHMS(arg_10_1)
	if arg_10_1 == nil then
		arg_10_1 = self:getTime()
	end

	local var_10_0 = os.date("*t", arg_10_1 - self:_getDiff(arg_10_1))

	return string.format("%02d:%02d:%02d", var_10_0.hour, var_10_0.min, var_10_0.sec)
end

function ServerTime:getLeftSeconds(arg_11_1)
	if arg_11_1 == nil then
		arg_11_1 = 0
	end

	return arg_11_1 - self:getTime()
end

function ServerTime:getLeftSecondsString(arg_12_1)
	local var_12_0, var_12_1, var_12_2, var_12_3 = self:getLeftTimeParts(arg_12_1)

	if var_12_0 + var_12_1 + var_12_2 + var_12_3 == 0 then
		return "-"
	else
		return string.format("%02d:%02d:%02d", var_12_0 * 24 + var_12_1, var_12_2, var_12_3)
	end
end

function ServerTime:getLeftTimeParts(arg_13_1)
	local var_13_0 = self:getLeftSeconds(arg_13_1)

	if var_13_0 < 0 then
		return 0, 0, 0, 0
	else
		return ((var_13_0 - var_13_0 % 3600) / 3600 - (var_13_0 - var_13_0 % 3600) / 3600 % 24) / 24, (var_13_0 - var_13_0 % 3600) / 3600 % 24, (var_13_0 - (var_13_0 - var_13_0 % 3600) / 3600 * 3600 - var_13_0 % 60) / 60, var_13_0 % 60
	end
end

function ServerTime:getAwardLeftTime(arg_14_1, arg_14_2, arg_14_3)
	local var_14_0 = os.date("*t", self:getTime() - self:_getDiff(self:getTime()))

	if var_14_0.hour * 3600 + var_14_0.min * 60 + var_14_0.sec < arg_14_1 * 3600 + arg_14_2 * 60 + arg_14_3 then
		return self:_secondToString(arg_14_1 * 3600 + arg_14_2 * 60 + arg_14_3 - (var_14_0.hour * 3600 + var_14_0.min * 60 + var_14_0.sec))
	else
		return "_"
	end
end

function ServerTime:getTimeStrSimple(arg_15_1)
	local var_15_0 = math.floor(arg_15_1 / 86400 / 365)

	if var_15_0 >= 1 then
		return var_0_1({
			var_15_0,
			g.core.lang:get(1221)
		})
	end

	local var_15_1 = math.floor(arg_15_1 / 86400 / 30)

	if var_15_1 >= 1 then
		return var_0_1({
			var_15_1,
			g.core.lang:get(1145)
		})
	end

	local var_15_2 = math.floor(arg_15_1 / 86400)

	if var_15_2 >= 1 then
		return var_0_1({
			var_15_2,
			g.core.lang:get(1179)
		})
	end

	local var_15_3 = math.floor(arg_15_1 / 3600)

	if var_15_3 >= 1 then
		return var_0_1({
			var_15_3,
			g.core.lang:get(1182)
		})
	end

	local var_15_4 = math.floor(arg_15_1 / 60)

	if var_15_4 >= 1 then
		return var_0_1({
			var_15_4,
			g.core.lang:get(1180)
		})
	end

	return var_0_1({
		arg_15_1,
		g.core.lang:get(1181)
	})
end

function ServerTime:getOpenLeftTime(arg_16_1, arg_16_2, arg_16_3)
	local var_16_0 = self:getDateObject()

	return arg_16_1 * 3600 + arg_16_2 * 60 + arg_16_3 - (var_16_0.hour * 3600 + var_16_0.min * 60 + var_16_0.sec)
end

function ServerTime:_secondToString(arg_17_1)
	local var_17_0 = (arg_17_1 - (arg_17_1 - arg_17_1 % 3600) / 3600 * 3600 - arg_17_1 % 60) / 60
	local var_17_1 = arg_17_1 % 60
	local var_17_2 = ""

	var_17_2 = (arg_17_1 - arg_17_1 % 3600) / 3600 < 10 and var_0_1({
		var_17_2,
		"0",
		(arg_17_1 - arg_17_1 % 3600) / 3600,
		":"
	}) or var_0_1({
		var_17_2,
		(arg_17_1 - arg_17_1 % 3600) / 3600,
		":"
	})
	var_17_2 = var_17_0 < 10 and var_0_1({
		var_17_2,
		"0",
		var_17_0,
		":"
	}) or var_0_1({
		var_17_2,
		var_17_0,
		":"
	})
	var_17_2 = var_17_1 < 10 and var_0_1({
		var_17_2,
		"0",
		var_17_1
	}) or var_0_1({
		var_17_2,
		var_17_1
	})

	return var_17_2
end

function ServerTime:secondToDHMString(arg_18_1)
	local var_18_0 = math.floor(arg_18_1 / 60) % 60

	return (arg_18_1 - arg_18_1 % 86400) / 86400 > 0 and g.core.lang:get(1052, {
		day = (arg_18_1 - arg_18_1 % 86400) / 86400,
		hour = (arg_18_1 - (arg_18_1 - arg_18_1 % 86400) / 86400 * 86400 - arg_18_1 % 3600) / 3600,
		minute = var_18_0
	}) or g.core.lang:get(1060, {
		hour = (arg_18_1 - (arg_18_1 - arg_18_1 % 86400) / 86400 * 86400 - arg_18_1 % 3600) / 3600,
		minute = var_18_0,
		second = arg_18_1 % 60
	})
end

function ServerTime:secondToHMString(arg_19_1)
	local var_19_0 = math.floor(arg_19_1 / 3600)
	local var_19_1 = math.ceil(arg_19_1 / 60 % 60)
	local var_19_2 = ""

	var_19_2 = var_19_0 < 10 and var_0_1({
		var_19_2,
		"0",
		var_19_0,
		":"
	}) or var_0_1({
		var_19_2,
		var_19_0,
		":"
	})
	var_19_2 = var_19_1 < 10 and var_0_1({
		var_19_2,
		"0",
		var_19_1
	}) or var_0_1({
		var_19_2,
		var_19_1
	})

	return var_19_2
end

function ServerTime:secondToHMSString(arg_20_1)
	local var_20_0 = (arg_20_1 - (arg_20_1 - arg_20_1 % 3600) / 3600 * 3600 - arg_20_1 % 60) / 60
	local var_20_1 = arg_20_1 % 60
	local var_20_2 = ""

	var_20_2 = (arg_20_1 - arg_20_1 % 3600) / 3600 < 10 and var_0_1({
		var_20_2,
		"0",
		(arg_20_1 - arg_20_1 % 3600) / 3600,
		":"
	}) or var_0_1({
		var_20_2,
		(arg_20_1 - arg_20_1 % 3600) / 3600,
		":"
	})
	var_20_2 = var_20_0 < 10 and var_0_1({
		var_20_2,
		"0",
		var_20_0,
		":"
	}) or var_0_1({
		var_20_2,
		var_20_0,
		":"
	})
	var_20_2 = var_20_1 < 10 and var_0_1({
		var_20_2,
		"0",
		var_20_1
	}) or var_0_1({
		var_20_2,
		var_20_1
	})

	return var_20_2
end

function ServerTime:secondToMSString(arg_21_1)
	local var_21_0 = arg_21_1 % 60
	local var_21_1 = ""

	var_21_1 = (arg_21_1 - arg_21_1 % 60) / 60 < 10 and var_0_1({
		var_21_1,
		"0",
		(arg_21_1 - arg_21_1 % 60) / 60,
		":"
	}) or var_0_1({
		var_21_1,
		(arg_21_1 - arg_21_1 % 60) / 60,
		":"
	})
	var_21_1 = var_21_0 < 10 and var_0_1({
		var_21_1,
		"0",
		var_21_0
	}) or var_0_1({
		var_21_1,
		var_21_0
	})

	return var_21_1
end

function ServerTime:getCurrentHHMMSS(arg_22_1)
	local var_22_0 = self:getDateObject(arg_22_1)

	return var_22_0.hour, var_22_0.min, var_22_0.sec
end

function ServerTime:secondsFromToday(arg_23_1)
	arg_23_1 = arg_23_1 or self:getTime()

	local var_23_0 = self:getTime()
	local var_23_1 = self:getDateObject(var_23_0)

	return arg_23_1 - (var_23_0 - var_23_1.hour * 3600 - var_23_1.min * 60 - var_23_1.sec)
end

function ServerTime:getNextNDayZeroTime(arg_24_1, arg_24_2)
	arg_24_1 = arg_24_1 or self:getTime()

	local var_24_0 = self:getDateObject(arg_24_1)

	return arg_24_1 - var_24_0.hour * 3600 - var_24_0.min * 60 - var_24_0.sec + (arg_24_2 - 1) * 86400
end

function ServerTime:secondsFromCurMonday(arg_25_1)
	arg_25_1 = arg_25_1 or self:getTime()

	local var_25_0 = self:getTime()
	local var_25_1 = self:getWeekDay()

	if var_25_1 == 0 then
		var_25_1 = 7
	end

	return arg_25_1 - (var_25_0 - ((var_25_1 - 1) * 24 * 3600 + self:secondsFromToday()))
end

function ServerTime:isDifferentMonth(arg_26_1)
	local var_26_0 = self:getDateObject(self:getTime())
	local var_26_1 = var_26_0.month
	local var_26_2 = self:getDateObject(arg_26_1)

	return var_26_2.year ~= var_26_0.year or var_26_2.month ~= var_26_1
end

function ServerTime:secondsFromMonday(arg_27_1)
	arg_27_1 = arg_27_1 or self:getTime()

	local var_27_0 = self:getWeekDayByTimeTamp(arg_27_1)

	if var_27_0 == 0 then
		var_27_0 = 7
	end

	local var_27_1 = self:getDateObject(arg_27_1)

	return (var_27_0 - 1) * 24 * 3600 + var_27_1.hour * 3600 + var_27_1.min * 60 + var_27_1.sec
end

function ServerTime:getMondayTime(arg_28_1)
	arg_28_1 = arg_28_1 or self:getTime()

	return arg_28_1 - self:secondsFromMonday(arg_28_1)
end

function ServerTime:isSameWeek(arg_29_1)
	return self:getMondayTime(arg_29_1) == self:getMondayTime(self:getTime())
end

function ServerTime:getDeltaDays(arg_30_1, arg_30_2)
	return (self:getZeroClockSeconds(arg_30_2) - self:getZeroClockSeconds(arg_30_1)) / 86400
end

function ServerTime:secondsToTommorrow(arg_31_1)
	local var_31_0 = self:getTime()
	local var_31_1 = self:getDateObject(var_31_0)

	return var_31_0 - var_31_1.hour * 3600 - var_31_1.min * 60 - var_31_1.sec + 86400 - arg_31_1
end

function ServerTime:isToday(arg_32_1)
	local var_32_0 = self:secondsFromToday(arg_32_1)

	if var_32_0 < 0 or 86400 < var_32_0 then
		return false
	end

	return true
end

function ServerTime:isBeforeToday(arg_33_1)
	if self:secondsFromToday(arg_33_1) < 0 then
		return true
	end

	return false
end

function ServerTime:is5ClockExpired(arg_34_1)
	return self:isTimeExpired(arg_34_1, 5)
end

function ServerTime:isTimeExpired(arg_35_1, arg_35_2)
	local var_35_0 = self:getTime()

	return self:secondsFromToday(arg_35_1) < arg_35_2 * 3600 and self:secondsFromToday(var_35_0) >= arg_35_2 * 3600 or var_35_0 - arg_35_1 >= 86400
end

function ServerTime:getDateYMDHMFormat(arg_36_1)
	local var_36_0 = self:getDateObject(arg_36_1)

	return g.core.lang:get(1065, {
		year = var_36_0.year,
		month = var_36_0.month,
		day = var_36_0.day,
		hour = string.format("%02d", var_36_0.hour),
		minute = string.format("%02d", var_36_0.min)
	})
end

function ServerTime:getDateYMDHFormat(arg_37_1)
	local var_37_0 = self:getDateObject(arg_37_1)

	return g.core.lang:get(1053, {
		year = var_37_0.year,
		month = var_37_0.month,
		day = var_37_0.day,
		hour = var_37_0.hour
	})
end

function ServerTime:getDateYMDFormat(arg_38_1)
	local var_38_0 = self:getDateObject(arg_38_1)

	return g.core.lang:get(1055, {
		year = var_38_0.year,
		month = var_38_0.month,
		day = var_38_0.day
	})
end

function ServerTime:getDateYMDFormat2(arg_39_1)
	local var_39_0 = self:getDateObject(arg_39_1)

	return g.core.lang:get(2086, {
		year = var_39_0.year,
		month = var_39_0.month,
		day = var_39_0.day
	})
end

function ServerTime:getDateMDHFormat(arg_40_1)
	local var_40_0 = self:getDateObject(arg_40_1)

	return g.core.lang:get(1056, {
		month = var_40_0.month,
		day = var_40_0.day,
		hour = var_40_0.hour
	})
end

function ServerTime:getDateMDHMFormat(arg_41_1)
	local var_41_0 = self:getDateObject(arg_41_1)

	return g.core.lang:get(1054, {
		month = var_41_0.month,
		day = var_41_0.day,
		hour = string.format("%02d", var_41_0.hour),
		minute = string.format("%02d", var_41_0.min)
	})
end

function ServerTime:getDateMDFormat(arg_42_1)
	local var_42_0 = self:getDateObject(arg_42_1)

	return g.core.lang:get(1057, {
		month = var_42_0.month,
		day = var_42_0.day
	})
end

function ServerTime:getDateMDFormatWithDot(arg_43_1)
	local var_43_0 = self:getDateObject(arg_43_1)

	return g.core.lang:get(1279, {
		month = var_43_0.month,
		day = var_43_0.day
	})
end

function ServerTime:getLeftDHMFormat(arg_44_1)
	local var_44_0 = arg_44_1 - self:getTime()

	if var_44_0 > 0 then
		return g.core.lang:get(1052, {
			day = math.floor(var_44_0 / 86400),
			hour = math.floor(var_44_0 % 86400 / 3600),
			minute = math.floor(var_44_0 % 86400 % 3600 / 60)
		})
	else
		return g.core.lang:get(1052, {
			minute = 0,
			day = 0,
			hour = 0
		})
	end
end

function ServerTime:getLeftHMFormat(arg_45_1)
	local var_45_0 = arg_45_1 - self:getTime()

	if var_45_0 > 0 then
		local var_45_1 = math.floor(var_45_0 / 86400)

		return g.core.lang:get(1059, {
			hour = math.floor(var_45_0 % 86400 / 3600),
			minute = math.floor(var_45_0 % 86400 % 3600 / 60)
		})
	else
		return g.core.lang:get(1059, {
			minute = 0,
			hour = 0
		})
	end
end

function ServerTime:getLeftHMSFormat(arg_46_1)
	local var_46_0 = arg_46_1 - self:getTime()

	if var_46_0 > 0 then
		local var_46_1 = math.floor(var_46_0 / 86400)

		return g.core.lang:get(1060, {
			hour = math.floor(var_46_0 % 86400 / 3600),
			minute = math.floor(var_46_0 % 86400 % 3600 / 60),
			second = var_46_0 % 86400 % 3600 % 60
		})
	else
		return g.core.lang:get(1060, {
			second = 0,
			minute = 0,
			hour = 0
		})
	end
end

function ServerTime:getLeftHMSFormatOverseas(arg_47_1)
	local var_47_0 = arg_47_1 - self:getTime()

	if var_47_0 > 0 then
		local var_47_1 = math.floor(var_47_0 / 86400)

		return g.core.lang:get(1060, {
			hour = string.format("%02d", (math.floor(var_47_0 % 86400 / 3600))),
			minute = string.format("%02d", (math.floor(var_47_0 % 86400 % 3600 / 60))),
			second = string.format("%02d", var_47_0 % 86400 % 3600 % 60)
		})
	else
		return g.core.lang:get(1060, {
			second = "00",
			minute = "00",
			hour = "00"
		})
	end
end

function ServerTime:getLeftDHFormat(arg_48_1)
	local var_48_0 = arg_48_1 - self:getTime()

	if var_48_0 > 0 then
		return g.core.lang:get(1051, {
			day = math.floor(var_48_0 / 86400),
			hour = math.floor(var_48_0 % 86400 / 3600)
		})
	else
		return g.core.lang:get(1051, {
			day = 0,
			hour = 0
		})
	end
end

function ServerTime:getLeftMSFormat(arg_49_1, arg_49_2)
	local var_49_0 = arg_49_1 - self:getTime()

	arg_49_2 = arg_49_2 or false

	if var_49_0 > 0 then
		local var_49_1 = math.floor(var_49_0 / 86400)
		local var_49_2 = math.floor(var_49_0 % 86400 / 3600)
		local var_49_3 = math.floor(var_49_0 % 86400 % 3600 / 60)

		if arg_49_2 then
			return g.core.lang:get(1063, {
				minute = string.format("%02d", var_49_3),
				second = string.format("%02d", var_49_0 % 86400 % 3600 % 60)
			})
		else
			return g.core.lang:get(1062, {
				minute = var_49_3,
				second = var_49_0 % 86400 % 3600 % 60
			})
		end
	elseif arg_49_2 then
		return g.core.lang:get(1063, {
			second = "00",
			minute = "00"
		})
	else
		return g.core.lang:get(1062, {
			second = 0,
			minute = 0
		})
	end
end

function ServerTime:getLeftSecondFormat(arg_50_1)
	local var_50_0 = arg_50_1 - self:getTime()

	if var_50_0 > 0 then
		return g.core.lang:get(1064, {
			second = var_50_0
		})
	else
		return g.core.lang:get(1064, {
			second = 0
		})
	end
end

function ServerTime:getLeftDHMSFormat(arg_51_1)
	local var_51_0 = arg_51_1 - self:getTime()

	if var_51_0 > 86400 then
		return self:getLeftDHFormat(arg_51_1)
	elseif var_51_0 > 3600 then
		return self:getLeftHMFormat(arg_51_1)
	else
		return self:getLeftMSFormat(arg_51_1)
	end
end

function ServerTime:getActivityLeftTime(arg_52_1)
	if arg_52_1 >= 86400 then
		arg_52_1 = arg_52_1 % 86400

		return g.core.lang:get(1051, {
			day = math.floor(arg_52_1 / 86400),
			hour = math.floor(arg_52_1 / 3600)
		}), false
	else
		arg_52_1 = arg_52_1 % 3600

		return string.format("%02d:%02d:%02d", math.floor(arg_52_1 / 3600), math.floor(arg_52_1 / 60), arg_52_1 % 60), true
	end
end

function ServerTime:getTimestampByHMS(arg_53_1, arg_53_2, arg_53_3)
	arg_53_1 = arg_53_1 or 0
	arg_53_2 = arg_53_2 or 0

	local var_53_0

	if not arg_53_3 then
		arg_53_3 = 0
		var_53_0 = self:getTime()
	end

	return var_53_0 - self:secondsFromToday(var_53_0) + (arg_53_1 * 3600 + arg_53_2 * 60 + arg_53_3) or 0
end

function ServerTime:getTimestampBySeconds(arg_54_1)
	local var_54_0 = self:getTime()

	return var_54_0 - self:secondsFromToday(var_54_0) + arg_54_1 or 0
end

function ServerTime:getTargetTimeStampByMD(arg_55_1, arg_55_2)
	arg_55_1 = tonumber(arg_55_1)
	arg_55_2 = tonumber(arg_55_2)

	return self:getYearTime() + self:_getElapsedDays(arg_55_1, arg_55_2) * 86400
end

function ServerTime:getTimeStampByParams(arg_56_1)
	local var_56_0 = self:getDateObject(self:getTime())
	local var_56_1 = arg_56_1.year or var_56_0.year
	local var_56_2 = arg_56_1.month or var_56_0.month
	local var_56_3 = arg_56_1.day or var_56_0.day
	local var_56_4 = arg_56_1.hour or 0
	local var_56_5 = arg_56_1.minute or 0
	local var_56_6 = arg_56_1.second or 0
	local var_56_7 = os.time({
		year = var_56_1,
		month = var_56_2,
		day = var_56_3,
		hour = var_56_4,
		min = var_56_5,
		sec = var_56_6
	})

	return var_56_7 + self:_getDiff(var_56_7)
end

function ServerTime:getEndTimeStamp(arg_57_1, arg_57_2)
	local var_57_0 = arg_57_1
	local var_57_1 = os.date("*t", arg_57_1).isdst
	local var_57_3 = false

	for iter_57_0 = 1, arg_57_2 do
		var_57_0 = var_57_0 + 86400

		if os.date("*t", var_57_0).isdst then
			var_57_1 = true
			var_57_3 = true ~= var_57_1
		else
			var_57_1 = false
			var_57_3 = false ~= var_57_1
		end
	end

	local var_57_4 = arg_57_1 + 86400 * arg_57_2

	if var_57_3 then
		var_57_4 = var_57_1 and var_57_4 - 3600 or var_57_4 + 3600
	end

	return var_57_4
end

function ServerTime:getRemainTimeFromNow(arg_58_1)
	local var_58_0 = self:getTime()
	local var_58_1 = arg_58_1 - var_58_0

	if os.date("*t", var_58_0 - self._diff).isdst then
		var_58_1 = var_58_1 + 3600
	end

	return var_58_1
end

function ServerTime:getTimeByStr(arg_59_1)
	local var_59_0 = string.split(arg_59_1, " ")
	local var_59_1 = string.split(var_59_0[1], "-")
	local var_59_2 = string.split(var_59_0[2], ":")
	local var_59_3 = {}

	var_59_3.year = var_59_1[1] or 0
	var_59_3.month = var_59_1[2] or 0
	var_59_3.day = var_59_1[3] or 0
	var_59_3.hour = var_59_2[1] or 0
	var_59_3.min = var_59_2[2] or 0
	var_59_3.sec = var_59_2[3] or 0

	local var_59_4 = os.time(var_59_3)

	return var_59_4 - self:_getDiff(var_59_4)
end

function ServerTime:getAutoRefreshTargetStamp(arg_60_1, arg_60_2)
	local var_60_0 = self:getTime()
	local var_60_1 = self:getDateObject(arg_60_2 or var_60_0)

	return (arg_60_2 or var_60_0) - (var_60_1.hour * 3600 + var_60_1.min * 60 + var_60_1.sec) + (math.floor((var_60_1.hour * 3600 + var_60_1.min * 60 + var_60_1.sec) / (3600 * arg_60_1)) + 1) * arg_60_1 * 3600
end

function ServerTime:getNextFixRefreshStamp(arg_61_1, arg_61_2)
	local var_61_0 = false
	local var_61_1 = self:getTime()
	local var_61_2 = arg_61_2 or var_61_1
	local var_61_3 = arg_61_2 or var_61_1

	if arg_61_1 == nil or #arg_61_1 < 1 then
		return var_61_3 + 86400
	end

	local var_61_4 = self:secondsFromToday(var_61_2)

	table.sort(arg_61_1, function(arg_62_0, arg_62_1)
		return arg_62_0 < arg_62_1
	end)

	for iter_61_0 = 1, #arg_61_1 do
		if var_61_4 < arg_61_1[iter_61_0] then
			var_61_3 = arg_61_1[iter_61_0] + (var_61_2 - var_61_4)
			var_61_0 = true

			break
		end
	end

	if var_61_0 == false then
		var_61_3 = var_61_2 - var_61_4 + 86400 + arg_61_1[1]
	end

	return var_61_3
end

function ServerTime:getCountDownBySecond(arg_63_1)
	if arg_63_1 <= 0 then
		return "00:00:00"
	end

	local var_63_0 = math.floor(arg_63_1 / 86400)

	arg_63_1 = arg_63_1 % 86400

	if var_63_0 >= 1 then
		return g.core.lang:get(1051, {
			day = var_63_0,
			hour = math.floor(arg_63_1 / 3600)
		})
	else
		return self:secondToHMSString(arg_63_1)
	end
end

function ServerTime:getWeekDay()
	local var_64_0 = self:getTime()

	return tonumber(os.date("%w", var_64_0 - self:_getDiff(var_64_0)))
end

function ServerTime:getWeekDayByTimeTamp(arg_65_1)
	return tonumber(os.date("%w", arg_65_1 - self:_getDiff(arg_65_1)))
end

function ServerTime:getTimerBeforeDHM(arg_66_1, arg_66_2)
	local var_66_0 = self:getTime() - arg_66_1

	var_66_0 = arg_66_2 and var_66_0 < 60 and 60 or var_66_0

	local var_66_1 = math.max(math.floor(var_66_0 / 60), 0)
	local var_66_2 = math.max(math.floor(var_66_0 / 3600), 0)

	if var_66_1 >= 60 then
		if var_66_2 < 24 then
			return g.core.lang:get(1058, {
				time = var_66_2
			})
		else
			return g.core.lang:get(1050, {
				time = math.max(math.floor(var_66_0 / 86400), 0)
			})
		end
	end

	return g.core.lang:get(1061, {
		time = var_66_1
	})
end

function ServerTime:checkTimeArea(arg_67_1, arg_67_2)
	local var_67_0 = self:getDateObject()

	return arg_67_1 <= var_67_0.hour * 3600 + var_67_0.min * 60 + var_67_0.sec and var_67_0.hour * 3600 + var_67_0.min * 60 + var_67_0.sec <= arg_67_2
end

function ServerTime:checkTimeAreaByTypeT(arg_68_1, arg_68_2)
	local var_68_0 = self:getDateObject()

	return arg_68_1 <= var_68_0.hour * 100 + var_68_0.min and var_68_0.hour * 100 + var_68_0.min <= arg_68_2
end

function ServerTime:checkTodayIsHolidayYMD(arg_69_1)
	local var_69_0 = self:getDate()

	return arg_69_1 == var_0_1({
		string.sub(var_69_0, 1, 4),
		string.sub(var_69_0, 6, 7),
		(string.sub(var_69_0, 9, 10))
	})
end

function ServerTime:checkTodayIsHolidayMD(arg_70_1)
	local var_70_0 = self:getDate()

	return arg_70_1 == var_0_1({
		string.sub(var_70_0, 6, 7),
		(string.sub(var_70_0, 9, 10))
	})
end

function ServerTime:getCurWeekCountDown()
	local var_71_0 = self:getWeekDay()

	if var_71_0 == 0 then
		var_71_0 = 7
	end

	local var_71_1 = (7 - var_71_0) * 24 * 3600 + self:getOpenLeftTime(24, 0, 0)
	local var_71_2 = ""
	local var_71_3 = math.max(0, math.floor(var_71_1 / 86400))
	local var_71_4 = math.max(0, math.floor(var_71_1 % 86400 / 3600))
	local var_71_5 = math.max(0, math.floor(var_71_1 % 86400 % 3600 / 60))
	local var_71_6 = math.max(0, var_71_1 % 86400 % 3600 % 60)

	if var_71_3 > 0 then
		var_71_2 = g.core.lang:get(1052, {
			day = var_71_3,
			hour = var_71_4,
			minute = var_71_5
		})
	elseif var_71_3 == 0 and (var_71_4 > 0 or var_71_5 > 0 or var_71_6 > 0) then
		var_71_2 = g.core.lang:get(1060, {
			hour = var_71_4,
			minute = var_71_5,
			second = var_71_6
		})
	end

	return var_71_2
end

function ServerTime:getCurWeekCountDown2()
	local var_72_0 = self:getWeekDay()

	if var_72_0 == 0 then
		var_72_0 = 7
	end

	local var_72_1 = (7 - var_72_0) * 24 * 3600 + self:getOpenLeftTime(24, 0, 0)

	return math.max(0, math.floor(var_72_1 / 86400)), math.max(0, math.floor(var_72_1 % 86400 / 3600)), math.max(0, math.floor(var_72_1 % 86400 % 3600 / 60)), (math.max(0, var_72_1 % 86400 % 3600 % 60))
end

function ServerTime:getHourTime(arg_73_1)
	local var_73_0 = math.floor((arg_73_1 + 86400) % 86400 / 3600)

	return string.format("%02d:%02d", var_73_0, (math.floor(((arg_73_1 + 86400) % 86400 - var_73_0 * 3600) / 60)))
end

function ServerTime:setOpenTime(arg_74_1)
	self._openTime = arg_74_1
end

function ServerTime:getOpenDuringTime(arg_75_1)
	return (arg_75_1 or self:getTime()) - self._openTime
end

function ServerTime:getOpenTime()
	return self._openTime
end

function ServerTime:getOpenTimeFromZero()
	local var_77_0 = self:getDateObject(self._openTime)

	return var_77_0.hour * 3600 + var_77_0.min * 60 + var_77_0.sec
end

function ServerTime:getCreateTimeFromZero()
	local var_78_0 = self:getDateObject((g.core.model.User:getCreateTime()))

	return var_78_0.hour * 3600 + var_78_0.min * 60 + var_78_0.sec
end

function ServerTime:getTimeFromZero(arg_79_1)
	local var_79_0 = self:getDateObject(arg_79_1 or self._openTime)

	return var_79_0.hour * 3600 + var_79_0.min * 60 + var_79_0.sec
end

function ServerTime:getTimeByOpenDay(arg_80_1)
	return self._openTime - self:getOpenTimeFromZero() + (arg_80_1 - 1) * 86400
end

function ServerTime:getTimeByCreateRole(arg_81_1)
	return g.core.model.User:getCreateTime() - self:getCreateTimeFromZero() + (arg_81_1 - 1) * 86400
end

function ServerTime:getZeroClockSeconds(arg_82_1)
	arg_82_1 = arg_82_1 or self:getTime()

	local var_82_0 = self:getDateObject(arg_82_1)

	return arg_82_1 - var_82_0.hour * 3600 - var_82_0.min * 60 - var_82_0.sec
end

function ServerTime:getCreateDuringTime()
	return self:getTime() - g.core.model.User:getCreateTime()
end

function ServerTime:getCreateRoleDays(arg_84_1)
	return (math.ceil(((arg_84_1 or self:getTime()) - self:getZeroClockSeconds((g.core.model.User:getCreateTime()))) / 3600 / 24))
end

function ServerTime:getOpenDays(arg_85_1)
	local var_85_0 = self:getOpenDuringTime(arg_85_1)
	local var_85_1 = self:getOpenTimeFromZero()
	local var_85_2 = math.ceil((var_85_0 + var_85_1) / 86400)

	if (var_85_0 + var_85_1) % 86400 == 0 then
		var_85_2 = var_85_2 + 1
	end

	return var_85_2
end

function ServerTime:getDays(arg_86_1, arg_86_2)
	local var_86_0 = self:getDateObject(arg_86_1)
	local var_86_1 = math.ceil((arg_86_2 - arg_86_1 + (var_86_0.hour * 3600 + var_86_0.min * 60 + var_86_0.sec)) / 86400)

	if (arg_86_2 - arg_86_1 + (var_86_0.hour * 3600 + var_86_0.min * 60 + var_86_0.sec)) % 86400 == 0 then
		var_86_1 = var_86_1 + 1
	end

	return var_86_1
end

function ServerTime:getIsSameDay(arg_87_1)
	local var_87_0 = os.date("*t", (self:getTime()))
	local var_87_1 = os.date("*t", arg_87_1)

	if var_87_0.day == var_87_1.day and var_87_0.month == var_87_1.month and var_87_0.year == var_87_1.year then
		return true
	end

	return false
end

function ServerTime:getTodayZeroTime()
	local var_88_0 = self:getTime() + 86400
	local var_88_1 = self:getDateObject(var_88_0)

	return var_88_0 - var_88_1.hour * 3600 - var_88_1.min * 60 - var_88_1.sec
end

function ServerTime:getCurZeroTime()
	local var_89_0 = self:getTime()
	local var_89_1 = self:getDateObject(var_89_0)

	return var_89_0 - var_89_1.hour * 3600 - var_89_1.min * 60 - var_89_1.sec
end

function ServerTime:getTimeNumByMinStep(arg_90_1)
	local var_90_0 = self:getDateObject()
	local var_90_1 = var_90_0.hour * 100 + var_90_0.min

	if var_90_0.sec ~= 0 then
		return false, var_90_1
	end

	arg_90_1 = g.core.utils.Number.formatNumberByLimit(arg_90_1 or 1, 1, 60)

	return var_90_0.min % arg_90_1 == 0, var_90_1
end

function ServerTime:getRealTimeZone(arg_91_1)
	arg_91_1 = arg_91_1 or self:getTime()

	return arg_91_1 - self:_getDiff(arg_91_1)
end

function ServerTime:getElapsedTime(arg_92_1)
	return {
		day = math.floor((self:getTime() - arg_92_1) / 86400)
	}
end

function ServerTime:getLeftTimeByDay(arg_93_1)
	local var_93_0 = self:getWeekDay()

	if var_93_0 == 0 then
		var_93_0 = 7
	end

	return (arg_93_1 - var_93_0 + 1) * 86400 - self:secondsFromToday()
end

function ServerTime:getShowTimeBySecond(arg_94_1)
	if arg_94_1 <= 0 then
		return "00:00:00"
	end

	local var_94_0 = math.floor(arg_94_1 / 86400)

	arg_94_1 = arg_94_1 % 86400

	local var_94_1 = math.floor(arg_94_1 / 3600)

	arg_94_1 = arg_94_1 % 3600

	if var_94_0 > 0 then
		return g.core.lang:get(1051, {
			day = var_94_0,
			hour = var_94_1
		})
	end

	return string.format("%02d:%02d:%02d", var_94_1, math.floor(arg_94_1 / 60), arg_94_1 % 60)
end

function ServerTime:secondToDHString(arg_95_1)
	local var_95_0 = math.floor(arg_95_1 % 3600 / 60)

	return (arg_95_1 - arg_95_1 % 86400) / 86400 > 0 and g.core.lang:get(429007, {
		day = (arg_95_1 - arg_95_1 % 86400) / 86400,
		hour = (arg_95_1 - (arg_95_1 - arg_95_1 % 86400) / 86400 * 86400 - arg_95_1 % 3600) / 3600
	}) or (arg_95_1 - (arg_95_1 - arg_95_1 % 86400) / 86400 * 86400 - arg_95_1 % 3600) / 3600 > 0 and g.core.lang:get(429008, {
		hour = (arg_95_1 - (arg_95_1 - arg_95_1 % 86400) / 86400 * 86400 - arg_95_1 % 3600) / 3600,
		minute = var_95_0
	}) or g.core.lang:get(429009, {
		second = arg_95_1 % 60,
		minute = var_95_0
	})
end

return ServerTime
