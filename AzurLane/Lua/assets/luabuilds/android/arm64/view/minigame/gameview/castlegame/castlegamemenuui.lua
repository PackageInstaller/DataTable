local var_0_0 = class("CastleGameMenuUI")

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0._tf = arg_1_1
	arg_1_0._event = arg_1_2
	arg_1_0.menuUI = findTF(arg_1_0._tf, "ui/menuUI")
	arg_1_0.battleScrollRect = GetComponent(findTF(arg_1_0.menuUI, "battList"), typeof(ScrollRect))
	arg_1_0.totalTimes = CastleGameVo.total_times
	arg_1_0.battleItems = {}
	arg_1_0.dropItems = {}

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
		arg_1_0._event:emit(BeachGuardGameView.CLOSE_GAME)

		return
	end, SFX_CANCEL)
	onButton(arg_1_0._event, findTF(arg_1_0.menuUI, "btnRule"), function()
		arg_1_0._event:emit(BeachGuardGameView.SHOW_RULE)

		return
	end, SFX_CANCEL)
	onButton(arg_1_0._event, findTF(arg_1_0.menuUI, "btnStart"), function()
		arg_1_0._event:emit(BeachGuardGameView.READY_START)

		return
	end, SFX_CANCEL)

	local var_1_0 = findTF(arg_1_0.menuUI, "tplBattleItem")

	for iter_1_0 = 1, 7 do
		local var_1_1 = tf(instantiate(var_1_0))

		var_1_1.name = "battleItem_" .. iter_1_0

		setParent(var_1_1, findTF(arg_1_0.menuUI, "battList/Viewport/Content"))
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

		updateDrop(var_1_2, {
			type = CastleGameVo.drop[iter_1_0][1],
			id = CastleGameVo.drop[iter_1_0][2],
			amount = CastleGameVo.drop[iter_1_0][3]
		})
		onButton(arg_1_0._event, var_1_2, function()
			arg_1_0._event:emit(BaseUI.ON_DROP, var_0)

			return
		end, SFX_PANEL)
		table.insert(arg_1_0.dropItems, var_1_2)
		setActive(var_1_1, true)
		table.insert(arg_1_0.battleItems, var_1_1)
	end

	return
end

function var_0_0.show(arg_9_0, arg_9_1)
	setActive(arg_9_0.menuUI, arg_9_1)

	return
end

function var_0_0.update(arg_10_0, arg_10_1)
	local var_10_0 = arg_10_0:getGameUsedTimes(arg_10_1)
	local var_10_1 = arg_10_0:getGameTimes(arg_10_1)

	for iter_10_0 = 1, #arg_10_0.battleItems do
		setActive(findTF(arg_10_0.battleItems[iter_10_0], "state_open"), false)
		setActive(findTF(arg_10_0.battleItems[iter_10_0], "state_closed"), false)
		setActive(findTF(arg_10_0.battleItems[iter_10_0], "state_clear"), false)
		setActive(findTF(arg_10_0.battleItems[iter_10_0], "state_current"), false)

		if iter_10_0 <= var_10_0 then
			SetParent(arg_10_0.dropItems[iter_10_0], findTF(arg_10_0.battleItems[iter_10_0], "state_clear/icon"))
			setActive(arg_10_0.dropItems[iter_10_0], true)
			setActive(findTF(arg_10_0.battleItems[iter_10_0], "state_clear"), true)
		elseif iter_10_0 == var_10_0 + 1 and var_10_1 >= 1 then
			setActive(findTF(arg_10_0.battleItems[iter_10_0], "state_current"), true)
			SetParent(arg_10_0.dropItems[iter_10_0], findTF(arg_10_0.battleItems[iter_10_0], "state_current/icon"))
			setActive(arg_10_0.dropItems[iter_10_0], true)
		elseif var_10_0 < iter_10_0 and iter_10_0 <= var_10_0 + var_10_1 then
			setActive(findTF(arg_10_0.battleItems[iter_10_0], "state_open"), true)
			SetParent(arg_10_0.dropItems[iter_10_0], findTF(arg_10_0.battleItems[iter_10_0], "state_open/icon"))
			setActive(arg_10_0.dropItems[iter_10_0], true)
		else
			setActive(findTF(arg_10_0.battleItems[iter_10_0], "state_closed"), true)
			SetParent(arg_10_0.dropItems[iter_10_0], findTF(arg_10_0.battleItems[iter_10_0], "state_closed/icon"))
			setActive(arg_10_0.dropItems[iter_10_0], true)
		end
	end

	local var_10_2 = 1 - (var_10_0 - 3 < 0 and 0 or var_10_0 - 3) / (arg_10_0.totalTimes - 4)

	if 1 - (var_10_0 - 3 < 0 and 0 or var_10_0 - 3) / (arg_10_0.totalTimes - 4) > 1 then
		var_10_2 = 1
	end

	scrollTo(arg_10_0.battleScrollRect, 0, var_10_2)
	setActive(findTF(arg_10_0.menuUI, "btnStart/tip"), var_10_1 > 0)
	arg_10_0:CheckGet(arg_10_1)

	return
end

function var_0_0.CheckGet(arg_11_0, arg_11_1)
	setActive(findTF(arg_11_0.menuUI, "got"), false)

	local var_11_0 = arg_11_0:getUltimate(arg_11_1)

	if var_11_0 and var_11_0 ~= 0 then
		setActive(findTF(arg_11_0.menuUI, "got"), true)
	end

	if var_11_0 == 0 then
		if CastleGameVo.total_times > arg_11_0:getGameUsedTimes(arg_11_1) then
			return
		end

		pg.m02:sendNotification(GAME.SEND_MINI_GAME_OP, {
			hubid = arg_11_1.id,
			cmd = MiniGameOPCommand.CMD_ULTIMATE,
			args1 = {}
		})
		setActive(findTF(arg_11_0.menuUI, "got"), true)
	end

	return
end

function var_0_0.getGameTimes(arg_12_0, arg_12_1)
	return arg_12_1.count
end

function var_0_0.getGameUsedTimes(arg_13_0, arg_13_1)
	return arg_13_1.usedtime
end

function var_0_0.getUltimate(arg_14_0, arg_14_1)
	return arg_14_1.ultimate
end

return var_0_0
