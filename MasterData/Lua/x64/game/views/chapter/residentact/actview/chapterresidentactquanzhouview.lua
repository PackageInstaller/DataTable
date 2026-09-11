ChapterResidentActBaseView = import("game.views.chapter.residentAct.ChapterResidentActBaseView")

local ChapterResidentActQuanZhouView = class("ChapterResidentActQuanZhouView", ChapterResidentActBaseView)

function ChapterResidentActQuanZhouView:RefreshUI()
	ChapterResidentActQuanZhouView.super.RefreshUI(self)

	local var_1_0, var_1_1, var_1_2 = ChapterResidentTools.GetResidentActProgress(self.activityID)

	self.progressShadowValueTxt_.text = string.format("%s<size=60>/%s</size>", var_1_0, var_1_1)
end

return ChapterResidentActQuanZhouView
