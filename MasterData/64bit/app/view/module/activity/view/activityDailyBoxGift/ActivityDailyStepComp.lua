local var_0_0 = g.core.model.User.activityDailyBoxData
local ActivityDailyStepComp = class("ActivityDailyStepComp", require("app.fairyGUI.activity.UI_ActivityDailyStepComp"))

function ActivityDailyStepComp:ctor()
	self.m_awardStateController:addEventListener(fgui.UIEventType.Changed, handler(self, self._onAwardControlChanged))
end

function ActivityDailyStepComp:updateStepProgress()
	local var_2_0 = var_0_0:getCurDailyBoxAwardScore()
	local var_2_1 = var_0_0:getDailyBoxAwardMaxScore()
	local var_2_2 = var_0_0:isCanGetDailyTurnAwards()

	self.m_progressValueTxt:setText(var_2_0 .. "/" .. var_2_1)
	self.m_progressComp:setPercent({
		cur = var_2_0,
		max = var_2_1
	})
	self.m_awardStateController:setSelectedIndex(var_2_2 and 1 or 0)
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
		redPointComp = self.m_redPointComp
	})
end

function ActivityDailyStepComp:_onAwardControlChanged()
	if self.m_awardStateController:getSelectedIndex() == 1 then
		self.m_awardEff:removeAllEffect()
		self.m_awardEff:addEffectSpine({
			name = "eff_ui_monthcard_jinduloop",
			isLoop = true
		})
	end
end

return ActivityDailyStepComp
