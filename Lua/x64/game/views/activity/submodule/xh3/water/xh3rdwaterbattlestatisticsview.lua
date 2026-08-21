local var_0_0 = import("game.views.battleResult.statistics.BattleStatisticsView")
local var_0_1 = class("XH3rdWaterBattleStatisticsView", var_0_0)

function var_0_1.UIName(arg_1_0)
	return "Widget/System/Formation/Cooperation/CooperationStatisticsUI"
end

function var_0_1.OnEnter(arg_2_0)
	var_0_1.super.OnEnter(arg_2_0)

	local var_2_0, var_2_1 = arg_2_0.stageData:GetIsCooperation()
	local var_2_2 = 0
	local var_2_3 = 0
	local var_2_4 = 45
	local var_2_5 = 59

	for iter_2_0 = 1, 3 do
		local var_2_6
		local var_2_7
		local var_2_8 = false

		if var_2_0 then
			var_2_6 = var_2_1[iter_2_0]

			if var_2_6 then
				local var_2_9 = var_2_6.playerID
				local var_2_10 = BattleFieldData:GetBattleResultData().battle_record_dir

				var_2_7 = var_2_10 and var_2_10[var_2_9]

				if var_2_7 then
					local var_2_11 = var_2_7[var_2_4] or 0

					if var_2_2 < var_2_11 then
						var_2_2 = var_2_11
					end

					local var_2_12 = var_2_7[var_2_5] or 0

					if var_2_3 < var_2_12 then
						var_2_3 = var_2_12
					end
				end

				var_2_8 = var_2_6.is_master
			end
		else
			local var_2_13, var_2_14, var_2_15 = BattleTools.GetBattleStatisticsData()

			var_2_8 = iter_2_0 == 1

			local var_2_16 = LuaExchangeHelper.GetBattleStatisticsData()
			local var_2_17 = var_2_16 and var_2_16.dataForLua.currentHPHero or {}
			local var_2_18 = arg_2_0.stageData:GetHeroTeam()
			local var_2_19 = var_2_17.Count or 0
			local var_2_20 = LuaExchangeHelper.GetBattleStatisticsData().dataForLua.recordDatas

			var_2_7 = {}

			if iter_2_0 <= var_2_19 then
				var_2_6 = {
					playerID = PlayerData:GetPlayerInfo().userID,
					nick = PlayerData:GetPlayerInfo().nick
				}

				local var_2_21

				if iter_2_0 == 1 and var_2_20:TryGetValue(var_2_4, var_2_21) then
					local var_2_22 = var_2_20[var_2_4] or 0

					if var_2_2 < var_2_22 then
						var_2_2 = var_2_22
					end

					var_2_7[var_2_4] = var_2_22
				end

				if iter_2_0 == 1 and var_2_20:TryGetValue(var_2_5, var_2_21) then
					local var_2_23 = var_2_20[var_2_5] or 0

					if var_2_3 < var_2_23 then
						var_2_3 = var_2_23
					end

					var_2_7[var_2_5] = var_2_23
				end
			end
		end

		arg_2_0.statisticsHeroItem_[iter_2_0]:SetPlayer(iter_2_0, arg_2_0.stageData:GetActivityID(), var_2_6, var_2_2, var_2_3, var_2_0, var_2_7, var_2_8)
	end
end

function var_0_1.GetStatisticsItem(arg_3_0)
	return XH3rdWaterBattleStatisticsItemView
end

return var_0_1
