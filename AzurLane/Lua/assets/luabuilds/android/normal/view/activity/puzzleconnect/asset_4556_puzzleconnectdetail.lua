class = var_0_10000

local var_0_0 = var_0_10000("PuzzleConnectDetail")

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0._tf = arg_1_1
	arg_1_0._event = arg_1_2
	findTF = var_1_10003
	arg_1_0._leftIcon1 = var_1_10003(arg_1_0._tf, "ad/leftIcon1/mask/img")
	findTF = var_3
	arg_1_0._leftIcon2 = var_3(arg_1_0._tf, "ad/leftIcon2/mask/img")
	findTF = var_3
	arg_1_0._playerDesc = var_3(arg_1_0._tf, "ad/playerDesc")
	findTF = var_3
	arg_1_0._progressTitle = var_3(arg_1_0._tf, "ad/progressTitle")
	findTF = var_3
	arg_1_0._chatText = var_3(arg_1_0._tf, "ad/chat/text")
	findTF = var_3
	arg_1_0._btnGo = var_3(arg_1_0._tf, "ad/btnGo")
	findTF = var_3
	arg_1_0._btnGoText = var_3(arg_1_0._tf, "ad/btnGo/text")
	onButton = var_3

	local var_1_0 = arg_1_0._event
	local var_1_1 = arg_1_0._btnGo

	local function var_1_2()
		local var_2_0 = arg_1_0

		PuzzleConnectMediator = var_2_10001
		var_2_0._stateType = var_2_10001.GetPuzzleActivityState(arg_1_0._configData.id, arg_1_0._activity)

		local var_2_1 = arg_1_0._stateType

		PuzzleConnectMediator = var_1

		local var_2_2, var_2_4

		if var_2_1 == var_1.state_collection then
			pg = var_2_1
			var_2_2 = var_2_1.m02

			local var_2_3 = var_0.sendNotification

			GAME = var_2_4
			var_2_4 = var_2_4.GO_SCENE
			SCENE = var_3

			var_2_3(var_2_2, var_2_4, var_3.LEVEL)
		else
			local var_2_5 = arg_1_0._stateType

			PuzzleConnectMediator = var_2_2

			local var_2_6

			if var_2_5 == var_2_2.state_puzzle then
				var_2_6 = arg_1_0._event

				local var_2_7 = var_0.emit

				PuzzleConnectLayer = var_2_4

				var_2_7(var_2_6, var_2_4.OPEN_GAME, arg_1_0._data)
			else
				local var_2_8 = arg_1_0._stateType

				PuzzleConnectMediator = var_2_6

				if var_2_8 == var_2_6.state_connection then
					local var_2_9 = arg_1_0._event
					local var_2_10 = var_0.emit

					PuzzleConnectLayer = var_2_4

					var_2_10(var_2_9, var_2_4.OPEN_GAME, arg_1_0._data)
				end
			end
		end

		return
	end

	SFX_CONFIRM = var_1_10007

	var_3(var_1_0, var_1_1, var_1_2, var_1_10007)

	onButton = var_3

	local var_1_3 = arg_1_0._event

	findTF = var_1_1

	local var_1_4 = var_1_1(arg_1_0._tf, "ad/btnClose")

	local function var_1_5()
		local var_3_0 = arg_1_0._event
		local var_3_1 = var_0.emit

		PuzzleConnectLayer = var_2_10002

		var_3_1(var_3_0, var_2_10002.OPEN_MENU)

		return
	end

	SFX_CONFIRM = var_7

	var_3(var_1_3, var_1_4, var_1_5, var_7)

	onButton = var_3

	local var_1_6 = arg_1_0._event

	findTF = var_1_4

	local var_1_7 = var_1_4(arg_1_0._tf, "bottom")

	local function var_1_8()
		local var_4_0 = arg_1_0._event
		local var_4_1 = var_0.emit

		PuzzleConnectLayer = var_2_10002

		var_4_1(var_4_0, var_2_10002.OPEN_MENU)

		return
	end

	SFX_CONFIRM = var_7

	var_3(var_1_6, var_1_7, var_1_8, var_7)

	Timer = var_3
	arg_1_0._timer = var_3.New(function()
		arg_1_0._chatIndex = arg_1_0._chatIndex + 1

		if arg_1_0._chatIndex > arg_1_0._chatLengh then
			local var_5_0 = arg_1_0._timer

			var_0.Stop(var_5_0)

			return
		end

		utf8 = var_0

		local var_5_1 = var_0.sub(arg_1_0._chatStr, 1, arg_1_0._chatIndex)

		setText = var_1

		var_1(arg_1_0._chatText, var_5_1)

		return
	end, 0.1, -1)
	setText = var_3
	findTF = var_4

	local var_1_9 = var_4(arg_1_0._tf, "ad/title/text")

	i18n = var_5

	var_3(var_1_9, var_5("tolovegame_puzzle_title_desc"))

	return
end

function var_0_0.startChat(arg_6_0)
	arg_6_0._chatIndex = 1

	local var_6_0 = arg_6_0._timer

	var_1.Start(var_6_0)

	return
end

function var_0_0.show(arg_7_0)
	setActive = var_1_10001

	var_1_10001(arg_7_0._tf, true)

	return
end

function var_0_0.hide(arg_8_0)
	local var_8_0 = arg_8_0._timer

	var_1.Stop(var_8_0)

	setActive = var_1

	var_1(arg_8_0._tf, false)

	return
end

