local DexiV4FramePage = class("DexiV4FramePage", import(".TemplatePage.FrameTemplatePage"))

function DexiV4FramePage:Switch(arg_1_1)
	self.isSwitching = true

	local var_1_0 = GetOrAddComponent(self.phases[1], typeof(CanvasGroup))

	self.phases[2]:SetAsLastSibling()
	setActive(self.phases[1]:Find("Image"), false)
	setLocalPosition(go(self.phases[1]), self.phases[2].localPosition)
	setActive(self.phases[1]:Find("label"), true)
	LeanTween.value(go(self.phases[1]), 0, 1, 0.4):setOnUpdate(System.Action_float(function(arg_2_0)
		var_1_0.alpha = arg_2_0

		return
	end))
	setActive(self.phases[2]:Find("Image"), true)

	local var_1_1 = GetOrAddComponent(self.phases[2], typeof(CanvasGroup))

	LeanTween.value(go(self.phases[2]), 0, 1, 0.4):setOnUpdate(System.Action_float(function(arg_3_0)
		var_1_1.alpha = arg_3_0

		return
	end))
	setActive(self.phases[2]:Find("label"), false)
	setLocalPosition(go(self.phases[2]), self.phases[1].localPosition)

	self.isSwitching = nil
	self.phases[1], self.phases[2] = self.phases[2], self.phases[1]

	self:UpdateAwardGot()

	return
end

return DexiV4FramePage
