local IslandFriendBlackListPage = class("IslandFriendBlackListPage", import(".IslandFriendWhiteListPage"))

function IslandFriendBlackListPage:getUIName()
	return "IslandFriendListUI4BlackList"
end

function IslandFriendBlackListPage:InitTitle()
	self.titleTxt.text = i18n("island_black_list_tip")

	return
end

function IslandFriendBlackListPage:GetData(arg_3_1)
	local var_3_0 = getProxy(IslandProxy):GetIsland():GetAccessAgency():GetBlackList()

	if #var_3_0 <= 0 then
		arg_3_1(var_3_0)

		return
	end

	self:emit(IslandMediator.BATCH_GET_FRIEND, var_3_0, arg_3_1)

	return
end

function IslandFriendBlackListPage:OnInitItem(arg_4_1)
	local var_4_0 = IslandBlackWhitListCard.New(arg_4_1)

	onButton(self, var_4_0.removeBtn, function()
		self:emit(IslandMediator.REMOVE_BLACK_LIST, var_4_0.player.id)

		return
	end, SFX_PANEL)

	self.cards[arg_4_1] = var_4_0

	return
end

return IslandFriendBlackListPage
