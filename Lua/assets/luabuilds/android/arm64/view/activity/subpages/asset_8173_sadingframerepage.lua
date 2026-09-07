local SaDingFrameRePage = class("SaDingFrameRePage", import("view.base.BaseActivityPage"))

function SaDingFrameRePage:OnInit()
	self.bg = self._tf:Find("AD")
	self.battleBtn = self.bg:Find("battle_btn")
	self.getBtn = self.bg:Find("get_btn")
	self.gotBtn = self.bg:Find("got_btn")
	self.bar = GetComponent(self._tf:Find("AD/switcher/phase2/barContent"), typeof(Slider))
	self.cur = self._tf:Find("AD/switcher/phase2/progress/step")
	self.target = self._tf:Find("AD/switcher/phase2/progress/all")
	self.getTag = self._tf:Find("AD/switcher/phase2/get")
	self.gotTag = self._tf:Find("AD/switcher/phase2/got")

	return
end

function SaDingFrameRePage:OnDataSetting()
	self.avatarConfig = pg.activity_event_avatarframe[self.activity:getConfig("config_id")]

	if self.avatarConfig.start_time == "stop" then
		self.timeStamp = nil
	else
		self.timeStamp = pg.TimeMgr.GetInstance():parseTimeFromConfig(self.avatarConfig.start_time)
	end

	return
end

function SaDingFrameRePage:OnFirstFlush()
	onButton(self, self.battleBtn, function()
		self:emit(ActivityMediator.EVENT_GO_SCENE, SCENE.TASK)

		return
	end, SFX_PANEL)
	onButton(self, self.getBtn, function()
		self:emit(ActivityMediator.EVENT_OPERATION, {
			cmd = 1,
			activity_id = self.activity.id
		})

		return
	end, SFX_PANEL)

	self.inPhase2 = self.timeStamp and pg.TimeMgr.GetInstance():GetServerTime() - self.timeStamp > 0

	return
end

function SaDingFrameRePage:OnUpdateFlush()
	local var_6_0 = self.activity.data1
	local var_6_1 = self.avatarConfig.target
	local var_6_3
	local var_6_2

	if self.avatarConfig.target < self.activity.data1 and not var_6_1 then
		var_6_2 = setText
		var_6_3 = self.cur
	end

	var_6_2(var_6_3, var_6_0 / var_6_1 >= 1 and setColorStr(var_6_0, COLOR_GREEN) or var_6_0)
	setText(self.target, "/" .. var_6_1)
	setSlider(self.bar, 0, var_6_1, var_6_0)

	local var_6_4 = var_6_1 <= var_6_0
	local var_6_5 = self.activity.data2 >= 1

	setActive(self.battleBtn, self.inPhase2 and not var_6_4)
	setActive(self.getBtn, self.inPhase2 and not var_6_5 and var_6_4)
	setActive(self.gotBtn, self.inPhase2 and var_6_5)
	setActive(self.getTag, self.inPhase2 and not var_6_5 and var_6_4)
	setActive(self.gotTag, self.inPhase2 and var_6_5)
	setActive(self._tf:Find("AD/switcher/phase2/progress"), not var_6_5)

	return
end

return SaDingFrameRePage
