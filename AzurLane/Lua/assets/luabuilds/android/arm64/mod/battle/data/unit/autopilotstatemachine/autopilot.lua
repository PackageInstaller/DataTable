ys = ys or {}

local var_0_0 = ys.Battle.BattleConst.AIStepType
local var_0_1 = class("AutoPilot")

ys.Battle.AutoPilot = var_0_1
var_0_1.__name = "AutoPilot"
var_0_1.PILOT_VALVE = 0.5

function var_0_1.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0._aiCfg = arg_1_2
	arg_1_0._target = arg_1_1

	arg_1_1._move:SetAutoMoveAI(arg_1_0, arg_1_1)
	arg_1_0:generateList()

	arg_1_0._currentStep = arg_1_0._stepList[arg_1_0._aiCfg.default]

	arg_1_0._currentStep:Active(arg_1_0._target)

	return
end

function var_0_1.GetDirection(arg_2_0)
	return (arg_2_0._currentStep:GetDirection((arg_2_0._target:GetPosition())))
end

function var_0_1.GetTarget(arg_3_0)
	return arg_3_0._target
end

function var_0_1.InputWeaponStateChange(arg_4_0)
	return
end

function var_0_1.SetHiveUnit(arg_5_0, arg_5_1)
	arg_5_0._hiveUnit = arg_5_1

	return
end

function var_0_1.GetHiveUnit(arg_6_0)
	return arg_6_0._hiveUnit
end

function var_0_1.OnHiveUnitDead(arg_7_0)
	arg_7_0._target:OnMotherDead()

	return
end

function var_0_1.NextStep(arg_8_0)
	local var_8_0 = arg_8_0._currentStep:GetToIndex()

	if arg_8_0._stepList[var_8_0] == nil then
		var_8_0 = arg_8_0._aiCfg.default
	end

	arg_8_0._currentStep = arg_8_0._stepList[var_8_0]

	arg_8_0._currentStep:Active(arg_8_0._target)

	return
end

function var_0_1.generateList(arg_9_0)
	arg_9_0._stepList = {}

	for iter_9_0, iter_9_1 in ipairs(arg_9_0._aiCfg.list) do
		local var_9_0
		local var_9_1 = iter_9_1.to
		local var_9_2 = iter_9_1.param

		if iter_9_1.type == var_0_0.STAY then
			var_9_0 = var_0.Battle.AutoPilotStay.New(iter_9_1.index, arg_9_0)
		elseif iter_9_1.type == var_0_0.MOVE_TO then
			var_9_0 = var_0.Battle.AutoPilotMoveTo.New(iter_9_1.index, arg_9_0)
		elseif iter_9_1.type == var_0_0.MOVE then
			var_9_0 = var_0.Battle.AutoPilotMove.New(iter_9_1.index, arg_9_0)
		elseif iter_9_1.type == var_0_0.MOVE_RELATIVE then
			var_9_0 = var_0.Battle.AutoPilotMoveRelative.New(iter_9_1.index, arg_9_0)
		elseif iter_9_1.type == var_0_0.BROWNIAN then
			var_9_0 = var_0.Battle.AutoPilotBrownian.New(iter_9_1.index, arg_9_0)
		elseif iter_9_1.type == var_0_0.CIRCLE then
			var_9_0 = var_0.Battle.AutoPilotCircle.New(iter_9_1.index, arg_9_0)
		elseif iter_9_1.type == var_0_0.RELATIVE_BROWNIAN then
			var_9_0 = var_0.Battle.AutoPilotRelativeBrownian.New(iter_9_1.index, arg_9_0)
		elseif iter_9_1.type == var_0_0.RELATIVE_FLEET_MOVE_TO then
			var_9_0 = var_0.Battle.AutoPilotRelativeFleetMoveTo.New(iter_9_1.index, arg_9_0)
		elseif iter_9_1.type == var_0_0.HIVE_STAY then
			var_9_0 = var_0.Battle.AutoPilotHiveRelativeStay.New(iter_9_1.index, arg_9_0)
		elseif iter_9_1.type == var_0_0.HIVE_CIRCLE then
			var_9_0 = var_0.Battle.AutoPilotHiveRelativeCircle.New(iter_9_1.index, arg_9_0)
		elseif iter_9_1.type == var_0_0.MINION_STAY then
			var_9_0 = var_0.Battle.AutoPilotMinionRelativeStay.New(iter_9_1.index, arg_9_0)
		elseif iter_9_1.type == var_0_0.MINION_CIRCLE then
			var_9_0 = var_0.Battle.AutoPilotMinionRelativeCircle.New(iter_9_1.index, arg_9_0)
		end

		var_9_0:SetParameter(var_9_2, var_9_1)

		arg_9_0._stepList[var_9_0:GetIndex()] = var_9_0
	end

	return
end

return
