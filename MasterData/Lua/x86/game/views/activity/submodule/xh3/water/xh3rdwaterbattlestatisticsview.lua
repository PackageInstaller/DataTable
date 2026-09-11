local XH3rdWaterBattleStatisticsView = class("XH3rdWaterBattleStatisticsView", (import("game.views.battleResult.statistics.BattleStatisticsView")))

function XH3rdWaterBattleStatisticsView:UIName()
	return "Widget/System/Formation/Cooperation/CooperationStatisticsUI"
end

function XH3rdWaterBattleStatisticsView:OnEnter()
	XH3rdWaterBattleStatisticsView.super.OnEnter(self)

	local var_2_0, var_2_1 = self.stageData:GetIsCooperation()
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

			if var_2_1[iter_2_0] then
				local var_2_9 = BattleFieldData:GetBattleResultData().battle_record_dir

				var_2_7 = var_2_9 and var_2_9[var_2_6.playerID]

				if var_2_7 then
					local var_2_10 = var_2_7[var_2_4] or 0

					if var_2_2 < var_2_10 then
						var_2_2 = var_2_10
					end

					local var_2_11 = var_2_7[var_2_5] or 0

					if var_2_3 < var_2_11 then
						var_2_3 = var_2_11
					end
				end

				var_2_8 = var_2_6.is_master
			end
		else
			local var_2_12, var_2_13, var_2_14 = BattleTools.GetBattleStatisticsData()

			var_2_8 = iter_2_0 == 1

			local var_2_15 = LuaExchangeHelper.GetBattleStatisticsData()
			local var_2_16

			if var_2_15 then
				var_2_16 = var_2_15.dataForLua.currentHPHero or {}
			end

			local var_2_17 = self.stageData:GetHeroTeam()
			local var_2_18 = var_2_16.Count or 0
			local var_2_19 = LuaExchangeHelper.GetBattleStatisticsData().dataForLua.recordDatas

			var_2_7 = {}

			if iter_2_0 <= var_2_18 then
				var_2_6 = {
					playerID = PlayerData:GetPlayerInfo().userID,
					nick = PlayerData:GetPlayerInfo().nick
				}

				if iter_2_0 == 1 and var_2_19:TryGetValue(var_2_4, nil) then
					local var_2_20 = var_2_19[var_2_4] or 0

					if var_2_2 < var_2_20 then
						var_2_2 = var_2_20
					end

					var_2_7[var_2_4] = var_2_20
				end

				if iter_2_0 == 1 and var_2_19:TryGetValue(var_2_5, nil) then
					local var_2_21 = var_2_19[var_2_5] or 0

					if var_2_3 < var_2_21 then
						var_2_3 = var_2_21
					end

					var_2_7[var_2_5] = var_2_21
				end
			end
		end

		self.statisticsHeroItem_[iter_2_0]:SetPlayer(iter_2_0, self.stageData:GetActivityID(), var_2_6, var_2_2, var_2_3, var_2_0, var_2_7, var_2_8)
	end
end

function XH3rdWaterBattleStatisticsView:GetStatisticsItem()
	return XH3rdWaterBattleStatisticsItemView
end

return XH3rdWaterBattleStatisticsView
