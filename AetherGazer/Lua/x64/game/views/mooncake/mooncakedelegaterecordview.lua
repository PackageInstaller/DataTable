local var_0_0 = class("MoonCakeDelegateRecordView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "UI/VersionUI/JapanRegionUI_2_4/JapanRegionMidautumnUI/MoonCakeDelegateRecordUI"
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

	arg_4_0.typeController_ = ControllerUtil.GetController(arg_4_0.transform_, "type")
	arg_4_0.submitedDelegateList_ = LuaList.New(handler(arg_4_0, arg_4_0.IndexSubmitedItem), arg_4_0.completedListGo_, MoonCakeDelegateItem)
	arg_4_0.ownDelegateList_ = LuaList.New(handler(arg_4_0, arg_4_0.IndexOwnItem), arg_4_0.ownListGo_, MoonCakeOwnDelegateItem)
	arg_4_0.recordTypeConst_ = {
		other = 2,
		own = 1
	}
end

function var_0_0.AddUIListener(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.maskBtn_, nil, function()
		arg_5_0:Back()
	end)
end

function var_0_0.Dispose(arg_7_0)
	arg_7_0.submitedDelegateList_:Dispose()

	arg_7_0.submitedDelegateList_ = nil

	arg_7_0.ownDelegateList_:Dispose()

	arg_7_0.ownDelegateList_ = nil

	var_0_0.super.Dispose(arg_7_0)
end

function var_0_0.OnEnter(arg_8_0)
	arg_8_0.activityID_ = arg_8_0.params_.activityID

	if arg_8_0.params_.isBack then
		arg_8_0.curType_ = MoonCakeTools.GetTempRecordViewType(arg_8_0.activityID_)
		arg_8_0.tempScrollPos_ = MoonCakeTools.GetTempRecordViewScrollPos(arg_8_0.activityID_)
	else
		arg_8_0.curType_ = arg_8_0.params_.recoverType
		arg_8_0.tempScrollPos_ = nil
	end

	if arg_8_0.recordTypeConst_.own == arg_8_0.curType_ then
		arg_8_0:RefreshOwnDelegate(arg_8_0.tempScrollPos_)
	else
		arg_8_0:RefreshSubmitedDelegate(arg_8_0.tempScrollPos_)
	end

	arg_8_0.typeController_:SetSelectedIndex(arg_8_0.curType_ - 1)
end

function var_0_0.OnExit(arg_9_0)
	MoonCakeTools.SetTempRecordViewType(arg_9_0.activityID_, arg_9_0.curType_)

	local var_9_0

	if arg_9_0.curType_ == arg_9_0.recordTypeConst_.own then
		var_9_0 = arg_9_0.ownDelegateList_:GetScrolledPosition()
	else
		var_9_0 = arg_9_0.submitedDelegateList_:GetScrolledPosition()
	end

	MoonCakeTools.SetTempRecordViewScrollPos(arg_9_0.activityID_, var_9_0)

	arg_9_0.tempScrollPos_ = nil
end

function var_0_0.RefreshSubmitedDelegate(arg_10_0, arg_10_1)
	arg_10_0.submitedDelegateDataList_ = MoonCakeData:GetSubmitedDelegateList(arg_10_0.activityID_)

	if not arg_10_1 then
		arg_10_0.submitedDelegateList_:StartScroll(#arg_10_0.submitedDelegateDataList_)
	else
		arg_10_0.submitedDelegateList_:StartScrollByPosition(#arg_10_0.submitedDelegateDataList_, arg_10_1)
	end
end

function var_0_0.RefreshOwnDelegate(arg_11_0, arg_11_1)
	arg_11_0.ownDelegateDataList_ = MoonCakeData:GetOwnSubmitedDelegateList(arg_11_0.activityID_)

	if not arg_11_1 then
		arg_11_0.ownDelegateList_:StartScroll(#arg_11_0.ownDelegateDataList_)
	else
		arg_11_0.ownDelegateList_:StartScrollByPosition(#arg_11_0.ownDelegateDataList_, arg_11_1)
	end
end

function var_0_0.IndexSubmitedItem(arg_12_0, arg_12_1, arg_12_2)
	arg_12_2:SetData(arg_12_0.submitedDelegateDataList_[arg_12_1], arg_12_0.activityID_)
end

function var_0_0.IndexOwnItem(arg_13_0, arg_13_1, arg_13_2)
	arg_13_2:SetData(arg_13_0.ownDelegateDataList_[arg_13_1], arg_13_0.activityID_)
end

function var_0_0.OnReceiveDelegateReward(arg_14_0)
	arg_14_0:RefreshOwnDelegate()
end

function var_0_0.OnFriendsListChange(arg_15_0)
	local var_15_0

	if arg_15_0.recordTypeConst_.own == arg_15_0.curType_ then
		var_15_0 = arg_15_0.ownDelegateList_:GetItemList()
	else
		var_15_0 = arg_15_0.submitedDelegateList_:GetItemList()
	end

	for iter_15_0, iter_15_1 in ipairs(var_15_0) do
		iter_15_1:RefreshFriend()
	end
end

return var_0_0
