local AddItemCommand = class("AddItemCommand", pm.SimpleCommand)

function AddItemCommand:execute(arg_1_1)
	local var_1_0 = arg_1_1:getBody()

	assert(isa(var_1_0, Drop), "should be an instance of Drop")
	var_1_0:AddItemOperation()
	PlayerConst.UpdateLinkActivity({
		var_1_0
	})

	return
end

return AddItemCommand
