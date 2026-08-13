class = var_0_10000

local var_0_0 = "SecondAnniversaryPage"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("...base.BaseActivityPage"))

function var_0_1.OnInit(arg_1_0)
	local var_1_0 = arg_1_0._tf

	arg_1_0.bg = var_1.Find(var_1_0, "AD")

	local var_1_1 = arg_1_0._tf

	arg_1_0.btnShop = var_1.Find(var_1_1, "BtnShop")

	local var_1_2 = arg_1_0._tf

	arg_1_0.btnContainer = var_1.Find(var_1_2, "BtnList/Viewport/Content")

	local var_1_3 = arg_1_0.btnContainer

	arg_1_0.btn1 = var_1.Find(var_1_3, "1")

	local var_1_4 = arg_1_0.btnContainer

	arg_1_0.btn2 = var_1.Find(var_1_4, "2")

	local var_1_5 = arg_1_0.btnContainer

	arg_1_0.btn3 = var_1.Find(var_1_5, "3")

	local var_1_6 = arg_1_0.btnContainer

	arg_1_0.btn4 = var_1.Find(var_1_6, "4")

	local var_1_7 = arg_1_0.btnContainer

	arg_1_0.btn5 = var_1.Find(var_1_7, "5")

	local var_1_8 = arg_1_0.btnContainer

	arg_1_0.btn6 = var_1.Find(var_1_8, "6")

	local var_1_9 = arg_1_0.btnContainer

	arg_1_0.btn7 = var_1.Find(var_1_9, "7")

	local var_1_10 = arg_1_0.btnContainer

	arg_1_0.btn8 = var_1.Find(var_1_10, "8")

	local var_1_11 = arg_1_0.btnContainer

	arg_1_0.btn9 = var_1.Find(var_1_11, "9")
	arg_1_0.btnList1 = {
		arg_1_0.btn1,
		arg_1_0.btn2,
		arg_1_0.btn3,
		arg_1_0.btn4,
		arg_1_0.btn5,
		arg_1_0.btn6,
		arg_1_0.btn7,
		arg_1_0.btn8,
		arg_1_0.btn9
	}

	local var_1_12 = arg_1_0.btnContainer

	arg_1_0.btn11 = var_1.Find(var_1_12, "11")

	local var_1_13 = arg_1_0.btnContainer

	arg_1_0.btn12 = var_1.Find(var_1_13, "12")

	local var_1_14 = arg_1_0.btnContainer

	arg_1_0.btn13 = var_1.Find(var_1_14, "13")

	local var_1_15 = arg_1_0.btnContainer

	arg_1_0.btn14 = var_1.Find(var_1_15, "14")

	local var_1_16 = arg_1_0.btnContainer

	arg_1_0.btn15 = var_1.Find(var_1_16, "15")

	local var_1_17 = arg_1_0.btnContainer

	arg_1_0.btn16 = var_1.Find(var_1_17, "16")

	local var_1_18 = arg_1_0.btnContainer

	arg_1_0.btn17 = var_1.Find(var_1_18, "17")

	local var_1_19 = arg_1_0.btnContainer

	arg_1_0.btn18 = var_1.Find(var_1_19, "18")

	local var_1_20 = arg_1_0.btnContainer

	arg_1_0.btn19 = var_1.Find(var_1_20, "19")
	arg_1_0.btnList2 = {
		arg_1_0.btn11,
		arg_1_0.btn12,
		arg_1_0.btn13,
		arg_1_0.btn14,
		arg_1_0.btn15,
		arg_1_0.btn16,
		arg_1_0.btn17,
		arg_1_0.btn18,
		arg_1_0.btn19
	}

	return
end

function var_0_1.OnFirstFlush(arg_2_0)
	onButton = var_1_10001

	local var_2_0 = arg_2_0
	local var_2_1 = arg_2_0.btnShop

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
	arg_2_0:initBtn(arg_2_0.btnList1)
	arg_2_0:initBtn(arg_2_0.btnList2)

	return
end

