local MusicBeatGameMenuUI = class("MusicBeatGameMenuUI")

function MusicBeatGameMenuUI:Ctor(arg_1_1, arg_1_2, arg_1_3)
	self._tf = arg_1_1
	self._event = arg_1_2
	self._gameVo = arg_1_3
	self.menuUI = findTF(self._tf, "ui/menuUI")
	self.battleScrollRect = GetComponent(findTF(self.menuUI, "battList"), typeof(ScrollRect))
	self.totalTimes = self._gameVo.totalTimes
	self.battleItems = {}
	self.dropItems = {}
	self.textLastTimes = findTF(self.menuUI, "lastTimes/desc")
	self.btnRank = findTF(self.menuUI, "btnRank")
	self.btnHome = findTF(self.menuUI, "btnHome")

	GetComponent(self.btnRank, typeof(Image)):SetNativeSize()

	self.imgHelp = findTF(self.menuUI, "imgHelp")
	self.highScore = findTF(self.menuUI, "highScore/text")

	setActive(self.imgHelp, false)
	onButton(self._event, findTF(self.menuUI, "rightPanelBg/arrowUp"), function()
		scrollTo(self.battleScrollRect, 0, (self.battleScrollRect.normalizedPosition.y + 1 / (self.totalTimes - 4) > 1 or nil) and 1)

		return
	end, SFX_CANCEL)
	onButton(self._event, findTF(self.menuUI, "rightPanelBg/arrowDown"), function()
		scrollTo(self.battleScrollRect, 0, (self.battleScrollRect.normalizedPosition.y - 1 / (self.totalTimes - 4) < 0 or nil) and 0)

		return
	end, SFX_CANCEL)
	onButton(self._event, findTF(self.menuUI, "btnBack"), function()
		self._event:emit(MusicBeatGameEvent.CLOSE_GAME)

		return
	end, SFX_CANCEL)
	onButton(self._event, findTF(self.menuUI, "btnRule"), function()
		self._event:emit(MusicBeatGameEvent.SHOW_RULE, true)

		return
	end, SFX_CANCEL)
	onButton(self._event, self.imgHelp, function()
		self._event:emit(MusicBeatGameEvent.SHOW_RULE, false)

		return
	end, SFX_CANCEL)

	self.btnStart = findTF(self.menuUI, "btnStart")

	onButton(self._event, self.btnStart, function()
		self._event:emit(MusicBeatGameEvent.READY_START)

		return
	end, SFX_CANCEL)
	onButton(self._event, self.btnRank, function()
		self._event:emit(MusicBeatGameEvent.SHOW_RANK)

		return
	end, SFX_CANCEL)
	onButton(self._event, self.btnHome, function()
		self._event:emit(MusicBeatGameEvent.ON_HOME)

		return
	end, SFX_CANCEL)

	local var_1_0 = findTF(self.menuUI, "tplBattleItem")

	for iter_1_0 = 1, 7 do
		local var_1_2 = tf(instantiate(var_1_0))

		var_1_2.name = "battleItem_" .. iter_1_0

		setParent(var_1_2, findTF(self.menuUI, "battList/Viewport/Content"))

		local var_1_4 = findTF(var_1_2, "icon")
		local var_1_5 = {
			type = self._gameVo.drop[iter_1_0][1],
			id = self._gameVo.drop[iter_1_0][2],
			count = self._gameVo.drop[iter_1_0][3]
		}

		updateDrop(var_1_4, var_1_5)
		onButton(self._event, var_1_4, function()
			self._event:emit(BaseUI.ON_DROP, var_1_5)

			return
		end, SFX_PANEL)
		table.insert(self.dropItems, var_1_4)
		setActive(var_1_2, true)
		table.insert(self.battleItems, var_1_2)

		local var_1_6 = self._gameVo:getGameUseTimes()
		local var_1_7 = self._gameVo:getGameTimes()
	end

	setText(findTF(self.menuUI, "btnRule/text"), i18n("beat_game_rule"))
	setText(findTF(self.menuUI, "btnStart/text"), i18n("beat_game_start"))
	setText(findTF(self.menuUI, "btnRank/text"), i18n("beat_game_rank"))

	return
end

function MusicBeatGameMenuUI:show(arg_11_1)
	setActive(self.menuUI, arg_11_1)

	return
end

function MusicBeatGameMenuUI:setGameRoomUI(arg_12_1)
	if arg_12_1 then
		setActive(findTF(self.menuUI, "lastTimes"), false)
		setActive(findTF(self.menuUI, "btnRank"), false)
	end

	return
end

function MusicBeatGameMenuUI:update(arg_13_1)
	self.mgHubData = arg_13_1

	local var_13_0 = self:getGameUsedTimes(arg_13_1)
	local var_13_1 = self:getGameTimes(arg_13_1)

	setText(self.textLastTimes, var_13_1)

	for iter_13_0 = 1, 7 do
		setActive(findTF(self.battleItems[iter_13_0], "lock"), false)
		setActive(findTF(self.battleItems[iter_13_0], "clear"), false)

		if iter_13_0 <= var_13_0 then
			setActive(findTF(self.battleItems[iter_13_0], "clear"), true)
		elseif iter_13_0 == var_13_0 + 1 and var_13_1 >= 1 then
			-- block empty
		elseif var_13_0 < iter_13_0 and iter_13_0 <= var_13_0 + var_13_1 then
			-- block empty
		else
			setActive(findTF(self.battleItems[iter_13_0], "lock"), true)
		end
	end

	scrollTo(self.battleScrollRect, 0, (1 - (var_13_0 - 3 < 0 and 0 or var_13_0 - 3) / (self.totalTimes - 4) > 1 or nil) and 1)

	local var_13_3 = getProxy(MiniGameProxy):GetHighScore(self._gameVo.gameId)

	setText(self.highScore, (var_13_3 and #var_13_3 > 0 or nil) and (var_13_3[1] or 0))

	return
end

function MusicBeatGameMenuUI:CheckGet()
	local var_14_0 = self:getUltimate(self.mgHubData)

	setActive(findTF(self.menuUI, "got"), false)

	if not var_14_0 then
		return
	end

	if var_14_0 ~= 0 then
		setActive(findTF(self.menuUI, "got"), true)
	elseif var_14_0 == 0 and self._gameVo.totalTimes <= self:getGameUsedTimes(self.mgHubData) then
		pg.m02:sendNotification(GAME.SEND_MINI_GAME_OP, {
			hubid = self.mgHubData.id,
			cmd = MiniGameOPCommand.CMD_ULTIMATE,
			args1 = {}
		})
		setActive(findTF(self.menuUI, "got"), true)
	end

	return
end

function MusicBeatGameMenuUI:showRankUI()
	triggerButton(self.btnRank)

	return
end

function MusicBeatGameMenuUI:getGameTimes(arg_16_1)
	return arg_16_1.count
end

function MusicBeatGameMenuUI:getGameUsedTimes(arg_17_1)
	return arg_17_1.usedtime
end

function MusicBeatGameMenuUI:getUltimate(arg_18_1)
	return arg_18_1.ultimate
end

return MusicBeatGameMenuUI
