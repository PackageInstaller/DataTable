local RapidSeasideMusicGamePage = class("RapidSeasideMusicGamePage", import("view.activity.CorePage.CoreActivityPage"))
local var_0_1 = 88

function RapidSeasideMusicGamePage:OnInit()
	self.mgHubData = getProxy(MiniGameProxy):GetHubByGameId(var_0_1)
	self.drops = pg.mini_game[var_0_1].simple_config_data.drop_ids
	self.totalTimes = #self.drops
	self.useTimes = self.mgHubData.usedtime
	self.gameTimes = self.mgHubData.count
	self.highestScore = self._tf:Find("ad/record/img/Text")

	return
end

function RapidSeasideMusicGamePage:OnFirstFlush()
	self.btnStart = findTF(self._tf, "ad/list/start")
	self.btnRule = findTF(self._tf, "ad/list/rule")
	self.btnRank = findTF(self._tf, "ad/list/rank")

	setText(findTF(self.btnStart, "Text"), i18n("beat_game_go"))
	setText(findTF(self.btnRule, "Text"), i18n("beat_game_rule"))
	setText(findTF(self.btnRank, "Text"), i18n("beat_game_rank"))
	GetComponent(findTF(self._tf, "ad/desc"), typeof(Image)):SetNativeSize()

	self.awardsTf = findTF(self._tf, "ad/awards")
	self.awardContent = findTF(self._tf, "ad/awards/content")
	self.awardsRect = GetComponent(self.awardsTf, typeof(ScrollRect))
	self.itemTpl = findTF(self._tf, "ad/awards/content/itemTpl")

	setActive(self.itemTpl, false)

	for iter_2_0 = 1, #self.drops do
		local var_2_0 = tf(Instantiate(self.itemTpl))

		setParent(var_2_0, self.awardContent)
		setActive(var_2_0, true)

		local var_2_1 = {
			type = self.drops[iter_2_0][1],
			id = self.drops[iter_2_0][2],
			count = self.drops[iter_2_0][3]
		}

		updateDrop(findTF(var_2_0, "ad/IconTpl"), var_2_1)
		onButton(self, var_2_0, function()
			self:emit(BaseUI.ON_DROP, var_2_1)

			return
		end, SFX_PANEL)
		setText(findTF(var_2_0, "ad/day"), "DAY" .. iter_2_0)
		setActive(findTF(var_2_0, "ad/lock"), iter_2_0 > self.useTimes + self.gameTimes)
		setActive(findTF(var_2_0, "ad/got"), iter_2_0 <= self.useTimes)
	end

	onButton(self, self.btnStart, function()
		pg.m02:sendNotification(GAME.GO_MINI_GAME, var_0_1)

		return
	end, SFX_CONFIRM)
	onButton(self, self.btnRule, function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = pg.gametip.musicbeat_minigame_help.tip
		})

		return
	end, SFX_CONFIRM)
	onButton(self, self.btnRank, function()
		pg.m02:sendNotification(GAME.GO_MINI_GAME, {
			rank = true,
			id = var_0_1
		})

		return
	end, SFX_CONFIRM)
	setText(self.highestScore, (self.mgHubData.highScores[var_0_1] and self.mgHubData.highScores[var_0_1][1] or nil) and self.mgHubData.highScores[var_0_1][1])
	scrollTo(self.awardsRect, 1 - (self.totalTimes - 7 < 0 and 0 or self.totalTimes - 7) / (self.totalTimes - 7), 0)

	return
end

function RapidSeasideMusicGamePage:willExit()
	return
end

return RapidSeasideMusicGamePage
