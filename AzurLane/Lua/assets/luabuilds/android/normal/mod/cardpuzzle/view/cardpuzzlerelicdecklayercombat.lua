class = var_0_10000

local var_0_0 = "CardPuzzleRelicDeckLayerCombat"

CardPuzzleRelicDeckLayer = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002)

function var_0_1.getUIName(arg_1_0)
	return "CardTowerGiftDeckCombat"
end

function var_0_1.init(arg_2_0)
	var_0_1.super.init(arg_2_0)

	onButton = var_1

	local var_2_0 = arg_2_0
	local var_2_1 = arg_2_0._tf
	local var_2_2 = var_3.Find(var_2_1, "backBtn")

	local function var_2_3()
		local var_3_0 = arg_2_0

		var_0.OnBackward(var_3_0)

		return
	end

	SFX_PANEL = var_5

	var_1(var_2_0, var_2_2, var_2_3, var_5)

	return
end

function var_0_1.OnBackward(arg_4_0)
	local var_4_0 = arg_4_0
	local var_4_1 = arg_4_0.emit

	CardPuzzleCardDeckMediator = var_1_10003

	var_4_1(var_4_0, var_1_10003.CLOSE_LAYER)

	return var_0_1.super.OnBackward(arg_4_0)
end

function var_0_1.willExit(arg_5_0)
	return
end

return var_0_1
