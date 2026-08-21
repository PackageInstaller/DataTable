local var_0_0 = class("IslandPathFinder", import("..IslandBaseUnit"))

function var_0_0.Ctor(arg_1_0, arg_1_1)
	var_0_0.super.Ctor(arg_1_0, arg_1_1)

	arg_1_0.unitList = arg_1_0:GetView():GetAllUnits()
	arg_1_0.starting = false

	arg_1_0:Init()

	return
end

function var_0_0.Start(arg_2_0, arg_2_1, arg_2_2)
	local var_2_0 = arg_2_1.unitId or 0
	local var_2_1 = arg_2_1.speed or 1.5
	local var_2_2 = arg_2_1.unitType or IslandConst.UNIT_LIST_OBJ

	arg_2_0.hideFlag = defaultValue(arg_2_1.hide, false)

	local var_2_3 = arg_2_0:FindUnit(var_2_0, var_2_2)

	if not var_2_3 then
		onNextTick(arg_2_2)

		return
	end

	var_2_3:Enable()
	var_2_3:WarpAgent()
	assert(var_2_3, "unit is nil" .. var_2_0)

	arg_2_0.unit = var_2_3
	arg_2_0.callback = arg_2_2

	var_2_3:SetNavAgentStopDistance(0.26)
	var_2_3:SetDestination(BuildVector3(arg_2_1.position), var_2_1, arg_2_1.radius, arg_2_1.charaRadius)
	var_2_3:CheckMovement()

	arg_2_0.starting = true

	return
end

function var_0_0.IsSameUnit(arg_3_0, arg_3_1)
	if not arg_3_0.unit then
		return false
	end

	return arg_3_1.id == arg_3_0.unit.id and arg_3_1.unitType == arg_3_0.unit.unitType
end

function var_0_0.FindUnit(arg_4_0, arg_4_1, arg_4_2)
	if arg_4_1 == 0 then
		return arg_4_0:GetView().player
	end

	for iter_4_0, iter_4_1 in ipairs(arg_4_0.unitList) do
		if iter_4_1:GetUnitType() == arg_4_2 and iter_4_1.id == arg_4_1 then
			return iter_4_1
		end
	end

	return nil
end

function var_0_0.OnUpdate(arg_5_0)
	if not arg_5_0.starting then
		return
	end

	local var_5_0 = arg_5_0.unit.agent

	if not arg_5_0.unit.agent.pathPending and var_5_0.remainingDistance <= var_5_0.stoppingDistance then
		arg_5_0:EndAction()
	end

	return
end

function var_0_0.EndAction(arg_6_0)
	arg_6_0.unit:SetNavAgentStopDistance(2)
	arg_6_0.unit:StopMove()

	if arg_6_0.hideFlag then
		arg_6_0.unit:Disable()
	end

	arg_6_0.callback()

	arg_6_0.starting = false

	return
end

function var_0_0.Stop(arg_7_0)
	arg_7_0:EndAction()

	return
end

function var_0_0.OnDispose(arg_8_0)
	arg_8_0.starting = nil
	arg_8_0.callback = nil
	arg_8_0.unitList = nil

	return
end

return var_0_0
