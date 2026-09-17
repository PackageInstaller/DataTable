local FormationPointsMatchManager = class("FormationPointsMatchManager", (require("controller.formation.base_formation_manager")))

FormationPointsMatchManager.MULTITON_MSG = "FormationPointsMatchManager instancealready constructed!"

function FormationPointsMatchManager:ctor()
	FormationPointsMatchManager.super.ctor(self)
end

function FormationPointsMatchManager:requestInfo(arg_2_1)
	require("network.network"):rpc("get_scorearena_battlearray", {
		default = require("model.playermodel").scorearenaAttackArray
	}, function(arg_3_0)
		if arg_3_0.result == 1 then
			self:handlerInfo(arg_3_0)

			if arg_2_1 then
				arg_2_1(arg_3_0)
			end
		end
	end)
end

function FormationPointsMatchManager:requestUpdateArrayFightgirl(arg_4_1, arg_4_2, arg_4_3)
	local var_4_0 = self:getFormationInfo()[1] or {}

	if arg_4_2 then
		for iter_4_0 = 1, #var_4_0 do
			if var_4_0[iter_4_0].fight_girl == arg_4_2 then
				arg_4_3({
					result = 4
				})

				return
			end
		end
	end

	local network = require("network.network")

	arg_4_1 = tonumber(arg_4_1)
	arg_4_2 = tonumber(arg_4_2)

	if arg_4_1 then
		local var_4_2 = {}

		var_4_2.id = -3
		var_4_2.pos = arg_4_1
		var_4_2.servantid = arg_4_2

		network:rpc("update_array_fightgirl", var_4_2, function(arg_5_0)
			if arg_5_0.result == 1 then
				self:updateFormationInfo(arg_5_0.array)
				self:updateGirlSuccess(arg_4_1)

				if arg_4_3 then
					arg_4_3(arg_5_0)
				end

				self:playVoiceById(arg_4_2)
			elseif arg_5_0.result == 5 then
				global_ShowBlockWords(L_GIRL_SELECT_CHANGE_WARNING.Clear_Waring[1], RISE_WORDS_FAIL)
				require("controller.audio_manager"):playeffectMusicTest("sound/invalid")
			elseif arg_5_0.result == 6 then
				global_ShowBlockWords(L_GIRL_SELECT_CHANGE_WARNING.Clear_Waring[2], RISE_WORDS_FAIL)
				require("controller.audio_manager"):playeffectMusicTest("sound/invalid")
			elseif arg_5_0.result == 8 then
				global_ShowBlockWords(L_GIRL_SELECT_CHANGE_WARNING.Clear_Waring[3], RISE_WORDS_FAIL)
				require("controller.audio_manager"):playeffectMusicTest("sound/invalid")
			elseif arg_5_0.result == 4 then
				global_ShowBlockWords(L_GIRL_SELECT_CHANGE_WARNING.Clear_Waring[5], RISE_WORDS_FAIL)
				require("controller.audio_manager"):playeffectMusicTest("sound/invalid")
			end
		end)
	end
end

function FormationPointsMatchManager:requestUpdateArrayAssisgirl(arg_6_1, arg_6_2, arg_6_3)
	arg_6_1 = tonumber(arg_6_1)
	arg_6_2 = tonumber(arg_6_2)

	if arg_6_1 then
		local var_6_0 = {}

		var_6_0.id = -3
		var_6_0.pos = arg_6_1
		var_6_0.assistgirl = arg_6_2

		require("network.network"):rpc("update_array_assistgirl", var_6_0, function(arg_7_0)
			if arg_7_0.result == 1 then
				self:updateFormationInfo(arg_7_0.array)

				if arg_6_3 then
					arg_6_3(arg_7_0)
				end
			elseif arg_7_0.result == 2 then
				global_ShowBlockWords(L_HORCRUXSELECT_WARNING[2])
				require("controller.audio_manager"):playeffectMusicTest("sound/invalid")
			elseif arg_7_0.result == 3 then
				global_ShowBlockWords(L_HORCRUXSELECT_WARNING[3])
				require("controller.audio_manager"):playeffectMusicTest("sound/invalid")
			elseif arg_7_0.result == 4 then
				global_ShowBlockWords(L_HORCRUXSELECT_WARNING[4])
				require("controller.audio_manager"):playeffectMusicTest("sound/invalid")
			elseif arg_7_0.result == 6 then
				audioManager:playeffectMusicTest("sound/invalid")

				local audio_manager = require("controller.audio_manager")

				global_ShowBlockWords(L_HORCRUXSELECT_WARNING[6])
			elseif arg_7_0.result == 7 then
				audioManager:playeffectMusicTest("sound/invalid")

				local var_7_1 = require("controller.audio_manager")

				global_ShowBlockWords(L_HORCRUXSELECT_WARNING[7])
			end
		end)
	end
