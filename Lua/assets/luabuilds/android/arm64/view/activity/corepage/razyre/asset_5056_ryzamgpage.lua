local RyzaMGPage = class("RyzaMGPage", import("view.activity.CorePage.CoreActivityPage"))
local var_0_1 = 43

function RyzaMGPage:OnInit()
	self.mgHubData = getProxy(MiniGameProxy):GetHubByGameId(var_0_1)
	self.drops = pg.mini_game[var_0_1].simple_config_data.drop_ids
	self.totalTimes = #self.drops
	self.useTimes = self.mgHubData.usedtime
	self.gameTimes = self.mgHubData.count

	return
end

function RyzaMGPage:OnFirstFlush()
	self.btnStart = findTF(self._tf, "ad/start")
	self.btnRule = findTF(self._tf, "ad/rule")
	self.moveLeft = findTF(self._tf, "ad/moveLeft")
	self.moveRight = findTF(self._tf, "ad/moveRight")
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
		GetSpriteFromAtlasAsync("ui/ryzamgpage_atlas", "day_" .. iter_2_0, function(arg_4_0)
			setImageSprite(findTF(var_2_0, "ad/complete"), arg_4_0, true)

			return
		end)
		GetSpriteFromAtlasAsync("ui/ryzamgpage_atlas", "day_c_" .. iter_2_0, function(arg_5_0)
			setImageSprite(findTF(var_2_0, "ad/open"), arg_5_0, true)

			return
		end)
		setActive(findTF(var_2_0, "ad/open"), iter_2_0 > self.useTimes)
		setActive(findTF(var_2_0, "ad/complete"), iter_2_0 <= self.useTimes)
		setActive(findTF(var_2_0, "ad/got"), iter_2_0 <= self.useTimes)
	end

	onButton(self, self.btnStart, function()
		pg.m02:sendNotification(GAME.GO_MINI_GAME, var_0_1)

		return
	end, SFX_CONFIRM)
	onButton(self, self.btnRule, function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = pg.gametip.ryza_mini_game.tip
		})

		return
	end, SFX_CONFIRM)
	onButton(self, self.moveRight, function()
		scrollTo(self.awardsRect, (self.awardsRect.normalizedPosition.x + 1 / (self.totalTimes - 4) <= 0 or nil) and 0, 0)

		return
	end, SFX_CONFIRM)
	onButton(self, self.moveLeft, function()
		scrollTo(self.awardsRect, (self.awardsRect.normalizedPosition.x - 1 / (self.totalTimes - 4) > 1 or nil) and 1, 0)

		return
	end, SFX_CONFIRM)
	scrollTo(self.awardsRect, 1 - (self.totalTimes - 4 < 0 and 0 or self.totalTimes - 4) / (self.totalTimes - 4), 0)

	return
end

function RyzaMGPage:willExit()
	return
end

return RyzaMGPage
