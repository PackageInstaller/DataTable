local var_0_0 = loadCfg("core.config.cfg.language_info")
local KsMath = require("app.core.utils.KsMath")
local var_0_2 = bit.band
local var_0_3 = bit.lshift
local var_0_4 = math.floor
local var_0_5 = math.ceil
local var_0_6 = pairs
local var_0_7 = {
	_lastUseTime = 0,
	_data = {},
	_patchKey = {}
}
local var_0_8
local var_0_9 = {
	start_sound = 39,
	gift2_action = 63,
	day4_sound = 114,
	day2_lines = 104,
	talk3_lines = 15,
	day3_lines = 108,
	favorite4_lines = 78,
	set_action = 6,
	time3_sound = 29,
	day5_action = 115,
	work_sound = 55,
	day12_lines = 144,
	asmr_sound_1 = 151,
	favorite1_action = 69,
	attack2_lines_woman = 91,
	attack1_sound = 89,
	attack1_lines_woman = 88,
	attack1_lines = 87,
	favorite5_lines_woman = 83,
	attack2_lines = 90,
	biography_sound = 86,
	touch_action = 52,
	talk1_action = 10,
	day12_sound = 146,
	day1_lines_woman = 101,
	favorite2_lines_woman = 71,
	day3_lines_woman = 109,
	attack3_sound = 95,
	id = 1,
	time1_lines = 19,
	inbattle_lines_woman = 35,
	favorite3_action = 77,
	win_lines_woman = 41,
	book2_sound = 97,
	asmr_sound_4 = 160,
	favorite3_lines = 74,
	work_lines = 53,
	favorite1_sound = 68,
	lose_sound = 45,
	day8_action = 127,
	touch_sound = 51,
	day4_action = 111,
	favorite5_action = 85,
	asmr_lines_time_7 = 171,
	favorite1_lines_woman = 67,
	favorite5_sound = 84,
	day3_action = 107,
	login_sound = 64,
	talk3_lines_woman = 16,
	asmr_lines_time_6 = 168,
	day2_action = 103,
	growup_lines_woman = 47,
	vow_lines_woman = 149,
	favorite2_sound = 72,
	asmr_sound_6 = 166,
	time1_action = 22,
	talk3_action = 18,
	get_lines = 31,
	gift1_lines_woman = 57,
	win_sound = 42,
	time2_action = 26,
	start_lines_woman = 38,
	favorite2_lines = 70,
	asmr_lines_time_5 = 165,
	set_lines_woman = 4,
	day9_action = 131,
	day10_lines = 136,
	time2_sound = 25,
	day11_lines = 140,
	asmr_lines_time_4 = 162,
	inbattle_lines = 34,
	day12_lines_woman = 145,
	day6_lines = 120,
	skin_sound = 98,
	time1_lines_woman = 20,
	win_lines = 40,
	talk2_lines_woman = 12,
	vow_sound = 150,
	gift1_lines = 56,
	day10_action = 135,
	attack3_lines = 93,
	asmr_sound_3 = 157,
	day9_sound = 134,
	asmr_lines_time_3 = 159,
	asmr_lines_3 = 158,
	time3_lines = 27,
	talk2_lines = 11,
	vow_lines = 148,
	gift2_lines = 60,
	asmr_lines_time_2 = 156,
	check_sound = 65,
	gift2_sound = 62,
	day1_action = 99,
	asmr_lines_4 = 161,
	day11_lines_woman = 141,
	asmr_sound_5 = 163,
	asmr_lines_5 = 164,
	gift2_lines_woman = 61,
	day4_lines = 112,
	touch_lines_woman = 50,
	special_sound_1 = 177,
	day6_sound = 122,
	day12_action = 143,
	favorite5_lines = 82,
	asmr_sound_7 = 169,
	time2_lines_woman = 24,
	get_sound = 33,
	gift1_action = 59,
	special_lines_1 = 175,
	book1_sound = 96,
	set_sound = 5,
	time3_lines_woman = 28,
	lose_lines = 43,
	inbattle_sound = 36,
	special_action_1 = 176,
	talk1_lines = 7,
	get_lines_woman = 32,
	work_lines_woman = 54,
	talk1_lines_woman = 8,
	bg_special_1 = 178,
	x_pos_2 = 179,
	radius_2 = 181,
	special_action_2 = 183,
	gift1_sound = 58,
	special_sound_2 = 184,
	favorite3_sound = 76,
	favorite4_sound = 80,
	growup_lines = 46,
	asmr_lines_6 = 167,
	day2_sound = 106,
	day10_sound = 138,
	day6_action = 119,
	day8_lines = 128,
	asmr_sound_2 = 154,
	day1_lines = 100,
	attack3_lines_woman = 94,
	favorite4_action = 81,
	bg_special_2 = 185,
	asmr_lines_2 = 155,
	day6_lines_woman = 121,
	favorite4_lines_woman = 79,
	lose_lines_woman = 44,
	day5_lines_woman = 117,
	day4_lines_woman = 113,
	day2_lines_woman = 105,
	favorite2_action = 73,
	time3_action = 30,
	day7_lines = 124,
	asmr_lines_1 = 152,
	day5_sound = 118,
	talk2_action = 14,
	radius_1 = 174,
	y_pos_2 = 180,
	day9_lines_woman = 133,
	x_pos_1 = 172,
	asmr_lines_7 = 170,
	day8_lines_woman = 129,
	attack2_sound = 92,
	day7_lines_woman = 125,
	day8_sound = 130,
	set_lines = 3,
	name = 2,
	day7_sound = 126,
	talk3_sound = 17,
	day1_sound = 102,
	day5_lines = 116,
	favorite3_lines_woman = 75,
	touch_lines = 49,
	day7_action = 123,
	day11_action = 139,
	talk1_sound = 9,
	start_lines = 37,
	asmr_lines_time_1 = 153,
	day3_sound = 110,
	talk2_sound = 13,
	vow_action = 147,
	day10_lines_woman = 137,
	growup_sound = 48,
	day11_sound = 142,
	day9_lines = 132,
	special_lines_2 = 182,
	favorite1_lines = 66,
	y_pos_1 = 173,
	time2_lines = 23,
	time1_sound = 21
}
local var_0_10 = {
	win_lines = 22,
	day3_lines_woman = 57,
	day3_lines = 56,
	day2_lines = 54,
	talk3_lines = 8,
	growup_lines = 26,
	favorite4_lines = 42,
	asmr_lines_6 = 83,
	talk2_lines = 6,
	time3_lines = 14,
	favorite5_lines_woman = 45,
	day11_lines = 72,
	day8_lines = 66,
	special_lines_1 = 85,
	talk2_lines_woman = 7,
	start_lines_woman = 21,
	day1_lines = 52,
	time1_lines_woman = 11,
	attack3_lines_woman = 51,
	attack2_lines = 48,
	time2_lines_woman = 13,
	attack1_lines_woman = 47,
	asmr_lines_2 = 79,
	time1_lines = 10,
	day6_lines_woman = 63,
	talk1_lines_woman = 5,
	favorite4_lines_woman = 43,
	lose_lines_woman = 25,
	win_lines_woman = 23,
	day5_lines_woman = 61,
	inbattle_lines_woman = 19,
	favorite3_lines = 40,
	day10_lines = 70,
	gift2_lines = 34,
	day4_lines_woman = 59,
	day10_lines_woman = 71,
	day2_lines_woman = 55,
	work_lines = 30,
	favorite1_lines_woman = 37,
	day7_lines = 64,
	asmr_lines_1 = 78,
	day1_lines_woman = 53,
	day12_lines = 74,
	day12_lines_woman = 75,
	vow_lines = 76,
	day11_lines_woman = 73,
	attack2_lines_woman = 49,
	asmr_lines_3 = 80,
	asmr_lines_4 = 81,
	day9_lines_woman = 69,
	asmr_lines_5 = 82,
	growup_lines_woman = 27,
	vow_lines_woman = 77,
	asmr_lines_7 = 84,
	day8_lines_woman = 67,
	attack1_lines = 46,
	gift2_lines_woman = 35,
	gift1_lines_woman = 33,
	day7_lines_woman = 65,
	inbattle_lines = 18,
	set_lines = 2,
	set_lines_woman = 3,
	name = 1,
	day6_lines = 62,
	talk3_lines_woman = 9,
	gift1_lines = 32,
	favorite2_lines_woman = 39,
	day5_lines = 60,
	favorite3_lines_woman = 41,
	touch_lines = 28,
	attack3_lines = 50,
	day4_lines = 58,
	start_lines = 20,
	favorite5_lines = 44,
	touch_lines_woman = 29,
	get_lines = 16,
	time3_lines_woman = 15,
	lose_lines = 24,
	talk1_lines = 4,
	get_lines_woman = 17,
	work_lines_woman = 31,
	day9_lines = 68,
	special_lines_2 = 86,
	favorite1_lines = 36,
	time2_lines = 12,
	favorite2_lines = 38
}
local var_0_11 = {
	200000,
	"413_200000_name",
	"413_210000_set_lines",
	"413_210000_set_lines",
	"",
	"happy",
	"413_210000_set_lines",
	"413_210000_set_lines",
	"",
	"happy",
	"413_210000_set_lines",
	"413_210000_set_lines",
	"",
	"happy",
	"413_210000_set_lines",
	"413_210000_set_lines",
	"",
	"shy",
	"413_210000_set_lines",
	"413_210000_set_lines",
	"",
	"happy",
	"413_210000_set_lines",
	"413_210000_set_lines",
	"",
	"happy",
	"413_210000_set_lines",
	"413_210000_set_lines",
	"",
	"happy",
	"413_210000_set_lines",
	"413_210000_set_lines",
	"",
	"413_210000_set_lines",
	"413_210000_set_lines",
	"",
	"413_210000_set_lines",
	"413_210000_set_lines",
	"",
	"413_210000_set_lines",
	"413_210000_set_lines",
	"",
	"413_210000_set_lines",
	"413_210000_set_lines",
	"",
	"413_210000_set_lines",
	"413_210000_set_lines",
	"",
	"413_210000_set_lines",
	"413_210000_set_lines",
	"",
	"touch",
	"413_210000_set_lines",
	"413_210000_set_lines",
	"",
	"413_210000_set_lines",
	"413_210000_set_lines",
	"",
	"shy",
	"413_210000_set_lines",
	"413_210000_set_lines",
	"",
	"surprise",
	"",
	"",
	"413_210000_set_lines",
	"413_210000_set_lines",
	"",
	"idle",
	"413_210000_set_lines",
	"413_210000_set_lines",
	"",
	"shy",
	"413_210000_set_lines",
	"413_210000_set_lines",
	"",
	"shy",
	"413_210000_set_lines",
	"413_210000_set_lines",
	"",
	"shy",
	"413_210000_set_lines",
	"413_210000_set_lines",
	"",
	"shy",
	"",
	"413_210000_set_lines",
	"413_210000_set_lines",
	"Vo_210000_attack1",
	"413_210000_set_lines",
	"413_210000_set_lines",
	"Vo_210000_attack2",
	"413_210000_set_lines",
	"413_210000_set_lines",
	"Vo_210005_attack3",
	"",
	"",
	"",
	"happy",
	"413_210000_set_lines",
	"413_210000_set_lines",
	"",
	"happy",
	"413_210000_set_lines",
	"413_210000_set_lines",
	"",
	"shy",
	"413_210000_set_lines",
	"413_210000_set_lines",
	"",
	"happy",
	"413_210000_set_lines",
	"413_210000_set_lines",
	"",
	"happy",
	"413_210000_set_lines",
	"413_210000_set_lines",
	"",
	"happy",
	"413_210000_set_lines",
	"413_210000_set_lines",
	"",
	"happy",
	"413_210000_set_lines",
	"413_210000_set_lines",
	"",
	"happy",
	"413_210000_set_lines",
	"413_210000_set_lines",
	"",
	"shy",
	"413_210000_set_lines",
	"413_210000_set_lines",
	"",
	"happy",
	"413_210000_set_lines",
	"413_210000_set_lines",
	"",
	"happy",
	"413_210000_set_lines",
	"413_210000_set_lines",
	"",
	"happy",
	"413_210000_set_lines",
	"413_210000_set_lines",
	"",
	"shy",
	"413_210000_set_lines",
	"413_210000_set_lines",
	"",
	"",
	"413_210000_set_lines",
	0,
	"",
	"413_210000_set_lines",
	0,
	"",
	"413_210000_set_lines",
	0,
	"",
	"413_210000_set_lines",
	0,
	"",
	"413_210000_set_lines",
	0,
	"",
	"413_210000_set_lines",
	0,
	"",
	"413_210000_set_lines",
	0,
	0,
	0,
	0,
	"413_210000_set_lines",
	"",
	"",
	0,
	0,
	0,
	0,
	"413_210000_set_lines",
	"",
	"",
	0
}
local var_0_12 = 185
local var_0_13 = {
	__index = function(self, arg_1_1)
		if var_0_7._setData[self.index] then
			local var_1_0 = var_0_7._setData[self.index]

			if arg_1_1 == "toObject" then
				return function()
					local var_2_0 = {}

					for iter_2_0, iter_2_1 in var_0_6(var_0_9) do
						var_2_0[iter_2_0] = var_1_0[iter_2_0]
					end

					return var_2_0
				end
			else
				return var_0_7._setData[self.index][arg_1_1]
			end
		end

		local var_1_1 = var_0_12
		local var_1_2 = #self._raw - var_0_5(var_0_12 / 30)

		if arg_1_1 == "toObject" then
			local var_1_3 = 1
			local var_1_4 = {}

			for iter_1_0 = 1, var_1_1 do
				if var_0_2(self._raw[var_1_2 + var_0_5(iter_1_0 / 30)], var_0_3(1, ((iter_1_0 % 30 == 0 or nil) and 30) - 1)) ~= 0 then
					var_1_4[iter_1_0] = self._raw[var_1_3]
					var_1_3 = var_1_3 + 1
				else
					var_1_4[iter_1_0] = var_0_11[iter_1_0]
				end
			end

			return function()
				local var_3_0 = {}

				for iter_3_0, iter_3_1 in var_0_6(var_0_9) do
					var_3_0[iter_3_0] = var_0_10[iter_3_0] and (var_0_0.get(var_1_4[iter_3_1]) and var_0_0.get(var_1_4[iter_3_1]).value or KsMath.TRANS_ERROR_TIP()) or var_1_4[iter_3_1]
				end

				return var_3_0
			end
		else
			assert(var_0_9[arg_1_1], "cannot find " .. arg_1_1 .. " in record_knight_show_info")

			var_1_1 = var_0_9[arg_1_1]
		end

		local var_1_6
		local var_1_7 = 0
		local var_1_8 = var_1_1 % 30

		if var_1_1 % 30 == 0 then
			var_1_8 = 30
		end

		local var_1_9 = var_0_4((var_1_1 - 1) / 30)

		if var_0_2(self._raw[var_1_2 + var_1_9 + 1], var_0_3(1, var_1_8 - 1)) ~= 0 then
			for iter_1_1 = 1, var_1_9 do
				while self._raw[var_1_2 + iter_1_1] > 0 do
					local var_1_10 = var_0_2(self._raw[var_1_2 + iter_1_1], self._raw[var_1_2 + iter_1_1] - 1)

					var_1_7 = var_1_7 + 1
				end
			end

			local var_1_11 = var_0_2(self._raw[var_1_2 + var_1_9 + 1], var_0_3(1, var_1_8) - 1)

			while var_1_11 > 0 do
				var_1_11 = var_0_2(var_1_11, var_1_11 - 1)
				var_1_7 = var_1_7 + 1
			end

			var_1_6 = self._raw[var_1_7]
		else
			var_1_6 = var_0_11[var_1_1]
		end

		if var_0_10[arg_1_1] then
			return var_0_0.get(var_1_6) and var_0_0.get(var_1_6).value or KsMath.TRANS_ERROR_TIP()
		end

		return var_1_6
	end
}
local var_0_14 = {
	__index = function(self, arg_4_1)
		if arg_4_1 == "toObject" then
			return function()
				local var_5_0 = {}

				for iter_5_0, iter_5_1 in var_0_6(var_0_9) do
					var_5_0[iter_5_0] = self._raw[iter_5_0]
				end

				return var_5_0
			end
		end

		return self._raw[arg_4_1]
	end,
	__newindex = function()
		return
	end
}

