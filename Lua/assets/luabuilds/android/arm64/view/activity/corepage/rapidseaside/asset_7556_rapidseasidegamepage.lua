local RapidSeasideGamePage = class("RapidSeasideGamePage", import("view.activity.CorePage.CoreActivityPage"))
local var_0_1 = 89

function RapidSeasideGamePage:OnInit()
	self.mgHubData = getProxy(MiniGameProxy):GetHubByGameId(var_0_1)
	self.drops = pg.mini_game[var_0_1].simple_config_data.drop_ids
	self.totalTimes = #self.drops
	self.useTimes = self.mgHubData.usedtime
	self.gameTimes = self.mgHubData.count

	return
end

function RapidSeasideGamePage:OnFirstFlush()
	self.btnRule = findTF(self._tf, "ad/rule")

	onButton(self, self.btnRule, function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = pg.gametip.crossroad_minigame_help.tip
		})

		return
	end, SFX_CANCEL)

	self.btnStart = findTF(self._tf, "ad/start")

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
		setText(findTF(var_2_1, "ad/desc"), "DAY" .. iter_2_0)

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

function RapidSeasideGamePage:OnUpdateFlush()
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

	return
end

function RapidSeasideGamePage:setChildVisible(arg_7_1, arg_7_2)
	for iter_7_0 = 1, arg_7_1.childCount do
		setActive(arg_7_1:GetChild(iter_7_0 - 1), arg_7_2)
	end

	return
end

function RapidSeasideGamePage:willExit()
	return
end

return RapidSeasideGamePage
