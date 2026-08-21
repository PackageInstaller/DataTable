local var_0_0 = class("SailBoatGameMenuUI")
local var_0_1

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0._tf = arg_1_1
	var_0_1 = SailBoatGameVo
	arg_1_0._event = arg_1_2
	arg_1_0.menuUI = findTF(arg_1_0._tf, "ui/menuUI")
	arg_1_0.battleScrollRect = GetComponent(findTF(arg_1_0.menuUI, "battList"), typeof(ScrollRect))
	arg_1_0.totalTimes = var_0_1.total_times
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
		arg_1_0._event:emit(SailBoatGameView.CLOSE_GAME)

		return
	end, SFX_CANCEL)
	onButton(arg_1_0._event, findTF(arg_1_0.menuUI, "btnRule"), function()
		arg_1_0._event:emit(SailBoatGameView.SHOW_RULE)

		return
	end, SFX_CANCEL)

	arg_1_0.btnStart = findTF(arg_1_0.menuUI, "btnStart")

	onButton(arg_1_0._event, findTF(arg_1_0.menuUI, "btnStart"), function()
		arg_1_0._event:emit(SailBoatGameView.OPEN_EQUIP_UI)

		return
	end, SFX_CANCEL)

	local var_1_0 = findTF(arg_1_0.menuUI, "tplBattleItem")

	arg_1_0._chapters = {}

	for iter_1_0 = 1, 7 do
		local var_1_2 = tf(instantiate(var_1_0))

		var_1_2.name = "battleItem_" .. iter_1_0

		setParent(var_1_2, findTF(arg_1_0.menuUI, "battList/Viewport/Content"))

		local var_1_3 = iter_1_0
		local var_1_4 = findTF(var_1_2, "icon")

		updateDrop(var_1_4, {
			type = var_0_1.drop[iter_1_0][1],
			id = var_0_1.drop[iter_1_0][2],
			amount = var_0_1.drop[iter_1_0][3]
		})
		onButton(arg_1_0._event, var_1_4, function()
			arg_1_0._event:emit(BaseUI.ON_DROP, var_0)

			return
		end, SFX_PANEL)
		table.insert(arg_1_0.dropItems, var_1_4)
		setActive(var_1_2, true)
		table.insert(arg_1_0.battleItems, var_1_2)

		local var_1_5 = var_0_1.GetGameUseTimes()
		local var_1_6 = var_0_1.GetGameTimes()
		local var_1_7 = findTF(arg_1_0.menuUI, "chapter/" .. iter_1_0 .. "/icon_bg/icon")

		updateDrop(var_1_7, {
			type = var_0_1.drop[iter_1_0][1],
			id = var_0_1.drop[iter_1_0][2],
			amount = var_0_1.drop[iter_1_0][3]
		})
		onButton(arg_1_0._event, var_1_7, function()
			arg_1_0._event:emit(BaseUI.ON_DROP, var_0)

			return
		end, SFX_PANEL)

		local var_1_8 = findTF(arg_1_0.menuUI, "chapter/" .. iter_1_0)

		onButton(arg_1_0._event, var_1_8, function()
			if var_1_5 == 7 and var_1_6 == 0 then
				var_0_1.selectRound = var_1_3

				arg_1_0:update(arg_1_0.mgHubData)
			end

			return
		end, SFX_CONFIRM)
		table.insert(arg_1_0._chapters, var_1_8)
	end

	return
end

function var_0_0.show(arg_10_0, arg_10_1)
	setActive(arg_10_0.menuUI, arg_10_1)

	return
end

