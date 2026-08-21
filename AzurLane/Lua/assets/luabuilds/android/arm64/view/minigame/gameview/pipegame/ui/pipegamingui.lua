local var_0_0 = class("PipeGamingUI")
local var_0_1

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0._tf = arg_1_1
	arg_1_0._event = arg_1_2
	var_0_1 = PipeGameVo
	arg_1_0._gameUI = findTF(arg_1_0._tf, "ui/gamingUI")
	arg_1_0.btnBack = findTF(arg_1_0._gameUI, "back")
	arg_1_0.btnPause = findTF(arg_1_0._gameUI, "pause")
	arg_1_0.gameTime = findTF(arg_1_0._gameUI, "time")

	onButton(arg_1_0._event, arg_1_0.btnBack, function()
		if not var_0_1.startSettlement then
			arg_1_0._event:emit(PipeGameEvent.PAUSE_GAME, true)
			arg_1_0._event:emit(PipeGameEvent.OPEN_LEVEL_UI)
		end

		return
	end, SFX_CONFIRM)
	onButton(arg_1_0._event, arg_1_0.btnPause, function()
		if not var_0_1.startSettlement then
			arg_1_0._event:emit(PipeGameEvent.PAUSE_GAME, true)
			arg_1_0._event:emit(PipeGameEvent.OPEN_PAUSE_UI)
		end

		return
	end, SFX_CONFIRM)

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

	return
end

function var_0_0.addScore(arg_7_0, arg_7_1)
	return
end

function var_0_0.step(arg_8_0, arg_8_1)
	setText(arg_8_0.gameTime, math.floor(var_0_1.gameDragTime))

	if var_0_1.gameDragTime <= 0 then
		arg_8_0:show(false)
	elseif var_0_1.startSettlement and isActive(arg_8_0._gameUI) then
		arg_8_0:show(false)
	end

	return
end

function var_0_0.press(arg_9_0, arg_9_1, arg_9_2)
	return
end

return var_0_0
