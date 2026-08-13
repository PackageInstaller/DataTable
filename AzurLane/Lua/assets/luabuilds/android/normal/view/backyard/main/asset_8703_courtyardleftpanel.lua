class = var_0_10000

local var_0_0 = "CourtYardLeftPanel"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".CourtYardBasePanel"))

function var_0_1.GetUIName(arg_1_0)
	return "main/leftPanel"
end

function var_0_1.init(arg_2_0)
	local var_2_0 = arg_2_0._tf

	arg_2_0.viewBtn = var_1.Find(var_2_0, "eye_btn")

	return
end

function var_0_1.OnRegister(arg_3_0)
	onToggle = var_1_10001

	local var_3_0 = arg_3_0
	local var_3_1 = arg_3_0.viewBtn

	local function var_3_2(arg_4_0)
		local var_4_0 = arg_3_0
		local var_4_1 = var_1.emit

		CourtYardMediator = var_2_10003

		var_4_1(var_4_0, var_2_10003.FOLD, arg_4_0)

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_3_0, var_3_1, var_3_2, var_1_10005)

	return
end

function var_0_1.OnEnterEditMode(arg_5_0)
	var_0_1.super.OnEnterEditMode(arg_5_0)

	setActive = var_1

	var_1(arg_5_0.viewBtn, false)

	return
end

function var_0_1.OnExitEditMode(arg_6_0)
	var_0_1.super.OnExitEditMode(arg_6_0)

	setActive = var_1

	var_1(arg_6_0.viewBtn, true)

	return
end

function var_0_1.UpdateFloor(arg_7_0)
	return
end

function var_0_1.OnVisitRegister(arg_8_0)
	onToggle = var_1_10001

	local var_8_0 = arg_8_0
	local var_8_1 = arg_8_0.viewBtn

	local function var_8_2(arg_9_0)
		local var_9_0 = arg_8_0
		local var_9_1 = var_1.emit

		CourtYardMediator = var_2_10003

		var_9_1(var_9_0, var_2_10003.FOLD, arg_9_0)

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_8_0, var_8_1, var_8_2, var_1_10005)

	return
end

function var_0_1.GetMoveX(arg_10_0)
	return {}
end

function var_0_1.OnFlush(arg_11_0, arg_11_1)
	return
end

return var_0_1
