local var_0_0 = class("PaChinKoMainRewardList", ReduxView)

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform
	arg_1_0.index_ = arg_1_2

	arg_1_0:BindCfgUI()
	arg_1_0:AddListeners()

	arg_1_0.rewardController_ = arg_1_0.uiControllerEx_:GetController("reward")
	arg_1_0.uiList_ = LuaList.New(handler(arg_1_0, arg_1_0.IndexItem), arg_1_0.uiListGo_, PaChinKoMainRewardItem)
	arg_1_0.uiTitleText_.text = GetTips(string.format("PACHINKO_LEVEL_REWARD_%s", arg_1_2))
end

function var_0_0.Dispose(arg_2_0)
	arg_2_0.uiList_:Dispose()

	arg_2_0.uiList_ = nil

	var_0_0.super.Dispose(arg_2_0)
end

function var_0_0.AddListeners(arg_3_0)
	return
end

function var_0_0.OnEnter(arg_4_0, arg_4_1)
	arg_4_0.activityID_ = arg_4_1
	arg_4_0.rewardIDList_ = PaChinKoTools.GetLevelRewardList(arg_4_0.activityID_, arg_4_0.index_)

	arg_4_0.uiList_:StartScroll(#arg_4_0.rewardIDList_)
	arg_4_0:RefreshUI()
end

function var_0_0.RefreshUI(arg_5_0)
	arg_5_0.uiList_:Refresh()
end

function var_0_0.OnExit(arg_6_0)
	return
end

function var_0_0.IndexItem(arg_7_0, arg_7_1, arg_7_2)
	local var_7_0 = arg_7_0.rewardIDList_[arg_7_1]

	arg_7_2:SetData(arg_7_0.activityID_, var_7_0)
end

return var_0_0
