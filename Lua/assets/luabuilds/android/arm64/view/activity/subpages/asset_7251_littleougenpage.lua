local LittleOuGenPage = class("LittleOuGenPage", import(".TemplatePage.PtTemplatePage"))

function LittleOuGenPage:OnInit()
	LittleOuGenPage.super.OnInit(self)

	self.heartTpl = self.bg:Find("HeartTpl")
	self.heartContainer = self.bg:Find("HeartContainer")
	self.heartUIItemList = UIItemList.New(self.heartContainer, self.heartTpl)

	self.heartUIItemList:make(function(arg_2_0, arg_2_1, arg_2_2)
		if arg_2_0 == UIItemList.EventUpdate then
			setActive(arg_2_2:Find("Full"), not (self.ptData:GetLevelProgress() < arg_2_1 + 1))
		end

		return
	end)

	self.helpBtn = self.bg:Find("help_btn")

	onButton(self, self.helpBtn, function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = pg.gametip.littleEugen_npc.tip
		})

		return
	end, SFX_PANEL)

	return
end

function LittleOuGenPage:OnUpdateFlush()
	LittleOuGenPage.super.OnUpdateFlush(self)

	local var_4_0, var_4_1 = self.ptData:GetLevelProgress()

	self.heartUIItemList:align(var_4_1)

	local var_4_2, var_4_3, var_4_4 = self.ptData:GetLevelProgress()
	local var_4_5, var_4_6, var_4_7 = self.ptData:GetResProgress()

	setText(self.step, setColorStr(var_4_2, "#f8e6e2") .. " / " .. setColorStr(var_4_3, "#4e2c2b"))
	setText(self.progress, (var_4_7 >= 1 and setColorStr(var_4_5, COLOR_GREEN) or setColorStr(var_4_5, "COLOR_GREEN")) .. "/" .. setColorStr(var_4_6, "#4e2c2b"))

	if self.firstSliderInit then
		if LeanTween.isTweening(go(self.slider)) then
			LeanTween.cancel(go(self.slider))
		end

		local var_4_8 = GetComponent(self.slider, typeof(Slider)).value

		LeanTween.value(go(self.slider), self.l1 ~= var_4_2 and 0 or self.sliderValue, var_4_7, 1):setOnUpdate(System.Action_float(function(arg_5_0)
			setSlider(self.slider, 0, 1, arg_5_0)

			self.sliderValue = arg_5_0

			return
		end))
	else
		setSlider(self.slider, 0, 1, var_4_7)

		self.firstSliderInit = true
		self.sliderValue = var_4_7
	end

	self.l1 = var_4_2

	self:updataTask()
	self:sortTaskGroups()
	self:updateTaskUI()

	return
end

function LittleOuGenPage:updataTask()
	for iter_6_0, iter_6_1 in ipairs(self.taskGroups) do
		for iter_6_2, iter_6_3 in ipairs(iter_6_1.tasks) do
			local var_6_0 = self.taskProxy:getFinishTaskById(iter_6_3.id) and 1 or 0
			local var_6_1 = self.taskProxy:getTaskById(iter_6_3.id)
			local var_6_2 = 0

			if var_6_1 then
				var_6_2 = var_6_1:getProgress()

				if var_6_2 == 0 then
					iter_6_1.progress = iter_6_1.progress or var_6_2
				end
			else
				var_6_2 = iter_6_1.progress
			end

			iter_6_3.progress = var_6_2

			if iter_6_3.finish ~= var_6_0 then
				setActive(iter_6_3.tf, false)
				table.insert(self.taskTplPool, iter_6_3.tf)

				iter_6_3.tf = nil
			end

			iter_6_3.finish = var_6_0
		end
	end

	return
end

function LittleOuGenPage:OnFirstFlush()
	LittleOuGenPage.super.OnFirstFlush(self)
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

	return
end

function LittleOuGenPage:initTask()
	self.missionTpl = findTF(self.bg, "missionTpl")

	setActive(self.missionTpl, false)

	self.missionContainer = findTF(self.bg, "mission/content")

	local var_10_0 = pg.activity_template[self.activity:getConfig("config_client").task_act_id].config_data

	self.taskProxy = getProxy(TaskProxy)
	self.taskTplPool = {}
	self.taskScroll = GetComponent(findTF(self.bg, "mission"), typeof(ScrollRect))
	self.taskGroups = {}

	for iter_10_0 = 1, #var_10_0 do
		if pg.task_data_template[var_10_0[iter_10_0]].type ~= Task.TYPE_ACTIVITY then
			if pg.task_data_template[var_10_0[iter_10_0]].type == Task.TYPE_ACTIVITY_BRANCH then
				self:insertTaskToGroup(var_10_0[iter_10_0], pg.task_data_template[var_10_0[iter_10_0]], (self:getTaskGroup(pg.task_data_template[var_10_0[iter_10_0]].type, pg.task_data_template[var_10_0[iter_10_0]].sub_type)))
			end
		end
	end

	return
end

function LittleOuGenPage:updateTaskUI()
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

function LittleOuGenPage:updateTaskList(arg_12_1, arg_12_2, arg_12_3, arg_12_4)
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
		setText(findTF(var_12_8, "pahase"), setColorStr(var_12_1, "#95b345") .. "/" .. setColorStr(var_12_0, "#e9c9bd"))
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

function LittleOuGenPage:changeGroupOpening(arg_17_1)
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

function LittleOuGenPage:getTaskTfFromPool()
	if #self.taskTplPool > 0 then
		return table.remove(self.taskTplPool, 1)
	end

	local var_18_0 = tf(Instantiate(self.missionTpl))

	SetParent(var_18_0, self.missionContainer)

	return var_18_0
end

function LittleOuGenPage:getTaskGroup(arg_19_1, arg_19_2)
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

function LittleOuGenPage:insertTaskToGroup(arg_20_1, arg_20_2, arg_20_3)
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

function LittleOuGenPage:sortTaskGroups()
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

function LittleOuGenPage:OnDestroy()
	if LeanTween.isTweening(go(self.slider)) then
		LeanTween.cancel(go(self.slider))
	end

	return
end

return LittleOuGenPage
