ys = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
ys = ys

local var_0_1 = var_0.Battle.BattleFormulas
local var_0_2 = var_0.Battle.BattleConfig
local var_0_3 = var_0.Battle

class = var_0_10004
var_0_3.CardPuzzleControlStrategy = var_0_10004("CardPuzzleControlStrategy", var_0.Battle.BattleJoyStickBotBaseStrategy)

local var_0_4 = var_0.Battle.CardPuzzleControlStrategy

var_0_4.__name = "CardPuzzleControlStrategy"

function var_0_4.Ctor(arg_1_0, arg_1_1)
	var_0_4.super.Ctor(arg_1_0, arg_1_1)

	local var_1_0 = arg_1_0._fleetVO
	local var_1_1 = var_2.GetCardPuzzleComponent(var_1_0)

	var_2.AttachMoveController(var_1_1, arg_1_0)

	arg_1_0._moveState = var_0.Battle.CardPuzzleMoveState.New(arg_1_0._fleetVO)

	return
end

function var_0_4.GetStrategyType(arg_2_0)
	return var_0.Battle.BattleJoyStickAutoBot.CARD_PUZZLE_CONTROL
end

function var_0_4.InputTargetPoint(arg_3_0, arg_3_1, arg_3_2)
	local var_3_0 = arg_3_0._moveState

	var_3.SetReferencePoint(var_3_0, arg_3_1)

	local var_3_1 = arg_3_0._moveState

	var_3.FinishCallback(var_3_1, arg_3_2)

	local var_3_2 = arg_3_0._moveState

	var_3.ChangeState(var_3_2, arg_3_0._moveState.STATE_MOVE)

	return
end

function var_0_4.analysis(arg_4_0)
	local var_4_0 = arg_4_0._moveState
	local var_4_1, var_4_2 = var_1.GetDirection(var_4_0)

	arg_4_0._hrz = var_4_1
	arg_4_0._vtc = var_4_2

	return
end

function var_0_4.Output(arg_5_0)
	local var_5_0 = arg_5_0._moveState

	var_1.Update(var_5_0)
	arg_5_0:analysis()

	return arg_5_0._hrz, arg_5_0._vtc
end

return
