class = var_0_10000

local var_0_0 = "HolidayCoreActivityUI"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.activity.CorePage.OutPost.OutPostCoreActivityUI"))

function var_0_1.getUIName(arg_1_0)
	return "HolidayCoreActivityUI"
end

function var_0_1.init(arg_2_0, ...)
	var_0_1.super.init(arg_2_0, ...)

	local var_2_0 = #arg_2_0:getActsInterested()

	ipairs = var_3

	for iter_2_0, iter_2_1 in var_3(var_1) do
		getProxy = var_1_10008
		ActivityProxy = var_1_10009
		var_1_10009 = var_1_10008(var_1_10009)
		var_1_10009 = var_1_10008.getActivityById(var_1_10009, iter_2_1) and not var_1_10008:isEnd()
		var_2_0 = var_1_10009 and var_2_0 or var_2_0 - 1
	end

	setActive = var_3

	var_3(arg_2_0.tabs, var_2_0 >= 1)

	return
end

function var_0_1.getActsInterested(arg_3_0)
	return {
		50602
	}
end

return var_0_1
