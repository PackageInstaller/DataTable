local var_0_0 = class("BoatAdGameMenuUI")
local var_0_1

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0._tf = arg_1_1
	var_0_1 = BoatAdGameVo
	arg_1_0._event = arg_1_2
	arg_1_0.menuUI = findTF(arg_1_0._tf, "ui/menuUI")
	arg_1_0.battleScrollRect = GetComponent(findTF(arg_1_0.menuUI, "battList"), typeof(ScrollRect))
	arg_1_0.totalTimes = var_0_1.total_times
	arg_1_0.battleItems = {}
	arg_1_0.dropItems = {}
	arg_1_0.lastText = findTF(arg_1_0.menuUI, "last/text")

	GetComponent(findTF(arg_1_0.menuUI, "desc"), typeof(Image)):SetNativeSize()
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
		arg_1_0._event:emit(SimpleMGEvent.CLOSE_GAME)

		return
	end, SFX_CANCEL)
	onButton(arg_1_0._event, findTF(arg_1_0.menuUI, "btnRule"), function()
		arg_1_0._event:emit(SimpleMGEvent.SHOW_RULE)

		return
	end, SFX_CANCEL)

	arg_1_0.btnStart = findTF(arg_1_0.menuUI, "btnStart")

	onButton(arg_1_0._event, findTF(arg_1_0.menuUI, "btnStart"), function()
		arg_1_0._event:emit(SimpleMGEvent.READY_START)

		return
	end, SFX_CANCEL)
	onButton(arg_1_0._event, findTF(arg_1_0.menuUI, "btnHome"), function()
		arg_1_0._event:emit(SimpleMGEvent.BACK_HOME)

		return
	end, SFX_CANCEL)

	local var_1_0 = findTF(arg_1_0.menuUI, "tplBattleItem")

	if var_0_1.drop and #var_0_1.drop > 0 then
		for iter_1_0 = 1, 7 do
			local var_1_2 = tf(instantiate(var_1_0))

			var_1_2.name = "battleItem_" .. iter_1_0

			setParent(var_1_2, findTF(arg_1_0.menuUI, "battList/Viewport/Content"))
			GetSpriteFromAtlasAsync(var_0_1.ui_atlas, "battleDesc" .. iter_1_0, function(arg_8_0)
				if arg_8_0 then
					setImageSprite(findTF(var_1_2, "state_open/desc"), arg_8_0, true)
					setImageSprite(findTF(var_1_2, "state_clear/desc"), arg_8_0, true)
					setImageSprite(findTF(var_1_2, "state_current/desc"), arg_8_0, true)
					setImageSprite(findTF(var_1_2, "state_closed/desc"), arg_8_0, true)
				end

				return
			end)

			local var_1_3 = findTF(var_1_2, "icon")

			updateDrop(var_1_3, {
				type = var_0_1.drop[iter_1_0][1],
				id = var_0_1.drop[iter_1_0][2],
				amount = var_0_1.drop[iter_1_0][3]
			})
			onButton(arg_1_0._event, var_1_3, function()
				arg_1_0._event:emit(BaseUI.ON_DROP, var_0)

				return
			end, SFX_PANEL)
			table.insert(arg_1_0.dropItems, var_1_3)
			setActive(var_1_2, true)
			table.insert(arg_1_0.battleItems, var_1_2)
		end
	end

	return
end

function var_0_0.show(arg_10_0, arg_10_1)
	setActive(arg_10_0.menuUI, arg_10_1)

	return
end

function var_0_0.update(arg_11_0, arg_11_1)
	setText(arg_11_0.lastText, var_0_1.GetGameTimes())

	arg_11_0.mgHubData = arg_11_1

	if #arg_11_0.battleItems <= 0 then
		return
	end

	local var_11_0 = arg_11_0:getGameUsedTimes(arg_11_1)
	local var_11_1 = arg_11_0:getGameTimes(arg_11_1)

	for iter_11_0 = 1, #arg_11_0.battleItems do
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
