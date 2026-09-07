local IslandFriendWhiteListPage = class("IslandFriendWhiteListPage", import(".IslandFriendListPage"))

function IslandFriendWhiteListPage:getUIName()
	return "IslandFriendListUI4WhitList"
end

function IslandFriendWhiteListPage:OnLoaded()
	IslandFriendWhiteListPage.super.OnLoaded(self)

	self.titleTxt = self._tf:Find("tip/Text"):GetComponent(typeof(Text))

	self:InitTitle()

	return
end

function IslandFriendWhiteListPage:InitTitle()
	self.titleTxt.text = i18n("island_white_list_tip")

	return
end

function IslandFriendWhiteListPage:GetData(arg_4_1)
	local var_4_0 = getProxy(IslandProxy):GetIsland():GetAccessAgency():GetWhiteList()

	if #var_4_0 <= 0 then
		arg_4_1(var_4_0)

		return
	end

	self:emit(IslandMediator.BATCH_GET_FRIEND, var_4_0, arg_4_1)

	return
end

function IslandFriendWhiteListPage:OnInitItem(arg_5_1)
	local var_5_0 = IslandBlackWhitListCard.New(arg_5_1)

	onButton(self, var_5_0.removeBtn, function()
		self:emit(IslandMediator.REMOVE_WHITE_LIST, var_5_0.player.id)

		return
	end, SFX_PANEL)

	self.cards[arg_5_1] = var_5_0

	return
end

return IslandFriendWhiteListPage
