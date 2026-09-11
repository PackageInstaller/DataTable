SubPlotSectionView = import("game.views.sectionSelect.subPlot.SubPlotSectionView")

local SubPlotOuMoFeiSiView = class("SubPlotOuMoFeiSiView", SubPlotSectionView)

function SubPlotOuMoFeiSiView:UIName()
	return "Widget/System/Operation/ChapterSectionUI/Summer_3_4_ChapterSectionUI"
end

function SubPlotOuMoFeiSiView:GetItemClass()
	return SubPlotSectionItem
end

function SubPlotOuMoFeiSiView:Init()
	SubPlotOuMoFeiSiView.super.Init(self)

	self.chapterPartBtnView_ = ChapterPartBtnView.New(self.chapterBranchGo_)

	self.chapterPartBtnView_:Show(true)
end

function SubPlotOuMoFeiSiView:OnEnter()
	SubPlotOuMoFeiSiView.super.OnEnter(self)
	self.chapterPartBtnView_:OnEnter()
end

function SubPlotOuMoFeiSiView:OnExit()
	SubPlotOuMoFeiSiView.super.OnExit(self)
	self.chapterPartBtnView_:OnExit()
end

function SubPlotOuMoFeiSiView:RefreshUI()
	SubPlotOuMoFeiSiView.super.RefreshUI(self)
	self.chapterPartBtnView_:RefreshUI(self.chapterID_)
end

function SubPlotOuMoFeiSiView:Dispose()
	self.chapterPartBtnView_:Dispose()

	self.chapterPartBtnView_ = nil

	SubPlotOuMoFeiSiView.super.Dispose(self)
end

return SubPlotOuMoFeiSiView
