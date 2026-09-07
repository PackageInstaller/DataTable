local FrameReTemplatePage = class("FrameReTemplatePage", import("view.base.BaseActivityPage"))

function FrameReTemplatePage:OnInit()
	self.bg = self._tf:Find("AD")
	self.battleBtn = self.bg:Find("battle_btn")
	self.getBtn = self.bg:Find("get_btn")
	self.gotBtn = self.bg:Find("got_btn")
	self.bar = self.bg:Find("frame/bar")
	self.step = self.bg:Find("frame/step")
	self.progress = self.bg:Find("frame/progress")
	self.frameGot = self.bg:Find("frame/got")

	return
end

function FrameReTemplatePage:OnDataSetting()
	self.avatarConfig = pg.activity_event_avatarframe[self.activity:getConfig("config_id")]

	return
end

function FrameReTemplatePage:OnFirstFlush()
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

	return
end

function FrameReTemplatePage:OnUpdateFlush()
	local var_6_0 = self.activity.data1
	local var_6_1 = self.avatarConfig.target

	var_6_0 = self.avatarConfig.target < self.activity.data1 and var_6_1 or var_6_0

	local var_6_2 = var_6_0 / var_6_1

	setText(self.step, var_6_0 / var_6_1 >= 1 and setColorStr(var_6_0, COLOR_GREEN) or var_6_0)
	setText(self.progress, "/" .. var_6_1)
	setFillAmount(self.bar, var_6_2)

	local var_6_3 = var_6_1 <= var_6_0
	local var_6_4 = self.activity.data2 >= 1

	setActive(self.battleBtn, not (var_6_1 <= var_6_0))
	setActive(self.getBtn, not var_6_4 and var_6_3)
	setActive(self.gotBtn, var_6_4)
	setActive(self.frameGot, var_6_4)

	return
end

return FrameReTemplatePage
