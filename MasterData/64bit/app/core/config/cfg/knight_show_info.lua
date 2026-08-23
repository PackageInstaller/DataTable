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
	time1_sound = 21,
	time1_action = 22,
	time2_lines = 23,
	time2_lines_woman = 24,
	time2_sound = 25,
	time2_action = 26,
	time3_lines = 27,
	time3_lines_woman = 28,
	time3_sound = 29,
	name = 2,
	get_lines = 31,
	get_lines_woman = 32,
	favorite3_lines_woman = 75,
	favorite3_lines = 74,
	favorite2_action = 73,
	favorite2_sound = 72,
	favorite2_lines_woman = 71,
	favorite2_lines = 70,
	favorite1_action = 69,
	favorite1_sound = 68,
	favorite1_lines_woman = 67,
	favorite1_lines = 66,
	check_sound = 65,
	talk1_sound = 9,
	talk1_lines_woman = 8,
	talk1_lines = 7,
	set_action = 6,
	set_sound = 5,
	set_lines_woman = 4,
	set_lines = 3,
	id = 1,
	time3_action = 30,
	vow_lines_woman = 149,
	vow_sound = 150,
	asmr_sound_1 = 151,
	asmr_lines_1 = 152,
	asmr_lines_time_1 = 153,
	asmr_sound_2 = 154,
	asmr_lines_2 = 155,
	asmr_lines_time_2 = 156,
	asmr_sound_3 = 157,
	asmr_lines_3 = 158,
	asmr_lines_time_3 = 159,
	asmr_sound_4 = 160,
	asmr_lines_4 = 161,
	asmr_lines_time_4 = 162,
	asmr_sound_5 = 163,
	asmr_lines_5 = 164,
	asmr_lines_time_5 = 165,
	asmr_sound_6 = 166,
	asmr_lines_6 = 167,
	asmr_lines_time_6 = 168,
	asmr_sound_7 = 169,
	asmr_lines_7 = 170,
	asmr_lines_time_7 = 171,
	x_pos_1 = 172,
	y_pos_1 = 173,
	radius_1 = 174,
	special_lines_1 = 175,
	special_action_1 = 176,
	special_sound_1 = 177,
	bg_special_1 = 178,
	x_pos_2 = 179,
	y_pos_2 = 180,
	radius_2 = 181,
	bg_special_2 = 185,
	special_sound_2 = 184,
	special_action_2 = 183,
	special_lines_2 = 182,
	vow_lines = 148,
	vow_action = 147,
	day12_sound = 146,
	day12_lines_woman = 145,
	day12_lines = 144,
	day12_action = 143,
	day11_sound = 142,
	day11_lines_woman = 141,
	day11_lines = 140,
	day11_action = 139,
	day10_sound = 138,
	day10_lines_woman = 137,
	day10_lines = 136,
	day10_action = 135,
	day9_sound = 134,
	day9_lines_woman = 133,
	day9_lines = 132,
	day9_action = 131,
	day8_sound = 130,
	day8_lines_woman = 129,
	day8_lines = 128,
	day8_action = 127,
	day7_sound = 126,
	day7_lines_woman = 125,
	day7_lines = 124,
	day7_action = 123,
	day6_sound = 122,
	day6_lines_woman = 121,
	day6_lines = 120,
	day6_action = 119,
	day5_sound = 118,
	day5_lines_woman = 117,
	day5_lines = 116,
	day5_action = 115,
	day4_sound = 114,
	day4_lines_woman = 113,
	day4_lines = 112,
	day4_action = 111,
	day3_sound = 110,
	day3_lines_woman = 109,
	day3_lines = 108,
	day3_action = 107,
	day2_sound = 106,
	day2_lines_woman = 105,
	day2_lines = 104,
	day2_action = 103,
	day1_sound = 102,
	day1_lines_woman = 101,
	day1_lines = 100,
	day1_action = 99,
	skin_sound = 98,
	book2_sound = 97,
	book1_sound = 96,
	attack3_sound = 95,
	attack3_lines_woman = 94,
	attack3_lines = 93,
	attack2_sound = 92,
	attack2_lines_woman = 91,
	attack2_lines = 90,
	attack1_sound = 89,
	attack1_lines_woman = 88,
	attack1_lines = 87,
	biography_sound = 86,
	favorite5_action = 85,
	favorite5_sound = 84,
	favorite5_lines_woman = 83,
	favorite5_lines = 82,
	favorite4_action = 81,
	favorite4_sound = 80,
	favorite4_lines_woman = 79,
	favorite4_lines = 78,
	favorite3_action = 77,
	favorite3_sound = 76,
	time1_lines_woman = 20,
	time1_lines = 19,
	talk3_action = 18,
	talk3_sound = 17,
	talk3_lines_woman = 16,
	talk3_lines = 15,
	talk2_action = 14,
	talk2_sound = 13,
	talk2_lines_woman = 12,
	talk2_lines = 11,
	talk1_action = 10,
	login_sound = 64,
	gift2_action = 63,
	gift2_sound = 62,
	gift2_lines_woman = 61,
	gift2_lines = 60,
	gift1_action = 59,
	gift1_sound = 58,
	gift1_lines_woman = 57,
	gift1_lines = 56,
	work_sound = 55,
	work_lines_woman = 54,
	work_lines = 53,
	touch_action = 52,
	touch_sound = 51,
	touch_lines_woman = 50,
	touch_lines = 49,
	growup_sound = 48,
	growup_lines_woman = 47,
	growup_lines = 46,
	lose_sound = 45,
	lose_lines_woman = 44,
	lose_lines = 43,
	win_sound = 42,
	win_lines_woman = 41,
	win_lines = 40,
	start_sound = 39,
	start_lines_woman = 38,
	start_lines = 37,
	inbattle_sound = 36,
	inbattle_lines_woman = 35,
	inbattle_lines = 34,
	get_sound = 33
}
local var_0_10 = {
	vow_lines = 76,
	time1_lines_woman = 11,
	favorite3_lines = 40,
	day12_lines_woman = 75,
	day12_lines = 74,
	time2_lines_woman = 13,
	special_lines_1 = 85,
	day11_lines_woman = 73,
	day11_lines = 72,
	time3_lines_woman = 15,
	favorite1_lines = 36,
	day10_lines_woman = 71,
	day10_lines = 70,
	time3_lines = 14,
	asmr_lines_6 = 83,
	day9_lines_woman = 69,
	day9_lines = 68,
	asmr_lines_5 = 82,
	favorite2_lines_woman = 39,
	day8_lines_woman = 67,
	day8_lines = 66,
	attack1_lines = 46,
	vow_lines_woman = 77,
	day7_lines_woman = 65,
	day7_lines = 64,
	asmr_lines_3 = 80,
	asmr_lines_2 = 79,
	day6_lines_woman = 63,
	day6_lines = 62,
	asmr_lines_1 = 78,
	asmr_lines_4 = 81,
	day5_lines_woman = 61,
	day5_lines = 60,
	time2_lines = 12,
	favorite1_lines_woman = 37,
	day4_lines_woman = 59,
	day4_lines = 58,
	asmr_lines_7 = 84,
	favorite2_lines = 38,
	day3_lines_woman = 57,
	day3_lines = 56,
	day2_lines_woman = 55,
	day2_lines = 54,
	day1_lines_woman = 53,
	day1_lines = 52,
	attack3_lines_woman = 51,
	attack3_lines = 50,
	attack2_lines_woman = 49,
	attack2_lines = 48,
	attack1_lines_woman = 47,
	get_lines_woman = 17,
	get_lines = 16,
	name = 1,
	favorite5_lines_woman = 45,
	favorite5_lines = 44,
	favorite4_lines_woman = 43,
	favorite4_lines = 42,
	favorite3_lines_woman = 41,
	time1_lines = 10,
	talk3_lines_woman = 9,
	talk3_lines = 8,
	talk2_lines_woman = 7,
	talk2_lines = 6,
	talk1_lines_woman = 5,
	talk1_lines = 4,
	gift2_lines_woman = 35,
	gift2_lines = 34,
	set_lines_woman = 3,
	set_lines = 2,
	gift1_lines_woman = 33,
	gift1_lines = 32,
	work_lines_woman = 31,
	work_lines = 30,
	touch_lines_woman = 29,
	touch_lines = 28,
	growup_lines_woman = 27,
	growup_lines = 26,
	lose_lines_woman = 25,
	lose_lines = 24,
	win_lines_woman = 23,
	win_lines = 22,
	start_lines_woman = 21,
	start_lines = 20,
	inbattle_lines_woman = 19,
	inbattle_lines = 18,
	special_lines_2 = 86
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
