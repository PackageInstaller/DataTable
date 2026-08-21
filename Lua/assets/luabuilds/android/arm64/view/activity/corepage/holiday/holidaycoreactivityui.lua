local var_0_0 = class("HolidayCoreActivityUI", import("view.activity.CorePage.OutPost.OutPostCoreActivityUI"))

function var_0_0.getUIName(arg_1_0)
	return "HolidayCoreActivityUI"
end

function var_0_0.init(arg_2_0, ...)
	var_0_0.super.init(arg_2_0, ...)

	local var_2_0 = arg_2_0:getActsInterested()
	local var_2_1 = #var_2_0

	for iter_2_0, iter_2_1 in ipairs(var_2_0) do
		local var_2_2 = getProxy(ActivityProxy):getActivityById(iter_2_1)

		var_2_1 = var_2_2 and not var_2_2:isEnd() and var_2_1 or var_2_1 - 1
	end

	setActive(arg_2_0.tabs, var_2_1 >= 1)

	return
end

function var_0_0.getActsInterested(arg_3_0)
	return {
		50602
	}
end

return var_0_0
