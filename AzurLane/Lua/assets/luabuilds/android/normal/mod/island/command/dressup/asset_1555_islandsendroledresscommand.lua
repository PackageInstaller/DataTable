class = var_0_10000

local var_0_0 = "IslandSendRoleDressCommand"

pm = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody().ship_id
	local var_1_1 = var_2.dress_id

	getProxy = var_1_10005
	IslandProxy = var_1_10006

	local var_1_2 = var_1_10005(var_1_10006)
	local var_1_3 = var_5.GetIsland(var_1_2)

	pg = var_1_2

	local var_1_4 = var_1_2.ConnectionMgr.GetInstance()

	var_6.Send(var_1_4, 21615, {
		ship_id = var_1_0,
		dress_id = var_1_1
	}, 21616, function(arg_2_0)
		local var_2_1

		if arg_2_0.result == 0 then
			pg = var_2_1

			local var_2_0 = var_2_1.GameTrackerMgr.GetInstance()

			var_2_1 = var_2_1.Record
			GameTrackerBuilder = var_2_10003

			var_2_1(var_2_0, var_2_10003.BuildIslandBindDress(var_1_0, var_1_1))

			getProxy = var_2_1
			IslandProxy = var_2_0

			local var_2_2 = var_2_1(var_2_0)

			var_2_10003 = var_2_1.GetIsland(var_2_2)

			local var_2_3 = var_2_1.GetCharacterAgency(var_2_10003)

			var_2.ReduceDressItem(var_2_3, var_1_1, 1)

			local var_2_4 = var_2:GetShipById(var_1_0)

			var_2_10003.SetDressIdOwned(var_2_4, var_1_1)

			local var_2_5 = arg_1_0
			local var_2_6 = var_4.sendNotification

			GAME = var_6

			var_2_6(var_2_5, var_6.ISLAND_SEND_ROLE_DRESS_DONE, {
				dress_id = var_1_1
			})
		else
			pg = var_2_1

			local var_2_7 = var_2_1.TipsMgr.GetInstance()
			local var_2_8 = var_1.ShowTips

			ERROR_MESSAGE = var_2_10003

			var_2_8(var_2_7, var_2_10003[arg_2_0.result] .. arg_2_0.result)
		end

		return
	end)

	return
end

return var_0_1
