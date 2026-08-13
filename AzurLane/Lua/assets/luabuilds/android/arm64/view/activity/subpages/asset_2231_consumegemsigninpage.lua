class = var_0_10000

local var_0_0 = "ConsumeGemSignInPage"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.base.BaseActivityPage"))

function var_0_1.OnInit(arg_1_0)
	local var_1_0 = arg_1_0._tf

	arg_1_0.rtLogin = var_1.Find(var_1_0, "AD/login")

	local var_1_1 = arg_1_0._tf

	arg_1_0.shopBtn = var_1.Find(var_1_1, "shop")

	local var_1_2 = arg_1_0._tf

	arg_1_0.getAllBtn = var_1.Find(var_1_2, "get_all")

	local var_1_3 = arg_1_0._tf

	arg_1_0.getAllBtnEnb = var_1.Find(var_1_3, "get_all/Text")

	local var_1_4 = arg_1_0._tf

	arg_1_0.helpBtn = var_1.Find(var_1_4, "help")
	UIItemList = var_1

	local var_1_5 = var_1.New
	local var_1_6 = arg_1_0._tf
	local var_1_7 = var_3.Find(var_1_6, "AD/targets")
	local var_1_8 = arg_1_0._tf

	arg_1_0.uiTargetList = var_1_5(var_1_7, var_4.Find(var_1_8, "AD/targets/task"))

	local var_1_9 = arg_1_0._tf

	arg_1_0.sliderTr = var_1.Find(var_1_9, "AD/slider/Image")

	local var_1_10 = arg_1_0._tf

	arg_1_0.ptTxt = var_1.Find(var_1_10, "AD/Text")
	onButton = var_1

	local var_1_11 = arg_1_0
	local var_1_12 = arg_1_0.helpBtn

	local function var_1_13()
		pg = var_2_10000

		local var_2_0 = var_2_10000.MsgboxMgr.GetInstance()
		local var_2_1 = var_0.ShowMsgBox
		local var_2_2 = {}

		MSGBOX_TYPE_HELP = var_2_10004
		var_2_2.type = var_2_10004
		pg = var_2_10004
		var_2_2.helps = var_2_10004.gametip.ConsumeGem_tip.tip

		var_2_1(var_2_0, var_2_2)

		return
	end

	SFX_PANEL = var_1_8

	var_1(var_1_11, var_1_12, var_1_13, var_1_8)

	onButton = var_1

	local var_1_14 = arg_1_0
	local var_1_15 = arg_1_0.shopBtn

	local function var_1_16()
		pg = var_2_10000

		local var_3_0 = var_2_10000.m02
		local var_3_1 = var_0.sendNotification

		GAME = var_2_10003

		local var_3_2 = var_2_10003.GO_SCENE

		SCENE = var_2_10004

		var_3_1(var_3_0, var_3_2, var_2_10004.NEW_SHOP)

		return
	end

	SFX_PANEL = var_1_8

	var_1(var_1_14, var_1_15, var_1_16, var_1_8)

	onButton = var_1

	local var_1_17 = arg_1_0
	local var_1_18 = arg_1_0.getAllBtn

	local function var_1_19()
		local var_4_0 = arg_1_0

		if #var_0.CollectCanGetAwards(var_4_0) <= 0 then
			return
		end

		local var_4_1 = {}

		ipairs = var_2

		for iter_4_0, iter_4_1 in var_2(var_0) do
			table = var_2_10007

			var_2_10007.insert(var_4_1, function(arg_5_0)
				local var_5_0 = arg_1_0
				local var_5_1 = var_1.emit

				ActivityMediator = var_3_10004

				var_5_1(var_5_0, var_3_10004.EVENT_PT_OPERATION, {
					cmd = 1,
					activity_id = arg_1_0.consumeGemAct.id,
					arg1 = iter_4_1,
					callback = arg_5_0
				})

				return
			end)
		end

		seriesAsync = var_2

		var_2(var_4_1)

		return
	end

	SFX_PANEL = var_1_8

	var_1(var_1_17, var_1_18, var_1_19, var_1_8)

	arg_1_0.itemWid = 118

	return
end

function var_0_1.CollectCanGetAwards(arg_6_0)
	local var_6_0 = {}
	local var_6_1 = arg_6_0.consumeGemAct.data1
	local var_6_2 = arg_6_0.consumeGemAct.data1_list

	ipairs = var_1_10004

	for iter_6_0, iter_6_1 in var_1_10004(arg_6_0.targets) do
		if iter_6_1 <= var_6_1 then
			table = var_1_10009

			if not var_1_10009.contains(var_6_2, iter_6_1) then
				table = var_1_10009

				var_1_10009.insert(var_6_0, iter_6_1)
			end
		end
	end

	return var_6_0
