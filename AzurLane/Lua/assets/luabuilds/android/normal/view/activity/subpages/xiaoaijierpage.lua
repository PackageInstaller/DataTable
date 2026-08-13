class = var_0_10000

local var_0_0 = "XiaoAiJiErPage"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".TemplatePage.PtTemplatePage"))

function var_0_1.OnInit(arg_1_0)
	var_0_1.super.OnInit(arg_1_0)

	local var_1_0 = arg_1_0.bg

	arg_1_0.helpBtn = var_1.Find(var_1_0, "help_btn")
	onButton = var_1

	local var_1_1 = arg_1_0
	local var_1_2 = arg_1_0.helpBtn

	local function var_1_3()
		pg = var_2_10000

		local var_2_0 = var_2_10000.MsgboxMgr.GetInstance()
		local var_2_1 = var_0.ShowMsgBox
		local var_2_2 = {}

		MSGBOX_TYPE_HELP = var_2_10003
		var_2_2.type = var_2_10003
		pg = var_2_10003
		var_2_2.helps = var_2_10003.gametip.littleaijier_npc.tip

		var_2_1(var_2_0, var_2_2)

		return
	end

	SFX_PANEL = var_1_10005

	var_1(var_1_1, var_1_2, var_1_3, var_1_10005)

	return
end

function var_0_1.OnUpdateFlush(arg_3_0)
	var_0_1.super.OnUpdateFlush(arg_3_0)

	local var_3_0 = arg_3_0.ptData
	local var_3_1, var_3_2, var_3_3 = var_1.GetLevelProgress(var_3_0)
	local var_3_4 = arg_3_0.ptData
	local var_3_5, var_3_6, var_3_7 = var_4.GetResProgress(var_3_4)

	setText = var_1_10007

	local var_3_8 = arg_3_0.step

	setColorStr = var_1_10009

	var_1_10007(var_3_8, var_1_10009(var_3_1, "#f0d1c6") .. " / " .. var_3_2)

	setText = var_1_10007

	local var_3_9 = arg_3_0.progress

	if 1 <= var_3_7 then
		setColorStr = var_3_11

		local var_3_10 = var_3_5

		COLOR_GREEN = var_11

		local var_3_11

		if not var_3_11(var_3_10, var_11) then
			setColorStr = var_3_11
			var_3_11 = var_3_11(var_3_5, "#f0d1c6")
		end

		var_1_10007(var_3_9, var_3_11 .. "/" .. var_3_6)

		local var_3_12

		if arg_3_0.firstSliderInit then
			LeanTween = var_3_12
			var_3_12 = var_3_12.isTweening
			go = var_3_9

			if var_3_12(var_3_9(arg_3_0.slider)) then
				LeanTween = var_3_12
				var_3_12 = var_3_12.cancel
				go = var_8

				var_3_12(var_8(arg_3_0.slider))
			end

			GetComponent = var_3_12

			local var_3_13 = arg_3_0.slider

			typeof = var_9
			Slider = var_10
			var_3_12 = var_3_12(var_3_13, var_9(var_10)).value
			var_3_12 = arg_3_0.l1 ~= var_3_1 and 0 or arg_3_0.sliderValue
			LeanTween = var_8

			local var_3_14 = var_8.value

			go = var_9

			local var_3_15 = var_3_14(var_9(arg_3_0.slider), var_3_12, var_3_7, 1)
			local var_3_16 = var_8.setOnUpdate

			System = var_10

			var_3_16(var_3_15, var_10.Action_float(function(arg_4_0)
				setSlider = var_2_10001

				var_2_10001(arg_3_0.slider, 0, 1, arg_4_0)

				arg_3_0.sliderValue = arg_4_0

				return
			end))
		else
			setSlider = var_3_12

			var_3_12(arg_3_0.slider, 0, 1, var_3_7)

			arg_3_0.firstSliderInit = true
			arg_3_0.sliderValue = var_3_7
		end

		arg_3_0.l1 = var_3_1

		arg_3_0:updataTask()
		arg_3_0:sortTaskGroups()
		arg_3_0:updateTaskUI()

		return
	end