function var_0_1.initBtn(arg_4_0, arg_4_1)
	onButton = var_1_10002

	local var_4_0 = arg_4_0
	local var_4_1 = arg_4_1[1]

	local function var_4_2()
		local var_5_0 = arg_4_0
		local var_5_1 = var_0.emit

		ActivityMediator = var_2_10002

		var_5_1(var_5_0, var_2_10002.GO_PRAY_POOL)

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10002(var_4_0, var_4_1, var_4_2, var_1_10006)

	onButton = var_1_10002

	local var_4_3 = arg_4_0
	local var_4_4 = arg_4_1[2]

	local function var_4_5()
		local var_6_0 = arg_4_0
		local var_6_1 = var_0.emit

		ActivityMediator = var_2_10002

		local var_6_2 = var_2_10002.EVENT_GO_SCENE

		SCENE = var_2_10003

		var_6_1(var_6_0, var_6_2, var_2_10003.SUMMARY)

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10002(var_4_3, var_4_4, var_4_5, var_1_10006)

	onButton = var_1_10002

	local var_4_6 = arg_4_0
	local var_4_7 = arg_4_1[3]

	local function var_4_8()
		local var_7_0 = arg_4_0
		local var_7_1 = var_0.emit

		ActivityMediator = var_2_10002

		local var_7_2 = var_2_10002.SELECT_ACTIVITY

		ActivityConst = var_2_10003

		var_7_1(var_7_0, var_7_2, var_2_10003.ACTIVITY_TYPE_RETURN_AWARD_ID)

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10002(var_4_6, var_4_7, var_4_8, var_1_10006)

	onButton = var_1_10002

	local var_4_9 = arg_4_0
	local var_4_10 = arg_4_1[4]

	local function var_4_11()
		local var_8_0 = arg_4_0
		local var_8_1 = var_0.emit

		ActivityMediator = var_2_10002

		local var_8_2 = var_2_10002.SELECT_ACTIVITY

		ActivityConst = var_2_10003

		var_8_1(var_8_0, var_8_2, var_2_10003.XIMU_LOGIN_ID)

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10002(var_4_9, var_4_10, var_4_11, var_1_10006)

	onButton = var_1_10002

	local var_4_12 = arg_4_0
	local var_4_13 = arg_4_1[5]

	local function var_4_14()
		local var_9_0 = arg_4_0
		local var_9_1 = var_0.emit

		ActivityMediator = var_2_10002

		local var_9_2 = var_2_10002.EVENT_GO_SCENE

		SCENE = var_2_10003

		local var_9_3 = var_2_10003.CHARGE
		local var_9_4 = {}

		ChargeScene = var_2_10005
		var_9_4.wrap = var_2_10005.TYPE_DIAMOND

		var_9_1(var_9_0, var_9_2, var_9_3, var_9_4)

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10002(var_4_12, var_4_13, var_4_14, var_1_10006)

	onButton = var_1_10002

	local var_4_15 = arg_4_0
	local var_4_16 = arg_4_1[6]

	local function var_4_17()
		local var_10_0 = arg_4_0
		local var_10_1 = var_0.emit

		ActivityMediator = var_2_10002

		local var_10_2 = var_2_10002.EVENT_GO_SCENE

		SCENE = var_2_10003

		var_10_1(var_10_0, var_10_2, var_2_10003.GETBOAT, {
			projectName = "light"
		})

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10002(var_4_15, var_4_16, var_4_17, var_1_10006)

	onButton = var_1_10002

	local var_4_18 = arg_4_0
	local var_4_19 = arg_4_1[7]

	local function var_4_20()
		local var_11_0 = arg_4_0
		local var_11_1 = var_0.emit

		ActivityMediator = var_2_10002

		local var_11_2 = var_2_10002.SELECT_ACTIVITY

		ActivityConst = var_2_10003

		var_11_1(var_11_0, var_11_2, var_2_10003.SANDIEGO_PT_ID)

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10002(var_4_18, var_4_19, var_4_20, var_1_10006)

	onButton = var_1_10002

	local var_4_21 = arg_4_0
	local var_4_22 = arg_4_1[8]

	local function var_4_23()
		local var_12_0 = arg_4_0
		local var_12_1 = var_0.emit

		ActivityMediator = var_2_10002

		local var_12_2 = var_2_10002.SELECT_ACTIVITY

		ActivityConst = var_2_10003

		var_12_1(var_12_0, var_12_2, var_2_10003.SKIN_U73)

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10002(var_4_21, var_4_22, var_4_23, var_1_10006)

	onButton = var_1_10002

	local var_4_24 = arg_4_0
	local var_4_25 = arg_4_1[9]

	local function var_4_26()
		pg = var_2_10000

		local var_13_0 = var_2_10000.TipsMgr.GetInstance()

		var_0.ShowTips(var_13_0, "即将开放，敬请期待！")

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10002(var_4_24, var_4_25, var_4_26, var_1_10006)

	return
end

return var_0_1
