local MaoxiV4FramePage = class("MaoxiV4FramePage", import(".TemplatePage.NewFrameTemplatePage"))

MaoxiV4FramePage.COLOR = "#1895ff"

function MaoxiV4FramePage:OnInit()
	MaoxiV4FramePage.super.OnInit(self)

	self.switchBtns = {
		self.switchBtn:Find("switch_btn_1"),
		self.switchBtn:Find("switch_btn_2")
	}

	return
end

function MaoxiV4FramePage:OnFirstFlush()
	MaoxiV4FramePage.super.OnFirstFlush(self)
	setActive(self.switchBtns[1], false)
	setActive(self.switchBtns[2], true)

	return
end

function MaoxiV4FramePage:OnUpdateFlush()
	local var_3_0 = self.activity.data1
	local var_3_1 = self.avatarConfig.target

	var_3_0 = self.avatarConfig.target < self.activity.data1 and var_3_1 or var_3_0

	local var_3_2 = var_3_0 / var_3_1

	setText(self.cur, var_3_0 / var_3_1 >= 1 and setColorStr(var_3_0, MaoxiV4FramePage.COLOR) or var_3_0)
	setText(self.target, "/" .. var_3_1)
	setFillAmount(self.bar, var_3_2)

	local var_3_3 = var_3_1 <= var_3_0
	local var_3_4 = self.activity.data2 >= 1

	setActive(self.battleBtn, self.inPhase2 and not var_3_3)
	setActive(self.getBtn, self.inPhase2 and not var_3_4 and var_3_3)
	setActive(self.gotBtn, self.inPhase2 and var_3_4)
	setActive(self.gotTag, self.inPhase2 and var_3_4)
	setActive(self.cur, not var_3_4 and self.inPhase2)
	setActive(self.target, not var_3_4 and self.inPhase2)

	return
end

function MaoxiV4FramePage:Switch(arg_4_1)
	self.isSwitching = true

	setToggleEnabled(self.switchBtn, false)
	setActive(self.switchBtns[1], true)
	setActive(self.switchBtns[2], false)

	self.switchBtns[1], self.switchBtns[2] = self.switchBtns[2], self.switchBtns[1]

	local var_4_0
	local var_4_1

	if arg_4_1 then
		var_4_1 = self.phases[2]
		var_4_0 = self.phases[1]
	else
		var_4_1 = self.phases[1]
		var_4_0 = self.phases[2]
	end

	local var_4_2 = GetOrAddComponent(var_4_0, typeof(CanvasGroup))

	var_4_1:SetAsLastSibling()
	setActive(var_4_0:Find("Image"), false)
	LeanTween.moveLocal(go(var_4_0), var_4_1.localPosition, 0.4):setOnComplete(System.Action(function()
		setActive(var_4_0:Find("label"), true)

		return
	end))
	LeanTween.value(go(var_4_0), 0, 1, 0.4):setOnUpdate(System.Action_float(function(arg_6_0)
		var_4_2.alpha = arg_6_0

		return
	end))
	setActive(var_4_1:Find("Image"), true)

	local var_4_3 = GetOrAddComponent(var_4_1, typeof(CanvasGroup))

	LeanTween.value(go(var_4_1), 0, 1, 0.4):setOnUpdate(System.Action_float(function(arg_7_0)
		var_4_3.alpha = arg_7_0

		return
	end))
	setActive(var_4_1:Find("label"), false)
	LeanTween.moveLocal(go(var_4_1), var_4_0.localPosition, 0.4):setOnComplete(System.Action(function()
		self.isSwitching = nil

		setToggleEnabled(self.switchBtn, true)

		return
	end))

	return
end

return MaoxiV4FramePage
