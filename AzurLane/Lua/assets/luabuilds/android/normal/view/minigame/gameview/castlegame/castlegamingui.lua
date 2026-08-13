class = var_0_10000

local var_0_0 = var_0_10000("CastleGamingUI")

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0._tf = arg_1_1
	arg_1_0._event = arg_1_2
	findTF = var_1_10003
	arg_1_0._gameUI = var_1_10003(arg_1_0._tf, "ui/gamingUI")
	findTF = var_3
	arg_1_0.btnBack = var_3(arg_1_0._gameUI, "back")
	findTF = var_3
	arg_1_0.btnPause = var_3(arg_1_0._gameUI, "pause")
	findTF = var_3
	arg_1_0.gameTime = var_3(arg_1_0._gameUI, "time")
	findTF = var_3
	arg_1_0.gameScore = var_3(arg_1_0._gameUI, "score")
	CastleGameJoyStick = var_3

	local var_1_0 = var_3.New

	findTF = var_4
	arg_1_0.joyStick = var_1_0(var_4(arg_1_0._gameUI, "joyStick"))
	onButton = var_3

	local var_1_1 = arg_1_0._event
	local var_1_2 = arg_1_0.btnBack

	local function var_1_3()
		local var_2_0 = arg_1_0._event
		local var_2_1 = var_0.emit

		CastleGameView = var_2_10002

		var_2_1(var_2_0, var_2_10002.PAUSE_GAME, true)

		local var_2_2 = arg_1_0._event
		local var_2_3 = var_0.emit

		CastleGameView = var_2

		var_2_3(var_2_2, var_2.OPEN_LEVEL_UI)

		return
	end

	SFX_CONFIRM = var_1_10007

	var_3(var_1_1, var_1_2, var_1_3, var_1_10007)

	onButton = var_3

	local var_1_4 = arg_1_0._event
	local var_1_5 = arg_1_0.btnPause

	local function var_1_6()
		local var_3_0 = arg_1_0._event
		local var_3_1 = var_0.emit

		CastleGameView = var_2_10002

		var_3_1(var_3_0, var_2_10002.PAUSE_GAME, true)

		local var_3_2 = arg_1_0._event
		local var_3_3 = var_0.emit

		CastleGameView = var_2

		var_3_3(var_3_2, var_2.OPEN_PAUSE_UI)

		return
	end

	SFX_CONFIRM = var_1_10007

	var_3(var_1_4, var_1_5, var_1_6, var_1_10007)

	findTF = var_3
	arg_1_0.addScoreTf = var_3(arg_1_0._gameUI, "addScore")
	GetComponent = var_3
	findTF = var_4

	local var_1_7 = var_4(arg_1_0._gameUI, "addScore/ad")

	typeof = var_5
	Animator = var_6
	arg_1_0.addScoreAnim = var_3(var_1_7, var_5(var_6))

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
	setActive = var_1_10001

	var_1_10001(arg_6_0.addScoreTf, false)

	Vector2 = var_1_10001
	arg_6_0.direct = var_1_10001(0, 0)

	return
end

function var_0_0.addScore(arg_7_0, arg_7_1)
	local var_7_0 = arg_7_1.num
	local var_7_1 = arg_7_1.pos
	local var_7_2 = arg_7_1.id

	findTF = var_1_10005

	local var_7_3 = var_1_10005(arg_7_0.addScoreTf, "ad").childCount

	for iter_7_0 = 0, var_7_3 - 1 do
		setActive = var_1_10011

		var_1_10011(var_5:GetChild(iter_7_0), false)
	end

	setActive = var_7
	findTF = var_8

	var_7(var_8(var_5, var_7_2), true)

	setText = var_7
	findTF = var_8

	local var_7_4 = var_8(var_5, var_7_2 .. "/txt")
	local var_7_5 = "+"

	tostring = var_10

	var_7(var_7_4, var_7_5 .. var_10(var_7_0))

	local var_7_6 = arg_7_0.addScoreTf
	local var_7_7 = arg_7_0._gameUI

	var_7_6.anchoredPosition = var_8.InverseTransformPoint(var_7_7, var_7_1)
	setActive = var_7_6

	var_7_6(arg_7_0.addScoreTf, false)

	setActive = var_7_6

	var_7_6(arg_7_0.addScoreTf, true)

	return
end

function var_0_0.step(arg_8_0)
	local var_8_0 = arg_8_0.joyStick

	var_1.step(var_8_0)

	setText = var_1

	local var_8_1 = arg_8_0.gameTime

	math = var_1_10003

	local var_8_2 = var_1_10003.floor

	CastleGameVo = var_1_10004

	var_1(var_8_1, var_8_2(var_1_10004.gameTime))

	setText = var_1

	local var_8_3 = arg_8_0.gameScore

	CastleGameVo = var_3

	var_1(var_8_3, var_3.scoreNum)

	CastleGameVo = var_1

	local var_8_4 = arg_8_0.joyStick

	var_1.joyStickData = var_2.getValue(var_8_4)

	local var_8_5 = arg_8_0.joyStick

	var_1.setDirectTarget(var_8_5, arg_8_0.direct)

	return
end

function var_0_0.press(arg_9_0, arg_9_1, arg_9_2)
	KeyCode = var_1_10003

	local var_9_0

	if arg_9_1 == var_1_10003.W then
		if arg_9_2 then
			var_9_0 = arg_9_0.direct
			var_9_0.y = 1
		elseif arg_9_0.direct.y == 1 then
			var_9_0 = arg_9_0.direct
			var_9_0.y = 0
		end
	end

	KeyCode = var_9_0

	local var_9_1

	if arg_9_1 == var_9_0.S then
		if arg_9_2 then
			var_9_1 = arg_9_0.direct
			var_9_1.y = -1
		elseif arg_9_0.direct.y == -1 then
			var_9_1 = arg_9_0.direct
			var_9_1.y = 0
		end
	end

	KeyCode = var_9_1

	local var_9_2

	if arg_9_1 == var_9_1.A then
		if arg_9_2 then
			var_9_2 = arg_9_0.direct
			var_9_2.x = -1
		elseif arg_9_0.direct.x == -1 then
			var_9_2 = arg_9_0.direct
			var_9_2.x = 0
		end
	end

	KeyCode = var_9_2

	if arg_9_1 == var_9_2.D then
		if arg_9_2 then
			arg_9_0.direct.x = 1
		elseif arg_9_0.direct.x == 1 then
			arg_9_0.direct.x = 0
		end
	end

	return
end

return var_0_0
