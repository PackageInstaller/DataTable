local var_0_0 = class("MusicBeatGameMenuUI")

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	arg_1_0._tf = arg_1_1
	arg_1_0._event = arg_1_2
	arg_1_0._gameVo = arg_1_3
	arg_1_0.menuUI = findTF(arg_1_0._tf, "ui/menuUI")
	arg_1_0.battleScrollRect = GetComponent(findTF(arg_1_0.menuUI, "battList"), typeof(ScrollRect))
	arg_1_0.totalTimes = arg_1_0._gameVo.totalTimes
	arg_1_0.battleItems = {}
	arg_1_0.dropItems = {}
	arg_1_0.textLastTimes = findTF(arg_1_0.menuUI, "lastTimes/desc")
	arg_1_0.btnRank = findTF(arg_1_0.menuUI, "btnRank")
	arg_1_0.btnHome = findTF(arg_1_0.menuUI, "btnHome")

	GetComponent(arg_1_0.btnRank, typeof(Image)):SetNativeSize()

	arg_1_0.imgHelp = findTF(arg_1_0.menuUI, "imgHelp")
	arg_1_0.highScore = findTF(arg_1_0.menuUI, "highScore/text")

	setActive(arg_1_0.imgHelp, false)
	onButton(arg_1_0._event, findTF(arg_1_0.menuUI, "rightPanelBg/arrowUp"), function()
		local var_2_0 = arg_1_0.battleScrollRect.normalizedPosition.y + 1 / (arg_1_0.totalTimes - 4)

		if arg_1_0.battleScrollRect.normalizedPosition.y + 1 / (arg_1_0.totalTimes - 4) > 1 then
			var_2_0 = 1
		end

		scrollTo(arg_1_0.battleScrollRect, 0, var_2_0)

		return
	end, SFX_CANCEL)
	onButton(arg_1_0._event, findTF(arg_1_0.menuUI, "rightPanelBg/arrowDown"), function()
		local var_3_0 = arg_1_0.battleScrollRect.normalizedPosition.y - 1 / (arg_1_0.totalTimes - 4)

		if arg_1_0.battleScrollRect.normalizedPosition.y - 1 / (arg_1_0.totalTimes - 4) < 0 then
			var_3_0 = 0
		end

		scrollTo(arg_1_0.battleScrollRect, 0, var_3_0)

		return
	end, SFX_CANCEL)
	onButton(arg_1_0._event, findTF(arg_1_0.menuUI, "btnBack"), function()
		arg_1_0._event:emit(MusicBeatGameEvent.CLOSE_GAME)

		return
	end, SFX_CANCEL)
	onButton(arg_1_0._event, findTF(arg_1_0.menuUI, "btnRule"), function()
		arg_1_0._event:emit(MusicBeatGameEvent.SHOW_RULE, true)

		return
	end, SFX_CANCEL)
	onButton(arg_1_0._event, arg_1_0.imgHelp, function()
		arg_1_0._event:emit(MusicBeatGameEvent.SHOW_RULE, false)

		return
	end, SFX_CANCEL)

	arg_1_0.btnStart = findTF(arg_1_0.menuUI, "btnStart")

	onButton(arg_1_0._event, arg_1_0.btnStart, function()
		arg_1_0._event:emit(MusicBeatGameEvent.READY_START)

		return
	end, SFX_CANCEL)
	onButton(arg_1_0._event, arg_1_0.btnRank, function()
		arg_1_0._event:emit(MusicBeatGameEvent.SHOW_RANK)

		return
	end, SFX_CANCEL)
	onButton(arg_1_0._event, arg_1_0.btnHome, function()
		arg_1_0._event:emit(MusicBeatGameEvent.ON_HOME)

		return
	end, SFX_CANCEL)

	local var_1_0 = findTF(arg_1_0.menuUI, "tplBattleItem")

	for iter_1_0 = 1, 7 do
		local var_1_2 = tf(instantiate(var_1_0))

		var_1_2.name = "battleItem_" .. iter_1_0

		setParent(var_1_2, findTF(arg_1_0.menuUI, "battList/Viewport/Content"))

		local var_1_4 = findTF(var_1_2, "icon")

		updateDrop(var_1_4, {
			type = arg_1_0._gameVo.drop[iter_1_0][1],
			id = arg_1_0._gameVo.drop[iter_1_0][2],
			count = arg_1_0._gameVo.drop[iter_1_0][3]
		})
		onButton(arg_1_0._event, var_1_4, function()
			arg_1_0._event:emit(BaseUI.ON_DROP, var_0)

			return
		end, SFX_PANEL)
		table.insert(arg_1_0.dropItems, var_1_4)
		setActive(var_1_2, true)
		table.insert(arg_1_0.battleItems, var_1_2)

		local var_1_5 = arg_1_0._gameVo:getGameUseTimes()
		local var_1_6 = arg_1_0._gameVo:getGameTimes()
	end

	setText(findTF(arg_1_0.menuUI, "btnRule/text"), i18n("beat_game_rule"))
	setText(findTF(arg_1_0.menuUI, "btnStart/text"), i18n("beat_game_start"))
	setText(findTF(arg_1_0.menuUI, "btnRank/text"), i18n("beat_game_rank"))

	return
