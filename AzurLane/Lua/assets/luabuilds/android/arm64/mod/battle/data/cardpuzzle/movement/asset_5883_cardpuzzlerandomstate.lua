ys = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
ys = ys

local var_0_1 = var_0.Battle

class = var_0_10002
var_0_1.CardPuzzleRandomState = var_0_10002("CardPuzzleRandomState", var_0.Battle.CardPuzzleIMoveState)

local var_0_2 = var_0.Battle.CardPuzzleRandomState

var_0_2.__name = "CardPuzzleRandomState"
var_0_2.VALVE = 0.5
var_0_2.RANDOM_RANGE = 10

function var_0_2.Ctor(arg_1_0)
	var_0_2.super.Ctor(arg_1_0)

	return
end

function var_0_2.AddMoveToState(arg_2_0, arg_2_1)
	arg_2_1:OnMoveToState()

	return
end

function var_0_2.AddRandomState(arg_3_0, arg_3_1)
	return
end

function var_0_2.AddStayState(arg_4_0, arg_4_1)
	arg_4_1:OnStayState()

	return
end

function var_0_2.IntputReferencePoint(arg_5_0, arg_5_1)
	local var_5_0 = {
		X1 = arg_5_1.x - var_0_2.RANDOM_RANGE,
		X2 = arg_5_1.x + var_0_2.RANDOM_RANGE,
		Z1 = arg_5_1.z - var_0_2.RANDOM_RANGE,
		Z2 = arg_5_1.z + var_0_2.RANDOM_RANGE
	}

	arg_5_0._referencePoint = var_0.Battle.BattleFormulas.RandomPos(var_5_0)

	return
end

function var_0_2.IsFinish(arg_6_0, arg_6_1)
	return (arg_6_0._referencePoint - arg_6_1:GetFleetPosition()).magnitude < var_0_2.VALVE
end

function var_0_2.GetOutput(arg_7_0, arg_7_1)
	return (arg_7_0._referencePoint - arg_7_1:GetFleetPosition()).normalized.x, var_3.z
end

function var_0_2.NextState(arg_8_0)
	return var_0.Battle.CardPuzzleMoveState.STATE_STAY
end

return