end

function var_0_1.updataTask(arg_5_0)
	ipairs = var_1_10001

	for iter_5_0, iter_5_1 in var_1_10001(arg_5_0.taskGroups) do
		ipairs = var_1_10006

		for iter_5_2, iter_5_3 in var_1_10006(iter_5_1.tasks) do
			local var_5_0 = arg_5_0.taskProxy
			local var_5_1 = var_11.getFinishTaskById(var_5_0, iter_5_3.id) and 1 or 0
			local var_5_2 = arg_5_0.taskProxy
			local var_5_3 = var_12.getTaskById(var_5_2, iter_5_3.id)
			local var_5_4 = 0

			if var_5_3 then
				local var_5_5

				if var_5_3:getProgress() ~= 0 or not iter_5_1.progress then
					var_5_5 = var_5_4
				end

				iter_5_1.progress = var_5_5
			else
				var_5_4 = iter_5_1.progress
			end

			iter_5_3.progress = var_5_4

			if iter_5_3.finish ~= var_5_1 and iter_5_3.tf then
				setActive = var_14

				var_14(iter_5_3.tf, false)

				table = var_14

				var_14.insert(arg_5_0.taskTplPool, iter_5_3.tf)

				iter_5_3.tf = nil
			end

			iter_5_3.finish = var_5_1
		end
	end

	return
end

function var_0_1.OnFirstFlush(arg_6_0)
	var_0_1.super.OnFirstFlush(arg_6_0)

	onButton = var_1

	local var_6_0 = arg_6_0
	local var_6_1 = arg_6_0.battleBtn

	local function var_6_2()
		local var_7_0 = arg_6_0
		local var_7_1 = var_0.emit

		ActivityMediator = var_2_10002

		local var_7_2 = var_2_10002.EVENT_GO_SCENE

		SCENE = var_2_10003

		var_7_1(var_7_0, var_7_2, var_2_10003.LEVEL)

		return
	end

	SFX_PANEL = var_1_10005

	var_1(var_6_0, var_6_1, var_6_2, var_1_10005)
	arg_6_0:initTask()
	arg_6_0:sortTaskGroups()
	arg_6_0:updateTaskUI()
	arg_6_0:tryClaimTaskReward()

	return
end

function var_0_1.tryClaimTaskReward(arg_8_0)
	local var_8_0 = {}

	for iter_8_0 = 1, #arg_8_0.taskGroups do
		local var_8_1 = arg_8_0.taskGroups[iter_8_0].tasks

		ipairs = var_1_10008

		for iter_8_1, iter_8_2 in var_1_10008(var_8_1) do
			local var_8_2 = iter_8_2.targetNum
			local var_8_3 = iter_8_2.progress
			local var_8_4 = iter_8_2.finish == 1

			if var_8_2 <= var_8_3 and not var_8_4 then
				local var_8_5 = arg_8_0.taskProxy

				if var_16.getTaskById(var_8_5, iter_8_2.id) then
					table = var_8_5

					var_8_5.insert(var_8_0, var_16)
				end
			end
		end
	end

	if #var_8_0 > 0 then
		local var_8_6 = arg_8_0
		local var_8_7 = arg_8_0.emit

		ActivityMediator = var_4

		var_8_7(var_8_6, var_4.ON_TASK_SUBMIT_ONESTEP, var_8_0)
	end

	return
end

