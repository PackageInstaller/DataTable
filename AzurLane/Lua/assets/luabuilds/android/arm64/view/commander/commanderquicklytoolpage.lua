class = var_0_10000

local var_0_0 = "CommanderQuicklyToolPage"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("..base.BaseSubView"))

function var_0_1.getUIName(arg_1_0)
	return "CommanderQuicklyToolPage"
end

function var_0_1.OnLoaded(arg_2_0)
	local var_2_0 = arg_2_0._tf

	arg_2_0.closeBtn = var_1.Find(var_2_0, "frame/close_btn")

	local var_2_1 = arg_2_0._tf

	arg_2_0.cancelBtn = var_1.Find(var_2_1, "frame/cancel_btn")

	local var_2_2 = arg_2_0._tf

	arg_2_0.confirmBtn = var_1.Find(var_2_2, "frame/confirm_btn")

	local var_2_3 = arg_2_0._tf

	arg_2_0.addBtn = var_1.Find(var_2_3, "frame/content/count/add")

	local var_2_4 = arg_2_0._tf

	arg_2_0.reduceBtn = var_1.Find(var_2_4, "frame/content/count/reduce")

	local var_2_5 = arg_2_0._tf
	local var_2_6 = var_1.Find(var_2_5, "frame/content/count/Text")
	local var_2_7 = var_1.GetComponent

	typeof = var_4
	Text = var_1_10006
	arg_2_0.valueTxt = var_2_7(var_2_6, var_4(var_1_10006))

	local var_2_8 = arg_2_0._tf
	local var_2_9 = var_1.Find(var_2_8, "frame/content/time/Text")
	local var_2_10 = var_1.GetComponent

	typeof = var_4
	Text = var_1_10006
	arg_2_0.time1Txt = var_2_10(var_2_9, var_4(var_1_10006))

	local var_2_11 = arg_2_0._tf
	local var_2_12 = var_1.Find(var_2_11, "frame/total/Text")
	local var_2_13 = var_1.GetComponent

	typeof = var_4
	Text = var_1_10006
	arg_2_0.maxTxt = var_2_13(var_2_12, var_4(var_1_10006))
	setText = var_1

	local var_2_14 = arg_2_0._tf
	local var_2_15 = var_3.Find(var_2_14, "frame/content/label1")

	i18n = var_4

	var_1(var_2_15, var_4("commander_box_quickly_tool_tip_1"))

	setText = var_1

	local var_2_16 = arg_2_0._tf
	local var_2_17 = var_3.Find(var_2_16, "frame/content/label2")

	i18n = var_4

	var_1(var_2_17, var_4("commander_box_quickly_tool_tip_2"))

	setText = var_1

	local var_2_18 = arg_2_0._tf
	local var_2_19 = var_3.Find(var_2_18, "frame/content/time/label")

	i18n = var_4

	var_1(var_2_19, var_4("commander_box_quickly_tool_tip_3"))

	return
end

function var_0_1.OnInit(arg_3_0)
	onButton = var_1_10001

	local var_3_0 = arg_3_0
	local var_3_1 = arg_3_0._tf

	local function var_3_2()
		local var_4_0 = arg_3_0

		var_0.Hide(var_4_0)

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_3_0, var_3_1, var_3_2, var_1_10006)

	onButton = var_1_10001

	local var_3_3 = arg_3_0
	local var_3_4 = arg_3_0.closeBtn

	local function var_3_5()
		local var_5_0 = arg_3_0

		var_0.Hide(var_5_0)

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_3_3, var_3_4, var_3_5, var_1_10006)

	onButton = var_1_10001

	local var_3_6 = arg_3_0
	local var_3_7 = arg_3_0.cancelBtn

	local function var_3_8()
		local var_6_0 = arg_3_0

		var_0.Hide(var_6_0)

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_3_6, var_3_7, var_3_8, var_1_10006)

	onButton = var_1_10001

	local var_3_9 = arg_3_0
	local var_3_10 = arg_3_0.addBtn

	local function var_3_11()
		if arg_3_0.maxCnt == 0 then
			return
		end

		local var_7_0 = arg_3_0
		local var_7_1 = var_0.UpdateValue

		math = var_2_10003

		var_7_1(var_7_0, var_2_10003.min(arg_3_0.value + 1, arg_3_0.maxCnt))

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_3_9, var_3_10, var_3_11, var_1_10006)

	onButton = var_1_10001

	local var_3_12 = arg_3_0
	local var_3_13 = arg_3_0.reduceBtn

	local function var_3_14()
		if arg_3_0.value <= 1 then
			return
		end

		local var_8_0 = arg_3_0
		local var_8_1 = var_0.UpdateValue

		math = var_2_10003

		var_8_1(var_8_0, var_2_10003.max(1, arg_3_0.value - 1))

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_3_12, var_3_13, var_3_14, var_1_10006)

	onButton = var_1_10001

	local var_3_15 = arg_3_0
	local var_3_16 = arg_3_0.confirmBtn

	local function var_3_17()
		if arg_3_0.value <= 0 then
			pg = var_0

			local var_9_0 = var_0.TipsMgr.GetInstance()
			local var_9_1 = var_0.ShowTips

			i18n = var_2_10003

			var_9_1(var_9_0, var_2_10003("cat_accelfrate_notenough"))

			return
		end

		if arg_3_0.value > arg_3_0.maxCnt then
			return
		end

		local var_9_2 = arg_3_0

		if var_0.CalcMaxUsageCnt(var_9_2) <= 0 then
			pg = var_1

			local var_9_3 = var_1.TipsMgr.GetInstance()
			local var_9_4 = var_1.ShowTips

			i18n = var_2_10004

			var_9_4(var_9_3, var_2_10004("commander_box_was_finished"))

			return
		end

		if var_0 < arg_3_0.value then
			local var_9_5 = arg_3_0

			var_1.UpdateValue(var_9_5, var_0)

			pg = var_1

			local var_9_6 = var_1.TipsMgr.GetInstance()
			local var_9_7 = var_1.ShowTips

			i18n = var_2_10004

			var_9_7(var_9_6, var_2_10004("comander_tool_cnt_is_reclac"))

			return
		end

		local var_9_8 = arg_3_0
		local var_9_9 = var_1.emit

		CommanderCatMediator = var_2_10004

		var_9_9(var_9_8, var_2_10004.USE_QUICKLY_TOOL, arg_3_0.itemId, arg_3_0.value, arg_3_0.boxId)

		local var_9_10 = arg_3_0

		var_1.Hide(var_9_10)

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_3_15, var_3_16, var_3_17, var_1_10006)

	return
