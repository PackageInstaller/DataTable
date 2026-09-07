local BisimaiFrameRePage = class("BisimaiFrameRePage", import(".TemplatePage.NewFrameTemplatePage"))

function BisimaiFrameRePage:OnFirstFlush()
	for iter_1_0, iter_1_1 in ipairs(self.phases) do
		setActive(iter_1_1, true)

		GetOrAddComponent(iter_1_1, typeof(CanvasGroup)).alpha = 0
	end

	BisimaiFrameRePage.super.OnFirstFlush(self)

	return
end

function BisimaiFrameRePage:Switch(arg_2_1)
	self.isSwitching = true

	setToggleEnabled(self.switchBtn, false)

	local var_2_0
	local var_2_1

	if arg_2_1 then
		var_2_1 = self.phases[2]
		var_2_0 = self.phases[1]
	else
		var_2_1 = self.phases[1]
		var_2_0 = self.phases[2]
	end

	var_2_1:SetAsLastSibling()

	local var_2_4 = {}

	table.insert(var_2_4, function(arg_3_0)
		LeanTween.alphaCanvas(GetOrAddComponent(var_2_0, typeof(CanvasGroup)), 0, 0.4)
		LeanTween.alphaCanvas(GetOrAddComponent(var_2_1, typeof(CanvasGroup)), 1, 0.4):setOnComplete(System.Action(arg_3_0))

		return
	end)
	seriesAsync(var_2_4, function()
		self.isSwitching = nil

		setToggleEnabled(self.switchBtn, true)

		return
	end)

	return
end

return BisimaiFrameRePage
