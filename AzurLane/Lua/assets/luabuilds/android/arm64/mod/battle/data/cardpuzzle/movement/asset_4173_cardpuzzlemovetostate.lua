ys = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
ys = ys

local var_0_1 = var_0.Battle

class = var_0_10002
var_0_1.CardPuzzleMoveToState = var_0_10002("CardPuzzleMoveToState", var_0.Battle.CardPuzzleIMoveState)

local var_0_2 = var_0.Battle.CardPuzzleMoveToState

var_0_2.__name = "CardPuzzleMoveToState"
var_0_2.VALVE = 0.5

function var_0_2.Ctor(arg_1_0)
	var_0_2.super.Ctor(arg_1_0)

	return
end

function var_0_2.AddMoveToState(arg_2_0, arg_2_1)
	arg_2_1:OnMoveToState()

	return
end

function var_0_2.AddRandomState(arg_3_0, arg_3_1)
	arg_3_1:OnRandomState()

	return
end

function var_0_2.AddStayState(arg_4_0, arg_4_1)
	arg_4_1:OnStayState()

	return
end

function var_0_2.IsFinish(arg_5_0, arg_5_1)
	return (arg_5_0._referencePoint - arg_5_1:GetFleetPosition()).magnitude < var_0_2.VALVE
end

function var_0_2.GetOutput(arg_6_0, arg_6_1)
	return (arg_6_0._referencePoint - arg_6_1:GetFleetPosition()).normalized.x, var_3.z
end

function var_0_2.NextState(arg_7_0)
	return var_0.Battle.CardPuzzleMoveState.STATE_STAY
end

return
