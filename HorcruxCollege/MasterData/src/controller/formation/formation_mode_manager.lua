local FormationModeManager = class("FormationModeManager", (require("controller.formation.base_formation_manager")))

FormationModeManager.MULTITON_MSG = "FormationModeManager instancealready constructed!"

function FormationModeManager:ctor()
	FormationModeManager.super.ctor(self)
end

local var_0_1 = 5

function FormationModeManager:requestInfo(arg_2_1, arg_2_2, arg_2_3)
	self:requestModeInfo(arg_2_1, arg_2_2, function(arg_3_0)
		if arg_3_0.result == 1 then
			self._mode = arg_2_1

			if arg_2_3 then
				arg_2_3(arg_3_0)
			end
		end
	end)
end

function FormationModeManager:handlerInfo(arg_4_1)
	self:updateFormationInfo(arg_4_1.array)
	self:updateLayer()
end

function FormationModeManager:updateFormationInfo(arg_5_1)
	self._formationInfo = {
		{}
	}

	for iter_5_0, iter_5_1 in pairs(arg_5_1) do
		if string.sub(iter_5_0, 1, 3) == "pos" then
			self._formationInfo[1][iter_5_1.pos] = iter_5_1
			self._formationInfo[1][iter_5_1.pos].pos = iter_5_1.pos
		elseif iter_5_0 == "assist" then
			self._formationInfo[1].assist = iter_5_1
		end
	end
end

function FormationModeManager:getFormationInfo()
	return self._formationInfo
end

function FormationModeManager:getAssistsInfo()
	local var_7_0 = {}
	local var_7_1 = self:getFormationInfo()

	for iter_7_0 = 1, #var_7_1 do
		var_7_0[iter_7_0] = var_7_1[iter_7_0].assist or {}
	end

	return var_7_0
end

function FormationModeManager:checkAdventureArray()
	local var_8_0 = self._formationInfo[1] or {}
	local var_8_1 = 0

	for iter_8_0 = 1, var_0_1 do
		if var_8_0[iter_8_0].fight_girl then
			var_8_1 = var_8_1 + 1
		end
	end

	if var_8_1 <= 0 then
		return false, 1
	end

	return true
end

local var_0_2 = {
	wind = true,
	water = true,
	fire = true,
	light = true,
	dark = true
}

function FormationModeManager:checkIsSameColorTeam(arg_9_1)
	local var_9_0 = true

	if not arg_9_1 then
		return var_9_0
	end

	local levelmode_data = require("data.levelmode_data")
	local servant_data = require("data.servant_data")
	local model_data = require("data.model_data")

	if not levelmode_data[arg_9_1] then
		return var_9_0
	end

	local var_9_4 = levelmode_data[arg_9_1].ele_type or levelmode_data[arg_9_1].element_type

	if not var_9_4 then
		return var_9_0
	end

	if levelmode_data[arg_9_1].ele_type_show then
		var_9_4 = levelmode_data[arg_9_1].ele_type_show .. ",imaginary"
	end

	local var_9_5 = {}
	local var_9_6 = {}

	for iter_9_0 = 1, var_0_1 do
		table.insert(var_9_6, true)
	end

	for iter_9_1 in var_9_4:gmatch("([^,]+)") do
		table.insert(var_9_5, iter_9_1)
	end

	if var_9_5[1] == "imaginary" then
		table.remove(var_9_5, 2)
	end

	local var_9_7 = 0

	for iter_9_2 = 1, var_0_1 do
		if self._formationInfo[1][iter_9_2].fight_girl then
			var_9_7 = var_9_7 + 1

			local var_9_8 = false
			local var_9_9 = false

			for iter_9_3, iter_9_4 in ipairs(var_9_5) do
				if model_data[servant_data[self._formationInfo[1][iter_9_2].fight_girl].modelid][iter_9_4] then
					var_9_8 = true

					break
				end

				if var_0_2[iter_9_4] then
					var_9_9 = true
				end
			end

			if not var_9_8 and var_9_9 and model_data[servant_data[self._formationInfo[1][iter_9_2].fight_girl].modelid].imaginary then
				var_9_8 = true
			end

			var_9_6[iter_9_2] = var_9_8
		end
	end

	for iter_9_5, iter_9_6 in pairs(var_9_6) do
		if not iter_9_6 then
			var_9_0 = false

			break
		end
	end

	if var_9_5[1] == "all" then
		var_9_5 = {}
		var_9_0 = true
	end

	if not var_9_0 then
		if #var_9_5 == 1 then
			global_ShowBlockWords(L_SPECIAL_JUMPTOWERLAYER.other1 .. L_SORT_ATTR[ATTR_INDEX[var_9_5[1]]] .. L_SPECIAL_JUMPTOWERLAYER.other2)
		else
			local var_9_10 = 1
			local var_9_11 = ""

			while var_9_5[var_9_10] do
				var_9_11 = var_9_10 == #var_9_5 and var_9_11 .. L_SORT_ATTR[ATTR_INDEX[var_9_5[var_9_10]]] or var_9_11 .. L_SORT_ATTR[ATTR_INDEX[var_9_5[var_9_10]]] .. "/"
				var_9_10 = var_9_10 + 1
			end

			if #var_9_5 > 4 and #var_9_5 <= 5 then
				global_ShowBlockWords(L_SPECIAL_JUMPTOWERLAYER.other1 .. var_9_11 .. L_SPECIAL_JUMPTOWERLAYER.other2, nil, nil, nil, nil, 26)
			elseif #var_9_5 > 5 then
				global_ShowBlockWords(L_SPECIAL_JUMPTOWERLAYER.other1 .. var_9_11 .. L_SPECIAL_JUMPTOWERLAYER.other2, nil, nil, nil, nil, 24)
			else
				global_ShowBlockWords(L_SPECIAL_JUMPTOWERLAYER.other1 .. var_9_11 .. L_SPECIAL_JUMPTOWERLAYER.other2)
			end
		end
	end

	if var_9_7 == 0 then
		var_9_0 = false

		global_ShowBlockWords(L_TEAM_Array_WARNING.Type_Adventure[1], RISE_WORDS_FAIL)
	end

	return var_9_0
