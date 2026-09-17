local var_0_0 = _G
local var_0_21 = FIGHTTYPE_SUBSTITUTION
local var_0_22 = FIGHTTYPE_AIATTACK
local var_0_23 = FIGHTTYPE_SUBSTITUTION_OLD
local var_0_25 = FIGHTTYPE_INFINITE
local var_0_26 = FIGHTTYPE_TOWER
local var_0_28 = FIGHTTYPE_EXPEDITION
local playermodel = require("model.playermodel")
local FightStatistics = require("fight.FightStatistics")
local core_manager = require("controller.core_manager")
local infinite_fight_manager = require("controller.infinite_fight_manager")
local substitution_manager = require("controller.substitution_manager")

return function(arg_1_0)
	return setfenv(function()
		function addStatistics(arg_3_0, arg_3_1, arg_3_2, arg_3_3, arg_3_4)
			FightStatistics.addStatistics(arg_3_0, arg_3_1, arg_3_2, arg_3_3, arg_3_4)
		end

		function dumpdata()
			FightStatistics.dumpdata()
		end

		function startStatistics()
			FightStatistics.startStatistics()
		end

		function stopStatistics()
			FightStatistics.stopStatistics()
		end

		function getStatisticsMsg()
			return FightStatistics.getStatisticsMsg()
		end

		function getStatisticModels()
			return FightStatistics.getStatisticModels()
		end

		function updateStatisticsModel()
			FightStatistics.updateStatisticsModel()
		end

		local function var_2_0(arg_10_0)
			if isNormalFight() and not isBigBossFight() then
				return
			end

			fightconsoleRef:updateDamageAddition(arg_10_0)
		end

		local var_2_1 = 0
		local var_2_2 = 1
		local var_2_3 = 0
		local var_2_4 = true

		function resetFightTimeStatistics()
			if not var_2_4 then
				return
			end

			var_2_1 = 0
			var_2_3 = 0
			var_2_2 = 1

			setGlobalDamageAddition(0)
			var_2_0(1)
		end

		function doResetFightTimeEnabled(arg_12_0)
			var_2_4 = arg_12_0
		end

		function updateFightTimeStatistics(arg_13_0)
			if fighttype == var_0_25 then
				infinite_fight_manager:sync_infinite_time(arg_13_0)

				return
			elseif fighttype == var_0_21 then
				substitution_manager:sync_substitution_time(arg_13_0)

				return
			elseif fighttype == var_0_0.FIGHTTYPE_EXPEDITION_MONOPOLY then
				var_0_0.require("controller.expedition_manager"):sync_expedition_time(arg_13_0)

				return
			end

			if fighttype ~= var_0_21 and fighttype ~= var_0_23 and fighttype ~= var_0_22 and fighttype ~= var_0_28 and fighttype ~= var_0_26 and fighttype ~= var_0_0.FIGHTTYPE_EXPEDITION_TOWER then
				local var_13_0 = {
					150,
					120,
					90,
					60,
					30
				}
				local var_13_1 = {
					90,
					90,
					40,
					10,
					5
				}
				local var_13_2 = {
					6,
					6,
					5,
					4,
					3
				}

				if var_2_1 < var_13_0[1] and var_2_1 + arg_13_0 >= var_13_0[1] then
					setGlobalDamageAddition(var_13_1[1])

					var_2_2 = var_13_2[1]

					var_2_0(var_13_2[1])
				elseif var_2_1 < var_13_0[2] and var_2_1 + arg_13_0 >= var_13_0[2] then
					setGlobalDamageAddition(var_13_1[2])

					var_2_2 = var_13_2[2]

					var_2_0(var_13_2[2])
				elseif var_2_1 < var_13_0[3] and var_2_1 + arg_13_0 >= var_13_0[3] then
					setGlobalDamageAddition(var_13_1[3])

					var_2_2 = var_13_2[3]

					var_2_0(var_13_2[3])
				elseif var_2_1 < var_13_0[4] and var_2_1 + arg_13_0 >= var_13_0[4] then
					setGlobalDamageAddition(var_13_1[4])

					var_2_2 = var_13_2[4]

					var_2_0(var_13_2[4])
				elseif var_2_1 < var_13_0[5] and var_2_1 + arg_13_0 >= var_13_0[5] then
					setGlobalDamageAddition(var_13_1[5])

					var_2_2 = var_13_2[5]

					var_2_0(var_13_2[5])
				elseif needGuideFight and var_2_1 < 2 and var_2_1 + arg_13_0 >= 2 and not var_0_0.GuideListener.isGuideFinish(var_0_0.TRIGGER_FIGHT, var_0_0.GUIDE_FIGHT_UI_CLASS) then
					var_0_0.GuideListener.triggerGuideFight(var_0_0.GUIDE_FIGHT_UI_CLASS, getPlayerItem(1))
				end

				var_2_1 = var_2_1 + arg_13_0

				fightconsoleRef:updateTime(var_2_1 - 150)
			elseif fighttype == var_0_23 then
				var_2_1 = var_2_1 + arg_13_0

				fightconsoleRef:updateTime(var_2_1 - 180)
			else
				var_2_1 = var_2_1 + arg_13_0

				fightconsoleRef:updateTime(var_2_1)
			end
		end

		function updateFightTimeByServer(arg_14_0, arg_14_1, arg_14_2)
			var_2_1 = arg_14_0

			fightconsoleRef:updateTime(var_2_1)

			if arg_14_1 then
				setGlobalDamageAddition(arg_14_2)

				var_2_2 = arg_14_1

				var_2_0(var_2_2)
			end
		end

		function getFightTimeStatistics()
			return var_2_1
		end

		function getFightStage()
			return var_2_2
		end

		function addClickXPCount()
			var_2_3 = var_2_3 + 1
		end

		function getClickXPCount()
			return var_2_3
		end

		function getCurFightArrayData()
			local var_19_0 = {}

			for iter_19_0 = 1, 4 do
				var_19_0[iter_19_0] = {}

				if playermodel.curSoul[iter_19_0] and playermodel.curSoul[iter_19_0].classtype == 1 then
					var_19_0[iter_19_0].fight_girl = playermodel.curSoul[iter_19_0].fight_girl
					var_19_0[iter_19_0].fight_girl_level = core_manager:getCoreLv(playermodel.curSoul[iter_19_0].fight_girl)
					var_19_0[iter_19_0].assist_girl = playermodel.curSoul[iter_19_0].assist_girl
				end
			end

			return var_19_0
		end
	end, arg_1_0)
end