end

function var_0_1.OnDataSetting(arg_7_0)
	arg_7_0.nday = arg_7_0.activity.data3
	getProxy = var_1
	TaskProxy = var_1_10003
	arg_7_0.taskProxy = var_1(var_1_10003)

	local var_7_0 = arg_7_0.activity

	arg_7_0.taskGroup = var_1.getConfig(var_7_0, "config_data")

	local var_7_1 = arg_7_0.activity
	local var_7_2 = var_1.getConfig(var_7_1, "config_client").link_act

	getProxy = var_1_10002
	ActivityProxy = var_4

	local var_7_3 = var_1_10002(var_4)

	arg_7_0.consumeGemAct = var_2.getActivityById(var_7_3, var_7_2)

	local var_7_4 = arg_7_0.consumeGemAct

	arg_7_0.targets = var_2.getDataConfig(var_7_4, "target")

	local var_7_5 = arg_7_0.consumeGemAct

	arg_7_0.drops = var_2.getDataConfig(var_7_5, "drop_client")
	updateActivityTaskStatus = var_2

	return var_2(arg_7_0.activity)
end

function var_0_1.OnFirstFlush(arg_8_0)
	arg_8_0:FlushSignInAct()
	arg_8_0:FlushTargetPtAct()
	arg_8_0:Hx4Channel()

	return
end

