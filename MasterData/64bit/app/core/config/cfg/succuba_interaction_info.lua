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
	touch_x_2 = 33,
	lines_3_option_3 = 42,
	lines_3_option_2 = 41,
	lines_3_option_1 = 40,
	time_3 = 39,
	res_3 = 38,
	lines_3 = 37,
	sound_3 = 36,
	loop_time_2 = 35,
	touch_y_2 = 34,
	exp = 9,
	loop_res_2 = 32,
	lines_2_option_3 = 31,
	lines_2_option_2 = 30,
	lines_2_option_1 = 29,
	time_2 = 28,
	res_2 = 27,
	lines_2 = 26,
	sound_2 = 25,
	loop_time_1 = 24,
	touch_y_1 = 23,
	touch_x_1 = 22,
	loop_res_1 = 21,
	lines_1_option_3 = 20,
	lines_1_option_2 = 19,
	lines_1_option_1 = 18,
	time_1 = 17,
	res_1 = 16,
	lines_1 = 15,
	sound_1 = 14,
	value_2 = 13,
	type_2 = 12,
	value_1 = 11,
	type_1 = 10,
	unlock_star = 8,
	weight = 7,
	quality = 6,
	act_des = 5,
	act_name = 4,
	interaction_type = 3,
	interaction_group = 2,
	id = 1
}
local var_0_10 = {
	act_des = 2,
	act_name = 1,
	lines_1_option_3 = 6,
	lines_1_option_2 = 5,
	lines_1_option_1 = 4,
	lines_2_option_3 = 10,
	lines_3 = 11,
	lines_1 = 3,
	lines_2_option_2 = 9,
	lines_2_option_1 = 8,
	lines_3_option_3 = 14,
	lines_2 = 7,
	lines_3_option_2 = 13,
	lines_3_option_1 = 12
}
local var_0_11 = {
	1,
	20700360,
	1,
	"916_2_act_name",
	"916_1_act_des",
	1,
	8000,
	0,
	20,
	3,
	90,
	0,
	0,
	"Vo_20700720_interact1",
	"916_53_lines_1",
	"idle_A",
	6,
	"916_1_lines_1_option_1",
	"916_1_lines_1_option_1",
	"916_1_lines_1_option_1",
	"idle_A",
	"",
	"",
	0,
	"",
	"916_1_lines_1_option_1",
	"",
	0,
	"916_1_lines_1_option_1",
	"916_1_lines_1_option_1",
	"916_1_lines_1_option_1",
	"",
	"",
	"",
	0,
	"",
	"916_1_lines_1_option_1",
	"",
	0,
	"916_1_lines_1_option_1",
	"916_1_lines_1_option_1",
	"916_1_lines_1_option_1"
}
local var_0_12 = 42
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
			assert(var_0_9[arg_1_1], "cannot find " .. arg_1_1 .. " in record_succuba_interaction_info")

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
		var_0_7._originData = loadCfg("core.config.cfg.succuba_interaction_info_data")

		for iter_13_0, iter_13_1 in var_0_6(var_0_7._data) do
			var_0_7._originData[iter_13_0] = iter_13_1
		end

		var_0_7._lastUseTime = os.time()
	end

	return var_0_7._originData
end

function var_0_7._getKey()
	if not var_0_8 then
		var_0_8 = loadCfg("core.config.cfg.succuba_interaction_info_key")

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
		package.loaded["app.core.config.cfg.succuba_interaction_info_data"] = nil
		package.loaded["app.core.config.cfg.succuba_interaction_info_key"] = nil
	end
end

function var_0_7.patchClearOriginData()
	if var_0_7._originData ~= nil or var_0_8 ~= nil then
		var_0_7._originData = nil
		var_0_8 = nil
		var_0_7._lastUseTime = 0
		package.loaded["app.core.config.cfg.succuba_interaction_info_data"] = nil
		package.loaded["app.core.config.cfg.succuba_interaction_info_key"] = nil
	end
end

return var_0_7