end

function var_0_0.show(arg_11_0, arg_11_1)
	setActive(arg_11_0.menuUI, arg_11_1)

	return
end

function var_0_0.setGameRoomUI(arg_12_0, arg_12_1)
	if arg_12_1 then
		setActive(findTF(arg_12_0.menuUI, "lastTimes"), false)
		setActive(findTF(arg_12_0.menuUI, "btnRank"), false)
	end

	return
end

function var_0_0.update(arg_13_0, arg_13_1)
	arg_13_0.mgHubData = arg_13_1

	local var_13_0 = arg_13_0:getGameUsedTimes(arg_13_1)
	local var_13_1 = arg_13_0:getGameTimes(arg_13_1)

	setText(arg_13_0.textLastTimes, var_13_1)

	for iter_13_0 = 1, 7 do
		setActive(findTF(arg_13_0.battleItems[iter_13_0], "lock"), false)
		setActive(findTF(arg_13_0.battleItems[iter_13_0], "clear"), false)

		if iter_13_0 <= var_13_0 then
			setActive(findTF(arg_13_0.battleItems[iter_13_0], "clear"), true)
		elseif iter_13_0 == var_13_0 + 1 and var_13_1 >= 1 then
			-- block empty
		elseif var_13_0 < iter_13_0 and iter_13_0 <= var_13_0 + var_13_1 then
			-- block empty
		else
			setActive(findTF(arg_13_0.battleItems[iter_13_0], "lock"), true)
		end
	end

	local var_13_2 = 1 - (var_13_0 - 3 < 0 and 0 or var_13_0 - 3) / (arg_13_0.totalTimes - 4)

	if 1 - (var_13_0 - 3 < 0 and 0 or var_13_0 - 3) / (arg_13_0.totalTimes - 4) > 1 then
		var_13_2 = 1
	end

	scrollTo(arg_13_0.battleScrollRect, 0, var_13_2)

	local var_13_3 = getProxy(MiniGameProxy):GetHighScore(arg_13_0._gameVo.gameId)

	if var_13_3 and #var_13_3 > 0 then
		local var_13_4 = var_13_3[1] or 0

		setText(arg_13_0.highScore, var_13_4)

		return
	end
end

function var_0_0.CheckGet(arg_14_0)
	local var_14_0 = arg_14_0:getUltimate(arg_14_0.mgHubData)

	setActive(findTF(arg_14_0.menuUI, "got"), false)

	if not var_14_0 then
		return
	end

	if var_14_0 ~= 0 then
		setActive(findTF(arg_14_0.menuUI, "got"), true)
	elseif var_14_0 == 0 and arg_14_0._gameVo.totalTimes <= arg_14_0:getGameUsedTimes(arg_14_0.mgHubData) then
		pg.m02:sendNotification(GAME.SEND_MINI_GAME_OP, {
			hubid = arg_14_0.mgHubData.id,
			cmd = MiniGameOPCommand.CMD_ULTIMATE,
			args1 = {}
		})
		setActive(findTF(arg_14_0.menuUI, "got"), true)
	end

	return
end

function var_0_0.showRankUI(arg_15_0)
	triggerButton(arg_15_0.btnRank)

	return
end

function var_0_0.getGameTimes(arg_16_0, arg_16_1)
	return arg_16_1.count
end

function var_0_0.getGameUsedTimes(arg_17_0, arg_17_1)
	return arg_17_1.usedtime
end

function var_0_0.getUltimate(arg_18_0, arg_18_1)
	return arg_18_1.ultimate
end

return var_0_0
