class = var_0_10000

local var_0_0 = var_0_10000("InviterPage")

var_0_0.REFRESH_TIME = 1800

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	pg = var_1_10003

	var_1_10003.DelegateInfo.New(arg_1_0)

	arg_1_0._event = arg_1_2
	arg_1_0._go = arg_1_1
	tf = var_3
	arg_1_0._tf = var_3(arg_1_1)

	local var_1_0 = arg_1_0._tf
	local var_1_1 = var_3.Find(var_1_0, "pt_panel/slider/Text")
	local var_1_2 = var_3.GetComponent

	typeof = var_5
	Text = var_1_10006
	arg_1_0.ptTxt = var_1_2(var_1_1, var_5(var_1_10006))

	local var_1_3 = arg_1_0._tf
	local var_1_4 = var_3.Find(var_1_3, "pt_panel/total_progress")
	local var_1_5 = var_3.GetComponent

	typeof = var_5
	Text = var_1_10006
	arg_1_0.phaseTotalTxt = var_1_5(var_1_4, var_5(var_1_10006))

	local var_1_6 = arg_1_0._tf
	local var_1_7 = var_3.Find(var_1_6, "pt_panel/progress")
	local var_1_8 = var_3.GetComponent

	typeof = var_5
	Text = var_1_10006
	arg_1_0.phaseTxt = var_1_8(var_1_7, var_5(var_1_10006))

	local var_1_9 = arg_1_0._tf

	arg_1_0.progress = var_3.Find(var_1_9, "pt_panel/slider")

	local var_1_10 = arg_1_0._tf

	arg_1_0.getBtn = var_3.Find(var_1_10, "pt_panel/get")

	local var_1_11 = arg_1_0._tf

	arg_1_0.awardTF = var_3.Find(var_1_11, "pt_panel/item")

	local var_1_12 = arg_1_0._tf

	arg_1_0.awardOverView = var_3.Find(var_1_12, "pt_panel/award_overview")

	local var_1_13 = arg_1_0._tf
	local var_1_14 = var_3.Find(var_1_13, "bg")
	local var_1_15 = var_3.GetComponent

	typeof = var_5
	Image = var_1_10006
	arg_1_0.bg = var_1_15(var_1_14, var_5(var_1_10006))
	UIItemList = var_3

	local var_1_16 = var_3.New
	local var_1_17 = arg_1_0._tf
	local var_1_18 = var_4.Find(var_1_17, "returners/content")
	local var_1_19 = arg_1_0._tf

	arg_1_0.returnerList = var_1_16(var_1_18, var_5.Find(var_1_19, "returners/content/tpl"))

	local var_1_20 = arg_1_0._tf

	arg_1_0.help = var_3.Find(var_1_20, "help")

	local var_1_21 = arg_1_0._tf

	arg_1_0.pushBtn = var_3.Find(var_1_21, "push_btn")

	local var_1_22 = arg_1_0._tf

	arg_1_0.pushedBtn = var_3.Find(var_1_22, "pushed_btn")

	local var_1_23 = arg_1_0._tf

	arg_1_0.pushDisBtn = var_3.Find(var_1_23, "push_btn_dis")

	local var_1_24 = arg_1_0._tf
	local var_1_25 = var_3.Find(var_1_24, "code")
	local var_1_26 = var_3.GetComponent

	typeof = var_5
	Text = var_1_19
	arg_1_0.codeTxt = var_1_26(var_1_25, var_5(var_1_19))

	local var_1_27 = arg_1_0._tf

	arg_1_0.taskLockPanel = var_3.Find(var_1_27, "task_lock_panel")
	setText = var_3

	local var_1_28 = arg_1_0.taskLockPanel
	local var_1_29 = var_4.Find(var_1_28, "Text")

	i18n = var_1_28

	var_3(var_1_29, var_1_28("word_sell_lock"))

	local var_1_30 = arg_1_0._tf

	arg_1_0.taskPanel = var_3.Find(var_1_30, "task_panel")

	local var_1_31 = arg_1_0._tf

	arg_1_0.taskItemTF = var_3.Find(var_1_31, "task_panel/item")

	local var_1_32 = arg_1_0._tf

	arg_1_0.taskProgress = var_3.Find(var_1_32, "task_panel/progress")

	local var_1_33 = arg_1_0._tf

	arg_1_0.taskDesc = var_3.Find(var_1_33, "task_panel/desc")

	local var_1_34 = arg_1_0._tf

	arg_1_0.taskGoBtn = var_3.Find(var_1_34, "task_panel/go")

	local var_1_35 = arg_1_0._tf

	arg_1_0.taskGotBtn = var_3.Find(var_1_35, "task_panel/got")

	local var_1_36 = arg_1_0._tf

	arg_1_0.taskGetBtn = var_3.Find(var_1_36, "task_panel/get")

	local var_1_37 = arg_1_0._tf
	local var_1_38 = var_3.Find(var_1_37, "task_panel/p")
	local var_1_39 = var_3.GetComponent

	typeof = var_5
	Text = var_6
	arg_1_0.taskProgressTxt = var_1_39(var_1_38, var_5(var_6))
	setText = var_3

	local var_1_40 = arg_1_0._tf
	local var_1_41 = var_4.Find(var_1_40, "pt_panel/title")

	i18n = var_1_40

	var_3(var_1_41, var_1_40("activity_return_reward_pt"))
	arg_1_0:Init()

	return
