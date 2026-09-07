local SortGameMenuUI = class("SortGameMenuUI")

function SortGameMenuUI:Ctor(arg_1_1, arg_1_2, arg_1_3)
	self._tf = arg_1_1
	self._event = arg_1_2
	self._gameVo = arg_1_3
	self.totalTimes = self._gameVo:GetTotalTimes()
	self.battleItems = {}

	self:initUI()

	return
end

function SortGameMenuUI:initUI()
	self.menuUI = findTF(self._tf, "ui/menuUI")
	self.highScore = findTF(self.menuUI, "highScore/text")
	self.battleScrollRect = GetComponent(findTF(self.menuUI, "battList"), typeof(ScrollRect))

	onButton(self._event, findTF(self.menuUI, "rightPanelBg/arrowUp"), function()
		scrollTo(self.battleScrollRect, 0, (self.battleScrollRect.normalizedPosition.y + 1 / (self.totalTimes - 4) > 1 or nil) and 1)

		return
	end, SFX_CANCEL)
	onButton(self._event, findTF(self.menuUI, "rightPanelBg/arrowDown"), function()
		scrollTo(self.battleScrollRect, 0, (self.battleScrollRect.normalizedPosition.y - 1 / (self.totalTimes - 4) < 0 or nil) and 0)

		return
	end, SFX_CANCEL)
	onButton(self._event, findTF(self.menuUI, "btnBack"), function()
		self._event:emit(SimpleMGEvent.CLOSE_GAME)

		return
	end, SFX_CANCEL)

	self.btnRule = findTF(self.menuUI, "btnRule")

	onButton(self._event, self.btnRule, function()
		self._event:emit(SimpleMGEvent.SHOW_RULE, true)

		return
	end, SFX_CANCEL)

	self.btnStart = findTF(self.menuUI, "btnStart")

	onButton(self._event, self.btnStart, function()
		self._event:emit(SimpleMGEvent.READY_START)

		return
	end, SFX_CANCEL)

	self.btnRank = findTF(self.menuUI, "btnRank")

	onButton(self._event, self.btnRank, function()
		pg.m02:sendNotification(GAME.SEND_MINI_GAME_OP, {
			hubid = self._gameVo:GetHubId(),
			cmd = MiniGameOPCommand.CMD_SPECIAL_TRACK,
			args1 = {
				self._gameVo:GetGameId(),
				103
			}
		})
		self._event:emit(SimpleMGEvent.SHOW_RANK)

		return
	end, SFX_CANCEL)

	self.btnHome = findTF(self.menuUI, "btnHome")

	onButton(self._event, self.btnHome, function()
		self._event:emit(SimpleMGEvent.ON_HOME)

		return
	end, SFX_CANCEL)

	self._tplBattleItem = findTF(self.menuUI, "battList/Viewport/Content/tplBattleItem")

	setActive(self._tplBattleItem, false)

	local var_2_0 = self._gameVo:GetDrop()

	for iter_2_0 = 1, 7 do
		local var_2_2 = tf(instantiate(self._tplBattleItem))

		var_2_2.name = "battleItem_" .. iter_2_0

		setParent(var_2_2, findTF(self.menuUI, "battList/Viewport/Content"))

		local var_2_3 = findTF(var_2_2, "ad/iconMask/icon")
		local var_2_4 = {
			type = var_2_0[iter_2_0][1],
			id = var_2_0[iter_2_0][2],
			count = var_2_0[iter_2_0][3]
		}

		updateDrop(var_2_3, var_2_4)
		onButton(self._event, var_2_3, function()
			self._event:emit(BaseUI.ON_DROP, var_2_4)

			return
		end, SFX_PANEL)
		setActive(var_2_2, true)
		table.insert(self.battleItems, var_2_2)
	end

	return
end

function SortGameMenuUI:Show(arg_11_1)
	setActive(self.menuUI, arg_11_1)

	return
end

function SortGameMenuUI:SetGameRoomUI(arg_12_1)
	if arg_12_1 then
		setActive(findTF(self.menuUI, "lastTimes"), false)
		setActive(findTF(self.menuUI, "btnRank"), false)
	end

	return
end

function SortGameMenuUI:Update()
	local var_13_0 = self._gameVo:GetGameUseTimes()
	local var_13_1 = self._gameVo:GetGameTimes()

	for iter_13_0 = 1, 7 do
		local var_13_2 = findTF(self.battleItems[iter_13_0], "ad/lock")
		local var_13_3 = findTF(self.battleItems[iter_13_0], "ad/got")

		setActive(var_13_2, false)
		setActive(var_13_3, false)

		if iter_13_0 <= var_13_0 then
			setActive(var_13_3, true)
		elseif iter_13_0 == var_13_0 + 1 and var_13_1 >= 1 then
			-- block empty
		elseif var_13_0 < iter_13_0 and iter_13_0 <= var_13_0 + var_13_1 then
			-- block empty
		else
			setActive(var_13_2, true)
		end
	end

	scrollTo(self.battleScrollRect, 0, (1 - (var_13_0 - 3 < 0 and 0 or var_13_0 - 3) / (self.totalTimes - 4) > 1 or nil) and 1)

	local var_13_5 = getProxy(MiniGameProxy):GetHighScore(self._gameVo:GetGameId())

	if not var_13_5 or #var_13_5 <= 0 or not var_13_5[1] then
		-- block empty
	end

	return
end

function SortGameMenuUI:CheckGet()
	setActive(findTF(self.menuUI, "got"), false)

	local var_14_0 = self._gameVo:GetUltimate()

	if var_14_0 and var_14_0 ~= 0 then
		setActive(findTF(self.menuUI, "got"), true)
	end

	if var_14_0 == 0 then
		if self._gameVo:GetTotalTimes() > self:getGameUsedTimes() then
			return
		end

		pg.m02:sendNotification(GAME.SEND_MINI_GAME_OP, {
			hubid = self._gameVo:GetHubId(),
			cmd = MiniGameOPCommand.CMD_ULTIMATE,
			args1 = {}
		})
		setActive(findTF(self.menuUI, "got"), true)
	end

	return
end

return SortGameMenuUI
