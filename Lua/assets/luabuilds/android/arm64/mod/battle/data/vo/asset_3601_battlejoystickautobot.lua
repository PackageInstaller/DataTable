ys = ys or {}

local var_0_0 = ys

ys.Battle.BattleJoyStickAutoBot = class("BattleJoyStickAutoBot")

local var_0_1 = ys.Battle.BattleJoyStickAutoBot

ys.Battle.BattleJoyStickAutoBot.__name = "BattleJoyStickAutoBot"
ys.Battle.BattleJoyStickAutoBot.COUNTER_MAIN = "CounterMainRandomStrategy"
ys.Battle.BattleJoyStickAutoBot.RANDOM = "RandomStrategy"
ys.Battle.BattleJoyStickAutoBot.AUTO_PILOT = "AutoPilotStrategy"
ys.Battle.BattleJoyStickAutoBot.IDLE = "IdleStrategy"

function ys.Battle.BattleJoyStickAutoBot:Ctor(arg_1_1, arg_1_2)
	self._dataProxy = arg_1_1
	self._fleetVO = arg_1_2

	self:init()

	return
end

function ys.Battle.BattleJoyStickAutoBot:UpdateFleetArea()
	if self._strategy then
		self._strategy:SetBoardBound(self._fleetVO:GetFleetBound())
	end

	return
end

function ys.Battle.BattleJoyStickAutoBot:FleetFormationUpdate()
	if self._strategy:GetStrategyType() == var_0_1.AUTO_PILOT then
		self:SwitchStrategy(var_0_1.AUTO_PILOT)
	end

	return
end

function ys.Battle.BattleJoyStickAutoBot:SetActive(arg_4_1)
	self._active = arg_4_1

	if arg_4_1 then
		self._fleetVO:SetMotionSource(function()
			return self._strategy:Output()
		end)
	else
		self._fleetVO:SetMotionSource()
	end

	return
end

function ys.Battle.BattleJoyStickAutoBot:SwitchStrategy(arg_6_1)
	if self._strategy then
		self._strategy:Dispose()
	end

	self._strategy = var_0_0.Battle[arg_6_1].New(self._fleetVO)

	self:UpdateFleetArea()
	self._strategy:Input(self._dataProxy:GetFoeShipList(), self._dataProxy:GetFoeAircraftList())

	return
end

function ys.Battle.BattleJoyStickAutoBot.init(arg_7_0)
	arg_7_0._active = false
	arg_7_0._uiMgr = pg.UIMgr.GetInstance()

	return
end

function ys.Battle.BattleJoyStickAutoBot:Dispose()
	if self._strategy then
		self._strategy:Dispose()
	end

	self._dataProxy = nil
	self._uiMediator = nil
	self._uiMgr = nil

	return
end

return
