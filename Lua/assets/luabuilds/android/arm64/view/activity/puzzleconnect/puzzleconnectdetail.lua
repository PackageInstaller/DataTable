local var_0_0 = class("PuzzleConnectDetail")

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0._tf = arg_1_1
	arg_1_0._event = arg_1_2
	arg_1_0._leftIcon1 = findTF(arg_1_0._tf, "ad/leftIcon1/mask/img")
	arg_1_0._leftIcon2 = findTF(arg_1_0._tf, "ad/leftIcon2/mask/img")
	arg_1_0._playerDesc = findTF(arg_1_0._tf, "ad/playerDesc")
	arg_1_0._progressTitle = findTF(arg_1_0._tf, "ad/progressTitle")
	arg_1_0._chatText = findTF(arg_1_0._tf, "ad/chat/text")
	arg_1_0._btnGo = findTF(arg_1_0._tf, "ad/btnGo")
	arg_1_0._btnGoText = findTF(arg_1_0._tf, "ad/btnGo/text")

	onButton(arg_1_0._event, arg_1_0._btnGo, function()
		arg_1_0._stateType = PuzzleConnectMediator.GetPuzzleActivityState(arg_1_0._configData.id, arg_1_0._activity)

		if arg_1_0._stateType == PuzzleConnectMediator.state_collection then
			pg.m02:sendNotification(GAME.GO_SCENE, SCENE.LEVEL)
		elseif arg_1_0._stateType == PuzzleConnectMediator.state_puzzle then
			arg_1_0._event:emit(PuzzleConnectLayer.OPEN_GAME, arg_1_0._data)
		elseif arg_1_0._stateType == PuzzleConnectMediator.state_connection then
			arg_1_0._event:emit(PuzzleConnectLayer.OPEN_GAME, arg_1_0._data)
		end

		return
	end, SFX_CONFIRM)
	onButton(arg_1_0._event, findTF(arg_1_0._tf, "ad/btnClose"), function()
		arg_1_0._event:emit(PuzzleConnectLayer.OPEN_MENU)

		return
	end, SFX_CONFIRM)
	onButton(arg_1_0._event, findTF(arg_1_0._tf, "bottom"), function()
		arg_1_0._event:emit(PuzzleConnectLayer.OPEN_MENU)

		return
	end, SFX_CONFIRM)

	arg_1_0._timer = Timer.New(function()
		arg_1_0._chatIndex = arg_1_0._chatIndex + 1

		if arg_1_0._chatIndex > arg_1_0._chatLengh then
			arg_1_0._timer:Stop()

			return
		end

		setText(arg_1_0._chatText, (utf8.sub(arg_1_0._chatStr, 1, arg_1_0._chatIndex)))

		return
	end, 0.1, -1)

	setText(findTF(arg_1_0._tf, "ad/title/text"), i18n("tolovegame_puzzle_title_desc"))

	return
end

function var_0_0.startChat(arg_6_0)
	arg_6_0._chatIndex = 1

	arg_6_0._timer:Start()

	return
end

function var_0_0.show(arg_7_0)
	setActive(arg_7_0._tf, true)

	return
end

function var_0_0.hide(arg_8_0)
	arg_8_0._timer:Stop()
	setActive(arg_8_0._tf, false)

	return
end

function var_0_0.setData(arg_9_0, arg_9_1)
	arg_9_0._data = arg_9_1
	arg_9_0._configData = arg_9_1.data
	arg_9_0._index = arg_9_1.index
	arg_9_0._chatStr = arg_9_0._configData.desc_bubble
	arg_9_0._chatLengh = utf8.len(arg_9_0._chatStr)
	arg_9_0._stepDescList = arg_9_0._configData.desc_step

	arg_9_0:updateUI()
	arg_9_0:startChat()

	return
end

function var_0_0.setActivity(arg_10_0, arg_10_1)
	arg_10_0._activity = arg_10_1

	if not arg_10_0._configData then
		return
	end

	arg_10_0._stateType = PuzzleConnectMediator.GetPuzzleActivityState(arg_10_0._configData.id, arg_10_0._activity)

	setActive(arg_10_0._btnGo, true)

	local var_10_0 = arg_10_0._configData.need[3]
	local var_10_1 = 0

	if arg_10_0._stateType == PuzzleConnectMediator.state_collection then
		setText(arg_10_0._btnGoText, i18n("tolovegame_puzzle_detail_collect"))

		var_10_0 = getProxy(PlayerProxy):getData():getResource(pg.activity_tolove_jigsaw[arg_10_0._configData.id].need[2])
		var_10_1 = 0
	elseif arg_10_0._stateType == PuzzleConnectMediator.state_puzzle then
		setText(arg_10_0._btnGoText, i18n("tolovegame_puzzle_detail_puzzle"))

		var_10_1 = 2
	elseif arg_10_0._stateType == PuzzleConnectMediator.state_connection then
		setText(arg_10_0._btnGoText, i18n("tolovegame_puzzle_detail_connection"))

		var_10_1 = 3
	elseif arg_10_0._stateType == PuzzleConnectMediator.state_complete then
		setActive(arg_10_0._btnGo, false)

		var_10_1 = 4
	end

	for iter_10_0 = 1, #arg_10_0._stepDescList do
		local var_10_2 = findTF(arg_10_0._tf, "ad/list/text_" .. iter_10_0)

		setText(var_10_2, arg_10_0:replaceStr(arg_10_0._stepDescList[iter_10_0], arg_10_0._configData.need[3], var_10_0, arg_10_0._configData.need[3]))

		GetComponent(var_10_2, "RichText").color = iter_10_0 <= var_10_1 and Color.New(0.49, 0.5, 0.53, 1) or Color.New(0.18, 0.16, 0.18, 1)

		if iter_10_0 > 2 and iter_10_0 > var_10_1 + 1 then
			setActive(var_10_2, false)
		else
			setActive(var_10_2, true)
		end
	end

	return
end

function var_0_0.updateUI(arg_11_0)
	LoadImageSpriteAsync("SquareIcon/" .. arg_11_0._configData.portrait_up, arg_11_0._leftIcon1)
	LoadImageSpriteAsync("SquareIcon/" .. arg_11_0._configData.portrait_down, arg_11_0._leftIcon2)
	setText(findTF(arg_11_0._tf, "ad/player"), i18n("tolovegame_puzzle_ship_need", pg.ship_data_statistics[arg_11_0._configData.ship_id].name))
	setText(arg_11_0._playerDesc, arg_11_0._configData.desc_demand)
	setText(arg_11_0._progressTitle, i18n("tolovegame_puzzle_task_need"))
	setText(arg_11_0._chatText, arg_11_0._configData.desc_bubble)

	return
end

function var_0_0.replaceStr(arg_12_0, arg_12_1, ...)
	if arg_12_1 then
		for iter_12_0, iter_12_1 in ipairs({
			...
		}) do
			arg_12_1 = string.gsub(arg_12_1, "$" .. iter_12_0, iter_12_1)
		end

		return arg_12_1
	end

	return arg_12_1
end

function var_0_0.dispose(arg_13_0)
	if arg_13_0._timer and arg_13_0._timer.running then
		arg_13_0._timer:Stop()

		arg_13_0._timer = nil
	end

	return
end

return var_0_0
