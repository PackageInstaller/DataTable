ys = ys or {}

local var_0_0 = ys

ys.Battle.CardPuzzleJoyStickAutoBot = class("CardPuzzleJoyStickAutoBot")

local var_0_1 = ys.Battle.CardPuzzleJoyStickAutoBot

ys.Battle.CardPuzzleJoyStickAutoBot.__name = "CardPuzzleJoyStickAutoBot"
ys.Battle.CardPuzzleJoyStickAutoBot.RANDOM = "RandomStrategy"
ys.Battle.CardPuzzleJoyStickAutoBot.MOVE_TO = "RandomStrategy"
ys.Battle.CardPuzzleJoyStickAutoBot.CARD_PUZZLE_CONTROL = "CardPuzzleControlStrategy"

function ys.Battle.CardPuzzleJoyStickAutoBot.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0._dataProxy = arg_1_1
	arg_1_0._fleetVO = arg_1_2

	arg_1_0:init()

	return
end

function ys.Battle.CardPuzzleJoyStickAutoBot.UpdateFleetArea(arg_2_0)
	if arg_2_0._strategy then
		arg_2_0._strategy:SetBoardBound(arg_2_0._fleetVO:GetFleetBound())
	end

	return
end

function ys.Battle.CardPuzzleJoyStickAutoBot.FleetFormationUpdate(arg_3_0)
	return
end

function ys.Battle.CardPuzzleJoyStickAutoBot.SetActive(arg_4_0, arg_4_1)
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

function ys.Battle.CardPuzzleJoyStickAutoBot.SwitchStrategy(arg_6_0, arg_6_1)
	if arg_6_0._strategy then
		arg_6_0._strategy:Dispose()
	end

	arg_6_1 = arg_6_1 or var_0_1.CARD_PUZZLE_CONTROL
	arg_6_0._strategy = var_0_0.Battle[arg_6_1].New(arg_6_0._fleetVO)

	arg_6_0:UpdateFleetArea()
	arg_6_0._strategy:Input(arg_6_0._dataProxy:GetFoeShipList(), arg_6_0._dataProxy:GetFoeAircraftList())

	return
end

function ys.Battle.CardPuzzleJoyStickAutoBot.init(arg_7_0)
	arg_7_0:SwitchStrategy()

	return
end

function ys.Battle.CardPuzzleJoyStickAutoBot.Dispose(arg_8_0)
	if arg_8_0._strategy then
		arg_8_0._strategy:Dispose()
	end

	arg_8_0._dataProxy = nil

	return
end

return
