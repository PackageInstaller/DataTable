local DexiV4FrameReRePage = class("DexiV4FrameReRePage", import(".TemplatePage.NewFrameTemplatePage"))

function DexiV4FrameReRePage:OnInit()
	self.super.OnInit(self)

	self.redDot = self._tf:Find("AD/switcher/phase2/Image/red")

	return
end

function DexiV4FrameReRePage:OnFirstFlush()
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

function DexiV4FrameReRePage:OnUpdateFlush()
	local var_5_0 = self.activity.data1
	local var_5_1 = self.avatarConfig.target

	var_5_0 = self.avatarConfig.target < self.activity.data1 and var_5_1 or var_5_0

	local var_5_2 = var_5_0 / var_5_1

	setText(self.cur, var_5_0 / var_5_1 >= 1 and setColorStr(var_5_0, COLOR_GREEN) or var_5_0)
	setText(self.target, "/" .. var_5_1)
	setFillAmount(self.bar, var_5_2)

	local var_5_3 = var_5_1 <= var_5_0
	local var_5_4 = self.activity.data2 >= 1

	setActive(self.battleBtn, not (var_5_1 <= var_5_0))
	setActive(self.getBtn, not var_5_4 and var_5_3)
	setActive(self.gotBtn, var_5_4)
	setActive(self.gotTag, var_5_4)
	setActive(self.redDot, self.activity:readyToAchieve())

	return
end

return DexiV4FrameReRePage
