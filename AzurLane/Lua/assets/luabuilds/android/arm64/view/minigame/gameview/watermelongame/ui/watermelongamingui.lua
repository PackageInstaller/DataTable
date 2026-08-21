local var_0_0 = class("WatermelonGamingUI")

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	arg_1_0._tf = arg_1_1
	arg_1_0._event = arg_1_2
	arg_1_0._gameVo = arg_1_3
	arg_1_0._gameUI = findTF(arg_1_0._tf, "ui/gamingUI")
	arg_1_0.btnBack = findTF(arg_1_0._gameUI, "back")
	arg_1_0.btnPause = findTF(arg_1_0._gameUI, "pause")
	arg_1_0.gameTime = findTF(arg_1_0._gameUI, "time")
	arg_1_0.touchUI = findTF(arg_1_0._gameUI, "touch")
	arg_1_0.touchEvent = GetComponent(arg_1_0.touchUI, typeof(EventTriggerListener))
	arg_1_0.uiCam = GameObject.Find("UICamera"):GetComponent("Camera")

	arg_1_0.touchEvent:AddPointDownFunc(function(arg_2_0, arg_2_1)
		arg_1_0._event:emit(WatermelonGameEvent.CLICK_MOVE, {
			pos = arg_1_0.uiCam:ScreenToWorldPoint(arg_2_1.position),
			callback = function(arg_3_0)
				arg_1_0.startDrag = arg_3_0

				return
			end
		})

		return
	end)
	arg_1_0.touchEvent:AddPointUpFunc(function(arg_4_0, arg_4_1)
		if arg_1_0.startDrag then
			arg_1_0._event:emit(WatermelonGameEvent.CLICK_DOWN, (arg_1_0.uiCam:ScreenToWorldPoint(arg_4_1.position)))
		end

		return
	end)
	arg_1_0.touchEvent:AddDragFunc(function(arg_5_0, arg_5_1)
		if arg_1_0.startDrag then
			arg_1_0._event:emit(WatermelonGameEvent.CLICK_MOVE, {
				pos = arg_1_0.uiCam:ScreenToWorldPoint(arg_5_1.position)
			})
		end

		return
	end)
	onButton(arg_1_0._event, arg_1_0.btnBack, function()
		if not arg_1_0._gameVo.startSettlement then
			arg_1_0._event:emit(WatermelonGameEvent.PAUSE_GAME, true)
			arg_1_0._event:emit(WatermelonGameEvent.OPEN_LEVEL_UI)
		end

		return
	end, SFX_CONFIRM)
	onButton(arg_1_0._event, arg_1_0.btnPause, function()
		if not arg_1_0._gameVo.startSettlement then
			arg_1_0._event:emit(WatermelonGameEvent.PAUSE_GAME, true)
			arg_1_0._event:emit(WatermelonGameEvent.OPEN_PAUSE_UI)
		end

		return
	end, SFX_CONFIRM)

	arg_1_0.direct = Vector2(0, 0)
	arg_1_0.joyStick = MiniGameJoyStick.New(findTF(arg_1_0._gameUI, "joyStick"))

	arg_1_0.joyStick:setActiveCallback(function(arg_8_0)
		return
	end)

	arg_1_0.btnDown = findTF(arg_1_0._gameUI, "down")

	onButton(arg_1_0._event, arg_1_0.btnDown, function()
		arg_1_0._event:emit(WatermelonGameEvent.CLICK_DOWN)

		return
	end, SFX_CONFIRM)

	arg_1_0.scoreHigh = findTF(arg_1_0._gameUI, "score/high")
	arg_1_0.scoreCurrent = findTF(arg_1_0._gameUI, "score/current")
	arg_1_0.nextBall = findTF(arg_1_0._gameUI, "next/ball")

	return
end

function var_0_0.show(arg_10_0, arg_10_1)
	setActive(arg_10_0._gameUI, arg_10_1)

	return
end

function var_0_0.update(arg_11_0)
	return
end

function var_0_0.start(arg_12_0)
	arg_12_0.subGameStepTime = 0

	arg_12_0:show(true)

	local var_12_0 = getProxy(MiniGameProxy):GetHighScore(arg_12_0._gameVo.gameId)

	if var_12_0 and #var_12_0 > 0 then
		local var_12_1 = var_12_0[1] or 0

		setText(arg_12_0.scoreHigh, var_12_1)
		setText(arg_12_0.scoreCurrent, 0)
		arg_12_0:setChildVisible(arg_12_0.nextBall, false)

		return
	end
end

function var_0_0.addScore(arg_13_0, arg_13_1)
	setText(arg_13_0.scoreCurrent, arg_13_0._gameVo.scoreNum)

	return
end

function var_0_0.step(arg_14_0, arg_14_1)
	setText(arg_14_0.gameTime, math.floor(arg_14_0._gameVo.gameTime))
	arg_14_0.joyStick:step()
	arg_14_0.joyStick:setDirectTarget(arg_14_0.direct)
	arg_14_0._gameVo:setJoyStickData(arg_14_0.joyStick:getValue())

	return
end

function var_0_0.updateBallId(arg_15_0, arg_15_1)
	arg_15_0:setChildVisible(arg_15_0.nextBall, false)
	setActive(findTF(arg_15_0.nextBall, arg_15_1), true)

	return
end

function var_0_0.setChildVisible(arg_16_0, arg_16_1, arg_16_2)
	for iter_16_0 = 1, arg_16_1.childCount do
		setActive(arg_16_1:GetChild(iter_16_0 - 1), arg_16_2)
	end

	return
end

function var_0_0.press(arg_17_0, arg_17_1, arg_17_2)
	if arg_17_1 == KeyCode.A then
		if arg_17_2 then
			arg_17_0.direct.x = -1
		elseif arg_17_0.direct.x == -1 then
			arg_17_0.direct.x = 0
		end
	elseif arg_17_1 == KeyCode.D then
		if arg_17_2 then
			arg_17_0.direct.x = 1
		elseif arg_17_0.direct.x == 1 then
			arg_17_0.direct.x = 0
		end
	elseif arg_17_1 == KeyCode.J then
		arg_17_0._event:emit(WatermelonGameEvent.CLICK_DOWN)
	end

	return
end

return var_0_0
