local var_0_0 = class("IslandDelayRecycleUnit", import(".IslandSceneUnit"))

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	var_0_0.super.Ctor(arg_1_0, arg_1_1, arg_1_2)

	return
end

function var_0_0.OnAttach(arg_2_0, arg_2_1)
	var_0_0.super.OnAttach(arg_2_0, arg_2_1)

	arg_2_0.delayRemoveTimer = Timer.New(function()
		arg_2_0:NotifiyCore(ISLAND_EVT.RMOVE_UNIT, IslandConst.UNIT_LIST_DELAY, arg_2_0.data.id)

		return
	end, arg_2_0.data.delayRecycleTime, 1)

	arg_2_0.delayRemoveTimer:Start()

	return
end

function var_0_0.OnDetach(arg_4_0)
	if arg_4_0.delayRemoveTimer then
		arg_4_0.delayRemoveTimer:Stop()

		arg_4_0.delayRemoveTimer = nil
	end

	return
end

return var_0_0
