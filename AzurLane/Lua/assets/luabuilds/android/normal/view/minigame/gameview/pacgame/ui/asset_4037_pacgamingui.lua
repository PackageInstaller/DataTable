class = var_0_10000

local var_0_0 = var_0_10000("PacGamingUI")

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	arg_1_0._tf = arg_1_1
	arg_1_0._event = arg_1_2
	arg_1_0._gameVo = arg_1_3

	arg_1_0:initUI()

	return
end

function var_0_0.initUI(arg_2_0)
	findTF = var_1_10001
	arg_2_0._gameUI = var_1_10001(arg_2_0._tf, "ui/gamingUI")
	findTF = var_1
	arg_2_0.btnBack = var_1(arg_2_0._gameUI, "back")
	findTF = var_1
	arg_2_0.btnPause = var_1(arg_2_0._gameUI, "pause")
	findTF = var_1
	arg_2_0.timeTF = var_1(arg_2_0._gameUI, "top/ad/time")
	findTF = var_1
	arg_2_0.scoreTF = var_1(arg_2_0._gameUI, "top/ad/score")
	onButton = var_1

	local var_2_0 = arg_2_0._event
	local var_2_1 = arg_2_0.btnBack

	local function var_2_2()
		if not arg_2_0._gameVo.startSettlement then
			local var_3_0 = arg_2_0._event
			local var_3_1 = var_0.emit

			SimpleMGEvent = var_2_10002

			var_3_1(var_3_0, var_2_10002.PAUSE_GAME, true)

			local var_3_2 = arg_2_0._event
			local var_3_3 = var_0.emit

			SimpleMGEvent = var_2

			var_3_3(var_3_2, var_2.OPEN_LEVEL_UI)
		end

		return
	end

	SFX_CONFIRM = var_1_10005

	var_1(var_2_0, var_2_1, var_2_2, var_1_10005)

	onButton = var_1

	local var_2_3 = arg_2_0._event
	local var_2_4 = arg_2_0.btnPause

	local function var_2_5()
		if not arg_2_0._gameVo.startSettlement then
			local var_4_0 = arg_2_0._event
			local var_4_1 = var_0.emit

			SimpleMGEvent = var_2_10002

			var_4_1(var_4_0, var_2_10002.PAUSE_GAME, true)

			local var_4_2 = arg_2_0._event
			local var_4_3 = var_0.emit

			SimpleMGEvent = var_2

			var_4_3(var_4_2, var_2.OPEN_PAUSE_UI)
		end

		return
	end

	SFX_CONFIRM = var_1_10005

	var_1(var_2_3, var_2_4, var_2_5, var_1_10005)

	Vector2 = var_1
	arg_2_0.direct = var_1(0, 0)
	MiniGameJoyStick = var_1

	local var_2_6 = var_1.New

	findTF = var_2
	arg_2_0.joyStick = var_2_6(var_2(arg_2_0._gameUI, "joyStick"))
	arg_2_0.joyStick.minDeadNum = 0.25

	local var_2_7 = arg_2_0.joyStick

	var_1.setActiveCallback(var_2_7, function(arg_5_0)
		return
	end)

	setText = var_1
	findTF = var_2_7

	local var_2_8 = var_2_7(arg_2_0._gameUI, "top/ad/time_desc")

	i18n = var_3

	var_1(var_2_8, var_3("pac_game_gaming_time_desc"))

	setText = var_1
	findTF = var_2_8

	local var_2_9 = var_2_8(arg_2_0._gameUI, "top/ad/score_desc")

	i18n = var_3

	var_1(var_2_9, var_3("pac_game_gaming_score"))

	return
end

function var_0_0.Show(arg_6_0, arg_6_1)
	setActive = var_1_10002

	var_1_10002(arg_6_0._gameUI, arg_6_1)

	return
end

function var_0_0.Update(arg_7_0)
	return
end

