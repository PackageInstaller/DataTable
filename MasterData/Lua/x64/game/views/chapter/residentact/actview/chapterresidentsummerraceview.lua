local ChapterResidentSummerRaceView = class("ChapterResidentSummerRaceView", (import("game.views.chapter.residentAct.ChapterResidentActBaseView")))

function ChapterResidentSummerRaceView:RefreshProgressUI()
	local var_1_0, var_1_1, var_1_2 = ChapterResidentTools.GetResidentActProgress(self.activityID)

	if self.progressValueTxt_ then
		self.progressValueTxt_.text = var_1_2 and var_1_2 or var_1_0 .. "/" .. var_1_1
	end

	if self.processImg_ then
		local var_1_4 = tonumber(var_1_1) or 0

		self.processImg_.fillAmount = math.min(math.max((var_1_4 > 0 or nil) and var_1_0 / var_1_4, 0), 1)
	end
end

return ChapterResidentSummerRaceView
