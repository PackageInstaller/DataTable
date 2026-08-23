local WeeklyCompetitionTaskItem = class("WeeklyCompetitionTaskItem", (require("app.fairyGUI.weeklyCompetition.UI_WeeklyCompetitionTaskItem")))

function WeeklyCompetitionTaskItem:ctor()
	self._data = nil
end

function WeeklyCompetitionTaskItem:updateItem(arg_2_1, arg_2_2, arg_2_3)
	self._data = arg_2_1

	self.m_descText:setText(g.core.lang:getByString(arg_2_1.cfg.text, {
		num = arg_2_1.cfg.value
	}))
	self.m_valueNumText:setText(g.core.lang:get(420101, {
		cur = self._data.receiveNum,
		max = self._data.receiveLimit
	}))
	self.m_isShowBgController:setSelectedIndex(arg_2_2)
	self.m_typeController:setSelectedIndex(self._data.cfg.refresh - 1)
	self.m_finTypeController:setSelectedIndex(self._data.cfg.fin_time - 1)
	self.m_rewardIcon:setURL(arg_2_3)
	self.m_rewardNumText:setText(g.core.lang:get(420106, {
		score = self._data.cfg.score
	}))
end

return WeeklyCompetitionTaskItem
