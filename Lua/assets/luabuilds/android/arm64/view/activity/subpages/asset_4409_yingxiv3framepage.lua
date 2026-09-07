local YingxiV3FramePage = class("YingxiV3FramePage", import(".TemplatePage.NewFrameTemplatePage"))

function YingxiV3FramePage:OnInit()
	YingxiV3FramePage.super.OnInit(self)

	self.gotTag = self._tf:Find("AD/switcher/phase2/got")

	return
end

function YingxiV3FramePage:Switch(arg_2_1)
	self.isSwitching = true

	local var_2_0
	local var_2_1

	if arg_2_1 then
		var_2_1 = self.phases[2]
		var_2_0 = self.phases[1]
	else
		var_2_1 = self.phases[1]
		var_2_0 = self.phases[2]
	end

	local var_2_2 = GetOrAddComponent(var_2_0, typeof(CanvasGroup))

	var_2_1:SetAsLastSibling()
	setActive(var_2_0:Find("Image"), false)
	setLocalPosition(go(var_2_0), var_2_1.localPosition)
	setActive(var_2_0:Find("label"), true)
	LeanTween.value(go(var_2_0), 0, 1, 0.4):setOnUpdate(System.Action_float(function(arg_3_0)
		var_2_2.alpha = arg_3_0

		return
	end))
	setActive(var_2_1:Find("Image"), true)

	local var_2_3 = GetOrAddComponent(var_2_1, typeof(CanvasGroup))

	LeanTween.value(go(var_2_1), 0, 1, 0.4):setOnUpdate(System.Action_float(function(arg_4_0)
		var_2_3.alpha = arg_4_0

		return
	end))
	setActive(var_2_1:Find("label"), false)
	setLocalPosition(go(var_2_1), var_2_0.localPosition)

	self.isSwitching = nil

	return
end

return YingxiV3FramePage
