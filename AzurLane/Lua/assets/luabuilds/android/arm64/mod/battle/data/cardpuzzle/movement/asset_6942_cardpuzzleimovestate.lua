ys = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
ys = ys

local var_0_1 = var_0.Battle.CardPuzzleMoveState
local var_0_2 = var_0.Battle

class = var_0_10003
var_0_2.CardPuzzleIMoveState = var_0_10003("CardPuzzleIMoveState")

local var_0_3 = var_0.Battle.CardPuzzleIMoveState

var_0_3.__name = "CardPuzzleIMoveState"
var_0_3.ADD_STATE_TABLE = {
	[var_0_1.STATE_STAY] = "AddStayState",
	[var_0_1.STATE_RANDOM] = "AddRandomState",
	[var_0_1.STATE_MOVE] = "AddMoveToState"
}

function var_0_3.Ctor(arg_1_0)
	arg_1_0._hrz = 0
	arg_1_0._vtc = 0
	arg_1_0._timeStamp = 0

	return
end

function var_0_3.AddMoveToState(arg_2_0, arg_2_1)
	return
end

function var_0_3.AddRandomState(arg_3_0, arg_3_1)
	return
end

function var_0_3.AddStayState(arg_4_0, arg_4_1)
	return
end

function var_0_3.IsFinish(arg_5_0, arg_5_1)
	return
end

function var_0_3.Update(arg_6_0)
	pg = var_1_10001

	local var_6_0 = var_1_10001.TimeMgr.GetInstance()

	arg_6_0._currentTime = var_1.GetCombatTime(var_6_0)

	return
end

function var_0_3.GetOutput(arg_7_0, arg_7_1)
	return arg_7_0._hrz, arg_7_0._vtc
end

function var_0_3.IntputReferencePoint(arg_8_0, arg_8_1)
	arg_8_0._referencePoint = arg_8_1

	return
end

function var_0_3.NextState(arg_9_0)
	return
end

return
