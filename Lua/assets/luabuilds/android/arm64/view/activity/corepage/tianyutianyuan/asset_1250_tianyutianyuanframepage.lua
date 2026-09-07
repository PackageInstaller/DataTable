local TianYuTianYuanFramePage = class("TianYuTianYuanFramePage", import("view.activity.CorePage.CoreNewFrameTemplatePage"))

function TianYuTianYuanFramePage:OnInit()
	self.super.OnInit(self)

	self.switchBtn = self._tf:Find("AD/switcher/switch_btn")

	return
end

function TianYuTianYuanFramePage:OnFirstFlush()
	for iter_2_0, iter_2_1 in ipairs(self.phases) do
		setActive(iter_2_1, true)

		GetOrAddComponent(iter_2_1, typeof(CanvasGroup)).alpha = 0
	end

	TianYuTianYuanFramePage.super.OnFirstFlush(self)

	return
end

function TianYuTianYuanFramePage:OnUpdateFlush()
	TianYuTianYuanFramePage.super.OnUpdateFlush(self)

	local var_3_0 = self.avatarConfig.target
	local var_3_2
	local var_3_1

	if self.avatarConfig.target < self.activity.data1 and not var_3_0 then
		var_3_1 = setText
		var_3_2 = self.cur
	end

	var_3_1(var_3_2, (self.activity.data1 / var_3_0 >= 1 and setColorStr(self.activity.data1, "#FCE87A") or setColorStr(self.activity.data1, "#FCE87A")) .. setColorStr("/" .. var_3_0, "#FFFFFF"))
	setActive(self.target, false)

	return
end

function TianYuTianYuanFramePage:Switch(arg_4_1)
	self.isSwitching = true

	setToggleEnabled(self.switchBtn, false)

	local var_4_0
	local var_4_1

	if arg_4_1 then
		var_4_1 = self.phases[2]
		var_4_0 = self.phases[1]
	else
		var_4_1 = self.phases[1]
		var_4_0 = self.phases[2]
	end

	var_4_1:SetAsLastSibling()
	setCanvasGroupAlpha(GetOrAddComponent(var_4_0, typeof(CanvasGroup)), 0)
	setCanvasGroupAlpha(GetOrAddComponent(var_4_1, typeof(CanvasGroup)), 1)

	self.isSwitching = nil

	setToggleEnabled(self.switchBtn, true)

	return
end

return TianYuTianYuanFramePage
