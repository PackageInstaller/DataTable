local var_0_0 = class("LittleChaijunPage", import(".TemplatePage.PtTemplatePage"))

function var_0_0.OnInit(arg_1_0)
	var_0_0.super.OnInit(arg_1_0)

	arg_1_0.helpBtn = arg_1_0.bg:Find("help_btn")

	onButton(arg_1_0, arg_1_0.helpBtn, function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = pg.gametip.littleChaijun_npc.tip
		})

		return
	end, SFX_PANEL)

	return
end

function var_0_0.OnUpdateFlush(arg_3_0)
	var_0_0.super.OnUpdateFlush(arg_3_0)

	local var_3_0, var_3_1, var_3_2 = arg_3_0.ptData:GetLevelProgress()
	local var_3_3, var_3_4, var_3_5 = arg_3_0.ptData:GetResProgress()

	setText(arg_3_0.step, setColorStr(var_3_0, "ebced8") .. " / " .. var_3_1)

	local var_3_6 = var_3_5 >= 1 and setColorStr(var_3_3, COLOR_GREEN) or setColorStr(var_3_3, "ebced8")

	setText(arg_3_0.progress, var_3_6 .. "/" .. var_3_4)

	if arg_3_0.firstSliderInit then
		if LeanTween.isTweening(go(arg_3_0.slider)) then
			LeanTween.cancel(go(arg_3_0.slider))
		end

		local var_3_7 = GetComponent(arg_3_0.slider, typeof(Slider)).value

		LeanTween.value(go(arg_3_0.slider), arg_3_0.l1 ~= var_3_0 and 0 or arg_3_0.sliderValue, var_3_5, 1):setOnUpdate(System.Action_float(function(arg_4_0)
			setSlider(arg_3_0.slider, 0, 1, arg_4_0)

			arg_3_0.sliderValue = arg_4_0

			return
		end))
	else
		setSlider(arg_3_0.slider, 0, 1, var_3_5)

		arg_3_0.firstSliderInit = true
		arg_3_0.sliderValue = var_3_5
	end

	arg_3_0.l1 = var_3_0

	arg_3_0:updataTask()
	arg_3_0:sortTaskGroups()
	arg_3_0:updateTaskUI()

	return
end

function var_0_0.updataTask(arg_5_0)
	for iter_5_0, iter_5_1 in ipairs(arg_5_0.taskGroups) do
		for iter_5_2, iter_5_3 in ipairs(iter_5_1.tasks) do
			local var_5_0 = arg_5_0.taskProxy:getFinishTaskById(iter_5_3.id) and 1 or 0
			local var_5_1 = arg_5_0.taskProxy:getTaskById(iter_5_3.id)
			local var_5_2 = 0

			if var_5_1 then
				var_5_2 = var_5_1:getProgress()

				if var_5_2 == 0 then
					iter_5_1.progress = iter_5_1.progress or var_5_2

					if false then
						var_5_2 = iter_5_1.progress
					end

					iter_5_3.progress = var_5_2

					if iter_5_3.finish ~= var_5_0 then
						setActive(iter_5_3.tf, false)
						table.insert(arg_5_0.taskTplPool, iter_5_3.tf)

						iter_5_3.tf = nil
					end

					iter_5_3.finish = var_5_0
				end
			end
		end
	end

	return
end

function var_0_0.OnFirstFlush(arg_6_0)
	var_0_0.super.OnFirstFlush(arg_6_0)
	onButton(arg_6_0, arg_6_0.displayBtn, function()
		arg_6_0:emit(ActivityMediator.SHOW_AWARD_WINDOW, PtAwardWindow, {
			type = 5,
			dropList = arg_6_0.ptData.dropList,
			targets = arg_6_0.ptData.targets,
			level = arg_6_0.ptData.level,
			count = arg_6_0.ptData.count,
			resId = arg_6_0.ptData.resId
		})

		return
	end, SFX_PANEL)
	onButton(arg_6_0, arg_6_0.battleBtn, function()
		arg_6_0:emit(ActivityMediator.EVENT_GO_SCENE, SCENE.LEVEL)

		return
	end, SFX_PANEL)
	arg_6_0:initTask()
	arg_6_0:sortTaskGroups()
	arg_6_0:updateTaskUI()

	return
