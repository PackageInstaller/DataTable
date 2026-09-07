local ChongYingFramePage = class("ChongYingFramePage", import(".TemplatePage.NewFrameTemplatePage"))

function ChongYingFramePage:OnInit()
	ChongYingFramePage.super.OnInit(self)

	self.bar = self._tf:Find("AD/switcher/phase2/barContent")
	self.cur = self._tf:Find("AD/switcher/phase2/progress/step")
	self.target = self._tf:Find("AD/switcher/phase2/progress/all")
	self.getTag = self._tf:Find("AD/switcher/phase2/get")
	self.gotTag = self._tf:Find("AD/switcher/phase2/got")
	self.titles = {
		self.switchBtn:Find("2"),
		self.switchBtn:Find("1")
	}

	return
end

function ChongYingFramePage:OnUpdateFlush()
	local var_2_0 = self.activity.data1
	local var_2_1 = self.avatarConfig.target
	local var_2_3
	local var_2_2

	if self.avatarConfig.target < self.activity.data1 and not var_2_1 then
		var_2_2 = setText
		var_2_3 = self.cur
	end

	var_2_2(var_2_3, var_2_0 / var_2_1 >= 1 and setColorStr(var_2_0, COLOR_GREEN) or var_2_0)
	setText(self.target, "/" .. var_2_1)
	setSlider(self.bar, 0, var_2_1, var_2_0)

	local var_2_4 = var_2_1 <= var_2_0
	local var_2_5 = self.activity.data2 >= 1

	setActive(self.battleBtn, self.inPhase2 and not var_2_4)
	setActive(self.getBtn, self.inPhase2 and not var_2_5 and var_2_4)
	setActive(self.gotBtn, self.inPhase2 and var_2_5)
	setActive(self.getTag, self.inPhase2 and not var_2_5 and var_2_4)
	setActive(self.gotTag, self.inPhase2 and var_2_5)
	setActive(self._tf:Find("AD/switcher/phase2/progress"), not var_2_5)

	return
end

function ChongYingFramePage:Switch(arg_3_1)
	self.isSwitching = true

	setToggleEnabled(self.switchBtn, false)

	local var_3_0 = {}

	for iter_3_0, iter_3_1 in ipairs({
		self.phases,
		self.titles
	}) do
		local var_3_1, var_3_2 = unpack(iter_3_1)

		if arg_3_1 then
			var_3_2 = var_3_1
			var_3_1 = var_3_2
		end

		LeanTween.cancel(go(var_3_1))

		local var_3_3 = GetOrAddComponent(var_3_1, "CanvasGroup")

		var_3_3.alpha = 0

		table.insert(var_3_0, function(arg_4_0)
			LeanTween.alphaCanvas(var_3_3, 1, 0.4):setOnComplete(System.Action(arg_4_0))

			return
		end)
		LeanTween.cancel(go(var_3_2))

		local var_3_4 = GetOrAddComponent(var_3_2, "CanvasGroup")

		var_3_4.alpha = 1

		table.insert(var_3_0, function(arg_5_0)
			LeanTween.alphaCanvas(var_3_4, 0, 0.4):setOnComplete(System.Action(arg_5_0))

			return
		end)
	end

	parallelAsync(var_3_0, function()
		self.isSwitching = nil

		setToggleEnabled(self.switchBtn, true)

		return
	end)

	return
end

return ChongYingFramePage
