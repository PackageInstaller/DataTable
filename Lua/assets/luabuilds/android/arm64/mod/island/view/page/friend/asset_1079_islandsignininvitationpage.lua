local IslandSignInInvitationPage = class("IslandSignInInvitationPage", import("...base.IslandBasePage"))
local var_0_1 = 1
local var_0_2 = 2

function IslandSignInInvitationPage:getUIName()
	return "IslandSignInInvitationUI"
end

function IslandSignInInvitationPage:OnLoaded()
	self.shareBtn = self._tf:Find("frame/public")
	self.onkeyBtn = self._tf:Find("frame/onkey")
	self.closeBtn = self._tf:Find("frame/close")
	self.toggles = {
		[var_0_1] = self._tf:Find("frame/toggles/1"),
		[var_0_2] = self._tf:Find("frame/toggles/2")
	}

	local var_2_0 = {}

	var_2_0[var_0_1] = self._tf:Find("frame/toggles/1/Text"):GetComponent(typeof(Text))
	var_2_0[var_0_2] = self._tf:Find("frame/toggles/2/Text"):GetComponent(typeof(Text))
	self.texts = var_2_0
	self.names = {
		i18n("island_friend"),
		i18n("island_guild")
	}
	self._scrollrect = self._tf:Find("frame/scrollrect"):GetComponent("LScrollRect")

	function self._scrollrect.onInitItem(arg_3_0)
		self:OnInitItem(arg_3_0)

		return
	end

	function self._scrollrect.onUpdateItem(arg_4_0, arg_4_1)
		self:OnUpdateItem(arg_4_0, arg_4_1)

		return
	end

	setText(self._tf:Find("frame/public/Text"), i18n("island_public_invitation"))
	setText(self._tf:Find("frame/onkey/Text"), i18n("island_onekey_invitation"))

	return
end

function IslandSignInInvitationPage:OnInit()
	onButton(self, self._tf, function()
		self:Hide()

		return
	end, SFX_PANEL)
	onButton(self, self.closeBtn, function()
		self:Hide()

		return
	end, SFX_PANEL)
	onButton(self, self.shareBtn, function()
		self:DoShare()

		return
	end, SFX_PANEL)
	onButton(self, self.onkeyBtn, function()
		self:OnOneKey()

		return
	end, SFX_PANEL)

	self.cards = {}

	for iter_5_0, iter_5_1 in pairs(self.toggles) do
		local var_5_0 = self.texts[iter_5_0]
		local var_5_1 = self.names[iter_5_0]

		onToggle(self, iter_5_1, function(arg_10_0)
			if arg_10_0 then
				self:SwitchPage(iter_5_0)
			end

			var_5_0.text = arg_10_0 and setColorStr(var_5_1, "#FEFEFE") or setColorStr(var_5_1, "#6B6E75")

			return
		end, SFX_PANEL)

		self.texts[iter_5_0].text = setColorStr(self.names[iter_5_0], "#6B6E75")
	end

	return
end

function IslandSignInInvitationPage:DoShare()
	if self:GetIsland():GetAccessAgency():HasOpenFlag(IslandConst.OPEN_SIGNIN) then
		pg.TipsMgr.GetInstance():ShowTips(i18n("island_public_invitation_1"))

		return
	end

	self:emit(IslandMediator.SHARE_SIGNIN)

	return
end

function IslandSignInInvitationPage:OnOneKey()
	local var_12_0 = {}

	for iter_12_0, iter_12_1 in ipairs(self.displays) do
		table.insert(var_12_0, iter_12_1.id)
	end

	self:emit(IslandMediator.SIGN_IN_INVITATION, var_12_0)

	return
end

function IslandSignInInvitationPage:AddListeners()
	self:AddListener(GAME.ISLAND_SIGN_IN_INVITATION_DONE, self.OnInvitation)
	self:AddListener(GAME.ISLAND_SIGN_SHARE_SIGNIN_DONE, self.OnShare)

	return
end

function IslandSignInInvitationPage:RemoveListeners()
	self:RemoveListener(GAME.ISLAND_SIGN_IN_INVITATION_DONE, self.OnInvitation)
	self:RemoveListener(GAME.ISLAND_SIGN_SHARE_SIGNIN_DONE, self.OnShare)

	return
end

function IslandSignInInvitationPage:OnInvitation()
	self:FlushList()

	return
end

function IslandSignInInvitationPage:OnShare()
	return
end

function IslandSignInInvitationPage:GetDisplayData(arg_17_1)
	local var_17_0 = {}

	if arg_17_1 == var_0_1 then
		var_17_0 = getProxy(FriendProxy):getAllFriends()
	elseif arg_17_1 == var_0_2 then
		local var_17_1 = getProxy(GuildProxy):getRawData()

		var_17_0 = var_17_1 and var_17_1:getSortMemberWithoutSelf() or {}
	end

	return var_17_0
end

function IslandSignInInvitationPage:SwitchPage(arg_18_1)
	self.pageIndex = arg_18_1

	self:FlushList()

	return
end

function IslandSignInInvitationPage:OnInitItem(arg_19_1)
	local var_19_0 = IslandSignInInvitationCard.New(arg_19_1)

	onButton(self, var_19_0.btn, function()
		self:DoInvitation(var_19_0)

		return
	end, SFX_PANEL)

	self.cards[arg_19_1] = var_19_0

	return
end

function IslandSignInInvitationPage:DoInvitation(arg_21_1)
	self:emit(IslandMediator.SIGN_IN_INVITATION, {
		arg_21_1.player.id
	})

	return
end

function IslandSignInInvitationPage:OnUpdateItem(arg_22_1, arg_22_2)
	local var_22_0 = self.cards[arg_22_2]

	if not self.cards[arg_22_2] then
		self:OnInitItem(arg_22_2)

		var_22_0 = self.cards[arg_22_2]
	end

	var_22_0:Update(self.displays[arg_22_1 + 1], (self:GetIsland():GetSignInAgency():IsInvited(self.displays[arg_22_1 + 1].id)))

	return
end

function IslandSignInInvitationPage:Show()
	IslandSignInInvitationPage.super.Show(self)
	triggerToggle(self.toggles[var_0_1], true)

	return
end

function IslandSignInInvitationPage:FlushList()
	self.displays = self:GetDisplayData(self.pageIndex)

	self._scrollrect:SetTotalCount(#self.displays)

	return
end

function IslandSignInInvitationPage:OnDestroy()
	ClearLScrollrect(self._scrollrect)

	for iter_25_0, iter_25_1 in pairs(self.cards) do
		iter_25_1:Dispose()
	end

	self.cards = nil

	return
end

return IslandSignInInvitationPage
