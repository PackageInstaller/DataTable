local TaskWeekPage = class("TaskWeekPage", import(".TaskCommonPage"))

TaskWeekPage.WEEK_TASK_TYPE_COMMON = 1
TaskWeekPage.WEEK_TASK_TYPE_PT = 2

function TaskWeekPage:getUIName()
	return "TaskListForWeekPage"
end

function TaskWeekPage:RefreshWeekProgress()
	self:UpdateWeekProgress(self.contextData.weekTaskProgressInfo)

	return
end

function TaskWeekPage:OnLoaded()
	TaskWeekPage.super.OnLoaded(self)

	local var_3_0 = self._tf:Find("task_progress")

	setActive(var_3_0, true)
	setText(var_3_0:Find("title"), i18n("week_task_title_label"))

	self.awardPreviewBtn = var_3_0:Find("award_preview")

	setText(self.awardPreviewBtn:Find("Text"), i18n("week_task_award_preview_label"))

	self.phaseTxt = var_3_0:Find("phase/Text"):GetComponent(typeof(Text))
	self.progressSlider = var_3_0:Find("slider"):GetComponent(typeof(Slider))
	self.progressTxt = var_3_0:Find("slider/Text"):GetComponent(typeof(Text))
	self.awardList = UIItemList.New(var_3_0:Find("awards"), var_3_0:Find("awards/itemtpl"))
	self.getBtn = var_3_0:Find("get_btn")
	self.getBtnEnableTF = self.getBtn:Find("enable")
	self.getBtnDisableTF = self.getBtn:Find("disable")
	self.tip = var_3_0:Find("tip")

	onButton(self, self.awardPreviewBtn, function()
		self.contextData.ptAwardWindow:ExecuteAction("Display", self.contextData.weekTaskProgressInfo:GetAllPhaseDrops())

		return
	end, SFX_PANEL)

	return
end

function TaskWeekPage:onUpdateTask(arg_5_1, arg_5_2)
	TaskWeekPage.super.onUpdateTask(self, arg_5_1, arg_5_2)

	arg_5_2.name = self.taskCards[arg_5_2].taskVO.id

	return
end

function TaskWeekPage:Update(arg_6_1, arg_6_2, arg_6_3)
	if self.contextData.weekTaskProgressInfo:ReachMaxPt() and self:isShowing() then
		pg.UIMgr.GetInstance():LoadingOn(false)
		self:DoDisablePtTaskAnim(function()
			pg.UIMgr.GetInstance():LoadingOff()
			self:Flush(arg_6_2)

			if arg_6_3 then
				arg_6_3(self.taskVOs or {})
			end

			return
		end)
	elseif TaskScene.IsPassScenario() then
		self:Flush(arg_6_2)

		if arg_6_3 then
			arg_6_3(self.taskVOs or {})
		end
	else
		setActive(self._tf, false)

		if arg_6_3 then
			arg_6_3({})
		end
	end

	return
end

function TaskWeekPage:DoDisablePtTaskAnim(arg_8_1)
	local function var_8_0(arg_9_0, arg_9_1)
		arg_9_0:DoSubmitAnim(function()
			setActive(arg_9_0._go, false)
			arg_9_1()

			return
		end)

		return
	end

	self._scrollView.enabled = false

	local var_8_1 = {}

	for iter_8_0, iter_8_1 in ipairs(self.taskVOs or {}) do
		if iter_8_1.isWeekTask then
			local var_8_2 = self:GetCard(iter_8_1.id)

			if var_8_2 then
				table.insert(var_8_1, function(arg_11_0)
					var_8_0(var_8_2, arg_11_0)

					return
				end)
			end
		end
	end

	seriesAsync(var_8_1, function()
		self._scrollView.enabled = true

		arg_8_1()

		return
	end)

	return
end

function TaskWeekPage:GetCard(arg_13_1)
	for iter_13_0, iter_13_1 in pairs(self.taskCards) do
		if iter_13_1.taskVO.id == arg_13_1 then
			return iter_13_1
		end
	end

	return nil
end