function var_0_1.initTask(arg_9_0)
	findTF = var_1_10001
	arg_9_0.missionTpl = var_1_10001(arg_9_0.bg, "missionTpl")
	setActive = var_1

	var_1(arg_9_0.missionTpl, false)

	findTF = var_1
	arg_9_0.missionContainer = var_1(arg_9_0.bg, "mission/content")

	local var_9_0 = arg_9_0.activity
	local var_9_1 = var_1.getConfig(var_9_0, "config_client").task_act_id

	pg = var_9_0

	local var_9_2 = var_9_0.activity_template[var_9_1].config_data[1]

	getProxy = var_3
	TaskProxy = var_1_10004
	arg_9_0.taskProxy = var_3(var_1_10004)
	arg_9_0.taskTplPool = {}
	GetComponent = var_3
	findTF = var_1_10004

	local var_9_3 = var_1_10004(arg_9_0.bg, "mission")

	typeof = var_5
	ScrollRect = var_6
	arg_9_0.taskScroll = var_3(var_9_3, var_5(var_6))
	arg_9_0.taskGroups = {}

	for iter_9_0 = 1, #var_9_2 do
		local var_9_4 = var_9_2[iter_9_0]

		pg = var_1_10008

		local var_9_5 = var_1_10008.task_data_template[var_9_4].type
		local var_9_6 = var_1_10008.sub_type

		if var_9_5 == 26 then
			local var_9_7 = arg_9_0:getTaskGroup(var_9_5, var_9_6)

			arg_9_0:insertTaskToGroup(var_9_4, var_1_10008, var_9_7)
		end
	end

	return
end

function var_0_1.updateTaskUI(arg_10_0)
	local var_10_0 = 0

	for iter_10_0 = 1, #arg_10_0.taskGroups do
		local var_10_1 = arg_10_0.taskGroups[iter_10_0].tasks

		ipairs = var_1_10008

		for iter_10_1, iter_10_2 in var_1_10008(var_10_1) do
			arg_10_0:updateTaskList(iter_10_1, var_10_0, iter_10_2, var_6)

			var_10_0 = var_10_0 + 1
		end
	end

	local var_10_2 = 0
	local var_10_3 = 0

	if arg_10_0.scrollToGroup then
		ipairs = var_4

		for iter_10_3, iter_10_4 in var_4(arg_10_0.taskGroups) do
			if iter_10_4 == arg_10_0.scrollToGroup then
				var_10_3 = var_10_2
			end

			if iter_10_4.opening then
				var_10_2 = var_10_2 + #iter_10_4.tasks
			else
				var_10_2 = var_10_2 + 1
			end
		end

		arg_10_0.scrollToGroup = nil
	end

	if var_10_3 ~= 0 and var_10_2 ~= 0 then
		scrollTo = var_4

		var_4(arg_10_0.taskScroll, 0, 1 - var_10_3 / var_10_2)
	else
		scrollTo = var_4

		var_4(arg_10_0.taskScroll, 0, 1)
	end

	return
end

