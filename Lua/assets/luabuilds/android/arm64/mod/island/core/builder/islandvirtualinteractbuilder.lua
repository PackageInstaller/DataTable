local var_0_0 = class("IslandVirtualInteractBuilder", import(".IslandItemInteractBuilder"))

function var_0_0.GetModule(arg_1_0, arg_1_1, arg_1_2)
	return IslandVirtualInteractUnit.New(arg_1_1, arg_1_2)
end

function var_0_0.Load(arg_2_0, arg_2_1, arg_2_2)
	local var_2_0

	table.insert({}, function(arg_3_0)
		var_2_0 = GameObject.New("VirtualInteractUnit" .. arg_2_1.id)

		arg_3_0()

		return
	end)
	table.insert({}, function(arg_4_0)
		arg_2_0:SetupBT(var_2_0, arg_2_1:GetBehaviourTree(), arg_4_0)

		return
	end)
	seriesAsync({}, function()
		arg_2_2(var_2_0)

		return
	end)

	return
end

return var_0_0
