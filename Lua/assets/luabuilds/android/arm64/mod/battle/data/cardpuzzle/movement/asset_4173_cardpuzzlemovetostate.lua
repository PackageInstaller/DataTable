ys = ys or {}

local var_0_0 = ys

ys.Battle.CardPuzzleMoveToState = class("CardPuzzleMoveToState", ys.Battle.CardPuzzleIMoveState)

local var_0_1 = ys.Battle.CardPuzzleMoveToState

ys.Battle.CardPuzzleMoveToState.__name = "CardPuzzleMoveToState"
ys.Battle.CardPuzzleMoveToState.VALVE = 0.5

function ys.Battle.CardPuzzleMoveToState.Ctor(arg_1_0)
	var_0_1.super.Ctor(arg_1_0)

	return
end

function ys.Battle.CardPuzzleMoveToState.AddMoveToState(arg_2_0, arg_2_1)
	arg_2_1:OnMoveToState()

	return
end

function ys.Battle.CardPuzzleMoveToState.AddRandomState(arg_3_0, arg_3_1)
	arg_3_1:OnRandomState()

	return
end

function ys.Battle.CardPuzzleMoveToState.AddStayState(arg_4_0, arg_4_1)
	arg_4_1:OnStayState()

	return
end

function ys.Battle.CardPuzzleMoveToState:IsFinish(arg_5_1)
	return (self._referencePoint - arg_5_1:GetFleetPosition()).magnitude < var_0_1.VALVE
end

function ys.Battle.CardPuzzleMoveToState:GetOutput(arg_6_1)
	local var_6_0 = (self._referencePoint - arg_6_1:GetFleetPosition()).normalized

	return var_6_0.x, var_6_0.z
end

function ys.Battle.CardPuzzleMoveToState.NextState(arg_7_0)
	return var_0_0.Battle.CardPuzzleMoveState.STATE_STAY
end

return
