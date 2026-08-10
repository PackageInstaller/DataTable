ChapterResidentActBaseView = import("game.views.chapter.residentAct.ChapterResidentActBaseView")

local var_0_0 = class("ChapterResidentActQuanZhouView", ChapterResidentActBaseView)

function var_0_0.RefreshUI(arg_1_0)
	var_0_0.super.RefreshUI(arg_1_0)

	local var_1_0, var_1_1, var_1_2 = ChapterResidentTools.GetResidentActProgress(arg_1_0.activityID)

	arg_1_0.progressShadowValueTxt_.text = string.format("%s<size=60>/%s</size>", var_1_0, var_1_1)
end

return var_0_0
