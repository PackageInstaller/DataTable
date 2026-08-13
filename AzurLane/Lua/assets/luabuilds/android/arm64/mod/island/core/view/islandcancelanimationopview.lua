class = var_0_10000

local var_0_0 = "IslandCancelAnimationOpView"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".IslandBaseHudView"))

function var_0_1.GetUIName(arg_1_0)
	return "IslandTopHeadHudUI"
end

function var_0_1.GetUIParent(arg_2_0, arg_2_1)
	return arg_2_0:GetView().layer2OpContianer
end

function var_0_1.GetHeadOffset(arg_3_0)
	Vector3 = var_1_10001

	return var_1_10001(0, 1.8, 0)
end

function var_0_1.OnInit(arg_4_0, arg_4_1)
	local var_4_0 = arg_4_0._tf

	arg_4_0.cancelAnimationOpTpl = var_2.Find(var_4_0, "tpls/IslandCancelAnimationOpTpl")
	arg_4_0.cancelAnimationOpTpls = {}

	var_0_1.super.OnInit(arg_4_0, arg_4_1)

	return
end

function var_0_1.ShowCancelableAnimationOp(arg_5_0, arg_5_1)
	local var_5_0 = arg_5_0:GenUnitData(arg_5_1.id, arg_5_1.unitType)
	local var_5_1 = arg_5_0:GetUnitHudRoot(var_5_0)
	local var_5_2 = var_3.Find(var_5_1, "aniamtionOpContainer")
	local var_5_3

	if not arg_5_0.cancelAnimationOpTpls[var_5_0.key] then
		Object = var_5_3
		var_5_3 = var_5_3.Instantiate(arg_5_0.cancelAnimationOpTpl, var_5_2)
	end

	setParent = var_5

	var_5(var_5_3, var_5_2)

	setActive = var_5

	var_5(var_5_3, true)

	local var_5_4 = arg_5_0.cancelAnimationOpTpls

	var_5_4[var_5_0.key] = var_5_3
	onButton = var_5_4

	local var_5_5 = arg_5_0
	local var_5_6 = var_5_3

	local function var_5_7()
		local var_6_0 = arg_5_0
		local var_6_1 = var_0.NotifiyCore

		ISLAND_EVT = var_2_10003

		var_6_1(var_6_0, var_2_10003.CANCEL_COUPLE_ACTION)

		return
	end

	SFX_PANEL = var_1_10010

	var_5_4(var_5_5, var_5_6, var_5_7, var_1_10010)

	return
end

function var_0_1.HideCancelableAnimationOp(arg_7_0, arg_7_1)
	local var_7_0 = arg_7_0:GenUnitData(arg_7_1.id, arg_7_1.unitType)

	if not arg_7_0.cancelAnimationOpTpls[var_7_0.key] then
		return
	end

	setActive = var_4

	var_4(var_3, false)

	return
end

function var_0_1.OnDispose(arg_8_0)
	var_0_1.super.OnDispose(arg_8_0)

	pairs = var_1

	for iter_8_0, iter_8_1 in var_1(arg_8_0.cancelAnimationOpTpls) do
		Object = var_1_10006

		var_1_10006.Destroy(iter_8_1)
	end

	arg_8_0.cancelAnimationOpTpls = nil

	return
end

return var_0_1