end

function var_0_0.Init(arg_2_0)
	onButton = var_1_10001

	local var_2_0 = arg_2_0
	local var_2_1 = arg_2_0.getBtn

	local function var_2_2()
		local var_3_0 = arg_2_0._event
		local var_3_1 = var_0.emit

		ActivityMediator = var_2_10002

		local var_3_2 = var_2_10002.RETURN_AWARD_OP
		local var_3_3 = {
			activity_id = arg_2_0.activity.id
		}

		ActivityConst = var_4
		var_3_3.cmd = var_4.RETURN_AWARD_OP_GET_AWARD
		var_3_3.arg1 = arg_2_0.nextTarget

		var_3_1(var_3_0, var_3_2, var_3_3)

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_2_0, var_2_1, var_2_2, var_1_10005)

	onButton = var_1_10001

	local var_2_3 = arg_2_0
	local var_2_4 = arg_2_0.awardOverView

	local function var_2_5()
		local var_4_0 = arg_2_0._event
		local var_4_1 = var_0.emit

		ActivityMediator = var_2_10002

		local var_4_2 = var_2_10002.RETURN_AWARD_OP
		local var_4_3 = {}

		ActivityConst = var_2_10004
		var_4_3.cmd = var_2_10004.RETURN_AWARD_OP_SHOW_AWARD_OVERVIEW
		var_4_3.arg1 = {
			blur = true,
			dropList = arg_2_0.config.drop_client,
			targets = arg_2_0.config.target,
			fetchList = arg_2_0.fetchList,
			count = arg_2_0.pt,
			resId = arg_2_0.config.pt
		}

		var_4_1(var_4_0, var_4_2, var_4_3)

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_2_3, var_2_4, var_2_5, var_1_10005)

	onButton = var_1_10001

	local var_2_6 = arg_2_0
	local var_2_7 = arg_2_0.pushBtn

	local function var_2_8()
		if arg_2_0.isPush then
			return
		end

		local var_5_1

		if not arg_2_0.returners or #arg_2_0.returners >= 3 then
			pg = var_5_1

			local var_5_0 = var_5_1.TipsMgr.GetInstance()

			var_5_1 = var_5_1.ShowTips
			i18n = var_2_10002

			var_5_1(var_5_0, var_2_10002("returner_max_count"))

			return
		end

		pg = var_5_1

		local var_5_2 = var_5_1.MsgboxMgr.GetInstance()
		local var_5_3 = var_0.ShowMsgBox
		local var_5_4 = {}

		i18n = var_2_10003
		var_5_4.content = var_2_10003("returner_push_tip")

		function var_5_4.onYes()
			local var_6_0 = arg_2_0._event
			local var_6_1 = var_0.emit

			ActivityMediator = var_3_10002

			local var_6_2 = var_3_10002.RETURN_AWARD_OP
			local var_6_3 = {
				activity_id = arg_2_0.activity.id
			}

			ActivityConst = var_4
			var_6_3.cmd = var_4.RETURN_AWARD_OP_PUSH_UID
			var_6_3.arg1 = arg_2_0.code

			var_6_1(var_6_0, var_6_2, var_6_3)

			return
		end

		var_5_3(var_5_2, var_5_4)

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_2_6, var_2_7, var_2_8, var_1_10005)

	return
