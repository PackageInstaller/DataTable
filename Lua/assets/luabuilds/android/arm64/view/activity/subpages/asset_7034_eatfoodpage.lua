local EatFoodPage = class("EatFoodPage", import("...base.BaseActivityPage"))
local var_0_1 = 35
local var_0_2 = 31

function EatFoodPage:OnInit()
	self.icons = {
		self._tf:Find("AD/bg/npc1"),
		self._tf:Find("AD/bg/npc2"),
		self._tf:Find("AD/bg/npc3"),
		self._tf:Find("AD/bg/npc4"),
		self._tf:Find("AD/bg/npc5"),
		self._tf:Find("AD/bg/npc6"),
		self._tf:Find("AD/bg/npc7")
	}
	self.locks = {
		self._tf:Find("AD/bg/lock1"),
		self._tf:Find("AD/bg/lock2"),
		self._tf:Find("AD/bg/lock3"),
		self._tf:Find("AD/bg/lock4"),
		self._tf:Find("AD/bg/lock5"),
		self._tf:Find("AD/bg/lock6"),
		self._tf:Find("AD/bg/lock7")
	}
	self.helpBtn = self._tf:Find("AD/help")
	self.goBtn = self._tf:Find("AD/go")

	local var_1_0 = Drop.Create(pg.mini_game_hub[var_0_1].reward_display)

	onButton(self, self._tf:Find("AD/btnFinalAward"), function()
		self:emit(BaseUI.ON_DROP, var_1_0)

		return
	end, SFX_PANEL)

	return
end

function EatFoodPage:SetData()
	local var_3_0 = getProxy(MiniGameProxy):GetHubByHubId(var_0_1)

	self.data = var_3_0
	self.ultimate = var_3_0.ultimate
	self.usedtime = var_3_0.usedtime
	self.count = var_3_0.count

	return
end

function EatFoodPage:OnFirstFlush()
	self:SetData()
	onButton(self, self.goBtn, function()
		pg.m02:sendNotification(GAME.GO_MINI_GAME, var_0_2)

		return
	end, SFX_PANEL)
	onButton(self, self.helpBtn, function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = pg.gametip.eatgame_tips.tip
		})

		return
	end, SFX_PANEL)
	self:UpdateSigned()
	self:CheckGet()

	return
end

function EatFoodPage:UpdateSigned()
	local var_7_0 = self.data:getConfig("reward_need")
	local var_7_1 = self.usedtime
	local var_7_3 = var_7_1 + self.count

	for iter_7_0, iter_7_1 in ipairs(self.icons) do
		local var_7_4 = iter_7_0 <= var_7_1
		local var_7_5 = iter_7_0 <= var_7_3

		setActive(self.icons[iter_7_0], false)
		setActive(self.locks[iter_7_0], false)

		if var_7_4 then
			setActive(self.icons[iter_7_0], var_7_4)
		elseif not var_7_5 then
			setActive(self.locks[iter_7_0], not var_7_5)
		end
	end

	return
end

function EatFoodPage:CheckGet()
	if self.ultimate == 0 then
		if self.data:getConfig("reward_need") > self.usedtime then
			return
		end

		pg.m02:sendNotification(GAME.SEND_MINI_GAME_OP, {
			hubid = var_0_1,
			cmd = MiniGameOPCommand.CMD_ULTIMATE,
			args1 = {}
		})
	end

	return
end

return EatFoodPage
