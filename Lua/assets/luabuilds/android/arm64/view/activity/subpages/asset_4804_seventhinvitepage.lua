local SeventhInvitePage = class("SeventhInvitePage", import("...base.BaseActivityPage"))

function SeventhInvitePage:OnInit()
	self.rtMarks = self._tf:Find("AD/progress")
	self.rtFinish = self._tf:Find("AD/award")
	self.rtBtns = self._tf:Find("AD/btn_list")

	return
end

function SeventhInvitePage:OnDataSetting()
	self.gameId = self.activity:getConfig("config_client").mini_game_id
	self.hubId = pg.mini_game[self.gameId].hub_id
	self.data = getProxy(MiniGameProxy):GetHubByHubId(self.hubId)
	self.ultimate = self.data.ultimate
	self.usedtime = self.data.usedtime
	self.maxtime = self.data:getConfig("reward_need")

	return
end

function SeventhInvitePage:OnFirstFlush()
	onButton(self, self.rtBtns:Find("go"), function()
		pg.m02:sendNotification(GAME.GO_MINI_GAME, self.gameId)

		return
	end, SFX_PANEL)
	onButton(self, self.rtBtns:Find("get"), function()
		pg.m02:sendNotification(GAME.SEND_MINI_GAME_OP, {
			hubid = self.hubId,
			cmd = MiniGameOPCommand.CMD_ULTIMATE,
			args1 = {}
		})

		return
	end, SFX_PANEL)

	return
end

function SeventhInvitePage:OnUpdateFlush()
	local var_6_0 = self.usedtime

	for iter_6_0 = 1, self.rtMarks.childCount do
		local var_6_1 = self.rtMarks:GetChild(iter_6_0 - 1)

		setActive(var_6_1:Find("mark"), iter_6_0 <= var_6_0)
		setActive(var_6_1:Find("icon"), iter_6_0 == var_6_0 and self.ultimate == 0)
	end

	setActive(self.rtFinish:Find("got"), self.ultimate == 1)
	setActive(self.rtBtns:Find("get"), self.ultimate == 0 and var_6_0 == self.maxtime)
	setActive(self.rtBtns:Find("got"), self.ultimate == 1)
	setActive(self.rtBtns:Find("go"), var_6_0 < self.maxtime)
	setActive(self.rtBtns:Find("red"), var_6_0 <= self.maxtime and self.ultimate ~= 1 and self.data.count > 0)

	return
end

return SeventhInvitePage
