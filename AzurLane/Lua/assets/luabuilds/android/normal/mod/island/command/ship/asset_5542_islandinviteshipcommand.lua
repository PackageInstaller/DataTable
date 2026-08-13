class = var_0_10000

local var_0_0 = "IslandInviteShipCommand"

pm = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody().id

	getProxy = var_1_10004
	IslandProxy = var_1_10005

	local var_1_1 = var_1_10004(var_1_10005)
	local var_1_2 = var_4.GetIsland(var_1_1)
	local var_1_3 = var_4.GetCharacterAgency(var_1_2)

	pg = var_1_2

	local var_1_4 = var_1_2.ConnectionMgr.GetInstance()

	var_5.Send(var_1_4, 21609, {
		ship_id = var_1_0
	}, 21610, function(arg_2_0)
		local var_2_1

		if arg_2_0.result == 0 then
			local var_2_0 = var_1_3

			var_2_1.RemoveInvite(var_2_0, var_1_0)

			IslandShip = var_2_1
			var_2_1 = var_2_1.New(arg_2_0.ship)
			var_2_10003 = var_1_3

			var_2.AddShip(var_2_10003, var_2_1)

			var_2_10003 = arg_1_0

			local var_2_2 = var_2.sendNotification

			GAME = var_4

			var_2_2(var_2_10003, var_4.ISLAND_INVITE_SHIP_DONE, {
				ship = var_2_1
			})

			IslandBookHelper = var_2_2

			var_2_2.OnAddNewShip(var_2_1.id)

			IslandTaskHelper = var_2

			local var_2_3 = var_2.UpdateRuntimeTaskByTargetType

			IslandTaskTargetType = var_2_10003

			var_2_3(var_2_10003.UNLOCK_SHIP)

			pg = var_2_3
			var_2_10003 = var_2_3.GameTrackerMgr.GetInstance()

			local var_2_4 = var_2.Record

			GameTrackerBuilder = var_4

			var_2_4(var_2_10003, var_4.BuildIslandUnlockShip(var_1_0))
		else
			pg = var_2_1

			local var_2_5 = var_2_1.TipsMgr.GetInstance()
			local var_2_6 = var_1.ShowTips

			ERROR_MESSAGE = var_2_10003

			var_2_6(var_2_5, var_2_10003[arg_2_0.result] .. arg_2_0.result)
		end

		return
	end)

	return
end

return var_0_1
