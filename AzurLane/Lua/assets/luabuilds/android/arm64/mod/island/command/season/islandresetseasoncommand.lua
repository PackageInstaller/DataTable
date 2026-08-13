class = var_0_10000

local var_0_0 = "IslandResetSeasonCommand"

pm = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1
	local var_1_1 = arg_1_1.getBody(var_1_0).callback

	pg = var_1_0

	local var_1_2 = var_1_0.ConnectionMgr.GetInstance()

	var_4.Send(var_1_2, 21024, {
		type = 0
	}, 21025, function(arg_2_0)
		if arg_2_0.result == 0 then
			getProxy = var_1
			IslandProxy = var_2_10003

			local var_2_0 = var_1(var_2_10003)

			var_2_10004 = var_1.GetIsland(var_2_0)

			local var_2_1 = var_1.GetSeasonAgency(var_2_10004)
			local var_2_2 = var_2.GetHighestRank(var_2_1)

			if arg_2_0.season_review then
				IslandSeasonReview = var_2_10004

				if not var_2_10004.New(arg_2_0.season_review) then
					var_2_10004 = nil
				end

				var_2:Reset(var_2_10004)

				local var_2_3 = var_1:GetInventoryAgency()
				local var_2_4 = var_5.OnSeasonReset(var_2_3)

				IslandDropHelper = var_2_10006

				local var_2_5 = var_2_10006.AddItems(arg_2_0)

				if var_2_10004 then
					local var_2_6 = var_2_10004
					local var_2_7 = var_2_10004.GetRecordData

					IslandSeasonReview = var_2_10010

					local var_2_8

					if not var_2_7(var_2_6, var_2_10010.KEYS.PT_RANK) then
						var_2_8 = 0
					end

					if var_2_8 ~= 0 and var_2_8 < var_2_2 then
						IslandAchievementHelper = var_8

						var_8.OnSeasonReset(var_2_8)
					end

					existCall = var_8

					var_8(var_1_1)

					IslandSeasonAgency = var_8

					local var_2_9 = var_8.AddResetData
					local var_2_10 = {
						awards = var_2_5.awards,
						pt = var_2_4
					}
					local var_2_11

					if not var_2_10004 or not var_2_10004.id then
						var_2_11 = 0
					end

					var_2_10.seasonId = var_2_11
					var_2_10.rank = var_2_8

					var_2_9(var_2_10)

					goto label_2_0

					pg = var_1

					do
						local var_2_12 = var_1.TipsMgr.GetInstance()
						local var_2_13 = var_1.ShowTips

						ERROR_MESSAGE = var_2_10004

						var_2_13(var_2_12, var_2_10004[arg_2_0.result] .. arg_2_0.result)
					end

					::label_2_0::

					return
				end
			end
		end
	end)

	return
end

return var_0_1