end

function var_0_1.Show(arg_10_0, arg_10_1, arg_10_2)
	setParent = var_1_10003

	local var_10_0 = arg_10_0._tf

	pg = var_1_10006

	var_1_10003(var_10_0, var_1_10006.UIMgr.GetInstance().OverlayMain)
	var_0_1.super.Show(arg_10_0)

	arg_10_0.itemId = arg_10_2
	arg_10_0.boxId = arg_10_1
	Item = var_3
	arg_10_0.cost = var_3.getConfigData(arg_10_0.itemId).usage_arg[1]
	arg_10_0.costM = arg_10_0.cost / 60
	getProxy = var_3
	BagProxy = var_5

	local var_10_1 = var_3(var_5)
	local var_10_2 = var_3.getItemCountById(var_10_1, arg_10_2)
	local var_10_3 = arg_10_0:CalcMaxUsageCnt()

	math = var_10_1
	arg_10_0.maxCnt = var_10_1.min(var_10_3, var_10_2)
	arg_10_0.maxTxt.text = var_10_2

	arg_10_0:UpdateValue(arg_10_0.maxCnt)

	return
end

function var_0_1.Hide(arg_11_0)
	var_0_1.super.Hide(arg_11_0)

	setParent = var_1

	var_1(arg_11_0._tf, arg_11_0._parentTf)

	return
end

function var_0_1.UpdateValue(arg_12_0, arg_12_1)
	arg_12_0.value = arg_12_1
	arg_12_0.valueTxt.text = arg_12_1

	local var_12_0 = arg_12_0.costM * arg_12_1 * 60

	getProxy = var_1_10004
	CommanderProxy = var_1_10006

	local var_12_1 = var_1_10004(var_1_10006)
	local var_12_2 = var_4.getBoxById(var_12_1, arg_12_0.boxId)
	local var_12_3 = var_4.getFinishTime(var_12_2) - var_12_0

	arg_12_0:AddTimer(var_12_3)

	return
end

function var_0_1.CalcMaxUsageCnt(arg_13_0)
	getProxy = var_1_10001
	CommanderProxy = var_1_10003

	local var_13_0 = var_1_10001(var_1_10003)
	local var_13_1 = var_1.getBoxById(var_13_0, arg_13_0.boxId)
	local var_13_2 = var_1.getFinishTime(var_13_1)

	pg = var_13_0

	local var_13_3 = var_13_0.TimeMgr.GetInstance()
	local var_13_4 = var_13_2 - var_3.GetServerTime(var_13_3)

	if 0 < var_13_4 then
		math = var_5

		return (var_5.ceil(var_13_4 / arg_13_0.cost))
	else
		return 0
	end

	return
end

function var_0_1.AddTimer(arg_14_0, arg_14_1)
	arg_14_0:RemoveTimer()

	Timer = var_2
	arg_14_0.timer = var_2.New(function()
		pg = var_2_10000

		local var_15_0 = var_2_10000.TimeMgr.GetInstance()
		local var_15_1 = var_0.GetServerTime(var_15_0)
		local var_15_3

		if arg_14_1 - var_15_1 <= 0 then
			local var_15_2 = arg_14_0

			var_15_3.RemoveTimer(var_15_2)

			var_15_3 = arg_14_0.time1Txt
			var_15_3.text = "00:00:00"
		else
			pg = var_15_3

			local var_15_4 = var_15_3.TimeMgr.GetInstance()
			local var_15_5 = var_2.DescCDTime(var_15_4, var_1)

			arg_14_0.time1Txt.text = var_15_5
		end

		return
	end, 1, -1)

	local var_14_0 = arg_14_0.timer

	var_2.Start(var_14_0)
	arg_14_0.timer.func()

	return
end

function var_0_1.RemoveTimer(arg_16_0)
	if arg_16_0.timer then
		local var_16_0 = arg_16_0.timer

		var_1.Stop(var_16_0)

		arg_16_0.timer = nil
	end

	return
end

function var_0_1.Hide(arg_17_0)
	var_0_1.super.Hide(arg_17_0)
	arg_17_0:RemoveTimer()

	return
end

function var_0_1.OnDestroy(arg_18_0)
	arg_18_0:RemoveTimer()

	return
end

return var_0_1
