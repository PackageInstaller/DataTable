class = var_0_10000

local var_0_0 = "LittleOuGenPage"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".TemplatePage.PtTemplatePage"))

function var_0_1.OnInit(arg_1_0)
	var_0_1.super.OnInit(arg_1_0)

	local var_1_0 = arg_1_0.bg

	arg_1_0.heartTpl = var_1.Find(var_1_0, "HeartTpl")

	local var_1_1 = arg_1_0.bg

	arg_1_0.heartContainer = var_1.Find(var_1_1, "HeartContainer")
	UIItemList = var_1
	arg_1_0.heartUIItemList = var_1.New(arg_1_0.heartContainer, arg_1_0.heartTpl)

	local var_1_2 = arg_1_0.heartUIItemList

	var_1.make(var_1_2, function(arg_2_0, arg_2_1, arg_2_2)
		UIItemList = var_2_10003

		if arg_2_0 == var_2_10003.EventUpdate then
			local var_2_0 = arg_2_1 + 1
			local var_2_1 = arg_1_0.ptData
			local var_2_2 = var_4.GetLevelProgress(var_2_1)
			local var_2_3 = arg_2_2:Find("Full")

			setActive = var_2_1

			var_2_1(var_2_3, not (var_2_2 < var_2_0))
		end

		return
	end)

	local var_1_3 = arg_1_0.bg

	arg_1_0.helpBtn = var_1.Find(var_1_3, "help_btn")
	onButton = var_1

	local var_1_4 = arg_1_0
	local var_1_5 = arg_1_0.helpBtn

	local function var_1_6()
		pg = var_2_10000

		local var_3_0 = var_2_10000.MsgboxMgr.GetInstance()
		local var_3_1 = var_0.ShowMsgBox
		local var_3_2 = {}

		MSGBOX_TYPE_HELP = var_2_10004
		var_3_2.type = var_2_10004
		pg = var_2_10004
		var_3_2.helps = var_2_10004.gametip.littleEugen_npc.tip

		var_3_1(var_3_0, var_3_2)

		return
	end

	SFX_PANEL = var_1_10006

	var_1(var_1_4, var_1_5, var_1_6, var_1_10006)

	return
end

function var_0_1.OnUpdateFlush(arg_4_0)
	var_0_1.super.OnUpdateFlush(arg_4_0)

	local var_4_0 = arg_4_0.ptData
	local var_4_1, var_4_2 = var_1.GetLevelProgress(var_4_0)
	local var_4_3 = arg_4_0.heartUIItemList

	var_3.align(var_4_3, var_4_2)

	local var_4_4 = arg_4_0.ptData
	local var_4_5, var_4_6, var_4_7 = var_3.GetLevelProgress(var_4_4)
	local var_4_8 = arg_4_0.ptData
	local var_4_9, var_4_10, var_4_11 = var_6.GetResProgress(var_4_8)

	setText = var_1_10009

	local var_4_12 = arg_4_0.step

	setColorStr = var_1_10012

	local var_4_13 = var_1_10012(var_4_5, "#f8e6e2")
	local var_4_14 = " / "

	setColorStr = var_14

	var_1_10009(var_4_12, var_4_13 .. var_4_14 .. var_14(var_4_6, "#4e2c2b"))

	setText = var_1_10009

	local var_4_15 = arg_4_0.progress

	if 1 <= var_4_11 then
		setColorStr = var_4_17

		local var_4_16 = var_4_9

		COLOR_GREEN = var_15

		local var_4_17

		if not var_4_17(var_4_16, var_15) then
			setColorStr = var_4_17
			var_4_17 = var_4_17(var_4_9, "COLOR_GREEN")
		end

		local var_4_18 = "/"

		setColorStr = var_4_16

		var_1_10009(var_4_15, var_4_17 .. var_4_18 .. var_4_16(var_4_10, "#4e2c2b"))

		local var_4_19

		if arg_4_0.firstSliderInit then
			LeanTween = var_4_19
			var_4_19 = var_4_19.isTweening
			go = var_4_15

			if var_4_19(var_4_15(arg_4_0.slider)) then
				LeanTween = var_4_19
				var_4_19 = var_4_19.cancel
				go = var_11

				var_4_19(var_11(arg_4_0.slider))
			end

			GetComponent = var_4_19

			local var_4_20 = arg_4_0.slider

			typeof = var_12
			Slider = var_14
			var_4_19 = var_4_19(var_4_20, var_12(var_14)).value
			var_4_19 = arg_4_0.l1 ~= var_4_5 and 0 or arg_4_0.sliderValue
			LeanTween = var_10

			local var_4_21 = var_10.value

			go = var_12

			local var_4_22 = var_4_21(var_12(arg_4_0.slider), var_4_19, var_4_11, 1)
			local var_4_23 = var_10.setOnUpdate

			System = var_13

			var_4_23(var_4_22, var_13.Action_float(function(arg_5_0)
				setSlider = var_2_10001

				var_2_10001(arg_4_0.slider, 0, 1, arg_5_0)

				arg_4_0.sliderValue = arg_5_0

				return
			end))
		else
			setSlider = var_4_19

			var_4_19(arg_4_0.slider, 0, 1, var_4_11)

			arg_4_0.firstSliderInit = true
			arg_4_0.sliderValue = var_4_11
		end

		arg_4_0.l1 = var_4_5

		arg_4_0:updataTask()
		arg_4_0:sortTaskGroups()
		arg_4_0:updateTaskUI()

		return
	end
