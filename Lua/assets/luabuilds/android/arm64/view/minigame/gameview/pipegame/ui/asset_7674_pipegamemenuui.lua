local PipeGameMenuUI = class("PipeGameMenuUI")
local var_0_1

function PipeGameMenuUI:Ctor(arg_1_1, arg_1_2)
	self._tf = arg_1_1
	var_0_1 = PipeGameVo
	self._event = arg_1_2
	self.menuUI = findTF(self._tf, "ui/menuUI")
	self.battleScrollRect = GetComponent(findTF(self.menuUI, "battList"), typeof(ScrollRect))
	self.totalTimes = var_0_1.total_times
	self.battleItems = {}
	self.dropItems = {}
	self.textLastTimes = findTF(self.menuUI, "lastTimes/desc")
	self.btnRank = findTF(self.menuUI, "btnRank")
	self.btnHome = findTF(self.menuUI, "btnHome")
	self.imgHelp = findTF(self.menuUI, "imgHelp")

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
		self._event:emit(PipeGameEvent.CLOSE_GAME)

		return
	end, SFX_CANCEL)
	onButton(self._event, findTF(self.menuUI, "btnRule"), function()
		self._event:emit(PipeGameEvent.SHOW_RULE, true)
		setActive(self.imgHelp, true)

		return
	end, SFX_CANCEL)
	onButton(self._event, self.imgHelp, function()
		self._event:emit(PipeGameEvent.SHOW_RULE, false)
		setActive(self.imgHelp, false)

		return
	end, SFX_CANCEL)

	self.btnStart = findTF(self.menuUI, "btnStart")

	onButton(self._event, self.btnStart, function()
		self._event:emit(PipeGameEvent.READY_START)

		return
	end, SFX_CANCEL)
	onButton(self._event, self.btnRank, function()
		self._event:emit(PipeGameEvent.SHOW_RANK)

		return
	end, SFX_CANCEL)
	onButton(self._event, self.btnHome, function()
		self._event:emit(PipeGameEvent.ON_HOME)

		return
	end, SFX_CANCEL)

	local var_1_0 = findTF(self.menuUI, "tplBattleItem")

	for iter_1_0 = 1, 7 do
		local var_1_2 = tf(instantiate(var_1_0))

		var_1_2.name = "battleItem_" .. iter_1_0

		setParent(var_1_2, findTF(self.menuUI, "battList/Viewport/Content"))

		local var_1_4 = findTF(var_1_2, "icon")
		local var_1_5 = {
			type = var_0_1.drop[iter_1_0][1],
			id = var_0_1.drop[iter_1_0][2],
			amount = var_0_1.drop[iter_1_0][3]
		}

		updateDrop(var_1_4, var_1_5)
		onButton(self._event, var_1_4, function()
			self._event:emit(BaseUI.ON_DROP, var_1_5)

			return
		end, SFX_PANEL)
		table.insert(self.dropItems, var_1_4)
		setActive(var_1_2, true)
		table.insert(self.battleItems, var_1_2)

		local var_1_6 = var_0_1.GetGameUseTimes()
		local var_1_7 = var_0_1.GetGameTimes()
	end

	return
end

function PipeGameMenuUI:show(arg_11_1)
	setActive(self.menuUI, arg_11_1)

	return
end

function PipeGameMenuUI:setGameRoomUI(arg_12_1)
	if arg_12_1 then
		setActive(findTF(self.menuUI, "lastTimes"), false)
		setActive(findTF(self.menuUI, "btnRank"), false)
	end

	return
end

function PipeGameMenuUI:update(arg_13_1)
	self.mgHubData = arg_13_1

	local var_13_0 = self:getGameUsedTimes(arg_13_1)
	local var_13_1 = self:getGameTimes(arg_13_1)

	setText(self.textLastTimes, var_13_1)

	for iter_13_0 = 1, 7 do
		setActive(findTF(self.battleItems[iter_13_0], "state_open"), false)
		setActive(findTF(self.battleItems[iter_13_0], "state_closed"), false)
		setActive(findTF(self.battleItems[iter_13_0], "state_clear"), false)
		setActive(findTF(self.battleItems[iter_13_0], "state_current"), false)

		if iter_13_0 <= var_13_0 then
			SetParent(self.dropItems[iter_13_0], findTF(self.battleItems[iter_13_0], "state_clear/icon"))
			setActive(self.dropItems[iter_13_0], true)
			setActive(findTF(self.battleItems[iter_13_0], "state_clear"), true)
		elseif iter_13_0 == var_13_0 + 1 and var_13_1 >= 1 then
			setActive(findTF(self.battleItems[iter_13_0], "state_current"), true)
			SetParent(self.dropItems[iter_13_0], findTF(self.battleItems[iter_13_0], "state_current/icon"))
			setActive(self.dropItems[iter_13_0], true)
		elseif var_13_0 < iter_13_0 and iter_13_0 <= var_13_0 + var_13_1 then
			setActive(findTF(self.battleItems[iter_13_0], "state_open"), true)
			SetParent(self.dropItems[iter_13_0], findTF(self.battleItems[iter_13_0], "state_open/icon"))
			setActive(self.dropItems[iter_13_0], true)
		else
			setActive(findTF(self.battleItems[iter_13_0], "state_closed"), true)
			SetParent(self.dropItems[iter_13_0], findTF(self.battleItems[iter_13_0], "state_closed/icon"))
			setActive(self.dropItems[iter_13_0], true)
		end
	end

	scrollTo(self.battleScrollRect, 0, (1 - (var_13_0 - 3 < 0 and 0 or var_13_0 - 3) / (self.totalTimes - 4) > 1 or nil) and 1)

	return
end

function PipeGameMenuUI:CheckGet()
	setActive(findTF(self.menuUI, "got"), false)

	local var_14_0 = self:getUltimate(self.mgHubData)

	if var_14_0 and var_14_0 ~= 0 then
		setActive(findTF(self.menuUI, "got"), true)
	end

	if var_14_0 == 0 then
		if var_0_1.total_times > self:getGameUsedTimes(self.mgHubData) then
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

function PipeGameMenuUI:getGameTimes(arg_15_1)
	return arg_15_1.count
end

function PipeGameMenuUI:getGameUsedTimes(arg_16_1)
	return arg_16_1.usedtime
end

function PipeGameMenuUI:getUltimate(arg_17_1)
	return arg_17_1.ultimate
end

return PipeGameMenuUI
