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
	painted_id = 12,
	name = 2,
	wing_direction = 4,
	cv = 20,
	story_pos_y = 9,
	weapon_res_6 = 37,
	name_offset_value = 51,
	weapon_slot_4 = 30,
	if_boss = 49,
	bg_pos_y = 6,
	weapon_slot_1 = 21,
	arter = 19,
	quality = 17,
	weapon_rotate_6 = 38,
	ignore_fly_back = 18,
	weapon_res_1 = 22,
	fight_id = 14,
	pre_spine_x = 42,
	weapon_rotate_1 = 23,
	weapon_slot_5 = 33,
	pre_pos_y = 40,
	pre_scale = 41,
	weapon_res_5 = 34,
	pre_spine_y = 43,
	popup_3 = 47,
	popup_1 = 45,
	pre_spine_scale = 44,
	pre_pos_x = 39,
	id = 1,
	popup_4 = 48,
	popup_2 = 46,
	weapon_rotate_3 = 29,
	body_type = 16,
	pos_x = 7,
	pic_pos_y = 11,
	weapon_res_3 = 28,
	weapon_slot_2 = 24,
	weapon_rotate_2 = 26,
	attack_away = 52,
	pos_y = 8,
	knight_show = 53,
	knight_show2 = 54,
	show_scene = 55,
	painted_id_work = 3,
	weapon_res_2 = 25,
	weapon_res_4 = 31,
	weapon_rotate_5 = 35,
	name_offset_type = 50,
	pic_pos_x = 10,
	weapon_rotate_4 = 32,
	icon_id = 15,
	weapon_slot_6 = 36,
	painted_bg_id = 13,
	weapon_slot_3 = 27,
	bg_pos_x = 5
}
local var_0_11 = {
	name = 1
}
local var_0_12 = {
	200000,
	"998_600100_name",
	1,
	1,
	0,
	0,
	0,
	0,
	0,
	0,
	0,
	301030,
	0,
	700970,
	301030,
	1,
	3,
	0,
	"",
	"",
	"weapon_light_1_slot",
	"",
	0,
	"weapon_lightning_1_slot",
	"eff_lightning_long",
	0,
	"",
	"",
	0,
	"",
	"",
	0,
	"",
	"",
	0,
	"",
	"",
	0,
	0,
	0,
	100,
	0,
	0,
	100,
	"",
	"",
	"",
	"",
	0,
	0,
	0,
	200,
	0,
	"0",
	0
}
local var_0_13 = 55
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
			assert(var_0_10[arg_1_1], "cannot find " .. arg_1_1 .. " in record_knight_base_info_os")

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
local var_0_19, var_0_20 = pcall(require, string.sub(var_0_17, 1, string.len(var_0_17) - string.len("knight_base_info_os")) .. "knight_base_info_2")
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
		var_0_7._originData = loadCfg("core.config.cfg.knight_base_info_os_data")

		for iter_14_0, iter_14_1 in var_0_6(var_0_7._data) do
			var_0_7._originData[iter_14_0] = iter_14_1
		end

		var_0_7._lastUseTime = os.time()
	end

	return var_0_7._originData
end

function var_0_7._getKey()
	if not var_0_8 then
		var_0_8 = loadCfg("core.config.cfg.knight_base_info_os_key")

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
		package.loaded["app.core.config.cfg.knight_base_info_os_data"] = nil
		package.loaded["app.core.config.cfg.knight_base_info_os_key"] = nil
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
		package.loaded["app.core.config.cfg.knight_base_info_os_data"] = nil
		package.loaded["app.core.config.cfg.knight_base_info_os_key"] = nil
		var_0_9 = nil
		var_0_7.__length = nil
	end
end

return var_0_7
