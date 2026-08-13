class = var_0_10000

local var_0_0 = "CardPuzzleCombatPauseLayer"

BaseUI = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003)

function var_0_1.getUIName(arg_1_0)
	return "CardTowerCombatPause"
end

function var_0_1.init(arg_2_0)
	var_0_1.super.init(arg_2_0)

	onButton = var_1

	local var_2_0 = arg_2_0
	local var_2_1 = arg_2_0._tf
	local var_2_2 = var_4.Find(var_2_1, "btn_quit")

	local function var_2_3()
		local var_3_0 = arg_2_0
		local var_3_1 = var_0.emit

		CardPuzzleCombatPauseMediator = var_2_10003

		var_3_1(var_3_0, var_2_10003.QUIT_COMBAT, {})

		return
	end

	SFX_PANEL = var_2_1

	var_1(var_2_0, var_2_2, var_2_3, var_2_1)

	onButton = var_1

	local var_2_4 = arg_2_0
	local var_2_5 = arg_2_0._tf
	local var_2_6 = var_4.Find(var_2_5, "btn_resume")

	local function var_2_7()
		local var_4_0 = arg_2_0

		var_0.OnBackward(var_4_0)

		return
	end

	SFX_PANEL = var_2_5

	var_1(var_2_4, var_2_6, var_2_7, var_2_5)

	return
end

function var_0_1.OnBackward(arg_5_0)
	local var_5_0 = arg_5_0
	local var_5_1 = arg_5_0.emit

	CardPuzzleCombatPauseMediator = var_1_10004

	var_5_1(var_5_0, var_1_10004.RESUME_COMBAT)
	arg_5_0:closeView()

	return true
end

function var_0_1.willExit(arg_6_0)
	return
end

return var_0_1
