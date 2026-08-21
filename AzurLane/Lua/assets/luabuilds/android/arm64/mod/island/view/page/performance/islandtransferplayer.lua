local var_0_0 = class("IslandTransferPlayer", import(".IslandBasePerformancePlayer"))

function var_0_0.Play(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0:emit(ISLAND_EX_EVT.SWITCH_MAP, arg_1_1.objId)

	arg_1_0.callback = arg_1_2

	return
end

function var_0_0.EndAction(arg_2_0)
	if arg_2_0.callback then
		arg_2_0.callback()
	end

	arg_2_0.callback = nil

	return
end

return var_0_0
