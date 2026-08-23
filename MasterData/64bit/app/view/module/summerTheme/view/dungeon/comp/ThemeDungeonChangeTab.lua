local var_0_0 = g.core.config.activity_theme_display_info
local var_0_1 = g.core.model.User.themeData
local var_0_2 = g.core.const.ConstMgr.ActivityConst
local ThemeDungeonChangeTab = class("ThemeDungeonChangeTab", require("app.fairyGUI.summerTheme.UI_ThemeDungeonChangeTab"))

function ThemeDungeonChangeTab:ctor()
	self._themeVal = 0
end

function ThemeDungeonChangeTab:setSelected(arg_2_1)
	self.m_isSelectController:setSelectedIndex(arg_2_1 and 1 or 0)
end

function ThemeDungeonChangeTab:updateTabCell(arg_3_1)
	self._themeVal = arg_3_1

	self.m_knightIcon:setIcon(g.core.common.Path:getKnightIconById(var_0_0.get(arg_3_1).role_res))

	local var_3_0 = var_0_1:getActivityData(arg_3_1)

	if not var_3_0 then
		local var_3_1 = g.core.model.User.activityDataManager:getActivityDataListByFilter(function(arg_4_0)
			if arg_4_0:getActivityType() == var_0_2.ACTIVITY_TYPE.SUMMER_ACTIVITY then
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

	if var_3_2 == var_0_2.ACTIVITY_STATE.START then
		self.m_stateController:setSelectedIndex(1)
	elseif var_3_2 == var_0_2.ACTIVITY_STATE.END or var_3_2 == var_0_2.ACTIVITY_STATE.EXPIRE then
		self.m_stateController:setSelectedIndex(2)
	else
		self.m_stateController:setSelectedIndex(0)
	end
end

return ThemeDungeonChangeTab
