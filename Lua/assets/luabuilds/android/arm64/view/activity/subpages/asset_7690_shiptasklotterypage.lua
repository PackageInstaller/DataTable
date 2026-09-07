local ShipTaskLotteryPage = class("ShipTaskLotteryPage", import("...base.BaseActivityPage"))

function ShipTaskLotteryPage:OnInit()
	self.stepText = findTF(self._tf, "ad/step")
	self.progressSlider = findTF(self._tf, "ad/progressSlider")
	self.iconTf = findTF(self._tf, "ad/IconTpl")
	self.btnGet = findTF(self._tf, "ad/btnGet")
	self.btnGot = findTF(self._tf, "ad/btnGot")
	self.btnGo = findTF(self._tf, "ad/btnGo")
	self.taskDesc = findTF(self._tf, "ad/taskDesc")
	self.titleDesc = findTF(self._tf, "ad/titleDesc")
	self.progressDesc = findTF(self._tf, "ad/progressDesc")

	onButton(self, self.btnGet, function()
		if self.currentTask then
			self:emit(ActivityMediator.ON_TASK_SUBMIT, self.currentTask)
		end

		return
	end, SFX_CONFIRM)
	onButton(self, self.btnGo, function()
		if self.currentTask then
			self:emit(ActivityMediator.ON_TASK_GO, self.currentTask)
		end

		return
	end, SFX_CONFIRM)
	onButton(self, self.iconTf, function()
		self:emit(BaseUI.ON_DROP, self.drop)

		return
	end, SFX_PANEL)
	setText(self.titleDesc, i18n("ship_task_lottery_title"))

	return
end

function ShipTaskLotteryPage:OnFirstFlush()
	self.taskIds = self.activity:getConfig("config_data")

	self:updateUI()

	return
end

function ShipTaskLotteryPage:OnUpdateFlush()
	self:updateUI()

	return
end

function ShipTaskLotteryPage:updateUI()
	local var_7_0

	for iter_7_0 = 1, #self.taskIds do
		if not var_7_0 then
			var_7_0 = getProxy(TaskProxy):getTaskById(self.taskIds[iter_7_0])

			if var_7_0 then
				break
			end
		end
	end

	if not var_7_0 then
		for iter_7_1 = #self.taskIds, 1, -1 do
			var_7_0 = getProxy(TaskProxy):getFinishTaskById(self.taskIds[iter_7_1])

			if var_7_0 then
				break
			end
		end
	end

	if var_7_0 then
		self.currentTask = var_7_0

		self:showTaskUI()
	end

	return
end

function ShipTaskLotteryPage:showTaskUI()
	local var_8_0 = self.currentTask:getConfig("award_display")

	self.drop = {
		type = var_8_0[1][1],
		id = var_8_0[1][2],
		count = var_8_0[1][3]
	}

	updateDrop(self.iconTf, self.drop)
	setText(self.taskDesc, self.currentTask:getConfig("desc"))
	setText(self.progressDesc, self.currentTask:getProgress() .. "/" .. self.currentTask:getConfig("target_num"))
	setSlider(self.progressSlider, 0, self.currentTask:getConfig("target_num"), self.currentTask:getProgress())
	setActive(self.btnGet, self.currentTask:getTaskStatus() == 1)
	setActive(self.btnGo, self.currentTask:getTaskStatus() == 0)
	setActive(self.btnGot, self.currentTask:getTaskStatus() == 2)

	return
end

function ShipTaskLotteryPage:OnDestroy()
	return
end

return ShipTaskLotteryPage
