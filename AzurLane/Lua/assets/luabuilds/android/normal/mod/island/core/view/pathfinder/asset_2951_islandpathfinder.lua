class = var_0_10000

local var_0_0 = "IslandPathFinder"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("..IslandBaseUnit"))

function var_0_1.Ctor(arg_1_0, arg_1_1)
	var_0_1.super.Ctor(arg_1_0, arg_1_1)

	local var_1_0 = arg_1_0:GetView()

	arg_1_0.unitList = var_2.GetAllUnits(var_1_0)
	arg_1_0.starting = false

	arg_1_0:Init()

	return
end

function var_0_1.Start(arg_2_0, arg_2_1, arg_2_2)
	BuildVector3 = var_1_10003

	local var_2_0 = var_1_10003(arg_2_1.position)
	local var_2_1

	if not arg_2_1.unitId then
		var_2_1 = 0
	end

	local var_2_2

	if not arg_2_1.speed then
		var_2_2 = 1.5
	end

	local var_2_3

	if not arg_2_1.unitType then
		IslandConst = var_2_3
		var_2_3 = var_2_3.UNIT_LIST_OBJ
	end

	defaultValue = var_1_10007
	arg_2_0.hideFlag = var_1_10007(arg_2_1.hide, false)

	local var_2_4 = arg_2_0

	if not arg_2_0.FindUnit(var_2_4, var_2_1, var_2_3) then
		onNextTick = var_2_4

		var_2_4(arg_2_2)

		return
	end

	var_7:Enable()
	var_7:WarpAgent()

	assert = var_8

	var_8(var_7, "unit is nil" .. var_2_1)

	arg_2_0.unit = var_7
	arg_2_0.callback = arg_2_2

	var_7:SetNavAgentStopDistance(0.26)
	var_7:SetDestination(var_2_0, var_2_2, arg_2_1.radius, arg_2_1.charaRadius)
	var_7:CheckMovement()

	arg_2_0.starting = true

	return
end

function var_0_1.IsSameUnit(arg_3_0, arg_3_1)
	if not arg_3_0.unit then
		return false
	end

	return arg_3_1.id == arg_3_0.unit.id and arg_3_1.unitType == arg_3_0.unit.unitType
end

function var_0_1.FindUnit(arg_4_0, arg_4_1, arg_4_2)
	if arg_4_1 == 0 then
		return arg_4_0:GetView().player
	end

	ipairs = var_1_10003

	for iter_4_0, iter_4_1 in var_1_10003(arg_4_0.unitList) do
		if iter_4_1:GetUnitType() == arg_4_2 and iter_4_1.id == arg_4_1 then
			return iter_4_1
		end
	end

	return nil
end

function var_0_1.OnUpdate(arg_5_0)
	if not arg_5_0.starting then
		return
	end

	if not arg_5_0.unit.agent.pathPending and var_2.remainingDistance <= var_2.stoppingDistance then
		arg_5_0:EndAction()
	end

	return
end

function var_0_1.EndAction(arg_6_0)
	local var_6_0 = arg_6_0.unit

	var_1.SetNavAgentStopDistance(var_6_0, 2)

	local var_6_1 = arg_6_0.unit

	var_1.StopMove(var_6_1)

	if arg_6_0.hideFlag then
		local var_6_2 = arg_6_0.unit

		var_1.Disable(var_6_2)
	end

	arg_6_0.callback()

	arg_6_0.starting = false

	return
end

function var_0_1.Stop(arg_7_0)
	arg_7_0:EndAction()

	return
end

function var_0_1.OnDispose(arg_8_0)
	arg_8_0.starting = nil
	arg_8_0.callback = nil
	arg_8_0.unitList = nil

	return
end

return var_0_1
