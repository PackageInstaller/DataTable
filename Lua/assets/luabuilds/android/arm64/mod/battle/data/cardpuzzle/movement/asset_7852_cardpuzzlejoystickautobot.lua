ys = ys or {}

local var_0_0 = ys

ys.Battle.CardPuzzleJoyStickAutoBot = class("CardPuzzleJoyStickAutoBot")

local var_0_1 = ys.Battle.CardPuzzleJoyStickAutoBot

ys.Battle.CardPuzzleJoyStickAutoBot.__name = "CardPuzzleJoyStickAutoBot"
ys.Battle.CardPuzzleJoyStickAutoBot.RANDOM = "RandomStrategy"
ys.Battle.CardPuzzleJoyStickAutoBot.MOVE_TO = "RandomStrategy"
ys.Battle.CardPuzzleJoyStickAutoBot.CARD_PUZZLE_CONTROL = "CardPuzzleControlStrategy"

function ys.Battle.CardPuzzleJoyStickAutoBot:Ctor(arg_1_1, arg_1_2)
	self._dataProxy = arg_1_1
	self._fleetVO = arg_1_2

	self:init()

	return
end

function ys.Battle.CardPuzzleJoyStickAutoBot:UpdateFleetArea()
	if self._strategy then
		self._strategy:SetBoardBound(self._fleetVO:GetFleetBound())
	end

	return
end

function ys.Battle.CardPuzzleJoyStickAutoBot.FleetFormationUpdate(arg_3_0)
	return
end

function ys.Battle.CardPuzzleJoyStickAutoBot:SetActive(arg_4_1)
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

function ys.Battle.CardPuzzleJoyStickAutoBot:SwitchStrategy(arg_6_1)
	if self._strategy then
		self._strategy:Dispose()
	end

	arg_6_1 = arg_6_1 or var_0_1.CARD_PUZZLE_CONTROL
	self._strategy = var_0_0.Battle[arg_6_1].New(self._fleetVO)

	self:UpdateFleetArea()
	self._strategy:Input(self._dataProxy:GetFoeShipList(), self._dataProxy:GetFoeAircraftList())

	return
end

function ys.Battle.CardPuzzleJoyStickAutoBot:init()
	self:SwitchStrategy()

	return
end

function ys.Battle.CardPuzzleJoyStickAutoBot:Dispose()
	if self._strategy then
		self._strategy:Dispose()
	end

	self._dataProxy = nil

	return
end

return
