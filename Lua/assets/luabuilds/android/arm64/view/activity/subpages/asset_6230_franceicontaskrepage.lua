local FranceIconTaskRePage = class("FranceIconTaskRePage", import("...base.BaseActivityPage"))

function FranceIconTaskRePage:OnInit()
	self.bg = self._tf:Find("AD")
	self.slider = self.bg:Find("slider")
	self.step = self.bg:Find("step")
	self.progress = self.bg:Find("progress")
	self.displayBtn = self.bg:Find("display_btn")
	self.awardTF = self.bg:Find("award")
	self.battleBtn = self.bg:Find("battle_btn")
	self.getBtn = self.bg:Find("get_btn")
	self.gotBtn = self.bg:Find("got_btn")

	return
end

function FranceIconTaskRePage:OnFirstFlush()
	FranceIconTaskRePage.super.OnFirstFlush(self)
	setActive(self.displayBtn, false)
	setActive(self.awardTF, false)
	onButton(self, self.battleBtn, function()
		self:emit(ActivityMediator.EVENT_GO_SCENE, SCENE.TASK, {
			page = "activity"
		})

		return
	end, SFX_PANEL)

	self.step = self._tf:Find("AD/switcher/phase2/Image/step")
	self.progress = self._tf:Find("AD/switcher/phase2/Image/progress")
	self.switchBtn = self._tf:Find("AD/switcher/switch_btn")
	self.bar = self._tf:Find("AD/switcher/phase2/Image/barContent/bar")
	self.phases = {
		self._tf:Find("AD/switcher/phase1"),
		self._tf:Find("AD/switcher/phase2")
	}
	self.inPhase2 = false

	onToggle(self, self.switchBtn, function(arg_4_0)
		if self.isSwitching then
			return
		end

		self.inPhase2 = arg_4_0

		self:Switch(arg_4_0)

		return
	end, SFX_PANEL)

	local var_2_0 = pg.activity_event_avatarframe[self.activity:getConfig("config_id")].start_time

	self.inTime = pg.TimeMgr.GetInstance():GetServerTime() - pg.TimeMgr.GetInstance():Table2ServerTime({
		year = var_2_0[1][1],
		month = var_2_0[1][2],
		day = var_2_0[1][3],
		hour = var_2_0[2][1],
		min = var_2_0[2][2],
		sec = var_2_0[2][3]
	}) > 0

	setActive(self.battleBtn, isActive(self.battleBtn) and self.inTime)

	if self.inTime then
		triggerToggle(self.switchBtn, true)
	end

	return
end

function FranceIconTaskRePage:Switch(arg_5_1)
	self.isSwitching = true

	local var_5_0 = GetOrAddComponent(self.phases[1], typeof(CanvasGroup))

	self.phases[2]:SetAsLastSibling()
	setActive(self.phases[1]:Find("Image"), false)
	LeanTween.moveLocal(go(self.phases[1]), self.phases[2].localPosition, 0.4):setOnComplete(System.Action(function()
		setActive(self.phases[1]:Find("label"), true)

		return
	end))
	LeanTween.value(go(self.phases[1]), 0, 1, 0.4):setOnUpdate(System.Action_float(function(arg_7_0)
		var_5_0.alpha = arg_7_0

		return
	end))
	setActive(self.phases[2]:Find("Image"), true)

	local var_5_1 = GetOrAddComponent(self.phases[2], typeof(CanvasGroup))

	LeanTween.value(go(self.phases[2]), 0, 1, 0.4):setOnUpdate(System.Action_float(function(arg_8_0)
		var_5_1.alpha = arg_8_0

		return
	end))
	setActive(self.phases[2]:Find("label"), false)
	LeanTween.moveLocal(go(self.phases[2]), self.phases[1].localPosition, 0.4):setOnComplete(System.Action(function()
		self.isSwitching = nil
		self.phases[1], self.phases[2] = self.phases[2], self.phases[1]

		return
	end))
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

function FranceIconTaskRePage:UpdateAwardGot()
	setActive(self._tf:Find("AD/switcher/phase2/got"), self.activity.data2 >= 1)

	return
end

function FranceIconTaskRePage:OnUpdateFlush()
	setActive(self.battleBtn, isActive(self.battleBtn) and self.inTime)
	self:UpdateAwardGot()

	local var_12_1 = self.activity.data1
	local var_12_2 = pg.activity_event_avatarframe[self.activity:getConfig("config_id")].target
	local var_12_4
	local var_12_3

	if var_12_2 < self.activity.data1 then
		var_12_1 = var_12_2
		var_12_3 = setText
		var_12_4 = self.step
	end

	var_12_3(var_12_4, var_12_1 / var_12_2 >= 1 and setColorStr(var_12_1, "#487CFFFF") or var_12_1)
	setText(self.progress, "/" .. var_12_2)
	setFillAmount(self.bar, var_12_1 / var_12_2)

	local var_12_5 = var_12_2 <= var_12_1
	local var_12_6 = self.activity.data2 >= 1

	setActive(self.battleBtn, not (self.activity.data2 >= 1) and not var_12_5 and self.inTime)
	setActive(self.getBtn, var_12_5 and not var_12_6)
	setActive(self.gotBtn, var_12_6)

	return
end

return FranceIconTaskRePage
