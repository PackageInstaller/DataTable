ys = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
ys = ys

local var_0_1 = var_0.Battle.BattleFormulas
local var_0_2 = var_0.Battle.BattleConfig
local var_0_3 = var_0.Battle

class = var_0_10004
var_0_3.CardPuzzleMoveState = var_0_10004("CardPuzzleMoveState")

local var_0_4 = var_0.Battle.CardPuzzleMoveState

var_0_4.__name = "CardPuzzleMoveState"
var_0_4.STATE_MOVE = "STATE_MOVE"
var_0_4.STATE_STAY = "STATE_STAY"
var_0_4.STATE_RANDOM = "STATE_RANDOM"

function var_0_4.Ctor(arg_1_0, arg_1_1)
	arg_1_0._fleet = arg_1_1
	arg_1_0._fleetMotion = arg_1_1:GetMotion()
	arg_1_0._moveToState = var_0.Battle.CardPuzzleMoveToState.New()
	arg_1_0._stayState = var_0.Battle.CardPuzzleStayState.New()
	arg_1_0._RandomState = var_0.Battle.CardPuzzleRandomState.New()

	arg_1_0:OnStayState()

	return
end

function var_0_4.SetReferencePoint(arg_2_0, arg_2_1)
	arg_2_0._currentReferencePoint = arg_2_1

	return
end

function var_0_4.ChangeState(arg_3_0, arg_3_1)
	local var_3_0 = var_0.Battle.CardPuzzleIMoveState.ADD_STATE_TABLE[arg_3_1]

	arg_3_0._currentState[var_3_0](arg_3_0._currentState, arg_3_0)

	return
end

function var_0_4.Update(arg_4_0)
	local var_4_0 = arg_4_0._currentState

	var_1.Update(var_4_0)

	local var_4_1 = arg_4_0._currentState

	if var_1.IsFinish(var_4_1, arg_4_0) then
		if arg_4_0._currentState == arg_4_0._moveToState then
			arg_4_0._callback()

			arg_4_0._callback = nil
		end

		local var_4_2 = arg_4_0._currentState
		local var_4_3 = var_1.NextState(var_4_2)

		arg_4_0:ChangeState(var_4_3)
	end

	return
end

function var_0_4.FinishCallback(arg_5_0, arg_5_1)
	arg_5_0._callback = arg_5_1

	return
end

function var_0_4.GetFleetPosition(arg_6_0)
	local var_6_0 = arg_6_0._fleetMotion

	return var_1.GetPos(var_6_0)
end

function var_0_4.GetDistance(arg_7_0)
	return arg_7_0._currentReferencePoint - arg_7_0:GetFleetPosition()
end

function var_0_4.GetDirection(arg_8_0)
	local var_8_0 = arg_8_0._currentState
	local var_8_1, var_8_2 = var_1.GetOutput(var_8_0, arg_8_0)

	return var_8_1, var_8_2
end

function var_0_4.GetStateChangeTimeStamp(arg_9_0)
	return arg_9_0._stateChangeTimeStamp
end

function var_0_4.OnMoveToState(arg_10_0)
	arg_10_0._currentState = arg_10_0._moveToState

	arg_10_0:HandleStateChange()

	return
end

function var_0_4.OnRandomState(arg_11_0)
	arg_11_0._currentState = arg_11_0._RandomState

	arg_11_0:HandleStateChange()

	return
end

function var_0_4.OnStayState(arg_12_0)
	arg_12_0._currentState = arg_12_0._stayState

	arg_12_0:HandleStateChange()

	return
end

function var_0_4.HandleStateChange(arg_13_0)
	pg = var_1_10001

	local var_13_0 = var_1_10001.TimeMgr.GetInstance()

	arg_13_0._stateChangeTimeStamp = var_1.GetCombatTime(var_13_0)

	local var_13_1 = arg_13_0._currentState
	local var_13_2 = var_1.IntputReferencePoint
	local var_13_3

	if not arg_13_0._currentReferencePoint then
		var_13_3 = arg_13_0:GetFleetPosition()
	end

	var_13_2(var_13_1, var_13_3)

	return
end

return
