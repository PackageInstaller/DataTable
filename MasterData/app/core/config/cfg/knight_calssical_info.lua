local var_0_0 = {}
local var_0_1 = loadCfg("core.config.cfg.language_info")

var_0_0.id = 0
var_0_0.passive_id = 0

local var_0_2 = {
	_lastUseTime = 0,
	_data = {},
	_patchKey = {}
}
local var_0_3
local var_0_4 = {
	id = 1,
	passive_id = 2
}
local var_0_5 = {}
local var_0_6 = {
	1,
	8030
}
local var_0_7 = {
	__index = function(self, arg_1_1)
		if var_0_2._setData[self.index] then
			local var_1_0 = var_0_2._setData[self.index]

			if arg_1_1 == "toObject" then
				return function()
					local var_2_0 = {}

					for iter_2_0, iter_2_1 in pairs(var_0_4) do
						var_2_0[iter_2_0] = var_1_0[iter_2_0]
					end

					return var_2_0
				end
			else
				return var_0_2._setData[self.index][arg_1_1]
			end
		end

		local KsMath = require("app.core.utils.KsMath")
		local var_1_2 = math.ceil(#var_0_6 / 30)
		local var_1_3 = {}
		local var_1_4 = #var_0_6

		if arg_1_1 ~= "toObject" then
			assert(var_0_4[arg_1_1], "cannot find " .. arg_1_1 .. " in record_knight_calssical_info")

			var_1_4 = var_0_4[arg_1_1]
		end

		for iter_1_0 = 1, var_1_4 do
			local var_1_6

			if KsMath.mathBitSignCheck(self._raw[#self._raw - var_1_2 + math.ceil(iter_1_0 / 30)], ((iter_1_0 % 30 == 0 or nil) and 30) - 1) then
				var_1_3[iter_1_0] = 1
				var_1_6 = 1 + 1
			end
		end

		if arg_1_1 == "toObject" then
			return function()
				local var_3_0 = {}
				local var_3_1

				for iter_3_0, iter_3_1 in pairs(var_0_4) do
					if var_1_3[iter_3_1] then
						var_3_0[iter_3_0] = self._raw[var_1_3[iter_3_1]]
						var_3_1 = self._raw[var_1_3[iter_3_1]]
					else
						var_3_0[iter_3_0] = var_0_6[iter_3_1]
						var_3_1 = var_0_6[iter_3_1]
					end

					if var_0_5[iter_3_0] then
						var_3_0[iter_3_0] = var_0_1.get(var_3_1) and var_0_1.get(var_3_1).value or require("app.core.utils.KsMath").TRANS_ERROR_TIP()
					end
				end

				return var_3_0
			end
		end

		local var_1_7
		local var_1_8

		if var_1_3[var_0_4[arg_1_1]] then
			var_1_8 = self._raw[var_1_3[var_0_4[arg_1_1]]]
			var_1_7 = self._raw[var_1_3[var_0_4[arg_1_1]]]
		else
			var_1_8 = var_0_6[var_0_4[arg_1_1]]
			var_1_7 = var_0_6[var_0_4[arg_1_1]]
		end

		if var_0_5[arg_1_1] then
			return var_0_1.get(var_1_7) and var_0_1.get(var_1_7).value or require("app.core.utils.KsMath").TRANS_ERROR_TIP()
		end

		return var_1_8
	end
}
local var_0_8 = {
	__index = function(self, arg_4_1)
		if arg_4_1 == "toObject" then
			return function()
				local var_5_0 = {}

				for iter_5_0, iter_5_1 in pairs(var_0_4) do
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

function var_0_2.getLength()
	return #var_0_2._getData()
end

function var_0_2.indexOf(arg_8_0)
	if arg_8_0 == nil or not var_0_2._getData()[arg_8_0] then
		return nil
	end

	if var_0_2._setData[arg_8_0] then
		return setmetatable({
			_raw = var_0_2._setData[arg_8_0]
		}, var_0_8)
	else
		return setmetatable({
			_raw = var_0_2._getData()[arg_8_0],
			index = arg_8_0
		}, var_0_7)
	end
end

function var_0_2.get(arg_9_0)
	return var_0_2.indexOf(var_0_2._getKey()[arg_9_0])
end

function var_0_2.hasKey(arg_10_0)
	if var_0_4[arg_10_0] == nil then
		return false
	else
		return true
	end
end

var_0_2._setData = {}

function var_0_2.set(arg_11_0, arg_11_1, arg_11_2)
	local var_11_0 = var_0_2._getKey()[arg_11_0]
	local var_11_1 = var_0_2.indexOf(var_11_0).toObject()

	var_11_1[arg_11_1] = arg_11_2
	var_0_2._setData[var_11_0] = var_11_1
end

function var_0_2.get_index_data()
	return var_0_2._getKey()
end

function var_0_2._getData()
	if not var_0_2._originData then
		var_0_2._originData = loadCfg("core.config.cfg.knight_calssical_info_data")

		for iter_13_0, iter_13_1 in pairs(var_0_2._data) do
			var_0_2._originData[iter_13_0] = iter_13_1
		end

		var_0_2._lastUseTime = os.time()
	end

	return var_0_2._originData
end

function var_0_2._getKey()
	if not var_0_3 then
		var_0_3 = loadCfg("core.config.cfg.knight_calssical_info_key")

		for iter_14_0, iter_14_1 in pairs(var_0_2._patchKey) do
			var_0_3[iter_14_0] = iter_14_1
		end

		var_0_2._lastUseTime = os.time()
	end

	return var_0_3
end

function var_0_2.checkDataClear()
	if var_0_2._lastUseTime > 0 and os.time() - var_0_2._lastUseTime > g.core.const.ConstMgr.BASE_CONST.CONFIG_CHECK_DATA_DELTA then
		var_0_2._originData = nil
		var_0_3 = nil
		var_0_2._lastUseTime = 0
		package.loaded["app.core.config.cfg.knight_calssical_info_data"] = nil
		package.loaded["app.core.config.cfg.knight_calssical_info_key"] = nil
	end
end

function var_0_2.patchClearOriginData()
	if var_0_2._originData ~= nil or var_0_3 ~= nil then
		var_0_2._originData = nil
		var_0_3 = nil
		var_0_2._lastUseTime = 0
		package.loaded["app.core.config.cfg.knight_calssical_info_data"] = nil
		package.loaded["app.core.config.cfg.knight_calssical_info_key"] = nil
	end
end

return var_0_2
