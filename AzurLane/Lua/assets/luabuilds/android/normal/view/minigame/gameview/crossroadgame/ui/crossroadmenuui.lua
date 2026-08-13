class = var_0_10000

local var_0_0 = var_0_10000("CrossRoadMenuUI")

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	arg_1_0._tf = arg_1_1
	arg_1_0._event = arg_1_2
	arg_1_0._gameVo = arg_1_3

	local var_1_0 = arg_1_0._gameVo

	arg_1_0.totalTimes = var_4.GetTotalTimes(var_1_0)

	arg_1_0:initUI()

	return
end

function var_0_0.initUI(arg_2_0)
	findTF = var_1_10001
	arg_2_0.menuUI = var_1_10001(arg_2_0._tf, "ui/menuUI")
	findTF = var_1
	arg_2_0.ui = var_1(arg_2_0.menuUI, "ui")
	onButton = var_1

	local var_2_0 = arg_2_0._event

	findTF = var_3

	local var_2_1 = var_3(arg_2_0.menuUI, "ui/btnBack")

	local function var_2_2()
		local var_3_0 = arg_2_0

		var_0.Show(var_3_0, false)

		local var_3_1 = arg_2_0._event
		local var_3_2 = var_0.emit

		SimpleMGEvent = var_2

		var_3_2(var_3_1, var_2.CLOSE_GAME)

		return
	end

	SFX_CANCEL = var_5

	var_1(var_2_0, var_2_1, var_2_2, var_5)

	findTF = var_1
	arg_2_0.btnRule = var_1(arg_2_0.menuUI, "ui/btnRule")
	onButton = var_1

	local var_2_3 = arg_2_0._event
	local var_2_4 = arg_2_0.btnRule

	local function var_2_5()
		local var_4_0 = arg_2_0._event
		local var_4_1 = var_0.emit

		SimpleMGEvent = var_2_10002

		var_4_1(var_4_0, var_2_10002.SHOW_RULE, true)

		return
	end

	SFX_CANCEL = var_5

	var_1(var_2_3, var_2_4, var_2_5, var_5)

	findTF = var_1
	arg_2_0.btnStart = var_1(arg_2_0.menuUI, "ui/btnStart")
	onButton = var_1

	local var_2_6 = arg_2_0._event
	local var_2_7 = arg_2_0.btnStart

	local function var_2_8()
		local var_5_0 = arg_2_0

		var_0.Show(var_5_0, false)

		local var_5_1 = arg_2_0._event
		local var_5_2 = var_0.emit

		SimpleMGEvent = var_2

		var_5_2(var_5_1, var_2.READY_START)

		return
	end

	SFX_CANCEL = var_5

	var_1(var_2_6, var_2_7, var_2_8, var_5)

	return
end

function var_0_0.Show(arg_6_0, arg_6_1)
	pg = var_1_10002

	local var_6_0 = var_1_10002.UIMgr.GetInstance()

	if arg_6_1 then
		setActive = var_1_10003

		var_1_10003(arg_6_0.menuUI, true)
		var_6_0:BlurPanel(arg_6_0.menuUI)
	else
		var_6_0:UnOverlayPanel(arg_6_0.menuUI, arg_6_0._tf)

		setActive = var_3

		var_3(arg_6_0.menuUI, false)
	end

	return
end

function var_0_0.Update(arg_7_0)
	return
end

return var_0_0