end

function var_0_1.updataTask(arg_6_0)
	ipairs = var_1_10001

	for iter_6_0, iter_6_1 in var_1_10001(arg_6_0.taskGroups) do
		ipairs = var_1_10006

		for iter_6_2, iter_6_3 in var_1_10006(iter_6_1.tasks) do
			local var_6_0 = arg_6_0.taskProxy
			local var_6_1 = var_11.getFinishTaskById(var_6_0, iter_6_3.id) and 1 or 0
			local var_6_2 = arg_6_0.taskProxy
			local var_6_3 = var_12.getTaskById(var_6_2, iter_6_3.id)
			local var_6_4 = 0

			if var_6_3 then
				local var_6_5

				if var_6_3:getProgress() ~= 0 or not iter_6_1.progress then
					var_6_5 = var_6_4
				end

				iter_6_1.progress = var_6_5
			else
				var_6_4 = iter_6_1.progress
			end

			iter_6_3.progress = var_6_4

			if iter_6_3.finish ~= var_6_1 then
				setActive = var_14

				var_14(iter_6_3.tf, false)

				table = var_14

				var_14.insert(arg_6_0.taskTplPool, iter_6_3.tf)

				iter_6_3.tf = nil
			end

			iter_6_3.finish = var_6_1
		end
	end

	return
end

function var_0_1.OnFirstFlush(arg_7_0)
	var_0_1.super.OnFirstFlush(arg_7_0)

	onButton = var_1

	local var_7_0 = arg_7_0
	local var_7_1 = arg_7_0.displayBtn

	local function var_7_2()
		local var_8_0 = arg_7_0
		local var_8_1 = var_0.emit

		ActivityMediator = var_2_10003

		local var_8_2 = var_2_10003.SHOW_AWARD_WINDOW

		PtAwardWindow = var_2_10004

		var_8_1(var_8_0, var_8_2, var_2_10004, {
			type = 5,
			dropList = arg_7_0.ptData.dropList,
			targets = arg_7_0.ptData.targets,
			level = arg_7_0.ptData.level,
			count = arg_7_0.ptData.count,
			resId = arg_7_0.ptData.resId
		})

		return
	end

	SFX_PANEL = var_1_10006

	var_1(var_7_0, var_7_1, var_7_2, var_1_10006)

	onButton = var_1

	local var_7_3 = arg_7_0
	local var_7_4 = arg_7_0.battleBtn

	local function var_7_5()
		local var_9_0 = arg_7_0
		local var_9_1 = var_0.emit

		ActivityMediator = var_2_10003

		local var_9_2 = var_2_10003.EVENT_GO_SCENE

		SCENE = var_2_10004

		var_9_1(var_9_0, var_9_2, var_2_10004.LEVEL)

		return
	end

	SFX_PANEL = var_1_10006

	var_1(var_7_3, var_7_4, var_7_5, var_1_10006)
	arg_7_0:initTask()
	arg_7_0:sortTaskGroups()
	arg_7_0:updateTaskUI()

	return
