class = var_0_10000

local var_0_0 = "PlayerVitaeAddCard"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".PlayerVitaeBaseCard"))

function var_0_1.OnInit(arg_1_0)
	local var_1_0 = arg_1_0._tf

	arg_1_0.line1 = var_1.Find(var_1_0, "line1")

	local var_1_1 = arg_1_0._tf

	arg_1_0.line2 = var_1.Find(var_1_1, "line2")

	local var_1_2 = arg_1_0._tf

	arg_1_0.txt = var_1.Find(var_1_2, "Text")
	onButton = var_1

	local var_1_3 = arg_1_0
	local var_1_4 = arg_1_0._tf

	local function var_1_5()
		if arg_1_0.inEdit then
			return
		end

		if not arg_1_0.canCilick then
			return
		end

		local var_2_0 = arg_1_0
		local var_2_1 = var_0.emit

		PlayerVitaeMediator = var_2_10003

		var_2_1(var_2_0, var_2_10003.CHANGE_PAINT, nil)

		return
	end

	SFX_PANEL = var_1_10006

	var_1(var_1_3, var_1_4, var_1_5, var_1_10006)

	return
end

function var_0_1.OnUpdate(arg_3_0, arg_3_1, arg_3_2, arg_3_3, arg_3_4)
	PlayerVitaeShipsPage = var_1_10005
	arg_3_0.canCilick = not (arg_3_4 == var_1_10005.RANDOM_FLAG_SHIP_PAGE)
	setActive = var_6

	var_6(arg_3_0.line1, not var_5)

	setActive = var_6

	var_6(arg_3_0.line2, not var_5)

	setActive = var_6

	var_6(arg_3_0.txt, not var_5)

	return
end

function var_0_1.EditCard(arg_4_0, arg_4_1)
	arg_4_0.inEdit = arg_4_1
	setActive = var_1_10002

	var_1_10002(arg_4_0.mask, arg_4_1)

	return
end

function var_0_1.Disable(arg_5_0)
	var_0_1.super.Disable(arg_5_0)
	arg_5_0:EditCard(false)

	return
end

function var_0_1.OnDispose(arg_6_0)
	arg_6_0:Disable()

	return
end

return var_0_1
