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
	hole_7_affect_type_2 = 45,
	hole_7_affect_value_1 = 44,
	hole_7_affect_type_1 = 43,
	hole_7_cost = 42,
	image_7 = 41,
	hole_6_affect_value_2 = 40,
	hole_6_affect_type_2 = 39,
	hole_6_affect_value_1 = 38,
	hole_6_affect_type_1 = 37,
	hole_6_cost = 36,
	image_6 = 35,
	hole_5_affect_value_2 = 34,
	hole_5_affect_type_2 = 33,
	hole_5_affect_value_1 = 32,
	hole_5_affect_type_1 = 31,
	hole_5_cost = 30,
	image_5 = 29,
	hole_4_affect_value_2 = 28,
	hole_4_affect_type_2 = 27,
	hole_4_affect_value_1 = 26,
	hole_4_affect_type_1 = 25,
	hole_4_cost = 24,
	image_4 = 23,
	hole_3_affect_value_2 = 22,
	hole_3_affect_type_2 = 21,
	hole_3_affect_value_1 = 20,
	hole_3_affect_type_1 = 19,
	hole_3_cost = 18,
	image_3 = 17,
	hole_2_affect_value_2 = 16,
	hole_2_affect_type_2 = 15,
	hole_2_affect_value_1 = 14,
	hole_2_affect_type_1 = 13,
	hole_2_cost = 12,
	image_2 = 11,
	hole_1_affect_value_2 = 10,
	hole_1_affect_type_2 = 9,
	hole_1_affect_value_1 = 8,
	hole_1_affect_type_1 = 7,
	hole_1_cost = 6,
	image_1 = 5,
	item_value = 4,
	item_type = 3,
	num = 2,
	id = 1,
	talent_id_5 = 57,
	talent_id_4 = 56,
	talent_id_3 = 55,
	talent_id_2 = 54,
	talent_id_1 = 53,
	hole_8_affect_value_2 = 52,
	hole_8_affect_type_2 = 51,
	hole_8_affect_value_1 = 50,
	hole_8_affect_type_1 = 49,
	hole_8_cost = 48,
	image_8 = 47,
	hole_7_affect_value_2 = 46
}
local var_0_10 = {}
local var_0_11 = {
	40010,
	8,
	3,
	63,
	3,
	1,
	3,
	2100,
	13,
	20,
	3,
	1,
	105,
	20,
	2,
	10,
	3,
	1,
	103,
	20,
	2,
	6300,
	3,
	1,
	104,
	20,
	1,
	2100,
	3,
	1,
	106,
	20,
	5,
	3200,
	3,
	1,
	4,
	2100,
	14,
	20,
	3,
	1,
	1,
	80000,
	11,
	20,
	3,
	1,
	2,
	4200,
	12,
	20,
	160186,
	160187,
	0,
	0,
	0
}
local var_0_12 = 57
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
			assert(var_0_9[arg_1_1], "cannot find " .. arg_1_1 .. " in record_unite_token_rune_info")

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
		var_0_7._originData = loadCfg("core.config.cfg.unite_token_rune_info_data")

		for iter_13_0, iter_13_1 in var_0_6(var_0_7._data) do
			var_0_7._originData[iter_13_0] = iter_13_1
		end

		var_0_7._lastUseTime = os.time()
	end

	return var_0_7._originData
end

function var_0_7._getKey()
	if not var_0_8 then
		var_0_8 = loadCfg("core.config.cfg.unite_token_rune_info_key")

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
		package.loaded["app.core.config.cfg.unite_token_rune_info_data"] = nil
		package.loaded["app.core.config.cfg.unite_token_rune_info_key"] = nil
	end
end

function var_0_7.patchClearOriginData()
	if var_0_7._originData ~= nil or var_0_8 ~= nil then
		var_0_7._originData = nil
		var_0_8 = nil
		var_0_7._lastUseTime = 0
		package.loaded["app.core.config.cfg.unite_token_rune_info_data"] = nil
		package.loaded["app.core.config.cfg.unite_token_rune_info_key"] = nil
	end
end

return var_0_7
