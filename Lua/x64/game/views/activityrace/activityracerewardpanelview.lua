local var_0_0 = class("ActivityRaceRewardPanelView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "UI/VolumeIIIDownUI/ActivityRace/ActivityRaceRewardPanelUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddUIListener()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.scrollHelper_ = LuaList.New(handler(arg_4_0, arg_4_0.IndexItem), arg_4_0.scrollView_, ActivityRaceRewardItem)
end

function var_0_0.AddUIListener(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.backMask_, nil, function()
		arg_5_0:Back()
	end)
end

function var_0_0.OnEnter(arg_7_0)
	arg_7_0.activityID_ = arg_7_0.params_.activityID

	arg_7_0:RefreshUI()
end

function var_0_0.RefreshUI(arg_8_0)
	arg_8_0.sortedRewardList_ = ActivityRaceData:GetSortedRewardList(arg_8_0.activityID_)

	arg_8_0.scrollHelper_:StartScroll(#arg_8_0.sortedRewardList_)
end

function var_0_0.IndexItem(arg_9_0, arg_9_1, arg_9_2)
	arg_9_2:SetData(arg_9_0.sortedRewardList_[arg_9_1])
end

function var_0_0.Dispose(arg_10_0)
	arg_10_0.scrollHelper_:Dispose()
	var_0_0.super.Dispose(arg_10_0)
end

return var_0_0
