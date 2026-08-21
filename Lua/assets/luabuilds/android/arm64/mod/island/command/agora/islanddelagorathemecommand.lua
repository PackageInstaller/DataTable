local var_0_0 = class("IslandDelAgoraThemeCommand", pm.SimpleCommand)

function var_0_0.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody().id

	print("del------------->", var_1_0)
	getProxy(IslandProxy):GetIsland():GetAgoraAgency():DelTheme(var_1_0)
	arg_1_0:sendNotification(GAME.ISLAND_DEL_AGORA_THEME_DONE)

	return
end

return var_0_0