function var_0_7.getLength()
	return #var_0_7._getData()
end

function var_0_7.indexOf(arg_8_0)
	if arg_8_0 == nil or not var_0_7._getData()[arg_8_0] then
		return nil
	end

	if var_0_7._setData[arg_8_0] then
		return setmetatable({
			_raw = var_0_7._setData[arg_8_0]
		}, var_0_14)
	else
		return setmetatable({
			_raw = var_0_7._getData()[arg_8_0],
			index = arg_8_0
		}, var_0_13)
	end
end

function var_0_7.get(arg_9_0)
	return var_0_7.indexOf(var_0_7._getKey()[arg_9_0])
end

function var_0_7.hasKey(arg_10_0)
	if var_0_9[arg_10_0] == nil then
		return false
	else
		return true
	end
end

var_0_7._setData = {}

function var_0_7.set(arg_11_0, arg_11_1, arg_11_2)
	local var_11_0 = var_0_7._getKey()[arg_11_0]

	if not var_11_0 then
		error("Key not found: " .. arg_11_0)
	end

	local var_11_1 = var_0_7.indexOf(var_11_0).toObject()

	var_11_1[arg_11_1] = arg_11_2
	var_0_7._setData[var_11_0] = var_11_1
end

function var_0_7.get_index_data()
	return var_0_7._getKey()
