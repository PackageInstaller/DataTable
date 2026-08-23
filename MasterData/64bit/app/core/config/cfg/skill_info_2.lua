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
	position = 15,
	skill_type = 16,
	skill_quality = 17,
	belong_advance_id = 18,
	buff_time_2 = 103,
	buff_prop_formula_2_value_1 = 102,
	buff_prop_formula_2 = 101,
	buff_prop_2 = 100,
	buff_target_value_2 = 99,
	buff_target_2 = 98,
	buff_2 = 97,
	buff_time_1 = 96,
	buff_prop_formula_1_value_1 = 95,
	buff_prop_formula_1 = 94,
	buff_prop_1 = 93,
	buff_target_value_1 = 92,
	buff_target_1 = 91,
	buff_1 = 90,
	affect_limit_6 = 89,
	formula_6_value_3 = 88,
	formula_6_value_2 = 87,
	formula_6_value_1 = 86,
	formula_6 = 85,
	skill_affect_prob_6 = 84,
	skill_affect_type_6 = 83,
	skill_range_value_6 = 82,
	skill_range_6 = 81,
	affect_limit_5 = 80,
	formula_5_value_3 = 79,
	formula_5_value_2 = 78,
	formula_5_value_1 = 77,
	formula_5 = 76,
	skill_affect_prob_5 = 75,
	skill_affect_type_5 = 74,
	skill_range_info = 143,
	skill_limit = 142,
	passive_skill_range = 141,
	passive_skill_id = 140,
	new_skill_id = 139,
	sp_type_value_2 = 138,
	sp_type_value = 137,
	sp_type = 136,
	buff_box_prop_1 = 135,
	buff_box_range_1 = 134,
	buff_box_1 = 133,
	buff_box_type_1 = 132,
	buff_time_6 = 131,
	buff_prop_formula_6_value_1 = 130,
	buff_prop_formula_6 = 129,
	buff_prop_6 = 128,
	buff_target_value_6 = 127,
	buff_target_6 = 126,
	buff_6 = 125,
	buff_time_5 = 124,
	buff_prop_formula_5_value_1 = 123,
	buff_prop_formula_5 = 122,
	buff_prop_5 = 121,
	buff_target_value_5 = 120,
	buff_target_5 = 119,
	buff_5 = 118,
	buff_time_4 = 117,
	buff_prop_formula_4_value_1 = 116,
	buff_prop_formula_4 = 115,
	buff_prop_4 = 114,
	buff_target_value_4 = 113,
	buff_target_4 = 112,
	buff_4 = 111,
	buff_time_3 = 110,
	buff_prop_formula_3_value_1 = 109,
	buff_prop_formula_3 = 108,
	buff_prop_3 = 107,
	buff_target_value_3 = 106,
	buff_target_3 = 105,
	buff_3 = 104,
	brief_description = 14,
	sign = 13,
	promote_description_2 = 12,
	promote_description = 11,
	split_description_2 = 10,
	split_description_1 = 9,
	description = 8,
	curtain_title = 7,
	curtain = 6,
	tween_pic = 5,
	level = 4,
	icon = 3,
	curtain_name = 2,
	id = 1,
	skill_range_value_5 = 73,
	skill_range_5 = 72,
	affect_limit_4 = 71,
	formula_4_value_3 = 70,
	formula_4_value_2 = 69,
	formula_4_value_1 = 68,
	formula_4 = 67,
	skill_affect_prob_4 = 66,
	skill_affect_type_4 = 65,
	skill_range_value_4 = 64,
	skill_range_4 = 63,
	affect_limit_3 = 62,
	formula_3_value_3 = 61,
	formula_3_value_2 = 60,
	formula_3_value_1 = 59,
	formula_3 = 58,
	skill_affect_prob_3 = 57,
	skill_affect_type_3 = 56,
	skill_range_value_3 = 55,
	skill_range_3 = 54,
	affect_limit_2 = 53,
	formula_2_value_3 = 52,
	formula_2_value_2 = 51,
	formula_2_value_1 = 50,
	formula_2 = 49,
	skill_affect_prob_2 = 48,
	skill_affect_type_2 = 47,
	skill_range_value_2 = 46,
	skill_range_2 = 45,
	affect_limit_1 = 44,
	formula_1_value_3 = 43,
	formula_1_value_2_step = 42,
	formula_1_value_2 = 41,
	formula_1_value_1_step = 40,
	formula_1_value_1 = 39,
	formula_1 = 38,
	skill_affect_prob_1 = 37,
	skill_affect_type_1 = 36,
	skill_range_value_1 = 35,
	skill_range_1 = 34,
	extra_stats_value_4 = 33,
	extra_stats_type_4 = 32,
	extra_stats_value_3 = 31,
	extra_stats_type_3 = 30,
	extra_stats_value_2 = 29,
	extra_stats_type_2 = 28,
	extra_stats_value_1 = 27,
	extra_stats_type_1 = 26,
	extra_cost_value = 25,
	extra_cost = 24,
	rage_value_2 = 23,
	rage_type_2 = 22,
	rage_value = 21,
	rage_type = 20,
	compose_id = 19
}
local var_0_10 = {
	split_description_2 = 3,
	description = 2,
	curtain_name = 1
}
local var_0_11 = {
	89,
	"1157_80010023_curtain_name",
	0,
	0,
	"0",
	0,
	0,
	"1157_80010023_curtain_name",
	"0",
	"1157_80010010_split_description_2",
	"0",
	"0",
	0,
	"0",
	"0",
	17,
	5,
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
	101,
	0,
	1000,
	0,
	0,
	20,
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
	0
}
local var_0_12 = 143
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
			assert(var_0_9[arg_1_1], "cannot find " .. arg_1_1 .. " in record_skill_info_2")

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
		var_0_7._originData = loadCfg("core.config.cfg.skill_info_2_data")

		for iter_13_0, iter_13_1 in var_0_6(var_0_7._data) do
			var_0_7._originData[iter_13_0] = iter_13_1
		end

		var_0_7._lastUseTime = os.time()
	end

	return var_0_7._originData
end

function var_0_7._getKey()
	if not var_0_8 then
		var_0_8 = loadCfg("core.config.cfg.skill_info_2_key")

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
		package.loaded["app.core.config.cfg.skill_info_2_data"] = nil
		package.loaded["app.core.config.cfg.skill_info_2_key"] = nil
	end
end

function var_0_7.patchClearOriginData()
	if var_0_7._originData ~= nil or var_0_8 ~= nil then
		var_0_7._originData = nil
		var_0_8 = nil
		var_0_7._lastUseTime = 0
		package.loaded["app.core.config.cfg.skill_info_2_data"] = nil
		package.loaded["app.core.config.cfg.skill_info_2_key"] = nil
	end
end

return var_0_7
