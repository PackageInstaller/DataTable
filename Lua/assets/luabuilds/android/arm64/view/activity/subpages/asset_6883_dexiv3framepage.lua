local DexiV3framePage = class("DexiV3framePage", import(".TemplatePage.PtTemplatePage"))

function DexiV3framePage:OnFirstFlush()
	DexiV3framePage.super.OnFirstFlush(self)
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
	self.switchBtn = self._tf:Find("AD/switch_btn")
	self.bar = self._tf:Find("AD/switcher/phase2/Image/barContent/bar")
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

function DexiV3framePage:Switch(arg_4_1)
	self.isSwitching = true

	local var_4_0 = GetOrAddComponent(self.phases[1], typeof(CanvasGroup))

	self.phases[2]:SetAsLastSibling()
	setActive(self.phases[1]:Find("Image"), false)
	LeanTween.moveLocal(go(self.phases[1]), self.phases[2].localPosition, 0.4):setOnComplete(System.Action(function()
		setActive(self.phases[1]:Find("label"), true)

		return
	end))
	LeanTween.value(go(self.phases[1]), 0, 1, 0.4):setOnUpdate(System.Action_float(function(arg_6_0)
		var_4_0.alpha = arg_6_0

		return
	end))
	setActive(self.phases[2]:Find("Image"), true)

	local var_4_1 = GetOrAddComponent(self.phases[2], typeof(CanvasGroup))

	LeanTween.value(go(self.phases[2]), 0, 1, 0.4):setOnUpdate(System.Action_float(function(arg_7_0)
		var_4_1.alpha = arg_7_0

		return
	end))
	setActive(self.phases[2]:Find("label"), false)
	LeanTween.moveLocal(go(self.phases[2]), self.phases[1].localPosition, 0.4):setOnComplete(System.Action(function()
		self.isSwitching = nil
		self.phases[1], self.phases[2] = self.phases[2], self.phases[1]

		return
	end))
	self:UpdateAwardGot()

	return
end

function DexiV3framePage:UpdateAwardGot()
	setActive(self.bg:Find("switcher/phase2/got"), not self.ptData:CanGetNextAward() and self.inPhase2)

	return
end

function DexiV3framePage:OnUpdateFlush()
	DexiV3framePage.super.OnUpdateFlush(self)
	setActive(self.battleBtn, isActive(self.battleBtn) and pg.TimeMgr.GetInstance():inTime((self.activity:getConfig("config_client"))))
	self:UpdateAwardGot()

	local var_10_0, var_10_1, var_10_2 = self.ptData:GetResProgress()

	setText(self.step, var_10_2 >= 1 and setColorStr(var_10_0, "#FFA76CFF") or var_10_0)
	setText(self.progress, "/" .. var_10_1)
	setFillAmount(self.bar, var_10_0 / var_10_1)

	return
end

return DexiV3framePage
