local var_0_0 = class("AddItemCommand", pm.SimpleCommand)

function var_0_0.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody()

	assert(isa(var_1_0, Drop), "should be an instance of Drop")
	var_1_0:AddItemOperation()
	PlayerConst.UpdateLinkActivity({
		var_1_0
	})

	return
end

return var_0_0
