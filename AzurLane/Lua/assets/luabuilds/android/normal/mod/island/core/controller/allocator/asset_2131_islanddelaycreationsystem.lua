class = var_0_10000

local var_0_0 = var_0_10000("IslandDelayCreationSystem")

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.controller = arg_1_1
	arg_1_0.timerDic = {}

	return
end

function var_0_0.InitUnit(arg_2_0)
	ipairs = var_1_10001

	for iter_2_0, iter_2_1 in var_1_10001(arg_2_0.controller.sceneData.delayInitUnits) do
		if iter_2_1.delayTime then
			arg_2_0:DelayInitUnit(iter_2_1)
		end
	end

	return
end

function var_0_0.DelayInitUnit(arg_3_0, arg_3_1)
	Timer = var_1_10002

	local var_3_0 = var_1_10002.New(function()
		local var_4_0 = arg_3_0.controller
		local var_4_1 = var_0.NotifiyCore

		ISLAND_EVT = var_2_10002

		var_4_1(var_4_0, var_2_10002.GEN_UNIT, arg_3_1)

		arg_3_0.timerDic[arg_3_1.id] = nil

		return
	end, arg_3_1.delayTime, 1)

	var_2.Start(var_3_0)

	arg_3_0.timerDic[arg_3_1.id] = var_2

	return
end

function var_0_0.Dispose(arg_5_0)
	pairs = var_1_10001

	for iter_5_0, iter_5_1 in var_1_10001(arg_5_0.timerDic) do
		iter_5_1:Stop()
	end

	arg_5_0.controller = nil
	arg_5_0.timerDic = nil

	return
end

return var_0_0
