local SailBoatGameMenuUI = class("SailBoatGameMenuUI")
local var_0_1

function SailBoatGameMenuUI:Ctor(arg_1_1, arg_1_2)
	self._tf = arg_1_1
	var_0_1 = SailBoatGameVo
	self._event = arg_1_2
	self.menuUI = findTF(self._tf, "ui/menuUI")
	self.battleScrollRect = GetComponent(findTF(self.menuUI, "battList"), typeof(ScrollRect))
	self.totalTimes = var_0_1.total_times
	self.battleItems = {}
	self.dropItems = {}

	onButton(self._event, findTF(self.menuUI, "rightPanelBg/arrowUp"), function()
		scrollTo(self.battleScrollRect, 0, (self.battleScrollRect.normalizedPosition.y + 1 / (self.totalTimes - 4) > 1 or nil) and 1)

		return
	end, SFX_CANCEL)
	onButton(self._event, findTF(self.menuUI, "rightPanelBg/arrowDown"), function()
		scrollTo(self.battleScrollRect, 0, (self.battleScrollRect.normalizedPosition.y - 1 / (self.totalTimes - 4) < 0 or nil) and 0)

		return
	end, SFX_CANCEL)
	onButton(self._event, findTF(self.menuUI, "btnBack"), function()
		self._event:emit(SailBoatGameView.CLOSE_GAME)

		return
	end, SFX_CANCEL)
	onButton(self._event, findTF(self.menuUI, "btnRule"), function()
		self._event:emit(SailBoatGameView.SHOW_RULE)

		return
	end, SFX_CANCEL)

	self.btnStart = findTF(self.menuUI, "btnStart")

	onButton(self._event, findTF(self.menuUI, "btnStart"), function()
		self._event:emit(SailBoatGameView.OPEN_EQUIP_UI)

		return
	end, SFX_CANCEL)

	local var_1_0 = findTF(self.menuUI, "tplBattleItem")

	self._chapters = {}

	for iter_1_0 = 1, 7 do
		local var_1_2 = tf(instantiate(var_1_0))

		var_1_2.name = "battleItem_" .. iter_1_0

		setParent(var_1_2, findTF(self.menuUI, "battList/Viewport/Content"))

		local var_1_3 = iter_1_0
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
		local var_1_8 = findTF(self.menuUI, "chapter/" .. iter_1_0 .. "/icon_bg/icon")
		local var_1_9 = {
			type = var_0_1.drop[iter_1_0][1],
			id = var_0_1.drop[iter_1_0][2],
			amount = var_0_1.drop[iter_1_0][3]
		}

		updateDrop(var_1_8, var_1_9)
		onButton(self._event, var_1_8, function()
			self._event:emit(BaseUI.ON_DROP, var_1_9)

			return
		end, SFX_PANEL)

		local var_1_10 = findTF(self.menuUI, "chapter/" .. iter_1_0)

		onButton(self._event, var_1_10, function()
			if var_1_6 == 7 and var_1_7 == 0 then
				var_0_1.selectRound = var_1_3

				self:update(self.mgHubData)
			end

			return
		end, SFX_CONFIRM)
		table.insert(self._chapters, var_1_10)
	end

	return
end

function SailBoatGameMenuUI:show(arg_10_1)
	setActive(self.menuUI, arg_10_1)

	return
end

function SailBoatGameMenuUI:update(arg_11_1)
	self.mgHubData = arg_11_1

	local var_11_0 = self:getGameUsedTimes(arg_11_1)
	local var_11_1 = self:getGameTimes(arg_11_1)

	for iter_11_0 = 1, 7 do
		setActive(findTF(self.battleItems[iter_11_0], "state_open"), false)
		setActive(findTF(self.battleItems[iter_11_0], "state_closed"), false)
		setActive(findTF(self.battleItems[iter_11_0], "state_clear"), false)
		setActive(findTF(self.battleItems[iter_11_0], "state_current"), false)

		if iter_11_0 <= var_11_0 then
			SetParent(self.dropItems[iter_11_0], findTF(self.battleItems[iter_11_0], "state_clear/icon"))
			setActive(self.dropItems[iter_11_0], true)
			setActive(findTF(self.battleItems[iter_11_0], "state_clear"), true)
		elseif iter_11_0 == var_11_0 + 1 and var_11_1 >= 1 then
			setActive(findTF(self.battleItems[iter_11_0], "state_current"), true)
			SetParent(self.dropItems[iter_11_0], findTF(self.battleItems[iter_11_0], "state_current/icon"))
			setActive(self.dropItems[iter_11_0], true)
		elseif var_11_0 < iter_11_0 and iter_11_0 <= var_11_0 + var_11_1 then
			setActive(findTF(self.battleItems[iter_11_0], "state_open"), true)
			SetParent(self.dropItems[iter_11_0], findTF(self.battleItems[iter_11_0], "state_open/icon"))
			setActive(self.dropItems[iter_11_0], true)
		else
			setActive(findTF(self.battleItems[iter_11_0], "state_closed"), true)
			SetParent(self.dropItems[iter_11_0], findTF(self.battleItems[iter_11_0], "state_closed/icon"))
			setActive(self.dropItems[iter_11_0], true)
		end

		setActive(findTF(self._chapters[iter_11_0], "close"), false)
		setActive(findTF(self._chapters[iter_11_0], "got"), false)
		setActive(findTF(self._chapters[iter_11_0], "active"), false)
		setActive(findTF(self._chapters[iter_11_0], "icon_bg"), false)

		if iter_11_0 <= var_11_0 then
			setActive(findTF(self._chapters[iter_11_0], "got"), true)
		elseif iter_11_0 == var_11_0 + 1 and var_11_1 >= 1 then
			setActive(findTF(self._chapters[iter_11_0], "active"), true)
			setActive(findTF(self._chapters[iter_11_0], "icon_bg"), true)
		elseif var_11_0 < iter_11_0 and iter_11_0 <= var_11_0 + var_11_1 then
			-- block empty
		else
			setActive(findTF(self._chapters[iter_11_0], "close"), true)
		end

		if var_0_1.selectRound == iter_11_0 then
			setActive(findTF(self._chapters[iter_11_0], "active"), true)
		end
	end

	scrollTo(self.battleScrollRect, 0, (1 - (var_11_0 - 3 < 0 and 0 or var_11_0 - 3) / (self.totalTimes - 4) > 1 or nil) and 1)

	return
end

function SailBoatGameMenuUI:CheckGet()
	setActive(findTF(self.menuUI, "got"), false)

	local var_12_0 = self:getUltimate(self.mgHubData)

	if var_12_0 and var_12_0 ~= 0 then
		setActive(findTF(self.menuUI, "got"), true)
	end

	if var_12_0 == 0 then
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

function SailBoatGameMenuUI:getGameTimes(arg_13_1)
	return arg_13_1.count
end

function SailBoatGameMenuUI:getGameUsedTimes(arg_14_1)
	return arg_14_1.usedtime
end

function SailBoatGameMenuUI:getUltimate(arg_15_1)
	return arg_15_1.ultimate
end

return SailBoatGameMenuUI