function var_0_1.FlushTargetPtAct(arg_9_0)
	arg_9_0.pt = arg_9_0.consumeGemAct.data1
	arg_9_0.gotList = arg_9_0.consumeGemAct.data1_list
	setText = var_1

	var_1(arg_9_0.ptTxt, arg_9_0.pt)

	local var_9_0 = arg_9_0:CollectCanGetAwards()

	setActive = var_1_10002

	var_1_10002(arg_9_0.getAllBtnEnb, #var_9_0 > 0)

	local var_9_1 = 0
	local var_9_2 = arg_9_0.uiTargetList

	var_3.make(var_9_2, function(arg_10_0, arg_10_1, arg_10_2)
		UIItemList = var_2_10003

		if arg_10_0 == var_2_10003.EventUpdate then
			local var_10_0 = arg_9_0.targets[arg_10_1 + 1]

			Drop = var_4

			local var_10_1 = var_4.Create(arg_9_0.drops[arg_10_1 + 1])

			setText = var_2_10005

			var_2_10005(arg_10_2:Find("day/Text"), var_10_0)

			table = var_2_10005

			local var_10_2 = var_2_10005.contains(arg_9_0.gotList, var_10_0)

			setActive = var_6

			var_6(arg_10_2:Find("task_1/got"), var_10_2)

			local var_10_3 = not var_10_2 and var_10_0 <= arg_9_0.pt

			setActive = var_7

			var_7(arg_10_2:Find("get"), var_10_3)

			setActive = var_7

			var_7(arg_10_2:Find("task_1/lock"), var_10_0 > arg_9_0.pt)

			setActive = var_7

			var_7(arg_10_2:Find("dot1/Image_1"), var_10_3)

			if var_10_2 then
				var_9_1 = arg_10_1 + 1
			end

			onButton = var_7

			local var_10_4 = arg_9_0
			local var_10_5 = arg_10_2
			local var_10_6 = arg_10_2.Find(var_10_5, "get")

			local function var_10_7()
				local var_11_0 = arg_9_0
				local var_11_1 = var_0.emit

				ActivityMediator = var_3_10003

				var_11_1(var_11_0, var_3_10003.EVENT_PT_OPERATION, {
					cmd = 1,
					activity_id = arg_9_0.consumeGemAct.id,
					arg1 = var_10_0
				})

				return
			end

			SFX_CONFIRM = var_10_5

			var_7(var_10_4, var_10_6, var_10_7, var_10_5)

			updateDrop = var_7

			var_7(arg_10_2:Find("task_1/IconTpl"), var_10_1)

			onButton = var_7

			local var_10_8 = arg_9_0
			local var_10_9 = arg_10_2

			local function var_10_10()
				local var_12_0 = arg_9_0
				local var_12_1 = var_0.emit

				BaseUI = var_3_10003

				var_12_1(var_12_0, var_3_10003.ON_DROP, var_10_1)

				return
			end

			SFX_PANEL = var_12

			var_7(var_10_8, var_10_9, var_10_10, var_12)
		end

		return
	end)

	local var_9_3 = arg_9_0.uiTargetList

	var_3.align(var_9_3, #arg_9_0.targets)

	local var_9_4 = arg_9_0.itemWid * 0.5 + (var_9_1 - 1) * arg_9_0.itemWid
	local var_9_5 = arg_9_0.sliderTr

	Vector2 = var_6
	var_9_5.sizeDelta = var_6(var_9_4, arg_9_0.sliderTr.sizeDelta.y)

	return
end

function var_0_1.FlushSignInAct(arg_13_0)
	local var_13_0 = {
		"task",
		"task_1",
		"task_2"
	}

	ipairs = var_1_10002

	for iter_13_0, iter_13_1 in var_1_10002(arg_13_0.taskGroup) do
		local var_13_1 = iter_13_1[1]
		local var_13_2 = arg_13_0.taskProxy
		local var_13_3

		if not var_8.getTaskVO(var_13_2, var_13_1) then
			Task = var_13_3
			var_13_3 = var_13_3.New({
				id = var_13_1
			})
		end

		local var_13_4 = arg_13_0.rtLogin
		local var_13_5 = var_9.Find(var_13_4, var_13_0[iter_13_0])

		setText = var_13_2

		var_13_2(var_13_5:Find("day/Text"), "DAY" .. iter_13_0)

		Drop = var_13_2

		local var_13_6 = var_13_2.Create(var_13_3:getConfig("award_display")[1])

		updateDrop = var_13_4

		var_13_4(var_13_5:Find("IconTpl"), var_13_6)

		onButton = var_13_4

		local var_13_7 = arg_13_0
		local var_13_8 = var_13_5
		local var_13_9 = var_13_5.Find(var_13_8, "get")

		local function var_13_10()
			local var_14_0 = arg_13_0
			local var_14_1 = var_0.emit

			ActivityMediator = var_2_10003

			var_14_1(var_14_0, var_2_10003.ON_TASK_SUBMIT, var_13_3)

			return
		end

		SFX_CONFIRM = var_13_8

		var_13_4(var_13_7, var_13_9, var_13_10, var_13_8)

		onButton = var_13_4

		local var_13_11 = arg_13_0
		local var_13_12 = var_13_5

		local function var_13_13()
			local var_15_0 = arg_13_0
			local var_15_1 = var_0.emit

			BaseUI = var_2_10003

			var_15_1(var_15_0, var_2_10003.ON_DROP, var_13_6)

			return
		end

		SFX_PANEL = var_13_8

		var_13_4(var_13_11, var_13_12, var_13_13, var_13_8)
	end

	return
end

function var_0_1.OnUpdateFlush(arg_16_0)
	arg_16_0:UpdateSignInAct()
	arg_16_0:UpdateTargetPtAct()

	return
end

function var_0_1.UpdateSignInAct(arg_17_0)
	local var_17_0 = false
	local var_17_1 = {
		"task",
		"task_1",
		"task_2"
	}

	ipairs = var_1_10003

	for iter_17_0, iter_17_1 in var_1_10003(arg_17_0.taskGroup) do
		local var_17_2 = iter_17_1[1]
		local var_17_3 = arg_17_0.taskProxy
		local var_17_4

		if not var_9.getTaskVO(var_17_3, var_17_2) then
			Task = var_17_4
			var_17_4 = var_17_4.New({
				id = var_17_2
			})
		end

		local var_17_5 = arg_17_0.rtLogin
		local var_17_6 = var_10.Find(var_17_5, var_17_1[iter_17_0])
		local var_17_7 = var_17_4
		local var_17_8 = var_17_4.isReceive(var_17_7)

		setActive = var_17_5

		var_17_5(var_17_6:Find("got"), var_17_8 or iter_17_0 < arg_17_0.nday)

		local var_17_9 = not var_17_0 and not var_17_8 and iter_17_0 == arg_17_0.nday

		setActive = var_17_7

		var_17_7(var_17_6:Find("get"), var_17_9)

		var_17_0 = var_17_0 or var_17_9
	end

	return
end

function var_0_1.UpdateTargetPtAct(arg_18_0)
	arg_18_0:FlushTargetPtAct()

	return
end

local function var_0_2(arg_19_0)
	pg = var_1_10001

	local var_19_0 = var_1_10001.SdkMgr.GetInstance()
	local var_19_1 = var_1.GetChannelUIDIncludeHarmony(var_19_0)
	local var_19_2 = arg_19_0._tf

	return (var_2.Find(var_19_2, "AD/rw_mask/rw_1/hx_ch" .. var_19_1))
end

function var_0_1.Hx4Channel(arg_20_0)
	local var_20_0 = var_0_2(arg_20_0)

	IsNil = var_1_10002

	if not var_1_10002(var_20_0) then
		setActive = var_2

		local var_20_1 = var_20_0

		HXSet = var_1_10005

		var_2(var_20_1, var_1_10005.isHx())
	end

	return
end

return var_0_1
