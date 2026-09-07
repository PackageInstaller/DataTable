local SignHalloweenPage = class("SignHalloweenPage", import("...base.BaseActivityPage"))
local var_0_1 = 15

function SignHalloweenPage:OnInit()
	self.icons = {
		self._tf:Find("AD/bg/npc1"),
		self._tf:Find("AD/bg/npc2"),
		self._tf:Find("AD/bg/npc3"),
		self._tf:Find("AD/bg/npc4"),
		self._tf:Find("AD/bg/npc5"),
		self._tf:Find("AD/bg/npc6"),
		self._tf:Find("AD/bg/npc7")
	}
	self.opens = {
		self._tf:Find("AD/bg/open1"),
		self._tf:Find("AD/bg/open2"),
		self._tf:Find("AD/bg/open3"),
		self._tf:Find("AD/bg/open4"),
		self._tf:Find("AD/bg/open5"),
		self._tf:Find("AD/bg/open6"),
		self._tf:Find("AD/bg/open7")
	}
	self.helpBtn = self._tf:Find("AD/help")
	self.goBtn = self._tf:Find("AD/go")

	return
end

function SignHalloweenPage:SetData()
	self.hubId = self.activity:getConfig("config_id")

	local var_2_0 = getProxy(MiniGameProxy):GetHubByHubId(self.hubId)

	self.data = var_2_0
	self.ultimate = var_2_0.ultimate
	self.usedtime = var_2_0.usedtime
	self.count = var_2_0.count

	return
end

function SignHalloweenPage:OnFirstFlush()
	self:SetData()
	onButton(self, self.goBtn, function()
		pg.m02:sendNotification(GAME.GO_MINI_GAME, var_0_1)

		return
	end, SFX_PANEL)
	onButton(self, self.helpBtn, function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = pg.gametip.help_candymagic.tip
		})

		return
	end, SFX_PANEL)
	self:UpdateSigned()
	self:CheckGet()

	return
end

function SignHalloweenPage:UpdateSigned()
	local var_6_0 = self.data:getConfig("reward_need")
	local var_6_1 = self.usedtime
	local var_6_3 = var_6_1 + self.count

	for iter_6_0, iter_6_1 in ipairs(self.icons) do
		local var_6_4 = iter_6_0 <= var_6_1
		local var_6_5 = iter_6_0 <= var_6_3

		setActive(self.icons[iter_6_0], false)
		setActive(self.opens[iter_6_0], false)

		if var_6_4 then
			setActive(self.icons[iter_6_0], var_6_4)
		elseif var_6_5 then
			setActive(self.opens[iter_6_0], var_6_5)
		end
	end

	return
end

function SignHalloweenPage:CheckGet()
	if self.ultimate == 0 then
		if self.data:getConfig("reward_need") > self.usedtime then
			return
		end

		pg.m02:sendNotification(GAME.SEND_MINI_GAME_OP, {
			hubid = self.hubId,
			cmd = MiniGameOPCommand.CMD_ULTIMATE,
			args1 = {}
		})
	end

	return
end

return SignHalloweenPage
