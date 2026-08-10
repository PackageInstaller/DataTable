local var_0_0 = class("FriendsView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Friends/FriendsUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddUIListeners()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.contentView_ = FriendsRightContentView.New(arg_4_0.rightContentPanel_)
	arg_4_0.toggle_ = {}
	arg_4_0.toggleCon_ = {}

	for iter_4_0 = 1, 4 do
		arg_4_0.toggle_[iter_4_0] = arg_4_0["tgl_" .. iter_4_0]
		arg_4_0.toggleCon_[iter_4_0] = ControllerUtil.GetController(arg_4_0.toggle_[iter_4_0].transform, "name")
	end

	arg_4_0.pageCon_ = ControllerUtil.GetController(arg_4_0.gameObject_.transform, "pageCon")
end

function var_0_0.AddUIListeners(arg_5_0)
	for iter_5_0, iter_5_1 in ipairs(arg_5_0.toggle_) do
		arg_5_0:AddBtnListener(iter_5_1, nil, function()
			if iter_5_0 ~= arg_5_0.curPageIndex_ then
				arg_5_0:RefreshUI(iter_5_0)
			end
		end)
	end
end

function var_0_0.OnEnter(arg_7_0)
	arg_7_0.contentView_:OnEnter()

	arg_7_0.params_.friendPage = arg_7_0.params_.friendPage or FriendsConst.FRIEND_TYPE.MY_FRIENDS
	arg_7_0.curPageIndex_ = arg_7_0.params_.friendPage == FriendsConst.FRIEND_TYPE.SEARCH and FriendsConst.FRIEND_TYPE.NEW_FRIENDS or arg_7_0.params_.friendPage

	arg_7_0:BindRedPoint()
	arg_7_0:RefreshUI(arg_7_0.curPageIndex_)
end

function var_0_0.RefreshUI(arg_8_0, arg_8_1)
	arg_8_0.isRefreshing_ = true
	arg_8_0.curPageIndex_ = arg_8_1
	arg_8_0.params_.friendPage = arg_8_0.curPageIndex_

	if arg_8_0.curPageIndex_ == FriendsConst.FRIEND_TYPE.MY_FRIENDS then
		FriendsAction:TryToRefreshFriendsView(1)
	elseif arg_8_0.curPageIndex_ == FriendsConst.FRIEND_TYPE.NEW_FRIENDS then
		if not FriendsData:GetHadFreshNewFriend() then
			FriendsAction:TryToRefreshNewFriendsList(1)
		else
			arg_8_0.isRefreshing_ = false

			arg_8_0.contentView_:RefreshUI(arg_8_0.curPageIndex_)
			arg_8_0.pageCon_:SetSelectedState(arg_8_0.curPageIndex_)
			arg_8_0:RefreshTgl(FriendsConst.FRIEND_TYPE.NEW_FRIENDS)
		end
	elseif arg_8_0.curPageIndex_ == FriendsConst.FRIEND_TYPE.SEARCH then
		arg_8_0.isRefreshing_ = false

		arg_8_0.contentView_:RefreshUI(arg_8_0.curPageIndex_)
		arg_8_0.pageCon_:SetSelectedState(arg_8_0.curPageIndex_)
		arg_8_0:RefreshTgl(FriendsConst.FRIEND_TYPE.NEW_FRIENDS)
	elseif arg_8_0.curPageIndex_ == FriendsConst.FRIEND_TYPE.FRIEND_REQUESTS then
		FriendsAction:TryToRefreshFriendsView(2)
	elseif arg_8_0.curPageIndex_ == FriendsConst.FRIEND_TYPE.BLACKLIST then
		FriendsAction:TryToRefreshFriendsView(3)
	end
end

function var_0_0.RefreshTgl(arg_9_0, arg_9_1)
	for iter_9_0, iter_9_1 in ipairs(arg_9_0.toggleCon_) do
		iter_9_1:SetSelectedState(iter_9_0 == arg_9_1 and "false" or "true")
	end
end

function var_0_0.OnFriendsListChange(arg_10_0, arg_10_1)
	if arg_10_0.curPageIndex_ == FriendsConst.FRIEND_TYPE.NEW_FRIENDS and arg_10_1 == FriendsConst.FRIEND_TYPE.SEARCH then
		arg_10_0.curPageIndex_ = FriendsConst.FRIEND_TYPE.SEARCH
		arg_10_0.params_.friendPage = arg_10_0.curPageIndex_
	elseif arg_10_0.curPageIndex_ == FriendsConst.FRIEND_TYPE.SEARCH and arg_10_1 == FriendsConst.FRIEND_TYPE.NEW_FRIENDS then
		arg_10_0.curPageIndex_ = FriendsConst.FRIEND_TYPE.NEW_FRIENDS
		arg_10_0.params_.friendPage = arg_10_1
	end

	if arg_10_0.curPageIndex_ == FriendsConst.FRIEND_TYPE.SEARCH then
		arg_10_0:RefreshTgl(FriendsConst.FRIEND_TYPE.NEW_FRIENDS)
		arg_10_0.pageCon_:SetSelectedState(arg_10_0.curPageIndex_)
		arg_10_0.contentView_:RefreshUI(arg_10_0.curPageIndex_)
	else
		arg_10_0:RefreshTgl(arg_10_0.curPageIndex_)
		arg_10_0.pageCon_:SetSelectedState(arg_10_0.curPageIndex_)
		arg_10_0.contentView_:RefreshUI(arg_10_0.curPageIndex_)
	end
end

function var_0_0.OnFriendsChatChange(arg_11_0, arg_11_1, arg_11_2, arg_11_3)
	if arg_11_0.isRefreshing_ then
		return
	end

	if arg_11_0.curPageIndex_ == FriendsConst.FRIEND_TYPE.MY_FRIENDS then
		arg_11_0.contentView_:OnFriendsChatChange(arg_11_1, arg_11_2, arg_11_3)
	end
end

function var_0_0.OnFriendsUnreadChange(arg_12_0, arg_12_1, arg_12_2)
	if arg_12_0.isRefreshing_ then
		return
	end

	if arg_12_0.curPageIndex_ == FriendsConst.FRIEND_TYPE.MY_FRIENDS then
		arg_12_0.contentView_:OnFriendsUnreadChange(arg_12_1, arg_12_2)
	end
end

function var_0_0.BindRedPoint(arg_13_0)
	manager.redPoint:bindUIandKey(arg_13_0.toggle_[3].transform, RedPointConst.FRIEND_FRIEND_REQUESTS)
end

function var_0_0.UnbindRedPoint(arg_14_0)
	manager.redPoint:unbindUIandKey(arg_14_0.toggle_[3].transform, RedPointConst.FRIEND_FRIEND_REQUESTS)
end

function var_0_0.OnTop(arg_15_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
end

function var_0_0.OnExit(arg_16_0)
	arg_16_0:UnbindRedPoint()
	arg_16_0.contentView_:OnExit()
	manager.windowBar:HideBar()
end

function var_0_0.Dispose(arg_17_0)
	arg_17_0:RemoveAllListeners()
	arg_17_0.contentView_:Dispose()
	var_0_0.super.Dispose(arg_17_0)
end

return var_0_0