function var_0_1.updateTaskList(arg_11_0, arg_11_1, arg_11_2, arg_11_3, arg_11_4)
	if not arg_11_3.show then
		return
	end

	local var_11_0 = arg_11_3.targetNum
	local var_11_1 = arg_11_3.progress
	local var_11_2 = arg_11_3.finish == 1
	local var_11_3 = arg_11_1 == 1
	local var_11_4 = arg_11_3.desc
	local var_11_5 = arg_11_3.drop
	local var_11_6 = arg_11_4.opening
	local var_11_7 = #arg_11_4.tasks == 1

	if not arg_11_3.tf then
		arg_11_3.tf = arg_11_0:getTaskTfFromPool()
	end

	findTF = var_14

	local var_11_8 = var_14(arg_11_3.tf, "AD")

	if var_11_3 then
		setActive = var_15
		findTF = var_16

		var_15(var_16(var_11_8, "mask1"), var_11_2)
	else
		setActive = var_15
		findTF = var_16

		var_15(var_16(var_11_8, "mask2"), var_11_2)
	end

	if var_11_2 then
		setActive = var_15
		findTF = var_16

		var_15(var_16(var_11_8, "pahase"), false)

		setSlider = var_15
		findTF = var_16

		var_15(var_16(var_11_8, "slider"), 0, 1, 1)
	else
		setActive = var_15
		findTF = var_16

		var_15(var_16(var_11_8, "pahase"), true)

		setSlider = var_15
		findTF = var_16

		var_15(var_16(var_11_8, "slider"), 0, 1, var_11_1 / var_11_0)
	end

	setText = var_15
	findTF = var_16

	var_15(var_16(var_11_8, "desc"), var_11_4)

	local var_11_9

	if arg_11_4.subType ~= 33 then
		setText = var_15
		findTF = var_11_9
		var_11_9 = var_11_9(var_11_8, "pahase")
		setColorStr = var_17

		var_15(var_11_9, var_17(var_11_1, "#957b01") .. "/" .. var_11_0)
	else
		setText = var_15
		findTF = var_11_9

		var_15(var_11_9(var_11_8, "pahase"), "")
	end

	updateDrop = var_15
	findTF = var_11_9

	var_15(var_11_9(var_11_8, "award"), var_11_5)

	onButton = var_15

	local var_11_10 = arg_11_0

	findTF = var_17

	local var_11_11 = var_17(var_11_8, "award")

	local function var_11_12()
		local var_12_0 = arg_11_0
		local var_12_1 = var_0.emit

		BaseUI = var_2_10002

		var_12_1(var_12_0, var_2_10002.ON_DROP, var_11_5)

		return
	end

	SFX_PANEL = var_19

	var_15(var_11_10, var_11_11, var_11_12, var_19)

	setActive = var_15
	findTF = var_11_10

	var_15(var_11_10(var_11_8, "got"), false)

	setActive = var_15
	findTF = var_16

	var_15(var_16(var_11_8, "get"), false)

	setActive = var_15
	findTF = var_16

	var_15(var_16(var_11_8, "go"), false)

	local var_11_13, var_11_14

	if not var_11_3 then
		setActive = var_15
		findTF = var_11_13

		var_15(var_11_13(var_11_8, "go"), not var_11_2)

		setActive = var_15
		findTF = var_11_13

		var_15(var_11_13(var_11_8, "got"), var_11_2)
	elseif var_11_2 then
		setActive = var_15
		findTF = var_11_13

		var_15(var_11_13(var_11_8, "got"), true)
	elseif var_11_0 <= var_11_1 then
		setActive = var_15
		findTF = var_11_13

		var_15(var_11_13(var_11_8, "get"), true)

		onButton = var_15
		var_11_13 = arg_11_0
		findTF = var_11_14
		var_11_14 = var_11_14(var_11_8, "get")

		local function var_11_15()
			local var_13_0 = arg_11_0.taskProxy

			if var_0.getTaskById(var_13_0, arg_11_3.id) then
				local var_13_1 = arg_11_0
				local var_13_2 = var_1.emit

				ActivityMediator = var_2_10003

				var_13_2(var_13_1, var_2_10003.ON_TASK_SUBMIT, var_0)
			end

			return
		end

		SFX_CONFIRM = var_19

		var_15(var_11_13, var_11_14, var_11_15, var_19)
	else
		setActive = var_15
		findTF = var_11_13

		var_15(var_11_13(var_11_8, "go"), true)

		onButton = var_15
		var_11_13 = arg_11_0
		findTF = var_11_14
		var_11_14 = var_11_14(var_11_8, "go")

		local function var_11_16()
			local var_14_0 = arg_11_0.taskProxy

			if var_0.getTaskById(var_14_0, arg_11_3.id) then
				local var_14_1 = arg_11_0
				local var_14_2 = var_1.emit

				ActivityMediator = var_2_10003

				var_14_2(var_14_1, var_2_10003.ON_TASK_GO, var_0)
			end

			return
		end

		SFX_CONFIRM = var_19

		var_15(var_11_13, var_11_14, var_11_16, var_19)
	end

	if var_11_7 or not var_11_3 or var_11_2 and var_11_3 then
		setActive = var_15
		findTF = var_11_13

		var_15(var_11_13(var_11_8, "show"), false)
	else
		setActive = var_15
		findTF = var_11_13

		var_15(var_11_13(var_11_8, "show"), true)

		setActive = var_15
		findTF = var_16

		var_15(var_16(var_11_8, "show/on"), var_11_6)

		setActive = var_15
		findTF = var_16

		var_15(var_16(var_11_8, "show/off"), not var_11_6)
	end

	if var_11_3 then
		onButton = var_15

		local var_11_17 = arg_11_0

		findTF = var_11_14

		local var_11_18 = var_11_14(var_11_8, "show")

		local function var_11_19()
			local var_15_0 = arg_11_0

			var_0.changeGroupOpening(var_15_0, arg_11_4)

			return
		end

		SFX_CONFIRM = var_19

		var_15(var_11_17, var_11_18, var_11_19, var_19)
	end

	setActive = var_15

	var_15(arg_11_3.tf, true)

	local var_11_20 = arg_11_3.tf

	var_15.SetSiblingIndex(var_11_20, arg_11_2)

	return
