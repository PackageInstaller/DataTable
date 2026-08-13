class = var_0_10000

local var_0_0 = "IslandDelAgoraThemeCommand"

pm = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1
	local var_1_1 = arg_1_1.getBody(var_1_0).id

	print = var_1_0

	var_1_0("del------------->", var_1_1)

	getProxy = var_1_0
	IslandProxy = var_6

	local var_1_2 = var_1_0(var_6)
	local var_1_3 = var_4.GetIsland(var_1_2)
	local var_1_4 = var_4.GetAgoraAgency(var_1_3)

	var_5.DelTheme(var_1_4, var_1_1)

	local var_1_5 = arg_1_0
	local var_1_6 = arg_1_0.sendNotification

	GAME = var_9

	var_1_6(var_1_5, var_9.ISLAND_DEL_AGORA_THEME_DONE)

	return
end

return var_0_1
