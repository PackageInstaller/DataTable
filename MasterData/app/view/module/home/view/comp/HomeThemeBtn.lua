local var_0_0 = g.core.const.ConstMgr
local var_0_1 = g.core.const.ConstMgr.ThemeConst.THEME_ACTIVITY_ICON
local var_0_2 = g.core.const.ConstMgr.ActivityConst.ACTIVITY_STATE
local var_0_3 = {
	IN_ACTIVITY = 0,
	AWARD_PHASE = 1
}
local var_0_4 = g.core.common.ServerTime
local var_0_5 = g.core.common.ModuleUnlock
local HomeThemeBtn = class("HomeThemeBtn", require("app.fairyGUI.home.UI_HomeThemeBtn"))

function HomeThemeBtn:ctor()
	self._activityData = nil
end

function HomeThemeBtn:updateCell(arg_2_1)
	self._activityData = arg_2_1

	local var_2_0 = arg_2_1:getConfigActivityValue()

	self:setIcon(var_0_1[var_2_0])

	if var_0_5:isModuleUnlock(var_0_0.FUNCTION_TYPE.SUMMER_ACTIVITY) then
		self.m_unlockedController:setSelectedIndex(1)
	else
		self.m_unlockedController:setSelectedIndex(0)
	end

	self:updateCD()

	local var_2_1 = arg_2_1.getActivityThemeValueList and arg_2_1:getActivityThemeValueList()
	local var_2_2 = arg_2_1.getOpenActivityData and arg_2_1:getOpenActivityData()
	local var_2_3 = var_2_2 and var_2_2:getConfigActivityValue() or var_2_0

	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
		redPointComp = self.m_redPointComp,
		customData = {
			themeValue = var_2_3,
			activityValues = var_2_1
		}
	})
end

function HomeThemeBtn:updateCD()
	local var_3_0

	if not self._activityData then
		do return end

		var_3_0 = nil
	end

	if self._activityData:getActivityState() == var_0_2.START then
		var_3_0 = var_0_4:getLeftSeconds((self._activityData:getFinishTime()))

		self.m_stateController:setSelectedIndex(var_0_3.IN_ACTIVITY)
	else
		var_3_0 = var_0_4:getLeftSeconds((self._activityData:getExpireTime()))

		self.m_stateController:setSelectedIndex(var_0_3.AWARD_PHASE)
	end

	self.m_cdTxt:setText((self:_getCDStr(var_3_0)))
end

function HomeThemeBtn:_getCDStr(arg_4_1)
	if arg_4_1 <= 0 then
		arg_4_1 = 0
	end

	if arg_4_1 > 86400 then
		arg_4_1 = arg_4_1 % 86400

		return g.core.lang:get(1051, {
			day = math.floor(arg_4_1 / 86400),
			hour = math.ceil(arg_4_1 / 3600)
		})
	else
		arg_4_1 = arg_4_1 % 3600

		local var_4_0 = {}

		var_4_0.hour = math.floor(arg_4_1 / 3600)
		var_4_0.minute = math.ceil(arg_4_1 / 60)

		return g.core.lang:get(1059, var_4_0)
	end
end

function HomeThemeBtn:_onClick()
	return
end

return HomeThemeBtn
