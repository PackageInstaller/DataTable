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
	talent_type_5 = 51,
	talent_value_4 = 50,
	talent_type_4 = 49,
	talent_value_3 = 48,
	talent_type_3 = 47,
	talent_value_2 = 46,
	talent_type_2 = 45,
	talent_value_1 = 44,
	talent_type_1 = 43,
	gm = 42,
	description = 41,
	type = 7,
	awaken_type_4 = 39,
	awaken_value_3 = 38,
	awaken_type_3 = 37,
	awaken_value_2 = 36,
	awaken_type_2 = 35,
	awaken_value_1 = 34,
	awaken_type_1 = 33,
	advanced_passive_skill_id_2 = 32,
	advanced_passive_skill_id_1 = 31,
	name = 2,
	skill_id = 29,
	compose_id = 28,
	basic_value_4 = 27,
	basic_type_4 = 26,
	basic_value_3 = 25,
	basic_type_3 = 24,
	basic_value_2 = 23,
	basic_type_2 = 22,
	basic_value_1 = 21,
	basic_type_1 = 20,
	upgrade_code = 19,
	unite_skill_id = 18,
	potential = 17,
	return_fragment_num = 16,
	fragment_id = 15,
	stamp_id = 14,
	next_star_id = 13,
	next_star_num = 12,
	star = 11,
	rare = 10,
	quality = 9,
	advance_id = 8,
	unite_type = 6,
	res_id = 5,
	put = 4,
	feature = 3,
	id = 1,
	awaken_value_4 = 40,
	passive_skill_id = 30,
	order = 61,
	spine = 60,
	sound_curtain = 59,
	sound_battle = 58,
	star_talent_5 = 57,
	star_talent_4 = 56,
	star_talent_3 = 55,
	star_talent_2 = 54,
	star_talent_1 = 53,
	talent_value_5 = 52
}
local var_0_11 = {
	description = 2,
	name = 1
}
local var_0_12 = {
	30001,
	"1019_30001_name",
	"高额伤害，无视隐匿",
	1,
	40030,
	2,
	1,
	40010,
	3,
	0,
	0,
	100,
	0,
	101,
	40010,
	100,
	12,
	0,
	20,
	1,
	1,
	2,
	0,
	3,
	0,
	4,
	0,
	40030,
	65,
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
	"1019_50130_description",
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
	"Vo_Combo_MaChao_ZhaoYun",
	"UI_Guwu_A",
	0,
	0
}
local var_0_13 = 61
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
			assert(var_0_10[arg_1_1], "cannot find " .. arg_1_1 .. " in record_unite_token_info_os")

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
local var_0_19, var_0_20 = pcall(require, string.sub(var_0_17, 1, string.len(var_0_17) - string.len("unite_token_info_os")) .. "unite_token_info_2")
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
		var_0_7._originData = loadCfg("core.config.cfg.unite_token_info_os_data")

		for iter_14_0, iter_14_1 in var_0_6(var_0_7._data) do
			var_0_7._originData[iter_14_0] = iter_14_1
		end

		var_0_7._lastUseTime = os.time()
	end

	return var_0_7._originData
end

function var_0_7._getKey()
	if not var_0_8 then
		var_0_8 = loadCfg("core.config.cfg.unite_token_info_os_key")

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
		package.loaded["app.core.config.cfg.unite_token_info_os_data"] = nil
		package.loaded["app.core.config.cfg.unite_token_info_os_key"] = nil
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
		package.loaded["app.core.config.cfg.unite_token_info_os_data"] = nil
		package.loaded["app.core.config.cfg.unite_token_info_os_key"] = nil
		var_0_9 = nil
		var_0_7.__length = nil
	end
end

return var_0_7