end

function var_0_0.Update(arg_7_0, arg_7_1)
	arg_7_0.activity = arg_7_1
	pg = var_1_10002

	local var_7_0 = var_1_10002.TimeMgr.GetInstance()
	local var_7_1 = var_2.GetServerTime(var_7_0)

	ActivityMainScene = var_7_0

	if var_7_0.FetchReturnersTime then
		ActivityMainScene = var_3

		if var_3.FetchReturnersTime <= var_7_1 then
			ActivityMainScene = var_3
			var_3.FetchReturnersTime = var_7_1 + var_0_0.REFRESH_TIME

			local var_7_2 = arg_7_0._event
			local var_7_3 = var_3.emit

			ActivityMediator = var_1_10005

			local var_7_4 = var_1_10005.RETURN_AWARD_OP
			local var_7_5 = {
				activity_id = arg_7_0.activity.id
			}

			ActivityConst = var_7
			var_7_5.cmd = var_7.RETURN_AWARD_OP_GET_RETRUNERS

			var_7_3(var_7_2, var_7_4, var_7_5)

			return
		end

		arg_7_0:UpdateData()
		arg_7_0:UpdateUI()
		arg_7_0:UpdateReturners()

		return
	end
end

function var_0_0.getTotalPt(arg_8_0, arg_8_1)
	local var_8_0 = 0

	ipairs = var_1_10003

	for iter_8_0, iter_8_1 in var_1_10003(arg_8_0.returners) do
		var_8_0 = var_8_0 + iter_8_1:getPt()
	end

	return var_8_0 + arg_8_1
end

