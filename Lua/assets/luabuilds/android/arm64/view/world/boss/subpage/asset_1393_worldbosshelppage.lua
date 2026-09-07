local WorldBossHelpPage = class("WorldBossHelpPage", import("....base.BaseSubView"))

function WorldBossHelpPage:getUIName()
	return "WorldBossHelpUI"
end

function WorldBossHelpPage:OnLoaded()
	self.friendBtn = self._tf:Find("window/sliders/content/friend")
	self.friendRequested = self.friendBtn:Find("requested")
	self.friendMark = self.friendBtn:Find("mark")
	self.friendSupportTimeTxt = self.friendBtn:Find("requested/Text"):GetComponent(typeof(Text))
	self.guildBtn = self._tf:Find("window/sliders/content/guild")
	self.guildRequested = self.guildBtn:Find("requested")
	self.guildMark = self.guildBtn:Find("mark")
	self.guildSupportTimeTxt = self.guildBtn:Find("requested/Text"):GetComponent(typeof(Text))
	self.worldBtn = self._tf:Find("window/sliders/content/world")
	self.worldRequested = self.worldBtn:Find("requested")
	self.worldMark = self.worldBtn:Find("mark")
	self.worldSupportTimeTxt = self.worldBtn:Find("requested/Text"):GetComponent(typeof(Text))
	self.timers = {}

	return
end

function WorldBossHelpPage:OnInit()
	onButton(self, self._tf, function()
		self:Hide()

		return
	end, SFX_PANEL)
	onButton(self, self._tf:Find("cancel_btn"), function()
		self:Hide()

		return
	end, SFX_PANEL)
	onButton(self, self._tf:Find("window/top/btnBack"), function()
		self:Hide()

		return
	end, SFX_PANEL)
	onButton(self, self.friendBtn, function()
		self.friendFlag = not self.friendFlag

		setActive(self.friendMark, self.friendFlag)

		return
	end, SFX_PANEL)
	onButton(self, self.guildBtn, function()
		self.guildFlag = not self.guildFlag

		setActive(self.guildMark, self.guildFlag)

		return
	end, SFX_PANEL)
	onButton(self, self.worldBtn, function()
		if nowWorld():GetBossProxy():WorldSupported() then
			pg.TipsMgr.GetInstance():ShowTips(i18n("world_boss_ask_help"))

			return
		end

		self.worldFlag = not self.worldFlag

		setActive(self.worldMark, self.worldFlag)

		return
	end, SFX_PANEL)
	onButton(self, self._tf:Find("confirm_btn"), function()
		self:emit(WorldBossMediator.ON_SURPPORT, {
			self.friendFlag,
			self.guildFlag,
			self.worldFlag
		})
		self:Hide()

		return
	end, SFX_PANEL)

	return
end

function WorldBossHelpPage:Reset()
	self.friendFlag = false
	self.guildFlag = false
	self.worldFlag = false

	return
end

function WorldBossHelpPage:Update(arg_12_1)
	self.boss = arg_12_1

	self:Reset()
	self:UpdateFriendRequestItem()
	self:UpdateGuildRequetItem()
	self:UpdateWorldRequetItem()
	self:Show()

	return
end

function WorldBossHelpPage:UpdateFriendRequestItem()
	local var_13_1 = nowWorld():GetBossProxy()
	local var_13_2 = var_13_1:FriendSupported()

	setButtonEnabled(self.friendBtn, not var_13_2)
	setActive(self.friendRequested, var_13_2)
	setActive(self.friendMark, false)
	self:RemoveRequestTimer(self.friendSupportTimeTxt)

	if var_13_2 then
		self:AddRequestTimer(var_13_1:GetNextFriendSupportTime(), self.friendSupportTimeTxt, function()
			self:UpdateFriendRequestItem()

			return
		end)
	end

	return
end

function WorldBossHelpPage:UpdateGuildRequetItem()
	local var_15_1 = nowWorld():GetBossProxy()
	local var_15_2 = var_15_1:GuildSupported()

	setButtonEnabled(self.guildBtn, not var_15_2)
	setActive(self.guildRequested, var_15_2)
	setActive(self.guildMark, false)
	self:RemoveRequestTimer(self.guildSupportTimeTxt)

	if var_15_2 then
		self:AddRequestTimer(var_15_1:GetNextGuildSupportTime(), self.guildSupportTimeTxt, function()
			self:UpdateGuildRequetItem()

			return
		end)
	end

	return
end

function WorldBossHelpPage:UpdateWorldRequetItem()
	local var_17_0 = nowWorld():GetBossProxy()
	local var_17_1 = var_17_0:WorldSupported()

	setActive(self.worldRequested, var_17_1)
	setActive(self.worldMark, false)
	self:RemoveRequestTimer(self.worldSupportTimeTxt)

	if var_17_1 then
		self:AddRequestTimer(var_17_0:GetNextWorldSupportTime(), self.worldSupportTimeTxt, function()
			self:UpdateWorldRequetItem()

			return
		end)
	end

	return
end

function WorldBossHelpPage:AddRequestTimer(arg_19_1, arg_19_2, arg_19_3)
	local var_19_0 = nowWorld():GetBossProxy()

	self.timers[arg_19_2] = Timer.New(function()
		local var_20_0 = arg_19_1 - pg.TimeMgr.GetInstance():GetServerTime()

		if var_20_0 > 0 then
			arg_19_2.text = pg.TimeMgr.GetInstance():DescCDTime(var_20_0)
		else
			arg_19_2.text = ""

			self:RemoveRequestTimer(arg_19_2)
			arg_19_3()
		end

		return
	end, 1, -1)

	self.timers[arg_19_2]:Start()
	self.timers[arg_19_2].func()

	return
end

function WorldBossHelpPage:RemoveRequestTimer(arg_21_1)
	if self.timers[arg_21_1] then
		self.timers[arg_21_1]:Stop()

		self.timers[arg_21_1] = nil
	end

	return
end

function WorldBossHelpPage:RemoveRequestTimers()
	for iter_22_0, iter_22_1 in pairs(self.timers) do
		iter_22_1:Stop()
	end

	self.timers = {}

	return
end

function WorldBossHelpPage:Show()
	WorldBossHelpPage.super.Show(self)
	pg.UIMgr.GetInstance():BlurPanel(self._tf)

	return
end

function WorldBossHelpPage:Hide()
	WorldBossHelpPage.super.Hide(self)
	pg.UIMgr.GetInstance():UnOverlayPanel(self._tf, self._parentTf)

	return
end

function WorldBossHelpPage:OnDestroy()
	self:Hide()
	self:RemoveRequestTimers()

	return
end

return WorldBossHelpPage
