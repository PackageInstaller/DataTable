local var_0_0 = class("IslandResetSeasonCommand", pm.SimpleCommand)

function var_0_0.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody().callback

	pg.ConnectionMgr.GetInstance():Send(21024, {
		type = 0
	}, 21025, function(arg_2_0)
		local var_2_9000

		if arg_2_0.result == 0 then
			local var_2_0 = getProxy(IslandProxy):GetIsland()
			local var_2_1 = var_2_0:GetSeasonAgency()
			local var_2_2 = var_2_1:GetHighestRank()
			local var_2_3 = arg_2_0.season_review and IslandSeasonReview.New(arg_2_0.season_review) or nil

			var_2_1:Reset(var_2_3)

			local var_2_4 = var_2_0:GetInventoryAgency()
			local var_2_5 = var_2_4.OnSeasonReset(var_2_9000)
			local var_2_6 = IslandDropHelper.AddItems(arg_2_0)
			local var_2_7 = var_2_3 and var_2_3:GetRecordData(IslandSeasonReview.KEYS.PT_RANK) or 0

			if var_2_4 ~= 0 and var_2_7 < var_2_2 then
				IslandAchievementHelper.OnSeasonReset(var_2_7)
			end

			existCall(var_1_0)

			local var_2_9 = {
				awards = var_2_6.awards,
				pt = var_2_5
			}

			if var_2_3 then
				var_2_9.seasonId = var_2_3.id or 0
				var_2_9.rank = var_2_7

				var_2_8(var_2_9)

				if false then
					pg.TipsMgr.GetInstance():ShowTips(ERROR_MESSAGE[arg_2_0.result] .. arg_2_0.result)
				end

				return
			end
		end
	end)

	return
end

return var_0_0
