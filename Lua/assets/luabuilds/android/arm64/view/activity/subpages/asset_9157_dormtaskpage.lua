local DormTaskPage = class("DormTaskPage", import("...base.BaseActivityPage"))

function DormTaskPage:OnInit()
	self.bg = self._tf:Find("AD")
	self.slider = self.bg:Find("slider"):GetComponent(typeof(Slider))
	self.step = self.bg:Find("step"):GetComponent(typeof(Text))
	self.stepMax = self.bg:Find("step_max"):GetComponent(typeof(Text))
	self.progress = self.bg:Find("progress"):GetComponent(typeof(Text))
	self.desc = self.bg:Find("desc"):GetComponent(typeof(Text))
	self.awardTF = self.bg:Find("award")
	self.awardGot = self.bg:Find("award_got")
	self.battleBtn = self.bg:Find("battle_btn")
	self.getBtn = self.bg:Find("get_btn")
	self.gotBtn = self.bg:Find("got_btn")

	return
end

function DormTaskPage:OnDataSetting()
	self.nday = 0
	self.taskProxy = getProxy(TaskProxy)
	self.taskGroup = self.activity:getConfig("config_client").unlock_task

	return updateActivityTaskStatus(self.activity)
end

function DormTaskPage:OnFirstFlush()
	onButton(self, self.battleBtn, function()
		self:emit(ActivityMediator.ON_TASK_GO, self.taskVO)

		return
	end, SFX_PANEL)
	onButton(self, self.getBtn, function()
		self:emit(ActivityMediator.ON_TASK_SUBMIT, self.taskVO)

		return
	end, SFX_PANEL)
	setText(self.stepMax, "/" .. #self.taskGroup)

	return
end

function DormTaskPage:OnUpdateFlush()
	self.taskIndex = self:getTaskIdx(self.activity)
	self.taskVO = self.taskProxy:getTaskById(self.taskGroup[self.taskIndex][1]) or self.taskProxy:getFinishTaskById(self.taskGroup[self.taskIndex][1])

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
		setText(self.step, "DAY" .. self.taskIndex)
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
	setActive(self.awardGot, var_6_4 == 2)

	return
end

function DormTaskPage:getTaskIdx(arg_8_1)
	local var_8_0 = 1
	local var_8_1 = math.min(arg_8_1:getNDay(), #self.taskGroup)

	for iter_8_0 = 1, var_8_1 do
		if not true then
			break
		end

		var_8_0 = iter_8_0

		if iter_8_0 < var_8_1 then
			for iter_8_1, iter_8_2 in ipairs(self.taskGroup[iter_8_0]) do
				if not self:isTaskFinished(iter_8_2) then
					break
				end
			end
		end
	end

	return math.min(var_8_0, #self.taskGroup)
end

function DormTaskPage:isTaskFinished(arg_9_1)
	self.taskProxy = self.taskProxy or getProxy(TaskProxy)

	local var_9_0 = self.taskProxy:getTaskById(arg_9_1) or self.taskProxy:getFinishTaskById(arg_9_1)

	return var_9_0 and var_9_0:getTaskStatus() == 2
end

return DormTaskPage
