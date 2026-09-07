local CastleGameMenuUI = class("CastleGameMenuUI")

function CastleGameMenuUI:Ctor(arg_1_1, arg_1_2)
	self._tf = arg_1_1
	self._event = arg_1_2
	self.menuUI = findTF(self._tf, "ui/menuUI")
	self.battleScrollRect = GetComponent(findTF(self.menuUI, "battList"), typeof(ScrollRect))
	self.totalTimes = CastleGameVo.total_times
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
		self._event:emit(BeachGuardGameView.CLOSE_GAME)

		return
	end, SFX_CANCEL)
	onButton(self._event, findTF(self.menuUI, "btnRule"), function()
		self._event:emit(BeachGuardGameView.SHOW_RULE)

		return
	end, SFX_CANCEL)
	onButton(self._event, findTF(self.menuUI, "btnStart"), function()
		self._event:emit(BeachGuardGameView.READY_START)

		return
	end, SFX_CANCEL)

	local var_1_0 = findTF(self.menuUI, "tplBattleItem")

	for iter_1_0 = 1, 7 do
		local var_1_1 = tf(instantiate(var_1_0))

		var_1_1.name = "battleItem_" .. iter_1_0

		setParent(var_1_1, findTF(self.menuUI, "battList/Viewport/Content"))
		GetSpriteFromAtlasAsync(CastleGameVo.ui_atlas, "battleDesc" .. iter_1_0, function(arg_7_0)
			if arg_7_0 then
				setImageSprite(findTF(var_1_1, "state_open/desc"), arg_7_0, true)
				setImageSprite(findTF(var_1_1, "state_clear/desc"), arg_7_0, true)
				setImageSprite(findTF(var_1_1, "state_current/desc"), arg_7_0, true)
				setImageSprite(findTF(var_1_1, "state_closed/desc"), arg_7_0, true)
			end

			return
		end)

		local var_1_2 = findTF(var_1_1, "icon")
		local var_1_3 = {
			type = CastleGameVo.drop[iter_1_0][1],
			id = CastleGameVo.drop[iter_1_0][2],
			amount = CastleGameVo.drop[iter_1_0][3]
		}

		updateDrop(var_1_2, var_1_3)
		onButton(self._event, var_1_2, function()
			self._event:emit(BaseUI.ON_DROP, var_1_3)

			return
		end, SFX_PANEL)
		table.insert(self.dropItems, var_1_2)
		setActive(var_1_1, true)
		table.insert(self.battleItems, var_1_1)
	end

	return
end

function CastleGameMenuUI:show(arg_9_1)
	setActive(self.menuUI, arg_9_1)

	return
end

function CastleGameMenuUI:update(arg_10_1)
	local var_10_0 = self:getGameUsedTimes(arg_10_1)
	local var_10_1 = self:getGameTimes(arg_10_1)

	for iter_10_0 = 1, #self.battleItems do
		setActive(findTF(self.battleItems[iter_10_0], "state_open"), false)
		setActive(findTF(self.battleItems[iter_10_0], "state_closed"), false)
		setActive(findTF(self.battleItems[iter_10_0], "state_clear"), false)
		setActive(findTF(self.battleItems[iter_10_0], "state_current"), false)

		if iter_10_0 <= var_10_0 then
			SetParent(self.dropItems[iter_10_0], findTF(self.battleItems[iter_10_0], "state_clear/icon"))
			setActive(self.dropItems[iter_10_0], true)
			setActive(findTF(self.battleItems[iter_10_0], "state_clear"), true)
		elseif iter_10_0 == var_10_0 + 1 and var_10_1 >= 1 then
			setActive(findTF(self.battleItems[iter_10_0], "state_current"), true)
			SetParent(self.dropItems[iter_10_0], findTF(self.battleItems[iter_10_0], "state_current/icon"))
			setActive(self.dropItems[iter_10_0], true)
		elseif var_10_0 < iter_10_0 and iter_10_0 <= var_10_0 + var_10_1 then
			setActive(findTF(self.battleItems[iter_10_0], "state_open"), true)
			SetParent(self.dropItems[iter_10_0], findTF(self.battleItems[iter_10_0], "state_open/icon"))
			setActive(self.dropItems[iter_10_0], true)
		else
			setActive(findTF(self.battleItems[iter_10_0], "state_closed"), true)
			SetParent(self.dropItems[iter_10_0], findTF(self.battleItems[iter_10_0], "state_closed/icon"))
			setActive(self.dropItems[iter_10_0], true)
		end
	end

	scrollTo(self.battleScrollRect, 0, (1 - (var_10_0 - 3 < 0 and 0 or var_10_0 - 3) / (self.totalTimes - 4) > 1 or nil) and 1)
	setActive(findTF(self.menuUI, "btnStart/tip"), var_10_1 > 0)
	self:CheckGet(arg_10_1)

	return
end

function CastleGameMenuUI:CheckGet(arg_11_1)
	setActive(findTF(self.menuUI, "got"), false)

	local var_11_0 = self:getUltimate(arg_11_1)

	if var_11_0 and var_11_0 ~= 0 then
		setActive(findTF(self.menuUI, "got"), true)
	end

	if var_11_0 == 0 then
		if CastleGameVo.total_times > self:getGameUsedTimes(arg_11_1) then
			return
		end

		pg.m02:sendNotification(GAME.SEND_MINI_GAME_OP, {
			hubid = arg_11_1.id,
			cmd = MiniGameOPCommand.CMD_ULTIMATE,
			args1 = {}
		})
		setActive(findTF(self.menuUI, "got"), true)
	end

	return
end

function CastleGameMenuUI:getGameTimes(arg_12_1)
	return arg_12_1.count
end

function CastleGameMenuUI:getGameUsedTimes(arg_13_1)
	return arg_13_1.usedtime
end

function CastleGameMenuUI:getUltimate(arg_14_1)
	return arg_14_1.ultimate
end

return CastleGameMenuUI
