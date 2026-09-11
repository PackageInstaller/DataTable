local ChapterResidentActAutoChessView_4_8 = class("ChapterResidentActAutoChessView_4_8", (import("game.views.chapter.residentAct.ChapterResidentActBaseView")))

function ChapterResidentActAutoChessView_4_8:AddUIListener()
	ChapterResidentActAutoChessView_4_8.super.AddUIListener(self)
	self:AddBtnListener(self.jumpBtn_, nil, function()
		manager.notify:Invoke(CHAPTER_RESIDENT_ACT_SWITCH_VIEW, ActivityConst.ACTIVITY_AUTO_CHESS_MAIN)
	end)
end

function ChapterResidentActAutoChessView_4_8:RefreshUI()
	ChapterResidentActAutoChessView_4_8.super.RefreshUI(self)

	local var_3_0, var_3_1 = TaskTools.GetTaskNumInfo(ActivityConst.ACTIVITY_AUTO_CHESS_MAIN)

	self.processText_.text = string.format("<size=48>%d</size>/%d", var_3_0, var_3_1)
	self.processImg_.fillAmount = var_3_0 / var_3_1
end

return ChapterResidentActAutoChessView_4_8
