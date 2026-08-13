class = var_0_10000

local var_0_0 = "IslandFollowNpcUnit"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".IslandDressupNpcUnit"))

function var_0_1.Ctor(arg_1_0, arg_1_1, arg_1_2)
	var_0_1.super.Ctor(arg_1_0, arg_1_1, arg_1_2)

	arg_1_0.randomizer = arg_1_2.randomizer

	return
end

function var_0_1.OnInit(arg_2_0, arg_2_1, arg_2_2)
	var_0_1.super.OnInit(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0:WarpAgent()

	return
end

function var_0_1.ResetPosition(arg_3_0)
	arg_3_0._go.transform.eulerAngles = arg_3_0.rotation

	local var_3_0 = arg_3_0:GetNavPosition()

	arg_3_0._go.transform.position = var_3_0

	return
end

function var_0_1.GetNavPosition(arg_4_0)
	for iter_4_0 = 1, 100 do
		IslandCalcUtil = var_1_10005
		var_1_10005 = var_1_10005.GetRandomPointInSector(arg_4_0.position, -arg_4_0._go.transform.forward, 3, 270)
		IslandHelper = var_6

		if var_6.IsPointInWalkableArea(var_1_10005, 0.2) then
			return var_1_10005
		end

		IslandHelper = var_7

		local var_4_0 = var_7.SampleWalkablPosition(var_1_10005, 2)

		if var_6 and var_4_0 ~= var_1_10005 then
			return var_4_0
		end
	end

	IslandHelper = var_1

	return var_1.SampleWalkablPosition(arg_4_0.position, arg_4_0.position.y * 1.1)
end

function var_0_1.OnAttach(arg_5_0, arg_5_1)
	var_0_1.super.OnAttach(arg_5_0, arg_5_1)
	arg_5_0:UpdateBtRandomizer()

	local var_5_0 = arg_5_0.behaviourTreeOwner.graph.blackboard

	var_2.SetVariableValue(var_5_0, "following", true)

	return
end

function var_0_1.UpdateBtRandomizer(arg_6_0)
	local var_6_0 = arg_6_0.behaviourTreeOwner.graph.blackboard

	var_1.SetVariableValue(var_6_0, "randomizer", arg_6_0.randomizer)

	return
end

function var_0_1.SetBtRandomizer(arg_7_0)
	arg_7_0:StopBt()

	arg_7_0.randomizer = true

	arg_7_0:UpdateBtRandomizer()
	arg_7_0:RestartBt()

	return
end

function var_0_1.DoExitHandle(arg_8_0)
	arg_8_0.isExiting = true

	local var_8_0 = arg_8_0.behaviourTreeOwner.graph.blackboard

	var_1.SetVariableValue(var_8_0, "following", false)

	return
end

function var_0_1.IsExitState(arg_9_0)
	return arg_9_0.isExiting
end

return var_0_1
