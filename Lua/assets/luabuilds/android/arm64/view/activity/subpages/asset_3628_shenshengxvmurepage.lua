local ShenshengxvmuRePage = class("ShenshengxvmuRePage", import("...base.BaseActivityPage"))

function ShenshengxvmuRePage:OnInit()
	self.bg = self._tf:Find("AD")
	self.step = self.bg:Find("step")
	self.progress = self.bg:Find("progress")
	self.displayBtn = self.bg:Find("display_btn")
	self.awardTF = self.bg:Find("award")
	self.battleBtn = self.bg:Find("battle_btn")
	self.getBtn = self.bg:Find("get_btn")
	self.gotBtn = self.bg:Find("got_btn")

	return
end

function ShenshengxvmuRePage:OnFirstFlush()
	ShenshengxvmuRePage.super.OnFirstFlush(self)
	setActive(self.displayBtn, false)
	setActive(self.awardTF, false)
	onButton(self, self.battleBtn, function()
		self:emit(ActivityMediator.EVENT_GO_SCENE, SCENE.TASK, {
			page = "activity"
		})

		return
	end, SFX_PANEL)

	self.step = self._tf:Find("AD/step")
	self.progress = self._tf:Find("AD/progress")
	self.bar = self._tf:Find("AD/slider/bar")

	local var_2_0 = pg.activity_event_avatarframe[self.activity:getConfig("config_id")].start_time

	if var_2_0 == "stop" then
		self.inTime = false
	end

	local var_2_2

	do
		self.inTime = pg.TimeMgr.GetInstance():GetServerTime() - pg.TimeMgr.GetInstance():Table2ServerTime({
			year = var_2_0[1][1],
			month = var_2_0[1][2],
			day = var_2_0[1][3],
			hour = var_2_0[2][1],
			min = var_2_0[2][2],
			sec = var_2_0[2][3]
		}) > 0
		var_2_2 = isActive(self.battleBtn) and self.inTime
	end

	setActive(self.battleBtn, var_2_2)

	return
end

function ShenshengxvmuRePage:Switch(arg_4_1)
	self:UpdateAwardGot()
	onButton(self, self.getBtn, function()
		self:emit(ActivityMediator.EVENT_OPERATION, {
			cmd = 1,
			activity_id = self.activity.id
		})

		return
	end, SFX_PANEL)

	return
end

function ShenshengxvmuRePage:UpdateAwardGot()
	setActive(self._tf:Find("AD/got"), self.activity.data2 >= 1)

	return
end

function ShenshengxvmuRePage:OnUpdateFlush()
	setActive(self.battleBtn, isActive(self.battleBtn) and self.inTime)
	self:UpdateAwardGot()

	local var_7_1 = self.activity.data1
	local var_7_2 = pg.activity_event_avatarframe[self.activity:getConfig("config_id")].target
	local var_7_4
	local var_7_3

	if var_7_2 < self.activity.data1 then
		var_7_1 = var_7_2
		var_7_3 = setText
		var_7_4 = self.step
	end

	var_7_3(var_7_4, var_7_1 / var_7_2 >= 1 and setColorStr(var_7_1, "#487CFFFF") or var_7_1)
	setText(self.progress, "/" .. var_7_2)
	setFillAmount(self.bar, var_7_1 / var_7_2)

	local var_7_5 = var_7_2 <= var_7_1
	local var_7_6 = self.activity.data2 >= 1

	setActive(self.battleBtn, not (self.activity.data2 >= 1) and not var_7_5 and self.inTime)
	setActive(self.getBtn, var_7_5 and not var_7_6)
	setActive(self.gotBtn, var_7_6)

	return
end

return ShenshengxvmuRePage
