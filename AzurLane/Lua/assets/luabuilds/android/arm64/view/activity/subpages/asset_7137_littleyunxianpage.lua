class = var_0_10000

local var_0_0 = "LittleYunXianPage"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".TemplatePage.PtTemplatePage"))

function var_0_1.OnInit(arg_1_0)
	var_0_1.super.OnInit(arg_1_0)

	local var_1_0 = arg_1_0.bg

	arg_1_0.adPhase1 = var_1.Find(var_1_0, "PHASE1")

	local var_1_1 = arg_1_0.bg

	arg_1_0.adPhase2 = var_1.Find(var_1_1, "PHASE2")

	local var_1_2 = arg_1_0.bg

	arg_1_0.helpBtn = var_1.Find(var_1_2, "help_btn")
	onButton = var_1

	local var_1_3 = arg_1_0
	local var_1_4 = arg_1_0.helpBtn

	local function var_1_5()
		pg = var_2_10000

		local var_2_0 = var_2_10000.MsgboxMgr.GetInstance()
		local var_2_1 = var_0.ShowMsgBox
		local var_2_2 = {}

		MSGBOX_TYPE_HELP = var_2_10004
		var_2_2.type = var_2_10004

		local var_2_3 = arg_1_0

		var_2_2.helps = var_4.GetHelpTip(var_2_3)

		var_2_1(var_2_0, var_2_2)

		return
	end

	SFX_PANEL = var_1_10006

	var_1(var_1_3, var_1_4, var_1_5, var_1_10006)

	return
end

function var_0_1.GetHelpTip(arg_3_0)
	pg = var_1_10001

	return var_1_10001.gametip.littleyunxian_npc.tip
end

