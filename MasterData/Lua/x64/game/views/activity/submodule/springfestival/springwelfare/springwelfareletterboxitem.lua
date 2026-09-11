local SpringWelfareLetterBoxItem = class("SpringWelfareLetterBoxItem", ReduxView)

function SpringWelfareLetterBoxItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:InitUI()
	self:AddUIListener()
end

function SpringWelfareLetterBoxItem:InitUI()
	self:BindCfgUI()

	self.friendController_ = ControllerUtil.GetController(self.transform_, "newFriend")
end

function SpringWelfareLetterBoxItem:AddUIListener()
	self:AddBtnListener(self.viewBtn_, nil, function()
		self:OnClickViewButton()
	end)
	self:AddBtnListener(self.friendBtn_, nil, function()
		self:OnClickFriendButton()
	end)
end

function SpringWelfareLetterBoxItem:SetLetterServerId(arg_6_1)
	self.serverId_ = arg_6_1
end

function SpringWelfareLetterBoxItem:RefreshUI()
	local var_7_0 = SpringWelfareData:GetLetterData(self.serverId_)

	if var_7_0.isSystem then
		self:RefreshSystemUI(var_7_0)
	elseif var_7_0.isPlayer then
		self:RefreshPlayerUI(var_7_0)
	end
end

function SpringWelfareLetterBoxItem:RefreshSystemUI(arg_8_1)
	if HeroData:GetHeroData(arg_8_1.heroId) == nil then
		print(string.format("英雄id: %d 不存在!", arg_8_1.heroId))
	end

	self.heroImg_.sprite = HeroTools.GetHeadSprite(arg_8_1.heroId)
	self.nameText_.text = HeroTools.GetHeroFullName(arg_8_1.heroId)

	SetActive(self.friendGo_, false)
end

function SpringWelfareLetterBoxItem:RefreshPlayerUI(arg_9_1)
	local var_9_0 = SpringWelfareData:GetPlayerInfo(arg_9_1.playerId)

	self.userId_ = arg_9_1.playerId
	self.nameText_.text = var_9_0.nick
	self.heroImg_.sprite = ItemTools.getItemSprite(var_9_0.icon)

	SetActive(self.friendGo_, true)
	self.friendController_:SetSelectedState(SpringWelfareData:IsFriendOrInRequest(arg_9_1.playerId) and "send" or "add")
end

function SpringWelfareLetterBoxItem:OnClickViewButton()
	local var_10_0 = SpringWelfareData:GetActivityId()
	local var_10_1 = SpringWelfareData:GetLetterData(self.serverId_)

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

function SpringWelfareLetterBoxItem:OnFriendsListChange()
	if not self.userId_ then
		return
	end

	self.friendController_:SetSelectedState(SpringWelfareData:IsFriendOrInRequest(self.userId_) and "send" or "add")
end

function SpringWelfareLetterBoxItem:Dispose()
	SpringWelfareLetterBoxItem.super.Dispose(self)
end

function SpringWelfareLetterBoxItem:OnClickFriendButton()
	local var_13_0 = SpringWelfareData:GetLetterData(self.serverId_).playerId

	if FriendsData:IsCanBeFriend(var_13_0) then
		FriendsAction:TryToRequestToFriend(var_13_0, FriendConst.ADD_FRIEND_SOURCE.ACTIVITY_COMMON, SpringWelfareData:GetActivityId())
	end
end

return SpringWelfareLetterBoxItem
