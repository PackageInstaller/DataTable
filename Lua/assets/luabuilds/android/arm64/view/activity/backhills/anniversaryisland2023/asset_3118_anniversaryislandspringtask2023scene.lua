local AnniversaryIslandSpringTask2023Scene = class("AnniversaryIslandSpringTask2023Scene", import("view.base.BaseUI"))

function AnniversaryIslandSpringTask2023Scene:getUIName()
	return "AnniversaryIslandSpringTask2023UI"
end

function AnniversaryIslandSpringTask2023Scene:init()
	self.taskListRect = GetComponent(self._tf:Find("TaskList/ScrollView"), "LScrollRect")

	function self.taskListRect.onUpdateItem(arg_3_0, arg_3_1)
		self:UpdateTaskListItem(arg_3_0, arg_3_1)

		return
	end

	setText(self._tf:Find("Desc/Text"), i18n("springtask_tip"))
	setActive(self._tf:Find("Top/Help"), false)

	return
end

function AnniversaryIslandSpringTask2023Scene:BuildTaskVOs()
	local var_4_0 = getProxy(ActivityProxy)
	local var_4_1 = var_4_0:getActivityByType(ActivityConst.ACTIVITY_TYPE_HOTSPRING_2)
	local var_4_2 = var_4_1:GetConfigID()

	self.activityId = var_4_0

	local var_4_3 = getProxy(ActivityTaskProxy):getTaskVOsByActId(var_4_2)

	self.lockTasks = {}
	self.taskVOs = _.map(var_4_1:GetUnlockTaskIds(), function(arg_5_0)
		local var_5_0 = _.detect(var_4_3, function(arg_6_0)
			return arg_6_0:GetConfigID() == arg_5_0
		end)

		if not var_5_0 then
			var_5_0 = ActivityTask.New(var_4_2, {
				id = arg_5_0
			})
			self.lockTasks[var_5_0] = true
		end

		return var_5_0
	end)

	table.sort(self.taskVOs, (CompareFuncs({
		function(arg_7_0)
			return arg_7_0:isOver() and 1 or 0
		end,
		function(arg_8_0)
			return self.lockTasks[arg_8_0] and 1 or 0
		end,
		function(arg_9_0)
			return arg_9_0:GetConfigID()
		end
	})))

	return
end

function AnniversaryIslandSpringTask2023Scene:UpdateTaskListItem(arg_10_1, arg_10_2)
	arg_10_1 = arg_10_1 + 1

	local var_10_0 = tf(arg_10_2)
	local var_10_1 = self.taskVOs[arg_10_1]
	local var_10_2 = pg.task_data_template[self.taskVOs[arg_10_1]:GetConfigID()]
	local var_10_3 = self.taskVOs[arg_10_1]:isFinish()
	local var_10_4 = self.taskVOs[arg_10_1]:isOver()
	local var_10_5 = self.taskVOs[arg_10_1]:isSubmit()
	local var_10_6 = var_10_2.award_display
	local var_10_7 = self.taskVOs[arg_10_1]:getProgress()
	local var_10_8 = self.taskVOs[arg_10_1]:getTargetNumber()

	setActive(var_10_0:Find("Lock"), self.lockTasks[self.taskVOs[arg_10_1]])
	setText(var_10_0:Find("BG/Progress"), var_10_7 .. "/" .. var_10_8)
	setSlider(var_10_0:Find("BG/ProgressBar"), 0, var_10_8, var_10_7)
	changeToScrollText(var_10_0:Find("BG/Name/Text"), var_10_2.name)
	setActive(var_10_0:Find("BG/Go"), not var_10_4 and not var_10_3)
	setActive(var_10_0:Find("BG/Commit"), not var_10_4 and var_10_3 and var_10_5)
	setActive(var_10_0:Find("BG/Reward"), not var_10_4 and var_10_3 and not var_10_5)
	setActive(var_10_0:Find("BG/Got"), var_10_4)
	UIItemList.StaticAlign(var_10_0:Find("BG/Items"), var_10_0:Find("BG/Items"):GetChild(0), #var_10_6, function(arg_11_0, arg_11_1, arg_11_2)
		local var_11_0

		if arg_11_0 ~= UIItemList.EventUpdate then
			do return end

			var_11_0 = {
				type = var_10_6[arg_11_1 + 1][1],
				id = var_10_6[arg_11_1 + 1][2]
			}
		end

		var_11_0.count = var_10_6[arg_11_1 + 1][3]

		updateDrop(arg_11_2:Find("Icon"), var_11_0)
		onButton(self, arg_11_2, function()
			self:emit(BaseUI.ON_DROP, var_11_0)

			return
		end)
		setActive(arg_11_2:Find("Completed"), var_10_4)

		return
	end)
	onButton(self, var_10_0:Find("BG/Go"), function()
		self:emit(AnniversaryIslandSpringTask2023Mediator.TASK_GO, {
			taskVO = var_10_1
		})

		return
	end, SFX_PANEL)
	onButton(self, var_10_0:Find("BG/Commit"), function()
		self:emit(AnniversaryIslandSpringTask2023Mediator.SHOW_SUBMIT_WINDOW, var_10_1)

		return
	end, SFX_PANEL)
	onButton(self, var_10_0:Find("BG/Reward"), function()
		self:emit(AnniversaryIslandSpringTask2023Mediator.SUBMIT_TASK, var_10_1)

		return
	end, SFX_PANEL)

	return
end

function AnniversaryIslandSpringTask2023Scene:didEnter()
	onButton(self, self._tf:Find("Top/Back"), function()
		self:onBackPressed()

		return
	end, SFX_CANCEL)
	onButton(self, self._tf:Find("Top/Home"), function()
		self:quickExitFunc()

		return
	end, SFX_CANCEL)
	onButton(self, self._tf:Find("Top/Help"), function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = i18n("springtask_help")
		})

		return
	end, SFX_PANEL)
	self:BuildTaskVOs()
	self:UpdateView()

	return
end

function AnniversaryIslandSpringTask2023Scene:UpdateView()
	self.taskListRect:SetTotalCount(#self.taskVOs)

	return
end

function AnniversaryIslandSpringTask2023Scene:willExit()
	return
end

return AnniversaryIslandSpringTask2023Scene
