local var_0_0 = class("CutFruitGamingUI")

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	arg_1_0._tf = arg_1_1
	arg_1_0._event = arg_1_2
	arg_1_0._gameVo = arg_1_3

	arg_1_0:initUI()

	return
end

function var_0_0.initUI(arg_2_0)
	arg_2_0._gameUI = findTF(arg_2_0._tf, "ui/gamingUI")
	arg_2_0.btnBack = findTF(arg_2_0._gameUI, "back")
	arg_2_0.btnPause = findTF(arg_2_0._gameUI, "pause")
	arg_2_0.timeTF = findTF(arg_2_0._gameUI, "top/ad/time")

	onButton(arg_2_0._event, arg_2_0.btnBack, function()
		if not arg_2_0._gameVo.startSettlement then
			arg_2_0._event:emit(SimpleMGEvent.PAUSE_GAME, true)
			arg_2_0._event:emit(SimpleMGEvent.OPEN_LEVEL_UI)
		end

		return
	end, SFX_CONFIRM)
	onButton(arg_2_0._event, arg_2_0.btnPause, function()
		if not arg_2_0._gameVo.startSettlement then
			arg_2_0._event:emit(SimpleMGEvent.PAUSE_GAME, true)
			arg_2_0._event:emit(SimpleMGEvent.OPEN_PAUSE_UI)
		end

		return
	end, SFX_CONFIRM)

	arg_2_0.btnUp = findTF(arg_2_0._gameUI, "up")
	arg_2_0.btnDown = findTF(arg_2_0._gameUI, "down")
	arg_2_0.btnLeft = findTF(arg_2_0._gameUI, "left")
	arg_2_0.btnRight = findTF(arg_2_0._gameUI, "right")

	onButton(arg_2_0._event, arg_2_0.btnUp, function()
		arg_2_0._event:emit(CutFruitGameView.EVENT_DIRECT, CutFruitGameConst.DIRECT_UP)

		return
	end)
	onButton(arg_2_0._event, arg_2_0.btnDown, function()
		arg_2_0._event:emit(CutFruitGameView.EVENT_DIRECT, CutFruitGameConst.DIRECT_DOWN)

		return
	end)
	onButton(arg_2_0._event, arg_2_0.btnLeft, function()
		arg_2_0._event:emit(CutFruitGameView.EVENT_DIRECT, CutFruitGameConst.DIRECT_LEFT)

		return
	end)
	onButton(arg_2_0._event, arg_2_0.btnRight, function()
		arg_2_0._event:emit(CutFruitGameView.EVENT_DIRECT, CutFruitGameConst.DIRECT_RIGHT)

		return
	end)

	return
end

function var_0_0.Show(arg_9_0, arg_9_1)
	setActive(arg_9_0._gameUI, arg_9_1)

	return
end

function var_0_0.Update(arg_10_0)
	return
end

function var_0_0.Start(arg_11_0)
	arg_11_0.subGameStepTime = 0

	arg_11_0:Show(true)

	arg_11_0._editorFlag = arg_11_0._gameVo:GetEditor()

	local var_11_0 = getProxy(MiniGameProxy):GetHighScore(arg_11_0._gameVo:GetGameId())

	if not var_11_0 or #var_11_0 <= 0 or not var_11_0[1] then
		-- block empty
	end

	arg_11_0._score = 0
	arg_11_0._time = -1

	return
end

function var_0_0.Step(arg_12_0)
	if arg_12_0._time ~= arg_12_0._gameVo:GetTimeInteger() then
		arg_12_0._time = arg_12_0._gameVo:GetTimeInteger()

		if arg_12_0._time < 0 then
			arg_12_0._time = 0
		end

		setText(arg_12_0.timeTF, math.floor(arg_12_0._time))
	end

	if arg_12_0._score ~= arg_12_0._gameVo:GetScore() then
		arg_12_0._score = arg_12_0._gameVo:GetScore()
	end

	return
end

function var_0_0.SetChildVisible(arg_13_0, arg_13_1, arg_13_2)
	for iter_13_0 = 1, arg_13_1.childCount do
		setActive(arg_13_1:GetChild(iter_13_0 - 1), arg_13_2)
	end

	return
end

function var_0_0.Press(arg_14_0, arg_14_1, arg_14_2)
	return
end

return var_0_0
