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
	sound_attack1 = 29,
	txt_room_5 = 28,
	advance_id = 1,
	txt_star = 44,
	sound_star = 43,
	txt_level_5 = 42,
	sound_level_5 = 41,
	txt_level_4 = 40,
	sound_level_4 = 39,
	txt_level_3 = 38,
	sound_level_3 = 37,
	txt_level_2 = 36,
	sound_level_2 = 35,
	txt_level_1 = 34,
	sound_level_1 = 33,
	txt_attack2 = 32,
	sound_attack2 = 31,
	txt_attack1 = 30,
	pos_x = 3,
	res = 2,
	sound_room_5 = 27,
	txt_room_4 = 26,
	sound_room_4 = 25,
	txt_room_3 = 24,
	sound_room_3 = 23,
	txt_room_2 = 22,
	sound_room_2 = 21,
	txt_room_1 = 20,
	sound_room_1 = 19,
	txt_get = 18,
	sound_get = 17,
	start_chats_3 = 16,
	start_chats_2 = 15,
	start_chats_1 = 14,
	daily_chats_5 = 13,
	daily_chats_4 = 12,
	daily_chats_3 = 11,
	daily_chats_2 = 10,
	daily_chats_1 = 9,
	icon = 8,
	scale = 7,
	battle_pos_y = 6,
	battle_pos_x = 5,
	pos_y = 4
}
local var_0_10 = {
	txt_level_5 = 21,
	txt_room_4 = 13,
	txt_star = 22,
	txt_room_3 = 12,
	txt_room_2 = 11,
	txt_room_1 = 10,
	txt_get = 9,
	start_chats_3 = 8,
	start_chats_2 = 7,
	start_chats_1 = 6,
	daily_chats_5 = 5,
	daily_chats_4 = 4,
	daily_chats_3 = 3,
	daily_chats_2 = 2,
	daily_chats_1 = 1,
	txt_level_4 = 20,
	txt_level_3 = 19,
	txt_level_2 = 18,
	txt_level_1 = 17,
	txt_attack2 = 16,
	txt_attack1 = 15,
	txt_room_5 = 14
}
local var_0_11 = {
	20500050,
	20500050,
	-5,
	-61,
	-180,
	-116,
	"0.95",
	"20700720",
	"920_20700720_daily_chats_1",
	"920_20700720_daily_chats_2",
	"920_20700720_daily_chats_3",
	"920_20700720_daily_chats_4",
	"920_20700720_daily_chats_5",
	"920_20700720_start_chats_1",
	"920_20700720_start_chats_2",
	"920_20700720_start_chats_3",
	"Vo_20700720_get",
	"920_20700720_txt_get",
	"Vo_20700720_room4",
	"920_20700720_txt_room_1",
	"Vo_20700720_room1",
	"920_20700720_txt_room_2",
	"Vo_20700720_room2",
	"920_20700720_txt_room_3",
	"Vo_20700720_room3",
	"920_20700720_txt_room_4",
	"Vo_20700720_room5",
	"920_20700720_txt_room_5",
	"Vo_20700720_attack1",
	"920_20700720_txt_attack1",
	"Vo_20700720_attack2",
	"920_20700720_txt_attack2",
	"Vo_2070072001_favorite1",
	"920_20700720_txt_level_1",
	"Vo_2070072001_favorite2",
	"920_20700720_txt_level_2",
	"Vo_2070072001_favorite3",
	"920_20700720_txt_level_3",
	"Vo_2070072001_favorite4",
	"920_20700720_txt_level_4",
	"Vo_2070072001_favorite5",
	"920_20700720_txt_level_5",
	"Vo_2070072001_growup",
	"920_20700720_txt_star"
}
local var_0_12 = 44
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
			assert(var_0_9[arg_1_1], "cannot find " .. arg_1_1 .. " in record_succuba_show_info")

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
		var_0_7._originData = loadCfg("core.config.cfg.succuba_show_info_data")

		for iter_13_0, iter_13_1 in var_0_6(var_0_7._data) do
			var_0_7._originData[iter_13_0] = iter_13_1
		end

		var_0_7._lastUseTime = os.time()
	end

	return var_0_7._originData
end

function var_0_7._getKey()
	if not var_0_8 then
		var_0_8 = loadCfg("core.config.cfg.succuba_show_info_key")

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
		package.loaded["app.core.config.cfg.succuba_show_info_data"] = nil
		package.loaded["app.core.config.cfg.succuba_show_info_key"] = nil
	end
end

function var_0_7.patchClearOriginData()
	if var_0_7._originData ~= nil or var_0_8 ~= nil then
		var_0_7._originData = nil
		var_0_8 = nil
		var_0_7._lastUseTime = 0
		package.loaded["app.core.config.cfg.succuba_show_info_data"] = nil
		package.loaded["app.core.config.cfg.succuba_show_info_key"] = nil
	end
end

return var_0_7
