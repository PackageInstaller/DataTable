class = var_0_10000

local var_0_0 = var_0_10000("WatermelonGamingUI")

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
	findTF = var_4
	arg_1_0.gameTime = var_4(arg_1_0._gameUI, "time")
	findTF = var_4
	arg_1_0.touchUI = var_4(arg_1_0._gameUI, "touch")
	GetComponent = var_4

	local var_1_0 = arg_1_0.touchUI

	typeof = var_7
	EventTriggerListener = var_1_10009
	arg_1_0.touchEvent = var_4(var_1_0, var_7(var_1_10009))
	GameObject = var_4

	local var_1_1 = var_4.Find("UICamera")

	arg_1_0.uiCam = var_4.GetComponent(var_1_1, "Camera")

	local var_1_2 = arg_1_0.touchEvent

	var_4.AddPointDownFunc(var_1_2, function(arg_2_0, arg_2_1)
		local var_2_0 = arg_1_0.uiCam
		local var_2_1 = var_2.ScreenToWorldPoint(var_2_0, arg_2_1.position)
		local var_2_2 = arg_1_0._event
		local var_2_3 = var_3.emit

		WatermelonGameEvent = var_2_10006

		var_2_3(var_2_2, var_2_10006.CLICK_MOVE, {
			pos = var_2_1,
			callback = function(arg_3_0)
				arg_1_0.startDrag = arg_3_0

				return
			end
		})

		return
	end)

	local var_1_3 = arg_1_0.touchEvent

	var_4.AddPointUpFunc(var_1_3, function(arg_4_0, arg_4_1)
		local var_4_0 = arg_1_0.uiCam
		local var_4_1 = var_2.ScreenToWorldPoint(var_4_0, arg_4_1.position)

		if arg_1_0.startDrag then
			local var_4_2 = arg_1_0._event
			local var_4_3 = var_3.emit

			WatermelonGameEvent = var_2_10006

			var_4_3(var_4_2, var_2_10006.CLICK_DOWN, var_4_1)
		end

		return
	end)

	local var_1_4 = arg_1_0.touchEvent

	var_4.AddDragFunc(var_1_4, function(arg_5_0, arg_5_1)
		if arg_1_0.startDrag then
			local var_5_0 = arg_1_0.uiCam
			local var_5_1 = var_2.ScreenToWorldPoint(var_5_0, arg_5_1.position)
			local var_5_2 = arg_1_0._event
			local var_5_3 = var_3.emit

			WatermelonGameEvent = var_2_10006

			var_5_3(var_5_2, var_2_10006.CLICK_MOVE, {
				pos = var_5_1
			})
		end

		return
	end)

	onButton = var_4

	local var_1_5 = arg_1_0._event
	local var_1_6 = arg_1_0.btnBack

	local function var_1_7()
		if not arg_1_0._gameVo.startSettlement then
			local var_6_0 = arg_1_0._event
			local var_6_1 = var_0.emit

			WatermelonGameEvent = var_2_10003

			var_6_1(var_6_0, var_2_10003.PAUSE_GAME, true)

			local var_6_2 = arg_1_0._event
			local var_6_3 = var_0.emit

			WatermelonGameEvent = var_3

			var_6_3(var_6_2, var_3.OPEN_LEVEL_UI)
		end

		return
	end

	SFX_CONFIRM = var_1_10009

	var_4(var_1_5, var_1_6, var_1_7, var_1_10009)

	onButton = var_4

	local var_1_8 = arg_1_0._event
	local var_1_9 = arg_1_0.btnPause

	local function var_1_10()
		if not arg_1_0._gameVo.startSettlement then
			local var_7_0 = arg_1_0._event
			local var_7_1 = var_0.emit

			WatermelonGameEvent = var_2_10003

			var_7_1(var_7_0, var_2_10003.PAUSE_GAME, true)

			local var_7_2 = arg_1_0._event
			local var_7_3 = var_0.emit

			WatermelonGameEvent = var_3

			var_7_3(var_7_2, var_3.OPEN_PAUSE_UI)
		end

		return
	end

	SFX_CONFIRM = var_1_10009

	var_4(var_1_8, var_1_9, var_1_10, var_1_10009)

	Vector2 = var_4
	arg_1_0.direct = var_4(0, 0)
	MiniGameJoyStick = var_4

	local var_1_11 = var_4.New

	findTF = var_6
	arg_1_0.joyStick = var_1_11(var_6(arg_1_0._gameUI, "joyStick"))

	local var_1_12 = arg_1_0.joyStick

	var_4.setActiveCallback(var_1_12, function(arg_8_0)
		return
	end)

	findTF = var_4
	arg_1_0.btnDown = var_4(arg_1_0._gameUI, "down")
	onButton = var_4

	local var_1_13 = arg_1_0._event
	local var_1_14 = arg_1_0.btnDown

	local function var_1_15()
		local var_9_0 = arg_1_0._event
		local var_9_1 = var_0.emit

		WatermelonGameEvent = var_2_10003

		var_9_1(var_9_0, var_2_10003.CLICK_DOWN)

		return
	end

	SFX_CONFIRM = var_9

	var_4(var_1_13, var_1_14, var_1_15, var_9)

	findTF = var_4
	arg_1_0.scoreHigh = var_4(arg_1_0._gameUI, "score/high")
	findTF = var_4
	arg_1_0.scoreCurrent = var_4(arg_1_0._gameUI, "score/current")
	findTF = var_4
	arg_1_0.nextBall = var_4(arg_1_0._gameUI, "next/ball")

	return