end

function FormationModeManager:requestOneTimeUpdateArray(arg_10_1, arg_10_2, arg_10_3)
	arg_10_1 = arg_10_1 or 1

	local var_10_0 = self:getFormationInfo()[arg_10_1]
	local audio_manager = require("controller.audio_manager")

	arg_10_2.assist = arg_10_2.assist or var_10_0.assist or {}

	print_lua_table(arg_10_2)
	print(dump(debug.traceback()))
	require("network.network"):rpc("update_adventure_array_onekey", {
		mode = self._mode,
		battlearray = arg_10_2
	}, function(arg_11_0)
		if arg_11_0.result == 1 then
			self:updateFormationInfo(arg_11_0.array)
			self:oneTimeUpdateSuccess()

			local var_11_0 = {}

			for iter_11_0, iter_11_1 in pairs(arg_10_2) do
				if type(iter_11_1) == "table" then
					var_11_0[iter_11_0] = iter_11_1
				end
			end

			if arg_10_3 then
				arg_10_3(arg_11_0)
			end

			self:playVoiceByArray(var_10_0, var_11_0)
		elseif arg_11_0.result == 2 then
			global_ShowBlockWords("角色未解锁")
			audio_manager:playeffectMusicTest("sound/invalid")
		elseif arg_11_0.result == 3 then
			global_ShowBlockWords("无效魂器")
			audio_manager:playeffectMusicTest("sound/invalid")
		elseif arg_11_0.result == 4 then
			global_ShowBlockWords("魂器对应位置未设置角色")
			audio_manager:playeffectMusicTest("sound/invalid")
		elseif arg_11_0.result == 5 then
			global_ShowBlockWords("设置了重复角色和魂器11111111")
			audio_manager:playeffectMusicTest("sound/invalid")
		elseif arg_11_0.result == 6 then
			global_ShowBlockWords("挂机阵容不能为空")
			audio_manager:playeffectMusicTest("sound/invalid")
		end
	end)
end

function FormationModeManager:getAdvanceForcesOneTimeArray()
	local playermodel = require("model.playermodel")
	local var_12_1 = {}

	for iter_12_0, iter_12_1 in pairs(playermodel.arrays[playermodel.curArray]) do
		if type(iter_12_1) == "table" then
			var_12_1[iter_12_0] = iter_12_1
		end
	end

	return var_12_1
end

return FormationModeManager
