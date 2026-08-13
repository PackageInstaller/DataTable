class = var_0_10000

local var_0_0 = "AddItemCommand"

pm = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody()

	assert = var_1_10003
	isa = var_1_10005

	local var_1_1 = var_1_0

	Drop = var_1_10008

	var_1_10003(var_1_10005(var_1_1, var_1_10008), "should be an instance of Drop")
	var_1_0:AddItemOperation()

	PlayerConst = var_3

	var_3.UpdateLinkActivity({
		var_1_0
	})

	return
end

return var_0_1
