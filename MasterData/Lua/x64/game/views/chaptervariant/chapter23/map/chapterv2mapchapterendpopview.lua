local ChapterV2MapChapterEndPopView = class("ChapterV2MapChapterEndPopView", ReduxView)

function ChapterV2MapChapterEndPopView:UIName()
	return "Widget/System/Xuheng_PlotMap/XuhengChapterpop01UI"
end

function ChapterV2MapChapterEndPopView:UIParent()
	return manager.ui.uiPop.transform
end

function ChapterV2MapChapterEndPopView:Init()
	self:BindCfgUI()
	self:AddUIListeners()
end

function ChapterV2MapChapterEndPopView:AddUIListeners()
	self:AddBtnListener(self.bgBtn_, nil, function()
		self:Back()
	end)
end

function ChapterV2MapChapterEndPopView:OnEnter()
	self.visitedStr_ = self.params_.visitedStr

	saveData("ChapterV2MapData", self.visitedStr_, true)
end

function ChapterV2MapChapterEndPopView:OnExit()
	return
end

function ChapterV2MapChapterEndPopView:Dispose()
	ChapterV2MapChapterEndPopView.super.Dispose(self)
end

return ChapterV2MapChapterEndPopView
