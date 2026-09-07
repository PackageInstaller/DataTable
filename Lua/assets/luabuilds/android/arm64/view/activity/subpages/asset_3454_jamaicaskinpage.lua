local JamaicaSkinPage = class("JamaicaSkinPage", import("...base.BaseActivityPage"))

function JamaicaSkinPage:OnInit()
	self.bg = self._tf:Find("AD")
	self.slider = self.bg:Find("slider")
	self.step = self.bg:Find("step")
	self.progress = self.bg:Find("progress")
	self.awardTF = self.bg:Find("award")
	self.battleBtn = self.bg:Find("battle_btn")
	self.getBtn = self.bg:Find("get_btn")
	self.gotBtn = self.bg:Find("got_btn")

	return
end

function JamaicaSkinPage:OnDataSetting()
	self.taskIDList = _.flatten((self.activity:getConfig("config_data")))
	self.dropList = {}
	self.descs = {}

	for iter_2_0, iter_2_1 in ipairs(self.taskIDList) do
		table.insert(self.dropList, Clone(pg.task_data_template[iter_2_1].award_display[1]))
		table.insert(self.descs, pg.task_data_template[iter_2_1].desc)
	end

	return updateActivityTaskStatus(self.activity)
end

function JamaicaSkinPage:OnFirstFlush()
	onButton(self, self.battleBtn, function()
		self:emit(ActivityMediator.SPECIAL_BATTLE_OPERA)

		return
	end, SFX_PANEL)
	onButton(self, self.getBtn, function()
		self:emit(ActivityMediator.ON_TASK_SUBMIT, self.curTaskVO)

		return
	end, SFX_PANEL)

	return
end

function JamaicaSkinPage:OnUpdateFlush()
	local var_6_0, var_6_1 = getActivityTask(self.activity)

	self.curTaskVO = var_6_1

	local var_6_2 = var_6_1:getConfig("award_display")[1]
	local var_6_3 = {
		type = var_6_2[1],
		id = var_6_2[2],
		count = var_6_2[3]
	}

	updateDrop(self.awardTF, var_6_3)
	onButton(self, self.awardTF, function()
		self:emit(BaseUI.ON_DROP, var_6_3)

		return
	end, SFX_PANEL)

	local var_6_4 = var_6_1:getProgress()
	local var_6_5 = var_6_1:getConfig("target_num")

	setText(self.progress, (var_6_5 <= var_6_4 and setColorStr(var_6_4, COLOR_GREEN) or var_6_4) .. "/" .. var_6_5)
	setSlider(self.slider, 0, var_6_5, var_6_4)

	local var_6_6 = table.indexof(self.taskIDList, var_6_0, 1)

	setText(self.step, var_6_6 .. "/" .. #self.taskIDList)

	local var_6_7 = var_6_1:getTaskStatus()

	setActive(self.battleBtn, var_6_7 == 0)
	setActive(self.getBtn, var_6_7 == 1)
	setActive(self.gotBtn, var_6_7 == 2)

	self.finishedIndex = var_6_7 == 2 and var_6_6 or var_6_6 - 1

	return
end

function JamaicaSkinPage:OnDestroy()
	return
end

return JamaicaSkinPage
