local JapanV2frameRePage = class("JapanV2frameRePage", import(".TemplatePage.NewFrameTemplatePage"))

function JapanV2frameRePage:OnInit()
	JapanV2frameRePage.super.OnInit(self)

	self.gotTag = self._tf:Find("AD/switcher/phase2/got")

	return
end

function JapanV2frameRePage:OnUpdateFlush()
	local var_2_0 = self.activity.data1
	local var_2_1 = self.avatarConfig.target

	var_2_0 = self.avatarConfig.target < self.activity.data1 and var_2_1 or var_2_0

	local var_2_2 = var_2_0 / var_2_1

	setText(self.cur, var_2_0 / var_2_1 >= 1 and setColorStr(var_2_0, "#487CFFFF") or var_2_0)
	setText(self.target, "/" .. var_2_1)
	setFillAmount(self.bar, var_2_2)

	local var_2_3 = var_2_1 <= var_2_0
	local var_2_4 = self.activity.data2 >= 1

	setActive(self.battleBtn, self.inPhase2 and not var_2_3)
	setActive(self.getBtn, self.inPhase2 and not var_2_4 and var_2_3)
	setActive(self.gotBtn, self.inPhase2 and var_2_4)
	setActive(self.gotTag, self.inPhase2 and var_2_4)
	setActive(self.cur, not var_2_4)
	setActive(self.target, not var_2_4)

	return
end

return JapanV2frameRePage