end

function var_0_1.initTask(arg_10_0)
	findTF = var_1_10001
	arg_10_0.missionTpl = var_1_10001(arg_10_0.bg, "missionTpl")
	setActive = var_1

	var_1(arg_10_0.missionTpl, false)

	findTF = var_1
	arg_10_0.missionContainer = var_1(arg_10_0.bg, "mission/content")

	local var_10_0 = arg_10_0.activity
	local var_10_1 = var_1.getConfig(var_10_0, "config_client").task_act_id

	pg = var_1_10002

	local var_10_2 = var_1_10002.activity_template[var_10_1].config_data

	getProxy = var_10_0
	TaskProxy = var_1_10005
	arg_10_0.taskProxy = var_10_0(var_1_10005)
	arg_10_0.taskTplPool = {}
	GetComponent = var_3
	findTF = var_1_10005

	local var_10_3 = var_1_10005(arg_10_0.bg, "mission")

	typeof = var_1_10006
	ScrollRect = var_8
	arg_10_0.taskScroll = var_3(var_10_3, var_1_10006(var_8))
	arg_10_0.taskGroups = {}

	for iter_10_0 = 1, #var_10_2 do
		local var_10_4 = var_10_2[iter_10_0]

		pg = var_8

		local var_10_5 = var_8.task_data_template[var_10_4].type
		local var_10_6 = var_8.sub_type

		Task = var_1_10011

		if var_10_5 ~= var_1_10011.TYPE_ACTIVITY then
			Task = var_1_10011

			if var_10_5 == var_1_10011.TYPE_ACTIVITY_BRANCH then
				var_1_10011 = arg_10_0:getTaskGroup(var_10_5, var_10_6)

				arg_10_0:insertTaskToGroup(var_10_4, var_8, var_1_10011)
			end
		end
	end

	return
end

function var_0_1.updateTaskUI(arg_11_0)
	local var_11_0 = 0

	for iter_11_0 = 1, #arg_11_0.taskGroups do
		local var_11_1 = arg_11_0.taskGroups[iter_11_0].tasks

		ipairs = var_1_10008

		for iter_11_1, iter_11_2 in var_1_10008(var_11_1) do
			arg_11_0:updateTaskList(iter_11_1, var_11_0, iter_11_2, var_6)

			var_11_0 = var_11_0 + 1
		end
	end

	local var_11_2 = 0
	local var_11_3 = 0

	if arg_11_0.scrollToGroup then
		ipairs = var_4

		for iter_11_3, iter_11_4 in var_4(arg_11_0.taskGroups) do
			if iter_11_4 == arg_11_0.scrollToGroup then
				var_11_3 = var_11_2
			end

			if iter_11_4.opening then
				var_11_2 = var_11_2 + #iter_11_4.tasks
			else
				var_11_2 = var_11_2 + 1
			end
		end

		arg_11_0.scrollToGroup = nil
	end

	if var_11_3 ~= 0 and var_11_2 ~= 0 then
		scrollTo = var_4

		var_4(arg_11_0.taskScroll, 0, 1 - var_11_3 / var_11_2)
	else
		scrollTo = var_4

		var_4(arg_11_0.taskScroll, 0, 1)
	end

	return
end

