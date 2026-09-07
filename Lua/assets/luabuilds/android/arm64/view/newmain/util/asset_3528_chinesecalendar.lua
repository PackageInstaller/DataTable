local ChineseCalendar = class("ChineseCalendar")
local var_0_1 = 1901
local var_0_2 = 199
local var_0_3 = {
	306771,
	677704,
	5580477,
	861776,
	890180,
	4631225,
	354893,
	634178,
	2404022,
	306762,
	6966718,
	675154,
	861510,
	6116026,
	742478,
	879171,
	2714935,
	613195,
	7642049,
	300884,
	674636,
	5973436,
	435536,
	447557,
	4905656,
	177741,
	612162,
	2398135,
	300874,
	6703934,
	870993,
	959814,
	5690554,
	372046,
	177732,
	3749688,
	601675,
	8165055,
	824659,
	870984,
	7185723,
	742735,
	354885,
	4894137,
	154957,
	601410,
	2921910,
	693578,
	8080061,
	445009,
	742726,
	5593787,
	318030,
	678723,
	3484600,
	338764,
	9082175,
	955730,
	436808,
	8049980,
	701775,
	308805,
	4871993,
	677709,
	337474,
	4100917,
	890185,
	7711422,
	354897,
	617798,
	5549755,
	306511,
	675139,
	5056183,
	861515,
	9261759,
	742482,
	748103,
	6909244,
	613200,
	301893,
	4869049,
	674637,
	11216322,
	435540,
	447561,
	7002685,
	702033,
	603974,
	5543867,
	300879,
	412484,
	3581239,
	959818,
	8827583,
	371795,
	702023,
	5846716,
	601680,
	824901,
	5065400,
	870988,
	894273,
	2468534,
	354889,
	8039869,
	154962,
	601415,
	6067642,
	693582,
	739907,
	4937015,
	709962,
	9788095,
	309843,
	678728,
	6630332,
	338768,
	693061,
	4888377,
	174924,
	350913,
	2808118,
	223562,
	6771389,
	234193,
	206278,
	5655482,
	415181,
	175427,
	3500855,
	373963,
	12298559,
	371027,
	365256,
	7153084,
	337359,
	153028,
	5418424,
	186060,
	374081,
	2992438,
	444746,
	8295102,
	430801,
	338630,
	5920442,
	154446,
	187074,
	3593527,
	484555,
	9390401,
	477523,
	430920,
	6630204,
	338895,
	158532,
	4418232,
	240332,
	238786,
	3623349,
	215497,
	8033725,
	169425,
	339397,
	5942586,
	177486,
	373443,
	4957495,
	369995,
	9259711,
	346835,
	169671,
	6641339,
	350927,
	185669,
	4575928,
	447180,
	435522,
	4082358,
	430921,
	7809469,
	436817,
	709958,
	5561018,
	308814,
	677699,
	4532024,
	861770,
	9343806,
	873042,
	895559,
	6731067,
	355663,
	306757,
	4869817,
	675148,
	857409,
	2986677
}

function ChineseCalendar:DayOfSolarYear(arg_1_1, arg_1_2)
	local var_1_0 = {
		1,
		32,
		61,
		92,
		122,
		153,
		183,
		214,
		245,
		275,
		306,
		336
	}
	local var_1_1 = {
		1,
		32,
		60,
		91,
		121,
		152,
		182,
		213,
		244,
		274,
		305,
		335
	}

	if self % 4 == 0 then
		if self % 100 ~= 0 then
			var_1_1 = var_1_0
		end

		if self % 16 == 0 then
			var_1_1 = var_1_0
		end
	end

	return var_1_1[arg_1_1] + arg_1_2 - 1
end