end

function var_0_0.initTask(arg_9_0)
	arg_9_0.missionTpl = findTF(arg_9_0.bg, "missionTpl")

	setActive(arg_9_0.missionTpl, false)

	arg_9_0.missionContainer = findTF(arg_9_0.bg, "mission/content")

	local var_9_0 = pg.activity_template[arg_9_0.activity:getConfig("config_client").task_act_id].config_data

	arg_9_0.taskProxy = getProxy(TaskProxy)
	arg_9_0.taskTplPool = {}
	arg_9_0.taskScroll = GetComponent(findTF(arg_9_0.bg, "mission"), typeof(ScrollRect))
	arg_9_0.taskGroups = {}

	for iter_9_0 = 1, #var_9_0 do
		if pg.task_data_template[var_9_0[iter_9_0]].type == 26 then
			arg_9_0:insertTaskToGroup(var_9_0[iter_9_0], pg.task_data_template[var_9_0[iter_9_0]], (arg_9_0:getTaskGroup(pg.task_data_template[var_9_0[iter_9_0]].type, pg.task_data_template[var_9_0[iter_9_0]].sub_type)))
		end
	end

	return
end

function var_0_0.updateTaskUI(arg_10_0)
	for iter_10_0 = 1, #arg_10_0.taskGroups do
		for iter_10_1, iter_10_2 in ipairs(arg_10_0.taskGroups[iter_10_0].tasks) do
			arg_10_0:updateTaskList(iter_10_1, 0, iter_10_2, arg_10_0.taskGroups[iter_10_0])
		end
	end

	local var_10_1 = 0
	local var_10_2 = 0

	if arg_10_0.scrollToGroup then
		for iter_10_3, iter_10_4 in ipairs(arg_10_0.taskGroups) do
			if iter_10_4 == arg_10_0.scrollToGroup then
				var_10_2 = var_10_1
			end

			var_10_1 = iter_10_4.opening and var_10_1 + #iter_10_4.tasks or var_10_1 + 1
		end

		arg_10_0.scrollToGroup = nil
	end

	if var_10_2 ~= 0 and var_10_1 ~= 0 then
		scrollTo(arg_10_0.taskScroll, 0, 1 - var_10_2 / var_10_1)
	else
		scrollTo(arg_10_0.taskScroll, 0, 1)
	end

	return
end

