local HMSHardyTaskPage = class("HMSHardyTaskPage", import(".TemplatePage.PassChaptersTemplatePage"))

function HMSHardyTaskPage:OnInit()
	HMSHardyTaskPage.super.OnInit(self)

	self.notGetBtn = self.bg:Find("not_get_btn")
	self.goHuntBtn = self.bg:Find("gohunt_btn")

	return
end

function HMSHardyTaskPage:OnFirstFlush()
	HMSHardyTaskPage.super.OnFirstFlush(self)
	onButton(self, self.goHuntBtn, function()
		self:emit(ActivityMediator.SELECT_ACTIVITY, pg.activity_const.HMS_Hunter_PT_ID.act_id)

		return
	end, SFX_PANEL)
	onButton(self, self.notGetBtn, function()
		self:emit(ActivityMediator.BATTLE_OPERA)

		return
	end, SFX_PANEL)
	onButton(self, self.battleBtn, function()
		pg.m02:sendNotification(GAME.GO_SCENE, SCENE.TASK)

		return
	end, SFX_PANEL)
	onButton(self, self.buildBtn, function()
		pg.m02:sendNotification(GAME.GO_SCENE, SCENE.GETBOAT, {
			page = BuildShipScene.PAGE_BUILD,
			projectName = BuildShipScene.PROJECTS.LIGHT
		})

		return
	end, SFX_PANEL)

	return
end

function HMSHardyTaskPage:OnUpdateFlush()
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
		setText(self.step, self.taskIndex)
	end

	local var_7_2 = self.taskVO:getProgress()
	local var_7_3 = self.taskVO:getConfig("target_num")

	setText(self.desc, self.taskVO:getConfig("desc"))
	setText(self.progress, var_7_2 .. "/" .. var_7_3)
	setSlider(self.slider, 0, var_7_3, var_7_2)

	local var_7_4 = self.taskVO:getTaskStatus()

	setActive(self.notGetBtn, var_7_4 == 0)
	setActive(self.getBtn, var_7_4 == 1)
	setActive(self.gotBtn, var_7_4 == 2)

	return
end

return HMSHardyTaskPage
