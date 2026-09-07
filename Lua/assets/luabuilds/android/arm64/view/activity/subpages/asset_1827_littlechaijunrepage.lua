local LittleChaijunRePage = class("LittleChaijunRePage", import(".TemplatePage.PtTemplatePage"))

function LittleChaijunRePage:OnInit()
	LittleChaijunRePage.super.OnInit(self)

	self.helpBtn = self.bg:Find("help_btn")

	onButton(self, self.helpBtn, function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = pg.gametip.littleChaijun_npc.tip
		})

		return
	end, SFX_PANEL)

	return
end

function LittleChaijunRePage:OnUpdateFlush()
	LittleChaijunRePage.super.OnUpdateFlush(self)

	local var_3_0, var_3_1, var_3_2 = self.ptData:GetLevelProgress()
	local var_3_3, var_3_4, var_3_5 = self.ptData:GetResProgress()

	setText(self.step, setColorStr(var_3_0, "ebced8") .. " / " .. var_3_1)
	setText(self.progress, (var_3_5 >= 1 and setColorStr(var_3_3, COLOR_GREEN) or setColorStr(var_3_3, "ebced8")) .. "/" .. var_3_4)

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

function LittleChaijunRePage:updataTask()
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

function LittleChaijunRePage:OnFirstFlush()
	LittleChaijunRePage.super.OnFirstFlush(self)
	onButton(self, self.displayBtn, function()
		self:emit(ActivityMediator.SHOW_AWARD_WINDOW, PtAwardWindow, {
			type = 5,
			dropList = self.ptData.dropList,
			targets = self.ptData.targets,
			level = self.ptData.level,
			count = self.ptData.count,
			resId = self.ptData.resId
		})

		return
	end, SFX_PANEL)
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

function LittleChaijunRePage:tryClaimTaskReward()
	local var_9_0 = {}

	for iter_9_0 = 1, #self.taskGroups do
		for iter_9_1, iter_9_2 in ipairs(self.taskGroups[iter_9_0].tasks) do
			if iter_9_2.targetNum <= iter_9_2.progress and iter_9_2.finish ~= 1 then
				local var_9_1 = self.taskProxy:getTaskById(iter_9_2.id)

				if var_9_1 then
					table.insert(var_9_0, var_9_1)
				end
			end
		end
	end

	if #var_9_0 > 0 then
		self:emit(ActivityMediator.ON_TASK_SUBMIT_ONESTEP, var_9_0)
	end

	return
end

function LittleChaijunRePage:initTask()
	self.missionTpl = findTF(self.bg, "missionTpl")

	setActive(self.missionTpl, false)

	self.missionContainer = findTF(self.bg, "mission/content")

	local var_10_0 = pg.activity_template[self.activity:getConfig("config_client").task_act_id].config_data[1]

	self.taskProxy = getProxy(TaskProxy)
	self.taskTplPool = {}
	self.taskScroll = GetComponent(findTF(self.bg, "mission"), typeof(ScrollRect))
	self.taskGroups = {}

	for iter_10_0 = 1, #var_10_0 do
		if pg.task_data_template[var_10_0[iter_10_0]].type == 26 then
			self:insertTaskToGroup(var_10_0[iter_10_0], pg.task_data_template[var_10_0[iter_10_0]], (self:getTaskGroup(pg.task_data_template[var_10_0[iter_10_0]].type, pg.task_data_template[var_10_0[iter_10_0]].sub_type)))
		end
	end

	return
end

function LittleChaijunRePage:updateTaskUI()
	for iter_11_0 = 1, #self.taskGroups do
		for iter_11_1, iter_11_2 in ipairs(self.taskGroups[iter_11_0].tasks) do
			self:updateTaskList(iter_11_1, 0, iter_11_2, self.taskGroups[iter_11_0])
		end
	end

	local var_11_1 = 0
	local var_11_2 = 0

	if self.scrollToGroup then
		for iter_11_3, iter_11_4 in ipairs(self.taskGroups) do
			if iter_11_4 == self.scrollToGroup then
				var_11_2 = var_11_1
			end

			var_11_1 = iter_11_4.opening and var_11_1 + #iter_11_4.tasks or var_11_1 + 1
		end

		self.scrollToGroup = nil
	end

	if var_11_2 ~= 0 and var_11_1 ~= 0 then
		scrollTo(self.taskScroll, 0, 1 - var_11_2 / var_11_1)
	else
		scrollTo(self.taskScroll, 0, 1)
	end

	return
