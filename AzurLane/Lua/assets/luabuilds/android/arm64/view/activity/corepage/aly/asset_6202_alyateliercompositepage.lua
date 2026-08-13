class = var_0_10000

local var_0_0 = "ALYAtelierCompositeRePage"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.activity.CorePage.CoreActivityPage"))

function var_0_1.OnInit(arg_1_0)
	setText = var_1_10001

	local var_1_0 = arg_1_0._tf
	local var_1_1 = var_3.Find(var_1_0, "bg/goBtn/Text")

	i18n = var_1_10004

	var_1_10001(var_1_1, var_1_10004("yumia_atelier_tip24"))

	onButton = var_1_10001

	local var_1_2 = arg_1_0
	local var_1_3 = arg_1_0._tf

	var_1_10001(var_1_2, var_4.Find(var_1_3, "bg/goBtn"), function()
		local var_2_0 = arg_1_0
		local var_2_1 = var_0.emit

		ActivityMediator = var_2_10003

		local var_2_2 = var_2_10003.EVENT_GO_SCENE

		SCENE = var_2_10004

		var_2_1(var_2_0, var_2_2, var_2_10004.ATELIER_COMPOSITE, {
			activityID = 50043,
			versionIndex = 2
		})

		return
	end)

	return
end

return var_0_1
