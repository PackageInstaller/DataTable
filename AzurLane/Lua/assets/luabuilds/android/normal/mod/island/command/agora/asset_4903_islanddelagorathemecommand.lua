class = var_0_10000

local var_0_0 = "IslandDelAgoraThemeCommand"

pm = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody().id

	print = var_1_10004

	var_1_10004("del------------->", var_1_0)

	getProxy = var_1_10004
	IslandProxy = var_5

	local var_1_1 = var_1_10004(var_5)
	local var_1_2 = var_4.GetIsland(var_1_1)
	local var_1_3 = var_4.GetAgoraAgency(var_1_2)

	var_5.DelTheme(var_1_3, var_1_0)

	local var_1_4 = arg_1_0
	local var_1_5 = arg_1_0.sendNotification

	GAME = var_8

	var_1_5(var_1_4, var_8.ISLAND_DEL_AGORA_THEME_DONE)

	return
end

return var_0_1
