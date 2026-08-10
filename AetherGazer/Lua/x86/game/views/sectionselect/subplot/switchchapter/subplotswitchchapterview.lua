local var_0_0 = class("SubPlotSwitchChapterView", ReduxView)

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform
	arg_1_0.chapterItemList_ = {}

	arg_1_0:BindCfgUI()
	arg_1_0:AddListeners()
end

function var_0_0.OnEnter(arg_2_0)
	BattleStageAction.ClickSubPlot(arg_2_0.chapterID_)

	for iter_2_0, iter_2_1 in pairs(arg_2_0.chapterItemList_) do
		iter_2_1:OnEnter()
	end

	local var_2_0 = getChapterClientCfgByChapterID(arg_2_0.chapterID_)

	manager.redPoint:bindUIandKey(arg_2_0.selectResourceBtn_.transform, string.format("%s_%s", RedPointConst.COMBAT_SUB_PLOT_CHAPTER_LIST, var_2_0.id))
end

function var_0_0.OnExit(arg_3_0)
	arg_3_0:StopTimer()
	SetActive(arg_3_0.selectResourcePanel_, false)

	for iter_3_0, iter_3_1 in pairs(arg_3_0.chapterItemList_) do
		iter_3_1:OnExit()
	end

	local var_3_0 = getChapterClientCfgByChapterID(arg_3_0.chapterID_)

	manager.redPoint:unbindUIandKey(arg_3_0.selectResourceBtn_.transform, string.format("%s_%s", RedPointConst.COMBAT_SUB_PLOT_CHAPTER_LIST, var_3_0.id))
end

function var_0_0.Dispose(arg_4_0)
	var_0_0.super.Dispose(arg_4_0)

	for iter_4_0, iter_4_1 in ipairs(arg_4_0.chapterItemList_) do
		iter_4_1:Dispose()
	end

	arg_4_0.chapterItemList_ = nil
end

function var_0_0.SetData(arg_5_0, arg_5_1)
	arg_5_0.chapterID_ = arg_5_1
end

function var_0_0.RefreshUI(arg_6_0)
	arg_6_0:RefreshChapterBtn()
	arg_6_0:RefreshChapterItemBtn()
end

function var_0_0.AddListeners(arg_7_0)
	arg_7_0:AddBtnListener(arg_7_0.selectResourceBtn_, nil, function()
		SetActive(arg_7_0.selectResourcePanel_, true)
		arg_7_0:ClickListener()
	end)
end

function var_0_0.RefreshChapterItemBtn(arg_9_0)
	arg_9_0.selectResourceText_.text = GetI18NText(ChapterCfg[arg_9_0.chapterID_].subhead)
end

function var_0_0.RefreshChapterBtn(arg_10_0)
	local var_10_0 = getChapterClientCfgByChapterID(arg_10_0.chapterID_)
	local var_10_1 = var_10_0.chapter_list
	local var_10_2 = #var_10_1 > 1

	if var_10_0.id == 6010010 then
		var_10_2 = false
	end

	SetActive(arg_10_0.gameObject_, var_10_2)

	for iter_10_0, iter_10_1 in pairs(var_10_1) do
		if arg_10_0.chapterItemList_[iter_10_0] then
			arg_10_0.chapterItemList_[iter_10_0]:SetData(iter_10_1)
		else
			arg_10_0.chapterItemList_[iter_10_0] = SubPlotBtnView.New(arg_10_0.selectResourceItem_, arg_10_0.selectResourcePanel_, iter_10_1)
		end
	end

	for iter_10_2 = #var_10_1 + 1, #arg_10_0.chapterItemList_ do
		arg_10_0.chapterItemList_[iter_10_2]:Show(false)
	end
end

function var_0_0.ClickListener(arg_11_0)
	if not arg_11_0.clickTimer_ then
		arg_11_0.buttonUp_ = 0
		arg_11_0.clickTimer_ = FuncTimerManager.inst:CreateFuncFrameTimer(function()
			if Input.GetMouseButtonUp(0) then
				arg_11_0.buttonUp_ = arg_11_0.buttonUp_ + 1

				if arg_11_0.buttonUp_ >= 2 then
					SetActive(arg_11_0.selectResourcePanel_, false)
					FuncTimerManager.inst:RemoveFuncTimer(arg_11_0.clickTimer_)

					arg_11_0.clickTimer_ = nil
				end
			end
		end, -1, true)
	end
end

function var_0_0.StopTimer(arg_13_0)
	if arg_13_0.clickTimer_ then
		FuncTimerManager.inst:RemoveFuncTimer(arg_13_0.clickTimer_)

		arg_13_0.clickTimer_ = nil
	end
end

return var_0_0
