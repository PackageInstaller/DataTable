class = var_0_10000

local var_0_0 = var_0_10000("ReturnerPage")

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	pg = var_1_10003

	var_1_10003.DelegateInfo.New(arg_1_0)

	arg_1_0._go = arg_1_1
	tf = var_3
	arg_1_0._tf = var_3(arg_1_1)
	arg_1_0._event = arg_1_2

	local var_1_0 = arg_1_0._tf
	local var_1_1 = var_3.Find(var_1_0, "bg")
	local var_1_2 = var_3.GetComponent

	typeof = var_5
	Image = var_1_10006
	arg_1_0.bg = var_1_2(var_1_1, var_5(var_1_10006))

	local var_1_3 = arg_1_0._tf

	arg_1_0.input = var_3.Find(var_1_3, "InputField")

	local var_1_4 = arg_1_0._tf
	local var_1_5 = var_3.Find(var_1_4, "InputField/Placeholder")
	local var_1_6 = var_3.GetComponent

	typeof = var_5
	Text = var_1_10006
	arg_1_0.inputPlaceholder = var_1_6(var_1_5, var_5(var_1_10006))

	local var_1_7 = arg_1_0._tf

	arg_1_0.confirmBtn = var_3.Find(var_1_7, "confim_btn")
	UIItemList = var_3

	local var_1_8 = var_3.New
	local var_1_9 = arg_1_0._tf
	local var_1_10 = var_4.Find(var_1_9, "task_list")
	local var_1_11 = arg_1_0._tf

	arg_1_0.taskUIlist = var_1_8(var_1_10, var_5.Find(var_1_11, "task_list/tpl"))

	local var_1_12 = arg_1_0._tf
	local var_1_13 = var_3.Find(var_1_12, "total_progress")
	local var_1_14 = var_3.GetComponent

	typeof = var_5
	Text = var_1_11
	arg_1_0.totalProgress = var_1_14(var_1_13, var_5(var_1_11))

	local var_1_15 = arg_1_0._tf
	local var_1_16 = var_3.Find(var_1_15, "progress")
	local var_1_17 = var_3.GetComponent

	typeof = var_5
	Text = var_1_11
	arg_1_0.progress = var_1_17(var_1_16, var_5(var_1_11))

	local var_1_18 = arg_1_0._tf

	arg_1_0.awrdOverviewBtn = var_3.Find(var_1_18, "award_overview")

	local var_1_19 = arg_1_0._tf

	arg_1_0.help = var_3.Find(var_1_19, "help")

	local var_1_20 = arg_1_0._tf
	local var_1_21 = var_3.Find(var_1_20, "pt")
	local var_1_22 = var_3.GetComponent

	typeof = var_5
	Text = var_1_11
	arg_1_0.ptTxt = var_1_22(var_1_21, var_5(var_1_11))

	local var_1_23 = arg_1_0._tf

	arg_1_0.matchBtn = var_3.Find(var_1_23, "match_btn")

	local var_1_24 = arg_1_0._tf

	arg_1_0.matchedBtn = var_3.Find(var_1_24, "matched_btn")

	arg_1_0:Init()

	return
end

function var_0_0.Init(arg_2_0)
	onButton = var_1_10001

	local var_2_0 = arg_2_0
	local var_2_1 = arg_2_0.confirmBtn

	local function var_2_2()
		local var_3_1

		if arg_2_0.code ~= 0 then
			pg = var_3_1

			local var_3_0 = var_3_1.TipsMgr.GetInstance()

			var_3_1 = var_3_1.ShowTips
			i18n = var_2_10002

			var_3_1(var_3_0, var_2_10002("return_have_participated_in_act"))

			return
		end

		getInputText = var_3_1

		if not var_3_1(arg_2_0.input) or var_0 == "" then
			return
		end

		tonumber = var_1

		if var_1(var_0) > 2147483647 then
			pg = var_1

			local var_3_2 = var_1.TipsMgr.GetInstance()
			local var_3_3 = var_1.ShowTips

			i18n = var_2_10003

			var_3_3(var_3_2, var_2_10003("word_notExist"))

			return
		end

		local var_3_4 = arg_2_0._event
		local var_3_5 = var_1.emit

		ActivityMediator = var_2_10003

		local var_3_6 = var_2_10003.RETURN_AWARD_OP
		local var_3_7 = {
			activity_id = arg_2_0.activity.id
		}

		ActivityConst = var_5
		var_3_7.cmd = var_5.RETURN_AWARD_OP_SET_RETRUNER
		tonumber = var_5
		var_3_7.arg1 = var_5(var_0)

		var_3_5(var_3_4, var_3_6, var_3_7)

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_2_0, var_2_1, var_2_2, var_1_10005)

	onButton = var_1_10001

	local var_2_3 = arg_2_0
	local var_2_4 = arg_2_0.awrdOverviewBtn

	local function var_2_5()
		local var_4_0 = arg_2_0._event
		local var_4_1 = var_0.emit

		ActivityMediator = var_2_10002

		local var_4_2 = var_2_10002.RETURN_AWARD_OP
		local var_4_3 = {}

		ActivityConst = var_2_10004
		var_4_3.cmd = var_2_10004.RETURN_AWARD_OP_SHOW_RETURNER_AWARD_OVERVIEW

		local var_4_4 = {
			blur = true,
			tasklist = arg_2_0.config.task_list
		}

		pg = var_5
		var_4_4.ptId = var_5.activity_template_headhunting[arg_2_0.activity.id].pt
		var_4_4.totalPt = arg_2_0.pt
		var_4_4.index = arg_2_0.taskIndex
		var_4_3.arg1 = var_4_4

		var_4_1(var_4_0, var_4_2, var_4_3)

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_2_3, var_2_4, var_2_5, var_1_10005)

	onButton = var_1_10001

	local var_2_6 = arg_2_0
	local var_2_7 = arg_2_0.matchBtn

	local function var_2_8()
		if arg_2_0.code ~= 0 then
			return
		end

		pg = var_0

		local var_5_0 = var_0.MsgboxMgr.GetInstance()
		local var_5_1 = var_0.ShowMsgBox
		local var_5_2 = {}

		i18n = var_2_10003
		var_5_2.content = var_2_10003("returner_match_tip")

		function var_5_2.onYes()
			local var_6_0 = arg_2_0._event
			local var_6_1 = var_0.emit

			ActivityMediator = var_3_10002

			local var_6_2 = var_3_10002.RETURN_AWARD_OP
			local var_6_3 = {
				activity_id = arg_2_0.activity.id
			}

			ActivityConst = var_4
			var_6_3.cmd = var_4.RETURN_AWARD_OP_MATCH

			var_6_1(var_6_0, var_6_2, var_6_3)

			return
		end

		var_5_1(var_5_0, var_5_2)

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_2_6, var_2_7, var_2_8, var_1_10005)

	return
