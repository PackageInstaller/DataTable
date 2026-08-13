class = var_0_10000

local var_0_0 = var_0_10000("TouchCakeGamingUI")
local var_0_1
local var_0_2
local var_0_3

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0._tf = arg_1_1
	arg_1_0._event = arg_1_2
	TouchCakeGameVo = var_1_10003
	var_0_1 = var_1_10003
	TouchCakeGameEvent = var_1_10003
	var_0_2 = var_1_10003
	TouchCakeGameConst = var_1_10003
	var_0_3 = var_1_10003
	findTF = var_1_10003
	arg_1_0._gameUI = var_1_10003(arg_1_0._tf, "ui/gamingUI")
	findTF = var_3
	arg_1_0.btnBack = var_3(arg_1_0._gameUI, "back")
	findTF = var_3
	arg_1_0.btnPause = var_3(arg_1_0._gameUI, "pause")
	findTF = var_3
	arg_1_0.gameTime = var_3(arg_1_0._gameUI, "time")
	findTF = var_3
	arg_1_0.leftTf = var_3(arg_1_0._gameUI, "left")
	findTF = var_3
	arg_1_0.rightTf = var_3(arg_1_0._gameUI, "right")
	GetComponent = var_3

	local var_1_0 = arg_1_0.leftTf

	typeof = var_5
	EventTriggerListener = var_1_10006
	arg_1_0.leftListener = var_3(var_1_0, var_5(var_1_10006))
	GetComponent = var_3

	local var_1_1 = arg_1_0.rightTf

	typeof = var_5
	EventTriggerListener = var_1_10006
	arg_1_0.rightListener = var_3(var_1_1, var_5(var_1_10006))
	findTF = var_3
	arg_1_0.effectTf = var_3(arg_1_0._gameUI, "effect")
	arg_1_0.comboEffectData = var_0_3.combo_effect

	local var_1_2 = arg_1_0.leftListener

	var_3.AddPointDownFunc(var_1_2, function()
		local var_2_0 = arg_1_0._event

		var_0.emit(var_2_0, var_0_2.PRESS_DIRECT, -1)

		return
	end)

	local var_1_3 = arg_1_0.rightListener

	var_3.AddPointDownFunc(var_1_3, function()
		local var_3_0 = arg_1_0._event

		var_0.emit(var_3_0, var_0_2.PRESS_DIRECT, 1)

		return
	end)

	onButton = var_3

	local var_1_4 = arg_1_0._event
	local var_1_5 = arg_1_0.btnBack

	local function var_1_6()
		if not var_0_1.startSettlement then
			local var_4_0 = arg_1_0._event
			local var_4_1 = var_0.emit

			TouchCakeGameEvent = var_2_10002

			var_4_1(var_4_0, var_2_10002.PAUSE_GAME, true)

			local var_4_2 = arg_1_0._event
			local var_4_3 = var_0.emit

			TouchCakeGameEvent = var_2

			var_4_3(var_4_2, var_2.OPEN_LEVEL_UI)
		end

		return
	end

	SFX_CONFIRM = var_1_10007

	var_3(var_1_4, var_1_5, var_1_6, var_1_10007)

	onButton = var_3

	local var_1_7 = arg_1_0._event
	local var_1_8 = arg_1_0.btnPause

	local function var_1_9()
		if not var_0_1.startSettlement then
			local var_5_0 = arg_1_0._event
			local var_5_1 = var_0.emit

			TouchCakeGameEvent = var_2_10002

			var_5_1(var_5_0, var_2_10002.PAUSE_GAME, true)

			local var_5_2 = arg_1_0._event
			local var_5_3 = var_0.emit

			TouchCakeGameEvent = var_2

			var_5_3(var_5_2, var_2.OPEN_PAUSE_UI)
		end

		return
	end

	SFX_CONFIRM = var_1_10007

	var_3(var_1_7, var_1_8, var_1_9, var_1_10007)

	findTF = var_3
	arg_1_0.scoreTf = var_3(arg_1_0._gameUI, "score")
	findTF = var_3
	arg_1_0.comboTf = var_3(arg_1_0._gameUI, "bgCombo/combo")

	return
