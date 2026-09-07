ys = ys or {}

local var_0_0 = ys

ys.Battle.CardPuzzleControlStrategy = class("CardPuzzleControlStrategy", ys.Battle.BattleJoyStickBotBaseStrategy)

local var_0_3 = ys.Battle.CardPuzzleControlStrategy

ys.Battle.CardPuzzleControlStrategy.__name = "CardPuzzleControlStrategy"

function ys.Battle.CardPuzzleControlStrategy:Ctor(arg_1_1)
	var_0_3.super.Ctor(self, arg_1_1)
	self._fleetVO:GetCardPuzzleComponent():AttachMoveController(self)

	self._moveState = var_0_0.Battle.CardPuzzleMoveState.New(self._fleetVO)

	return
end

function ys.Battle.CardPuzzleControlStrategy.GetStrategyType(arg_2_0)
	return var_0_0.Battle.BattleJoyStickAutoBot.CARD_PUZZLE_CONTROL
end

function ys.Battle.CardPuzzleControlStrategy:InputTargetPoint(arg_3_1, arg_3_2)
	self._moveState:SetReferencePoint(arg_3_1)
	self._moveState:FinishCallback(arg_3_2)
	self._moveState:ChangeState(self._moveState.STATE_MOVE)

	return
end

function ys.Battle.CardPuzzleControlStrategy:analysis()
	local var_4_0, var_4_1 = self._moveState:GetDirection()

	self._hrz = var_4_0
	self._vtc = var_4_1

	return
end

function ys.Battle.CardPuzzleControlStrategy:Output()
	self._moveState:Update()
	self:analysis()

	return self._hrz, self._vtc
end

return
