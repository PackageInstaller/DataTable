class = var_0_10000

local var_0_0 = var_0_10000("MainPlayerTestSequence")

function var_0_0.Execute(arg_1_0, arg_1_1)
	ISLAND_PLAYER_TESTING = var_1_10002

	if var_1_10002 then
		getProxy = var_1_10002
		PlayerProxy = var_1_10004

		local var_1_0 = var_1_10002(var_1_10004)
		local var_1_1 = var_2.getRawData(var_1_0).id

		pg = var_1_10003

		local var_1_2 = var_1_10003.m02
		local var_1_3 = var_3.sendNotification

		GAME = var_1_10006

		var_1_3(var_1_2, var_1_10006.ISLAND_ENTER, {
			id = var_1_1
		})
	else
		arg_1_1()
	end

	return
end

return var_0_0
