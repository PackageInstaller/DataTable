ys = ys or {}

local var_0_0 = ys

ys.Battle.IdleStrategy = class("IdleStrategy", ys.Battle.BattleJoyStickBotBaseStrategy)

local var_0_3 = ys.Battle.IdleStrategy

ys.Battle.IdleStrategy.__name = "IdleStrategy"

function ys.Battle.IdleStrategy.Ctor(arg_1_0, arg_1_1)
	var_0_3.super.Ctor(arg_1_0, arg_1_1)

	return
end

function ys.Battle.IdleStrategy.GetStrategyType(arg_2_0)
	return var_0_0.Battle.BattleJoyStickAutoBot.IDLE
end

function ys.Battle.IdleStrategy.analysis(arg_3_0)
	arg_3_0._hrz = 0
	arg_3_0._vtc = 0

	return
end

return
