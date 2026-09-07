local XiaoAiJiErPage = class("XiaoAiJiErPage", import(".TemplatePage.PtTemplatePage"))

function XiaoAiJiErPage:OnInit()
	XiaoAiJiErPage.super.OnInit(self)

	self.helpBtn = self.bg:Find("help_btn")

	onButton(self, self.helpBtn, function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = pg.gametip.littleaijier_npc.tip
		})

		return
	end, SFX_PANEL)

	return
end

function XiaoAiJiErPage:OnUpdateFlush()
	XiaoAiJiErPage.super.OnUpdateFlush(self)

	local var_3_0, var_3_1, var_3_2 = self.ptData:GetLevelProgress()
	local var_3_3, var_3_4, var_3_5 = self.ptData:GetResProgress()

	setText(self.step, setColorStr(var_3_0, "#f0d1c6") .. " / " .. var_3_1)
	setText(self.progress, (var_3_5 >= 1 and setColorStr(var_3_3, COLOR_GREEN) or setColorStr(var_3_3, "#f0d1c6")) .. "/" .. var_3_4)

	if self.firstSliderInit then
		if LeanTween.isTweening(go(self.slider)) then
			LeanTween.cancel(go(self.slider))
		end

		local var_3_6 = GetComponent(self.slider, typeof(Slider)).value

		LeanTween.value(go(self.slider), self.l1 ~= var_3_0 and 0 or self.sliderValue, var_3_5, 1):setOnUpdate(System.Action_float(function(arg_4_0)
			setSlider(self.slider, 0, 1, arg_4_0)

			self.sliderValue = arg_4_0

			return
		end))
	else
		setSlider(self.slider, 0, 1, var_3_5)

		self.firstSliderInit = true
		self.sliderValue = var_3_5
	end

	self.l1 = var_3_0

	self:updataTask()
	self:sortTaskGroups()
	self:updateTaskUI()

	return
end

function XiaoAiJiErPage:updataTask()
	for iter_5_0, iter_5_1 in ipairs(self.taskGroups) do
		for iter_5_2, iter_5_3 in ipairs(iter_5_1.tasks) do
			local var_5_0 = self.taskProxy:getFinishTaskById(iter_5_3.id) and 1 or 0
			local var_5_1 = self.taskProxy:getTaskById(iter_5_3.id)
			local var_5_2 = 0

			if var_5_1 then
				var_5_2 = var_5_1:getProgress()

				if var_5_2 == 0 then
					iter_5_1.progress = iter_5_1.progress or var_5_2
				end
			else
				var_5_2 = iter_5_1.progress
			end

			iter_5_3.progress = var_5_2

			if iter_5_3.finish ~= var_5_0 and iter_5_3.tf then
				setActive(iter_5_3.tf, false)
				table.insert(self.taskTplPool, iter_5_3.tf)

				iter_5_3.tf = nil
			end

			iter_5_3.finish = var_5_0
		end
	end

	return
end

function XiaoAiJiErPage:OnFirstFlush()
	XiaoAiJiErPage.super.OnFirstFlush(self)
	onButton(self, self.battleBtn, function()
		self:emit(ActivityMediator.EVENT_GO_SCENE, SCENE.LEVEL)

		return
	end, SFX_PANEL)
	self:initTask()
	self:sortTaskGroups()
	self:updateTaskUI()
	self:tryClaimTaskReward()

	return
end

function XiaoAiJiErPage:tryClaimTaskReward()
	local var_8_0 = {}

	for iter_8_0 = 1, #self.taskGroups do
		for iter_8_1, iter_8_2 in ipairs(self.taskGroups[iter_8_0].tasks) do
			if iter_8_2.targetNum <= iter_8_2.progress and iter_8_2.finish ~= 1 then
				local var_8_1 = self.taskProxy:getTaskById(iter_8_2.id)

				if var_8_1 then
					table.insert(var_8_0, var_8_1)
				end
			end
		end
	end

	if #var_8_0 > 0 then
		self:emit(ActivityMediator.ON_TASK_SUBMIT_ONESTEP, var_8_0)
	end

	return
end

function XiaoAiJiErPage:initTask()
	self.missionTpl = findTF(self.bg, "missionTpl")

	setActive(self.missionTpl, false)

	self.missionContainer = findTF(self.bg, "mission/content")

	local var_9_0 = pg.activity_template[self.activity:getConfig("config_client").task_act_id].config_data[1]

	self.taskProxy = getProxy(TaskProxy)
	self.taskTplPool = {}
	self.taskScroll = GetComponent(findTF(self.bg, "mission"), typeof(ScrollRect))
	self.taskGroups = {}

	for iter_9_0 = 1, #var_9_0 do
		if pg.task_data_template[var_9_0[iter_9_0]].type == 26 then
			self:insertTaskToGroup(var_9_0[iter_9_0], pg.task_data_template[var_9_0[iter_9_0]], (self:getTaskGroup(pg.task_data_template[var_9_0[iter_9_0]].type, pg.task_data_template[var_9_0[iter_9_0]].sub_type)))
		end
	end

	return
end

