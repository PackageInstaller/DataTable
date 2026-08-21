local var_0_0 = class("IslandCancelAnimationOpView", import(".IslandBaseHudView"))

function var_0_0.GetUIName(arg_1_0)
	return "IslandTopHeadHudUI"
end

function var_0_0.GetUIParent(arg_2_0, arg_2_1)
	return arg_2_0:GetView().layer2OpContianer
end

function var_0_0.GetHeadOffset(arg_3_0)
	return Vector3(0, 1.8, 0)
end

function var_0_0.OnInit(arg_4_0, arg_4_1)
	arg_4_0.cancelAnimationOpTpl = arg_4_0._tf:Find("tpls/IslandCancelAnimationOpTpl")
	arg_4_0.cancelAnimationOpTpls = {}

	var_0_0.super.OnInit(arg_4_0, arg_4_1)

	return
end

function var_0_0.ShowCancelableAnimationOp(arg_5_0, arg_5_1)
	local var_5_0 = arg_5_0:GenUnitData(arg_5_1.id, arg_5_1.unitType)
	local var_5_1 = arg_5_0:GetUnitHudRoot(var_5_0):Find("aniamtionOpContainer")
	local var_5_2 = arg_5_0.cancelAnimationOpTpls[var_5_0.key] or Object.Instantiate(arg_5_0.cancelAnimationOpTpl, var_5_1)

	setParent(var_5_2, var_5_1)
	setActive(var_5_2, true)

	arg_5_0.cancelAnimationOpTpls[var_5_0.key] = var_5_2

	onButton(arg_5_0, var_5_2, function()
		arg_5_0:NotifiyCore(ISLAND_EVT.CANCEL_COUPLE_ACTION)

		return
	end, SFX_PANEL)

	return
end

function var_0_0.HideCancelableAnimationOp(arg_7_0, arg_7_1)
	local var_7_0 = arg_7_0.cancelAnimationOpTpls[arg_7_0:GenUnitData(arg_7_1.id, arg_7_1.unitType).key]

	if not var_7_0 then
		return
	end

	setActive(var_7_0, false)

	return
end

function var_0_0.OnDispose(arg_8_0)
	var_0_0.super.OnDispose(arg_8_0)

	for iter_8_0, iter_8_1 in pairs(arg_8_0.cancelAnimationOpTpls) do
		Object.Destroy(iter_8_1)
	end

	arg_8_0.cancelAnimationOpTpls = nil

	return
end

return var_0_0
