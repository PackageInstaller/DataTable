local WeeklyCompetitionBubbleComp = class("WeeklyCompetitionBubbleComp", (require("app.fairyGUI.weeklyCompetition.UI_WeeklyCompetitionBubbleComp")))

function WeeklyCompetitionBubbleComp:ctor()
	self._awards = nil

	self:_initList()
end

function WeeklyCompetitionBubbleComp:_initList()
	self.m_list:setVirtual()
	self.m_list:setItemRenderer(handler(self, self._onAwardItemRender))
	self.m_list:doFairyBatching(false)
end

function WeeklyCompetitionBubbleComp:updateBubble(arg_3_1)
	self._awards = arg_3_1

	self.m_list:setNumItems(#self._awards)
	self.m_list:resizeToFit(#self._awards)
end

function WeeklyCompetitionBubbleComp:_onAwardItemRender(arg_4_1, arg_4_2)
	arg_4_2:updateIcon(self._awards[arg_4_1 + 1])
end

return WeeklyCompetitionBubbleComp
