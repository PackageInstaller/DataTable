local DailyReportLikeBtn = class("DailyReportLikeBtn", require("app.fairyGUI.dailyReport.UI_DailyReportLikeBtn"))

function DailyReportLikeBtn:onLikeSuccess(arg_1_1)
	if arg_1_1 then
		self.m_likeTransition:play(arg_1_1)
	else
		self.m_likeTransition:play()
	end
end

function DailyReportLikeBtn:setLike(arg_2_1)
	if arg_2_1 then
		self._inLike = true

		self.m_stateController:setSelectedIndex(1)
	else
		self._inLike = false

		self.m_stateController:setSelectedIndex(0)
	end
end

function DailyReportLikeBtn:isInLike()
	return self._inLike
end

return DailyReportLikeBtn
