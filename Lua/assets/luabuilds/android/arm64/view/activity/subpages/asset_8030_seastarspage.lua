local SeaStarsPage = class("SeaStarsPage", import(".TemplatePage.NewFrameTemplatePage"))

function SeaStarsPage:OnFirstFlush()
	SetActive(self.switchBtn, false)

	for iter_1_0, iter_1_1 in ipairs(self.phases) do
		setActive(iter_1_1, true)

		GetOrAddComponent(iter_1_1, typeof(CanvasGroup)).alpha = 0
	end

	SeaStarsPage.super.OnFirstFlush(self)

	return
end

function SeaStarsPage:Switch(arg_2_1)
	local var_2_3 = self.phases[1]
	local var_2_4 = self.phases[1].localPosition
	local var_2_5 = self.phases[2].localPosition

	self.phases[2]:SetAsLastSibling()

	local var_2_6 = {}

	table.insert(var_2_6, function(arg_3_0)
		LeanTween.moveLocal(go(var_2_3), var_2_5, 0.4)
		LeanTween.alphaCanvas(GetOrAddComponent(var_2_3, typeof(CanvasGroup)), 0, 0.4)
		LeanTween.moveLocal(go(var_2_1), var_2_4, 0.4)
		LeanTween.alphaCanvas(GetOrAddComponent(var_2_1, typeof(CanvasGroup)), 1, 0.4):setOnComplete(System.Action(arg_3_0))

		return
	end)
	seriesAsync(var_2_6, function()
		setToggleEnabled(self.switchBtn, true)

		return
	end)

	return
end

return SeaStarsPage
