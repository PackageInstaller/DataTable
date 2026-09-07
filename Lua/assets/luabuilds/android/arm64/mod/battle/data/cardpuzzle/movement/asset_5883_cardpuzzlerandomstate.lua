ys = ys or {}

local var_0_0 = ys

ys.Battle.CardPuzzleRandomState = class("CardPuzzleRandomState", ys.Battle.CardPuzzleIMoveState)

local var_0_1 = ys.Battle.CardPuzzleRandomState

ys.Battle.CardPuzzleRandomState.__name = "CardPuzzleRandomState"
ys.Battle.CardPuzzleRandomState.VALVE = 0.5
ys.Battle.CardPuzzleRandomState.RANDOM_RANGE = 10

function ys.Battle.CardPuzzleRandomState.Ctor(arg_1_0)
	var_0_1.super.Ctor(arg_1_0)

	return
end

function ys.Battle.CardPuzzleRandomState.AddMoveToState(arg_2_0, arg_2_1)
	arg_2_1:OnMoveToState()

	return
end

function ys.Battle.CardPuzzleRandomState.AddRandomState(arg_3_0, arg_3_1)
	return
end

function ys.Battle.CardPuzzleRandomState.AddStayState(arg_4_0, arg_4_1)
	arg_4_1:OnStayState()

	return
end

function ys.Battle.CardPuzzleRandomState.IntputReferencePoint(arg_5_0, arg_5_1)
	arg_5_0._referencePoint = var_0_0.Battle.BattleFormulas.RandomPos({
		X1 = arg_5_1.x - var_0_1.RANDOM_RANGE,
		X2 = arg_5_1.x + var_0_1.RANDOM_RANGE,
		Z1 = arg_5_1.z - var_0_1.RANDOM_RANGE,
		Z2 = arg_5_1.z + var_0_1.RANDOM_RANGE
	})

	return
end

function ys.Battle.CardPuzzleRandomState:IsFinish(arg_6_1)
	return (self._referencePoint - arg_6_1:GetFleetPosition()).magnitude < var_0_1.VALVE
end

function ys.Battle.CardPuzzleRandomState:GetOutput(arg_7_1)
	local var_7_0 = (self._referencePoint - arg_7_1:GetFleetPosition()).normalized

	return var_7_0.x, var_7_0.z
end

function ys.Battle.CardPuzzleRandomState.NextState(arg_8_0)
	return var_0_0.Battle.CardPuzzleMoveState.STATE_STAY
end

return
