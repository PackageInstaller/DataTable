local IslandVirtualInteractBuilder = class("IslandVirtualInteractBuilder", import(".IslandItemInteractBuilder"))

function IslandVirtualInteractBuilder:GetModule(arg_1_1, arg_1_2)
	return IslandVirtualInteractUnit.New(arg_1_1, arg_1_2)
end

function IslandVirtualInteractBuilder:Load(arg_2_1, arg_2_2)
	local var_2_0 = {}
	local var_2_1

	table.insert(var_2_0, function(arg_3_0)
		var_2_1 = GameObject.New("VirtualInteractUnit" .. arg_2_1.id)

		arg_3_0()

		return
	end)
	table.insert(var_2_0, function(arg_4_0)
		self:SetupBT(var_2_1, arg_2_1:GetBehaviourTree(), arg_4_0)

		return
	end)
	seriesAsync(var_2_0, function()
		arg_2_2(var_2_1)

		return
	end)

	return
end

return IslandVirtualInteractBuilder
