local GloryTaskPage = class("GloryTaskPage", import("...base.BaseActivityPage"))

function GloryTaskPage:OnInit()
	self.bg = self._tf:Find("AD")
	self.slider = self.bg:Find("slider")
	self.step = self.bg:Find("step")
	self.progress = self.bg:Find("progress")
	self.displayBtn = self.bg:Find("display_btn")
	self.awardTF = self.bg:Find("award")
	self.battleBtn = self.bg:Find("battle_btn")
	self.getBtn = self.bg:Find("get_btn")

	return
end

function GloryTaskPage:OnDataSetting()
	local var_2_0 = getProxy(TaskProxy)

	self.taskList = self.taskList or self.activity:getConfig("config_data")

	for iter_2_0, iter_2_1 in ipairs(self.taskList) do
		self.taskIndex = iter_2_0
		self.taskVO = var_2_0:getTaskVO(iter_2_1)

		if not self.taskVO:isReceive() then
			break
		end
	end

	assert(self.taskVO, "without any taskVO!!!")

	return
end

function GloryTaskPage:OnFirstFlush()
	onButton(self, self.displayBtn, function()
		self:emit(ActivityMediator.SHOW_AWARD_WINDOW, GloryAwardWindow, {
			taskList = self.taskList,
			taskVO = self.taskVO
		})

		return
	end, SFX_PANEL)
	onButton(self, self.battleBtn, function()
		self:emit(ActivityMediator.BATTLE_OPERA)

		return
	end, SFX_PANEL)
	onButton(self, self.getBtn, function()
		self:emit(ActivityMediator.ON_TASK_SUBMIT, self.taskVO)

		return
	end, SFX_PANEL)

	return
end

function GloryTaskPage:OnUpdateFlush()
	local var_7_0 = self.taskVO:getConfig("award_display")[1]
	local var_7_1 = {
		type = var_7_0[1],
		id = var_7_0[2],
		count = var_7_0[3]
	}

	updateDrop(self.awardTF, var_7_1)
	onButton(self, self.awardTF, function()
		self:emit(BaseUI.ON_DROP, var_7_1)

		return
	end, SFX_PANEL)

	if self.step then
		setText(self.step, self.taskIndex .. "/" .. #self.taskList)
	end

	local var_7_2 = self.taskVO:getProgress()
	local var_7_3 = self.taskVO:getConfig("target_num")

	setText(self.progress, var_7_2 .. "/" .. var_7_3)
	setSlider(self.slider, 0, var_7_3, var_7_2)

	local var_7_4 = self.taskVO:getTaskStatus()

	setActive(self.battleBtn, var_7_4 == 0)
	setActive(self.getBtn, var_7_4 == 1)

	return
end

function GloryTaskPage:OnDestroy()
	return
end

return GloryTaskPage
