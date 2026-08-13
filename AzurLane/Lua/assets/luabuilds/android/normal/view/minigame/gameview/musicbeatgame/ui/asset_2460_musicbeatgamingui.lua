class = var_0_10000

local var_0_0 = var_0_10000("MusicBeatGamingUI")

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	arg_1_0._tf = arg_1_1
	arg_1_0._event = arg_1_2
	arg_1_0._gameVo = arg_1_3
	findTF = var_1_10004
	arg_1_0._gameUI = var_1_10004(arg_1_0._tf, "ui/gamingUI")
	findTF = var_4
	arg_1_0.btnBack = var_4(arg_1_0._gameUI, "back")
	findTF = var_4
	arg_1_0.btnPause = var_4(arg_1_0._gameUI, "pause")
	onButton = var_4

	local var_1_0 = arg_1_0._event
	local var_1_1 = arg_1_0.btnBack

	local function var_1_2()
		if not arg_1_0._gameVo.startSettlement then
			local var_2_0 = arg_1_0._event
			local var_2_1 = var_0.emit

			MusicBeatGameEvent = var_2_10002

			var_2_1(var_2_0, var_2_10002.PAUSE_GAME, true)

			local var_2_2 = arg_1_0._event
			local var_2_3 = var_0.emit

			MusicBeatGameEvent = var_2

			var_2_3(var_2_2, var_2.OPEN_LEVEL_UI)
		end

		return
	end

	SFX_CONFIRM = var_1_10008

	var_4(var_1_0, var_1_1, var_1_2, var_1_10008)

	onButton = var_4

	local var_1_3 = arg_1_0._event
	local var_1_4 = arg_1_0.btnPause

	local function var_1_5()
		if not arg_1_0._gameVo.startSettlement then
			local var_3_0 = arg_1_0._event
			local var_3_1 = var_0.emit

			MusicBeatGameEvent = var_2_10002

			var_3_1(var_3_0, var_2_10002.PAUSE_GAME, true)

			local var_3_2 = arg_1_0._event
			local var_3_3 = var_0.emit

			MusicBeatGameEvent = var_2

			var_3_3(var_3_2, var_2.OPEN_PAUSE_UI)
		end

		return
	end

	SFX_CONFIRM = var_1_10008

	var_4(var_1_3, var_1_4, var_1_5, var_1_10008)

	findTF = var_4
	arg_1_0.scoreCurrent = var_4(arg_1_0._gameUI, "score/text")

	return
end

function var_0_0.show(arg_4_0, arg_4_1)
	setActive = var_1_10002

	var_1_10002(arg_4_0._gameUI, arg_4_1)

	return
end

function var_0_0.update(arg_5_0)
	return
end

function var_0_0.start(arg_6_0)
	arg_6_0.subGameStepTime = 0

	local var_6_0 = arg_6_0

	arg_6_0.show(var_6_0, true)

	getProxy = var_1
	MiniGameProxy = var_6_0

	local var_6_1 = var_1(var_6_0)

	if var_1.GetHighScore(var_6_1, arg_6_0._gameVo.gameId) then
		local var_6_2 = #var_1

		if not (0 < var_6_2) or not var_1[1] then
			local var_6_3 = 0
		end

		setText = var_3

		var_3(arg_6_0.scoreCurrent, 0)

		return
	end
end

function var_0_0.addScore(arg_7_0, arg_7_1)
	setText = var_1_10002

	var_1_10002(arg_7_0.scoreCurrent, arg_7_0._gameVo.scoreNum)

	return
end

function var_0_0.step(arg_8_0, arg_8_1)
	local var_8_0 = arg_8_0._gameVo.gameTime

	return
end

function var_0_0.setChildVisible(arg_9_0, arg_9_1, arg_9_2)
	for iter_9_0 = 1, arg_9_1.childCount do
		local var_9_0 = arg_9_1
		local var_9_1 = arg_9_1.GetChild(var_9_0, iter_9_0 - 1)

		setActive = var_9_0

		var_9_0(var_9_1, arg_9_2)
	end

	return
end

function var_0_0.press(arg_10_0, arg_10_1, arg_10_2)
	KeyCode = var_1_10003

	if arg_10_1 == var_1_10003.A then
		-- block empty
	else
		KeyCode = var_3

		if arg_10_1 == var_3.D then
			-- block empty
		end
	end

	return
end

return var_0_0
