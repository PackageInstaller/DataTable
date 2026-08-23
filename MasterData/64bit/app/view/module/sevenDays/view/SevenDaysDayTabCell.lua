local var_0_0 = g.core.const.ConstMgr.SevenDaysConst
local var_0_1 = g.core.model.User.sevenDaysData
local SevenDaysDayTabCell = class("SevenDaysDayTabCell", require("app.fairyGUI.sevenDaysActivity.UI_SevenDaysDayTabCell"))

function SevenDaysDayTabCell:updateCell(arg_1_1, arg_1_2)
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
		redPointComp = self.m_redPointComp,
		customData = {
			day = arg_1_2,
			actValue = arg_1_1
		}
	})
	self.m_actValueController:setSelectedIndex(arg_1_1 - 1)

	local var_1_0 = arg_1_2 % var_0_0.DAY_TAB_NUM

	if arg_1_2 % var_0_0.DAY_TAB_NUM == 0 then
		var_1_0 = var_0_0.DAY_TAB_NUM
	end

	self.m_dayNumTxt:setText(var_1_0)
	self.m_dayTxt:setText(g.core.lang:get(403002, {
		day = g.core.lang:get(100 + var_1_0)
	}))
	self.m_stateController:setSelectedIndex((var_0_1:getDayTabState(arg_1_1, arg_1_2)))
end

return SevenDaysDayTabCell