end

function FormationPointsMatchManager:requestChallenge(arg_8_1, arg_8_2)
	local var_8_0 = self:getFormationInfo()
	local var_8_1 = self:getCurFormationIndex()

	if var_8_0[var_8_1] then
		for iter_8_0, iter_8_1 in pairs(var_8_0[var_8_1]) do
			if iter_8_1.fight_girl then
				require("controller.scorearena_manager"):start_score_arena_fight(nil, arg_8_1, function(arg_9_0)
					if arg_9_0 == 1 then
						LayerManager:switchShowLayer("FightLayer", {
							is_hide_topcost = true,
							is_hide_listbutton = true
						})
					end
				end)

				return
			end
		end

		global_ShowBlockWords(L_TEAM_Array_WARNING.Type_ScoreArena[1], RISE_WORDS_FAIL)
		require("controller.audio_manager"):playeffectMusicTest("sound/invalid")
	end
end

function FormationPointsMatchManager:handlerInfo(arg_10_1)
	self:updateFormationInfo(arg_10_1.array)
	self:updateLayer()
end

function FormationPointsMatchManager:updateFormationInfo(arg_11_1)
	self._formationInfo = {
		{}
	}

	for iter_11_0, iter_11_1 in pairs(arg_11_1) do
		if string.find(iter_11_0, "pos") then
			self._formationInfo[1][iter_11_1.pos] = iter_11_1
			self._formationInfo[1][iter_11_1.pos].pos = iter_11_1.pos
		elseif iter_11_0 == "assist" then
			self._formationInfo[1].assist = iter_11_1
		end
	end
end

function FormationPointsMatchManager:getAssistsInfo()
	local var_12_0 = {}
	local var_12_1 = self:getFormationInfo()

	for iter_12_0 = 1, #var_12_1 do
		var_12_0[iter_12_0] = var_12_1[iter_12_0].assist or {}
	end

	return var_12_0
end

function FormationPointsMatchManager:requestOneTimeUpdateArray(arg_13_1, arg_13_2, arg_13_3)
	arg_13_1 = arg_13_1 or 1

	local var_13_0 = self:getFormationInfo()[arg_13_1]
	local array_manager = require("controller.array_manager")
	local audio_manager = require("controller.audio_manager")

	arg_13_2.assist = arg_13_2.assist or require("model.playermodel").arrays[arg_13_1].assist or {}

	require("network.network"):rpc("update_array_onekey", {
		id = -3,
		battlearray = arg_13_2
	}, function(arg_14_0)
		if arg_14_0.result == 1 then
			self:updateFormationInfo(arg_14_0.array)
			self:oneTimeUpdateSuccess()

			local var_14_0 = {}

			for iter_14_0, iter_14_1 in pairs(arg_13_2) do
				if type(iter_14_1) == "table" then
					var_14_0[iter_14_0] = iter_14_1
				end
			end

			if arg_13_3 then
				arg_13_3(arg_14_0)
			end

			self:playVoiceByArray(var_13_0, var_14_0)
		elseif arg_14_0.result == 2 then
			global_ShowBlockWords("角色未解锁")
			audio_manager:playeffectMusicTest("sound/invalid")
		elseif arg_14_0.result == 3 then
			global_ShowBlockWords("无效魂器")
			audio_manager:playeffectMusicTest("sound/invalid")
		elseif arg_14_0.result == 4 then
			global_ShowBlockWords("魂器对应位置未设置角色")
			audio_manager:playeffectMusicTest("sound/invalid")
		elseif arg_14_0.result == 5 then
			global_ShowBlockWords("设置了重复角色和魂器")
			audio_manager:playeffectMusicTest("sound/invalid")
		elseif arg_14_0.result == 6 then
			global_ShowBlockWords("挂机阵容不能为空")
			audio_manager:playeffectMusicTest("sound/invalid")
		end
	end)
end

return FormationPointsMatchManager
