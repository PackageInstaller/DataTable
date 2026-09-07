local RefluxTaskView = class("RefluxTaskView", import("..base.BaseSubView"))

function RefluxTaskView:getUIName()
	return "RefluxTaskUI"
end

function RefluxTaskView:OnInit()
	self:initData()
	self:initUI()
	self:updateUI()

	return
end

function RefluxTaskView:OnDestroy()
	return
end

function RefluxTaskView:OnBackPress()
	self:Hide()

	return
end

function RefluxTaskView:initData()
	self.taskProxy = getProxy(TaskProxy)
	self.refluxProxy = getProxy(RefluxProxy)
	self.totalDayCount = pg.return_task_template[pg.return_task_template.all[#pg.return_task_template.all]].reward_date
	self.taskVOList = nil
	self.taskVOListForShow = nil
	self.lastSubmitTaskIDList = {}

	return
end

function RefluxTaskView:initUI()
	local var_6_0 = self._tf:Find("DayImg")

	self.daySpriteList = {}

	for iter_6_0 = 0, self.totalDayCount - 1 do
		table.insert(self.daySpriteList, (getImageSprite((var_6_0:GetChild(iter_6_0)))))
	end

	self.itemTpl = self._tf:Find("ItemTpl")
	self.taskUIList = UIItemList.New(self._tf:Find("ScrollRect/Container"), (self._tf:Find("TaskTpl")))

	self.taskUIList:make(function(arg_7_0, arg_7_1, arg_7_2)
		if arg_7_0 == UIItemList.EventUpdate then
			arg_7_1 = arg_7_1 + 1

			self:updateTask(arg_7_2, self.taskVOListForShow[arg_7_1])
		end

		return
	end)

	self.taskProgressText = self._tf:Find("BG/ProgressText")
	self.oneStepBtnDisable = self._tf:Find("OneStepDisable")
	self.oneStepBtn = self._tf:Find("OneStepBtn")

	onButton(self, self.oneStepBtn, function()
		if self:isTaskListOverflow() then
			pg.TipsMgr.GetInstance():ShowTips(i18n("award_overflow_tip"))

			return
		else
			local var_8_0 = {}
			local var_8_1 = {}

			for iter_8_0, iter_8_1 in ipairs((self:getTaskVOList())) do
				local var_8_2 = iter_8_1:getTaskStatus()
				local var_8_3, var_8_4 = self:isTaskOverflow(iter_8_1)

				if var_8_2 == 1 and self:isTaskUnlocked(iter_8_1) and not var_8_3 then
					table.insert(var_8_0, iter_8_1)
					table.insert(var_8_1, iter_8_1.id)
				end
			end

			if #var_8_0 > 0 then
				self:setLastSubmitTask(var_8_1)
				pg.m02:sendNotification(GAME.SUBMIT_TASK_ONESTEP, {
					resultList = var_8_0
				})
			end
		end

		return
	end, SFX_PANEL)

	return
end

function RefluxTaskView:updateData()
	self.taskVOList = self:getTaskVOList()
	self.taskVOListForShow = self:getTaskVOListForShow()

	return
end

function RefluxTaskView:updateUI()
	self:updateData()
	self:updateTaskList()
	self:updateTaskProgress()
	self:updateOneStepBtn()

	return
end

function RefluxTaskView:updateOutline()
	return
end

function RefluxTaskView:updateItem(arg_12_1, arg_12_2)
	local var_12_0 = arg_12_1:Find("Icon")

	setText(arg_12_1:Find("Count"), arg_12_2.count)

	if arg_12_2.type ~= DROP_TYPE_SHIP then
		setImageSprite(var_12_0, LoadSprite(arg_12_2:getIcon()))
	else
		setImageSprite(var_12_0, LoadSprite("QIcon/" .. Ship.New({
			configId = arg_12_2.id
		}):getPainting()))
	end

	return
end

function RefluxTaskView:updateTaskList()
	self.taskUIList:align(#self.taskVOListForShow)

	return
end

function RefluxTaskView:updateTask(arg_14_1, arg_14_2)
	local var_14_0 = arg_14_1:Find("Go")
	local var_14_1 = var_14_0:Find("Btn")
	local var_14_2 = var_14_0:Find("Progress")
	local var_14_3 = var_14_2:Find("Text")
	local var_14_4 = arg_14_1:Find("Get")
	local var_14_5 = var_14_4:Find("Btn")
	local var_14_6 = var_14_4:Find("Progress")
	local var_14_7 = var_14_6:Find("Text")
	local var_14_8 = arg_14_1:Find("Got")
	local var_14_9 = arg_14_2:getTaskStatus()

	setActive(var_14_0, var_14_9 == 0)
	setActive(var_14_4, var_14_9 == 1)
	setActive(var_14_8, var_14_9 == 2)
	setImageSprite(arg_14_1:Find("DayImg"), self.daySpriteList[self:getTaskUnlockSignCount(arg_14_2)])
	setActive(arg_14_1:Find("Lock"), not self:isTaskUnlocked(arg_14_2))
	setText(arg_14_1:Find("DescText"), arg_14_2:getConfig("desc"))

	local var_14_10 = arg_14_2:getProgress()
	local var_14_11 = arg_14_2:getConfig("target_num")

	setSlider(var_14_2, 0, var_14_11, var_14_10)
	setText(var_14_3, var_14_10 .. "/" .. var_14_11)
	setSlider(var_14_6, 0, var_14_11, var_14_10)
	setText(var_14_7, var_14_10 .. "/" .. var_14_11)

	local var_14_12 = self:getTaskAwardForShow(arg_14_2)
	local var_14_13 = UIItemList.New(arg_14_1:Find("Drops"), self.itemTpl)

	var_14_13:make(function(arg_15_0, arg_15_1, arg_15_2)
		if arg_15_0 == UIItemList.EventUpdate then
			arg_15_1 = arg_15_1 + 1

			self:updateItem(arg_15_2, var_14_12[arg_15_1])
		end

		return
	end)
	var_14_13:align(#var_14_12)
	onButton(self, var_14_1, function()
		pg.m02:sendNotification(GAME.TASK_GO, {
			taskVO = arg_14_2
		})

		return
	end, SFX_PANEL)
	onButton(self, var_14_5, function()
		local function var_17_0()
			pg.m02:sendNotification(GAME.SUBMIT_TASK, arg_14_2.id)
			self:setLastSubmitTask({
				arg_14_2.id
			})

			return
		end

		local var_17_1, var_17_2 = self:isTaskOverflow(arg_14_2)

		if var_17_1 then
			pg.MsgboxMgr.GetInstance():ShowMsgBox({
				type = MSGBOX_TYPE_ITEM_BOX,
				content = i18n("award_max_warning"),
				items = var_17_2,
				onYes = var_17_0
			})
		else
			var_17_0()
		end

		return
	end, SFX_PANEL)

	return
end

function RefluxTaskView:updateTaskProgress()
	local var_19_0 = self:getTaskVOList()
	local var_19_1 = 0

	for iter_19_0, iter_19_1 in ipairs(var_19_0) do
		if self:isTaskUnlocked(iter_19_1) then
			var_19_1 = var_19_1 + 1
		end
	end

	setText(self.taskProgressText, var_19_1 .. "/" .. #var_19_0)

	return
end

function RefluxTaskView:updateOneStepBtn()
	local var_20_0 = 0

	for iter_20_0, iter_20_1 in ipairs((self:getTaskVOList())) do
		if iter_20_1:getTaskStatus() == 1 and self:isTaskUnlocked(iter_20_1) then
			var_20_0 = var_20_0 + 1
		end
	end

	setActive(self.oneStepBtnDisable, not (var_20_0 > 1))

	return
end

function RefluxTaskView:getTaskVOList()
	local var_21_0 = {}

	for iter_21_0, iter_21_1 in ipairs(pg.return_task_template.all) do
		table.insert(var_21_0, (self.taskProxy:getTaskVO(iter_21_1)))
	end

	return var_21_0
end

function RefluxTaskView:getTaskVOListForShow()
	local var_22_0 = {}
	local var_22_1 = {}

	for iter_22_0, iter_22_1 in ipairs(self.taskVOList) do
		if self:isTaskUnlocked(iter_22_1) then
			table.insert(var_22_0, iter_22_1)
		else
			table.insert(var_22_1, iter_22_1)
		end
	end

	table.sort(var_22_0, function(arg_23_0, arg_23_1)
		local var_23_0 = arg_23_0:getTaskStatus()
		local var_23_1 = arg_23_1:getTaskStatus()

		if var_23_0 == 2 then
			var_23_0 = -1
		end

		if var_23_1 == 2 then
			var_23_1 = -1
		end

		if var_23_0 == var_23_1 then
			return self:getTaskUnlockSignCount(arg_23_0) < self:getTaskUnlockSignCount(arg_23_1)
		else
			return var_23_1 < var_23_0
		end

		return
	end)
	table.sort(var_22_1, function(arg_24_0, arg_24_1)
		return arg_24_0.id < arg_24_1.id
	end)

	local var_22_2 = {}

	for iter_22_2, iter_22_3 in ipairs(var_22_0) do
		table.insert(var_22_2, iter_22_3)
	end

	for iter_22_4, iter_22_5 in ipairs(var_22_1) do
		table.insert(var_22_2, iter_22_5)
	end

	return var_22_2
end

function RefluxTaskView:getTaskUnlockSignCount(arg_25_1)
	return pg.return_task_template[arg_25_1.id].reward_date
end

function RefluxTaskView:isTaskUnlocked(arg_26_1)
	return self:getTaskUnlockSignCount(arg_26_1) <= self.refluxProxy.signCount
end

function RefluxTaskView:isTaskOverflow(arg_27_1)
	local var_27_0 = getProxy(PlayerProxy):getRawData()
	local var_27_1 = LOCK_UR_SHIP and 0 or getProxy(BagProxy):GetLimitCntById(pg.gameset.urpt_chapter_max.description[1])
	local var_27_2 = self:getTaskAwardForShow(arg_27_1)
	local var_27_3, var_27_4 = Task.StaticJudgeOverflow(false, false, false, true, true, {
		{
			var_27_2[1].type,
			var_27_2[1].id,
			var_27_2[1].count
		}
	})

	return var_27_3, var_27_4
end

function RefluxTaskView:isTaskListOverflow()
	local var_28_0 = {}

	for iter_28_0, iter_28_1 in ipairs((self:getTaskVOList())) do
		if iter_28_1:getTaskStatus() == 1 and self:isTaskUnlocked(iter_28_1) then
			local var_28_1 = self:getTaskAwardForShow(iter_28_1)
			local var_28_2 = var_28_1[1].id
			local var_28_3 = var_28_0[var_28_1[1].id]

			if not var_28_0[var_28_1[1].id] then
				var_28_3 = {
					var_28_1[1].type,
					var_28_2,
					var_28_1[1].count
				}
			else
				var_28_3[3] = var_28_3[3] + var_28_1[1].count
			end

			var_28_0[var_28_2] = var_28_3
		end
	end

	local var_28_4 = {}

	for iter_28_2, iter_28_3 in pairs(var_28_0) do
		table.insert(var_28_4, iter_28_3)
	end

	local var_28_5, var_28_6 = Task.StaticJudgeOverflow(false, false, false, true, true, var_28_4)

	return var_28_5, var_28_6
end

function RefluxTaskView:setLastSubmitTask(arg_29_1)
	self.lastSubmitTaskIDList = arg_29_1

	return
end

function RefluxTaskView:clearLastSubmitTask()
	self.lastSubmitTaskIDList = {}

	return
end

function RefluxTaskView:calcLastSubmitTaskPT()
	local var_31_0 = 0
	local var_31_1 = 0

	for iter_31_0, iter_31_1 in ipairs(self.lastSubmitTaskIDList) do
		var_31_0 = var_31_0 + pg.return_task_template[iter_31_1].pt_award
		var_31_1 = pg.return_task_template[iter_31_1].pt_item
	end

	self:clearLastSubmitTask()

	return {
		type = DROP_TYPE_ITEM,
		id = var_31_1,
		count = var_31_0
	}
end

function RefluxTaskView:getTaskAwardForShow(arg_32_1)
	local var_32_0

	for iter_32_0, iter_32_1 in ipairs(pg.return_task_template[arg_32_1.id].level) do
		if iter_32_1[1] <= self.refluxProxy.returnLV and self.refluxProxy.returnLV <= iter_32_1[2] then
			var_32_0 = iter_32_0
		end
	end

	local var_32_1 = {}

	table.insert(var_32_1, (Drop.New({
		type = pg.return_task_template[arg_32_1.id].award_display[var_32_0][1],
		id = pg.return_task_template[arg_32_1.id].award_display[var_32_0][2],
		count = pg.return_task_template[arg_32_1.id].award_display[var_32_0][3]
	})))
	table.insert(var_32_1, (Drop.New({
		type = DROP_TYPE_ITEM,
		id = pg.return_task_template[arg_32_1.id].pt_item,
		count = pg.return_task_template[arg_32_1.id].pt_award
	})))

	return var_32_1
end

function RefluxTaskView.isAnyTaskCanGetAward()
	local var_33_0 = getProxy(TaskProxy)
	local var_33_1 = getProxy(RefluxProxy)
	local var_33_2 = {}

	for iter_33_0, iter_33_1 in ipairs(pg.return_task_template.all) do
		table.insert(var_33_2, (var_33_0:getTaskVO(iter_33_1)))
	end

	local function var_33_3(arg_34_0)
		return pg.return_task_template[arg_34_0.id].reward_date
	end

	local function var_33_4(arg_35_0)
		return var_33_3(arg_35_0) <= var_33_1.signCount
	end

	for iter_33_2, iter_33_3 in ipairs(var_33_2) do
		if iter_33_3:getTaskStatus() == 1 and var_33_4(iter_33_3) then
			return true
		end
	end

	return false
end

return RefluxTaskView
