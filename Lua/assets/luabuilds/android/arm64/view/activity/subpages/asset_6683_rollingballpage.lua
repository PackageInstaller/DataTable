local RollingBallPage = class("RollingBallPage", import("...base.BaseActivityPage"))

function RollingBallPage:OnInit()
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

	return
end

function RollingBallPage:SetData()
	local var_2_0 = getProxy(MiniGameProxy):GetHubByHubId(10)

	self.data = var_2_0
	self.ultimate = var_2_0.ultimate
	self.usedtime = var_2_0.usedtime

	return
end

function RollingBallPage:OnFirstFlush()
	self:SetData()
	onButton(self, self.goBtn, function()
		pg.m02:sendNotification(GAME.GO_MINI_GAME, 14)

		return
	end, SFX_PANEL)
	onButton(self, self.helpBtn, function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = pg.gametip.rolling_ball_help.tip
		})

		return
	end, SFX_PANEL)
	self:UpdateSigned()
	self:CheckGet()

	return
end

function RollingBallPage:UpdateSigned()
	local var_6_0 = self.data:getConfig("reward_need")
	local var_6_1 = self.usedtime

	for iter_6_0, iter_6_1 in ipairs(self.icons) do
		setActive(iter_6_1, iter_6_0 <= var_6_1)
	end

	return
end

function RollingBallPage:CheckGet()
	if self.ultimate == 0 then
		if self.data:getConfig("reward_need") > self.usedtime then
			return
		end

		pg.m02:sendNotification(GAME.SEND_MINI_GAME_OP, {
			hubid = 10,
			cmd = MiniGameOPCommand.CMD_ULTIMATE,
			args1 = {}
		})
	end

	return
end

return RollingBallPage