end

function var_0_0.show(arg_6_0, arg_6_1)
	setActive = var_1_10002

	var_1_10002(arg_6_0._gameUI, arg_6_1)

	return
end

function var_0_0.update(arg_7_0)
	return
end

function var_0_0.start(arg_8_0)
	arg_8_0.subGameStepTime = 0

	arg_8_0:updateScore()
	arg_8_0:updateCombo()
	arg_8_0:show(true)

	return
end

function var_0_0.updateScore(arg_9_0)
	setText = var_1_10001

	var_1_10001(arg_9_0.scoreTf, var_0_1.scoreNum)

	return
end

function var_0_0.updateCombo(arg_10_0)
	setText = var_1_10001

	var_1_10001(arg_10_0.comboTf, var_0_1.comboNum)

	GetComponent = var_1_10001

	local var_10_0 = arg_10_0.comboTf

	typeof = var_3
	Animator = var_1_10004

	local var_10_1 = var_1_10001(var_10_0, var_3(var_1_10004))

	var_1.SetTrigger(var_10_1, "combo")

	local var_10_2

	for iter_10_0 = #arg_10_0.comboEffectData, 1, -1 do
		if var_0_1.comboNum >= arg_10_0.comboEffectData[iter_10_0][1] then
			var_10_2 = arg_10_0.comboEffectData[iter_10_0][2]

			break
		end
	end

	local var_10_3 = arg_10_0

	arg_10_0.setChildVisible(var_10_3, arg_10_0.effectTf, false)

	if var_10_2 then
		setActive = var_2
		findTF = var_10_3

		var_2(var_10_3(arg_10_0.effectTf, var_10_2), true)
	end

	return
end

function var_0_0.setChildVisible(arg_11_0, arg_11_1, arg_11_2)
	for iter_11_0 = 1, arg_11_1.childCount do
		local var_11_0 = arg_11_1
		local var_11_1 = arg_11_1.GetChild(var_11_0, iter_11_0 - 1)

		setActive = var_11_0

		var_11_0(var_11_1, arg_11_2)
	end

	return
end

function var_0_0.step(arg_12_0, arg_12_1)
	math = var_1_10002

	local var_12_0 = var_1_10002.ceil(var_0_1.gameTime) <= 0 and 0 or var_12_0

	math = var_3

	local var_12_1 = var_3.floor(var_12_0 / 60)

	math = var_4

	local var_12_2 = var_4.floor(var_12_0 % 60)

	if var_12_1 < 10 then
		local var_12_3 = "0"

		tostring = var_1_10006

		if not (var_12_3 .. var_1_10006(var_12_1)) then
			tostring = var_12_3
			var_12_3 = var_12_3(var_12_1)
		end

		if var_12_2 < 10 then
			local var_12_4 = "0"

			tostring = var_1_10007

			if not (var_12_4 .. var_1_10007(var_12_2)) then
				tostring = var_12_4
				var_12_4 = var_12_4(var_12_2)
			end

			setText = var_1_10007

			var_1_10007(arg_12_0.gameTime, var_12_3 .. " : " .. var_12_4)

			if var_12_0 <= 0 then
				arg_12_0:show(false)
			elseif var_0_1.startSettlement then
				isActive = var_7

				if var_7(arg_12_0._gameUI) then
					arg_12_0:show(false)
				end
			end

			return
		end
	end
end

function var_0_0.dispose(arg_13_0)
	ClearEventTrigger = var_1_10001

	var_1_10001(arg_13_0.leftListener)

	ClearEventTrigger = var_1_10001

	var_1_10001(arg_13_0.rightListener)

	return
end

function var_0_0.press(arg_14_0, arg_14_1, arg_14_2)
	return
end

return var_0_0
