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
	description = 8,
	buff_prop_formula_5 = 122,
	buff_prop_formula_2_value_1 = 102,
	formula_4_value_3 = 70,
	buff_prop_formula_4_value_1 = 116,
	extra_stats_value_1 = 27,
	buff_prop_formula_3_value_1 = 109,
	buff_target_5 = 119,
	formula_1_value_2_step = 42,
	sign = 13,
	buff_prop_formula_1_value_1 = 95,
	formula_4_value_1 = 68,
	formula_6_value_2 = 87,
	buff_target_value_1 = 92,
	buff_1 = 90,
	formula_4 = 67,
	tween_pic = 5,
	curtain = 6,
	split_description_2 = 10,
	skill_range_value_3 = 55,
	skill_affect_prob_6 = 84,
	formula_1_value_1_step = 40,
	compose_id = 19,
	affect_limit_1 = 44,
	formula_6_value_1 = 86,
	icon = 3,
	skill_affect_type_3 = 56,
	buff_target_value_2 = 99,
	id = 1,
	affect_limit_6 = 89,
	rage_value_2 = 23,
	buff_prop_1 = 93,
	extra_cost_value = 25,
	buff_target_value_3 = 106,
	affect_limit_2 = 53,
	buff_prop_formula_3 = 108,
	passive_skill_range = 141,
	skill_range_3 = 54,
	buff_prop_formula_6_value_1 = 130,
	buff_box_1 = 133,
	buff_box_range_1 = 134,
	skill_range_value_2 = 46,
	sp_type = 136,
	sp_type_value_2 = 138,
	formula_6_value_3 = 88,
	position = 15,
	split_description_1 = 9,
	passive_skill_id = 140,
	skill_affect_prob_3 = 57,
	skill_limit = 142,
	rage_type_2 = 22,
	buff_time_2 = 103,
	buff_prop_formula_1 = 94,
	rage_value = 21,
	rage_type = 20,
	skill_affect_type_5 = 74,
	buff_time_3 = 110,
	formula_6 = 85,
	buff_prop_formula_2 = 101,
	formula_4_value_2 = 69,
	buff_target_3 = 105,
	buff_time_1 = 96,
	buff_target_2 = 98,
	formula_2_value_1 = 50,
	formula_5 = 76,
	skill_affect_type_4 = 65,
	skill_affect_type_1 = 36,
	extra_stats_type_2 = 28,
	skill_affect_type_6 = 83,
	buff_prop_formula_6 = 129,
	promote_description_2 = 12,
	formula_2_value_3 = 52,
	extra_stats_type_4 = 32,
	buff_6 = 125,
	extra_stats_type_3 = 30,
	buff_prop_2 = 100,
	affect_limit_3 = 62,
	extra_stats_value_4 = 33,
	extra_cost = 24,
	skill_affect_type_2 = 47,
	buff_prop_formula_4 = 115,
	buff_target_6 = 126,
	skill_range_4 = 63,
	skill_range_2 = 45,
	promote_description = 11,
	curtain_title = 7,
	buff_target_1 = 91,
	new_skill_id = 139,
	buff_prop_4 = 114,
	skill_type = 16,
	level = 4,
	skill_affect_prob_5 = 75,
	skill_affect_prob_4 = 66,
	formula_2 = 49,
	buff_4 = 111,
	buff_time_6 = 131,
	extra_stats_value_2 = 29,
	buff_prop_3 = 107,
	extra_stats_value_3 = 31,
	formula_5_value_1 = 77,
	buff_5 = 118,
	formula_1 = 38,
	buff_time_4 = 117,
	brief_description = 14,
	buff_2 = 97,
	skill_range_info = 143,
	buff_target_value_6 = 127,
	buff_time_5 = 124,
	curtain_name = 2,
	formula_5_value_3 = 79,
	formula_3_value_1 = 59,
	buff_3 = 104,
	buff_prop_5 = 121,
	buff_box_prop_1 = 135,
	formula_5_value_2 = 78,
	skill_range_value_6 = 82,
	belong_advance_id = 18,
	buff_target_value_5 = 120,
	affect_limit_5 = 80,
	formula_1_value_1 = 39,
	buff_target_4 = 112,
	formula_3_value_3 = 61,
	extra_stats_type_1 = 26,
	affect_limit_4 = 71,
	buff_prop_6 = 128,
	formula_3 = 58,
	buff_prop_formula_5_value_1 = 123,
	formula_3_value_2 = 60,
	skill_range_value_1 = 35,
	formula_1_value_3 = 43,
	skill_range_5 = 72,
	skill_range_6 = 81,
	formula_1_value_2 = 41,
	skill_affect_prob_1 = 37,
	buff_box_type_1 = 132,
	formula_2_value_2 = 51,
	skill_range_value_5 = 73,
	skill_affect_prob_2 = 48,
	skill_range_value_4 = 64,
	skill_quality = 17,
	sp_type_value = 137,
	skill_range_1 = 34,
	buff_target_value_4 = 113
}
local var_0_11 = {
	description = 2,
	curtain_name = 1,
	split_description_2 = 3
}
local var_0_12 = {
	1,
	"256_35_description",
	0,
	1,
	"0",
	0,
	0,
	"256_35_description",
	"0",
	"256_1_split_description_2",
	"0",
	"0",
	0,
	"0",
	"0",
	17,
	3,
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
	1,
	1000,
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
	1000,
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
	0
}
local var_0_13 = 143
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
			assert(var_0_10[arg_1_1], "cannot find " .. arg_1_1 .. " in record_skill_info")

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
local var_0_19, var_0_20 = pcall(require, string.sub(var_0_17, 1, string.len(var_0_17) - string.len("skill_info")) .. "skill_info_2")
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
		var_0_7._originData = loadCfg("core.config.cfg.skill_info_data")

		for iter_14_0, iter_14_1 in var_0_6(var_0_7._data) do
			var_0_7._originData[iter_14_0] = iter_14_1
		end

		var_0_7._lastUseTime = os.time()
	end

	return var_0_7._originData
end

function var_0_7._getKey()
	if not var_0_8 then
		var_0_8 = loadCfg("core.config.cfg.skill_info_key")

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
		package.loaded["app.core.config.cfg.skill_info_data"] = nil
		package.loaded["app.core.config.cfg.skill_info_key"] = nil
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
		package.loaded["app.core.config.cfg.skill_info_data"] = nil
		package.loaded["app.core.config.cfg.skill_info_key"] = nil
		var_0_9 = nil
		var_0_7.__length = nil
	end
end

return var_0_7
