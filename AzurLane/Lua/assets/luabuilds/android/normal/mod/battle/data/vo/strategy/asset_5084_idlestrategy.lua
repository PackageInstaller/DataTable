ys = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
ys = ys

local var_0_1 = var_0.Battle.BattleFormulas
local var_0_2 = var_0.Battle.BattleConfig
local var_0_3 = var_0.Battle

class = var_0_10004
var_0_3.IdleStrategy = var_0_10004("IdleStrategy", var_0.Battle.BattleJoyStickBotBaseStrategy)

local var_0_4 = var_0.Battle.IdleStrategy

var_0_4.__name = "IdleStrategy"

function var_0_4.Ctor(arg_1_0, arg_1_1)
	var_0_4.super.Ctor(arg_1_0, arg_1_1)

	return
end

function var_0_4.GetStrategyType(arg_2_0)
	return var_0.Battle.BattleJoyStickAutoBot.IDLE
end

function var_0_4.analysis(arg_3_0)
	arg_3_0._hrz = 0
	arg_3_0._vtc = 0

	return
end

return
