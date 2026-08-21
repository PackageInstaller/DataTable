local var_0_0 = class("IslandGetAgoraThemesCommand", pm.SimpleCommand)

function var_0_0.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody().callback
	local var_1_1 = getProxy(IslandProxy):GetIsland()

	if var_1_1:GetAgoraAgency():IsUpdateThemes() then
		if var_1_0 then
			var_1_0()
		end

		return
	end

	pg.ConnectionMgr.GetInstance():Send(21321, {
		id = var_1_1.id
	}, 21322, function(arg_2_0)
		for iter_2_0, iter_2_1 in ipairs(arg_2_0.theme_list) do
			table.insert({}, IslandTheme.New(iter_2_1))
		end

		var_1_1:GetAgoraAgency():SetThemes({})

		if var_1_0 then
			var_1_0()
		end

		arg_1_0:sendNotification(GAME.ISLAND_GET_AGORA_THEME_DONE)

		return
	end)

	return
end

return var_0_0
