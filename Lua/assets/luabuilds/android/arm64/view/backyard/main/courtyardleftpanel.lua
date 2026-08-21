local var_0_0 = class("CourtYardLeftPanel", import(".CourtYardBasePanel"))

function var_0_0.GetUIName(arg_1_0)
	return "main/leftPanel"
end

function var_0_0.init(arg_2_0)
	arg_2_0.viewBtn = arg_2_0._tf:Find("eye_btn")

	return
end

function var_0_0.OnRegister(arg_3_0)
	onToggle(arg_3_0, arg_3_0.viewBtn, function(arg_4_0)
		arg_3_0:emit(CourtYardMediator.FOLD, arg_4_0)

		return
	end, SFX_PANEL)

	return
end

function var_0_0.OnEnterEditMode(arg_5_0)
	var_0_0.super.OnEnterEditMode(arg_5_0)
	setActive(arg_5_0.viewBtn, false)

	return
end

function var_0_0.OnExitEditMode(arg_6_0)
	var_0_0.super.OnExitEditMode(arg_6_0)
	setActive(arg_6_0.viewBtn, true)

	return
end

function var_0_0.UpdateFloor(arg_7_0)
	return
end

function var_0_0.OnVisitRegister(arg_8_0)
	onToggle(arg_8_0, arg_8_0.viewBtn, function(arg_9_0)
		arg_8_0:emit(CourtYardMediator.FOLD, arg_9_0)

		return
	end, SFX_PANEL)

	return
end

function var_0_0.GetMoveX(arg_10_0)
	return {}
end

function var_0_0.OnFlush(arg_11_0, arg_11_1)
	return
end

return var_0_0
