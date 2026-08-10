local var_0_0 = class("SailIslandRewardView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "UI/VersionUI/XuHeng3rdUI/XH3rdVoyagesUI/XH3rdVoyagesRewardPopUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiPop.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddUIListener()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.rewardItemList_ = LuaList.New(handler(arg_4_0, arg_4_0.IndexItem), arg_4_0.uiList_, SailIslandRewardItem)
end

function var_0_0.AddUIListener(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.maskBtn_, nil, function()
		arg_5_0:Back()
	end)
end

function var_0_0.OnEnter(arg_7_0)
	arg_7_0.activityID_ = arg_7_0.params_.activityID

	arg_7_0:RefreshUI()
end

function var_0_0.Dispose(arg_8_0)
	arg_8_0.rewardItemList_:Dispose()

	arg_8_0.rewardItemList_ = nil

	var_0_0.super.Dispose(arg_8_0)
end

function var_0_0.RefreshUI(arg_9_0)
	arg_9_0.sortTaskList_ = SailGameData:GetSortTaskList(arg_9_0.activityID_)

	arg_9_0.rewardItemList_:StartScroll(#arg_9_0.sortTaskList_)
end

function var_0_0.IndexItem(arg_10_0, arg_10_1, arg_10_2)
	arg_10_2:SetData(arg_10_0.sortTaskList_[arg_10_1], arg_10_0.activityID_)
end

function var_0_0.OnReceiveSailTask(arg_11_0)
	arg_11_0:RefreshUI()
end

return var_0_0
