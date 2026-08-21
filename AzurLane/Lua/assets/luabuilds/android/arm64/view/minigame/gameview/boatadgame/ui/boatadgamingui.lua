local var_0_0 = class("BoatAdGamingUI")
local var_0_1

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0._tf = arg_1_1
	arg_1_0._event = arg_1_2
	var_0_1 = BoatAdGameVo
	arg_1_0._gameUI = findTF(arg_1_0._tf, "ui/gamingUI")
	arg_1_0.btnBack = findTF(arg_1_0._gameUI, "back")
	arg_1_0.btnPause = findTF(arg_1_0._gameUI, "pause")
	arg_1_0.gameTime = findTF(arg_1_0._gameUI, "topRight/timeImg/time")
	arg_1_0.gameScore = findTF(arg_1_0._gameUI, "topRight/scoreImg/score")

	onButton(arg_1_0._event, arg_1_0.btnBack, function()
		arg_1_0._event:emit(SimpleMGEvent.PAUSE_GAME, true)
		arg_1_0._event:emit(SimpleMGEvent.OPEN_LEVEL_UI)

		return
	end, SFX_CONFIRM)
	onButton(arg_1_0._event, arg_1_0.btnPause, function()
		arg_1_0._event:emit(SimpleMGEvent.PAUSE_GAME, true)
		arg_1_0._event:emit(SimpleMGEvent.OPEN_PAUSE_UI)

		return
	end, SFX_CONFIRM)

	arg_1_0.direct = Vector2(0, 0)
	arg_1_0.joyStickTf = findTF(arg_1_0._gameUI, "joyStick")
	arg_1_0.joyStick = MiniGameJoyStick.New(arg_1_0.joyStickTf)

	arg_1_0.joyStick:setActiveCallback(function(arg_4_0)
		return
	end)

	return
end

function var_0_0.show(arg_5_0, arg_5_1)
	setActive(arg_5_0._gameUI, arg_5_1)

	return
end

function var_0_0.update(arg_6_0)
	return
end

function var_0_0.start(arg_7_0)
	arg_7_0.direct = Vector2(0, 0)
	arg_7_0.subGameStepTime = 0
	arg_7_0._char = nil

	return
end

function var_0_0.step(arg_8_0, arg_8_1)
	arg_8_0._char = arg_8_0._char or var_0_1.GetGameChar()
	arg_8_0.joyStickTf.position = arg_8_0._char:getWorld()

	setText(arg_8_0.gameScore, var_0_1.scoreNum)
	setText(arg_8_0.gameTime, math.floor(var_0_1.gameStepTime))

	if arg_8_0.leftFlag and arg_8_0.rightFlag then
		arg_8_0.direct.x = arg_8_0.lastDirect
	elseif arg_8_0.leftFlag then
		arg_8_0.direct.x = -1
	elseif arg_8_0.rightFlag then
		arg_8_0.direct.x = 1
	elseif not arg_8_0.leftFlag and not arg_8_0.rightFlag then
		arg_8_0.direct.x = 0
	end

	arg_8_0.joyStick:step()
	arg_8_0.joyStick:setDirectTarget(arg_8_0.direct)

	var_0_1.joyStickData = arg_8_0.joyStick:getValue()

	return
end

function var_0_0.press(arg_9_0, arg_9_1, arg_9_2)
	if arg_9_1 == KeyCode.W then
		-- block empty
	elseif arg_9_1 == KeyCode.S then
		-- block empty
	elseif arg_9_1 == KeyCode.A then
		arg_9_0.leftFlag = arg_9_2

		if arg_9_2 then
			arg_9_0.lastDirect = -1
		end
	elseif arg_9_1 == KeyCode.D then
		arg_9_0.rightFlag = arg_9_2

		if arg_9_2 then
			arg_9_0.lastDirect = 1
		end
	end

	return
end

return var_0_0
