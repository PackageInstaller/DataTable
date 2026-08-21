local var_0_0 = class("TouchCakeGamingUI")
local var_0_1
local var_0_2
local var_0_3

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0._tf = arg_1_1
	arg_1_0._event = arg_1_2
	var_0_1 = TouchCakeGameVo
	var_0_2 = TouchCakeGameEvent
	var_0_3 = TouchCakeGameConst
	arg_1_0._gameUI = findTF(arg_1_0._tf, "ui/gamingUI")
	arg_1_0.btnBack = findTF(arg_1_0._gameUI, "back")
	arg_1_0.btnPause = findTF(arg_1_0._gameUI, "pause")
	arg_1_0.gameTime = findTF(arg_1_0._gameUI, "time")
	arg_1_0.leftTf = findTF(arg_1_0._gameUI, "left")
	arg_1_0.rightTf = findTF(arg_1_0._gameUI, "right")
	arg_1_0.leftListener = GetComponent(arg_1_0.leftTf, typeof(EventTriggerListener))
	arg_1_0.rightListener = GetComponent(arg_1_0.rightTf, typeof(EventTriggerListener))
	arg_1_0.effectTf = findTF(arg_1_0._gameUI, "effect")
	arg_1_0.comboEffectData = var_0_3.combo_effect

	arg_1_0.leftListener:AddPointDownFunc(function()
		arg_1_0._event:emit(var_0_2.PRESS_DIRECT, -1)

		return
	end)
	arg_1_0.rightListener:AddPointDownFunc(function()
		arg_1_0._event:emit(var_0_2.PRESS_DIRECT, 1)

		return
	end)
	onButton(arg_1_0._event, arg_1_0.btnBack, function()
		if not var_0_1.startSettlement then
			arg_1_0._event:emit(TouchCakeGameEvent.PAUSE_GAME, true)
			arg_1_0._event:emit(TouchCakeGameEvent.OPEN_LEVEL_UI)
		end

		return
	end, SFX_CONFIRM)
	onButton(arg_1_0._event, arg_1_0.btnPause, function()
		if not var_0_1.startSettlement then
			arg_1_0._event:emit(TouchCakeGameEvent.PAUSE_GAME, true)
			arg_1_0._event:emit(TouchCakeGameEvent.OPEN_PAUSE_UI)
		end

		return
	end, SFX_CONFIRM)

	arg_1_0.scoreTf = findTF(arg_1_0._gameUI, "score")
	arg_1_0.comboTf = findTF(arg_1_0._gameUI, "bgCombo/combo")

	return
end

function var_0_0.show(arg_6_0, arg_6_1)
	setActive(arg_6_0._gameUI, arg_6_1)

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
	setText(arg_9_0.scoreTf, var_0_1.scoreNum)

	return
end

function var_0_0.updateCombo(arg_10_0)
	setText(arg_10_0.comboTf, var_0_1.comboNum)
	GetComponent(arg_10_0.comboTf, typeof(Animator)):SetTrigger("combo")

	local var_10_0

	for iter_10_0 = #arg_10_0.comboEffectData, 1, -1 do
		if var_0_1.comboNum >= arg_10_0.comboEffectData[iter_10_0][1] then
			var_10_0 = arg_10_0.comboEffectData[iter_10_0][2]

			break
		end
	end

	arg_10_0:setChildVisible(arg_10_0.effectTf, false)

	if var_10_0 then
		setActive(findTF(arg_10_0.effectTf, var_10_0), true)
	end

	return
end

function var_0_0.setChildVisible(arg_11_0, arg_11_1, arg_11_2)
	for iter_11_0 = 1, arg_11_1.childCount do
		setActive(arg_11_1:GetChild(iter_11_0 - 1), arg_11_2)
	end

	return
end

function var_0_0.step(arg_12_0, arg_12_1)
	local var_12_0 = math.ceil(var_0_1.gameTime)

	var_12_0 = var_12_0 <= 0 and 0 or var_12_0

	local var_12_1 = math.floor(var_12_0 / 60)
	local var_12_2 = math.floor(var_12_0 % 60)
	local var_12_3 = var_12_1 < 10 and "0" .. tostring(var_12_1) or tostring(var_12_1)
	local var_12_4 = var_12_2 < 10 and "0" .. tostring(var_12_2) or tostring(var_12_2)

	setText(arg_12_0.gameTime, var_12_3 .. " : " .. var_12_4)

	if var_12_0 <= 0 then
		arg_12_0:show(false)
	elseif var_0_1.startSettlement and isActive(arg_12_0._gameUI) then
		arg_12_0:show(false)
	end

	return
end

function var_0_0.dispose(arg_13_0)
	ClearEventTrigger(arg_13_0.leftListener)
	ClearEventTrigger(arg_13_0.rightListener)

	return
end

function var_0_0.press(arg_14_0, arg_14_1, arg_14_2)
	return
end

return var_0_0
