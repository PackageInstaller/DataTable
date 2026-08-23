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
	star_talent_1 = 50,
	next_star_id = 49,
	return_fragment_num = 48,
	next_star_num = 47,
	fragment_id = 46,
	star = 45,
	energy_value_2 = 44,
	energy_type_2 = 43,
	energy_value_1 = 42,
	energy_type_1 = 41,
	initial_energy = 40,
	energy_skill_id = 39,
	advanced_passive_skill_id_3 = 38,
	advanced_passive_skill_id_2 = 37,
	advanced_passive_skill_id_1 = 36,
	shield_active = 35,
	active_skill_id = 34,
	shield_common = 33,
	common_id = 32,
	skill_factor = 31,
	initial_anger = 30,
	develop_magical_defence = 29,
	base_magical_defence = 28,
	develop_physical_defence = 27,
	base_physical_defence = 26,
	develop_attack = 25,
	base_attack = 24,
	develop_hp = 23,
	base_hp = 22,
	attack_range = 21,
	attack_type = 20,
	group = 19,
	character_tips = 18,
	sex = 16,
	res_id = 15,
	is_display = 14,
	put = 13,
	knight_star_id = 12,
	promote_code = 11,
	level_exp_id = 10,
	potential = 9,
	profession = 8,
	censor = 7,
	rare = 6,
	quality = 5,
	advance_id = 4,
	english_name = 3,
	id = 1,
	tactics = 81,
	promote_passive_14_3 = 153,
	classical = 203,
	token_value = 204,
	token_num = 205,
	is_element_leader = 206,
	army_skill_id = 207,
	army_passive_skill_id_1 = 208,
	wish_show = 202,
	homeland_talent = 201,
	mobility = 200,
	batch = 199,
	game_type = 198,
	trick_type = 197,
	purplize_sp_text = 196,
	purplize_type = 195,
	purplize_id = 194,
	if_au_knight = 193,
	awake_id = 192,
	disposition = 191,
	name_txt = 190,
	lineage_talent = 189,
	promote_passive_21_3 = 188,
	promote_passive_21_2 = 187,
	promote_passive_21_1 = 186,
	promote_talent_21 = 185,
	skill_type_21 = 184,
	promote_passive_20_3 = 183,
	promote_passive_20_2 = 182,
	promote_passive_20_1 = 181,
	promote_talent_20 = 180,
	skill_type_20 = 179,
	promote_passive_19_3 = 178,
	promote_passive_19_2 = 177,
	promote_passive_19_1 = 176,
	promote_talent_19 = 175,
	skill_type_19 = 174,
	promote_passive_18_3 = 173,
	promote_passive_18_2 = 172,
	promote_passive_18_1 = 171,
	promote_talent_18 = 170,
	skill_type_18 = 169,
	promote_passive_17_3 = 168,
	promote_passive_17_2 = 167,
	promote_passive_17_1 = 166,
	promote_talent_17 = 165,
	skill_type_17 = 164,
	promote_passive_16_3 = 163,
	promote_passive_16_2 = 162,
	promote_passive_16_1 = 161,
	promote_talent_16 = 160,
	skill_type_16 = 159,
	promote_passive_15_3 = 158,
	promote_passive_15_2 = 157,
	promote_passive_15_1 = 156,
	promote_talent_15 = 155,
	skill_type_15 = 154,
	type = 17,
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
	promote_passive_1_1 = 86,
	promote_talent_1 = 85,
	skill_type_1 = 84,
	gm = 83,
	passive_skill_1 = 82,
	name = 2,
	feature = 80,
	description = 79,
	association_18 = 78,
	association_17 = 77,
	association_16 = 76,
	association_15 = 75,
	association_14 = 74,
	association_13 = 73,
	association_12 = 72,
	association_11 = 71,
	association_10 = 70,
	association_9 = 69,
	association_8 = 68,
	association_7 = 67,
	association_6 = 66,
	association_5 = 65,
	association_4 = 64,
	association_3 = 63,
	association_2 = 62,
	association_1 = 61,
	star_talent_extra = 60,
	original_talent_3 = 59,
	original_talent_2 = 58,
	original_talent_1 = 57,
	star_talent_7 = 56,
	star_talent_6 = 55,
	star_talent_5 = 54,
	star_talent_4 = 53,
	star_talent_3 = 52,
	star_talent_2 = 51
}
local var_0_10 = {
	tactics = 4,
	name = 1,
	feature = 3,
	description = 2
}
local var_0_11 = {
	800100,
	"1142_800100_name",
	"Clara",
	800100,
	5,
	0,
	0,
	1,
	15,
	3,
	5,
	1,
	1,
	1,
	800100,
	0,
	2,
	2,
	2,
	2,
	6,
	14385,
	3017,
	1005,
	199,
	395,
	79,
	412,
	77,
	1,
	0,
	80010001,
	0,
	80010010,
	0,
	8001003,
	8001004,
	0,
	80010031,
	25,
	0,
	0,
	0,
	0,
	7,
	800100,
	60,
	60,
	0,
	840,
	841,
	842,
	843,
	844,
	845,
	846,
	0,
	0,
	0,
	0,
	1216,
	1217,
	1218,
	1219,
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
	"1142_800100_description",
	"1142_800100_feature",
	"1142_800100_tactics",
	0,
	0,
	3,
	13521,
	9000,
	0,
	0,
	3,
	13522,
	0,
	0,
	0,
	1,
	13523,
	0,
	0,
	0,
	3,
	13524,
	0,
	0,
	0,
	1,
	13525,
	0,
	0,
	0,
	3,
	13526,
	0,
	0,
	0,
	1,
	13527,
	0,
	0,
	0,
	1,
	13528,
	0,
	0,
	0,
	1,
	13529,
	0,
	0,
	0,
	1,
	13530,
	0,
	0,
	0,
	1,
	13531,
	0,
	0,
	0,
	1,
	13532,
	0,
	0,
	0,
	1,
	13533,
	0,
	0,
	0,
	1,
	13534,
	0,
	0,
	0,
	1,
	13535,
	0,
	0,
	0,
	1,
	13536,
	0,
	0,
	0,
	1,
	13537,
	0,
	0,
	0,
	1,
	13538,
	0,
	0,
	0,
	1,
	13539,
	0,
	0,
	0,
	1,
	13540,
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
	0,
	0,
	0,
	0,
	"0",
	0,
	0,
	0,
	2400,
	200,
	2,
	1,
	0,
	0,
	0,
	0,
	0
}
local var_0_12 = 208
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
			assert(var_0_9[arg_1_1], "cannot find " .. arg_1_1 .. " in record_knight_info_2")

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
		var_0_7._originData = loadCfg("core.config.cfg.knight_info_2_data")

		for iter_13_0, iter_13_1 in var_0_6(var_0_7._data) do
			var_0_7._originData[iter_13_0] = iter_13_1
		end

		var_0_7._lastUseTime = os.time()
	end

	return var_0_7._originData
end

function var_0_7._getKey()
	if not var_0_8 then
		var_0_8 = loadCfg("core.config.cfg.knight_info_2_key")

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
		package.loaded["app.core.config.cfg.knight_info_2_data"] = nil
		package.loaded["app.core.config.cfg.knight_info_2_key"] = nil
	end
end

function var_0_7.patchClearOriginData()
	if var_0_7._originData ~= nil or var_0_8 ~= nil then
		var_0_7._originData = nil
		var_0_8 = nil
		var_0_7._lastUseTime = 0
		package.loaded["app.core.config.cfg.knight_info_2_data"] = nil
		package.loaded["app.core.config.cfg.knight_info_2_key"] = nil
	end
end

return var_0_7