function var_0_0.updateTaskList(arg_11_0, arg_11_1, arg_11_2, arg_11_3, arg_11_4)
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

	arg_11_3.tf = arg_11_3.tf or arg_11_0:getTaskTfFromPool()

	local var_11_8 = findTF(arg_11_3.tf, "AD")

	arg_11_3.tf.sizeDelta = Vector2(778, var_11_3 and 120 or 110)

	setActive(findTF(var_11_8, "bg1"), var_11_3)
	setActive(findTF(var_11_8, "bg2"), not var_11_3)

	if var_11_3 then
		setActive(findTF(var_11_8, "mask1"), var_11_2)
	else
		setActive(findTF(var_11_8, "mask2"), var_11_2)
	end

	if var_11_2 then
		setActive(findTF(var_11_8, "pahase"), false)
		setSlider(findTF(var_11_8, "slider"), 0, 1, 1)
	else
		setActive(findTF(var_11_8, "pahase"), true)
		setSlider(findTF(var_11_8, "slider"), 0, 1, var_11_1 / var_11_0)
	end

	setText(findTF(var_11_8, "desc"), var_11_4)

	if arg_11_4.subType ~= 33 then
		setText(findTF(var_11_8, "pahase"), setColorStr(var_11_1, "#b35845") .. "/" .. var_11_0)
	else
		setText(findTF(var_11_8, "pahase"), "")
	end

	updateDrop(findTF(var_11_8, "award"), var_11_5)
	onButton(arg_11_0, findTF(var_11_8, "award"), function()
		arg_11_0:emit(BaseUI.ON_DROP, var_11_5)

		return
	end, SFX_PANEL)
	setActive(findTF(var_11_8, "got"), false)
	setActive(findTF(var_11_8, "get"), false)
	setActive(findTF(var_11_8, "go"), false)

	if not var_11_3 then
		setActive(findTF(var_11_8, "go"), not var_11_2)
		setActive(findTF(var_11_8, "got"), var_11_2)
	elseif var_11_2 then
		setActive(findTF(var_11_8, "got"), true)
	elseif var_11_0 <= var_11_1 then
		setActive(findTF(var_11_8, "get"), true)
		onButton(arg_11_0, findTF(var_11_8, "get"), function()
			local var_13_0 = arg_11_0.taskProxy:getTaskById(arg_11_3.id)

			if var_13_0 then
				arg_11_0:emit(ActivityMediator.ON_TASK_SUBMIT, var_13_0)
			end

			return
		end, SFX_CONFIRM)
	else
		setActive(findTF(var_11_8, "go"), true)
		onButton(arg_11_0, findTF(var_11_8, "go"), function()
			local var_14_0 = arg_11_0.taskProxy:getTaskById(arg_11_3.id)

			if var_14_0 then
				arg_11_0:emit(ActivityMediator.ON_TASK_GO, var_14_0)
			end

			return
		end, SFX_CONFIRM)
	end

	if var_11_7 or not var_11_3 or var_11_2 and var_11_3 then
		setActive(findTF(var_11_8, "show"), false)
	else
		setActive(findTF(var_11_8, "show"), true)
		setActive(findTF(var_11_8, "show/on"), var_11_6)
		setActive(findTF(var_11_8, "show/off"), not var_11_6)
	end

	if var_11_3 then
		onButton(arg_11_0, findTF(var_11_8, "show"), function()
			arg_11_0:changeGroupOpening(arg_11_4)

			return
		end, SFX_CONFIRM)
	end

	setActive(arg_11_3.tf, true)
	arg_11_3.tf:SetSiblingIndex(arg_11_2)

	return
end

function var_0_0.changeGroupOpening(arg_16_0, arg_16_1)
	arg_16_1.opening = not arg_16_1.opening

	for iter_16_0 = 1, #arg_16_1.tasks do
		local var_16_0 = arg_16_1.tasks[iter_16_0]

		var_16_0.show = iter_16_0 == 1 and true or arg_16_1.opening

		if not var_16_0.show and var_16_0.tf then
			setActive(var_16_0.tf, false)
			table.insert(arg_16_0.taskTplPool, var_16_0.tf)

			var_16_0.tf = nil
		end
	end

	arg_16_0.scrollToGroup = arg_16_1

	arg_16_0:updateTaskUI()

	return
end

function var_0_0.getTaskTfFromPool(arg_17_0)
	if #arg_17_0.taskTplPool > 0 then
		return table.remove(arg_17_0.taskTplPool, 1)
	end

	local var_17_0 = tf(Instantiate(arg_17_0.missionTpl))

	SetParent(var_17_0, arg_17_0.missionContainer)

	return var_17_0
end

function var_0_0.getTaskGroup(arg_18_0, arg_18_1, arg_18_2)
	for iter_18_0 = 1, #arg_18_0.taskGroups do
		if arg_18_0.taskGroups[iter_18_0].type == arg_18_1 and arg_18_0.taskGroups[iter_18_0].subType == arg_18_2 then
			return arg_18_0.taskGroups[iter_18_0]
		end
	end

	table.insert(arg_18_0.taskGroups, {
		progress = 0,
		opening = false,
		type = arg_18_1,
		subType = arg_18_2,
		tasks = {}
	})

	return {
		progress = 0,
		opening = false,
		type = arg_18_1,
		subType = arg_18_2,
		tasks = {}
	}
end

