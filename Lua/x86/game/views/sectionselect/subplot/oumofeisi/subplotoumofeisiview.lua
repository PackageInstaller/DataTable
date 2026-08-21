SubPlotSectionView = import("game.views.sectionSelect.subPlot.SubPlotSectionView")

local var_0_0 = class("SubPlotOuMoFeiSiView", SubPlotSectionView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Operation/ChapterSectionUI/Summer_3_4_ChapterSectionUI"
end

function var_0_0.GetItemClass(arg_2_0)
	return SubPlotSectionItem
end

function var_0_0.Init(arg_3_0)
	var_0_0.super.Init(arg_3_0)

	arg_3_0.chapterPartBtnView_ = ChapterPartBtnView.New(arg_3_0.chapterBranchGo_)

	arg_3_0.chapterPartBtnView_:Show(true)
end

function var_0_0.OnEnter(arg_4_0)
	var_0_0.super.OnEnter(arg_4_0)
	arg_4_0.chapterPartBtnView_:OnEnter()
end

function var_0_0.OnExit(arg_5_0)
	var_0_0.super.OnExit(arg_5_0)
	arg_5_0.chapterPartBtnView_:OnExit()
end

function var_0_0.RefreshUI(arg_6_0)
	var_0_0.super.RefreshUI(arg_6_0)
	arg_6_0.chapterPartBtnView_:RefreshUI(arg_6_0.chapterID_)
end

function var_0_0.Dispose(arg_7_0)
	arg_7_0.chapterPartBtnView_:Dispose()

	arg_7_0.chapterPartBtnView_ = nil

	var_0_0.super.Dispose(arg_7_0)
end

return var_0_0
