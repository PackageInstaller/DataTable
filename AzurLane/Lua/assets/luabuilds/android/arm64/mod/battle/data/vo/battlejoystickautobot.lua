ys = ys or {}

local var_0_0 = ys

ys.Battle.BattleJoyStickAutoBot = class("BattleJoyStickAutoBot")

local var_0_1 = ys.Battle.BattleJoyStickAutoBot

ys.Battle.BattleJoyStickAutoBot.__name = "BattleJoyStickAutoBot"
ys.Battle.BattleJoyStickAutoBot.COUNTER_MAIN = "CounterMainRandomStrategy"
ys.Battle.BattleJoyStickAutoBot.RANDOM = "RandomStrategy"
ys.Battle.BattleJoyStickAutoBot.AUTO_PILOT = "AutoPilotStrategy"
ys.Battle.BattleJoyStickAutoBot.IDLE = "IdleStrategy"

function ys.Battle.BattleJoyStickAutoBot.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0._dataProxy = arg_1_1
	arg_1_0._fleetVO = arg_1_2

	arg_1_0:init()

	return
end

function ys.Battle.BattleJoyStickAutoBot.UpdateFleetArea(arg_2_0)
	if arg_2_0._strategy then
		arg_2_0._strategy:SetBoardBound(arg_2_0._fleetVO:GetFleetBound())
	end

	return
end

function ys.Battle.BattleJoyStickAutoBot.FleetFormationUpdate(arg_3_0)
	if arg_3_0._strategy:GetStrategyType() == var_0_1.AUTO_PILOT then
		arg_3_0:SwitchStrategy(var_0_1.AUTO_PILOT)
	end

	return
end

function ys.Battle.BattleJoyStickAutoBot.SetActive(arg_4_0, arg_4_1)
	arg_4_0._active = arg_4_1

	if arg_4_1 then
		arg_4_0._fleetVO:SetMotionSource(function()
			return arg_4_0._strategy:Output()
		end)
	else
		arg_4_0._fleetVO:SetMotionSource()
	end

	return
end

function ys.Battle.BattleJoyStickAutoBot.SwitchStrategy(arg_6_0, arg_6_1)
	if arg_6_0._strategy then
		arg_6_0._strategy:Dispose()
	end

	arg_6_0._strategy = var_0_0.Battle[arg_6_1].New(arg_6_0._fleetVO)

	arg_6_0:UpdateFleetArea()
	arg_6_0._strategy:Input(arg_6_0._dataProxy:GetFoeShipList(), arg_6_0._dataProxy:GetFoeAircraftList())

	return
end

function ys.Battle.BattleJoyStickAutoBot.init(arg_7_0)
	arg_7_0._active = false
	arg_7_0._uiMgr = pg.UIMgr.GetInstance()

	return
end

function ys.Battle.BattleJoyStickAutoBot.Dispose(arg_8_0)
	if arg_8_0._strategy then
		arg_8_0._strategy:Dispose()
	end

	arg_8_0._dataProxy = nil
	arg_8_0._uiMediator = nil
	arg_8_0._uiMgr = nil

	return
end

return
