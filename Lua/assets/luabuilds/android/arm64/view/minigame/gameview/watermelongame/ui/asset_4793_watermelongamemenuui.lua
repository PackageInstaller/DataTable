local WatermelonGameMenuUI = class("WatermelonGameMenuUI")

function WatermelonGameMenuUI:Ctor(arg_1_1, arg_1_2, arg_1_3)
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
		self._event:emit(WatermelonGameEvent.CLOSE_GAME)

		return
	end, SFX_CANCEL)
	onButton(self._event, findTF(self.menuUI, "btnRule"), function()
		self._event:emit(WatermelonGameEvent.SHOW_RULE, true)

		return
	end, SFX_CANCEL)
	onButton(self._event, self.imgHelp, function()
		self._event:emit(WatermelonGameEvent.SHOW_RULE, false)

		return
	end, SFX_CANCEL)

	self.btnStart = findTF(self.menuUI, "btnStart")

	onButton(self._event, self.btnStart, function()
		self._event:emit(WatermelonGameEvent.READY_START)

		return
	end, SFX_CANCEL)
	onButton(self._event, self.btnRank, function()
		pg.m02:sendNotification(GAME.SEND_MINI_GAME_OP, {
			hubid = self.mgHubData.id,
			cmd = MiniGameOPCommand.CMD_SPECIAL_TRACK,
			args1 = {
				self._gameVo.gameId,
				103
			}
		})
		self._event:emit(WatermelonGameEvent.SHOW_RANK)

		return
	end, SFX_CANCEL)
	onButton(self._event, self.btnHome, function()
		self._event:emit(WatermelonGameEvent.ON_HOME)

		return
	end, SFX_CANCEL)

	local var_1_0 = findTF(self.menuUI, "tplBattleItem")

	for iter_1_0 = 1, 7 do
		local var_1_2 = tf(instantiate(var_1_0))

		var_1_2.name = "battleItem_" .. iter_1_0

		setParent(var_1_2, findTF(self.menuUI, "battList/Viewport/Content"))
		GetSpriteFromAtlasAsync(WatermelonGameConst.ui_atlas, "DAY" .. iter_1_0, function(arg_10_0)
			if arg_10_0 then
				setImageSprite(findTF(var_1_2, "state_open/desc"), arg_10_0, true)
				setImageSprite(findTF(var_1_2, "state_clear/desc"), arg_10_0, true)
				setImageSprite(findTF(var_1_2, "state_current/desc"), arg_10_0, true)
				setImageSprite(findTF(var_1_2, "state_closed/desc"), arg_10_0, true)
			end

			return
		end)

		local var_1_3 = findTF(var_1_2, "icon")
		local var_1_4 = {
			type = self._gameVo.drop[iter_1_0][1],
			id = self._gameVo.drop[iter_1_0][2],
			count = self._gameVo.drop[iter_1_0][3]
		}

		updateDrop(var_1_3, var_1_4)
		onButton(self._event, var_1_3, function()
			self._event:emit(BaseUI.ON_DROP, var_1_4)

			return
		end, SFX_PANEL)
		table.insert(self.dropItems, var_1_3)
		setActive(var_1_2, true)
		table.insert(self.battleItems, var_1_2)

		local var_1_5 = self._gameVo:getGameUseTimes()
		local var_1_6 = self._gameVo:getGameTimes()
	end

	return
end

function WatermelonGameMenuUI:show(arg_12_1)
	setActive(self.menuUI, arg_12_1)

	return
end

function WatermelonGameMenuUI:setGameRoomUI(arg_13_1)
	if arg_13_1 then
		setActive(findTF(self.menuUI, "lastTimes"), false)
		setActive(findTF(self.menuUI, "btnRank"), false)
	end

	return
end

function WatermelonGameMenuUI:update(arg_14_1)
	self.mgHubData = arg_14_1

	local var_14_0 = self:getGameUsedTimes(arg_14_1)
	local var_14_1 = self:getGameTimes(arg_14_1)

	setText(self.textLastTimes, var_14_1)

	for iter_14_0 = 1, 7 do
		setActive(findTF(self.battleItems[iter_14_0], "state_open"), false)
		setActive(findTF(self.battleItems[iter_14_0], "state_closed"), false)
		setActive(findTF(self.battleItems[iter_14_0], "state_clear"), false)
		setActive(findTF(self.battleItems[iter_14_0], "state_current"), false)

		if iter_14_0 <= var_14_0 then
			SetParent(self.dropItems[iter_14_0], findTF(self.battleItems[iter_14_0], "state_clear/icon"))
			setActive(self.dropItems[iter_14_0], true)
			setActive(findTF(self.battleItems[iter_14_0], "state_clear"), true)
		elseif iter_14_0 == var_14_0 + 1 and var_14_1 >= 1 then
			setActive(findTF(self.battleItems[iter_14_0], "state_current"), true)
			SetParent(self.dropItems[iter_14_0], findTF(self.battleItems[iter_14_0], "state_current/icon"))
			setActive(self.dropItems[iter_14_0], true)
		elseif var_14_0 < iter_14_0 and iter_14_0 <= var_14_0 + var_14_1 then
			setActive(findTF(self.battleItems[iter_14_0], "state_open"), true)
			SetParent(self.dropItems[iter_14_0], findTF(self.battleItems[iter_14_0], "state_open/icon"))
			setActive(self.dropItems[iter_14_0], true)
		else
			setActive(findTF(self.battleItems[iter_14_0], "state_closed"), true)
			SetParent(self.dropItems[iter_14_0], findTF(self.battleItems[iter_14_0], "state_closed/icon"))
			setActive(self.dropItems[iter_14_0], true)
		end
	end

	scrollTo(self.battleScrollRect, 0, (1 - (var_14_0 - 3 < 0 and 0 or var_14_0 - 3) / (self.totalTimes - 4) > 1 or nil) and 1)

	local var_14_3 = getProxy(MiniGameProxy):GetHighScore(self._gameVo.gameId)

	setText(self.highScore, (var_14_3 and #var_14_3 > 0 or nil) and (var_14_3[1] or 0))

	return
end

function WatermelonGameMenuUI:CheckGet()
	setActive(findTF(self.menuUI, "got"), false)

	local var_15_0 = self:getUltimate(self.mgHubData)

	if var_15_0 and var_15_0 ~= 0 then
		setActive(findTF(self.menuUI, "got"), true)
	end

	if var_15_0 == 0 then
		if self._gameVo.totalTimes > self:getGameUsedTimes(self.mgHubData) then
			return
		end

		pg.m02:sendNotification(GAME.SEND_MINI_GAME_OP, {
			hubid = self.mgHubData.id,
			cmd = MiniGameOPCommand.CMD_ULTIMATE,
			args1 = {}
		})
		setActive(findTF(self.menuUI, "got"), true)
	end

	return
end

function WatermelonGameMenuUI:getGameTimes(arg_16_1)
	return arg_16_1.count
end

function WatermelonGameMenuUI:getGameUsedTimes(arg_17_1)
	return arg_17_1.usedtime
end

function WatermelonGameMenuUI:getUltimate(arg_18_1)
	return arg_18_1.ultimate
end

return WatermelonGameMenuUI
