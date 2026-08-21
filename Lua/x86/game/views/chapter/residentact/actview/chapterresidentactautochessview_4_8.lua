local var_0_0 = import("game.views.chapter.residentAct.ChapterResidentActBaseView")
local var_0_1 = class("ChapterResidentActAutoChessView_4_8", var_0_0)

function var_0_1.AddUIListener(arg_1_0)
	var_0_1.super.AddUIListener(arg_1_0)
	arg_1_0:AddBtnListener(arg_1_0.jumpBtn_, nil, function()
		manager.notify:Invoke(CHAPTER_RESIDENT_ACT_SWITCH_VIEW, ActivityConst.ACTIVITY_AUTO_CHESS_MAIN)
	end)
end

function var_0_1.RefreshUI(arg_3_0)
	var_0_1.super.RefreshUI(arg_3_0)

	local var_3_0, var_3_1 = TaskTools.GetTaskNumInfo(ActivityConst.ACTIVITY_AUTO_CHESS_MAIN)

	arg_3_0.processText_.text = string.format("<size=48>%d</size>/%d", var_3_0, var_3_1)
	arg_3_0.processImg_.fillAmount = var_3_0 / var_3_1
end

return var_0_1