function var_0_0.UpdateData(arg_9_0)
	arg_9_0.isPush = arg_9_0.activity.data2_list[1] == 1
	getProxy = var_2
	PlayerProxy = var_1_10003

	local var_9_0 = var_2(var_1_10003)

	arg_9_0.code = var_2.getRawData(var_9_0).id
	arg_9_0.fetchList = var_1.data1_list
	pg = var_2
	arg_9_0.config = var_2.activity_template_headhunting[var_1.id]
	arg_9_0.targets = arg_9_0.config.target
	arg_9_0.nextIndex = -1

	for iter_9_0 = 1, #arg_9_0.targets do
		local var_9_1 = arg_9_0.targets[iter_9_0]

		table = var_1_10007

		if not var_1_10007.contains(arg_9_0.fetchList, var_9_1) then
			arg_9_0.nextIndex = iter_9_0

			break
		end
	end

	if arg_9_0.nextIndex == -1 then
		arg_9_0.fetchIndex = #arg_9_0.targets
		arg_9_0.nextIndex = #arg_9_0.targets
	else
		math = var_2
		arg_9_0.fetchIndex = var_2.max(arg_9_0.nextIndex - 1, 0)
	end

	arg_9_0.drops = arg_9_0.config.drop_client
	arg_9_0.nextDrops = arg_9_0.config.drop_client[arg_9_0.nextIndex]
	arg_9_0.nextTarget = arg_9_0.targets[arg_9_0.nextIndex]
	arg_9_0.returners = var_1:getClientList()

	local var_9_2 = var_1.data3

	arg_9_0.pt = arg_9_0:getTotalPt(var_9_2)
	setActive = var_3

	var_3(arg_9_0.pushBtn, not arg_9_0.isPush and #arg_9_0.returners < 3)

	setActive = var_3

	var_3(arg_9_0.pushedBtn, arg_9_0.isPush)

	setActive = var_3

	var_3(arg_9_0.pushDisBtn, not arg_9_0.isPush and #arg_9_0.returners >= 3)

	return
end

function var_0_0.UpdateUI(arg_10_0)
	arg_10_0.codeTxt.text = arg_10_0.code

	local var_10_0 = arg_10_0.ptTxt

	var_10_0.text = arg_10_0.pt .. "/" .. arg_10_0.nextTarget
	setActive = var_10_0

	var_10_0(arg_10_0.getBtn, arg_10_0.fetchIndex ~= #arg_10_0.targets and arg_10_0.pt >= arg_10_0.nextTarget)

	arg_10_0.phaseTxt.text = arg_10_0.fetchIndex

	local var_10_1 = arg_10_0.phaseTotalTxt

	var_10_1.text = #arg_10_0.targets
	setFillAmount = var_10_1

	var_10_1(arg_10_0.progress, arg_10_0.pt / arg_10_0.nextTarget)

	local var_10_2 = arg_10_0.nextDrops
	local var_10_3 = {
		type = var_10_2[1],
		id = var_10_2[2],
		count = var_10_2[3]
	}

	updateDrop = var_3

	var_3(arg_10_0.awardTF, var_10_3)

	onButton = var_3

	local var_10_4 = arg_10_0
	local var_10_5 = arg_10_0.awardTF

	local function var_10_6()
		local var_11_0 = arg_10_0._event
		local var_11_1 = var_0.emit

		BaseUI = var_2_10002

		var_11_1(var_11_0, var_2_10002.ON_DROP, var_10_3)

		return
	end

	SFX_PANEL = var_1_10007

	var_3(var_10_4, var_10_5, var_10_6, var_1_10007)

	pg = var_3

	local var_10_7 = var_3.activity_template_headhunting[arg_10_0.activity.id].tasklist

	arg_10_0:UpdateTasks(var_10_7)

	return
end

function var_0_0.getTask(arg_12_0, arg_12_1)
	getProxy = var_1_10002
	TaskProxy = var_1_10003

	local var_12_0 = var_1_10002(var_1_10003)
	local var_12_1

	if not var_2.getTaskById(var_12_0, arg_12_1) then
		var_12_1 = var_2:getFinishTaskById(arg_12_1)
	end

	return var_12_1
end

function var_0_0.UpdateTasks(arg_13_0, arg_13_1)
	if arg_13_0.isPush then
		local var_13_0 = arg_13_0.activity
		local var_13_1 = var_2.getDayIndex(var_13_0)

		getProxy = var_13_0
		TaskProxy = var_1_10005

		local var_13_2 = var_13_0(var_1_10005)
		local var_13_3 = 0

		for iter_13_0 = #arg_13_1, 1, -1 do
			if arg_13_0:getTask(arg_13_1[iter_13_0]) then
				var_13_3 = iter_13_0

				break
			end
		end

		local var_13_4 = arg_13_0

		if (not arg_13_0.getTask(var_13_4, arg_13_1[var_13_3]) or var_6:isReceive()) and var_13_3 < var_13_1 then
			if var_13_3 == #arg_13_1 and var_6 and var_6:isReceive() then
				arg_13_0:UpdateTaskTF(var_6)
			else
				local var_13_5 = arg_13_0._event

				var_13_4 = var_13_4.emit
				ActivityMediator = iter_13_0

				local var_13_6 = iter_13_0.RETURN_AWARD_OP
				local var_13_7 = {
					activity_id = var_2.id
				}

				ActivityConst = var_11
				var_13_7.cmd = var_11.RETURN_AWARD_OP_ACCEPT_TASK

				var_13_4(var_13_5, var_13_6, var_13_7)
			end
		else
			assert = var_13_4

			var_13_4(var_6)
			arg_13_0:UpdateTaskTF(var_6)
		end
	else
		setActive = var_2

		var_2(arg_13_0.taskPanel, false)

		setActive = var_2

		var_2(arg_13_0.taskLockPanel, true)
	end

	return
end

function var_0_0.UpdateTaskTF(arg_14_0, arg_14_1)
	setActive = var_1_10002

	var_1_10002(arg_14_0.taskLockPanel, false)

	setActive = var_1_10002

	var_1_10002(arg_14_0.taskPanel, true)

	local var_14_0 = arg_14_1:isFinish()
	local var_14_1 = arg_14_1
	local var_14_2 = arg_14_1.isReceive(var_14_1)

	setActive = var_14_1

	var_14_1(arg_14_0.taskGoBtn, arg_14_1 and not var_14_0)

	setActive = var_14_1

	var_14_1(arg_14_0.taskGotBtn, arg_14_1 and var_14_2)

	setActive = var_14_1

	var_14_1(arg_14_0.taskGetBtn, arg_14_1 and var_14_0 and not var_14_2)

	local var_14_3 = arg_14_1:getConfig("award_display")[1]
	local var_14_4 = {
		type = var_14_3[1],
		id = var_14_3[2],
		count = var_14_3[3]
	}

	updateDrop = var_6

	var_6(arg_14_0.taskItemTF, var_14_4)

	onButton = var_6

	local var_14_5 = arg_14_0
	local var_14_6 = arg_14_0.taskItemTF

	local function var_14_7()
		local var_15_0 = arg_14_0._event
		local var_15_1 = var_0.emit

		BaseUI = var_2_10002

		var_15_1(var_15_0, var_2_10002.ON_DROP, var_14_4)

		return
	end

	SFX_PANEL = var_1_10010

	var_6(var_14_5, var_14_6, var_14_7, var_1_10010)

	setFillAmount = var_6

	var_6(arg_14_0.taskProgress, arg_14_1:getProgress() / arg_14_1:getConfig("target_num"))

	setText = var_6

	var_6(arg_14_0.taskDesc, arg_14_1:getConfig("desc"))

	local var_14_8 = arg_14_0.taskProgressTxt
	local var_14_9 = arg_14_1:getProgress()
	local var_14_10 = "/"
	local var_14_11 = arg_14_1

	var_14_8.text = var_14_9 .. var_14_10 .. arg_14_1.getConfig(var_14_11, "target_num")
	onButton = var_14_8

	local var_14_12 = arg_14_0
	local var_14_13 = arg_14_0.taskGoBtn

	local function var_14_14()
		local var_16_0 = arg_14_0._event
		local var_16_1 = var_0.emit

		ActivityMediator = var_2_10002

		var_16_1(var_16_0, var_2_10002.ON_TASK_GO, arg_14_1)

		return
	end

	SFX_PANEL = var_14_11

	var_14_8(var_14_12, var_14_13, var_14_14, var_14_11)

	onButton = var_14_8

	local var_14_15 = arg_14_0
	local var_14_16 = arg_14_0.taskGetBtn

	local function var_14_17()
		local var_17_0 = arg_14_0._event
		local var_17_1 = var_0.emit

		ActivityMediator = var_2_10002

		var_17_1(var_17_0, var_2_10002.ON_TASK_SUBMIT, arg_14_1)

		return
	end

	SFX_PANEL = var_14_11

	var_14_8(var_14_15, var_14_16, var_14_17, var_14_11)

	return
end

local function var_0_1(arg_18_0, arg_18_1)
	LoadSpriteAsync = var_1_10002

	var_1_10002("qicon/" .. arg_18_1:getPainting(), function(arg_19_0)
		IsNil = var_2_10001

		if not var_2_10001(arg_18_0) then
			local var_19_0 = arg_18_0
			local var_19_1 = var_1.GetComponent

			typeof = var_2_10003
			Image = var_2_10004
			var_19_1(var_19_0, var_2_10003(var_2_10004)).sprite = arg_19_0
		end

		return
	end)

	UIItemList = var_1_10002

	local var_18_0 = var_1_10002.New(arg_18_0:Find("starts"), arg_18_0:Find("starts/tpl"))

	var_2.align(var_18_0, arg_18_1:getStar())

	return
end

function var_0_0.UpdateReturners(arg_20_0)
	local var_20_0 = arg_20_0.returners
	local var_20_1 = arg_20_0.returnerList

	var_2.make(var_20_1, function(arg_21_0, arg_21_1, arg_21_2)
		UIItemList = var_2_10003

		if arg_21_0 == var_2_10003.EventUpdate then
			local var_21_1

			if var_20_0[arg_21_1 + 1] then
				local var_21_0 = var_3

				var_21_1 = var_3.getIcon(var_21_0)
				Ship = var_21_0

				local var_21_2 = var_21_0.New({
					configId = var_21_1
				})

				var_0_1(arg_21_2:Find("info/icon"), var_21_2)

				setText = var_6

				var_6(arg_21_2:Find("info/name"), var_3:getName())

				setText = var_6

				var_6(arg_21_2:Find("info/pt/Text"), var_3:getPt())
			end

			setActive = var_21_1

			var_21_1(arg_21_2:Find("empty"), not var_3)

			setActive = var_21_1

			var_21_1(arg_21_2:Find("info"), var_3)
		end

		return
	end)

	local var_20_2 = arg_20_0.returnerList

	var_2.align(var_20_2, 2)

	return
end

function var_0_0.Dispose(arg_22_0)
	pg = var_1_10001

	var_1_10001.DelegateInfo.Dispose(arg_22_0)

	arg_22_0.bg.sprite = nil

	return
end

return var_0_0