end

function var_0_1.changeGroupOpening(arg_16_0, arg_16_1)
	arg_16_1.opening = not arg_16_1.opening

	for iter_16_0 = 1, #arg_16_1.tasks do
		local var_16_0 = arg_16_1.tasks[iter_16_0]

		if iter_16_0 == 1 then
			var_16_0.show = true
		else
			var_16_0.show = arg_16_1.opening
		end

		if not var_16_0.show and var_16_0.tf then
			setActive = var_7

			var_7(var_16_0.tf, false)

			table = var_7

			var_7.insert(arg_16_0.taskTplPool, var_16_0.tf)

			var_16_0.tf = nil
		end
	end

	arg_16_0.scrollToGroup = arg_16_1

	arg_16_0:updateTaskUI()

	return
end

function var_0_1.getTaskTfFromPool(arg_17_0)
	local var_17_0 = #arg_17_0.taskTplPool

	if 0 < var_17_0 then
		table = var_17_0

		return var_17_0.remove(arg_17_0.taskTplPool, 1)
	end

	tf = var_17_0
	Instantiate = var_2

	local var_17_1 = var_17_0(var_2(arg_17_0.missionTpl))

	SetParent = var_2

	var_2(var_17_1, arg_17_0.missionContainer)

	return var_17_1
end

function var_0_1.getTaskGroup(arg_18_0, arg_18_1, arg_18_2)
	for iter_18_0 = 1, #arg_18_0.taskGroups do
		if arg_18_0.taskGroups[iter_18_0].type == arg_18_1 and var_7.subType == arg_18_2 then
			return var_7
		end
	end

	local var_18_0 = {
		progress = 0,
		opening = false,
		type = arg_18_1,
		subType = arg_18_2,
		tasks = {}
	}

	table = var_4

	var_4.insert(arg_18_0.taskGroups, var_18_0)

	return var_18_0
end

function var_0_1.insertTaskToGroup(arg_19_0, arg_19_1, arg_19_2, arg_19_3)
	local var_19_0 = arg_19_3.tasks

	for iter_19_0 = 1, #var_19_0 do
		if var_19_0[iter_19_0].id == arg_19_1 then
			return
		end
	end

	local var_19_1 = arg_19_2.target_num
	local var_19_2 = arg_19_2.desc
	local var_19_3 = {
		type = arg_19_2.award_display[1][1],
		id = arg_19_2.award_display[1][2],
		count = arg_19_2.award_display[1][3]
	}
	local var_19_4 = false

	if #arg_19_3.tasks == 0 then
		var_19_4 = true
	end

	local var_19_5 = arg_19_0.taskProxy
	local var_19_6 = var_9.getFinishTaskById(var_19_5, arg_19_1) and 1 or 0
	local var_19_7 = arg_19_0.taskProxy
	local var_19_8 = var_10.getTaskById(var_19_7, arg_19_1)
	local var_19_9 = 0
	local var_19_10

	if var_19_8 then
		if var_19_8:getProgress() ~= 0 or not arg_19_3.progress then
			var_19_10 = var_19_9
		end

		arg_19_3.progress = var_19_10
	else
		var_19_9 = arg_19_3.progress
	end

	table = var_19_10

	var_19_10.insert(arg_19_3.tasks, {
		id = arg_19_1,
		targetNum = var_19_1,
		show = var_19_4,
		finish = var_19_6,
		progress = var_19_9,
		desc = var_19_2,
		drop = var_19_3
	})

	return
