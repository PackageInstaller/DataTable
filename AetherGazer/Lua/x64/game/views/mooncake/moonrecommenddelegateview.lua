local var_0_0 = class("MoonRecommendDelegateView", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_0.gameObject_.transform

	arg_1_0:InitUI()
end

function var_0_0.InitUI(arg_2_0)
	arg_2_0:BindCfgUI()

	arg_2_0.delegateList_ = LuaList.New(handler(arg_2_0, arg_2_0.IndexItem), arg_2_0.listGo_, MoonCakeDelegateItem)
end

function var_0_0.Dispose(arg_3_0)
	arg_3_0.delegateList_:Dispose()

	arg_3_0.delegateList_ = nil

	var_0_0.super.Dispose(arg_3_0)
end

function var_0_0.Show(arg_4_0, arg_4_1)
	SetActive(arg_4_0.gameObject_, arg_4_1)
end

function var_0_0.SetData(arg_5_0, arg_5_1, arg_5_2)
	arg_5_0.activityID_ = arg_5_1

	arg_5_0:RefreshList(arg_5_2)
	arg_5_0:RefreshProgress()
end

function var_0_0.RefreshList(arg_6_0, arg_6_1)
	arg_6_0.delegateDataList_ = MoonCakeData:GetSortRecommendDelegateList(arg_6_0.activityID_)

	if not arg_6_1 then
		arg_6_0.delegateList_:StartScroll(#arg_6_0.delegateDataList_)
	else
		arg_6_0.delegateList_:StartScrollByPosition(#arg_6_0.delegateDataList_, arg_6_1)
	end
end

function var_0_0.RefreshProgress(arg_7_0)
	local var_7_0 = GameSetting.activity_mid_autumn_entrust_finish_limit.value[1]
	local var_7_1 = MoonCakeData:GetTodaySubmitTimes(arg_7_0.activityID_)

	var_7_1 = var_7_1 <= var_7_0 and var_7_1 or var_7_0
	arg_7_0.progressText_.text = string.format("%s/%s", var_7_0 - var_7_1, var_7_0)
end

function var_0_0.GetScrollPos(arg_8_0)
	return arg_8_0.delegateList_:GetScrolledPosition()
end

function var_0_0.IndexItem(arg_9_0, arg_9_1, arg_9_2)
	arg_9_2:SetData(arg_9_0.delegateDataList_[arg_9_1], arg_9_0.activityID_)
end

function var_0_0.PageRegisterEvent(arg_10_0)
	arg_10_0:RegistEventListener(MOON_DELEGATE_SUBMIT, handler(arg_10_0, arg_10_0.OnSubmitDelegate))
	arg_10_0:RegistEventListener(MOON_RECOMMEND_DELEGATE_UPDATE, handler(arg_10_0, arg_10_0.OnRefreshRecommendDelegate))
end

function var_0_0.PageRemoveEvent(arg_11_0)
	arg_11_0:RemoveAllEventListener()
end

function var_0_0.OnSubmitDelegate(arg_12_0)
	local var_12_0 = arg_12_0.delegateList_:GetItemList()

	for iter_12_0, iter_12_1 in pairs(var_12_0) do
		iter_12_1:RefreshUI()
	end

	arg_12_0:RefreshProgress()
end

function var_0_0.OnRefreshRecommendDelegate(arg_13_0)
	arg_13_0:RefreshList()
end

function var_0_0.OnFriendsListChange(arg_14_0)
	local var_14_0 = arg_14_0.delegateList_:GetItemList()

	for iter_14_0, iter_14_1 in pairs(var_14_0) do
		iter_14_1:RefreshFriend()
	end
end

return var_0_0
