class = var_0_10000

local var_0_0 = "IslandChangeViewDressCommand"

pm = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody().ship_id
	local var_1_1 = var_2.game_type
	local var_1_2 = var_2.type

	pg = var_1_10006

	local var_1_3 = var_1_10006.ConnectionMgr.GetInstance()

	var_6.Send(var_1_3, 23029, {
		type = var_1_2,
		game_type = var_1_1,
		ship_id = var_1_0
	}, 23030, function(arg_2_0)
		if arg_2_0.result == 0 then
			getProxy = var_1
			IslandProxy = var_2_10002

			local var_2_0 = var_1(var_2_10002)

			var_2_10003 = var_1.GetIsland(var_2_0)

			local var_2_1 = var_1.GetCharacterAgency(var_2_10003)

			var_2.SetMiniGameShipViewId(var_2_1, var_1_1, var_1_0)

			local var_2_2 = arg_1_0

			var_2_10003 = var_2_10003.sendNotification
			GAME = var_5

			var_2_10003(var_2_2, var_5.PLAY_ROOM_REFRESH_ROOM_INFO)
		else
			pg = var_1

			local var_2_3 = var_1.TipsMgr.GetInstance()
			local var_2_4 = var_1.ShowTips

			ERROR_MESSAGE = var_2_10003

			var_2_4(var_2_3, var_2_10003[arg_2_0.result] .. arg_2_0.result)
		end

		return
	end)

	return
end

return var_0_1