end

function var_0_1.sortTaskGroups(arg_20_0)
	ipairs = var_1_10001

	for iter_20_0, iter_20_1 in var_1_10001(arg_20_0.taskGroups) do
		table = var_1_10006

		var_1_10006.sort(iter_20_1.tasks, function(arg_21_0, arg_21_1)
			if arg_21_0.finish ~= arg_21_1.finish then
				return arg_21_0.finish < arg_21_1.finish
			end

			return arg_21_0.targetNum < arg_21_1.targetNum
		end)
	end

	table = var_1

	var_1.sort(arg_20_0.taskGroups, function(arg_22_0, arg_22_1)
		local var_22_0 = arg_22_0.tasks
		local var_22_1 = arg_22_1.tasks
		local var_22_2 = 0
		local var_22_3 = arg_22_0.tasks[1].id
		local var_22_4 = 0
		local var_22_5 = 0
		local var_22_6 = 0
		local var_22_7 = arg_22_1.tasks[1].id
		local var_22_8 = 0
		local var_22_9 = 0

		ipairs = var_2_10012

		for iter_22_0, iter_22_1 in var_2_10012(var_22_0) do
			if var_22_2 == 0 and iter_22_1.finish == 0 and iter_22_1.progress >= iter_22_1.targetNum then
				var_22_2 = 1
				var_22_3 = iter_22_1.id
			end

			var_22_4 = iter_22_1.finish == 1 and var_22_4 + 1 or var_22_4
		end

		local var_22_10 = var_22_4 == #var_22_0 and 1 or 0

		ipairs = var_12

		for iter_22_2, iter_22_3 in var_12(var_22_1) do
			if var_22_6 == 0 and iter_22_3.finish == 0 and iter_22_3.progress >= iter_22_3.targetNum then
				var_22_6 = 1
				var_22_7 = iter_22_3.id
			end

			var_22_8 = iter_22_3.finish == 1 and var_22_8 + 1 or var_22_8
		end

		local var_22_11 = var_22_8 == #var_22_1 and 1 or 0

		if var_22_2 ~= var_22_6 then
			return var_22_6 < var_22_2
		elseif var_22_10 ~= var_22_11 then
			return var_22_10 < var_22_11
		else
			return var_22_3 < var_22_7
		end

		return
	end)

	ipairs = var_1

	for iter_20_2, iter_20_3 in var_1(arg_20_0.taskGroups) do
		local var_20_0 = iter_20_3.opening
		local var_20_1 = iter_20_3.tasks

		for iter_20_4 = 1, #var_20_1 do
			local var_20_2 = var_20_1[iter_20_4]

			if iter_20_4 == 1 then
				var_20_2.show = true
			elseif var_20_0 then
				var_20_2.show = true
			else
				var_20_2.show = false
			end
		end
	end

	return
end

function var_0_1.OnDestroy(arg_23_0)
	LeanTween = var_1_10001

	local var_23_0 = var_1_10001.isTweening

	go = var_1_10002

	if var_23_0(var_1_10002(arg_23_0.slider)) then
		LeanTween = var_1

		local var_23_1 = var_1.cancel

		go = var_2

		var_23_1(var_2(arg_23_0.slider))
	end

	return
end

return var_0_1