end

function var_0_7._getData()
	if not var_0_7._originData then
		var_0_7._originData = loadCfg("core.config.cfg.knight_show_info_data")

		for iter_13_0, iter_13_1 in var_0_6(var_0_7._data) do
			var_0_7._originData[iter_13_0] = iter_13_1
		end

		var_0_7._lastUseTime = os.time()
	end

	return var_0_7._originData
end

function var_0_7._getKey()
	if not var_0_8 then
		var_0_8 = loadCfg("core.config.cfg.knight_show_info_key")

		for iter_14_0, iter_14_1 in var_0_6(var_0_7._patchKey) do
			var_0_8[iter_14_0] = iter_14_1
		end

		var_0_7._lastUseTime = os.time()
	end

	return var_0_8
end

function var_0_7.checkDataClear()
	if var_0_7._lastUseTime > 0 and os.time() - var_0_7._lastUseTime > g.core.const.ConstMgr.BASE_CONST.CONFIG_CHECK_DATA_DELTA then
		var_0_7._originData = nil
		var_0_8 = nil
		var_0_7._lastUseTime = 0
		package.loaded["app.core.config.cfg.knight_show_info_data"] = nil
		package.loaded["app.core.config.cfg.knight_show_info_key"] = nil
	end
end

function var_0_7.patchClearOriginData()
	if var_0_7._originData ~= nil or var_0_8 ~= nil then
		var_0_7._originData = nil
		var_0_8 = nil
		var_0_7._lastUseTime = 0
		package.loaded["app.core.config.cfg.knight_show_info_data"] = nil
		package.loaded["app.core.config.cfg.knight_show_info_key"] = nil
	end
end

return var_0_7