end

function LittleChaijunRePage:updateTaskList(arg_12_1, arg_12_2, arg_12_3, arg_12_4)
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

	arg_12_3.tf = arg_12_3.tf or self:getTaskTfFromPool()

	local var_12_8 = findTF(arg_12_3.tf, "AD")

	arg_12_3.tf.sizeDelta = Vector2(778, var_12_3 and 120 or 110)

	setActive(findTF(var_12_8, "bg1"), var_12_3)
	setActive(findTF(var_12_8, "bg2"), not var_12_3)

	if var_12_3 then
		setActive(findTF(var_12_8, "mask1"), var_12_2)
	else
		setActive(findTF(var_12_8, "mask2"), var_12_2)
	end

	if var_12_2 then
		setActive(findTF(var_12_8, "pahase"), false)
		setSlider(findTF(var_12_8, "slider"), 0, 1, 1)
	else
		setActive(findTF(var_12_8, "pahase"), true)
		setSlider(findTF(var_12_8, "slider"), 0, 1, var_12_1 / var_12_0)
	end

	setText(findTF(var_12_8, "desc"), var_12_4)

	if arg_12_4.subType ~= 33 then
		setText(findTF(var_12_8, "pahase"), setColorStr(var_12_1, "#b35845") .. "/" .. var_12_0)
	else
		setText(findTF(var_12_8, "pahase"), "")
	end

	updateDrop(findTF(var_12_8, "award"), var_12_5)
	onButton(self, findTF(var_12_8, "award"), function()
		self:emit(BaseUI.ON_DROP, var_12_5)

		return
	end, SFX_PANEL)
	setActive(findTF(var_12_8, "got"), false)
	setActive(findTF(var_12_8, "get"), false)
	setActive(findTF(var_12_8, "go"), false)

	if not var_12_3 then
		setActive(findTF(var_12_8, "go"), not var_12_2)
		setActive(findTF(var_12_8, "got"), var_12_2)
	elseif var_12_2 then
		setActive(findTF(var_12_8, "got"), true)
	elseif var_12_0 <= var_12_1 then
		setActive(findTF(var_12_8, "get"), true)
		onButton(self, findTF(var_12_8, "get"), function()
			local var_14_0 = self.taskProxy:getTaskById(arg_12_3.id)

			if var_14_0 then
				self:emit(ActivityMediator.ON_TASK_SUBMIT, var_14_0)
			end

			return
		end, SFX_CONFIRM)
	else
		setActive(findTF(var_12_8, "go"), true)
		onButton(self, findTF(var_12_8, "go"), function()
			local var_15_0 = self.taskProxy:getTaskById(arg_12_3.id)

			if var_15_0 then
				self:emit(ActivityMediator.ON_TASK_GO, var_15_0)
			end

			return
		end, SFX_CONFIRM)
	end

	if var_12_7 or not var_12_3 or var_12_2 and var_12_3 then
		setActive(findTF(var_12_8, "show"), false)
	else
		setActive(findTF(var_12_8, "show"), true)
		setActive(findTF(var_12_8, "show/on"), var_12_6)
		setActive(findTF(var_12_8, "show/off"), not var_12_6)
	end

	if var_12_3 then
		onButton(self, findTF(var_12_8, "show"), function()
			self:changeGroupOpening(arg_12_4)

			return
		end, SFX_CONFIRM)
	end

	setActive(arg_12_3.tf, true)
	arg_12_3.tf:SetSiblingIndex(arg_12_2)

	return
end

function LittleChaijunRePage:changeGroupOpening(arg_17_1)
	arg_17_1.opening = not arg_17_1.opening

	for iter_17_0 = 1, #arg_17_1.tasks do
		local var_17_0 = arg_17_1.tasks[iter_17_0]

		var_17_0.show = iter_17_0 == 1 and true or arg_17_1.opening

		if not var_17_0.show and var_17_0.tf then
			setActive(var_17_0.tf, false)
			table.insert(self.taskTplPool, var_17_0.tf)

			var_17_0.tf = nil
		end
	end

	self.scrollToGroup = arg_17_1

	self:updateTaskUI()

	return
end

function LittleChaijunRePage:getTaskTfFromPool()
	if #self.taskTplPool > 0 then
		return table.remove(self.taskTplPool, 1)
	end

	local var_18_0 = tf(Instantiate(self.missionTpl))

	SetParent(var_18_0, self.missionContainer)

	return var_18_0
