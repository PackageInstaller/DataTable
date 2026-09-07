local JPSkirmishHeadFrameRePage = class("JPSkirmishHeadFrameRePage", import(".TemplatePage.FrameReTemplatePage"))

function JPSkirmishHeadFrameRePage:OnInit()
	self.bg = self._tf:Find("AD")
	self.battleBtn = self.bg:Find("GoBtn")
	self.getBtn = self.bg:Find("GetBtn")
	self.gotBtn = self.bg:Find("GotBtn")
	self.bar = self.bg:Find("Progress")
	self.progress = self.bg:Find("ProgressText")
	self.frameGot = self.bg:Find("GotTag")

	return
end

function JPSkirmishHeadFrameRePage:OnUpdateFlush()
	local var_2_0 = self.activity.data1
	local var_2_1 = self.avatarConfig.target

	var_2_0 = self.avatarConfig.target < self.activity.data1 and var_2_1 or var_2_0

	local var_2_2 = var_2_0 / var_2_1

	setText(self.progress, (var_2_0 / var_2_1 >= 1 and setColorStr(var_2_0, COLOR_GREEN) or var_2_0) .. "/" .. var_2_1)
	setSlider(self.bar, 0, 1, var_2_2)

	local var_2_3 = var_2_1 <= var_2_0
	local var_2_4 = self.activity.data2 >= 1
	local var_2_5 = self.avatarConfig.start_time

	if self.avatarConfig.start_time == "stop" then
		self.inTime = false
	else
		self.inTime = pg.TimeMgr.GetInstance():GetServerTime() - pg.TimeMgr.GetInstance():Table2ServerTime({
			year = var_2_5[1][1],
			month = var_2_5[1][2],
			day = var_2_5[1][3],
			hour = var_2_5[2][1],
			min = var_2_5[2][2],
			sec = var_2_5[2][3]
		}) > 0
	end

	setActive(self.battleBtn, self.inTime and not var_2_3 or false)
	setActive(self.getBtn, not var_2_4 and var_2_3)
	setActive(self.gotBtn, var_2_4)
	setActive(self.frameGot, var_2_4)

	return
end

return JPSkirmishHeadFrameRePage
