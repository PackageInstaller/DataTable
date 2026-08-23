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
local var_0_9
local var_0_10 = {
	id = 1,
	association_15 = 74,
	promote_passive_1_1 = 86,
	promote_passive_16_2 = 162,
	promote_passive_16_3 = 163,
	skill_type_17 = 164,
	promote_talent_17 = 165,
	promote_passive_17_1 = 166,
	promote_passive_17_2 = 167,
	promote_passive_17_3 = 168,
	skill_type_18 = 169,
	promote_talent_18 = 170,
	promote_passive_18_1 = 171,
	promote_passive_18_2 = 172,
	promote_passive_18_3 = 173,
	skill_type_19 = 174,
	promote_talent_19 = 175,
	promote_passive_19_1 = 176,
	promote_passive_19_2 = 177,
	promote_passive_19_3 = 178,
	skill_type_20 = 179,
	promote_talent_20 = 180,
	promote_passive_20_1 = 181,
	promote_passive_20_2 = 182,
	promote_passive_20_3 = 183,
	skill_type_21 = 184,
	promote_talent_21 = 185,
	promote_passive_21_1 = 186,
	promote_passive_21_2 = 187,
	promote_passive_21_3 = 188,
	lineage_talent = 189,
	personality_talk_1 = 190,
	personality_talk_2 = 191,
	personality_talk_3 = 192,
	personality_talk_4 = 193,
	name_txt = 194,
	disposition = 195,
	awake_id = 196,
	if_au_knight = 197,
	purplize_id = 198,
	purplize_type = 199,
	purplize_sp_text = 200,
	trick_type = 201,
	game_type = 202,
	batch = 203,
	mobility = 204,
	homeland_talent = 205,
	wish_show = 206,
	classical = 207,
	token_value = 208,
	token_num = 209,
	is_element_leader = 210,
	army_skill_id = 211,
	army_passive_skill_id_1 = 212,
	promote_passive_16_1 = 161,
	promote_talent_16 = 160,
	skill_type_16 = 159,
	promote_passive_15_3 = 158,
	promote_passive_15_2 = 157,
	promote_passive_15_1 = 156,
	promote_talent_15 = 155,
	skill_type_15 = 154,
	promote_passive_14_3 = 153,
	promote_passive_14_2 = 152,
	promote_passive_14_1 = 151,
	promote_talent_14 = 150,
	skill_type_14 = 149,
	promote_passive_13_3 = 148,
	promote_passive_13_2 = 147,
	promote_passive_13_1 = 146,
	promote_talent_13 = 145,
	skill_type_13 = 144,
	promote_passive_12_3 = 143,
	promote_passive_12_2 = 142,
	promote_passive_12_1 = 141,
	promote_talent_12 = 140,
	skill_type_12 = 139,
	promote_passive_11_3 = 138,
	promote_passive_11_2 = 137,
	promote_passive_11_1 = 136,
	promote_talent_11 = 135,
	skill_type_11 = 134,
	promote_passive_10_3 = 133,
	promote_passive_10_2 = 132,
	promote_passive_10_1 = 131,
	promote_talent_10 = 130,
	skill_type_10 = 129,
	promote_passive_9_3 = 128,
	promote_passive_9_2 = 127,
	promote_passive_9_1 = 126,
	promote_talent_9 = 125,
	skill_type_9 = 124,
	promote_passive_8_3 = 123,
	promote_passive_8_2 = 122,
	promote_passive_8_1 = 121,
	promote_talent_8 = 120,
	skill_type_8 = 119,
	promote_passive_7_3 = 118,
	promote_passive_7_2 = 117,
	promote_passive_7_1 = 116,
	promote_talent_7 = 115,
	skill_type_7 = 114,
	promote_passive_6_3 = 113,
	promote_passive_6_2 = 112,
	promote_passive_6_1 = 111,
	promote_talent_6 = 110,
	skill_type_6 = 109,
	promote_passive_5_3 = 108,
	promote_passive_5_2 = 107,
	promote_passive_5_1 = 106,
	promote_talent_5 = 105,
	skill_type_5 = 104,
	promote_passive_4_3 = 103,
	promote_passive_4_2 = 102,
	promote_passive_4_1 = 101,
	promote_talent_4 = 100,
	skill_type_4 = 99,
	promote_passive_3_3 = 98,
	promote_passive_3_2 = 97,
	promote_passive_3_1 = 96,
	promote_talent_3 = 95,
	skill_type_3 = 94,
	promote_passive_2_3 = 93,
	promote_passive_2_2 = 92,
	promote_passive_2_1 = 91,
	promote_talent_2 = 90,
	skill_type_2 = 89,
	promote_passive_1_3 = 88,
	promote_passive_1_2 = 87,
	name = 2,
	promote_talent_1 = 85,
	skill_type_1 = 84,
	gm = 83,
	passive_skill_1 = 82,
	tactics = 81,
	feature = 80,
	background_description = 79,
	description = 78,
	association_18 = 77,
	association_17 = 76,
	association_16 = 75,
	type = 16,
	association_14 = 73,
	association_13 = 72,
	association_12 = 71,
	association_11 = 70,
	association_10 = 69,
	association_9 = 68,
	association_8 = 67,
	association_7 = 66,
	association_6 = 65,
	association_5 = 64,
	association_4 = 63,
	association_3 = 62,
	association_2 = 61,
	association_1 = 60,
	star_talent_extra = 59,
	original_talent_3 = 58,
	original_talent_2 = 57,
	original_talent_1 = 56,
	star_talent_7 = 55,
	star_talent_6 = 54,
	star_talent_5 = 53,
	star_talent_4 = 52,
	star_talent_3 = 51,
	star_talent_2 = 50,
	star_talent_1 = 49,
	next_star_id = 48,
	return_fragment_num = 47,
	next_star_num = 46,
	fragment_id = 45,
	star = 44,
	energy_value_2 = 43,
	energy_type_2 = 42,
	energy_value_1 = 41,
	energy_type_1 = 40,
	initial_energy = 39,
	energy_skill_id = 38,
	advanced_passive_skill_id_3 = 37,
	advanced_passive_skill_id_2 = 36,
	advanced_passive_skill_id_1 = 35,
	shield_active = 34,
	active_skill_id = 33,
	shield_common = 32,
	common_id = 31,
	skill_factor = 30,
	initial_anger = 29,
	develop_magical_defence = 28,
	base_magical_defence = 27,
	develop_physical_defence = 26,
	base_physical_defence = 25,
	develop_attack = 24,
	base_attack = 23,
	develop_hp = 22,
	base_hp = 21,
	attack_range = 20,
	attack_type = 19,
	group = 18,
	character_tips = 17,
	sex = 15,
	res_id = 14,
	is_display = 13,
	put = 12,
	knight_star_id = 11,
	promote_code = 10,
	level_exp_id = 9,
	potential = 8,
	profession = 7,
	rare = 6,
	quality = 5,
	advance_id = 4,
	english_name = 3
}
local var_0_11 = {
	description = 2,
	name = 1,
	tactics = 4,
	feature = 3
}
local var_0_12 = {
	200000,
	"1000_210000_name",
	"0",
	200000,
	3,
	0,
	1,
	12,
	3,
	3,
	1,
	1,
	1,
	200000,
	0,
	2,
	3,
	2,
	1,
	6,
	8,
	199,
	1,
	10,
	1,
	5,
	1,
	5,
	1,
	0,
	21000000,
	0,
	21000010,
	0,
	0,
	0,
	0,
	0,
	0,
	0,
	0,
	0,
	0,
	0,
	0,
	60,
	0,
	0,
	0,
	0,
	0,
	0,
	0,
	0,
	0,
	0,
	0,
	0,
	0,
	0,
	0,
	0,
	0,
	0,
	0,
	0,
	0,
	0,
	0,
	0,
	0,
	0,
	0,
	0,
	0,
	0,
	0,
	"1000_300100_description",
	"0",
	"1000_400100_feature",
	"1000_210000_tactics",
	0,
	0,
	1,
	15301,
	0,
	0,
	0,
	3,
	15302,
	0,
	0,
	0,
	1,
	15303,
	0,
	0,
	0,
	3,
	15304,
	0,
	0,
	0,
	1,
	15305,
	0,
	0,
	0,
	3,
	15306,
	0,
	0,
	0,
	1,
	15307,
	0,
	0,
	0,
	1,
	15308,
	0,
	0,
	0,
	1,
	15309,
	0,
	0,
	0,
	1,
	15310,
	0,
	0,
	0,
	1,
	15311,
	0,
	0,
	0,
	1,
	15312,
	0,
	0,
	0,
	1,
	15313,
	0,
	0,
	0,
	1,
	15314,
	0,
	0,
	0,
	1,
	15315,
	0,
	0,
	0,
	1,
	15316,
	0,
	0,
	0,
	1,
	15317,
	0,
	0,
	0,
	1,
	15318,
	0,
	0,
	0,
	1,
	15319,
	0,
	0,
	0,
	1,
	15320,
	0,
	0,
	0,
	0,
	0,
	0,
	0,
	0,
	0,
	"0",
	"0",
	"0",
	"0",
	"0",
	"0",
	0,
	0,
	0,
	0,
	"0",
	0,
	0,
	0,
	2400,
	0,
	2,
	0,
	0,
	0,
	0,
	0,
	0
}
local var_0_13 = 212
local var_0_14 = {
	__index = function(self, arg_1_1)
		if var_0_7._setData[self.index] then
			local var_1_0 = var_0_7._setData[self.index]

			if arg_1_1 == "toObject" then
				return function()
					local var_2_0 = {}

					for iter_2_0, iter_2_1 in var_0_6(var_0_10) do
						var_2_0[iter_2_0] = var_1_0[iter_2_0]
					end

					return var_2_0
				end
			else
				return var_0_7._setData[self.index][arg_1_1]
			end
		end

		local var_1_1 = var_0_13
		local var_1_2 = #self._raw - var_0_5(var_0_13 / 30)

		if arg_1_1 == "toObject" then
			local var_1_3 = 1
			local var_1_4 = {}

			for iter_1_0 = 1, var_1_1 do
				if var_0_2(self._raw[var_1_2 + var_0_5(iter_1_0 / 30)], var_0_3(1, ((iter_1_0 % 30 == 0 or nil) and 30) - 1)) ~= 0 then
					var_1_4[iter_1_0] = self._raw[var_1_3]
					var_1_3 = var_1_3 + 1
				else
					var_1_4[iter_1_0] = var_0_12[iter_1_0]
				end
			end

			return function()
				local var_3_0 = {}

				for iter_3_0, iter_3_1 in var_0_6(var_0_10) do
					var_3_0[iter_3_0] = var_0_11[iter_3_0] and (var_0_0.get(var_1_4[iter_3_1]) and var_0_0.get(var_1_4[iter_3_1]).value or KsMath.TRANS_ERROR_TIP()) or var_1_4[iter_3_1]
				end

				return var_3_0
			end
		else
			assert(var_0_10[arg_1_1], "cannot find " .. arg_1_1 .. " in record_knight_info_os")

			var_1_1 = var_0_10[arg_1_1]
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
			var_1_6 = var_0_12[var_1_1]
		end

		if var_0_11[arg_1_1] then
			return var_0_0.get(var_1_6) and var_0_0.get(var_1_6).value or KsMath.TRANS_ERROR_TIP()
		end

		return var_1_6
	end
}
local var_0_15 = {
	__index = function(self, arg_4_1)
		if arg_4_1 == "toObject" then
			return function()
				local var_5_0 = {}

				for iter_5_0, iter_5_1 in var_0_6(var_0_10) do
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
local var_0_17 = ...
local var_0_19, var_0_20 = pcall(require, string.sub(var_0_17, 1, string.len(var_0_17) - string.len("knight_info_os")) .. "knight_info_2")
local var_0_21 = var_0_20

if not var_0_19 then
	var_0_21 = nil
end

function var_0_7.getSelfLength()
	var_0_7.__length = var_0_7.__length or #var_0_7._getData()

	return var_0_7.__length
end

function var_0_7.getLength()
	if var_0_21 then
		return var_0_7.getSelfLength() + var_0_21.getLength()
	end

	return var_0_7.__length
end

function var_0_7.indexOf(arg_9_0)
	if arg_9_0 == nil then
		return nil
	end

	if var_0_7._setData[arg_9_0] then
		return setmetatable({
			_raw = var_0_7._setData[arg_9_0]
		}, var_0_15)
	else
		if not var_0_7._getData()[arg_9_0] then
			if var_0_21 then
				return var_0_21.indexOf(arg_9_0 - var_0_7.getSelfLength())
			end

			return nil
		end

		return setmetatable({
			_raw = var_0_7._getData()[arg_9_0],
			index = arg_9_0
		}, var_0_14)
	end
end

function var_0_7.get(arg_10_0)
	if not var_0_7._getKey()[arg_10_0] then
		if var_0_21 then
			return var_0_21.get(arg_10_0)
		end

		return nil
	end

	return var_0_7.indexOf(var_0_7._getKey()[arg_10_0])
end

function var_0_7.hasKey(arg_11_0)
	if var_0_10[arg_11_0] == nil then
		return false
	else
		return true
	end
end

var_0_7._setData = {}

function var_0_7.set(arg_12_0, arg_12_1, arg_12_2)
	local var_12_0 = var_0_7._getKey()[arg_12_0]

	if not var_12_0 then
		if var_0_21 then
			var_0_21.set(arg_12_0, arg_12_1, arg_12_2)

			return
		end

		error("Key not found: " .. arg_12_0)
	end

	local var_12_1 = var_0_7.indexOf(var_12_0).toObject()

	var_12_1[arg_12_1] = arg_12_2
	var_0_7._setData[var_12_0] = var_12_1
end

function var_0_7.get_index_data()
	if var_0_9 then
		return var_0_9
	end

	local var_13_0 = {}

	for iter_13_0, iter_13_1 in var_0_6(var_0_7._getKey()) do
		var_13_0[iter_13_0] = iter_13_1
	end

	if var_0_21 and var_0_21.get_index_data then
		local var_13_1 = var_0_7.getSelfLength()

		for iter_13_2, iter_13_3 in var_0_6(var_0_21.get_index_data()) do
			var_13_0[iter_13_2] = iter_13_3 + var_13_1
		end
	end

	var_0_9 = var_13_0

	return var_0_9
end

function var_0_7._getData()
	if not var_0_7._originData then
		var_0_7._originData = loadCfg("core.config.cfg.knight_info_os_data")

		for iter_14_0, iter_14_1 in var_0_6(var_0_7._data) do
			var_0_7._originData[iter_14_0] = iter_14_1
		end

		var_0_7._lastUseTime = os.time()
	end

	return var_0_7._originData
end

function var_0_7._getKey()
	if not var_0_8 then
		var_0_8 = loadCfg("core.config.cfg.knight_info_os_key")

		for iter_15_0, iter_15_1 in var_0_6(var_0_7._patchKey) do
			var_0_8[iter_15_0] = iter_15_1
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
		package.loaded["app.core.config.cfg.knight_info_os_data"] = nil
		package.loaded["app.core.config.cfg.knight_info_os_key"] = nil
		var_0_9 = nil

		if var_0_21 and var_0_21.checkDataClear then
			var_0_21.checkDataClear()
		end
	end
end

function var_0_7.patchClearOriginData()
	if var_0_7._originData ~= nil or var_0_8 ~= nil then
		var_0_7._originData = nil
		var_0_8 = nil
		var_0_7._lastUseTime = 0
		package.loaded["app.core.config.cfg.knight_info_os_data"] = nil
		package.loaded["app.core.config.cfg.knight_info_os_key"] = nil
		var_0_9 = nil
		var_0_7.__length = nil
	end
end

return var_0_7
