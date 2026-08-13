ys = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
ys = ys

local var_0_1 = var_0.Battle

class = var_0_10002
var_0_1.BattleJoyStickAutoBot = var_0_10002("BattleJoyStickAutoBot")

local var_0_2 = var_0.Battle.BattleJoyStickAutoBot

var_0_2.__name = "BattleJoyStickAutoBot"
var_0_2.COUNTER_MAIN = "CounterMainRandomStrategy"
var_0_2.RANDOM = "RandomStrategy"
var_0_2.AUTO_PILOT = "AutoPilotStrategy"
var_0_2.IDLE = "IdleStrategy"

function var_0_2.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0._dataProxy = arg_1_1
	arg_1_0._fleetVO = arg_1_2

	arg_1_0:init()

	return
end

function var_0_2.UpdateFleetArea(arg_2_0)
	if arg_2_0._strategy then
		local var_2_0 = arg_2_0._strategy
		local var_2_1 = var_1.SetBoardBound
		local var_2_2 = arg_2_0._fleetVO

		var_2_1(var_2_0, var_3.GetFleetBound(var_2_2))
	end

	return
end

function var_0_2.FleetFormationUpdate(arg_3_0)
	local var_3_0 = arg_3_0._strategy

	if var_1.GetStrategyType(var_3_0) == var_0_2.AUTO_PILOT then
		arg_3_0:SwitchStrategy(var_0_2.AUTO_PILOT)
	end

	return
end

function var_0_2.SetActive(arg_4_0, arg_4_1)
	arg_4_0._active = arg_4_1

	if arg_4_1 then
		local function var_4_0()
			local var_5_0 = arg_4_0._strategy

			return var_0.Output(var_5_0)
		end

		local var_4_1 = arg_4_0._fleetVO

		var_3.SetMotionSource(var_4_1, var_4_0)
	else
		local var_4_2 = arg_4_0._fleetVO

		var_2.SetMotionSource(var_4_2)
	end

	return
end

function var_0_2.SwitchStrategy(arg_6_0, arg_6_1)
	if arg_6_0._strategy then
		local var_6_0 = arg_6_0._strategy

		var_2.Dispose(var_6_0)
	end

	arg_6_0._strategy = var_0.Battle[arg_6_1].New(arg_6_0._fleetVO)

	arg_6_0:UpdateFleetArea()

	local var_6_1 = arg_6_0._strategy
	local var_6_2 = var_2.Input
	local var_6_3 = arg_6_0._dataProxy
	local var_6_4 = var_4.GetFoeShipList(var_6_3)
	local var_6_5 = arg_6_0._dataProxy

	var_6_2(var_6_1, var_6_4, var_5.GetFoeAircraftList(var_6_5))

	return
end

function var_0_2.init(arg_7_0)
	arg_7_0._active = false
	pg = var_1
	arg_7_0._uiMgr = var_1.UIMgr.GetInstance()

	return
end

function var_0_2.Dispose(arg_8_0)
	if arg_8_0._strategy then
		local var_8_0 = arg_8_0._strategy

		var_1.Dispose(var_8_0)
	end

	arg_8_0._dataProxy = nil
	arg_8_0._uiMediator = nil
	arg_8_0._uiMgr = nil

	return
end

return
