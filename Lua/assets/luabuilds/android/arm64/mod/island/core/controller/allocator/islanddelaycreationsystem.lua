local var_0_0 = class("IslandDelayCreationSystem")

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.controller = arg_1_1
	arg_1_0.timerDic = {}

	return
end

function var_0_0.InitUnit(arg_2_0)
	for iter_2_0, iter_2_1 in ipairs(arg_2_0.controller.sceneData.delayInitUnits) do
		if iter_2_1.delayTime then
			arg_2_0:DelayInitUnit(iter_2_1)
		end
	end

	return
end

function var_0_0.DelayInitUnit(arg_3_0, arg_3_1)
	local var_3_0 = Timer.New(function()
		arg_3_0.controller:NotifiyCore(ISLAND_EVT.GEN_UNIT, arg_3_1)

		arg_3_0.timerDic[arg_3_1.id] = nil

		return
	end, arg_3_1.delayTime, 1)

	var_3_0:Start()

	arg_3_0.timerDic[arg_3_1.id] = var_3_0

	return
end

function var_0_0.Dispose(arg_5_0)
	for iter_5_0, iter_5_1 in pairs(arg_5_0.timerDic) do
		iter_5_1:Stop()
	end

	arg_5_0.controller = nil
	arg_5_0.timerDic = nil

	return
end

return var_0_0