function var_0_1.OnUpdateFlush(arg_4_0)
	var_0_1.super.OnUpdateFlush(arg_4_0)

	setText = var_1

	local var_4_0 = arg_4_0.adPhase1

	i18n = var_1_10004

	var_1(var_4_0, var_1_10004("littleyunxian_tip1"))

	setText = var_1

	local var_4_1 = arg_4_0.adPhase2

	i18n = var_4

	var_1(var_4_1, var_4("littleyunxian_tip2"))

	setActive = var_1

	var_1(arg_4_0.battleBtn, false)

	local var_4_2 = arg_4_0.ptData
	local var_4_3, var_4_4, var_4_5 = var_1.GetLevelProgress(var_4_2)
	local var_4_6 = arg_4_0.ptData
	local var_4_7, var_4_8, var_4_9 = var_4.GetResProgress(var_4_6)

	setText = var_1_10007

	local var_4_10 = arg_4_0.step

	setColorStr = var_1_10010

	local var_4_11 = var_1_10010(var_4_3, "#b9aef8")
	local var_4_12 = " / "

	setColorStr = var_12

	var_1_10007(var_4_10, var_4_11 .. var_4_12 .. var_12(var_4_4, "#666176"))

	setText = var_1_10007

	local var_4_13 = arg_4_0.progress

	if 1 <= var_4_9 then
		setColorStr = var_4_15

		local var_4_14 = var_4_7

		COLOR_GREEN = var_13

		local var_4_15

		if not var_4_15(var_4_14, var_13) then
			setColorStr = var_4_15
			var_4_15 = var_4_15(var_4_7, "#b9aef8")
		end

		local var_4_16 = "/"

		setColorStr = var_4_14

		var_1_10007(var_4_13, var_4_15 .. var_4_16 .. var_4_14(var_4_8, "#666176"))

		local var_4_17

		if arg_4_0.firstSliderInit then
			LeanTween = var_4_17
			var_4_17 = var_4_17.isTweening
			go = var_4_13

			if var_4_17(var_4_13(arg_4_0.slider)) then
				LeanTween = var_4_17
				var_4_17 = var_4_17.cancel
				go = var_9

				var_4_17(var_9(arg_4_0.slider))
			end

			GetComponent = var_4_17

			local var_4_18 = arg_4_0.slider

			typeof = var_10
			Slider = var_12
			var_4_17 = var_4_17(var_4_18, var_10(var_12)).value
			var_4_17 = arg_4_0.l1 ~= var_4_3 and 0 or arg_4_0.sliderValue
			LeanTween = var_8

			local var_4_19 = var_8.value

			go = var_10

			local var_4_20 = var_4_19(var_10(arg_4_0.slider), var_4_17, var_4_9, 1)
			local var_4_21 = var_8.setOnUpdate

			System = var_11

			var_4_21(var_4_20, var_11.Action_float(function(arg_5_0)
				setSlider = var_2_10001

				var_2_10001(arg_4_0.slider, 0, 1, arg_5_0)

				arg_4_0.sliderValue = arg_5_0

				return
			end))
		else
			setSlider = var_4_17

			var_4_17(arg_4_0.slider, 0, 1, var_4_9)

			arg_4_0.firstSliderInit = true
			arg_4_0.sliderValue = var_4_9
		end

		arg_4_0.l1 = var_4_3

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

		local var_8_3 = {
			type = 5,
			blur = true,
			dropList = arg_7_0.ptData.dropList,
			targets = arg_7_0.ptData.targets,
			level = arg_7_0.ptData.level,
			count = arg_7_0.ptData.count,
			resId = arg_7_0.ptData.resId
		}

		Drop = var_6

		local var_8_4 = var_6.New
		local var_8_5 = {}

		DROP_TYPE_RESOURCE = var_2_10009
		var_8_5.type = var_2_10009
		var_8_5.id = arg_7_0.ptData.resId

		local var_8_6 = var_8_4(var_8_5)

		var_8_3.resIcon = var_6.getIcon(var_8_6)

		var_8_1(var_8_0, var_8_2, var_2_10004, var_8_3)

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

	if var_12_2 then
		setActive = var_1_10015
		findTF = var_17

		var_1_10015(var_17(var_12_8, "pahase"), false)

		setSlider = var_1_10015
		findTF = var_17

		var_1_10015(var_17(var_12_8, "slider"), 0, 1, 1)
	else
		setActive = var_1_10015
		findTF = var_17

		var_1_10015(var_17(var_12_8, "pahase"), true)

		setSlider = var_1_10015
		findTF = var_17

		var_1_10015(var_17(var_12_8, "slider"), 0, 1, var_12_1 / var_12_0)
	end

	setText = var_1_10015
	findTF = var_17

	var_1_10015(var_17(var_12_8, "desc"), var_12_4)

	local var_12_9

	if arg_12_4.subType ~= 33 then
		setText = var_15
		findTF = var_12_9
		var_12_9 = var_12_9(var_12_8, "pahase")
		setColorStr = var_18

		local var_12_10 = var_18(var_12_1, "#b1a2d3")
		local var_12_11 = "/"

		setColorStr = var_20

		var_15(var_12_9, var_12_10 .. var_12_11 .. var_20(var_12_0, "#b1a2d3"))
	else
		setText = var_15
		findTF = var_12_9

		var_15(var_12_9(var_12_8, "pahase"), "")
	end

	updateDrop = var_15
	findTF = var_12_9

	var_15(var_12_9(var_12_8, "award"), var_12_5)

	onButton = var_15

	local var_12_12 = arg_12_0

	findTF = var_18

	local var_12_13 = var_18(var_12_8, "award")

	local function var_12_14()
		local var_13_0 = arg_12_0
		local var_13_1 = var_0.emit

		BaseUI = var_2_10003

		var_13_1(var_13_0, var_2_10003.ON_DROP, var_12_5)

		return
	end

	SFX_PANEL = var_20

	var_15(var_12_12, var_12_13, var_12_14, var_20)

	setActive = var_15
	findTF = var_12_12

	var_15(var_12_12(var_12_8, "got"), false)

	setActive = var_15
	findTF = var_17

	var_15(var_17(var_12_8, "get"), false)

	setActive = var_15
	findTF = var_17

	var_15(var_17(var_12_8, "go"), false)

	local var_12_15, var_12_16

	if not var_12_3 then
		setActive = var_15
		findTF = var_12_15

		var_15(var_12_15(var_12_8, "go"), not var_12_2)

		onButton = var_15
		var_12_15 = arg_12_0
		findTF = var_12_16
		var_12_16 = var_12_16(var_12_8, "go")

		local function var_12_17()
			local var_14_0 = arg_12_0.taskProxy
			local var_14_1

			if not var_0.getTaskById(var_14_0, arg_12_3.id) then
				Task = var_14_1
				var_14_1 = var_14_1.New({
					id = arg_12_3.id
				})
			end

			if var_14_1 then
				local var_14_2 = arg_12_0
				local var_14_3 = var_1.emit

				ActivityMediator = var_2_10004

				var_14_3(var_14_2, var_2_10004.ON_TASK_GO, var_14_1)
			end

			return
		end

		SFX_CONFIRM = var_20

		var_15(var_12_15, var_12_16, var_12_17, var_20)

		setActive = var_15
		findTF = var_12_15

		var_15(var_12_15(var_12_8, "got"), var_12_2)
	elseif var_12_2 then
		setActive = var_15
		findTF = var_12_15

		var_15(var_12_15(var_12_8, "got"), true)
	elseif var_12_0 <= var_12_1 then
		setActive = var_15
		findTF = var_12_15

		var_15(var_12_15(var_12_8, "get"), true)

		onButton = var_15
		var_12_15 = arg_12_0
		findTF = var_12_16
		var_12_16 = var_12_16(var_12_8, "get")

		local function var_12_18()
			local var_15_0 = arg_12_0.taskProxy

			if var_0.getTaskById(var_15_0, arg_12_3.id) then
				local var_15_1 = arg_12_0
				local var_15_2 = var_1.emit

				ActivityMediator = var_2_10004

				var_15_2(var_15_1, var_2_10004.ON_TASK_SUBMIT, var_0)
			end

			return
		end

		SFX_CONFIRM = var_20

		var_15(var_12_15, var_12_16, var_12_18, var_20)
	else
		setActive = var_15
		findTF = var_12_15

		var_15(var_12_15(var_12_8, "go"), true)

		onButton = var_15
		var_12_15 = arg_12_0
		findTF = var_12_16
		var_12_16 = var_12_16(var_12_8, "go")

		local function var_12_19()
			local var_16_0 = arg_12_0.taskProxy
			local var_16_1

			if not var_0.getTaskById(var_16_0, arg_12_3.id) then
				Task = var_16_1
				var_16_1 = var_16_1.New({
					id = arg_12_3.id
				})
			end

			if var_16_1 then
				local var_16_2 = arg_12_0
				local var_16_3 = var_1.emit

				ActivityMediator = var_2_10004

				var_16_3(var_16_2, var_2_10004.ON_TASK_GO, var_16_1)
			end

			return
		end

		SFX_CONFIRM = var_20

		var_15(var_12_15, var_12_16, var_12_19, var_20)
	end

	if var_12_7 or not var_12_3 or var_12_2 and var_12_3 then
		setActive = var_15
		findTF = var_12_15

		var_15(var_12_15(var_12_8, "show"), false)
	else
		setActive = var_15
		findTF = var_12_15

		var_15(var_12_15(var_12_8, "show"), true)

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

		findTF = var_12_16

		local var_12_21 = var_12_16(var_12_8, "show")

		local function var_12_22()
			local var_17_0 = arg_12_0

			var_0.changeGroupOpening(var_17_0, arg_12_4)

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

