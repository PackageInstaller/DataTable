local ChapterMainContentView = class("ChapterMainContentView", ReduxView)

function ChapterMainContentView:OnCtor(arg_1_1, arg_1_2)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform
	self.chapterToggle_ = arg_1_2

	self:BindCfgUI()

	self.mainPlotPanelView_ = ChapterMainPlotPanelView.New(self.chapterGo_)
	self.subPlotPanelView_ = ChapterSubPlotPanelView.New(self.subPlotGo_)
	self.lnkView_ = ChapterChallengeLnkView.New(self.lnkPanelGo_)
end

function ChapterMainContentView:OnEnter()
	self.mainPlotPanelView_:OnEnter()
	self.subPlotPanelView_:OnEnter()

	local var_2_0 = ChapterTools.GetChapterChallengeLnkList()
	local var_2_1 = {
		RedPointConst.COMBAT_PLOT,
		RedPointConst.COMBAT_SUB_PLOT
	}

	for iter_2_0, iter_2_1 in ipairs(var_2_0) do
		table.insert(var_2_1, ChapterTools.GetRedPoint(iter_2_1))
	end

	manager.redPoint:addGroup(RedPointConst.COMBAT_MAIN, var_2_1, true)
	manager.redPoint:bindUIandKey(self.chapterNameGo_.transform, RedPointConst.COMBAT_PLOT)
	self.lnkView_:OnEnter(var_2_0)
end

function ChapterMainContentView:OnExit()
	self.mainPlotPanelView_:OnExit()
	self.subPlotPanelView_:OnExit()
	manager.redPoint:unbindUIandKey(self.chapterNameGo_.transform, RedPointConst.COMBAT_PLOT)
	self.lnkView_:OnExit()
end

function ChapterMainContentView:Dispose()
	self.mainPlotPanelView_:Dispose()

	self.mainPlotPanelView_ = nil

	self.subPlotPanelView_:Dispose()

	self.subPlotPanelView_ = nil

	self.lnkView_:Dispose()

	self.lnkView_ = nil

	ChapterMainContentView.super.Dispose(self)

	self.gameObject_ = nil
	self.transform_ = nil
end

function ChapterMainContentView:SetActive(arg_5_1)
	SetActive(self.gameObject_, arg_5_1)
	SetActive(self.plotExPanel_, arg_5_1)
end

function ChapterMainContentView:RefreshUI()
	self.lnkView_:RefresLock()
end

return ChapterMainContentView
