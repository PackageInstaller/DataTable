ys = ys or {}
ys.Battle.BattleJoyStickBotBaseStrategy = class("BattleJoyStickBotBaseStrategy")
ys.Battle.BattleJoyStickBotBaseStrategy.__name = "BattleJoyStickBotBaseStrategy"

function ys.Battle.BattleJoyStickBotBaseStrategy.Ctor(arg_1_0, arg_1_1)
	arg_1_0._hrz = 0
	arg_1_0._vtc = 0
	arg_1_0._fleetVO = arg_1_1
	arg_1_0._motionVO = arg_1_1:GetMotion()

	return
end

function ys.Battle.BattleJoyStickBotBaseStrategy.GetStrategyType(arg_2_0)
	return nil
end

function ys.Battle.BattleJoyStickBotBaseStrategy.SetBoardBound(arg_3_0, arg_3_1, arg_3_2, arg_3_3, arg_3_4)
	arg_3_0._upperBound = arg_3_1
	arg_3_0._lowerBound = arg_3_2
	arg_3_0._leftBound = arg_3_3
	arg_3_0._rightBound = arg_3_4
	arg_3_0._totalWidth = arg_3_4 - arg_3_3
	arg_3_0._totalHeight = arg_3_1 - arg_3_2

	return
end

function ys.Battle.BattleJoyStickBotBaseStrategy.Input(arg_4_0, arg_4_1, arg_4_2)
	arg_4_0._foeShipList = arg_4_1
	arg_4_0._foeAircraftList = arg_4_2

	return
end

function ys.Battle.BattleJoyStickBotBaseStrategy:Output()
	self:analysis()

	return self._hrz, self._vtc
end

function ys.Battle.BattleJoyStickBotBaseStrategy.Dispose(arg_6_0)
	arg_6_0._foeShipList = nil
	arg_6_0._foeAircraftList = nil
	arg_6_0._motionVO = nil

	return
end

function ys.Battle.BattleJoyStickBotBaseStrategy.analysis(arg_7_0)
	return
end

function ys.Battle.BattleJoyStickBotBaseStrategy.getDirection(arg_8_0, arg_8_1)
	return (arg_8_1 - arg_8_0).normalized.x, (arg_8_1 - arg_8_0).normalized.z
end

return
