ys = ys or {}
ys.Battle.CardPuzzleIMoveState = class("CardPuzzleIMoveState")
ys.Battle.CardPuzzleIMoveState.__name = "CardPuzzleIMoveState"
ys.Battle.CardPuzzleIMoveState.ADD_STATE_TABLE = {
	[ys.Battle.CardPuzzleMoveState.STATE_STAY] = "AddStayState",
	[ys.Battle.CardPuzzleMoveState.STATE_RANDOM] = "AddRandomState",
	[ys.Battle.CardPuzzleMoveState.STATE_MOVE] = "AddMoveToState"
}

function ys.Battle.CardPuzzleIMoveState.Ctor(arg_1_0)
	arg_1_0._hrz = 0
	arg_1_0._vtc = 0
	arg_1_0._timeStamp = 0

	return
end

function ys.Battle.CardPuzzleIMoveState.AddMoveToState(arg_2_0, arg_2_1)
	return
end

function ys.Battle.CardPuzzleIMoveState.AddRandomState(arg_3_0, arg_3_1)
	return
end

function ys.Battle.CardPuzzleIMoveState.AddStayState(arg_4_0, arg_4_1)
	return
end

function ys.Battle.CardPuzzleIMoveState.IsFinish(arg_5_0, arg_5_1)
	return
end

function ys.Battle.CardPuzzleIMoveState.Update(arg_6_0)
	arg_6_0._currentTime = pg.TimeMgr.GetInstance():GetCombatTime()

	return
end

function ys.Battle.CardPuzzleIMoveState:GetOutput(arg_7_1)
	return self._hrz, self._vtc
end

function ys.Battle.CardPuzzleIMoveState.IntputReferencePoint(arg_8_0, arg_8_1)
	arg_8_0._referencePoint = arg_8_1

	return
end

function ys.Battle.CardPuzzleIMoveState.NextState(arg_9_0)
	return
end

return
