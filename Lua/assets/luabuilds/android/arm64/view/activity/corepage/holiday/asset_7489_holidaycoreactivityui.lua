local HolidayCoreActivityUI = class("HolidayCoreActivityUI", import("view.activity.CorePage.OutPost.OutPostCoreActivityUI"))

function HolidayCoreActivityUI:getUIName()
	return "HolidayCoreActivityUI"
end

function HolidayCoreActivityUI:init(...)
	HolidayCoreActivityUI.super.init(self, ...)

	local var_2_0 = self:getActsInterested()
	local var_2_1 = #var_2_0

	for iter_2_0, iter_2_1 in ipairs(var_2_0) do
		local var_2_2 = getProxy(ActivityProxy):getActivityById(iter_2_1)

		var_2_1 = var_2_2 and not var_2_2:isEnd() and var_2_1 or var_2_1 - 1
	end

	setActive(self.tabs, var_2_1 >= 1)

	return
end

function HolidayCoreActivityUI:getActsInterested()
	return {
		50602
	}
end

return HolidayCoreActivityUI
