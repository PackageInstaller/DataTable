local var_0_0 = class("MusicBeatGamingUI")

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	arg_1_0._tf = arg_1_1
	arg_1_0._event = arg_1_2
	arg_1_0._gameVo = arg_1_3
	arg_1_0._gameUI = findTF(arg_1_0._tf, "ui/gamingUI")
	arg_1_0.btnBack = findTF(arg_1_0._gameUI, "back")
	arg_1_0.btnPause = findTF(arg_1_0._gameUI, "pause")

	onButton(arg_1_0._event, arg_1_0.btnBack, function()
		if not arg_1_0._gameVo.startSettlement then
			arg_1_0._event:emit(MusicBeatGameEvent.PAUSE_GAME, true)
			arg_1_0._event:emit(MusicBeatGameEvent.OPEN_LEVEL_UI)
		end

		return
	end, SFX_CONFIRM)
	onButton(arg_1_0._event, arg_1_0.btnPause, function()
		if not arg_1_0._gameVo.startSettlement then
			arg_1_0._event:emit(MusicBeatGameEvent.PAUSE_GAME, true)
			arg_1_0._event:emit(MusicBeatGameEvent.OPEN_PAUSE_UI)
		end

		return
	end, SFX_CONFIRM)

	arg_1_0.scoreCurrent = findTF(arg_1_0._gameUI, "score/text")

	return
end

function var_0_0.show(arg_4_0, arg_4_1)
	setActive(arg_4_0._gameUI, arg_4_1)

	return
end

function var_0_0.update(arg_5_0)
	return
end

function var_0_0.start(arg_6_0)
	arg_6_0.subGameStepTime = 0

	arg_6_0:show(true)

	local var_6_0 = getProxy(MiniGameProxy):GetHighScore(arg_6_0._gameVo.gameId)

	if not var_6_0 or #var_6_0 <= 0 or not var_6_0[1] then
		-- block empty
	end

	setText(arg_6_0.scoreCurrent, 0)

	return
end

function var_0_0.addScore(arg_7_0, arg_7_1)
	setText(arg_7_0.scoreCurrent, arg_7_0._gameVo.scoreNum)

	return
end

function var_0_0.step(arg_8_0, arg_8_1)
	return
end

function var_0_0.setChildVisible(arg_9_0, arg_9_1, arg_9_2)
	for iter_9_0 = 1, arg_9_1.childCount do
		setActive(arg_9_1:GetChild(iter_9_0 - 1), arg_9_2)
	end

	return
end

function var_0_0.press(arg_10_0, arg_10_1, arg_10_2)
	if arg_10_1 == KeyCode.A then
		-- block empty
	elseif arg_10_1 == KeyCode.D then
		-- block empty
	end

	return
end

return var_0_0
