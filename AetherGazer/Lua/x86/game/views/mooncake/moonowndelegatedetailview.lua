local var_0_0 = class("MoonOwnDelegateDetailView", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_0.gameObject_.transform

	arg_1_0:InitUI()
	arg_1_0:AddUIListener()
end

function var_0_0.InitUI(arg_2_0)
	arg_2_0:BindCfgUI()

	arg_2_0.statusController_ = ControllerUtil.GetController(arg_2_0.transform_, "status")
	arg_2_0.friendController_ = ControllerUtil.GetController(arg_2_0.transform_, "friend")
	arg_2_0.commonPortrait_ = CommonHeadPortrait.New(arg_2_0.headItem_)
end

function var_0_0.AddUIListener(arg_3_0)
	arg_3_0:AddBtnListener(arg_3_0.dispatchBtn_, nil, function()
		if not ActivityData:GetActivityIsOpen(arg_3_0.activityID_) then
			ShowTips("TIME_OVER")

			return
		end

		MoonCakeData:SetSelectDelegateDispatchBtn(arg_3_0.activityID_)
		MoonCakeAction.UpdateDelegateDispatchPoint(arg_3_0.activityID_)
		JumpTools.OpenPageByJump("moonCakeDispatchDelegate", {
			activityID = arg_3_0.activityID_
		})
	end)
	arg_3_0:AddBtnListener(arg_3_0.addFriendBtn_, nil, function()
		if not ActivityData:GetActivityIsOpen(arg_3_0.activityID_) then
			ShowTips("TIME_OVER")

			return
		end

		local var_5_0 = arg_3_0.delegateData_.submiter_uid

		if FriendsData:IsCanBeFriend(var_5_0) then
			FriendsAction:TryToRequestToFriend(var_5_0, FriendConst.ADD_FRIEND_SOURCE.MOON_CAKE_DELEGATE)
		end
	end)
	arg_3_0:AddBtnListener(arg_3_0.receiveBtn_, nil, function()
		if not ActivityData:GetActivityIsOpen(arg_3_0.activityID_) then
			ShowTips("TIME_OVER")

			return
		end

		local var_6_0 = arg_3_0.delegateData_.delegateID

		MoonCakeAction.ReceiveDelegateReward(arg_3_0.activityID_, var_6_0)
	end)
	arg_3_0:AddBtnListener(arg_3_0.cancelBtn_, nil, function()
		if not ActivityData:GetActivityIsOpen(arg_3_0.activityID_) then
			ShowTips("TIME_OVER")

			return
		end

		local var_7_0 = arg_3_0.activityID_
		local var_7_1 = arg_3_0.delegateData_.delegateID

		ShowMessageBox({
			title = GetTips("PROMPT"),
			content = GetTips("MID_AUTUMN_FESTIVAL_TASK_CANCEL_CONFIRM"),
			OkCallback = function()
				local var_8_0 = MoonCakeData:GetOwnDelegateData(var_7_0, var_7_1)

				if var_8_0.isCompleted == true or var_8_0.isReceived == true then
					ShowTips("MID_AUTUMN_FESTIVAL_TASK_CANCEL_FAIL")

					return
				end

				MoonCakeAction.CancelDelegate(var_7_0, var_7_1)
			end
		})
	end)
	arg_3_0:AddBtnListener(arg_3_0.headBtn_, nil, function()
		if not ActivityData:GetActivityIsOpen(arg_3_0.activityID_) then
			ShowTips("TIME_OVER")

			return
		end

		ForeignInfoAction:TryToCheckForeignDetailInfo(arg_3_0.delegateData_.submiter_uid)
	end)
end

function var_0_0.Show(arg_10_0, arg_10_1)
	SetActive(arg_10_0.gameObject_, arg_10_1)
end

function var_0_0.SetData(arg_11_0, arg_11_1)
	arg_11_0.activityID_ = arg_11_1

	arg_11_0:RefreshUI()
end

function var_0_0.RefreshUI(arg_12_0)
	arg_12_0.delegateData_ = MoonCakeData:GetOwnRunningDelegate(arg_12_0.activityID_)

	arg_12_0:RefreshStatus()
	arg_12_0:RefreshTodayProgress()
	arg_12_0:RefreshDelegate()
	arg_12_0:RefreshGiver()
	arg_12_0:RefreshFriend()
end

function var_0_0.RefreshStatus(arg_13_0)
	if arg_13_0.delegateData_.delegateID == nil then
		arg_13_0.statusController_:SetSelectedState("none")
	elseif arg_13_0.delegateData_.isCompleted ~= true then
		arg_13_0.statusController_:SetSelectedState("running")
	elseif arg_13_0.delegateData_.isReceived == false then
		arg_13_0.statusController_:SetSelectedState("completed")
	end
end

function var_0_0.RefreshTodayProgress(arg_14_0)
	local var_14_0 = GameSetting.activity_mid_autumn_entrust_release_limit.value[1]
	local var_14_1 = MoonCakeData:GetTodayDisptachTimes(arg_14_0.activityID_)

	var_14_1 = var_14_1 <= var_14_0 and var_14_1 or var_14_0
	arg_14_0.progressText_.text = string.format("%s/%s", var_14_0 - var_14_1, var_14_0)
	arg_14_0.dispatchBtn_.interactable = var_14_1 < var_14_0
end

function var_0_0.RefreshGiver(arg_15_0)
	if not arg_15_0.delegateData_.isCompleted then
		return
	end

	local var_15_0 = arg_15_0.delegateData_.submiter_uid

	arg_15_0.userName_.text = arg_15_0.delegateData_.nick

	arg_15_0.commonPortrait_:RenderHead(arg_15_0.delegateData_.portrait)
	arg_15_0.commonPortrait_:RenderFrame(arg_15_0.delegateData_.frame)
end

function var_0_0.RefreshFriend(arg_16_0)
	if not arg_16_0.delegateData_.isCompleted then
		return
	end

	local var_16_0 = arg_16_0.delegateData_.submiter_uid

	if FriendsData:IsFriend(var_16_0) == true then
		arg_16_0.friendController_:SetSelectedState("myFriend")
	elseif FriendsData:IsInRequest(var_16_0) == true then
		arg_16_0.friendController_:SetSelectedState("requested")
	else
		arg_16_0.friendController_:SetSelectedState("add")
	end
end

function var_0_0.RefreshDelegate(arg_17_0)
	if arg_17_0.delegateData_.delegateID == nil then
		return
	end

	local var_17_0 = arg_17_0.delegateData_.targetID
	local var_17_1 = MoonCakeCfg[var_17_0].moon_cakes

	arg_17_0.moonCakeName_.text = ItemTools.getItemName(var_17_1) .. "X1"
	arg_17_0.moonCakeIcon_.sprite = ItemTools.getItemSprite(var_17_1)
end

function var_0_0.PageRegisterEvent(arg_18_0)
	arg_18_0:RegistEventListener(MOON_DELEGATE_CALCEL, handler(arg_18_0, arg_18_0.OnCancelDelegate))
	arg_18_0:RegistEventListener(MOON_DELEGATE_REWARD_RECEIVE, handler(arg_18_0, arg_18_0.OnReceiveDelegateReward))
	arg_18_0:RegistEventListener(MOON_DELEGATE_UPDATE, handler(arg_18_0, arg_18_0.OnDelegateUpdate))

	local var_18_0 = string.format("%s_%s", RedPointConst.MOON_DELEGATE_DISPATCH, arg_18_0.activityID_)

	manager.redPoint:bindUIandKey(arg_18_0.dispatchBtn_.transform, var_18_0)
end

function var_0_0.PageRemoveEvent(arg_19_0)
	arg_19_0:RemoveAllEventListener()

	local var_19_0 = string.format("%s_%s", RedPointConst.MOON_DELEGATE_DISPATCH, arg_19_0.activityID_)

	manager.redPoint:unbindUIandKey(arg_19_0.dispatchBtn_.transform, var_19_0)
end

function var_0_0.OnCancelDelegate(arg_20_0)
	arg_20_0.delegateData_ = MoonCakeData:GetOwnRunningDelegate(arg_20_0.activityID_)

	arg_20_0:RefreshStatus()
end

function var_0_0.OnReceiveDelegateReward(arg_21_0)
	arg_21_0.delegateData_ = MoonCakeData:GetOwnRunningDelegate(arg_21_0.activityID_)

	arg_21_0:RefreshStatus()
	arg_21_0:RefreshTodayProgress()
end

function var_0_0.OnDelegateUpdate(arg_22_0)
	arg_22_0:RefreshUI()
end

function var_0_0.OnFriendsListChange(arg_23_0)
	arg_23_0.delegateData_ = MoonCakeData:GetOwnRunningDelegate(arg_23_0.activityID_)

	arg_23_0:RefreshFriend()
end

function var_0_0.Dispose(arg_24_0)
	arg_24_0.commonPortrait_:Dispose()
	var_0_0.super.Dispose(arg_24_0)
end

return var_0_0