function var_0_1.updateTaskList(arg_12_0, arg_12_1, arg_12_2, arg_12_3, arg_12_4)
	if not arg_12_3.show then
		return
	end

	local var_12_0 = arg_12_3.targetNum
	local var_12_1 = arg_12_3.progress
	local var_12_2 = arg_12_3.finish == 1
	local var_12_3 = arg_12_1 == 1
	local var_12_4 = arg_12_3.desc
	local var_12_5 = arg_12_3.drop
	local var_12_6 = arg_12_4.opening
	local var_12_7 = #arg_12_4.tasks == 1

	if not arg_12_3.tf then
		arg_12_3.tf = arg_12_0:getTaskTfFromPool()
	end

	findTF = var_14

	local var_12_8 = var_14(arg_12_3.tf, "AD")
	local var_12_9 = arg_12_3.tf

	Vector2 = var_16
	var_12_9.sizeDelta = var_16(778, var_12_3 and 120 or 110)
	setActive = var_12_9
	findTF = var_17

	var_12_9(var_17(var_12_8, "bg1"), var_12_3)

	setActive = var_12_9
	findTF = var_17

	var_12_9(var_17(var_12_8, "bg2"), not var_12_3)

	if var_12_3 then
		setActive = var_12_9
		findTF = var_17

		var_12_9(var_17(var_12_8, "mask1"), var_12_2)
	else
		setActive = var_12_9
		findTF = var_17

		var_12_9(var_17(var_12_8, "mask2"), var_12_2)
	end

	if var_12_2 then
		setActive = var_12_9
		findTF = var_17

		var_12_9(var_17(var_12_8, "pahase"), false)

		setSlider = var_12_9
		findTF = var_17

		var_12_9(var_17(var_12_8, "slider"), 0, 1, 1)
	else
		setActive = var_12_9
		findTF = var_17

		var_12_9(var_17(var_12_8, "pahase"), true)

		setSlider = var_12_9
		findTF = var_17

		var_12_9(var_17(var_12_8, "slider"), 0, 1, var_12_1 / var_12_0)
	end

	setText = var_12_9
	findTF = var_17

	var_12_9(var_17(var_12_8, "desc"), var_12_4)

	local var_12_10

	if arg_12_4.subType ~= 33 then
		setText = var_15
		findTF = var_12_10
		var_12_10 = var_12_10(var_12_8, "pahase")
		setColorStr = var_18

		local var_12_11 = var_18(var_12_1, "#95b345")
		local var_12_12 = "/"

		setColorStr = var_20

		var_15(var_12_10, var_12_11 .. var_12_12 .. var_20(var_12_0, "#e9c9bd"))
	else
		setText = var_15
		findTF = var_12_10

		var_15(var_12_10(var_12_8, "pahase"), "")
	end

	updateDrop = var_15
	findTF = var_12_10

	var_15(var_12_10(var_12_8, "award"), var_12_5)

	onButton = var_15

	local var_12_13 = arg_12_0

	findTF = var_18

	local var_12_14 = var_18(var_12_8, "award")

	local function var_12_15()
		local var_13_0 = arg_12_0
		local var_13_1 = var_0.emit

		BaseUI = var_2_10003

		var_13_1(var_13_0, var_2_10003.ON_DROP, var_12_5)

		return
	end

	SFX_PANEL = var_20

	var_15(var_12_13, var_12_14, var_12_15, var_20)

	setActive = var_15
	findTF = var_12_13

	var_15(var_12_13(var_12_8, "got"), false)

	setActive = var_15
	findTF = var_17

	var_15(var_17(var_12_8, "get"), false)

	setActive = var_15
	findTF = var_17

	var_15(var_17(var_12_8, "go"), false)

	local var_12_16, var_12_17

	if not var_12_3 then
		setActive = var_15
		findTF = var_12_16

		var_15(var_12_16(var_12_8, "go"), not var_12_2)

		setActive = var_15
		findTF = var_12_16

		var_15(var_12_16(var_12_8, "got"), var_12_2)
	elseif var_12_2 then
		setActive = var_15
		findTF = var_12_16

		var_15(var_12_16(var_12_8, "got"), true)
	elseif var_12_0 <= var_12_1 then
		setActive = var_15
		findTF = var_12_16

		var_15(var_12_16(var_12_8, "get"), true)

		onButton = var_15
		var_12_16 = arg_12_0
		findTF = var_12_17
		var_12_17 = var_12_17(var_12_8, "get")

		local function var_12_18()
			local var_14_0 = arg_12_0.taskProxy

			if var_0.getTaskById(var_14_0, arg_12_3.id) then
				local var_14_1 = arg_12_0
				local var_14_2 = var_1.emit

				ActivityMediator = var_2_10004

				var_14_2(var_14_1, var_2_10004.ON_TASK_SUBMIT, var_0)
			end

			return
		end

		SFX_CONFIRM = var_20

		var_15(var_12_16, var_12_17, var_12_18, var_20)
	else
		setActive = var_15
		findTF = var_12_16

		var_15(var_12_16(var_12_8, "go"), true)

		onButton = var_15
		var_12_16 = arg_12_0
		findTF = var_12_17
		var_12_17 = var_12_17(var_12_8, "go")

		local function var_12_19()
			local var_15_0 = arg_12_0.taskProxy

			if var_0.getTaskById(var_15_0, arg_12_3.id) then
				local var_15_1 = arg_12_0
				local var_15_2 = var_1.emit

				ActivityMediator = var_2_10004

				var_15_2(var_15_1, var_2_10004.ON_TASK_GO, var_0)
			end

			return
		end

		SFX_CONFIRM = var_20

		var_15(var_12_16, var_12_17, var_12_19, var_20)
	end

	if var_12_7 or not var_12_3 or var_12_2 and var_12_3 then
		setActive = var_15
		findTF = var_12_16

		var_15(var_12_16(var_12_8, "show"), false)
	else
		setActive = var_15
		findTF = var_12_16

		var_15(var_12_16(var_12_8, "show"), true)

		setActive = var_15
		findTF = var_17

		var_15(var_17(var_12_8, "show/on"), var_12_6)

		setActive = var_15
		findTF = var_17

		var_15(var_17(var_12_8, "show/off"), not var_12_6)
	end

	if var_12_3 then
		onButton = var_15

		local var_12_20 = arg_12_0

		findTF = var_12_17

		local var_12_21 = var_12_17(var_12_8, "show")

		local function var_12_22()
			local var_16_0 = arg_12_0

			var_0.changeGroupOpening(var_16_0, arg_12_4)

			return
		end

		SFX_CONFIRM = var_20

		var_15(var_12_20, var_12_21, var_12_22, var_20)
	end

	setActive = var_15

	var_15(arg_12_3.tf, true)

	local var_12_23 = arg_12_3.tf

	var_15.SetSiblingIndex(var_12_23, arg_12_2)

	return
