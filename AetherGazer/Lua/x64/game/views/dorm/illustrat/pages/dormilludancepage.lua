local var_0_0 = class("DormIlluDancePage", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform
	arg_1_0.recordIndex_ = nil

	arg_1_0:InitData()
	arg_1_0:InitUI()
end

function var_0_0.InitData(arg_2_0)
	arg_2_0.allIDList_ = IdolDanceDIYActionCfg.all
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()
	arg_3_0:AddUIListener()

	arg_3_0.uiList_ = LuaList.New(handler(arg_3_0, arg_3_0.IndexItem), arg_3_0.uiListGo_, DormIlluDanceItem)
end

function var_0_0.AddUIListener(arg_4_0)
	return
end

function var_0_0.Show(arg_5_0, arg_5_1)
	arg_5_0:InitData()
	arg_5_0:RefreshData()
	arg_5_0:RefreshUI(arg_5_1)
	arg_5_0:RegistEventListener(COMMON_FILTER_OK, handler(arg_5_0, arg_5_0.RefreshAll))
end

function var_0_0.Hide(arg_6_0)
	return
end

function var_0_0.OnClickFliter(arg_7_0)
	JumpTools.OpenPageByJump("commonFilterView", {
		filterGroup = Filter_Root_Define.IDOL_DANCE_ACTION_Filter_List
	})
	arg_7_0:RefreshData()
	arg_7_0:RefreshUI()
end

function var_0_0.RefreshAll(arg_8_0)
	arg_8_0:RefreshData()
	arg_8_0:RefreshUI()
end

function var_0_0.RefreshData(arg_9_0)
	arg_9_0.allIDList_ = {}

	local var_9_0 = IdolTraineeTools.FilterDIYDanceAction

	for iter_9_0, iter_9_1 in ipairs(IdolDanceDIYActionCfg.all) do
		if var_9_0 == nil or var_9_0(iter_9_1) then
			table.insert(arg_9_0.allIDList_, iter_9_1)
		end
	end
end

function var_0_0.RefreshUI(arg_10_0, arg_10_1)
	arg_10_0.uiList_:StartScroll(#arg_10_0.allIDList_)
	arg_10_0.uiList_:Refresh()

	if arg_10_0.recordIndex_ and arg_10_1 then
		arg_10_0.uiList_:ScrollToIndex(arg_10_0.recordIndex_)
	end
end

function var_0_0.Dispose(arg_11_0)
	if arg_11_0.uiList_ then
		arg_11_0.uiList_:Dispose()
	end

	arg_11_0.recordIndex_ = nil

	var_0_0.super.Dispose(arg_11_0)
end

function var_0_0.IndexItem(arg_12_0, arg_12_1, arg_12_2)
	arg_12_2:SetData(arg_12_1, arg_12_0.allIDList_[arg_12_1])
	arg_12_2:RegistCallBack(function(arg_13_0, arg_13_1)
		arg_12_0:OpenDetailView(arg_13_0, arg_13_1)
	end)
end

function var_0_0.OpenDetailView(arg_14_0, arg_14_1, arg_14_2)
	arg_14_0.recordIndex_ = arg_14_2

	JumpTools.OpenPageByJump("/dormIlluDanceDetail", {
		danceID = arg_14_1,
		danceIDList = arg_14_0.allIDList_
	})
end

return var_0_0
