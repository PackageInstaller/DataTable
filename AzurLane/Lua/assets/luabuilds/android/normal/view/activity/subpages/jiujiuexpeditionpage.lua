class = var_0_10000

local var_0_0 = "JiuJiuExpeditionPage"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("...base.BaseActivityPage"))

function var_0_1.OnInit(arg_1_0)
	local var_1_0 = arg_1_0._tf

	arg_1_0.bg = var_1.Find(var_1_0, "AD")

	local var_1_1 = arg_1_0.bg

	arg_1_0.slider = var_1.Find(var_1_1, "slider")

	local var_1_2 = arg_1_0.bg

	arg_1_0.step = var_1.Find(var_1_2, "step")

	local var_1_3 = arg_1_0.bg

	arg_1_0.progress = var_1.Find(var_1_3, "progress")

	local var_1_4 = arg_1_0.bg

	arg_1_0.awardTF = var_1.Find(var_1_4, "award")

	local var_1_5 = arg_1_0.bg

	arg_1_0.battleBtn = var_1.Find(var_1_5, "battle_btn")

	local var_1_6 = arg_1_0.bg

	arg_1_0.getBtn = var_1.Find(var_1_6, "get_btn")

	local var_1_7 = arg_1_0.bg

	arg_1_0.gotBtn = var_1.Find(var_1_7, "got_btn")

	local var_1_8 = arg_1_0.bg

	arg_1_0.help = var_1.Find(var_1_8, "help")

	local var_1_9 = arg_1_0.bg

	arg_1_0.book = var_1.Find(var_1_9, "book")

	local var_1_10 = arg_1_0.bg

	arg_1_0.startGame = var_1.Find(var_1_10, "startGame")

	local var_1_11 = arg_1_0.bg

	arg_1_0.desc = var_1.Find(var_1_11, "desc")

	return
end

function var_0_1.OnDataSetting(arg_2_0)
	local var_2_0 = arg_2_0.activity
	local var_2_1 = var_1.getConfig(var_2_0, "config_data")

	_ = var_2_0
	arg_2_0.taskIDList = var_2_0.flatten(var_2_1)
	arg_2_0.dropList = {}
	arg_2_0.descs = {}
	ipairs = var_2

	for iter_2_0, iter_2_1 in var_2(arg_2_0.taskIDList) do
		pg = var_1_10007
		var_1_10007 = var_1_10007.task_data_template[iter_2_1].award_display[1]
		table = var_1_10008
		var_1_10008 = var_1_10008.insert

		local var_2_2 = arg_2_0.dropList

		Clone = var_1_10010

		var_1_10008(var_2_2, var_1_10010(var_1_10007))

		pg = var_1_10008
		var_1_10008 = var_1_10008.task_data_template[iter_2_1].desc
		table = var_2_2

		var_2_2.insert(arg_2_0.descs, var_1_10008)
	end

	updateActivityTaskStatus = var_2

	return var_2(arg_2_0.activity)
end

