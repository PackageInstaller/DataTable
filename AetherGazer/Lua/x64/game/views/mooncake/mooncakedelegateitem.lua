local var_0_0 = class("MoonCakeDelegateItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_0.gameObject_.transform

	arg_1_0:InitUI()

	arg_1_0.commonPortrait_ = CommonHeadPortrait.New(arg_1_0.headItem_)

	arg_1_0:AddUIListener()
end

function var_0_0.InitUI(arg_2_0)
	arg_2_0:BindCfgUI()

	arg_2_0.statusController_ = ControllerUtil.GetController(arg_2_0.transform_, "status")
	arg_2_0.friendController_ = ControllerUtil.GetController(arg_2_0.transform_, "friend")
end

function var_0_0.AddUIListener(arg_3_0)
	if arg_3_0.submitBtn_ then
		arg_3_0:AddBtnListener(arg_3_0.submitBtn_, nil, function()
			if not ActivityData:GetActivityIsOpen(arg_3_0.activityID_) then
				ShowTips("TIME_OVER")

				return
			end

			if GameSetting.activity_mid_autumn_entrust_finish_limit.value[1] <= MoonCakeData:GetTodaySubmitTimes(arg_3_0.activityID_) then
				ShowTips("MID_AUTUMN_FESTIVAL_TASK_FINISH_LIMIT")

				return
			end

			local var_4_0 = arg_3_0.delegateData_.delegateID
			local var_4_1 = arg_3_0.delegateData_.uid

			MoonCakeAction.SubmitDelegate(arg_3_0.activityID_, var_4_1, var_4_0)
		end)
	end

	arg_3_0:AddBtnListener(arg_3_0.headBtn_, nil, function()
		if not ActivityData:GetActivityIsOpen(arg_3_0.activityID_) then
			ShowTips("TIME_OVER")

			return
		end

		ForeignInfoAction:TryToCheckForeignDetailInfo(arg_3_0.delegateData_.uid)
	end)

	if arg_3_0.addFriendBtn_ then
		arg_3_0:AddBtnListener(arg_3_0.addFriendBtn_, nil, function()
			if not ActivityData:GetActivityIsOpen(arg_3_0.activityID_) then
				ShowTips("TIME_OVER")

				return
			end

			local var_6_0 = arg_3_0.delegateData_.uid

			if FriendsData:IsCanBeFriend(var_6_0) then
				FriendsAction:TryToRequestToFriend(var_6_0, FriendConst.ADD_FRIEND_SOURCE.MOON_CAKE_DELEGATE)
			end
		end)
	end
end

function var_0_0.SetData(arg_7_0, arg_7_1, arg_7_2)
	arg_7_0.activityID_ = arg_7_2
	arg_7_0.delegateData_ = arg_7_1

	arg_7_0:RefreshUI()
end

function var_0_0.RefreshUI(arg_8_0)
	arg_8_0:RefreshPrincipal()
	arg_8_0:RefreshFriend()
	arg_8_0:RefreshDelegate()
	arg_8_0:RefreshStatus()
end

function var_0_0.RefreshPrincipal(arg_9_0)
	arg_9_0.userName_.text = arg_9_0.delegateData_.nick
	arg_9_0.userLevel_.text = "LV." .. arg_9_0.delegateData_.level
	arg_9_0.userUid_.text = arg_9_0.delegateData_.uid

	arg_9_0.commonPortrait_:RenderHead(arg_9_0.delegateData_.portrait)
	arg_9_0.commonPortrait_:RenderFrame(arg_9_0.delegateData_.frame)
end

function var_0_0.RefreshFriend(arg_10_0)
	if FriendsData:IsFriend(arg_10_0.delegateData_.uid) == true then
		arg_10_0.friendController_:SetSelectedState("myFriend")
	elseif FriendsData:IsInRequest(arg_10_0.delegateData_.uid) == true then
		arg_10_0.friendController_:SetSelectedState("requested")
	else
		arg_10_0.friendController_:SetSelectedState("add")
	end
end

function var_0_0.RefreshDelegate(arg_11_0)
	local var_11_0 = arg_11_0.delegateData_.targetID
	local var_11_1 = MoonCakeCfg[var_11_0].moon_cakes

	arg_11_0.curNum_ = ItemTools.getItemNum(var_11_1) or 0

	if arg_11_0.curNum_ > 0 then
		arg_11_0.moonCakeCurNum_.text = string.format(GetTips("MID_AUTUMN_FESTIVAL_MOONCAKE_QUANTITY"), arg_11_0.curNum_)
	else
		arg_11_0.moonCakeCurNum_.text = GetTips("MID_AUTUMN_FESTIVAL_TASK_MOONCAKE_NOT_ENOUGH")
	end

	arg_11_0.moonCakeName_.text = ItemTools.getItemName(var_11_1)
	arg_11_0.moonCakeIcon_.sprite = ItemTools.getItemSprite(var_11_1)
	arg_11_0.moonCakeNeedNum_.text = "x1"
end

function var_0_0.RefreshStatus(arg_12_0)
	if arg_12_0.delegateData_.isCompleted == true then
		arg_12_0.statusController_:SetSelectedState("complete")
	elseif arg_12_0.curNum_ <= 0 then
		arg_12_0.statusController_:SetSelectedState("notEnough")

		arg_12_0.submitBtn_.interactable = false
	else
		arg_12_0.statusController_:SetSelectedState("enough")

		arg_12_0.submitBtn_.interactable = true
	end
end

function var_0_0.SetStatus(arg_13_0, arg_13_1)
	arg_13_0.statusController_:SetSelectedState(arg_13_1)
end

function var_0_0.SetClickHandler(arg_14_0, arg_14_1)
	arg_14_0.clickHandler_ = arg_14_1
end

function var_0_0.OnSubmitDelegate(arg_15_0)
	arg_15_0.delegateData_ = MoonCakeData:GetDelegateData(arg_15_0.activityID_, arg_15_0.delegateID_)

	arg_15_0:RefreshStatus()
end

function var_0_0.Dispose(arg_16_0)
	arg_16_0.commonPortrait_:Dispose()
	var_0_0.super.Dispose(arg_16_0)
end

return var_0_0