function var_0_0.Start(arg_8_0)
	arg_8_0.subGameStepTime = 0

	arg_8_0:Show(true)

	local var_8_0 = arg_8_0._gameVo

	arg_8_0._editorFlag = var_1.GetEditor(var_8_0)
	getProxy = var_1
	MiniGameProxy = var_8_0

	local var_8_1 = var_1(var_8_0)
	local var_8_2 = var_1.GetHighScore
	local var_8_3 = arg_8_0._gameVo

	if var_8_2(var_8_1, var_3.GetGameId(var_8_3)) then
		local var_8_4 = #var_1

		if not (0 < var_8_4) or not var_1[1] then
			local var_8_5 = 0
		end

		setText = var_3

		var_3(arg_8_0.scoreTF, 0)

		if arg_8_0._editorFlag then
			setActive = var_3
			findTF = var_4

			var_3(var_4(arg_8_0._gameUI, "joyStick"), false)

			setActive = var_3
			findTF = var_4

			var_3(var_4(arg_8_0._gameUI, "top"), false)

			setActive = var_3
			findTF = var_4

			var_3(var_4(arg_8_0._gameUI, "bg_top"), false)
		end

		arg_8_0._score = 0
		arg_8_0._time = -1

		return
	end
end

function var_0_0.Step(arg_9_0)
	local var_9_0 = arg_9_0.joyStick

	var_1.step(var_9_0)

	local var_9_1 = arg_9_0.joyStick

	var_1.setDirectTarget(var_9_1, arg_9_0.direct)

	local var_9_2 = arg_9_0._gameVo
	local var_9_3 = var_1.SetJoyStickData
	local var_9_4 = arg_9_0.joyStick

	var_9_3(var_9_2, var_3.getValue(var_9_4))

	local var_9_5 = arg_9_0._time
	local var_9_6 = arg_9_0._gameVo

	if var_9_5 ~= var_2.GetStepTimeInteger(var_9_6) then
		local var_9_7 = arg_9_0._gameVo

		arg_9_0._time = var_1.GetStepTimeInteger(var_9_7)
		setText = var_1

		local var_9_8 = arg_9_0.timeTF

		math = var_9_6

		var_1(var_9_8, var_9_6.floor(arg_9_0._time))
	end

	local var_9_9 = arg_9_0._score
	local var_9_10 = arg_9_0._gameVo

	if var_9_9 ~= var_2.GetScore(var_9_10) then
		local var_9_11 = arg_9_0._gameVo

		arg_9_0._score = var_1.GetScore(var_9_11)
		setText = var_1

		var_1(arg_9_0.scoreTF, arg_9_0._score)
	end

	return
end

function var_0_0.SetChildVisible(arg_10_0, arg_10_1, arg_10_2)
	for iter_10_0 = 1, arg_10_1.childCount do
		local var_10_0 = arg_10_1
		local var_10_1 = arg_10_1.GetChild(var_10_0, iter_10_0 - 1)

		setActive = var_10_0

		var_10_0(var_10_1, arg_10_2)
	end

	return
end

function var_0_0.Press(arg_11_0, arg_11_1, arg_11_2)
	KeyCode = var_1_10003

	local var_11_0

	if arg_11_1 == var_1_10003.A then
		if arg_11_2 then
			var_11_0 = arg_11_0.direct
			var_11_0.x = -1
		elseif arg_11_0.direct.x == -1 then
			var_11_0 = arg_11_0.direct
			var_11_0.x = 0
		end
	else
		KeyCode = var_11_0

		local var_11_1

		if arg_11_1 == var_11_0.D then
			if arg_11_2 then
				var_11_1 = arg_11_0.direct
				var_11_1.x = 1
			elseif arg_11_0.direct.x == 1 then
				var_11_1 = arg_11_0.direct
				var_11_1.x = 0
			end
		else
			KeyCode = var_11_1

			local var_11_2

			if arg_11_1 == var_11_1.W then
				if arg_11_2 then
					var_11_2 = arg_11_0.direct
					var_11_2.y = 1
				elseif arg_11_0.direct.y == 1 then
					var_11_2 = arg_11_0.direct
					var_11_2.y = 0
				end
			else
				KeyCode = var_11_2

				if arg_11_1 == var_11_2.S then
					if arg_11_2 then
						arg_11_0.direct.y = -1
					elseif arg_11_0.direct.y == -1 then
						arg_11_0.direct.y = 0
					end
				end
			end
		end
	end

	return
end

return var_0_0
