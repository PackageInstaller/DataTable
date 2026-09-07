ys = ys or {}

local var_0_0 = ys

ys.Battle.CardPuzzleStayState = class("CardPuzzleStayState", ys.Battle.CardPuzzleIMoveState)

local var_0_1 = ys.Battle.CardPuzzleStayState

ys.Battle.CardPuzzleStayState.__name = "CardPuzzleStayState"
ys.Battle.CardPuzzleStayState.STAY_DURATION = 5000

function ys.Battle.CardPuzzleStayState.Ctor(arg_1_0)
	var_0_1.super.Ctor(arg_1_0)

	return
end

function ys.Battle.CardPuzzleStayState.AddMoveToState(arg_2_0, arg_2_1)
	arg_2_1:OnMoveToState()

	return
end

function ys.Battle.CardPuzzleStayState.AddRandomState(arg_3_0, arg_3_1)
	arg_3_1:OnRandomState()

	return
end

function ys.Battle.CardPuzzleStayState.AddStayState(arg_4_0, arg_4_1)
	arg_4_1:OnStayState()

	return
end

function ys.Battle.CardPuzzleStayState:IsFinish(arg_5_1)
	return self._currentTime - arg_5_1:GetStateChangeTimeStamp() > var_0_1.STAY_DURATION
end

function ys.Battle.CardPuzzleStayState.NextState(arg_6_0)
	return var_0_0.Battle.CardPuzzleMoveState.STATE_RANDOM
end

return
