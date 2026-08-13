ys = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
ys = ys

local var_0_1 = var_0.Battle

class = var_0_10002
var_0_1.BattleJoyStickBotBaseStrategy = var_0_10002("BattleJoyStickBotBaseStrategy")

local var_0_2 = var_0.Battle.BattleJoyStickBotBaseStrategy

var_0_2.__name = "BattleJoyStickBotBaseStrategy"

function var_0_2.Ctor(arg_1_0, arg_1_1)
	arg_1_0._hrz = 0
	arg_1_0._vtc = 0
	arg_1_0._fleetVO = arg_1_1
	arg_1_0._motionVO = arg_1_1:GetMotion()

	return
end

function var_0_2.GetStrategyType(arg_2_0)
	return nil
end

function var_0_2.SetBoardBound(arg_3_0, arg_3_1, arg_3_2, arg_3_3, arg_3_4)
	arg_3_0._upperBound = arg_3_1
	arg_3_0._lowerBound = arg_3_2
	arg_3_0._leftBound = arg_3_3
	arg_3_0._rightBound = arg_3_4
	arg_3_0._totalWidth = arg_3_4 - arg_3_3
	arg_3_0._totalHeight = arg_3_1 - arg_3_2

	return
end

function var_0_2.Input(arg_4_0, arg_4_1, arg_4_2)
	arg_4_0._foeShipList = arg_4_1
	arg_4_0._foeAircraftList = arg_4_2

	return
end

function var_0_2.Output(arg_5_0)
	arg_5_0:analysis()

	return arg_5_0._hrz, arg_5_0._vtc
end

function var_0_2.Dispose(arg_6_0)
	arg_6_0._foeShipList = nil
	arg_6_0._foeAircraftList = nil
	arg_6_0._motionVO = nil

	return
end

function var_0_2.analysis(arg_7_0)
	return
end

function var_0_2.getDirection(arg_8_0, arg_8_1)
	return (arg_8_1 - arg_8_0).normalized.x, var_2.z
end

return
