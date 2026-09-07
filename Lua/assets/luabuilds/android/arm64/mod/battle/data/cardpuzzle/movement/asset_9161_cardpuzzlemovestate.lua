ys = ys or {}

local var_0_0 = ys

ys.Battle.CardPuzzleMoveState = class("CardPuzzleMoveState")
ys.Battle.CardPuzzleMoveState.__name = "CardPuzzleMoveState"
ys.Battle.CardPuzzleMoveState.STATE_MOVE = "STATE_MOVE"
ys.Battle.CardPuzzleMoveState.STATE_STAY = "STATE_STAY"
ys.Battle.CardPuzzleMoveState.STATE_RANDOM = "STATE_RANDOM"

function ys.Battle.CardPuzzleMoveState:Ctor(arg_1_1)
	self._fleet = arg_1_1
	self._fleetMotion = arg_1_1:GetMotion()
	self._moveToState = var_0_0.Battle.CardPuzzleMoveToState.New()
	self._stayState = var_0_0.Battle.CardPuzzleStayState.New()
	self._RandomState = var_0_0.Battle.CardPuzzleRandomState.New()

	self:OnStayState()

	return
end

function ys.Battle.CardPuzzleMoveState.SetReferencePoint(arg_2_0, arg_2_1)
	arg_2_0._currentReferencePoint = arg_2_1

	return
end

function ys.Battle.CardPuzzleMoveState:ChangeState(arg_3_1)
	self._currentState[var_0_0.Battle.CardPuzzleIMoveState.ADD_STATE_TABLE[arg_3_1]](self._currentState, self)

	return
end

function ys.Battle.CardPuzzleMoveState:Update()
	self._currentState:Update()

	if self._currentState:IsFinish(self) then
		if self._currentState == self._moveToState then
			self._callback()

			self._callback = nil
		end

		self:ChangeState((self._currentState:NextState()))
	end

	return
end

function ys.Battle.CardPuzzleMoveState.FinishCallback(arg_5_0, arg_5_1)
	arg_5_0._callback = arg_5_1

	return
end

function ys.Battle.CardPuzzleMoveState:GetFleetPosition()
	return self._fleetMotion:GetPos()
end

function ys.Battle.CardPuzzleMoveState:GetDistance()
	return self._currentReferencePoint - self:GetFleetPosition()
end

function ys.Battle.CardPuzzleMoveState:GetDirection()
	local var_8_0, var_8_1 = self._currentState:GetOutput(self)

	return var_8_0, var_8_1
end

function ys.Battle.CardPuzzleMoveState:GetStateChangeTimeStamp()
	return self._stateChangeTimeStamp
end

function ys.Battle.CardPuzzleMoveState:OnMoveToState()
	self._currentState = self._moveToState

	self:HandleStateChange()

	return
end

function ys.Battle.CardPuzzleMoveState:OnRandomState()
	self._currentState = self._RandomState

	self:HandleStateChange()

	return
end

function ys.Battle.CardPuzzleMoveState:OnStayState()
	self._currentState = self._stayState

	self:HandleStateChange()

	return
end

function ys.Battle.CardPuzzleMoveState:HandleStateChange()
	self._stateChangeTimeStamp = pg.TimeMgr.GetInstance():GetCombatTime()

	self._currentState:IntputReferencePoint(self._currentReferencePoint or self:GetFleetPosition())

	return
end

return
