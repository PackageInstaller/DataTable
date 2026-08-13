class = var_0_10000

local var_0_0 = "SecondAnniversaryCollectPage"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("...base.BaseActivityPage"))

function var_0_1.OnInit(arg_1_0)
	local var_1_0 = arg_1_0._tf

	arg_1_0.bg = var_1.Find(var_1_0, "AD")

	local var_1_1 = arg_1_0._tf

	arg_1_0.btnContainer = var_1.Find(var_1_1, "BtnList")

	local var_1_2 = arg_1_0.btnContainer

	arg_1_0.btn1 = var_1.Find(var_1_2, "1")

	local var_1_3 = arg_1_0.btnContainer

	arg_1_0.btn2 = var_1.Find(var_1_3, "2")

	local var_1_4 = arg_1_0.btnContainer

	arg_1_0.btn3 = var_1.Find(var_1_4, "3")

	local var_1_5 = arg_1_0.btnContainer

	arg_1_0.btn4 = var_1.Find(var_1_5, "4")

	local var_1_6 = arg_1_0.btnContainer

	arg_1_0.btn5 = var_1.Find(var_1_6, "5")

	local var_1_7 = arg_1_0.btnContainer

	arg_1_0.btn6 = var_1.Find(var_1_7, "6")

	return
end

function var_0_1.OnFirstFlush(arg_2_0)
	onButton = var_1_10001

	local var_2_0 = arg_2_0
	local var_2_1 = arg_2_0.btn1

	local function var_2_2()
		local var_3_0 = arg_2_0
		local var_3_1 = var_0.emit

		ActivityMediator = var_2_10002

		local var_3_2 = var_2_10002.EVENT_GO_SCENE

		SCENE = var_2_10003

		var_3_1(var_3_0, var_3_2, var_2_10003.SKINSHOP)

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_2_0, var_2_1, var_2_2, var_1_10005)

	onButton = var_1_10001

	local var_2_3 = arg_2_0
	local var_2_4 = arg_2_0.btn2

	local function var_2_5()
		local var_4_0 = arg_2_0
		local var_4_1 = var_0.emit

		ActivityMediator = var_2_10002

		local var_4_2 = var_2_10002.SELECT_ACTIVITY

		ActivityConst = var_2_10003

		var_4_1(var_4_0, var_4_2, var_2_10003.ACTIVITY_TYPE_RETURN_AWARD_ID2)

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_2_3, var_2_4, var_2_5, var_1_10005)

	onButton = var_1_10001

	local var_2_6 = arg_2_0
	local var_2_7 = arg_2_0.btn3

	local function var_2_8()
		local var_5_0 = arg_2_0
		local var_5_1 = var_0.emit

		ActivityMediator = var_2_10002

		local var_5_2 = var_2_10002.SELECT_ACTIVITY

		ActivityConst = var_2_10003

		var_5_1(var_5_0, var_5_2, var_2_10003.YIDALI_MAIN_ID)

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_2_6, var_2_7, var_2_8, var_1_10005)

	onButton = var_1_10001

	local var_2_9 = arg_2_0
	local var_2_10 = arg_2_0.btn4

	local function var_2_11()
		local var_6_0 = arg_2_0
		local var_6_1 = var_0.emit

		ActivityMediator = var_2_10002

		local var_6_2 = var_2_10002.SELECT_ACTIVITY

		ActivityConst = var_2_10003

		var_6_1(var_6_0, var_6_2, var_2_10003.ANNIVERSARY_LOGIN_ID)

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_2_9, var_2_10, var_2_11, var_1_10005)

	onButton = var_1_10001

	local var_2_12 = arg_2_0
	local var_2_13 = arg_2_0.btn5

	local function var_2_14()
		local var_7_0 = arg_2_0
		local var_7_1 = var_0.emit

		ActivityMediator = var_2_10002

		local var_7_2 = var_2_10002.SELECT_ACTIVITY

		ActivityConst = var_2_10003

		var_7_1(var_7_0, var_7_2, var_2_10003.CARDPAIR_ZQ)

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_2_12, var_2_13, var_2_14, var_1_10005)

	onButton = var_1_10001

	local var_2_15 = arg_2_0
	local var_2_16 = arg_2_0.btn6

	local function var_2_17()
		local var_8_0 = arg_2_0
		local var_8_1 = var_0.emit

		ActivityMediator = var_2_10002

		local var_8_2 = var_2_10002.SELECT_ACTIVITY

		ActivityConst = var_2_10003

		var_8_1(var_8_0, var_8_2, var_2_10003.DACHAOLIFU_SKIN)

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_2_15, var_2_16, var_2_17, var_1_10005)

	return
end

return var_0_1
