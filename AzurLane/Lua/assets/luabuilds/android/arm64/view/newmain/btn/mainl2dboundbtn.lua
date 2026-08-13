class = var_0_10000

local var_0_0 = "MainL2dBoundBtn"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".MainBaseBtn"))

function var_0_1.Ctor(arg_1_0, arg_1_1, arg_1_2)
	var_0_1.super.Ctor(arg_1_0, arg_1_1, arg_1_2)

	setActive = var_3

	var_3(arg_1_0._tf, false)

	local var_1_0 = arg_1_0
	local var_1_1 = arg_1_0.bind

	GAME = var_6

	var_1_1(var_1_0, var_6.ROTATE_PAINTING_INDEX, function()
		local var_2_0 = arg_1_0

		var_0.FlushL2d(var_2_0)

		return
	end)

	return
end

function var_0_1.OnClick(arg_3_0)
	Live2dConst = var_1_10001
	tobool = var_1_10002
	Live2dConst = var_1_10004
	var_1_10001.l2d_bound_open = not var_1_10002(var_1_10004.l2d_bound_open)

	arg_3_0:FlushL2d()

	pg = var_1

	local var_3_0 = var_1.TipsMgr.GetInstance()
	local var_3_1 = var_1.ShowTips

	i18n = var_4
	Live2dConst = var_1_10006

	var_3_1(var_3_0, var_4(var_1_10006.l2d_bound_open and "l2d_tip_on" or "l2d_tip_off"))

	return
end

function var_0_1.Flush(arg_4_0, arg_4_1)
	arg_4_0:FlushL2d()

	return
end

function var_0_1.IsFixed(arg_5_0)
	return true
end

function var_0_1.FlushL2d(arg_6_0)
	getProxy = var_1_10001
	PlayerProxy = var_1_10003

	local var_6_0 = var_1_10001(var_1_10003)
	local var_6_1 = var_1.getRawData(var_6_0)
	local var_6_2 = var_1.GetFlagShip(var_6_1)

	MainPaintingView = var_1_10002

	local var_6_3 = var_1_10002.GetAssistantStatus(var_6_2)

	MainPaintingView = var_6_1

	local var_6_4 = var_6_3 == var_6_1.STATE_L2D
	local var_6_5 = var_6_2
	local var_6_6 = var_6_2.GetSkinConfig(var_6_5).id
	local var_6_7 = var_6_2
	local var_6_8 = var_6_2.GetSkinConfig(var_6_7).ship_l2d_id

	pg = var_6_5

	if var_6_5.ship_l2d_tips[var_6_6] and var_6_4 and var_6_8 then
		type = var_6_7

		if var_6_7(var_6_8) == "table" and #var_6_8 > 0 then
			setActive = var_6_7

			var_6_7(arg_6_0._tf, true)

			setActive = var_6_7
			findTF = var_9

			local var_6_9 = var_9(arg_6_0._tf, "on")

			Live2dConst = var_1_10010

			var_6_7(var_6_9, not var_1_10010.l2d_bound_open)

			setActive = var_6_7
			findTF = var_6_9

			local var_6_10 = var_6_9(arg_6_0._tf, "off")

			Live2dConst = var_1_10010

			var_6_7(var_6_10, var_1_10010.l2d_bound_open)

			goto label_6_0
		end
	end

	Live2dConst = var_6_7
	var_6_7.l2d_bound_open = false
	setActive = var_6_7

	var_6_7(arg_6_0._tf, false)

	::label_6_0::

	local var_6_11 = arg_6_0
	local var_6_12 = arg_6_0.emit

	NewMainScene = var_1_10010

	var_6_12(var_6_11, var_1_10010.L2D_BOUND_CHANGE)

	return
end

return var_0_1
