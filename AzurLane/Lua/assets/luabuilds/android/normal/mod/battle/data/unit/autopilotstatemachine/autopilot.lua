ys = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
ys = ys

local var_0_1 = var_0.Battle.BattleConst.AIStepType

class = var_0_10002

local var_0_2 = var_0_10002("AutoPilot")

var_0.Battle.AutoPilot = var_0_2
var_0_2.__name = "AutoPilot"
var_0_2.PILOT_VALVE = 0.5

function var_0_2.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0._aiCfg = arg_1_2
	arg_1_0._target = arg_1_1

	local var_1_0 = arg_1_1._move

	var_3.SetAutoMoveAI(var_1_0, arg_1_0, arg_1_1)
	arg_1_0:generateList()

	arg_1_0._currentStep = arg_1_0._stepList[arg_1_0._aiCfg.default]

	local var_1_1 = arg_1_0._currentStep

	var_3.Active(var_1_1, arg_1_0._target)

	return
end

function var_0_2.GetDirection(arg_2_0)
	local var_2_0 = arg_2_0._target
	local var_2_1 = var_1.GetPosition(var_2_0)
	local var_2_2 = arg_2_0._currentStep

	return (var_2.GetDirection(var_2_2, var_2_1))
end

function var_0_2.GetTarget(arg_3_0)
	return arg_3_0._target
end

function var_0_2.InputWeaponStateChange(arg_4_0)
	return
end

function var_0_2.SetHiveUnit(arg_5_0, arg_5_1)
	arg_5_0._hiveUnit = arg_5_1

	return
end

function var_0_2.GetHiveUnit(arg_6_0)
	return arg_6_0._hiveUnit
end

function var_0_2.OnHiveUnitDead(arg_7_0)
	local var_7_0 = arg_7_0._target

	var_1.OnMotherDead(var_7_0)

	return
end

function var_0_2.NextStep(arg_8_0)
	local var_8_0 = arg_8_0._currentStep
	local var_8_1 = var_1.GetToIndex(var_8_0)

	if arg_8_0._stepList[var_8_1] == nil then
		var_8_1 = arg_8_0._aiCfg.default
	end

	arg_8_0._currentStep = arg_8_0._stepList[var_8_1]

	local var_8_2 = arg_8_0._currentStep

	var_2.Active(var_8_2, arg_8_0._target)

	return
end

function var_0_2.generateList(arg_9_0)
	arg_9_0._stepList = {}
	ipairs = var_1

	for iter_9_0, iter_9_1 in var_1(arg_9_0._aiCfg.list) do
		local var_9_0
		local var_9_1 = iter_9_1.index
		local var_9_2 = iter_9_1.to
		local var_9_3 = iter_9_1.type
		local var_9_4 = iter_9_1.param

		if var_9_3 == var_0_1.STAY then
			var_9_0 = var_0.Battle.AutoPilotStay.New(var_9_1, arg_9_0)
		elseif var_9_3 == var_0_1.MOVE_TO then
			var_9_0 = var_0.Battle.AutoPilotMoveTo.New(var_9_1, arg_9_0)
		elseif var_9_3 == var_0_1.MOVE then
			var_9_0 = var_0.Battle.AutoPilotMove.New(var_9_1, arg_9_0)
		elseif var_9_3 == var_0_1.MOVE_RELATIVE then
			var_9_0 = var_0.Battle.AutoPilotMoveRelative.New(var_9_1, arg_9_0)
		elseif var_9_3 == var_0_1.BROWNIAN then
			var_9_0 = var_0.Battle.AutoPilotBrownian.New(var_9_1, arg_9_0)
		elseif var_9_3 == var_0_1.CIRCLE then
			var_9_0 = var_0.Battle.AutoPilotCircle.New(var_9_1, arg_9_0)
		elseif var_9_3 == var_0_1.RELATIVE_BROWNIAN then
			var_9_0 = var_0.Battle.AutoPilotRelativeBrownian.New(var_9_1, arg_9_0)
		elseif var_9_3 == var_0_1.RELATIVE_FLEET_MOVE_TO then
			var_9_0 = var_0.Battle.AutoPilotRelativeFleetMoveTo.New(var_9_1, arg_9_0)
		elseif var_9_3 == var_0_1.HIVE_STAY then
			var_9_0 = var_0.Battle.AutoPilotHiveRelativeStay.New(var_9_1, arg_9_0)
		elseif var_9_3 == var_0_1.HIVE_CIRCLE then
			var_9_0 = var_0.Battle.AutoPilotHiveRelativeCircle.New(var_9_1, arg_9_0)
		elseif var_9_3 == var_0_1.MINION_STAY then
			var_9_0 = var_0.Battle.AutoPilotMinionRelativeStay.New(var_9_1, arg_9_0)
		elseif var_9_3 == var_0_1.MINION_CIRCLE then
			var_9_0 = var_0.Battle.AutoPilotMinionRelativeCircle.New(var_9_1, arg_9_0)
		end

		var_9_0:SetParameter(var_9_4, var_9_2)

		arg_9_0._stepList[var_9_0:GetIndex()] = var_9_0
	end

	return
end

return
