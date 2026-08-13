ys = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
ys = ys

local var_0_1 = var_0.Battle

class = var_0_10002
var_0_1.CardPuzzleStayState = var_0_10002("CardPuzzleStayState", var_0.Battle.CardPuzzleIMoveState)

local var_0_2 = var_0.Battle.CardPuzzleStayState

var_0_2.__name = "CardPuzzleStayState"
var_0_2.STAY_DURATION = 5000

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
	local var_5_0 = arg_5_1:GetStateChangeTimeStamp()

	return arg_5_0._currentTime - var_5_0 > var_0_2.STAY_DURATION
end

function var_0_2.NextState(arg_6_0)
	return var_0.Battle.CardPuzzleMoveState.STATE_RANDOM
end

return
