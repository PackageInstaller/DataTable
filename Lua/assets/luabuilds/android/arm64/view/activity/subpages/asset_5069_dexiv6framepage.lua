local DexiV6FramePage = class("DexiV6FramePage", import(".TemplatePage.NewFrameTemplatePage"))

function DexiV6FramePage:OnInit()
	self.bg = self._tf:Find("AD")
	self.battleBtn = self.bg:Find("battle_btn")
	self.getBtn = self.bg:Find("get_btn")
	self.gotBtn = self.bg:Find("got_btn")
	self.switchBtn = self._tf:Find("AD/switch_btn")
	self.phases = {
		self._tf:Find("AD/switcher/phase1"),
		self._tf:Find("AD/switcher/phase2")
	}
	self.bar = self._tf:Find("AD/switcher/phase2/Image/barContent/bar")
	self.cur = self._tf:Find("AD/switcher/phase2/Image/step")
	self.gotTag = self._tf:Find("AD/switcher/phase2/Image/got")
	self.getTag = self._tf:Find("AD/switcher/phase2/Image/get")

	return
end

function DexiV6FramePage:OnUpdateFlush()
	local var_2_0 = self.activity.data1
	local var_2_1 = self.avatarConfig.target

	var_2_0 = self.avatarConfig.target < self.activity.data1 and var_2_1 or var_2_0

	local var_2_2 = var_2_0 / var_2_1

	setText(self.cur, (var_2_0 / var_2_1 >= 1 and setColorStr(var_2_0, COLOR_GREEN) or setColorStr(var_2_0, "#81CBD0")) .. setColorStr("/" .. var_2_1, "#1AB3B1"))
	setFillAmount(self.bar, var_2_2)

	local var_2_3 = var_2_1 <= var_2_0
	local var_2_4 = self.activity.data2 >= 1

	setActive(self.battleBtn, self.inPhase2 and not var_2_3)
	setActive(self.getBtn, self.inPhase2 and not var_2_4 and var_2_3)
	setActive(self.gotBtn, self.inPhase2 and var_2_4)
	setActive(self.gotTag, self.inPhase2 and var_2_4)
	setActive(self.getTag, self.inPhase2 and not var_2_4 and var_2_3)
	setActive(self.cur, not var_2_4)

	return
end

return DexiV6FramePage