function var_0_0.insertTaskToGroup(arg_19_0, arg_19_1, arg_19_2, arg_19_3)
	for iter_19_0 = 1, #arg_19_3.tasks do
		if arg_19_3.tasks[iter_19_0].id == arg_19_1 then
			return
		end
	end

	local var_19_0 = arg_19_2.target_num
	local var_19_1 = arg_19_2.desc
	local var_19_2 = {
		type = arg_19_2.award_display[1][1],
		id = arg_19_2.award_display[1][2],
		count = arg_19_2.award_display[1][3]
	}
	local var_19_3 = false

	if #arg_19_3.tasks == 0 then
		var_19_3 = true
	end

	local var_19_4 = arg_19_0.taskProxy:getFinishTaskById(arg_19_1) and 1 or 0
	local var_19_5 = arg_19_0.taskProxy:getTaskById(arg_19_1)
	local var_19_6 = 0

	if var_19_5 then
		var_19_6 = var_19_5:getProgress()

		if var_19_6 == 0 then
			arg_19_3.progress = arg_19_3.progress or var_19_6

			if false then
				var_19_6 = arg_19_3.progress
			end

			table.insert(arg_19_3.tasks, {
				id = arg_19_1,
				targetNum = var_19_0,
				show = var_19_3,
				finish = var_19_4,
				progress = var_19_6,
				desc = var_19_1,
				drop = var_19_2
			})

			return
		end
	end
end

function var_0_0.sortTaskGroups(arg_20_0)
	for iter_20_0, iter_20_1 in ipairs(arg_20_0.taskGroups) do
		table.sort(iter_20_1.tasks, function(arg_21_0, arg_21_1)
			if arg_21_0.finish ~= arg_21_1.finish then
				return arg_21_0.finish < arg_21_1.finish
			end

			return arg_21_0.targetNum < arg_21_1.targetNum
		end)
	end

	table.sort(arg_20_0.taskGroups, function(arg_22_0, arg_22_1)
		local var_22_0 = arg_22_1.tasks
		local var_22_1 = 0
		local var_22_2 = arg_22_0.tasks[1].id
		local var_22_3 = 0
		local var_22_5 = 0
		local var_22_6 = arg_22_1.tasks[1].id
		local var_22_7 = 0

		for iter_22_0, iter_22_1 in ipairs(arg_22_0.tasks) do
			if var_22_1 == 0 and iter_22_1.finish == 0 and iter_22_1.progress >= iter_22_1.targetNum then
				var_22_1 = 1
				var_22_2 = iter_22_1.id
			end

			var_22_3 = iter_22_1.finish == 1 and var_22_3 + 1 or var_22_3
		end

		local var_22_9 = var_22_3 == #arg_22_0.tasks and 1 or 0

		for iter_22_2, iter_22_3 in ipairs(var_22_0) do
			if var_22_5 == 0 and iter_22_3.finish == 0 and iter_22_3.progress >= iter_22_3.targetNum then
				var_22_5 = 1
				var_22_6 = iter_22_3.id
			end

			var_22_7 = iter_22_3.finish == 1 and var_22_7 + 1 or var_22_7
		end

		local var_22_10 = var_22_7 == #var_22_0 and 1 or 0

		if var_22_1 ~= var_22_5 then
			return var_22_5 < var_22_1
		elseif var_22_9 ~= var_22_10 then
			return var_22_9 < var_22_10
		else
			return var_22_2 < var_22_6
		end

		return
	end)

	for iter_20_2, iter_20_3 in ipairs(arg_20_0.taskGroups) do
		for iter_20_4 = 1, #iter_20_3.tasks do
			iter_20_3.tasks[iter_20_4].show = iter_20_4 == 1 and true or not not iter_20_3.opening
		end
	end

	return
end

function var_0_0.OnDestroy(arg_23_0)
	if LeanTween.isTweening(go(arg_23_0.slider)) then
		LeanTween.cancel(go(arg_23_0.slider))
	end

	return
end

return var_0_0