function var_0_0.update(arg_11_0, arg_11_1)
	arg_11_0.mgHubData = arg_11_1

	local var_11_0 = arg_11_0:getGameUsedTimes(arg_11_1)
	local var_11_1 = arg_11_0:getGameTimes(arg_11_1)

	for iter_11_0 = 1, 7 do
		setActive(findTF(arg_11_0.battleItems[iter_11_0], "state_open"), false)
		setActive(findTF(arg_11_0.battleItems[iter_11_0], "state_closed"), false)
		setActive(findTF(arg_11_0.battleItems[iter_11_0], "state_clear"), false)
		setActive(findTF(arg_11_0.battleItems[iter_11_0], "state_current"), false)

		if iter_11_0 <= var_11_0 then
			SetParent(arg_11_0.dropItems[iter_11_0], findTF(arg_11_0.battleItems[iter_11_0], "state_clear/icon"))
			setActive(arg_11_0.dropItems[iter_11_0], true)
			setActive(findTF(arg_11_0.battleItems[iter_11_0], "state_clear"), true)
		elseif iter_11_0 == var_11_0 + 1 and var_11_1 >= 1 then
			setActive(findTF(arg_11_0.battleItems[iter_11_0], "state_current"), true)
			SetParent(arg_11_0.dropItems[iter_11_0], findTF(arg_11_0.battleItems[iter_11_0], "state_current/icon"))
			setActive(arg_11_0.dropItems[iter_11_0], true)
		elseif var_11_0 < iter_11_0 and iter_11_0 <= var_11_0 + var_11_1 then
			setActive(findTF(arg_11_0.battleItems[iter_11_0], "state_open"), true)
			SetParent(arg_11_0.dropItems[iter_11_0], findTF(arg_11_0.battleItems[iter_11_0], "state_open/icon"))
			setActive(arg_11_0.dropItems[iter_11_0], true)
		else
			setActive(findTF(arg_11_0.battleItems[iter_11_0], "state_closed"), true)
			SetParent(arg_11_0.dropItems[iter_11_0], findTF(arg_11_0.battleItems[iter_11_0], "state_closed/icon"))
			setActive(arg_11_0.dropItems[iter_11_0], true)
		end

		setActive(findTF(arg_11_0._chapters[iter_11_0], "close"), false)
		setActive(findTF(arg_11_0._chapters[iter_11_0], "got"), false)
		setActive(findTF(arg_11_0._chapters[iter_11_0], "active"), false)
		setActive(findTF(arg_11_0._chapters[iter_11_0], "icon_bg"), false)

		if iter_11_0 <= var_11_0 then
			setActive(findTF(arg_11_0._chapters[iter_11_0], "got"), true)
		elseif iter_11_0 == var_11_0 + 1 and var_11_1 >= 1 then
			setActive(findTF(arg_11_0._chapters[iter_11_0], "active"), true)
			setActive(findTF(arg_11_0._chapters[iter_11_0], "icon_bg"), true)
		elseif var_11_0 < iter_11_0 and iter_11_0 <= var_11_0 + var_11_1 then
			-- block empty
		else
			setActive(findTF(arg_11_0._chapters[iter_11_0], "close"), true)
		end

		if var_0_1.selectRound == iter_11_0 then
			setActive(findTF(arg_11_0._chapters[iter_11_0], "active"), true)
		end
	end

	local var_11_2 = 1 - (var_11_0 - 3 < 0 and 0 or var_11_0 - 3) / (arg_11_0.totalTimes - 4)

	if 1 - (var_11_0 - 3 < 0 and 0 or var_11_0 - 3) / (arg_11_0.totalTimes - 4) > 1 then
		var_11_2 = 1
	end

	scrollTo(arg_11_0.battleScrollRect, 0, var_11_2)

	return
end

function var_0_0.CheckGet(arg_12_0)
	setActive(findTF(arg_12_0.menuUI, "got"), false)

	local var_12_0 = arg_12_0:getUltimate(arg_12_0.mgHubData)

	if var_12_0 and var_12_0 ~= 0 then
		setActive(findTF(arg_12_0.menuUI, "got"), true)
	end

	if var_12_0 == 0 then
		if var_0_1.total_times > arg_12_0:getGameUsedTimes(arg_12_0.mgHubData) then
			return
		end

		pg.m02:sendNotification(GAME.SEND_MINI_GAME_OP, {
			hubid = arg_12_0.mgHubData.id,
			cmd = MiniGameOPCommand.CMD_ULTIMATE,
			args1 = {}
		})
		setActive(findTF(arg_12_0.menuUI, "got"), true)
	end

	return
end

function var_0_0.getGameTimes(arg_13_0, arg_13_1)
	return arg_13_1.count
end

function var_0_0.getGameUsedTimes(arg_14_0, arg_14_1)
	return arg_14_1.usedtime
end

function var_0_0.getUltimate(arg_15_0, arg_15_1)
	return arg_15_1.ultimate
end

return var_0_0