function XiaoAiJiErPage:updateTaskUI()
	for iter_10_0 = 1, #self.taskGroups do
		for iter_10_1, iter_10_2 in ipairs(self.taskGroups[iter_10_0].tasks) do
			self:updateTaskList(iter_10_1, 0, iter_10_2, self.taskGroups[iter_10_0])
		end
	end

	local var_10_1 = 0
	local var_10_2 = 0

	if self.scrollToGroup then
		for iter_10_3, iter_10_4 in ipairs(self.taskGroups) do
			if iter_10_4 == self.scrollToGroup then
				var_10_2 = var_10_1
			end

			var_10_1 = iter_10_4.opening and var_10_1 + #iter_10_4.tasks or var_10_1 + 1
		end

		self.scrollToGroup = nil
	end

	if var_10_2 ~= 0 and var_10_1 ~= 0 then
		scrollTo(self.taskScroll, 0, 1 - var_10_2 / var_10_1)
	else
		scrollTo(self.taskScroll, 0, 1)
	end

	return
end

function XiaoAiJiErPage:updateTaskList(arg_11_1, arg_11_2, arg_11_3, arg_11_4)
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

	arg_11_3.tf = arg_11_3.tf or self:getTaskTfFromPool()

	local var_11_8 = findTF(arg_11_3.tf, "AD")

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
		setText(findTF(var_11_8, "pahase"), setColorStr(var_11_1, "#957b01") .. "/" .. var_11_0)
	else
		setText(findTF(var_11_8, "pahase"), "")
	end

	updateDrop(findTF(var_11_8, "award"), var_11_5)
	onButton(self, findTF(var_11_8, "award"), function()
		self:emit(BaseUI.ON_DROP, var_11_5)

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
		onButton(self, findTF(var_11_8, "get"), function()
			local var_13_0 = self.taskProxy:getTaskById(arg_11_3.id)

			if var_13_0 then
				self:emit(ActivityMediator.ON_TASK_SUBMIT, var_13_0)
			end

			return
		end, SFX_CONFIRM)
	else
		setActive(findTF(var_11_8, "go"), true)
		onButton(self, findTF(var_11_8, "go"), function()
			local var_14_0 = self.taskProxy:getTaskById(arg_11_3.id)

			if var_14_0 then
				self:emit(ActivityMediator.ON_TASK_GO, var_14_0)
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
		onButton(self, findTF(var_11_8, "show"), function()
			self:changeGroupOpening(arg_11_4)

			return
		end, SFX_CONFIRM)
	end

	setActive(arg_11_3.tf, true)
	arg_11_3.tf:SetSiblingIndex(arg_11_2)

	return
end

function XiaoAiJiErPage:changeGroupOpening(arg_16_1)
	arg_16_1.opening = not arg_16_1.opening

	for iter_16_0 = 1, #arg_16_1.tasks do
		local var_16_0 = arg_16_1.tasks[iter_16_0]

		var_16_0.show = iter_16_0 == 1 and true or arg_16_1.opening

		if not var_16_0.show and var_16_0.tf then
			setActive(var_16_0.tf, false)
			table.insert(self.taskTplPool, var_16_0.tf)

			var_16_0.tf = nil
		end
	end

	self.scrollToGroup = arg_16_1

	self:updateTaskUI()

	return
end

function XiaoAiJiErPage:getTaskTfFromPool()
	if #self.taskTplPool > 0 then
		return table.remove(self.taskTplPool, 1)
	end

	local var_17_0 = tf(Instantiate(self.missionTpl))

	SetParent(var_17_0, self.missionContainer)

	return var_17_0
end

function XiaoAiJiErPage:getTaskGroup(arg_18_1, arg_18_2)
	for iter_18_0 = 1, #self.taskGroups do
		if self.taskGroups[iter_18_0].type == arg_18_1 and self.taskGroups[iter_18_0].subType == arg_18_2 then
			return self.taskGroups[iter_18_0]
		end
	end

	local var_18_0 = {
		progress = 0,
		opening = false,
		type = arg_18_1,
		subType = arg_18_2,
		tasks = {}
	}

	table.insert(self.taskGroups, var_18_0)

	return var_18_0
end

function XiaoAiJiErPage:insertTaskToGroup(arg_19_1, arg_19_2, arg_19_3)
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
	local var_19_3 = #arg_19_3.tasks == 0
	local var_19_4 = self.taskProxy:getFinishTaskById(arg_19_1) and 1 or 0
	local var_19_5 = self.taskProxy:getTaskById(arg_19_1)
	local var_19_6 = 0

	if var_19_5 then
		var_19_6 = var_19_5:getProgress()

		if var_19_6 == 0 then
			arg_19_3.progress = arg_19_3.progress or var_19_6
		end
	else
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

function XiaoAiJiErPage:sortTaskGroups()
	for iter_20_0, iter_20_1 in ipairs(self.taskGroups) do
		table.sort(iter_20_1.tasks, function(arg_21_0, arg_21_1)
			if arg_21_0.finish ~= arg_21_1.finish then
				return arg_21_0.finish < arg_21_1.finish
			end

			return arg_21_0.targetNum < arg_21_1.targetNum
		end)
	end

	table.sort(self.taskGroups, function(arg_22_0, arg_22_1)
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

	for iter_20_2, iter_20_3 in ipairs(self.taskGroups) do
		for iter_20_4 = 1, #iter_20_3.tasks do
			iter_20_3.tasks[iter_20_4].show = iter_20_4 == 1 and true or not not iter_20_3.opening
		end
	end

	return
end

function XiaoAiJiErPage:OnDestroy()
	if LeanTween.isTweening(go(self.slider)) then
		LeanTween.cancel(go(self.slider))
	end

	return
end

return XiaoAiJiErPage