end

function var_0_0.show(arg_10_0, arg_10_1)
	setActive = var_1_10002

	var_1_10002(arg_10_0._gameUI, arg_10_1)

	return
end

function var_0_0.update(arg_11_0)
	return
end

function var_0_0.start(arg_12_0)
	arg_12_0.subGameStepTime = 0

	local var_12_0 = arg_12_0

	arg_12_0.show(var_12_0, true)

	getProxy = var_1
	MiniGameProxy = var_12_0

	local var_12_1 = var_1(var_12_0)

	if var_1.GetHighScore(var_12_1, arg_12_0._gameVo.gameId) then
		local var_12_2 = #var_1
		local var_12_3

		if not (0 < var_12_2) or not var_1[1] then
			var_12_3 = 0
		end

		setText = var_12_1

		var_12_1(arg_12_0.scoreHigh, var_12_3)

		setText = var_12_1

		var_12_1(arg_12_0.scoreCurrent, 0)
		arg_12_0:setChildVisible(arg_12_0.nextBall, false)

		return
	end
end

function var_0_0.addScore(arg_13_0, arg_13_1)
	setText = var_1_10002

	var_1_10002(arg_13_0.scoreCurrent, arg_13_0._gameVo.scoreNum)

	return
end

function var_0_0.step(arg_14_0, arg_14_1)
	local var_14_0 = arg_14_0._gameVo.gameTime

	setText = var_1_10003

	local var_14_1 = arg_14_0.gameTime

	math = var_1_10006

	var_1_10003(var_14_1, var_1_10006.floor(var_14_0))

	local var_14_2 = arg_14_0.joyStick

	var_3.step(var_14_2)

	local var_14_3 = arg_14_0.joyStick

	var_3.setDirectTarget(var_14_3, arg_14_0.direct)

	local var_14_4 = arg_14_0._gameVo
	local var_14_5 = var_3.setJoyStickData
	local var_14_6 = arg_14_0.joyStick

	var_14_5(var_14_4, var_6.getValue(var_14_6))

	return
end

function var_0_0.updateBallId(arg_15_0, arg_15_1)
	local var_15_0 = arg_15_0

	arg_15_0.setChildVisible(var_15_0, arg_15_0.nextBall, false)

	setActive = var_2
	findTF = var_15_0

	var_2(var_15_0(arg_15_0.nextBall, arg_15_1), true)

	return
end

function var_0_0.setChildVisible(arg_16_0, arg_16_1, arg_16_2)
	for iter_16_0 = 1, arg_16_1.childCount do
		local var_16_0 = arg_16_1:GetChild(iter_16_0 - 1)

		setActive = var_1_10008

		var_1_10008(var_16_0, arg_16_2)
	end

	return
end

function var_0_0.press(arg_17_0, arg_17_1, arg_17_2)
	KeyCode = var_1_10003

	local var_17_0

	if arg_17_1 == var_1_10003.A then
		if arg_17_2 then
			var_17_0 = arg_17_0.direct
			var_17_0.x = -1
		elseif arg_17_0.direct.x == -1 then
			var_17_0 = arg_17_0.direct
			var_17_0.x = 0
		end
	else
		KeyCode = var_17_0

		local var_17_1

		if arg_17_1 == var_17_0.D then
			if arg_17_2 then
				var_17_1 = arg_17_0.direct
				var_17_1.x = 1
			elseif arg_17_0.direct.x == 1 then
				var_17_1 = arg_17_0.direct
				var_17_1.x = 0
			end
		else
			KeyCode = var_17_1

			if arg_17_1 == var_17_1.J then
				local var_17_2 = arg_17_0._event
				local var_17_3 = var_3.emit

				WatermelonGameEvent = var_1_10006

				var_17_3(var_17_2, var_1_10006.CLICK_DOWN)
			end
		end
	end

	return
end

return var_0_0