function TaskWeekPage:Flush(arg_14_1)
	self.taskVOs = {}

	self:UpdateWeekProgress(self.contextData.weekTaskProgressInfo)

	if not self.contextData.weekTaskProgressInfo:ReachMaxPt() then
		for iter_14_0, iter_14_1 in pairs((self.contextData.weekTaskProgressInfo:GetSubTasks())) do
			table.insert(self.taskVOs, iter_14_1)
		end
	end

	for iter_14_2, iter_14_3 in pairs(self.contextData.taskVOsById) do
		if iter_14_3:ShowOnTaskScene() and arg_14_1[iter_14_3:GetRealType()] then
			table.insert(self.taskVOs, iter_14_3)
		end
	end

	table.sort(self.taskVOs, CompareFuncs({
		function(arg_15_0)
			return -arg_15_0.getTaskStatus(arg_15_0, arg_15_0)
		end,
		function(arg_16_0)
			return pg.NewGuideMgr.GetInstance():IsBusy() and arg_16_0.id == getDorm3dGameset("drom3d_weekly_task")[1] and 0 or 1
		end,
		function(arg_17_0)
			return arg_17_0.isWeekTask and 1 or 0
		end,
		function(arg_18_0)
			return arg_18_0.id
		end
	}))
	self:Show()

	self._scrollView.enabled = true

	self._scrollView:SetTotalCount(#self.taskVOs, -1)

	return
end

function TaskWeekPage:UpdateWeekProgress(arg_19_1)
	self:UpdateWeekProgressGetBtn(arg_19_1)

	self.phaseTxt.text = arg_19_1:GetPhase() .. "/" .. arg_19_1:GetTotalPhase()

	local var_19_0 = arg_19_1:GetProgress()
	local var_19_1 = arg_19_1:GetTarget()

	self.progressSlider.value = var_19_0 / var_19_1
	self.progressTxt.text = var_19_0 .. "/" .. var_19_1

	local var_19_2 = arg_19_1:GetDropList()

	self.awardList:make(function(arg_20_0, arg_20_1, arg_20_2)
		if arg_20_0 == UIItemList.EventUpdate then
			local var_20_0 = {
				type = var_19_2[arg_20_1 + 1][1],
				id = var_19_2[arg_20_1 + 1][2],
				count = var_19_2[arg_20_1 + 1][3]
			}

			updateDrop(arg_20_2, var_20_0)
			onButton(self, arg_20_2, function()
				self:emit(TaskMediator.ON_DROP, var_20_0)

				return
			end, SFX_PANEL)
		end

		return
	end)
	self.awardList:align(#var_19_2)

	return
end

function TaskWeekPage:UpdateWeekProgressGetBtn(arg_22_1)
	local var_22_0 = arg_22_1:CanUpgrade()

	setGray(self.getBtn, not var_22_0, false)
	setActive(self.getBtnEnableTF, var_22_0)
	setActive(self.getBtnDisableTF, not var_22_0)
	setActive(self.tip, var_22_0)
	onButton(self, self.getBtn, function()
		if var_22_0 then
			self:JudgeOverflow(arg_22_1, function()
				self:emit(TaskMediator.ON_SUBMIT_WEEK_PROGREE)

				return
			end)
		end

		return
	end, SFX_PANEL)

	return
end

function TaskWeekPage:JudgeOverflow(arg_25_1, arg_25_2)
	local var_25_0 = getProxy(PlayerProxy):getRawData()
	local var_25_2, var_25_3 = Task.StaticJudgeOverflow(var_25_0.gold, var_25_0.oil, LOCK_UR_SHIP and 0 or getProxy(BagProxy):GetLimitCntById(pg.gameset.urpt_chapter_max.description[1]), true, true, (arg_25_1:GetDropList()))

	if var_25_2 then
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_ITEM_BOX,
			content = i18n("award_max_warning"),
			items = var_25_3,
			onYes = arg_25_2
		})
	else
		arg_25_2()
	end

	return
end

function TaskWeekPage:OnDestroy()
	self._scrollView.onValueChanged:RemoveAllListeners()

	return
end

function TaskWeekPage:RefreshWeekTaskPageBefore(arg_27_1)
	local var_27_0 = self:GetCard(arg_27_1)

	if var_27_0 then
		setActive(var_27_0._go, false)
	end

	return
end

return TaskWeekPage