function var_0_1.OnFirstFlush(arg_3_0)
	onButton = var_1_10001

	local var_3_0 = arg_3_0
	local var_3_1 = arg_3_0.battleBtn

	local function var_3_2()
		if arg_3_0.curTaskVO then
			local var_4_0 = arg_3_0
			local var_4_1 = var_0.emit

			ActivityMediator = var_2_10002

			var_4_1(var_4_0, var_2_10002.ON_TASK_GO, arg_3_0.curTaskVO)
		end

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_3_0, var_3_1, var_3_2, var_1_10005)

	onButton = var_1_10001

	local var_3_3 = arg_3_0
	local var_3_4 = arg_3_0.getBtn

	local function var_3_5()
		local var_5_0 = arg_3_0
		local var_5_1 = var_0.emit

		ActivityMediator = var_2_10002

		var_5_1(var_5_0, var_2_10002.ON_TASK_SUBMIT, arg_3_0.curTaskVO)

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_3_3, var_3_4, var_3_5, var_1_10005)

	onButton = var_1_10001

	local var_3_6 = arg_3_0
	local var_3_7 = arg_3_0.help

	local function var_3_8()
		pg = var_2_10000

		local var_6_0 = var_2_10000.MsgboxMgr.GetInstance()
		local var_6_1 = var_0.ShowMsgBox
		local var_6_2 = {}

		MSGBOX_TYPE_HELP = var_2_10003
		var_6_2.type = var_2_10003
		pg = var_2_10003
		var_6_2.helps = var_2_10003.gametip.jiujiu_expedition_help.tip

		var_6_1(var_6_0, var_6_2)

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_3_6, var_3_7, var_3_8, var_1_10005)

	PLATFORM_CODE = var_1_10001
	PLATFORM_JP = var_3_6

	if var_1_10001 ~= var_3_6 then
		setActive = var_1_10001

		var_1_10001(arg_3_0.book, false)
	else
		JiuJiuExpeditionCollectionMediator = var_1_10001

		local var_3_9, var_3_10, var_3_11

		var_1_10001, var_3_9, var_3_10, var_3_11 = var_1_10001.GetCollectionData()
		setActive = var_1_10005
		findTF = var_1_10006

		var_1_10005(var_1_10006(arg_3_0.book, "tip"), var_3_11 < var_3_10)

		onButton = var_1_10005

		local var_3_12 = arg_3_0
		local var_3_13 = arg_3_0.book

		local function var_3_14()
			local var_7_0 = arg_3_0
			local var_7_1 = var_0.emit

			ActivityMediator = var_2_10002

			local var_7_2 = var_2_10002.OPEN_LAYER

			Context = var_2_10003

			local var_7_3 = var_2_10003.New
			local var_7_4 = {}

			JiuJiuExpeditionCollectionLayer = var_2_10005
			var_7_4.viewComponent = var_2_10005
			JiuJiuExpeditionCollectionMediator = var_2_10005
			var_7_4.mediator = var_2_10005

			var_7_1(var_7_0, var_7_2, var_7_3(var_7_4))

			return
		end

		SFX_PANEL = var_1_10009

		var_1_10005(var_3_12, var_3_13, var_3_14, var_1_10009)
	end

	onButton = var_1_10001

	local var_3_15 = arg_3_0
	local var_3_16 = arg_3_0.startGame

	local function var_3_17()
		local var_8_0 = arg_3_0
		local var_8_1 = var_0.emit

		ActivityMediator = var_2_10002

		local var_8_2 = var_2_10002.EVENT_GO_SCENE

		SCENE = var_2_10003

		var_8_1(var_8_0, var_8_2, var_2_10003.JIUJIU_EXPEDITION)

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_3_15, var_3_16, var_3_17, var_1_10005)

	return
end

function var_0_1.OnUpdateFlush(arg_9_0)
	getActivityTask = var_1_10001

	local var_9_0, var_9_1 = var_1_10001(arg_9_0.activity)

	arg_9_0.curTaskVO = var_9_1
	setText = var_1_10003

	local var_9_2 = arg_9_0.desc
	local var_9_3 = arg_9_0.curTaskVO

	var_1_10003(var_9_2, var_5.getConfig(var_9_3, "desc"))

	local var_9_4 = var_9_1:getConfig("award_display")[1]
	local var_9_5 = {
		type = var_9_4[1],
		id = var_9_4[2],
		count = var_9_4[3]
	}

	updateDrop = var_5

	var_5(arg_9_0.awardTF, var_9_5)

	onButton = var_5

	local var_9_6 = arg_9_0
	local var_9_7 = arg_9_0.awardTF

	local function var_9_8()
		local var_10_0 = arg_9_0
		local var_10_1 = var_0.emit

		BaseUI = var_2_10002

		var_10_1(var_10_0, var_2_10002.ON_DROP, var_9_5)

		return
	end

	SFX_PANEL = var_1_10009

	var_5(var_9_6, var_9_7, var_9_8, var_1_10009)

	local var_9_9 = var_9_1:getProgress()
	local var_9_10 = var_9_1
	local var_9_11 = var_9_1.getConfig(var_9_10, "target_num")

	setText = var_9_10

	local var_9_12 = arg_9_0.progress

	if var_9_11 <= var_9_9 then
		setColorStr = var_1_10009

		local var_9_13 = var_9_9

		COLOR_GREEN = var_1_10011

		local var_9_14

		if not var_1_10009(var_9_13, var_1_10011) then
			var_9_14 = var_9_9
		end

		var_9_10(var_9_12, var_9_14 .. "/" .. var_9_11)

		setSlider = var_9_10

		var_9_10(arg_9_0.slider, 0, var_9_11, var_9_9)

		table = var_9_10

		local var_9_15 = var_9_10.indexof(arg_9_0.taskIDList, var_9_0, 1)

		setText = var_8

		var_8(arg_9_0.step, var_9_15 .. "/" .. #arg_9_0.taskIDList)

		local var_9_16 = var_9_1
		local var_9_17 = var_9_1.getTaskStatus(var_9_16)

		setActive = var_9_16

		var_9_16(arg_9_0.battleBtn, var_9_17 == 0)

		setActive = var_9_16

		var_9_16(arg_9_0.getBtn, var_9_17 == 1)

		setActive = var_9_16

		var_9_16(arg_9_0.gotBtn, var_9_17 == 2)

		if var_9_17 == 2 then
			arg_9_0.finishedIndex = var_9_15
		else
			arg_9_0.finishedIndex = var_9_15 - 1
		end

		return
	end
end

function var_0_1.OnDestroy(arg_11_0)
	return
end

return var_0_1
