local U110BattlePage = class("U110BattlePage", import("...base.BaseActivityPage"))

function U110BattlePage:OnInit()
	self.bg = self._tf:Find("AD")
	self.slider = self.bg:Find("slider")
	self.step = self.bg:Find("step")
	self.progress = self.bg:Find("progress")
	self.desc = self.bg:Find("desc")
	self.awardTF = self.bg:Find("award")
	self.battleBtn = self.bg:Find("battle_btn")
	self.getBtn = self.bg:Find("get_btn")
	self.gotBtn = self.bg:Find("got_btn")
	self.buildBtn = self.bg:Find("build_btn")

	return
end

function U110BattlePage:OnDataSetting()
	self.taskIDList = _.flatten((self.activity:getConfig("config_data")))
	self.taskProxy = getProxy(TaskProxy)

	return
end

function U110BattlePage:OnFirstFlush()
	onButton(self, self.battleBtn, function()
		local var_4_0 = getProxy(ActivityProxy):getActivityById(ActivityConst.ACTIVITY_U110_BATTLE_LEVEL)

		if not var_4_0 or var_4_0:isEnd() then
			pg.TipsMgr.GetInstance():ShowTips(i18n("challenge_end_tip"))

			return
		end

		self:emit(ActivityMediator.SPECIAL_BATTLE_OPERA)

		return
	end, SFX_PANEL)
	onButton(self, self.getBtn, function()
		self:emit(ActivityMediator.ON_TASK_SUBMIT, self.curTaskVO)

		return
	end, SFX_PANEL)
	onButton(self, self.buildBtn, function()
		local var_6_0 = getProxy(ActivityProxy):getActivityById(ActivityConst.ACTIVITY_U110_BUILD)

		if not var_6_0 or var_6_0:isEnd() then
			pg.TipsMgr.GetInstance():ShowTips(i18n("challenge_end_tip"))

			return
		end

		self:emit(ActivityMediator.EVENT_GO_SCENE, SCENE.GETBOAT, {
			projectName = BuildShipScene.PROJECTS.SPECIAL
		})

		return
	end)

	return
end

function U110BattlePage:OnUpdateFlush()
	local var_7_0 = self:findCurTaskIndex()

	setText(self.step, var_7_0 .. "/" .. #self.taskIDList)

	local var_7_1 = self.taskIDList[var_7_0]
	local var_7_2 = self.taskProxy:getTaskVO(self.taskIDList[var_7_0])

	self.curTaskVO = var_7_2

	local var_7_3 = var_7_2:getProgress()
	local var_7_4 = var_7_2:getConfig("target_num")

	setText(self.progress, (var_7_4 <= var_7_3 and setColorStr(var_7_3, COLOR_GREEN) or var_7_3) .. "/" .. var_7_4)
	setSlider(self.slider, 0, var_7_4, var_7_3)

	local var_7_5 = var_7_2:getConfig("award_display")[1]
	local var_7_6 = {
		type = var_7_5[1],
		id = var_7_5[2],
		count = var_7_5[3]
	}

	updateDrop(self.awardTF, var_7_6)
	onButton(self, self.awardTF, function()
		self:emit(BaseUI.ON_DROP, var_7_6)

		return
	end, SFX_PANEL)
	setText(self.desc, pg.task_data_template[var_7_1].desc)

	local var_7_7 = var_7_2:getTaskStatus()

	setActive(self.battleBtn, var_7_7 == 0)
	setActive(self.getBtn, var_7_7 == 1)
	setActive(self.gotBtn, var_7_7 == 2)

	return
end

function U110BattlePage:OnDestroy()
	return
end

function U110BattlePage:findCurTaskIndex()
	local var_10_0

	for iter_10_0, iter_10_1 in ipairs(self.taskIDList) do
		if self.taskProxy:getTaskVO(iter_10_1):getTaskStatus() <= 1 then
			var_10_0 = iter_10_0

			break
		elseif iter_10_0 == #self.taskIDList then
			var_10_0 = iter_10_0
		end
	end

	return var_10_0
end

return U110BattlePage
