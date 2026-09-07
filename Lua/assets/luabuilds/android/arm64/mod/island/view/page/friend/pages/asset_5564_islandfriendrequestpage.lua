local IslandFriendRequestPage = class("IslandFriendRequestPage", import(".IslandFriendListPage"))

function IslandFriendRequestPage:getUIName()
	return "IslandFriendRequestUI"
end

function IslandFriendRequestPage:CreateCard(arg_2_1)
	return IslandFriendRequestCard.New(arg_2_1)
end

function IslandFriendRequestPage:OnInitItem(arg_3_1)
	IslandFriendRequestPage.super.OnInitItem(self, arg_3_1)

	local var_3_0 = self.cards[arg_3_1]

	onButton(self, self.cards[arg_3_1].agreeBtn, function()
		self:emit(IslandMediator.ACCEPT_REQUEST, var_3_0.player.id)

		return
	end, SFX_PANEL)
	onButton(self, self.cards[arg_3_1].refuseBtn, function()
		self:emit(IslandMediator.REFUSE_REQUEST, var_3_0.player.id, false)

		return
	end, SFX_PANEL)

	return
end

function IslandFriendRequestPage:GetData(arg_6_1)
	local var_6_0 = getProxy(NotificationProxy):getRequests()

	if #var_6_0 <= 0 then
		return arg_6_1({})
	end

	arg_6_1(var_6_0)

	return
end

return IslandFriendRequestPage
