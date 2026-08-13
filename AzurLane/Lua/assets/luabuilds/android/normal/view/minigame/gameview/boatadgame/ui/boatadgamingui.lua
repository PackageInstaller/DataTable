class = var_0_10000

local var_0_0 = var_0_10000("BoatAdGamingUI")
local var_0_1

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0._tf = arg_1_1
	arg_1_0._event = arg_1_2
	BoatAdGameVo = var_1_10003
	var_0_1 = var_1_10003
	findTF = var_1_10003
	arg_1_0._gameUI = var_1_10003(arg_1_0._tf, "ui/gamingUI")
	findTF = var_3
	arg_1_0.btnBack = var_3(arg_1_0._gameUI, "back")
	findTF = var_3
	arg_1_0.btnPause = var_3(arg_1_0._gameUI, "pause")
	findTF = var_3
	arg_1_0.gameTime = var_3(arg_1_0._gameUI, "topRight/timeImg/time")
	findTF = var_3
	arg_1_0.gameScore = var_3(arg_1_0._gameUI, "topRight/scoreImg/score")
	onButton = var_3

	local var_1_0 = arg_1_0._event
	local var_1_1 = arg_1_0.btnBack

	local function var_1_2()
		local var_2_0 = arg_1_0._event
		local var_2_1 = var_0.emit

		SimpleMGEvent = var_2_10002

		var_2_1(var_2_0, var_2_10002.PAUSE_GAME, true)

		local var_2_2 = arg_1_0._event
		local var_2_3 = var_0.emit

		SimpleMGEvent = var_2

		var_2_3(var_2_2, var_2.OPEN_LEVEL_UI)

		return
	end

	SFX_CONFIRM = var_1_10007

	var_3(var_1_0, var_1_1, var_1_2, var_1_10007)

	onButton = var_3

	local var_1_3 = arg_1_0._event
	local var_1_4 = arg_1_0.btnPause

	local function var_1_5()
		local var_3_0 = arg_1_0._event
		local var_3_1 = var_0.emit

		SimpleMGEvent = var_2_10002

		var_3_1(var_3_0, var_2_10002.PAUSE_GAME, true)

		local var_3_2 = arg_1_0._event
		local var_3_3 = var_0.emit

		SimpleMGEvent = var_2

		var_3_3(var_3_2, var_2.OPEN_PAUSE_UI)

		return
	end

	SFX_CONFIRM = var_1_10007

	var_3(var_1_3, var_1_4, var_1_5, var_1_10007)

	Vector2 = var_3
	arg_1_0.direct = var_3(0, 0)
	findTF = var_3
	arg_1_0.joyStickTf = var_3(arg_1_0._gameUI, "joyStick")
	MiniGameJoyStick = var_3
	arg_1_0.joyStick = var_3.New(arg_1_0.joyStickTf)

	local var_1_6 = arg_1_0.joyStick

	var_3.setActiveCallback(var_1_6, function(arg_4_0)
		return
	end)

	return
end

function var_0_0.show(arg_5_0, arg_5_1)
	setActive = var_1_10002

	var_1_10002(arg_5_0._gameUI, arg_5_1)

	return
end

function var_0_0.update(arg_6_0)
	return
end

function var_0_0.start(arg_7_0)
	Vector2 = var_1_10001
	arg_7_0.direct = var_1_10001(0, 0)
	arg_7_0.subGameStepTime = 0
	arg_7_0._char = nil

	return
end

function var_0_0.step(arg_8_0, arg_8_1)
	if not arg_8_0._char then
		arg_8_0._char = var_0_1.GetGameChar()
	end

	local var_8_0 = arg_8_0.joyStickTf
	local var_8_1 = arg_8_0._char

	var_8_0.position = var_3.getWorld(var_8_1)

	local var_8_2 = var_0_1.gameTime
	local var_8_3 = var_0_1.gameStepTime

	setText = var_8_1

	var_8_1(arg_8_0.gameScore, var_0_1.scoreNum)

	setText = var_8_1

	local var_8_4 = arg_8_0.gameTime

	math = var_6

	var_8_1(var_8_4, var_6.floor(var_8_3))

	if arg_8_0.leftFlag and arg_8_0.rightFlag then
		arg_8_0.direct.x = arg_8_0.lastDirect
	elseif arg_8_0.leftFlag then
		arg_8_0.direct.x = -1
	elseif arg_8_0.rightFlag then
		arg_8_0.direct.x = 1
	elseif not arg_8_0.leftFlag and not arg_8_0.rightFlag then
		arg_8_0.direct.x = 0
	end

	local var_8_5 = arg_8_0.joyStick

	var_4.step(var_8_5)

	local var_8_6 = arg_8_0.joyStick

	var_4.setDirectTarget(var_8_6, arg_8_0.direct)

	local var_8_7 = var_0_1
	local var_8_8 = arg_8_0.joyStick

	var_8_7.joyStickData = var_5.getValue(var_8_8)

	return
end

function var_0_0.press(arg_9_0, arg_9_1, arg_9_2)
	KeyCode = var_1_10003

	if arg_9_1 == var_1_10003.W then
		-- block empty
	else
		KeyCode = var_3

		if arg_9_1 == var_3.S then
			-- block empty
		else
			KeyCode = var_3

			if arg_9_1 == var_3.A then
				arg_9_0.leftFlag = arg_9_2

				if arg_9_2 then
					arg_9_0.lastDirect = -1
				end
			else
				KeyCode = var_3

				if arg_9_1 == var_3.D then
					arg_9_0.rightFlag = arg_9_2

					if arg_9_2 then
						arg_9_0.lastDirect = 1
					end
				end
			end
		end
	end

	return
end

return var_0_0
