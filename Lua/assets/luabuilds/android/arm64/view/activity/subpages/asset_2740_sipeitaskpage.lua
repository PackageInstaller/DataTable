local SipeiTaskPage = class("SipeiTaskPage", import("...base.BaseActivityPage"))

function SipeiTaskPage:OnInit()
	self.bg = self._tf:Find("AD")
	self.slider = self.bg:Find("slider"):GetComponent(typeof(Slider))
	self.step = self.bg:Find("step"):GetComponent(typeof(Text))
	self.progress = self.bg:Find("progress"):GetComponent(typeof(Text))
	self.desc = self.bg:Find("desc"):GetComponent(typeof(Text))
	self.awardTF = self.bg:Find("award")
	self.battleBtn = self.bg:Find("battle_btn")
	self.getBtn = self.bg:Find("get_btn")
	self.gotBtn = self.bg:Find("got_btn")

	return
end

function SipeiTaskPage:OnDataSetting()
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

function SipeiTaskPage:OnFirstFlush()
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

function SipeiTaskPage:OnUpdateFlush()
	local var_6_0 = self.taskVO:getConfig("award_display")[1]
	local var_6_1 = {
		type = var_6_0[1],
		id = var_6_0[2],
		count = var_6_0[3]
	}

	updateDrop(self.awardTF, var_6_1)
	onButton(self, self.awardTF, function()
		self:emit(BaseUI.ON_DROP, var_6_1)

		return
	end, SFX_PANEL)

	if self.step then
		setText(self.step, self.taskIndex .. "/" .. #self.taskList)
	end

	local var_6_2 = self.taskVO:getProgress()
	local var_6_3 = self.taskVO:getConfig("target_num")

	setText(self.desc, self.taskVO:getConfig("desc"))
	setText(self.progress, var_6_2 .. "/" .. var_6_3)
	setSlider(self.slider, 0, var_6_3, var_6_2)

	local var_6_4 = self.taskVO:getTaskStatus()

	setActive(self.battleBtn, var_6_4 == 0)
	setActive(self.getBtn, var_6_4 == 1)
	setActive(self.gotBtn, var_6_4 == 2)

	return
end

function SipeiTaskPage:OnDestroy()
	return
end

return SipeiTaskPage