end

function var_0_1.changeGroupOpening(arg_17_0, arg_17_1)
	arg_17_1.opening = not arg_17_1.opening

	for iter_17_0 = 1, #arg_17_1.tasks do
		local var_17_0 = arg_17_1.tasks[iter_17_0]

		if iter_17_0 == 1 then
			var_17_0.show = true
		else
			var_17_0.show = arg_17_1.opening
		end

		if not var_17_0.show and var_17_0.tf then
			setActive = var_7

			var_7(var_17_0.tf, false)

			table = var_7

			var_7.insert(arg_17_0.taskTplPool, var_17_0.tf)

			var_17_0.tf = nil
		end
	end

	arg_17_0.scrollToGroup = arg_17_1

	arg_17_0:updateTaskUI()

	return
end

function var_0_1.getTaskTfFromPool(arg_18_0)
	local var_18_0 = #arg_18_0.taskTplPool

	if 0 < var_18_0 then
		table = var_18_0

		return var_18_0.remove(arg_18_0.taskTplPool, 1)
	end

	tf = var_18_0
	Instantiate = var_1_10003

	local var_18_1 = var_18_0(var_1_10003(arg_18_0.missionTpl))

	SetParent = var_2

	var_2(var_18_1, arg_18_0.missionContainer)

	return var_18_1
end

function var_0_1.getTaskGroup(arg_19_0, arg_19_1, arg_19_2)
	for iter_19_0 = 1, #arg_19_0.taskGroups do
		if arg_19_0.taskGroups[iter_19_0].type == arg_19_1 and var_7.subType == arg_19_2 then
			return var_7
		end
	end

	local var_19_0 = {
		progress = 0,
		opening = false,
		type = arg_19_1,
		subType = arg_19_2,
		tasks = {}
	}

	table = var_4

	var_4.insert(arg_19_0.taskGroups, var_19_0)

	return var_19_0
end