function ChineseCalendar:CalDate(arg_2_1, arg_2_2)
	local var_2_0 = {
		leap = false,
		month = 0,
		day = 0,
		year = self
	}

	if self <= var_0_1 or self > var_0_1 + var_0_2 - 1 then
		return var_2_0
	end

	local var_2_1 = self - var_0_1 + 1
	local var_2_2 = ChineseCalendar.DayOfSolarYear(self, arg_2_1, arg_2_2)
	local var_2_3 = var_2_2 - ChineseCalendar.DayOfSolarYear(self, bit.rshift(bit.band(var_0_3[self - var_0_1 + 1], 96), 5), (bit.band(var_0_3[self - var_0_1 + 1], 31))) + 1

	if var_2_3 <= 0 then
		var_2_1 = var_2_1 - 1
		var_2_0.year = var_2_0.year - 1

		if var_2_1 <= 0 then
			return var_2_0
		end

		var_2_3 = var_2_2 + ChineseCalendar.DayOfSolarYear(var_2_0.year, 12, 31) - ChineseCalendar.DayOfSolarYear(var_2_0.year, bit.rshift(bit.band(var_0_3[var_2_1], 96), 5), (bit.band(var_0_3[var_2_1], 31))) + 1
	end

	local var_2_4 = 1

	while var_2_4 <= 13 do
		local var_2_5 = 29

		if bit.band(bit.rshift(var_0_3[var_2_1], 6 + var_2_4), 1) == 1 then
			var_2_5 = 30
		end

		if var_2_3 <= var_2_5 then
			break
		else
			var_2_3 = var_2_3 - var_2_5
		end

		var_2_4 = var_2_4 + 1
	end

	var_2_0.day = var_2_3

	local var_2_6 = bit.band(bit.rshift(var_0_3[var_2_1], 20), 15)

	if var_2_6 > 0 and var_2_6 < var_2_4 then
		var_2_4 = var_2_4 - 1

		if var_2_4 == var_2_6 then
			var_2_0.leap = true
		end
	end

	assert(var_2_6 <= 12)

	var_2_0.month = var_2_4

	return var_2_0
end

function ChineseCalendar:IsNewYear(arg_3_1, arg_3_2)
	return arg_3_1 == 1 and arg_3_2 == 1
end

function ChineseCalendar:IsLunarNewYear(arg_4_1, arg_4_2)
	local var_4_0 = ChineseCalendar.CalDate(self, arg_4_1, arg_4_2 + 1)

	return var_4_0.month == 1 and var_4_0.day == 1
end

function ChineseCalendar:IsValentineDay(arg_5_1, arg_5_2)
	return arg_5_1 == 2 and arg_5_2 == 14
end

function ChineseCalendar:IsMidAutumnFestival(arg_6_1, arg_6_2)
	local var_6_0 = ChineseCalendar.CalDate(self, arg_6_1, arg_6_2)

	return var_6_0.month == 8 and var_6_0.day == 15
end

function ChineseCalendar:AllHallowsDay(arg_7_1, arg_7_2)
	return arg_7_1 == 10 and arg_7_2 == 31
end

function ChineseCalendar:IsChristmas(arg_8_1, arg_8_2)
	return arg_8_1 == 12 and arg_8_2 == 25
end

function ChineseCalendar:GetCurrYearMonthDay()
	local var_9_0 = string.split(pg.TimeMgr.GetInstance():STimeDescC(self, "%Y.%m.%d"), ".")

	return tonumber(var_9_0[1]), tonumber(var_9_0[2]), (tonumber(var_9_0[3]))
end

function ChineseCalendar:AnySpecialDay(arg_10_1, arg_10_2)
	return ChineseCalendar.IsNewYear(self, arg_10_1, arg_10_2) or ChineseCalendar.IsLunarNewYear(self, arg_10_1, arg_10_2) or ChineseCalendar.IsValentineDay(self, arg_10_1, arg_10_2) or ChineseCalendar.IsMidAutumnFestival(self, arg_10_1, arg_10_2) or ChineseCalendar.AllHallowsDay(self, arg_10_1, arg_10_2) or ChineseCalendar.IsChristmas(self, arg_10_1, arg_10_2)
end

return ChineseCalendar
