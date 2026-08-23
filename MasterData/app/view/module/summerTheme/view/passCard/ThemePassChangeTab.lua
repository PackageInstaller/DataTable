local var_0_0 = g.core.model.User.themeData
local var_0_1 = g.core.const.ConstMgr.ActivityConst
local ThemePassChangeTab = class("ThemePassChangeTab", require("app.fairyGUI.themePasscard.UI_ThemePassChangeTab"))

function ThemePassChangeTab:ctor()
	self._themeVal = 0
end

function ThemePassChangeTab:setSelected(arg_2_1)
	self.m_isSelectController:setSelectedIndex(arg_2_1 and 1 or 0)
end

function ThemePassChangeTab:updateTabCell(arg_3_1)
	self._themeVal = arg_3_1

	local var_3_0 = var_0_0:getActivityData(arg_3_1)

	if not var_3_0 then
		local var_3_1 = g.core.model.User.activityDataManager:getActivityDataListByFilter(function(arg_4_0)
			if arg_4_0:getActivityType() == var_0_1.ACTIVITY_TYPE.SUMMER_ACTIVITY then
				return arg_4_0:getConfigActivityValue() == arg_3_1
			end
		end)

		if not var_3_1 or not var_3_1[1] then
			self.m_stateController:setSelectedIndex(2)
		else
			self.m_stateController:setSelectedIndex(0)
		end

		return
	end

	local var_3_2 = var_3_0:getActivityState()

	if var_3_2 == var_0_1.ACTIVITY_STATE.START then
		self.m_stateController:setSelectedIndex(1)
	elseif var_3_2 == var_0_1.ACTIVITY_STATE.END or var_3_2 == var_0_1.ACTIVITY_STATE.EXPIRE then
		self.m_stateController:setSelectedIndex(2)
	else
		self.m_stateController:setSelectedIndex(0)
	end
end

return ThemePassChangeTab
