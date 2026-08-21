ys = ys or {}

local var_0_0 = ys

ys.Battle.CardPuzzleControlStrategy = class("CardPuzzleControlStrategy", ys.Battle.BattleJoyStickBotBaseStrategy)

local var_0_3 = ys.Battle.CardPuzzleControlStrategy

ys.Battle.CardPuzzleControlStrategy.__name = "CardPuzzleControlStrategy"

function ys.Battle.CardPuzzleControlStrategy.Ctor(arg_1_0, arg_1_1)
	var_0_3.super.Ctor(arg_1_0, arg_1_1)
	arg_1_0._fleetVO:GetCardPuzzleComponent():AttachMoveController(arg_1_0)

	arg_1_0._moveState = var_0_0.Battle.CardPuzzleMoveState.New(arg_1_0._fleetVO)

	return
end

function ys.Battle.CardPuzzleControlStrategy.GetStrategyType(arg_2_0)
	return var_0_0.Battle.BattleJoyStickAutoBot.CARD_PUZZLE_CONTROL
end

function ys.Battle.CardPuzzleControlStrategy.InputTargetPoint(arg_3_0, arg_3_1, arg_3_2)
	arg_3_0._moveState:SetReferencePoint(arg_3_1)
	arg_3_0._moveState:FinishCallback(arg_3_2)
	arg_3_0._moveState:ChangeState(arg_3_0._moveState.STATE_MOVE)

	return
end

function ys.Battle.CardPuzzleControlStrategy.analysis(arg_4_0)
	local var_4_0, var_4_1 = arg_4_0._moveState:GetDirection()

	arg_4_0._hrz = var_4_0
	arg_4_0._vtc = var_4_1

	return
end

function ys.Battle.CardPuzzleControlStrategy.Output(arg_5_0)
	arg_5_0._moveState:Update()
	arg_5_0:analysis()

	return arg_5_0._hrz, arg_5_0._vtc
end

return
