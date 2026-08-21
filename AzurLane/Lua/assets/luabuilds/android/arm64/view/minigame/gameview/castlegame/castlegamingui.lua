local var_0_0 = class("CastleGamingUI")

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0._tf = arg_1_1
	arg_1_0._event = arg_1_2
	arg_1_0._gameUI = findTF(arg_1_0._tf, "ui/gamingUI")
	arg_1_0.btnBack = findTF(arg_1_0._gameUI, "back")
	arg_1_0.btnPause = findTF(arg_1_0._gameUI, "pause")
	arg_1_0.gameTime = findTF(arg_1_0._gameUI, "time")
	arg_1_0.gameScore = findTF(arg_1_0._gameUI, "score")
	arg_1_0.joyStick = CastleGameJoyStick.New(findTF(arg_1_0._gameUI, "joyStick"))

	onButton(arg_1_0._event, arg_1_0.btnBack, function()
		arg_1_0._event:emit(CastleGameView.PAUSE_GAME, true)
		arg_1_0._event:emit(CastleGameView.OPEN_LEVEL_UI)

		return
	end, SFX_CONFIRM)
	onButton(arg_1_0._event, arg_1_0.btnPause, function()
		arg_1_0._event:emit(CastleGameView.PAUSE_GAME, true)
		arg_1_0._event:emit(CastleGameView.OPEN_PAUSE_UI)

		return
	end, SFX_CONFIRM)

	arg_1_0.addScoreTf = findTF(arg_1_0._gameUI, "addScore")
	arg_1_0.addScoreAnim = GetComponent(findTF(arg_1_0._gameUI, "addScore/ad"), typeof(Animator))

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
	setActive(arg_6_0.addScoreTf, false)

	arg_6_0.direct = Vector2(0, 0)

	return
end

function var_0_0.addScore(arg_7_0, arg_7_1)
	local var_7_0 = findTF(arg_7_0.addScoreTf, "ad")

	for iter_7_0 = 0, var_7_0.childCount - 1 do
		setActive(var_7_0:GetChild(iter_7_0), false)
	end

	setActive(findTF(var_7_0, arg_7_1.id), true)
	setText(findTF(var_7_0, arg_7_1.id .. "/txt"), "+" .. tostring(arg_7_1.num))

	arg_7_0.addScoreTf.anchoredPosition = arg_7_0._gameUI:InverseTransformPoint(arg_7_1.pos)

	setActive(arg_7_0.addScoreTf, false)
	setActive(arg_7_0.addScoreTf, true)

	return
end

function var_0_0.step(arg_8_0)
	arg_8_0.joyStick:step()
	setText(arg_8_0.gameTime, math.floor(CastleGameVo.gameTime))
	setText(arg_8_0.gameScore, CastleGameVo.scoreNum)

	CastleGameVo.joyStickData = arg_8_0.joyStick:getValue()

	arg_8_0.joyStick:setDirectTarget(arg_8_0.direct)

	return
end

function var_0_0.press(arg_9_0, arg_9_1, arg_9_2)
	if arg_9_1 == KeyCode.W then
		if arg_9_2 then
			arg_9_0.direct.y = 1
		elseif arg_9_0.direct.y == 1 then
			arg_9_0.direct.y = 0
		end
	end

	if arg_9_1 == KeyCode.S then
		if arg_9_2 then
			arg_9_0.direct.y = -1
		elseif arg_9_0.direct.y == -1 then
			arg_9_0.direct.y = 0
		end
	end

	if arg_9_1 == KeyCode.A then
		if arg_9_2 then
			arg_9_0.direct.x = -1
		elseif arg_9_0.direct.x == -1 then
			arg_9_0.direct.x = 0
		end
	end

	if arg_9_1 == KeyCode.D then
		if arg_9_2 then
			arg_9_0.direct.x = 1
		elseif arg_9_0.direct.x == 1 then
			arg_9_0.direct.x = 0
		end
	end

	return
end

return var_0_0
