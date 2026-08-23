local var_0_0 = g.core.config.activity_theme_display_info
local var_0_1 = g.core.model.User.themeData
local var_0_2 = g.core.const.ConstMgr.ThemeConst
local var_0_3 = g.core.const.ConstMgr.ActivityConst
local var_0_4 = g.core.model.User.themeData
local var_0_5 = g.core.common.ServerTime
local var_0_6 = g.core.config.activity_theme_info
local var_0_7 = g.core.config.activity_theme_boss_new_info
local SummerThemeBossEntryCell = class("SummerThemeBossEntryCell", require("app.fairyGUI.summerTheme.UI_SummerThemeBossEntryCell"))

function SummerThemeBossEntryCell:ctor()
	self.getSharedTrans(self, "enter_right", "CommonCardCellList", self)

	self._themeVal = 0
	self._unlockTipText = ""
end

function SummerThemeBossEntryCell:updateCell(arg_2_1)
	self._themeVal = arg_2_1

	local var_2_0 = var_0_6.get(arg_2_1)

	if var_2_0 and var_2_0.boss_id > 0 then
		local var_2_1 = var_0_7.match(function(arg_3_0)
			return arg_3_0.boss_id == var_2_0.boss_id
		end)

		if var_2_1 and var_2_1[1] then
			self.m_iconLoader:setIcon(g.core.common.Path:getMiddleKnightPicById(var_2_1[1].show))
		end
	end

	local var_2_2 = var_0_0.get(arg_2_1)
	local var_2_3 = self:_calcBossState(arg_2_1)

	if var_2_3 == var_0_2.THEME_STATE_TYPE.UNOPEN then
		self:setTitle(g.core.lang:get(405960))

		local var_2_4 = self:_getUnlockTime(arg_2_1)
		local var_2_5

		if var_2_4 > var_0_5:getTime() then
			local var_2_6, var_2_7, var_2_8, var_2_9 = var_0_5:getLeftTimeParts(var_2_4)

			if var_2_8 > 0 or var_2_9 > 0 then
				var_2_7 = var_2_7 + 1
			end

			var_2_5 = g.core.lang:get(500125, {
				day = var_2_6,
				hour = var_2_7
			})
		else
			var_2_5 = g.core.lang:get(1008)
		end

		self._unlockTipText = var_2_5

		self.m_unlockTxt:setText(var_2_5)
	else
		self:setTitle(var_2_2.boss_tab)

		self._unlockTipText = ""
	end

	self.m_stateController:setSelectedIndex(var_2_3)
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
		redPointComp = self.m_redPointComp,
		customData = {
			themeValue = arg_2_1
		}
	})
end

function SummerThemeBossEntryCell:_getUnlockTime(arg_4_1)
	local var_4_0 = var_0_1:getActivityData(arg_4_1)

	if var_4_0 and var_4_0:getActivityState() == var_0_3.ACTIVITY_STATE.START then
		local var_4_1 = var_0_4:getThemeData(arg_4_1)

		if var_4_1 then
			local var_4_2 = var_4_1:getBossData():getBossStartTime()

			var_4_2 = var_4_2 or 0

			return var_4_2
		end

		return 0
	end

	local var_4_3 = g.core.model.User.activityDataManager:getActivityDataListByFilter(function(arg_5_0)
		if arg_5_0:getActivityType() == var_0_3.ACTIVITY_TYPE.SUMMER_ACTIVITY then
			return arg_5_0:getConfigActivityValue() == arg_4_1
		end
	end)

	if var_4_3 and var_4_3[1] then
		return var_4_3[1]:getStartTime() or 0
	end

	return 0
end

function SummerThemeBossEntryCell:_calcBossState(arg_6_1)
	local var_6_0 = var_0_1:getActivityData(arg_6_1)

	if not var_6_0 then
		local var_6_1 = g.core.model.User.activityDataManager:getActivityDataListByFilter(function(arg_7_0)
			if arg_7_0:getActivityType() == var_0_3.ACTIVITY_TYPE.SUMMER_ACTIVITY then
				return arg_7_0:getConfigActivityValue() == arg_6_1
			end
		end)

		if not var_6_1 or not var_6_1[1] then
			return var_0_2.THEME_STATE_TYPE.FINISH
		end

		return var_0_2.THEME_STATE_TYPE.UNOPEN
	end

	local var_6_2 = var_6_0:getActivityState()

	if var_6_2 == var_0_3.ACTIVITY_STATE.START then
		return var_0_1:getThemeData(arg_6_1):getBossData():getBossOpenState()
	elseif var_6_2 == var_0_3.ACTIVITY_STATE.END or var_6_2 == var_0_3.ACTIVITY_STATE.EXPIRE then
		return var_0_2.THEME_STATE_TYPE.FINISH
	end

	return var_0_2.THEME_STATE_TYPE.UNOPEN
end

function SummerThemeBossEntryCell:getBossState()
	return self:_calcBossState(self._themeVal)
end

function SummerThemeBossEntryCell:getUnlockTipText()
	return self._unlockTipText
end

function SummerThemeBossEntryCell:getThemeVal()
	return self._themeVal
end

return SummerThemeBossEntryCell
