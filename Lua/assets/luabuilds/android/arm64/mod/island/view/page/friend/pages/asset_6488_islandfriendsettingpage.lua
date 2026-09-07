local IslandFriendSettingPage = class("IslandFriendSettingPage", import("view.base.BaseSubView"))

function IslandFriendSettingPage:getUIName()
	return "IslandFriendAccessUI"
end

function IslandFriendSettingPage:OnLoaded()
	self.toggle = self._tf:Find("frame/toggle")
	self.friendToggle = self._tf:Find("frame/on_panel/friend")
	self.guildToggle = self._tf:Find("frame/on_panel/guild")
	self.codeToggle = self._tf:Find("frame/on_panel/code")
	self.codeTxt = self._tf:Find("frame/code_panel/id/Text"):GetComponent(typeof(Text))
	self.codeMask = self._tf:Find("frame/code_panel/mask")
	self.codeRefreshBtn = self._tf:Find("frame/code_panel/refresh")
	self.codeRefreshTxt = self._tf:Find("frame/code_panel/refresh/Text"):GetComponent(typeof(Text))
	self.codeCopyBtn = self._tf:Find("frame/code_panel/copy")
	self.tipBtn = self._tf:Find("frame/tip")

	setText(self._tf:Find("frame/title/Text"), i18n("island_open_settings"))
	setText(self._tf:Find("frame/on_panel/friend/Text"), i18n("island_friend"))
	setText(self._tf:Find("frame/on_panel/guild/Text"), i18n("island_guild"))
	setText(self._tf:Find("frame/on_panel/code/Text"), i18n("island_code"))
	setText(self._tf:Find("frame/on_tip/Text"), i18n("island_open_settings_tip1"))
	setText(self._tf:Find("frame/off_tip/Text"), i18n("island_open_settings_tip2"))
	setText(self._tf:Find("frame/code_panel/copy/Text"), i18n("island_btn_label_copy"))
	setText(self._tf:Find("frame/toggle/on/Text"), i18n("island_visit_on"))
	setText(self._tf:Find("frame/toggle/off/Text_1"), i18n("island_visit_on"))
	setText(self._tf:Find("frame/toggle/on/Text_2"), i18n("island_visit_off"))
	setText(self._tf:Find("frame/toggle/off/Text"), i18n("island_visit_off"))

	return
end

function IslandFriendSettingPage:OnInit()
	onButton(self, self.codeRefreshBtn, function()
		self:emit(IslandMediator.REFRESH_INVITECODE, false)

		return
	end, SFX_PANEL)
	onButton(self, self.tipBtn, function()
		self:emit(IslandFriendPage.EVENT_MSG, i18n("island_open_settings_tip3"))

		return
	end, SFX_PANEL)
	onButton(self, self.codeCopyBtn, function()
		UniPasteBoard.SetClipBoardString(self.inviteCode)
		pg.TipsMgr.GetInstance():ShowTips(i18n("friend_id_copy_ok"))

		return
	end, SFX_PANEL)

	return
end

function IslandFriendSettingPage:OnRefreshInviteCode()
	self.inviteCode = getProxy(IslandProxy):GetIsland():GetAccessAgency():GetInviteCode()

	self:InitInviteCode(true)
	self:UpdateRefreshBtn()

	return
end

function IslandFriendSettingPage:Show()
	IslandFriendSettingPage.super.Show(self)

	local var_8_0 = getProxy(IslandProxy):GetIsland():GetAccessAgency()

	self.openFlags = var_8_0:GetOpenFlag()
	self.inviteCode = var_8_0:GetInviteCode()

	self:InitToggles()

	return
end

function IslandFriendSettingPage:InitInviteCode(arg_9_1)
	self.codeTxt.text = arg_9_1 and self.inviteCode or ""

	return
end

function IslandFriendSettingPage:InitToggles()
	triggerToggle(self.toggle, table.contains(self.openFlags, IslandConst.OPEN_ALL))
	triggerToggle(self.friendToggle, not table.contains(self.openFlags, IslandConst.OPEN_FRIEND))
	triggerToggle(self.guildToggle, not table.contains(self.openFlags, IslandConst.OPEN_GUILD))
	triggerToggle(self.codeToggle, table.contains(self.openFlags, IslandConst.OPEN_CODE))
	self:InitCodePanenl(table.contains(self.openFlags, IslandConst.OPEN_CODE))
	onToggle(self, self.toggle, function(arg_11_0)
		if arg_11_0 then
			table.insert(self.openFlags, IslandConst.OPEN_ALL)
			self:Send()
		else
			table.removebyvalue(self.openFlags, IslandConst.OPEN_ALL)
			self:Send()
		end

		return
	end)
	onToggle(self, self.friendToggle, function(arg_12_0)
		if arg_12_0 then
			table.removebyvalue(self.openFlags, IslandConst.OPEN_FRIEND)
		else
			table.insert(self.openFlags, IslandConst.OPEN_FRIEND)
		end

		self:Send()

		return
	end, SFX_PANEL)
	onToggle(self, self.guildToggle, function(arg_13_0)
		if arg_13_0 then
			table.removebyvalue(self.openFlags, IslandConst.OPEN_GUILD)
		else
			table.insert(self.openFlags, IslandConst.OPEN_GUILD)
		end

		self:Send()

		return
	end, SFX_PANEL)
	onToggle(self, self.codeToggle, function(arg_14_0)
		if arg_14_0 then
			table.insert(self.openFlags, IslandConst.OPEN_CODE)

			if not self.inviteCode or self.inviteCode == "" then
				self:emit(IslandMediator.REFRESH_INVITECODE, true)
			end
		else
			table.removebyvalue(self.openFlags, IslandConst.OPEN_CODE)
		end

		self:InitCodePanenl(arg_14_0)
		self:Send()

		return
	end, SFX_PANEL)
	self:UpdateRefreshBtn()

	return
end

function IslandFriendSettingPage:UpdateRefreshBtn()
	self.codeRefreshTxt.text = i18n("island_code_refresh_cnt", getProxy(IslandProxy):GetIsland():GetAccessAgency():isFreshInviteCode() and "0" or "1")

	return
end

function IslandFriendSettingPage:InitCodePanenl(arg_16_1)
	setActive(self.codeMask, not arg_16_1)
	self:InitInviteCode(arg_16_1)

	return
end

function IslandFriendSettingPage:Send()
	local var_17_0 = {}
	local var_17_1 = {}
	local var_17_2 = getProxy(IslandProxy):GetIsland():GetAccessAgency():GetOpenFlag()

	for iter_17_0, iter_17_1 in ipairs(self.openFlags) do
		if not table.contains(var_17_2, iter_17_1) then
			table.insert(var_17_0, iter_17_1)
		end
	end

	for iter_17_2, iter_17_3 in ipairs(var_17_2) do
		if not table.contains(self.openFlags, iter_17_3) then
			table.insert(var_17_1, iter_17_3)
		end
	end

	if #var_17_0 > 0 or #var_17_1 > 0 then
		self:emit(IslandMediator.SET_ACCESS_FLAG, var_17_0, var_17_1)
	end

	return
end

function IslandFriendSettingPage:Hide()
	IslandFriendSettingPage.super.Hide(self)
	removeOnToggle(self.toggle)
	removeOnToggle(self.friendToggle)
	removeOnToggle(self.guildToggle)
	removeOnToggle(self.codeToggle)

	return
end

function IslandFriendSettingPage:OnDestroy()
	if self:isShowing() then
		self:Hide()
	end

	return
end

return IslandFriendSettingPage
