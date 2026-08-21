local var_0_0 = class("SpringWelfareLetterBoxItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:InitUI()
	arg_1_0:AddUIListener()
end

function var_0_0.InitUI(arg_2_0)
	arg_2_0:BindCfgUI()

	arg_2_0.friendController_ = ControllerUtil.GetController(arg_2_0.transform_, "newFriend")
end

function var_0_0.AddUIListener(arg_3_0)
	arg_3_0:AddBtnListener(arg_3_0.viewBtn_, nil, function()
		arg_3_0:OnClickViewButton()
	end)
	arg_3_0:AddBtnListener(arg_3_0.friendBtn_, nil, function()
		arg_3_0:OnClickFriendButton()
	end)
end

function var_0_0.SetLetterServerId(arg_6_0, arg_6_1)
	arg_6_0.serverId_ = arg_6_1
end

function var_0_0.RefreshUI(arg_7_0)
	local var_7_0 = SpringWelfareData:GetLetterData(arg_7_0.serverId_)

	if var_7_0.isSystem then
		arg_7_0:RefreshSystemUI(var_7_0)
	elseif var_7_0.isPlayer then
		arg_7_0:RefreshPlayerUI(var_7_0)
	end
end

function var_0_0.RefreshSystemUI(arg_8_0, arg_8_1)
	local var_8_0 = arg_8_1.heroId

	if HeroData:GetHeroData(var_8_0) == nil then
		print(string.format("英雄id: %d 不存在!", var_8_0))
	end

	local var_8_1 = HeroTools.GetHeadSprite(var_8_0)

	arg_8_0.heroImg_.sprite = var_8_1
	arg_8_0.nameText_.text = HeroTools.GetHeroFullName(var_8_0)

	SetActive(arg_8_0.friendGo_, false)
end

function var_0_0.RefreshPlayerUI(arg_9_0, arg_9_1)
	local var_9_0 = arg_9_1.playerId
	local var_9_1 = SpringWelfareData:GetPlayerInfo(var_9_0)

	arg_9_0.userId_ = var_9_0
	arg_9_0.nameText_.text = var_9_1.nick
	arg_9_0.heroImg_.sprite = ItemTools.getItemSprite(var_9_1.icon)

	SetActive(arg_9_0.friendGo_, true)

	local var_9_2 = SpringWelfareData:IsFriendOrInRequest(var_9_0)

	arg_9_0.friendController_:SetSelectedState(var_9_2 and "send" or "add")
end

function var_0_0.OnClickViewButton(arg_10_0)
	local var_10_0 = SpringWelfareData:GetActivityId()
	local var_10_1 = SpringWelfareData:GetLetterData(arg_10_0.serverId_)

	if var_10_1.isSystem then
		JumpTools.OpenPageByJump("springWelfareSystemLetter", {
			firstView = false,
			letterServerId = var_10_1.serverId
		})
		SDKTools.SendMessageToSDK("activity_letter", {
			opt = 3,
			publish_player_uid = 0,
			mail_id = var_10_1.letterId,
			activity_id = var_10_0
		})
	elseif var_10_1.isPlayer then
		local var_10_2 = SpringWelfareData:GetPlayerInfo(var_10_1.playerId)

		JumpTools.OpenPageByJump("springWelfarePlayerLetter", {
			firstView = false,
			letterServerId = var_10_1.serverId
		})
		SDKTools.SendMessageToSDK("activity_letter", {
			opt = 3,
			mail_id = var_10_1.timestamp,
			activity_id = var_10_0,
			publish_player_uid = var_10_1.playerId
		})
	end
end

function var_0_0.OnFriendsListChange(arg_11_0)
	if not arg_11_0.userId_ then
		return
	end

	local var_11_0 = SpringWelfareData:IsFriendOrInRequest(arg_11_0.userId_)

	arg_11_0.friendController_:SetSelectedState(var_11_0 and "send" or "add")
end

function var_0_0.Dispose(arg_12_0)
	var_0_0.super.Dispose(arg_12_0)
end

function var_0_0.OnClickFriendButton(arg_13_0)
	local var_13_0 = SpringWelfareData:GetLetterData(arg_13_0.serverId_).playerId

	if FriendsData:IsCanBeFriend(var_13_0) then
		FriendsAction:TryToRequestToFriend(var_13_0, FriendConst.ADD_FRIEND_SOURCE.ACTIVITY_COMMON, SpringWelfareData:GetActivityId())
	end
end

return var_0_0
