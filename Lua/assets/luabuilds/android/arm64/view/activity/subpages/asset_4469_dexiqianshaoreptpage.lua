local DeXiQianShaoRePtPage = class("DeXiQianShaoRePtPage", import(".TemplatePage.NewFrameTemplatePage"))

function DeXiQianShaoRePtPage:OnInit()
	self.bg = self._tf:Find("AD")
	self.battleBtn = self.bg:Find("battle_btn")
	self.getBtn = self.bg:Find("get_btn")
	self.gotBtn = self.bg:Find("got_btn")
	self.switchBtn = self._tf:Find("AD/switcher/switch_btn")
	self.phases = {
		self._tf:Find("AD/switcher/phase1"),
		self._tf:Find("AD/switcher/phase2")
	}
	self.bar = self._tf:Find("AD/switcher/phase2/Image/bar")
	self.cur = self._tf:Find("AD/switcher/phase2/Image/step")
	self.target = self._tf:Find("AD/switcher/phase2/Image/progress")
	self.gotTag = self._tf:Find("AD/switcher/phase2/got")

	return
end

function DeXiQianShaoRePtPage:OnFirstFlush()
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
	onToggle(self, self.switchBtn, function(arg_5_0)
		if self.isSwitching then
			return
		end

		self:Switch(arg_5_0)

		return
	end, SFX_PANEL)

	self.inPhase2 = self.timeStamp and pg.TimeMgr.GetInstance():GetServerTime() - self.timeStamp > 0

	triggerToggle(self.switchBtn, self.inPhase2)

	if not IsNil(self.gotTag:Find("Text")) then
		setText(self.gotTag:Find("Text"), i18n("avatarframe_got"))
	end

	return
end

return DeXiQianShaoRePtPage
