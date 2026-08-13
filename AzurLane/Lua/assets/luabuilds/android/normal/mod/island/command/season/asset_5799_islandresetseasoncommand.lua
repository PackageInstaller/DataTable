class = var_0_10000

local var_0_0 = "IslandResetSeasonCommand"

pm = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody().callback

	pg = var_1_10004

	local var_1_1 = var_1_10004.ConnectionMgr.GetInstance()

	var_4.Send(var_1_1, 21024, {
		type = 0
	}, 21025, function(arg_2_0)
		if arg_2_0.result == 0 then
			getProxy = var_1
			IslandProxy = var_2_10002

			local var_2_0 = var_1(var_2_10002)

			var_2_10003 = var_1.GetIsland(var_2_0)

			local var_2_1 = var_1.GetSeasonAgency(var_2_10003)

			var_2_10003 = var_2.GetHighestRank(var_2_1)

			if arg_2_0.season_review then
				IslandSeasonReview = var_4

				local var_2_2

				if not var_4.New(arg_2_0.season_review) then
					var_2_2 = nil
				end

				var_2:Reset(var_2_2)

				local var_2_3 = var_1:GetInventoryAgency()
				local var_2_4 = var_5.OnSeasonReset(var_2_3)

				IslandDropHelper = var_2_3

				local var_2_5 = var_2_3.AddItems(arg_2_0)

				if var_2_2 then
					var_2_10008 = var_2_2

					local var_2_6 = var_2_2.GetRecordData

					IslandSeasonReview = var_2_10009

					local var_2_7

					if not var_2_6(var_2_10008, var_2_10009.KEYS.PT_RANK) then
						var_2_7 = 0
					end

					if var_2_7 ~= 0 and var_2_7 < var_2_10003 then
						IslandAchievementHelper = var_2_10008

						var_2_10008.OnSeasonReset(var_2_7)
					end

					existCall = var_2_10008

					var_2_10008(var_1_0)

					IslandSeasonAgency = var_2_10008

					local var_2_8 = var_2_10008.AddResetData
					local var_2_9 = {
						awards = var_2_5.awards,
						pt = var_2_4
					}
					local var_2_10

					if not var_2_2 or not var_2_2.id then
						var_2_10 = 0
					end

					var_2_9.seasonId = var_2_10
					var_2_9.rank = var_2_7

					var_2_8(var_2_9)

					goto label_2_0

					pg = var_1

					do
						local var_2_11 = var_1.TipsMgr.GetInstance()
						local var_2_12 = var_1.ShowTips

						ERROR_MESSAGE = var_2_10003

						var_2_12(var_2_11, var_2_10003[arg_2_0.result] .. arg_2_0.result)
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
