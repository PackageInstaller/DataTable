class = var_0_10000

local var_0_0 = "AddItemCommand"

pm = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1
	local var_1_1 = arg_1_1.getBody(var_1_0)

	assert = var_1_0
	isa = var_1_10004

	local var_1_2 = var_1_1

	Drop = var_1_10006

	var_1_0(var_1_10004(var_1_2, var_1_10006), "should be an instance of Drop")
	var_1_1:AddItemOperation()

	PlayerConst = var_3

	var_3.UpdateLinkActivity({
		var_1_1
	})

	return
end

return var_0_1
