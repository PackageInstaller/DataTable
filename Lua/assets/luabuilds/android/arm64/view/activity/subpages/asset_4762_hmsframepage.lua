local HMSFramePage = class("HMSFramePage", import(".TemplatePage.NewFrameTemplatePage"))

function HMSFramePage:Switch(arg_1_1)
	local var_1_0
	local var_1_1

	if arg_1_1 then
		var_1_1 = self.phases[2]
		var_1_0 = self.phases[1]
	else
		var_1_1 = self.phases[1]
		var_1_0 = self.phases[2]
	end

	local var_1_2 = GetOrAddComponent(var_1_0, typeof(CanvasGroup))

	var_1_1:SetAsLastSibling()
	setActive(var_1_0:Find("Image"), false)
	setActive(var_1_0:Find("label"), true)
	setActive(var_1_1:Find("Image"), true)
	setActive(var_1_1:Find("label"), false)

	return
end

return HMSFramePage
