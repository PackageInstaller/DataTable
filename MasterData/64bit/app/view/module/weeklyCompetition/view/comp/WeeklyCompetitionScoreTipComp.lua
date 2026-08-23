local WeeklyCompetitionScoreTipComp = class("WeeklyCompetitionScoreTipComp", (require("app.fairyGUI.weeklyCompetition.UI_WeeklyCompetitionScoreTipComp")))

function WeeklyCompetitionScoreTipComp:ctor()
	self._scoreInfo = {
		disScore = 0,
		startScore = 0
	}
end

function WeeklyCompetitionScoreTipComp:initViewComp(arg_2_1)
	self.m_scoreIcon:setURL(arg_2_1:getScoreIconUrl())
end

function WeeklyCompetitionScoreTipComp:playShow(arg_3_1, arg_3_2)
	self._scoreInfo.startScore = arg_3_1
	self._scoreInfo.disScore = arg_3_2

	self.m_scoreText:setText(self._scoreInfo.disScore)
	self.m_enterTransition:play(handler(self, self._showEnd))
	g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.UI_EVENT_WEEKLY_COMPETITION_SCORE_UP)
end

function WeeklyCompetitionScoreTipComp:_showEnd()
	self.m_backTransition:play(handler(self, self._backEnd))
end

function WeeklyCompetitionScoreTipComp:_backEnd()
	self:dispatchCompEvent("tipCompHide", {
		startScore = self._scoreInfo.startScore,
		targetScore = self._scoreInfo.startScore + self._scoreInfo.disScore
	})
end

return WeeklyCompetitionScoreTipComp
