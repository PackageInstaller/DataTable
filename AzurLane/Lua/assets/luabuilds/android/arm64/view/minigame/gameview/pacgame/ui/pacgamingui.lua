local var_0_0 = class("PacGamingUI")

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
	arg_2_0.scoreTF = findTF(arg_2_0._gameUI, "top/ad/score")

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

	arg_2_0.direct = Vector2(0, 0)
	arg_2_0.joyStick = MiniGameJoyStick.New(findTF(arg_2_0._gameUI, "joyStick"))
	arg_2_0.joyStick.minDeadNum = 0.25

	arg_2_0.joyStick:setActiveCallback(function(arg_5_0)
		return
	end)
	setText(findTF(arg_2_0._gameUI, "top/ad/time_desc"), i18n("pac_game_gaming_time_desc"))
	setText(findTF(arg_2_0._gameUI, "top/ad/score_desc"), i18n("pac_game_gaming_score"))

	return
end

function var_0_0.Show(arg_6_0, arg_6_1)
	setActive(arg_6_0._gameUI, arg_6_1)

	return
end

function var_0_0.Update(arg_7_0)
	return
end

function var_0_0.Start(arg_8_0)
	arg_8_0.subGameStepTime = 0

	arg_8_0:Show(true)

	arg_8_0._editorFlag = arg_8_0._gameVo:GetEditor()

	local var_8_0 = getProxy(MiniGameProxy):GetHighScore(arg_8_0._gameVo:GetGameId())

	if not var_8_0 or #var_8_0 <= 0 or not var_8_0[1] then
		-- block empty
	end

	setText(arg_8_0.scoreTF, 0)

	if arg_8_0._editorFlag then
		setActive(findTF(arg_8_0._gameUI, "joyStick"), false)
		setActive(findTF(arg_8_0._gameUI, "top"), false)
		setActive(findTF(arg_8_0._gameUI, "bg_top"), false)
	end

	arg_8_0._score = 0
	arg_8_0._time = -1

	return
end

function var_0_0.Step(arg_9_0)
	arg_9_0.joyStick:step()
	arg_9_0.joyStick:setDirectTarget(arg_9_0.direct)
	arg_9_0._gameVo:SetJoyStickData(arg_9_0.joyStick:getValue())

	if arg_9_0._time ~= arg_9_0._gameVo:GetStepTimeInteger() then
		arg_9_0._time = arg_9_0._gameVo:GetStepTimeInteger()

		setText(arg_9_0.timeTF, math.floor(arg_9_0._time))
	end

	if arg_9_0._score ~= arg_9_0._gameVo:GetScore() then
		arg_9_0._score = arg_9_0._gameVo:GetScore()

		setText(arg_9_0.scoreTF, arg_9_0._score)
	end

	return
end

function var_0_0.SetChildVisible(arg_10_0, arg_10_1, arg_10_2)
	for iter_10_0 = 1, arg_10_1.childCount do
		setActive(arg_10_1:GetChild(iter_10_0 - 1), arg_10_2)
	end

	return
end

function var_0_0.Press(arg_11_0, arg_11_1, arg_11_2)
	if arg_11_1 == KeyCode.A then
		if arg_11_2 then
			arg_11_0.direct.x = -1
		elseif arg_11_0.direct.x == -1 then
			arg_11_0.direct.x = 0
		end
	elseif arg_11_1 == KeyCode.D then
		if arg_11_2 then
			arg_11_0.direct.x = 1
		elseif arg_11_0.direct.x == 1 then
			arg_11_0.direct.x = 0
		end
	elseif arg_11_1 == KeyCode.W then
		if arg_11_2 then
			arg_11_0.direct.y = 1
		elseif arg_11_0.direct.y == 1 then
			arg_11_0.direct.y = 0
		end
	elseif arg_11_1 == KeyCode.S then
		if arg_11_2 then
			arg_11_0.direct.y = -1
		elseif arg_11_0.direct.y == -1 then
			arg_11_0.direct.y = 0
		end
	end

	return
end

return var_0_0