function var_0_0.setData(arg_9_0, arg_9_1)
	arg_9_0._data = arg_9_1
	arg_9_0._configData = arg_9_1.data
	arg_9_0._index = arg_9_1.index
	arg_9_0._chatStr = arg_9_0._configData.desc_bubble
	utf8 = var_2
	arg_9_0._chatLengh = var_2.len(arg_9_0._chatStr)
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

	PuzzleConnectMediator = var_2
	arg_10_0._stateType = var_2.GetPuzzleActivityState(arg_10_0._configData.id, arg_10_0._activity)
	setActive = var_2

	var_2(arg_10_0._btnGo, true)

	local var_10_0 = arg_10_0._configData.need[3]
	local var_10_1 = 0
	local var_10_2 = arg_10_0._stateType

	PuzzleConnectMediator = var_1_10005

	local var_10_3

	if var_10_2 == var_1_10005.state_collection then
		setText = var_10_2
		var_10_3 = arg_10_0._btnGoText
		i18n = var_1_10006

		var_10_2(var_10_3, var_1_10006("tolovegame_puzzle_detail_collect"))

		pg = var_10_2

		local var_10_4 = var_10_2.activity_tolove_jigsaw[arg_10_0._configData.id].need[2]

		getProxy = var_10_3
		PlayerProxy = var_1_10006
		var_1_10006 = var_10_3(var_1_10006)
		var_1_10006 = var_10_3.getData(var_1_10006)
		var_10_0 = var_10_3.getResource(var_1_10006, var_10_4)
		var_10_1 = 0
	else
		local var_10_5 = arg_10_0._stateType

		PuzzleConnectMediator = var_10_3

		local var_10_6

		if var_10_5 == var_10_3.state_puzzle then
			setText = var_10_5
			var_10_6 = arg_10_0._btnGoText
			i18n = var_1_10006

			var_10_5(var_10_6, var_1_10006("tolovegame_puzzle_detail_puzzle"))

			var_10_1 = 2
		else
			local var_10_7 = arg_10_0._stateType

			PuzzleConnectMediator = var_10_6

			local var_10_8

			if var_10_7 == var_10_6.state_connection then
				setText = var_10_7
				var_10_8 = arg_10_0._btnGoText
				i18n = var_1_10006

				var_10_7(var_10_8, var_1_10006("tolovegame_puzzle_detail_connection"))

				var_10_1 = 3
			else
				local var_10_9 = arg_10_0._stateType

				PuzzleConnectMediator = var_10_8

				if var_10_9 == var_10_8.state_complete then
					setActive = var_10_9

					var_10_9(arg_10_0._btnGo, false)

					var_10_1 = 4
				end
			end
		end
	end

	for iter_10_0 = 1, #arg_10_0._stepDescList do
		local var_10_10 = arg_10_0._stepDescList[iter_10_0]

		findTF = var_1_10009
		var_1_10009 = var_1_10009(arg_10_0._tf, "ad/list/text_" .. iter_10_0)
		setText = var_10_11

		var_10_11(var_1_10009, arg_10_0:replaceStr(var_10_10, arg_10_0._configData.need[3], var_10_0, arg_10_0._configData.need[3]))

		local var_10_11

		if iter_10_0 <= var_10_1 then
			GetComponent = var_10_11
			var_10_11 = var_10_11(var_1_10009, "RichText")
			Color = var_11
			var_10_11.color = var_11.New(0.49, 0.5, 0.53, 1)
		else
			GetComponent = var_10_11

			local var_10_12 = var_10_11(var_1_10009, "RichText")

			Color = var_11
			var_10_12.color = var_11.New(0.18, 0.16, 0.18, 1)
		end

		if 2 < iter_10_0 and var_10_1 + 1 < iter_10_0 then
			setActive = var_10

			var_10(var_1_10009, false)
		else
			setActive = var_10

			var_10(var_1_10009, true)
		end
	end

	return
end

function var_0_0.updateUI(arg_11_0)
	LoadImageSpriteAsync = var_1_10001

	var_1_10001("SquareIcon/" .. arg_11_0._configData.portrait_up, arg_11_0._leftIcon1)

	LoadImageSpriteAsync = var_1_10001

	var_1_10001("SquareIcon/" .. arg_11_0._configData.portrait_down, arg_11_0._leftIcon2)

	pg = var_1_10001

	local var_11_0 = var_1_10001.ship_data_statistics[arg_11_0._configData.ship_id].name

	setText = var_2
	findTF = var_3

	local var_11_1 = var_3(arg_11_0._tf, "ad/player")

	i18n = var_4

	var_2(var_11_1, var_4("tolovegame_puzzle_ship_need", var_11_0))

	setText = var_2

	var_2(arg_11_0._playerDesc, arg_11_0._configData.desc_demand)

	setText = var_2

	local var_11_2 = arg_11_0._progressTitle

	i18n = var_4

	var_2(var_11_2, var_4("tolovegame_puzzle_task_need"))

	setText = var_2

	var_2(arg_11_0._chatText, arg_11_0._configData.desc_bubble)

	return
end

function var_0_0.replaceStr(arg_12_0, arg_12_1, ...)
	if arg_12_1 then
		ipairs = var_1_10002

		for iter_12_0, iter_12_1 in var_1_10002({
			...
		}) do
			string = var_1_10007
			arg_12_1 = var_1_10007.gsub(arg_12_1, "$" .. iter_12_0, iter_12_1)
		end

		return arg_12_1
	end

	return arg_12_1
end

function var_0_0.dispose(arg_13_0)
	if arg_13_0._timer and arg_13_0._timer.running then
		local var_13_0 = arg_13_0._timer

		var_1.Stop(var_13_0)

		arg_13_0._timer = nil
	end

	return
end

return var_0_0
