local var_0_0 = class("IslandSaveAgoraThemeCommand", pm.SimpleCommand)

function var_0_0.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody()

	pg.ConnectionMgr.GetInstance():Send(21317, {
		theme = {
			id = var_1_0.themeData.id,
			name = var_1_0.themeData.name,
			placed_data = {
				placed_list = AgoraCalc.EncodePlaced(var_1_0.themeData.updateList),
				floor_data = AgoraCalc.EncodeLayer(var_1_0.themeData.floorList),
				tile_data = AgoraCalc.EncodeLayer(var_1_0.themeData.tileList)
			}
		}
	}, 21318, function(arg_2_0)
		if arg_2_0.result == 0 then
			getProxy(IslandProxy):GetIsland():GetAgoraAgency():AddTheme(IslandTheme.New(var_0))
			arg_1_0:sendNotification(GAME.ISLAND_SAVE_AGORA_THEME_DONE)
		end

		return
	end)

	return
end

return var_0_0
