return {
	RequireReceive = function(arg_1_0, arg_1_1)
		manager.net:SendWithLoadingNew(11032, {
			stage_id = arg_1_0
		}, 11033, function(arg_2_0)
			arg_1_1(arg_2_0)
		end)
	end
}
