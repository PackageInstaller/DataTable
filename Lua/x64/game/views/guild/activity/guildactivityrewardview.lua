local var_0_0 = class("GuildActivityRewardView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "UI/GuildActivityUI/GuildActivityRewardPop"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddUIListener()

	arg_3_0.receiveHandler_ = handler(arg_3_0, arg_3_0.OnGuildActivityReceiveRateReward)
end

function var_0_0.AddUIListener(arg_4_0)
	arg_4_0:AddBtnListener(arg_4_0.bgBtn_, nil, function()
		arg_4_0:Back()
	end)
end

function var_0_0.InitUI(arg_6_0)
	arg_6_0:BindCfgUI()

	arg_6_0.scrollHelper_ = LuaList.New(handler(arg_6_0, arg_6_0.IndexItem), arg_6_0.listGo_, GuildActivityRewardItem)
end

function var_0_0.OnEnter(arg_7_0)
	GuildActivityLuaBridge.GetManager():SetOnWarField(false)

	manager.ui.mainCameraCom_.orthographic = true
	arg_7_0.activityID_ = arg_7_0.params_.activityID
	arg_7_0.rateIDList_ = GuildActivityData:GetSortedRateIDList(arg_7_0.activityID_)

	arg_7_0.scrollHelper_:StartScroll(#arg_7_0.rateIDList_)
end

function var_0_0.IndexItem(arg_8_0, arg_8_1, arg_8_2)
	arg_8_2:SetData(arg_8_0.rateIDList_[arg_8_1], arg_8_0.activityID_)
	arg_8_2:setReceiveCallBack(arg_8_0.receiveHandler_)
end

function var_0_0.Dispose(arg_9_0)
	arg_9_0.scrollHelper_:Dispose()
	var_0_0.super.Dispose(arg_9_0)
end

function var_0_0.OnGuildActivityReceiveRateReward(arg_10_0)
	arg_10_0.rateIDList_ = GuildActivityData:GetSortedRateIDList(arg_10_0.activityID_)

	arg_10_0.scrollHelper_:StartScroll(#arg_10_0.rateIDList_)
end

return var_0_0
