class = var_0_10000

local var_0_0 = "IslandShipAttrLimitUnlockCommand"

pm = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody().id

	getProxy = var_1_10004
	IslandProxy = var_1_10005

	local var_1_1 = var_1_10004(var_1_10005)
	local var_1_2 = var_4.GetIsland(var_1_1)
	local var_1_3 = var_4.GetCharacterAgency(var_1_2)

	if not var_5.GetShipById(var_1_3, var_1_0) then
		return
	end

	pg = var_1_3

	local var_1_4 = var_1_3.ConnectionMgr.GetInstance()

	var_7.Send(var_1_4, 21603, {
		ship_id = var_1_0
	}, 21604, function(arg_2_0)
		if arg_2_0.result == 0 then
			Clone = var_1

			local var_2_0 = var_1(var_0)
			local var_2_1 = var_0

			var_2.SetUnlockExtraAttLimit(var_2_1)

			local var_2_2 = arg_1_0
			local var_2_3 = var_2.sendNotification

			GAME = var_2_10004

			var_2_3(var_2_2, var_2_10004.ISLNAD_SHIP_ATTR_LIMIT_UNLOCK_DONE)

			pg = var_2_3

			local var_2_4 = var_2_3.GameTrackerMgr.GetInstance()
			local var_2_5 = var_2.Record

			GameTrackerBuilder = var_4

			var_2_5(var_2_4, var_4.BuildIslandShipAttrLimit(var_2_0, var_0))
		end

		return
	end)

	return
end

return var_0_1
