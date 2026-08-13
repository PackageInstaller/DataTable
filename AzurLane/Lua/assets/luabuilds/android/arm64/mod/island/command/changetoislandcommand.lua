class = var_0_10000

local var_0_0 = "ChangeToIslandCommand"

pm = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1
	local var_1_1 = arg_1_1.getBody(var_1_0)
	local var_1_2 = arg_1_1:getType()

	getProxy = var_1_0
	ContextProxy = var_1_10006

	local var_1_3 = var_1_0(var_1_10006)

	var_4.getCurrentContext(var_1_3).skipBack = true
	pg = var_5

	local var_1_4 = var_5.m02
	local var_1_5 = var_5.sendNotification

	GAME = var_1_10008

	var_1_5(var_1_4, var_1_10008.ISLAND_ENTER, var_1_1)

	return
end

return var_0_1
