local PlayRoomInfoInviteScene = class("PlayRoomInfoInviteScene", import("view.base.BaseUI"))

PlayRoomInfoInviteScene.PAGE = {
	GUILD = 2,
	FRIEND = 1
}

function PlayRoomInfoInviteScene:getUIName()
	return "IslandPlayRoomInfoInviteUI"
end

function PlayRoomInfoInviteScene:init()
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
	setText(self.uiFriendText, i18n("island_friend"))
	setText(self.uiGuildText, i18n("island_guild"))
	onToggle(self, self.uiFriendToggle, function(arg_5_0)
		if arg_5_0 then
			self.selectedPage = PlayRoomInfoInviteScene.PAGE.FRIEND

			self:RefreshUI()
		end

		self.uiFriendText.color = arg_5_0 and Color.NewHex("FEFEFE") or Color.NewHex("6B6E75")

		return
	end, SFX_PANEL)
	onToggle(self, self.uiGuildToggle, function(arg_6_0)
		if arg_6_0 then
			self.selectedPage = PlayRoomInfoInviteScene.PAGE.GUILD

			self:RefreshUI()
		end

		self.uiGuildText.color = arg_6_0 and Color.NewHex("FEFEFE") or Color.NewHex("6B6E75")

		return
	end, SFX_PANEL)

	self.uiFriendText.color = Color.NewHex("FEFEFE")
	self.uiGuildText.color = Color.NewHex("6B6E75")
	self.uiScrollView = LuaList.New(self, handler(self, self.IndexItem), self.uiList, PlayRoomInfoInviteItem)

	return
end

function PlayRoomInfoInviteScene:didEnter()
	self.selectedPage = PlayRoomInfoInviteScene.PAGE.FRIEND

	triggerToggle(self.uiFriendToggle, true)

	return
end

function PlayRoomInfoInviteScene:willExit()
	self:UnOverlayPanel(self._tf)
	self.uiScrollView:Dispose()

	self.uiScrollView = nil

	return
end

function PlayRoomInfoInviteScene:RefreshUI()
	self.displayData = self:GetDisplayData()

	self.uiScrollView:StartScroll(#self.displayData)
	setActive(self.uiEmptyGo, #self.displayData <= 0)

	return
end

function PlayRoomInfoInviteScene:IndexItem(arg_10_1, arg_10_2)
	arg_10_2:didEnter(self.displayData[arg_10_1])

	return
end

function PlayRoomInfoInviteScene:RefreshItem()
	self.uiScrollView:Refresh()

	return
end

function PlayRoomInfoInviteScene:GetDisplayData()
	local var_12_0 = {}

	if self.selectedPage == PlayRoomInfoInviteScene.PAGE.FRIEND then
		var_12_0 = getProxy(FriendProxy):getAllFriends()
	elseif self.selectedPage == PlayRoomInfoInviteScene.PAGE.GUILD then
		local var_12_1 = getProxy(GuildProxy):getRawData()

		var_12_0 = var_12_1 and var_12_1:getSortMemberWithoutSelf() or {}
	end

	table.sort(var_12_0, function(arg_13_0, arg_13_1)
		local var_13_0 = arg_13_0:isOnline()

		if var_13_0 ~= arg_13_1:isOnline() then
			return var_13_0 == true
		end

		return arg_13_0.preOnLineTime >= arg_13_1.preOnLineTime
	end)

	return var_12_0
end

return PlayRoomInfoInviteScene
