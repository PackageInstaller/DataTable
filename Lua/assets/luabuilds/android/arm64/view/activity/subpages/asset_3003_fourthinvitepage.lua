local FourthInvitePage = class("FourthInvitePage", import("...base.BaseActivityPage"))

function FourthInvitePage:OnInit()
	self.icons = {
		self._tf:Find("AD/bg/npc1"),
		self._tf:Find("AD/bg/npc2"),
		self._tf:Find("AD/bg/npc3"),
		self._tf:Find("AD/bg/npc4"),
		self._tf:Find("AD/bg/npc5"),
		self._tf:Find("AD/bg/npc6"),
		self._tf:Find("AD/bg/npc7")
	}
	self.helpBtn = self._tf:Find("AD/help")
	self.goBtn = self._tf:Find("AD/go")
	self.gotBtn = self._tf:Find("AD/got")

	return
end

function FourthInvitePage:OnDataSetting()
	self.gameId = self.activity:getConfig("config_client").mini_game_id
	self.hubId = pg.mini_game[self.gameId].hub_id
	self.data = getProxy(MiniGameProxy):GetHubByHubId(self.hubId)
	self.ultimate = self.data.ultimate
	self.usedtime = self.data.usedtime
	self.maxtime = self.data:getConfig("reward_need")

	return
end

function FourthInvitePage:OnFirstFlush()
	onButton(self, self.goBtn, function()
		pg.m02:sendNotification(GAME.GO_MINI_GAME, self.gameId)

		return
	end, SFX_PANEL)
	onButton(self, self.helpBtn, function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = pg.gametip.catchteasure_help.tip
		})

		return
	end, SFX_PANEL)

	return
end

function FourthInvitePage:OnUpdateFlush()
	SetActive(self.gotBtn, self.ultimate == 1)
	self:UpdateSigned()
	self:CheckGet()

	return
end

function FourthInvitePage:UpdateSigned()
	local var_7_1 = self.usedtime

	for iter_7_0, iter_7_1 in ipairs(self.icons) do
		setActive(iter_7_1, iter_7_0 <= var_7_1)
	end

	return
end

function FourthInvitePage:CheckGet()
	if self.ultimate == 0 then
		if self.maxtime > self.usedtime then
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

return FourthInvitePage
