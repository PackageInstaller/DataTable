ys = ys or {}

local var_0_0 = ys
local var_0_2 = ys.Battle.BattleConfig

ys.Battle.CounterMainRandomStrategy = class("CounterMainRandomStrategy", ys.Battle.RandomStrategy)

local var_0_3 = ys.Battle.CounterMainRandomStrategy

ys.Battle.CounterMainRandomStrategy.__name = "CounterMainRandomStrategy"
ys.Battle.CounterMainRandomStrategy.FIX_FRONT = 0.5

function ys.Battle.CounterMainRandomStrategy.Ctor(arg_1_0, arg_1_1)
	var_0_3.super.Ctor(arg_1_0, arg_1_1)

	return
end

function ys.Battle.CounterMainRandomStrategy.GetStrategyType(arg_2_0)
	return var_0_0.Battle.BattleJoyStickAutoBot.COUNTER_MAIN
end

function ys.Battle.CounterMainRandomStrategy.generateTargetPoint(arg_3_0)
	local var_3_0 = arg_3_0._upperBound
	local var_3_1 = arg_3_0._lowerBound

	for iter_3_0, iter_3_1 in pairs(arg_3_0._foeShipList) do
		local var_3_2 = iter_3_1:GetPosition().z

		var_3_0 = math.min(var_3_2, var_3_0)
		var_3_1 = math.max(var_3_2, var_3_1)
	end

	local var_3_3 = arg_3_0._fleetVO:GetLeaderPersonality()
	local var_3_4 = var_0_3.FIX_FRONT
	local var_3_5 = var_3_3.rear_rate
	local var_3_6

	if arg_3_0._fleetVO:GetIFF() == var_0_2.FRIENDLY_CODE then
		var_3_4 = 1 - var_3_4
		var_3_5 = 1 - var_3_5
		var_3_6 = nil
	end

	return (Vector3(math.random(arg_3_0._totalWidth * var_3_5 + arg_3_0._leftBound, arg_3_0._totalWidth * var_3_4 + arg_3_0._leftBound), 0, (math.random(math.max(var_3_1, arg_3_0._totalHeight * var_3_3.lower_rate + arg_3_0._lowerBound), (math.min(var_3_0, arg_3_0._totalHeight * var_3_3.upper_rate + arg_3_0._lowerBound))))))
end

return