end

function LittleChaijunRePage:getTaskGroup(arg_19_1, arg_19_2)
	for iter_19_0 = 1, #self.taskGroups do
		if self.taskGroups[iter_19_0].type == arg_19_1 and self.taskGroups[iter_19_0].subType == arg_19_2 then
			return self.taskGroups[iter_19_0]
		end
	end

	local var_19_0 = {
		progress = 0,
		opening = false,
		type = arg_19_1,
		subType = arg_19_2,
		tasks = {}
	}

	table.insert(self.taskGroups, var_19_0)

	return var_19_0
end

function LittleChaijunRePage:insertTaskToGroup(arg_20_1, arg_20_2, arg_20_3)
	for iter_20_0 = 1, #arg_20_3.tasks do
		if arg_20_3.tasks[iter_20_0].id == arg_20_1 then
			return
		end
	end

	local var_20_0 = arg_20_2.target_num
	local var_20_1 = arg_20_2.desc
	local var_20_2 = {
		type = arg_20_2.award_display[1][1],
		id = arg_20_2.award_display[1][2],
		count = arg_20_2.award_display[1][3]
	}
	local var_20_3 = #arg_20_3.tasks == 0
	local var_20_4 = self.taskProxy:getFinishTaskById(arg_20_1) and 1 or 0
	local var_20_5 = self.taskProxy:getTaskById(arg_20_1)
	local var_20_6 = 0

	if var_20_5 then
		var_20_6 = var_20_5:getProgress()

		if var_20_6 == 0 then
			arg_20_3.progress = arg_20_3.progress or var_20_6
		end
	else
		var_20_6 = arg_20_3.progress
	end

	table.insert(arg_20_3.tasks, {
		id = arg_20_1,
		targetNum = var_20_0,
		show = var_20_3,
		finish = var_20_4,
		progress = var_20_6,
		desc = var_20_1,
		drop = var_20_2
	})

	return
end

function LittleChaijunRePage:sortTaskGroups()
	for iter_21_0, iter_21_1 in ipairs(self.taskGroups) do
		table.sort(iter_21_1.tasks, function(arg_22_0, arg_22_1)
			if arg_22_0.finish ~= arg_22_1.finish then
				return arg_22_0.finish < arg_22_1.finish
			end

			return arg_22_0.targetNum < arg_22_1.targetNum
		end)
	end

	table.sort(self.taskGroups, function(arg_23_0, arg_23_1)
		local var_23_0 = arg_23_1.tasks
		local var_23_1 = 0
		local var_23_2 = arg_23_0.tasks[1].id
		local var_23_3 = 0
		local var_23_5 = 0
		local var_23_6 = arg_23_1.tasks[1].id
		local var_23_7 = 0

		for iter_23_0, iter_23_1 in ipairs(arg_23_0.tasks) do
			if var_23_1 == 0 and iter_23_1.finish == 0 and iter_23_1.progress >= iter_23_1.targetNum then
				var_23_1 = 1
				var_23_2 = iter_23_1.id
			end

			var_23_3 = iter_23_1.finish == 1 and var_23_3 + 1 or var_23_3
		end

		local var_23_9 = var_23_3 == #arg_23_0.tasks and 1 or 0

		for iter_23_2, iter_23_3 in ipairs(var_23_0) do
			if var_23_5 == 0 and iter_23_3.finish == 0 and iter_23_3.progress >= iter_23_3.targetNum then
				var_23_5 = 1
				var_23_6 = iter_23_3.id
			end

			var_23_7 = iter_23_3.finish == 1 and var_23_7 + 1 or var_23_7
		end

		local var_23_10 = var_23_7 == #var_23_0 and 1 or 0

		if var_23_1 ~= var_23_5 then
			return var_23_5 < var_23_1
		elseif var_23_9 ~= var_23_10 then
			return var_23_9 < var_23_10
		else
			return var_23_2 < var_23_6
		end

		return
	end)

	for iter_21_2, iter_21_3 in ipairs(self.taskGroups) do
		for iter_21_4 = 1, #iter_21_3.tasks do
			iter_21_3.tasks[iter_21_4].show = iter_21_4 == 1 and true or not not iter_21_3.opening
		end
	end

	return
end

function LittleChaijunRePage:OnDestroy()
	if LeanTween.isTweening(go(self.slider)) then
		LeanTween.cancel(go(self.slider))
	end

	return
end

return LittleChaijunRePage
