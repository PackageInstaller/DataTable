local PlayRoomRankScene = class("PlayRoomRankScene", import("view.base.BaseUI"))

PlayRoomRankScene.PAGE = {
	ALL = 0,
	FRIEND = 1,
	GUILD = 2
}

function PlayRoomRankScene:getUIName()
	return "IslandPlayRoomRankUI"
end

function PlayRoomRankScene:init()
	self:OverlayPanel(self._tf, {
		pbList = {
			self._tf:Find("bg")
		}
	})
	onButton(self, self.uiBgBtn, function()
		self:closeView()

		return
	end, SFX_PANEL)
	onButton(self, self.uiCloseBtn, function()
		self:closeView()

		return
	end, SFX_PANEL)
	setText(self.uiFriendText1, i18n("island_friend"))
	setText(self.uiFriendText2, i18n("island_friend"))
	setText(self.uiGuildText1, i18n("island_guild"))
	setText(self.uiGuildText2, i18n("island_guild"))
	setText(self.uiAllText1, i18n("channel_name_1"))
	setText(self.uiAllText2, i18n("channel_name_1"))
	triggerToggle(self.uiFriendToggle, true)
	onToggle(self, self.uiFriendToggle, function(arg_5_0)
		if arg_5_0 then
			self.selectedPage = PlayRoomRankScene.PAGE.FRIEND

			self:RefreshUI()
		end

		return
	end, SFX_PANEL)
	onToggle(self, self.uiGuildToggle, function(arg_6_0)
		if arg_6_0 then
			self.selectedPage = PlayRoomRankScene.PAGE.GUILD

			self:RefreshUI()
		end

		return
	end, SFX_PANEL)
	onToggle(self, self.uiAllToggle, function(arg_7_0)
		if arg_7_0 then
			self.selectedPage = PlayRoomRankScene.PAGE.ALL

			self:RefreshUI()
		end

		return
	end, SFX_PANEL)

	self.uiScrollView = LuaList.New(self, handler(self, self.IndexItem), self.uiList, PlayRoomRankItem)
	self.rankItemView = PlayRoomRankItem.New(self.uiItem, self)

	return
end

function PlayRoomRankScene:didEnter()
	self.selectedPage = PlayRoomRankScene.PAGE.FRIEND

	return
end

function PlayRoomRankScene:willExit()
	self:UnOverlayPanel(self._tf)
	self.uiScrollView:Dispose()

	self.uiScrollView = nil

	self.rankItemView:willExit()

	self.rankItemView = nil

	return
end

function PlayRoomRankScene:RefreshUI()
	self.displayData = self:GetDisplayData()

	self.uiScrollView:StartScroll(#self.displayData)
	self.rankItemView:didEnter(getProxy(PlayRoomProxy):GetSelfRankData(self.contextData.gameType))

	return
end

function PlayRoomRankScene:IndexItem(arg_11_1, arg_11_2)
	arg_11_2:didEnter(self.displayData[arg_11_1])

	return
end

function PlayRoomRankScene:GetDisplayData()
	local var_12_0 = {}
	local var_12_1 = {}
	local var_12_2 = getProxy(PlayRoomProxy):GetRankData(self.contextData.gameType)

	if self.selectedPage == PlayRoomRankScene.PAGE.FRIEND then
		var_12_1 = getProxy(FriendProxy):getAllFriends()
	elseif self.selectedPage == PlayRoomRankScene.PAGE.GUILD then
		local var_12_3 = getProxy(GuildProxy):getRawData()

		var_12_1 = var_12_3 and var_12_3:getSortMemberWithoutSelf() or {}
	else
		return var_12_2
	end

	local var_12_4 = {}

	for iter_12_0, iter_12_1 in ipairs(var_12_1) do
		table.insert(var_12_4, iter_12_1.id)
	end

	for iter_12_2, iter_12_3 in ipairs(var_12_2) do
		if table.keyof(var_12_4, iter_12_3.playerData.id) then
			table.insert(var_12_0, iter_12_3)
		end
	end

	return var_12_0
end

return PlayRoomRankScene
