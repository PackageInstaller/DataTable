class = var_0_10000

local var_0_0 = "IslandSaveAgoraCommand"

pm = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody().list
	local var_1_1 = var_2.floorList
	local var_1_2 = var_2.tileList

	getProxy = var_1_10006
	IslandProxy = var_1_10008

	local var_1_3 = var_1_10006(var_1_10008)
	local var_1_4 = var_6.GetIsland(var_1_3)
	local var_1_5 = var_6.GetAgoraAgency(var_1_4)

	AgoraCalc = var_1_3

	local var_1_6 = var_1_3.EncodeLayer(var_1_1)

	AgoraCalc = var_1_4

	local var_1_7 = var_1_4.EncodeLayer(var_1_2)

	AgoraCalc = var_10

	local var_1_8 = var_10.EncodePlaced(var_1_0)
	local var_1_9 = {
		placed_list = var_1_8,
		floor_data = var_1_6,
		tile_data = var_1_7
	}

	pg = var_12

	local var_1_10 = var_12.ConnectionMgr.GetInstance()

	var_12.Send(var_1_10, 21307, {
		update_data = var_1_9
	}, 21308, function(arg_2_0)
		local var_2_2

		if arg_2_0.result == 0 then
			local var_2_0 = var_1_5

			var_2_2.UpdatePlacedData(var_2_0, var_1_9, true)

			pg = var_2_2

			local var_2_1 = var_2_2.TipsMgr.GetInstance()

			var_2_2 = var_2_2.ShowTips
			i18n = var_2_10004

			var_2_2(var_2_1, var_2_10004("island_agora_save_success"))

			pg = var_2_2

			local var_2_3 = var_2_2.GameTrackerMgr.GetInstance()

			var_2_2 = var_2_2.Record
			GameTrackerBuilder = var_2_10004

			var_2_2(var_2_3, var_2_10004.BuildIslandAgoraSave())
		else
			pg = var_2_2

			local var_2_4 = var_2_2.TipsMgr.GetInstance()
			local var_2_5 = var_1.ShowTips

			ERROR_MESSAGE = var_2_10004

			var_2_5(var_2_4, var_2_10004[arg_2_0.result] .. arg_2_0.result)
		end

		return
	end)

	return
end

return var_0_1