end

function var_0_0.Update(arg_7_0, arg_7_1)
	arg_7_0.activity = arg_7_1

	arg_7_0:UpdateData()

	if arg_7_0:ShouldAcceptTasks() then
		arg_7_0:AcceptTasks()
	else
		arg_7_0:UpdateTasks()
	end

	if not (arg_7_0.code ~= 0) then
		local var_7_0 = arg_7_0.inputPlaceholder

		i18n = var_1_10004
		var_7_0.text = var_1_10004("input_returner_code")
	else
		local var_7_1 = arg_7_0.inputPlaceholder

		var_7_1.text = arg_7_0.code
		setInputText = var_7_1

		var_7_1(arg_7_0.input, "")
	end

	local var_7_2 = arg_7_0.input
	local var_7_3 = var_3.GetComponent

	typeof = var_1_10005
	InputField = var_1_10006

	local var_7_4 = var_7_3(var_7_2, var_1_10005(var_1_10006))

	var_7_4.interactable = not var_2
	setActive = var_7_4

	var_7_4(arg_7_0.matchBtn, not var_2)

	setActive = var_7_4

	var_7_4(arg_7_0.matchedBtn, var_2)

	return
end

function var_0_0.ShouldAcceptTasks(arg_8_0)
	if arg_8_0.code == 0 then
		return false
	end

	if arg_8_0.taskIndex == 0 then
		return true
	end

	local var_8_0 = arg_8_0.config.task_list

	getProxy = var_1_10002
	TaskProxy = var_1_10003

	local var_8_1 = var_1_10002(var_1_10003)

	_ = var_1_10003

	local var_8_2 = var_1_10003.all(var_8_0[arg_8_0.taskIndex], function(arg_9_0)
		local var_9_0 = var_8_1

		return var_1.getFinishTaskById(var_9_0, arg_9_0) ~= nil
	end)

	_ = var_4

	local var_8_3 = var_4.all(var_8_0[arg_8_0.taskIndex], function(arg_10_0)
		local var_10_0 = var_8_1

		if var_1.getTaskById(var_10_0, arg_10_0) == nil then
			local var_10_1 = var_8_1
			local var_10_2

			if var_1.getFinishTaskById(var_10_1, arg_10_0) ~= nil then
				var_10_2 = false
			else
				var_10_2 = true
			end

			return var_10_2
		end
	end)
	local var_8_4 = arg_8_0.taskIndex == #var_8_0

	local function var_8_5()
		return arg_8_0.day > arg_8_0.taskIndex
	end

	return var_8_3 or var_8_2 and not var_8_4 and var_8_5()
end

function var_0_0.AcceptTasks(arg_12_0)
	local var_12_0 = arg_12_0._event
	local var_12_1 = var_1.emit

	ActivityMediator = var_1_10003

	local var_12_2 = var_1_10003.RETURN_AWARD_OP
	local var_12_3 = {
		activity_id = arg_12_0.activity.id
	}

	ActivityConst = var_5
	var_12_3.cmd = var_5.RETURN_AWARD_OP_RETURNER_GET_AWARD

	var_12_1(var_12_0, var_12_2, var_12_3)

	return
end

