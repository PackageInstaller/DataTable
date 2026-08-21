local var_0_0 = class("MainL2dBoundBtn", import(".MainBaseBtn"))

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	var_0_0.super.Ctor(arg_1_0, arg_1_1, arg_1_2)
	setActive(arg_1_0._tf, false)
	arg_1_0:bind(GAME.ROTATE_PAINTING_INDEX, function()
		arg_1_0:FlushL2d()

		return
	end)

	return
end

function var_0_0.OnClick(arg_3_0)
	Live2dConst.l2d_bound_open = not tobool(Live2dConst.l2d_bound_open)

	arg_3_0:FlushL2d()
	pg.TipsMgr.GetInstance():ShowTips(i18n(Live2dConst.l2d_bound_open and "l2d_tip_on" or "l2d_tip_off"))

	return
end

function var_0_0.Flush(arg_4_0, arg_4_1)
	arg_4_0:FlushL2d()

	return
end

function var_0_0.IsFixed(arg_5_0)
	return true
end

function var_0_0.FlushL2d(arg_6_0)
	local var_6_0 = getProxy(PlayerProxy):getRawData():GetFlagShip()
	local var_6_1 = MainPaintingView.GetAssistantStatus(var_6_0) == MainPaintingView.STATE_L2D
	local var_6_2 = var_6_0:GetSkinConfig().ship_l2d_id

	if pg.ship_l2d_tips[var_6_0:GetSkinConfig().id] and var_6_1 and var_6_2 and type(var_6_2) == "table" and #var_6_2 > 0 then
		setActive(arg_6_0._tf, true)
		setActive(findTF(arg_6_0._tf, "on"), not Live2dConst.l2d_bound_open)
		setActive(findTF(arg_6_0._tf, "off"), Live2dConst.l2d_bound_open)
	else
		Live2dConst.l2d_bound_open = false

		setActive(arg_6_0._tf, false)
	end

	arg_6_0:emit(NewMainScene.L2D_BOUND_CHANGE)

	return
end

return var_0_0
