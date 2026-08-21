local var_0_0 = class("IslandShipStatusBox", import(".IslandShipStatusPage"))

function var_0_0.getUIName(arg_1_0)
	return "IslandShipStatusBox"
end

function var_0_0.OnLoaded(arg_2_0)
	var_0_0.super.OnLoaded(arg_2_0)

	arg_2_0.hideBtn = arg_2_0._tf:Find("close")

	return
end

function var_0_0.OnInit(arg_3_0)
	var_0_0.super.OnInit(arg_3_0)
	onButton(arg_3_0, arg_3_0.hideBtn, function()
		arg_3_0:Hide()

		return
	end, SFX_PANEL)

	return
end

function var_0_0.OnShow(arg_5_0, ...)
	var_0_0.super.OnShow(arg_5_0, ...)
	arg_5_0:OverlayPanel(arg_5_0._tf, {
		groupDelta = 1
	})

	return
end

function var_0_0.OnHide(arg_6_0)
	var_0_0.super.OnHide(arg_6_0)
	arg_6_0:UnOverlayPanel(arg_6_0._tf, arg_6_0._parentTf)

	return
end

function var_0_0.OnDisable(arg_7_0)
	arg_7_0:OnHide()

	return
end

return var_0_0