function var_0_1.insertTaskToGroup(arg_20_0, arg_20_1, arg_20_2, arg_20_3)
	local var_20_0 = arg_20_3.tasks

	for iter_20_0 = 1, #var_20_0 do
		if var_20_0[iter_20_0].id == arg_20_1 then
			return
		end
	end

	local var_20_1 = arg_20_2.target_num
	local var_20_2 = arg_20_2.desc
	local var_20_3 = {
		type = arg_20_2.award_display[1][1],
		id = arg_20_2.award_display[1][2],
		count = arg_20_2.award_display[1][3]
	}
	local var_20_4 = false

	if #arg_20_3.tasks == 0 then
		var_20_4 = true
	end

	local var_20_5 = arg_20_0.taskProxy
	local var_20_6 = var_9.getFinishTaskById(var_20_5, arg_20_1) and 1 or 0
	local var_20_7 = arg_20_0.taskProxy
	local var_20_8 = var_10.getTaskById(var_20_7, arg_20_1)
	local var_20_9 = 0

	if var_20_8 then
		if var_20_8:getProgress() ~= 0 or not arg_20_3.progress then
			var_20_7 = var_20_9
		end

		arg_20_3.progress = var_20_7
	else
		var_20_9 = arg_20_3.progress
	end

	table = var_20_7

	var_20_7.insert(arg_20_3.tasks, {
		id = arg_20_1,
		targetNum = var_20_1,
		show = var_20_4,
		finish = var_20_6,
		progress = var_20_9,
		desc = var_20_2,
		drop = var_20_3
	})

	return
end

function var_0_1.sortTaskGroups(arg_21_0)
	ipairs = var_1_10001

	for iter_21_0, iter_21_1 in var_1_10001(arg_21_0.taskGroups) do
		table = var_1_10006

		var_1_10006.sort(iter_21_1.tasks, function(arg_22_0, arg_22_1)
			if arg_22_0.finish ~= arg_22_1.finish then
				return arg_22_0.finish < arg_22_1.finish
			end

			return arg_22_0.targetNum < arg_22_1.targetNum
		end)
	end

	table = var_1

	var_1.sort(arg_21_0.taskGroups, function(arg_23_0, arg_23_1)
		local var_23_0 = arg_23_0.tasks
		local var_23_1 = arg_23_1.tasks
		local var_23_2 = 0
		local var_23_3 = arg_23_0.tasks[1].id
		local var_23_4 = 0
		local var_23_5 = 0
		local var_23_6 = 0
		local var_23_7 = arg_23_1.tasks[1].id
		local var_23_8 = 0
		local var_23_9 = 0

		ipairs = var_2_10012

		for iter_23_0, iter_23_1 in var_2_10012(var_23_0) do
			if var_23_2 == 0 and iter_23_1.finish == 0 and iter_23_1.progress >= iter_23_1.targetNum then
				var_23_2 = 1
				var_23_3 = iter_23_1.id
			end

			var_23_4 = iter_23_1.finish == 1 and var_23_4 + 1 or var_23_4
		end

		local var_23_10 = var_23_4 == #var_23_0 and 1 or 0

		ipairs = var_12

		for iter_23_2, iter_23_3 in var_12(var_23_1) do
			if var_23_6 == 0 and iter_23_3.finish == 0 and iter_23_3.progress >= iter_23_3.targetNum then
				var_23_6 = 1
				var_23_7 = iter_23_3.id
			end

			var_23_8 = iter_23_3.finish == 1 and var_23_8 + 1 or var_23_8
		end

		local var_23_11 = var_23_8 == #var_23_1 and 1 or 0

		if var_23_2 ~= var_23_6 then
			return var_23_6 < var_23_2
		elseif var_23_10 ~= var_23_11 then
			return var_23_10 < var_23_11
		else
			return var_23_3 < var_23_7
		end

		return
	end)

	ipairs = var_1

	for iter_21_2, iter_21_3 in var_1(arg_21_0.taskGroups) do
		local var_21_0 = iter_21_3.opening
		local var_21_1 = iter_21_3.tasks

		for iter_21_4 = 1, #var_21_1 do
			local var_21_2 = var_21_1[iter_21_4]

			if iter_21_4 == 1 then
				var_21_2.show = true
			elseif var_21_0 then
				var_21_2.show = true
			else
				var_21_2.show = false
			end
		end
	end

	return
end

function var_0_1.OnDestroy(arg_24_0)
	LeanTween = var_1_10001

	local var_24_0 = var_1_10001.isTweening

	go = var_1_10003

	if var_24_0(var_1_10003(arg_24_0.slider)) then
		LeanTween = var_1

		local var_24_1 = var_1.cancel

		go = var_3

		var_24_1(var_3(arg_24_0.slider))
	end

	return
end

return var_0_1
