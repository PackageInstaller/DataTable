class = var_0_10000

local var_0_0 = "IslandGiveGiftCommand"

pm = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody().id
	local var_1_1 = var_2.itemId

	pg = var_1_10005

	local var_1_2 = var_1_10005.ConnectionMgr.GetInstance()

	var_5.Send(var_1_2, 21613, {
		ship_id = var_1_0,
		gift_id = var_1_1
	}, 21614, function(arg_2_0)
		if arg_2_0.result == 0 then
			IslandItem = var_2_0

			local var_2_0 = var_2_0.StaticGetUsageArg(var_1_1)

			getProxy = var_2
			IslandProxy = var_2_10003
			var_2_10003 = var_2(var_2_10003)
			var_2_10003 = var_2.GetIsland(var_2_10003)

			local var_2_1 = var_2.GetCharacterAgency(var_2_10003)
			local var_2_2 = var_2.GetShipById(var_2_1, var_1_0)

			if var_2_10003.IsFavoriteGift(var_2_2, var_1_1) then
				IslandConst = var_2_3

				local var_2_3

				if not var_2_3.GIFT_INDEX_FAVORITE then
					IslandConst = var_2_3
					var_2_3 = var_2_3.GIFT_INDEX_COMMON
				end

				ipairs = var_2_2

				for iter_2_0, iter_2_1 in var_2_2(var_2_0) do
					if var_2_3 == iter_2_0 then
						local var_2_4 = iter_2_1[1]
						local var_2_5 = iter_2_1[2]

						ipairs = var_2_10012

						for iter_2_2, iter_2_3 in var_2_10012(var_2_5) do
							IslandShipStatus = var_2_10017
							var_2_10017 = var_2_10017.New

							local var_2_6 = {
								id = iter_2_3
							}

							pg = var_2_10019

							local var_2_7 = var_2_10019.TimeMgr.GetInstance()

							var_2_6.start_time = var_2_10019.GetServerTime(var_2_7)
							var_2_10017 = var_2_10017(var_2_6)
							var_2_10019 = var_2_10003

							var_2_10003.AddStatus(var_2_10019, var_2_10017)
						end

						var_2_10003:AddEnergy(var_2_4)
					end
				end

				getProxy = var_5
				IslandProxy = var_6

				local var_2_8 = var_5(var_6)
				local var_2_9 = var_5.GetIsland(var_2_8)
				local var_2_10 = var_5.GetInventoryAgency(var_2_9)

				var_5.RemoveItem(var_2_10, var_1_1, 1)

				local var_2_11 = arg_1_0
				local var_2_12 = var_6.sendNotification

				GAME = var_8

				var_2_12(var_2_11, var_8.ISLAND_GIVE_GIFT_DONE)

				pg = var_2_12

				local var_2_13 = var_2_12.GameTrackerMgr.GetInstance()
				local var_2_14 = var_6.Record

				GameTrackerBuilder = var_8

				var_2_14(var_2_13, var_8.BuildIslandShipGiveGift(var_1_0, var_1_1))

				pg = var_2_14

				local var_2_15 = var_2_14.TipsMgr.GetInstance()
				local var_2_16 = var_6.ShowTips

				i18n = var_8

				var_2_16(var_2_15, var_8("island_give_gift_success"))

				if false then
					pg = var_2_0

					local var_2_17 = var_2_0.TipsMgr.GetInstance()
					local var_2_18 = var_1.ShowTips

					ERROR_MESSAGE = var_2_10003

					var_2_18(var_2_17, var_2_10003[arg_2_0.result] .. arg_2_0.result)
				end

				return
			end
		end
	end)

	return
end

return var_0_1
