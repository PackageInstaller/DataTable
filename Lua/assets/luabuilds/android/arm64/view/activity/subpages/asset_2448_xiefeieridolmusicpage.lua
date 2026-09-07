local XiefeierIdolMusicPage = class("XiefeierIdolMusicPage", import("...base.BaseActivityPage"))
local var_0_1 = {
	0.08,
	0.19,
	0.4,
	0.6,
	0.734,
	0.876,
	1,
	1
}

function XiefeierIdolMusicPage:OnInit()
	self.bg = self._tf:Find("AD")
	self.masklist = self.bg:Find("maskList")
	self.slider = self.bg:Find("slider")

	return
end

function XiefeierIdolMusicPage:OnDataSetting()
	self.HubID = self.activity:getConfig("config_id")

	print("self.HubID:" .. self.HubID)

	self.mgProxy = getProxy(MiniGameProxy)

	return
end

function XiefeierIdolMusicPage:OnFirstFlush()
	onButton(self, self.bg:Find("battle_btn"), function()
		pg.m02:sendNotification(GAME.GO_MINI_GAME, 16)

		return
	end, SFX_PANEL)

	return
end

function XiefeierIdolMusicPage:OnUpdateFlush()
	self.hubData = self.mgProxy:GetHubByHubId(self.HubID)
	self.finish_times = self.hubData.usedtime
	self.all_times = self.hubData.usedtime + self.hubData.count

	for iter_5_0 = 1, 7 do
		setActive(self.masklist:Find("mask" .. iter_5_0 .. "/dot"), iter_5_0 <= self.finish_times)
		setActive(self.masklist:Find("mask" .. iter_5_0 .. "/frame"), iter_5_0 <= self.all_times and not isActive(self.masklist:Find("mask" .. iter_5_0 .. "/dot")))
	end

	if self.finish_times > 0 then
		setSlider(self.slider, 0, 1, var_0_1[self.finish_times])
	else
		setSlider(self.slider, 0, 1, 0)
	end

	if self.finish_times >= self.hubData:getConfig("reward_need") and self.hubData.ultimate == 0 then
		self:emit(ActivityMediator.MUSIC_GAME_OPERATOR, {
			hubid = self.HubID,
			cmd = MiniGameOPCommand.CMD_ULTIMATE,
			args1 = {}
		})
	end

	setActive(self.bg:Find("got_icon"), self.hubData.ultimate ~= 0)

	return
end

function XiefeierIdolMusicPage:OnDestroy()
	clearImageSprite(self.bg)

	return
end

return XiefeierIdolMusicPage
