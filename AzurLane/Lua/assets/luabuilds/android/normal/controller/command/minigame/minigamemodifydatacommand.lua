class = var_0_10000

local var_0_0 = "MiniGameModifyDataCommand"

pm = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody().id
	local var_1_1 = var_2.map

	getProxy = var_1_10005
	MiniGameProxy = var_1_10006

	local var_1_2 = var_1_10005(var_1_10006)
	local var_1_3 = var_5.GetMiniGameData(var_1_2, var_1_0)

	pairs = var_1_2

	for iter_1_0, iter_1_1 in var_1_2(var_1_1) do
		var_1_3:SetRuntimeData(iter_1_0, iter_1_1)
	end

	local var_1_4 = arg_1_0
	local var_1_5 = arg_1_0.sendNotification

	GAME = var_9

	var_1_5(var_1_4, var_9.MODIFY_MINI_GAME_DATA_DONE, {
		id = var_1_0,
		map = var_1_1
	})

	return
end

return var_0_1
