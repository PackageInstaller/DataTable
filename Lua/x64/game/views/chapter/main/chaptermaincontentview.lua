local var_0_0 = class("ChapterMainContentView", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform
	arg_1_0.chapterToggle_ = arg_1_2

	arg_1_0:BindCfgUI()

	arg_1_0.mainPlotPanelView_ = ChapterMainPlotPanelView.New(arg_1_0.chapterGo_)
	arg_1_0.subPlotPanelView_ = ChapterSubPlotPanelView.New(arg_1_0.subPlotGo_)
	arg_1_0.lnkView_ = ChapterChallengeLnkView.New(arg_1_0.lnkPanelGo_)
end

function var_0_0.OnEnter(arg_2_0)
	arg_2_0.mainPlotPanelView_:OnEnter()
	arg_2_0.subPlotPanelView_:OnEnter()

	local var_2_0 = ChapterTools.GetChapterChallengeLnkList()
	local var_2_1 = {
		RedPointConst.COMBAT_PLOT,
		RedPointConst.COMBAT_SUB_PLOT
	}

	for iter_2_0, iter_2_1 in ipairs(var_2_0) do
		table.insert(var_2_1, ChapterTools.GetRedPoint(iter_2_1))
	end

	manager.redPoint:addGroup(RedPointConst.COMBAT_MAIN, var_2_1, true)
	manager.redPoint:bindUIandKey(arg_2_0.chapterNameGo_.transform, RedPointConst.COMBAT_PLOT)
	arg_2_0.lnkView_:OnEnter(var_2_0)
end

function var_0_0.OnExit(arg_3_0)
	arg_3_0.mainPlotPanelView_:OnExit()
	arg_3_0.subPlotPanelView_:OnExit()
	manager.redPoint:unbindUIandKey(arg_3_0.chapterNameGo_.transform, RedPointConst.COMBAT_PLOT)
	arg_3_0.lnkView_:OnExit()
end

function var_0_0.Dispose(arg_4_0)
	arg_4_0.mainPlotPanelView_:Dispose()

	arg_4_0.mainPlotPanelView_ = nil

	arg_4_0.subPlotPanelView_:Dispose()

	arg_4_0.subPlotPanelView_ = nil

	arg_4_0.lnkView_:Dispose()

	arg_4_0.lnkView_ = nil

	var_0_0.super.Dispose(arg_4_0)

	arg_4_0.gameObject_ = nil
	arg_4_0.transform_ = nil
end

function var_0_0.SetActive(arg_5_0, arg_5_1)
	SetActive(arg_5_0.gameObject_, arg_5_1)
	SetActive(arg_5_0.plotExPanel_, arg_5_1)
end

function var_0_0.RefreshUI(arg_6_0)
	arg_6_0.lnkView_:RefresLock()
end

return var_0_0
