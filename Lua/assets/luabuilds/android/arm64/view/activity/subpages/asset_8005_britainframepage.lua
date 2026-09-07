local BritainframePage = class("BritainframePage", import(".TemplatePage.PtTemplatePage"))

function BritainframePage:OnFirstFlush()
	BritainframePage.super.OnFirstFlush(self)
	setActive(self.displayBtn, false)
	setActive(self.awardTF, false)
	onButton(self, self.battleBtn, function()
		self:emit(ActivityMediator.EVENT_GO_SCENE, SCENE.TASK, {
			page = "activity"
		})

		return
	end, SFX_PANEL)

	self.step = self._tf:Find("AD/switcher/phase2/background/step")
	self.progress = self._tf:Find("AD/switcher/phase2/background/progress")
	self.switchBtn = self._tf:Find("AD/switcher/switch_btn")
	self.bar = self._tf:Find("AD/switcher/phase2/background/barContent/bar")
	self.phases = {
		self._tf:Find("AD/switcher/phase1"),
		self._tf:Find("AD/switcher/phase2")
	}
	self.inPhase2 = false

	onToggle(self, self.switchBtn, function(arg_3_0)
		if self.isSwitching then
			return
		end

		self.inPhase2 = arg_3_0

		self:Switch(arg_3_0)

		return
	end, SFX_PANEL)

	if pg.TimeMgr.GetInstance():inTime((self.activity:getConfig("config_client"))) then
		triggerToggle(self.switchBtn, true)
	end

	return
end

function BritainframePage:Switch(arg_4_1)
	self.isSwitching = true

	local var_4_0 = GetOrAddComponent(self.phases[1], typeof(CanvasGroup))

	self.phases[2]:SetAsLastSibling()
	setActive(self.phases[1]:Find("background"), false)
	LeanTween.moveLocal(go(self.phases[1]), self.phases[2].localPosition, 0.4)
	LeanTween.value(go(self.phases[1]), 0, 1, 0.4):setOnUpdate(System.Action_float(function(arg_5_0)
		var_4_0.alpha = arg_5_0

		return
	end))
	setActive(self.phases[2]:Find("background"), true)

	local var_4_1 = GetOrAddComponent(self.phases[2], typeof(CanvasGroup))

	LeanTween.value(go(self.phases[2]), 0, 1, 0.4):setOnUpdate(System.Action_float(function(arg_6_0)
		var_4_1.alpha = arg_6_0

		return
	end))
	LeanTween.moveLocal(go(self.phases[2]), self.phases[1].localPosition, 0.4):setOnComplete(System.Action(function()
		self.isSwitching = nil
		self.phases[1], self.phases[2] = self.phases[2], self.phases[1]

		return
	end))
	self:UpdateAwardGot()

	return
end

function BritainframePage:UpdateAwardGot()
	local var_8_0 = not self.ptData:CanGetNextAward() and self.inPhase2

	setActive(self.bg:Find("switcher/phase2/background/got"), var_8_0)

	local var_8_1 = self.bg:Find("switcher/phase2/background")

	setActive(var_8_1:Find("progress"), not var_8_0)
	setActive(var_8_1:Find("step"), not var_8_0)

	return
end

function BritainframePage:OnUpdateFlush()
	BritainframePage.super.OnUpdateFlush(self)
	setActive(self.battleBtn, isActive(self.battleBtn) and pg.TimeMgr.GetInstance():inTime((self.activity:getConfig("config_client"))))
	self:UpdateAwardGot()

	local var_9_0, var_9_1, var_9_2 = self.ptData:GetResProgress()

	setText(self.step, var_9_2 >= 1 and setColorStr(var_9_0, "#487CFFFF") or var_9_0)
	setText(self.progress, "/" .. var_9_1)
	setFillAmount(self.bar, var_9_0 / var_9_1)

	return
end

return BritainframePage
