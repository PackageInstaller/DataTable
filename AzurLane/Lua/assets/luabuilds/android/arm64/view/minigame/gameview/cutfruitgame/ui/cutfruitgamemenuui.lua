local var_0_0 = class("CutFruitGameMenuUI")

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	arg_1_0._tf = arg_1_1
	arg_1_0._event = arg_1_2
	arg_1_0._gameVo = arg_1_3
	arg_1_0.totalTimes = arg_1_0._gameVo:GetTotalTimes()
	arg_1_0.battleItems = {}

	arg_1_0:initUI()
	setText(findTF(arg_1_0.btnStart, "text"), i18n("pac_game_start_btn"))
	setText(findTF(arg_1_0.btnRule, "text"), i18n("pac_game_rule_btn"))

	return
end

function var_0_0.initUI(arg_2_0)
	arg_2_0.menuUI = findTF(arg_2_0._tf, "ui/menuUI")
	arg_2_0.highScore = findTF(arg_2_0.menuUI, "highScore/text")
	arg_2_0.battleScrollRect = GetComponent(findTF(arg_2_0.menuUI, "battList"), typeof(ScrollRect))

	onButton(arg_2_0._event, findTF(arg_2_0.menuUI, "rightPanelBg/arrowUp"), function()
		local var_3_0 = arg_2_0.battleScrollRect.normalizedPosition.y + 1 / (arg_2_0.totalTimes - 4)

		if arg_2_0.battleScrollRect.normalizedPosition.y + 1 / (arg_2_0.totalTimes - 4) > 1 then
			var_3_0 = 1
		end

		scrollTo(arg_2_0.battleScrollRect, 0, var_3_0)

		return
	end, SFX_CANCEL)
	onButton(arg_2_0._event, findTF(arg_2_0.menuUI, "rightPanelBg/arrowDown"), function()
		local var_4_0 = arg_2_0.battleScrollRect.normalizedPosition.y - 1 / (arg_2_0.totalTimes - 4)

		if arg_2_0.battleScrollRect.normalizedPosition.y - 1 / (arg_2_0.totalTimes - 4) < 0 then
			var_4_0 = 0
		end

		scrollTo(arg_2_0.battleScrollRect, 0, var_4_0)

		return
	end, SFX_CANCEL)
	onButton(arg_2_0._event, findTF(arg_2_0.menuUI, "btnBack"), function()
		arg_2_0._event:emit(SimpleMGEvent.CLOSE_GAME)

		return
	end, SFX_CANCEL)

	arg_2_0.btnRule = findTF(arg_2_0.menuUI, "btnRule")

	onButton(arg_2_0._event, arg_2_0.btnRule, function()
		arg_2_0._event:emit(SimpleMGEvent.SHOW_RULE, true)

		return
	end, SFX_CANCEL)

	arg_2_0.btnStart = findTF(arg_2_0.menuUI, "btnStart")

	onButton(arg_2_0._event, arg_2_0.btnStart, function()
		arg_2_0._event:emit(SimpleMGEvent.READY_START)

		return
	end, SFX_CANCEL)

	arg_2_0.btnRank = findTF(arg_2_0.menuUI, "btnRank")

	onButton(arg_2_0._event, arg_2_0.btnRank, function()
		pg.m02:sendNotification(GAME.SEND_MINI_GAME_OP, {
			hubid = arg_2_0._gameVo:GetHubId(),
			cmd = MiniGameOPCommand.CMD_SPECIAL_TRACK,
			args1 = {
				arg_2_0._gameVo:GetGameId(),
				103
			}
		})
		arg_2_0._event:emit(SimpleMGEvent.SHOW_RANK)

		return
	end, SFX_CANCEL)

	arg_2_0.btnHome = findTF(arg_2_0.menuUI, "btnHome")

	onButton(arg_2_0._event, arg_2_0.btnHome, function()
		arg_2_0._event:emit(SimpleMGEvent.ON_HOME)

		return
	end, SFX_CANCEL)

	arg_2_0._tplBattleItem = findTF(arg_2_0.menuUI, "battList/Viewport/Content/tplBattleItem")

	setActive(arg_2_0._tplBattleItem, false)

	local var_2_0 = arg_2_0._gameVo:GetDrop()

	for iter_2_0 = 1, 7 do
		local var_2_2 = tf(instantiate(arg_2_0._tplBattleItem))

		var_2_2.name = "battleItem_" .. iter_2_0

		setParent(var_2_2, findTF(arg_2_0.menuUI, "battList/Viewport/Content"))
		setText(findTF(var_2_2, "ad/desc"), i18n("which_day_2", iter_2_0))

		local var_2_3 = findTF(var_2_2, "ad/iconMask/icon")

		updateDrop(var_2_3, {
			type = var_2_0[iter_2_0][1],
			id = var_2_0[iter_2_0][2],
			count = var_2_0[iter_2_0][3]
		})
		onButton(arg_2_0._event, var_2_3, function()
			arg_2_0._event:emit(BaseUI.ON_DROP, var_0)

			return
		end, SFX_PANEL)
		setActive(var_2_2, true)
		table.insert(arg_2_0.battleItems, var_2_2)
	end

	return
end

function var_0_0.Show(arg_11_0, arg_11_1)
	setActive(arg_11_0.menuUI, arg_11_1)

	return
end

function var_0_0.SetGameRoomUI(arg_12_0, arg_12_1)
	if arg_12_1 then
		setActive(findTF(arg_12_0.menuUI, "lastTimes"), false)
		setActive(findTF(arg_12_0.menuUI, "btnRank"), false)
	end

	return
end

function var_0_0.Update(arg_13_0)
	local var_13_0 = arg_13_0._gameVo:GetGameUseTimes()
	local var_13_1 = arg_13_0._gameVo:GetGameTimes()

	for iter_13_0 = 1, 7 do
		local var_13_2 = findTF(arg_13_0.battleItems[iter_13_0], "ad/lock")
		local var_13_3 = findTF(arg_13_0.battleItems[iter_13_0], "ad/got")

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

	local var_13_4 = 1 - (var_13_0 - 3 < 0 and 0 or var_13_0 - 3) / (arg_13_0.totalTimes - 4)

	if 1 - (var_13_0 - 3 < 0 and 0 or var_13_0 - 3) / (arg_13_0.totalTimes - 4) > 1 then
		var_13_4 = 1
	end

	scrollTo(arg_13_0.battleScrollRect, 0, var_13_4)

	local var_13_5 = getProxy(MiniGameProxy):GetHighScore(arg_13_0._gameVo:GetGameId())

	if var_13_5 and #var_13_5 > 0 then
		setText(arg_13_0.highScore, i18n("pac_game_high_score_tip", var_13_6))

		return
	end
end

function var_0_0.CheckGet(arg_14_0)
	setActive(findTF(arg_14_0.menuUI, "got"), false)

	local var_14_0 = arg_14_0._gameVo:GetUltimate()

	if var_14_0 and var_14_0 ~= 0 then
		setActive(findTF(arg_14_0.menuUI, "got"), true)
	end

	if var_14_0 == 0 then
		if arg_14_0._gameVo:GetTotalTimes() > arg_14_0:getGameUsedTimes() then
			return
		end

		pg.m02:sendNotification(GAME.SEND_MINI_GAME_OP, {
			hubid = arg_14_0._gameVo:GetHubId(),
			cmd = MiniGameOPCommand.CMD_ULTIMATE,
			args1 = {}
		})
		setActive(findTF(arg_14_0.menuUI, "got"), true)
	end

	return
end

return var_0_0
