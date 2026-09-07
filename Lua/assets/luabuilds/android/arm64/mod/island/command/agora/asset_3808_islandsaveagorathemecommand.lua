local IslandSaveAgoraThemeCommand = class("IslandSaveAgoraThemeCommand", pm.SimpleCommand)

function IslandSaveAgoraThemeCommand:execute(arg_1_1)
	local var_1_0 = arg_1_1:getBody()
	local var_1_1 = {
		id = var_1_0.themeData.id,
		name = var_1_0.themeData.name,
		placed_data = {
			placed_list = AgoraCalc.EncodePlaced(var_1_0.themeData.updateList),
			floor_data = AgoraCalc.EncodeLayer(var_1_0.themeData.floorList),
			tile_data = AgoraCalc.EncodeLayer(var_1_0.themeData.tileList)
		}
	}

	pg.ConnectionMgr.GetInstance():Send(21317, {
		theme = var_1_1
	}, 21318, function(arg_2_0)
		if arg_2_0.result == 0 then
			getProxy(IslandProxy):GetIsland():GetAgoraAgency():AddTheme(IslandTheme.New(var_1_1))
			self:sendNotification(GAME.ISLAND_SAVE_AGORA_THEME_DONE)
		end

		return
	end)

	return
end

return IslandSaveAgoraThemeCommand
