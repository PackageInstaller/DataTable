class = var_0_10000

local var_0_0 = "HMSFramePage"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".TemplatePage.NewFrameTemplatePage"))

function var_0_1.Switch(arg_1_0, arg_1_1)
	local var_1_0
	local var_1_1

	if arg_1_1 then
		var_1_10004 = arg_1_0.phases[1]
		var_1_1 = arg_1_0.phases[2]
		var_1_0 = var_1_10004
	else
		var_1_10004 = arg_1_0.phases[2]
		var_1_1 = arg_1_0.phases[1]
		var_1_0 = var_1_10004
	end

	GetOrAddComponent = var_1_10004

	local var_1_2 = var_1_0

	typeof = var_1_10007
	CanvasGroup = var_1_10009

	local var_1_3 = var_1_10004(var_1_2, var_1_10007(var_1_10009))
	local var_1_4 = var_1_0.localPosition
	local var_1_5 = var_1_1.localPosition

	var_1_1:SetAsLastSibling()

	setActive = var_7

	var_7(var_1_0:Find("Image"), false)

	setActive = var_7

	var_7(var_1_0:Find("label"), true)

	setActive = var_7

	var_7(var_1_1:Find("Image"), true)

	setActive = var_7

	var_7(var_1_1:Find("label"), false)

	return
end

return var_0_1
