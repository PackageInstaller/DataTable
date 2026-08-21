local var_0_0 = class("IslandSaveAgoraCommand", pm.SimpleCommand)

function var_0_0.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody()
	local var_1_1 = getProxy(IslandProxy):GetIsland():GetAgoraAgency()

	pg.ConnectionMgr.GetInstance():Send(21307, {
		update_data = {
			placed_list = AgoraCalc.EncodePlaced(var_1_0.list),
			floor_data = AgoraCalc.EncodeLayer(var_1_0.floorList),
			tile_data = AgoraCalc.EncodeLayer(var_1_0.tileList)
		}
	}, 21308, function(arg_2_0)
		if arg_2_0.result == 0 then
			var_1_1:UpdatePlacedData(var_0, true)
			pg.TipsMgr.GetInstance():ShowTips(i18n("island_agora_save_success"))
			pg.GameTrackerMgr.GetInstance():Record(GameTrackerBuilder.BuildIslandAgoraSave())
		else
			pg.TipsMgr.GetInstance():ShowTips(ERROR_MESSAGE[arg_2_0.result] .. arg_2_0.result)
		end

		return
	end)

	return
end

return var_0_0
