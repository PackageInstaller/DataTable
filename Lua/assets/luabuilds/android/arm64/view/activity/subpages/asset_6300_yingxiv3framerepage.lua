local YingxiV3FrameRePage = class("YingxiV3FrameRePage", import(".TemplatePage.NewFrameTemplatePage"))

function YingxiV3FrameRePage:OnInit()
	self.bg = self._tf:Find("AD")
	self.battleBtn = self.bg:Find("btn/battle_btn")
	self.getBtn = self.bg:Find("btn/get_btn")
	self.gotBtn = self.bg:Find("btn/got_btn")
	self.bar = self.bg:Find("barContent/bar")
	self.cur = self.bg:Find("progress/cur")
	self.target = self.bg:Find("progress/target")
	self.gotTag = self.bg:Find("tag/got")
	self.getTag = self.bg:Find("tag/get")

	return
end

function YingxiV3FrameRePage:OnFirstFlush()
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

function YingxiV3FrameRePage:OnUpdateFlush()
	YingxiV3FrameRePage.super.OnUpdateFlush(self)
	setActive(self.getTag, self.inPhase2 and self.activity.data2 < 1 and self.avatarConfig.target <= self.activity.data1)

	return
end

return YingxiV3FrameRePage
