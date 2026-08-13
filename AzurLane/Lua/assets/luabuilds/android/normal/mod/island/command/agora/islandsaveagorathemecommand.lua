class = var_0_10000

local var_0_0 = "IslandSaveAgoraThemeCommand"

pm = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody().themeData.id
	local var_1_1 = var_2.themeData.name
	local var_1_2 = var_2.themeData.updateList
	local var_1_3 = var_2.themeData.floorList
	local var_1_4 = var_2.themeData.tileList

	AgoraCalc = var_1_10008

	local var_1_5 = var_1_10008.EncodePlaced(var_1_2)

	AgoraCalc = var_9

	local var_1_6 = var_9.EncodeLayer(var_1_3)

	AgoraCalc = var_10

	local var_1_7 = var_10.EncodeLayer(var_1_4)
	local var_1_8 = {
		id = var_1_0,
		name = var_1_1,
		placed_data = {
			placed_list = var_1_5,
			floor_data = var_1_6,
			tile_data = var_1_7
		}
	}

	pg = var_12

	local var_1_9 = var_12.ConnectionMgr.GetInstance()

	var_12.Send(var_1_9, 21317, {
		theme = var_1_8
	}, 21318, function(arg_2_0)
		if arg_2_0.result == 0 then
			getProxy = var_1
			IslandProxy = var_2_10002

			local var_2_0 = var_1(var_2_10002)
			local var_2_1 = var_1.GetIsland(var_2_0)
			local var_2_2 = var_1.GetAgoraAgency(var_2_1)
			local var_2_3 = var_2.AddTheme

			IslandTheme = var_2_10005

			var_2_3(var_2_2, var_2_10005.New(var_1_8))

			local var_2_4 = arg_1_0
			local var_2_5 = var_3.sendNotification

			GAME = var_5

			var_2_5(var_2_4, var_5.ISLAND_SAVE_AGORA_THEME_DONE)
		end

		return
	end)

	return
end

return var_0_1
