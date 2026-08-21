ys = ys or {}

local var_0_0 = ys

ys.Battle.CardPuzzleMoveState = class("CardPuzzleMoveState")
ys.Battle.CardPuzzleMoveState.__name = "CardPuzzleMoveState"
ys.Battle.CardPuzzleMoveState.STATE_MOVE = "STATE_MOVE"
ys.Battle.CardPuzzleMoveState.STATE_STAY = "STATE_STAY"
ys.Battle.CardPuzzleMoveState.STATE_RANDOM = "STATE_RANDOM"

function ys.Battle.CardPuzzleMoveState.Ctor(arg_1_0, arg_1_1)
	arg_1_0._fleet = arg_1_1
	arg_1_0._fleetMotion = arg_1_1:GetMotion()
	arg_1_0._moveToState = var_0_0.Battle.CardPuzzleMoveToState.New()
	arg_1_0._stayState = var_0_0.Battle.CardPuzzleStayState.New()
	arg_1_0._RandomState = var_0_0.Battle.CardPuzzleRandomState.New()

	arg_1_0:OnStayState()

	return
end

function ys.Battle.CardPuzzleMoveState.SetReferencePoint(arg_2_0, arg_2_1)
	arg_2_0._currentReferencePoint = arg_2_1

	return
end

function ys.Battle.CardPuzzleMoveState.ChangeState(arg_3_0, arg_3_1)
	arg_3_0._currentState[var_0_0.Battle.CardPuzzleIMoveState.ADD_STATE_TABLE[arg_3_1]](arg_3_0._currentState, arg_3_0)

	return
end

function ys.Battle.CardPuzzleMoveState.Update(arg_4_0)
	arg_4_0._currentState:Update()

	if arg_4_0._currentState:IsFinish(arg_4_0) then
		if arg_4_0._currentState == arg_4_0._moveToState then
			arg_4_0._callback()

			arg_4_0._callback = nil
		end

		arg_4_0:ChangeState((arg_4_0._currentState:NextState()))
	end

	return
end

function ys.Battle.CardPuzzleMoveState.FinishCallback(arg_5_0, arg_5_1)
	arg_5_0._callback = arg_5_1

	return
end

function ys.Battle.CardPuzzleMoveState.GetFleetPosition(arg_6_0)
	return arg_6_0._fleetMotion:GetPos()
end

function ys.Battle.CardPuzzleMoveState.GetDistance(arg_7_0)
	return arg_7_0._currentReferencePoint - arg_7_0:GetFleetPosition()
end

function ys.Battle.CardPuzzleMoveState.GetDirection(arg_8_0)
	local var_8_0, var_8_1 = arg_8_0._currentState:GetOutput(arg_8_0)

	return var_8_0, var_8_1
end

function ys.Battle.CardPuzzleMoveState.GetStateChangeTimeStamp(arg_9_0)
	return arg_9_0._stateChangeTimeStamp
end

function ys.Battle.CardPuzzleMoveState.OnMoveToState(arg_10_0)
	arg_10_0._currentState = arg_10_0._moveToState

	arg_10_0:HandleStateChange()

	return
end

function ys.Battle.CardPuzzleMoveState.OnRandomState(arg_11_0)
	arg_11_0._currentState = arg_11_0._RandomState

	arg_11_0:HandleStateChange()

	return
end

function ys.Battle.CardPuzzleMoveState.OnStayState(arg_12_0)
	arg_12_0._currentState = arg_12_0._stayState

	arg_12_0:HandleStateChange()

	return
end

function ys.Battle.CardPuzzleMoveState.HandleStateChange(arg_13_0)
	arg_13_0._stateChangeTimeStamp = pg.TimeMgr.GetInstance():GetCombatTime()

	local var_13_0 = arg_13_0._currentReferencePoint or arg_13_0:GetFleetPosition()

	arg_13_0._currentState:IntputReferencePoint(var_13_0)

	return
end

return