function var_0_0.UpdateData(arg_13_0)
	local var_13_0 = arg_13_0.activity

	pg = var_1_10002
	arg_13_0.config = var_1_10002.activity_template_returnner[var_13_0.id]
	arg_13_0.code = var_13_0.data2
	pg = var_2

	local var_13_1 = var_2.activity_template_headhunting[var_13_0.id]

	arg_13_0.pt = var_13_0.data3
	arg_13_0.taskIndex = var_13_0.data4

	local var_13_2 = arg_13_0.ptTxt

	var_13_2.text = arg_13_0.pt
	pg = var_13_2

	local var_13_3 = var_13_2.TimeMgr.GetInstance()
	local var_13_4 = var_3.GetServerTime(var_13_3)

	pg = var_13_3

	local var_13_5 = var_13_3.TimeMgr.GetInstance()

	arg_13_0.day = var_4.DiffDay(var_13_5, var_13_0:getStartTime(), var_13_4) + 1

	return
end

local function var_0_1(arg_14_0, arg_14_1, arg_14_2)
	local var_14_0 = arg_14_2:getConfig("award_display")[1]
	local var_14_1 = {
		type = var_14_0[1],
		id = var_14_0[2],
		count = var_14_0[3]
	}

	updateDrop = var_5

	var_5(arg_14_1:Find("item"), var_14_1)

	onButton = var_5

	local var_14_2 = arg_14_0
	local var_14_3 = arg_14_1:Find("item")

	local function var_14_4()
		local var_15_0 = arg_14_0._event
		local var_15_1 = var_0.emit

		BaseUI = var_2_10002

		var_15_1(var_15_0, var_2_10002.ON_DROP, var_14_1)

		return
	end

	SFX_PANEL = var_9

	var_5(var_14_2, var_14_3, var_14_4, var_9)

	setText = var_5

	var_5(arg_14_1:Find("desc"), arg_14_2:getConfig("desc"))

	setFillAmount = var_5

	var_5(arg_14_1:Find("slider"), arg_14_2:getProgress() / arg_14_2:getConfig("target_num"))

	local var_14_5 = arg_14_1:Find("go")
	local var_14_6 = arg_14_1:Find("get")
	local var_14_7 = arg_14_1
	local var_14_8 = arg_14_1.Find(var_14_7, "got")

	setActive = var_14_7

	var_14_7(var_14_5, not arg_14_2:isFinish())

	setActive = var_14_7

	local var_14_9 = var_14_6
	local var_14_10

	if arg_14_2:isFinish() then
		var_14_10 = not arg_14_2:isReceive()
	end

	var_14_7(var_14_9, var_14_10)

	setActive = var_14_7

	var_14_7(var_14_8, arg_14_2:isReceive())

	onButton = var_14_7

	local var_14_11 = arg_14_0
	local var_14_12 = var_14_5

	local function var_14_13()
		local var_16_0 = arg_14_0._event
		local var_16_1 = var_0.emit

		ActivityMediator = var_2_10002

		var_16_1(var_16_0, var_2_10002.ON_TASK_GO, arg_14_2)

		return
	end

	SFX_PANEL = var_1_10012

	var_14_7(var_14_11, var_14_12, var_14_13, var_1_10012)

	onButton = var_14_7

	local var_14_14 = arg_14_0
	local var_14_15 = var_14_6

	local function var_14_16()
		local var_17_0 = arg_14_0._event
		local var_17_1 = var_0.emit

		ActivityMediator = var_2_10002

		var_17_1(var_17_0, var_2_10002.ON_TASK_SUBMIT, arg_14_2)

		return
	end

	SFX_PANEL = var_1_10012

	var_14_7(var_14_14, var_14_15, var_14_16, var_1_10012)

	return
end

function var_0_0.UpdateTasks(arg_18_0)
	local var_18_0

	if not arg_18_0.config.task_list[arg_18_0.taskIndex] then
		var_18_0 = {}
	end

	local var_18_1 = arg_18_0.taskUIlist

	var_3.make(var_18_1, function(arg_19_0, arg_19_1, arg_19_2)
		UIItemList = var_2_10003

		if arg_19_0 == var_2_10003.EventUpdate then
			local var_19_0 = var_18_0[arg_19_1 + 1]

			getProxy = var_4
			TaskProxy = var_2_10005

			local var_19_1 = var_4(var_2_10005)
			local var_19_2

			if not var_4.getTaskById(var_19_1, var_19_0) then
				var_19_1 = var_4
				var_19_2 = var_4.getFinishTaskById(var_19_1, var_19_0)
			end

			assert = var_19_1

			var_19_1(var_19_2)
			var_0_1(arg_18_0, arg_19_2, var_19_2)
		end

		return
	end)

	local var_18_2 = arg_18_0.taskUIlist

	var_3.align(var_18_2, #var_18_0)

	arg_18_0.totalProgress.text = #var_1
	arg_18_0.progress.text = arg_18_0.taskIndex

	return
end

function var_0_0.Dispose(arg_20_0)
	pg = var_1_10001

	var_1_10001.DelegateInfo.Dispose(arg_20_0)

	arg_20_0.bg.sprite = nil

	return
end

return var_0_0
