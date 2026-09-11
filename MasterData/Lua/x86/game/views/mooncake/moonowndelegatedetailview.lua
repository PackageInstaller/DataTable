local MoonOwnDelegateDetailView = class("MoonOwnDelegateDetailView", ReduxView)

function MoonOwnDelegateDetailView:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = self.gameObject_.transform

	self:InitUI()
	self:AddUIListener()
end

function MoonOwnDelegateDetailView:InitUI()
	self:BindCfgUI()

	self.statusController_ = ControllerUtil.GetController(self.transform_, "status")
	self.friendController_ = ControllerUtil.GetController(self.transform_, "friend")
	self.commonPortrait_ = CommonHeadPortrait.New(self.headItem_)
end

function MoonOwnDelegateDetailView:AddUIListener()
	self:AddBtnListener(self.dispatchBtn_, nil, function()
		if not ActivityData:GetActivityIsOpen(self.activityID_) then
			ShowTips("TIME_OVER")

			return
		end

		MoonCakeData:SetSelectDelegateDispatchBtn(self.activityID_)
		MoonCakeAction.UpdateDelegateDispatchPoint(self.activityID_)
		JumpTools.OpenPageByJump("moonCakeDispatchDelegate", {
			activityID = self.activityID_
		})
	end)
	self:AddBtnListener(self.addFriendBtn_, nil, function()
		if not ActivityData:GetActivityIsOpen(self.activityID_) then
			ShowTips("TIME_OVER")

			return
		end

		if FriendsData:IsCanBeFriend(self.delegateData_.submiter_uid) then
			FriendsAction:TryToRequestToFriend(self.delegateData_.submiter_uid, FriendConst.ADD_FRIEND_SOURCE.MOON_CAKE_DELEGATE)
		end
	end)
	self:AddBtnListener(self.receiveBtn_, nil, function()
		if not ActivityData:GetActivityIsOpen(self.activityID_) then
			ShowTips("TIME_OVER")

			return
		end

		MoonCakeAction.ReceiveDelegateReward(self.activityID_, self.delegateData_.delegateID)
	end)
	self:AddBtnListener(self.cancelBtn_, nil, function()
		if not ActivityData:GetActivityIsOpen(self.activityID_) then
			ShowTips("TIME_OVER")

			return
		end

		local var_7_0 = self.activityID_
		local var_7_1 = self.delegateData_.delegateID

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
	self:AddBtnListener(self.headBtn_, nil, function()
		if not ActivityData:GetActivityIsOpen(self.activityID_) then
			ShowTips("TIME_OVER")

			return
		end

		ForeignInfoAction:TryToCheckForeignDetailInfo(self.delegateData_.submiter_uid)
	end)
end

function MoonOwnDelegateDetailView:Show(arg_10_1)
	SetActive(self.gameObject_, arg_10_1)
end

function MoonOwnDelegateDetailView:SetData(arg_11_1)
	self.activityID_ = arg_11_1

	self:RefreshUI()
end

function MoonOwnDelegateDetailView:RefreshUI()
	self.delegateData_ = MoonCakeData:GetOwnRunningDelegate(self.activityID_)

	self:RefreshStatus()
	self:RefreshTodayProgress()
	self:RefreshDelegate()
	self:RefreshGiver()
	self:RefreshFriend()
end

function MoonOwnDelegateDetailView:RefreshStatus()
	if self.delegateData_.delegateID == nil then
		self.statusController_:SetSelectedState("none")
	elseif self.delegateData_.isCompleted ~= true then
		self.statusController_:SetSelectedState("running")
	elseif self.delegateData_.isReceived == false then
		self.statusController_:SetSelectedState("completed")
	end
end

function MoonOwnDelegateDetailView:RefreshTodayProgress()
	local var_14_0 = GameSetting.activity_mid_autumn_entrust_release_limit.value[1]
	local var_14_1 = MoonCakeData:GetTodayDisptachTimes(self.activityID_)

	var_14_1 = var_14_1 <= GameSetting.activity_mid_autumn_entrust_release_limit.value[1] and var_14_1 or var_14_0
	self.progressText_.text = string.format("%s/%s", var_14_0 - var_14_1, var_14_0)
	self.dispatchBtn_.interactable = var_14_1 < var_14_0
end

function MoonOwnDelegateDetailView:RefreshGiver()
	if not self.delegateData_.isCompleted then
		return
	end

	self.userName_.text = self.delegateData_.nick

	self.commonPortrait_:RenderHead(self.delegateData_.portrait)
	self.commonPortrait_:RenderFrame(self.delegateData_.frame)
end

function MoonOwnDelegateDetailView:RefreshFriend()
	if not self.delegateData_.isCompleted then
		return
	end

	local var_16_0 = self.delegateData_.submiter_uid

	if FriendsData:IsFriend(self.delegateData_.submiter_uid) == true then
		self.friendController_:SetSelectedState("myFriend")
	elseif FriendsData:IsInRequest(var_16_0) == true then
		self.friendController_:SetSelectedState("requested")
	else
		self.friendController_:SetSelectedState("add")
	end
end

function MoonOwnDelegateDetailView:RefreshDelegate()
	if self.delegateData_.delegateID == nil then
		return
	end

	local var_17_0 = MoonCakeCfg[self.delegateData_.targetID].moon_cakes

	self.moonCakeName_.text = ItemTools.getItemName(MoonCakeCfg[self.delegateData_.targetID].moon_cakes) .. "X1"
	self.moonCakeIcon_.sprite = ItemTools.getItemSprite(var_17_0)
end

function MoonOwnDelegateDetailView:PageRegisterEvent()
	self:RegistEventListener(MOON_DELEGATE_CALCEL, handler(self, self.OnCancelDelegate))
	self:RegistEventListener(MOON_DELEGATE_REWARD_RECEIVE, handler(self, self.OnReceiveDelegateReward))
	self:RegistEventListener(MOON_DELEGATE_UPDATE, handler(self, self.OnDelegateUpdate))
	manager.redPoint:bindUIandKey(self.dispatchBtn_.transform, (string.format("%s_%s", RedPointConst.MOON_DELEGATE_DISPATCH, self.activityID_)))
end

function MoonOwnDelegateDetailView:PageRemoveEvent()
	self:RemoveAllEventListener()
	manager.redPoint:unbindUIandKey(self.dispatchBtn_.transform, (string.format("%s_%s", RedPointConst.MOON_DELEGATE_DISPATCH, self.activityID_)))
end

function MoonOwnDelegateDetailView:OnCancelDelegate()
	self.delegateData_ = MoonCakeData:GetOwnRunningDelegate(self.activityID_)

	self:RefreshStatus()
end

function MoonOwnDelegateDetailView:OnReceiveDelegateReward()
	self.delegateData_ = MoonCakeData:GetOwnRunningDelegate(self.activityID_)

	self:RefreshStatus()
	self:RefreshTodayProgress()
end

function MoonOwnDelegateDetailView:OnDelegateUpdate()
	self:RefreshUI()
end

function MoonOwnDelegateDetailView:OnFriendsListChange()
	self.delegateData_ = MoonCakeData:GetOwnRunningDelegate(self.activityID_)

	self:RefreshFriend()
end

function MoonOwnDelegateDetailView:Dispose()
	self.commonPortrait_:Dispose()
	MoonOwnDelegateDetailView.super.Dispose(self)
end

return MoonOwnDelegateDetailView
