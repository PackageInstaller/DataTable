local SpringFestival2026PacGamePage = class("SpringFestival2026PacGamePage", import("view.activity.CorePage.CoreActivityPage"))
local var_0_1 = 81

function SpringFestival2026PacGamePage:OnInit()
	self.mgHubData = getProxy(MiniGameProxy):GetHubByGameId(var_0_1)
	self.drops = pg.mini_game[var_0_1].simple_config_data.drop_ids
	self.totalTimes = #self.drops
	self.useTimes = self.mgHubData.usedtime
	self.gameTimes = self.mgHubData.count

	return
end

function SpringFestival2026PacGamePage:OnFirstFlush()
	self.highScore = findTF(self._tf, "ad/title/text")
	self.btnRule = findTF(self._tf, "ad/rule")

	setText(findTF(self.btnRule, "text"), i18n("pac_game_rule_btn"))
	onButton(self, self.btnRule, function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = pg.gametip.pac_minigame_help.tip
		})

		return
	end, SFX_CANCEL)

	self.btnStart = findTF(self._tf, "ad/start")

	setText(findTF(self.btnStart, "text"), i18n("pac_game_start_btn"))
	onButton(self, self.btnStart, function()
		pg.m02:sendNotification(GAME.GO_MINI_GAME, var_0_1)

		return
	end, SFX_CANCEL)

	self.battleItems = {}
	self._tplBattleItem = findTF(self._tf, "ad/awards/Viewport/Content/item_tpl")

	setActive(self._tplBattleItem, false)

	for iter_2_0 = 1, 7 do
		local var_2_1 = tf(instantiate(self._tplBattleItem))

		var_2_1.name = "award_" .. iter_2_0

		setParent(var_2_1, findTF(self._tf, "ad/awards/Viewport/Content"))
		setText(findTF(var_2_1, "ad/desc"), i18n("which_day_2", iter_2_0))

		local var_2_2 = findTF(var_2_1, "ad/iconMask/icon")
		local var_2_3 = {
			type = self.drops[iter_2_0][1],
			id = self.drops[iter_2_0][2],
			count = self.drops[iter_2_0][3]
		}

		updateDrop(var_2_2, var_2_3)
		onButton(self, var_2_2, function()
			self:emit(BaseUI.ON_DROP, var_2_3)

			return
		end, SFX_PANEL)
		setActive(var_2_1, true)
		table.insert(self.battleItems, var_2_1)
	end

	return
end

function SpringFestival2026PacGamePage:OnUpdateFlush()
	for iter_6_0 = 1, 7 do
		local var_6_0 = findTF(self.battleItems[iter_6_0], "ad/lock")
		local var_6_1 = findTF(self.battleItems[iter_6_0], "ad/got")

		setActive(var_6_0, false)
		setActive(var_6_1, false)

		if iter_6_0 <= self.useTimes then
			setActive(var_6_1, true)
		elseif iter_6_0 == self.useTimes + 1 and self.gameTimes >= 1 then
			-- block empty
		elseif iter_6_0 > self.useTimes and iter_6_0 <= self.useTimes + self.gameTimes then
			-- block empty
		else
			setActive(var_6_0, true)
		end
	end

	local var_6_2 = getProxy(MiniGameProxy):GetHighScore(var_0_1)

	setText(self.highScore, i18n("pac_game_high_score_tip", (var_6_2 and #var_6_2 > 0 or nil) and (var_6_2[1] or 0)))

	return
end

function SpringFestival2026PacGamePage:willExit()
	return
end

return SpringFestival2026PacGamePage