function var_0_1.changeGroupOpening(arg_18_0, arg_18_1)
	arg_18_1.opening = not arg_18_1.opening

	for iter_18_0 = 1, #arg_18_1.tasks do
		local var_18_0 = arg_18_1.tasks[iter_18_0]

		if iter_18_0 == 1 then
			var_18_0.show = true
		else
			var_18_0.show = arg_18_1.opening
		end

		if not var_18_0.show and var_18_0.tf then
			setActive = var_7

			var_7(var_18_0.tf, false)

			table = var_7

			var_7.insert(arg_18_0.taskTplPool, var_18_0.tf)

			var_18_0.tf = nil
		end
	end

	arg_18_0.scrollToGroup = arg_18_1

	arg_18_0:updateTaskUI()

	return
end

function var_0_1.getTaskTfFromPool(arg_19_0)
	local var_19_0 = #arg_19_0.taskTplPool

	if 0 < var_19_0 then
		table = var_19_0

		return var_19_0.remove(arg_19_0.taskTplPool, 1)
	end

	tf = var_19_0
	Instantiate = var_1_10003

	local var_19_1 = var_19_0(var_1_10003(arg_19_0.missionTpl))

	SetParent = var_2

	var_2(var_19_1, arg_19_0.missionContainer)

	return var_19_1
end

function var_0_1.getTaskGroup(arg_20_0, arg_20_1, arg_20_2)
	for iter_20_0 = 1, #arg_20_0.taskGroups do
		if arg_20_0.taskGroups[iter_20_0].type == arg_20_1 and var_7.subType == arg_20_2 then
			return var_7
		end
	end

	local var_20_0 = {
		progress = 0,
		opening = false,
		type = arg_20_1,
		subType = arg_20_2,
		tasks = {}
	}

	table = var_4

	var_4.insert(arg_20_0.taskGroups, var_20_0)

	return var_20_0
end

