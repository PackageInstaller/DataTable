local TianHouSkinPage = class("TianHouSkinPage", import("...base.BaseActivityPage"))
local var_0_1 = {
	[0] = {
		color = "ffffff",
		name = "none"
	},
	{
		color = "ffed95",
		name = "na"
	},
	{
		color = "feb8ff",
		name = "k"
	},
	{
		color = "ad92ff",
		name = "rb"
	},
	{
		color = "affff4",
		name = "zn"
	},
	{
		color = "ffa685",
		name = "ca"
	},
	{
		color = "c1ffa7",
		name = "cu"
	}
}

function TianHouSkinPage.GetCurrentDay()
	return pg.TimeMgr.GetInstance():STimeDescS(pg.TimeMgr.GetInstance():GetServerTime(), "*t").yday
end

function TianHouSkinPage:OnInit()
	self.bg = self._tf:Find("AD")
	self.helpBtn = self.bg:Find("help")
	self.gotTag = self.bg:Find("got")
	self.medalText = self.bg:Find("medal")
	self.ticketText = self.bg:Find("ticket")
	self.fireworkBtn = self.bg:Find("game_list/firework")
	self.shootBtn = self.bg:Find("game_list/shoot")
	self.foodBtn = self.bg:Find("game_list/food")
	self.effectNode = self.bg:Find("effectNode")
	self.playEffectBtn = self.bg:Find("fire")

	return
end

function TianHouSkinPage:OnFirstFlush()
	self.hubID = self.activity:getConfig("config_id")

	onButton(self, self.helpBtn, function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = i18n("help_summer_feast")
		})

		return
	end, SFX_PANEL)
	onButton(self, self.fireworkBtn, function()
		pg.m02:sendNotification(GAME.GO_MINI_GAME, 26)

		return
	end, SFX_PANEL)
	onButton(self, self.shootBtn, function()
		pg.m02:sendNotification(GAME.GO_MINI_GAME, 27)

		return
	end, SFX_PANEL)
	onButton(self, self.foodBtn, function()
		pg.m02:sendNotification(GAME.GO_MINI_GAME, 25)

		return
	end, SFX_PANEL)

	local var_3_0 = getProxy(MiniGameProxy):GetMiniGameData(26):GetRuntimeData("elements")

	self.ishow = var_3_0 and #var_3_0 >= 4 and var_3_0[4] == self.GetCurrentDay()

	onButton(self, self.playEffectBtn, function()
		if not self.ishow then
			return
		end

		self:PlayFirework(var_3_0)
		setActive(self.playEffectBtn, false)

		return
	end, SFX_PANEL)
	blinkAni(self.playEffectBtn:Find("light"), 0.5)

	return
end

function TianHouSkinPage:OnUpdateFlush()
	local var_9_0 = getProxy(MiniGameProxy):GetHubByHubId(self.hubID)
	local var_9_1 = var_9_0:getConfig("reward_need")

	setText(self.ticketText, var_9_0.count)
	setText(self.medalText, var_9_0.usedtime .. "/" .. var_9_1)
	setActive(self.gotTag, var_9_0.ultimate ~= 0)

	if var_9_0.ultimate == 0 and var_9_1 <= var_9_0.usedtime then
		pg.m02:sendNotification(GAME.SEND_MINI_GAME_OP, {
			hubid = self.hubID,
			cmd = MiniGameOPCommand.CMD_ULTIMATE,
			args1 = {}
		})
	end

	setActive(self.playEffectBtn, self.ishow)
	pg.NewStoryMgr.GetInstance():Play("TIANHOUYUYI1")

	return
end

function TianHouSkinPage:TransformColor()
	return Color.New(tonumber(string.sub(self, 1, 2), 16) / 255, tonumber(string.sub(self, 3, 4), 16) / 255, tonumber(string.sub(self, 5, 6), 16) / 255)
end

function TianHouSkinPage:PlayFirework(arg_11_1)
	arg_11_1 = arg_11_1 or {
		0,
		0,
		0
	}

	local var_11_0 = UnityEngine.ParticleSystem.MinMaxGradient.New

	pg.PoolMgr.GetInstance():GetPrefab("ui/firework", "", false, function(arg_12_0)
		local var_12_0 = tf(arg_12_0):Find("Fire"):GetComponent("ParticleSystem").main.startColor

		tf(arg_12_0):Find("Fire"):GetComponent("ParticleSystem").main.startColor = var_11_0(self.TransformColor(var_0_1[arg_11_1[1]].color))
		tf(arg_12_0):Find("Fire/par_small"):GetComponent("ParticleSystem").main.startColor = var_11_0(self.TransformColor(var_0_1[arg_11_1[2]].color))
		tf(arg_12_0):Find("Fire/par_small/par_big"):GetComponent("ParticleSystem").main.startColor = var_11_0(self.TransformColor(var_0_1[arg_11_1[3]].color))

		setParent(arg_12_0, self.effectNode)

		arg_12_0.transform.localPosition = Vector2(0, 0)
		self.fireEffect = arg_12_0

		return
	end)
	self:PlaySE()

	return
end

function TianHouSkinPage:ClearEffectFirework()
	self:StopSE()

	if self.fireEffect then
		pg.PoolMgr.GetInstance():ReturnPrefab("ui/firework", "", self.fireEffect)
	end

	return
end

function TianHouSkinPage:PlaySE()
	if self.SETimer then
		return
	end

	self.SECount = 10
	self.SETimer = Timer.New(function()
		self.SECount = self.SECount - 1

		if self.SECount <= 0 then
			self.SECount = math.random(5, 20)

			pg.CriMgr.GetInstance():PlaySE_V3("battle-firework")
		end

		return
	end, 0.1, -1)

	self.SETimer:Start()

	return
end

function TianHouSkinPage:StopSE()
	if self.SETimer then
		pg.CriMgr.GetInstance():StopSEBattle_V3()
		self.SETimer:Stop()

		self.SETimer = nil
	end

	return
end

function TianHouSkinPage:OnHideFlush()
	self:ClearEffectFirework()

	return
end

function TianHouSkinPage:OnDestroy()
	self:ClearEffectFirework()

	return
end

return TianHouSkinPage
