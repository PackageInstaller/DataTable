local var_0_0 = class("MoonCakeOwnDelegateItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_0.gameObject_.transform

	arg_1_0:InitUI()
	arg_1_0:AddUIListener()
end

function var_0_0.InitUI(arg_2_0)
	arg_2_0:BindCfgUI()

	arg_2_0.commonPortrait_ = CommonHeadPortrait.New(arg_2_0.headItem_)
	arg_2_0.friendController_ = ControllerUtil.GetController(arg_2_0.transform_, "friend")
end

function var_0_0.AddUIListener(arg_3_0)
	arg_3_0:AddBtnListener(arg_3_0.addFriendBtn_, nil, function()
		if not ActivityData:GetActivityIsOpen(arg_3_0.activityID_) then
			ShowTips("TIME_OVER")

			return
		end

		local var_4_0 = arg_3_0.delegateData_.submiter_uid

		if FriendsData:IsCanBeFriend(var_4_0) then
			FriendsAction:TryToRequestToFriend(var_4_0, FriendConst.ADD_FRIEND_SOURCE.MOON_CAKE_DELEGATE)
		end
	end)
	arg_3_0:AddBtnListener(arg_3_0.headBtn_, nil, function()
		if not ActivityData:GetActivityIsOpen(arg_3_0.activityID_) then
			ShowTips("TIME_OVER")

			return
		end

		ForeignInfoAction:TryToCheckForeignDetailInfo(arg_3_0.delegateData_.submiter_uid)
	end)
end

function var_0_0.SetData(arg_6_0, arg_6_1, arg_6_2)
	arg_6_0.activityID_ = arg_6_2
	arg_6_0.delegateData_ = arg_6_1

	arg_6_0:RefreshUI()
end

function var_0_0.RefreshUI(arg_7_0)
	arg_7_0:RefreshDelegate()
	arg_7_0:RefreshGiver()
	arg_7_0:RefreshFriend()
end

function var_0_0.RefreshGiver(arg_8_0)
	local var_8_0 = arg_8_0.delegateData_.submiter_uid

	arg_8_0.userName_.text = arg_8_0.delegateData_.nick

	arg_8_0.commonPortrait_:RenderHead(arg_8_0.delegateData_.portrait)
	arg_8_0.commonPortrait_:RenderFrame(arg_8_0.delegateData_.frame)
end

function var_0_0.RefreshFriend(arg_9_0)
	local var_9_0 = arg_9_0.delegateData_.submiter_uid

	if FriendsData:IsFriend(var_9_0) == true then
		arg_9_0.friendController_:SetSelectedState("myFriend")
	elseif FriendsData:IsInRequest(var_9_0) == true then
		arg_9_0.friendController_:SetSelectedState("requested")
	else
		arg_9_0.friendController_:SetSelectedState("add")
	end
end

function var_0_0.RefreshDelegate(arg_10_0)
	local var_10_0 = arg_10_0.delegateData_.targetID
	local var_10_1 = MoonCakeCfg[var_10_0].moon_cakes

	arg_10_0.moonCakeName_.text = ItemTools.getItemName(var_10_1) .. "X1"
	arg_10_0.moonCakeIcon_.sprite = ItemTools.getItemSprite(var_10_1)
end

function var_0_0.Dispose(arg_11_0)
	arg_11_0.commonPortrait_:Dispose()
	var_0_0.super.Dispose(arg_11_0)
end

return var_0_0