function var_0_1.insertTaskToGroup(arg_21_0, arg_21_1, arg_21_2, arg_21_3)
	local var_21_0 = arg_21_3.tasks

	for iter_21_0 = 1, #var_21_0 do
		if var_21_0[iter_21_0].id == arg_21_1 then
			return
		end
	end

	local var_21_1 = arg_21_2.target_num
	local var_21_2 = arg_21_2.desc
	local var_21_3 = {
		type = arg_21_2.award_display[1][1],
		id = arg_21_2.award_display[1][2],
		count = arg_21_2.award_display[1][3]
	}
	local var_21_4 = false

	if #arg_21_3.tasks == 0 then
		var_21_4 = true
	end

	local var_21_5 = arg_21_0.taskProxy
	local var_21_6 = var_9.getFinishTaskById(var_21_5, arg_21_1) and 1 or 0
	local var_21_7 = arg_21_0.taskProxy
	local var_21_8 = var_10.getTaskById(var_21_7, arg_21_1)
	local var_21_9 = 0

	if var_21_8 then
		if var_21_8:getProgress() ~= 0 or not arg_21_3.progress then
			var_21_7 = var_21_9
		end

		arg_21_3.progress = var_21_7
	else
		var_21_9 = arg_21_3.progress
	end

	table = var_21_7

	var_21_7.insert(arg_21_3.tasks, {
		id = arg_21_1,
		targetNum = var_21_1,
		show = var_21_4,
		finish = var_21_6,
		progress = var_21_9,
		desc = var_21_2,
		drop = var_21_3
	})

	return
end

function var_0_1.sortTaskGroups(arg_22_0)
	ipairs = var_1_10001

	for iter_22_0, iter_22_1 in var_1_10001(arg_22_0.taskGroups) do
		table = var_1_10006

		var_1_10006.sort(iter_22_1.tasks, function(arg_23_0, arg_23_1)
			if arg_23_0.finish ~= arg_23_1.finish then
				return arg_23_0.finish < arg_23_1.finish
			end

			return arg_23_0.targetNum < arg_23_1.targetNum
		end)
	end

	table = var_1

	var_1.sort(arg_22_0.taskGroups, function(arg_24_0, arg_24_1)
		local var_24_0 = arg_24_0.tasks
		local var_24_1 = arg_24_1.tasks
		local var_24_2 = 0
		local var_24_3 = arg_24_0.tasks[1].id
		local var_24_4 = 0
		local var_24_5 = 0
		local var_24_6 = 0
		local var_24_7 = arg_24_1.tasks[1].id
		local var_24_8 = 0
		local var_24_9 = 0

		ipairs = var_2_10012

		for iter_24_0, iter_24_1 in var_2_10012(var_24_0) do
			if var_24_2 == 0 and iter_24_1.finish == 0 and iter_24_1.progress >= iter_24_1.targetNum then
				var_24_2 = 1
				var_24_3 = iter_24_1.id
			end

			var_24_4 = iter_24_1.finish == 1 and var_24_4 + 1 or var_24_4
		end

		local var_24_10 = var_24_4 == #var_24_0 and 1 or 0

		ipairs = var_12

		for iter_24_2, iter_24_3 in var_12(var_24_1) do
			if var_24_6 == 0 and iter_24_3.finish == 0 and iter_24_3.progress >= iter_24_3.targetNum then
				var_24_6 = 1
				var_24_7 = iter_24_3.id
			end

			var_24_8 = iter_24_3.finish == 1 and var_24_8 + 1 or var_24_8
		end

		local var_24_11 = var_24_8 == #var_24_1 and 1 or 0

		if var_24_2 ~= var_24_6 then
			return var_24_6 < var_24_2
		elseif var_24_10 ~= var_24_11 then
			return var_24_10 < var_24_11
		else
			return var_24_3 < var_24_7
		end

		return
	end)

	ipairs = var_1

	for iter_22_2, iter_22_3 in var_1(arg_22_0.taskGroups) do
		local var_22_0 = iter_22_3.opening
		local var_22_1 = iter_22_3.tasks

		for iter_22_4 = 1, #var_22_1 do
			local var_22_2 = var_22_1[iter_22_4]

			if iter_22_4 == 1 then
				var_22_2.show = true
			elseif var_22_0 then
				var_22_2.show = true
			else
				var_22_2.show = false
			end
		end
	end

	return
end

function var_0_1.OnDestroy(arg_25_0)
	LeanTween = var_1_10001

	local var_25_0 = var_1_10001.isTweening

	go = var_1_10003

	if var_25_0(var_1_10003(arg_25_0.slider)) then
		LeanTween = var_1

		local var_25_1 = var_1.cancel

		go = var_3

		var_25_1(var_3(arg_25_0.slider))
	end

	return
end

return var_0_1
